FROM ubuntu:xenial

RUN apt-get --fix-missing update
RUN apt-get -y install dialog apt-utils autoconf

# enable add-apt-repository command:
RUN apt-get -y install software-properties-common 

# The main PPA for supported PHP versions with many PECL extensions
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update

#install php7.1 and dependecies
RUN  apt-get -y install curl git vim apache2 libapache2-mod-php7.1  php7.1 php7.1-xml php7.1-mbstring php7.1-mysql php7.1-json php7.1-curl php7.1-cli php7.1-common php7.1-mcrypt php7.1-gd libapache2-mod-php7.1 php7.1-zip

# install node 8.x
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# build tools for native libraries
RUN echo "installing build essentials...\n"
RUN apt-get install -y build-essential
