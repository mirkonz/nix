# Load Oh My Zsh plugins
zinit ice wait lucid
zinit snippet OMZ::lib/compfix.zsh
zinit snippet OMZ::lib/git.zsh

# Core Utilities
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

# Directory Jumping
zinit light rupa/z
zinit light agkozak/zsh-z  # Alternative directory jumping

# Powerlevel10k Theme
zinit ice depth=1
zinit light romkatv/powerlevel10k