#!/bin/bash

SCRIPTDIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"

update()
{
  if [ -z "${THEME_VERSION_NEW-}" ]; then
    THEME_VERSION_NEW="${1?Please specify THEME_VERSION_NEW}"
  fi

  # Display available updates to Academic.
  cd "${SCRIPTDIR}/../themes/academic"
  git fetch
  git log --pretty=oneline --abbrev-commit --decorate \
    "HEAD..${THEME_VERSION_NEW?}"

  # Update Academic.
  git checkout "${THEME_VERSION_NEW?}"

  cd "${SCRIPTDIR}/../"

  cp -TR \
    themes/academic/exampleSite/config/_default/ \
    config/example-academic/

  git commit \
    -m "academic: Upgrade theme to academic ${THEME_VERSION_NEW}" \
    config/example-academic/ \
    themes/academic/
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Bash Strict Mode
    set -eu -o pipefail

    set -x
    update "$@"
fi
