variable "linux_vms" {
  description = "Linux VM and NIC configuration"

  type = map(object({
    vm_name                         = string
    computer_name                   = string
    location                        = string
    resource_group_name             = string
    vm_size                         = string
    admin_username                  = string
    admin_password                  = optional(string)
    disable_password_authentication = bool
    ssh_public_key                  = optional(string)

    nic_name             = string
    subnet_id            = string
    public_ip_address_id = optional(string)

    tags = map(string)
  }))
}