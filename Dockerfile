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
    $PHPIZE_DEPS libpng-dev freetype-dev libjpeg-turbo-dev \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-configure ldap \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install pdo_mysql gd ldap opcache \
    && cd /var/www && curl -sS https://getcomposer.org/installer | php \
    && mv /var/www/composer.phar /usr/local/bin/composer \
    && curl -sSL -o BookStack.tar.gz https://github.com/BookStackApp/BookStack/archive/v$VERSION.tar.gz \
    && mkdir -p ${BOOKSTACK_HOME} \
    && tar --strip-components=1 -C ${BOOKSTACK_HOME} -xf BookStack.tar.gz \
    && rm BookStack.tar.gz \
    && mv /usr/bin/wkhtmltopdf ${BOOKSTACK_HOME} \
    && cd $BOOKSTACK_HOME && composer install --no-dev \
    && chown -R www-data:www-data $BOOKSTACK_HOME \
    && apk del .build-deps \
    && rm -rf /root/.composer

COPY env_secrets_expand.sh docker-entrypoint.sh wait-for.sh /

RUN chmod +x /env_secrets_expand.sh \
    && chmod +x /docker-entrypoint.sh \
    && chmod +x /wait-for.sh

WORKDIR $BOOKSTACK_HOME

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm", "-F"]
