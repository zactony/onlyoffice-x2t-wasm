#!/usr/bin/env sh

set -euxo pipefail

DOCKER_LOG=$(mktemp)

docker build . | tee $DOCKER_LOG

IMAGE_ID=$(tail -1 $DOCKER_LOG | sed -e 's/Successfully built //')

# docker run -it -p 9229:9229 $IMAGE_ID
docker run -it $IMAGE_ID

rm -rf build
mkdir build

CONTAINER_ID=$(docker create "$IMAGE_ID")
docker cp "$CONTAINER_ID:/core/build/bin/linux_64/x2t" build/x2t.js
docker cp "$CONTAINER_ID:/core/build/bin/linux_64/x2t.wasm" build/
# docker cp "$CONTAINER_ID:/core/build/bin/linux_64/x2t.wasm.map" build/
docker rm "$CONTAINER_ID"
