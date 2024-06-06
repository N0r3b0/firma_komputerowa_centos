#!/bin/bash

# Połączenie z PostgreSQL flaga -c pozwala na wykonanie pojedynczego polecenia SQL po niej
PSQL="psql -U postgres -d firma_komputerowa -c"

# Nadawanie uprawnień do wyświetlania listy tabel, ale nie zawartości tabel
$PSQL "GRANT USAGE ON SCHEMA schema1 TO user2, user3, user4"
$PSQL "GRANT USAGE ON SCHEMA schema2 TO user1, user3, user4"
$PSQL "GRANT USAGE ON SCHEMA schema3 TO user1, user2, user4"
$PSQL "GRANT USAGE ON SCHEMA schema4 TO user1, user2, user3"

$PSQL "GRANT SELECT ON ALL TABLES IN SCHEMA schema1 TO user1"
$PSQL "GRANT SELECT ON ALL TABLES IN SCHEMA schema2 TO user2"
$PSQL "GRANT SELECT ON ALL TABLES IN SCHEMA schema3 TO user3"
$PSQL "GRANT SELECT ON ALL TABLES IN SCHEMA schema4 TO user4"

echo "Nadawanie uprawnień zakończone."
