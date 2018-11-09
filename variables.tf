variable "image" {
  default = "ubuntu-16.04_working"
}

variable "flavor" {
  default = "m1.small"
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
