#!/bin/sh

command_exists(){
    type "$1" > /dev/null 2>&1
}

#
# Install xcode and update system software if needed
#
if ! command_exists xcode-select; then
    echo "Installing xcode-select"
    xcode-select --install
else
    echo "Installing system updates"
    softwareupdate --install -a
fi

#
# Make config folder if none exists
#
if [ ! -d ~/.config ]; then
  echo "    Creating .config folder"
  mkdir ~/.config
fi

#
# Check to see if brew in istalled if not then install it
#
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
    phpunit
    python3
    yarn
    dnsmasq
    mysql
    nginx
)

caskApps=(
    # flags should pass through the `brew cask`
    atom
    dropbox
    google-chrome
    iterm2
    insomnia
    karabiner-elements
    phpstorm
    sequel-pro
    slack
    sourcetree
    teamviewer
)

zshPlugins=(
    git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions   
)

#
# Install homebrew and all my brewApps
#
if ! command_exists brew; then
    echo "Some reason brew did not install"
else
    echo "Updating brew"
    brew update
    echo "Upgrading brew"
    brew upgrade
    echo "Tapping dupes"
    brew tap homebrew/dupes
    echo "Tapping versions"
    brew tap homebrew/versions
    echo "Tapping php"
    brew tap homebrew/homebrew-php
    echo "Tapping caskroom"
    brew tap caskroom/cask
    echo "Checking for apps to install"
    for app in "${brewApps[@]}"; do
        if  brew list "$app" > /dev/null 2>&1; then
            echo "$app already installed"
        else  
            echo "Installing $app"
            brew install $app
        fi
    done

    #
    # Moves the cask app folder to the correct place
    #
    if [ -d /opt/homebrew-cask/Caskroom ]; then
        echo "Moving caskroom folder"
        sudo mv /opt/homebrew-cask/Caskroom /usr/local
    fi

    #
    # Installs all all my caskApps
    #
    for app in "${caskApps[@]}"; do
        if  brew cask list "$app" > /dev/null; then
            echo "$app already installed"
        else
          echo "Installing $app"
          brew cask install $app
        fi
    done
fi

#
# Installs neovim to pip
#
if pip3 list neovim > /dev/null 2>&1; then
    pip3 install --upgrade neovim
else
    pip3 install neovim
    pip3 install --upgrade neovim
fi

#
# Installs yarn dependencies
#
if ! command_exists yarn; then
    echo "yarn not found. Please install and then re-run installation scripts"
    exit 1
fi

if ! command_exists npm; then
    echo "npm not found. Please install and then re-run installation scripts"
    exit 1                 
else 
    npm update -g
fi

if ! command_exists ng; then
    npm install -g @angular/cli@latest
    ng set --global packageManager=yarn
else
    echo "Angular-cli already installed"
fi

#
# Add ssh keys to github
#
if [ ! -d ~/.ssh/ ]; then
    mkdir ~/.ssh/
fi
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "Adding ssh key"
    cd ~/.ssh && ssh-keygen
    echo "Copying ssh key"
    cat id_rsa.pub | pbcopy

    echo "Add new ssh key to github"
    open "https://github.com/settings/keys"
    while true; do
        read -p "Are you done adding your ssh keys to github?" yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

#
# Installs zsh with oh-my-zsh
#
if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Installing oh-my-zsh"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

#
# Installing zsh plugins
#
if [ ! -d ~/.oh-my-zsh ]; then
    mkdir -p ~/.oh-my-zsh/plugins
fi
for plugin in "${zshPlugins[@]}"; do
    echo "Installing zsh plugins"
    git clone $plugin
done
 

#
# Install composer
#
if ! command_exists composer; then
    echo "Downloading composer"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"

    echo "Moving composer to the correct directory"
    mv composer.phar /usr/local/bin/composer
else
    echo "Updating composer"
    composer self-update
    echo "Updating global composer dependencies"
    composer global update
fi

#
# Install laravel and laravel valet
#
if [ ! -d ~/.composer/vendor/laravel ]; then
    echo "Downloading laravel"
    composer global require "laravel/installer"
fi

if [ ! -d ~/.composer/vendor/laravel/valet ]; then
    echo "Downloading laravel valet"
    composer global require laravel/valet
    valet install
fi

#
# Set up laravel projects paths
#
if [ ! -d ~/projects ]; then
    echo "Making projects directory"
    mkdir ~/projects
fi

if [ ! -d ~/projects/clevermage ]; then
    echo "Making projects directory"
    mkdir ~/projects/clevermage
    valet park ~/projects/clevermage
fi

if [ ! -d ~/projects/personal ]; then
    echo "Making projects directory"
    mkdir ~/projects/personal
    valet park ~/projects/personal
fi

if [ ! -d ~/projects/redolive ]; then
    echo "Making projects directory"
    mkdir ~/projects/redolive
    valet park ~/projects/redolive
fi


#
# Clones the developer setup repo
#
if [ ! -d ~/developer-setup ]; then
  echo "Cloning developer-setup"
  git clone git@github.com:Penthious/developer-setup.git ~/developer-setup
fi

#
# Where I remove base files and symlink my developer-setup files
#
echo "Removing current zshrc file"
rm ~/.zshrc
echo "Removing current gitconfig file"
rm ~/.gitconfig
echo "Removing current atom settings"
rm -rf ~/.atom
echo "Removing current ideavimcr"
rm ~/.ideavimrc
echo "Symlinking ideavimcr"
ln -sf ~/developer-setup/phpstorm/.ideavimcr ~/.ideavimrc

if [ ! -d ~/.config/karabiner ]; then
  echo "Making directory .config/karabiner"
  mkdir -p ~/.config/karabiner
else
  echo "Removing current karabiner file"
  rm ~/.config/karabiner/karabiner.json
fi

echo "Symlinking gitconfig"
ln -sf ~/developer-setup/.gitconfig ~/.gitconfig
echo "Symlinking karabiner"
ln -sf ~/developer-setup/karabiner.json ~/.config/karabiner/karabiner.json
echo "Symlinking atom"
ln -sf ~/developer-setup/.atom ~/.atom


if [ ! -f ~/.zshrc ]; then
    echo "Symlinking zshrc"
    ln -sf ~/developer-setup/.zshrc ~/.zshrc
else
    echo "Keeping existing zshrc!"
fi

if [ ! -d ~/.config/nvim ]; then
  echo "    Creating nvim folder!"
  mkdir -p ~/.config/nvim
  echo "Symlinking neovim"
  ln -sf ~/developer-setup/init.vim ~/.config/nvim/init.vim
else
  echo "Removing current neovim files"
  rm ~/.config/nvim/init.vim
  echo "Symlinking neovim"
  ln -sf ~/developer-setup/init.vim ~/.config/nvim/init.vim
fi

#
# Finally change shell to zsh
#
if ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
fi
