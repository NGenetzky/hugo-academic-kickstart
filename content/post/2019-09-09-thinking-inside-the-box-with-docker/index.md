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


## web-nginx: Manually building image with commits to container

Now we are going to stop the container (which will also destory it since we
specified the `--rm` flag). Next we are going add a file to the container
from the internet, and save the container an image.

```bash
→ f='./web-nginx/stop_wget_html_and_commit.sh' && cat "${f}" && "${f}"
#!/bin/sh
docker rm -f 'web-nginx-container' || true

docker run -t \
    --name 'web-nginx-container' \
    'web-nginx-image' \
    wget \
    'https://gist.github.com/physacco/2e1b52415f3a964ad2a542a99bebed8f' \
    -O '/var/www/wget-gist-from-github.html'

docker commit \
    'web-nginx-container' \
    'web-nginx-with-data-image:1.0'
...
sha256:30515dc065f479399b54d7e4bb2b67528d6e22d6d97798ec1f7669d6f455ae68
```

Now we can create a new container from this image we just saved. This time we
are also going to mount a "volume". We will then navigate to `localhost:80`.

```bash
→ f='./web-nginx/run_2nd_image_with_volume.sh' && cat "${f}" && "${f}"
#!/bin/sh
SCRIPTDIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"
cd "${SCRIPTDIR}"

docker rm -f 'web-nginx-container' >/dev/null 2>&1 || true

docker run --detach --rm \
    --name "web-nginx-container" \
    --volume "$(pwd):/var/www/mounted-pwd" \
    --publish 80:80 \
    'web-nginx-with-data-image:1.0' \
    'nginx'

xdg-open 'http://localhost:80'
49a0f1e9474ba8ae3a30a2e4eaca3186bd1923f5a64f1e7726ba3f481c078b92
```

## web-nginx: Inspect images and containers

Note that this time I specified the 'CMD' for the container explicitly; this
is because some special metadata about the image was overritten. We will walk
through the steps to investigate these images. First we will lookup the image
history:

```bash
→ f='./web-nginx/image_history.sh' && cat "${f}" && "${f}"
#!/bin/sh
docker image history \
    'web-nginx-with-data-image:1.0' 
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
30515dc065f4        About an hour ago   wget https://gist.github.com/physacco/2e1b52…   0B                  
251c0ed12ac2        23 hours ago        /bin/sh -c #(nop) COPY file:3008ecd53df1eb46…   510B                
02affa393ea5        17 months ago       /bin/sh -c #(nop)  CMD ["nginx"]                0B                  
<missing>           17 months ago       /bin/sh -c #(nop) WORKDIR /etc/nginx            0B                  
<missing>           17 months ago       /bin/sh -c #(nop)  VOLUME [/var/www /var/log…   0B                  
<missing>           17 months ago       /bin/sh -c #(nop)  EXPOSE 443/tcp               0B                  
<missing>           17 months ago       /bin/sh -c #(nop)  EXPOSE }}}80/tcp                0B                  
<missing>           17 months ago       /bin/sh -c #(nop) ADD file:b5da41d30400c84d8…   479B                
<missing>           17 months ago       /bin/sh -c #(nop) ADD file:1a9ecefd9c60d5ed5…   475B                
<missing>           17 months ago       /bin/sh -c adduser www-data -G www-data -H -…   5.05kB              
<missing>           17 months ago       /bin/sh -c apk add --update     nginx   && r…   1.37MB              
<missing>           17 months ago       /bin/sh -c #(nop)  MAINTAINER Johannes Mitlm…   0B                  
<missing>           19 months ago       /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           19 months ago       /bin/sh -c #(nop) ADD file:093f0723fa46f6cdb…   4.15MB 
```

After doing this we can then use `docker inspect` to investigate the nitty
gritty details. We were specifically interested in the "`Cmd`", so we can use
the magical `--format` parameter to filter down to just this data. I 

```bash
→ f='./web-nginx/inspect_and_compare.bash' && cat "${f}" && "${f}"
#!/bin/bash

DEFAULT_A='web-nginx-image'
DEFAULT_B='web-nginx-with-data-image:1.0'

inspect_and_compare(){
    local a b format
    a="${1-${DEFAULT_A}}"
    b="${2-${DEFAULT_B}}"
    format='{{ json .Config.Cmd }}'

    diff \
        <(docker inspect "${a}" --format "${format}") \
        <(docker inspect "${b}" --format "${format}")
}

inspect_and_compare "$@"
1c1
< ["nginx"]
---
> ["wget","https://gist.github.com/physacco/2e1b52415f3a964ad2a542a99bebed8f","-O","/var/www/wget-gist-from-github.html"]
```

## cli-pyflame: Simple application with command line interface in python

Second we are going to build our own application from scratch. Our
application has some dependencies and we would like to make the final image
as small as possible. We will utilize the technique outlined by [Itamar
Turner-Trauring](itamar@pythonspeed.com) in the following articles:

- [multi-stage-docker-python][]
- [activate-virtualenv-dockerfile][]

### Dockerfile

We will break down [./cli-pyflame/Dockerfile][] to identify the key parts.

We will use `apt` to install some system level dependencies. Note that in
order to conserve space we must clear apt's caches before the end of the
`RUN` statement. Note that these build tools are not required for our
application to be able to run, but are only neccessary to build the
application.

```Dockerfile
# Configure apt and install packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
```

Next we set up a python virtual env and configure the container to use this
environment by using environment variables.

```Dockerfile
ENV VIRTUAL_ENV='/opt/venv/'
RUN python -m venv "${VIRTUAL_ENV}"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
```

Next we will install python dependencies. Note that we `COPY` the
`requirements.txt` separately before we `COPY` the rest of the application.
This is an optimization which allows for more effective use of the build
cache. When running `docker build` it will attempt to use a cached version of
each layer which has not had any changes - which means that unless
`requirements.txt` is modified then the cache from the previous build will be
used.

```Dockerfile
WORKDIR /usr/src/app/
COPY requirements.txt .
RUN pip install -r requirements.txt
```

Here we:

1. Build it initially.
2. Build it again and see that cache is used.
3. Build it again after invalidating the cache for `requirements.txt`

```bash
→ f='./cli-pyflame/build.sh' && cat "$f" && "$f"
#!/bin/sh
SCRIPTDIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)" #"
cd "${SCRIPTDIR}"
docker build \
    --tag 'cli-pyflame-image' \
    './'
Sending build context to Docker daemon   7.68kB
Step 1/11 : FROM python:3.7-slim AS compile-image
...
Successfully built a7ddb6b4d33f
Successfully tagged cli-pyflame-image:latest
→ f='./cli-pyflame/build.sh' && "$f"  | grep -A 1 'Step 8'
Step 8/11 : RUN pip install -r requirements.txt
 ---> Using cache
→ echo '#' >> cli-pyflame/requirements.txt && f='./cli-pyflame/build.sh' && "$f"  | grep -A 1 'Step 8'
Step 8/11 : RUN pip install -r requirements.txt
 ---> Running in 28b9a235d42a
```

Here we actually `COPY` in the source code, and then install the application.

```
COPY ./ /usr/src/app/
RUN pip install .
```

Here is where we configure the `ENTRYPOINT`. I highly recommend reviewing
this article ([docker-run-vs-cmd-vs-entrypoint][]) to understand the
intricies, advantages and disadvangtages of `CMD` and `ENTRYPOINT`.

```
ENTRYPOINT ["python", "-m", "pyflame.flame"]
```

### Run

Run with default entrypoint with no `CMD`.

```bash
→ f='./cli-pyflame/run.sh' && cat "$f" && "$f"
#!/bin/sh
docker run --rm \
    --name "cli-pyflame-container" \
    'cli-pyflame-image' "$@"
NAME
    flame.py

SYNOPSIS
    flame.py COMMAND

COMMANDS
    COMMAND is one of the following:

     lite
```

Next we will change the `CMD` by just adding argument at the end.

```bash
→ f='./cli-pyflame/run.sh' && "$f" lite -h
INFO: Showing help with the command 'flame.py lite -- --help'.

NAME
    flame.py lite

SYNOPSIS
    flame.py lite N <flags>

POSITIONAL ARGUMENTS
    N

FLAGS
    --of=OF

NOTES
    You can also use flags syntax for POSITIONAL ARGUMENTS
```

Alternatively could change the `ENTRYPOINT` when we call `docker run`. Here
we will launch an interactive bash shell, and then we can call the cli
multiple times.

```
→ f='./cli-pyflame/console.sh' && cat "$f" && "$f"
#!/bin/sh
docker run -it --rm \
    --entrypoint '/bin/bash' \
    --name "cli-pyflame-container" \
    'cli-pyflame-image' \
    "$@"
root@678d6adbdc25:/usr/src/app# python -m pyflame.flame lite 1 apple
WARNING:root:lit 1 apple on fire
root@678d6adbdc25:/usr/src/app# python -m pyflame.flame lite 2
WARNING:root:lit 2 candles on fire
```

[thinking-inside-the-box-with-docker]: https://gitlab.com/ngenetzky-dojofive/thinking-inside-the-box-with-docker
[multi-stage-docker-python]: https://pythonspeed.com/articles/multi-stage-docker-python/
[activate-virtualenv-dockerfile]: https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
[./cli-pyflame/Dockerfile]: https://gitlab.com/ngenetzky-dojofive/thinking-inside-the-box-with-docker/blob/69924697de0530dd431233cf97fb1c513c40b5ea/cli-pyflame/Dockerfile
[docker-run-vs-cmd-vs-entrypoint]: https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/
