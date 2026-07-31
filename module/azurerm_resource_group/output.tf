output "resource_groups" {
  description = "Created resource group details"

  value = {
    for key, resource_group in azurerm_resource_group.rg : key => {
      id       = resource_group.id
      name     = resource_group.name
      location = resource_group.location
      tags     = resource_group.tags
    }
  }
}