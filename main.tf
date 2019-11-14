
provider "azurerm"{}

terraform {
  backend "azurerm" {
    resource_group_name  = "SBSA-CIB-Risk-Infrastructure"
    storage_account_name = "sbsasancibrisk001"
    container_name       = "sbsasancibrisk001"
    key                  = "starter.terraform.tfstate"
  }
}

#Shared
  deployment_location = "${var.deployment_location}"
  diagnostics_storage = "${var.diagnostics_storage}"
  diagnostics_resource_group = "${var.diagnostics_resource_group}"
  tag_source_deployment = "${var.tag_source_deployment}"
  tag_environment_deployment = "${var.tag_environment_deployment}"
}
##Linux VM Deployment
#Linux VM Image
  image_publisher = "${var.linux_image_publisher}"
  image_offer = "${var.linux_image_offer}"
  image_sku = "${var.linux_image_sku}"
  image_version = "${var.linux_image_version}"

#Linux Credentials
  admin_username = "${var.linux_admin_username}"
  admin_pw = "${var.linux_admin_pw}"

#Jenkins Linux VM
module "jenkins_linux" {
  source = "./terraform-devops"

  hostname = "${var.jenkins_linux_hostname}"
  deployment_rg = "${var.jenkins_linux_deployment_rg}"
  virtual_network_name = "${var.jenkins_linux_virtual_network_name}"
  address_space = "${var.jenkins_linux_address_space}"
  subnet_id = "${var.jenkins_linux_subnet_id}"
  network_security_group = "${var.jenkins_linux_network_security_group}"
  vm_size = "${var.jenkins_linux_vm_size}"

#Rabbit Production Linux VM
module "rabbit_prd_linux" {
  source = "./terraform-devops"

  hostname = "${var.rabbit_prd_hostname}"
  deployment_rg = "${var.rabbit_prd_deployment_rg}"
  virtual_network_name = "${var.rabbit_prd_virtual_network_name}"
  address_space = "${var.rabbit_prd_address_space}"
  subnet_id = "${var.rabbit_prd_subnet_id}"
  network_security_group = "${var.rabbit_prd_network_security_group}"
  vm_size = "${var.rabbit_prd_vm_size}"

#Rabbit Development Linux VM
module "rabbit_dev_linux" {
  source = "./terraform-devops"

  hostname = "${var.rabbit_dev_hostname}"
  deployment_rg = "${var.rabbit_dev_deployment_rg}"
  virtual_network_name = "${var.rabbit_dev_virtual_network_name}"
  address_space = "${var.rabbit_dev_address_space}"
  subnet_id = "${var.rabbit_dev_subnet_id}"
  network_security_group = "${var.rabbit_dev_network_security_group}"
  vm_size = "${var.rabbit_dev_vm_size}"

##Windows Server VM Deployment
#Windows VM Image
  image_publisher = "${var.win_image_publisher}"
  image_offer = "${var.win_image_offer}"
  image_sku = "${var.win_image_sku}"
  image_version = "${var.win_image_version}"

#Windows Credentials
  admin_username = "${var.win_admin_username}"
  admin_pw = "${var.win_admin_pw}"

#Jenkins Windows Server VM
module "jenkins_win64" {
  source = "./terraform-devops"

  hostname = "${var.jenkins_win_hostname}"
  deployment_rg = "${var.jenkins_win_deployment_rg}"
  virtual_network_name = "${var.jenkins_win_virtual_network_name}"
  address_space = "${var.jenkins_win_address_space}"
  subnet_id = "${var.jenkins_win_subnet_id}"
  network_security_group = "${var.jenkins_win_network_security_group}"
  vm_size = "${var.jenkins_win_vm_size}"

#Agents Development Windows Server VM
module "agent_win64" {
  source = "./terraform-devops"

  hostname = "${var.agent_win_hostname}"
  deployment_rg = "${var.agent_win_deployment_rg}"
  virtual_network_name = "${var.agent_win_virtual_network_name}"
  address_space = "${var.agent_win_address_space}"
  subnet_id = "${var.agent_win_subnet_id}"
  network_security_group = "${var.agent_win_network_security_group}"
  vm_size = "${var.agent_win_vm_size}"

#Automation Windows Server VM
module "auto_win64" {
  source = "./terraform-devops"

  hostname = "${var.auto_win_hostname}"
  deployment_rg = "${var.auto_win_deployment_rg}"
  virtual_network_name = "${var.auto_win_virtual_network_name}"
  address_space = "${var.auto_win_address_space}"
  subnet_id = "${var.auto_win_subnet_id}"
  network_security_group = "${var.auto_win_network_security_group}"
  vm_size = "${var.auto_win_vm_size}"