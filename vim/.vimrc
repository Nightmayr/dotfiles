set nocompatible              " be iMproved, required
filetype off                  " required
 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 " alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
 

"Git Integration"
Plugin 'tpope/vim-fugitive'

"Code Folding"
Plugin 'tmhedberg/SimpylFold'

"Vim Python Autoindent"
Plugin 'vim-scripts/indentpython.vim'

"Syntax checking/Higlighting"
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'

"Status Bar"
Plugin 'vim-airline/vim-airline'

"File Browsing"
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

"Colour Schemes"
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'

"Super Searching"
Plugin 'kien/ctrlp.vim'

"Tagbar"
Plugin 'majutsushi/tagbar'

"Surround"
Plugin 'tpope/vim-surround'

"YouCompleteMe (autocomplete)"
"Plugin 'valloric/youcompleteme'

"GOLANG"
Plugin 'fatih/vim-go'


"Commenting"
Plugin 'scrooloose/nerdcommenter'


"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line)


syntax on
:set autoindent

" Setting paste mode toggle
set pastetoggle=<F3>

" Vim tab indentation settings
set expandtab
set shiftwidth=4
set smarttab
set autoindent
set smartindent

"UTF8 Support"
set encoding=utf-8

"Line numbering"
set nu
set ruler
"Backspace"
set bs=2
"Options from realython.com"
"1 Split Layouts"
set splitbelow
set splitright
"Move between split layouts without mouse"
"Ctrl j to move to split below"
"Ctrl k to move to split above"
"Ctrl l to move to split right"
"Ctrl h to move to split left"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Enable Folding"
set foldmethod=indent
set foldlevel=99
"Enable folding with the spacebar"
nnoremap <space> za

"Python Indentation"
"PEP8"
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

"Flagging Unnecessary Whitespace"
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


"Make code look pretty"
let python_highlight_all=1
syntax on

"Colour Scheme"
"if has('gui_running')
"      set background=dark
"        colorscheme solarized
"    else
"          colorscheme default "zenburn
"      endif

call togglebg#map("<F5>")

" Solarized Dark
"syntax enable
"set t_Co=256
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
"let g:solarized_termtrans = 1
"colorscheme solarized
colorscheme PaperColor

"System Clipboard (able to use macOS clipboard for copy/paste)"
set clipboard=unnamed
"end of options from realpython.com"




"inoremap { {<CR><BS>}<Esc>:let leavechar="}"<CR>ko"
"inoremap ( ()<Esc>:let leavechar=")"<CR>i"
"inoremap [ []<Esc>:let leavechar="]"<CR>i"
"imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a"

"NERDtree"
map <C-n> :NERDTreeToggle<CR>

"Syntastic Default Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

"Youcompleteme fix
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
