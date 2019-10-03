output "address" {
  value = "${openstack_networking_floatingip_v2.irida_galaxy.address}"
}
output "volume_devices" {
  value = "${openstack_compute_volume_attach_v2.attached.device}"
}
