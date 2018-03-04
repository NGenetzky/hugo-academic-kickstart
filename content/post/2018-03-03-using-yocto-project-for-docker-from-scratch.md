+++
title = "Using Yocto Project for Docker FROM scratch"
date = 2018-03-03
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = [
    "docker",
    "github",
    "resin",
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

## Yocto and  Docker

[Yocto Project](https://www.yoctoproject.org/) is an amazing way to build a
Linux System from the ground up. It uses an amazing build system that can build
and install practically any application.

[Docker](https://www.docker.com/) is an amazing tool for running applications.
There are many parts to docker, but the one that I would like to focus on is
the concept of a docker image. There are standard images created for all the
major distributions and its easy to create your own. The image contains the
files needed for your application and all the dependencies for your
application.

## TLDR Pseudo Code

For people well versed in these two tools I will first explain in pseudo code
what I did, and then I will dive into the specific things I did.

```sh
# Added this configuration to local.conf
MACHINE = "genericx86-64"
IMAGE_FSTYPES += "tar.xz"

# pokyuser@crops/poky after oe-init-build-env
bitbake core-image-minimal

# ngenetzky@hostpc
docker import \
    build/tmp/deploy/images/genericx86-64/core-image-minimal-genericx86-64.tar.xz \
    ngenetzky/core-image-minimal:v1
docker run -it \
    ngenetzky/core-image-minimal:v1 \
    /bin/sh
```

Here are a few useful resources for the code.

- [Yocto Project Quick Start](http://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html)
- [MACHINE](http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#var-MACHINE)
- [IMAGE_FSTYPES](http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#var-IMAGE_FSTYPES)
- [docker import](https://docs.docker.com/engine/reference/commandline/import/)


## Building images for Host PC

[Poky](https://www.yoctoproject.org/tools-resources/projects/poky) contains
everything needed to build simple images. It supports `MACHINE=genericx86-64`,
which will be able to run on my host PC, which is a
 [Intel Nuc Skull Canyon](https://www.intel.com/content/www/us/en/products/boards-kits/nuc/kits/nuc6i7kyk.html)
. Note the [meta-intel](http://git.yoctoproject.org/cgit/cgit.cgi/meta-intel/about/)
has improved support, and might be considered in the future. I have a few
commits on [meta-ngenetzky](https://github.com/NGenetzky/meta-ngenetzky) that
show how I configured the build. First I will build a standard image from Poky,
`bitbake core-image-full-cmdline`.

## Building a simple python-flask application image

I have used the [simple-server-python](https://github.com/NGenetzky/simple-server-python)
as an example before. I created a simple recipe
([simple-server-python_1.0.bb](https://github.com/NGenetzky/meta-ngenetzky/blob/84a291ccd193612220758ac856189b0a7ff6d27c/recipes-python/simple-server-python/simple-server-python_1.0.bb))
that will install the python module and ensure that runtime dependencies are
handled. Then we can add it to the image from local.conf.
```
# local.conf
IMAGE_INSTALL_append = " simple-server-python "
```

OK, next I will create a docker image from this 'core-image-full-cmdline'. Then
I will create a Dockerfile to allow for additional customizations, such as
setting the CMD or entrypoint. Note that this image does not support package
management (apt,dpkg,opkg).

```
# Dockerfile
FROM ngenetzky/core-image-full-cmdline:v2
EXPOSE 80
CMD ["python","/usr/bin/simple_server_python.py"]
```

## Compare Docker Images

I figured the size of each of the images might be of interest. The
'resin/nuc-python' shows the size of the image built from the standard
[Dockerfile](https://github.com/NGenetzky/simple-server-python/blob/ac0a41a2872854440c13b96a5fdf9ed74a0328f4/Dockerfile)
. Adding the application only added ~14 MB to the image (v1->v2). It's
amazing that the core-image-minimal weighs in at a mere 7.63MB.

```
└─> docker image ls
REPOSITORY                              TAG     CREATED            SIZE
resin/nuc-python--simple-server-python  latest  8 seconds ago      661MB
ngenetzky/simple-server-python          v2      22 minutes ago     94MB
ngenetzky/core-image-full-cmdline       v2      26 minutes ago     94MB
ngenetzky/core-image-full-cmdline       v1      About an hour ago  79.3MB
ngenetzky/core-image-minimal            v1      4 hours ago        7.63MB
```

## Conclusion

With minimal effort I am able to make small, highly customizable docker images
built completely from source. Then an application was added with only a few
lines of code. Next time I plan to investigate whether this approach is viable
to use with the Resin.io platform.

