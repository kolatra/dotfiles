#!/bin/sh

URL="https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.7.4_Server_Java_17-21.zip"

wget -O /tmp/archive.zip "$URL"
mkdir ./gt
unzip /tmp/archive.zip -d ./gt
mv ./gt/startserver-java9.sh ./gt/start.sh
chmod a+x ./gt/start.sh
sudo mv ./gt/* /var/lib/mc-gtnh
sudo chown -R mc-gtnh:mc-gtnh /var/lib/mc-gtnh
rm -rf ./gt
