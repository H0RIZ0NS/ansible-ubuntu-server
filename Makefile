########################################################################

SHELL := /usr/bin/env bash -Eeu -o pipefail

.DEFAULT_GOAL := up

########################################################################

.PHONY: up
up: requirements
	vagrant up

.PHONY: requirements
requirements: .requirements/ansible_collections/

.requirements/ansible_collections/:
	ansible-galaxy collection install --requirements-file requirements.yml

.PHONY: apply
apply:
	ansible-playbook --diff --inventory=config/hosts.dev --limit vagrant.dev playbooks/main.yml

.PHONY: check
check:
	ansible-playbook --diff --check --inventory=config/hosts.dev --limit vagrant.dev playbooks/main.yml

########################################################################
