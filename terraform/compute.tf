resource "openstack_compute_servergroup_v2" "app" {
  name     = "${var.prefix}-app-anti-affinity"
  policies = ["soft-anti-affinity"]
}

resource "openstack_compute_instance_v2" "app" {
  count = var.instance_count

  name            = format("%s-app-%02d", var.prefix, count.index + 1)
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  key_pair        = var.keypair_name
  security_groups = [openstack_networking_secgroup_v2.app.name]

  user_data = file("${path.module}/../cloud-init/user-data.yaml")

  scheduler_hints {
    group = openstack_compute_servergroup_v2.app.id
  }

  network {
    uuid = openstack_networking_network_v2.app.id
  }

  metadata = {
    managed_by = "terraform"
    project    = "openstack-platform-lab"
    role       = "app"
  }

  depends_on = [
    openstack_networking_router_interface_v2.app
  ]
}
