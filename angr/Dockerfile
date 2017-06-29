FROM ubuntu:16.04

## Helpful commands
# >> Build the docker container
# docker build -t retriforce .
# >> Run the docker container, mapping a directory into the container
# docker run --rm -it -v "<HOST_SHARE>:<GUEST_DIR>" retriforce

MAINTAINER DongInn Kim "dikim@indiana.edu"

RUN /bin/bash -l -c "mkdir /root/.ssh"
ADD ssh_keys/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config 

## Tunables
ENV UNICORNVER  1.0.1
#ENV CAPSTONEVER 3.0.4
ENV CAPSTONEVER next
ENV KEYSTONEVER 0.9.1

## Checkout new versions if you're interested:
# http://www.unicorn-engine.org/download/
# http://www.capstone-engine.org/download.html
# http://www.keystone-engine.org/download/

## Prepare dependencies
RUN apt-get update -y 
RUN apt-get install -y python-dev libglib2.0-dev wget less vim sed cmake time python-pip
RUN apt-get install -y lib32stdc++-4.8-dev libc6-dev-i386
RUN apt-get install -y binwalk
RUN apt-get install -y git unzip
RUN pip install --upgrade pip

###########################################################
## Install the Unicorn Engine
# Get the Unicorn-Engine sources
WORKDIR /usr/src
RUN wget https://github.com/unicorn-engine/unicorn/archive/$UNICORNVER.tar.gz && tar -xzf $UNICORNVER.tar.gz

# Build the Unicorn-Engine
WORKDIR /usr/src/unicorn-$UNICORNVER
RUN ./make.sh && ./make.sh install

# Build the Python bindings
WORKDIR /usr/src/unicorn-$UNICORNVER/bindings/python
RUN make install

###########################################################
## Install the Captsone Engine
# Get the Capstone-Engine sources
WORKDIR /usr/src
RUN wget https://github.com/aquynh/capstone/archive/$CAPSTONEVER.tar.gz && tar -xzf $CAPSTONEVER.tar.gz

# Build the Unicorn-Engine
WORKDIR /usr/src/capstone-$CAPSTONEVER
RUN ./make.sh && ./make.sh install

# Build the Python bindings
WORKDIR /usr/src/capstone-$CAPSTONEVER/bindings/python
RUN make install

###########################################################
## Install the Keystone Engine
# Get the Keystone-Engine sources
WORKDIR /usr/src
RUN wget https://github.com/keystone-engine/keystone/archive/$KEYSTONEVER.tar.gz && tar -xzf $KEYSTONEVER.tar.gz

# Build the Keystone-Engine
WORKDIR /usr/src/keystone-$KEYSTONEVER
RUN mkdir build
WORKDIR /usr/src/keystone-$KEYSTONEVER/build
RUN ../make-share.sh
RUN make install

# Build the Python bindings
WORKDIR /usr/src/keystone-$KEYSTONEVER/bindings/python
RUN make install

# Very important for Ubuntu! Otherwise keystone python scripts will not run
RUN sed  -i '1i /usr/local/lib/' /etc/ld.so.conf
RUN ldconfig


###########################################################
## Install the Radare2
# Get the Radare2 sources
WORKDIR /usr/src
RUN git clone git@github.com:radare/radare2.git
WORKDIR /usr/src/radare2
RUN ./configure
RUN make
RUN make install

###########################################################
# Cleanup
RUN rm -rf /usr/src/*

WORKDIR /root
RUN git clone https://github.com/dikim33/unicorn.git uck
RUN chmod +x uck/challenge.py

###########################################################
## Install angr
run apt-get install -y virtualenvwrapper python-pip python2.7-dev build-essential libxml2-dev libxslt1-dev git libffi-dev cmake libreadline-dev libtool debootstrap debian-archive-keyring  libpixman-1-dev libqt4-dev graphviz-dev binutils-multiarch nasm 

run useradd -s /bin/bash -m angr

run git clone git@github.com:angr/angr-doc.git /home/angr/angr-doc
run chown -R angr /home/angr/angr-doc
run su - angr -c "pip install virtualenv virtualenvwrapper"
run su - angr -c "mkdir virt_env; cd virt_env; virtualenv angr; cd angr; source bin/activate; pip install angr"
run su - angr -c "echo 'source virt_env/angr/bin/activate' >> /home/angr/.bashrc"
cmd su - angr

