setopt correct
setopt auto_pushd
setopt pushd_silent
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt interactive_comments
autoload compinit && compinit
autoload colors && colors
autoload zcalc
autoload zmv

bindkey -v
bindkey '^H' backward-delete-char
bindkey '^?' backward-delete-char
autoload edit-command-line && zle -N edit-command-line
bindkey -M vicmd '^W' edit-command-line
bindkey -M viins '^W' edit-command-line

export PROMPT="%(?.%{${fg_no_bold[white]}%}.%{${fg_no_bold[red]}%})%(!.#.>)%{${reset_color}%} "
export SPROMPT="Correct ${fg_no_bold[red]}%R${reset_color} to ${fg_no_bold[green]}%r${reset_color}? "
export CORRECT_IGNORE='_*'
export DIRSTACKSIZE='10'

export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'
export PAGER='less -i'

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
alias d='dirs -pv'
alias decrypt='pass usb | e4crypt add_key | grep -v "passphrase"'
alias du='du --max-depth=1 -h'
alias ffmpeg='ffmpeg -hide_banner'
alias grep='grep --color=auto'
alias info='info --vi-keys'
alias less='less -Ri'
alias ll='ls -Ahl'
alias ls='ls -N --color=auto'
alias reflect='sudo reflector -p https -l 20 -f 4 --save /etc/pacman.d/mirrorlist'
alias sd='systemctl'
alias setvol='pactl set-sink-input-volume'
alias sudo='sudo '
alias todo='grep -nr "TODO" * | sed "s/\([^:]*TODO.*:\)\|\(\s*\*\/$\)/\x1B[0m/g"'
alias trash='gvfs-trash'

sudo_pacman() { sudo pacman "${@}" && rehash }
compdef sudo_pacman=pacman
alias pacup='sudo_pacman -Syu'
alias pacin='sudo_pacman -S'
alias pacrm='sudo_pacman -Rs'
alias pacls='pacman -Qet'
alias pacor='pacman -Qdt'
alias pacsr='pacman -Ss'

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
		printf '%s\n' $pkg
	else
		printf 'command not found: %s\n' "$cmd"
	fi

	return 127
}

pd() {
	local stack=( ${(f)"$(dirs -p)"} )
	shift stack

	select dir in "${stack[@]}"; do
		dir="${dir/\~/${HOME}}"
		cd "${dir:-.}"
		break
	done
}

if [[ -v ONESHOT ]]; then
	run_once() {
		BUFFER="{ {${BUFFER}} || notify-send 'Command failed: ${BUFFER}' } &!; exit"
		zle ".${WIDGET}" "${@}"
	}

	zle -N accept-line run_once
fi
