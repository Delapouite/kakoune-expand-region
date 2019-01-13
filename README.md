# kakoune-expand-region

[kakoune](http://kakoune.org) plugin that allows you to select increasingly larger regions of text using the same key combination.

It aims to be similar to features from other editors:

- Vim's [expand region](https://github.com/terryma/vim-expand-region)
- Emac's [expand region](https://github.com/magnars/expand-region.el)
- IntelliJ's [syntax aware selection](http://www.jetbrains.com/idea/documentation/tips/#tips_code_editing)
- Eclipse's [select enclosing element](http://stackoverflow.com/questions/4264047/intellij-ctrlw-equivalent-shortcut-in-eclipse)

Warning: this project is still in beta.

## Install

Add `expand-region.kak` to your autoload dir: `~/.config/kak/autoload/`.

## Usage

Run the `expand` command successively.

```
# Suggested mapping

map global normal + :expand<ret>
```

## Related commands

Here are two simple linewise commands that your may also find useful:

```
def grow-selection %{
  exec '<a-:>L<a-;>H'
}

def shrink-selection %{
  exec '<a-:>H<a-;>L'
}
```

## See Also

[kakoune-expand](https://github.com/occivink/kakoune-expand): this alternative version made by occivink offers the `:expand-repeat` command.
[kak-tree](https://github.com/ul/kak-tree): use the `tree-select-parent-node` command to traverse the AST.

## Licence

MIT
