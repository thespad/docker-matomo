# [thespad/matomo](https://github.com/thespad/docker-matomo)

[![GitHub Release](https://img.shields.io/github/release/thespad/docker-matomo.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/thespad/docker-matomo/releases)
![Commits](https://img.shields.io/github/commits-since/thespad/docker-matomo/latest?color=26689A&include_prereleases&logo=github&style=for-the-badge)
![Image Size](https://img.shields.io/docker/image-size/thespad/matomo/latest?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Size)
[![Docker Pulls](https://img.shields.io/docker/pulls/thespad/matomo.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/thespad/matomo)
[![GitHub Stars](https://img.shields.io/github/stars/thespad/docker-matomo.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/thespad/docker-matomo)
[![Docker Stars](https://img.shields.io/docker/stars/thespad/matomo.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/thespad/matomo)

[![ci](https://img.shields.io/github/workflow/status/thespad/docker-matomo/Check%20for%20update%20and%20release.svg?labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&label=Check%20For%20Upstream%20Updates)](https://github.com/thespad/docker-matomo/actions/workflows/call-check-and-release.yml)
[![ci](https://img.shields.io/github/workflow/status/thespad/docker-matomo/Check%20for%20base%20image%20updates.svg?labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&label=Check%20For%20Baseimage%20Updates)](https://github.com/thespad/docker-matomo/actions/workflows/call-baseimage-update.yml)
[![ci](https://img.shields.io/github/workflow/status/thespad/docker-matomo/Build%20Image%20On%20Release.svg?labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&label=Build%20Image)](https://github.com/thespad/docker-matomo/actions/workflows/call-build-image.yml)

## DEPRECATION NOTICE

This image is deprecated. We will not offer support for this image and it will not be updated. We recommend switching to [the official image](https://hub.docker.com/_/matomo) instead.

[matomo](https://github.com/matomo-org/matomo/) is a powerful web analytics platform that gives you 100% data ownership

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`.

Simply pulling `ghcr.io/thespad/matomo` should retrieve the correct image for your arch.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | latest |
| arm64 | ✅ | latest |
| armhf | ✅ | latest |

## Application Setup

Webui is accessible at `http://SERVERIP:PORT`

[Enable Redis support](https://matomo.org/faq/how-to/faq_20511/)

More info at [matomo](https://github.com/matomo-org/matomo/).

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose ([recommended](https://docs.linuxserver.io/general/docker-compose))

Compatible with docker-compose v2 schemas.

```yaml
---
version: "2.1"
services:
  matomo:
    image: ghcr.io/thespad/matomo
    container_name: matomo
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - </path/to/appdata/config>:/config
    ports:
      - 80:80
    restart: unless-stopped
```

### docker cli

```shell
docker run -d \
  --name=matomo \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -p 80:80 \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  ghcr.io/thespad/matomo
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | Web GUI |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=America/New_York` | Specify a timezone to use EG America/New_York |
| `-v /config` | Contains all relevant configuration files. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```shell
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```shell
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Support Info

* Shell access whilst the container is running: `docker exec -it matomo /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f matomo`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. We do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull matomo`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d matomo`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull ghcr.io/thespad/matomo`
* Stop the running container: `docker stop matomo`
* Delete the container: `docker rm matomo`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

### Image Update Notifications - Diun (Docker Image Update Notifier)

* We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:

```shell
git clone https://github.com/thespad/docker-matomo.git
cd docker-matomo
docker build \
  --no-cache \
  --pull \
  -t ghcr.io/thespad/matomo:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`

```shell
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **06.12.21:** - Rebase to Alpine 3.15
* **17.06.21:** - Rebase to Alpine 3.14
* **02.05.21:** - Initial Release.
