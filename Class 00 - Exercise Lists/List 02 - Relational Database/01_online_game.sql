CREATE DATABASE db_online_game;

USE db_online_game;

CREATE TABLE tb_class (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    character_type VARCHAR(100) NOT NULL,
    description TEXT
);

INSERT INTO tb_class (character_type, description)
VALUES
    ("Warrior", "Specializes in melee combat, with high strength and defense."),
    ("Mage", "Uses powerful spells, focusing on intelligence and magical abilities."),
    ("Archer", "Excels in ranged attacks with high dexterity."),
    ("Elf", "Agile and intuitive, adept in archery and nature-based magic, with sharp senses and graceful precision."),
    ("Hobbit", "Small and hearty, hobbits are known for their love of peace, comfort, and good food. They excel in stealth and adaptability, making them surprisingly resourceful in difficult situations."),
    ("Orc", "Brutal and fierce, orcs are known for their immense strength and aggressive nature, thriving in close combat and destruction."),
    ("Other", NULL);

SELECT * FROM tb_class;

CREATE TABLE tb_characters (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    character_name VARCHAR(100) NOT NULL,
    strength INT,
    speed INT,
    attack INT,
    defense INT,
    intelligence INT,
    dexterity INT,
    character_type BIGINT,
    FOREIGN KEY (character_type) REFERENCES tb_class(id)
);

INSERT INTO tb_characters (character_name, strength, speed, attack, defense, intelligence, dexterity, character_type)
VALUES
    ("Aragorn", 2500, 2200, 2700, 2100, 1900, 2200, 1),  -- Warrior
    ("Gandalf", 1500, 2100, 3000, 1800, 2800, 2000, 2),  -- Mage
    ("Legolas", 1800, 2400, 2700, 1800, 2200, 2900, 3),  -- Archer
    ("Frodo Baggins", 1200, 2000, 1500, 1500, 2400, 2100, 5),  -- Hobbit
    ("Samwise Gamgee", 1800, 2100, 1700, 2200, 2400, 2100, 5),  -- Hobbit
    ("Gimli", 2700, 1500, 2600, 2700, 1800, 1500, 1),  -- Warrior
    ("Arwen", 1900, 2300, 2100, 2300, 2600, 2400, 4),  -- Elf
    ("Boromir", 2700, 1900, 2300, 2600, 1900, 2100, 1);  -- Warrior

SELECT * FROM tb_characters;

SELECT * FROM tb_characters WHERE attack > 2000;

SELECT * FROM tb_characters WHERE defense BETWEEN 1000 AND 2000;

SELECT * FROM tb_characters WHERE character_name Like "%c%";

SELECT tb_characters.id, character_name, strength, speed, attack, defense, intelligence, dexterity, tb_class.character_type AS character_type, tb_class.description AS description
FROM tb_characters 
INNER JOIN tb_class
ON tb_characters.character_type = tb_class.id ORDER BY tb_characters.id;

SELECT tb_characters.id, character_name, strength, speed, attack, defense, intelligence, dexterity, tb_class.character_type AS character_type, tb_class.description AS description
FROM tb_characters 
INNER JOIN tb_class
ON tb_characters.character_type = tb_class.id
WHERE tb_class.character_type = "Archer";