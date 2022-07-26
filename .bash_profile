# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Make neovim or vim the default editor
if $( command -v nvim > /dev/null ); then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

# pyenv settings
if [ -d "$HOME/.pyenv" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
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

if [ -d "$HOME/.gem/bin" ]; then
    export PATH="$HOME/.gem/bin:$PATH"
fi

if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "/usr/local/go" ]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "$HOME/pentest/bin" ]; then
    export PATH="$HOME/pentest/bin:$PATH"
fi
