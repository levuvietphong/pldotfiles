# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"
#export PATH=/Users/phong/miniconda/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source ~/.zprezto/init.zsh

export EDITOR='vim'

alias c="clear"
alias l="ls"
alias rm="rm -f"
. ~/z.sh


# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

source ~/bin/base16-tomorrow.sh

function kill_emacs_daemon(){
    PID=$(ps aux | grep "[E]macs-x86_64-10_9 --daemon" | awk '{print $2}')
    kill -9 $PID
}

export EMACSCLIENT="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
alias e='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -t'
#alias em="/Applications/Emacs.app/Contents/MacOS/Emacs -nw --no-site-file --no-splash"
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw --no-site-file --no-splash"
alias ed='/Applications/Emacs.app/Contents/MacOS/Emacs --daemon'
alias ked=kill_emacs_daemon

# start emacsd
if pgrep Emacs > /dev/null 2>&1
then
    echo "emacs is running" > /dev/null 2>&1
else
    $(/Applications/Emacs.app/Contents/MacOS/Emacs --daemon 2>/dev/null)
fi

# autossh
autossh -M 0 -f -T -N roger
