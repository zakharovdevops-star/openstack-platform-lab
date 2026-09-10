#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Terraform formatting"
terraform -chdir="${ROOT_DIR}/terraform" fmt -check -recursive

echo "==> Terraform initialization"
terraform -chdir="${ROOT_DIR}/terraform" init -backend=false -input=false

echo "==> Terraform validation"
terraform -chdir="${ROOT_DIR}/terraform" validate

if command -v ansible-playbook >/dev/null 2>&1; then
  echo "==> Ansible syntax check"
  cp -n "${ROOT_DIR}/ansible/inventory/hosts.ini.example" "${ROOT_DIR}/ansible/inventory/hosts.ini" || true
  cp -n "${ROOT_DIR}/ansible/group_vars/all.yml.example" "${ROOT_DIR}/ansible/group_vars/all.yml" || true
  (
    cd "${ROOT_DIR}/ansible"
    ansible-playbook --syntax-check playbooks/bootstrap.yml
  )
else
  echo "ansible-playbook not installed; skipping Ansible syntax check"
fi
