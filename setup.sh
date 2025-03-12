#!/bin/bash

if ! [ "$(id -u)" = 0 ]; then
    echo "The script need to be run as root." >&2
    exit 1
fi

if [ "$SUDO_USER" ]; then
    REAL_USER=$SUDO_USER
else
    REAL_USER=$(whoami)
fi

REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

# Application Versions
GREENCLIP_VERSION="4.2"
NVIM_VERSION="stable"
NVM_VERSION="0.39.2"
NERD_FONT_VERSION="3.0.2"
ALACRITTY_VERSION="0.15.0"
POLYBAR_VERSION="3.7.2"
BLOODHOUND_CLI_VERSION="0.1.3"
DOCKER_COMPOSE_VERSION="2.32.4"
GO_VERSION="1.23.5"
CHISEL_VERSION="1.10.1"
ETCHER_VERSION="1.19.25"
LAZYGIT_VERSION="0.45.2"
NERD_FONT="Inconsolata"

# Folders
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
TMP_DIR="/tmp/setup-cache"
OPT_DIR="/opt"
PREFIX="/usr/local"
APPLICATIONS_DIR="$PREFIX/share/applications"
ICONS_DIR="$PREFIX/share/icons"
FONTS_DIR="$PREFIX/share/fonts"
THEMES_DIR="$PREFIX/share/themes"
NERD_FONT_DIR="$FONTS_DIR/$NERD_FONT"

# Create needed folders
[ ! -d "$TMP_DIR" ] && mkdir -p "$TMP_DIR"
[ ! -d "$OPT_DIR" ] && mkdir -p "$OPT_DIR"
[ ! -d "$PREFIX" ] && mkdir -p "$PREFIX"
[ ! -d "$APPLICATIONS_DIR" ] && mkdir -p "$APPLICATIONS_DIR"
[ ! -d "$ICONS_DIR" ] && mkdir -p "$ICONS_DIR"
[ ! -d "$FONTS_DIR" ] && mkdir -p "$FONTS_DIR"
[ ! -d "$THEMES_DIR" ] && mkdir -p "$THEMES_DIR"

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor >"/usr/share/keyrings/signal-desktop-keyring.gpg"
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |
    tee /etc/apt/sources.list.d/signal-xenial.list >/dev/null

wget https://download.docker.com/linux/debian/gpg -O /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

apt-get update
# 1. General Packages
# 2. General Libs and Essentials
# 3. Docker Engine
# 4. Alacritty Dependencies
# 5. I3 Dependencies
# 6. john Dependencies
# 7. rbenv Dependencies
DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get --yes --quiet --option Dpkg::Options::="--force-confold" --option Dpkg::Options::="--force-confdef" install \
    snapd playerctl forensics-all nmap sshuttle ffuf vim xinput zsh cherrytree lm-sensors keepassxc fzf rofi xclip jq xq htop remmina flameshot chromium tmux fd-find luarocks autorandr picom libreoffice bat ripgrep stow signal-desktop \
    ruby nodejs npm libsecret-1-dev python3-venv libgssapi-krb5-2 build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc python3-dev \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev \
    i3 nitrogen lxpolkit lxappearance udiskie picom brightnessctl alsa-utils dunst \
    libnss3-dev libkrb5-dev libgmp-dev libbz2-dev zlib1g-dev \
    autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

snap install core
snap refresh core

if [ -d /usr/share/doc/git/contrib/credential/libsecret/ ]; then
    cd /usr/share/doc/git/contrib/credential/libsecret/ && make
fi

cd "$SCRIPT_DIR"
sudo -su "$REAL_USER" stow -v2 . || exit

# Install prefered font
mkdir "$NERD_FONT_DIR"
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v$NERD_FONT_VERSION/$NERD_FONT.zip" -O "$TMP_DIR/$NERD_FONT.zip"
unzip -o "$TMP_DIR/$NERD_FONT.zip" -d "$NERD_FONT_DIR"
fc-cache

# Install prefered Icons
git clone https://github.com/zayronxio/Zafiro-icons "$TMP_DIR/zafiro-icons" && cd "$TMP_DIR/zafiro-icons"
cp -r -a Dark "$PREFIX/share/icons/Zafiro-Icons-Dark"

# Install prefered GTK theme
git clone https://github.com/EliverLara/Nordic "$THEMES_DIR/Nordic"

# Install prefered cursor theme
git clone https://github.com/guillaumeboehm/Nordzy-cursors "$TMP_DIR/nordzy-cursors" && cd "$TMP_DIR/nordzy-cursors"
cp -r xcursors/Nordzy-cursors "$ICONS_DIR"

# Docker setup
groupadd docker 2>/dev/null
usermod -aG docker "$REAL_USER"
mkdir -p "$DOCKER_PLUGINS_DIR" &&
    curl -SL "https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-linux-x86_64" -o "$DOCKER_PLUGINS_DIR/docker-compose" &&
    chmod +x "$DOCKER_PLUGINS_DIR/docker-compose"

# install oh-my-zsh
curl -fsSL -o "$TMP_DIR/oh-my-zsh-install.sh" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && chmod +x "$TMP_DIR/oh-my-zsh-install.sh"
sudo -iu "$REAL_USER" bash -c "$TMP_DIR/oh-my-zsh-install.sh --unattended --keep-zshrc"
chsh -s "$(which zsh)" "$REAL_USER"

# install direnv for REAL_USER
sudo -iu "$REAL_USER" bash -c "curl -sfL https://direnv.net/install.sh | bash"

# Install golang
curl -SL "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz" -o "$TMP_DIR/go.tar.gz" && tar -xvzf "$TMP_DIR/go.tar.gz" -C "$PREFIX"
export PATH="$PREFIX/go/bin:$PATH"

# install uv python package and version manager
curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="$PREFIX/bin" sh

# install rbenv for REAL_USER
wget -q https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer -O "$TMP_DIR/rbenv_install.sh" && chmod +x "$TMP_DIR/rbenv_install.sh"
wget -q https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-doctor -O "$TMP_DIR/rbenv_doctor.sh" && chmod +x "$TMP_DIR/rbenv_doctor.sh"
rbenv_install_cmd="$TMP_DIR/rbenv_install.sh && $TMP_DIR/rbenv_doctor.sh"
sudo -iu "$REAL_USER" bash -c "$rbenv_install_cmd"

# install poetry for REAL_USER
curl -sSL -o "$TMP_DIR/poetry-install.py" https://install.python-poetry.org
sudo -iu "$REAL_USER" python3 "$TMP_DIR/poetry-install.py"

# install nvm for REAL_USER
wget "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" -O "$TMP_DIR/nvm-install.sh" && chmod +x "$TMP_DIR/nvm-install.sh"
nvm_install_cmd="$TMP_DIR/nvm-install.sh && source \$HOME/.nvm/nvm.sh && nvm install --lts"
sudo -iu "$REAL_USER" bash -c "$nvm_install_cmd"

# install rustup for REAL_USER
curl --proto '=https' --tlsv1.2 -sSf -o "$TMP_DIR/rustup-install.sh" https://sh.rustup.rs && chmod +x "$TMP_DIR/rustup-install.sh"
rustup_install_cmd="$TMP_DIR/rustup-install.sh -y --no-modify-path && source \$HOME/.cargo/env && rustup override set stable && rustup update stable"
sudo -iu "$REAL_USER" bash -c "$rustup_install_cmd"
bash -c "$rustup_install_cmd"
source "$HOME/.cargo/env"

# install Alacritty
# Build it as REAL_USER since they have rustup
sudo -iu "$REAL_USER" bash -c "git clone https://github.com/alacritty/alacritty.git $TMP_DIR/alacritty && cd $TMP_DIR/alacritty && git checkout v$ALACRITTY_VERSION && cargo build --release"
tic -xe alacritty,alacritty-direct extra/alacritty.info

cp target/release/alacritty "$PREFIX/bin"
cp extra/logo/alacritty-term.svg "$PREFIX/share/pixmaps/Alacritty.svg"
desktop-file-install extra/linux/Alacritty.desktop
update-desktop-database

mkdir -p "$PREFIX/share/man/man1"
mkdir -p "$PREFIX/share/man/man5"
scdoc <extra/man/alacritty.1.scd | gzip -c | tee "$PREFIX/share/man/man1/alacritty.1.gz" >/dev/null
scdoc <extra/man/alacritty-msg.1.scd | gzip -c | tee "$PREFIX/share/man/man1/alacritty-msg.1.gz" >/dev/null
scdoc <extra/man/alacritty.5.scd | gzip -c | tee "$PREFIX/share/man/man5/alacritty.5.gz" >/dev/null
scdoc <extra/man/alacritty-bindings.5.scd | gzip -c | tee "$PREFIX/share/man/man5/alacritty-bindings.5.gz" >/dev/null

# install tmux tpm for REAL_USER
sudo -iu "$REAL_USER" bash -c "git clone https://github.com/tmux-plugins/tpm $REAL_HOME/.tmux/plugins/tpm && $REAL_HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

# install python tools with uv for REAL_USER
sudo -iu "$REAL_USER" uv tool install jrnl
sudo -iu "$REAL_USER" uv tool install bbot
sudo -iu "$REAL_USER" uv tool install sqlmap
sudo -iu "$REAL_USER" uv tool install git+https://github.com/Pennyw0rth/NetExec
sudo -iu "$REAL_USER" uv tool install impacket
sudo -iu "$REAL_USER" uv tool install semgrep
sudo -iu "$REAL_USER" uv tool install bloodhound
sudo -iu "$REAL_USER" uv tool install bloodyad

# install starship prompt
wget https://starship.rs/install.sh -O "$TMP_DIR/starship-install.sh" && chmod +x "$TMP_DIR/starship-install.sh"
"$TMP_DIR/starship-install.sh" --bin-dir "$PREFIX/bin" -y

# install polybar
git clone --recursive https://github.com/polybar/polybar "$OPT_DIR/polybar" && cd "$OPT_DIR/polybar"
git checkout "$POLYBAR_VERSION"
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH="$PREFIX" ..
make -j$(nproc)
make install

# install neovim
wget "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.appimage" -O "$TMP_DIR/nvim"
chmod +x $TMP_DIR/nvim
mv $TMP_DIR/nvim "$PREFIX/bin/nvim"

# install greenclip
wget "https://github.com/erebe/greenclip/releases/download/v$GREENCLIP_VERSION/greenclip" -O $TMP_DIR/greenclip
chmod +x $TMP_DIR/greenclip
mv $TMP_DIR/greenclip "$PREFIX/bin/greenclip"

# install act for testing ci actions
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nektos/act/master/install.sh -o $TMP_DIR/act-install.sh && chmod +x $TMP_DIR/act-install.sh
$TMP_DIR/act-install.sh -b "$PREFIX/bin"

# install chisel for tunneling
mkdir "$OPT_DIR/chisel"

curl -SL "https://github.com/jpillora/chisel/releases/download/v$CHISEL_VERSION/chisel_${CHISEL_VERSION}_linux_amd64.gz" | gunzip >"$OPT_DIR/chisel/chisel-$CHISEL_VERSION-linux" && chmod +x "$OPT_DIR/chisel/chisel-$CHISEL_VERSION-linux"
curl -SL "https://github.com/jpillora/chisel/releases/download/v$CHISEL_VERSION/chisel_${CHISEL_VERSION}_windows_amd64.gz" | gunzip >"$OPT_DIR/chisel/chisel-$CHISEL_VERSION-windows-x64.exe"
curl -SL "https://github.com/jpillora/chisel/releases/download/v$CHISEL_VERSION/chisel_${CHISEL_VERSION}_windows_386.gz" | gunzip >"$OPT_DIR/chisel/chisel-$CHISEL_VERSION-windows-x86-64.exe"

ln -sf "$OPT_DIR/chisel/chisel-$CHISEL_VERSION-linux" "$PREFIX/bin/chisel"

# install etcher
curl -SL "https://github.com/balena-io/etcher/releases/download/v$ETCHER_VERSION/balenaEtcher-$ETCHER_VERSION-x64.AppImage" >$PREFIX/bin/etcher
chmod +x "$PREFIX/bin/etcher"

# install john the ripper
git clone https://github.com/openwall/john "$OPT_DIR/john-src" && cd "$OPT_DIR/john-src/src"
./configure && make -sj$(nproc)
ln -sf "$OPT_DIR/john-src/run" "$OPT_DIR/john"
cat <<EOF >"$PREFIX/bin/john"
#!/bin/bash
cd $OPT_DIR/john && ./john "\$@" && cd - >/dev/null
EOF
chmod +x "$PREFIX/bin/john"

# install trufflehog
curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b "$PREFIX/bin"

# install metasploit-framework
cd $TMP_DIR
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall &&
    chmod 755 msfinstall &&
    ./msfinstall
ln -sf /opt/metasploit-framework/bin/* "$PREFIX/bin"

# install responder
git clone https://github.com/lgandx/Responder "$OPT_DIR/Responder" && cd "$OPT_DIR/Responder"
uv venv
uv pip install -r requirements.txt
cat <<EOF >"$PREFIX/bin/responder"
#!/bin/bash
$OPT_DIR/Responder/.venv/bin/python $OPT_DIR/Responder/Responder.py "\$@"
EOF
chmod +x "$PREFIX/bin/responder"

# install lazygit
cd $TMP_DIR
curl -SL "https://github.com/jesseduffield/lazygit/releases/download/v$LAZYGIT_VERSION/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -o $TMP_DIR/lazygit.tar.gz
tar -xzvf $TMP_DIR/lazygit.tar.gz lazygit
mv $TMP_DIR/lazygit "$PREFIX/bin/"

# install enum4linux
git clone https://github.com/CiscoCXSecurity/enum4linux "$OPT_DIR/enum4linux"
ln -sf "$OPT_DIR/enum4linux/enum4linux.pl" "$PREFIX/bin/enum4linux"

# install helpful repos
git clone https://github.com/danielmiessler/SecLists "$OPT_DIR/seclists"
git clone https://github.com/samratashok/nishang "$OPT_DIR/nishang"
git clone https://github.com/Unic0rn28/hashcat-rules "$OPT_DIR/hashcat-rules"

# Installing exploitdb
git clone https://gitlab.com/exploit-database/exploitdb.git "$OPT_DIR/exploitdb"
ln -sf "$OPT_DIR/exploitdb/searchsploit" "$PREFIX/bin/searchsploit"

cp -n "$OPT_DIR/exploitdb/.searchsploit_rc" ~/.searchsploit_rc
sudo -iu "$REAL_USER" cp -n "$OPT_DIR/exploitdb/.searchsploit_rc" "\$HOME/.searchsploit_rc"

# Install Bloodhound Community Edition and Legacy Edition
git clone https://github.com/SpecterOps/bloodhound-cli "$OPT_DIR/bloodhound-cli" && cd "$OPT_DIR/bloodhound-cli"
git checkout "v$BLOODHOUND_CLI_VERSION"
go build -ldflags="-s -w -X 'github.com/SpecterOps/BloodHound_CLI/cmd/config.Version=$(git describe --tags --abbrev=0)' -X 'github.com/SpecterOps/BloodHound_CLI/cmd/config.BuildDate=$(date -u '+%d %b %Y')'" -o bloodhound-cli main.go
cat <<EOF >"$PREFIX/bin/bloodhound"
#!/bin/bash
if ! [ \$(id -u) = 0 ]; then
    echo "The script need to be run as root." >&2
    exit 1
fi
cd $OPT_DIR/bloodhound-cli && ./bloodhound-cli "\$@" && cd - > /dev/null
EOF
chmod +x "$PREFIX/bin/bloodhound"

curl -SL https://github.com/SpecterOps/BloodHound-Legacy/releases/download/v4.3.1/BloodHound-linux-x64.zip -o "$TMP_DIR/bloodhound-legacy.zip" &&
    unzip "$TMP_DIR/bloodhound-legacy.zip" -d "$TMP_DIR" &&
    mv "$TMP_DIR/BloodHound-linux-x64" "$OPT_DIR/bloodhound-legacy"

cat <<EOF >"$PREFIX/bin/bloodhound-legacy"
#!/bin/bash
$OPT_DIR/bloodhound-legacy/BloodHound --no-sandbox "\$@"
EOF
chmod +x "$PREFIX/bin/bloodhound-legacy"

# Targeted Kerberoast
git clone https://github.com/ShutdownRepo/targetedKerberoast "$OPT_DIR/targetedKerberoast" && cd "$OPT_DIR/targetedKerberoast"
uv venv
uv pip install -r requirements.txt
cat <<EOF >"$PREFIX/bin/targetedKerberoast"
#!/bin/bash
$OPT_DIR/targetedKerberoast/.venv/bin/python $OPT_DIR/targetedKerberoast/targetedKerberoast.py "\$@"
EOF
chmod +x "$PREFIX/bin/targetedKerberoast"

# Petitpotam
git clone https://github.com/topotam/PetitPotam "$OPT_DIR/PetitPotam" && cd "$OPT_DIR/PetitPotam"
uv venv
uv pip install impacket
cat <<EOF >"$PREFIX/bin/petitpotam"
#!/bin/bash
$OPT_DIR/PetitPotam/.venv/bin/python $OPT_DIR/PetitPotam/PetitPotam.py "\$@"
EOF
chmod +x "$PREFIX/bin/petitpotam"

# gMSADumper
git clone https://github.com/micahvandeusen/gMSADumper "$OPT_DIR/gMSADumper" && cd "$OPT_DIR/gMSADumper"
uv venv
uv pip install -r requirements.txt
uv pip install gssapi
cat <<EOF >"$PREFIX/bin/gMSADumper"
#!/bin/bash
$OPT_DIR/gMSADumper/.venv/bin/python $OPT_DIR/gMSADumper/gMSADumper.py "\$@"
EOF
chmod +x "$PREFIX/bin/gMSADumper"

# Create custom scripts
cat <<'EOF' >"$PREFIX/bin/shuttle"
#!/bin/bash
# run sshuttle based on infra metadata

if [ -z $1 ]; then
    INFRA_PATH="."
else
    INFRA_PATH="$1"
fi

id_ed25519=$(find -iname "*-id_ed25519" | cut -b3-)
jumpbox_ip=$(cat terraform.tfstate | jq ".resources[] | select(.name | split(\"-\") | index(\"jumpbox\") == 1 ) | .instances[].attributes.ipv4_address" -r)

sshuttle -r "root@$jumpbox_ip" 0.0.0.0/0 -e "ssh -i $INFRA_PATH/$id_ed25519"

EOF
chmod +x "$PREFIX/bin/shuttle"

cat <<'EOF' >"$PREFIX/bin/sync_krb"
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
chmod +x "$PREFIX/bin/sync_krb"

cat <<'EOF' >"$PREFIX/bin/neo4j-docker"
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
chmod +x "$PREFIX/bin/neo4j-docker"

# Create a simple bashrc for root user with correct ENV
cat <<'EOF' >"/root/.bashrc"
export LS_OPTIONS="--color=auto"
eval "$(dircolors)"
alias ls="ls $LS_OPTIONS"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias q="exit"
alias :q="exit"
alias c="clear"

# ENVIRONMENT
export GOROOT="/usr/local/go"
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
EOF

cd "$SCRIPT_DIR"
echo "Setup is Complete!"
echo "Reboot to Finalize Setup!"
