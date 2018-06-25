FROM ubuntu:xenial

# install missing dependencies
RUN apt-get --fix-missing update
RUN apt-get -y install dialog apt-utils

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

# apache enable mod_rewrite
RUN a2enmod rewrite
RUN service apache2 restart

#setup apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN apt-get -y install autoconf
RUN chown -R www-data:www-data /var/www

#	to run composer as non root-user
USER www-data
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

# speedup composer: 
# 1 - setup https to speedup composer. see: https://debril.org/how-to-fix-composers-slowness.html
RUN php composer.phar config --global repo.packagist composer https://packagist.org 

# 2 - speed up composer with this library that do parallel downloads
RUN php composer.phar -vvv global require hirak/prestissimo

# fix and update
RUN php composer.phar self-update
