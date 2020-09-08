#!/usr/bin/env bash

echo "Pulling dotfiles repository"
git -C ~/dotfiles/ pull origin master

echo "Copying dotfiles into home directory"
rsync --exclude ".git/" --exclude "sync.sh" --exclude "*.swp" --exclude "*.swo" -avh --no-perms ~/dotfiles/ ~

echo "Reloading bashrc"
source ~/.bashrc
