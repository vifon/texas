#!/bin/bash

check-dependency() {
    if ! command -v "$1" &> /dev/null; then
        cat <<EOF

Warning:
  You don't have $1 installed.
  texas will not work without it.
EOF
        false
    else
        true
    fi
}

check-dependencies() {
    local RET=0
    local STATUS
    while [ -n "$1" ]; do
        check-dependency "$1"
        STATUS=$?
        if [ "$RET" = 0 ]; then
            RET=$STATUS
        fi
        shift
    done
    return $RET
}

guess-shell-config() {
    local CONFIG
    case "$SHELL" in
        /bin/bash)
            CONFIG=$HOME/.bashrc
            ;;
        /bin/zsh)
            CONFIG=$HOME/.zshrc
            ;;
        *)
            CONFIG=
            ;;
    esac
    echo "$CONFIG"
}

ask() {
    local REPLY
    while ! [ "$REPLY" = y -o "$REPLY" = n ]; do
        echo -n $'\n'"$1 [y/n] "
        read -n 1
        echo -n $'\n'
    done
    test "$REPLY" = "y"
}

confirmation() {
    ask "\
This install script will append a few lines to your shell config.
You will be asked for the config path later. Is that ok?"
}

config-select() {
    local CONFIG
    CONFIG="$1"

    if [ -t 0 ]; then
        local REPLY
        read -e -p $'\n'"Select you shell config path: " -i "$CONFIG"
        echo "$REPLY"
    else
        echo "$CONFIG"
    fi
}

install() {
    local CONFIG MODE
    while [ -n "$1" ]; do
        case "$1" in
            --zsh)
                MODE=zsh
                shift
                ;;
            --config)
                shift
                CONFIG="$1"
                shift
                ;;
        esac
    done

    local TEXAS_DIR
    TEXAS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    if [ "$MODE" = "zsh" ]; then
        echo "Installing the zsh plugin..."
        ln -sf texas.zsh "$TEXAS_DIR/texas"
        cat <<EOF >> "$CONFIG"
fpath=("$TEXAS_DIR" \$fpath)
source "$TEXAS_DIR/texas_init.zsh"
EOF
    else
        echo "Installing the bash plugin..."
        cat <<EOF >> "$CONFIG"
source "$TEXAS_DIR/texas.bash"
EOF
    fi

    echo "Installing the ranger plugin..."
    mkdir -p "$HOME/.config/ranger/plugins"
    ln -sf "$TEXAS_DIR/texas.py" -t "$HOME/.config/ranger/plugins"

    if ask "Do you want to bind alt+z to texas?"; then
        echo "Installing the keybind..."
        if [ "$MODE" = "zsh" ]; then
            cat <<'EOF' >> "$CONFIG"
bindkey -s '\ez' "\eq texas\n"
EOF
        else
            cat <<'EOF' >> "$CONFIG"
bind -x '"\ez":"texas"'
EOF
        fi
    fi

    cat <<EOF

Note:
  If you move $TEXAS_DIR, you will need to adjust the lines
  just added to $CONFIG and the created symbolic links.

Installation complete! Have fun!
EOF
}

main() {
    if ! check-dependencies "ranger" "tmux"; then
        if ! ask "Do you want to continue nonetheless?"; then
            exit
        fi
    fi

    local DEFCONFIG
    DEFCONFIG="$(guess-shell-config)"

    if ! confirmation; then
        exit
    fi

    local CONFIG
    CONFIG="$(config-select "$DEFCONFIG")"

    if [ "$SHELL" = "/bin/zsh" ]; then
        install --zsh --config "$CONFIG"
    else
        install --config "$CONFIG"
    fi
}

main
