resource "openstack_compute_keypair_v2" "irida_keypair" {
  name       = "irida_keypair"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "openstack_networking_network_v2" "irida_network_1" {
  name           = "irida_network_1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name            = "irida_subnet_1"
  network_id      = "${openstack_networking_network_v2.irida_network_1.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = "${var.dns_nameservers}"
}

resource "openstack_networking_router_v2" "router_1" {
  name                = "router_1"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.public_network.id}"
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = "${openstack_networking_router_v2.router_1.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_1.id}"
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "${var.pool}"
}

resource "openstack_compute_instance_v2" "irida" {
  name            = "irida_instance"
  image_name      = "${var.image_name}"
  flavor_name     = "${var.flavor_name}"
  key_pair        = "${openstack_compute_keypair_v2.irida_keypair.name}"
  security_groups = ["default", "irida_secgroup", "general_secgroup"]
  user_data       = "#cloud-config\nhostname: ${var.fqdn} \nfqdn: ${var.fqdn}"

  metadata {
    ansible_groups = "irida"
  }

  network {
    uuid = "${openstack_networking_network_v2.irida_network_1.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "irida_fip1" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.irida.id}"

  connection {
    host        = "${openstack_networking_floatingip_v2.floatip_1.address}"
    user        = "${var.ssh_user_name}"
    private_key = "${file(var.ssh_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get install -y python python-pip",
    ]
  }

  # https://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html
  provisioner "local-exec" {
    command = "printf '[devservers]\n${openstack_networking_floatingip_v2.floatip_1.address}\n' > hosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -e ansible_ssh_private_key_file=${var.ssh_key_file} -u ubuntu -i hosts ansible/site.yml"
  }
}
