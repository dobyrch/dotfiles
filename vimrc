set nocompatible

"Color"
syntax enable
set t_Co=16
set background=dark
color solarized

"Display"
set ruler
set number
set display=lastline,uhex

"Encryption"
set cryptmethod=blowfish

"Mappings"
set mouse=a
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>
noremap q: :q
noremap q/ :q
noremap q? :q

"Search"
set ignorecase
set smartcase
set nowrapscan
set nohlsearch

"Whitespace"
set autoindent
set smartindent
set list
set listchars=trail:█,tab:\—\ 
set backspace=indent,eol,start

"Write file with elevated privileges"
cnoremap w!! w !sudo tee > /dev/null %

"Use the vimrc in the working directory"
set exrc
set secure

"Remove trailing whitespace"
command! -range=% Trim <line1>,<line2>s/\s\+$

"Jump to the last known cursor position"
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif
