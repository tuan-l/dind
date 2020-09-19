# Docker-in-docker

This repository is used to keep what I have learned about docker-in-docker.

## Prerequisites

First of all, you have to have the docker-ce installed on your system, follow the instructions below to install docker and docker-compose:

```bash
## Install docker rootless
$ curl -fsSL https://get.docker.com/rootless | sh
$ sudo apt update && apt install -y docker-compose

## For Alpine Linux users
$ sudo apk update && sudo apk add docker docker-compose
```

```bash
## Add current user to docker group
$ sudo usermod -aG docker $USER

## For Alpine Linux users
$ sudo addgroup $USER docker
```

After then, edit `.env` file if needed. This is optional. Default values are:

```bash
USER_ID=dind
USER_PW=password
PORT=1022
```

these are username and password for the user you will use to manipulate with the experiment. Both `root` and `USER_ID` users use the same password `USER_PW`. `PORT` is used to forward SSH port to.

## Experiment

Run the following commands to build and run the experiment:

```bash
docker-compose up --build
```

SSH into main container by the following commands:

```bash
# user is the username you have defined before
$ ssh user@localhost -p 1022
```

then type in your password to login.

Inside this container you could working with docker as normally, the only prolem we face here is `docker volume`, you could not bind mount correctly in nested containers.

You also could use `Tera Term`, `PuTTy`, `WinSCP` or `FileZilla` to manipulate with the system.
