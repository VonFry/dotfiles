# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Here is a customed random theme.
if [ ! -f $ZSH/custom/themes/lambda-mod.zsh-theme ]; then
    git clone https://github.com/halfo/lambda-mod-zsh-theme.git $ZSH_CUSTOM/themes
fi
ZSH_THEME_LIST=(lambda-mod robbyrussell agnoster)
ZSH_THEME=$ZSH_THEME_LIST[RANDOM%${#ZSH_THEME_LIST[@]}+1]
print "THEME \e[31m $ZSH_THEME \e[0m in \e[32m $ZSH_THEME_LIST\e[0m"

export UPDATE_ZSH_DAYS=7

plugins=(
    gitignore git git-extra github git-flow git-remote-branch
    autojump sudo screen dotenv
    man colored-man-pages profiles
    python pip
    ruby gem rails rake chruby
    cabal stack
    redis-cli
    thefuck
    docker docker-compose
)
if [[ $(uname) = "Darwin" ]]; then
    plugins=($plugins osx xcode brew brew-cask)
fi

# User configuration

source $ZSH/oh-my-zsh.sh

setopt nonomatch
setopt extendedglob

setopt rm_star_silent

source $HOME/.cmd-custom/defvar.sh

export PATH=/usr/local/bin:$PATH

source $HOME/.cmd-custom/zplug.zsh
source $CMD_CUSTOM_DIR/unalias.sh
source $CMD_CUSTOM_DIR/alias.sh
source $CMD_CUSTOM_DIR/os.sh
source $CMD_CUSTOM_DIR/function.sh

export PATH=$HOME/.local/bin:$HOME/.cabal/bin:$PATH

find $CMD_CUSTOM_DIR/misc/ -type f ! -name '.*' | xargs -n1 source

find $CMD_CUSTOM_DIR/local -type f ! -name ".*" | xargs -n1 source

source $CMD_CUSTOM_DIR/update.sh
