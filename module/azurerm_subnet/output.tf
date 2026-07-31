output "subnets" {
  description = "Created subnet information"

  value = {
    for key, subnet in azurerm_subnet.snet : key => {
      id                   = subnet.id
      name                 = subnet.name
      resource_group_name  = subnet.resource_group_name
      virtual_network_name = subnet.virtual_network_name
    }
  }
}