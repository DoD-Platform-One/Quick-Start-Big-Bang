# Big Bang Quick Start

_This is a mirror of a government repo hosted on [Repo1](https://repo1.dso.mil/) by  [DoD Platform One](http://p1.dso.mil/).  Please direct all code changes, issues and comments to <https://repo1.dso.mil/platform-one/quick-start/big-bang>_

This is a small repo to help quickly test basic concepts of Big Bang on a local development machine.

---

## Prerequisites

What you need:

- [Docker](https://docs.docker.com/get-started/)
- [k3d](https://github.com/rancher/k3d)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- VM or Machine with 
  - Bare minimum: 6 logical cpu cores and 16GB RAM
  - Recommended: 8+ cores and 32GB+ RAM

Nice to haves:

- [Kubectl](https://kubernetes.io/docs/tasks/tools/) - _CLI for working with k8s/k3d_
- [K8s Lens](https://k8slens.dev/) - _Handy GUI for kubectl_

## Instructions

```shell
# Get your username and password from https://registry1.dso.mil and set them as
# env vars to be used later. The password to use is in your user profile under
# 'CLI secret'. If you don't have an account you can register one on the 
# Platform One login page.
export REGISTRY1_USERNAME="bobbytables"
export REGISTRY1_PASSWORD="yourpasswordhere"

# Create a Terraform .tfvars file that will be gitignored (since it has secrets
# in it)
cat <<EOF >>terraform.tfvars
registry1_username = "${REGISTRY1_USERNAME}"
registry1_password = "${REGISTRY1_PASSWORD}"
EOF

# Linux systems may require this line for EFK to not die. Otherwise you can skip
# to the next command
sudo sysctl -w vm.max_map_count=262144

# Initialize k3d. Your system will be automatically configured to use the right
# KUBECONTEXT.
./init-k3d.sh

# Initialize & apply terraform. This will take several minutes.
# If you want to watch it happen use the next command under 
# "Watch the deployments" in a new terminal or other user interface
terraform init
terraform apply --auto-approve

# Watch the deployments. Wait for everything under STATUS to say "Running" and
# everything under READY to say "True"
watch kubectl get kustomizations,hr,po -A

# Get a list of http endpoints that will resolve to your localhost.
kubectl get virtualservices -A

```

### Teardown

```shell
# Big bang teardown (optional, takes several minutes & just reverts back to an
# empty cluster)
terraform destroy

# k3d teardown
k3d cluster delete big-bang-quick-start

# Delete Terraform state (if you didn't run `terraform destroy`)
rm terraform.tfstate
```
