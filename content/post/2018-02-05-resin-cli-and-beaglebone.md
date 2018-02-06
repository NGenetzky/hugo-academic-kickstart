+++
title = "Resin CLI and Beaglebone"
date = 2018-02-05
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = [
    "docker",
    "github",
    "resin",
    "rpi",
]
categories = []

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
#[header]
#image = ""
#caption = ""
#preview = true
+++

## Getting started with the CLI

I attempted to install the npm package but my system was incompatible with some
of the requirements. Thankfull, rather than having to debug this issue I was
able to simply [download a release](https://github.com/resin-io/resin-cli/releases)
that I was able to simply unzip, add to path and use.

## Changing applicaton code, building and deploying to device

The other day I deployed this application but one thing I noted was that the
public url did not provde access to my API. The reason for this is because
Resin.io is only forwarding port 80. So I am going to go through the steps
to change the port the python server runs on and then bulid and deploy my
application using the resin-cli.

I checked out my ngenetzky-petstore. Modified the `__main__.py` and the
Dockerfile to use port 80. Then I go about building my container (for the rpi1)
locally.

```
└─> resin build --deviceType raspberrypi3 --arch armhf
[Info]    Building Dockerfile.template project
[Build]   Step 1/10 : FROM resin/raspberrypi3-alpine-python:3
[Build]    ---> 693a4fc3f771
[Build]   Step 2/10 : RUN mkdir -p /usr/src/app
[Build]    ---> Running in 92da63f7c9f1
[Build]   standard_init_linux.go:195: exec user process caused "exec format error"
```

With a little research it appears that maybe I was correct when I thought that
docker running on x86 would have issues building a container for ARM.

To Be Continued...
