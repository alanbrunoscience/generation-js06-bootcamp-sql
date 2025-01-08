CREATE DATABASE db_products;

USE db_products;

CREATE TABLE tb_products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prod_name VARCHAR(255) NOT NULL,
    prod_description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

INSERT INTO tb_products(prod_name, prod_description, price, stock_quantity)
VALUES("Basic T-shirt", "High-quality cotton men's basic T-shirt. Comfortable and available in various colors.", 39.90, 120),
("Nike Air Max Sports Shoes", "Nike Air Max shoes with cushioning technology and modern design. Perfect for physical activities.", 499.99, 35),
("Samsung Galaxy S22 Smartphone", "Samsung Galaxy S22 smartphone with a 6.1-inch AMOLED display, 50 MP camera, and 128 GB storage.", 2999.00, 50),
("Dell Inspiron 15 Laptop", "Dell Inspiron 15 laptop with Intel Core i5 processor, 8 GB RAM, and 512 GB SSD.", 2799.90, 20),
("Apple Watch Series 7", "Apple Watch Series 7 with a larger display, fast charging, and advanced health tracking features.", 399.00, 45),
("Canon EOS Rebel T7 DSLR Camera", "Canon EOS Rebel T7 DSLR camera with 24.1 MP, Full HD video recording, and built-in Wi-Fi.", 549.99, 25),
("Bose SoundLink Revolve+ Bluetooth Speaker", "Bose SoundLink Revolve+ Bluetooth speaker with 360-degree sound, water-resistant design, and up to 16 hours of playtime.", 349.99, 60),
("JBL Live 500BT Headphones", "JBL Live 500BT Bluetooth headphones with active noise cancellation and high-quality sound.", 249.99, 75);

SELECT prod_name AS Product_Name, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS Price FROM tb_products WHERE Price > 500;

SELECT prod_name AS Product_Name, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS Price FROM tb_products WHERE Price <= 500;

UPDATE tb_products SET price = 256.46, stock_quantity = 90 WHERE id = 8;

SELECT * FROM tb_products;

/*

SET SQL_SAFE_UPDATES = 0;

DROP TABLE tb_products;

DROP DATABASE db_products;

*/