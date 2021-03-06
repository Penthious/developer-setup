# Path to your oh-my-zsh installation.
#export PATH=$HOME/bin:/usr/local/bin:$HOME/.composer/vendor/bin:$PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH="$PATH:`yarn global bin`"
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.composer/vendor/bin
export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"
export VIRTUAL_ENV_DISABLE_PROMPT=0
export VIRTUALENVWRAPPER_PYTHON="/usr/local/opt/python/libexec/bin/python"
#export NVM_DIR="$HOME/.nvm"
#  . "/usr/local/opt/nvm/nvm.sh"
export GOPATH=$HOME/golang
export GOPROXY=direct
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export NEW_RELIC_ENABLED=false
export USE_MIRAGE=false
export CONNECT_SCHEMAS_ENABLE=false
export NVM_DIR=~/projects/personal/developer_setup/.nvm
#export CONNECT_BOOTSTRAP_SERVERS='localhost:9092'
#export CONTROL_CENTER_BOOTSTRAP_SERVERS='localhost:9092'
#export KAFKA_ADVERTISED_LISTENERS='PLAINTEXT://localhost:29092'
#export KSQL_BOOTSTRAP_SERVERS="localhost:9092"
#export KAFKA_ADVERTISED_HOST_NAME='localhost'
#export KAFKA_ADVERTISED_PORT='9092'
#export KAFKA_PORT='9092'

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
source $(brew --prefix nvm)/nvm.sh

source /usr/local/bin/virtualenvwrapper.sh
source ~/projects/personal/developer_setup/zsh/.zshrc.aliases
source ~/projects/personal/developer_setup/zsh/.zshrc.functions
source ~/projects/personal/developer_setup/zsh/.zshrc.plugins
source $ZSH/oh-my-zsh.sh

