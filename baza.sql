CREATE DATABASE firma_komputerowa;

\c firma_komputerowa;

-- Tabela Produkty
CREATE TABLE Products (
    Product_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specification TEXT,
    Price NUMERIC(10, 2) NOT NULL,
    Availability INT NOT NULL,
    Category VARCHAR(50)
);

-- Tabela Klienci
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT
);

-- Tabela Zamówienia
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Order_Date DATE NOT NULL,
    Status VARCHAR(20) NOT NULL
);

-- Tabela Szczegóły Zamówienia
CREATE TABLE Order_Details (
    Order_Detail_ID SERIAL PRIMARY KEY,
    Order_ID INT REFERENCES Orders(Order_ID),
    Product_ID INT REFERENCES Products(Product_ID),
    Quantity INT NOT NULL,
    Price NUMERIC(10, 2) NOT NULL
);

-- Tabela Dostawcy
CREATE TABLE Suppliers (
    Supplier_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(100)
);

-- Tabela Dostawy
CREATE TABLE Shipments (
    Shipment_ID SERIAL PRIMARY KEY,
    Supplier_ID INT REFERENCES Suppliers(Supplier_ID),
    Shipment_Date DATE NOT NULL,
    Status VARCHAR(20) NOT NULL
);

-- Tabela Pracownicy
CREATE TABLE Employees (
    Employee_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL
);

-- Tabela Płatności
CREATE TABLE Payments (
    Payment_ID SERIAL PRIMARY KEY,
    Order_ID INT REFERENCES Orders(Order_ID),
    Payment_Date DATE NOT NULL,
    Amount NUMERIC(10, 2) NOT NULL
);
