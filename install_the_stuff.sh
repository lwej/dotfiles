#!/bin/sh

# Just install the UI stuff
sudo apt install \
    ranger rofi bat i3 -y i3lock exa tldr scrot imagemagick maim polybar -y

# Install Hack font https://github.com/source-foundry/Hack/
cd ~/Downloads
echo "Installing Hack font system-wide"
wget https://github.com/source-foundry/Hack/blob/master/config/fontconfig/45-Hack.conf && sudo mv 45-Hack.conf /etc/fonts/conf.d/
wget -c https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.tar.gz && tar -xzf Hack-v3.003-ttf.tar.gz && cd ttf && sudo mv * /usr/share/fonts/
fc-cache -f -v
fc-list | grep "Hack"
