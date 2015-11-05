set nocompatible

"Color"
if !&diff | syntax enable | endif
if &term == 'linux' | set t_Co=8 | endif
set background=dark
color solarized

"Completion"
set wildmenu
set wildmode=longest,list,full

"Configuration"
set exrc
set secure

"Display"
set ruler
set number
set display=lastline

"Encryption"
set cryptmethod=blowfish2

"Keywords"
filetype plugin on
runtime ftplugin/man.vim
map K \K

"Mouse"
set mouse=a
set clipboard=unnamedplus
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

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
set virtualedit=all

"Windows"
set splitright
map <C-H> gT
map <C-L> gt

"Write file with elevated privileges"
cmap w!! write !sudo tee % > /dev/null

"Split lines on delimiter"
command! -range -nargs=1 Split <line1>,<line2>s/<args>/\r/g

"Remove trailing whitespace"
command! -range=% Strip <line1>,<line2>s/\s\+$

"Run make and open quickfix window"
command! -nargs=* Make wall | silent make <args> | redraw! | cwindow

"Jump to the last known cursor position"
function! RestoreCursor()
	if line("'\"") > 0 && line("'\"") <= line("$")
		normal g`"zz
	endif
endfunction
autocmd BufReadPost * call RestoreCursor()

"Show output of external command in new window"
function! RunCmd(cmd)
	new
	set buftype=nofile
	execute 'read !' a:cmd
	1 delete
	filetype detect
endfunction
command! -nargs=+ Run call RunCmd(<q-args>)
