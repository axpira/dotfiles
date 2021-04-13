#/bin/bash

#set -ex


function isActive {
  local cmd=$(xprop -id $activeId $1)
  if [ -z "${cmd##*true*}" ]; then
      echo true
  else
      echo false
  fi
}
# tmux display-message -p '#{pane_at_left} #{pane_at_right}'
# bspc node -f west

#tmux display-message -p '#{pane_at_left} #{pane_at_right}'


# super + {_,shift + }{h,j,k,l}
# 	bspc node -{f,s} {west,south,north,east}

direction=$1

case $direction in
    l|left)
        bspcDirection="west"
        tmuxDirection="L"
        direction="left"
        key="h"
        ;;
    d|down)
        bspcDirection="south"
        tmuxDirection="D"
        direction="bottom"
        key="j"
        ;;
    u|up)
        bspcDirection="north"
        tmuxDirection="U"
        direction="top"
        key="k"
        ;;
    r|right)
        bspcDirection="east"
        tmuxDirection="R"
        direction="right"
        key="l"
        ;;
esac

# is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
#     | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

# logger $($is_vim)

# logger "IS VIM $is_vim"

activeId=$(xdo id)

tmuxActive=$(isActive 'HAS_TMUX')
vimActive=$(isActive 'HAS_VIM')
#logger $(date)
logger "START---------------"
logger "TmuxActive $tmuxActive VimActive $vimActive" 
logger "$(printf %d $(tmux list-panes | wc -l))"
logger "bspcDirection [$bspcDirection] tmuxDirection [$tmuxDirection] direction [$direction] key [$key]"

#/home/axpira/.local/bin/nvr --remote-send "<esc><c-w><c-$key>"
#logger $?
#logger "<esc><c-w><c-$key>"
#exit 0
logger "TmuxStatus [$tmuxStatus] TmuxActive [$tmuxActive] Direction [$direction] TmuxDirection [$tmuxDirection] [$key]"


tmuxInfo=$(tmux display-message -p "#{pane_active} #{pane_left}-#{pane_bottom}-#{pane_top}-#{pane_right} #{pane_at_left}#{pane_at_bottom}#{pane_at_top}#{pane_at_right}")
logger "Infos $tmuxInfo"
#tmux send-keys "M-$key"
if [ $tmuxActive == true ]; then
    tmuxStatus=$(tmux display-message -p "#{pane_at_${direction}}")
#    logger "TmuxStatus [$tmuxStatus] TmuxActive [$tmuxActive] Direction [$direction] TmuxDirection [$tmuxDirection] [$key]"
    #cmd="$(tmux display -p '#{pane_current_command}')"
    #cmd="$(basename "$cmd" | tr A-Z a-z)"
    #logger "CMD [$cmd]"
    #if [ "$cmd" == "nvim" ]; then
    #    logger "esta no vim"
    #    tmux send-keys M-$key
    #    logger $?
    #    tmuxStatusNew=$(tmux display-message -p "#{pane_at_${direction}}")
    #    logger "From $tmuxStatus to $tmuxStatusNew"
    #    if [ $tmuxStatus == $tmuxStatusNew  && $tmuxStatus == 0 ]; then
    #        tmux select-pane -$tmuxDirection
    #    fi
    #    #exit
    #else
    #    tmux select-pane -$tmuxDirection

    #    #if [ $tmuxStatus == 0 ]; then
    #    #    #tmux send-keys M-$key
    #    #    #exit
    #    #fi
    #fi
    tmux send-keys M-$key

    tmuxStatusNew=$(tmux display-message -p "#{pane_at_${direction}}")
    #if [ $tmuxStatus != $tmuxStatusNew ]; then
    #    tmux select-pane -$tmuxDirection
    #fi
    logger "From $tmuxStatus to $tmuxStatusNew"
    #tmux send-keys M-$key
    #tmuxStatus=$(tmux display-message -p "#{pane_at_${direction}}")
    #logger "TmuxStatus [$tmuxStatus]"

    #tmux send-keys M-$key
    exit
fi

tmuxInfo=$(tmux display-message -p "#{pane_active} #{pane_left}-#{pane_bottom}-#{pane_top}-#{pane_right} #{pane_at_left}#{pane_at_bottom}#{pane_at_top}#{pane_at_right}")
logger "Infos $tmuxInfo"
bspc node -f $bspcDirection


