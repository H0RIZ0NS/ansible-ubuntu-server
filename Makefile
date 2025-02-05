export SHELL := /usr/bin/env bash -Eeu -o pipefail
export ANSIBLE_INVENTORY := config/hosts.dev.ini

.PHONY: install
install: .requirements/ansible_collections/

.requirements/ansible_collections/:
	ansible-galaxy collection install --requirements-file requirements.yml

.PHONY: apply
apply:
	ansible-playbook --diff --limit ubuntu.dev playbooks/main.yml

.PHONY: check
check:
	ansible-playbook --diff --check --limit ubuntu.dev playbooks/main.yml
