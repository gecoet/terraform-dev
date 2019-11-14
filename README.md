# Terraform Core Infrastrucute

This project drives the core infrastructure that underpins our services.

- Subnets
- Keyvaults
- Jenkins Linux VM
- Jenkins Windows VM
- Rabbit Production VM
- Rabbit Development VM
- Automation VM
- Agents Vm

## 1. IAAS VM's

- The DevOps VM's will be deployed into the management Resource Group
- The deployments of Linux VM's will be used for Jenkins, Rabbit and the Risk app store.
- After VM deployments Boot diagnostics will be enabled and VM extensions will be installed.
- VM's will be linked to Data object "pre-deployed backend services"

## 2. Prerequisite for Azure Core Infra VM's

- Desired Resource Group should be in place
- Virtual network should be configured
- Subnet for VM's should be configured
- Network Security Group should be configured
- Shared Storage account for all diagnostics services should be in place 

## 3. Variables

|Octopus Variable|Variable Name|Variable Description|Hard Coded (tfvars)|
|---|---|---|---|
|ResourceGroupName|resource_group_name|This specifies the name of the resource group.||
|DeploymentLocation|deployment_location|The Azure region the vm will be deployed to.||
|Hostname|hostname|The name of the VM.||
|NetworkSecurityGroup|network_security_group|The network security group used for vm.||
|VirtualNetworkName|virtual_network_name|This specifies name of virtual network where VM's will be configured.||
|AddressSpace|address_space|The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created||
|SubnetID|subnet_id|The Name for the subnet||
|StorageTier|storage_account_tier|Defines the storage tier. Valid options are Standard and Premium.||
|VmSize|vm_size|Specifies the size of the virtual machine.||
|ImagePublisher|image_publisher|Name of the publisher of the image (az vm image list "Canonical").||
|ImageOffer|image_offer|Name of the offer (UbuntuServer).||
|ImageSku|image_sku|Image SKU to apply (18.04-LTS).||
|ImageVersion|image_version|Image version to apply (latest).||
|BootDiagnostics|boot_diagnostics|TEnable or Disable boot diagnostics.||
|BootDiagnosticsStorageAccountType|boot_diagnostics_sa_type|Storage account type for boot diagnostics (LRS / GRS / ZRS).||
|DiagnosticsRG|diagnostics_resource_group|Specifies the Resource group for diagnostics.||
|DiagnosticsStorage|diagnostics_storage|storage account used for diagnostics.||
|AdminUsername|admin_username|The local Admin username.||
|AdminPassword|admin_pw|The local Admin Password.||
|TagDeploymentSource|tag_source_deployment|Source of the deployment.||
|EnvironmentDeploy|tag_environment_deployment|Environment of the deployment||

### 3.1. Octopus Deploy

Please ensure the following vars are catered for in Octopus:

```terraform

  # General locals
  tag_source_deployment = "#{SourceDeploymentTag}" 
  tag_environment_deployment = "#{EnvironmentDeploymentTag}"

  # subnet locals
  subnet_resource_group_name = "#{SubnetRGName}" 
  subnet_name = "#{SubnetName}" 
  subnet_virtual_network_name = "#{VNetName}" 
  address_prefix = "#{SubnetCIDR}" 

  # Key Vault locals
  deployment_rg = "#{DeploymentRGName}" 
  key_vault_name = "#{KeyVaultName}" 
  key_vault_tenant_id = "#{KeyVaultTenantId}" 
  key_vault_sku_name = "#{KeyVaultSKU}" 

  # Key Vault Access Policy locals
  key_vault_access_policy_object_id = "#{KeyVaultAccessPolicyObjectId}" 

```
Octopus Deploy does a replace of these placeholders per environment.

Octopus Deploy also manages the Access Key for the Azure Blob Storage backend for the Terraform project. The Jenkinsfile has a step that replaces a placeholder in the main.tf file with the key.

```terraform

terraform {
  backend "azurerm" {
    resource_group_name  = "SAN-CIBRiskTech-DevOps"
    storage_account_name = "sasandosta001"
    container_name       = "sasanpdstc001"
    key                  = "base-infra.terraform.tfstate"
    ######
  }
}

```
becomes

```terraform

  terraform {
  backend "azurerm" {
    resource_group_name  = "SAN-CIBRiskTech-DevOps"
    storage_account_name = "sasandosta001"
    container_name       = "sasanpdstc001"
    key                  = "base-infra.terraform.tfstate"
    access_key			     ="#{AccessKey}"
  }
}

```
and Octopus injects the Storage Account Access key into the slug provided.

## 4. Outputs

|Output Name|Description|
|---|---|
|VM_id|Reference to a VM with which this NIC has been associated.|

## 5. Gotchas

DuringAt the time of testing the VMAccessAgent extension deployment on a Windows Server VM, it came to light that the latest version (in some regions) has issues when the CMD gets executed inside the VM. Work around is to set "auto_upgrade_minor_version = false" and to set "type_handler_version = 2.3"


