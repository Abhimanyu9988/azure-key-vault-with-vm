variable "azurerm_resource_group" {
  description = "The name for the Azure resource group."
  type        = string
  default     = "key-vault-rg"
}

variable "location" {
  description = "The location for Azure resources."
  type        = string
  default     = "East US"
}

variable "admin_password"{
    description = "The password for the Azure VM."
    type        = string
    default     = "admin@1234"
}

variable "key_vault_secret_value" {
  description = "The value for the Azure Key Vault secret."
  type        = string
  default     = "kvvaultsecretvalue"
  }

variable "azure_key_vault_name" {
    description = "The name for the Azure Key Vault."
    type        = string
    default     = "keyvaultvmwithterraform"
  
}

variable "prefix" {
  default     = "az-kv"
  description = "The prefix which should be used for all resources in this example"
}

variable "azurerm_key_vault_secret"{
    description = "The name for the Azure Key Vault secret."
    type        = string
    default     = "secret-for-azure-kv"
}

variable "admin_username" {
    description = "The username for the Azure VM."
    type        = string
    default     = "adminuser"
}

variable "azurerm_linux_virtual_machine_name" {
    description = "The name for the Azure VM."
    type        = string
    default     = "Azure-key-vault-vm"
}

variable "azurerm_network_interface" {
    description = "The name for the Azure Network Interface."
    type        = string
    default     = "Azure-key-vault-nic"
}

variable "azurerm_virtual_network" {
    description = "value for the Azure Virtual Network."
    type        = string
    default     = "key-vault-vnet"
}