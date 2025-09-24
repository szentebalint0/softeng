
-- Insert top-level categories
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Electronics', NULL),   -- ID 1
('Clothing', NULL),      -- ID 2
('Home & Garden', NULL); -- ID 3

-- Insert Electronics subcategories
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Mobile Phones', 1),
('Laptops', 1),
('Cameras', 1);

-- Insert Clothing subcategories
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Men''s Clothing', 2),
('Women''s Clothing', 2),
('Accessories', 2);

-- Insert Home & Garden subcategories
INSERT INTO Category (CategoryName, ParentCategoryFk) VALUES
('Furniture', 3),
('Kitchenware', 3),
('Gardening Tools', 3);