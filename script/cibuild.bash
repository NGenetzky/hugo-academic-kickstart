#!/bin/bash

_cibuild(){
  hugo version

  _DEFAULT_URL="http://127.0.0.1:1313/"
  URL="${URL-"${_DEFAULT_URL}"}"

  hugo --gc --minify -b $URL
  hugo --gc --minify -b $URL --cacheDir "$(pwd)/.cache/"

  # hugo -c content -d public --configDir config --themesDir themes "$@"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Bash Strict Mode
  set -eu -o pipefail

  set -x
  SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

  _cibuild
fi
