#!/usr/bin/env bash

location="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $location'/../src/repositories.sh'
source $location'/../src/packages.sh'
source $location'/../src/colors.sh'
source $location'/../src/modules.sh'


declare log_file="install_server.log"
declare -a repositories=("${_php_server_repositories[@]}")
declare -a packages=("${_php_server_packages[@]}")
declare -a modules=("${_php_server_modules[@]}")


source $location'/../src/installer.sh'
