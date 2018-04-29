+++
title = "Yocto Source Mirror"
date = 2018-04-28T05:20:09Z
draft = false

tags = []
categories = []

[header]
image = ""
caption = ""
+++

## Mirror of Downloads
References:
- [Efficiently Fetching Source Files During a Build](https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#efficiently-fetching-source-files-during-a-build).
- [TipsAndTricks/TeamWorkflows](https://wiki.yoctoproject.org/wiki/TipsAndTricks/TeamWorkflows)

### Using a SOURCE_MIRROR

```
SOURCE_MIRROR_URL ?= "file:///mnt/downloads/"
INHERIT += "own-mirrors"
# Use this when generating the mirror:
#BB_GENERATE_MIRROR_TARBALLS = "1"
# Use this to test the mirror:
#BB_NO_NETWORK = "1"
```

### Prepare the source mirror

Add the following line to local.conf: 
```
BB_GENERATE_MIRROR_TARBALLS = "1"
```

Then run the following to perform every fetch task needed to build the target
(in this case, core-image-minimal).

Note that this step is version dependent.

> We removed the fetchall and checkuriall tasks, "bitbake X --runall=fetch" and
> "bitbake X --runall=checkuri" replace them. --runonly option added to bitbake
> which behaves like the older --runall option.

```
# Yocto 2.5 and later:
bitbake core-image-minimal --runall="fetch"
```

Copy the resulting files into the directory you would like as the source mirror.
```
cp -t /mnt/downloads/ /tmp/workdir/build/downloads/*
```


