#!/bin/sh

gsettings set org.cinnamon.desktop.background.slideshow slideshow-enabled true
gsettings set org.cinnamon.desktop.background.slideshow random-order true
gsettings set org.cinnamon.desktop.background.slideshow delay 240

# -------------- Add "Next Background" option to desktop context menu -------------
# -------------- section c/o Smurphos at https://forums.linuxmint.com/viewtopic.php?f=208&t=286840&p=1586949&hilit=slideshow#p1586949
echo "[Nemo Action]
Name=Next wallpaper
Comment=If the desktop background slideshow is active, display the next image
Exec=dbus-send --print-reply --dest=org.Cinnamon.Slideshow /org/Cinnamon/Slideshow org.Cinnamon.Slideshow.getNextImage
Icon-Name=media-seek-forward-symbolic
Selection=none
Extensions=any;
Conditions=gsettings org.cinnamon.desktop.background.slideshow slideshow-enabled;desktop;" > ~/.local/share/nemo/actions/next-wallpaper.nemo_action

# -- Download/Install all linuxMint background images in /usr/share/backgrounds ---
sudo -s -- <<EOF
apt install mint-backgrounds-* -y


# ----------- Remove images I don't love (through LM Tina) ------------------------
rm /usr/share/backgrounds/linuxmint/bookwood_linuxmint.jpg /usr/share/backgrounds/linuxmint/default_background.jpg /usr/share/backgrounds/linuxmint/edesigner_linuxmint.png /usr/share/backgrounds/linuxmint/ktee_linuxmint.png /usr/share/backgrounds/linuxmint/sele_linuxmint.png

rm /usr/share/backgrounds/linuxmint-nadia/amazing_sunset.jpg /usr/share/backgrounds/linuxmint-nadia/blue_skies.jpg /usr/share/backgrounds/linuxmint-nadia/chinatown.jpg /usr/share/backgrounds/linuxmint-nadia/end_of_the_world.jpg /usr/share/backgrounds/linuxmint-nadia/long_grass.jpg /usr/share/backgrounds/linuxmint-nadia/mt_washington.jpg /usr/share/backgrounds/linuxmint-nadia/pier.jpg /usr/share/backgrounds/linuxmint-nadia/road.jpg /usr/share/backgrounds/linuxmint-nadia/sunrise_over_the_ligurian.jpg /usr/share/backgrounds/linuxmint-nadia/the_tree.jpg /usr/share/backgrounds/linuxmint-nadia/water.jpg 

rm /usr/share/backgrounds/linuxmint-maya/ancient.jpg /usr/share/backgrounds/linuxmint-maya/fiji.jpg /usr/share/backgrounds/linuxmint-maya/iguazu.jpg /usr/share/backgrounds/linuxmint-maya/inch_beach /usr/share/backgrounds/linuxmint-maya/saltplains.jpg /usr/share/backgrounds/linuxmint-maya/road2.jpg /usr/share/backgrounds/linuxmint-maya/storm.jpg /usr/share/backgrounds/linuxmint-maya/stormcoming.jpg

rm /usr/share/backgrounds/linuxmint-olivia/below_clouds.jpg /usr/share/backgrounds/linuxmint-olivia/blue_sea_and_boat.jpg /usr/share/backgrounds/linuxmint-olivia/chao_phraya.jpg /usr/share/backgrounds/linuxmint-olivia/city_night.jpg /usr/share/backgrounds/linuxmint-olivia/cool_blue_water.jpg /usr/share/backgrounds/linuxmint-olivia/leaf_and_dews.jpg /usr/share/backgrounds/linuxmint-olivia/west_village.jpg

rm /usr/share/backgrounds/linuxmint-petra/arturodonate_skyline.jpg /usr/share/backgrounds/linuxmint-petra/arturodonate_sunrise.jpg /usr/share/backgrounds/linuxmint-petra/bobjagendorf_frozen.jpg /usr/share/backgrounds/linuxmint-petra/kennymatic_blossoms.jpg /usr/share/backgrounds/linuxmint-petra/kennymatic_funkytown.jpg /usr/share/backgrounds/linuxmint-petra/kennymatic_perspective.jpg /usr/share/backgrounds/linuxmint-petra/rapciu_dawn.jpg /usr/share/backgrounds/linuxmint-petra/rapciu_gs1.jpg /usr/share/backgrounds/linuxmint-petra/rapciu_winter.jpg

rm /usr/share/backgrounds/linuxmint-qiana/9dzign_flame.png /usr/share/backgrounds/linuxmint-qiana/blumblaum_3929361972.jpg /usr/share/backgrounds/linuxmint-qiana/dexxus_4714207610.jpg /usr/share/backgrounds/linuxmint-qiana/dexxus_5626316429.jpg /usr/share/backgrounds/linuxmint-qiana/dexxus_5652914929.jpg /usr/share/backgrounds/linuxmint-qiana/j_baer* /usr/share/backgrounds/linuxmint-qiana/konstantin* /usr/share/backgrounds/linuxmint-qiana/mattbuck007_* /usr/share/backgrounds/linuxmint-qiana/papalars_9771422564.jpg /usr/share/backgrounds/linuxmint-qiana/pedrosimoes7_9871620665.jpg /usr/share/backgrounds/linuxmint-qiana/sayantan_7864647044.jpg /usr/share/backgrounds/linuxmint-qiana/shaireproductions_5901561832.jpg /usr/share/backgrounds/linuxmint-qiana/simon__syon_*

rm /usr/share/backgrounds/linuxmint-rafaela/clem_alps.jpg /usr/share/backgrounds/linuxmint-rafaela/clem_giardini.jpg /usr/share/backgrounds/linuxmint-rafaela/clem_lago_di_tenno.jpg /usr/share/backgrounds/linuxmint-rafaela/clem_venezia.jpg /usr/share/backgrounds/linuxmint-rafaela/ether_stepping_back.jpg /usr/share/backgrounds/linuxmint-rafaela/ether_x.jpg /usr/share/backgrounds/linuxmint-rafaela/kennymatic_cathedral_grove.jpg /usr/share/backgrounds/linuxmint-rafaela/m1r0r1m_rila_lake.jpg /usr/share/backgrounds/linuxmint-rafaela/rapciu_deeper.png /usr/share/backgrounds/linuxmint-rafaela/rapciu_hiding.png /usr/share/backgrounds/linuxmint-rafaela/rapciu_pearl.png /usr/share/backgrounds/linuxmint-rafaela/rapciu_sweets.png

rm /usr/share/backgrounds/linuxmint-rebecca/darek_59* /usr/share/backgrounds/linuxmint-rebecca/dexxus_* /usr/share/backgrounds/linuxmint-rebecca/havard_bjerke_822728* /usr/share/backgrounds/linuxmint-rebecca/jebeld17_5917553766.jpg /usr/share/backgrounds/linuxmint-rebecca/konstantin_7* /usr/share/backgrounds/linuxmint-rebecca/locosteve_6779913454.jpg /usr/share/backgrounds/linuxmint-rebecca/papalars_3441098292.jpg /usr/share/backgrounds/linuxmint-rebecca/papalars_10080199475.jpg /usr/share/backgrounds/linuxmint-rebecca/simon__syon_*

rm -r /usr/share/backgrounds/linuxmint-retro/

rm -r /usr/share/backgrounds/linuxmint-rosa/calexil_linux_mint.png /usr/share/backgrounds/linuxmint-rosa/clem_calm.jpg /usr/share/backgrounds/linuxmint-rosa/clem_expo.jpg /usr/share/backgrounds/linuxmint-rosa/clem_lago.jpg /usr/share/backgrounds/linuxmint-rosa/clem_vigneti.jpg /usr/share/backgrounds/linuxmint-rosa/ether_3_* /usr/share/backgrounds/linuxmint-rosa/ether_clouds_life.jpg /usr/share/backgrounds/linuxmint-rosa/ether_sea_foam.jpg /usr/share/backgrounds/linuxmint-rosa/jankaluza_electric_apple.jpg /usr/share/backgrounds/linuxmint-rosa/konstantin_japan.jpg /usr/share/backgrounds/linuxmint-rosa/konstantin_lightning.jpg 

rm /usr/share/backgrounds/linuxmint-sarah/jankaluza_contemplation.jpg /usr/share/backgrounds/linuxmint-sarah/dking_momiji.jpg /usr/share/backgrounds/linuxmint-sarah/konstantin_sky.jpg /usr/share/backgrounds/linuxmint-sarah/linuxmint_beach.jpg /usr/share/backgrounds/linuxmint-sarah/linuxmint_green.jpg /usr/share/backgrounds/linuxmint-sarah/sezgin_tuplips.jpg 

rm /usr/share/backgrounds/linuxmint-serena/ajilden_blossom.jpg /usr/share/backgrounds/linuxmint-serena/capelli_ears_of_corn.jpg /usr/share/backgrounds/linuxmint-serena/capelli_lilium.jpg /usr/share/backgrounds/linuxmint-serena/ekilby_lilac.jpg /usr/share/backgrounds/linuxmint-serena/jvasek_xmas_bokeh.jpg /usr/share/backgrounds/linuxmint-serena/rlukeman_skye.jpg /usr/share/backgrounds/linuxmint-serena/sschooler_sky.jpg

rm /usr/share/backgrounds/linuxmint-sonya/ekilby_lilac2.jpg /usr/share/backgrounds/linuxmint-sonya/jankaluza_petal.jpg /usr/share/backgrounds/linuxmint-sonya/jbishop_water.jpg /usr/share/backgrounds/linuxmint-sonya/jowens_palm.jpg /usr/share/backgrounds/linuxmint-sonya/nfeans_street_lights.jpg /usr/share/backgrounds/linuxmint-sonya/sdai_snow.jpg 

rm /usr/share/backgrounds/linuxmint-sylvia/aviatorjk_bark.jpg /usr/share/backgrounds/linuxmint-sylvia/dclarke_dew.jpg /usr/share/backgrounds/linuxmint-sylvia/dcoffman_lake.jpg /usr/share/backgrounds/linuxmint-sylvia/dcoffman_nature.jpg /usr/share/backgrounds/linuxmint-sylvia/dolah_canyon.jpg /usr/share/backgrounds/linuxmint-sylvia/jankaluza_oil_purple.jpg /usr/share/backgrounds/linuxmint-sylvia/jankaluza_oil_red.jpg /usr/share/backgrounds/linuxmint-sylvia/jdonovan_yosemite.jpg /usr/share/backgrounds/linuxmint-sylvia/sezgin_flowers.jpg /usr/share/backgrounds/linuxmint-sylvia/thomasb_glass_ball.jpg 

rm /usr/share/backgrounds/linuxmint-tara/emcomeau_the_process.jpg /usr/share/backgrounds/linuxmint-tara/evablue_jacques_cartier.jpg /usr/share/backgrounds/linuxmint-tara/jankaluza_* /usr/share/backgrounds/linuxmint-tara/jkosinska_sugar.jpg /usr/share/backgrounds/linuxmint-tara/jplenio_lake.jpg /usr/share/backgrounds/linuxmint-tara/jspires_waiting_for_the_waves.jpg /usr/share/backgrounds/linuxmint-tara/monika_pure_green_grass.jpg /usr/share/backgrounds/linuxmint-tara/proskurovskiy_* /usr/share/backgrounds/linuxmint-tara/sezgin_being_different.jpg /usr/share/backgrounds/linuxmint-tara/tomvining_aso.jpg /usr/share/backgrounds/linuxmint-tara/whmii_toy_store.jpg /usr/share/backgrounds/linuxmint-tara/wjusten_machu_picchu.jpg

rm /usr/share/backgrounds/linuxmint-tessa/aruban_pitsunda.jpg /usr/share/backgrounds/linuxmint-tessa/bfantinatti_small_leaves.jpg /usr/share/backgrounds/linuxmint-tessa/dcoffman_lake.jpg /usr/share/backgrounds/linuxmint-tessa/dking_autumn_in_japan.jpg /usr/share/backgrounds/linuxmint-tessa/jankaluza_* /usr/share/backgrounds/linuxmint-tessa/sezgin_lily.jpg

rm /usr/share/backgrounds/linuxmint-tina/aedmonds_snow.jpg /usr/share/backgrounds/linuxmint-tina/bfantinatti_lily_of_the_nile.jpg /usr/share/backgrounds/linuxmint-tina/ibandura_divide.jpg /usr/share/backgrounds/linuxmint-tina/jankaluza_* /usr/share/backgrounds/linuxmint-tina/linuxmint_mauritius.jpg /usr/share/backgrounds/linuxmint-tina/linuxmint_red_columbine.jpg /usr/share/backgrounds/linuxmint-tina/ndiamantidis_lighthouse.jpg /usr/share/backgrounds/linuxmint-tina/seano_ohahu.jpg /usr/share/backgrounds/linuxmint-tina/sezgin_* /usr/share/backgrounds/linuxmint-tina/acaproni_maldives.jpg 

rm /usr/share/backgrounds/linuxmint-tricia/bfantinatti_night_sky.jpg /usr/share/backgrounds/linuxmint-tricia/jbeekhuis_bandon.jpg /usr/share/backgrounds/linuxmint-tricia/jrinke_florence.jpg /usr/share/backgrounds/linuxmint-tricia/kyoung_chicago.jpg /usr/share/backgrounds/linuxmint-tricia/aandreyev_coal.jpg
EOF

# Softlink all LM backgrounds in a single directory, and point the slideshow to it
# Thanks to rene! https://forums.linuxmint.com/posting.php?mode=reply&f=208&t=300200
mkdir ~/.all_backgrounds
ln -sf /usr/share/backgrounds/*/* ~/.all_backgrounds
gsettings set org.cinnamon.desktop.background.slideshow image-source "directory:///home/${USER}/.all_backgrounds"

