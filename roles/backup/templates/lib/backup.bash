declare -r BACKUP_CREDENTIALS_PATH={{ backup_credentials_path }}

_log() {
  printf "\n== ${1}\n\n"
}

_export_credentials() {
  if [[ ! -f "$BACKUP_CREDENTIALS_PATH"  ]] || [[ ! -r "$BACKUP_CREDENTIALS_PATH" ]]; then
    _log "[ERROR] No credential file could be found at ${BACKUP_CREDENTIALS_PATH}"

    exit 1
  fi

  while read var_declaration; do
    if ! echo "$var_declaration" | grep --quiet --perl-regexp "^[A-Z0-9_]+=(?:[^=]+|'[^']+')\$"; then
      _log '[WARNING] Invalid variable declaration, skipping'

      continue
    fi

    export "$var_declaration"
  done \
    < "$BACKUP_CREDENTIALS_PATH"
}
