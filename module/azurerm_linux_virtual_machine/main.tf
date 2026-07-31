resource "azurerm_network_interface" "nic" {
  for_each = var.linux_vms

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.public_ip_address_id
  }

  tags = each.value.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.linux_vms

  name                = each.value.vm_name
  computer_name       = each.value.computer_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.vm_size
  admin_username      = each.value.admin_username

  disable_password_authentication = each.value.disable_password_authentication

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  admin_password = (
    each.value.disable_password_authentication
    ? null
    : each.value.admin_password
  )

  dynamic "admin_ssh_key" {
    for_each = each.value.disable_password_authentication ? [1] : []

    content {
      username   = each.value.admin_username
      public_key = each.value.ssh_public_key
    }
  }

  os_disk {
    name                 = "${each.value.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = each.value.tags
}