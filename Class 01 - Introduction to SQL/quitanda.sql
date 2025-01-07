CREATE DATABASE db_quitanda;

USE db_quitanda;

CREATE TABLE tb_produtos(
	id BIGINT AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    quantidade INT,
    data_validade DATE,
    preco DECIMAL NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE tb_produtos MODIFY preco DECIMAL(6,2);

ALTER TABLE tb_produtos ADD descricao varchar(255);

DESC tb_produtos;

ALTER TABLE tb_produtos CHANGE descricao descricao_produto varchar(500);

ALTER TABLE tb_produtos DROP descricao_produto;

INSERT INTO tb_produtos (nome, quantidade, data_validade, preco)
VALUES ("tomate", 100, "2024-12-15", 8.00);

INSERT INTO tb_produtos (nome, quantidade, data_validade, preco)
VALUES ("maçã", 20, "2024-12-15", 5.00);

INSERT INTO tb_produtos (nome, quantidade, data_validade, preco)
VALUES ("laranja", 50, "2024-12-15", 10.00);

INSERT INTO tb_produtos (nome, quantidade, data_validade, preco)
VALUES ("banana", 200, "2024-12-15", 12.00);

INSERT INTO tb_produtos (nome, quantidade, data_validade, preco)
VALUES ("uva", 1200, "2024-12-15", 30.00);

INSERT INTO tb_produtos (nome, quantidade, data_validade, preco)
VALUES ("pêra", 500, "2024-12-15", 2.99);

SELECT * FROM tb_produtos;

SELECT nome, preco FROM tb_produtos;

SELECT * FROM tb_produtos WHERE id = 1;

SELECT * FROM tb_produtos WHERE preco > 4.00;

SELECT * FROM tb_produtos WHERE preco > 4.00 AND nome = "pêra";

SELECT * FROM tb_produtos WHERE preco > 5.00 OR nome = "tomate";

SELECT * FROM tb_produtos WHERE nome != "tomate";

SELECT nome, CONCAT('R$ ', FORMAT(preco, 2, 'pt_BR')) AS Preço FROM tb_produtos;

SELECT nome, DATE_FORMAT(data_validade, '%d/%m/%Y') AS Data_Validade FROM tb_produtos;

UPDATE tb_produtos SET preco = 2.99 WHERE id = 6;

UPDATE tb_produtos SET preco = 2.99;

SET SQL_SAFE_UPDATES = 1;

DELETE FROM tb_produtos WHERE id = 6;

DROP DATABASE db_quitanda;

DROP TABLE tb_produtos;


