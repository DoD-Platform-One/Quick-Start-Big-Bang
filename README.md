# Big Bang Universe Hello World

What you need:
- [K3d](https://github.com/rancher/k3d)
- [Kustomize](https://kubernetes-sigs.github.io/kustomize/installation/)

Nice to haves:
- [Stern](https://github.com/wercker/stern) - _Aggregate logs across the entire cluster_   
    
         stern --all-namespaces . 
    
- [K8s Lens](https://k8slens.dev/) - _Handy GUI for kubectl_

Use it:
- Init cluster (may prompt for sudo auth) `./init.sh`
- `kubectl get vs -A` to view the list of endpoints
- Navigate to https://test.bigbang.dev to test SSO integration
