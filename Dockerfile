FROM php:8.0-fpm-alpine

ARG DATE
ARG VERSION

LABEL org.opencontainers.image.created=$DATE \
    org.opencontainers.image.authors="Zeigren" \
    org.opencontainers.image.url="https://github.com/Zeigren/bookstack_docker" \
    org.opencontainers.image.source="https://github.com/Zeigren/bookstack_docker" \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.title="zeigren/bookstack"

ENV BOOKSTACK_HOME="/var/www/bookstack"

RUN apk update \
    && apk add --no-cache zip unzip fontconfig ttf-freefont wkhtmltopdf \
    openldap-dev \
    && apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS libpng-dev freetype-dev libjpeg-turbo-dev libwebp-dev \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-configure ldap \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install pdo_mysql gd ldap opcache \
    && cd /var/www && curl -sS https://getcomposer.org/installer | php \
    && mv /var/www/composer.phar /usr/local/bin/composer \
    && curl -sSL -o BookStack.tar.gz https://github.com/BookStackApp/BookStack/archive/$VERSION.tar.gz \
    && mkdir -p ${BOOKSTACK_HOME} ${BOOKSTACK_HOME}/tmp_public \
    && tar --strip-components=1 -C ${BOOKSTACK_HOME} -xf BookStack.tar.gz \
    && rm BookStack.tar.gz \
    && mv /usr/bin/wkhtmltopdf ${BOOKSTACK_HOME} \
    && cd $BOOKSTACK_HOME && composer install --no-dev \
    && mv $BOOKSTACK_HOME/public/* ${BOOKSTACK_HOME}/tmp_public \
    && chown -R www-data:www-data $BOOKSTACK_HOME /usr/local/etc/php-fpm.d /usr/local/etc/php \
    && apk del .build-deps \
    && rm -rf /root/.composer

COPY env_secrets_expand.sh docker-entrypoint.sh wait-for.sh /

RUN chmod +x /env_secrets_expand.sh /docker-entrypoint.sh /wait-for.sh

USER www-data

VOLUME /var/www/bookstack/storage /var/www/bookstack/public

WORKDIR $BOOKSTACK_HOME

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm", "-F"]
