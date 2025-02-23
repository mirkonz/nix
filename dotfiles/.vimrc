"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Necessary for cool features of vim
set nocompatible

" Sets how many lines of history VIM has to remember and undolevels
set history=9999
set undolevels=9999

" Enable syntax highlighting
syntax enable

" If you want mouse support
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-plug
" Automatic installaion of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.vim/plugged')


" Vim extensions
Plug 'sjl/gundo.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/visualrepeat'

" Alignment
Plug 'bronson/vim-trailing-whitespace'
Plug 'godlygeek/tabular'
Plug 'luochen1990/indent-detector.vim'

" Code Related
Plug 'vim-scripts/matchit.zip'
Plug 'dsawardekar/ember.vim'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'pangloss/vim-javascript'
Plug 'gregsexton/matchtag'
Plug 'jelera/vim-javascript-syntax'
Plug 'mattn/emmet-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'powerline/powerline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' }
Plug 'vim-scripts/closetag.vim'
Plug 'vim-scripts/css_color'
Plug 'mustache/vim-mustache-handlebars'

" UI
Plug 'bling/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'tomasr/molokai'


call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 256 colors in vim
set t_Co=256

" Set the title of the terminal
set title

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
set ruler

"This is the most awesome configurationa ever, is shows both
"the absolute and relative numbering together to make jumps
"easier
set number
" set relativenumber
nnoremap <silent><leader>n :set relativenumber!<cr>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Mark the current line
set cursorline

" For the vimdow
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>Search Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When searching try to be smart about cases
set smartcase
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding is enabled by default
set foldenable

" Only very nested blocks will be folded
set foldlevelstart=2 " 99 means everything will open up

" The maximum nesting level
set foldnestmax=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set utf8 as standard encoding and en_US as the standard language
set fileencoding=utf-8
set encoding=utf8

" Use Unix as the standard file type
" set ffs=unix,dos,mac

" Set to auto read when a file is changed from the outside
set autoread

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs ;)
set smarttab

" Migrated to editorconfig
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab "Converts tabs into space characters

" Textwrap at 80 haracters
set tw=100
set wrap

" Tab completion
set wildmenu
set wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Indentation
set autoindent "Auto indent
set smartindent "Smart indent

"Adding omnicomplete
set ofu=syntaxcomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"Show editor mode
set showmode

" Format the status line
set statusline=\ FILE:\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h

" Height of the command bar
set cmdheight=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins Specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree
"""""""""""""
nnoremap <C-b> :NERDTreeToggle<CR>