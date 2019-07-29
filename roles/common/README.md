# `common`

## Role variables

* `installed_locales`: a collection of locales that must be installed on the
  system
* `postmaster_redirect_address`: an e-mail address where *postmaster* and *root*
  e-mails will be redirected to

## Example playbook

```yaml
- hosts: …
  tasks:
    - import_role:
        name: roles/common
      vars:
        installed_locales:
          - en_US.UTF-8
          - en_IE.UTF-8
        postmaster_redirect_address: root@localhost # You should really override this variable
```
