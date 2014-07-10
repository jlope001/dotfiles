#!/usr/bin/env bash
#
# simple bootstrap script that will load up my dotfiles. Don't need anything fancy for now.

CURRENT_DIRECTORY=`pwd`

APT_GET='sudo apt-get'
if [ `whoami` = 'root' ]; then
  APT_GET='apt-get'
fi

echo "==== bootstrap zsh"
ZSH_EXISTS="$HOME/.zshrc"
if [ ! -e "$ZSH_EXISTS" ]; then
  $APT_GET install zsh
fi

echo "==== bootstrap oh-my-zsh"
OH_ZSH_EXISTS="$HOME/.oh-my-zsh"
if [ ! -d "$OH_ZSH_EXISTS" ]; then
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
fi

# set bash default to zsh
echo "==== changing default shell to zsh"
chsh -s `which zsh`

echo "==== setup zsh config"
ZSHRC_FILE="$HOME/.zshrc"
if [ ! -h "$ZSHRC_FILE" ]; then
  cp $HOME/.zshrc $HOME/.zshrc.bak
  rm $HOME/.zshrc
fi

# copy over dotfiles into main directory
mkdir -p $HOME/.dotfiles/{python,zsh}
cp -rf $CURRENT_DIRECTORY/zsh python $HOME/.dotfiles/

