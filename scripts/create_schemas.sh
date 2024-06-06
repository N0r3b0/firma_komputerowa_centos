#!/bin/bash

# Połączenie z PostgreSQL flaga -c pozwala na wykonanie pojedynczego polecenia SQL po niej
PSQL="psql -U postgres -d firma_komputerowa -c"

# Tworzenie schematów i przypisanie właścicieli
$PSQL "CREATE SCHEMA schema1 AUTHORIZATION user1"
$PSQL "CREATE SCHEMA schema2 AUTHORIZATION user2"
$PSQL "CREATE SCHEMA schema3 AUTHORIZATION user3"
$PSQL "CREATE SCHEMA schema4 AUTHORIZATION user4"

# Tworzenie tabel w każdym schemacie
$PSQL "CREATE TABLE schema1.Products (Product_ID SERIAL PRIMARY KEY, Name VARCHAR(100) NOT NULL, Specification TEXT, Price NUMERIC(10, 2) NOT NULL, Availability INT NOT NULL, Category VARCHAR(50))"
$PSQL "CREATE TABLE schema2.Customers (Customer_ID SERIAL PRIMARY KEY, First_Name VARCHAR(50) NOT NULL, Last_Name VARCHAR(50) NOT NULL, Email VARCHAR(100), Phone VARCHAR(20), Address TEXT)"
$PSQL "CREATE TABLE schema3.Orders (Order_ID SERIAL PRIMARY KEY, Customer_ID INT REFERENCES schema2.Customers(Customer_ID), Order_Date DATE NOT NULL, Status VARCHAR(20) NOT NULL)"
$PSQL "CREATE TABLE schema4.Order_Details (Order_Detail_ID SERIAL PRIMARY KEY, Order_ID INT REFERENCES schema3.Orders(Order_ID), Product_ID INT REFERENCES schema1.Products(Product_ID), Quantity INT NOT NULL, Price NUMERIC(10, 2) NOT NULL)"

# Dodawanie rekordów do tabel
for i in {1..8}
do
  $PSQL "INSERT INTO schema1.Products (Name, Specification, Price, Availability, Category) VALUES ('Product$i', 'Spec$i', 100.00, 10, 'Category$i')"
  $PSQL "INSERT INTO schema2.Customers (First_Name, Last_Name, Email, Phone, Address) VALUES ('FirstName$i', 'LastName$i', 'email$i@example.com', '123456789', 'Address$i')"
  $PSQL "INSERT INTO schema3.Orders (Customer_ID, Order_Date, Status) VALUES ($i, '2023-01-01', 'Completed')"
  $PSQL "INSERT INTO schema4.Order_Details (Order_ID, Product_ID, Quantity, Price) VALUES ($i, $i, 1, 100.00)"
done

echo "Tworzenie schematów, tabel i dodawanie rekordów zakończone."
