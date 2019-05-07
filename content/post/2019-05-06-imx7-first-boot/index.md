+++
title = "IMX7 First Boot"
date = 2019-05-06T23:07:15-05:00
draft = false
tags = []
categories = []
[image]
  caption = ""
  focal_point = ""
+++

## New family member, SBC-iMX7!

CompuLab 0815
SB-SOM Rev1.1 188C02751

Resources:

- [SBC-iMX7 - NXP i.MX 7 Single Board Computer](https://www.compulab.com/products/sbcs/sbc-imx7-freescale-i-mx-7-single-board-computer/)
- [Specifications](https://www.compulab.com/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/#specs)
- [CL-SOM-iMX7 reference guide](https://www.compulab.com/wp-content/uploads/2018/03/cl-som-imx7_reference-guide_2018-03-27.pdf)
- [CL-SOM-iMX7: Evaluation Kit: Getting Started](https://mediawiki.compulab.com/index.php/CL-SOM-iMX7:_Evaluation_Kit:_Getting_Started)
- [Resources](https://www.compulab.com/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/#devres)

## First boot!

#### Find the power supply

- [connector J6](https://mediawiki.compulab.com/w/index.php?title=SB-SOM:_Connectors:_J6_and_J8)
- Minimum Typical Maximum = 5.3V 12V 16V

I found a 12V 1A DC power supply, and just happend to have a DC adapter kit.

#### CL-SOM-iMX7: Evaluation Kit: Getting Started

- [CL-SOM-iMX7: Evaluation Kit: Getting Started](https://mediawiki.compulab.com/index.php/CL-SOM-iMX7:_Evaluation_Kit:_Getting_Started)

{{<
    figure src="https://mediawiki.compulab.com/w/images/c/cb/SB_SOM_topview2.jpg"
    title="SB-SOM top view"
>}}


#### U-Boot fails to mount filesystem

Trouble in paradise


```
→ kermit -l /dev/ttyUSB1 -b 115200 -c
Connecting to /dev/ttyUSB1, speed 115200
 Escape character: Ctrl-\ (ASCII 28, FS): enabled
Type the escape character followed by C to get back,
or followed by ? to see other options.
----------------------------------------------------
U-Boot SPL 2015.04-cl-som-am57x-0.80 (Dec 21 2015 - 12:30:11)
DRA752 ES1.1
Trying to boot from SPI


U-Boot 2015.04-cl-som-am57x-0.80 (Dec 21 2015 - 12:30:11)

CPU  : DRA752 ES1.1
Board: CL-SOM-AM57x
I2C:   ready
DRAM:  2 GiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
SF: Detected M25PX16 with page size 256 Bytes, erase size 64 KiB, total 2 MiB, mapped at 5c000000
PCB:   1.0
SCSI:  SATA link 0 timeout.
AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
flags: 64bit ncq stag pm led clo only pmp pio slum part ccc apst 
scanning bus for devices...
Found 0 device(s).
Net:   cpsw
Hit any key to stop autoboot:  0 
MMC: no card present
switch to partitions #0, OK
mmc1(part 0) is current device
Failed to mount ext2 filesystem...
** Unrecognized filesystem type **
Unknown command 'nand' - try 'help'
U-Boot# 
```

## Yocto Linux Image 

- [2019/01/cl-som-imx7_yocto-linux_2019-01-27.zip](https://www.compulab.com/wp-content/uploads/2019/01/cl-som-imx7_yocto-linux_2019-01-27.zip)
- [Package contents](https://mediawiki.compulab.com/w/index.php?title=CL-SOM-iMX7:_Yocto_Linux:_Package_contents)
- [Live SD card](https://mediawiki.compulab.com/w/index.php?title=CL-SOM-iMX7:_Yocto_Linux:_Creating_Live-SD_card)

So I used [Etcher](https://www.balena.io/etcher/) to burn a microsd with
`cl-som-imx7-image-qt5.sdcard.bz2`. Note that P6, the SD Card slot is used for
boot.

Alternatively we can use bzcat:

```
→ bzcat ./cl-som-imx7-yocto-linux/images/cl-som-imx7-image-qt5.sdcard.bz2 | sudo dd of=/dev/sdd bs=1M ; sync                                                 
0+310393 records in
0+310393 records out
1556086784 bytes (1.6 GB, 1.4 GiB) copied, 121.705 s, 12.8 MB/s
```

## U-Boot Upgrade

- [CL-SOM-iMX7_NXP_i.MX7_U-Boot](https://mediawiki.compulab.com/index.php/CL-SOM-iMX7_NXP_i.MX7_U-Boot)

Ehhhh, I'm a bit scared. I'll wait.


##  Linux

- [Creating_Live-SD_card](https://mediawiki.compulab.com/w/index.php?title=CL-SOM-iMX7:_Linux:_Creating_Live-SD_card)

