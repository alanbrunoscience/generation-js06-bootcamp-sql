CREATE DATABASE db_pizzeria;

USE db_pizzeria;

CREATE TABLE tb_categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pizza_category VARCHAR(100) NOT NULL,
    description TEXT
);

INSERT INTO tb_categories (pizza_category, description)
VALUES
    ("Classic", "Traditional and timeless, these pizzas feature classic toppings like mozzarella cheese, tomatoes, and basil, providing a simple yet delicious taste."),
    ("Special", "Unique and flavorful, these pizzas feature a mix of premium ingredients like different cheeses, spicy meats, and flavorful combinations that stand out from the ordinary."),
    ("Vegan and Vegetarian", "Perfect for plant-based diets, these pizzas are topped with a variety of fresh vegetables, plant-based cheeses, and creative combinations without any animal products."),
    ("Sweet", "Indulge in a sweet treat with desserts made on a pizza crust, featuring chocolate, fruits, and creamy fillings for a perfect end to a meal."),
    ("Gourmet", "A refined pizza experience, featuring high-end ingredients such as truffles, smoked salmon, or prosciutto, for a more sophisticated and unique taste."),
    ("With Meat", "Meat lovers will enjoy these pizzas, topped with a variety of meats like chicken, bacon, beef, or ribs for a savory and satisfying meal."),
    ("Exotic", "These pizzas are for the adventurous eater, featuring unusual ingredients like seafood, wild game, or bold fruit pairings that offer a distinct and exciting flavor."),
    ("Other", NULL);


SELECT * FROM tb_categories;

CREATE TABLE tb_pizzas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pizza_name VARCHAR(100) NOT NULL,
    size_inch DECIMAL(5, 2),
    quantity INT,
    price DECIMAL(5, 2),
    is_available BOOLEAN DEFAULT TRUE,
    pizza_category BIGINT,
    FOREIGN KEY (pizza_category) REFERENCES tb_categories(id)
);

INSERT INTO tb_pizzas (pizza_name, size_inch, quantity, price, is_available, pizza_category)
VALUES
    ("Margherita", 12.00, 50, 48.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Classic')),
    ("Calabresa", 14.00, 30, 35.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Classic')),
    ("Four Cheeses", 12.00, 20, 40.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Special')),
    ("Chicken with Catupiry", 16.00, 15, 55.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Special')),
    ("Vegan Veggie", 14.00, 10, 38.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Vegan and Vegetarian')),
    ("Banana with Cinnamon", 12.00, 25, 35.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Sweet')),
    ("Truffle", 14.00, 10, 45.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Gourmet')),
    ("Seafood (Shrimp and Shellfish)", 16.00, 8, 80.00, TRUE, (SELECT id FROM tb_categories WHERE pizza_category = 'Exotic'));

SELECT * FROM tb_pizzas;

SELECT * FROM tb_pizzas WHERE price > 45.00;

SELECT * FROM tb_pizzas WHERE price BETWEEN 50.00 AND 100.00;

SELECT * FROM tb_pizzas WHERE pizza_name Like "%m%";

SELECT tb_pizzas.id, pizza_name, size_inch, quantity, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, is_available, tb_categories.pizza_category AS pizza_category, tb_categories.description AS description
FROM tb_pizzas 
INNER JOIN tb_categories
ON tb_pizzas.pizza_category = tb_categories.id ORDER BY tb_pizzas.id;

SELECT tb_pizzas.id, pizza_name, size_inch, quantity, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, is_available, tb_categories.pizza_category AS pizza_category, tb_categories.description AS description
FROM tb_pizzas
INNER JOIN tb_categories
ON tb_pizzas.pizza_category = tb_categories.id
WHERE tb_categories.pizza_category = "Sweet";


