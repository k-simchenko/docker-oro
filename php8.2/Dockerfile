FROM php:8.2-fpm

RUN apt-get update && apt-get install default-mysql-client -y

RUN apt-get update && \
    requirements="git cron rsync vim libpng-dev libmcrypt-dev libmcrypt4 libcurl3-dev libfreetype6 libjpeg62-turbo libjpeg62-turbo-dev libpng-dev libfreetype6-dev libicu-dev libxslt1-dev libzip-dev  unzip libc-client-dev libkrb5-dev libonig-dev" && \
    apt-get install -y $requirements && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) pdo_mysql

RUN docker-php-ext-install -j$(nproc) mbstring
RUN docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install -j$(nproc) xsl
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-install -j$(nproc) bcmath
RUN docker-php-ext-install -j$(nproc) opcache
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install -j$(nproc) imap
RUN docker-php-ext-install -j$(nproc) sockets

RUN printf "\n\n\n" | pecl install redis && \
    docker-php-ext-enable redis

RUN pecl install xdebug
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && apt-get install ssmtp -y
RUN echo "sendmail_path = /usr/sbin/ssmtp -t" > /usr/local/etc/php/conf.d/sendmail.ini
RUN echo "mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd 
RUN docker-php-ext-install -j$(nproc) simplexml
RUN docker-php-ext-install -j$(nproc) xml

RUN \
    apt-get update && \
    apt-get install libldap2-dev -y

RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install -j$(nproc) pgsql
RUN docker-php-ext-install -j$(nproc) pdo_pgsql 

RUN docker-php-ext-configure pcntl --enable-pcntl \
  && docker-php-ext-install pcntl;

SHELL ["/bin/bash", "--login", "-c"]

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN nvm install v18.18.2
RUN nvm use v18.18.2
RUN ln -s /root/.nvm/versions/node/v18.18.2/bin/node /bin/nodejs
RUN ln -s /root/.nvm/versions/node/v18.18.2/bin/node /bin/node


RUN apt-get update && apt-get install openssh-server -y

COPY ./conf.d/* /usr/local/etc/php/conf.d/
COPY ./php-code/disable_xdebug.sh /
COPY ./php-code/enable_xdebug.sh /

RUN mkdir -p /root/.ssh/
COPY ./ssh/* /root/.ssh/
RUN chmod 700 /root/.ssh/
RUN chmod 600 -R /root/.ssh/authorized_keys

COPY ./zzz-docker.conf /usr/local/etc/php-fpm.d/zzz-docker.conf

CMD ["php-fpm", "-R"]

WORKDIR /code

RUN apt-get update; \
    apt-get install -y libmagickwand-dev; \
    pecl install imagick; \
    docker-php-ext-enable imagick;


RUN apt-get update; \
    apt-get install -y libnss3; \
    apt-get install -y libatk1.0-0; \
    apt-get install -y libatk-bridge2.0-0; \
    apt-get install -y libdrm-dev; \
    apt-get install -y libxkbcommon-x11-0; \
    apt-get install -y libxcomposite-dev; \
    apt-get install -y libxdamage1;