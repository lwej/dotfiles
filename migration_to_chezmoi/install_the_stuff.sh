#!/bin/sh

sudo apt install \
    ranger rofi bat i3 i3lock exa tldr scrot imagemagick maim snapd ripgrep fzf shellcheck -y

sudo snap install \
    --beta nvim --classic && sudo snap install alacritty

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install Hack font https://github.com/source-foundry/Hack/
cd ~/Downloads || exit
echo "Installing Hack font and Hack Nerd font system-wide"
wget https://raw.githubusercontent.com/source-foundry/Hack/master/config/fontconfig/45-Hack.conf && sudo mv 45-Hack.conf /etc/fonts/conf.d/
wget -c https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.tar.gz && tar -xzf Hack-v3.003-ttf.tar.gz && cd ttf && sudo cp ./*.ttf /usr/share/fonts/

# Install Hack Nerd Font
cd ~/Downloads || exit
wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip && unzip Hack.zip -d hack-nerd-font
cd hack-nerdfont && sudo cp /.*.ttf /usr/share/fonts


# Install nerd symbols
cd ~/Downloads || exit
wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip && unzip NerdFontsSymbolsOnly.zip -d nerd-font-symbols
cd nerd-font-symbols && sudo cp /.*.ttf /usr/share/fonts
fc-cache -f -v

fc-list | grep "Hack"
fc-list | grep "SymbolsNerd"

# NvChad
mv ~/.config/nvim ~/.config/nvim-backup
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

mv ~/.config/nvim-backup ~/.config/nvim

cd || exit

pip3 install neovim-remote
