#!/usr/bin/env bash

bash ubuntu-essentials.sh

echo "Installing PHP Server packages"
echo "---------------------------------"

echo ""
echo "Adding ppa's ..."
echo "---------------------------------"

sudo add-apt-repository ppa:nginx/stable -y
sudo add-apt-repository ppa:ondrej/php5 -y

sudo apt-get update -y

echo ""
echo "Upgrading system ..."
echo "---------------------------------"

sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo ""
echo "Installing packages ..."
echo "---------------------------------"

export PACKAGES="mysql-server mysql-client" 
export PACKAGES="$PACKAGES nginx php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt"
export PACKAGES="$PACKAGES php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy"
export PACKAGES="$PACKAGES php5-xmlrpc php5-xsl php5-xcache php5-fpm php5-cli php5-cgi siege"

sudo apt-get install $PACKAGES -y

echo "----------------------------------"
echo "DONE"
echo "----------------------------------"
echo ""