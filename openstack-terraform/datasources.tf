data "openstack_networking_network_v2" "irida_galaxy" {
  name = "${var.pool}"
}
