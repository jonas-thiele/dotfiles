# My Dotfiles

## Installation

Install git and clone this repository to `~/dotfiles/`:

``` bash
sudo apt install git
git clone https://github.com/jonas-thiele/dotfiles.git
cd ~/dotfiles
```

### Terminal settings

First, you need to configure your terminal emulator to use the correct color
and font settings. I use the nord theme with the JetBrainsMono font patched
nerd-font symbols.

#### gnome-terminal

Simply run `./bootstrap.sh setup-terminal-gnome` to install the theme and font.
To apply the settings you have to manually set *Nord* as the default profile.
Then you need to enable *Custom font* in the *Test* tab of the preferences
window and select *JetBrainsMono Nerd Font Mono Regular*. If the font doesn't show 
up, follow this guide: https://superuser.com/a/1549327.


### Installing dotfiles, packages, and plugins

The command `./bootstrap.sh all` does the following:

1. Install some basic packages (like vim and tmux). You will be asked to type
in your password
2. Backup all the existing dotfiles in the home directory that will be 
overwritten with symlinks in step 3
3. Delete all of these existing dotfiles
4. Create symlinks to the new dotfiles.
5. Installs plugin managers for vim and tmux and runs them to install the plugins
referenced in the dotfiles

Restart your terminal and you should be good to go.
