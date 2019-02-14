variable "image" {
  default = "ubuntu-16.04_working"
}

variable "flavor" {
  default = "m1.medium"
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "pool" {
  default = "public1"
}

variable "fqdn" {
  default = "irida-dev.sanbi.ac.za"
}

variable "public_network" {
  default = "public1"
}

variable "ceph_network" {
  default = "ceph-net"
}
