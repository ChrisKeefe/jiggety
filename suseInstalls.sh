#!/bin/bash
set -e

# No need to configure backups. OpenSUSE on btrfs saves snapshots by default

# Update zypper repos and system updates
sudo zypper ref
sudo zypper update

# TODO: First startup
# log in to firefox and show bookmarks toolbar, remove pocket, set default search to duckduckgo.
# deal with passwording: https://stackoverflow.com/a/11955369

# TODO: Install
# both printers (attached, move into /etc/cups/ppd, set root as owner)
# Install R and relevant packages (ggplot2, dplyr, etc)
# music and video players (clementine? vlc?)
# inkscape? yed?
# tree
# vim and vim config
# vscode

read -p "Install LaTeX and Beamer Poster dependencies? [y/n] " LaTeX
read -p "Install Slack (requires snapd and will prompt for pw)? [y/n] " SLACK
read -p "Install Discord? [y/n] " DISCORD
read -p "Install VSCode? [y/n] " CODE
read -p "Keep it simple, or try to install yEd? [simple/yed] " YED

sudo -s <<EOF

# required dependencies
zypper --non-interactive install jq
zypper --non-interactive install sshpass
# xclip is pre-installed with this SUSE config

# snapcraft config and slack install
if [[ ${SLACK} = "y" ]]; then
    zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.2 snappy
    zypper --gpg-auto-import-keys refresh
    zypper dup --from snappy
    zypper --non-interactive install snapd

    # add snapd to path
    source /etc/profile

    systemctl enable --now snapd

    snap install slack --classic
fi


if [[ ${LaTeX} = "y" ]]; then
    zypper --non-interactive install texlive
    # install beamer dependencies
    zypper --non-interactive install texlive-luatex qrencode
    # TODO: install fonts
fi

if [[ ${DISCORD} = "y" ]]; then
    # TODO: test this: may require su perms in discord_from_tar.sh
    bash discord_from_tar.sh
fi

# Install VSCode
if [[ ${CODE} = "y" ]]; then
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
    zypper refresh
    zypper --non-interactive install code
    # TODO: vscode config (incl turning off telemetry)
fi

# Hacky lightweight yEd install
if [[ ${YED} = "yed" ]]; then
        bash install_yEd.sh
fi

# optional software
sudo zypper --non-interactive install chromium
pip install flake8
EOF

