data "openstack_networking_network_v2" "irida" {
  name = "${var.pool}"
}
