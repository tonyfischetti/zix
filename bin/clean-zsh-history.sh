#!/usr/local/bin/zsh

set -v

sleep 1
bckup $HOME/.zsh_history
sleep 1
cat $HOME/.zsh_history | ack -v '/sys/devices/pci' | ack -v ':delete:' | ack -v 'tmux delete' | ack -v 'export ZCONTEXT=delete' | ack -v '/\.Trash/' | ack '^:' | ack -v '0;ls$' | sponge $HOME/.zsh_history
sleep 1

