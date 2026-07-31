output "virtual_networks" {
  description = "Created virtual network details"

  value = {
    for key, virtual_network in azurerm_virtual_network.vnet : key => {
      id                  = virtual_network.id
      name                = virtual_network.name
      location            = virtual_network.location
      resource_group_name = virtual_network.resource_group_name
      address_space       = virtual_network.address_space
    }
  }
}