CREATE DATABASE db_courses;

USE db_courses;

--- Create The Tables
CREATE TABLE tb_categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tb_courses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    workload INT NOT NULL,
    price DECIMAL(6, 2) NOT NULL,
    description VARCHAR(500) NOT NULL,
    requirements VARCHAR(255) NOT NULL,
    category_id BIGINT,
    FOREIGN KEY (category_id) REFERENCES tb_categories(id) ON DELETE SET NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert Values Into the Tables
INSERT INTO tb_categories(category_name, description)
VALUES
    ('Information Technology (IT)', 'Courses focused on tech fields like programming, cybersecurity, and data analysis. Ideal for tech careers such as software development and system administration.'),
    ('Management and Business', 'Courses on business administration, marketing, finance, and human resources. Designed to prepare professionals for leadership and strategic roles in companies.'),
    ('Health', 'Courses related to healthcare professions, including nursing, psychology, physical therapy, and pharmacy. For careers in medical and health services.'),
    ('Education', 'Courses focused on teaching, educational management, and specialized areas like psychopedagogy. For careers in education and academic administration.'),
    ('Arts and Design', 'Courses that develop creativity and artistic skills, such as graphic design, fashion, photography, and music. Ideal for creative professions.'),
    ('Law', 'Courses on various branches of law, including civil, criminal, and labor law. For careers in the legal field, such as lawyer or judge.'),
    ('Humanities and Social Sciences', 'Courses in philosophy, sociology, history, and anthropology. Ideal for those interested in studying human behavior and society.'),
    ('Communication and Marketing', 'Courses focused on media, advertising, digital marketing, and public relations. For careers in communication, marketing, and media.'),
    ('Engineering and Architecture', 'Courses in fields like civil, electrical, and mechanical engineering, as well as architecture. For careers in construction, infrastructure, and design.'),
    ('Natural Sciences and Environment', 'Courses in biology, chemistry, ecology, and environmental science. For careers in scientific research and environmental protection.'),
    ('Languages and Linguistics', 'Courses in language learning, translation, interpretation, and linguistics. For careers in language-related fields and international communication.'),
    ('Tourism and Hospitality', 'Courses focused on tourism management, hotel administration, and event planning. For careers in travel, tourism, and hospitality services.'),
    ('Other', NULL);

SELECT * FROM tb_categories;

INSERT INTO tb_courses(course_name, workload, price, description, requirements, category_id)
VALUES
    ('Introduction to Programming with Python', 40, 150.00, 'Learn the fundamentals of programming with Python, including variables, loops, and functions.', 'Basic computer literacy required.', (SELECT id FROM tb_categories WHERE category_name = 'Information Technology (IT)')),
    ('Business Strategy and Leadership', 60, 950.00, 'Explore the principles of business strategy and develop leadership skills to drive success in any organization.', 'Basic knowledge of business concepts recommended.', (SELECT id FROM tb_categories WHERE category_name = 'Management and Business')),
    ('Mental Health and Wellness', 50, 450.00, 'A comprehensive course on mental health management, focusing on practical tools and techniques for improving well-being.', 'Interest in psychology or healthcare encouraged.', (SELECT id FROM tb_categories WHERE category_name = 'Health')),
    ('Introduction to Educational Technology', 45, 650.00, 'Learn how to integrate technology in the classroom, from digital tools to educational software.', 'Basic understanding of educational systems recommended.', (SELECT id FROM tb_categories WHERE category_name = 'Education')),
    ('Graphic Design Fundamentals', 30, 300.00, 'An introductory course on graphic design, covering essential tools and techniques for creating visually compelling designs.', 'No prior design experience required.', (SELECT id FROM tb_categories WHERE category_name = 'Arts and Design')),
    ('Corporate Law and Legal Frameworks', 60, 1200.00, 'An in-depth look at corporate law, covering company formation, governance, and regulatory compliance.', 'Some background in law or business helpful.', (SELECT id FROM tb_categories WHERE category_name = 'Law')),
    ('Sociology and Social Change', 50, 750.00, 'Study the social forces that drive change in societies and understand the impact of culture, economics, and politics on social structures.', 'Basic understanding of social sciences recommended', (SELECT id FROM tb_categories WHERE category_name = 'Humanities and Social Sciences')),
    ('Sustainable Tourism and Hospitality Management', 60, 1800.00, 'Explore sustainable tourism practices and how to manage hospitality businesses with an eco-friendly approach.', 'Interest in travel and hospitality encouraged.', (SELECT id FROM tb_categories WHERE category_name = 'Tourism and Hospitality'));

SELECT * FROM tb_courses;

-- Queries
SELECT * FROM tb_courses WHERE price >= 500.00;

SELECT * FROM tb_courses WHERE price BETWEEN 600.00 AND 1000.00;

SELECT * FROM tb_courses WHERE course_name LIKE "%s%";

SELECT * FROM tb_courses
INNER JOIN tb_categories
ON tb_courses.category_id = tb_categories.id;

SELECT * FROM tb_courses
INNER JOIN tb_categories
ON tb_courses.category_id = tb_categories.id
WHERE tb_categories.category_name = 'Information Technology (IT)';