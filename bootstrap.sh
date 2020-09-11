#!/usr/bin/env bash

find_dotfiles() {
    find -H "$HOME/dotfiles/" -name '*.sync'
}

# Creates a symlink of form '.<name>' in the home directory for each file 
# '<name>.sync'.
sync() {
    echo "Creating symlinks for dotfiles"
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

# Removes all files and folders that would be in the way of symlinks created
# by sync.
clean() {
    echo "Cleaning home directory for synchronization"
    for file in $(find_dotfiles); do
        destination="$HOME/.$(basename "$file" '.sync')"
        if [ -e "$destination" ]; then
            echo "    Delete $destination"
            rm -rf $destination
        fi
    done
}

# Backups all files and folders in the home directory that would be replaced 
# by dotfiles.
backup() {
    echo "Creating backup of existing dotfiles in home directory"
    echo "Creating backup directory ~/dotfiles.bck"
    mkdir -p $HOME/dotfiles.bck

    for file in $(find_dotfiles); do
        target_name=".$(basename "$file" '.sync')"
        if [ -e "$HOME/$target_name" ]; then
            echo "    Copying $HOME/$target_name to $HOME/dotfiles.bck/$target_name"
            cp -R $HOME/$target_name $HOME/dotfiles.bck/$target_name
        fi
    done
}

# Clones and installs all third party tools required by the dotfiles.
install-tools() {
    echo "Installing third-party tools that are required for dotfiles"

    # TPM tmux plugin manager
    echo "Installing TPM (tmux plugin manager)"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

case "$1" in
    backup)
        backup
        ;;
    clean)
        clean
        ;;
    install-tools)
        install-tools
        ;;
    sync)
        sync
        ;;
    all)
        backup
        clean
        install-tools
        sync
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {backup|clean|install-tools|sync|all}\n"
        exit 1
        ;;
esac
