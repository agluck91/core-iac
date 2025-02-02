variable "vms" {
  description = "Map of VMs with their configurations"
  type = map(object({
    target_node    = string
    clone_template = string
    vmid           = number
    cores          = optional(number)
    memory         = optional(number)
    disk_size      = optional(string)
    disk_slot      = string
    storage_pool   = optional(string)
    network_bridge = optional(string)
    network_id     = number
    cloud_init = object({
      user      = string
      password  = optional(string)
      ip_config = string          # e.g., "ip=dhcp" or "ip=192.168.1.10/24,gw=192.168.1.1"
      ssh_keys  = list(string)    # List of SSH public keys
    })
  }))
}
variable "PROXMOX_VE_ENDPOINT" {
  description = "Proxmox API Endpoint"
  type        = string
}

variable "PROXMOX_VE_INSECURE" {
  description = "Allow insecure TLS connections"
  type        = bool
  default     = false
}

variable "PROXMOX_VE_PASSWORD" {
  description = "Proxmox Password"
  type        = string
  sensitive   = true
}

variable "PROXMOX_VE_USERNAME" {
  description = "Proxmox Username"
  type        = string
}
