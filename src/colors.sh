#!/usr/bin/env bash
success_color='\e[1;32m'
info_color='\e[1;34m'
error_color='\e[1;31m'
end_color='\e[0m'

function error_message {
	echo -e $error_color$1$end_color
}

function success_message {
	echo -e $success_color$1$end_color	
}

function info_message {
	echo -e $info_color$1$end_color	
}