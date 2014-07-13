#!/usr/bin/env bash

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# RVM setup
export PATH="$PATH:$HOME/.rvm/bin"
source $HOME/.rvm/scripts/rvm
source ~/.autoenv/activate.sh

# zsh
source $HOME/.dotfiles/zsh/aliases.zsh
. $HOME/.dotfiles/zsh/functions.zsh

# python
. $HOME/.dotfiles/python/functions.sh

# load up private stuff
if [ -d "$HOME/.dotfiles/private" ]; then
  . $HOME/.dotfiles/private/private.sh
fi

# have zsh run bash PROMPT_COMMAND
precmd() { eval "$PROMPT_COMMAND" }
