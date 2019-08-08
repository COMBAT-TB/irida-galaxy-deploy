variable "image" {
  default = "packer-ubuntu-16.04-hwe"
}

variable "flavor" {
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
  default = "iridagalaxy.sanbi.ac.za"
}

variable "dns_nameservers" {
  default = ["192.168.2.75", "192.168.2.8", "8.8.8.8", "8.8.4.4"]
}
