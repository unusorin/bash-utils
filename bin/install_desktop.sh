#!/usr/bin/env bash

location="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $location'/../src/repositories.sh'
source $location'/../src/packages.sh'
source $location'/../src/colors.sh'
source $location'/../src/modules.sh'


declare log_file="install_desktop.log"
declare -a repositories=("${_desktop_repositories[@]}")
declare -a packages=("${_desktop_packages[@]}")
declare -a modules=("${_desktop_modules[@]}")


source $location'/../src/installer.sh'
