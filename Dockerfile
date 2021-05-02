FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.13

LABEL maintainer="Adam Beardwood"

RUN \
  apk add --update --no-cache \
    curl \
    composer \
    php7-gd \
    php7-dom \
    php7-xml \
    php7-ctype \
    php7-pdo \
    php7-pdo_mysql \
    php7-mysqli \
    php7-opcache \
    php7-pecl-apcu \
    php7-pecl-redis \
    php7-tokenizer && \
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