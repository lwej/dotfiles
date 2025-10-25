#!/bin/bash

function do_install() {
    if [ -d "$NVIM_SOURCE_PATH" ]; then
        cd "$NVIM_SOURCE_PATH" || exit
    fi
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
}

read -p "Install NeoVim (y/n)?" choice

case "$choice" in
  y|Y ) do_install;;
  n|N ) echo "Not installing then";;
  * ) echo "invalid option: $choice";;
esac
