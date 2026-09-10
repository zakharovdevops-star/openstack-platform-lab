resource "openstack_networking_network_v2" "app" {
  name           = "${var.prefix}-app-net"
  admin_state_up = true

  tags = ["portfolio", "platform-lab"]
}

resource "openstack_networking_subnet_v2" "app" {
  name            = "${var.prefix}-app-subnet"
  network_id      = openstack_networking_network_v2.app.id
  cidr            = var.private_subnet_cidr
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers

  tags = ["portfolio", "platform-lab"]
}

resource "openstack_networking_router_v2" "app" {
  name                = "${var.prefix}-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id

  tags = ["portfolio", "platform-lab"]
}

resource "openstack_networking_router_interface_v2" "app" {
  router_id = openstack_networking_router_v2.app.id
  subnet_id = openstack_networking_subnet_v2.app.id
}
