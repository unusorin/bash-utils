#!/usr/bin/env bash


echo -e ""
info_message " => Trying to register apt repositories ... "
echo -e ""

for repository in "${repositories[@]}"; do
	sudo add-apt-repository ppa:$repository -y >> $log_file 2>&1
	if [ $? == 0 ];then
		success_message " ==> Installed repository: "$repository
	else
		error_message " ==> Failed to install repository: "$repository
		error_message " => Failed to register apt repositories ... "
		exit 1;
	fi

done

echo ""
success_message " => Registered all required apt repositories ... "
info_message " => Trying to update apt database ... "

sudo apt-get update >> $log_file 2>&1

if [ $? == 0 ]; then
	success_message " => Updated apt database ..."
else
	error_message " => Failed to update apt database ... "
	exit 1;
fi

echo ""

info_message " => Trying to upgrade current installed packages ... "

sudo apt-get upgrade -y >> $log_file 2>&1

if [ $? != 0 ]; then
	error_message "Failed to upgrade current installed packages ... "
	exit 1;
fi

sudo apt-get dist-upgrade -y >> $log_file 2>&1

if [ $? != 0 ]; then
	error_message "Failed to upgrade current installed packages ... "
	exit 1;
fi

success_message " => Upgraded current installed packages ..."
echo ""

info_message " => Trying to install required packages ... "
echo ""

for package in "${packages[@]}"; do
	sudo apt-get install $package -y >> $log_file 2>&1
	if [ $? == 0 ];then
		success_message " ==> Installed package: "$package
	else
		error_message " ==> Failed to install package: "$package
		error_message " => Failed to install required packages ... "
		exit 1;
	fi

done

echo ""
success_message " => Installed required packages ... "
echo ""


for module in "${modules[@]}"; do
	info_message " => Trying to execute module: "$module
	source $location'/../src/modules/'$module'.sh'
	success_message " => Executed module: "$module
done

success_message " ==== DONE ==== "
