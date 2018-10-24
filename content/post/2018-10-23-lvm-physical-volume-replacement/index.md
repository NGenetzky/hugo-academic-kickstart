+++
title = "LVM Physical Volume Replacement"
date = 2018-10-23T00:00:00Z
draft = true
tags = [
  "lvm",
]
categories = []
+++

```
→ sudo umount /dev/data-vg/data
→ sudo e2fsck -f /dev/data-vg/data                                                                                                                                                                                                     
e2fsck 1.42.13 (17-May-2015)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/data-vg/data: 383754/15163392 files (0.3% non-contiguous), 23129959/60635136 blocks
→ sudo resize2fs /dev/data-vg/data 100G
resize2fs 1.42.13 (17-May-2015)
Resizing the filesystem on /dev/data-vg/data to 26214400 (4k) blocks.
The filesystem on /dev/data-vg/data is now 26214400 (4k) blocks long.
→ sudo lvreduce -l 30719 /dev/data-vg/data
  WARNING: Reducing active logical volume to 120.00 GiB
  THIS MAY DESTROY YOUR DATA (filesystem etc.)
Do you really want to reduce data? [y/n]: y
  Size of logical volume data-vg/data changed from 231.30 GiB (59214 extents) to 120.00 GiB (30719 extents).
  Logical volume data successfully resized.
→ sudo pvmove /dev/disk/by-id/nvme-Force_MP500_174579940001224101F7-part5  /dev/disk/by-id/nvme-Samsung_SSD_960_EVO_500GB_S3X4NF0JB20800X-part7
  No free extents on physical volume "/dev/nvme1n1p7".
  No specified PVs have space available.
→ sudo vgreduce data-vg /dev/disk/by-id/nvme-Force_MP500_174579940001224101F7-part5
  Removed "/dev/nvme0n1p5" from volume group "data-vg"
→ sudo e2fsck -f /dev/data-vg/data
e2fsck 1.42.13 (17-May-2015)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/data-vg/data: 383756/6553600 files (0.6% non-contiguous), 22590739/26214400 blocks
→ sudo resize2fs /dev/data-vg/data
resize2fs 1.42.13 (17-May-2015)
Resizing the filesystem on /dev/data-vg/data to 31456256 (4k) blocks.
The filesystem on /dev/data-vg/data is now 31456256 (4k) blocks long.
```
