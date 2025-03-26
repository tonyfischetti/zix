#!/bin/bash

# SBCL
cd ~/.lisp; sbcl --eval "(progn (save-lisp-and-die \"pluto-sbcl.core\" :save-runtime-options t :purify t))";

# CLISP
# (not implemented yet)
# cd ~/.lisp; clisp -q -x '(progn (ql:quickload :styx) (use-package :styx) (EXT:SAVEINITMEM "pluto-clisp.mem"))'
