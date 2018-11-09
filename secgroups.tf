resource "openstack_networking_secgroup_v2" "neo4j" {
  name        = "neo4j"
  description = "Security group for the neo4j example instances"
}

resource "openstack_networking_secgroup_rule_v2" "neo4j" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.neo4j.id}"
}

resource "openstack_networking_secgroup_rule_v2" "neo4j_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.neo4j.id}"
}

resource "openstack_networking_secgroup_rule_v2" "neo4j_80" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.neo4j.id}"
}

resource "openstack_networking_secgroup_rule_v2" "neo4j_7474" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 7474
  port_range_max    = 7474
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.neo4j.id}"
}

resource "openstack_networking_secgroup_rule_v2" "neo4j_7687" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 7687
  port_range_max    = 7687
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.neo4j.id}"
}

resource "openstack_networking_secgroup_rule_v2" "neo4j_2376" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 2376
  port_range_max    = 2376
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.neo4j.id}"
}
