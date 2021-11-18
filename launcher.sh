#!/usr/bin/env bash
# set -x
set -o errexit
set -o pipefail
source $(dirname 0)/scripts/libs.bash
###########################################
# Vars
###########################################
DOCKER_IMAGE="k8ssandbox"
REF_K8S="latest"

msg_info "Check if docker is running"

if ! docker info > /dev/null 2>&1; then
  msg_error "This script uses docker, and it isn't running - please start docker and try again!"
  exit 1
fi

msg_info "Launch docker Lab Client"

docker run --rm -it \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $PWD:/workspace -w /workspace \
    --name k8s-client \
    ${DOCKER_IMAGE}:${REF_K8S}