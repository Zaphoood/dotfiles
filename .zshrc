# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
plugins=()

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='vim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load aliases
source $HOME/.zsh_aliases

# Disable ugly highlight colors for `ls`
export LS_COLORS=${LS_COLORS/ow=34;42/ow=1;34}           х INT
export LS_COLORS=${LS_COLORS/tw=30;42/tw=1;34}           х INT
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Set library path for linker
export LD_LIBRARY_PATH=/usr/local/lib

# Configure `less`
# Leaves output on screen after quitting
export LESS="-Xr"

# Mount USB devices in shared folder (`/media`)
export UDISKS_FILESYSTEM_SHARED=1

# Sometimes, pip installs to this directory, so it needs to be in PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi

# This is where Go executables are installed. Useful for development
if command -v go &> /dev/null ; then
    PATH="$PATH:$(go env GOPATH)/bin"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# pnpm
export PNPM_HOME="/home/mathis/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null
then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi


[ -f "/home/mathis/.ghcup/env" ] && source "/home/mathis/.ghcup/env" # ghcup-env

# Manually add ~/.ghcup/bin since the above env script doesn't seem to work
[ -d "$HOME/.ghcup/bin" ] && export PATH="$HOME/.ghcup/bin:$PATH"

export PATH="/opt:$PATH"

alias dc=sl

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
