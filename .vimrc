set nocompatible              " be iMproved, required
filetype off                  " required
 
"Vim-plug automatic installation"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-Plug
call plug#begin('~/.vim/bundle')

"Plugs

"Git Integration"
Plug 'tpope/vim-fugitive'

"Code Folding"
Plug 'tmhedberg/SimpylFold'

"Vim Python Autoindent"
Plug 'vim-scripts/indentpython.vim'

"Syntax checking/Higlighting"
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'

"Status Bar"
Plug 'vim-airline/vim-airline'

"File Browsing"
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

"Colour Schemes"
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'flazz/vim-colorschemes'
Plug 'dracula/vim'
"Super Searching"
Plug 'kien/ctrlp.vim'

"Tagbar"
Plug 'majutsushi/tagbar'

"Surround"
Plug 'tpope/vim-surround'

"YouCompleteMe (autocomplete)"
"Plug 'valloric/youcompleteme'

"GOLANG"
Plug 'fatih/vim-go'


"Commenting"
Plug 'scrooloose/nerdcommenter'


call plug#end()
"All of your Plugs must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PlugList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugSearch foo - searches for foo; append `!` to refresh local cache
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plug stuff after this line)


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
"colorscheme PaperColor
colorscheme dracula

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
