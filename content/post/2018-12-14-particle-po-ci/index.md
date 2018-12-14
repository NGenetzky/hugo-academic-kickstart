+++
title = "Particle PO CI"
date = 2018-12-14
draft = false
tags = [
  "ci",
  "cpp",
  "particle",
]
categories = [
  "hobby-electronics",
]
+++

## Container / Virtualization

gitlab-ci uses a docker container.

```yaml
# use the official gcc image, based on debian
# can use verions as well, like gcc:5.2
# see https://hub.docker.com/_/gcc/
image: gcc
```

Travis CI on the other hand uses ["sudo enabled, full virtual machine per
build"](https://docs.travis-ci.com/user/reference/overview/).

```yaml
dist: trusty
sudo: required
language: generic
```

## Install / Bootstrap

Before doing the build we need to set up the build environment. While this
isn't that difficult to do from scratch there is an existing project,
[po-util](https://github.com/nrobinson2000/po), that will do the job.

```yaml
build:
  stage: build
  before_script: 
    - ci/po-install.sh
```

```yaml
install:
  - ci/po-install.sh
```

The `po-install.sh` is not very complex but to summarize it does the
following things:

- Installs prerequistes for scripts
- Installs scripts from [po-util](https://github.com/nrobinson2000/po)
- Configures settings for po, or loads those stored in the repo.
- `po install` which ensures we have all tools and libraries required for the
  build.

Note: For travis-ci you can cache the `~/.po-util/` directory to speed up
subsequent builds:

```yaml
cache:
  directories:
  - $HOME/.po-util
```

## po-config

This configuration (stored at `~/.po-util/config`) contains variables used by
the `po` script.

```bash
BASE_DIR="${HOME}/.po-util/src"
PARTICLE_FIRMWARE_URL='https://github.com/particle-iot/firmware.git'
FIRMWARE_PARTICLE="${HOME}/.po-util/src/particle"
FIRMWARE_DUO="${HOME}/.po-util/src/redbearduo"
FIRMWARE_PI="${HOME}/.po-util/src/pi"
export PARTICLE_DEVELOP=1
BRANCH='release/stable'
BRANCH_DUO='duo'
AUTO_HEADER=false
```

## Build

This is where we get to the real build.

gitlab-ci:

```yaml
build:
  stage: build
  script: 
    - ci/gitlab_build.sh
```

travis-ci:

```yaml
script:
  - ci/po-build.sh
```

This is where `po` hides some of the complexity, but it also places certain
requirements on the structure of your project. One of these requirements is
that your firmware is in `./firmware/` rather than `./src/`, which is what
Particle recommends in their project template.


```bash
po photon build
```

## Deploy

I found it very easy to deploy artifacts of the build stage in gitlab-ci, but
I have not yet implemented it for travis-ci. Ideally I would like this to
only deploy the final `bin` for each of the device types that I built, but
this will require a little more scripting.

```yaml
build:
  stage: build
  artifacts:
    paths:
      - bin/
    when: on_success
    expire_in: 30 days
```

