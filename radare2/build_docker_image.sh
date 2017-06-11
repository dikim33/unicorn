#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo "Build a docker image with the Dockerfile in the current directory"

image_name="iuctf/radare2"

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo "$0 requires the your private ssh key as an argument"
    echo
    echo "Make sure that your public ssh key is already added to your github profile and"
    echo "the paired private ssh key is used here."
    echo "Probably temporary ssh key would be appropriate."
    echo
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!!!!! Please DO NOT use your high valuable ssh key. !!!!!"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo

    exit 1;
fi

docker images | grep $image_name > /dev/null
if [ $? -eq 0 ]; then
    echo
    echo "You already have a docker image, 'iuctf/radare2'."
    echo "This script is aborted now."
    echo
    exit 1;
fi

if [ ! -d ssh_keys ]; then
    mkdir ssh_keys
fi

cp $1 ssh_keys/

docker build -t "$image_name" .

exit 0;
