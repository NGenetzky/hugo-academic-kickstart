+++
title = "RPI with Yocto"
date = 2018-01-28T22:45:48Z
draft = true

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = [
    "rpi",
    "yocto",
    "github",
]
categories = []

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
# Use `caption` to display an image caption.
#   Markdown linking is allowed, e.g. `caption = "[Image credit](http://example.org)"`.
# Set `preview` to `false` to disable the thumbnail in listings.
[header]
image = ""
caption = ""
preview = true

+++

## Find my pi

- [Find your Raspberry Pi's IP Address](https://howchoo.com/g/mjk3m2e2njy/find-your-raspberry-pis-ip-address)

1. Use ifconfig to find my dev machine ip
2. use nmap to scan the computers on my network.

## jumpnow

- [Building Raspberry Pi Systems with Yocto](http://www.jumpnowtek.com/rpi/Raspberry-Pi-Systems-with-Yocto.html)

### prebuilt image

First I am going to load the prebuilt image.

1. Downloaded.
2. Extracted using xz.
3. Copy to sdcard using dd.

This image is a whopping 2Gb! I think I am going to go straight to building my own with Yocto.

## Yocto using meta-ngenetzky

### Setup Yocto build Environment

- [github.com/NGenetzky/meta-ngenetzky](https://github.com/NGenetzky/meta-ngenetzky)
- [github.com/NGenetzky/yocto-manifests](https://github.com/NGenetzky/yocto-manifests)
- [github.com/crops/poky-container](https://github.com/crops/poky-container)

After cloning meta-ngenetzky, I am able to execute 'bitbake.sh' to create a
workspace for Yocto and then I'm dropped inside the container. Currently the
script is configured to create a shared downloads and sstate-cache directories.

```sh
./scripts/bitbake.sh /data/ngenetzky/workspace-0
```

After it clones the required projects (using repo) I am able to initalize the
build environment and start the first build.

```sh
source ./yocto/poky/oe-init-build-env ./build
bitbake core-image-minimal
```

### Lower space requirements

I am using a very small ssd, and so I decided to modify the script to mount the
downloads and sstate-cache from my external harddrive.

### Configure Environment for building for RPI.

I have created a "group" in the manifests for "rpi", which allows the projects
required for the meta-raspberrypi to be added easily. Next I created a new
"project" inside my repo, which allows me to customize the local.conf and
bblayers.conf files for a particular project.

### meta-raspberrypi Quick Start

- [meta-raspberrypi](https://git.yoctoproject.org/cgit.cgi/meta-raspberrypi/about/)

1. source poky/oe-init-build-env rpi-build
2. Add this layer to bblayers.conf and the dependencies above
3. Set MACHINE in local.conf to one of the supported boards
4. bitbake rpi-hwup-image
5. dd to a SD card the generated sdimg file (use xzcat if rpi-sdimg.xz is used)
6. Boot your RPI.

