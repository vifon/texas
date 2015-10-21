# -*- sh -*-

# Start a new tmux session with texas inside.
if [ -z "$TMUX" ]; then
    tmux -L texas new-session 'LAUNCH_TEXAS=1 zsh'
    return
fi

TEXAS_RANGER_PID=$(tmux split-window -p 70 -P -F '#{pane_pid}' "LAUNCH_TEXAS=$LAUNCH_TEXAS TEXAS_SHELL_PID=$$ ranger")

# Unset the variable only here because the ranger plugin reacts to it.
unset LAUNCH_TEXAS

autoload -U add-zsh-hook

texas--sh-to-ranger-sync() {
    if ! kill -USR1 $TEXAS_RANGER_PID 2> /dev/null; then
        # ranger is no longer running, let's clean up the zsh state.

        # The ranger's PID is no longer needed.
        unset TEXAS_RANGER_PID

        # TODO: save the original binding instead of hardcoding the assumed default.
        bindkey "^o" accept-line-and-down-history

        # Remove the hook because there is no ranger to communicate with.
        chpwd_functions=${chpwd_functions:#texas--sh-to-ranger-sync}
    fi
}
add-zsh-hook chpwd texas--sh-to-ranger-sync

texas--exit-cleanup() {
    kill -HUP $TEXAS_RANGER_PID
}
add-zsh-hook zshexit texas--exit-cleanup

texas--ranger-to-sh-sync() {
    if zle; then
        cd -qP /proc/$TEXAS_RANGER_PID/cwd
        zle reset-prompt
    fi
}
trap texas--ranger-to-sh-sync USR1

texas--ranger-to-sh-paths() {
    if zle; then
        local SELECTION_FILE=/tmp/texas-selection.$$
        local RANGER_SELECTION
        while read RANGER_SELECTION; do
            LBUFFER="${LBUFFER%% #} ${(q)RANGER_SELECTION}"
        done < $SELECTION_FILE
        rm -f $SELECTION_FILE
    fi
}
trap texas--ranger-to-sh-paths USR2


texas--switch-to-ranger() {
    if [ "$(tmux display-message -p '#{window_panes}')" -gt 1 ]; then
        tmux select-pane -t :.+
    else
        tmux next-window
    fi
}
zle -N texas--switch-to-ranger
bindkey "^o" texas--switch-to-ranger
