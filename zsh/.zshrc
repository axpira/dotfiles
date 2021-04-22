source $ZPLUGINSDIR/zsh-completions/zsh-completions.plugin.zsh
source $ZPLUGINSDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZPLUGINSDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZPLUGINSDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_SAVE_NO_DUPS    # Do not write a duplicate event to the history file.

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

_get_project_root () {
	root=$PWD
	while [[ $root != $HOME && ! -e $root/.git ]]; do
		root=$root:h
	done
	printf "%s" "$root"
}

dr() {
  cd $(_get_project_root)
}

alias tmux="tmux -f ${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"

function = { echo "2k $@ p" | dc }
alias calc="="

alias texi2pdf="texi2pdf --clean"
alias mplayer="mplayer -af scaletempo"
alias gocover="go test -coverprofile=coverage.out && go tool cover -html=coverage.out"
alias wttr="curl wttr.in"
alias rate="curl rate.sx"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
#alias zathura="devour zathura"
#alias sxiv="devour sxiv"
#alias mpv="devour mpv"
alias grep="grep --color=auto --exclude-dir={.git,artwork,node_modules,vendor}"
alias g='git'
alias gs='git status'
alias gl='git l'

# `ls` after `cd`
function cd {
  builtin cd "$@" && ls
}

setopt autocd extendedglob nomatch notify
unsetopt menu_complete
unsetopt flowcontrol


setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt interactivecomments
setopt share_history


export KEYTIMEOUT=1
bindkey -v
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

#zstyle :compinstall filename '/home/axpira/.config/zsh/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -Uz compinit && compinit
zmodload zsh/complist

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#
#

cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats       '%b[%u%c]'
zstyle ':vcs_info:*:*' actionformats '%b|%a%u%c'
zstyle ':vcs_info:*:*' stagedstr         "%{${fg[green]}%}${PRCH[circle]}"
zstyle ':vcs_info:*:*' unstagedstr       "%{${fg[yellow]}%}${PRCH[circle]}"
zstyle ':vcs_info:*:*' check-for-changes true

add-zsh-hook precmd vcs_info

PROMPT='%F{blue}%~ %F{244}%# %F{reset}'
RPROMPT='%F{244}${vcs_info_msg_0_}'

if [[ -f ~/.alias && -r ~/.alias ]]; then
	source ~/.alias
fi

if [[ -f ~/.env && -r ~/.env ]]; then
	source ~/.env
fi

source $HOME/.fzf.zsh
