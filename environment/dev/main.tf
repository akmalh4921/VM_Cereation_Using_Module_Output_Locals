module "resource_group" {
  source = "../../module/azurerm_resource_group"

  resource_groups = local.resource_groups
}

module "virtual_network" {
  source = "../../module/azurerm_virtual_network"

  virtual_networks = {
    for key, value in local.virtual_networks : key => {
      name = value.name

      resource_group_name = module.resource_group.resource_groups[
        value.resource_group_key
      ].name

      location = module.resource_group.resource_groups[
        value.resource_group_key
      ].location

      address_space = value.address_space
      tags          = value.tags
    }
  }

  depends_on = [
    module.resource_group
  ]
}

module "subnet" {
  source = "../../module/azurerm_subnet"

  subnets = {
    for key, value in local.subnets : key => {
      name = value.name

      resource_group_name = module.resource_group.resource_groups[
        value.resource_group_key
      ].name

      virtual_network_name = module.virtual_network.virtual_networks[
        value.virtual_network_key
      ].name

      address_prefixes = value.address_prefixes
    }
  }

  depends_on = [
    module.virtual_network
  ]
}

module "public_ip" {
  source = "../../module/azurerm_public_ip"

  public_ips = {
    for key, value in local.public_ips : key => {
      name = value.name

      resource_group_name = module.resource_group.resource_groups[
        value.resource_group_key
      ].name

      location = module.resource_group.resource_groups[
        value.resource_group_key
      ].location

      allocation_method = value.allocation_method
      sku               = value.sku
      tags              = value.tags
    }
  }

  depends_on = [
    module.resource_group
  ]
}

module "linux_vm" {
  source = "../../module/azurerm_linux_virtual_machine"

  linux_vms = {
    for key, value in local.linux_vms : key => {
      # VM details
      vm_name                         = value.vm_name
       computer_name = replace(value.vm_name, "-", "")
      vm_size                         = value.vm_size
      admin_username                  = value.admin_username
      
      disable_password_authentication = value.disable_password_authentication

      admin_password = (
        value.disable_password_authentication
        ? null
        : value.admin_password
      )

      ssh_public_key = (
        value.disable_password_authentication
        ? file("${path.root}/keys/id_rsa.pub")
        : null
      )

      # NIC details
      nic_name = value.nic_name

      resource_group_name = module.resource_group.resource_groups[
        value.resource_group_key
      ].name

      location = module.resource_group.resource_groups[
        value.resource_group_key
      ].location

      subnet_id = module.subnet.subnets[
        value.subnet_key
      ].id

      public_ip_address_id = module.public_ip.public_ips[
        value.public_ip_key
      ].id

      tags = value.tags
    }
  }

  depends_on = [
    module.subnet,
    module.public_ip
  ]
}
