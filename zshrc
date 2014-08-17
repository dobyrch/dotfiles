umask 077
setopt correct
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
autoload -U compinit promptinit
autoload -U colors && colors
compinit
promptinit

export PROMPT="%(?.%{$fg_no_bold[white]%}.%{$fg_no_bold[red]%})%(!.#.>)%{$reset_color%} "
export SPROMPT="Correct $fg_no_bold[red]%R$reset_color to $fg_no_bold[green]%r$reset_color? "
export CORRECT_IGNORE='_*'

if [ $(hostname) != 'arch' ]; then
    export PROMPT="%m${PROMPT}"
fi

export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'
export PAGER='less -i'
export PATH="${PATH}:${HOME}/.scripts"

#Setup Go
export GOPATH="${HOME}/Documents/go"
export PATH="${PATH}:${GOPATH}/bin"

if [ -e '/usr/share/doc/pkgfile/command-not-found.zsh' ]; then
    source '/usr/share/doc/pkgfile/command-not-found.zsh'
fi

eval $(dircolors -b)
alias diff='colordiff'
alias dtb='echo "main(i){for(i=0;;i++)putchar(((i*(i>>3|i>>11)&43&i>>8))^(i&i>>12|i>>4));}" | cc -x c - && ./a.out | aplay'
alias grep='grep --color=always'
alias info='info --vi-keys'
alias less='less -Ri'
alias ll='ls -Ahl'
alias ls='ls --color=always'
alias reconf="source ${HOME}/.zshrc"
alias reflect='sudo reflector -l 20 -p http --sort rate --save /etc/pacman.d/mirrorlist'
alias sd='systemctl'
alias sudo='sudo '
alias todo='grep -nr "TODO" * | sed "s/\([^:]*TODO.*:\)\|\(\s*\*\/$\)/\x1B[0m/g"'
alias trash='gvfs-trash'
alias weather='telnet rainmaker.wunderground.com 3000'

if type pacman &> /dev/null; then
    alias pacup='yaourt -Syu '
    alias pacin='yaourt -S '
    alias paclo='yaourt -U '
    alias pacrm='yaourt -Rns '
    alias pacsr='pacman -Ss '
    alias pacsa='yaourt -Ss '
    alias pacro='yaourt -Qtd '
    alias pacls='yaourt -Qet '
    alias paccc='yaourt -Sc '
elif type apt-get &> /dev/null; then
    alias pacup='sudo apt-get upgrade '
    alias pacin='sudo apt-get install '
    alias pacrm='sudo apt-get remove '
    alias pacsr='apt-cache search '
    alias pacro='sudo apt-get autoremove '
    alias pacls='dpkg -l '
    alias paccc='sudo apt-get autoclean '
fi

# Colorize man pages
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;47;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;32m'

if [ "${TERM}" = "linux" ]; then
#   echo -en "\e]P0073642" # Black
    echo -en "\e]P1dc322f" # Red
    echo -en "\e]P2859900" # Green
    echo -en "\e]P3b58900" # Yellow
    echo -en "\e]P4268bd2" # Blue
    echo -en "\e]P5d33682" # Magenta
    echo -en "\e]P62aa198" # Cyan
    echo -en "\e]P7eee8d5" # White
    echo -en "\e]P8002b36" # Bright Black
    echo -en "\e]P9cb4b16" # Bright Red
    echo -en "\e]PA586e75" # Bright Green
    echo -en "\e]PB657b83" # Bright Yellow
    echo -en "\e]PC839496" # Bright Blue
    echo -en "\e]PD6c71c4" # Bright Magenta
    echo -en "\e]PE93a1a1" # Bright Cyan
    echo -en "\e]PFfdf6e3" # Bright White
fi

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' ${terminfo[smkx]}
    }
    function zle-line-finish () {
        printf '%s' ${terminfo[rmkx]}
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

