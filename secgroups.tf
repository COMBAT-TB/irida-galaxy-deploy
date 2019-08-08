# new
resource "openstack_networking_secgroup_v2" "irida_secgroup" {
  name        = "irida_secgroup"
  description = "IRIDA irida access security group"
}

resource "openstack_networking_secgroup_v2" "general_secgroup" {
  name        = "general_secgroup"
  description = "My neutron ssh-access security group"
}

module "general" {
  source      = "./modules/network_rules/general"
  secgroup_id = "${openstack_networking_secgroup_v2.general_secgroup.id}"
}

module "irida" {
  source      = "./modules/network_rules/irida"
  secgroup_id = "${openstack_networking_secgroup_v2.irida_secgroup.id}"
}

# Old
# resource "openstack_networking_secgroup_v2" "irida" {
#   name        = "irida"
#   description = "Security group for the irida instances"
# }


# resource "openstack_networking_secgroup_rule_v2" "irida_icmp" {
#   direction         = "ingress"
#   ethertype         = "IPv4"
#   protocol          = "icmp"
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = "${openstack_networking_secgroup_v2.irida.id}"
# }


# resource "openstack_networking_secgroup_rule_v2" "irida_22" {
#   direction         = "ingress"
#   ethertype         = "IPv4"
#   protocol          = "tcp"
#   port_range_min    = 22
#   port_range_max    = 22
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = "${openstack_networking_secgroup_v2.irida.id}"
# }


# resource "openstack_networking_secgroup_rule_v2" "irida_80" {
#   direction         = "ingress"
#   ethertype         = "IPv4"
#   protocol          = "tcp"
#   port_range_min    = 80
#   port_range_max    = 80
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = "${openstack_networking_secgroup_v2.irida.id}"
# }


# resource "openstack_networking_secgroup_rule_v2" "irida_8080" {
#   direction         = "ingress"
#   ethertype         = "IPv4"
#   protocol          = "tcp"
#   port_range_min    = 8080
#   port_range_max    = 8080
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = "${openstack_networking_secgroup_v2.irida.id}"
# }


# resource "openstack_networking_secgroup_rule_v2" "irida_3306" {
#   direction         = "ingress"
#   ethertype         = "IPv4"
#   protocol          = "tcp"
#   port_range_min    = 3306
#   port_range_max    = 3306
#   remote_ip_prefix  = "0.0.0.0/0"
#   security_group_id = "${openstack_networking_secgroup_v2.irida.id}"
# }


/*resource "openstack_networking_secgroup_rule_v2" "irida_2376" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 2376
  port_range_max    = 2376
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.irida.id}"
} */

