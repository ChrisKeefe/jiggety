#!/bin/bash

set -e
# TODO: Install fonts for getGit
# Install printers (attached, move into /etc/cups/ppd, set root as owner)
# Install R and relevant packages (ggplot2, dplyr, etc)
# Install gcc and other c programming utils
# remove "Show Desktop" from toolbar
# log in to firefox and show bookmarks toolbar, remove pocket, set default search to duckduckgo.
# deal with passwording: https://stackoverflow.com/a/11955369

read -p "Keep it simple, or try to install yEd? [simple/yed] " YED

sudo -s -- <<EOF
# enter password
apt update
apt upgrade -y
apt dist-upgrade -y
apt autoremove
apt autoclean -y

# Required dependencies:
apt install snapd
apt install jq -y
apt install xclip -y

# Optional software:
apt install dconf-editor
apt install build-essential -y
apt install chromium-browser -y
apt install clementine -y
apt install idle-python3.6 -y
apt install python-pip -y
pip install flake8
apt install default-jdk -y
apt install inkscape -y
snap install slack --classic
snap install discord

# Install Vim
apt install neovim -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.viM

# Install VSCode
snap install code --classic
EOF

# Hacky lightweight yEd install
if [[ ${YED} = "yed" ]]; then
	bash install_yEd.sh
fi

# Add Snap packages to PATH
echo 'export PATH=$PATH:/snap/bin' >> ~/.bashrc


