resource "openstack_compute_keypair_v2" "irida_galaxy" {
  name       = "irida_galaxy"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "openstack_networking_network_v2" "irida_galaxy" {
  name           = "irida_galaxy"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "irida_galaxy" {
  name            = "irida_galaxy"
  network_id      = "${openstack_networking_network_v2.irida_galaxy.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = "${var.dns_nameservers}"
}

resource "openstack_networking_router_v2" "irida_galaxy" {
  name                = "irida_galaxy"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.irida_galaxy.id}"
}

resource "openstack_networking_router_interface_v2" "irida_galaxy" {
  router_id = "${openstack_networking_router_v2.irida_galaxy.id}"
  subnet_id = "${openstack_networking_subnet_v2.irida_galaxy.id}"
}

resource "openstack_networking_floatingip_v2" "irida_galaxy" {
  pool = "${var.pool}"
}

resource "openstack_compute_instance_v2" "irida_galaxy" {
  name            = "${var.fqdn}"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${openstack_compute_keypair_v2.irida_galaxy.name}"
  security_groups = ["default", "${openstack_networking_secgroup_v2.irida_galaxy.name}"]
  user_data       = "#cloud-config\nhostname: ${var.fqdn} \nfqdn: ${var.fqdn}"

  network {
    uuid = "${openstack_networking_network_v2.irida_galaxy.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "irida_galaxy" {
  floating_ip = "${openstack_networking_floatingip_v2.irida_galaxy.address}"
  instance_id = "${openstack_compute_instance_v2.irida_galaxy.id}"

  connection {
    host        = "${openstack_networking_floatingip_v2.irida_galaxy.address}"
    user        = "${var.ssh_user_name}"
    private_key = "${file(var.ssh_key_file)}"
  }

  provisioner "local-exec" {
    command = "echo ${openstack_networking_floatingip_v2.irida_galaxy.address} > instance_ip.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      # Remove older docker versions if installed 
      "sudo apt-get remove docker docker-engine docker.io containerd runc",
    ]
  }

  # Copies all files and folders in ../docker-svc/ to docker-svc/
  provisioner "file" {
    source      = "../docker-svc"
    destination = "docker-svc"
  }

  provisioner "file" {
    source      = "../docker-compose.yml"
    destination = "docker-compose.yml"
  }
  provisioner "file" {
    source      = "./install-docker-and-deploy.sh"
    destination = "install-docker-and-deploy.sh"
  }
  # deploy irida_galaxy
  provisioner "remote-exec" {
    inline = [
      "chmod +x docker-svc/irida/*.sh",
      "chmod +x install-docker-and-deploy.sh",
      "./install-docker-and-deploy.sh",
    ]
  }

  # deploy irida_galaxy
  # provisioner "remote-exec" {
  #   script = "./install-docker-and-deploy.sh"
  # }

}
