#az vm identity assign --name "Azure-key-vault-vm" --resource-group "key-vault-rg"
#echo "Assign permissions to the VM identity"
#echo "Edit the systemAssignedIdentity value in the snippet below"
#az keyvault set-policy --name "keyvaultvmwithterraform" --object-id "<systemAssignedIdentity>" --secret-permissions get list


#!/bin/bash

# Retrieve VM name and resource group name from Terraform outputs
VM_NAME=$(terraform output -raw azurerm_linux_virtual_machine_name | sed 's/"//g' | awk '{$1=$1};1')
RESOURCE_GROUP=$(terraform output -raw resource_group_name | sed 's/"//g' | awk '{$1=$1};1')

# Assign managed identity to the VM
IDENTITY_RESULT=$(az vm identity assign --name "$VM_NAME" --resource-group "$RESOURCE_GROUP")

# Extract the systemAssignedIdentity from the output
SYSTEM_ASSIGNED_IDENTITY=$(echo "$IDENTITY_RESULT" | jq -r '.systemAssignedIdentity')

# Retrieve Key Vault name from Terraform output
KEY_VAULT_NAME=$(terraform output key_vault_name | sed 's/"//g' | awk '{$1=$1};1')

# Set Key Vault policy for the systemAssignedIdentity
az keyvault set-policy --name "$KEY_VAULT_NAME" --object-id "$SYSTEM_ASSIGNED_IDENTITY" --secret-permissions get list

# ssh inside the vm
UserName=$(terraform output -raw admin_username | sed 's/"//g' | awk '{$1=$1};1')
PublicIP=$(terraform output -raw public_ip_address | sed 's/"//g' | awk '{$1=$1};1')
ssh $UserName@$PublicIP