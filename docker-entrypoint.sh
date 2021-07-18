#!/bin/sh

source /env_secrets_expand.sh

set -e

# BookStack Configuration
# https://www.bookstackapp.com/docs/
# https://github.com/BookStackApp/BookStack/blob/master/.env.example.complete
# -------------------------------------------------------------------------------

cat >"$BOOKSTACK_HOME/.env" <<EOF
# Application environment
# Can be 'production', 'development', 'testing' or 'demo'
APP_ENV=${APP_ENV:-production}

# Enable debug mode
# Shows advanced debug information and errors.
# CAN EXPOSE OTHER VARIABLES, LEAVE DISABLED
APP_DEBUG=${APP_DEBUG:-false}

# Application key
# Used for encryption where needed.
APP_KEY=${APP_KEY:-SomeRandomStringWith32Characters}

# Application URL
# This must be the root URL that you want to host BookStack on.
# All URL's in BookStack will be generated using this value.
APP_URL=${APP_URL:-null}

# Application default language
# The default language choice to show.
# May be overridden by user-preference or visitor browser settings.
APP_LANG=${APP_LANG:-en}

# Auto-detect language for public visitors.
# Uses browser-sent headers to infer a language.
# APP_LANG will be used if such a header is not provided.
APP_AUTO_LANG_PUBLIC=${APP_AUTO_LANG_PUBLIC:-true}

# Application timezone
# Used where dates are displayed such as on exported content.
APP_TIMEZONE=${APP_TIMEZONE:-UTC}

# Application theme
APP_THEME=${APP_THEME:-false}

# Database details
DB_HOST=${DB_HOST:-mariadb:3306}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-bookstack}
DB_USERNAME=${DB_USERNAME:-bookstack}
DB_PASSWORD=${DB_PASSWORD:-password}

# Mail system to use
# Can be 'smtp' or 'sendmail'
MAIL_DRIVER=${MAIL_DRIVER:-smtp}

# Mail sending options
MAIL_FROM=${MAIL_FROM:-null}
MAIL_FROM_NAME=${MAIL_FROM_NAME:-null}

# SMTP mail options
MAIL_HOST=${MAIL_HOST:-localhost}
MAIL_PORT=${MAIL_PORT:-1025}
MAIL_USERNAME=${MAIL_USERNAME:-null}
MAIL_PASSWORD=${MAIL_PASSWORD:-null}
MAIL_ENCRYPTION=${MAIL_ENCRYPTION:-null}

# Cache & Session driver to use
# Can be 'file', 'database', 'memcached' or 'redis'
CACHE_DRIVER=${CACHE_DRIVER:-redis}
SESSION_DRIVER=${SESSION_DRIVER:-redis}

# Session configuration
SESSION_LIFETIME=${SESSION_LIFETIME:-120}
SESSION_COOKIE_NAME=${SESSION_COOKIE_NAME:-bookstack_session}
SESSION_COOKIE_PATH=${SESSION_COOKIE_PATH:-/}
SESSION_SECURE_COOKIE=${SESSION_SECURE_COOKIE:-false}

# Cache key prefix
# Can be used to prevent conflicts multiple BookStack instances use the same store.
CACHE_PREFIX=${CACHE_PREFIX:-bookstack}

# Memcached server configuration
# If using a UNIX socket path for the host, set the port to 0
# This follows the following format: HOST:PORT:WEIGHT
# For multiple servers separate with a comma
MEMCACHED_SERVERS=${MEMCACHED_SERVERS:-false}

# Redis server configuration
# This follows the following format: HOST:PORT:DATABASE
# or, if using a password: HOST:PORT:DATABASE:PASSWORD
# For multiple servers separate with a comma. These will be clustered.
REDIS_SERVERS=${REDIS_SERVERS:-redis:6379:0}

# Queue driver to use
# Queue not really currently used but may be configurable in the future.
# Would advise not to change this for now.
QUEUE_CONNECTION=${QUEUE_CONNECTION:-sync}

# Storage system to use
# Can be 'local', 'local_secure' or 's3'
STORAGE_TYPE=${STORAGE_TYPE:-local}

# Image storage system to use
# Defaults to the value of STORAGE_TYPE if unset.
# Accepts the same values as STORAGE_TYPE.
STORAGE_IMAGE_TYPE=${STORAGE_IMAGE_TYPE:-local}

# Attachment storage system to use
# Defaults to the value of STORAGE_TYPE if unset.
# Accepts the same values as STORAGE_TYPE although 'local' will be forced to 'local_secure'.
STORAGE_ATTACHMENT_TYPE=${STORAGE_ATTACHMENT_TYPE:-local_secure}

# Amazon S3 storage configuration
STORAGE_S3_KEY=${STORAGE_S3_KEY:-false}
STORAGE_S3_SECRET=${STORAGE_S3_SECRET:-false}
STORAGE_S3_BUCKET=${STORAGE_S3_BUCKET:-false}
STORAGE_S3_REGION=${STORAGE_S3_REGION:-false}

# S3 endpoint to use for storage calls
# Only set this if using a non-Amazon s3-compatible service such as Minio
STORAGE_S3_ENDPOINT=${STORAGE_S3_ENDPOINT:-false}

# Storage URL prefix
# Used as a base for any generated image urls.
# An s3-format URL will be generated if not set.
STORAGE_URL=${STORAGE_URL:-false}

# Authentication method to use
# Can be 'standard', 'ldap' or 'saml2'
AUTH_METHOD=${AUTH_METHOD:-standard}

# Social authentication configuration
# All disabled by default.

AZURE_APP_ID=${AZURE_APP_ID:-false}
AZURE_APP_SECRET=${AZURE_APP_SECRET:-false}
AZURE_TENANT=${AZURE_TENANT:-false}
AZURE_AUTO_REGISTER=${AZURE_AUTO_REGISTER:-false}
AZURE_AUTO_CONFIRM_EMAIL=${AZURE_AUTO_CONFIRM_EMAIL:-false}

DISCORD_APP_ID=${DISCORD_APP_ID:-false}
DISCORD_APP_SECRET=${DISCORD_APP_SECRET:-false}
DISCORD_AUTO_REGISTER=${DISCORD_AUTO_REGISTER:-false}
DISCORD_AUTO_CONFIRM_EMAIL=${DISCORD_AUTO_CONFIRM_EMAIL:-false}

FACEBOOK_APP_ID=${FACEBOOK_APP_ID:-false}
FACEBOOK_APP_SECRET=${FACEBOOK_APP_SECRET:-false}
FACEBOOK_AUTO_REGISTER=${FACEBOOK_AUTO_REGISTER:-false}
FACEBOOK_AUTO_CONFIRM_EMAIL=${FACEBOOK_AUTO_CONFIRM_EMAIL:-false}

GITHUB_APP_ID=${GITHUB_APP_ID:-false}
GITHUB_APP_SECRET=${GITHUB_APP_SECRET:-false}
GITHUB_AUTO_REGISTER=${GITHUB_AUTO_REGISTER:-false}
GITHUB_AUTO_CONFIRM_EMAIL=${GITHUB_AUTO_CONFIRM_EMAIL:-false}

GITLAB_APP_ID=${GITLAB_APP_ID:-false}
GITLAB_APP_SECRET=${GITLAB_APP_SECRET:-false}
GITLAB_BASE_URI=${GITLAB_BASE_URI:-false}
GITLAB_AUTO_REGISTER=${GITLAB_AUTO_REGISTER:-false}
GITLAB_AUTO_CONFIRM_EMAIL=${GITLAB_AUTO_CONFIRM_EMAIL:-false}

GOOGLE_APP_ID=${GOOGLE_APP_ID:-false}
GOOGLE_APP_SECRET=${GOOGLE_APP_SECRET:-false}
GOOGLE_SELECT_ACCOUNT=${GOOGLE_SELECT_ACCOUNT:-false}
GOOGLE_AUTO_REGISTER=${GOOGLE_AUTO_REGISTER:-false}
GOOGLE_AUTO_CONFIRM_EMAIL=${GOOGLE_AUTO_CONFIRM_EMAIL:-false}

OKTA_BASE_URL=${OKTA_BASE_URL:-false}
OKTA_APP_ID=${OKTA_APP_ID:-false}
OKTA_APP_SECRET=${OKTA_APP_SECRET:-false}
OKTA_AUTO_REGISTER=${OKTA_AUTO_REGISTER:-false}
OKTA_AUTO_CONFIRM_EMAIL=${OKTA_AUTO_CONFIRM_EMAIL:-false}

SLACK_APP_ID=${SLACK_APP_ID:-false}
SLACK_APP_SECRET=${SLACK_APP_SECRET:-false}
SLACK_AUTO_REGISTER=${SLACK_AUTO_REGISTER:-false}
SLACK_AUTO_CONFIRM_EMAIL=${SLACK_AUTO_CONFIRM_EMAIL:-false}

TWITCH_APP_ID=${TWITCH_APP_ID:-false}
TWITCH_APP_SECRET=${TWITCH_APP_SECRET:-false}
TWITCH_AUTO_REGISTER=${TWITCH_AUTO_REGISTER:-false}
TWITCH_AUTO_CONFIRM_EMAIL=${TWITCH_AUTO_CONFIRM_EMAIL:-false}

TWITTER_APP_ID=${TWITTER_APP_ID:-false}
TWITTER_APP_SECRET=${TWITTER_APP_SECRET:-false}
TWITTER_AUTO_REGISTER=${TWITTER_AUTO_REGISTER:-false}
TWITTER_AUTO_CONFIRM_EMAIL=${TWITTER_AUTO_CONFIRM_EMAIL:-false}

# LDAP authentication configuration
LDAP_SERVER=${LDAP_SERVER:-false}
LDAP_BASE_DN=${LDAP_BASE_DN:-false}
LDAP_DN=${LDAP_DN:-false}
LDAP_PASS=${LDAP_PASS:-false}
LDAP_USER_FILTER=${LDAP_USER_FILTER:-false}
LDAP_VERSION=${LDAP_VERSION:-false}
LDAP_START_TLS=${LDAP_START_TLS:-false}
LDAP_TLS_INSECURE=${LDAP_TLS_INSECURE:-false}
LDAP_ID_ATTRIBUTE=${LDAP_ID_ATTRIBUTE:-uid}
LDAP_EMAIL_ATTRIBUTE=${LDAP_EMAIL_ATTRIBUTE:-mail}
LDAP_DISPLAY_NAME_ATTRIBUTE=${LDAP_DISPLAY_NAME_ATTRIBUTE:-cn}
LDAP_THUMBNAIL_ATTRIBUTE=${LDAP_THUMBNAIL_ATTRIBUTE:-null}
LDAP_FOLLOW_REFERRALS=${LDAP_FOLLOW_REFERRALS:-true}
LDAP_DUMP_USER_DETAILS=${LDAP_DUMP_USER_DETAILS:-false}

# LDAP group sync configuration
LDAP_USER_TO_GROUPS=${LDAP_USER_TO_GROUPS:-false}
LDAP_GROUP_ATTRIBUTE=${LDAP_GROUP_ATTRIBUTE:-"memberOf"}
LDAP_REMOVE_FROM_GROUPS=${LDAP_REMOVE_FROM_GROUPS:-false}

# SAML authentication configuration
SAML2_NAME=${SAML2_NAME:-SSO}
SAML2_EMAIL_ATTRIBUTE=${SAML2_EMAIL_ATTRIBUTE:-email}
SAML2_DISPLAY_NAME_ATTRIBUTES=${SAML2_DISPLAY_NAME_ATTRIBUTES:-username}
SAML2_EXTERNAL_ID_ATTRIBUTE=${SAML2_EXTERNAL_ID_ATTRIBUTE:-null}
SAML2_IDP_ENTITYID=${SAML2_IDP_ENTITYID:-null}
SAML2_IDP_SSO=${SAML2_IDP_SSO:-null}
SAML2_IDP_SLO=${SAML2_IDP_SLO:-null}
SAML2_IDP_x509=${SAML2_IDP_x509:-null}
SAML2_ONELOGIN_OVERRIDES=${SAML2_ONELOGIN_OVERRIDES:-null}
SAML2_DUMP_USER_DETAILS=${SAML2_DUMP_USER_DETAILS:-false}
SAML2_AUTOLOAD_METADATA=${SAML2_AUTOLOAD_METADATA:-false}
SAML2_IDP_AUTHNCONTEXT=${SAML2_IDP_AUTHNCONTEXT:-true}

# SAML group sync configuration
SAML2_USER_TO_GROUPS=${SAML2_USER_TO_GROUPS:-false}
SAML2_GROUP_ATTRIBUTE=${SAML2_GROUP_ATTRIBUTE:-group}
SAML2_REMOVE_FROM_GROUPS=${SAML2_REMOVE_FROM_GROUPS:-false}

# Disable default third-party services such as Gravatar and Draw.IO
# Service-specific options will override this option
DISABLE_EXTERNAL_SERVICES=${DISABLE_EXTERNAL_SERVICES:-false}

# Use custom avatar service, Sets fetch URL
# Possible placeholders: ${hash} ${size} ${email}
# If set, Avatars will be fetched regardless of DISABLE_EXTERNAL_SERVICES option.
AVATAR_URL=${AVATAR_URL:-}

# Enable diagrams.net integration
# Can simply be true/false to enable/disable the integration.
# Alternatively, It can be URL to the diagrams.net instance you want to use.
# For URLs, The following URL parameters should be included: embed=1&proto=json&spin=1
DRAWIO=${DRAWIO:-true}

# Default item listing view
# Used for public visitors and user's without a preference
# Can be 'list' or 'grid'
APP_VIEWS_BOOKS=${APP_VIEWS_BOOKS:-list}
APP_VIEWS_BOOKSHELVES=${APP_VIEWS_BOOKSHELVES:-grid}
APP_VIEWS_BOOKSHELF=${APP_VIEWS_BOOKSHELF:-grid}

# Use dark mode by default
# Will be overriden by any user/session preference.
APP_DEFAULT_DARK_MODE=${APP_DEFAULT_DARK_MODE:-false}

# Page revision limit
# Number of page revisions to keep in the system before deleting old revisions.
# If set to 'false' a limit will not be enforced.
REVISION_LIMIT=${REVISION_LIMIT:-50}

# Recycle Bin Lifetime
# The number of days that content will remain in the recycle bin before
# being considered for auto-removal. It is not a guarantee that content will
# be removed after this time.
# Set to 0 for no recycle bin functionality.
# Set to -1 for unlimited recycle bin lifetime.
RECYCLE_BIN_LIFETIME=${RECYCLE_BIN_LIFETIME:-30}

# Allow <script> tags in page content
# Note, if set to 'true' the page editor may still escape scripts.
ALLOW_CONTENT_SCRIPTS=${ALLOW_CONTENT_SCRIPTS:-false}

# Indicate if robots/crawlers should crawl your instance.
# Can be 'true', 'false' or 'null'.
# The behaviour of the default 'null' option will depend on the 'app-public' admin setting.
# Contents of the robots.txt file can be overridden, making this option obsolete.
ALLOW_ROBOTS=${ALLOW_ROBOTS:-null}

# A list of hosts that BookStack can be iframed within.
# Space separated if multiple. BookStack host domain is auto-inferred.
# For Example: ALLOWED_IFRAME_HOSTS="https://example.com https://a.example.com"
# Setting this option will also auto-adjust cookies to be SameSite=None.
ALLOWED_IFRAME_HOSTS=${ALLOWED_IFRAME_HOSTS:-null}

# The default and maximum item-counts for listing API requests.
API_DEFAULT_ITEM_COUNT=${API_DEFAULT_ITEM_COUNT:-100}
API_MAX_ITEM_COUNT=${API_MAX_ITEM_COUNT:-500}

# The number of API requests that can be made per minute by a single user.
API_REQUESTS_PER_MIN=${API_REQUESTS_PER_MIN:-180}

# Enable the logging of failed email+password logins with the given message.
# The default log channel below uses the php 'error_log' function which commonly
# results in messages being output to the webserver error logs.
# The message can contain a %u parameter which will be replaced with the login
# user identifier (Username or email).
LOG_FAILED_LOGIN_MESSAGE=${LOG_FAILED_LOGIN_MESSAGE:-false}
LOG_FAILED_LOGIN_CHANNEL=${LOG_FAILED_LOGIN_CHANNEL:-errorlog_plain_webserver}
EOF

# PHP Configuration
# -------------------------------------------------------------------------------

# https://github.com/php/php-src/blob/master/php.ini-production
# https://www.php.net/manual/en/ini.list.php
cat >"/usr/local/etc/php/php.ini" <<EOF
post_max_size = ${POST_MAX_SIZE:-0}
upload_max_filesize = ${UPLOAD_MAX_FILESIZE:-0}
memory_limit = ${MEMORY_LIMIT:-1024M}
expose_php = ${EXPOSE_PHP:-off}
opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION:-128}
opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES:-10000}
opcache.enable_cli=${OPCACHE_ENABLE_CLI:-1}
opcache.validate_timestamps=${OPCACHE_VALIDATE_TIMESTAMPS:-0}
EOF

# https://www.php.net/manual/en/install.fpm.configuration.php
sed -i "s/pm =.*/pm = ${FPM_PM:-ondemand}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.max_children =.*/pm.max_children = ${FPM_MAX_CHILDREN:-10}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.start_servers =.*/pm.start_servers = ${FPM_START_SERVERS:-3}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.min_spare_servers =.*/pm.min_spare_servers = ${FPM_MIN_SPARE_SERVERS:-1}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.max_spare_servers =.*/pm.max_spare_servers = ${FPM_MAX_SPARE_SERVERS:-2}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/;pm.max_requests =.*/pm.max_requests = ${FPM_MAX_REQUESTS:-500}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/;pm.process_idle_timeout =.*/pm.process_idle_timeout = ${FPM_PROCESS_IDLE_TIMEOUT:-10s}/" /usr/local/etc/php-fpm.d/www.conf

# -------------------------------------------------------------------------------

echo "Test connection to ${DB_HOST}"

/wait-for.sh ${DB_HOST} -- echo 'Success!'

echo "Give ${DB_HOST} a few seconds to warm up"

sleep 5s

export BOOKSTACK_VERSION="$(grep -Eo '[0-9.]+' ${BOOKSTACK_HOME}/version)"
mkdir -p /var/www/tmp
curl -sSL -o /var/www/BookStack.tar.gz https://github.com/BookStackApp/BookStack/archive/v${BOOKSTACK_VERSION}.tar.gz
tar --strip-components=1 -C /var/www/tmp -xf /var/www/BookStack.tar.gz
cp -rf /var/www/tmp/public ${BOOKSTACK_HOME}
rm /var/www/BookStack.tar.gz
rm -rf /var/www/tmp

if [[ $(stat -c '%u%g' ${BOOKSTACK_HOME}) != 8282 ]]; then
  echo "Setting BookStack permissions"
  chown -R www-data:www-data $BOOKSTACK_HOME
fi

if [[ $(stat -c '%u%g' public) != 8282 ]]; then
  echo "Setting folder permissions for public"
  chown -R www-data:www-data public
fi

if [[ $(stat -c '%u%g' storage) != 8282 ]]; then
  echo "Setting folder permissions for storage"
  chown -R www-data:www-data storage
fi

if [[ $(stat -c '%u%g%a' public/uploads) != 8282775 ]]; then
  echo "Setting folder permissions for public/uploads"
  chown -R www-data:www-data public && chmod -R 775 public/uploads
fi

if [[ $(stat -c '%u%g%a' storage/uploads) != 8282775 ]]; then
  echo "Setting folder permissions for storage/uploads"
  chown -R www-data:www-data storage && chmod -R 775 storage/uploads
fi

if [[ $(stat -c '%u%g%a' bootstrap/cache) != 8282775 ]]; then
  echo "Setting folder permissions for bootstrap/cache"
  chown -R www-data:www-data bootstrap/cache && chmod -R 775 bootstrap/cache
fi

php artisan key:generate --force

php artisan migrate --force

php artisan cache:clear

php artisan view:clear

exec "$@"
