#!/bin/sh

set -x

TAG="${1:-"2.0.0-preview-2"}"
ARCHIVE_REF="${ARCHIVE_REF:-https://github.com/skupperproject/skupper/archive/refs/tags/${TAG}.tar.gz}"
curl -Ls "${ARCHIVE_REF}" > archive.tar.gz

BASEPATH="skupper-$TAG/api/types/crds"
DISTPATH=./skupper/charts/crds/crds
rm -f "${DISTPATH}/*"

tar -xvzf archive.tar.gz -C "$DISTPATH" --strip=4 "${BASEPATH}"

rm -rf archive.tar.gz
