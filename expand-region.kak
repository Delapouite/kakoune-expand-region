decl str text_objects '<a-i>w <a-i>W <a-i>q <a-i>Q x <a-i>r <a-a>r <a-i>b <a-a>b <a-i>B <a-a>B "\%"'
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
        echo "decl str to $to;exec $to;"
      fi
      (( i++ ))
    done
  }
  %sh{
    length="${#kak_selection}"
    if (( length > $kak_opt_init_length )) && (( length < $kak_opt_max_length )); then
      echo "decl str candidate '$kak_opt_to'"
      echo "decl int max_length $length"

      # used for next expand command
      echo "decl int index $1"
      echo "decl str last_desc $kak_selection_desc"

      echo "select $kak_opt_init_desc"
    fi

    # echo "echo -debug length: $length init_length: $kak_opt_init_length"
  }
  %sh{
    index=$1
    (( index++ ))

    if (( index < $kak_opt_text_objects_length )); then
      echo "exp-loop $index"
    else
      echo "select $kak_opt_init_desc"
      echo "exec '$kak_opt_candidate'"
      echo "info '$kak_opt_candidate'"
      # echo "echo -debug END '$kak_opt_candidate'"
    fi
  }
}

def expand %{
  %sh{
    if [ -n "$kak_opt_last_desc" ] && [ "$kak_opt_last_desc" = "$kak_selection_desc" ]; then
      # in the middle of an expansion, don't replay smaller text-objects
      # echo "echo -debug == EXPAND CONTINUE == from $kak_opt_index"
      :;
    else
      # init for first iteration
      echo 'decl int index 0'
      # echo 'echo -debug == EXPAND =='
    fi
  }
  decl int init_length %sh{ echo "${#kak_selection}" }

  decl str init_desc %val{selection_desc}
  decl int max_length 9999999

  # let's roll the recursion
  exp-loop %opt{index}
}

# Suggested mapping

#map global normal + :expand<ret>
