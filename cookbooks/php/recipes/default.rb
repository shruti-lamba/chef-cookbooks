#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
remote_file '/opt/php-7.1.12.tar.gz' do
  source 'http://in1.php.net/get/php-7.1.12.tar.gz/from/this/mirror'
  owner 'root'
  group 'root'
  action :create_if_missing
end

package %w(build-essential autoconf bison libtool flex libbz2-dev curl libcurl4-gnutls-dev librtmp-dev libmcrypt-dev) do
  action :install
end

bash 'compile php' do
  code <<-EOH
    cd /opt
    tar -zxvf php-7.1.12.tar.gz
    cd php-7.1.12
    ./configure \
--prefix=/usr \
--with-config-file-path=/etc \
--enable-mbstring \
--enable-zip \
--enable-bcmath \
--enable-pcntl \
--enable-ftp \
--enable-exif \
--enable-calendar \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-wddx \
--with-curl \
--with-mcrypt \
--with-iconv \
--with-gmp \
--with-gd \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
--with-zlib-dir=/usr \
--with-xpm-dir=/usr \
--with-freetype-dir=/usr \
--enable-gd-native-ttf \
--enable-gd-jis-conv \
--with-openssl \
--with-gettext=/usr \
--with-zlib=/usr \
--with-bz2=/usr \
--with-recode=/usr
    make
    make install
 EOH
end
