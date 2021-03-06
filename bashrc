# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Source all files in $HOME/.bash.d if the directory exists
if [ -d "$HOME/.bash.d" ]; then
    for FILE in $(find "$HOME/.bash.d" -iname "*.sh"); do
        source $FILE
    done
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Make neovim or vim the default editor
if $( command -v nvim > /dev/null ); then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1

    reset_color='\033[0m'
    cyan_bold='\033[1;36m'
    blue_bold='\033[1;34m'
    white_bold='\033[1;37m'
    green='\033[32m'

    git_color=$cyan_bold
    venv_color=$cyan_bold
    prompt_color=$green
    info_color=$blue_bold
    symbol_color=$blue_bold
    pwd_color=$white_bold

    prompt_symbol=@

    _user_and_host_ps1="${info_color}\u${symbol_color}${prompt_symbol}${info_color}\h${prompt_color}"
    _pwd_ps1="${pwd_color}\W${prompt_color}"
    _prompt_ps1="${info_color}\$${reset_color}"

    _venv_ps1() {
        if [[ -n $VIRTUAL_ENV ]]; then
            venv="${VIRTUAL_ENV##*/}"
            printf -- "[${venv_color}$venv${prompt_color}]"
        else
            echo ''
        fi
    }

    _git_ps1() {
        if $(type -t __git_ps1 > /dev/null); then
            printf "%s" "$(__git_ps1 [${git_color}%s${prompt_color}])"
        else
            echo ''
        fi
    }

    PS1="${prompt_color}${debian_chroot:+$(debian_chroot)}${_user_and_host_ps1}[${_pwd_ps1}]\$(_venv_ps1)\$(_git_ps1)${prompt_color}${_prompt_ps1} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Add local bin directory to path for user scripts if it exists
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# spicetify settings
if [ -d "$HOME/.spicetify" ]; then
    export SPICETIFY_INSTALL="$HOME/.spicetify"
    export PATH="$SPICETIFY_INSTALL:$PATH"
fi

# pyenv settings
if [ -d "$HOME/.pyenv" ]; then
    export PATH="/home/trent/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# nvm settings
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# rbenv settings
if [ -d "$HOME/.rbenv" ]; then
    export RBENV_DIR="$HOME/.rbenv"
    export PATH="$RBENV_DIR/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ -d "$HOME/.poetry" ]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

if [ -d "$HOME/.cargo" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "/usr/local/go" ]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "$HOME/opt/bin" ]; then
    export PATH="$HOME/opt/bin:$PATH"
fi

# fzf setup
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
