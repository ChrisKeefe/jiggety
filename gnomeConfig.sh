#!/bin/sh

set -ex
# TODO: confirm
# default mouse-button-modifier keybinding clobbers vscode multi-cursor, so...
# gsettings set org.cinnamon.desktop.wm.preferences mouse-button-modifier "<Super>"

# TODO: set DE sounds as needed
# GNOME ships with no "minimize" button: Super-H works, but it's nice to have.
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,close


# TODO: Set "Home" key to sleep
