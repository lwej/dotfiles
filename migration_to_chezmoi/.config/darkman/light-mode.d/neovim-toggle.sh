#!/usr/bin/env bash

# This uses the neovim-remote python package to control other neovim instances.
# see: https://github.com/mhinz/neovim-remote
# Further, it is assumed that toggling the theme in neovim is enough.

for server in $(nvr --serverlist); do
    nvr --servername "$server" --remote-send '<space>tt'
done
