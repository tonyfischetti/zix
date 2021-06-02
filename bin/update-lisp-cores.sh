#!/usr/local/bin/zsh

# SBCL
sbcl --eval "(progn (load \"~/.lisp/def-cli-args.lisp\") (save-lisp-and-die \"pluto-sbcl.core\" :save-runtime-options t :purify t))";
mv ./pluto-sbcl.core ~/.lisp/;

# CLISP
# (not implemented yet)
