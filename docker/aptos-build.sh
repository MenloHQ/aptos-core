#!/bin/sh
# Copyright (c) Aptos
# SPDX-License-Identifier: Apache-2.0
set -e

DOCKERFILE=$1
if [ -z "$APTOS_BUILD_TAG" ]; then
  TAGS="--tag $2"
else
  TAGS="--tag $2 --tag $APTOS_BUILD_TAG"
fi

if [ -z "$DOCKERFILE" ] || [ -z "$TAGS" ]
then
  echo "Usage aptos-build.sh <Docker_file> <Local_tag> <Other_args>"
fi

shift 2

DIR="$( cd "$( dirname "$0" )" && pwd )"

docker buildx -f $DOCKERFILE $DIR/.. $TAGS \
    --build-arg GIT_REV="$(git rev-parse HEAD)" \
    --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg ENABLE_FAILPOINTS="$ENABLE_FAILPOINTS" \
    "$@"; then
      exit 0

exit 1