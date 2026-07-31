output "linux_vms" {
  description = "Created Linux VM details"

  value = {
    for key, vm in azurerm_linux_virtual_machine.vm : key => {
      id                   = vm.id
      name                 = vm.name
      computer_name        = vm.computer_name
      resource_group_name  = vm.resource_group_name
      network_interface_id = azurerm_network_interface.nic[key].id
      private_ip_address   = azurerm_network_interface.nic[key].private_ip_address
    }
  }
}

output "network_interfaces" {
  description = "Created network interface details"

  value = {
    for key, nic in azurerm_network_interface.nic : key => {
      id                 = nic.id
      name               = nic.name
      private_ip_address = nic.private_ip_address
    }
  }
}