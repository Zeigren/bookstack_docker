# Docker Stack For [BookStack](https://github.com/BookStackApp/BookStack)

![Docker Image Size (latest)](https://img.shields.io/docker/image-size/zeigren/bookstack/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/zeigren/bookstack)

## Tags

- latest
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

- PHP 7.4-fpm-alpine - BookStack
- NGINX Alpine
- MariaDB
- Redis Alpine

## Links

### [Docker Hub](https://hub.docker.com/r/zeigren/bookstack)

### [GitHub](https://github.com/Zeigren/docker-swarm-bookstack)

### [Main Repository](https://phabricator.kairohm.dev/diffusion/4/)

### [Project](https://phabricator.kairohm.dev/project/view/36/)

## Usage

Use [Docker Compose](https://docs.docker.com/compose/) or [Docker Swarm](https://docs.docker.com/engine/swarm/) to deploy. There are examples for using NGINX or Traefik for SSL termination, or don't use SSL at all.

## Configuration

Configuration consists of environment variables in the `.yml` and `.conf` files.

- bookstack_nginx.conf = NGINX config file (only needs to be modified if you're using NGINX for SSL termination)
- Make whatever changes you need to the appropriate `.yml`. All environment variables for BookStack can be found in `docker-entrypoint.sh`

### Using NGINX for SSL Termination

- yourdomain.test.crt = The SSL certificate for your domain (you'll need to create/copy this)
- yourdomain.test.key = The SSL key for your domain (you'll need to create/copy this)

### [Docker Swarm](https://docs.docker.com/engine/swarm/)

I personally use this with [Traefik](https://traefik.io/) as a reverse proxy, I've included an example `traefik.yml` but it's not necessary.

You'll need to create the appropriate [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) and [Docker Configs](https://docs.docker.com/engine/swarm/configs/).

Run with `docker stack deploy --compose-file docker-swarm.yml bookstack`

### [Docker Compose](https://docs.docker.com/compose/)

You'll need to create a `config` folder and put `bookstack_nginx.conf` in it, if you're using NGINX for SSL also put your SSL certificate and SSL key in it.

Run with `docker-compose up -d`. View using `127.0.0.1:9080`.

Once it's started you can login with username `admin@admin.com` and password `password`.

## Issues

Upgrading from 0.25.5 to 0.26.* isn't working properly.

## Inspiration

This is a fork of [solidnerd/docker-bookstack](https://github.com/solidnerd/docker-bookstack) which itself is a fork of [Kilhog/docker-bookstack](https://github.com/Kilhog/docker-bookstack).
