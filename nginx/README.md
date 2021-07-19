# Configuration

Configuration consists of environment variables in the `.yml` and `.conf` files.

- bookstack_nginx.conf = NGINX config file (only needs to be modified if you're using NGINX for SSL termination)
- Make whatever changes you need to the appropriate `.yml`. All environment variables for BookStack can be found in `docker-entrypoint.sh`

## Using NGINX for SSL Termination

- yourdomain.test.crt = The SSL certificate for your domain (you'll need to create/copy this)
- yourdomain.test.key = The SSL key for your domain (you'll need to create/copy this)

## [Docker Swarm](https://docs.docker.com/engine/swarm/)

I personally use this with [Traefik](https://traefik.io/) as a reverse proxy, I've included an example `traefik.yml` but it's not necessary.

You'll need to create the appropriate [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) and [Docker Configs](https://docs.docker.com/engine/swarm/configs/).

Run with `docker stack deploy --compose-file docker-swarm.yml bookstack`

## [Docker Compose](https://docs.docker.com/compose/)

You'll need to create a `config` folder and put `bookstack_nginx.conf` in it, if you're using NGINX for SSL also put your SSL certificate and SSL key in it.

Run with `docker-compose up -d`. View using `127.0.0.1:9080`.

Once it's started you can login with username `admin@admin.com` and password `password`.
