resource "proxmox_vm_qemu" "vm" {
  for_each = var.vms

  name        = each.key
  target_node = each.value.target_node
  vmid        = each.value.vmid

  onboot = true

  # Hardware specs
  cores  = lookup(each.value, "cores", 2)
  memory = lookup(each.value, "memory", 2048)
  agent  = 1 # Enable QEMU agent

  # Clone from a template with Cloud-Init preconfigured
  clone = each.value.clone_template

  # Disk configuration
  disk {
    type    = "disk"
    storage = lookup(each.value, "storage_pool", "fast-storage")
    size    = lookup(each.value, "disk_size", "20G")
    slot    = lookup(each.value, "disk_slot", 0)
  }

  # Network
  network {
    model  = "virtio"
    bridge = lookup(each.value, "network_bridge", "vmbr0")
    id     = lookup(each.value, "network_id", 0)
  }

  # Cloud-Init Settings
  os_type = "cloud-init"

  # User configuration
  ciuser     = each.value.cloud_init.user
  cipassword = lookup(each.value.cloud_init, "password", null) # Optional (avoid storing passwords in plaintext)

  # IP Configuration (static or DHCP)
  ipconfig0 = each.value.cloud_init.ip_config

  # SSH Keys (supports multiple keys)
  sshkeys = join("\n", each.value.cloud_init.ssh_keys)
}
