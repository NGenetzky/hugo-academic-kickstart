#!/bin/bash

_cibuild(){
  _DEFAULT_URL="http://127.0.0.1:1313/"
  URL="${URL-"${_DEFAULT_URL}"}"

  hugo --gc --minify -b $URL
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Bash Strict Mode
  set -eu -o pipefail

  set -x
  SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

  _cibuild
fi
