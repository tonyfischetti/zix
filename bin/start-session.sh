#!/bin/bash

VAL="$1"
tmux new -s $VAL \; \
  setenv ZCONTEXT $VAL \; \
  send-keys -t 1 "export ZCONTEXT="$VAL C-m \; \
  send-keys -t 1 "C-l";
