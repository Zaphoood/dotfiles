CASE_SENSITIVE="true"
export EDITOR='vim'
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Make Ctrl+S do nothing
stty -ixon
bindkey -r "^S"

source $HOME/.zsh_aliases

# Prompt
alias _check_git_repo="git rev-parse --git-dir > /dev/null 2>&1"
_set_in_git_repo_hook() {
    _check_git_repo
    export IN_GIT_REPO=$?
};

typeset -a -g chpwd_functions
chpwd_functions=(_set_in_git_repo_hook $chpwd_functions);
export IN_GIT_REPO=

function git_branch() {
    if [[ -z $IN_GIT_REPO ]]; then
        _set_in_git_repo_hook
    fi

    if [[ IN_GIT_REPO -ne 0 ]]; then
        return
    fi

    branch=$(git symbolic-ref --short -q HEAD)
    commit_hash=$(git rev-parse --short HEAD)
    echo "(${branch:-$commit_hash}) "
}
setopt PROMPT_SUBST
export PROMPT='%F{blue}%~%F %F{magenta}$(git_branch)❯%f '

# export LS_COLORS=${LS_COLORS/ow=34;42/ow=1;34}
# export LS_COLORS=${LS_COLORS/tw=30;42/tw=1;34}
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Leaves output of `less` on screen after exiting
export LESS="-Xr"


# pip may install packages to this directory
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$PATH:$HOME/.local/bin"
# fi

# `go install` puts binaries here
if command -v go &> /dev/null ; then
    PATH="$PATH:$(go env GOPATH)/bin"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
# Load nvm lazily
function _nvm() {
    unalias nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
alias nvm="_nvm"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_CMD_INIT=1

function _pyenv() {
    # Unset alias to this function in order to avoid infinite recursion
    unalias pyenv
    if command -v pyenv &>/dev/null; then
        export PYENV_CMD_INIT=0
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init - | sed s/precmd/precwd/g)"
    else
        echo "Pyenv is not installed"
    fi
    pyenv "$@"
}
alias pyenv="_pyenv"

export PATH="/opt:$PATH"

alias dc=sl

# pnpm
export PNPM_HOME="/home/mathis/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# pfetch with kitties (https://github.com/andreasgrafen/pfetch-with-kitties)
export PF_ASCII="Catppuccin"
export PF_ALIGN="20"
