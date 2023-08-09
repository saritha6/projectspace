provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "RG" {
  name     = "vs-terraform"
  location = "West Europe"

  tags = {
    Owner = "Saru"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vs-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "VMsubnet"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
-------------------------------------------------------
 azure storageblob

resource "azurerm_resource_group" "example001" {
  name     = "saru-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example001" {
  name                     = "example001storacc"
  resource_group_name      = azurerm_resource_group.example001.name
  location                 = azurerm_resource_group.example001.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example001" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.example001.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example001" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.example001.name
  storage_container_name = azurerm_storage_container.example001.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
