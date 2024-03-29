" charset
set encoding=utf-8                   "enc, vim buffer charset, NOT the file's charset
set fileencoding=utf-8               "fenc, default save charset
set colorcolumn=72,80                   "set vertical line warning
set completeopt-=preview             "NO MORE scratch preview
"fencs, default opening charset priority (as auto detection)
set fileencodings=utf-8,utf-16le,big5,gb2312,gb18030,gbk,default

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