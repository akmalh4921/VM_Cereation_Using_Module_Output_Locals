output "resource_group_names" {
  description = "Created resource group names"

  value = {
    for key, value in module.resource_group.resource_groups :
    key => value.name
  }
}

output "virtual_network_ids" {
  description = "Created virtual network IDs"

  value = {
    for key, value in module.virtual_network.virtual_networks :
    key => value.id
  }
}

output "subnet_ids" {
  description = "Created subnet IDs"

  value = {
    for key, value in module.subnet.subnets :
    key => value.id
  }
}

output "vm_public_ips" {
  description = "Public IP address of each VM"

  value = {
    for key, value in module.linux_vm.linux_vms :
    key => value
  }
}

output "vm_private_ips" {
  description = "Private IP address of each VM"

  value = {
    for key, value in module.linux_vm.linux_vms :
    key => value.private_ip_address
  }
}