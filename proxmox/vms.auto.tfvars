vms = {
  "srv-prod-node01" = {
    target_node    = "pve-main",
    clone_template = "ubuntu-2404-cloudinit-template",
    vmid           = 500,
    cores          = 4,
    memory         = 4096,
    disk_size      = "30G",
    disk_slot      = "scsi0",
    network_bridge = "vmbr0",
    network_id     = 0,
    storage_pool   = "fast-storage",
    cloud_init = {
      user      = "agluck",
      ip_config = "ip=10.10.1.26/24,gw=10.10.1.1", # Static IP
    }
  },
  "srv-prod-node02" = {
    target_node    = "pve-main",
    clone_template = "ubuntu-2404-cloudinit-template",
    vmid           = 501,
    cores          = 4,
    memory         = 4096,
    disk_size      = "30G",
    disk_slot      = "scsi0",
    network_bridge = "vmbr0",
    network_id     = 0,
    storage_pool   = "fast-storage",
    cloud_init = {
      user      = "agluck",
      ip_config = "ip=10.10.1.27/24,gw=10.10.1.1", # Static IP
    }
  },
  "srv-prod-node03" = {
    target_node    = "pve-main",
    clone_template = "ubuntu-2404-cloudinit-template",
    vmid           = 502,
    cores          = 4,
    memory         = 4096,
    disk_size      = "30G",
    disk_slot      = "scsi0",
    network_bridge = "vmbr0",
    network_id     = 0,
    storage_pool   = "fast-storage",
    cloud_init = {
      user      = "agluck",
      ip_config = "ip=10.10.1.28/24,gw=10.10.1.1", # Static IP
    }
  }
}
