#!/usr/bin/env bash
# Thin wrapper kept for muscle memory.  The core-build recipe now lives
# in ~/.lisp/Makefile (single source of truth): `make core` rebuilds
# pluto-sbcl.core only when a pluto source is newer than the core.
exec make -C ~/.lisp core
