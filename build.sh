#!/bin/bash

if [ -f v${num}/dofigen.yml ]; then
	pushd v${num}
	dofigen dofigen.yml
	popd
fi

docker builder prune --filter type=exec.cachemount -f

time DOCKER_BUILDKIT=1 docker build -t devquest-${num} -f v${num}/Dockerfile --no-cache .
