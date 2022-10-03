#!/bin/bash

_test(){
  # TODO # shellcheck script/*
  # shellcheck script/bootstrap*
  :
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Bash Strict Mode
  set -eu -o pipefail

  SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

  cd "${SCRIPTDIR}/../"
  set -x
  _test "$@"
fi
