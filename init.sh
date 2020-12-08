#!/bin/bash
set -e

APPLICATION=hello-world-bb-universe
IMAGE_CACHE=${HOME}/.dod-platform-one-big-bang-cache
REGISTRY_CREDS=${PWD}/.iron-bank-creds.yaml

function setup_creds() {
  if [ ! -f ${REGISTRY_CREDS} ]; then
    cat <<EOF > .iron-bank-creds.yaml
configs:
  registry1.dsop.io:
    auth:
      username: REPLACE_ME
      password: REPLACE_ME
EOF
    echo "Need to add Iron Brank pull creds.  Edit the file ${REGISTRY_CREDS} and then press [spacebar] to continue."
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
  kubectl apply -f https://repo1.dsop.io/platform-one/big-bang/apps/sandbox/fluxv2/-/raw/3-4-ib-images/flux-system.yaml

  # Wait for flux
  kubectl wait --for=condition=available --timeout 300s -n "flux-system" "deployment/helm-controller"
  kubectl wait --for=condition=available --timeout 300s -n "flux-system" "deployment/source-controller"
}

function deploy_bb() {
  # Launch big bang 
  kustomize build bigbang | kubectl apply -f -

  # Wait for Istio
  kubectl wait --for=condition=ready --timeout 300s -n "bigbang" "helmrelease/bigbang" 
  kubectl wait --for=condition=ready --timeout 300s -n "bigbang" "helmrelease/istio" 
}

setup_creds
launch_k3d
install_flux
deploy_bb

# Install the workloads
kustomize build hello-world-auth-test | kubectl apply -f -    

# Wait for the deployment to complete
kubectl rollout status deployment/podinfo -n hello-world

echo "Loaded, navigate to https://test.bigbang.dev"