FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive TZ=UTC

RUN apt-get update && apt-get install -y \
    nginx software-properties-common curl unzip supervisor \
    && add-apt-repository ppa:ondrej/php -y \
    && apt-get update \
    && apt-get install -y php8.3-fpm php8.3-cli php8.3-common php8.3-zip php8.3-mbstring php8.3-curl php8.3-gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /sites /var/log/nginx /var/log/php-fpm /etc/traefik/dynamic/sites \
    && chown -R www-data:www-data /sites

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d/ /etc/nginx/conf.d/
COPY nginx/snippets/ /etc/nginx/snippets/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]
