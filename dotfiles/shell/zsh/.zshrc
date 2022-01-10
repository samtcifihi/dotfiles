# Lines configured by zsh-newuser-install
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/eatrosin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ghcup (Haskell Installer/Manager)
[ -f "/home/eatrosin/.ghcup/env" ] && source "/home/eatrosin/.ghcup/env"


autoload -U colors && colors

# Luke Smith prompt
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# auto cd into directory
setopt autocd

# disable ctrl-s
stty stop undef

# enable comments
setopt interactive_comments

# History File
HISTFILE=~/.zshdata/histfile
HISTSIZE=1000000
SAVEHIST=1000000

# load .zsh_aliases, if it exists
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"

# basic tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vim mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[3 q';;      # underscore
        viins|main) echo -ne '\e[1 q';; # block
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[1 q"
}
zle -N zle-line-init
echo -ne '\e[1 q' # Use block shape cursor on startup.
preexec() { echo -ne '\e[1 q' ;} # Use block shape cursor for each new prompt.

# edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# use lf to cd to another directory
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Load syntax highlighting; should be last.
# source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null