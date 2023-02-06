[this docker image](https://hub.docker.com/repository/docker/coreycothrum/nginx) is meant to be used in conjunction with [coreycothrum/certbot_docker](https://github.com/coreycothrum/certbot_docker)

**see [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) as an example**

### what this image is
an extention of the official [nginx docker image](https://hub.docker.com/_/nginx) to make integration with [certbot](https://certbot.eff.org/) easier. Key features:
* `nginx -s reload` runs periodically to pull in updated certificates
* example nginx `*.conf` setup for use with certbot
* out-of-the-box ready for simple hosting (static HTML content)

The goal of this image is to:
1. be easy to use
2. not require any further intervention after being started

## environment variables
appropriate defaults are defined in `.env`

**`DOMAIN_NAME` should be changed in any production/real (i.e. not localhost) deployment.**

| variable name          | default value         | description                 |
| ---------------------- | --------------------- | --------------------------- |
| `DOMAIN_NAME`          | `localhost.localhost` | domain name of server       |

## custom configuration options
a default NGINX config is provided. It was generated with help from: https://ssl-config.mozilla.org. It's a good one.

It has hooks to customize for your needs without completely overwritting it. Do that if possible. See the subsections below for more information.

### custom static content
the default config will serve `/usr/share/nginx/html` via HTTPS.
To serve custom static content, simply [tell docker to mount](https://github.com/docker-library/docs/tree/master/nginx#hosting-some-simple-static-content) a local directory there:

    -v /path/to/new/html/root/:/usr/share/nginx/html/:ro

No other changes are needed for this simple case.

see [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) for an example of this

### more/different location blocks
alternatively, you can supply your own server `location` block(s) by overwritting `/etc/nginx/conf.d/default.locations`:

    -v /path/to/new/default.locations:/etc/nginx/conf.d/default.locations:ro

see [coreycothrum/fastapi_template](https://github.com/coreycothrum/fastapi_template) for an example of this

### advanced/custom config file
to make more significant changes, overwrite the nginx conf file(s) [as you normally would](https://github.com/docker-library/docs/tree/master/nginx#complex-configuration):

    # for example
    -v /path/to/new/config.conf:/etc/nginx/templates/default.conf.template:ro

    # or more sledgehammer style
    -v /path/to/new/conf/dir:/etc/nginx/:ro

see the [official NGINX image](https://hub.docker.com/_/nginx) documentation for more information
