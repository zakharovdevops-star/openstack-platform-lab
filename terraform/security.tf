resource "openstack_networking_secgroup_v2" "app" {
  name        = "${var.prefix}-app-sg"
  description = "Security group for the OpenStack platform portfolio lab."

  tags = ["portfolio", "platform-lab"]
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.admin_cidr
  security_group_id = openstack_networking_secgroup_v2.app.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = var.admin_cidr
  security_group_id = openstack_networking_secgroup_v2.app.id
}

resource "openstack_networking_secgroup_rule_v2" "intra_group" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_group_id   = openstack_networking_secgroup_v2.app.id
  security_group_id = openstack_networking_secgroup_v2.app.id
}
