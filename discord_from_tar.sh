#!/bin/bash
set -e

# Install latest stable Discord from tar.gz

# Get tarball
if [[ ! -f ~/Downloads/discord.tar.gz ]]; then
  wget "https://discordapp.com/api/download/stable?platform=linux&format=tar.gz" -O ~/Downloads/discord.tar.gz
fi

sudo -s <<EOF
# extract to /opt
if [[ ! -d /opt/Discord ]]; then
  tar -xvf ~/Downloads/discord.tar.gz -C /opt/
fi

# symlink binary into PATH
ln -s /opt/Discord/Discord /usr/local/bin/discord

# fix broken filepaths in discord.desktop...
sed -i 's+Icon=discord+Icon=/opt/Discord/discord.png+g' /opt/Discord/discord.desktop
sed -i 's+Exec=/usr/share/discord/Discord+Exec=/usr/local/bin/discord+g' /opt/Discord/discord.desktop

# ... and symlink to expose icon in GNOME menus/search
ln -s /opt/Discord/discord.desktop ~/.local/share/applications

EOF

# cleanup
rm ~/Downloads/discord.tar.gz
