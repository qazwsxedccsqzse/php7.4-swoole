FROM phusion/baseimage:focal-1.0.0alpha1-amd64
CMD ["/sbin/my_init"]
RUN apt-get update && apt-get install -y wget tar make libpcre3 libpcre3-dev openssl libssl-dev openssl libssl-dev supervisor
WORKDIR /root
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
apt-get update && \
apt-get install -y php7.4-cli \
php7.4-common \
php7.4 \
php7.4-mysql \
php7.4-fpm \
php7.4-curl \
php7.4-bz2 \
php7.4-json \
php7.4-cgi \
php7.4-mbstring \
php7.4-gd \
php-imagick \
php-memcache \
php-pear \
php7.4-xml \
php7.4-dev \
php7.4-bcmath \
php7.4-zip \
php7.4-dom && \
wget https://github.com/swoole/swoole-src/archive/v4.4.2.tar.gz && \
tar zxfv v4.4.2.tar.gz && rm -rf v4.4.2.tar.gz && \
cd /root/swoole-src-4.4.2 && \
phpize7.4 && ./configure \
--enable-openssl  \
--enable-http2  \
--enable-sockets \
--enable-mysqlnd && \
make clean && make install && \
echo "extension=swoole.so" >> /etc/php/7.4/cli/php.ini && \
cd /root && rm -rf swoole-src-4.4.2 && \
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');" && \
mv composer.phar /usr/local/bin/composer
