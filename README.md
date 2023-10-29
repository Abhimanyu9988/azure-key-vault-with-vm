# Azure Resource Provisioning with Terraform

This repository contains Terraform configurations and scripts for provisioning Azure resources, setting up an Azure Key Vault, and securely accessing Key Vault secrets from an Azure Virtual Machine.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Terraform Deployment](https://github.com/Abhimanyu9988/azure-key-vault-with-vm/blob/main/main.tf)
  - [Post-Deployment Script](https://github.com/Abhimanyu9988/azure-key-vault-with-vm/blob/main/after-terraform-cmd.sh)
- [Variables](https://github.com/Abhimanyu9988/azure-key-vault-with-vm/blob/main/variables.tf)
- [Inside-VM Installation Script](https://github.com/Abhimanyu9988/azure-key-vault-with-vm/blob/main/install-script-inside-vm.sh)


## Overview

This project automates the provisioning of Azure resources, including a Virtual Machine, and demonstrates secure secret retrieval from Azure Key Vault. The key components include:

- Terraform configurations for Azure resource setup.
- A Bash script for post-deployment tasks like assigning managed identity and configuring Key Vault policies.
- An installation script that runs inside the Azure VM to set up the required environment and fetch secrets from Key Vault.

## Prerequisites

Before getting started, make sure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- Azure CLI configured with necessary permissions.
- A service principal or user account with sufficient permissions to create Azure resources.

## Usage

### Terraform Deployment

1. Clone this repository to your local machine.

2. Modify the variables in `variables.tf` to customize your deployment.

3. Run the following commands to deploy Azure resources:

   ```bash
   terraform init
   terraform apply --auto-approve

### Assigning managed identity and configuring Key Vault policies 

#### Inside-VM Installation Script

The `install-script-inside-vm.sh` script inside the Azure VM performs the following tasks:

1. Sets up the required repositories.
2. Installs Python3 and pip.
3. Installs Azure SDK packages for authentication and Key Vault access.

You may need to edit this script if you have additional setup requirements specific to your project. To customize the script:

1. Open `install-script-inside-vm.sh` in your Azure VM.

2. Modify the script with key_vault_name and secret_name. 

For secret_name : 
```
output "azurerm_key_vault_secret_name" {
  value = azurerm_key_vault_secret.example.name
}
```

For key_value_name : 
```
output "key_vault_name" {
  value = azurerm_key_vault.azurerm_key_vault.name
}
```

3. Save the changes and run the script inside the VM.

The script also creates a Python script to fetch secrets from Key Vault and demonstrates Key Vault secret retrieval.

Feel free to customize the installation script to suit your specific needs.


```bash
./after-terraform-cmd.sh