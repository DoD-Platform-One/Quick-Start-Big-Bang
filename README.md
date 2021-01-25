# Big Bang Quick Start

_This is a mirror of a government repo hosted on [Repo1](https://repo1.dso.mil/) by  [DoD Platform One](http://p1.dso.mil/).  Please direct all code changes, issues and comments to https://repo1.dso.mil/platform-one/quick-start/big-bang_

This is a small repo to help quickly test basic concepts of Big Bang on a local development machine.

---

What you need:
- [K3d](https://github.com/rancher/k3d)

Nice to haves:
- [K8s Lens](https://k8slens.dev/) - _Handy GUI for kubectl_

Use it:
- Init cluster (may prompt for sudo auth) `./init.sh`
- `kubectl get vs -A` to view the list of endpoints
