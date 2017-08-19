FROM php:5.6-fpm
MAINTAINER Jurel Patoc "patocjurel@gmail.com"

RUN apt-get update && apt-get upgrade -y

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

COPY nginx.list /etc/apt/sources.list.d/nginx.list

RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -

RUN apt-get update \
    && apt-get install nginx vim -y

COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.php /usr/share/nginx/html/index.php

CMD service nginx start

WORKDIR /home

EXPOSE 80