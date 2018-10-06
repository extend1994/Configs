# Key bindings for my working environment
**Note: italic hot-keys are defined in my .vimrc, not from the original plugin.**

## vim
Just press the following keys ( **case-sensitive** ), ***no prefix***.

### Editor envioronment
- Normal mode
  - *`Ctrl` + `n`*: Toggle line number
  - *`Ctrl` + `j`*: Toggle cursorcolumn
  - *`Ctrl` + `h`*: Toggle cursorline
  - *`Ctrl` + `a`*: Toggle auto indent
- Insert mode
  - *`Ctrl` + `o`*: Toggle paste mode
- tab buffer
  - *`Shift` + `r`*: Move to previous tab
  - *`Shift` + `t`*: Move to next tab
  - *`Shift` + `y`*: Close the attached tab

### vim-syntastic
- *`Shift` + `c`*: Toggle vim-syntastic

### snippets
- *`Ctrl` + `j`*: Adopt the candidate snippet
  - **To avoid confliction with YouCompleteMe**

### Markdown env
- vim-markdown
  - `]]`: Go to next header
  - `[[`: Go to previous header
  - `][`: Go to next sibling header
  - `[]`: Go to previous sibling header
  - `]c`: Go to current header
  - `]u`: Go to parent header
- goyo.vim: Focus mode for writing
  - *`Ctrl` + `g`*: Toggle goyo
- limelight.vim
  - *`Ctrl` + `l`*: Toggle limelight

### Git related
- vim-gitgutter
  - *`Shift` + `g`*: Toggle `git diff` block/line highlight

### NERD-tree: file system explorer in vim window
- *`Ctrl` + `t`*: Toggle NERD tree

## tmux
Press the following keys ( **case-sensitive** ) ***after you press tmux prefix***.

### Mouse mode
- *`Ctrl` + `m`*: Turn on mouse mode
- *`Ctrl` + `M`*: Turn off mouse mode

### tpm: tmux plugins manager
Note: you must be in the tmux env to use these
- `I`: Install tmux plugins listed in .tmux.conf
- `U`: Update tmux plugins
- `Alt` + `u`: Remove/Uninstall tmux plugins

### tmux-resurrect: tmux session store and load
- `Ctrl` + `s`: store current tmux session
- `Ctrl` + `r`: load last stored tmux seesion

## References
- [vim-markdown](https://github.com/plasticboy/vim-markdown#mappings)
- [tpm](https://github.com/tmux-plugins/tpm#key-bindings)
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect#key-bindings)
