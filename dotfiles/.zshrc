# Lines configured by zsh-newuser-install
HISTFILE=~/.zshdata/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/eatrosin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
[ -f "/home/eatrosin/.ghcup/env" ] && source "/home/eatrosin/.ghcup/env" # ghcup-env
