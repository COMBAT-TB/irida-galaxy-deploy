resource "openstack_networking_secgroup_v2" "irida_galaxy" {
  name        = "irida_galaxy"
  description = "Security group for the irida_galaxy example instances"
}

resource "openstack_networking_secgroup_rule_v2" "irida_galaxy" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_21" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 21
  port_range_max    = 21
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}
resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_80" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_8080" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}
resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_8800" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8800
  port_range_max    = 8800
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}
resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_9090" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9090
  port_range_max    = 9090
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}
resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_9002" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9002
  port_range_max    = 9002
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_3306" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3306
  port_range_max    = 3306
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_galaxy_2376" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 2376
  port_range_max    = 2376
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida_galaxy.id}"
}
