this project is meant to be used in conjunction with [coreycothrum/certbot_docker](https://github.com/coreycothrum/certbot_docker)

**see [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) for an usage example**

this project [is deployed to docker hub](https://hub.docker.com/repository/docker/coreycothrum/nginx).

### what this image is
an extention of the official [nginx docker image](https://hub.docker.com/_/nginx) to make integration with [certbot](https://certbot.eff.org/) easier. Key features:
* `nginx -s reload` runs periodically to pull in updated certificates
* HTTPS only and pre-integrated w/ [coreycothrum/certbot_docker](https://github.com/coreycothrum/certbot_docker)
* template 'best practices' nginx `*.conf` that is easy to extend
* out-of-the-box ready for simple hosting (static HTML content)

The goal of this image is to:
1. be easy to use
2. not require any further intervention after being started

## environment variables
appropriate defaults are defined in `.env`. These defaults are fine for a localhost/development environment, but should all be changed for anything resembling production (or running on a valid/public domain).

| variable name          | default value         | description                                                 |
| ---------------------- | --------------------- | ----------------------------------------------------------- |
| `DOMAIN_NAME`          | `localhost.localhost` | domain name of server. Default is OK for local development. |

## custom configuration options
a default NGINX config is provided. It was generated with help from: https://ssl-config.mozilla.org. It's a good one ("A" rating on [ssllabs.com](www.ssllabs.com)).

It has hooks for easy customization without completely overwritting it. Do that if possible. See the subsequent section(s) for more information.

### custom static content
the default config will serve `/usr/share/nginx/html` (SSL/HTTPS only).
To serve custom static content, simply [tell docker to mount](https://github.com/docker-library/docs/tree/master/nginx#hosting-some-simple-static-content) a local directory there:

    docker run --rm                                            \
               --env-file .env                                 \
               --volume /some/content:/usr/share/nginx/html:ro \
               coreycothrum/nginx

No other changes are needed for this simple case.

see [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) for an example of this

### more/different location blocks
most other use cases (proxy pass, etc) can be implemented by supplying custom server `location` block(s). Do this by overwritting `/etc/nginx/templates/default.locations.template`:

    --volume /local/locations.template:/etc/nginx/templates/default.locations.template:ro

see [coreycothrum/fastapi_template](https://github.com/coreycothrum/fastapi_template) for an example of this

### advanced/custom config file
*rarely*, there may be need for more significant customization. try not to.

If needed, overwrite the nginx conf file(s) [as you normally would](https://github.com/docker-library/docs/tree/master/nginx#complex-configuration):

    # for example
    --volume /local/default.conf.template:/etc/nginx/templates/default.conf.template:ro

    # or more sledgehammer style
    --volume /path/to/new/conf/dir:/etc/nginx/:ro

see the [official NGINX image](https://hub.docker.com/_/nginx) documentation for more information
