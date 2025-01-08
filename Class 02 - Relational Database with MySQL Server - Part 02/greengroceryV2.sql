CREATE DATABASE db_greengrocery;

USE db_greengrocery;

CREATE TABLE tb_products (
	id BIGINT AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    quantity INT,
    expiration_date DATE NULL,
    price DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO tb_products (product_name, quantity, expiration_date, price)
VALUES
	("Tomato", 100, "2025-12-15", 8.00),
	("Apple", 20, "2025-12-15", 5.00),
	("Orange", 50, "2025-12-15", 10.00),
	("Banana", 200, "2025-12-15", 12.00),
	("Grape", 250, "2025-12-15", 8.69),
	("Pear", 500, "2025-12-15", 2.99);
    
SELECT * FROM tb_products;

CREATE TABLE tb_categories (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
	prod_description VARCHAR(255) NOT NULL
);

INSERT INTO tb_categories (prod_description)
VALUES
	("Fruits"),
	("Vegetables"),
	("Spices"),
	("Eggs"),
	("Other");

SELECT * FROM tb_categories;

-- Modifying the Table Structure - Creating the Relationship
ALTER TABLE tb_products ADD category_id BIGINT;

-- Add a Constraint, indicating that the 'category_id' will be the Foreign Key in the table 'tb_categories'
ALTER TABLE tb_products ADD CONSTRAINT fk_prod_categories
FOREIGN KEY (category_id) REFERENCES tb_categories (id);

SELECT * FROM tb_products;

-- Filling Up the attribute 'category_id' for all registers in the table
UPDATE tb_products SET category_id = 1 WHERE id = 1;
UPDATE tb_products SET category_id = 1 WHERE id = 2;
UPDATE tb_products SET category_id = 1 WHERE id = 3;
UPDATE tb_products SET category_id = 1 WHERE id = 4;
UPDATE tb_products SET category_id = 1 WHERE id = 5;
UPDATE tb_products SET category_id = 1 WHERE id = 6;

-- Inserting more items into the table 'tb_products'
INSERT INTO tb_products (product_name, quantity, expiration_date, price, category_id)
VALUES 
	("Sweet potato", 2000, "2025-03-09", 10.00, 2),
	("Lettuce", 300, "2025-03-10", 7.00, 2),
	("Onion", 1020, "2025-03-08", 5.00, 2),
	("White egg", 1000, "2025-03-07", 15.00, 4),
	("Watercress", 1500, "2025-03-06", 3.00, 2),
	("Carrot", 1800, "2025-03-09", 3.50, 2),
	("Pepper", 1100, "2025-03-15", 10.00, 3),
	("Rosemary", 130, "2025-03-10", 5.00, 3),
	("Mango", 200, "2025-03-07", 5.49, 1),
	("Kale", 100, "2025-03-12", 1.50, 2),
	("Radish", 1200, "2025-03-15", 13.00, 2),
	("Grapefruit", 3000, "2025-03-13", 50.00, 1),
	("Gray bag", 1118, NULL, 0.50, NULL),
	("Green bag", 1118, NULL, 0.50, NULL);
    
SELECT * FROM tb_products;

/* Queries */

-- Selecting data and sorting (ORDER BY)
-- ASC - Ascending Order
-- DESC - Descending Order
SELECT * FROM tb_products ORDER BY product_name ASC;

SELECT * FROM tb_products ORDER BY product_name DESC;

-- Sorting by two or more fields in a table
SELECT * FROM tb_products ORDER BY product_name, price ASC; -- Within each group of products with the same name, the table will be sorted by price in ascending order.

-- Selecting data within a criteria list (IN)
-- Return all products whose price is equal to R$ 5.00, R$ 10.00 or R$ 15.00.
SELECT * FROM tb_products WHERE price IN (5.00, 10.00, 15.00);

-- Selecting data within a range (BETWEEN)
SELECT * FROM tb_products WHERE price BETWEEN 5.00 AND 15.00;

-- Selecting data that contains specific text (LIKE)
/*

+-------------+-----------------------------------------------------------------------------------------------------------------+
|   Pattern   |                                                   Description                                                   |                                                   |
+-------------+-----------------------------------------------------------------------------------------------------------------+
|    %text    | The content you are searching for must end with the text you entered (text).                                    |
+-------------+-----------------------------------------------------------------------------------------------------------------+
|    text%    | The content you are searching for must begin with the text you entered (text).                                  |
+-------------+-----------------------------------------------------------------------------------------------------------------+
|    %text%   | The content searched must contain the typed text (text) in any position (beginning, middle or end of the text). |
+-------------+-----------------------------------------------------------------------------------------------------------------+

*/
SELECT * FROM tb_products WHERE product_name LIKE "%ra%";

-- (Collation) Discovering how characters are encoded and how the Database interprets them
-- Case Sensitive (CS) is the name given to the Database that differentiates between uppercase and lowercase letters.
-- Case Insensitive (CI) is the name given to the Database that does not differentiate between uppercase and lowercase letters.
-- Accent Sensitive (AS) is the name given to the Database that differentiates accented characters.
-- Accent Insensitive (AI) is the name given to the Database that does not differentiate accented characters.
SELECT @@collation_database; -- ai: accent insensitive / ci: case insensitive

-- Selecting Data with Mathematical Functions
/* 

Most Used Functions

+----------------------+---------------------------------------------------------------------------------------------------------+
|       Operator       |                                               Description                                               |                                                   |
+----------------------+---------------------------------------------------------------------------------------------------------+
|   COUNT(attribute)   | Counts how many non-null rows an attribute has. COUNT(*) indicates the number of rows in the table.     |
+----------------------+---------------------------------------------------------------------------------------------------------+
|   AVG(attribute)     | Calculates the average of the values ​​of an attribute.                                                   |
+----------------------+---------------------------------------------------------------------------------------------------------+
|   SUM(attribute)     | Calculates the sum of the values ​​of an attribute.                                                       |
+----------------------+---------------------------------------------------------------------------------------------------------+
|   MAX(attribute)     | Finds the largest value in the rows of an attribute.                                                    |
+----------------------+---------------------------------------------------------------------------------------------------------+
|   MIN(attribute)     | Finds the smallest value in the rows of an attribute.                                                   |
+----------------------+---------------------------------------------------------------------------------------------------------+

*/
SELECT AVG(price) AS Average FROM tb_products;

/* Relationship Between Tables */
-- 1... 1 (One to One)
-- 1... n (One to Many)
-- n... n (Many to Many)

/* JOIN

- JOIN queries can be used for a variety of purposes, such as converting data found in two or more tables into information. 
The JOIN clause is used to combine data from two or more database tables, based on a relationship between the columns of the 
two tables.

*/

-- INNER JOIN
-- In INNER JOIN queries, the result will only bring rows that are common in both tables, associated through the Primary and 
-- Foreign Keys, that is, if the Foreign Key has a NULL value, this record will not be displayed.
-- Obs.: INNER JOIN prioritizes the right table.
SELECT tb_products.id, product_name, price, quantity, tb_categories.prod_description 
FROM tb_products INNER JOIN tb_categories 
ON tb_products.category_id = tb_categories.id ORDER BY tb_products.id;

-- LEFT JOIN
-- In LEFT JOIN queries, the result will not only show the rows that are common in both tables, associated through the Primary 
-- and Foreign Keys, but also the non-associated data from the table on the left side of the relationship. In other words, 
-- regardless of whether the Foreign Key has a NULL value or not, all records from the table on the left side of the relationship
-- will be displayed.
-- Obs.: LEFT JOIN prioritizes the left table.
SELECT tb_products.id, product_name, price, quantity, tb_categories.prod_description
FROM tb_products LEFT JOIN tb_categories
ON tb_products.category_id = tb_categories.id;

-- RIGHT JOIN
-- In RIGHT JOIN queries, the result will not only bring the rows that are common in the 2 tables, associated through the Primary 
-- and Foreign Keys, but also the non-associated data from the table on the right side of the relationship, that is, regardless of
-- whether the Foreign Key has a NULL value or not, all records from the table on the right side of the relationship will be displayed.
-- Obs.: RIGHT JOIN prioritizes the right table.
SELECT tb_products.id, product_name, price, quantity, tb_categories.prod_description
FROM tb_products RIGHT JOIN tb_categories
ON tb_products.category_id = tb_categories.id;

/* Important Observations

Which table is on the Right and which table is on the Left?

- Left 🡢 Table that has the Foreign Key;
- Right 🡢 Table that does not have the Foreign Key.

The Table that does not have the Foreign Key (tb_categories), is the Table that controls the relationship, because if a category is deleted, the existence of the products in this category no longer makes sense. Example: If the Grocery Store decided to no longer sell fruits, it does not make sense to delete the fruits category and keep all the products in the fruits category in the Database.

*/

-- Selecting Data and Grouping (GROUP BY)
-- Example: finding the average price of products, grouped by category, that is, the average price per category.
SELECT tb_categories.prod_description, AVG(price) AS Average_Price
FROM tb_products INNER JOIN tb_categories
ON tb_categories.id = tb_products.category_id
GROUP BY tb_categories.prod_description;