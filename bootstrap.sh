#!/usr/bin/env bash
#
# bootstrap script that will load up dotfiles. Nothing fancy.

CURRENT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# we only support ubuntu/centos
INSTALL_STRING="apt-get"
if [ -f /etc/redhat-release ]; then
  INSTALL_STRING="yum"
fi

if [ ! `whoami` = 'root' ]; then
  INSTALL_STRING="sudo $INSTALL_STRING"
fi
$INSTALL_STRING -y install zsh

echo "==== bootstrap zsh"
ZSH_EXISTS="$HOME/.zshrc"
if [ ! -e "$ZSH_EXISTS" ]; then
  $APT_GET install zsh
fi

echo "==== bootstrap oh-my-zsh"
OH_ZSH_EXISTS="$HOME/.oh-my-zsh"
if [ ! -d "$OH_ZSH_EXISTS" ]; then
  wget --no-check-certificate http://install.ohmyz.sh -O - | sh
fi

echo "==== changing default shell to zsh"
if [ -f /etc/redhat-release ]; then
  USERNAME=$USER
  sudo usermod -s /bin/zsh $USERNAME
else
  chsh -s `which zsh`
fi



echo "==== setup zsh config"
ZSHRC_FILE="$HOME/.zshrc"
if [ ! -h "$ZSHRC_FILE" ]; then
  cp $HOME/.zshrc $HOME/.zshrc.bak
  rm $HOME/.zshrc
fi

echo "==== copy over dotfiles into home directory"
mkdir -p $HOME/.dotfiles/{python,zsh}
cp -rf $CURRENT_DIRECTORY/zsh python $HOME/.dotfiles/

echo "====  setup private dotfiles capabilities"
mkdir -p $HOME/.dotfiles/private/{python,zsh}
touch $HOME/.dotfiles/private/private.sh

