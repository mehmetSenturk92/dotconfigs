#!/bin/bash
set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
answer=$1

cd $SCRIPTPATH

fileCheck() {
    check=$1
    echo "Do you want export $check file contents [ Y / N ]"
    read bool
    if [ "$bool" == "Y" ]
    then
        echo "source $SCRIPTPATH/$check" >> .zshrc
        echo "source $SCRIPTPATH/$check command added to .zshrc"
    else
        echo "Skipping $check file"
    fi
}

if  [ "$answer" == "Y" ]
then
    cat .rootrc > .zshrc
    echo "source $SCRIPTPATH/.env" >> .zshrc
    echo "source $SCRIPTPATH/.functions" >> .zshrc
    echo "source $SCRIPTPATH/.aliases" >> .zshrc
    echo "source $SCRIPTPATH/.edit" >> .zshrc
    echo "source $SCRIPTPATH/.keybindings" >> .zshrc
    echo "source $SCRIPTPATH/.zshplugins" >> .zshrc
    echo "source $SCRIPTPATH/.local" >> .zshrc
    echo "source $ZSH/oh-my-zsh.sh" >> .zshrc
elif [ "$answer" == "N" ]
then
    cat backup/.zshrc > .zshrc
    echo "\n" >> .zshrc
    cat .vimrc > .vimrc
    echo "Getting .zshrc from backup"
    fileCheck .env
    fileCheck .functions
    fileCheck .aliases
    fileCheck .edit
    fileCheck .keybindings
    fileCheck .zshplugins
    fileCheck .local
    cat backup/.vimrc >> .vimrc
    echo "source $ZSH/oh-my-zsh.sh" >> .zshrc
else
    echo "Wrong input supplied. Valid inputs are Y or N"
    exit 1
fi

