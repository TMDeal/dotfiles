#!/bin/bash

# Expand out aliases within script
shopt -s expand_aliases

# Application Versions
GREENCLIP_VERSION="4.2"
NVIM_VERSION="stable"
NVM_VERSION="0.39.2"
NERD_FONT_VERSION="3.0.2"
NERD_FONT="Inconsolata"

# Dependency List
ALL_DEPS="$DEPS $PYENV_DEPS $ALACRITTY_DEPS $POLYBAR_DEPS $I3_DEPS"

# .local folders
APPLICATIONS_DIR="$HOME/.local/share/applications"
ICONS_DIR="$HOME/.local/share/icons"
FONTS_DIR="$HOME/.local/share/fonts"
NERD_FONT_DIR="$FONTS_DIR/$NERD_FONT"

function apt {
    export DEBIAN_FRONTEND=noninteractive
    export DEBIAN_PRIORITY=critical
    export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
    command /usr/bin/apt --yes --quiet --option Dpkg::Options::=--force-confold --option Dpkg::Options::=--force-confdef "$@"
}

sudo apt update
sudo apt upgrade
sudo apt autoremove

# 1. General Packages
# 2. Pyenv Dependencies
# 3. Alacritty Dependencies
# 4. Polybar Dependencies
# 5. I3 Dependencies
sudo apt install \
    lm-sensors keepassxc zoxide fzf rofi xclip jq xq htop remmina flameshot chromium tmux python3-venv fd-find luarocks autorandr picom libreoffice bat ripgrep stow \
    build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc \
    build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev \
    i3 nitrogen lxpolkit udiskie picom brightnessctl alsa-utils dunst

# Create folders in .local/share
mkdir "$APPLICATIONS_DIR"
mkdir "$ICONS_DIR"
mkdir "$FONTS_DIR"
mkdir "$NERD_FONT_DIR"

# Install prefered font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v$NERD_FONT_VERSION/$NERD_FONT.zip" -O "/tmp/$NERD_FONT.zip"
unzip "/tmp/$NERD_FONT.zip" -d "$NERD_FONT_DIR"
fc-cache

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install pyenv
curl https://pyenv.run | bash

# install poetry
curl -sSL https://install.python-poetry.org | python3

# install pipx
pip install --user pipx
pipx install jrnl
pipx install sqlmap
pipx install netexec
pipx install impacket

# install nvm
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | bash
source "$HOME/.nvm/nvm.sh"
nvm install --lts

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup override set stable
rustup update stable

cargo install eva
cargo install starship --locked

# install tmux and tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
"$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

# install Alacritty
git clone https://github.com/alacritty/alacritty.git /tmp/alacritty
cd /tmp/alacritty && cargo build --release

sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc <extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
scdoc <extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
scdoc <extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
scdoc <extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

# install polybar
sudo git clone --recursive https://github.com/polybar/polybar /tmp/polybar && cd /tmp/polybar
sudo mkdir build && cd build
sudo cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
sudo make -j$(nproc)
sudo make install

# install neovim
wget "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim.appimage" -O /tmp/nvim
chmod +x /tmp/nvim
sudo mv /tmp/nvim /usr/local/bin

# install greenclip
wget "https://github.com/erebe/greenclip/releases/download/v$GREENCLIP_VERSION/greenclip" -O /tmp/greenclip
chmod +x /tmp/greenclip
sudo mv /tmp/greenclip /usr/local/bin

# install seclists
sudo mkdir /opt/wordlists
sudo git clone https://github.com/danielmiessler/SecLists /opt/wordlists/seclists

# Installing exploitdb
sudo git clone https://gitlab.com/exploit-database/exploitdb.git /opt/exploitdb
sudo ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit
sudo cp -n /opt/exploitdb/.searchsploit_rc ~/.searchsploit_rc

echo "Setup is Complete!"
echo "Reboot to Finish Setup"
