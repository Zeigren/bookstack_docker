FROM php:7.3-fpm

ENV BOOKSTACK=BookStack \
    BOOKSTACK_VERSION=0.27.5 \
    BOOKSTACK_HOME="/var/www/bookstack"

RUN apt-get update && apt-get install -y --no-install-recommends git libzip-dev zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev wget libldap2-dev libtidy-dev libxml2-dev fontconfig fonts-freefont-ttf wkhtmltopdf tar curl \
   && docker-php-ext-install dom pdo pdo_mysql zip tidy  \
   && docker-php-ext-configure ldap \
   && docker-php-ext-install ldap \
   && docker-php-ext-configure gd --with-freetype-dir=usr/include/ --with-jpeg-dir=/usr/include/ \
   && docker-php-ext-install gd \
   && cd /var/www && curl -sS https://getcomposer.org/installer | php \
   && mv /var/www/composer.phar /usr/local/bin/composer \
   && wget https://github.com/BookStackApp/BookStack/archive/v${BOOKSTACK_VERSION}.tar.gz -O ${BOOKSTACK}.tar.gz \
   && tar -xf ${BOOKSTACK}.tar.gz && mv BookStack-${BOOKSTACK_VERSION} ${BOOKSTACK_HOME} && rm ${BOOKSTACK}.tar.gz  \
   && cd $BOOKSTACK_HOME && composer install \
   && chown -R www-data:www-data $BOOKSTACK_HOME \
   && apt-get -y autoremove \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /var/tmp/*

COPY docker-entrypoint.sh /

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

COPY env_secrets_expand.sh /

RUN ["chmod", "+x", "/env_secrets_expand.sh"]

WORKDIR $BOOKSTACK_HOME

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm", "-F"]