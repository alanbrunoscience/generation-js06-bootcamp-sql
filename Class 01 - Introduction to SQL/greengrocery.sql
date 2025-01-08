/* Observations

- DML (Data Manipulation Language): DML instructions indicate an action for the DBMS to execute. 
Used to retrieve, insert and modify a record in the database. Its main commands are: INSERT, DELETE, 
UPDATE and SELECT;

- DDL (Data Definition Language): DDL statements are responsible for creating, altering and deleting objects in 
the database, that is, the structure of the Database and its Tables. Its main commands are: CREATE DATABASE, 
CREATE TABLE, ALTER TABLE and DROP TABLE;

*/

-- 1) Create Database
CREATE DATABASE db_greengrocery;

-- 2) Selecting the Database
USE db_greengrocery;

-- 3) Create Table
CREATE TABLE tb_products(
	id BIGINT AUTO_INCREMENT, -- 'AUTO_INCREMENT' is a type of DDL command
    name_product VARCHAR(255) NOT NULL, -- 'NOT NULL' is a type of DDL command
    quantity INT,
    expiration_date DATE,
    price DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (id) -- 'PRIMARY KEY' is a type of DDL command
);

-- 4) Inserting Data Into the Table
INSERT INTO tb_products(name_product, quantity, expiration_date, price)
VALUES ("Tomato", 100, "2025-12-15", 8.00),
("Apple", 20, "2025-12-15", 5.00),
("Orange", 50, "2025-12-15", 10.00),
("Banana", 200, "2025-12-15", 12.00),
("Grape", 250, "2025-12-15", 8.69),
("Pear", 500, "2025-12-15", 2.99);

-- 5) Selecting Data From the Table
SELECT * FROM tb_products;

-- 6) Selecting Only An Attribute From the Table
SELECT name_product FROM tb_products;

-- 7) Selecting Two or More Attributes From the Table
SELECT name_product, price FROM tb_products;

-- 8) Selecting Data From Table With Filter Criteria
SELECT * FROM tb_products WHERE id = 1;

-- 9) Selecting Data With Relational Operators
SELECT * FROM tb_products WHERE price > 5.00;

-- 10) Selecting Data With Logical Operators
SELECT * FROM tb_products WHERE price > 5.00 AND quantity < 100;

-- 11) Modifying The Table Structure - Modifying The Structure Of A Column (ALTER TABLE... MODIFY)
ALTER TABLE tb_products MODIFY price DECIMAL(7,2); # 7 decimal numbers with the last 2 decimals (00000.00)

SELECT * FROM tb_products;

-- 12) Modifying The Table Structure - Adding a New Column (ALTER TABLE... ADD)
ALTER TABLE tb_products ADD prod_description VARCHAR(255);

SELECT * FROM tb_products;

-- 13) Updating Data On The Table (UPDATE)

/* Observations

- Pay Attention to details when constructing an UPDATE query. You MUST include the WHERE statement, 
otherwise MySQL Workbench will prevent you from updating ALL RECORDS, without the possibility of 
undoing an update incorrectly.

- To prevent an UPDATE statement from being mistakenly executed without a WHERE statement, 
MySQL has a "safety lock" that can be turned on or off using the SET SQL_SAFE_UPDATES statement.

- SQL_SAFE_UPDATES is a unique MySQL protection and security feature, enabled by default, that 
prevents the execution of the famous UPDATE without WHERE, which modifies all records in the table.

-> SET SQL_SAFE_UPDATES = 0; (Disable Safe Mode)
-> SET SQL_SAFE_UPDATES = 1; (Enable Safe Mode)

*/

UPDATE tb_products SET price = 3.49 WHERE id = 6;

SELECT * FROM tb_products WHERE id = 6;

-- 14) Updating the Products Description
UPDATE tb_products SET prod_description = "Italian Tomato" WHERE id = 1;
UPDATE tb_products SET prod_description = "Green Apple" WHERE id = 2;
UPDATE tb_products SET prod_description = "Sweet Lime Orange" WHERE id = 3;
UPDATE tb_products SET prod_description = "Silver Banana" WHERE id = 4;
UPDATE tb_products SET prod_description = "Italian Grape" WHERE id = 5;
UPDATE tb_products SET prod_description = "Williams Pear" WHERE id = 6;

/* Or...

UPDATE tb_products
SET prod_description = CASE
    WHEN id = 1 THEN "Italian Tomato"
    WHEN id = 2 THEN "Green Apple"
    WHEN id = 3 THEN "Sweet Lime Orange"
    WHEN id = 4 THEN "Silver Banana"
    WHEN id = 5 THEN "Italian Grape"
    WHEN id = 6 THEN "Williams Pear"
END
WHERE id IN (1, 2, 3, 4, 5, 6);

*/

SELECT * FROM tb_products;

-- 15) Modifying The Table Structure - Excluding A Column (ALTER TABLE... DROP)
ALTER TABLE tb_products DROP prod_description;

SELECT * FROM tb_products;

-- 16) Deleting Data in the Table (DELETE FROM... WHERE)

/* Observations

- Pay attention to details when constructing the delete query, as you MUST include the WHERE command, 
otherwise MySQL Server will DELETE ALL RECORDS, without the possibility of undoing the operation.

- Just like the UPDATE statement, to prevent a DELETE statement from being executed by mistake without 
the WHERE statement, MySQL uses the "safety lock", which can be activated or deactivated through the 
SET SQL_SAFE_UPDATES statement, as we saw previously.

-> SET SQL_SAFE_UPDATES = 0; (Disable Safe Mode)
-> SET SQL_SAFE_UPDATES = 1; (Enable Safe Mode)

*/

DELETE FROM tb_products WHERE id = 2;

SELECT * FROM tb_products WHERE id = 2;

SELECT * FROM tb_products;

-- 17) Deleting The Whole Table (DELETE FROM <table-name>)
DELETE FROM tb_products; -- To do it, it's necessary to disable the safe update mode (SET SQL_SAFE_UPDATES = 0)

/* ATTENTION

- This command is just an example. Remember that if you execute it, the change cannot be undone and all products 
will be deleted. The only way to recover would be to register everything again, however the IDs would be different.

*/

-- 18) Modifying The Table Structure - Changing The Column Name (ALTER TABLE... CHANGE)

/* IMPORTANT

- The CHANGE clause allows you to change only the attribute name. If you enter a data type 
that is different from the current data type, the statement will not be executed.

*/

ALTER TABLE tb_products CHANGE name_product name VARCHAR(255);

SELECT * FROM tb_products;

-- 19) Modifying The Table Structure - Set the PRIMARY KEY (ALTER TABLE... ADD PRIMARY KEY)
ALTER TABLE tb_products ADD PRIMARY KEY (id);

-- 20) Selecting Data and Formatting 'price' As Brazilian Currency
-- CONCAT: https://www.w3schools.com/sql/func_mysql_concat.asp
-- FORMAT: https://www.w3schools.com/sql/func_mysql_format.asp
SELECT name AS Product_Name, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS Price FROM tb_products;

-- 21) Selecting Data and Formatting 'expiration_date' to Brazilian Format
-- DATE_FORMAT: https://www.w3schools.com/sql/func_mysql_date_format.asp
SELECT name AS Product_Name, DATE_FORMAT(expiration_date, '%d/%m/%Y') AS Expiration_Date FROM tb_products;

-- 22) Delete a Table (DROP TABLE <table-name>)
DROP TABLE tb_products;

-- 23) Delete the Database (DROP DATABASE <database-name>)
DROP DATABASE db_greengrocery;

/* Bonus */

--- View Table Structure
DESC tb_products;

--- Discover Database Collation
SELECT @@collation_database;