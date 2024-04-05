#!/usr/bin/env sh

set -euxo pipefail

docker build .

IMAGE_ID=$(docker build --quiet .)

rm -rf results
mkdir results

docker run -it -p 9229:9229 -v $PWD/tests/:/tests/ -v $PWD/results/:/results/ $IMAGE_ID

rm -rf build
mkdir build

CONTAINER_ID=$(docker create "$IMAGE_ID")
docker cp "$CONTAINER_ID:/core/build/bin/linux_64/x2t" build/x2t.js
docker cp "$CONTAINER_ID:/core/build/bin/linux_64/x2t.wasm" build/
docker cp "$CONTAINER_ID:/core/build/bin/linux_64/x2t.zip" build/
docker cp "$CONTAINER_ID:/core/build/bin/linux_64/x2t.zip.sha512" build/
docker rm "$CONTAINER_ID"
