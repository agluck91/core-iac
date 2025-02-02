terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  # Configure the Proxmox provider
  pm_api_url      = var.PROXMOX_VE_ENDPOINT
  pm_user         = var.PROXMOX_VE_USERNAME
  pm_password     = var.PROXMOX_VE_PASSWORD
  pm_tls_insecure = var.PROXMOX_VE_INSECURE
} 
