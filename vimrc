set nocompatible

"Color"
if !&diff | syntax enable | endif
set t_Co=16
set background=dark
color solarized

"Completion"
set wildmenu
set wildmode=longest,list,full

"Display"
set ruler
set number
set display=lastline,uhex

"Encryption"
set cryptmethod=blowfish

"Mappings"
set mouse=n
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

"Tags"
set tags=./tags;

"Whitespace"
set autoindent
set smartindent
set list
set listchars=trail:█,tab:\—\ 
set backspace=indent,eol,start

"Write file with elevated privileges"
cnoremap w!! write !sudo tee % > /dev/null

"Use the vimrc in the working directory"
set exrc
set secure

"Split lines on delimiter"
command! -range -nargs=1 Split <line1>,<line2>s/<args>/\r/g

"Remove trailing whitespace"
command! -range=% Strip <line1>,<line2>s/\s\+$

"Jump to the last known cursor position"
autocmd BufReadPost *
\	if line("'\"") > 0 && line("'\"") <= line("$") |
\		exe "normal g`\"" |
\	endif
