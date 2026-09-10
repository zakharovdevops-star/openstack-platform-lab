.PHONY: fmt init validate plan apply destroy inventory ansible check

fmt:
	cd terraform && terraform fmt -recursive

init:
	cd terraform && terraform init

validate: init
	cd terraform && terraform fmt -check -recursive
	cd terraform && terraform validate

plan: init
	cd terraform && terraform plan -out=tfplan

apply:
	cd terraform && terraform apply tfplan

destroy: init
	cd terraform && terraform destroy

inventory:
	./scripts/generate_inventory.sh

ansible:
	cd ansible && ansible-playbook playbooks/bootstrap.yml

check:
	./scripts/check.sh
