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
# clone common QIIME repos, add relevant git remotes
# Install R and relevant packages (ggplot2, dplyr, etc)
# Install firefox fb-blocker plugin
# Eclipse

read -p "Install LaTeX and Beamer Poster dependencies? [y/n] " LaTeX
read -p "Install Slack and Discord (requires snapd and will prompt for pw)? [y/n] " SNAP

sudo -s <<EOF

# required dependencies
zypper install jq -y

# snapcraft config
if [[ ${SNAP} = "y" ]]; then
  zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.2 snappy
  zypper --gpg-auto-import-keys refresh
  zypper dup --from snappy
  zypper install snapd -y

  # add snapd to path
  source /etc/profile

  systemctl enable --now snapd

  snap install slack --classic
fi


#Install Miniconda, QIIME2, qiime2 repos, personal repos.
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
SHELL=$0
eval "$(~/miniconda/bin/conda shell.$SHELL hook)"
conda init
rm Miniconda3-latest-*

# optional software
zypper install chromium-browser
pip install flake8

if [[ ${LaTeX} = "y" ]]; then
        # Install LaTeX
	zypper install texlive -y

        # install beamer dependencies
	zypper install texlive-luatex qrencode -y

	# TODO: install fonts
fi

# Install Discord
wget "https://discordapp.com/api/download/stable?platform=linux&format=tar.gz" -O /opt/discord.tar.gz
tar -xvf /opt/discord.tar.gz -C /opt/
ln -s /opt/Discord/Discord /usr/local/bin/discord
ln -s ~/src/jiggety/desktop_files/discord.desktop ~/.local/share/applications


#Install q2 environment
Q2LATEST=$(curl --silent "https://api.github.com/repos/qiime2/qiime2/tags" | jq -r '.[0].name')
Q2PREV=$(curl --silent "https://api.github.com/repos/qiime2/qiime2/tags" | jq -r '.[1].name')
ISDEV=$(echo $Q2LATEST | grep -o 'dev')

# if latest version is a dev version, use the prior tag. Else, it is a patch and we should use that
if [[ $ISDEV == "dev" ]]; then
  Q2LATEST=$Q2PREV
fi
# Strip patch numbers for download
Q2LATEST=$(echo $Q2LATEST | grep -oP '20[12][0-9]\.[0-9]+')
Q2SHORT=$(echo "$Q2LATEST" | grep -oP '[12][0-9]\.[0-9]+')
Q2URL="https://data.qiime2.org/distro/core/qiime2-${Q2LATEST}-py36-linux-conda.yml"
conda update conda -y
wget $Q2URL
conda env create -n "q2-${Q2SHORT}" --file "qiime2-${Q2LATEST}-py36-linux-conda.yml"
rm "qiime2-${Q2LATEST}-py36-linux-conda.yml"

#Install dev environment
wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py36-linux-conda.yml
conda env create -n q2-dev --file qiime2-latest-py36-linux-conda.yml
rm qiime2-latest-py36-linux-conda.yml
EOF

# TODO: 
# conda create --name gitRepoDump --clone base
# conda activate gitRepoDump
# conda install nodejs -y
# npm install -g git-friends
