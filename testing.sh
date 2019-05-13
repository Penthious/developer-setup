#!/bin/sh
command_exists(){
    type "$1" > /dev/null 2>&1
}
echo $SHELL
if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif [[ ! -d "$HOME/.oh-my-zsh/" ]]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

#
# Installing zsh plugins
#
if [ ! -d ~/.oh-my-zsh ]; then
    mkdir -p ~/.oh-my-zsh/plugins
fi
for plugin in "${zshPlugins[@]}"; do
    rm -rf $zshPlugins[plugin] 
    echo "Installing zsh plugins"
    echo $plugin
    git clone $plugin
done
