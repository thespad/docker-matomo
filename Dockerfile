FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.15-php8

LABEL maintainer="Adam Beardwood"

RUN \
  apk add --update --no-cache \
    curl \
    composer \
    php8-gd \
    php8-dom \
    php8-xml \
    php8-ctype \
    php8-pdo \
    php8-pdo_mysql \
    php8-mysqli \
    php8-opcache \
    php8-pecl-apcu \
    php8-pecl-redis \
    php8-tokenizer && \
  echo "**** install matomo ****" && \
  mkdir -p /app/matomo && \
  if [ -z ${MATOMO_RELEASE+x} ]; then \
    MATOMO_RELEASE=$(curl -sX GET "https://api.github.com/repos/matomo-org/matomo/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -s -o \
    /tmp/matomo.tar.gz -L \
    "https://builds.matomo.org/matomo-${MATOMO_RELEASE}.tar.gz" && \
  tar xf \
    /tmp/matomo.tar.gz -C \
    /app/matomo/ --strip-components=1 && \
  rm /tmp/matomo.tar.gz 

COPY root/ /

EXPOSE 80

VOLUME /config