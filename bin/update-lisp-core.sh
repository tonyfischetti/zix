#!/usr/local/bin/zsh

sbcl --eval "(progn (load \"~/.sbcl/def-cli-args.lisp\") (save-lisp-and-die \"clix.core\" :save-runtime-options t :purify t))";
sudo mv ./clix.core /usr/local/lib/sbcl/;
