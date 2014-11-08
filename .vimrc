set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'camelcasemotion'
Plugin 'wting/nerdcommenter'
Plugin 'kien/ctrlp.vim'

" Powerline
Plugin 'tpope/vim-fugitive'
Plugin 'wting/vim-powerline'

" Appearance
Plugin 'wting/rainbow_parentheses.vim'
Plugin 'nathanaelkane/vim-indent-guides'

" Syntax
Plugin 'scrooloose/syntastic'
Plugin 'wting/cheetah.vim'

" All of your Plugins must be added before the following line
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
" Put your non-Plugin stuff after this line
filetype plugin on
filetype plugin indent on
syntax enable

set listchars=tab:>-,trail:-
set list
set ofu=syntaxcomplete#Complete
set history=1000
set undolevels=1000
" change the terminal's title
set title
" allow backspace over everything
set backspace=indent,eol,start
set iskeyword=@,48-57,_,192-255
set lazyredraw
" remove modelines, prevents a few security exploits
set modelines=0
set hidden
set splitright
set splitbelow
set ttyfast
set ruler
set visualbell
set noerrorbells
set showmode
set showcmd
set scrolloff=4
set nowrap
set formatoptions=qrn1
if v:version >= 703 && has('patch541')
set fo+=j
endif

set number
if exists("&relativenumber")
    set relativenumber
    augroup vimrc-relative_number
    silent! au InsertEnter * set number
    silent! au InsertLeave * set relativenumber
    silent! au FocusLost *   set number
    silent! au FocusGained * set relativenumber
    augroup END
endif

" indent
ca 2et setlocal ts=2 sts=2 sw=2 et
ca 2noet setlocal ts=2 sts=2 sw=2 noet
ca 4et setlocal ts=4 sts=4 sw=4 et
ca 4noet setlocal ts=4 sts=4 sw=4 noet
ca cc80 sw=4 ts=4 sts=4 et nowrap linebreak nolist tw=76 cc=80

" search options
set ignorecase
" disable ignore case if uppercase present
set smartcase
set gdefault
set incsearch
set hlsearch
set showmatch

" use Perl/Python regex instead
nnoremap / /\v
vnoremap / /\v

"change default grep behavior
set grepprg=gp\ -n

" set folds, default open
set foldmethod=indent
set foldlevel=20
set foldlevelstart=20
set showtabline=2

" remove trailing whitespace
function! StripTrailingWhitespaces()
     " prelude
     let _s=@/
     let l = line(".")
     let c = col(".")
     " business time
     %s/\s\+$//e
     " epilogue
     let @/=_s
     call cursor(l, c)
endfunction
augroup vimrc-strip_ws
     au BufWritePre * :call StripTrailingWhitespaces()
augroup END

" reduce timeout to 5ms (from default 60ms) for large file support
let g:matchparen_insert_timeout=5

" don't make backup for certain directories, allows crontab -e on osx
set backupskip=/tmp/*,/private/tmp/*
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" force 256 color support even if terminal doesn't allow it
set t_Co=256
" shows the current line in different color
set cursorline

colorscheme zenburn

" highlight current line
au ColorScheme * hi CursorLine term=underline ctermbg=darkblue

" dark tab display for indent guides
set background=dark

" hlsearch color
hi! Search term=reverse ctermfg=255 ctermbg=130

" make sign column same color as theme
"highlight clear SignColumn
hi! link SignColumn LineNr

set backupdir=~/.vim/backups
set directory=~/.vim/swaps

set wildignore+=build/**
set wildignore+=htdocs/**
set wildignore+=*/build/*
set wildignore+=*/htdocs/*

" CtrlP
let g:ctrlp_map = '<s-t>'
nnoremap <c-b> = :CtrlPBuffer<cr>
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_lazy_update = 0
let g:ctrlp_use_caching = 1000
let g:ctrlp_cache_dir = '~/.vim/tmp/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 50000
let g:ctrlp_max_height = 20
let g:ctrlp_open_multiple_files = 'tj'
" make tabs default behavior
let g:ctrlp_prompt_mappings = {
     \ 'AcceptSelection("e")': ['<c-b>'],
     \ 'AcceptSelection("t")': ['<cr>', '<c-t>', '<2-LeftMouse>'],
     \ 'AcceptSelection("h")': ['<c-s>', '<c-x>'],
     \ }

set autoindent
set tabstop=4
set shiftwidth=4
set shiftround 				" use multiples of shiftwidth when using < or >

" Move tabs left/right http://stackoverflow.com/a/7192324/195139
nnoremap <silent> <s-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
nnoremap <silent> <s-right> :execute 'silent! tabmove ' . tabpagenr()<cr>
" nnoremap <silent> <c-s-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
" nnoremap <silent> <c-s-l> :execute 'silent! tabmove ' . tabpagenr()<cr>

" arrow keys not allowed
inoremap <silent> <up> <esc>:bprev<cr>
inoremap <silent> <down> <esc>:bnext<cr>
inoremap <silent> <left> <esc>:tabprev<cr>
inoremap <silent> <right> <esc>:tabnext<cr>
noremap <silent> <up> :bprev<cr>
noremap <silent> <down> :bnext<cr>
noremap <silent> <left> :tabprev<cr>
noremap <silent> <right> :tabnext<cr>

nnoremap <silent> <s-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
nnoremap <silent> <s-right> :execute 'silent! tabmove ' . tabpagenr()<cr>
