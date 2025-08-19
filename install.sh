#!/bin/bash

set -euxo pipefail

ln -s ~/.zsh/.zshrc ~/.zshrc
ln -s ~/.zsh/.ackrc ~/.ackrc
# ln -s ~/.zsh/.gitconfig ~/.gitconfig
mkdir -p ~/.gnupg
ln -s ~/.zsh/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/.zsh/.wgetrc ~/.wgetrc
ln -s ~/.zsh/.visidatarc ~/.visidatarc
ln -s ~/.zsh/.sqliterc ~/.sqliterc
mkdir -p ~/.config/htop
ln -s ~/.zsh/.htoprc ~/.config/htop/htoprc
ln -s ~/.zsh/.npmrc ~/.npmrc
ln -s ~/.zsh/.ghci ~/.ghci
mkdir -p ~/.config/fd
ln -s ~/.zsh/.fdignore ~/.config/fd/ignore
mkdir -p ~/.config/ghostty
ln -s ~/.zsh/.ghostty ~/.config/ghostty/config
mkdir -p ~/.config/powershell
ln -s ~/.zsh/pwsh-profile.ps1 ~/.config/powershell/Microsoft.PowerShell_profile.ps1

if [ `uname` = 'Darwin' ]; then
    mkdir ~/.hammerspoon
    ln -s ~/.zsh/.hammerspoon.init.lua ~/.hammerspoon/init.lua
fi

sudo ln -s ~/.zsh/bin/lisp /usr/local/bin/lisp
sudo ln -s ~/.zsh/bin/lispscript /usr/local/bin/lispscript
sudo ln -s ~/.zsh/site-functions/_pass /usr/share/zsh/vendor-completions/_pass
sudo ln -s ~/.zsh/site-functions/_gulp /usr/share/zsh/vendor-completions/_gulp
sudo ln -s ~/.zsh/site-functions/_deno /usr/share/zsh/vendor-completions/_deno
sudo ln -s ~/.zsh/site-functions/_rustup /usr/share/zsh/vendor-completions/_rustup

