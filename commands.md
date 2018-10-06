# Commands for vim and tmux

## vim
- ***To reload vim configuration, you can use `:so ~/.vimrc`***
- `<Leader>` in .vimrc is mapped to `\` by default
- To find help/documentation, try `:help <plugin_name>`
- `:e` edit other files and stored in the buffer
- [vim patterns](http://vimdoc.sourceforge.net/htmldoc/pattern.html)

### Vim plugin manager: Vundle
- `:PluginSearch [keyword]`: Search vim plugins and install it, etc.
- `:PluginInstall`: Install plugins written in .vimrc `vundle#begin()` block
- `:PluginUpdate`: Update installed plugins
- `:PluginList`: List installed plugins.
- `:PluginClean`: **Remove** plugins not in .vimrc but on the hard disk

### YouCompleteMe: Auto-completor
- `:let b:ycm_largefile`: Equals 1 to disable, 0 to enable again

### vim-markdown: Enhance markdown writing efficiency
- `:HeaderIncrease`
- `:HeaderDecrease`
- TOC
  - `:Toc`: TOC in a split & vertical window
  - `:Toch`: TOC in a split & **horizontal** window
  - `:Toct`: TOC in a new **tab**

### tabular: text filtering and alignment
- `:Tab /<symbol>`
- https://devhints.io/tabular

### vim-gitgutter: show git diff in editted file
- `:GitGutterToggle`: Toggle vim-gitgutter
- `:GitGutterSignsToggle`: Toggle `git diff` signs
- `:GitGutterLineHighlightsToggle`: Toggle highlight blocks
- `:GitGutterAll`: Update `git diff` result in editted pane immediately
- Hunks
  - `:GitGutterNextHunk`
  - `:GitGutterPrevHunk`
  - `:GitGutterStageHunk`
  - `:GitGutterUndoHunk`
  - `:GitGutterPreviewHunk`

### vim-fugitive: Able to use Git commands in the editor mode
- `:Gstatus`: `git status`
- `:Gwrite`: `git add`
- `:Gcommit`: `git commit`
- `:Gread`: `git checkout -- <filename>`
- `:Gdiff`: `git diff`
- `:Glog`: `git log`
- `:Gmove`: `git mv`
- `:Gdelete`: `git rm`
- `:Ggrep`: `git grep`
- `:Gblame`: `git blame`

## References
- [vim-markdown](https://github.com/plasticboy/vim-markdown#commands)
- [vim-gitgutter](https://github.com/airblade/vim-gitgutter#getting-started)
