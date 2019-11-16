---
title: "Gitlab-CI Simple but Flexible"
event: "Penguins Unbound: November 2019 Meeting"
event_url: "https://www.meetup.com/PenguinsUnbound/events/258009156/"
location: "Roseville, MN, USA"
summary: Gitlab-CI is an amazing platform that makes CI pipelines simple and easy.
# abstract:
draft: false
date: 2019-11-16T10:00:00
date_end: 2019-11-16T12:00:00
publishDate: "2019-11-12"
authors: [ "nathan-genetzky" ]
tags:
- "ci"
- "devops"
- "gitlab"
- "gitlab-ci"

featured: true
links:
- name: slides
  url: "slides/2019-11-16-gitlab-ci-simple-but-flexible"
  icon_pack: fas
  icon: chalkboard
# url_slides:
# url_code:
# url_pdf:
# url_video:
projects: []
---

Gitlab-CI is an amazing platform that makes CI pipelines simple and easy.
Don't worry if you don't use gitlab to host your repository, there is still
hope!

## Don't RM RF, Shellcheck that sh library

Let's start with a simple CI pipeline that utilizes [shellcheck][] to protect
a Github project from containing shell scripts that violate good practices. I
believe this is a great place to start for multiple reasons:

1. Almost every project contains shell scripts
2. It's easy to make silly mistakes, and most scripts are not written by
posix/bash experts
3. Not everyone is using gitlab to host their projects.

Use these links to guide you through connecting gitlab and github:

- [ci_cd_for_external_repos/github_integration](https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/github_integration.html)
- [tokens/new](https://github.com/settings/tokens/new)
- [import/github/new?ci_cd_only=true](https://gitlab.com/import/github/new?ci_cd_only=true)

Although the gitlab-ci integration added to shlib was very simple it can
serve to demonstrate some core features:

1. Each "job" can run in a docker container that is from a docker image of
our choice.
2. The `script` attribute can be shell commands, or an executable script.

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

## Using docker buildpack to build microcontroller firmware

Next we will use a docker image to compile microcontroller applications for
the Particle family of devices. I added this to one of my trivial projects,
and isolated it into a single PR.

- image from
[dockerhub](https://hub.docker.com/r/particle/buildpack-particle-firmware)
- created from
[particle-iot/firmware-buildpack-builder](https://github.com/particle-iot/firmware-buildpack-builder)
- example usage in
[particle-project-serial-pub-sub/merge_requests/1](https://gitlab.com/NGenetzky/particle-project-serial-pub-sub/merge_requests/1)
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

We have added environment variables to interact with the buildpack, and we
have indicates the locations of the artifacts produced by the buildpack.

There are many predefined variables that are injected into the environment.

- [Predefined environment variables reference](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html)

Note that most of the complexity hidden behind the buildpack. Buildpacks
exist for a wide variety of projects.
[(IBM Cloud Docs Buildpacks)](https://cloud.ibm.com/docs/runtimes-common?topic=runtimes-common-available_buildpacks)


## Using Google Test Framework (GTest) to test C or C++

The next example is a derivative work; I forked this project and added
gitlab-ci support. gtest-demo: "C/C++ unit test demo using Google Test
deployed to Travis-CI with test coverage deployed to Coveralls".

- Upstream project: [gtest-demo](https://github.com/bast/gtest-demo)
- GTest Demo thanks to [Radovan Bast](https://github.com/bast).
- Container Travis setup thanks to [Joan Massich](https://github.com/massich).
- Clean-up in CMake code thanks to [Claus Klein](https://github.com/ClausKlein).

The changes necessary to use this demo with gitlab are identified in a single
PR. The dockbuild, from the [dockcross][] project, is a key part of this
example. With the images provided by that project we could quickly test again
a matrix of different architectures and GCC versions. Also, by using an
existing docker image you cut down the build time required to install the
packages.

- [gtest-demo/merge_requests/1](https://gitlab.com/ngenetzky-dojofive/gtest-demo/merge_requests/1)
- [dockcross][]

Here is the `.gitlab-ci.yml`:

```yaml
gtest:
  stage: test
  image: gcc
  before_script:
    - ci/gitlab_gtest_pre.sh
  script:
    - ci/gitlab_gtest.sh
  artifacts:
    paths:
      - build/
    expire_in: 30 days

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

This is key part of `ci/gitlab_gtest.sh`

```bash
cmake -H. -Bbuild
cd build
cmake --build .
ctest
```

## Snakes on a plane!

Well... not quite, they are contained in a different type of container in the
cloud. We will build a docker container for a python application that has a
number of dependencies. The easiest way to build docker containers on
gitlab-ci it to use [kaniko][], a Google container tool.

The build stage isn't pretty, but it is short. This is based on the docs on
gitlab, [Building a Docker image with kaniko][gl_using_kaniko].

```yaml
variables:
  IMAGE_NAME: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHORT_SHA
build:
  stage: build
  image:
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  script:
    - echo "{\"auths\":{\"$CI_REGISTRY\":{\"username\":\"$CI_REGISTRY_USER\",\"password\":\"$CI_REGISTRY_PASSWORD\"}}}" > /kaniko/.docker/config.json
    - /kaniko/executor --cache=true --context $CI_PROJECT_DIR --dockerfile $CI_PROJECT_DIR/Dockerfile --destination $IMAGE_NAME
```

Here are the items in the script list, for readability:

```bash
echo "{\"auths\": {\"$CI_REGISTRY\": { \
      \"username\":\"$CI_REGISTRY_USER\", \
      \"password\":\"$CI_REGISTRY_PASSWORD\" \
    }}}" > /kaniko/.docker/config.json

/kaniko/executor --cache=true \
  --context $CI_PROJECT_DIR \
  --dockerfile $CI_PROJECT_DIR/Dockerfile \
  --destination $IMAGE_NAME
```

Next we will add a `test` stage. This stage will run after the build stage
and will run unittests inside of this container.

```yaml
variables:
  IMAGE_NAME: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHORT_SHA

test:
  stage: test
  image:
    name: "${IMAGE_NAME}"
  script:
    - python -m unittest
```

{{< figure
  src="/talk/2019-11-16-gitlab-ci-simple-but-flexible/screenshot-gitlab-git-annex-adapter-pipeline.png"
  title="Screenshot of git-annex-adapter Pipeline"
  link="https://gitlab.com/NGenetzky/git-annex-adapter/pipelines/96349628"
  height="500px"
>}}

Ironically, I did not introduce this error intentionally; however, it
provides an opportunity to discuss a few of the benefits of this setup.

1. The status of the jobs is attached to the commits on which they run.
  1. Status will also appear in merge requests.
  2. Status will also appear on Github.
2. The status provides a URL to the pipeline.
3. The logs for each job in a pipeline are available.

Here is an exert from the logs. I have not investigated the issue farther at
this time.

```
23 $ python -m unittest
24 .[DEBUG] [git_annex_adapter.process.GitAnnexInitRunner] Unknown error:
25 Traceback (most recent call last):
...
36   File "/usr/local/lib/python3.8/subprocess.py", line 1702, in _execute_child
37     raise child_exception_type(errno_num, err_msg, err_filename)
38 FileNotFoundError: [Errno 2] No such file or directory: '/tmp/git-annex-adapter-tests-u8jw0who/nonexistent'
39 E......./usr/local/lib/python3.8/subprocess.py:942: ResourceWarning: subprocess 602 is still running
40   _warn("subprocess %s is still running" % self.pid,
41 ResourceWarning: Enable tracemalloc to get the object allocation traceback
...
75 Ran 27 tests in 9.022s
76 FAILED (errors=1)
80 ERROR: Job failed: exit code 1
```

{{< figure
  src="/talk/2019-11-16-gitlab-ci-simple-but-flexible/screenshot-github-git-annex-adapter-commits.png"
  title="Screenshot of git-annex-adapter Commits"
  link="https://github.com/NGenetzky/git-annex-adapter/commits/0b325bda6f0a421c5e86ada6f4209516e8d7b3b4"
  height="500px"
>}}

## Gitlab pricing

Commitment to open source, public projects:

> As part of GitLab’s commitment to open source, Gold project features are
available for free to public projects on GitLab.com.

- That means 50,000 CI pipeline minutes per month on Gitlab's shared runners"!
- The gold tier typically costs $99 per user per month!

Gitlab Pricing for closed source or private projects:

- For a limited time there is free usage of CI/CD for GitHub and other
external repos, even if they are private.
- [pricing][]
- [ci-cd-github-extended-again][ci-cd-github-extended-again] until Mar. 22 2020
- [ci-cd-github][]
- [ci-cd-external][]

[shellcheck]: https://github.com/koalaman/shellcheck
[dockcross]: https://github.com/dockcross/dockcross
[kaniko]: https://github.com/GoogleContainerTools/kaniko
[gl_using_kaniko]: https://docs.gitlab.com/ee/ci/docker/using_kaniko.html
[ci-cd-github-extended-again]: https://about.gitlab.com/blog/2019/09/09/ci-cd-github-extended-again/
[ci-cd-github]: https://about.gitlab.com/solutions/github/
[ci-cd-external]: https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/
[pricing]: https://about.gitlab.com/pricing/
