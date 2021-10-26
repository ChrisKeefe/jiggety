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
# inkscape? yed?
# tree

read -p "Install LaTeX and Beamer Poster dependencies? [y/n] " LaTeX
read -p "Install Snap (requires snapd and will prompt for pw)? [y/n] " SNAP
read -p "Install Skype? [y/n] " SKYPE
read -p "Install Discord? [y/n] " DISCORD
read -p "Install VSCode? [y/n] " CODE
read -p "Keep it simple, or try to install yEd? [simple/yed] " YED


sudo -s <<EOF

# required dependencies
zypper --non-interactive install jq
zypper --non-interactive install sshpass
# xclip is pre-installed with this SUSE config

# Configure pre-installed flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# Install slack and zoom
flatpak install flathub zoom -y --noninteractive
flatpak install slack -y --non-interactive

# snapcraft config and slack install
read -p 'Leap or tumbleweed? [leap/tumbleweed] ' WHICH_SUSE
if [[ "$WHICH_SUSE" == "leap" ]]; then
	read -p 'What version number? [e.g. 15.0] ' SUSE_VERSION_NUMBER
	SUSE_VERSION_STR=openSUSE_Leap_${SUSE_VERSION_NUMBER}
else
	SUSE_VERSION_STR=openSUSE_Tumbleweed
fi

if [[ ${SNAP} = "y" ]]; then
    zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/${SUSE_VERSION_STR} snappy
    zypper --gpg-auto-import-keys refresh
    zypper dup --from snappy
    zypper --non-interactive install snapd
    # add snapd to path
    source /etc/profile
    systemctl enable --now snapd
fi

if [[ ${SKYPE} = "y" ]]; then
    zypper addrepo https://repo.skype.com/rpm/stable/skype-stable.repo
    zypper update
    zypper --non-interactive install skypeforlinux
fi

if [[ ${LaTeX} = "y" ]]; then
    zypper --non-interactive install texlive
    # install beamer dependencies
    zypper --non-interactive install texlive-beamerposter qrencode
    # install lato font family - raleway is already installed
    zypper --non-interactive install lato-fonts
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
    code --install-extension vscodevim.vim
fi

# Install GH CLI
zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
zypper ref
zypper install gh

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Hacky lightweight yEd install
if [[ ${YED} = "yed" ]]; then
        bash install_yEd.sh
fi

# optional software
zypper --non-interactive install vlc  
zypper --non-interactive install clementine
zypper --non-interactive install chromium
zypper --non-interactive in htop
zypper --non-interactive in neovim
zypper --non-interactive in variety
zypper --non-interactive in inkscape
zypper --non-interactive in openmpi4 openmpi4-devel openmpi4-docs
echo "export PATH=$PATH:/usr/lib64/mpi/gcc/openmpi4/bin" >> ~/.bashrc

# misc cleanup
zypper --non-interactive remove xterm

# rpm -ql <packagename> will list the files in the package, from which you can get a path
flatpak install org.signal.Signal
flatpak install flathub com.github.alainm23.planner
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
pip install flake8
EOF

