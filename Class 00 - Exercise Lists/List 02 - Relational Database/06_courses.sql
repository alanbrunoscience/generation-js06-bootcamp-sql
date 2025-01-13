CREATE DATABASE db_butcher_shop;

USE db_butcher_shop;

CREATE TABLE tb_categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prod_category VARCHAR(100) NOT NULL,
    description VARCHAR(500) NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO tb_categories (prod_category, description)
VALUES
    ("Beef", "Includes premium cuts and everyday beef products, ideal for grilling, roasting, or stewing. Perfect for various culinary styles."),
    ("Pork", "A versatile meat with tender cuts and flavorful options for roasting, grilling, or frying."),
    ("Poultry", "Lean and healthy meats sourced from birds, suitable for a variety of dishes, from baked to fried."),
    ("Lamb and Sheep", "Tender and flavorful meats from lamb or sheep, ideal for roasting or slow-cooking. Often used in gourmet dishes."),
    ("Fish and Seafood", "Fresh and frozen aquatic products, ideal for health-conscious consumers and a variety of recipes."),
    ("Processed Meats", "Pre-packaged or freshly made meat products, seasoned and ready to cook or serve."),
    ("Exotic Meats", "Uncommon and specialty meats offering unique flavors for adventurous palates."),
    ("Organic Meats", "Sustainably raised meats, free from hormones and antibiotics, perfect for eco-conscious consumers."),
    ("Prepared Meats", "Pre-seasoned or pre-cooked meats, perfect for convenience and ready-to-cook meals."),
    ("Other Meats", "Includes organ meats and specialty cuts used for traditional recipes or unique dishes.");

SELECT * FROM tb_categories;

CREATE TABLE tb_products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prod_name VARCHAR(255) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    unit_of_measure VARCHAR(10) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    prod_category BIGINT,
    FOREIGN KEY (prod_category) REFERENCES tb_categories(id)
);

INSERT INTO tb_products (prod_name, stock_quantity, unit_of_measure, price, prod_category)
VALUES
    ("Lamb Chops", 25, "kg", 34.99, 4), -- Lamb category
    ("Bacon Strips", 40, "kg", 15.99, 2), -- Pork category
    ("Whole Chicken", 60, "unit", 6.99, 3), -- Poultry category
    ("Tilapia Fillet", 30, "kg", 19.49, 5), -- Fish category
    ("Ground Beef", 80, "kg", 9.99, 1), -- Beef category
    ("Marinated Pork Ribs", 20, "kg", 17.99, 2), -- Processed Meat category
    ("Duck Breast", 15, "kg", 24.99, 7), -- Exotic category
    ("Beef Liver", 50, "kg", 6.49, 10); -- Other Meats category

SELECT * FROM tb_products;

SELECT * FROM tb_products WHERE price > 50.00;

SELECT * FROM tb_products WHERE price BETWEEN 50.00 AND 150.00;

SELECT * FROM tb_products WHERE prod_name Like "%c%";

SELECT tb_products.id, prod_name, stock_quantity, unit_of_measure, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, tb_categories.prod_category AS prod_category, tb_categories.description AS description
FROM tb_products 
INNER JOIN tb_categories
ON tb_products.prod_category = tb_categories.id ORDER BY tb_products.id;

SELECT tb_products.id, prod_name, stock_quantity, unit_of_measure, CONCAT('R$ ', FORMAT(price, 2, 'pt_BR')) AS price, tb_categories.prod_category AS prod_category, tb_categories.description AS description
FROM tb_products
INNER JOIN tb_categories
ON tb_products.prod_category = tb_categories.id
WHERE tb_categories.prod_category = "Poultry";


INSERT INTO tb_tutors (user_id, bio, experience, category_id, num_courses, rating, total_reviews)
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


INSERT INTO tb_courses (course_name, workload, price, description, tutor_id, requirements, rating, num_reviews, category_id)
VALUES
    ('Introduction to Programming with Python', 40, 150.00, 'Learn the fundamentals of programming with Python, including variables, loops, and functions.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'john.green')), 'Basic computer literacy required.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Programming with Python')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Programming with Python')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Information Technology (IT)')),

    ('Business Strategy and Leadership', 60, 950.00, 'Explore the principles of business strategy and develop leadership skills to drive success in any organization.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sarah.adams')), 'Basic knowledge of business concepts recommended.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Business Strategy and Leadership')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Business Strategy and Leadership')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Management and Business')),

    ('Mental Health and Wellness', 50, 450.00, 'A comprehensive course on mental health management, focusing on practical tools and techniques for improving well-being.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'david.clark')), 'Interest in psychology or healthcare encouraged.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Mental Health and Wellness')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Mental Health and Wellness')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Health')),

    ('Introduction to Educational Technology', 45, 650.00, 'Learn how to integrate technology in the classroom, from digital tools to educational software.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'olivia.harris')), 'Basic understanding of educational systems recommended.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Educational Technology')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Introduction to Educational Technology')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Education')),

    ('Graphic Design Fundamentals', 30, 300.00, 'An introductory course on graphic design, covering essential tools and techniques for creating visually compelling designs.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'michael.roberts')), 'No prior design experience required.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Graphic Design Fundamentals')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Graphic Design Fundamentals')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Arts and Design')),

    ('Corporate Law and Legal Frameworks', 60, 1200.00, 'An in-depth look at corporate law, covering company formation, governance, and regulatory compliance.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'sophia.lewis')), 'Some background in law or business helpful.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Corporate Law and Legal Frameworks')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Corporate Law and Legal Frameworks')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Law')),

    ('Sociology and Social Change', 50, 750.00, 'Study the social forces that drive change in societies and understand the impact of culture, economics, and politics on social structures.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'daniel.walker')), 'Basic understanding of social sciences recommended.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sociology and Social Change')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sociology and Social Change')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Humanities and Social Sciences')),

    ('Sustainable Tourism and Hospitality Management', 60, 1800.00, 'Explore sustainable tourism practices and how to manage hospitality businesses with an eco-friendly approach.', 
        (SELECT id FROM tb_tutor WHERE tutor_id = (SELECT id FROM tb_users WHERE username = 'isabella.carter')), 'Interest in travel and hospitality encouraged.',
        (SELECT AVG(rating) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sustainable Tourism and Hospitality Management')), 
        (SELECT COUNT(*) FROM tb_course_reviews WHERE course_id = (SELECT id FROM tb_courses WHERE course_name = 'Sustainable Tourism and Hospitality Management')), 
        (SELECT id FROM tb_categories WHERE category_name = 'Tourism and Hospitality'));

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



