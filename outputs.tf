output "istio_gw_ip" {
  description = "The IP address of the Istio IngressGateway"
  //noinspection HILUnresolvedReference - `module.big_bang.external_load_balancer` is a json object and `ip` is one of its keys
  value = module.big_bang.external_load_balancer.ip
}
