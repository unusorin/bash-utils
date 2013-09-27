#!/usr/bin/env bash

echo "Installing Ubuntu essentials ... "
echo "----------------------------------"

sudo apt-get install git mc make gcc curl -y


echo "Configuring GIT ..."
echo "----------------------------------"

export USER_EMAIL="sorin.badea91@gmail.com"
export USER_FULL_NAME="Sorin Badea"

echo "Setting user identification ...";
echo "----------------------------------"

git config --global user.email $USER_EMAIL
git config --global user.name $USER_FULL_NAME

echo "Setting git colors ....";
echo "----------------------------------"

git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
git config --global color.ui true

echo "Installing custom bashrc ...";
echo "----------------------------------"

cp .bashrc ~/.bashrc

echo "----------------------------------"
echo "DONE"
echo "----------------------------------"
echo ""
