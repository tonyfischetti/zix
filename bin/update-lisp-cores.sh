#!/usr/local/bin/zsh

# SBCL
# sbcl --eval "(progn (load \"~/.lisp/def-cli-args.lisp\") (save-lisp-and-die \"pluto-sbcl.core\" :save-runtime-options t :purify t))";
# mv ./pluto-sbcl.core ~/.lisp/;

# CLISP
# (not implemented yet)
clisp -q -x '(progn (ql:quickload :charon) (use-package :charon) (EXT:SAVEINITMEM "pluto-clisp.mem"))'
mv ./pluto-clisp.mem ~/.lisp/;
