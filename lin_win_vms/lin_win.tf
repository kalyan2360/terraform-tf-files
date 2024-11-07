
variable "existing_resource_group_name" {
  description = "name of the existing resourcegroup name"
  type        = string
  default = "rgTestKalyan"
}

variable "location" {
  description = "Location of the resource group"
  type        = string
  default     = "UK South"  # adjust as needed
}

variable "linux_vm_count" {
  description = "Number of Linux VMs"
  type        = number
  default     = 1
}

variable "windows_vm_count" {
  description = "Number of Windows VMs"
  type        = number
  default     = 1
}

# Import Existing Resource Group: Reference the existing resource group rather than creating a new one.

data "azurerm_resource_group" "existing_rg" {
  name = var.existing_resource_group_name
}

# Create a Virtual Network and Subnet (if not already available):

resource "azurerm_virtual_network" "vnet" {
  name                = "kk-vnet"
  address_space       = ["10.0.0.0/16"]
# location            = data.azurerm_resource_group.existing_rg.location
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "kk-subnet"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Linux VMs: Use a count loop to create multiple Linux VMs.

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.linux_vm_count
  name                = "linux-vm-${count.index + 1}"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
# location            = data.azurerm_resource_group.existing_rg.location
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "kalyan2"
#  admin_password      = "Password123!"  # Use secure method in production

 admin_ssh_key {
    username   = "kalyan2"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  network_interface_ids = [azurerm_network_interface.linux_nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.linux_vm_count
  name                = "linux-nic-${count.index + 1}"
# location            = data.azurerm_resource_group.existing_rg.location
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Windows VMs: Similar to the Linux VMs, use a count loop for the Windows VMs.

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.windows_vm_count
  name                = "windows-vm-${count.index + 1}"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
# location            = data.azurerm_resource_group.existing_rg.location
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Admin@123"  # Use secure method in production
  network_interface_ids = [azurerm_network_interface.windows_nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "windows_nic" {
  count               = var.windows_vm_count
  name                = "windows-nic-${count.index + 1}"
# location            = data.azurerm_resource_group.existing_rg.location
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
