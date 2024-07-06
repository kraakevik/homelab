data "bitwarden-secrets_secret" "public_ssh_key" {
  id = "c03207e9-dc3d-4900-9c01-b1a300fef12e"
}

resource "proxmox_vm_qemu" "tailnet" {
  count = 1
  name = "docker"
  target_node = "pve"
  clone = "debian12-cloudinit"
  onboot = true
  agent = 1
  cloudinit_cdrom_storage = "vmpool"
  cores = 16
  sockets = 1
  cpu = "host"
  memory = "32000"
  scsihw = "virtio-scsi-pci"
  qemu_os = "l26"
  machine = "q35"

  disks {
    scsi {
      scsi0 {
        disk {
          size = 256
          storage = "vmpool"
          emulatessd = true
          iothread = false
          discard = true
          backup = false
          replicate = false
        }
      }
    }
  }

  vga {
    type = "none" 
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
}
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
#set ip dhcp or static
  ipconfig0 = "ip=192.168.1.40/24,gw=192.168.1.1"
  ssh_user="root"
#sshkeys set using variables.
  sshkeys = data.bitwarden-secrets_secret.public_ssh_key.value
}