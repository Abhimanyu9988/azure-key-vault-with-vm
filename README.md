# Azure Resource Provisioning with Terraform

This repository contains Terraform configurations and scripts for provisioning Azure resources, setting up an Azure Key Vault, and securely accessing Key Vault secrets from an Azure Virtual Machine.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - Terraform Deployment
  - Post-Deployment Script
- Variables
- [Inside-VM Installation Script](#inside-vm-installation-script)
- [Contributing](#contributing)
- [License](#license)

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

