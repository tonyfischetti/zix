#!/usr/bin/env bash
# zix doctor — check that this machine's shell environment is properly
# installed.  Reports every piece, never mutates anything, exits
# nonzero if something is wrong.  Invoked by `make doctor`.

ZIX="$(cd "$(dirname "$0")" && pwd)"
UNAME_S="$(uname -s)"

green="\033[32m"; red="\033[31m"; yellow="\033[33m"; bold="\033[1m"; off="\033[0m"
fail=0
ok()   { printf "  ${green}✓${off} %s\n" "$1"; }
bad()  { printf "  ${red}✗ %s${off}\n" "$1"; fail=1; }
warn() { printf "  ${yellow}! %s${off}\n" "$1"; }

printf "${bold}zix doctor${off} (%s)\n" "$UNAME_S"

# --- tools ---
command -v zsh    >/dev/null && ok "zsh on PATH ($(command -v zsh))" || bad "zsh not found (make deps)"
command -v fzf    >/dev/null && ok "fzf on PATH"    || bad "fzf not found (make deps)"
command -v zoxide >/dev/null && ok "zoxide on PATH" || bad "zoxide not found (make deps)"

# --- symlinks ---
# each entry is "link|source-relative-to-zix"; -ef dereferences, so a
# link counts only if it resolves to the repo's copy
links="
$HOME/.zshrc|.zshrc
$HOME/.ackrc|.ackrc
$HOME/.wgetrc|.wgetrc
$HOME/.visidatarc|.visidatarc
$HOME/.sqliterc|.sqliterc
$HOME/.npmrc|.npmrc
$HOME/.ghci|.ghci
$HOME/.gnupg/gpg.conf|gpg.conf
$HOME/.config/htop/htoprc|.htoprc
$HOME/.config/fd/ignore|.fdignore
$HOME/.config/ghostty/config|.ghostty
$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1|pwsh-profile.ps1
"
if [ "$UNAME_S" = "Darwin" ]; then
  links="$links
$HOME/.hammerspoon/init.lua|.hammerspoon.init.lua"
fi
linkfail=0
while IFS='|' read -r link src; do
  [ -z "$link" ] && continue
  if ! [ "$link" -ef "$ZIX/$src" ]; then
    bad "$link does not resolve to zix's $src (make setup)"
    linkfail=1
  fi
done <<< "$links"
[ "$linkfail" -eq 0 ] && ok "all rc/config symlinks resolve into $ZIX"

# --- built artifacts ---
[ -x "$ZIX/bin/dvd" ] && ok "bin/dvd built" || bad "bin/dvd missing (make setup)"

# --- node ---
if command -v bun >/dev/null; then
  [ -d "$ZIX/node_modules" ] && ok "node_modules present (bun)" || bad "node_modules missing (make setup)"
else
  warn "bun not on PATH — bin/codex won't run"
fi

# --- things zix provides but other repos own the deps for ---
# (lispscript needs clix's sbcl+core; PATH additions live in .zshrc, so
# a docker-build shell won't have them yet — warn, never fail)
command -v lispscript >/dev/null 2>&1 \
  && ok "lispscript resolvable via PATH" \
  || warn "lispscript not on current PATH (fine outside a zsh session)"
case "$SHELL" in
  *zsh*) ok "login shell is zsh" ;;
  *)     warn "login shell is not zsh ($SHELL)" ;;
esac

echo
if [ "$fail" -eq 0 ]; then
  printf "${green}${bold}all good.${off}\n"
else
  printf "${red}${bold}problems found — see above.${off}\n"
fi
exit "$fail"
