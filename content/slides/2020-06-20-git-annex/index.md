---
title: "Git-Annex"
authors: [ "nathan-genetzky" ]
tags:
- "bash"
- "git"
- "git-annex"
- "meetup"
- "penguins-unbound"
- "python"
- "sh"
- "shell"
categories: []
date: "2020-06-20"
slides:
  theme: black
  highlight_style: dracula
---

{{% section %}}

# Git Annex

Nathan Genetzky

2020-06-20

---

### Goal

- Provide a high level introduction of what git-annex is.
- Compare and contrast the different ways git-annex can be used.
- Convince 25% of audience try using git-annex
- Provide a plethora of resources for future investigation

{{% /section %}}

---

{{% section %}}

## Introduction to git-annex

---

### Background on the Author

Joey Hess really likes git.

- etckeeper
- Ikiwiki
- git-annex

---

### From the Author

---

### git-annex quick start

- [install](https://git-annex.branchable.com/install/)
  - [Android](https://git-annex.branchable.com/Android/)
  - debian: `apt-get install git-annex`
- [walkthrough](https://git-annex.branchable.com/walkthrough/)

{{% /section %}}

---

{{% section %}}

## git-annex can be used in many different ways

---

### git-annex without any annexed files

---

### git-annex can be overwhelmingly automated

---

### git-annex flexible configuration and manual usage

{{% /section %}}

{{% section %}}

## git-annex configuration

---

### git config vs git annex config

---

### gitignore

```shell
# Ignore everything
*
# But descend into directories
!*/
# Recursively allow files under subtree
!/subtree/**
```

---

### gitattributes

{{% /section %}}

---

{{% section %}}

## git-annex handles large files and metadata

---

### Configure which files go into annex

- [git-annex-matching-expression](https://git-annex.branchable.com/git-annex-matching-expression/)
- [largefiles](https://git-annex.branchable.com/tips/largefiles/)

---

### backends - simple

Simple Recommendation: Default to MD5E

---

### backends - file ext in hash

```shell
$ touch a a.b a.b.c a.b.c.d
$ git-annex add .
add a ok
add a.b ok
add a.b.c ok
add a.b.c.d ok
$ git-annex lookupkey *
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.b
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.b.c
SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.c.d
```

---

### Metadata

- generate
- views

---

### Find annex files

```shell
# Find mp3 files in either of two repositories that have less than 3 copies:
git annex find \
    --not --exclude '*.mp3' --and \
    -\( --in usbdrive --or --in archive -\) --and \
    --not --copies 3
```

{{% /section %}}

---

{{% section %}}

## git-annex automates git operations and file transfers

---

### git-annex can automate the movement of files

---

### preferred content - Configure which files should move and where

---

### preferred content - Practical example

- `(A)` camera is "source" of photos
- `(B)` laptop connected to camera is "client"
- `(C)` external hard-drive is "archive"
- `(D)` web server is "public"

- `(A)->(B)`: Always
- `(B)->(C)`: if file is placed in "archive/" directory
- `(B)->(D)`: if file is placed in "public/" directory

{{% /section %}}

---

{{% section %}}

## Sharing files from git-annex with git

---

### via git on computer in your network

- via SSH
- via HTTP

---

### via Gogs, a git-annex compatible git server

- Gogs on your server or computer
- Gogs provided by [gin.g-node.org](https://gin.g-node.org/)
- Gogs on an embedded device

{{% /section %}}

---

{{% section %}}

## Sharing files from git-annex with Special Remotes

- Only work with annexed files
- encryption

---

### Special Remotes - Cloud services

- git-lfs
- rclone
- S3

---

### Special Remotes - local usage

- directory
- rsync
- adb

---

### Special Remotes - Bring your Own

{{% /section %}}

---

{{% section %}}

## Other tools that work with git-annex

---

### Datalad handles publication and reproduction at scale

---

### git-annex metadata GUI

---

### git-annex-adapter - use from python

---

### recastex - manage podcasts

---

### pre-commit-annex for extract and exiftool

---

### AnnexRemote

---

### Firefox plugin FlashGot - download manager

{{% /section %}}

---

## Conclusion
