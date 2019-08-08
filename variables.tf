variable "image_name" {
  default = "packer-ubuntu-16.04-hwe"
}

variable "flavor_name" {
  default = "ld1.large"
}

variable "ssh_key_file" {
  default = "~/.ssh/vms"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "pool" {
  default = "public1"
}

variable "fqdn" {
  default = "iridadev.sanbi.ac.za"
}

variable "ceph_network" {
  default = "ceph-net"
}

variable "dns_nameservers" {
  default = ["192.168.2.75", "192.168.2.8", "8.8.8.8", "8.8.4.4"]
}
