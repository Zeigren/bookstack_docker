#!/bin/sh

source /env_secrets_expand.sh

set -e

echoerr() { echo "$@" 1>&2; }

if [ ! -f "$BOOKSTACK_HOME/.env" ]; then
  if [[ -n "${DB_HOST}" ]]; then
  cat > "$BOOKSTACK_HOME/.env" <<EOF
# Application environment
# Can be 'production', 'development', 'testing' or 'demo'
APP_ENV=${APP_ENV:-production}

# Enable debug mode
# Shows advanced debug information and errors.
# CAN EXPOSE OTHER VARIABLES, LEAVE DISABLED
APP_DEBUG=${APP_DEBUG:-false}

# Application key
# Used for encryption where needed.
# Run `php artisan key:generate` to generate a valid key.
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
# Valid timezone values can be found here: https://www.php.net/manual/en/timezones.php
APP_TIMEZONE=${APP_TIMEZONE:-UTC}

# Application theme
# Used to specific a themes/<APP_THEME> folder where BookStack UI
# overrides can be made. Defaults to disabled.
APP_THEME=${APP_THEME:-false}

# Database details
# Host can contain a port (localhost:3306) or a separate DB_PORT option can be used.
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-3306}
DB_DATABASE=${DB_DATABASE:-bookstack}
DB_USERNAME=${DB_USERNAME:-bookstack}
DB_PASSWORD=${DB_PASSWORD:-password}

# Mail system to use
# Can be 'smtp', 'mail' or 'sendmail'
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
CACHE_DRIVER=${CACHE_DRIVER:-file}
SESSION_DRIVER=${SESSION_DRIVER:-file}

# Session configuration
SESSION_LIFETIME=${SESSION_LIFETIME:-120}
SESSION_COOKIE_NAME=${SESSION_COOKIE_NAME:-bookstack_session}
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
REDIS_SERVERS=${REDIS_SERVERS:-false}

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
# Refer to https://www.bookstackapp.com/docs/admin/third-party-auth/

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
# Refer to https://www.bookstackapp.com/docs/admin/ldap-auth/
LDAP_SERVER=${LDAP_SERVER:-false}
LDAP_BASE_DN=${LDAP_BASE_DN:-false}
LDAP_DN=${LDAP_DN:-false}
LDAP_PASS=${LDAP_PASS:-false}
LDAP_USER_FILTER=${LDAP_USER_FILTER:-false}
LDAP_VERSION=${LDAP_VERSION:-false}
LDAP_TLS_INSECURE=${LDAP_TLS_INSECURE:-false}
LDAP_ID_ATTRIBUTE=${LDAP_ID_ATTRIBUTE:-uid}
LDAP_EMAIL_ATTRIBUTE=${LDAP_EMAIL_ATTRIBUTE:-mail}
LDAP_DISPLAY_NAME_ATTRIBUTE=${LDAP_DISPLAY_NAME_ATTRIBUTE:-cn}
LDAP_FOLLOW_REFERRALS=${LDAP_FOLLOW_REFERRALS:-true}
LDAP_DUMP_USER_DETAILS=${LDAP_DUMP_USER_DETAILS:-false}

# LDAP group sync configuration
# Refer to https://www.bookstackapp.com/docs/admin/ldap-auth/
LDAP_USER_TO_GROUPS=${LDAP_USER_TO_GROUPS:-false}
LDAP_GROUP_ATTRIBUTE=${LDAP_GROUP_ATTRIBUTE:-"memberOf"}
LDAP_REMOVE_FROM_GROUPS=${LDAP_REMOVE_FROM_GROUPS:-false}

# SAML authentication configuration
# Refer to https://www.bookstackapp.com/docs/admin/saml2-auth/
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

# SAML group sync configuration
# Refer to https://www.bookstackapp.com/docs/admin/saml2-auth/
SAML2_USER_TO_GROUPS=${SAML2_USER_TO_GROUPS:-false}
SAML2_GROUP_ATTRIBUTE=${SAML2_GROUP_ATTRIBUTE:-group}
SAML2_REMOVE_FROM_GROUPS=${SAML2_REMOVE_FROM_GROUPS:-false}

# Disable default third-party services such as Gravatar and Draw.IO
# Service-specific options will override this option
DISABLE_EXTERNAL_SERVICES=${DISABLE_EXTERNAL_SERVICES:-false}

# Use custom avatar service, Sets fetch URL
# Possible placeholders: ${hash} ${size} ${email}
# If set, Avatars will be fetched regardless of DISABLE_EXTERNAL_SERVICES option.
# Example: AVATAR_URL=https://seccdn.libravatar.org/avatar/${hash}?s=${size}&d=identicon
AVATAR_URL=${AVATAR_URL:-}

# Enable Draw.io integration
DRAWIO=${DRAWIO:-true}

# Default item listing view
# Used for public visitors and user's without a preference
# Can be 'list' or 'grid'
APP_VIEWS_BOOKS=${APP_VIEWS_BOOKS:-list}
APP_VIEWS_BOOKSHELVES=${APP_VIEWS_BOOKSHELVES:-grid}

# Page revision limit
# Number of page revisions to keep in the system before deleting old revisions.
# If set to 'false' a limit will not be enforced.
REVISION_LIMIT=${REVISION_LIMIT:-50}

# Allow <script> tags in page content
# Note, if set to 'true' the page editor may still escape scripts.
ALLOW_CONTENT_SCRIPTS=${ALLOW_CONTENT_SCRIPTS:-false}

# Indicate if robots/crawlers should crawl your instance.
# Can be 'true', 'false' or 'null'.
# The behaviour of the default 'null' option will depend on the 'app-public' admin setting.
# Contents of the robots.txt file can be overridden, making this option obsolete.
ALLOW_ROBOTS=${ALLOW_ROBOTS:-null}

# The default and maximum item-counts for listing API requests.
API_DEFAULT_ITEM_COUNT=${API_DEFAULT_ITEM_COUNT:-100}
API_MAX_ITEM_COUNT=${API_MAX_ITEM_COUNT:-500}

# The number of API requests that can be made per minute by a single user.
API_REQUESTS_PER_MIN=${API_REQUESTS_PER_MIN:-180}
EOF

sed -ie "s/single/errorlog/g" app/Config/app.php
    else
        echo >&2 'error: missing DB_HOST environment variable'
        exit 1
    fi
fi

if [ ! -f "/usr/local/etc/php/php.ini" ]; then
  cat > "/usr/local/etc/php/php.ini" <<EOF
post_max_size = ${POST_MAX_SIZE:-0}
upload_max_filesize = ${UPLOAD_MAX_FILESIZE:-0}
memory_limit = ${MEMORY_LIMIT:-1028M}
expose_php = ${EXPOSE_PHP:-off}
cgi.fix_pathinfo = ${CGIFIX_PATHINFO:-0}
EOF
fi

if [ ! -e "/usr/local/etc/php/conf.d/opcache.ini" ]; then
  cat > "/usr/local/etc/php/conf.d/opcache.ini" <<EOF
opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION:-64}
opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES:-4000}
opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ:-60}
opcache.fast_shutdown=${OPCACHE_FAST_SHUTDOWN:-1}
opcache.enable_cli=${OPCACHE_ENABLE_CLI:-1}
opcache.validate_timestamps=${OPCACHE_VALIDATE_TIMESTAMPS:-0}
EOF
fi

# Set PHP-FPM conf
sed -i "s/pm =.*/pm = ${FPM_PM:-dynamic}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.max_children =.*/pm.max_children = ${FPM_MAX_CHILDREN:-5}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.start_servers =.*/pm.start_servers = ${FPM_START_SERVERS:-2}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.min_spare_servers =.*/pm.min_spare_servers = ${FPM_MIN_SPARE:-1}/" /usr/local/etc/php-fpm.d/www.conf
sed -i "s/pm.max_spare_servers =.*/pm.max_spare_servers = ${FPM_MAX_SPARE:-3}/" /usr/local/etc/php-fpm.d/www.conf

echo "Test connection to ${DB_HOST}"

/wait-for.sh ${DB_HOST} -- echo 'Success!'

echo "Give ${DB_HOST} a few seconds to warm up"

sleep 5s

composer install --no-dev

php artisan key:generate

php artisan migrate --force

if [[ $(stat -c '%u%g' ${BOOKSTACK_HOME}) != 8282 ]]; then
echo "Setting BookStack permissions"
chown -R www-data:www-data $BOOKSTACK_HOME
fi

if [[ $(stat -c '%u%g' public) != 8282 ]] ; then
echo "Setting folder permissions for public"
chown -R www-data:www-data public
fi

if [[ $(stat -c '%u%g' storage) != 8282 ]] ; then
echo "Setting folder permissions for storage"
chown -R www-data:www-data storage
fi

if [[ $(stat -c '%u%g%a' public/uploads) != 8282775 ]] ; then
echo "Setting folder permissions for public/uploads"
chown -R www-data:www-data public && chmod -R 775 public/uploads
fi

if [[ $(stat -c '%u%g%a' storage/uploads) != 8282775 ]] ; then
echo "Setting folder permissions for storage/uploads"
chown -R www-data:www-data storage && chmod -R 775 storage/uploads
fi

if [[ $(stat -c '%u%g%a' bootstrap/cache) != 8282775 ]] ; then
echo "Setting folder permissions for bootstrap/cache"
chown -R www-data:www-data bootstrap/cache && chmod -R 775 bootstrap/cache
fi

php artisan cache:clear

php artisan view:clear

exec "$@"
