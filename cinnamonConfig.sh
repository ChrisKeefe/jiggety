#!/bin/sh

set -ex
# default mouse-button-modifier keybinding clobbers vscode multi-cursor, so...
gsettings set org.cinnamon.desktop.wm.preferences mouse-button-modifier "<Super>"

# Set Cinnamon sounds
gsettings set org.cinnamon.sounds login-enabled false
gsettings set org.cinnamon.sounds map-enabled false
gsettings set org.cinnamon.sounds maximize-enabled false
gsettings set org.cinnamon.sounds switch-enabled false
gsettings set org.cinnamon.sounds notification-enabled false
gsettings set org.cinnamon.sounds tile-enabled false
gsettings set org.cinnamon.sounds minimize-enabled false
gsettings set org.cinnamon.sounds close-enabled false
gsettings set org.cinnamon.sounds unmaximize-enabled false
gsettings set org.cinnamon.sounds logout-enabled true
gsettings set org.cinnamon.sounds unplug-enabled true
gsettings set org.cinnamon.sounds plug-enabled true

# Configure bluetooth
gsettings set org.blueberry tray-enabled true
gsettings set org.blueberry obex-enabled false
# TODO: add OBEX (bluetooth file transfer) off by default

# Set keyboard key to launch calculator
# TODO: add `keyboard` and `star` keys to media-keys schema if possible, then configure calc launcher

