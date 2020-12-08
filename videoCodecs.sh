#!/bin/bash

# Add and enable packman essentials repo
sudo zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.2/Essentials packman-essentials
sudo zypper dup --from packman-essentials --allow-vendor-change

# interestingly, in Leap 15.2, libavcodec57 and 58 are already installed after these commands run, with no explicit install.
# For future reference, see the wiki <https://en.opensuse.org/SDB:Firefox_MP4/H.264_Video_Support>
