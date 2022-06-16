source /etc/environment

ADMIN_EMAIL_ADDRESS='{{ admin_email_address }}'
ROOT_EMAIL_ADDRESS='{{ root_email_address }}'
{% if is_mysql %}

MYSQL_BACKUP_STORAGE_DIR='{{ mysql_backup_storage_dir }}'
MYSQL_BACKUP_ROTATE_CONF_PATH='{{ mysql_backup_rotate_conf_path }}'
MYSQL_DATABASE_LIST_PATH='{{ mysql_database_list_path }}'
MYSQL_SOCKET_PATH='{{ mysql_socket_path }}'
{% endif %}

BACKUP_RETENTION_DAYS={{ backup_retention_days }}
BACKUP_INCLUDE_LIST_PATH='{{ backup_include_list_path }}'
BACKUP_EXCLUDE_LIST_PATH='{{ backup_exclude_list_path }}'
