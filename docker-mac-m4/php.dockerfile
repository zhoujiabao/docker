FROM php:8.1.0-fpm
# 安装必要的 php 依赖包
RUN apt-get update \
    && apt-get install -qq vim build-essential librabbitmq-dev -y libpng-dev libjpeg-dev -y libzip-dev\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## 安装composer
RUN cd /tmp && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
    apt clean && \
    rm -rf /tmp/* \

# 安装 php 扩展
RUN docker-php-ext-install pdo_mysql
RUN pecl install redis && docker-php-ext-enable redis

RUN pecl install amqp-2.1.0
RUN docker-php-ext-enable amqp

RUN pecl install mongodb && docker-php-ext-enable mongodb

# 安装 GD 扩展
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install exif