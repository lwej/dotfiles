#!/usr/bin/env bash

# alacritty supports changing config realtime so just replace themename

# alacritty.yml
# sed -i -e 's/colors: \*default_dark/colors: \*default_light/g' ~/.config/alacritty/alacritty.yml

# alacritty.toml
sed -i -e 's/default_dark/default_light/g' ~/.config/alacritty/alacritty.toml
