sudo apt update
sudo apt -y install git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev
cd /usr/src/
sudo curl -O https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-21.2.0.tar.gz
sudo tar xvf asterisk-21.2.0.tar.gz
cd asterisk-21*/
sudo contrib/scripts/get_mp3_source.sh
sudo contrib/scripts/install_prereq install

#Set numeric number of your country.

sudo ./configure
sudo make menuselect #Choose "chan_ooh323" and "format_mp3"
sudo make
sudo make install
sudo make samples
sudo make config
sudo ldconfig
sudo groupadd asterisk
sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
sudo usermod -aG audio,dialout asterisk
sudo chown -R asterisk.asterisk /etc/asterisk
sudo chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
sudo chown -R asterisk.asterisk /usr/lib/asterisk
echo " AST_USER="asterisk" " >> /etc/default/asterisk
echo " AST_GROUP="asterisk" " >> /etc/default/asterisk

sudo systemctl restart asterisk
sudo systemctl enable asterisk
sudo systemctl status asterisk
sudo asterisk -rvv

