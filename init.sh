#!/bin/bash
set -e

APPLICATION=hello-world-bb-universe
IMAGE_CACHE=${HOME}/.dod-platform-one-big-bang-cache
REGISTRY_CREDS=$(pwd)/bigbang/.iron-bank-creds

function setup_creds() {
  if [ ! -f ${REGISTRY_CREDS}.env ]; then
    cat <<EOF > $REGISTRY_CREDS.env
IB_USERNAME=REPLACE_ME
IB_PASSWORD=REPLACE_ME

EOF
    echo "Need to add Iron Brank pull creds.  Edit the file ${REGISTRY_CREDS}.env and then press [spacebar] to continue."
    read -s -d ' '
  fi

  source ${REGISTRY_CREDS}.env

  cat <<EOF > $REGISTRY_CREDS-bb.yaml
apiVersion: v1
kind: Secret
metadata:
    name: common-bb
stringData:
    values.yaml: |-
        registryCredentials:
          username: $IB_USERNAME
          password: $IB_PASSWORD
EOF

}

function launch_k3d() {
  mkdir -p ${IMAGE_CACHE}

  # Clean slate
  k3d cluster delete ${APPLICATION} || echo "Cluster already deleted"

  # Create the cluster
  k3d cluster create \
    --volume ${IMAGE_CACHE}:/var/lib/rancher/k3s/agent/containerd/io.containerd.content.v1.content \
    --k3s-server-arg "--disable=metrics-server" \
    --k3s-server-arg "--disable=traefik" \
    -p 80:80@loadbalancer \
    -p 443:443@loadbalancer \
    ${APPLICATION}
}

function install_flux() {
  kubectl create ns flux-system

  # Create the IB pull secret for flux
  kubectl create secret docker-registry private-registry -n flux-system \
    --docker-server=registry1.dso.mil \
    --docker-username="${IB_USERNAME}" \
    --docker-password="${IB_PASSWORD}"

  # Install flux in the cluster
  kubectl apply -f https://repo1.dso.mil/platform-one/big-bang/umbrella/-/raw/master/scripts/deploy/flux.yaml

  # Wait for flux
  kubectl wait --for=condition=available --timeout 300s -n "flux-system" "deployment/helm-controller"
  kubectl wait --for=condition=available --timeout 300s -n "flux-system" "deployment/source-controller"
}

function deploy_bb() {
  # Launch big bang 
  kubectl apply -f start.yaml

  watch kubectl get kustomizations,hr,po -A
}

setup_creds
launch_k3d
install_flux
deploy_bb
