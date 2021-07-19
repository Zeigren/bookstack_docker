# Docker Stack For [BookStack](https://github.com/BookStackApp/BookStack)

![Docker Image Size (latest)](https://img.shields.io/docker/image-size/zeigren/bookstack/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/zeigren/bookstack)

## Links

### [Docker Hub](https://hub.docker.com/r/zeigren/bookstack)

### [ghcr.io](https://ghcr.io/zeigren/bookstack_docker)

### [GitHub](https://github.com/Zeigren/bookstack_docker)

### [Main Repository](https://phabricator.kairohm.dev/diffusion/4/)

### [Project](https://phabricator.kairohm.dev/project/view/36/)

## Tags

- latest
- 21.05.3
- 21.05.2
- 21.05.1
- 21.04.2
- 0.31.8
- 0.30.1
- 0.30.0
- 0.29.3
- 0.29.0
- 0.28.3
- 0.28.2
- 0.28.0
- 0.27.5
- 0.27.4
- 0.26.2
- 0.26.1
- 0.26.0
- 0.25.5

## Stack

- PHP 8.0-fpm-alpine - BookStack
- Caddy or NGINX - web server
- MariaDB - database
- Redis Alpine - cache

## Usage

Use [Docker Compose](https://docs.docker.com/compose/) or [Docker Swarm](https://docs.docker.com/engine/swarm/) to deploy. Containers are available from both Docker Hub and the GitHub Container Registry.

There are examples for using either [Caddy](https://caddyserver.com/) or [NGINX](https://www.nginx.com/) as the web server and examples for using Caddy, NGINX, or [Traefik](https://traefik.io/traefik/) for HTTPS (the Traefik example also includes using it as a reverse proxy). The NGINX examples are in the nginx folder.

## Recommendations

I recommend using Caddy as the web server and either have it handle HTTPS or pair it with Traefik as they both have native [ACME](https://en.wikipedia.org/wiki/Automated_Certificate_Management_Environment) support for automatically getting HTTPS certificates from [Let's Encrypt](https://letsencrypt.org/) or will create self signed certificates for local use.

If you can I also recommend using [Docker Swarm](https://docs.docker.com/engine/swarm/) over [Docker Compose](https://docs.docker.com/compose/) as it supports [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) and [Docker Configs](https://docs.docker.com/engine/swarm/configs/).

If Caddy doesn't work for you or you are chasing performance then checkout the NGINX examples. I haven't done any performance testing but NGINX has a lot of configurability which may let you squeeze out better performance if you have a lot of users, also check the performance section below.

## Configuration

Configuration consists of setting environment variables in the `.yml` files. More environment variables for configuring BookStack and PHP can be found in `docker-entrypoint.sh` and for Caddy in `bookstack_caddyfile`.

Setting the `DOMAIN` variable changes whether Caddy uses HTTP, HTTPS with a self signed certificate, or HTTPS with a certificate from Let's Encrypt or ZeroSSL. Check the Caddy [documentation](https://caddyserver.com/docs/automatic-https) for more info.

Once the container is started you can login with username `admin@admin.com` and password `password`.

### [Docker Swarm](https://docs.docker.com/engine/swarm/)

I personally use this with [Traefik](https://traefik.io/traefik/) as a reverse proxy, I've included an example `traefik.yml` but it's not necessary.

You'll need to create the appropriate [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) and [Docker Configs](https://docs.docker.com/engine/swarm/configs/).

Run with `docker stack deploy --compose-file docker-swarm.yml bookstack`

### [Docker Compose](https://docs.docker.com/compose/)

Run with `docker-compose up -d`. View using `127.0.0.1:9080`.

### File Uploads

Set the `POST_MAX_SIZE`, `UPLOAD_MAX_FILESIZE`, and `MEMORY_LIMIT` variables to whatever you want the max file upload size to be (`MEMORY_LIMIT` should at least be 128M). See the [BookStack documentation](https://www.bookstackapp.com/docs/admin/upload-config) for more information.

### Performance Tuning

The web servers set the relevant HTTP headers to have browsers cache as much as they can for as long as they can while requiring browsers to check if those files have changed, this is to get the benefit of caching without having to deal with the caches potentially serving old content. If content doesn't change that often or can be invalidated in another way then this behavior can be changed to reduce the number of requests.

By default I set PHP to scale up child processes based on demand, this is great for a low resource and light usage environment but setting this to be dynamic or static will yield better performance. Check the PHP Configuration section in `docker-entrypoint.sh` for some tuning options to set and/or research.

## Inspiration

This is a fork of [solidnerd/docker-bookstack](https://github.com/solidnerd/docker-bookstack) which itself is a fork of [Kilhog/docker-bookstack](https://github.com/Kilhog/docker-bookstack).
