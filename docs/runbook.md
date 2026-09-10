# Operations runbook

## Pre-flight

```bash
openstack token issue
openstack network list
openstack image list
openstack flavor list
openstack keypair list
```

Confirm that the configured external network, image, flavor, and key pair exist.

## Validate configuration

```bash
make validate
```

## Review planned changes

```bash
make plan
```

Never apply a plan you have not reviewed.

## Apply

```bash
make apply
```

## Verify OpenStack resources

```bash
openstack server list
openstack network list
openstack router list
openstack security group list
```

## Generate inventory

```bash
make inventory
cat ansible/inventory/hosts.ini
```

If the Nova-reported addresses are not reachable from the Ansible control host, replace them with the correct routable addresses or access through a bastion.

## Configure instances

```bash
ansible-galaxy collection install -r ansible/requirements.yml
make ansible
```

## Common incident: instance stuck in ERROR

Collect evidence before recreating the instance:

```bash
openstack server show <server>
openstack console log show <server>
```

Investigate scheduler errors, flavor resources, image problems, Neutron port allocation, security-group configuration and compute-host capacity.

## Common incident: no network connectivity

```bash
openstack port list --server <server>
openstack router show <router>
openstack security group rule list <security-group>
```

Verify subnet CIDR, DHCP, router interface, external gateway, security-group ingress and administrative routes.

## Recovery principle

Prefer rebuilding reproducibly from code over manually repairing undocumented drift. If an emergency manual change is necessary: restore service, document the change, update Terraform/Ansible, reconcile drift, and record root cause/prevention actions.

## Destroy

```bash
make destroy
```
