# Big Bang Quick Start

_This is a mirror of a government repo hosted on [Repo1](https://repo1.dso.mil/) by  [DoD Platform One](http://p1.dso.mil/).  Please direct all code changes, issues and comments to https://repo1.dso.mil/platform-one/quick-start/big-bang_

This is a small repo to help quickly test basic concepts of Big Bang on a local development machine.

---

What you need:
- [K3d](https://github.com/rancher/k3d)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Nice to haves:
- [K8s Lens](https://k8slens.dev/) - _Handy GUI for kubectl_

# Instructions

### Create the file `terraform.tfvars` and fill out below.  You 

```bash
registry1_username="REPLACE_ME"
registry1_password="REPLACE_ME"
```

### Deploy Big Bang onto the new cluster

```bash
# Initialize K3d (temporary until k3d module is complete)
./init-k3d.sh

# Initialize & apply terraform
terraform init
terraform apply 

# Watch the deployments
watch kubectl get kustomizations,hr,po -A

# Get a list of http endpoints
kubectl get vs -A
```
