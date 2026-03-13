# zsh/functions/base.zsh
# Create Python .gitignore in current directory.
pyignore() {
  curl -fsSL \
    https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore \
    -o .gitignore
}

# Remove Python caches under current tree.
pyclearcache() {
  find . -type d -name __pycache__ -prune -exec rm -rf {} +
  find . -type f \( -name '*.pyc' -o -name '*.pyo' \) -delete
}

# Safer update helper: manual invocation only.
dot_update() {
  if [[ "$DOTFILES_OS" == "darwin" ]]; then
    softwareupdate -l || true
    brew update && brew upgrade && brew upgrade --cask && brew cleanup
  else
    echo "No OS update recipe configured for: $DOTFILES_OS"
  fi
}
