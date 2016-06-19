# -*- sh -*-

if ! command -v ranger &> /dev/null && ! command -v tmux &> /dev/null; then
    return 1
fi

texas()
{
    # Start a new tmux session with texas inside.
    if [ -z "$TMUX" ]; then
        tmux -L texas new-session 'LAUNCH_TEXAS=1 bash'
        return
    fi

    TEXAS_RANGER_PID=$(tmux split-window -p 70 -P -F '#{pane_pid}' "TEXAS_BASH=1 LAUNCH_TEXAS=$LAUNCH_TEXAS TEXAS_SHELL_PID=$$ ranger")

    # Unset the variable only here because the ranger plugin reacts to it.
    unset LAUNCH_TEXAS

    cd()
    {
        builtin cd "$@"
        if ! kill -USR1 $TEXAS_RANGER_PID 2> /dev/null; then
            # ranger is no longer running, let's clean up the bash state.

            # The ranger's PID is no longer needed.
            unset TEXAS_RANGER_PID

            # Remove the hook because there is no ranger to communicate with.
            unset -f cd
        fi
    }

    texas--exit-cleanup() {
        kill -HUP $TEXAS_RANGER_PID
    }
    trap texas--exit-cleanup EXIT

    texas--ranger-to-sh-sync() {
        builtin cd -P /proc/$TEXAS_RANGER_PID/cwd
        # FIXME: update the prompt
    }
    trap texas--ranger-to-sh-sync USR1


    texas--switch-to-ranger() {
        if [ "$(tmux display-message -p '#{window_panes}')" -gt 1 ]; then
            tmux select-pane -t :.+
        else
            tmux next-window
        fi
    }
}

if [ -n "$LAUNCH_TEXAS" ]; then
    texas
fi
