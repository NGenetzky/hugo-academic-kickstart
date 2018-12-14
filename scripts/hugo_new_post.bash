#!/bin/bash

SCRIPTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"
GITDIR="${SCRIPTDIR}/../"

hugo_new_post()
{
    local slug="${1?}"
    local prefix="$(date +%Y-%m-%d)"
    local hint="content/post/${prefix}-${slug}/index.md"
    (
        cd ${GITDIR}
        hugo new \
            "${hint}"
    )
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Bash Strict Mode
    set -eu -o pipefail

    hugo_new_post "$@"
fi
