# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to your dotfiles installation.
export DOTFILES_DIR="$HOME/.dotfiles"

# Themes #######################################################################
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins ######################################################################
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration ###########################################################


# macOS ########################################################################
if [[ $(uname) == "Darwin" ]]; then

    # Lock the screen (when going AFK)
    # https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L157-L158
    alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

    # Recursively delete `.DS_Store` files
    alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

    # Flush Directory Service cache
    # https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L71-L72
    alias flush_dns="sudo killall -HUP mDNSResponder"

    # Add color to folders/files
    alias ls='ls -G'

    # Get macOS Software Updates, and update installed Ruby gems, Homebrew, Python
    # modules, npm, and their installed packages.
    # Inspired by https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L56-L57
    function update() {
    sudo softwareupdate -i -a
    brew update
    brew upgrade
    brew upgrade --cask
    brew cleanup
    }
fi

# Python #######################################################################
## Python Virtualenvwrapper settings. ##########################################
export VIRTUALENVWRAPPER_PYTHON=$HOME/.pyenv/shims/python
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.pyenv/shims/virtualenv
source $HOME/.pyenv/versions/$(pyenv global)/bin/virtualenvwrapper.sh



## Functions Custom ############################################################
# .gitignore file for Python.
function pyignore() {
    curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
}

# Remove all python __pycache__/, .pyc  and .pyo files.
function pyclearcache(){
    find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
}

# Capture existing VSCode extensions ###########################################
# Skip if running in WSL
if [ -x "$(command -v code)" ] && [[ "$(uname -r)" != *"microsoft"* ]]; then
  code --list-extensions >"$HOME"/.dotfiles/Code/extensions.list
fi
if [ -x "$(command -v code-insiders)" ] && [[ "$(uname -r)" != *"microsoft"* ]]; then
  code-insiders --list-extensions >"$HOME"/.dotfiles/CodeInsiders/extensions.list
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# End of file 