CASE_SENSITIVE="true"
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

export EDITOR='vim'

# Make Ctrl+S do nothing
stty -ixon
bindkey -r "^S"

source $HOME/.zsh_aliases

# Prompt
alias _check_git_repo="git rev-parse --git-dir > /dev/null 2>&1"
export IN_GIT_REPO=
_set_in_git_repo_hook() {
    _check_git_repo
    export IN_GIT_REPO=$?
};
typeset -a -g chpwd_functions
chpwd_functions=(_set_in_git_repo_hook $chpwd_functions);

if [[ -d "$HOME/gitstatus" ]]; then
    source ~/gitstatus/gitstatus.plugin.zsh
    gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

    function git_status() {
        if [[ -z $IN_GIT_REPO ]]; then
            _set_in_git_repo_hook
        fi

        if [[ IN_GIT_REPO -ne 0 ]]; then
            return
        fi

        if ! gitstatus_query MY || [[ $VCS_STATUS_RESULT != ok-sync ]]; then
            return
        fi

        local out=""
        if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
            out+=" %F{black}$VCS_STATUS_LOCAL_BRANCH%f"
        else
            out+=" %F{black}${VCS_STATUS_COMMIT:0:7}%f"
        fi
        (( VCS_STATUS_COMMITS_BEHIND )) && out+=" %F{green}⇣${VCS_STATUS_COMMITS_BEHIND}%f"
        (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && out+=" "
        (( VCS_STATUS_COMMITS_AHEAD  )) && out+="%F{green}⇡${VCS_STATUS_COMMITS_AHEAD}%f"

        (( VCS_STATUS_NUM_STAGED    )) && out+=" %F{green}+${VCS_STATUS_NUM_STAGED}%f"
        (( VCS_STATUS_NUM_UNSTAGED  )) && out+=" %F{yellow}!${VCS_STATUS_NUM_UNSTAGED}%f"
        (( VCS_STATUS_NUM_UNTRACKED )) && out+=" %F{blue}?${VCS_STATUS_NUM_UNTRACKED}%f"
        (( VCS_STATUS_NUM_CONFLICED )) && out+=" %F{red}!${VCS_STATUS_NUM_CONFLICED}%f"

        echo "$out"
    }
else
    function git_status() {}
fi

setopt PROMPT_SUBST
local _exit_code_status='%(?.%F{green}✔%f.%F{red}✘%f)'
local _path_formatted='%F{blue}%B%~%b%f'
export PROMPT='$_path_formatted% $(git_status)%f $_exit_code_status %F{magenta}❯%f '

# export LS_COLORS=${LS_COLORS/ow=34;42/ow=1;34}
# export LS_COLORS=${LS_COLORS/tw=30;42/tw=1;34}
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Leaves output of `less` on screen after exiting
export LESS="-Xr"

# pip may install packages to this directory
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$PATH:$HOME/.local/bin"
# fi

# Add go install path to $PATH
if command -v go &> /dev/null; then
    # Quick:
    PATH="$PATH:$HOME/go/bin"
    # Safe: (Use this running binaries installed via go doesn't work. In that
    # case you might want to update the hard-coded value above)
    # PATH="$PATH:$(go env GOPATH)/bin"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

function _pyenv() {
    # Unset alias to this function in order to avoid infinite recursion
    unalias pyenv
    if command -v pyenv &>/dev/null; then
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init - | sed s/precmd/precwd/g)"
    else
        echo "Pyenv is not installed"
    fi
    pyenv "$@"
}
alias pyenv="_pyenv"

export PATH="$HOME/.cargo/bin:/opt:$PATH"

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
