set nocompatible

" Enable colors
syntax enable
set t_Co=16
set background=dark
color solarized

" Enable numbering
set ruler
set number
set display=lastline

" Enable preferred search options
set ignorecase
set smartcase
set nowrapscan
set nohlsearch

" Enable preferred whitespace options
set autoindent
set smartindent
set backspace=indent,eol,start

" Show trailing whitespace and tabs
set list
set listchars=trail:\ ,tab:\ \ 

" Enable strong encryption
set cryptmethod=blowfish

" Enable mouse support
set mouse=a
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>

" Write file with elevated privileges
cnoremap w!! w !sudo tee > /dev/null %

" Disable commands I type accidentally
noremap q: :q
noremap q/ :q
noremap q? :q

" Disable arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Jump to the last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" Use the vimrc in the working directory
set exrc
set secure
