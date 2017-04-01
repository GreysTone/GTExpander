#!/bin/bash

# This script is used to expand a general *NIX enviornment for GreysTone
echo "Expanding *NIX Coding ENV for GreysTone"
SYSTEM_STR=`tail /etc/issue`
UBUNTU=`expr index "$SYSTEM_STR" UBUNTU`

if [ $UBUNTU -eq 1 ]
then
  echo "==> Detected OS: Ubuntu"
  
  ## update package manager
  echo "==> Updating package manager (1/4)"
  sudo apt-get update
  sudo apt-get upgrade

  ## install basic package
  echo "==> Installing basic package (2/4)"
  sudo apt-get install -y zsh tmux curl
  sudo apt-get install -y git cmake build-essential libncurses5-dev
  sudo apt-get install -y python-dev python3-dev
  sudo apt-get install -y libpython-dev libpython3-dev
  sudo apt-get install -y exuberant-ctags

  ## tty environment
  echo "==> Setting up OH-MY-ZSH (3/4)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  ## vim configuration
  echo "==> Setting up VIM (4/4)"
  git clone https://github.com/vim/vim.git
  cd vim/src
  ./configure --with-features=huge --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --enable-cscope
  make && sudo make install
  cd ../..
  cp ./vimrc ~/.vimrc
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
  echo "==> Only install clang-completer for YCM"
  ~/.vim/bundle/YouCompleteMe/install.py --clang-completer
  cp ./ycm_extra_conf.py ~/.vim/bundle/YouCompleteMe/ycm_extra_conf
else
  echo "Unsupported operating system"
fi

