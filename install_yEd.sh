#!/bin/sh

# This is a hacky lightweight install script for yEd graph editor. Good luck!
cd Downloads
wget https://yworks.com/resources/yed/demo/yEd-3.19.zip
unzip yEd-3.19.zip
cd yed-3.19/
chmod +x yed.jar

cd Downloads
sudo -s << EOF
# Move files out of home directory
mv yEd-3.19 /opt/

# Put run script into a PATH directory 
touch /usr/bin/yed
chmod +x /usr/bin/yed

cat > ~/usr/bin/yed << EOF
#!/bin/sh
java -jar /opt/yed-3.19/yed.jar &
EOF

EOF

# Cleanup
rm ~/Downloads/yEd-3.19.zip



