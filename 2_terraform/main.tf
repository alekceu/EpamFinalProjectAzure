resource "azurerm_resource_group" "rg" {
  name     = "RG_EpamFP"
  location = "eastus"
}

# Create virtual network
resource "azurerm_virtual_network" "az_vn" {
  name                = "AZVM-UbuntuWebServer-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "az_subnet" {
  name                 = "AZVM-UbuntuWebServer-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.az_vn.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "az_public_ip" {
  name                = "AZVM-UbuntuWebServer-publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "AZ_WEB_nsg" {
  name                = "AZ_WEB_NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "AZVM_nic" {
  name                = "AZVM-NIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "AZVM_nic_configuration"
    subnet_id                     = azurerm_subnet.az_subnet.id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.az_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "NSGtoNI" {
  network_interface_id      = azurerm_network_interface.AZVM_nic.id
  network_security_group_id = azurerm_network_security_group.AZ_WEB_nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "AZVM" {
  name                  = "AZVM-UbuntuWEBServer"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.AZVM_nic.id]
  size                  = "Standard_B1ls"

  os_disk {
    name                 = "AZVMUbuntuWEBServerOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
 
 source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

computer_name                   = "UbuntuWebServer"
  admin_username                  = "alekceu"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "alekceu"
    public_key = file("./ssh_key/id_rsa.pub")
  }
}
