CREATE DATABASE db_hr_system;

USE db_hr_system;

CREATE TABLE tb_collaborators (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    cpf CHAR(14) NOT NULL,
    employee_role VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    base_salary DECIMAL(9, 2) NOT NULL
);

INSERT INTO tb_collaborators(full_name, cpf, employee_role, hire_date, base_salary)
VALUES("Albert Heiz", "776.917.820-71", "Software Engineer", "2025-03-01", 12800),
("Bianca Jhones", "304.782.160-76", "Full-Stack Developer", "2025-03-01", 9800),
("Carlos Sainz", "796.961.910-06", "Tech Lead", "2025-03-01", 10000),
("Daniel San", "992.338.660-09", "UX Designer", "2025-03-01", 6500),
("Elen Rose", "554.235.540-47", "Product Owner", "2025-03-01", 5000),
("Fernando Claus", "061.422.260-55", "Jr. Developer", "2025-03-01", 2000);

SELECT full_name AS Collaborator_Name, CONCAT('R$ ', FORMAT(base_salary, 2, 'pt_BR')) AS Salary FROM tb_collaborators WHERE base_salary > 2000;

SELECT full_name AS Collaborator_Name, CONCAT('R$ ', FORMAT(base_salary, 2, 'pt_BR')) AS Salary FROM tb_collaborators WHERE base_salary <= 2000;

UPDATE tb_collaborators SET employee_role = "Mid-level Developer", base_salary = 6000 WHERE id = 6;

SELECT * FROM tb_collaborators;

/*

SET SQL_SAFE_UPDATES = 0;

DROP TABLE tb_collaborators;

DROP DATABASE db_hr_system;

*/