#!/bin/bash

# Ustawienia
BACKUP_DIR="/var/lib/pgsql/projekt/backup"
BACKUP_FILE="$BACKUP_DIR/firma_komputerowa_backup.sql"

# Sprawdzenie czy katalog backupu istnieje, jeśli nie, utworzenie go
if [[ ! -d "$BACKUP_DIR" ]]; then
  mkdir -p "$BACKUP_DIR"
fi

# Wykonanie backupu bazy danych
pg_dump -U postgres -d firma_komputerowa -F p > "$BACKUP_FILE"  # -F p oznacza Format: plain text -> format sql

# if [[ $? -eq 0 ]]; sprawdza, czy poprzednie polecenie zakończyło się sukcesem
if [[ $? -eq 0 ]]; then  
  echo "Backup bazy danych zakończony sukcesem. Plik backupu: $BACKUP_FILE"
else
  echo "Backup bazy danych nie powiódł się."
fi
