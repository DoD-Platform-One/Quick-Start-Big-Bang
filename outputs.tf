output "istio_gw_ip" {
  description = "DEPRECATED - Kept for backwards compatibility reasons, will be removed later. Returns the IP of the first LoadBalancer found in the istio-system namespace"
  value = jsondecode(module.big_bang.external_load_balancer)[0].ip
}

output "external_load_balancer" {
  description = "JSON array with info on Istio's LoadBalancer(s). Keys are 'name', 'ip', 'hostname'"
  value = module.big_bang.external_load_balancer
}
