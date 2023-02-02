#!/usr/bin/env bash
set -eu

docker build -t coreycothrum/nginx:$(git describe --always --tags --dirty) .
