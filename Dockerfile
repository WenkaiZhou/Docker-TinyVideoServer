ARG ALPINE_VERSION=3.18
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="WenkaiZhou <zwenkai@foxmail.com>"
LABEL Description="Tiny video server container with Nginx 1.24 based on Alpine Linux."

# Ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# Install packages and remove default server definition
RUN apk --no-cache add \
  bash \
  curl \
  nginx \
  tzdata \
  supervisor

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Video server volume
VOLUME /var/www/html
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www

# Entrypoint to create file
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Make sure files/folders needed by the processes are accessable when they run under the www-data user
RUN chown -R www-data:www-data /var/www/html /run /var/lib/nginx /var/log/nginx

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf", "-u", "www-data"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=30s CMD curl --silent --fail http://127.0.0.1/