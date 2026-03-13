#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

info() { printf "==> %s\n" "$*"; }
warn() { printf "WARN: %s\n" "$*" >&2; }

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    info "Homebrew already installed"
    return
  fi

  if [[ "$OSTYPE" == darwin* ]]; then
    info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    warn "Skipping Homebrew install: non-macOS host"
  fi
}

install_pyenv_stack() {
  export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"

  if [[ ! -d "$PYENV_ROOT" ]]; then
    info "Installing pyenv"
    git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
  fi

  mkdir -p "$PYENV_ROOT/plugins"

  for repo in pyenv-update pyenv-virtualenv pyenv-virtualenvwrapper; do
    if [[ ! -d "$PYENV_ROOT/plugins/$repo" ]]; then
      info "Installing $repo"
      git clone "https://github.com/pyenv/$repo.git" "$PYENV_ROOT/plugins/$repo"
    fi
  done
}

apply_macos_defaults() {
  if [[ "$OSTYPE" != darwin* ]]; then
    return
  fi

  if [[ -x "$DOTFILES_DIR/scripts/macos-defaults.sh" ]]; then
    info "Applying macOS defaults"
    "$DOTFILES_DIR/scripts/macos-defaults.sh"
  else
    warn "No macOS defaults script found"
  fi
}

sync_vscode_extensions() {
  if [[ -x "$DOTFILES_DIR/scripts/sync-vscode-extensions.sh" ]]; then
    info "Syncing VS Code extensions"
    "$DOTFILES_DIR/scripts/sync-vscode-extensions.sh" export
  fi
}

main() {
  info "Running bootstrap"
  install_homebrew
  install_pyenv_stack
  apply_macos_defaults
  sync_vscode_extensions
  info "Bootstrap complete"
}

main "$@"