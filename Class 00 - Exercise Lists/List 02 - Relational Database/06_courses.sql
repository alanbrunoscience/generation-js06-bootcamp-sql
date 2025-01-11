CREATE DATABASE db_butcher_shop;

USE db_butcher_shop;

CREATE TABLE tb_categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prod_category VARCHAR(100) NOT NULL,
    description VARCHAR(500) NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO tb_categories (prod_category, description)
VALUES
    ("Beef", "Includes premium cuts and everyday beef products, ideal for grilling, roasting, or stewing. Perfect for various culinary styles."),
    ("Pork", "A versatile meat with tender cuts and flavorful options for roasting, grilling, or frying."),
    ("Poultry", "Lean and healthy meats sourced from birds, suitable for a variety of dishes, from baked to fried."),
    ("Lamb and Sheep", "Tender and flavorful meats from lamb or sheep, ideal for roasting or slow-cooking. Often used in gourmet dishes."),
    ("Fish and Seafood", "Fresh and frozen aquatic products, ideal for health-conscious consumers and a variety of recipes."),
    ("Processed Meats", "Pre-packaged or freshly made meat products, seasoned and ready to cook or serve."),
    ("Exotic Meats", "Uncommon and specialty meats offering unique flavors for adventurous palates."),
    ("Organic Meats", "Sustainably raised meats, free from hormones and antibiotics, perfect for eco-conscious consumers."),
    ("Prepared Meats", "Pre-seasoned or pre-cooked meats, perfect for convenience and ready-to-cook meals."),
    ("Other Meats", "Includes organ meats and specialty cuts used for traditional recipes or unique dishes.");

SELECT * FROM tb_categories;

CREATE TABLE tb_products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prod_name VARCHAR(255) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    unit_of_measure VARCHAR(10) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    prod_category BIGINT,
    FOREIGN KEY (prod_category) REFERENCES tb_categories(id)
);

INSERT INTO tb_products (prod_name, stock_quantity, unit_of_measure, price, prod_category)
VALUES
    ("Lamb Chops", 25, "kg", 34.99, 4), -- Lamb category
    ("Bacon Strips", 40, "kg", 15.99, 2), -- Pork category
    ("Whole Chicken", 60, "unit", 6.99, 3), -- Poultry category
    ("Tilapia Fillet", 30, "kg", 19.49, 5), -- Fish category
    ("Ground Beef", 80, "kg", 9.99, 1), -- Beef category
    ("Marinated Pork Ribs", 20, "kg", 17.99, 2), -- Processed Meat category
    ("Duck Breast", 15, "kg", 24.99, 7), -- Exotic category
    ("Beef Liver", 50, "kg", 6.49, 10); -- Other Meats category

SELECT * FROM tb_products;

SELECT * FROM tb_products WHERE price > 50.00;

SELECT * FROM tb_products WHERE price BETWEEN 50.00 AND 150.00;

SELECT * FROM tb_products WHERE prod_name Like "%c%";

SELECT tb_products.id, prod_name, stock_quantity, unit_of_measure, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, tb_categories.prod_category AS prod_category, tb_categories.description AS description
FROM tb_products 
INNER JOIN tb_categories
ON tb_products.prod_category = tb_categories.id ORDER BY tb_products.id;

SELECT tb_products.id, prod_name, stock_quantity, unit_of_measure, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, tb_categories.prod_category AS prod_category, tb_categories.description AS description
FROM tb_products
INNER JOIN tb_categories
ON tb_products.prod_category = tb_categories.id
WHERE tb_categories.prod_category = "Poultry";