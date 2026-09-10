#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_DIR="${ROOT_DIR}/terraform"
INV="${ROOT_DIR}/ansible/inventory/hosts.ini"
GROUP_VARS="${ROOT_DIR}/ansible/group_vars/all.yml"

command -v terraform >/dev/null 2>&1 || {
  echo "terraform is required" >&2
  exit 1
}

command -v jq >/dev/null 2>&1 || {
  echo "jq is required" >&2
  exit 1
}

names_json="$(terraform -chdir="${TF_DIR}" output -json instance_names)"
ips_json="$(terraform -chdir="${TF_DIR}" output -json instance_ipv4)"

count="$(jq 'length' <<<"${names_json}")"

{
  echo "[app]"
  for ((i=0; i<count; i++)); do
    name="$(jq -r ".[$i]" <<<"${names_json}")"
    ip="$(jq -r ".[$i]" <<<"${ips_json}")"
    printf '%s ansible_host=%s\n' "${name}" "${ip}"
  done
  echo
  echo "[app:vars]"
  echo "ansible_user=ubuntu"
} > "${INV}"

if [[ ! -f "${GROUP_VARS}" ]]; then
  cp "${ROOT_DIR}/ansible/group_vars/all.yml.example" "${GROUP_VARS}"
fi

echo "Generated ${INV}"
echo "Review ansible_user and reachable addresses before running Ansible."
