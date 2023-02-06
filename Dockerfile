FROM nginx:1.23

VOLUME ["/etc/letsencrypt", "/var/www/certbot"]

COPY conf/default.conf.template      /etc/nginx/templates/default.conf.template
COPY conf/default.locations.template /etc/nginx/templates/default.locations.template
COPY scripts/reload-timer.sh         /docker-entrypoint.d/99-reload-timer.sh
