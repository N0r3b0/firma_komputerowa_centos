#!/bin/bash

# Ustawienia
BACKUP_DIR="/var/lib/pgsql/projekt/backup"
BACKUP_FILE="$BACKUP_DIR/firma_komputerowa_backup.sql"
DB_NAME="firma_komputerowa"

# Utworzenie bazy danych
createdb -U postgres "$DB_NAME"

# if [[ $? -eq 0 ]]; sprawdza, czy poprzednie polecenie zakończyło się sukcesem
if [[ $? -eq 0 ]]; then
  echo "Baza danych $DB_NAME została pomyślnie utworzona."
else
  echo "Utworzenie bazy danych $DB_NAME nie powiodło się."
  exit 1
fi

# Przywrócenie bazy danych z backupu
psql -U postgres -d "$DB_NAME" -f "$BACKUP_FILE"

# if [[ $? -eq 0 ]]; sprawdza, czy poprzednie polecenie zakończyło się sukcesem
if [[ $? -eq 0 ]]; then
  echo "Baza danych $DB_NAME została pomyślnie przywrócona z pliku backupu $BACKUP_FILE."
else
  echo "Przywrócenie bazy danych $DB_NAME nie powiodło się."
fi
