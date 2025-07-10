# If you come from bash you might have to change your $PATH.
export PATH=/usr/sbin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

plugin() {
    repo="$1"

    if [ -z $2 ]; then
        plugin=$(echo $repo | cut -f2 -d "/")
    else
        plugin="$2"
    fi

    if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
        git clone "https://github.com/$repo" "$ZSH_CUSTOM/plugins/$plugin"
    fi
}

# # Install powerlevel10k if it is not already installed
# if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
#     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# fi

plugin "zsh-users/zsh-autosuggestions"
plugin "zsh-users/zsh-syntax-highlighting"
plugin "hlissner/zsh-autopair"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    direnv
    ssh-agent
    asdf
    git
    tmux
    fzf
    sudo
    docker
    docker-compose
    python
    pip
    rbenv
    nvm
    rust
    golang
    extract
    common-aliases
    zsh-autopair
    zsh-autosuggestions
    zsh-syntax-highlighting
    jump
    poetry
    uv
    starship
)

export ZSH_TMUX_AUTOSTART="false"
export ZSH_TMUX_FIXTERM_WITH_256COLOR="tmux-256color"
export ZSH_TMUX_DEFAULT_SESSION_NAME="main"
export ZSH_TMUX_UNICODE="true"

export DISABLE_FZF_AUTO_COMPLETION="false"
export DISABLE_FZF_KEY_BINDINGS="false"

export VIRTUAL_ENV_DISABLE_PROMPT="false"

export PYTHON_VENV_NAME=".venv"
export PYTHON_AUTO_VRUN=true

export POETRY_VIRTUALENVS_IN_PROJECT=1

zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes


if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.gem/bin" ]; then
    export PATH="$HOME/.gem/bin:$PATH"
fi

if [ -d "/usr/local/go" ]; then
    export GOROOT="/usr/local/go"
    export GOPATH="$HOME/.go"
    export PATH="$GOPATH/bin:$PATH"
    export PATH="$GOROOT/bin:$PATH"
fi

if [ -d "$HOME/.dotnet" ]; then
    export PATH="$HOME/.dotnet:$PATH"
fi

if $( command -v ruby > /dev/null ); then
    USER_GEM_PATH=$(gem environment | grep USER | awk '{print $5}')
    export PATH="$PATH:$USER_GEM_PATH/bin"
fi

source $ZSH/oh-my-zsh.sh

# User configuration


[[ ! -f "$HOME/.dir_colors" ]] && wget https://raw.githubusercontent.com/arcticicestudio/nord-dircolors/develop/src/dir_colors -O ~/.dir_colors
eval $(dircolors ~/.dir_colors)

bindkey '^ ' autosuggest-accept

# Make neovim or vim the default editor
if $( command -v nvim > /dev/null ); then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

alias glow="glow -p"
alias reload="omz reload"
alias t="tmux"
alias tad="tmux detach -t"
alias j="jump"
alias m="mark"
alias dm="unmark"
alias mls="marks"
alias c="clear"
alias cls="clear"
alias q="exit"
alias :q="exit"
alias qq="clear; tad"
alias :qq="clear; tad"
alias mkdir="mkdir -p"
alias open="xdg-open"
alias rm="rm -I"
alias lgit="lazygit"
alias ctrlc='xclip -selection c'
alias ctrlv='xclip -selection c -o'
alias vimdiff="vim -d"
alias vimn="vim -u NONE"
alias ev="vim ~/.config/nvim/init.lua"
alias prun='source "$(poetry env info --path)/bin/activate"'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias news="newsboat"
alias msfconsole="msfconsole -q"
alias sudop='sudo env "PATH=$PATH"'
alias ipv4='curl -s -4 ifconfig.co/json | jq'
alias ipv6='curl -s -6 ifconfig.co/json | jq'
alias lg="lazygit"

if $( command -v nvim > /dev/null ); then
   alias vim="nvim"
fi

if $( command -v htop > /dev/null ); then
    alias top="htop"
fi

if $( command -v rofi > /dev/null ); then
    alias dmenu="rofi -dmenu"
fi

if $( command -v batcat > /dev/null ); then
    export BAT_THEME="Nord"
    alias bat="batcat"
    alias cat="bat -pp"
fi

if $( command -v rg > /dev/null ); then
    alias grep="rg"
fi

if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
