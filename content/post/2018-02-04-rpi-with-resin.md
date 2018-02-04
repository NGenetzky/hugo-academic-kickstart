+++
title = "RPI with Resin"
date = 2018-02-04
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = [
    "github",
    "python",
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

# Getting Started With Raspberry Pi 3 and Python

- [Getting Started With Raspberry Pi 3 and Python](https://docs.resin.io/raspberrypi3/python/getting-started/)
- [NGenetzky/simple-server-python](https://github.com/NGenetzky/simple-server-python)

Following their guide is very easy. I was really impressed by the feedback when
using git push. It shows the log messages for building the image on the build
server.

```
└─> git push rpi3app1 master
Counting objects: 62, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (32/32), done.
Writing objects: 100% (62/62), 706.32 KiB | 0 bytes/s, done.
Total 62 (delta 25), reused 62 (delta 25)

[Info]     Starting build for gh_ngenetzky/rpi3app1, user gh_ngenetzky
[Info]     Dashboard link: https://dashboard.resin.io/apps/960411/devices
[Info]     Building on arm01
[Info]     Fetching base image
[Warning]  No image tag given for resin/raspberrypi3-python, using default (latest)
[==================================================>] 100%
[Info]     Building Dockerfile.template project
[Build]    Step 1/7 : FROM resin/raspberrypi3-python
[Build]     ---> 3e70503baf68
...
[Build]    Successfully tagged registry2.resin.io:443/rpi3app1/319b8654758f4bc4498945c8634a8cbc03a79276:latest
[Success]  Image created successfully
[Info]     Verifying image integrity...
[Success]  Image passed integrity checks!
[Info]     Uploading image to registry...
[==================================================>] 100%
[Success]  Image uploaded successfully!
[Info]     Check your dashboard for device download progress:
[Info]       https://dashboard.resin.io/apps/960411/devices
[Info]     Build took 33 seconds
[Info]     487.10 MB total image size
[Info]     480.72 MB resin/raspberrypi3-python:latest
[Info]     6.38 MB user additions
```

# RPI GPIO Access

## Via Terminal

You can access the terminal through the web on the dashboard.resin.io for the
device. You can also ssh to the device locally, but you must use port 22222.

The script below will turn off the leds and then turn them on after 1 second;
led0 and led1 are labeled ACT and PWR on Raspberry Pi 3.

```
echo 0 > '/sys/devices/platform/leds/leds/led0/brightness'
echo 0 > '/sys/devices/platform/leds/leds/led1/brightness'
sleep 1
echo 255 > '/sys/devices/platform/leds/leds/led0/brightness'
echo 255 > '/sys/devices/platform/leds/leds/led1/brightness'
```

## Via the simple-server-python application

- [Flask Quickstart](http://flask.pocoo.org/docs/0.12/quickstart/)
- [Basic GPIO with Python on Resin](https://github.com/resin-io-projects/resin-rpi-gpio-sample-with-python)

I have never written flask in my life, but it looks easy. I wanted to make it
as simple as possible to start with and so I used the file access rather than
`import GPIO from RPi` as was done in GPIO example.

In about 15-30 min I added the ability to set the 'brightness' on the led0/led1
of the RPI from the web. By enabling the "Public URL" I now have access from
anywhere in the world at a url like:
`https://c597e63dd91f97a978af9d00c8863f56.resindevice.io/led/led0/255`

