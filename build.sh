#!/usr/bin/env bash

set -euxo pipefail

docker build --format docker --target test-output -o results .
docker build --format docker --target output -o build .
