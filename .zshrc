# Path to your oh-my-zsh installation.
#export PATH=$HOME/bin:/usr/local/bin:$HOME/.composer/vendor/bin:$PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/.composer/vendor/bin
export PATH="$PATH:`yarn global bin`"
export ZSH=/Users/tomas/.oh-my-zsh


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

source ~/developer-setup/zsh/.zshrc.aliases
source ~/developer-setup/zsh/.zshrc.functions
source ~/developer-setup/zsh/.zshrc.plugins
source $ZSH/oh-my-zsh.sh

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

