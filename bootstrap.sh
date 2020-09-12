#!/usr/bin/env bash

header() {
    echo ""
    echo "==================================="
    echo "$1"
    echo "==================================="
}

find_dotfiles() {
    find -H "$HOME/dotfiles/" -name '*.sync'
}

# Creates a symlink of form '.<name>' in the home directory for each file 
# '<name>.sync'.
sync() {
    header "Creating symlinks for dotfiles"

    for file in $(find_dotfiles); do
        destination="$HOME/.$(basename "$file" '.sync')"
        if [ -e "$destination" ]; then
            echo "$destination already exists!"
        else
            echo "$destination -> $file"
            ln -s "$file" "$destination"
        fi
    done
}

# Removes all files and folders that would be in the way of symlinks created
# by sync.
clean() {
    header "Cleaning home directory for synchronization"

    for file in $(find_dotfiles); do
        destination="$HOME/.$(basename "$file" '.sync')"
        if [ -e "$destination" ]; then
            echo "Delete $destination"
            rm -rf $destination
        fi
    done
}

# Backups all files and folders in the home directory that would be replaced 
# by dotfiles.
backup() {
    header "Creating backup of existing dotfiles in home directory"

    echo "Creating backup directory ~/dotfiles.bck"
    mkdir -p $HOME/dotfiles.bck

    for file in $(find_dotfiles); do
        target_name=".$(basename "$file" '.sync')"
        if [ -e "$HOME/$target_name" ]; then
            echo "Copying $HOME/$target_name to $HOME/dotfiles.bck/$target_name"
            cp -R $HOME/$target_name $HOME/dotfiles.bck/$target_name
        fi
    done
}

# Clones and installs all third party tools required by the dotfiles.
install-plugins() {
    header "Installing third-party tools that are required for dotfiles"

    echo "Installing TPM (tmux plugin manager)"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    echo "Installing tmux plugins"
    tmux start-server
    tmux new-session -d
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux kill-server

    echo "Installing vim-plug (vim plugins manager)"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Installing vim plugins"
    vim +PlugInstall +qall
}

# Installs important packages that are needed for a basic shell setup
install-packages() {
    header "Installing packages"

    sudo apt -y install vim
    sudo apt -y install tmux
    sudo apt -y install uuid
    sudo apt -y install curl
}

# Sets up the shell theme for the gnome-terminal terminal emulator
setup-terminal-gnome() {
    header "Setting up gnome-terminal"

    echo "Installing nord terminal profile"
    mkdir -p ~/dotfiles/tmp
    git clone https://github.com/arcticicestudio/nord-gnome-terminal.git \
        ~/dotfiles/tmp
    ~/dotfiles/tmp/src/nord.sh  
    rm -rf ~/dotfiles/tmp

    echo "Installing JetBrainsMono font"
    mkdir -p ~/.fonts
    wget ~/.fonts/ https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
    fc-cache -f -v

    echo "You need to manually set the Nord profile as default and select the font"
}   
      

case "$1" in
    backup)
        backup
        ;;
    clean)
        clean
        ;;
    sync)
        sync
        ;;
    install-plugins)
        install-tools
        ;;
    setup-terminal-gnome)
        setup-terminal-gnome
        ;;
    all)
        install-packages
        backup
        clean
        sync
        install-plugins
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {install-tools|backup|clean|sync|install-plugins|setup-terminal-gnome|all}\n"
        exit 1
        ;;
esac
