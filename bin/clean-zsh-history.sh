#!/usr/local/bin/zsh

set -v

sleep 1
bckup $HOME/.zsh_history
sleep 1
cat $HOME/.zsh_history | ack -v ':delete:' | ack -v '/\.Trash/' | ack -v ';cd\.{0,4}$' | ack -v '0;cd \.{1,2}$' | ack -v '0;ls$' |  ack -v '0;e..{1,4}$' | ack '^:' |perl -pe 's/(\d{4}-\d{2}-\d{2})_\d+?:\d+?:\d+/$1_ATIME/g' | sponge $HOME/.zsh_history
sleep 1

