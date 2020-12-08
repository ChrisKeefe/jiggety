#!/bin/sh

set -e

#Install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
# hit enter, scroll through license w/enter, type "yes", hit enter, hit enter to confirm
# default location, yes and enter to configure in .bashrc

# Set $PATH for this session, allowing bash to find conda
PATH="/home/chris/miniconda3/bin:/home/chris/miniconda3/condabin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# install conda tooling for building and uploading packages
conda install conda-build -y
conda install anaconda-client -y

#Install latest q2 environment
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
sudo timeshift --create --comments "Installs miniconda and QIIME 2"

