resource "openstack_compute_keypair_v2" "irida" {
  name       = "irida"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "openstack_networking_network_v2" "irida" {
  name           = "irida"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "irida" {
  name            = "irida"
  network_id      = "${openstack_networking_network_v2.irida.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "irida" {
  name                = "irida"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.irida.id}"
}

resource "openstack_networking_router_interface_v2" "irida" {
  router_id = "${openstack_networking_router_v2.irida.id}"
  subnet_id = "${openstack_networking_subnet_v2.irida.id}"
}

resource "openstack_networking_floatingip_v2" "irida" {
  pool = "${var.pool}"
}

resource "openstack_compute_instance_v2" "irida" {
  name            = "irida"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${openstack_compute_keypair_v2.irida.name}"
  security_groups = ["default", "${openstack_networking_secgroup_v2.irida.name}"]

  network {
    uuid = "${openstack_networking_network_v2.irida.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "irida" {
  floating_ip = "${openstack_networking_floatingip_v2.irida.address}"
  instance_id = "${openstack_compute_instance_v2.irida.id}"

  connection {
    host        = "${openstack_networking_floatingip_v2.irida.address}"
    user        = "${var.ssh_user_name}"
    private_key = "${file(var.ssh_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
    ]
  }

  # Copies the docker-compose.yml
  #provisioner "file" {6
  #  source      = "docker-irida"
  # destination = "./"
  #}

  # deploy irida
  #provisioner "remote-exec" {
  #  script = "./deploy-irida.sh"
  #}
}
