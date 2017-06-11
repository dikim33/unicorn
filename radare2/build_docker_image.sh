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
    echo "$0 <your_temporary_private_ssh_key>" 
    echo "It requires the your private ssh key (RSA) as an argument"
    echo
    echo "Make sure that your public ssh key (RSA) is already added to your github profile and"
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

cp $1 ssh_keys/id_rsa

docker build -t "$image_name" .


if [ $? -ne 0 ]; then
    echo
    echo "Oops!!!!"
    echo "It failed to build your docker image because you may have not provided a correct ssh key"
    echo
fi

# Remove the temporary ssh_keys here once the build is done.
rm -rf ssh_keys

exit 0;
