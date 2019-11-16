---
title: Gitlab CI Simple but Flexible
summary: Gitlab-CI is an amazing platform that makes CI pipelines simple and easy.
authors: [ "nathan-genetzky" ]
tags:
- "ci"
- "devops"
- "gitlab"
- "gitlab-ci"
categories: []
date: "2019-11-16"
slides:
  theme: black
  highlight_style: dracula
---

# Gitlab CI Simple but Flexible

Nathan Genetzky

---

Gitlab-CI is an amazing platform that makes CI pipelines simple and easy.
Don't worry if you don't use gitlab to host your repository, there is still
hope!

---

## Topics

- Don't RM RF, Shellcheck that sh library
- Using docker buildpack to build microcontroller firmware
- Using Google Test Framework (GTest) to test C or C++

---

## Don't RM RF, Shellcheck that sh library

Let's start with a simple CI pipeline that utilizes [shellcheck][] to protect
a Github project from containing shell scripts that violate good practices.

---

I believe this is a great place to start for multiple reasons:

1. Almost every project contains shell scripts
2. It's easy to make silly mistakes, and most scripts are not written by
posix/bash experts
3. Not everyone is using gitlab to host their projects.

---

Use these links to guide you through connecting gitlab and github:

- [ci_cd_for_external_repos/github_integration](https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/github_integration.html)
- [tokens/new](https://github.com/settings/tokens/new)
- [import/github/new?ci_cd_only=true](https://gitlab.com/import/github/new?ci_cd_only=true)

---

Although the gitlab-ci integration added to shlib was very simple it can
serve to demonstrate some core features:

1. Each "job" can run in a docker container that is from a docker image of
our choice.
2. The `script` attribute can be shell commands, or an executable script.

---

`gitlab-ci.yaml`:

```yaml
test-shellcheck:
  stage: test
  image: ubuntu:18.04
  script:
  - apt-get update && apt-get install shellcheck
  - scripts/test-shellcheck.bash
```

This is the key part of `scripts/test-shellcheck.bash`:

```bash
find ./* \
  \( -iname '*.bash' -or -iname '*.sh' \) \
  -exec shellcheck "$@" {} +
```

---

## Using docker buildpack to build microcontroller firmware

---

Next we will use a docker image to compile microcontroller applications for
the Particle family of devices. I added this to one of my trivial projects,
and isolated it into a single PR.

- image from
[dockerhub](https://hub.docker.com/r/particle/buildpack-particle-firmware)
- created from
[particle-iot/firmware-buildpack-builder](https://github.com/particle-iot/firmware-buildpack-builder)
- example usage in
[particle-project-serial-pub-sub/merge_requests/1](https://gitlab.com/NGenetzky/particle-project-serial-pub-sub/merge_requests/1)

---

`gitlab-ci`:

```yaml
particle_build:
  stage: build
  image: particle/buildpack-particle-firmware:1.4.2-xenon
  variables:
    PLATFORM: xenon
    PARTICLE_BUILD_IN: src/
    PARTICLE_BUILD_OUT: build/
    # -Werror: Make all warnings into errors.
    CFLAGS: '-Werror'
  script:
    - ci/particle_build.bash
  artifacts:
    paths:
      - build/
```

---

We have added environment variables to interact with the buildpack, and we
have indicates the locations of the artifacts produced by the buildpack.

There are also many predefined variables that are injected into the
environment including metadata about the  project, build, and job.

- [Predefined environment variables reference](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html)

---

## Using Google Test Framework (GTest) to test C or C++

---

The next example is a derivative work; I forked this project and added
gitlab-ci support. gtest-demo: "C/C++ unit test demo using Google Test
deployed to Travis-CI with test coverage deployed to Coveralls".

- Upstream project: [gtest-demo](https://github.com/bast/gtest-demo)
- GTest Demo thanks to [Radovan Bast](https://github.com/bast).
- Container Travis setup thanks to [Joan Massich](https://github.com/massich).
- Clean-up in CMake code thanks to [Claus Klein](https://github.com/ClausKlein).

---

The changes necessary to use this demo with gitlab are identified in a single
PR. The dockbuild, from the [dockcross][] project, is a key part of this
example. With the images provided by that project we could quickly test again
a matrix of different architectures and GCC versions. Also, by using an
existing docker image you cut down the build time required to install the
packages.

- [gtest-demo/merge_requests/1](https://gitlab.com/ngenetzky-dojofive/gtest-demo/merge_requests/1)
- [dockcross][]

---

Key part of `.gitlab-ci.yml`:

```yaml
u1804-gtest:
  stage: test
  image: dockbuild/ubuntu1804-gcc7:latest
  script:
    - ci/gitlab_gtest.sh
  artifacts:
    paths:
      - build/
    expire_in: 30 days
```

Key part of `ci/gitlab_gtest.sh`:

```bash
cmake -H. -Bbuild
cd build
cmake --build .
ctest
```

[shellcheck]: https://github.com/koalaman/shellcheck
[dockcross]: https://github.com/dockcross/dockcross
