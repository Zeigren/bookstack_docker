# Docker Stack For [BookStack](https://github.com/BookStackApp/BookStack)

![Docker Image Size (latest)](https://img.shields.io/docker/image-size/zeigren/bookstack/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/zeigren/bookstack)

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
- Caddy
- MariaDB
- Redis Alpine

## Links

### [Docker Hub](https://hub.docker.com/r/zeigren/bookstack)

### [ghcr.io](https://ghcr.io/zeigren/bookstack_docker)

### [GitHub](https://github.com/Zeigren/bookstack_docker)

### [Main Repository](https://phabricator.kairohm.dev/diffusion/4/)

### [Project](https://phabricator.kairohm.dev/project/view/36/)

## Usage

Use [Docker Compose](https://docs.docker.com/compose/) or [Docker Swarm](https://docs.docker.com/engine/swarm/) to deploy. There are examples for using Caddy or Traefik for HTTPS.

## Configuration

Configuration consists of setting environment variables in the `.yml` files. More environment variables for configuring BookStack and PHP can be found in `docker-entrypoint.sh` and for Caddy in `bookstack_caddyfile`.

Setting the `DOMAIN` variable changes whether Caddy uses HTTP, HTTPS with a self signed certificate, or HTTPS with a certificate from Let's Encrypt or ZeroSSL.

Once the container is started you can login with username `admin@admin.com` and password `password`.

### [Docker Swarm](https://docs.docker.com/engine/swarm/)

I personally use this with [Traefik](https://traefik.io/) as a reverse proxy, I've included an example `traefik.yml` but it's not necessary.

You'll need to create the appropriate [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) and [Docker Configs](https://docs.docker.com/engine/swarm/configs/).

Run with `docker stack deploy --compose-file docker-swarm.yml bookstack`

### [Docker Compose](https://docs.docker.com/compose/)

Run with `docker-compose up -d`. View using `127.0.0.1:9080`.

### File Uploads

Set the `POST_MAX_SIZE`, `UPLOAD_MAX_FILESIZE`, and `MEMORY_LIMIT` variables to whatever you want the max file upload size to be (`MEMORY_LIMIT` should at least be 128M). See the [BookStack documentation](https://www.bookstackapp.com/docs/admin/upload-config) for more information.

## Issues

Upgrading from 0.25.5 to 0.26.* isn't working properly.

## Inspiration

This is a fork of [solidnerd/docker-bookstack](https://github.com/solidnerd/docker-bookstack) which itself is a fork of [Kilhog/docker-bookstack](https://github.com/Kilhog/docker-bookstack).
