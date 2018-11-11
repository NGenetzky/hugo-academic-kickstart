+++
title = "Setup new NVMe Disk with multi boot UEFI"
date = 2018-02-04
draft = false

tags = [
  "partition",
  "uefi",
  "windows",
]
categories = []
+++

# Installing Windows

* [Rufus](http://rufus.akeo.ie)

Downloaded Educational version of Windows 10. Created a bootable drive with Rufus.

## Issues with UEFI vs Legacy/CSM boot

When I was first trying I had UEFI boot disabled in my BIOS. This meant that
the Windows live boot was unable to create the paritions as desired. The error
message was not very helpful at all, and so I had plenty of fun exploring other
solutions before I found the right one.

## Shrinking Windows

Using Disk Management I was only able to shrink the drive to 250 GB. I disabled
pagefile and hibernation features, utilitized Disk Cleanup and Disk Defrag and
yet it still wouldn't let me shrink it. Finally I resorted to using a third
party tool, MiniTool. It worked like a charm and was much more intuitive than
the tools provided by Windows.

# Migrating Ubuntu install from old parition

* [How to Migrate Ubuntu installed on a LVM Logical Volume from a MBR disk to a
  GPT disk on non-(U)EFI hardware without data
  loss](https://help.ubuntu.com/community/How%20to%20Migrate%20Ubuntu%20installed%20on%20a%20LVM%20Logical%20Volume%20from%20a%20MBR%20disk%20to%20a%20GPT%20disk%20on%20non-%28U%29EFI%20hardware%20without%20data%20loss)

This part was made so easy because my old parition was using LVM. There are many good
articles for reference.

