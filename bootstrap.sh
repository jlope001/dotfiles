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
SHELL_USERNAME=$USER
if [ -f /etc/redhat-release ]; then
  sudo usermod -s /bin/zsh $SHELL_USERNAME
else
  sudo chsh -s `which zsh` $SHELL_USERNAME
fi

echo "==== install additional fonts"
mkdir -p $HOME/{.fonts,.fonts.conf.d}
# cd $HOME/.fonts
wget -P $HOME/.fonts/ https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
fc-cache -vf $HOME/.fonts
wget -P $HOME/.fonts.conf.d/ https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

echo "==== setup zsh config"
ZSHRC_FILE="$HOME/.zshrc"
if [ ! -h "$ZSHRC_FILE" ]; then
  cp $HOME/.zshrc $HOME/.zshrc.bak
  rm $HOME/.zshrc
  cp $CURRENT_DIRECTORY/zsh/rc.zsh $HOME/.zshrc
fi

echo "==== copy over dotfiles into home directory"
mkdir -p $HOME/.dotfiles/{python,zsh,vim}
cp -rf $CURRENT_DIRECTORY/zsh python vim $HOME/.dotfiles/

echo "====  setup private dotfiles capabilities"
mkdir -p $HOME/.dotfiles/private/{python,zsh}
touch $HOME/.dotfiles/private/private.sh

echo "====  setup vimrc file"
cp $CURRENT_DIRECTORY/vim/vimrc $HOME/.vimrc

echo "====  setup tmux file"
cp $CURRENT_DIRECTORY/tmux/tmux.conf $HOME/.tmux.conf

