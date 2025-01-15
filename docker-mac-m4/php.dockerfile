FROM php:8.1.12-fpm
# 安装必要的 php 依赖包
RUN apt-get update \
    && apt-get install -qq -y vim build-essential librabbitmq-dev libpng-dev libjpeg-dev libzip-dev\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## 安装composer
RUN cd /tmp && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
    apt clean && \
    rm -rf /tmp/*

# 安装 php 扩展
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install sockets
RUN pecl install redis && docker-php-ext-enable redis
RUN pecl install mongodb && docker-php-ext-enable mongodb
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install exif
RUN pecl install amqp-1.11.0 && docker-php-ext-enable amqp