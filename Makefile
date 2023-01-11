########################################################################

SHELL := /usr/bin/env bash -Eeu -o pipefail

.DEFAULT_GOAL := up

########################################################################

.PHONY: up
up: requirements
	vagrant up

.PHONY: requirements
requirements: .requirements/ansible_collections/ .requirements/ansible_roles/

.requirements/ansible_collections/:
	ansible-galaxy collection install --requirements-file requirements.yml

.requirements/ansible_roles/:
	ansible-galaxy role install --role-file requirements.yml

.PHONY: apply
apply:
	ansible-playbook --diff --inventory=config/hosts.dev playbooks/stack.yml

.PHONY: check
check:
	ansible-playbook --diff --check --inventory=config/hosts.dev playbooks/stack.yml

########################################################################
