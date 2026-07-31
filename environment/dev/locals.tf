locals {
  project     = lower(var.project)
  environment = lower(var.environment)
  sequence    = var.sequence
  location    = var.location

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Employee-ID-007"
  }

  resource_groups = {
    for key, value in var.resource_groups : key => {
      name = lower(
        "rg-${local.project}-${local.environment}-${local.sequence}"
      )

      location = local.location
      tags     = local.common_tags
    }
  }

  virtual_networks = {
    for key, value in var.virtual_networks : key => {
      name = lower(
        "vnet-${local.project}-${local.environment}-${local.sequence}"
      )

      resource_group_key = value.resource_group_key
      address_space      = value.address_space
      tags               = local.common_tags
    }
  }

  subnets = {
    for key, value in var.subnets : key => {
      name = lower(
        "snet-${local.project}-${local.environment}-${local.sequence}"
      )

      resource_group_key  = value.resource_group_key
      virtual_network_key = value.virtual_network_key
      address_prefixes    = value.address_prefixes
    }
  }

  public_ips = {
    for key, value in var.public_ips : key => {
      name = lower(
        "pip-${local.project}-${local.environment}-${local.sequence}"
      )

      resource_group_key = value.resource_group_key
      allocation_method  = value.allocation_method
      sku                = value.sku
      tags               = local.common_tags
    }
  }


  linux_vms = {
    for key, value in var.linux_vms : key => {
      vm_name = lower(
        "vm-${local.project}-${local.environment}-${value.sequence}"
      )

       computer_name = lower(
      "vm${value.sequence}"
    )

      nic_name = lower(
        "nic-${local.project}-${local.environment}-${value.sequence}"
      )

      resource_group_key = value.resource_group_key
      subnet_key         = value.subnet_key
      public_ip_key      = value.public_ip_key

      vm_size                         = value.vm_size
      admin_username                  = value.admin_username
      admin_password                  = value.admin_password
      disable_password_authentication = value.disable_password_authentication

      tags = local.common_tags
    }
  }
}
