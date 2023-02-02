[this docker image](https://hub.docker.com/repository/docker/coreycothrum/nginx) is meant to be used in conjunction with [coreycothrum/certbot_docker](https://github.com/coreycothrum/certbot_docker).

**see [coreycothrum/nginx_certbot_docker_compose](https://github.com/coreycothrum/nginx_certbot_docker_compose) as an example.**

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

**`DOMAIN_NAME` should be changed in any production/real (i.e. not localhost) deployment.** The others should be left alone.

| variable name          | default value         | description                 |
| ---------------------- | --------------------- | --------------------------- |
| `DOMAIN_NAME`          | `localhost.localhost` | domain name of server       |

## overwrite `nginx.conf` with custom config
a basic `nginx.conf` is provided. use this as reference, though it'll probably need to be overwritten:

    -v /path/to/new/config.conf:/etc/nginx/templates/default.conf.template:ro

probably also want to overwrite the HTML doc root:

    -v /path/to/new/html/root/:/usr/share/nginx/html/:ro # or whatever DEST the new config expects
