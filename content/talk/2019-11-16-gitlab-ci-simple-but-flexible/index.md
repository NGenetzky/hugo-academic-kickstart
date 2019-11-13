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
