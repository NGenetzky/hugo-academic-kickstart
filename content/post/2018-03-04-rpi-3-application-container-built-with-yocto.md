+++
title = "RPI 3 Application Container built with Yocto"
date = 2018-03-03
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = [
    "docker",
    "github",
    "resin",
    "rpi",
    "yocto",
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

## Deploying Image built from Dockerfile

I provisioned my RPI 3 with resin-os downloaded from resin.io and it
automatically loaded my existing application on first boot. I want to make sure
the docker images are as similar as possible; so I slightly modified the
dockerfile and pushed the changes to resin which will handle deploying to my
devices.

- resin-os v2.10.1
- resin/armv7hf-supervisor v6.6.3

## Deploying Application Image built with Yocto Project

I followed the steps outlined in my last post
([Using Yocto Project for Docker FROM scratch]({{< ref "post/2018-03-03-using-yocto-project-for-docker-from-scratch.md" >}}))
but used the 'rpi3' project which uses a different bsp layer and sets the
machine for rpi3: `MACHINE = "raspberrypi3"`. Here are the resulting images.

```
└─> docker images
REPOSITORY                                       TAG                 IMAGE ID            CREATED             SIZE
ngenetzky/simple-server-python-raspberrypi3      v2                  37a20312c6a9        3 minutes ago       74.9MB
ngenetzky/core-image-full-cmdline-raspberrypi3   v2                  7c880495683a        7 minutes ago       74.9MB
```

Then I deployed the image using resin-cli:
`resin deploy rpi3app1 ngenetzky/simple-server-python-raspberrypi3:v2`
The process was much faster than I had expected.

