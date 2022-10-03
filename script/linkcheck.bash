#!/bin/bash

SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"
GITDIR="${SCRIPTDIR}/../"
DOCKERTAG="filiph/linkcheck"

linkcheck_exists(){
  docker inspect "${DOCKERTAG}" > /dev/null 2>&1 
}

linkcheck_fetch(){
  git clone \
    "https://github.com/filiph/linkcheck.git" \
    "${GITDIR}/.local/share/linkcheck"
}

linkcheck_build(){
  docker build \
    -t "${DOCKERTAG}" \
    "${GITDIR}/.local/share/linkcheck"
}

linkcheck_precondition(){
  if ! linkcheck_exists ; then
    linkcheck_fetch
    linkcheck_build
  fi
}

linkcheck()
{
  linkcheck_precondition

  docker run \
    --net host \
    "${DOCKERTAG}" \
    http://localhost:1313 \
    $@
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Bash Strict Mode
    set -eu -o pipefail

    set -x
    linkcheck "$@"
fi
