#!/bin/sh

set -e
# TODO: Make this robust against overwriting existing keys

read -p "What is your github email address? " GHEMAIL

# Generate GH SSH Key
# NOTE: ~/.ssh/id_rsa fails
ssh-keygen -t rsa -b 4096 -C "${GHEMAIL}" -f $HOME/.ssh/id_rsa

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

xclip -sel clip < ~/.ssh/id_rsa.pub

printf "Your new SSH Key has been added to your clipboard."
read -p "Press enter once you have added your SSH Key to your Github account. "


# Add GitHub API token to global environment
printf "Generate a new API token: https://github.com/settings/tokens"
read -p "Paste your new token here: " TMPTOKEN

if [ ! -f ~/src/jiggety/scrpt_vars ]; then
	touch scrpt_vars
fi

echo "export GHTKN=\"${TMPTOKEN}\"" >> scrpt_vars
source scrpt_vars

# Update jiggety remote URL so use SSH
git remote remove origin
git remote add origin git@github.com:ChrisKeefe/jiggety.git
