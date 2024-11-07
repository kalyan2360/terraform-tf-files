

resource azurerm_resource_group rg_kk{
	name = var.rg_name
	location = var.loc
	
}

resource azurerm_virtual_network vnet_kk{ 
	name = var.v_net_name
	resource_group_name  = azurerm_resource_group.rg_kk.name 
        location = var.loc
	address_space = var.vnet_address_space_ip
	
}

resource azurerm_subnet subnet_kk1{
	name = var.subnet_name
        resource_group_name = azurerm_resource_group.rg_kk.name
	address_prefixes = var.subnet_space_ip
	virtual_network_name = azurerm_virtual_network.vnet_kk.name 
	
}	

# resource azurerm_ssh_public_key ssh-key-kk{
#	name = var.ssh_key_name
#	resource_group_name = azurerm_resource_group.rg_kk.name
#        location = var.loc
#	public_key = file("~/.ssh/id_rsa.pub")
#  }

resource azurerm_network_interface nic_kk {
	name = var.nic_kk_name
	resource_group_name = azurerm_resource_group.rg_kk.name
	location = var.loc
	ip_configuration {
	name = var.nic_ip_name
	private_ip_address_allocation = "Dynamic"
	public_ip_address_id = azurerm_public_ip.pub_ip.id
	subnet_id = azurerm_subnet.subnet_kk1.id
	
}
}
resource azurerm_public_ip pub_ip{
	name = var.pub_ip_name
	resource_group_name = azurerm_resource_group.rg_kk.name
        location = var.loc
	allocation_method = "Static"
}

resource "azurerm_network_security_group" "kk_nsg_grp" {
			name                = var.nsg
			location            = azurerm_resource_group.rg_kk.location
			resource_group_name = azurerm_resource_group.rg_kk.name

			security_rule {
				name                       = "sshport"
				priority                   = 100
				direction                  = "Inbound"
				access                     = "Allow"
				protocol                   = "Tcp"
				source_port_range          = "*"
				destination_port_range     = "22"
				source_address_prefix      = "*"
				destination_address_prefix = "*"
			  }
			}

resource "azurerm_network_interface_security_group_association" "nsgasoc" {
  network_interface_id      = azurerm_network_interface.nic_kk.id
  network_security_group_id = azurerm_network_security_group.kk_nsg_grp.id
}

/*  resource azurerm_linux_virtual_machine kk_vm{
			name = var.vm_name_kk
			resource_group_name  = azurerm_resource_group.rg_kk.name
			location = var.loc

			admin_username = var.admin_user_name
			network_interface_ids =[azurerm_network_interface.nic_kk.id]
			size = var.size

			admin_ssh_key{
				public_key = file("~/.ssh/id_rsa.pub")
				username = "kalyan2" 
			}
			os_disk{
				caching  = "ReadWrite"
				storage_account_type ="Standard_LRS"
			}
			source_image_reference{
				publisher =  "Canonical"
				offer = var.offer
				sku = var.sku 
				version = "latest"
			}
		}
*/

resource "azurerm_windows_virtual_machine" "windows-kk" {
  name                = "win-vm2"
  resource_group_name = azurerm_resource_group.rg_kk.name
  location            = azurerm_resource_group.rg_kk.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Kk@12345"
  network_interface_ids = [
    azurerm_network_interface.nic_kk.id,
  ]
    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
