#!/bin/bash

# This script is used to expand a general *NIX enviornment for GreysTone
echo "Expanding *NIX coding env for GreysTone"
# Adjusted to distribution Ubuntu
echo "Operating System: Ubuntu"

# update package manager
echo "==> Updating package manager (1/4)"
sudo apt-get update
sudo apt-get upgrade

# install basic package
echo "==> Installing basic package (2/4)"
sudo apt-get install -y zsh tmux
sudo apt-get install -y git vim cmake build-essential
sudo apt-get install -y python-dev python3-dev
sudo apt-get install -y exuberant-ctags

# tty environment
echo "==> Setting up OH-MY-ZSH (3/4)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# vim configuration
echo "==> Setting up VIM (4/4)"
cp ./vimrc ~/.vimrc
cp ./ycm_extra_conf.py ~/.vim/bundle/YouCompleteMe/ycm_extra_conf
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "==> Only install clang-completer for YCM"
~/.vim/bundle/YouCompleteMe/install.py --clang-completer

