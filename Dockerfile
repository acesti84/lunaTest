FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install dialog
RUN apt-get -y install apt-utils
RUN apt-get --fix-missing update

# enable add-apt-repository command:
RUN apt-get -y install software-properties-common 

# The main PPA for supported PHP versions with many PECL extensions
RUN apt-get install -y language-pack-en-base && export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/apache2
RUN apt-get update
RUN apt-get -y install curl 
RUN apt-get -y install git  
RUN apt-get -y install vim  
RUN apt-get -y install apache2 

RUN apt-get -y install tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

#install php7.2 and dependecies
RUN apt-get -y install php7.2 
RUN apt-get -y install php7.2-common
RUN apt-get -y install php7.2-xml 
RUN apt-get -y install php7.2-mbstring 
RUN apt-get -y install php7.2-mysql 
RUN apt-get -y install php7.2-curl 
RUN apt-get -y install php7.2-json
RUN apt-get -y install php7.2-cli php7.2-common 
RUN apt-get -y install php7.2-gd 
RUN apt-get -y install php7.2-zip
RUN apt-get -y install php7.2-mysql
RUN apt-get -y install php-pear
RUN apt-get -y install libapache2-mod-php7.2

#install generic dependencies
RUN apt-get -y install supervisor
RUN apt-get -y install autoconf
RUN apt-get -y install openssl
RUN apt-get -y install mysql-client


#install dev packages
RUN apt-get -y install libpng-dev 
RUN apt-get -y install build-essential 
RUN apt-get -y install bzip2
RUN apt-get -y install php7.2-dev
RUN apt-get -y install libbz2-dev
RUN apt-get -y install libxml2-dev

#restart apache 
RUN service apache2 restart 
