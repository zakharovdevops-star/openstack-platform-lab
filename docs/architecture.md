# Architecture

## Goal

Provision a small, repeatable OpenStack workload environment while demonstrating clear lifecycle boundaries:

1. **Terraform** owns cloud resources.
2. **cloud-init** performs minimum first-boot bootstrap.
3. **Ansible** owns repeatable guest configuration.
4. **Runbooks** document common operational actions.

## OpenStack services represented

### Keystone
Authentication and authorization are deliberately external to the repository. Terraform consumes credentials from the normal OpenStack authentication chain.

### Neutron
The lab creates one private network, one IPv4 subnet, one router, one router interface and one security group. The router uses an existing external network as its gateway.

### Nova
The lab creates a configurable number of instances and places them in a `soft-anti-affinity` server group.

This is not a complete HA design. It demonstrates failure-domain awareness without making the lab impossible to deploy on smaller OpenStack installations.

## Lifecycle

```text
Engineer
   |
   | authenticate
   v
OpenStack API
   ^
   |
Terraform ----> Neutron + Nova resources
   |
   +---------> cloud-init on first boot
                    |
                    v
                 Linux VM
                    ^
                    |
                 Ansible
```

## Why soft anti-affinity?

Hard anti-affinity can make instance scheduling fail when the cloud has insufficient eligible compute hosts. For a portable portfolio lab, soft anti-affinity demonstrates the intent—spread instances when possible—without unnecessarily making deployment brittle.
