output "public_ips" {
  description = "Created Public IP information"

  value = {
    for key, public_ip in azurerm_public_ip.pip : key => {
      id         = public_ip.id
      name       = public_ip.name
      ip_address = public_ip.ip_address
    }
  }
}