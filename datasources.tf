data "openstack_networking_network_v2" "neo4j" {
  name = "${var.pool}"
}
