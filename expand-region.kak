decl str text_objects '<a-i>w <a-i>W <a-i>q <a-i>Q <a-i>] <a-i>b <a-a>b <a-i>B <a-a>B <a-i>p "\%"'
decl int text_objects_length %sh{
  arr=($kak_opt_text_objects)
  echo "${#arr[@]}"
}

def exp-loop -hidden -params 1 %{
  %sh{
    index=$1
    i=0

    for to in ${kak_opt_text_objects[@]}; do
      if (( index == i )); then
        echo "decl str to $to;exec $to;echo -debug $to;"
      fi
      (( i++ ))
    done
  }
  %sh{
    length="${#kak_selection}"
    if (( length > $kak_opt_init_length )) && (( length < $kak_opt_max_length )); then
      echo "decl str candidate '$kak_opt_to'"
      echo "decl int max_length $length"
      echo "select $kak_opt_init_desc"
    fi

    echo "echo -debug length: $length init_length: $kak_opt_init_length"
  }
  %sh{
    index=$1
    (( index++ ))

    if (( index < $kak_opt_text_objects_length )); then
      echo "decl int index $index"
      echo "exp-loop $index"
    else
      echo "select $kak_opt_init_desc"
      echo "exec '$kak_opt_candidate'"
      echo "info '$kak_opt_candidate'"
      echo "echo -debug END '$kak_opt_candidate'"
    fi
  }
}

def expand %{
  # init for first iteration
  decl int index 0
  decl int init_length %sh{ echo "${#kak_selection}" }
  decl str init_desc %val{selection_desc}
  decl int max_length 9999999

  # let's roll the recursion
  echo -debug '== EXPAND =='
  exp-loop %opt{index}
}

map global normal + :expand<ret>
