###Organize and make general copy for use on other machines
umask 077
#setopt completealiases
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

export PROMPT="%(?.%{$fg_no_bold[white]%}.%{$fg_no_bold[red]%})%# %{$reset_color%}"
export SPROMPT="Correct $fg_no_bold[red]%R$reset_color to $fg_no_bold[green]%r$reset_color? "
#export MOZ_DISABLE_PANGO=1
export CORRECT_IGNORE='_*'

if [ $(hostname) != "arch" ]; then
    export PROMPT="%m$PROMPT"
    export SPROMPT="%m$SPROMPT"
fi

export EDITOR="/usr/bin/vim -p"
export VISUAL="/usr/bin/vim -p"
export PATH=$PATH:~/.scripts:.

if [ -e /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

alias d='dirs'
alias ls='ls --color=auto'
alias ll='ls -Ahl'
alias grep='grep --color=auto'
alias diff='colordiff'
eval $(dircolors -b)
alias sudo='sudo '

if type pacman &> /dev/null; then
    alias pacup='yaourt -Syua '       # Sync & upgrade
    alias pacin='yaourt -S '          # Install package
    alias paclo='yaourt -U '          # Install local package
    alias pacrm='yaourt -Rns '        # Purge package
    alias pacsr='pacman -Ss '         # Search official repos
    alias pacsa='yaourt -Ss '         # Search repos & AUR
    alias pacro='yaourt -Qtd '        # Remove orphans
    alias pacls='yaourt -Qet '        # List installed packages
    alias paccc='yaourt -Sc '         # Clean cache
elif type apt-get &> /dev/null; then
    alias pacup='sudo apt-get upgrade '
    alias pacin='sudo apt-get install '
    alias pacrm='sudo apt-get remove '
    alias pacsr='apt-cache search '
    alias pacro='sudo apt-get autoremove '
    alias pacls='dpkg -l '
    alias paccc='sudo apt-get autoclean '
fi

alias dtb='echo "main(i){for(i=0;;i++)putchar(((i*(i>>3|i>>11)&43&i>>8))^(i&i>>12|i>>4));}" | gcc -x c - && ./a.out | aplay'
#turn into a prog which can specify channels/recordings; run devilspie to keep aspect ratio
alias tv='vlc ~/Videos/channels.xspf 2> /dev/null --no-playlist-autostart &'
alias luvpn='sudo openconnect --user=dbc215 --authgroup=GeneralAccess sslvpn.lehigh.edu'
alias viw='vim -R'
alias reflect='sudo reflector --verbose -l 20 -p http --sort rate --save /etc/pacman.d/mirrorlist'
alias trash='gvfs-trash'

man() {
	env \
        LESS_TERMCAP_md=$(printf "\e[1;32m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[0;41;30m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[0;32m") \
			man "$@"
}

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0073642" # Black
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
    #clear # Clear artifacts
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
