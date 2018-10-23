+++
title = "Yocto Source Mirror"
date = 2018-04-28T05:20:09Z

tags = [
  "bitbake",
  "yocto",
]
categories = []

# [header]
# image = ""
# caption = ""
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
(in this case, core-image-minimal). Note that this step is version dependent.
The change is sumarized [here](https://www.yoctoproject.org/docs/2.5/ref-manual/ref-manual.html#migration-2.5-bitbake-changes).

```
# Prior to Yocto 2.4:
bitbake core-image-minimal -c fetchall
# Yocto 2.5 and later:
bitbake core-image-minimal --runall="fetch"
```

Copy the resulting files into the directory you would like as the source mirror.
```
cp -t /mnt/downloads/ /tmp/workdir/build/downloads/*
```

### References

[bitbake v2.5 usage and syntax](https://www.yoctoproject.org/docs/2.5/bitbake-user-manual/bitbake-user-manual.html#usage-and-syntax)

```
bitbake -h
...
       --runall=RUNALL       Run the specified task for any recipe in the taskgraph
                             of the specified target (even if it wouldn't otherwise
                             have run).
       --runonly=RUNONLY     Run only the specified task within the taskgraph of
                             the specified targets (and any task dependencies those
                             tasks may have).
```



