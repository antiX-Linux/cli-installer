#!/bin/bash
#lib-exec
#This library is used for starting and running commands in common forms 
#and printing styled output / logs


echo_variable() {
	echo "$ME: Setting environment variable: $*"
	export "$@"
}

echo_cmd() {
    echo "$ME: run: $*"
    "$@"
}

echo_eval_cmd() {
    echo "$ME: run: eval $*"
    eval "$@" &
}

echo_bg_cmd() {
    echo "$ME: run: $* &"
    "$@" &
}

