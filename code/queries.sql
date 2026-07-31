-- Query 1: Multi-table join
-- Shows customers and the products they bought where price > $100
SELECT c.FirstName, c.LastName, p.Name AS ProductName, p.Price
FROM Customer c
JOIN Purchase pu ON c.CustomerID = pu.CustomerID
JOIN Product p ON pu.ProductID = p.ProductID
WHERE p.Price > 100.00;

-- Query 2: Aggregate query 
-- Shows total items in stock and average product price
SELECT SUM(StockQuantity) AS TotalInventoryItems, ROUND(AVG(Price), 2) AS AveragePrice
FROM Product;

-- Query 3: Multi-table query 
-- Shows which credit cards belong to which customer emails
SELECT c.Email, cc.CardNumber, cc.ExpiryDate
FROM Customer c
JOIN CreditCard cc ON c.CustomerID = cc.CustomerID;