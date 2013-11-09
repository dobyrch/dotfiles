syntax enable
set t_Co=16
set background=dark
color solarized
set autoindent
set smartindent
set display=lastline
set ruler
set number
set ignorecase
set smartcase
set nowrapscan
set tabstop=4
set softtabstop=4
set shiftwidth=4  "when shiftwidth=0, use tabstop instead"
set expandtab
autocmd FileType make setlocal noexpandtab
set nocompatible
set backspace=indent,eol,start
set list
"set listchars=trail:.,tab:>\ 
set mouse=a
set cryptmethod=blowfish
cmap w!! w !sudo tee > /dev/null %
noremap q: :q
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>
noremap <S-Up> <Up>
noremap <S-Down> <Down>
inoremap <S-Up> <Up>
inoremap <S-Down> <Down>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

"Use a vimrc in the working directory for per-project configuration"
redir => s:wd
silent pwd
redir END
let s:wd = substitute(s:wd, "^\\n\\+\\|\\n\\+$","","g")
if expand('~') != '/root' && filereadable('./.vimrc') && s:wd != expand('~') && s:wd != '/etc/vimrc'
    source ./.vimrc
endif
