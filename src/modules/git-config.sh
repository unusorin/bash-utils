#!/usr/bin/env bash

echo ""

info_message " => Please provide your full name:"
read full_name

info_message " => Please provide your email address:"
read email_address

info_message " => Configuring git ..."

git config --global user.name $full_name

if [ $? != 0 ]; then
	error_message " => Failed to configure git ..."
	exit 1;
fi

git config --global user.email $email_address

if [ $? != 0 ]; then
	error_message " => Failed to configure git ..."
	exit 1;
fi

git config --global color.branch auto

if [ $? != 0 ]; then
	error_message " => Failed to configure git ..."
	exit 1;
fi

git config --global color.diff auto

if [ $? != 0 ]; then
	error_message " => Failed to configure git ..."
	exit 1;
fi

git config --global color.interactive auto

if [ $? != 0 ]; then
	error_message " => Failed to configure git ..."
	exit 1;
fi

git config --global color.status auto

if [ $? != 0 ]; then
	error_message " => Failed to configure git ..."
	exit 1;
fi

git config --global color.ui true

if [ $? != 0 ]; then
	error_message " => Failed to configure git ..."
	exit 1;
fi

success_message " => GIT configured"
echo ""