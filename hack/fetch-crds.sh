#!/bin/sh

TAG="${1:-"2.0.0-preview-1"}"
curl -Ls "https://github.com/skupperproject/skupper/archive/refs/tags/${TAG}.tar.gz" > archive.tar.gz

BASEPATH="skupper-$TAG/api/types/crds"
DISTPATH=./skupper/charts/crds/crds
rm -f "${DISTPATH}/*"

tar -xvzf archive.tar.gz -C "$DISTPATH" --strip-components=4 \
  "${BASEPATH}/skupper_access_grant_crd.yaml" \
  "${BASEPATH}/skupper_access_token_crd.yaml" \
  "${BASEPATH}/skupper_attached_connector_anchor_crd.yaml" \
  "${BASEPATH}/skupper_attached_connector_crd.yaml" \
  "${BASEPATH}/skupper_certificate_crd.yaml" \
  "${BASEPATH}/skupper_connector_crd.yaml" \
  "${BASEPATH}/skupper_link_crd.yaml" \
  "${BASEPATH}/skupper_listener_crd.yaml" \
  "${BASEPATH}/skupper_router_access_crd.yaml" \
  "${BASEPATH}/skupper_secured_access_crd.yaml" \
  "${BASEPATH}/skupper_site_crd.yaml"


rm -rf archive.tar.gz
