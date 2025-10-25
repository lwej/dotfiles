#!/bin/bash

function do_install() {
    if [ -d "$DARKMAN_SOURCE_PATH" ]; then
        cd "$DARKMAN_SOURCE_PATH" || exit
    fi

    if [! command -v darkman >/dev/null 2>&1]; then
        make
        sudo make install PREFIX=/usr
        systemctl --user enable --now darkman.service
    fi

    if [ -d "$DARKMAN_DARK_CONF_PATH" ]; then
        echo "Symlinking $DARKMAN_DARK_CONF_PATH..."
        sudo ln -s "$DARKMAN_DARK_CONF_PATH" "/usr/share/dark-mode.d"
    fi

    if [ -d "$DARKMAN_LIGHT_CONF_PATH" ]; then
        echo "Symlinking $DARKMAN_LIGHT_CONF_PATH..."
        sudo ln -s "$DARKMAN_LIGHT_CONF_PATH" "/usr/share/light-mode.d"
    fi
}

read -p "Install darkman (y/n)?" choice

case "$choice" in
  y|Y ) do_install;;
  n|N ) echo "Not installing then";;
  * ) echo "invalid option: $choice";;
esac
