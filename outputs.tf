output "istio_gw_ip" {
  description = "DEPRECATED - Kept for backwards compatibility reasons, will be removed later. Returns the IP of the first LoadBalancer found in the istio-system namespace"
  value = jsondecode(module.big_bang.external_load_balancer)[0].ip
}

output "external_load_balancer" {
  description = <<EOF
JSON array with information on all LoadBalancer services in the istio-system namespace. Example output:
```
[
  {
    "name": "public-ingressgateway",
    "ip": "192.0.2.0",
    "hostname": "null"
  },
  {...}
]
```
EOF
  value = module.big_bang.external_load_balancer
}
