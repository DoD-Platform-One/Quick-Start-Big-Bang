#!/bin/bash
set -e

APPLICATION=big-bang-quick-start
IMAGE_CACHE=${HOME}/.dod-platform-one-big-bang-cache
REGISTRY_CREDS=$(pwd)/.iron-bank-creds.yaml

function setup_creds() {
  if [ ! -f ${REGISTRY_CREDS} ]; then
    cat <<EOF > $REGISTRY_CREDS
configs:
  registry1.dsop.io:
    auth:
      username: REPLACE_ME
      password: REPLACE_ME  
  registry1.dso.mil:
    auth:
      username: REPLACE_ME
      password: REPLACE_ME
EOF
    echo "Need to add Iron Brank pull creds from https://registry1.dso.mil/.  Edit the file ${REGISTRY_CREDS} and then press [spacebar] to continue."
    read -s -d ' '
  fi
}

function launch_k3d() {
  mkdir -p ${IMAGE_CACHE}

  # Clean slate
  k3d cluster delete ${APPLICATION} || echo "Cluster already deleted"

  # Create the cluster
  k3d cluster create \
    --volume ${IMAGE_CACHE}:/var/lib/rancher/k3s/agent/containerd/io.containerd.content.v1.content \
    --volume ${REGISTRY_CREDS}:/etc/rancher/k3s/registries.yaml \
    --k3s-server-arg "--disable=metrics-server" \
    --k3s-server-arg "--disable=traefik" \
    -p 80:80@loadbalancer \
    -p 443:443@loadbalancer \
    ${APPLICATION}
}

function install_flux() {
  kubectl create ns flux-system

  # Install flux in the cluster
  kubectl apply -f https://repo1.dso.mil/platform-one/big-bang/umbrella/-/raw/master/scripts/deploy/flux.yaml

  # Wait for flux
  kubectl wait --for=condition=available --timeout 300s -n "flux-system" "deployment/helm-controller"
  kubectl wait --for=condition=available --timeout 300s -n "flux-system" "deployment/source-controller"
}

function deploy_bb() {
  # Launch big bang 
  kubectl apply -f start.yaml

  # Watch the deployments
  watch kubectl get kustomizations,hr,po -A
}

setup_creds
launch_k3d
install_flux
deploy_bb
