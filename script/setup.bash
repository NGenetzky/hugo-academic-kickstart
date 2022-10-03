#!/bin/bash

_setup() {
  cd "${SCRIPTDIR}/../"
  git submodule update --init
  git clean -fdx resources/
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Bash Strict Mode
  set -eu -o pipefail

  set -x
  SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

  _setup
fi
