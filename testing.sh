#!/bin/sh

cd ~/.ssh && ssh-keygen
cat id_rsa.pub | pbcopy

open "https://github.com/settings/keys"
while true; do
    read -p "Are you done adding your ssh keys to github?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Keys were added"
