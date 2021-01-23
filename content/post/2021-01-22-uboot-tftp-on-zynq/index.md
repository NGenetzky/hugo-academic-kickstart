---
title: "U-boot TFTP on Zynq"
date: 2020-01-22
draft: false
authors: ["Nathan Genetzky"]
categories: ["dojofive"]
tags:
- fpga
- tftp
- u-boot
- xilinx
- zynq
---

## Intro

Often when working with Embedded Linux devices it can be helpful to utilize
TFTP from u-boot. It can be used to quickly test changes in the kernel and
other components. It can also be used to program persistent storage.

## Example

I would like to explain a string of commands for u-boot. Not long ago it was
all black magic to me, and I would have liked someone to explain it to me.

```sh
usb start ; env set autoload no ; dhcp ; env set serverip 192.168.1.116 ; env set bitstream_addr 0x4000000 ; tftpboot ${bitstream_addr} download.bit.bin ; fpga load 0 ${bitstream_addr} ${filesize} ; pxe get ; pxe boot
```

### Connecting to TFTP

Let's start with connecting to the correct TFTP server.

```sh
1. usb start
2. env set autoload no
3. dhcp
4. env set serverip 192.168.1.116
```

In this scenario we are using a USB to Ethernet adapter (1a). We have a DHCP
server (3a), but it does not contain the files we wish to download. We tell
u-boot to request an address, but to not "autoload" a file from the server
(2a).

After successfully performing "DHCP" (3b) there will be a new environment
variable set that indicates the IP of the board. The "serverip" variable will
also be set to the address of the DHCP server (3c). We must overwrite this
value with the IP of the server that is hosting the files of interest (4)

### u-boot addresses

In u-boot you will often be interacting with "variables", as seen above, or
directly with blocks of memory. The overall goal is to put the write things
into the right memory location and then execute a command that will utilize
those segments of memory (8a,10a).

To a certain degree the addresses assigned to variables can be chosen. It is
important to consider the size and scope of the files you need in memory. In
many cases a number of standard variables are defined reasonable spacing
between.

```sh
6. env set bitstream_addr 0x4000000
7. tftpboot ${bitstream_addr} download.bit.bin
8. fpga load 0 ${bitstream_addr} ${filesize}
```

First we are choosing a region to place the binary bitstream (6). Next we are
going to download a file named "download.bit.bin" form our TFTP server (7).
It is important to note that we do not have to specify the IP of the server
because the value of ${serverip} get's used by defualt (7). We could easily
override it (in this case `tftpboot ${bitstream_addr}
192.168.1.116:download.bit.bin`. Many commands that process files will set
the "${filesize}" variable; which in this case we provide to the command that
needs to use this region (8).

### PXE Boot

```sh
9. pxe get
10. pxe boot
```

PXE boot is a extension of DHCP (and therefore TFTP) that provides more
control of which files are provided to which devices (based on MAC address).
The first command simply downloads the script file into a particular region
of memory (9) "${scriptaddr}.

The next part (10b) will parse the "pxelinux"/"extlinux" file from the
server. There can be multiple options in each config file.
