# TMUX_VIM=1
# export $(tmux showenv -g TMUX_VIM)
# tmux setenv -g  TMUX_VIM "$(($TMUX_VIM*-1))"
# echo $TMUX_VIM
# STATUS_RIGHT=$(tmux show-option -vg status-right)
# echo $STATUS_RIGHT
# [ $1 -eq 1 ] && tmux send-keys $(tmux showenv TMUX_VIM)

# Constants
#modes select, resize, move
MODE_SELECT=S
MODE_RESIZE=R
MODE_MOVE=M

TMUX_ON=1
TMUX_RESIZE_UNIT=5
VIM_RESIZE_UNIT=5

# Toggle
TMUX_VIM_TOGGLE_OPTION=$(tmux show-option -vg @TMUX_VIM_TOGGLE 2>/dev/null)
TMUX_VIM_TOGGLE=$TMUX_VIM_TOGGLE_OPTION

TMUX_VIM_MODE_OPTION=$(tmux show-option -vg @TMUX_VIM_MODE 2>/dev/null)
TMUX_VIM_MODE=$TMUX_VIM_MODE_OPTION

init() {
    keybind

    # Vim/Tmux toggle state, default 1 = TMUX
    TMUX_VIM_TOGGLE=1
    tmux set-option -g @TMUX_VIM_TOGGLE 1

    TMUX_VIM_MODE=$MODE_SELECT
    tmux set-option -g @TMUX_VIM_MODE $TMUX_VIM_MODE

    tmux set-option -ag status-right "#(tmux show-option -vg @TMUX_VIM_LABEL)"
    updateLabelOption
}
keybind() {
    tmux unbind-key v
    tmux bind-key   v run-shell "$0 toggle"

    tmux unbind-key s
    tmux bind-key   s run-shell "$0 modeSelect"

    tmux unbind-key r
    tmux bind-key   r run-shell "$0 modeResize"

    tmux unbind-key -n C-h
    tmux unbind-key h
    tmux bind-key   h run-shell "$0 actionLeft"
    tmux bind-key   -n C-h run-shell "$0 actionLeft"

    tmux unbind-key -n C-j
    tmux unbind-key j
    tmux bind-key   j  run-shell "$0 actionDown"
    tmux bind-key   -n C-j run-shell "$0 actionDown"

    tmux unbind-key -n C-k
    tmux unbind-key k
    tmux bind-key   k  run-shell "$0 actionUp"
    tmux bind-key   -n C-k run-shell "$0 actionUp"

    tmux unbind-key -n C-l
    tmux unbind-key l
    tmux bind-key   l  run-shell "$0 actionRight"
    tmux bind-key   -n C-l run-shell "$0 actionRight"
}

toggle() {
    TMUX_VIM_TOGGLE=$(($TMUX_VIM_TOGGLE_OPTION*-1))
    tmux set-option -g @TMUX_VIM_TOGGLE $TMUX_VIM_TOGGLE
    updateLabelOption
}

modeSelect() {
    TMUX_VIM_MODE=$MODE_SELECT
    tmux set-option -g @TMUX_VIM_MODE $TMUX_VIM_MODE
    updateLabelOption
}

modeResize() {
    TMUX_VIM_MODE=$MODE_RESIZE
    tmux set-option -g @TMUX_VIM_MODE $TMUX_VIM_MODE
    updateLabelOption
}

updateLabelOption() {
    # Update label option
    if [ $TMUX_VIM_TOGGLE -eq 1 ]
    then tmux set-option -g @TMUX_VIM_LABEL " #[bg=yellow]TMUX-${TMUX_VIM_MODE}"
    else tmux set-option -g @TMUX_VIM_LABEL " #[bg=red]VIM-${TMUX_VIM_MODE}"
    fi
}

actionLeft() {
    if [ $TMUX_VIM_MODE = $MODE_SELECT ]
    then selectPaneLeft
    elif [ $TMUX_VIM_MODE = $MODE_RESIZE ]
    then resizePaneLeft
    fi
}

actionDown() {
    if [ $TMUX_VIM_MODE = $MODE_SELECT ]
    then selectPaneDown
    elif [ $TMUX_VIM_MODE = $MODE_RESIZE ]
    then resizePaneDown
    fi
}

actionUp() {
    if [ $TMUX_VIM_MODE = $MODE_SELECT ]
    then selectPaneUp
    elif [ $TMUX_VIM_MODE = $MODE_RESIZE ]
    then resizePaneUp
    fi
}

actionRight() {
    if [ $TMUX_VIM_MODE = $MODE_SELECT ]
    then selectPaneRight
    elif [ $TMUX_VIM_MODE = $MODE_RESIZE ]
    then resizePaneRight
    fi
}

selectPaneLeft() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux select-pane -L
    else tmux send-keys C-w h
    fi
}
selectPaneDown() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux select-pane -D
    else tmux send-keys C-w j
    fi
}
selectPaneUp() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux select-pane -U
    else tmux send-keys C-w k
    fi
}
selectPaneRight() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux select-pane -R
    else tmux send-keys C-w l
    fi
}
resizePaneLeft() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux resize-pane -L $TMUX_RESIZE_UNIT
    else tmux send-keys C-w ${VIM_RESIZE_UNIT}\<
    fi
}
resizePaneDown() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux resize-pane -D $TMUX_RESIZE_UNIT
    else tmux send-keys C-w ${VIM_RESIZE_UNIT}\+
    fi
}
resizePaneUp() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux resize-pane -U $TMUX_RESIZE_UNIT
    else tmux send-keys C-w ${VIM_RESIZE_UNIT}\-
    fi
}
resizePaneRight() {
    if [ $TMUX_VIM_TOGGLE -eq $TMUX_ON ]
    then tmux resize-pane -R $TMUX_RESIZE_UNIT
    else tmux send-keys C-w ${VIM_RESIZE_UNIT}\>
    fi
}
$1
# Refresh the -S status bar only
tmux refresh-client -S
# in tmux to display
