.PHONY: apply
apply: ensure-inventory
	ansible-playbook --diff --inventory=hosts playbooks/infra.yml

.PHONY: check
check: ensure-inventory
	ansible-playbook --diff --check --inventory=hosts playbooks/infra.yml

.PHONY: ensure-inventory
ensure-inventory:
ifeq ($(wildcard hosts),)
	@echo 'No inventory file found 😞'
	@exit 1
endif
