#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
FAIL=0

ok()   { printf "[OK]   %s\n" "$*"; }
warn() { printf "[WARN] %s\n" "$*"; }
err()  { printf "[ERR]  %s\n" "$*"; FAIL=1; }

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

check_cmd() {
  local c="$1"
  if has_cmd "$c"; then ok "command found: $c"; else err "missing command: $c"; fi
}

check_file() {
  local f="$1"
  if [[ -r "$f" ]]; then ok "readable: $f"; else err "missing or unreadable: $f"; fi
}

check_link() {
  local f="$1"
  if [[ -L "$f" ]]; then ok "symlink: $f"; else warn "not a symlink: $f"; fi
}

main() {
  echo "Dotfiles doctor"
  echo

  check_cmd zsh
  check_cmd git
  if [[ "$OSTYPE" == darwin* ]]; then
    check_cmd brew
  fi

  check_file "$DOTFILES_DIR/.zshrc"
  check_file "$DOTFILES_DIR/install.conf.yaml"
  check_file "$DOTFILES_DIR/scripts/bootstrap.sh"

  check_link "$HOME/.zshrc"
  check_link "$HOME/.zprofile"

  if has_cmd pyenv; then
    ok "pyenv is available"
  else
    warn "pyenv not available (run bootstrap)"
  fi

  if [[ $FAIL -ne 0 ]]; then
    echo
    err "doctor found issues"
    exit 1
  fi

  echo
  ok "doctor passed"
}

main "$@"