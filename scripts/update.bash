#!/bin/bash

SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

update()
{
  # Display available updates to Academic.
  cd "${SCRIPTDIR}/../themes/academic"
  git fetch
  git log --pretty=oneline --abbrev-commit --decorate HEAD..origin/master
  cd "${SCRIPTDIR}/../"

  # Update Academic.
  git submodule update --remote --merge
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Bash Strict Mode
    set -eu -o pipefail

    set -x
    update "$@"
fi
