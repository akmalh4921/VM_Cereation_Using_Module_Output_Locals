project     = "pridictive"
environment = "dev"
sequence    = 007
location    = "CentralIndia"

resource_groups = {
  app_rg = {

  }
}

virtual_networks = {
  app_vnet = {
    resource_group_key = "app_rg"
    address_space      = ["10.10.0.0/16"]

  }
}

subnets = {
  app_subnet = {
    resource_group_key  = "app_rg"
    virtual_network_key = "app_vnet"
    address_prefixes    = ["10.10.1.0/24"]

  }
}

public_ips = {
  vm_pip = {
    resource_group_key = "app_rg"
    allocation_method  = "Static"
    sku                = "Standard"

  }
}



linux_vms = {
  vm1 = {
    resource_group_key              = "app_rg"
    subnet_key                      = "app_subnet"
    public_ip_key                   = "vm_pip"
    vm_size                         = "Standard_D2s_V3"
    admin_username                  = "devopsadmin"
    admin_password                  = "Devops@12345"
    disable_password_authentication = false

  }
}