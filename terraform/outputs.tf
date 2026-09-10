output "private_network_id" {
  description = "Created Neutron private network ID."
  value       = openstack_networking_network_v2.app.id
}

output "router_id" {
  description = "Created Neutron router ID."
  value       = openstack_networking_router_v2.app.id
}

output "security_group_id" {
  description = "Created Neutron security group ID."
  value       = openstack_networking_secgroup_v2.app.id
}

output "instance_ids" {
  description = "Nova instance IDs."
  value       = openstack_compute_instance_v2.app[*].id
}

output "instance_names" {
  description = "Nova instance names."
  value       = openstack_compute_instance_v2.app[*].name
}

output "instance_ipv4" {
  description = "Primary IPv4 addresses reported by Nova."
  value       = openstack_compute_instance_v2.app[*].access_ip_v4
}
