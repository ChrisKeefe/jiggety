#!/bin/bash

# Points Nautilus file browser "Places" at rotational HDD mounted to /media/archives
sed -i 's+$HOME/Music+/media/archives/Musica+' ~/.config/user-dirs.dirs
sed -i 's+$HOME/Pictures+/media/archives/Pictures+' ~/.config/user-dirs.dirs
sed -i 's+$HOME/Videos+/media/archives/Videos+' ~/.config/user-dirs.dirs

