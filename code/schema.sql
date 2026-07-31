-- Clean-up! Drop tables if they exist to prevent errors on multiple runs
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS CreditCard;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Customer;

-- Step 1: Create Customer Table
CREATE TABLE Customer (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- Step 2: Create Staff Table
CREATE TABLE Staff (
    StaffID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL
);

-- Step 3: Create Product Table
CREATE TABLE Product (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INTEGER NOT NULL
);

-- Step 4: Create CreditCard Table
CREATE TABLE CreditCard (
    CardID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerID INTEGER NOT NULL,
    CardNumber VARCHAR(16) NOT NULL,
    ExpiryDate VARCHAR(5) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Step 5: Create Purchase Table
CREATE TABLE Purchase (
    PurchaseID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    PurchaseDate DATE DEFAULT CURRENT_DATE,
    Quantity INTEGER NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Step 6: Insert sample/dummy data 
INSERT INTO Customer (FirstName, LastName, Email) VALUES 
('Alice', 'Smith', 'alice@example.com'),
('Bob', 'Johnson', 'bob@example.com');

INSERT INTO Staff (FirstName, LastName, Role) VALUES 
('Charlie', 'Admin', 'Manager'),
('Diana', 'Prince', 'Inventory Specialist');

INSERT INTO Product (Name, Price, StockQuantity) VALUES 
('Mechanical Keyboard', 120.00, 50),
('Wireless Mouse', 45.50, 100),
('HD Monitor', 250.00, 30);

INSERT INTO CreditCard (CustomerID, CardNumber, ExpiryDate) VALUES 
(1, '1111222233334444', '12/27'),
(2, '5555666677778888', '08/26');

INSERT INTO Purchase (CustomerID, ProductID, PurchaseDate, Quantity) VALUES 
(1, 1, '2026-07-20', 1),
(1, 2, '2026-07-21', 2),
(2, 3, '2026-07-25', 1);