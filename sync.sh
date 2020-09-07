#!/usr/bin/env bash

function sync() {
    rsync --exclude ".git/" --exclude "sync.sh" -avh --no-perms ~/dotfiles/ ~
    source ~/.bash_profile
}


read -p "This will overwrite existing dotfiles. Continue? (y/n)" -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sync
fi