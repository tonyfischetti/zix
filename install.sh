#!/bin/bash

ln -s ~/.zsh/.zshrc ~/.zshrc
ln -s ~/.zsh/.ackrc ~/.ackrc
mkdir -p ~/.gnupg
ln -s ~/.zsh/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/.zsh/.wgetrc ~/.wgetrc
ln -s ~/.zsh/.sqliterc ~/.sqliterc
mkdir -p ~/.config/htop
ln -s ~/.zsh/.htoprc ~/.config/htop/htoprc
ln -s ~/.zsh/.npmrc ~/.npmrc
mkdir -p ~/.config/fd
ln -s ~/.zsh/.fdignore ~/.config/fd/ignore
mkdir -p ~/.config/powershell
ln -s ~/.zsh/pwsh-profile.ps1 ~/.config/powershell/Microsoft.PowerShell_profile.ps1

sudo ln -s ~/.zsh/bin/lisp /usr/local/bin/lisp
sudo ln -s ~/.zsh/bin/lispscript /usr/local/bin/lispscript
sudo ln -s ~/.zsh/site-functions/_pass /usr/local/share/zsh/site-functions/_pass
sudo ln -s ~/.zsh/site-functions/_gulp /usr/local/share/zsh/site-functions/_gulp
sudo ln -s ~/.zsh/site-functions/_deno /usr/local/share/zsh/site-functions/_deno

mkdir -p ~/.ssh/login-keys.d/

echo "don't forget to decrypt the ssh_config and run 'ln -s ~/.zsh/ssh_config ~/.ssh/config'"
echo "and..."
echo "don't forget to add private key to ~/.ssh/login-keys.d and put key in '~/.keys'"
echo "and..."
echo "don't forget to 'ln -s ~/.zsh/.gitconfig ~/.gitconfig'"
