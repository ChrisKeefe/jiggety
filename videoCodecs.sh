#!/bin/bash

# Add and enable packman essentials repo
read -p 'Leap or tumbleweed? [leap/tumbleweed] ' WHICH_SUSE
if [[ "$WHICH_SUSE" == "leap" ]]; then
	sudo zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.2/Essentials packman-essentials
	# interestingly, in Leap 15.2, libavcodec57 and 58 are already installed after these commands run, with no explicit install.
	# For future reference, see the wiki <https://en.opensuse.org/SDB:Firefox_MP4/H.264_Video_Support>
else
	sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials
	# in Tumbleweed as of 12/2020, libavcodec57 is not installed at startup, but 58_91 is.
fi

sudo zypper dup --from packman-essentials --allow-vendor-change

