+++
title = "LVM Physical Volume Replacement"
date = 2018-10-23T00:00:00Z
tags = [
  "lvm",
]
categories = []
+++


## Resize, Reduce and Remove

Note that this section has extra complexity because I had to shrink the FS so
that I could remove one of my SSDs. PV migration is much easier if you can
allocate the new PV before removing the old ones.

1. Resize FS
2. Reduce LV
3. Move PV
4. Reduce VG
5. Resize FS

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

## Partition New Drive

{{< figure src="./gparted-screenshot.png" link="./gparted_details.html" >}}

```
→ blkid | grep nvme0n1
/dev/nvme0n1p1: UUID="5C98-C744" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="3e6b049d-cd95-4878-b6e6-1a65e1aa5472"
/dev/nvme0n1p2: UUID="1DBfWd-vRcl-IDvO-uddd-7XDG-lCW0-N1URv5" TYPE="LVM2_member" PARTLABEL="pv-0" PARTUUID="9b252b0c-ae40-4823-b6eb-77705bd3cdf7"
/dev/nvme0n1p3: UUID="bWGo5P-tCAa-DDkS-ugaG-5hm0-he8H-HCykBL" TYPE="LVM2_member" PARTLABEL="pv-1" PARTUUID="1e0be258-0e9b-4fe5-8b47-35bbc277955b"
/dev/nvme0n1p4: UUID="wzEteP-Ti1C-rihY-icdI-mOdb-w0cv-9xUrUL" TYPE="LVM2_member" PARTLABEL="pv-2" PARTUUID="29b8ae91-23a2-4918-a2df-0f1fe27c553a"
/dev/nvme0n1p5: UUID="ZeeoVn-G11l-d2Dv-tD9C-ki4X-58uG-IQJXSZ" TYPE="LVM2_member" PARTLABEL="pv-3" PARTUUID="d72fd476-51e6-46a4-94f0-9fb747ee66ba"
/dev/nvme0n1p6: UUID="BlEuOU-83JI-FSJH-6xJS-ycnk-hpey-hxssZM" TYPE="LVM2_member" PARTLABEL="pv-4" PARTUUID="444a4c0d-5a43-4ff7-b821-75429338254c"
/dev/nvme0n1p7: UUID="166ff7ee-17be-44ad-b1dd-b30dbb1c2d28" TYPE="swap" PARTLABEL="swap" PARTUUID="92b08275-c921-46a5-aca9-fb23cc548a9a"
```

## Extend VG, Remove PV

```
→ sudo pvs
  PV             VG        Fmt  Attr PSize   PFree 
  /dev/nvme0n1p2           lvm2 ---   97.66g 97.66g
  /dev/nvme0n1p3           lvm2 ---   97.66g 97.66g
  /dev/nvme0n1p4           lvm2 ---   97.66g 97.66g
  /dev/nvme0n1p5           lvm2 ---   97.66g 97.66g
  /dev/nvme0n1p6           lvm2 ---   56.02g 56.02g
  /dev/nvme1n1p6 ubuntu-vg lvm2 a--  120.00g  8.71g
  /dev/nvme1n1p7 data-vg   lvm2 a--  120.00g     0 
  /dev/nvme1n1p9 ubuntu-vg lvm2 a--   64.76g     0 

→ sudo vgextend data-vg /dev/nvme0n1p2
  Volume group "data-vg" successfully extended

→ sudo vgextend data-vg /dev/nvme0n1p3
  Volume group "data-vg" successfully extended

→ sudo pvmove /dev/nvme1n1p7
  /dev/nvme1n1p7: Moved: 0.0%
  /dev/nvme1n1p7: Moved: 9.1%
  /dev/nvme1n1p7: Moved: 18.3%
  /dev/nvme1n1p7: Moved: 25.4%
  /dev/nvme1n1p7: Moved: 32.6%
  /dev/nvme1n1p7: Moved: 39.9%
  /dev/nvme1n1p7: Moved: 47.1%
  /dev/nvme1n1p7: Moved: 54.2%
  /dev/nvme1n1p7: Moved: 61.3%
  /dev/nvme1n1p7: Moved: 68.5%
  /dev/nvme1n1p7: Moved: 75.8%
  /dev/nvme1n1p7: Moved: 81.4%
  /dev/nvme1n1p7: Moved: 89.3%
  /dev/nvme1n1p7: Moved: 96.8%
  /dev/nvme1n1p7: Moved: 100.0%

→ sudo vgreduce data-vg /dev/nvme1n1p7
  Removed "/dev/nvme1n1p7" from volume group "data-vg"

→ sudo pvs
  PV             VG        Fmt  Attr PSize   PFree  
  /dev/nvme0n1p2 data-vg   lvm2 a--   97.65g      0 
  /dev/nvme0n1p3 data-vg   lvm2 a--   97.65g  75.31g
  /dev/nvme0n1p4           lvm2 ---   97.66g  97.66g
  /dev/nvme0n1p5           lvm2 ---   97.66g  97.66g
  /dev/nvme0n1p6           lvm2 ---   56.02g  56.02g
  /dev/nvme1n1p6 ubuntu-vg lvm2 a--  120.00g   8.71g
  /dev/nvme1n1p7           lvm2 ---  120.00g 120.00g
  /dev/nvme1n1p9 ubuntu-vg lvm2 a--   64.76g      0 
```

## Extend LV and Resize FS 

```
→ sudo umount /dev/data-vg/data

→ sudo lvextend -r -l +100%FREE /dev/data-vg/data
fsck from util-linux 2.27.1
/dev/mapper/data--vg-data: clean, 383756/7864320 files, 22672979/31456256 blocks
  Size of logical volume data-vg/data changed from 120.00 GiB (30719 extents) to 195.30 GiB (49998 extents).
  Logical volume data successfully resized.
resize2fs 1.42.13 (17-May-2015)
Resizing the filesystem on /dev/mapper/data--vg-data to 51197952 (4k) blocks.
The filesystem on /dev/mapper/data--vg-data is now 51197952 (4k) blocks long.

→ sudo mount /dev/data-vg/data
```

