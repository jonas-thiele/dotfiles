# My Dotfiles

This repo contains all my dotfiles and tools that help setting up my preferred
working environment.


## Prerequisites

### Terminal Emulator

It is important to configure the terminal emulator of choice to use the correct
color palette. Otherwise the themes defined in the dotfiles will not look as
intended.

#### gnome-terminal

First, we need to install the nord profile for 
[gnome-terminal](https://github.com/arcticicestudio/nord-gnome-terminal):

``` bash
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
./nord-gnome-terminal/src/nord.sh
```


## Installation

Install git and clone this repository to `~/dotfiles/`:

``` bash
sudo apt install git
git clone https://github.com/jonas-thiele/dotfiles.git
```