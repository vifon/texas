# -*- sh -*-

if ! (( $+commands[ranger] && $+commands[tmux] )); then
    return 1
fi

autoload -U texas
if [ -n "$LAUNCH_TEXAS" ]; then
    unset LAUNCH_TEXAS
    texas
fi
