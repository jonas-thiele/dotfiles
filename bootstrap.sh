#!/usr/bin/env bash

find_dotfiles() {
    find -H "$HOME/dotfiles/" -name '*.sync'
}

sync () {
    for file in $(find_dotfiles); do
        destination="$HOME/.$(basename "$file" '.sync')"
        if [ -e "$destination" ]; then
            echo "    $destination already exists!"
        else
            echo "    $destination -> $file"
            ln -s "$file" "$destination"
        fi
    done
}

echo "Pulling dotfiles repository"
git -C "$HOME/dotfiles/" pull origin master

echo "Creating symlinks for dotfiles"
sync
