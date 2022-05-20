#!/bin/bash

ln -s ~/.zsh/.zshrc ~/.zshrc
ln -s ~/.zsh/.ackrc ~/.ackrc
mkdir -p ~/.gnupg
ln -s ~/.zsh/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/.zsh/.wgetrc ~/.wgetrc
ln -s ~/.zsh/.sqliterc ~/.sqliterc
mkdir -p ~/.config/htop
ln -s ~/.zsh/.htoprc ~/.config/htop/htoprc
rm ~/.gitconfig
ln -s ~/.zsh/.gitconfig ~/.gitconfig

sudo ln -s ~/.zsh/bin/lisp /usr/local/bin/lisp
sudo ln -s ~/.zsh/bin/lispscript /usr/local/bin/lispscript
sudo ln -s ~/.zsh/site-functions/_pass /usr/local/share/zsh/site-functions/_pass
sudo ln -s ~/.zsh/site-functions/_gulp /usr/local/share/zsh/site-functions/_gulp

mkdir -p ~/.ssh/login-keys.d/

echo "don't forget to decrypt the ssh_config and run 'ln -s ~/.zsh/ssh_config ~/.ssh/config'"
echo "and..."
echo "don't forget to add private key to ~/.ssh/login-keys.d and put key in '~/.keys'"

