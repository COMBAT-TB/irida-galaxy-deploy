resource "openstack_compute_keypair_v2" "neo4j" {
  name       = "neo4j"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "openstack_networking_network_v2" "neo4j" {
  name           = "neo4j"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "neo4j" {
  name            = "neo4j"
  network_id      = "${openstack_networking_network_v2.neo4j.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4", "192.168.2.75", "192.168.2.8"]
}

resource "openstack_networking_router_v2" "neo4j" {
  name                = "neo4j"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.neo4j.id}"
}

resource "openstack_networking_router_interface_v2" "neo4j" {
  router_id = "${openstack_networking_router_v2.neo4j.id}"
  subnet_id = "${openstack_networking_subnet_v2.neo4j.id}"
}

resource "openstack_networking_floatingip_v2" "neo4j" {
  pool = "${var.pool}"
}

resource "openstack_compute_instance_v2" "neo4j" {
  name            = "neo4j"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${openstack_compute_keypair_v2.neo4j.name}"
  security_groups = ["default", "${openstack_networking_secgroup_v2.neo4j.name}"]

  network {
    uuid = "${openstack_networking_network_v2.neo4j.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "neo4j" {
  floating_ip = "${openstack_networking_floatingip_v2.neo4j.address}"
  instance_id = "${openstack_compute_instance_v2.neo4j.id}"

  connection {
    host        = "${openstack_networking_floatingip_v2.neo4j.address}"
    user        = "${var.ssh_user_name}"
    private_key = "${file(var.ssh_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
    ]
  }

  # provisioner "remote-exec" {
  #   script = "./install-docker.sh"
  # }

  # Copies the docker-compose.yml
  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "docker-compose.yml"
  }
  provisioner "remote-exec" {
    script = "./deploy-neo4j.sh"
  }
}
