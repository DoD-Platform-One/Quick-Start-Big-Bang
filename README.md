# Big Bang Quick Start

_This is a mirror of a government repo hosted on [Repo1](https://repo1.dso.mil/) by  [DoD Platform One](http://p1.dso.mil/).  Please direct all code changes, issues and comments to <https://repo1.dso.mil/platform-one/quick-start/big-bang>_

This is a small repo to help quickly test basic concepts of Big Bang on a local development machine.

---

What you need:

- [Docker](https://docs.docker.com/get-started/)
- [k3d](https://github.com/rancher/k3d)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- VM or Machine with 5-6 cpu cores and ~16 GB of ram

Nice to haves:

- [Kubectl](https://kubernetes.io/docs/tasks/tools/) - _CLI for working with k8s/k3d_
- [K8s Lens](https://k8slens.dev/) - _Handy GUI for kubectl_

## Instructions

### Create and populate the file `terraform.tfvars` with your [Registry1](http://registry1.dso.mil/) CLI username and secret from the user profile screen

```terraform
registry1_username = "REPLACE_ME"
registry1_password = "REPLACE_ME"
```

### Deploy Big Bang onto the new cluster

```shell
# Linux systems may require this line for EFK to not die
sudo sysctl -w vm.max_map_count=262144

# Initialize k3d
./init-k3d.sh

# Initialize & apply terraform
terraform init
terraform apply --auto-approve

# Watch the deployments
watch kubectl get kustomizations,hr,po -A

# Get a list of http endpoints
kubectl get vs -A
```

### Teardown

```shell
# Big bang teardown (optional, takes several minutes & just reverts back to an empty cluster)
terraform destroy

# k3d teardown
k3d cluster delete big-bang-quick-start
```
