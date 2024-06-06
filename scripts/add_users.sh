#!/bin/bash

# Plik tekstowy z nazwami kont i grup użytkowników
FILE="/var/lib/pgsql/projekt/users"

# Sprawdzenie czy plik istnieje
if [[ ! -f "$FILE" ]]; then
  echo "Plik $FILE nie istnieje."
  exit 1
fi

# Połączenie z PostgreSQL
PSQL="psql -U postgres -d postgres -c"

# Odczytanie pliku linijka po linijce
while IFS=: read -r user group
do
  # Tworzenie grupy (roli), jeśli nie istnieje
  if ! $PSQL "SELECT 1 FROM pg_roles WHERE rolname='$group'" | grep -q 1; then
    echo "Tworzenie grupy: $group"
    $PSQL "CREATE ROLE $group"
  fi

  # Tworzenie użytkownika, jeśli nie istnieje
  if ! $PSQL "SELECT 1 FROM pg_roles WHERE rolname='$user'" | grep -q 1; then
    echo "Tworzenie użytkownika: $user"
    $PSQL "CREATE USER $user WITH PASSWORD 'password'"
    $PSQL "GRANT $group TO $user"
  else
    echo "Użytkownik $user już istnieje."
  fi

done < "$FILE"

echo "Tworzenie użytkowników zakończone."
