#!/usr/bin/env bash

# alacritty supports changing config realtime so just replace themename

# alacritty.yml
# sed -i -e 's/colors: \*default_light/colors: \*default_dark/g' ~/.config/alacritty/alacritty.yml

# alacritty.toml
sed -i -e 's/default_light/default_dark/g' ~/.config/alacritty/alacritty.toml
