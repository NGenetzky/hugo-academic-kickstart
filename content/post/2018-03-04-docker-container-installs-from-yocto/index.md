+++
title = "Docker Container Installs from Yocto"
date = 2018-03-04
draft = false

tags = [
    "docker",
    "docker-compose",
    "github",
    "opkg",
    "yocto",
]
categories = []
+++

## Yocto Application Containers from SCRATCH

Yesterday I wrote about
[Using Yocto Project for Docker FROM scratch]({{< ref "/post/2018-03-03-using-yocto-project-for-docker-from-scratch" >}})
, but I quickly realized it is hard to iterate quickly with this workflow. As
I added support for python-connexion I generated a fresh container image at least
10 times. This is silly when I am only altering a few packages on the system, and
so I looked to improve my workflow.

Currently I run the application containers using docker-compose. There is
virtually no difference in how the containers are used once they are created
with `docker import`. I use two different images below because one is using
python-flask and the other is using python3-flask, but I could easily spin
up another service from the same `ngenetzky/core-image-minimal:v3` image.

```
# docker-compose.yaml
version: '3'
services:
    ssp:
        image: ngenetzky/core-image-full-cmdline:v2
        command: ["python", "/usr/bin/simple_server_python.py"]
        ports:
            - "8080:80"
    ss:
        command: ["python3", "-m", "swagger_server"]
        image: ngenetzky/core-image-minimal:v3
        ports:
            - "8081:80"
```


## Enabling package-management

This white paper is an excellent resource:

* [Using Package Manager to Efficiently Develop Yocto Project-based Systems](https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/package-manager-white-paper.pdf)

I tweaked the x86-64 project's local.conf slightly to enable the ipk and
package-management.

```
# local.conf
PACKAGE_CLASSES = "package_ipk"
EXTRA_IMAGE_FEATURES += "package-management"
```

Since I already have a docker-compose file I simply extended it to add the
pkgfeed service to host ipks from my Yocto build workspace.

```
# docker-compose.yaml
version: '3'
services:
    ...
    pkgfeed:
        command: ["python3", "-m", "http.server", "80"]
        image: python:3
        ports:
            - "8000:80"
        working_dir: "/srv"
        volumes:
            - "/data/yocto-pyro/1/build/tmp/deploy/ipk:/srv"
```

Currently I simply set the opkg.conf manually, but I am considering apply
the settings at build time.

```
# docker exec -it yoctocontainers_ss_1 /bin/vi /etc/opkg/opkg.conf
# /etc/opkg/opkg.conf
...
src  all    http://pkgfeed:80/all
src  core2-64   http://pkgfeed:80/core2-64
src  genericx86_64  http://pkgfeed:80/genericx86_64
```

