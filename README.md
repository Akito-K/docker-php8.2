# docker-php8.2-apache

A Debian LAMP container

It's on [docker-hub](https://hub.docker.com/repository/docker/niclab/php8.2/) and [github](https://github.com/Akito-K/docker-php8.2)

## tags and links
* `latest` [(main/Dockerfile)](https://github.com/Akito-K/docker-php8.2/blob/main/Dockerfile)

## how to build

```sh
git clone git@github.com:Akito-K/docker-php8.2.git
cd docker-php8.2
docker build --rm -t niclab/php8.2 .
```

## running

```sh
docker-compose up -d
```