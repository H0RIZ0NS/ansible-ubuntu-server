# `webapp`

This role will bootstrap an Apache/PHP deployment environment for websites and
web apps, and is optimized for working with the famous «Capistrano workflow». In
particular, it means that: 1 app = 1 Apache vhost = 1 Linux user, and that this
app will be hosted in this user’s home directory, and that the app’s document
root will be set to `/home/{user_name}/public_html` (this actually being a
symbolic link to `/home/{user_name}/app/current`, which will itself generally be
a symbolic link to `/home/{user_name}/releases/{some_release}`, depending on the
deployment tool you’re using).

## Role variables

* `paranoid_mode`: when `true`, enables some «security through obscurity» tricks
  (mainly: it will hide Apache/PHP server signatures from HTTP headers)
* `default_http_port`: the default TCP port that Apache will listen to by default,
  in case you haven’t configured a specific port for a given virtual host
* `deploy_pubkeys`: a list of SSH public keys that can be used to log into any
  app-hosting user account (each item in the array can be either the actual public
  key, or a URL where the key can be found)
* `vhosts`: a list of objects describing the applications that will be hosted
  on the target hosts; each element in this list is an object with the following
  properties (optional properties are marked with a __*__):
    - `name`: the name identifying the application; it will be used as the
      user account name, Apache vhost name, Apache log directory name, etc.
    - `http_port`: the TCP port that Apache will listen to for this virtual host
    - `server_name`: a FQDN that will be used as the value of the `ServerName`
      Apache directive
    - `server_aliases*`: an array of alias FQDNs that will be concatenated as the
      value of the `ServerAlias` Apache directive
    - `additional_vhost_config*`: a string containing some literal Apache config
      that will be inserted at the end of the vhost’s Ansible-generated config
      (you should use a YAML [block literal](https://en.wikipedia.org/wiki/YAML#Indented_delimiting)
      string here)
    - `additional_docroot_config*`: same thing as above but scoped to the vhost’s
      document root folder thanks to a `<Directory>` directive

## Example playbook

```yaml
- hosts: …
  tasks:
    - import_role:
        name: roles/webapp
      vars:
        paranoid_mode: true
        default_http_port: 80
        deploy_pubkeys:
          - http://github.com/some_user.keys
        vhosts:
          - name: some_app
            http_port: 443
            server_name: example.org
            server_aliases:
              - www.example.org
              - test.example.org
            additional_vhost_config: |
              DefaultType text/html
              FileETag All
            additional_docroot_config: |
              php_admin_value post_max_size 8M
              php_admin_value upload_max_filesize 4M
          - name: other_stuff
            server_name: internet.com
```
