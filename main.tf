terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
    purge_soft_delete_on_destroy    = true
    recover_soft_deleted_key_vaults = true
  }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.azurerm_resource_group
  location = var.location
}

resource "azurerm_virtual_network" "virtual_network_name" {
  name                = var.azurerm_virtual_network
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "azurerm_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network_name.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "azurerm_public_ip" {
  name                = "${var.prefix}-pip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "azurerm_network_interface" {
  name                = var.azurerm_network_interface
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.azurerm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.azurerm_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "azurerm_linux_virtual_machine" {
  name                = var.azurerm_linux_virtual_machine_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.azurerm_network_interface.id,
  ]
  admin_password = var.admin_password
  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

data "azurerm_client_config" "current" {}
###Create a key vault
resource "azurerm_key_vault" "azurerm_key_vault" {
  name                       = var.azure_key_vault_name
  location                   = azurerm_resource_group.resource_group.location
  resource_group_name        = azurerm_resource_group.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  purge_protection_enabled    = false
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  name         = var.azurerm_key_vault_secret
  value        = var.key_vault_secret_value
  key_vault_id = azurerm_key_vault.azurerm_key_vault.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.azurerm_linux_virtual_machine.name
}

output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

output "key_vault_name" {
  value = azurerm_key_vault.azurerm_key_vault.name
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.azurerm_linux_virtual_machine.public_ip_address
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.azurerm_linux_virtual_machine.admin_username
}

output "admin_password" {
  value = azurerm_linux_virtual_machine.azurerm_linux_virtual_machine.admin_password
  sensitive = true
}


output "azurerm_linux_virtual_machine_name" {
  value = azurerm_linux_virtual_machine.azurerm_linux_virtual_machine.name
}

output "azurerm_key_vault_secret_name" {
  value = azurerm_key_vault_secret.example.name
}