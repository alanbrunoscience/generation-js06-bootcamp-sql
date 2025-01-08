CREATE DATABASE db_students;

USE db_students;

CREATE TABLE tb_students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL,
    grade DECIMAL(5, 2) NOT NULL,
    enrollment_date DATE NOT NULL
);

INSERT INTO tb_students (full_name, birthdate, grade, enrollment_date)
VALUES
('John Silva', '2005-04-12', 8.75, '2023-01-15'),
('Maria Oliveira', '2004-08-22', 9.50, '2022-05-20'),
('Peter Souza', '2006-02-05', 7.90, '2023-03-10'),
('Anna Costa', '2005-11-18', 6.30, '2022-09-25'),
('Luke Almeida', '2007-01-30', 9.10, '2023-02-05'),
('Beatrice Santos', '2004-12-13', 8.00, '2022-11-18'),
('Charles Pereira', '2005-07-25', 10.00, '2021-08-30'),
('Larissa Lima', '2006-09-10', 7.50, '2023-04-18');

SELECT full_name, grade FROM tb_students WHERE grade > 7;

SELECT full_name, grade FROM tb_students WHERE grade <= 7;

UPDATE tb_students SET grade = 8.76 WHERE id = 3;

SELECT * FROM tb_students;

/*

SET SQL_SAFE_UPDATES = 0;

DROP TABLE tb_students;

DROP DATABASE db_students;

*/