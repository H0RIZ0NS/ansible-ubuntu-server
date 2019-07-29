# `docker`

## Role variables

* `docker_users`: a list of usernames that will be allowed to interact with the
  Docker daemon

## Example playbook

```yaml
- hosts: …
  tasks:
    - import_role:
        name: roles/docker
      vars:
        docker_users:
          - jack
          - joe
```
