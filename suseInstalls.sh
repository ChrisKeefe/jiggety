#!/bin/bash

set -e
PKGMAN="zypper"
# OpenSUSE on btrfs saves snapshots by default
sudo $PKGMAN ref

# TODO: First startup
# log in to firefox and show bookmarks toolbar, remove pocket, set default search to duckduckgo.
# deal with passwording: https://stackoverflow.com/a/11955369

# TODO: Install
# fonts for getGit
# both printers (attached, move into /etc/cups/ppd, set root as owner)
# clone common QIIME repos, add relevant git remotes
# Install R and relevant packages (ggplot2, dplyr, etc)
# Install firefox fb-blocker plugin
# Eclipse

sudo -s <<EOF
sudo $PKGMAN install chromium-browser
$PKGMAN install python3-idle -y
$PKGMAN install python3-pip -y
pip install flake8
$PKGMAN install texlive -y
$PKGMAN install jq -y

#Install Miniconda, QIIME2, qiime2 repos, personal repos.
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
SHELL=$0
eval "$(~/miniconda/bin/conda shell.$SHELL hook)"
conda init
rm Miniconda3-latest-*

# hit enter, scroll through license w/enter, type "yes", hit enter, hit enter to confirm
# default location, yes and enter to configure in .bashrc

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
# download all qiime and personal repos
# conda create --name gitRepoDump --clone base
# conda activate gitRepoDump
# conda install nodejs -y
# npm install -g git-friends
