CREATE DATABASE db_drugstore;

USE db_drugstore;

CREATE TABLE tb_categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prod_category VARCHAR(100) NOT NULL,
    description TEXT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO tb_categories (prod_category, description)
VALUES
    ("Medications", "Products used for the treatment of illnesses and medical conditions."),
    ("Vitamins and Supplements", "Nutritional supplements including vitamins and minerals."),
    ("Beauty and Personal Care", "Products for aesthetics and personal hygiene."),
    ("Hygiene and Well-being", "Items related to hygiene and overall well-being."),
    ("Baby and Child Care", "Products designed for the care and hygiene of babies and children."),
    ("Health Care Products", "Medical devices and accessories for personal health monitoring."),
    ("First Aid Products", "Items for immediate treatment of injuries and emergencies."),
    ("Food and Beverages", "Functional foods, snacks, and healthy drinks."),
    ("Veterinary Products", "Medications and care products for animals."),
    ("Other", NULL);

SELECT * FROM tb_categories;

CREATE TABLE tb_products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prod_name VARCHAR(255) NOT NULL,
    generic_name VARCHAR(255) NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL,
    prod_category BIGINT,
    FOREIGN KEY (prod_category) REFERENCES tb_categories(id)
);

INSERT INTO tb_products (prod_name, generic_name, stock_quantity, price, prod_category)
VALUES
    ("Paracetamol", "Acetaminophen", 100, 4.99, 1),
    ("Vitamin C 500mg", NULL, 50, 9.99, 2),
    ("Moisturizing Lotion", NULL, 30, 14.99, 3),
    ("Toothpaste", NULL, 200, 3.49, 4),
    ("Baby Wipes", NULL, 150, 5.99, 5),
    ("Blood Pressure Monitor", NULL, 10, 49.99, 6),
    ("Adhesive Bandages", NULL, 75, 2.99, 7),
    ("Gluten-Free Cookies", NULL, 20, 6.49, 8);

SELECT * FROM tb_products;

SELECT * FROM tb_products WHERE price > 50.00;

SELECT * FROM tb_products WHERE price BETWEEN 5.00 AND 60.00;

SELECT * FROM tb_products WHERE pizza_name Like "%c%";

SELECT tb_products.id, prod_name, generic_name, stock_quantity, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, tb_categories.prod_category AS prod_category, tb_categories.description AS description
FROM tb_products 
INNER JOIN tb_categories
ON tb_products.prod_category = tb_categories.id ORDER BY tb_products.id;

SELECT tb_products.id, prod_name, generic_name, stock_quantity, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, tb_categories.prod_category AS prod_category, tb_categories.description AS description
FROM tb_products 
INNER JOIN tb_categories
ON tb_products.prod_category = tb_categories.id
WHERE tb_categories.prod_category = "Beauty and Personal Care";