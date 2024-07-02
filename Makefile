########################################################################

.DEFAULT_GOAL := up

SHELL := /usr/bin/env bash -Eeu -o pipefail

export ANSIBLE_INVENTORY := config/hosts.dev.ini

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
	ansible-playbook --diff --limit vagrant.dev playbooks/main.yml

.PHONY: check
check:
	ansible-playbook --diff --check --limit vagrant.dev playbooks/main.yml

########################################################################
