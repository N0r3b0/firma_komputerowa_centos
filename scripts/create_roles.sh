#!/bin/bash

# Połączenie z PostgreSQL flaga -c pozwala na wykonanie pojedynczego polecenia SQL po niej
PSQL="psql -U postgres -d firma_komputerowa -c"

# Tworzenie ról
echo "Tworzenie ról..."
$PSQL "CREATE ROLE rola1"
$PSQL "CREATE ROLE rola2"
$PSQL "CREATE ROLE rola3"
$PSQL "CREATE ROLE rola4"
$PSQL "CREATE ROLE rola5"

# Przypisywanie użytkowników do ról
echo "Przypisywanie użytkowników do ról..."
$PSQL "GRANT rola1 TO user1"
$PSQL "GRANT rola2 TO user2"
$PSQL "GRANT rola3 TO user3"
$PSQL "GRANT rola4 TO user4"
$PSQL "GRANT rola5 TO user1, user2"

# Rola 1 – wybrana grupa użytkowników może wyświetlać zawartość tabeli/tabel z dwóch różnych schematów
echo "Nadawanie uprawnień dla roli 1..."
$PSQL "GRANT SELECT ON schema2.Customers, schema3.Orders TO rola1"

# Rola 2 – wybrany użytkownik może tylko usuwać rekordy w tabeli znajdującej się w schemacie, którego nie jest właścicielem
echo "Nadawanie uprawnień dla roli 2..."
$PSQL "GRANT DELETE ON schema1.Products TO rola2"

# Rola 3 – wybrany użytkownik może tylko dodawać rekordy w tabeli znajdującej się w schemacie, którego nie jest właścicielem
echo "Nadawanie uprawnień dla roli 3..."
$PSQL "GRANT INSERT ON schema2.Customers TO rola3"

# Rola 4 – wybrany użytkownik może tylko wyświetlać zawartość jednej kolumny w tabeli znajdującej się w schemacie, którego nie jest właścicielem
echo "Nadawanie uprawnień dla roli 4..."
$PSQL "GRANT SELECT (Name) ON schema1.Products TO rola4"

# Rola 5 – wybrana grupa użytkowników może aktualizować zawartość tabeli/tabel z dwóch różnych schematów
echo "Nadawanie uprawnień dla roli 5..."
$PSQL "GRANT UPDATE ON schema2.Customers, schema3.Orders TO rola5"

echo "Tworzenie ról i nadawanie uprawnień zakończone."
