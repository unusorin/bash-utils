#!/usr/bin/env bash

echo ""
info_message " => Trying to register Google Chrome repository ..."

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - >> $log_file 2>&1

if [ $? != 0 ]; then
	error_message =" => Failed to register Google Chrome repository ..."
	exit 1;
fi

sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' >> $log_file 2>&1

if [ $? != 0 ]; then
	error_message =" => Failed to register Google Chrome repository ..."
	exit 1;
fi

success_message " => Registered Google Chrome repository ..."
info_message " => Trying to refresh apt database ..."

sudo apt-get update >> $log_file 2>&1

if [ $? != 0 ]; then
	error_message " => Failed to refresh apt database ..."
	exit 1;
fi

success_message " => Refreshed apt database ..."
info_message " => Trying to install Google Chrome Stable ..."
sudo apt-get install google-chrome-stable -y >> $log_file 2>&1

if [ $? != 0 ]; then
	error_message " => Failed to install Google Chrome Stable ..."
	exit 1;
fi
success_message " => Installed Google Chrome Stable ..."
echo ""
