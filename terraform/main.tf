resource "null_resource" "create_vm" {
  triggers = {
    vm_name   = var.vm_name
    memory    = tostring(var.memory)
    cpus      = tostring(var.cpus)
    disk_size = tostring(var.disk_size)
    iso_path  = var.iso_path
  }

  provisioner "local-exec" {
    interpreter = ["C:/Program Files/Git/bin/bash.exe", "-lc"]

    command = <<-EOT
      set -euo pipefail

      VBOXMANAGE="/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"
      VM_NAME="${var.vm_name}"
      ISO_PATH="${var.iso_path}"
      #DISK_PATH="$(pwd)/${var.vm_name}.vdi"
      DISK_PATH="/c/Users/your_user_id/VirtualBox VMs/${var.vm_name}/${var.vm_name}.vdi"

      "$VBOXMANAGE" createvm --name "$VM_NAME" --ostype "RedHat_64" --register
      "$VBOXMANAGE" modifyvm "$VM_NAME" --memory ${var.memory} --cpus ${var.cpus} --graphicscontroller vmsvga --vram 128 --accelerate3d on --nic1 nat --nictype1 82540EM --cableconnected1 on
      "$VBOXMANAGE" createhd --filename "$DISK_PATH" --size ${var.disk_size}
      "$VBOXMANAGE" storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
      "$VBOXMANAGE" storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$DISK_PATH"
      "$VBOXMANAGE" storagectl "$VM_NAME" --name "IDE Controller" --add ide
      "$VBOXMANAGE" storageattach "$VM_NAME" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$ISO_PATH"
      "$VBOXMANAGE" modifyvm "$VM_NAME" --boot1 dvd --boot2 disk
      "$VBOXMANAGE" startvm "$VM_NAME" --type gui
    EOT
  }
}
