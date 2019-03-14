variable "image_id" {
  default = "ceca3226-51cb-4c9a-8a84-db8aedf0b847"
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
  default = "irida-demo.sanbi.ac.za"
}

variable "public_network" {
  default = "public1"
}

variable "ceph_network" {
  default = "ceph-net"
}
