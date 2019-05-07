#!/bin/bash

source /env_secrets_expand.sh

set -e

echoerr() { echo "$@" 1>&2; }

# Split out host and port from DB_HOST env variable
IFS=":" read -r DB_HOST_NAME DB_PORT <<< "$DB_HOST"
DB_PORT=${DB_PORT:-3306}

if [ ! -f "$BOOKSTACK_HOME/.env" ]; then
  if [[ -n "${DB_HOST}" ]]; then
  cat > "$BOOKSTACK_HOME/.env" <<EOF
      # Environment
      APP_ENV=${APP_ENV:-production}
      APP_DEBUG=${APP_DEBUG:-false}
      APP_KEY=${APP_KEY:-SomeRandomStringWith32Characters}

      # The below url has to be set if using social auth options
      # or if you are not using BookStack at the root path of your domain.
      APP_URL=${APP_URL:-null}

      # Database details
      DB_HOST=${DB_HOST:-localhost}
      DB_DATABASE=${DB_DATABASE:-bookstack}
      DB_USERNAME=${DB_USERNAME:-bookstack}
      DB_PASSWORD=${DB_PASSWORD:-password}

      # Cache and session
      # Can be 'file', 'database', 'memcached' or 'redis'
      CACHE_DRIVER=${CACHE_DRIVER:-file}
      SESSION_DRIVER=${SESSION_DRIVER:-file}
      # Memcached server configuration
      # If using a UNIX socket path for the host, set the port to 0
      # This follows the following format: HOST:PORT:WEIGHT
      # For multiple servers separate with a comma
      MEMCACHED_SERVERS=${MEMCACHED_SERVERS:-false}
      # Redis server configuration
      # This follows the following format: HOST:PORT:DATABASE
      # or, if using a password: HOST:PORT:DATABASE:PASSWORD
      # For multiple servers separate with a comma. These will be clustered.
      REDIS_SERVERS=${REDIS_SERVERS:-false}
      # Queue driver to use
      # Queue not really currently used but may be configurable in the future.
      # Would advise not to change this for now.
      QUEUE_DRIVER=sync

      # Storage
      STORAGE_TYPE=${STORAGE_TYPE:-local}
      # Amazon S3 Config
      STORAGE_S3_KEY=${STORAGE_S3_KEY:-false}
      STORAGE_S3_SECRET=${STORAGE_S3_SECRET:-false}
      STORAGE_S3_REGION=${STORAGE_S3_REGION:-false}
      STORAGE_S3_BUCKET=${STORAGE_S3_BUCKET:-false}
      # S3 endpoint to use for storage calls
      # Only set this if using a non-Amazon s3-compatible service such as Minio
      STORAGE_S3_ENDPOINT=${STORAGE_S3_ENDPOINT:-false}
      # Storage URL
      # Used to prefix image urls for when using custom domains/cdns
      STORAGE_URL=${STORAGE_URL:-false}

      # General auth
      AUTH_METHOD=${AUTH_METHOD:-standard}

      # Social Authentication information. Defaults as off.
      GITHUB_APP_ID=${GITHUB_APP_ID:-false}
      GITHUB_APP_SECRET=${GITHUB_APP_SECRET:-false}
      GOOGLE_APP_ID=${GOOGLE_APP_ID:-false}
      GOOGLE_APP_SECRET=${GOOGLE_APP_SECRET:-false}

      # External services such as Gravatar
      DISABLE_EXTERNAL_SERVICES=${DISABLE_EXTERNAL_SERVICES:-false}

      # LDAP Settings
      LDAP_SERVER=${LDAP_SERVER:-false}
      LDAP_BASE_DN=${LDAP_BASE_DN:-false}
      LDAP_DN=${LDAP_DN:-false}
      LDAP_PASS=${LDAP_PASS:-false}
      LDAP_USER_FILTER=${LDAP_USER_FILTER:-false}
      LDAP_VERSION=${LDAP_VERSION:-false}

      # Mail settings
      MAIL_DRIVER=${MAIL_DRIVER:-smtp}
      MAIL_HOST=${MAIL_HOST:-localhost}
      MAIL_PORT=${MAIL_PORT:-1025}
      MAIL_USERNAME=${MAIL_USERNAME:-null}
      MAIL_PASSWORD=${MAIL_PASSWORD:-null}
      MAIL_ENCRYPTION=${MAIL_ENCRYPTION:-null}
      # URL used for social login redirects, NO TRAILING SLASH
EOF

sed -ie "s/single/errorlog/g" config/app.php
    else
        echo >&2 'error: missing DB_HOST environment variable'
        exit 1
    fi
fi

if [ ! -f "/usr/local/etc/php/php.ini" ]; then
  cat > "/usr/local/etc/php/php.ini" <<EOF
[PHP]
post_max_size = ${post_max_size:-0}
upload_max_filesize = ${upload_max_filesize:-0}
memory_limit = ${memory_limit:-1028M}
expose_php = ${expose_php:-off}
cgi.fix_pathinfo = ${cgifix_pathinfo:-0}
EOF
fi

echoerr "wait-for-db: waiting for ${DB_HOST_NAME}:${DB_PORT}"

timeout 15 bash <<EOT
while ! (echo > /dev/tcp/${DB_HOST_NAME}/${DB_PORT}) >/dev/null 2>&1;
    do sleep 1;
done;
EOT
RESULT=$?

if [ $RESULT -eq 0 ]; then
  # sleep another second for so that we don't get a "the database system is starting up" error
  sleep 1
  echoerr "wait-for-db: done"
else
  echoerr "wait-for-db: timeout out after 15 seconds waiting for ${DB_HOST_NAME}:${DB_PORT}"
fi

composer install

php artisan key:generate

php artisan migrate --force

echo "Setting folder permissions for uploads"
chown -R www-data:www-data public/uploads && chmod -R 775 public/uploads
chown -R www-data:www-data storage/uploads && chmod -R 775 storage/uploads

php artisan cache:clear

php artisan view:clear

exec "$@"