#!/bin/zsh

. /etc/profile


#export QT_AUTO_SCREEN_SCALE=0
#export QT_SCALE_FACTOR=2
# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
#export BROWSER="qutebrowser"
#export BROWSER=luakit
export BROWSER=firefox
export READER=zathura
export SXHKD_SHELL="sh"

export PANEL_FIFO=/tmp/panel-fifo

# ~/ Clean-up:
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_TEMPLATES_DIR="$HOME/templates"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_VIDEOS_DIR="$HOME/videos"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZPLUGINSDIR="${XDG_DATA_HOME:-$HOME/.local/share}/zplugins"
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GOROOT="$HOME/.local/go/go"
export NODE_PATH="${XDG_DATA_HOME}/node_modules"
export NPM_CONFIG_PREFIX="$NODE_PATH"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export KUBECONFIG=~/.kube/config

export PATH="$HOME/.fzf/bin:$HOME/.local/bin/:$HOME/.config/script:$HOME/.local/share/cargo/bin:$GOROOT/bin:$GOPATH/bin:$NODE_PATH/bin:$PATH:."
#export PATH="$HOME/.local/bin/:$HOME/.config/script:$GOPATH/bin:$NODE_PATH/bin:$PATH"
export PATH="$PATH:$HOME/.config/script/funcs"

#export CDPATH=.:..:~:~/workspaces:~/.config
#export CDPATH=.:..
export CDPATH=.


export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export HISTSIZE=10000
export SAVEHIST=10000
export VIM_CACHE=${XDG_CACHE_HOME}/vim

# Other program settings:
#export VIMINIT='source $MYVIMRC'
#export MYVIMRC='$XDG_CONFIG_HOME/vim/vimrc'  #or any other location you want
#export DICS="/usr/share/stardict/dic/"
#export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
#export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
#export FZF_COMPLETION_TRIGGER='~~'
#export LS_OPTIONS="$LS_OPTIONS --group-directories-first"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"  # Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"  # Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D"	#May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
"

#[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc ] && shortcuts >/dev/null 2>&1 &
#if pacman -Qs libxft-bgra >/dev/null 2>&1; then
#	# Start graphical server on tty1 if not already running.
#	[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx
#else
#	echo "\033[31mIMPORTANT\033[0m: Note that \033[32m\`libxft-bgra\`\033[0m must be installed for this build of dwm.
#Please run:
#	\033[32myay -S libxft-bgra\033[0m
#and replace \`libxft\`"
#fi
#
## Switch escape and caps if tty and no passwd required:
#sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null
## This file is written by xdg-user-dirs-update
## If you want to change or add directories, just edit the line you're
## interested in. All local changes will be retained on the next run.
## Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
## homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
## absolute path. No other format is supported.
## 

#complete -C /home/axpira/.local/bin/vault vault

[ -f "$HOME/.env" ] && . $HOME/.env
[ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ] && exec sx
