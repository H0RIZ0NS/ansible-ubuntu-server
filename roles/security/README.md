# `security`

**BE VERY CAREFUL** before applying this role and make sure you understand the
(non-trivial) changes that will be made.

Here’s a (non-exhaustive) list of changes that will get implemented:

* default SSH port will be changed to a user-defined value
* SSH root login and password authentication will be disabled
* some pretty restrictive *iptables* rules will be set up, including:
    - *DROP* as default policy for all chains
    - basic ICMP/TCP/UDP flood protection
    - only the SSH input port will be left open
    - only some vital output ports will be left open
* a secure (configurable) *umask* value of 077 will be (tentatively) enforced
* the existence of a public-key-authenticated main *sudoer* admin user will be
  guaranteed

**CAUTION:** as mentioned earlier, the default SSH port will be changed, so
immediately after applying this role, you will have to edit the connection port
of the concerned hosts in your inventory, otherwise you won’t be able to get
access to them anymore. I realize that this process is not ideal; I’ll try to
think about a better, more automated solution.

## Role variables

* `ssh_port`: the TCP port that the SSH daemon will listen to
* `iptables_flood_protection_enabled`: whether or not the flood protection rules
  should be added to `iptables` (you might want to turn them off if you experience
  performance issues or weird behavior)
* `iptables_additional_rules`: additional `iptables` rules that will be appended
  to the default ones (you should use a YAML [block literal](https://en.wikipedia.org/wiki/YAML#Indented_delimiting)
  string here)
* `admin_name`: the username of the main admin user; this user may or may not
  already exist on the system
* `admin_password`: the admin user’s password (encrypted, see
  [here](https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module)
  ); if empty, a default password will be generated and stored in a file located
  at `/tmp/pass-[current_datetime]-[admin_name]`
* `admin_ssh_pubkey`: the SSH public key (or a URL to it) with which the admin
  user will be allowed to log into the system

## Example playbook

```yaml
- hosts: …
  tasks:
    - import_role:
        name: roles/security
      vars:
        ssh_port: 22 # I highly recommend that you override this one with a custom value
        iptables_flood_protection_enabled: true
        iptables_additional_rules: ''
        admin_name: admin
        admin_password: ''
        admin_ssh_pubkey: ~ # You should really override this one, otherwise you won’t be able to log in with the admin user
```
