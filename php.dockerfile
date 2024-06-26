FROM php:8.1.0-fpm
# 安装必要的 php 依赖包
RUN apt-get update \
    && apt-get install -qq vim

## 安装composer
RUN cd /tmp && \  
    curl -sS https://getcomposer.org/installer | php && \  
    mv composer.phar /usr/local/bin/composer && \  
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \  
    apt clean && \  
    rm -rf /tmp/*

# 安装 php 扩展
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-enable redis