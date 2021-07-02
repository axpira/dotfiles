. ~/.config/profile

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

calc() {
  dc -e "$1 p"
}

extract() {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#PS1="\[\033[01;32m\]]0;\u@\h:\w\007\]\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$(parse_git_branch) \$\[\033[00m\] "
#PS1="\[\033[01;38;5;60m\]\u@\h\[\033[01;38;5;240m\] \w \$(parse_git_branch) \$\[\033[00m\] "
PS1="\[\033[01;38;5;240m\]\w\[\033[01;30;5;240m\]\$(parse_git_branch)\[\033[01;38;5;60m\]\$\[\033[00m\] "

set -o vi
bind 'set show-mode-in-prompt on'
set enable-bracketed-paste on
bind '"\C-l":clear-screen'
shopt -s histappend
shopt -s lithist
shopt -s progcomp_alias

alias ll='ls -lh'
alias la='ls -lah'
#alias vim="nvim"
alias texi2pdf="texi2pdf --clean"
alias mplayer="mplayer -af scaletempo"
alias gocover="go test -coverprofile=coverage.out && go tool cover -html=coverage.out"
alias wttr="curl wttr.in"
alias rate="curl rate.sx"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
#alias kke='kubectl get pods --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains("Evicted")) | "kubectl delete pods \(.metadata.name) -n \(.metadata.namespace)"' | xargs -n 1 bash -c'
alias tf="tail -f /var/log/messages"
alias vb="vimb -e tabbed"
alias dua="du -sch .[!.]* * |sort -h"
alias g="git"

## Base16 Shell
#BASE16_SHELL="$HOME/.config/base16-shell/"
#[ -n "$PS1" ] && \
#    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#        eval "$("$BASE16_SHELL/profile_helper.sh")"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Base16 Tomorrow Night
# Author: Chris Kempson (http://chriskempson.com)

_gen_fzf_default_opts() {

local color00='#1d1f21'
local color01='#282a2e'
local color02='#373b41'
local color03='#969896'
local color04='#b4b7b4'
local color05='#c5c8c6'
local color06='#e0e0e0'
local color07='#ffffff'
local color08='#cc6666'
local color09='#de935f'
local color0A='#f0c674'
local color0B='#b5bd68'
local color0C='#8abeb7'
local color0D='#81a2be'
local color0E='#b294bb'
local color0F='#a3685a'

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"

}

_gen_fzf_default_opts

source <(kubectl completion bash)
