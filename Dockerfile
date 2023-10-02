FROM php:8.2-apache

RUN cd /etc/apache2/mods-enabled \
    && ln -s ../mods-available/rewrite.load

# ミドルウェアインストール
RUN apt-get update \
    && apt-get install -y \
  nano vim wget \
  zip unzip \
  libzip-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libjpeg-dev \
  libpng-dev \
  libmcrypt-dev \
  libicu-dev \
  libpq-dev \
  cron \
  zlib1g-dev \
  libonig-dev \
  && docker-php-ext-install \
    pdo_mysql \
    mysqli \
    pdo \
    intl \
    zip \
    opcache

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
  && apt-get clean

RUN apt-get install -y imagemagick libmagickwand-dev \
  && pecl install imagick \
  && docker-php-ext-enable imagick

# Composer
RUN cd /usr/bin && curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer self-update --2

# Xdebug
RUN pecl install xdebug \
  && docker-php-ext-enable xdebug

# リライトモジュール
RUN a2enmod rewrite

# mysqldump
RUN apt install -y \
  default-mysql-client-core \
  default-mysql-client \
