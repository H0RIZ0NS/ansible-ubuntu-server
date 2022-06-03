<h1 align="center"><img src=".github/img/ansible-stack.png" alt="Ansible Stack"/></h1>

This is an Ansible stack that can be used to provision servers on the Interwebs.
It’s still a work in progress, but provides some good foundation for now.

## Docs

![Soon…](.github/img/soon.jpg)

## TODO

- [ ] Write the docs
- [x] Allow any user to log in through pubkey authentication
- [x] Streamline the backup workflow
- [x] Create an `http` role that would configure HTTP logs’ rotation
- [ ] Store admin passwords in a vault and use them as inventory variables
- [ ] Check if some file modes (set for the `template` or `copy` modules for example) aren’t too restrictive
- [ ] Harden the security even more (install Fail2ban, etc.)
- [ ] Set up a CI workflow
