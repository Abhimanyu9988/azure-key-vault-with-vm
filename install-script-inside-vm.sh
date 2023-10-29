sudo add-apt-repository universe
sudo apt update
sudo apt install -y python3-pip
pip3 install -y azure.identity
pip3 install -y azure-keyvault-secrets
echo "Please edit the python script to add your key vault name and secret name"
cat <<EOL > fetch_secret.py
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

key_vault_name = "keyvaultvmwithterraform"
key_vault_uri = f"https://keyvaultvmwithterraform.vault.azure.net"
secret_name = "secret-for-azure-kv"

credential = DefaultAzureCredential()
client = SecretClient(vault_url=key_vault_uri, credential=credential)
retrieved_secret = client.get_secret(secret_name)

print(f"The value of secret '{secret_name}' in '{key_vault_name}' is: '{retrieved_secret.value}'")
EOL
echo "Running the python script"
python3 fetch_secret.py
