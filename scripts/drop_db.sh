#!/bin/bash

# Nazwa bazy danych do usunięcia
DB_NAME="firma_komputerowa"

# Usunięcie bazy danych
dropdb -U postgres "$DB_NAME"

if [[ $? -eq 0 ]]; then
  echo "Baza danych $DB_NAME została pomyślnie usunięta."
else
  echo "Usunięcie bazy danych $DB_NAME nie powiodło się."
fi