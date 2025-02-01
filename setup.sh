#!/bin/bash

# Expand out aliases within script
shopt -s expand_aliases

# Application Versions
GREENCLIP_VERSION="4.2"
NVIM_VERSION="stable"
NVM_VERSION="0.39.2"
NERD_FONT_VERSION="3.0.2"
NERD_FONT="Inconsolata"
ALACRITTY_VERSION="0.15.0"
POLYBAR_VERSION="3.7.2"
BLOODHOUND_CLI_VERSION="0.1.3"
DOCKER_COMPOSE_VERSION="2.32.4"
GO_VERSION="1.23.5"
CHISEL_VERSION="1.10.1"
ETCHER_VERSION="1.19.25"

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

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor >/tmp/signal-desktop-keyring.gpg
cat /tmp/signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg >/dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |
    sudo tee /etc/apt/sources.list.d/signal-xenial.list

sudo apt update
sudo apt upgrade
sudo apt autoremove

# 1. General Packages
# 2. Pyenv Dependencies
# 3. Alacritty Dependencies
# 4. Polybar Dependencies
# 5. I3 Dependencies
# 6. john Dependencies
sudo apt install \
    lm-sensors keepassxc zoxide fzf rofi xclip jq xq htop remmina flameshot chromium tmux python3-venv fd-find luarocks autorandr picom libreoffice bat ripgrep stow libgssapi-krb5-2 docker.io signal-desktop build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev microsoft-edge-stable cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc \
    build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev \
    i3 nitrogen lxpolkit udiskie picom brightnessctl alsa-utils dunst \
    libnss3-dev libkrb5-dev libgmp-dev libbz2-dev zlib1g-dev

# Create folders in .local/share
mkdir "$APPLICATIONS_DIR"
mkdir "$ICONS_DIR"
mkdir "$FONTS_DIR"
mkdir "$NERD_FONT_DIR"

# Install prefered font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v$NERD_FONT_VERSION/$NERD_FONT.zip" -O "/tmp/$NERD_FONT.zip"
unzip "/tmp/$NERD_FONT.zip" -d "$NERD_FONT_DIR"
fc-cache

# Docker setup
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose

# install Alacritty
git clone https://github.com/alacritty/alacritty.git /tmp/alacritty && cd /tmp/alacritty
git checkout "v$ALACRITTY_VERSION"
cargo build --release

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

# Install golang
curl -SL https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz -o /tmp/go.tar.gz && sudo tar -xvzf /tmp/go.tar.gz -C /usr/local/go

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install poetry
curl -sSL https://install.python-poetry.org | python3

# install uv python package and version maanger
curl -LsSf https://astral.sh/uv/install.sh | sh

# install nvm
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | bash
source "$HOME/.nvm/nvm.sh"
nvm install --lts

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup override set stable
rustup update stable

# install tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
"$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

# install pacakges with uv
uv tool install jrnl
uv tool install sqlmap
uv tool install git+https://github.com/Pennyw0rth/NetExec
uv tool install impacket
uv tool install semgrep
uv tool install bloodhound
uv tool install bloodyad

# install cargo packages
cargo install starship --locked

# install polybar
git clone --recursive https://github.com/polybar/polybar /tmp/polybar && cd /tmp/polybar
git checkout "$POLYBAR_VERSION"
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=~/.local ..
make -j$(nproc)
make install

# install neovim
wget "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim.appimage" -O /tmp/nvim
chmod +x /tmp/nvim
mv /tmp/nvim ~/.local/bin/nvim

# install greenclip
wget "https://github.com/erebe/greenclip/releases/download/v$GREENCLIP_VERSION/greenclip" -O /tmp/greenclip
chmod +x /tmp/greenclip
mv /tmp/greenclip ~/.local/bin/greenclip

# install act for testing ci actions
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nektos/act/master/install.sh -o /tmp/act-install.sh && chmod +x /tmp/act-install.sh
/tmp/act-install.sh -b ~/.local/bin

# install chisel for tunneling
mkdir ~/.local/share/chisel
curl -SL "https://github.com/jpillora/chisel/releases/download/v$CHISEL_VERSION/chisel_${CHISEL_VERSION}_linux_amd64.gz" | gunzip >~/.local/share/chisel/chisel-$CHISEL_VERSION-linux && chmod +x ~/.local/share/chisel/chisel-$CHISEL_VERSION-linux
curl -SL "https://github.com/jpillora/chisel/releases/download/v$CHISEL_VERSION/chisel_${CHISEL_VERSION}_windows_amd64.gz" | gunzip >~/.local/share/chisel/chisel-$CHISEL_VERSION-windows-x64.exe
curl -SL "https://github.com/jpillora/chisel/releases/download/v$CHISEL_VERSION/chisel_${CHISEL_VERSION}_windows_386.gz" | gunzip >~/.local/share/chisel/chisel-$CHISEL_VERSION-windows-x86-64.exe
ln -sf "~/.local/share/chisel/chisel-$CHISEL_VERSION-linux" ~/.local/bin/chisel

# install etcher
curl -SL "https://github.com/balena-io/etcher/releases/download/v$ETCHER_VERSION/balenaEtcher-$ETCHER_VERSION-x64.AppImage" >~/.local/bin/etcher
chmod +x ~/.local/bin/etcher

# install john the ripper
git clone https://github.com/openwall/john /tmp/john && cd /tmp/john/src
./configure && make -sj4
mv ../run ~/.local/share/john
ln -sf ~/.local/share/john ~/.local/bin/john

# install trufflehog
curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b ~/.local/bin

# install metasploit-framework
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall &&
    chmod 755 msfinstall &&
    ./msfinstall
ln -sf /opt/metasploit-framework/bin/* ~/.local/bin

# install responder
git clone https://github.com/lgandx/Responder ~/.local/share/responder && cd ~/.local/share/responder
uv venv
./.venv/bin/pip install -r requirements.txt
cat <<EOF >"~/.local/bin/responder"
#!/bin/bash
~/.local/share/responder/.venv/bin/python ~/.local/share/responder/Responder.py "$@"
EOF
chmod +x ~/.local/bin/responder

# install lazygit
curl -SL "https://github.com/jesseduffield/lazygit/releases/download/v$LAZYGIT_VERSION/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -o /tmp/lazygit.tar.gz
tar -xzvf /tmp/lazygit.tar.gz lazygit
mv /tmp/lazygit ~/.local/bin/

# install enum4linux
git clone https://github.com/CiscoCXSecurity/enum4linux ~/.local/share/enum4linux
ln -sf ~/.local/share/enum4linux/enum4linux.pl ~/.local/bin/enum4linux

# install helpful repos
git clone https://github.com/danielmiessler/SecLists ~/.local/share/seclists
git clone https://github.com/samratashok/nishang ~/.local/share/nishang
git clone https://github.com/Unic0rn28/hashcat-rules/tree/main ~/.local/share/hashcat-rules

# Installing exploitdb
git clone https://gitlab.com/exploit-database/exploitdb.git ~/.local/share/exploitdb
ln -sf ~/.local/share/exploitdb/searchsploit ~/.local/bin/searchsploit
cp -n ~/.local/share/exploitdb/.searchsploit_rc ~/.searchsploit_rc
sed -i 's/\/opt\//\~\/.local\/share\//g' ~/.searchsploit_rc

# Install Bloodhound Community Edition and Legacy Edition
git clone https://github.com/SpecterOps/bloodhound-cli /tmp/bloodhound-cli && cd /tmp/bloodhound-cli
go build -ldflags="-s -w -X 'github.com/SpecterOps/BloodHound_CLI/cmd/config.Version=$(git describe --tags --abbrev=0)' -X 'github.com/SpecterOps/BloodHound_CLI/cmd/config.BuildDate=$(date -u '+%d %b %Y')'" -o bloodhound-cli main.go
mkdir ~/.local/share/bloodhound
mv bloodhound-cli ~/.local/share/bloodhound/bloodhound-cli
cat <<EOF >"~/.local/bin/bloodhound"
#!/bin/bash
cd ~/.local/share/bloodhound && ./bloodhound-cli "$@" && cd -
EOF
bloodhound install
bloodhound containers down

curl -SL https://github.com/SpecterOps/BloodHound-Legacy/releases/download/v4.3.1/BloodHound-linux-x64.zip -o /tmp/bloodhound.zip &&
    unzip /tmp/bloodhound.zip -d ~/.local/share/bloodhound &&
    mv ~/.local/share/bloodhound/BloodHound-linux-x64 ~/.local/share/bloodhound/legacy

cat <<EOF >"~/.local/bin/bloodhound-legacy"
#!/bin/bash
~/.local/share/bloodhound/legacy/BloodHound --no-sandbox "$@"
EOF

# Targeted Kerberoast
git clone https://github.com/ShutdownRepo/targetedKerberoast ~/.local/share/targetedKerberoast && cd ~/.local/share/targetedKerberoast
uv venv
./.venv/bin/pip install -r requirements.txt
cat <<EOF >"~/.local/bin/targetedKerberoast"
#!/bin/bash
~/.local/share/targetedKerberoast/.venv/bin/python ~/.local/share/targetedKerberoast/targetedKerberoast.py "$@"
EOF
chmod +x ~/.local/bin/targetedKerberoast

# Petitpotam
git clone https://github.com/topotam/PetitPotam ~/.local/share/PetitPotam/ && cd ~/.local/share/PetitPotam
uv venv
./.venv/bin/pip install impacket
cat <<EOF >"~/.local/bin/petitpotam"
#!/bin/bash
~/.local/share/PetitPotam/.venv/bin/python ~/.local/share/PetitPotam/PetitPotam.py "$@"
EOF
chmod +x ~/.local/bin/petitpotam

# gMSADumper
git clone https://github.com/micahvandeusen/gMSADumper ~/.local/share/gMSADumper && cd ~/.local/share/gMSADumper
uv venv
./.venv/bin/pip install -r requirements.txt
./.venv/bin/pip install gssapi
cat <<EOF >"~/.local/bin/gMSADumper"
#!/bin/bash
~/.local/share/gMSADumper/.venv/bin/python ~/.local/share/gMSADumper/gMSADumper.py "$@"
EOF
chmod +x ~/.local/bin/petitpotam

# Create custom scripts
cat <<EOF >~/.local/bin/shuttle
#!/bin/bash
# run sshuttle based on infra metadata

if [ -z $1 ]; then
    INFRA_PATH="."
else
    INFRA_PATH="$1"
fi

id_ed25519=$(find -iname "*-id_ed25519" | cut -b3-)
jumpbox_ip=$(cat terraform.tfstate | jq ".resources[] | select(.name | split(\"-\") | index(\"jumpbox\") == 1 ) | .instances[].attributes.ipv4_address" -r)

echo sshuttle -r "root@$jumpbox_ip" 0.0.0.0/0 -e "ssh -i $INFRA_PATH/$id_ed25519"

EOF

cat <<EOF >~/.local/bin/sync_krb
#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

SWITCH="$1"

if [[ "$SWITCH" == "on" ]]; then
    timedatectl set-ntp off
    rdate -n "$2"
elif [[ "$SWITCH" == "off" ]]; then
    timedatectl set-ntp on
else
    echo "USAGE:"
    echo "$0 [on|off] [IP]"
fi
EOF

cat <<EOF >~/.local/bin/neo4j
#!/bin/bash

DATA_FLDR="$1"
if [ -z "$1" ]; then
        echo "No data folder specified."
        echo "Data will live at /tmp/data"
        DATA_FLDR="/tmp/data"
fi

VERSION="4.4"

docker run \
        --publish=7474:7474 --publish=7687:7687 \
        --env NEO4J_AUTH=none \
        --volume="$DATA_FLDR":/data \
        neo4j:"$VERSION"
EOF

echo "Setup is Complete!"
echo "Reboot to Finish Setup"
