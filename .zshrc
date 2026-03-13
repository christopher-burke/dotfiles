# ~/.zshrc
# Fast startup only: no installs, no updates, no network calls.

# Powerlevel10k instant prompt (keep at top).
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"

# Normalize OS name so module file names are stable.
case "$OSTYPE" in
  darwin*) DOTFILES_OS="darwin" ;;
  linux*)  DOTFILES_OS="linux" ;;
  *)       DOTFILES_OS="unknown" ;;
esac
export DOTFILES_OS

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

_zsh_modules=(
  "$DOTFILES_DIR/zsh/env/base.zsh"
  "$DOTFILES_DIR/zsh/env/${DOTFILES_OS}.zsh"
  "$DOTFILES_DIR/zsh/aliases/base.zsh"
  "$DOTFILES_DIR/zsh/functions/base.zsh"
  "$DOTFILES_DIR/zsh/tools/python.zsh"
  "$DOTFILES_DIR/zsh/prompt/p10k.zsh"
  "$DOTFILES_DIR/zsh/local/machine.zsh"
)

for _m in "${_zsh_modules[@]}"; do
  [[ -r "$_m" ]] && source "$_m"
done
unset _m _zsh_modules
