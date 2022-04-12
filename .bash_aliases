# Set alias 'fuck' for package thefuck
eval "$(thefuck --alias)"

# nvim
alias vim="nvim"

# Quickly copy to system clipboard using xclip
alias c="xclip -r -selection clipboard"
alias v="xclip -r -selection clipboard -o"

# Terminal clock
alias clock="tty-clock -sc -f \"%a, %d %b %Y %T %z\""
alias clock-tiny="tty-clock -cD"

# Anime client for watching animes from the terminal
alias anime="ani-cli"

# git log
alias glog="git log --graph --oneline --all"

# Doxygen
alias doxy="doxygen"

# Pandoc for viewing Markdown files in terminal
function md() {
    if [ $# -eq 0 ]; then
        echo 'Usage: md <filename>'
        return
    fi
    glow -p "$1"
}

# Viewing Markdown files as they will be renderer by github
alias md-view="grip -b"

# Cool matrix effect
alias matrix="cmatrix -s"

# Alias for managing dotfiles in a git repository
# that has its working tree set to $HOME
alias dot-cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'

alias set-brightness="xrandr --output HDMI-0 --brightness"
