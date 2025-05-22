# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Shell Options
autoload -Uz compinit
compinit
setopt AUTO_CD

# Environment Variables
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
export MAIL=jronnbla@student.hive.fi
export BAT_THEME="Monokai Pro"

# Path Configuration
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/APPS/bin:$PATH"
export PATH="$HOME/APPS:$PATH"
export PATH="$HOME/APPS/nvim/bin:$PATH"
export PATH="$HOME/APPS/sassc/bin:$PATH"
export PATH="$HOME/APPS/gettext/bin:$PATH"

# Library Paths
export LD_LIBRARY_PATH="$HOME/APPS/gettext/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$HOME/APPS/gettext/lib/pkgconfig:$PKG_CONFIG_PATH"

# App Specific Configurations
export SASSC="$HOME/APPS/sassc/bin/sassc"
export GETTEXT="$HOME/APPS/gettext"

# Neovim LSP/Mason Configuration
# Add Mason bin directory to PATH if not already included
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Aliases
alias vim="nvim"
alias zsh='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias zel="$HOME/APPS/zellij/zellij"
alias fl='ft_lock'
alias q='yazi'
alias norm='norminette -R Checkdefine && norminette -R CheckForbiddenSourceHeader'
