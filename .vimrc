" charset
set encoding=utf-8                   "enc, vim buffer charset, NOT the file's charset
set fileencoding=utf-8               "fenc, default save charset
set colorcolumn=72,80                   "set vertical line warning
set completeopt-=preview             "NO MORE scratch preview
"fencs, default opening charset priority (as auto detection)
set fileencodings=utf-8,utf-16le,big5,gb2312,gb18030,gbk,default

" enable features which are not Vi compatible but really really nice.
set nocompatible  "nocp
filetype off                  " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" auto completion
Plugin 'Valloric/YouCompleteMe'
" snippet engine
Plugin 'SirVer/ultisnips'
Plugin 'garbas/vim-snipmate'
" vim-snipmate is dependent on vim-addon-mw-utils & tlib_vim
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" snippet
Plugin 'honza/vim-snippets'
" markdown writing env
Plugin 'plasticboy/vim-markdown'
" centralize markdown text
Plugin 'junegunn/goyo.vim'
" markdown focus mode
Plugin 'junegunn/limelight.vim'
" vim status line
Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
" text filtering and alignment
Plugin 'godlygeek/tabular'
" show git diff on left side of vim window
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
" syntax check
Plugin 'vim-syntastic/syntastic'
" file system explorer
Plugin 'scrooloose/nerdtree'
" show git status in NERDTree (can change symbols)
Plugin 'Xuyuanp/nerdtree-git-plugin'
" show real color of rgb text
Plugin 'ap/vim-css-color'

call vundle#end()             " required
filetype plugin indent on     " required
filetype plugin on

" default no bomb for utf-8
set nobomb

" expand TABs to spaces
set expandtab     "et
" set TAB's width
set tabstop=2     "ts
" auto indent width
set shiftwidth=2  "sw
" decide tab space according to the editing file
set smarttab

" use the indent of the previous line for a newly created line
set autoindent    "ai

" 256 color mode
set t_Co=256

" show the ruler for the cursor
set ruler  "ru
" show line numbers
set number "nu

" show the search results before stop typing
set incsearch     "is
" highlight search results
set hlsearch      "hls
" case-insensitive search
set ignorecase    "ic
" smart search (override 'ic' when pattern has uppers)
set smartcase     "scs

" enable backspace in insert mode
set backspace=2   "bs

" file formats priority when try to read a file
set fileformats=unix,dos,mac "ffs

" indicates a fast terminal connection
set ttyfast "tf

" don't redrawnscreen  while executing macros, registers and other commands
set lazyredraw "lz

" enable window title
set title

" auto-reload editing file when it's changed somewhere else
set autoread

" set windows title back to path instead of default 'Thanks for Flying Vim'
let &titleold = getcwd()

" set statusbar
set statusline+=%f              "filename
set statusline+=%m              "modified flag
set statusline+=%r              "read only flag
set statusline+=\ \%y           "filetype
set statusline+=%=              "left/right separator
set statusline+=%#warningmsg#   "show the errors/warning in the status line
set statusline+=%h              "help file flag
set statusline+=%*              "color off
set statusline+=\ [%{&ff}\]\    "fileformat (unix, dos, mac ...)
set statusline+=%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"} "file charset
set statusline+=[%l,%c]         "cursor line,column
set statusline+=\ \[%L\ lines\] "total lines
set statusline+=\ [%P]          "percent through file
set statusline+=\ %a            "if open multiple files, show current file and and the number of all files
set statusline+=%{SyntasticStatuslineFlag()}

" display a status line at the bottom of the window
set laststatus=2 "ls

" show as much as possible of the last line, instead of '@' symbol
set display+=lastline

" set code folding feature
set foldmethod=indent "fdm
set foldnestmax=5     "fdn max fold level
set foldlevel=5       "fdl default fold level

" set scroll offset(the min number of lines above and below cursor) to 2
set scrolloff=2       "so

" enable mouse in all mode
" disable it if you want to use ctrl+c to copy things
" set mouse=a

" hichlight current line
set cursorline
set cursorcolumn

" highlight syntax
syntax on

" color scheme
colorscheme luna-term

" make whitespaces and TABs visible
"l
set list
"lcs
set listchars=tab:>-,trail:·
hi Normal  ctermfg=252 ctermbg=none
highlight SpecialKey guifg=DarkGray
"luna-term theme would be better without the next line
"highlight cursorline cterm=none ctermbg=2 ctermfg=0
" set temp dirs, can speedup 100x when working on fuse via internet or nfs
"set backupdir=~/.vim/bak/
"set directory=~/.vim/swp/
"set undodir=~/.vim/undo/

" <BAR> means pipe '|', <CR> mean enter
" map hot key <Ctrl>+m to switch paste mode
map <C-o> :set paste!<BAR>set paste?<CR>
" map hot key <Ctrl>+n to switch if shows line numbers
map <C-n> :set nu!<BAR>set nu?<CR>
" map hot key <Ctrl>+j to switch if highlights current working column
map <C-j> :set cursorcolumn!<BAR>set cursorcolumn?<CR>
" map hot key <Ctrl>+h to switch if highlights current working line
map <C-h> :set cursorline!<BAR>set cursorline?<CR>
" map hot key <Ctrl>+a to switch if auto indent
map <C-a> :set ai!<BAR>set ai?<CR>
" map hot key <Ctrl>+x to load the command of all lines indention
map <C-x> :normal gg=G<CR>

" map tab / shift-tab to add/remove indent in normal & visual modes
nmap <tab>   v>
nmap <s-tab> v<
vmap <tab>   >gv
vmap <s-tab> <gv

" map F9 to save and make
map <F9> :w <CR> :make <CR>
" map F10 to execute filename(without ext.) as external command (usually for c & cpp)
map <F10> :!./%< <CR>
" map F11 = F9 + F10
map <F11> :w <CR> :make <CR> :!./%< <CR>

"=== setting depends on filetype  ==="
" au, autocommand
autocmd FileType make,gitconfig,gitcommit,apache,dockerfile setlocal et!
autocmd FileType gitcommit setlocal cc=50,72 | setlocal textwidth=72 | highlight ColorColumn ctermbg=cyan
autocmd FileType html,css,javascript,yaml setlocal sw=2 ts=2
autocmd FileType fstab setlocal sw=8 ts=8

"=== manually setting filetype ==="
" au, autocommand
autocmd BufRead,BufNewFile *.cpp set filetype=cpp
autocmd BufRead,BufNewFile *.plt set filetype=gnuplot
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile named.conf* set filetype=named
autocmd BufRead,BufNewFile *.pac set filetype=javascript

" auto remove trailing whitespace when saving file
autocmd BufWritePre * :%s/\s\+$//e

" set makeprg(depends on filetype) if makefile is not exist
if !filereadable('makefile') && !filereadable('Makefile')
  autocmd FileType c setlocal makeprg=gcc\ %\ -o\ %<
  autocmd FileType cpp setlocal makeprg=g++\ %\ -o\ %<
  autocmd FileType sh setlocal makeprg=bash\ -n\ %
  autocmd FileType php setlocal makeprg=php\ -l\ %
endif

" set Netrw's default style to tree style listing
let g:netrw_liststyle=3

"======  ycm configs ======"
" C-family Semantic Completion
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" Python Semantic Completion
let g:ycm_python_binary_path = '/usr/bin/python'
let g:ycm_server_python_interpreter='/usr/bin/python'
" ycm options, see https://github.com/Valloric/YouCompleteMe#options
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_tags_files=1
" minimum number at which auto-completion displays
let g:ycm_min_num_of_chars_for_completion=1

"====== ultisnips config ======"
" custom key binding of ultisnips to integrate with ycm
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"====== vim-markdown config ======"
let g:vim_markdown_new_list_item_indent = 2
" code block program lang shortcut
let g:vim_markdown_fenced_languages = ['javascript=js']

"====== goyo.vim config ======"
map <C-g> :Goyo<CR>
let g:goyo_width = 125

"====== limelight.vim config ======"
map <C-l> :Limelight!!<CR>
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
"
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

"====== vim-airline config ======"
let g:airline_section_warning = '%{SyntasticStatuslineFlag()}'
" tabline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" disable 'show_buffer' to stop buffering after closing the file
" let g:airline#extensions#tabline#show_buffers = 0
" when there are too many tabs, show this
let tabEllipsis = '…'
" map hot key <Shift>+r in order to move to previous tab
map <s-r> :bp<CR>
" map hot key <Shift>+t in order to move to next tab
map <s-t> :bn<CR>
" map hot key <Shift>+y to close the attached tab
map <s-y> :bd<CR>

"====== vim-gitgutter config ====="
map <s-g> :GitGutterLineHighlightsToggle<CR>

"====== vim-syntastic config ======"
map <s-c> :SyntasticToggleMode<CR>
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_generic = 1
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exec = 'eslint'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"====== NERDtree config ======"
"autocmd vimenter * NERDTree " uncomment if you want NERDTree when you enter
map <C-t> :NERDTreeToggle<CR>

"===== NERDTree git plugin config"
let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ "Modified"  : "!",
  \ "Staged"    : "✚",
  \ "Untracked" : "?",
  \ "Renamed"   : ">",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "x",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ 'Ignored'   : '☒',
  \ "Unknown"   : "??"
  \}

"====== vim-snipmate config ======"
let g:snipMate = { 'snippet_version' : 1 }
