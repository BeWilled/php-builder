FROM php:7.1.9-alpine

MAINTAINER "Michel Behlok"

#Install libpq dependencies
RUN apk update
RUN apk add libjpeg-turbo-dev libpng-dev libpq git
#Install php dependencies
RUN docker-php-ext-configure gd --with-jpeg-dir=/usr --with-png-dir=/usr && docker-php-ext-install gd && docker-php-ext-install zip
#Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN composer global require hirak/prestissimo
