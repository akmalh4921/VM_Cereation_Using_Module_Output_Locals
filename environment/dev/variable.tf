variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "sequence" {
  description = "Resource Name Sufix"
  type        = number
}


variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_groups" {
  description = "Resource groups configuration"

  type = map(object({
    sequence = optional(string, "007")
  }))
}

variable "virtual_networks" {
  description = "Virtual networks configuration"

  type = map(object({
    resource_group_key = string
    address_space      = list(string)
    sequence           = optional(string, "007")
  }))
}

variable "subnets" {
  description = "Subnet configuration"

  type = map(object({
    resource_group_key  = string
    virtual_network_key = string
    address_prefixes    = list(string)
    sequence            = optional(string, "007")
  }))
}

variable "public_ips" {
  description = "Public IP configuration"

  type = map(object({
    resource_group_key = string
    allocation_method  = string
    sku                = string
    sequence           = optional(string, "007")
  }))
}


variable "linux_vms" {
  description = "Linux VM configuration"

  type = map(object({
    resource_group_key              = string
    subnet_key                      = string
    public_ip_key                   = string
    vm_size                         = string
    admin_username                  = string
    admin_password                  = optional(string)
    disable_password_authentication = bool
    sequence                        = optional(string, "007")
  }))


}