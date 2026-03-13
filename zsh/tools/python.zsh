# pyenv location (init happens in tools/python.zsh).
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"

# Optional: central place for language-specific env vars.
#export WORKON_HOME="${WORKON_HOME:-$HOME/.virtualenvs}"
export WORKON_HOME="${WORKON_HOME:-$HOME/.venv}"

# zsh/tools/python.zsh
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"

if [[ -d "$PYENV_ROOT/bin" ]]; then
  path=("$PYENV_ROOT/bin" $path)
  export PATH

  # Login shell path support.
  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
  fi

  # Optional virtualenvwrapper integration.
  if command -v pyenv >/dev/null 2>&1 && pyenv commands | grep -q '^virtualenvwrapper_lazy$'; then
    export VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-$HOME/.pyenv/shims/python}"
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="${PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV:-true}"
    pyenv virtualenvwrapper_lazy
  fi
fi