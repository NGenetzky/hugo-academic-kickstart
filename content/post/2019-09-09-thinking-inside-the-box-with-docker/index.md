---
title: "Thinking Inside the Box With Docker"
date: 2019-09-09
draft: false
authors: ["Natahn Genetzky"]
categories: ["dojofive"]
tags:
- bash
- docker
- python
---

## Introduction

Today we will be investigating different ways docker can be used by running
through simple examples that contain realistic tasks that are performed
involving docker. I will be running through these examples in the following
git respository. I will try to keep good history of what was done in git.

- [thinking-inside-the-box-with-docker](https://gitlab.com/ngenetzky-dojofive/thinking-inside-the-box-with-docker)

I will attempt to describe code or commands I am executing.

- Commands executed on the command line will be prefixed with: "→"
- Characters may be omitted, but they will be replaced with: "..."

## web-nginx: Serve static content over http from image built from Dockerfile

First we are going to set up a web server in a container, using an existing
image. I have used the `jojomi/nginx-static` image in the past for other
projects.

- [github](https://github.com/jojomi/docker-nginx-static)
- [dockerhub](https://hub.docker.com/r/jojomi/nginx-static)

### Dockerfile

We will build from build `FROM jojomi/nginx-static`, however we would like to
change the "default" site to configure `location /` to have `autoindex on`,
so that we get a listing of files on the server.

```Dockerfile
# FILE: ./web-nginx/Dockerfile
FROM jojomi/nginx-static
COPY ./nginx-default.conf /etc/nginx/sites-enabled/default
```

We will then build this container with a tag so that we can reference it.

```bash
→ f='./web-nginx/build.sh' && cat "${f}" && "${f}"
#!/bin/sh
SCRIPTDIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)" #"
cd "${SCRIPTDIR}"
docker build \
    --tag 'web-nginx-image' \
    './'
...
Successfully tagged web-nginx-image:latest
```

We can then run this container. Since this is a web server we will choose to
"publish" port 80 so that we access the web server and we will "detach" the
terminal since there is no interaction needed.

```bash
→ f='./web-nginx/run.sh' && cat "${f}" && "${f}"
#!/bin/sh
docker run --detach --rm \
    --name "web-nginx-container" \
    --publish 80:80 \
    'web-nginx-image'
b62adcb571a46f4e913f2d84507398a99f539b3e38df3b2d56911fcceca64195
```

You may be wondering how I identified the configuration for nginx that was
included with the container. To do this I simple "entered" the container, and
then I was able to locate the configuration files of interest.

```bash
→ f='./web-nginx/enter.sh' && cat "${f}" && "${f}"
#!/bin/sh
docker exec -it \
    'web-nginx-container' \
    '/bin/sh'
/etc/nginx # 
```
