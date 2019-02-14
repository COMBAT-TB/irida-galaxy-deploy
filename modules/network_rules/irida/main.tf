resource "openstack_networking_secgroup_rule_v2" "irida_443" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_80" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_8080" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"

resource "openstack_networking_secgroup_rule_v2" "irida_8081" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8081
  port_range_max    = 8081
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_3306" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3306
  port_range_max    = 3306
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_https_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_https_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 4000
  port_range_max    = 4000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_ldap_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 389
  port_range_max    = 389
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "irida_ldaps_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 636
  port_range_max    = 636
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}


resource "openstack_networking_secgroup_rule_v2" "irida_dns_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}
resource "openstack_networking_secgroup_rule_v2" "irida_dns_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}


resource "openstack_networking_secgroup_rule_v2" "irida_ceph_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6789
  port_range_max    = 6789
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}