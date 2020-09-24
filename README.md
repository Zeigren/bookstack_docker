# Docker Stack For [BookStack](https://github.com/ssddanbrown/BookStack)

[![DockerHub](https://img.shields.io/docker/cloud/build/zeigren/bookstack)](https://hub.docker.com/r/zeigren/bookstack)
[![MicroBadger](https://images.microbadger.com/badges/image/zeigren/bookstack.svg)](https://microbadger.com/images/zeigren/bookstack)
[![MicroBadger](https://images.microbadger.com/badges/version/zeigren/bookstack.svg)](https://microbadger.com/images/zeigren/bookstack)
[![MicroBadger](https://images.microbadger.com/badges/commit/zeigren/bookstack.svg)](https://microbadger.com/images/zeigren/bookstack)
![Docker Pulls](https://img.shields.io/docker/pulls/zeigren/bookstack)

## Tags

- latest
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
- Nginx Alpine
- MariaDB 10.4/latest
- Redis Alpine

## Links

### [Docker Hub](https://hub.docker.com/r/zeigren/bookstack)

### [GitHub](https://github.com/Zeigren/docker-swarm-bookstack)

### [Main Repository](https://phabricator.kairohm.dev/diffusion/4/)

### [Project](https://phabricator.kairohm.dev/project/view/36/)

## Usage

Use [Docker Compose](https://docs.docker.com/compose/) or [Docker Swarm](https://docs.docker.com/engine/swarm/) to deploy BookStack.

Clone the repository and create a `config` folder inside the directory.

I like using [Portainer](https://www.portainer.io/) since it makes all the tinkering easier, but it's not necessary.

## Configuration

Configuration consists of environment variables in the `docker-compose.yml` and `docker-stack.yml` files or as files contained in the `config` folder.

### [Docker Swarm](https://docs.docker.com/engine/swarm/)

I personally use this with [Traefik](https://traefik.io/) as a reverse proxy, but also not necessary.

You'll need to create these [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/):

- yourdomain.com.crt = The SSL certificate for your domain (you'll need to create/copy this)
- yourdomain.com.key = The SSL key for your domain (you'll need to create/copy this)
- bookstacksql_root_password = Root password for your SQL database
- bookstacksql_password = BookStack user password for your SQL database

You'll also need to create this [Docker Config](https://docs.docker.com/engine/swarm/configs/):

- bookstack_vhost = The nginx vhost file for BookStack (template included, simply replace all instances of `yourdomain`)

Make whatever changes you need to docker-stack.yml (replace all instances of `yourdomain`). All environment variables for BookStack can be found in `docker-entrypoint.sh`.

Run with `docker stack deploy --compose-file docker-stack.yml bookstack`

Once it's started you can login with username `admin@admin.com` and password `password`.

### [Docker Compose](https://docs.docker.com/compose/)

You'll need to create/modify these files and put them in the `config` folder:

- bookstack_vhost = The nginx vhost file for BookStack (template included, simply replace all instances of `yourdomain`)
- yourdomain.com.crt = The SSL certificate for your domain (you'll need to create/copy this)
- yourdomain.com.key = The SSL key for your domain (you'll need to create/copy this)

Make whatever changes you need to `docker-compose.yml` (replace all instances of `yourdomain`, change passwords). All environment variables for BookStack can be found in `docker-entrypoint.sh`.

Run with `docker-compose up -d`

Once it's started you can login with username `admin@admin.com` and password `password`.

#### Test

For a quick test you can copy `test_vhost.conf` into the `config` folder and run `docker-compose -f test.yml up -d`, then open up a web browser to `127.0.0.1:9080`.

## Issues

Upgrading from 0.25.5 to 0.26.* isn't working properly.

## Inspiration

This is a fork of [solidnerd/docker-bookstack](https://github.com/solidnerd/docker-bookstack) which itself is a fork of [Kilhog/docker-bookstack](https://github.com/Kilhog/docker-bookstack).
