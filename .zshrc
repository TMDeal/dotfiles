# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    tmux
    fzf

    # Docker
    docker
    docker-compose

    # Python
    pyenv
    python
    pip

    # Ruby
    rbenv

    # Node.js
    nvm

    # Rust
    rust

    # Golang
    golang

    # Utility
    extract
    common-aliases
    zsh-interactive-cd
)

export ZSH_TMUX_AUTOSTART="false"
export ZSH_TMUX_FIXTERM_WITH_256COLOR="tmux-256color"
export ZSH_TMUX_DEFAULT_SESSION_NAME="main"
export ZSH_TMUX_UNICODE="true"

export DISABLE_FZF_AUTO_COMPLETION="false"
export DISABLE_FZF_KEY_BINDINGS="false"

export NVM_LAZY=1

export VIRTUAL_ENV_DISABLE_PROMPT="false"
export ZSH_PYENV_QUIET="true"

source $ZSH/oh-my-zsh.sh

# User configuration

if $( command -v nvim > /dev/null ); then
   alias vim="nvim"
fi

if $( command -v htop > /dev/null ); then
    alias top="htop"
fi

alias reload="omz reload"

alias t="tmux"
alias tad="tmux detach -t"

alias c="clear"
alias cls="clear"
alias q="exit"
alias :q="exit"
alias qq="clear; tad"
alias :qq="clear; tad"
alias mkdir="mkdir -p"
alias open="xdg-open"
alias rm="rm -I"

alias ctrlc='xclip -selection c'
alias ctrlv='xclip -selection c -o'

alias vimn="vim -u NONE"
alias ev="vim ~/.config/nvim/init.lua"

alias ygit="yadm"
alias ylgit="lazygit --git-dir ~/.local/share/yadm/repo.git --work-tree=$HOME"
alias lgit="lazygit"

alias dmenu="rofi -dmenu"
alias bat="batcat"

# Make neovim or vim the default editor
if $( command -v nvim > /dev/null ); then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.gem/bin" ]; then
    export PATH="$HOME/.gem/bin:$PATH"
fi

if [ -d "/usr/local/go" ]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "/pentest/bin" ]; then
    export PATH="/pentest/bin:$PATH"
fi

if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
fi