variable "registry1_username" {
  description = "Your username on https://registry1.dso.mil"
  type        = string
}

variable "registry1_password" {
  description = "Your password on https://registry1.dso.mil. You can find it under 'CLI secret' in your user profile"
  type        = string
}

variable "reduce_flux_resources" {
  description = "If true, reduces cpu/memory requests for resource-constrained environments"
  type        = bool
  default     = true
}
