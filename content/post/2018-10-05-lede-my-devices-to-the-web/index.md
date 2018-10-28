+++
title = "LEDE My Devices To The Web"
date = 2018-10-05
draft = false

tags = [
    "lede",
    "linux",
    "openwrt",
]
categories = []
+++

## Context

I live in an apartment complex that has a WIFI network that uses MAC address
white-listing to grant internet connectivity. This becomes an issue for an IOT
hobbyist such as myself. Often these devices assume they only need to be given
a SSID and passkey to connect to the internet.

## Lucus: Connecting Worlds

Lucus is a Linksys WRT3200ACM (
[linksys](https://www.linksys.com/us/p/P-WRT3200ACM/),
[openwrt](https://openwrt.org/toh/hwdata/linksys/linksys_wrt3200acm)
), a strong, ARMv7 router with 4 antennas and 2 radios. This router is a strong
choice for anyone hoping to explore the OpenWRT/LEDE project. Currently I am
running the most recent firmware, OpenWrt 18.06.1 with 4.14.63 kernel.

He is tasked with the following responsibilities:

- Act as a client to my apartment's WIFI (WWAN via wlan0)
- DHCP server for my private subnet (LAN)
- Hosting Wireless AP (access point) to my private subnet (LAN via wlan2)
- Bridge my LAN to the WWAN (wlan2+eth0 via br-lan)

## Tarra: Helping how she can

Tarra is a slightly older router, TP-Link TL-WR841ND (
[tp-link](https://www.tp-link.com/us/download/TL-WR841ND_V9.html),
[openwrt](https://wiki.openwrt.org/toh/tp-link/tl-wr841nd)
). She simply acts as a dumb AP to provide additional Ethernet access to my
private subnet. She is stuck on an older release, OpenWrt Chaos Calmer 15.05.1
with 3.18.23 kernel.

These guides were referenced to configure Tarra:

- [dumbap](https://wiki.openwrt.org/doc/recipes/dumbap)
- [bridgeap](https://wiki.openwrt.org/doc/recipes/bridgedap)
