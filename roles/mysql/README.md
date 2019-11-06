# `mysql`

## Role variables

* `mysql_databases`: a list of databases that should exist
* `mysql_users`: a list of users that should exist; each element in this list is
  an object with the following properties:
    - `username`: the user’s name
    - `password`: the user’s password (in native hashed form, please see
      [here](https://dev.mysql.com/doc/refman/5.7/en/password-hashing.html))
    - `owned_databases`: a list of databases over which the user will have full
      privileges (except `GRANT`)
* `mysql_backup_cron_hour`: the hour at which MySQL’s daily backup should run
  (must be quoted as a string)
* `mysql_backup_cron_minute`: the minute at which MySQL’s daily backup should run
  (must be quoted as a string)

## Example playbook

```yaml
- hosts: …
  tasks:
    - import_role:
        name: roles/mysql
      vars:
        mysql_databases:
          - db1
          - db2
        mysql_users:
          -
            username: john
            password: '*06C0BF5B64ECE2F648B5F048A71903906BA08E5C' # test1
            owned_databases:
              - db2
          -
            username: jack
            password: '*7CEB3FDE5F7A9C4CE5FBE610D7D8EDA62EBE5F4E' # test2
            owned_databases:
              - db1
              - db2
        mysql_backup_cron_hour: '2'
        mysql_backup_cron_minute: '0'
```
