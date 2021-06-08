variable "registry1_username" {
  type = string
}

variable "registry1_password" {
  type = string
}

variable "reduce_flux_resources" {
  type = bool
  default = true
}

module "big_bang" {
  source = "git::https://repo1.dso.mil/platform-one/big-bang/terraform-modules/big-bang-terraform-launcher.git?ref=v0.1.0"

  big_bang_manifest_file = "bigbang/start.yaml"
  registry_credentials = [{
    registry = "registry1.dso.mil"
    username = var.registry1_username
    password = var.registry1_password
  }]
  reduce_flux_resources = var.reduce_flux_resources
}
