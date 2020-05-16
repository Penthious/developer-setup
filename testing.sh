#!/bin/sh

sentence="https://github.com/zsh-users/zsh-syntax-highlighting"
regex=""

if [[ "$sentence" =~ "/(?!.*\/)([^.]*)/" ]]; 
then 
echo "hi"
else 
  echo "Not proper format"; 
fi