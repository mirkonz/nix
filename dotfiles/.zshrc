# Enable Powerlevel10k instant prompt (should stay at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$PATH"

# Load Zinit
source ~/.zinit/bin/zinit.zsh

################################################################
# Nix Integration
################################################################

# Load Nix environment (if available)
if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
    source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# Set up the Nix profile for single-user or multi-user installations
if [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
elif [[ -e "/etc/profile.d/nix.sh" ]]; then
    source "/etc/profile.d/nix.sh"
fi

# Add Nix to PATH
export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"

# Use Direnv with Nix
eval "$(direnv hook zsh)"

################################################################
# Zinit Plugins
################################################################

# Load Oh My Zsh plugins
zinit ice wait lucid
zinit snippet OMZ::lib/compfix.zsh
zinit snippet OMZ::lib/git.zsh

# Core Utilities
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

# System & Language Managers
zinit light docker
zinit light docker-compose
zinit light dotenv
zinit light gem
zinit light git
zinit light npm
zinit light nvm
zinit light pyenv
zinit light rbenv
zinit light zsh-users/zsh-history-substring-search

# Directory Jumping
zinit light rupa/z
zinit light agkozak/zsh-z  # Alternative directory jumping

# Powerlevel10k Theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Apply compinit for completions
autoload -Uz compinit && compinit

################################################################
# ZSH options
################################################################

# NVM NODE
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

autoload -U add-zsh-hook
load-nvmrc() {
    if [[ -f .nvmrc && -r .nvmrc ]]; then
        nvm use
    elif [[ $(nvm version) != $(nvm version default) ]]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# RUBY
eval "$(rbenv init -)"

# Load Aliases
source "${HOME}/.aliases"

# FZF (if installed)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load Powerlevel10k Config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end