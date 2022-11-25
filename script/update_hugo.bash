#!/bin/bash

update_hugo(){
  sed -i \
    -e "s@${HUGO_VERSION_OLD?}@${HUGO_VERSION_NEW?}@" \
    ./.devcontainer/devcontainer.json \
    ./docker-compose.yml \
    ./netlify.toml \
    ./script/bootstrap.bash \
    ./script/env

  git commit \
    -m "hugo: Upgrade to v${HUGO_VERSION_NEW} from v${HUGO_VERSION_OLD}" \
    ./.devcontainer/devcontainer.json \
    ./docker-compose.yml \
    ./netlify.toml \
    ./script/bootstrap.bash \
    ./script/env
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Bash Strict Mode
  set -eu -o pipefail

  SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

  . script/env

  HUGO_VERSION_OLD="${HUGO_VERSION}"
  HUGO_VERSION_NEW="${1?Please specify HUGO_VERSION_NEW}"

  update_hugo
fi
