SHELL := /usr/bin/env bash -Eeu -o pipefail

.PHONY: up
up: requirements
	vagrant up

.requirements/ansible_collections/:
	ansible-galaxy collection install --requirements-file requirements.yml

.requirements/ansible_roles/:
	ansible-galaxy role install --role-file requirements.yml

.PHONY: requirements
requirements: .requirements/ansible_collections/ .requirements/ansible_roles/

.PHONY: apply
apply:
	ansible-playbook --diff --inventory=hosts.dev playbooks/stack.yml

.PHONY: check
check:
	ansible-playbook --diff --check --inventory=hosts.dev playbooks/stack.yml
