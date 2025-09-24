-- Category hierarchy from Mermaid diagram
--
-- graph TD
--     A[Products]
--     A --> B[Electronics]
--     A --> C[Clothing]
--     A --> D[Home & Garden]
--
--     B --> E[Mobile Phones]
--     B --> F[Laptops]
--     B --> G[Cameras]
--
--     C --> H[Men's Clothing]
--     C --> I[Women's Clothing]
--     C --> J[Accessories]
--
--     D --> K[Furniture]
--     D --> L[Kitchenware]
--     D --> M[Gardening Tools]

-- Clear all tables in correct order
DELETE FROM OrderDetail;
DELETE FROM [Order];
DELETE FROM ProductPriceHistory;
DELETE FROM Product;
DELETE FROM Address;
DELETE FROM Category;
DELETE FROM Customer;

-- Reset identity seeds
DBCC CHECKIDENT ('Category', RESEED, 0);
DBCC CHECKIDENT ('Customer', RESEED, 0);
DBCC CHECKIDENT ('Product', RESEED, 0);
DBCC CHECKIDENT ('ProductPriceHistory', RESEED, 0);
DBCC CHECKIDENT ('Order', RESEED, 0);
DBCC CHECKIDENT ('OrderDetail', RESEED, 0);
DBCC CHECKIDENT ('Address', RESEED, 0);

-- Insert categories
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Electronics', NULL),   -- 1
('Clothing', NULL),      -- 2
('Home & Garden', NULL); -- 3
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Mobile Phones', 1),
('Laptops', 1),
('Cameras', 1);
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Men''s Clothing', 2),
('Women''s Clothing', 2),
('Accessories', 2);
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Furniture', 3),
('Kitchenware', 3),
('Gardening Tools', 3);

-- Insert customers
INSERT INTO Customer (Name, ContactPerson, TaxNumber, PhoneNumber, Email, BillingAddress, IsCompany)
VALUES 
('Acme Ltd.', 'John Doe', '12345678', '123-456-7890', 'acme@example.com', '123 Main St', 1),
('Beta Kft.', 'Jane Smith', '87654321', '987-654-3210', 'beta@example.com', '456 Market St', 1),
('Charlie', 'Charlie Brown', NULL, '555-555-5555', 'charlie@example.com', '789 Elm St', 0);

-- Insert addresses
INSERT INTO Address (CustomerFk, PostCode, City, Street, Detail)
VALUES 
(1, 1000, 'Budapest', 'Main St', '1A'),
(2, 2000, 'Debrecen', 'Market St', '2B'),
(3, 3000, 'Szeged', 'Elm St', '3C');

-- Insert products
INSERT INTO Product (EAN, ProductName, Description, NetPrice, VatPercent, GrossPrice, Stock, CategoryFk)
VALUES 
('1234567890123456', 'Laptop', 'High performance laptop', 300000, 27, 381000, 10, 5),
('2345678901234567', 'Smartphone', 'Latest model smartphone', 150000, 27, 190500, 25, 4),
('3456789012345678', 'Camera', 'Digital camera', 80000, 27, 101600, 15, 6),
('4567890123456789', 'Men''s Jacket', 'Winter jacket', 20000, 27, 25400, 30, 7),
('5678901234567890', 'Women''s Dress', 'Summer dress', 15000, 27, 19050, 20, 8),
('6789012345678901', 'Accessory', 'Fashion accessory', 5000, 27, 6350, 50, 9),
('7890123456789012', 'Furniture', 'Wooden table', 50000, 27, 63500, 5, 10),
('8901234567890123', 'Kitchenware', 'Cooking pot', 8000, 27, 10160, 40, 11),
('9012345678901234', 'Gardening Tool', 'Garden shovel', 3000, 27, 3810, 60, 12);

-- Insert product price history
INSERT INTO ProductPriceHistory (ProductFk, NetPrice, VatPercent, ChangeDateUTC)
VALUES 
(1, 290000, 27, '2025-09-01T10:00:00'),
(2, 140000, 27, '2025-09-01T10:00:00'),
(3, 75000, 27, '2025-09-01T10:00:00');

-- Insert orders
INSERT INTO [Order] (CustomerFk, OrderDate, DiscountPercent, TotalAmount, IsCancelled)
VALUES 
(1, DEFAULT, 10, 350000, 0),
(2, DEFAULT, 0, 150000, 0);

-- Insert order details
INSERT INTO OrderDetail (OrderFk, ProductFk, Quantity, NetPrice, VatPercent, AddressFk)
VALUES 
(1, 1, 1, 300000, 27, 1),
(2, 2, 2, 150000, 27, 2);
