#!/bin/bash
set -e

APPLICATION=big-bang-quick-start
IMAGE_CACHE=${HOME}/.dod-platform-one-big-bang-cache

function launch_k3d() {
  mkdir -p ${IMAGE_CACHE}

  # Clean slate
  k3d cluster delete ${APPLICATION} || echo "Cluster already deleted"

  # Create the cluster
  k3d cluster create \
    --volume ${IMAGE_CACHE}:/var/lib/rancher/k3s/agent/containerd/io.containerd.content.v1.content \
    --volume /etc/machine-id:/etc/machine-id \
    --k3s-server-arg "--disable=metrics-server" \
    --k3s-server-arg "--disable=traefik" \
    -p 80:80@loadbalancer \
    -p 443:443@loadbalancer \
    ${APPLICATION}
}


function deploy_bb() {
  # Watch the deployments
  watch kubectl get kustomizations,hr,po -A
}

launch_k3d
deploy_bb
