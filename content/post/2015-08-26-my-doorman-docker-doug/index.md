+++
title = "My Doorman, Docker Doug"
description = ""
tags = [
    "ifttt",
    "particle",
    "pushbullet",
    "python",
    "rpi",
    "ifttt",
    "docker",
]
date = "2015-08-26"
+++

I recently added a new member to my team. Doug is a Raspberry Pi that lives
near my router. Unfortunately Doug will not quite open my door for me (yet) but
he will notify me when my door opens or my door closes. The entire process is
very flexible, but is a team effort.

How does Doug do it? Doug uses a reed switch to detect if the door is open or
closed. When the door is opened or closed he will notify Matt, a Photon
Particle, that the event occurred. This is done through the restful API defined
by Particle. Matt will then broadcast an event, either "doug/door/open" or
"doug/door/close". IFTTT will react to the event by sending me a push
notification through Pushbullet.

So why is he "Docker" Doug? Doug runs Docker. This means that Doug has little
to no job security. If he crashed tomorrow it would be three simple steps to
replace him. 1. Download image configured for Docker (thanks to Hypriot). 2.
Download and run the docker image. 3. Install and run the Python script.

So what's in store for Doug in the future? A LCD character display could be
mounted outside the door to provide information to people visiting my home. A
webcam could be installed outside the door and it would allow visitors to leave
a message if I was not home or act as a security device. A PIR sensor could be
installed to detect if someone was outside my door, and this could be used as a
way to trigger the security web cam to start recording. A electric door strike
could be installed to allow my door to be locked or unlocked remotely by
authorized users.

(Originally posted July 26, 2015 at nathan.genetzky.us/projects/my-doorman-docker-doug)
