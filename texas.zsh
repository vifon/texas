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
    kill -USR1 $TEXAS_RANGER_PID
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


texas--switch-to-ranger() {
    if [ "$(tmux display-message -p '#{window_panes}')" -gt 1 ]; then
        tmux select-pane -t :.+
    else
        tmux next-window
    fi
}
zle -N texas--switch-to-ranger
bindkey "^o" texas--switch-to-ranger
