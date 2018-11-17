+++
title = "Shellcheck With Travis CI"
date = 2018-11-16T20:45:02-06:00
draft = false
tags = [
  "bash",
  "ci",
  "shell",
  "travis-ci",
]
categories = []
+++

Using [shellcheck](https://github.com/koalaman/shellcheck) is a very easy way
to avoid simple bugs in your shell scripts. By adding it to your CI you can
easily make it a free check.  To check all 'sh' and 'bash' files in my project
I used the following code in
[ngenetzky/shlib](https://github.com/NGenetzky/shlib).

<!--more-->

- [scripts/test-shellcheck.bash](https://github.com/NGenetzky/shlib/blob/5843f1b2cc4e76cd22ce9c79e4382b1f6db18e45/scripts/test-shellcheck.bash)

```shell
#!/bin/bash

SCRIPTDIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"
GITROOT="$(readlink -f "${SCRIPTDIR}/../")"

main(){
  (
    cd "${GITROOT}"
    find ./* \
      \( -iname '*.bash' -or -iname '*.sh' \) \
      -exec shellcheck "$@" {} +
  )
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Bash Strict Mode
    set -eu -o pipefail

    # set -x
    main "$@"
fi
```

- [.travis.yml](https://github.com/NGenetzky/shlib/blob/ab92c00f75041620bc19d0cf930c67d9049925be/.travis.yml)

```shell
sudo: required
dist: trusty
language: bash
script:
- scripts/test-shellcheck.bash
```

References:

- [github.com/martinseener/example-shellcheck-bashate-travisci](https://github.com/martinseener/example-shellcheck-bashate-travisci)
