#!/usr/bin/env bash

function sync() {
    rsync --exclude ".git/" --exclude "sync.sh" --exclude "*.swp" --exclude "*.swo" -avh --no-perms ~/dotfiles/ ~
    source ~/.bashrc
}

echo "Pulling dotfiles repository"
git -C ~/dotfiles/ pull origin master

read -p "This will overwrite existing dotfiles. Continue? (y/n)" -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sync
fi
