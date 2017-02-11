#!/bin/sh
xcode-select --install

command_exists(){
    type "$1" > /dev/null 2>&1
}

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\n\nInstalling homebrew packages..."
echo "=============================="

brewApps=(
    # flags should pass through the `brew list check`
    git
    'grep --with-default-names'
    neovim/neovim/neovim
    wget
    zsh
    node
    php71
    php71-xdebug
    python3
    yarn
)

caskApps=(
    # flags should pass through the `brew cask`
    google-chrome
    phpstorm
    sequel-pro
    slack
    iterm2
    insomnia
    atom
    karabiner-elements
    teamviewer
)
if ! command_exists brew; then
    echo "Some reason brew did not install"
else
    for app in "${brewApps[@]}"; do
        if brew list "$app" > /dev/null 2>&1; then
            brew upgrade $app
        else
            brew install $app
        fi
    done

    brew tap caskroom/cask

    for app in "${caskApps[@]}"; do
        if  brew cask list "$app" > /dev/null; then
            echo "$app already installed"
        fi
        brew cask install $app
    done
fi


if ! command_exists yarn; then
    echo "yarn not found. Please install and then re-run installation scripts"
    exit 1
else

fi

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
    echo "Changing to oh-my-zsh"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    echo "Adding zsh auto complete"
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# Install composer
echo "Downloading composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

echo "Moving composer to the correct directory"
mv composer.phar /usr/local/bin/composer

# Install laravel and laravel valet
echo "Downloading laravel"
composer global require "laravel/installer"
echo "Downloading laravel valet"
composer global require laravel/valet
