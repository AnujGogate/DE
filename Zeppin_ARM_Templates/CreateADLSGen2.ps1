# Define parameters
$ResourceGroupName = "zeppin-rg" # Change to your resource group name
$StorageAccountName = "zeppinlake"    # Change to a unique storage account name
$Location = "CentralIndia"
$ContainerName = "silver"

# Login to Azure (if not already logged in)
az login

# Step 1: Create the resource group (if it doesn't already exist)
az group create --name $ResourceGroupName --location $Location

# Step 2: Create the Storage Account
az storage account create `
    --name $StorageAccountName `
    --resource-group $ResourceGroupName `
    --location $Location `
    --sku Standard_LRS `
    --kind StorageV2 `
    --hns true

# Step 3: Create the Container (ADLS Gen2)
$StorageKey = az storage account keys list `
    --account-name $StorageAccountName `
    --resource-group $ResourceGroupName `
    --query [0].value `
    --output tsv

az storage container create `
    --name $ContainerName `
    --account-name $StorageAccountName `
    --account-key $StorageKey

Write-Host "Storage account '$StorageAccountName' with container '$ContainerName' has been created successfully in the '$Location' region."
