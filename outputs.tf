output "jenkins_linux_vm_id" {
  description = "Reference to a VM with which this NIC has been associated"
  value = "${module.jenkins_linux.vm_id}"
}
output "rabbit_prd_linux_vm_id" {
  description = "Reference to a VM with which this NIC has been associated"
  value = "${module.rabbit_prd_linux.vm_id}"
}
output "rabbit_dev_linux_vm_id" {
  description = "Reference to a VM with which this NIC has been associated"
  value = "${module.rabbit_dev_linux.vm_id}"
}
output "jenkins_win64_vm_id" {
  description = "Reference to a VM with which this NIC has been associated"
  value = "${module.jenkins_win64.vm_id}"
}
output "agent_win64_vm_id" {
  description = "Reference to a VM with which this NIC has been associated"
  value = "${module.agent_win64.vm_id}"
}
output "auto_win64_vm_id" {
  description = "Reference to a VM with which this NIC has been associated"
  value = "${module.auto_win64.vm_id}"
}