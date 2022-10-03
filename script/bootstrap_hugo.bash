#!/bin/bash
VERSION='0.57.2'
VARIANT='hugo_extended'
cd /tmp/
# sudo apt-get update && sudo apt-get install -y ca-certificates openssl git curl && \
#     rm -rf /var/lib/apt/lists/* && \
case ${VERSION} in \
    latest) \
    export VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') ;;\
esac && \
echo "${VERSION}" && \
wget -O "${VERSION}.tar.gz" "https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${VARIANT}_${VERSION}_Linux-64bit.tar.gz" && \
tar xf "${VERSION}.tar.gz" && \
mv hugo /usr/bin/hugo
