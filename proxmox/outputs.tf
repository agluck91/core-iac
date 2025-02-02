output "vm_ips" {
  description = "IP addresses of all VMs"
  value = {
    for vm_name, vm in proxmox_vm_qemu.vm : vm_name => vm.default_ipv4_address
  }
}
