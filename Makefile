# zix — Tony's shell environment.  Single source of truth for setting
# up a machine's shell (replaces install.sh).
#
#   make deps      install OS packages (needs sudo/brew)
#   make setup     idempotent install: symlinks, artifacts, node deps
#   make doctor    check the install and report, loud + colorful
#   make clean     remove built artifacts
#
# Everything is re-runnable: `make setup` on a drifted machine repairs
# it.  No sudo outside `deps` — completions resolve via fpath
# ($ZSH/site-functions, .zshrc line ~18) and bin/ resolves via PATH, so
# the old /usr/local/bin + vendor-completions symlinks are gone.
#
# NB: written to run on the macOS system make (GNU Make 3.81) as well
# as Debian's — so no .ONESHELL; multi-step recipes use continuations.

SHELL := /bin/bash
.DELETE_ON_ERROR:

ZIX     := $(CURDIR)
UNAME_S := $(shell uname -s)

# bin/codex's runtime; pinned (the bun.sh installer is unpinned AND
# appends PATH exports to ~/.zshrc — which is a symlink into this repo)
BUN_VERSION := 1.3.13

ALL_ARTIFACTS := bin/dvd

.PHONY: help all deps setup links node doctor clean

help:
	@echo "zix setup — targets:"
	@echo "  make deps      install OS packages (needs sudo/brew)"
	@echo "  make setup     idempotent install (symlinks, artifacts, node deps)"
	@echo "  make doctor    check the install and report"
	@echo "  make clean     remove built artifacts"

all: $(ALL_ARTIFACTS)

# ---- OS packages ----------------------------------------------------- #
# The one place the shell's platform deps are written down (was smeared
# across the Dockerfile).  Term::Animation is for asciiquarium.
deps:
ifeq ($(UNAME_S),Darwin)
	brew install fzf zoxide
	@command -v bun >/dev/null \
	  || echo "bun not installed — get it from https://bun.sh (bin/codex needs it)"
else
	sudo apt-get update -qq -o Acquire::Retries=3
	sudo apt-get install -qq -y -o Acquire::Retries=3 \
	  zsh procps fzf zoxide wget unzip build-essential libcurses-perl cpanminus nala
	sudo cpanm install Term::Animation
	@if command -v bun >/dev/null && [ "$$(bun --version)" = "$(BUN_VERSION)" ]; then \
	  echo "bun $(BUN_VERSION) already installed"; \
	else \
	  arch=$$( [ "$$(uname -m)" = "aarch64" ] && echo aarch64 || echo x64 ); \
	  echo "installing bun $(BUN_VERSION) ($$arch)"; \
	  wget -q "https://github.com/oven-sh/bun/releases/download/bun-v$(BUN_VERSION)/bun-linux-$$arch.zip" \
	    -O /tmp/bun.zip && \
	  unzip -qoj /tmp/bun.zip -d /tmp/bun-extract && \
	  sudo install -m 755 /tmp/bun-extract/bun /usr/local/bin/bun && \
	  rm -rf /tmp/bun.zip /tmp/bun-extract; \
	fi
endif

# ---- full install ---------------------------------------------------- #
setup: links all node
	@echo "setup complete — run 'make doctor' to verify."

# every link is ln -sfn and every dir mkdir -p, so a rerun converges
# instead of dying like the old bare `ln -s` did
links:
	ln -sfn $(ZIX)/.zshrc      $(HOME)/.zshrc
	ln -sfn $(ZIX)/.ackrc      $(HOME)/.ackrc
	ln -sfn $(ZIX)/.wgetrc     $(HOME)/.wgetrc
	ln -sfn $(ZIX)/.visidatarc $(HOME)/.visidatarc
	ln -sfn $(ZIX)/.sqliterc   $(HOME)/.sqliterc
	ln -sfn $(ZIX)/.npmrc      $(HOME)/.npmrc
	ln -sfn $(ZIX)/.ghci       $(HOME)/.ghci
	mkdir -p $(HOME)/.gnupg
	ln -sfn $(ZIX)/gpg.conf $(HOME)/.gnupg/gpg.conf
	mkdir -p $(HOME)/.config/htop
	ln -sfn $(ZIX)/.htoprc $(HOME)/.config/htop/htoprc
	mkdir -p $(HOME)/.config/fd
	ln -sfn $(ZIX)/.fdignore $(HOME)/.config/fd/ignore
	mkdir -p $(HOME)/.config/ghostty
	ln -sfn $(ZIX)/.ghostty $(HOME)/.config/ghostty/config
	mkdir -p $(HOME)/.config/powershell
	ln -sfn $(ZIX)/pwsh-profile.ps1 $(HOME)/.config/powershell/Microsoft.PowerShell_profile.ps1
ifeq ($(UNAME_S),Darwin)
	mkdir -p $(HOME)/.hammerspoon
	ln -sfn $(ZIX)/.hammerspoon.init.lua $(HOME)/.hammerspoon/init.lua
endif

# ---- built artifacts ------------------------------------------------- #
bin/dvd: src/dvd.c
	gcc -O2 $< -o $@

# ---- node dependencies ----------------------------------------------- #
# bin/codex runs on bun (bun.lock is the lockfile).  A machine without
# bun skips this with a warning instead of failing the whole setup.
node:
	@if command -v bun >/dev/null; then \
	  cd $(ZIX) && bun install --frozen-lockfile; \
	else \
	  echo "node: bun not on PATH -- skipping (bin/codex won't run)"; \
	fi

# ---- doctor: report, never mutate ------------------------------------ #
doctor:
	@bash $(ZIX)/doctor.sh

clean:
	- @rm -f $(ALL_ARTIFACTS)
