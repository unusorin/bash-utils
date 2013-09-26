
#!/usr/bin/env bash

echo "Installing PHP Build dependencies ... "
echo "----------------------------------"

export PACKAGES="abuild-essential apache2-threaded-dev apache2-mpm-prefork apache2-prefork-dev libcurl4-openssl-dev"
export PACKAGES="$PACKAGES libsqlite3-dev sqlite3 mysql-server libmysqlclient-dev libreadline-dev libzip-dev libxslt1-dev"
export PACKAGES="$PACKAGES libicu-dev libmcrypt-dev libmhash-dev libpcre3-dev libjpeg-dev libpng12-dev libfreetype6-dev libbz2-dev libxpm-dev" 
export PACKAGES="$PACKAGES libxml2-dev libpcre3-dev libbz2-dev libcurl4-openssl-dev libdb4.8-dev libjpeg-dev libpng12-dev libxpm-dev libfreetype6-dev"
export PACKAGES="$PACKAGES libmysqlclient-dev postgresql-server-dev-9.1 libt1-dev libgd2-xpm-dev libgmp-dev libsasl2-dev libmhash-dev unixodbc-dev freetds-dev"
export PACKAGES="$PACKAGES libpspell-dev libsnmp-dev libtidy-dev libxslt1-dev libmcrypt-dev build-dep php5 nano build-essential checkinstall zip"

sudo apt-get install $PACKAGES -y --force-yes

echo ""
echo "Check the following links for reference ..."
echo "----------------------------------"
echo "* http://gediminasm.org/post/compile-php"
echo "* http://zgadzaj.com/how-to-install-php-53-and-52-together-on-ubuntu-1204"
echo "----------------------------------"
echo ""


echo ""
echo "Compiling PHP ..."
echo "---------------------------------"

# current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

# requires a php source directory as a first argument
if [ ! -d "$1" ]
then
    echo "Php source is not a valid directory"
    exit 1
fi

# Ubuntu users only, a quirk to locate libpcre
if [ ! -f "/usr/lib/libpcre.a" ]; then
    if [ -f "/usr/lib/i386-linux-gnu/libpcre.a" ]; then
        sudo ln -s /usr/lib/i386-linux-gnu/libpcre.a /usr/lib/libpcre.a
    elif [ -f "/usr/lib/x86_64-linux-gnu/libpcre.a" ]; then
        sudo ln -s /usr/lib/x86_64-linux-gnu/libpcre.a /usr/lib/libpcre.a
    fi
fi

# define full path to php sources
SRC="$DIR/$1"

# Here follows paths for installation binaries and general settings
PREFIX="/opt/php" # will install binaries in ~/php/bin directory, make sure it is exported in your $PATH for executables
SBIN_DIR="/opt/php" # all binaries will go to ~/php/bin
CONF_DIR="/opt/php" # will use php.ini located here as ~/php/php.ini
CONFD_DIR="/opt/php/conf.d" # will load all extra configuration files from ~/php/conf.d directory
MAN_DIR="/opt/php/share/man" # man pages goes here

EXTENSION_DIR="/opt/php/share/modules" # all shared modules will be installed in ~/php/share/modules phpize binary will configure it accordingly
export EXTENSION_DIR
PEAR_INSTALLDIR="/opt/php/share/pear" # pear package directory
export PEAR_INSTALLDIR

if [ ! -d "$CONFD_DIR" ]; then
    mkdir -p $CONFD_DIR
fi

# here follows a main configuration script
PHP_CONF="--config-cache \
    --prefix=$PREFIX \
    --sbindir=$SBIN_DIR \
    --sysconfdir=$CONF_DIR \
    --localstatedir=/var \
    --with-layout=GNU \
    --with-config-file-path=$CONF_DIR \
    --with-config-file-scan-dir=$CONFD_DIR \
    --disable-rpath \
    --mandir=$MAN_DIR \
"

# enter source directory
cd $SRC

# build configure, not included in git versions
if [ ! -f "$SRC/configure" ]; then
    ./buildconf --force
fi

# Additionally you can add these, if they are needed:
#   --enable-ftp
#   --enable-exif
#   --enable-calendar
#   --with-snmp=/usr
#   --with-pspell
#   --with-tidy=/usr
#   --with-xmlrpc
#   --with-xsl=/usr
# and any other, run "./configure --help" inside php sources

# define extension configuration
EXT_CONF="--enable-mbstring \
    --enable-mbregex \
    --enable-phar \
    --enable-posix \
    --enable-soap \
    --enable-sockets \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-zip \
    --enable-inline-optimization \
    --enable-intl \
    --enable-debug \
    --enable-maintainer-zts \
    --with-icu-dir=/usr \
    --with-curl=/usr/bin \
    --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=shared,/usr \
    --with-xpm-dir=/usr \
    --with-freetype-dir=/usr \
    --with-bz2=/usr \
    --with-gettext \
    --with-iconv-dir=/usr \
    --with-mcrypt=/usr \
    --with-mhash \
    --with-zlib-dir=/usr \
    --with-regex=php \
    --with-pcre-regex=/usr \
    --with-openssl \
    --with-openssl-dir=/usr/bin \
    --with-mysql-sock=/var/run/mysqld/mysqld.sock \
    --with-mysqli=mysqlnd \
    --with-sqlite3=/usr \
    --with-pdo-mysql=mysqlnd \
    --with-pdo-sqlite=/usr
"

# adapt fpm user and group if different wanted
PHP_FPM_CONF="--enable-fpm \
    --with-fpm-user=www-data \
    --with-fpm-group=www-data
"

# CLI, php-fpm and apache2 module
./configure $PHP_CONF \
    --disable-cgi \
    --with-readline \
    --enable-pcntl \
    --enable-cli \
    --with-apxs2=/usr/bin/apxs2 \
    --with-pear \
    $PHP_FPM_CONF \
    $EXT_CONF

# CGI and FastCGI
#./configure $PHP_CONF --disable-cli --enable-cgi $EXT_CONF

# build sources
make
sudo checkinstall -D make install