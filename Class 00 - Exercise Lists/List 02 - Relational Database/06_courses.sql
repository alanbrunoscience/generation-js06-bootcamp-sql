CREATE DATABASE db_courses;

USE db_courses;

-- Creating Tables
CREATE TABLE tb_users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('student', 'tutor', 'admin') DEFAULT 'student' NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tb_categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_tutors (
    tutor_id BIGINT PRIMARY KEY,
    bio TEXT NOT NULL,
    experience VARCHAR(255) NOT NULL,
    category_id BIGINT NOT NULL,
    num_courses INT NOT NULL,
    rating DECIMAL(3,2),
    total_reviews INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tutor_id) REFERENCES tb_users(id),
    FOREIGN KEY (category_id) REFERENCES tb_categories(id)
);

CREATE TABLE tb_tutor_reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tutor_id BIGINT NOT NULL,
    reviewer_id BIGINT NOT NULL,
    rating DECIMAL(3,2) NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tutor_id) REFERENCES tb_tutors(tutor_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES tb_users(id) ON DELETE CASCADE,
    UNIQUE (tutor_id, reviewer_id),
    INDEX idx_tutor_id (tutor_id),
    INDEX idx_reviewer_id (reviewer_id)
);

CREATE TABLE tb_courses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    workload INT NOT NULL,
	price DECIMAL(10, 2) NOT NULL,
    description TEXT,
	tutor_id BIGINT NOT NULL,
    requirements TEXT,
    rating FLOAT DEFAULT 0,
    num_reviews INT DEFAULT 0,
    category_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (tutor_id) REFERENCES tb_tutors(tutor_id),
    FOREIGN KEY (category_id) REFERENCES tb_categories(id)
);

CREATE TABLE tb_enrollments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'completed', 'dropped') DEFAULT 'active',
    FOREIGN KEY (user_id) REFERENCES tb_users(id),
    FOREIGN KEY (course_id) REFERENCES tb_courses(id)
);

CREATE TABLE tb_course_reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    reviewer_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reviewer_id) REFERENCES tb_users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES tb_courses(id) ON DELETE CASCADE
);

-- Inserting Data
INSERT INTO tb_users(name, username, email, password, role, is_active)
VALUES
    ('Anna Smith', 'anna.smith', 'anna.smith@example.com', 'hashedpassword1', 'student', TRUE),
    ('Charles Johnson', 'charles.johnson', 'charles.johnson@example.com', 'hashedpassword2', 'student', TRUE),
    ('Beatrice Williams', 'beatrice.williams', 'beatrice.williams@example.com', 'hashedpassword3', 'student', TRUE),
    ('Philip Brown', 'philip.brown', 'philip.brown@example.com', 'hashedpassword4', 'student', TRUE),
    ('Marian Taylor', 'marian.taylor', 'marian.taylor@example.com', 'hashedpassword5', 'student', TRUE),
    ('Luke Anderson', 'luke.anderson', 'luke.anderson@example.com', 'hashedpassword6', 'student', TRUE),
    ('Rita Clark', 'rita.clark', 'rita.clark@example.com', 'hashedpassword7', 'student', TRUE),
    ('Edward Harris', 'edward.harris', 'edward.harris@example.com', 'hashedpassword8', 'student', TRUE),
    ('Julia Lewis', 'julia.lewis', 'julia.lewis@example.com', 'hashedpassword9', 'student', TRUE),
    ('Thomas Walker', 'thomas.walker', 'thomas.walker@example.com', 'hashedpassword10', 'student', TRUE),
    ('Patricia Young', 'patricia.young', 'patricia.young@example.com', 'hashedpassword11', 'student', TRUE),
    ('Gabriel King', 'gabriel.king', 'gabriel.king@example.com', 'hashedpassword12', 'student', TRUE),
    ('Camila Scott', 'camila.scott', 'camila.scott@example.com', 'hashedpassword13', 'student', TRUE),
    ('John Green', 'john.green', 'john.green@example.com', 'hashedpassword14', 'tutor', TRUE),
    ('Sarah Adams', 'sarah.adams', 'sarah.adams@example.com', 'hashedpassword15', 'tutor', TRUE),
    ('David Clark', 'david.clark', 'david.clark@example.com', 'hashedpassword16', 'tutor', TRUE),
    ('Olivia Harris', 'olivia.harris', 'olivia.harris@example.com', 'hashedpassword17', 'tutor', TRUE),
    ('Michael Roberts', 'michael.roberts', 'michael.roberts@example.com', 'hashedpassword18', 'tutor', TRUE),
    ('Sophia Lewis', 'sophia.lewis', 'sophia.lewis@example.com', 'hashedpassword19', 'tutor', TRUE),
    ('Daniel Walker', 'daniel.walker', 'daniel.walker@example.com', 'hashedpassword20', 'tutor', TRUE),
    ('Emma Hall', 'emma.hall', 'emma.hall@example.com', 'hashedpassword21', 'tutor', TRUE),
    ('James Moore', 'james.moore', 'james.moore@example.com', 'hashedpassword22', 'tutor', TRUE),
    ('Benjamin White', 'benjamin.white', 'benjamin.white@example.com', 'hashedpassword23', 'tutor', TRUE),
    ('Charlotte Allen', 'charlotte.allen', 'charlotte.allen@example.com', 'hashedpassword24', 'tutor', TRUE),
    ('William Scott', 'william.scott', 'william.scott@example.com', 'hashedpassword25', 'tutor', TRUE),
    ('Isabella Carter', 'isabella.carter', 'isabella.carter@example.com', 'hashedpassword26', 'tutor', TRUE);

SELECT * FROM tb_users;

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

INSERT INTO tb_tutors (tutor_id, bio, experience, category_id, num_courses, rating, total_reviews)
VALUES
    ((SELECT id FROM tb_users WHERE username = 'john.green' LIMIT 1), 'Specialized in Information Technology (IT) with over 10 years of experience in software development, system administration, and IT consulting. Passionate about teaching programming and tech-related topics.', '10 years in IT development', (SELECT id FROM tb_categories WHERE category_name = 'Information Technology (IT)' LIMIT 1), 5, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'john.green' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'john.green' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'sarah.adams' LIMIT 1), 'Expert in Management and Business, with a focus on strategic management, leadership, and entrepreneurship. Experienced in both corporate and startup environments.', '15 years in business management', (SELECT id FROM tb_categories WHERE category_name = 'Management and Business' LIMIT 1), 7, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sarah.adams' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sarah.adams' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'david.clark' LIMIT 1), 'Health professional specializing in healthcare management and patient care. Over 8 years of experience in the medical field, with a focus on mental health and wellness.', '8 years in healthcare management', (SELECT id FROM tb_categories WHERE category_name = 'Health' LIMIT 1), 4, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'david.clark' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'david.clark' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'olivia.harris' LIMIT 1), 'With a background in Education, I have worked in various teaching roles for over 12 years. My focus is on curriculum development, educational technology, and student engagement.', '12 years in education', (SELECT id FROM tb_categories WHERE category_name = 'Education' LIMIT 1), 6, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'olivia.harris' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'olivia.harris' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'michael.roberts' LIMIT 1), 'A professional with expertise in Arts and Design, having worked in graphic design, digital art, and user experience (UX) design. 10+ years of creative experience.', '10 years in the creative industry', (SELECT id FROM tb_categories WHERE category_name = 'Arts and Design' LIMIT 1), 8, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'michael.roberts' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'michael.roberts' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'sophia.lewis' LIMIT 1), 'Law specialist with a strong background in corporate law, intellectual property rights, and contract law. Over 10 years of practice and consulting experience.', '10 years in legal practice', (SELECT id FROM tb_categories WHERE category_name = 'Law' LIMIT 1), 5, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sophia.lewis' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sophia.lewis' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'daniel.walker' LIMIT 1), 'Experienced in Humanities and Social Sciences, focusing on sociology, psychology, and cultural studies. Over 8 years teaching at universities and workshops.', '8 years in social sciences', (SELECT id FROM tb_categories WHERE category_name = 'Humanities and Social Sciences' LIMIT 1), 5, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'daniel.walker' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'daniel.walker' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'emma.hall' LIMIT 1), 'Specialist in Communication and Marketing, with over 12 years of experience in brand management, public relations, and digital marketing strategies.', '12 years in marketing', (SELECT id FROM tb_categories WHERE category_name = 'Communication and Marketing' LIMIT 1), 9, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'emma.hall' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'emma.hall' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'james.moore' LIMIT 1), 'Engineer with expertise in Mechanical Engineering, offering a strong background in design, analysis, and manufacturing. 15 years of experience in the engineering field.', '15 years in engineering', (SELECT id FROM tb_categories WHERE category_name = 'Engineering and Architecture' LIMIT 1), 7, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'james.moore' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'james.moore' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'benjamin.white' LIMIT 1), 'Architect with a passion for sustainable design, architecture, and urban planning. Over 12 years working in both commercial and residential projects.', '12 years in architecture', (SELECT id FROM tb_categories WHERE category_name = 'Engineering and Architecture' LIMIT 1), 6, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'benjamin.white' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'benjamin.white' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'charlotte.allen' LIMIT 1), 'Environmental scientist with a focus on natural resources, climate change, and sustainability. Over 9 years of experience working on environmental projects.', '9 years in environmental science', (SELECT id FROM tb_categories WHERE category_name = 'Natural Sciences and Environment' LIMIT 1), 4, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'charlotte.allen' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'charlotte.allen' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'william.scott' LIMIT 1), 'Linguistics expert with a deep understanding of languages, phonetics, and language acquisition. Over 10 years of experience in teaching and research in linguistics.', '10 years in linguistics', (SELECT id FROM tb_categories WHERE category_name = 'Languages and Linguistics' LIMIT 1), 6, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'william.scott' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'william.scott' LIMIT 1))),
    ((SELECT id FROM tb_users WHERE username = 'isabella.carter' LIMIT 1), 'Tourism and Hospitality expert with a focus on hospitality management, sustainable tourism, and travel consulting. 11 years of experience in the tourism industry.', '11 years in tourism', (SELECT id FROM tb_categories WHERE category_name = 'Tourism and Hospitality' LIMIT 1), 7, (SELECT AVG(rating) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'isabella.carter' LIMIT 1)), (SELECT COUNT(*) FROM tb_tutor_reviews WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'isabella.carter' LIMIT 1)));

SELECT * FROM tb_tutors;

INSERT INTO tb_tutor_reviews (tutor_id, reviewer_id, rating, comment)
VALUES
    ((SELECT id FROM tb_users WHERE username = 'john.green' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'anna.smith' LIMIT 1), 4.5, 'The tutor was excellent! Very knowledgeable and explained concepts clearly. Just a bit more engagement would make it perfect.'),
    ((SELECT id FROM tb_users WHERE username = 'john.green' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'charles.johnson' LIMIT 1), 3.7, 'Good session overall, but some topics felt rushed. More examples could have helped.'),
    ((SELECT id FROM tb_users WHERE username = 'john.green' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'beatrice.williams' LIMIT 1), 5, 'Absolutely fantastic! Exceeded my expectations in every way. Highly recommend!'),
    ((SELECT id FROM tb_users WHERE username = 'olivia.harris' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'philip.brown' LIMIT 1), 5, 'Incredible teaching style! Very clear, interactive, and thorough.'),
    ((SELECT id FROM tb_users WHERE username = 'michael.roberts' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'marian.taylor' LIMIT 1), 4, 'Very good tutor. Some points could have been better structured, but I learned a lot.'),
    ((SELECT id FROM tb_users WHERE username = 'sophia.lewis' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'luke.anderson' LIMIT 1), 5, 'Rating scale exceeded! This tutor was beyond exceptional—simply amazing!'),
    ((SELECT id FROM tb_users WHERE username = 'daniel.walker' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'rita.clark' LIMIT 1), 2, 'Unfortunately, it didn’t meet my expectations. The tutor seemed unprepared for some parts.'),
    ((SELECT id FROM tb_users WHERE username = 'emma.hall' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'edward.harris' LIMIT 1), 4, 'Solid teaching, but there’s room for improvement in engaging students.'),
    ((SELECT id FROM tb_users WHERE username = 'james.moore' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'julia.lewis' LIMIT 1), 5, 'Perfect session! The tutor was engaging, knowledgeable, and patient.'),
    ((SELECT id FROM tb_users WHERE username = 'benjamin.white' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'thomas.walker' LIMIT 1), 1, 'Terrible experience. The tutor was unprepared and didn’t address the topics I needed.'),
    ((SELECT id FROM tb_users WHERE username = 'charlotte.allen' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'patricia.young' LIMIT 1), 2, 'The session was disappointing. The tutor lacked depth in the subject.'),
    ((SELECT id FROM tb_users WHERE username = 'william.scott' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'gabriel.king' LIMIT 1), 4, 'Good content, but the session could have been more dynamic.'),
    ((SELECT id FROM tb_users WHERE username = 'isabella.carter' LIMIT 1), (SELECT id FROM tb_users WHERE username = 'camila.scott' LIMIT 1), 5, 'Excellent! The tutor made everything easy to understand and was very supportive.');

SELECT * FROM tb_tutor_reviews;

INSERT INTO tb_courses (course_name, workload, price, description, tutor_id, requirements, rating, num_reviews, category_id)
VALUES
    ('Introduction to Programming with Python', 40, 150.00, 'Learn the fundamentals of programming with Python, including variables, loops, and functions.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'john.green')), 
        'Basic computer literacy required.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Programming with Python')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Programming with Python')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Information Technology (IT)')),

    ('Business Strategy and Leadership', 60, 950.00, 'Explore the principles of business strategy and develop leadership skills to drive success in any organization.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sarah.adams')), 
        'Basic knowledge of business concepts recommended.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Business Strategy and Leadership')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Business Strategy and Leadership')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Management and Business')),

    ('Mental Health and Wellness', 50, 450.00, 'A comprehensive course on mental health management, focusing on practical tools and techniques for improving well-being.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'david.clark')), 
        'Interest in psychology or healthcare encouraged.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Mental Health and Wellness')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Mental Health and Wellness')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Health')),

    ('Introduction to Educational Technology', 45, 650.00, 'Learn how to integrate technology in the classroom, from digital tools to educational software.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'olivia.harris')), 
        'Basic understanding of educational systems recommended.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Educational Technology')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Educational Technology')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Education')),

    ('Graphic Design Fundamentals', 30, 300.00, 'An introductory course on graphic design, covering essential tools and techniques for creating visually compelling designs.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'michael.roberts')), 
        'No prior design experience required.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Graphic Design Fundamentals')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Graphic Design Fundamentals')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Arts and Design')),

    ('Corporate Law and Legal Frameworks', 60, 1200.00, 'An in-depth look at corporate law, covering company formation, governance, and regulatory compliance.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sophia.lewis')), 
        'Some background in law or business helpful.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Corporate Law and Legal Frameworks')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Corporate Law and Legal Frameworks')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Law')),

    ('Sociology and Social Change', 50, 750.00, 'Study the social forces that drive change in societies and understand the impact of culture, economics, and politics on social structures.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'daniel.walker')), 
        'Basic understanding of social sciences recommended.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sociology and Social Change')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sociology and Social Change')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Humanities and Social Sciences')),

    ('Sustainable Tourism and Hospitality Management', 60, 1800.00, 'Explore sustainable tourism practices and how to manage hospitality businesses with an eco-friendly approach.', 
        (SELECT tutor_id FROM tb_tutors WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'isabella.carter')), 
        'Interest in travel and hospitality encouraged.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sustainable Tourism and Hospitality Management')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sustainable Tourism and Hospitality Management')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Tourism and Hospitality'));


SELECT * FROM tb_courses;

INSERT INTO tb_enrollments (user_id, course_id, enrollment_date, status)
VALUES
    ((SELECT id FROM tb_users WHERE username = 'anna.smith'), (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Programming with Python'), NOW(), 'active'),
    ((SELECT id FROM tb_users WHERE username = 'charles.johnson'), (SELECT id FROM tb_courses WHERE course_name = 'Business Strategy and Leadership'), NOW(), 'active'),
    ((SELECT id FROM tb_users WHERE username = 'beatrice.williams'), (SELECT id FROM tb_courses WHERE course_name = 'Mental Health and Wellness'), NOW(), 'completed'),
    ((SELECT id FROM tb_users WHERE username = 'philip.brown'), (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Educational Technology'), NOW(), 'dropped'),
    ((SELECT id FROM tb_users WHERE username = 'marian.taylor'), (SELECT id FROM tb_courses WHERE course_name = 'Graphic Design Fundamentals'), NOW(), 'active'),
    ((SELECT id FROM tb_users WHERE username = 'luke.anderson'), (SELECT id FROM tb_courses WHERE course_name = 'Corporate Law and Legal Frameworks'), NOW(), 'completed'),
    ((SELECT id FROM tb_users WHERE username = 'rita.clark'), (SELECT id FROM tb_courses WHERE course_name = 'Sociology and Social Change'), NOW(), 'active'),
    ((SELECT id FROM tb_users WHERE username = 'julia.lewis'), (SELECT id FROM tb_courses WHERE course_name = 'Sustainable Tourism and Hospitality Management'), NOW(), 'active');

SELECT * FROM tb_enrollments;

INSERT INTO tb_course_reviews (reviewer_id, course_id, rating, review_text)
VALUES
    ((SELECT id FROM tb_users WHERE username = 'anna.smith'), (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Programming with Python'), 4, 'Great course, but some topics could be more detailed. Overall, a solid introduction to Python!'),
    ((SELECT id FROM tb_users WHERE username = 'charles.johnson'), (SELECT id FROM tb_courses WHERE course_name = 'Business Strategy and Leadership'), 5, 'Incredibly informative! I now feel more confident in business strategy and leadership decisions. Highly recommended.'),
    ((SELECT id FROM tb_users WHERE username = 'beatrice.williams'), (SELECT id FROM tb_courses WHERE course_name = 'Mental Health and Wellness'), 5, 'An excellent course. The material was comprehensive and really helpful in understanding mental health in a professional context.'),
    ((SELECT id FROM tb_users WHERE username = 'philip.brown'), (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Educational Technology'), 4.5, 'Very insightful course, the tools and resources provided will be helpful in integrating technology into teaching.'),
    ((SELECT id FROM tb_users WHERE username = 'marian.taylor'), (SELECT id FROM tb_courses WHERE course_name = 'Graphic Design Fundamentals'), 5, 'Amazing course! It covered all the essential skills for beginners, and the projects were fun and engaging.'),
    ((SELECT id FROM tb_users WHERE username = 'luke.anderson'), (SELECT id FROM tb_courses WHERE course_name = 'Corporate Law and Legal Frameworks'), 3.5, 'Good content, but the course lacked practical examples in some areas. Still, a solid introduction to corporate law.'),
    ((SELECT id FROM tb_users WHERE username = 'rita.clark'), (SELECT id FROM tb_courses WHERE course_name = 'Sociology and Social Change'), 4, 'A well-organized course that made complex concepts accessible. Some sections felt rushed, though.'),
    ((SELECT id FROM tb_users WHERE username = 'edward.harris'), (SELECT id FROM tb_courses WHERE course_name = 'Sustainable Tourism and Hospitality Management'), 4.5, 'Very informative and relevant to the industry. The case studies were excellent, but the pace could be a bit faster.'),
    ((SELECT id FROM tb_users WHERE username = 'julia.lewis'), (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Programming with Python'), 5, 'Fantastic course! It provided a clear and structured path to learning Python for absolute beginners.'),
    ((SELECT id FROM tb_users WHERE username = 'gabriel.king'), (SELECT id FROM tb_courses WHERE course_name = 'Business Strategy and Leadership'), 4, 'The course is well-structured, but I think it would benefit from more in-depth case studies to apply the theory.');

SELECT * FROM tb_course_reviews;