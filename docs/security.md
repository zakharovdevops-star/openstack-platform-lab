# Security notes

This repository is intentionally conservative about secrets.

## Credentials

Do not commit `clouds.yaml`, `secure.yaml`, `openrc.sh`, passwords, application credentials, private SSH keys, or Terraform state.

The `.gitignore` excludes common credential and state files, but `.gitignore` is not a security boundary.

## Recommended authentication

For automation, prefer short-lived or scoped credentials where supported. OpenStack application credentials are generally preferable to embedding a user password in CI variables because they can be scoped and revoked independently.

## Terraform state

A production implementation should use encrypted remote state, access control, state locking, audit logging, and backup/recovery procedures.

## Administrative access

The lab allows SSH only from `admin_cidr`. For production, consider VPN, bastion hosts, zero-trust access and avoiding direct Internet-reachable SSH.

## Images

Treat base images as supply-chain dependencies. Define image ownership, patching cadence, vulnerability scanning, hardening baseline, deprecation policy and a rebuild process.

## Network policy

Production design may require multiple security groups by role, explicit east-west policy, load balancers, IPv6 policy, egress restrictions and centralized firewalling.
