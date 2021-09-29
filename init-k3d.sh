#!/bin/bash
set -e

APPLICATION=big-bang-quick-start
IMAGE_CACHE=${HOME}/.dod-platform-one-big-bang-cache

# Clean slate
k3d cluster delete ${APPLICATION} || echo "Cluster already deleted"

mkdir -p ${IMAGE_CACHE}

# Create the cluster
k3d cluster create \
  -i rancher/k3s:v1.21.5-k3s1
  --volume ${IMAGE_CACHE}:/var/lib/rancher/k3s/agent/containerd/io.containerd.content.v1.content \
  --volume /etc/machine-id:/etc/machine-id \
  --k3s-server-arg "--disable=traefik" \
  -p 80:80@loadbalancer \
  -p 443:443@loadbalancer \
  ${APPLICATION}

echo "k3d ready, check the README.md for the next steps."