#!/bin/sh
set -e

sudo zypper in ruby-devel
sudo zypper in gcc
sudo gem install jekyll
gem list
echo 'export GEM_HOME=$HOME/.gem' >> $HOME/.bashrc

# to install ruby plugins
# cd ~/src/ChrisKeefe.github.io
# bundle update
