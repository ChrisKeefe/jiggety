#!/bin/sh

set -ex
# TODO: confirm
# default mouse-button-modifier keybinding clobbers vscode multi-cursor, so...
# gsettings set org.cinnamon.desktop.wm.preferences mouse-button-modifier "<Super>"

# TODO: set DE sounds as needed
# GNOME ships with no "minimize" button: Super-H works, but it's nice to have.
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,close
# Allow over-amplification - louder at cost of sound quality
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true 
# swap caps-lock with esc
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch', 'caps:swapescape']"

# TODO: Set "Home" key to sleep
