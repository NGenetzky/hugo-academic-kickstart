#!/bin/bash

_bootstrap_hugo(){
  _DEFAULT_HUGO_VERSION="0.58.3"
  HUGO_VERSION="${HUGO_VERSION-"${_DEFAULT_HUGO_VERSION}"}"

  VARIANT='hugo_extended'
  cd /tmp/ || exit 1
  # sudo apt-get update && sudo apt-get install -y ca-certificates openssl git curl && \
  #     rm -rf /var/lib/apt/lists/* && \
  case ${HUGO_VERSION} in \
      latest) export HUGO_VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') ;;
  esac

  echo "Installing HUGO_VERSION=${HUGO_VERSION}."
  wget -q -O "${HUGO_VERSION}.tar.gz" "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${VARIANT}_${HUGO_VERSION}_Linux-64bit.tar.gz" && \
  tar xf "${HUGO_VERSION}.tar.gz"

  _BINDIR="/usr/local/bin/"
  if [ -w "${_BINDIR}" ] ; then
    install hugo "${_BINDIR}/hugo_${HUGO_VERSION}"
    ln -sfT "hugo_${HUGO_VERSION}" "${_BINDIR}/hugo"
  else
    _BINDIR="${HOME}/.local/bin/"
    install hugo "${_BINDIR}/hugo_${HUGO_VERSION}"
    ln -sfT "hugo_${HUGO_VERSION}" "${_BINDIR}/hugo"
  fi

  rm hugo
}

_bootstrap_apts(){
  command -v shellcheck > /dev/null || sudo apt install shellcheck
}

_bootstrap_hugo
_bootstrap_apts
