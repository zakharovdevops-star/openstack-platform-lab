variable "prefix" {
  description = "Prefix used for resources created by this lab."
  type        = string
  default     = "portfolio"
}

variable "region" {
  description = "OpenStack region."
  type        = string
  default     = "RegionOne"
}

variable "external_network_name" {
  description = "Name of the existing external Neutron network."
  type        = string
}

variable "image_name" {
  description = "Name of an existing Glance image."
  type        = string
}

variable "flavor_name" {
  description = "Name of an existing Nova flavor."
  type        = string
}

variable "keypair_name" {
  description = "Name of an existing Nova SSH key pair."
  type        = string
}

variable "admin_cidr" {
  description = "CIDR allowed to reach SSH. Prefer a bastion/VPN range in real environments."
  type        = string

  validation {
    condition     = can(cidrhost(var.admin_cidr, 0))
    error_message = "admin_cidr must be a valid IPv4 or IPv6 CIDR."
  }
}

variable "private_subnet_cidr" {
  description = "CIDR for the private application subnet."
  type        = string
  default     = "10.20.0.0/24"
}

variable "dns_nameservers" {
  description = "DNS resolvers provided to instances through the Neutron subnet."
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "instance_count" {
  description = "Number of demo application instances."
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 5
    error_message = "instance_count must be between 1 and 5 for this lab."
  }
}
