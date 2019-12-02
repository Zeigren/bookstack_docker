[![Docker Hub](https://img.shields.io/docker/cloud/build/zeigren/bookstack)](https://hub.docker.com/repository/docker/zeigren/bookstack)

## Docker Image For [BookStack](https://github.com/ssddanbrown/BookStack)

## Current Version: 0.27.5

### Stack

- BookStack Version 0.27.5
- Nginx Alpine
- Mariadb 10.3/latest
- Redis Alpine
- PHP 7.3-fpm

### [Docker Hub](https://hub.docker.com/r/zeigren/bookstack)
### [Main Repository](https://projects.zeigren.com/diffusion/4/)
### [Project](https://projects.zeigren.com/project/view/36/)

## Configuration

This is designed to be run under [Docker Swarm](https://docs.docker.com/engine/swarm/) mode, don't know why you can't use secrets with just compose but it is what it is.

I like using [Portainer](https://www.portainer.io/) since it makes all the swarm configuration and tinkering easier, but it's not necessary.

I personally use this with [Traefik](https://traefik.io/) as a reverse proxy, but also not necessary.

You'll need to create these [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/):

- YOURDOMAIN.com.crt = The SSL certificate for your domain (you'll need to create/copy this)
- YOURDOMAIN.com.key = The SSL key for your domain (you'll need to create/copy this)
- dhparam.pem = Diffie-Hellman parameter (you'll need to create/copy this)
- bookstacksql_root_password = Root password for your SQL database
- bookstacksql_password = BookStack user password for your SQL database

You'll also need to create this [Docker Config](https://docs.docker.com/engine/swarm/configs/):

- bookstack_vhost = The nginx vhost file for BookStack (template included, simply replace all instances of 'YOURDOMAIN')

Make whatever changes you need to docker-stack.yml (replace all instances of 'YOURDOMAIN').

Run with `docker stack deploy --compose-file docker-stack.yml bookstack`

Once it's started you can login with username 'admin@admin.com' and password 'password'.

## Issues

Upgrading from 0.25.5 to 0.26.* isn't working properly.

### Inspiration

This is a fork of [solidnerd/docker-bookstack](https://github.com/solidnerd/docker-bookstack) which itself is a fork of [Kilhog/docker-bookstack](https://github.com/Kilhog/docker-bookstack).
