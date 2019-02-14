resource "openstack_networking_secgroup_rule_v2" "general_ssh_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}

resource "openstack_networking_secgroup_rule_v2" "general_ntp_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 123
  port_range_max    = 123
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${var.secgroup_id}"
}
