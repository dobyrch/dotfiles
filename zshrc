setopt CORRECT
setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt PUSHD_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
autoload compinit && compinit
autoload colors && colors
autoload zmv

greet

export PROMPT="%(?.%{${fg_no_bold[white]}%}.%{${fg_no_bold[red]}%})%(!.#.>)%{${reset_color}%} "
export SPROMPT="Correct ${fg_no_bold[red]}%R${reset_color} to ${fg_no_bold[green]}%r${reset_color}? "
export CORRECT_IGNORE='_*'

export HISTFILE="${HOME}/.cache/zsh/history"
export SAVEHIST='100'

export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'
export PAGER='less -i'

bindkey -v
bindkey '^?' backward-delete-char

export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;47;30m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;35m'
export LESS_TERMCAP_ue=$'\e[0m'

eval $(dircolors -b)
alias ag='fg %-'
alias bmount='udisksctl mount -b'
alias broken='find . -xtype l'
alias du='du --max-depth=1 -h'
alias ffmpeg='ffmpeg -hide_banner'
alias grep='grep --color=auto'
alias ls='ls -N --color=auto'
alias ll='ls -Ahl'
alias less='less -Ri'
alias info='info --vi-keys'
alias trash='gvfs-trash'
alias todo='grep -nr "TODO" * | sed "s/\([^:]*TODO.*:\)\|\(\s*\*\/$\)/\x1B[0m/g"'
alias reflect='sudo reflector -p http -l 20 -f 4 --save /etc/pacman.d/mirrorlist'
alias sd='systemctl'
alias setvol='pactl set-sink-input-volume'
alias sudo='sudo '

if type pacman &> /dev/null; then
	alias pacup='sudo pacman -Syu'
	alias pacin='sudo pacman -S'
	alias pacrm='sudo pacman -Rns'
	alias paccc='sudo pacman -Sc'
	alias pacro='pacman -Qdt'
	alias pacls='pacman -Qet'
	alias pacsr='pacman -Ss'
elif type apt-get &> /dev/null; then
	alias pacup='sudo apt-get upgrade'
	alias pacin='sudo apt-get install'
	alias pacrm='sudo apt-get remove'
	alias paccc='sudo apt-get autoclean'
	alias pacro='sudo apt-get autoremove'
	alias pacls='dpkg -l'
	alias pacsr='apt-cache search'
fi

command_not_found_handler() {
	local pkg cmd="$1"

	pkg=$(pkgfile -b -v -- "$cmd" 2>/dev/null |
		head -n1 |
		sed "s/^/${fg_bold[magenta]}/" |
		sed "s:/:/${reset_color}:" |
		sed "s/ / ${fg_bold[green]}/" |
		sed "s/\t.*/${reset_color}/"
	)

	if [[ -n "$pkg" ]]; then
		printf '%s may be found in ' "$cmd"
		printf "%s\n" $pkg
		return 0
	fi

	return 127
}
