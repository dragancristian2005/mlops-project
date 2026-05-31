terraform {
  required_version = ">= 1.5.0"
}

variable "vm_name" {
  default = "Rocky9.7_Ansible"
}

variable "memory" {
  default = 4096
}

variable "cpus" {
  default = 2
}

variable "disk_size" {
  default = 20000
}

variable "iso_path" {
  description = "Path for the ISO"
}
