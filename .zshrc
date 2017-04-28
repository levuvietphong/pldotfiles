# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"
export PATH=/Users/phong/miniconda2/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

export PATH=/usr/local/Cellar/netcdf:$PATH

source ~/.zprezto/init.zsh

export EDITOR='vim'

alias c="clear"
alias l="ls"
alias rm="rm -f"
. ~/z.sh


# Base16 Shell
#BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#source ~/bin/base16-tomorrow.sh

# function kill_emacs_daemon(){
#     PID=$(ps aux | grep "[E]macs-x86_64-10_9 --daemon" | awk '{print $2}')
#     kill -9 $PID
# }

alias e='emacsclient -t'
alias emacsd='emacs --daemon'
alias ked='killall Emacs'

# autossh
autossh -M 0 -f -T -N roger
