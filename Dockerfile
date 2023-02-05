FROM nginx:1.23

VOLUME ["/etc/letsencrypt", "/var/www/certbot"]

COPY conf/nginx.conf                 /etc/nginx/templates/default.conf.template
COPY conf/nginx.https.locations.conf /etc/nginx/locations/default.conf
COPY scripts/reload-timer.sh         /docker-entrypoint.d/99-reload-timer.sh
