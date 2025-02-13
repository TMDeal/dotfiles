export ENABLE_LOGGING=

if [ ! -z $ENABLE_LOGGING ]; then
    export HISTSIZE=20000
    export HISTFILESIZE=$HISTSIZE
    export PROMPT_COMMAND="history -a"
    export HISTTIMEFORMAT="%F %T "
    setopt INC_APPEND_HISTORY 2>/dev/null

    logdir="$HOME/Logs"
    mkdir -p $logdir 2>/dev/null

    if [[ ! -z "$TMUX" && -z "$TMUX_LOGGING" ]]; then
        logfile="$logdir/tmux_$(date -u +%F_%H_%M_%S)_UTC.$$.log"
        "$HOME/.tmux/plugins/tmux-logging/scripts/start_logging.sh" "$logfile"
        export TMUX_LOGGING="$logfile"
    fi

    if [[ -z "$NORMAL_LOGGING" && ! -z "$PS1" && -z "$TMUX" ]]; then
        logfile="$logdir/$(date -u +%F_%H_%M_%S)_UTC.$$.log"
        export NORMAL_LOGGING="$logfile"
        script -f -q "$logfile"
        exit
    fi
fi

