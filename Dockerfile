FROM nginx:1.23

VOLUME ["/etc/letsencrypt", "/var/www/certbot"]

COPY conf/nginx.conf.template     /etc/nginx/templates/default.conf.template
COPY conf/locations.conf.template /etc/nginx/templates/default.locations.template
COPY scripts/reload-timer.sh      /docker-entrypoint.d/99-reload-timer.sh
