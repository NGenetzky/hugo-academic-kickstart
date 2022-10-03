#!/bin/bash

_git_remote_add(){
  # TODO: Check if already exists first
  git remote add wowchemy_ac 'git@github.com:wowchemy/starter-hugo-academic.git'
  git remote add wowchemy_sb 'git@github.com:wowchemy/hugo-second-brain-theme.git'
  git remote add wowchemy_rg 'git@github.com:wowchemy/starter-hugo-research-group.git'
}

_setup() {
  cd "${SCRIPTDIR}/../"
  git submodule update --init
  git clean -fdx resources/
  _git_remote_add

  # rm /tmp/hugo_cache/ -rf
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Bash Strict Mode
  set -eu -o pipefail

  set -x
  SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"

  _setup
fi
