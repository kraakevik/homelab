data "bitwarden-secrets_secret" "public_ssh_key" {
  id = "c03207e9-dc3d-4900-9c01-b1a300fef12e"
}

resource "proxmox_lxc" "samba" {
  vmid         = 101
  target_node  = "pve"
  hostname     = "samba"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  unprivileged = false
  password = "abc123"
  onboot = true
  start = true

   
  ssh_public_keys = data.bitwarden-secrets_secret.public_ssh_key.value

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "vmpool"
    size    = "32G"
  }
  nameserver = "1.1.1.1"

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.30/24"
    gw     = "192.168.1.1"
  }
}