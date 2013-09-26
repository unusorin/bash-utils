
#!/usr/bin/env bash

echo "Installing Desktop essentials ... "
echo "----------------------------------"

bash ubuntu-essentials.sh

echo "Adding ppa's....."
echo "----------------------------------"
sudo add-apt-repository ppa:webupd8team/sublime-text-2 -y
sudo add-apt-repository ppa:olivier-berten/misc -y

#google chrome ppa
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

sudo apt-get update -y

echo "Upgrading current packages ... "
echo "----------------------------------"

sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y


echo "Installing packages ... "
echo "----------------------------------"

sudo apt-get install terminator openjdk-7-jre openjdk-7-jdk qgit pidgin sublime-text google-chrome-stable mysql-workbench vlc filezilla unetbootin -y --force-yes

echo "----------------------------------"
echo "DONE"
echo "----------------------------------"
echo ""