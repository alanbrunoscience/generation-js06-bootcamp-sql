CREATE DATABASE db_building_materials_store;

USE db_building_materials_store;

-- Create the Tables
CREATE TABLE tb_categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tb_products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL,
    description VARCHAR(500),
    stock_quantity INT NOT NULL DEFAULT 0,
    unit_of_measure VARCHAR(15) NOT NULL,
    prod_category BIGINT NULL,
    FOREIGN KEY(prod_category) REFERENCES tb_categories(id) ON DELETE SET NULL -- ON DELETE SET NULL is useful because it avoids cascading deletion and keeps the products while indicating that they are no longer associated with any category.
);

CREATE TABLE tb_suppliers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL
);

CREATE TABLE tb_supplier_contacts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    supplier_id BIGINT NOT NULL,
    contact_type ENUM('Phone', 'Email', 'Address') NOT NULL,
    contact_value VARCHAR(255),
    FOREIGN KEY (supplier_id) REFERENCES tb_suppliers(id)
);

CREATE TABLE tb_supplier_products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    delivery_time INT,
    supplier_id BIGINT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES tb_suppliers(id),
    FOREIGN KEY (product_id) REFERENCES tb_products(id)
);

-- Insert Values Into the Tables
INSERT INTO tb_categories (category_name, description)
VALUES
    ('Structural Materials', 'Materials used to form the framework or support of buildings.'),
    ('Finishing Materials', 'Products for completing the interior and exterior of a building.'),
    ('Plumbing Supplies', 'Components for water supply and drainage systems.'),
    ('Electrical Supplies', 'Materials for electrical wiring and power systems.'),
    ('Insulation and Weatherproofing', 'Materials for maintaining temperature and protecting structures.'),
    ('Tools and Equipment', 'Instruments for construction and DIY projects.'),
    ('Landscaping Materials', 'Supplies for outdoor spaces and gardens.'),
    ('Fasteners and Hardware', 'Small components for assembly and installation.'),
    ('Safety Gear', 'Protective equipment for workers and DIY enthusiasts.'),
    ('Miscellaneous Supplies', 'Additional materials and accessories.'),
    ('Other', NULL);

SELECT * FROM tb_categories;

INSERT INTO tb_products (material_name, description, stock_quantity, unit_of_measure, prod_category)
VALUES
    ('Cement', 'Portland cement for general construction use.', 100, 'kg', 1),
    ('Brick', 'Clay bricks for walls and structures.', 500, 'unit', 1),
    ('Wood Plank', 'Treated wood planks for framing.', 200, 'm', 1),
    ('Paint - White', 'Interior paint, matte finish, 5L bucket.', 50, 'bucket', 2),
    ('PVC Pipe', 'PVC pipe for plumbing, 1.5-inch diameter.', 300, 'm', 3),
    ('Steel Rebar', 'Reinforced steel bars for concrete support.', 150, 'kg', 1),
    ('Roof Tile', 'Ceramic tiles for roofing, terracotta color.', 400, 'unit', 1),
    ('Electrical Cable', 'Copper electrical cable, 3-core, 2.5mm.', 250, 'm', 4),
    ('Safety Helmet', 'Protective helmet for construction workers.', 75, 'unit', 5),
    ('Glue - Construction Adhesive', 'Heavy-duty adhesive for construction projects.', 120, 'tube', 2);

SELECT * FROM tb_products;

INSERT INTO tb_suppliers (supplier_name)
VALUES
    ('Global Construction Supplies'),
    ('BuildPro Distributors'),
    ('EcoBuild Materials'),
    ('Steel & More'),
    ('Ace Plumbing Supplies');

SELECT * FROM tb_suppliers;

INSERT INTO tb_supplier_contacts (supplier_id, contact_type, contact_value)
VALUES
    (1, 'Phone', '+1 555-1234'),
    (1, 'Email', 'contact@globalcs.com'),
    (2, 'Phone', '+1 555-5678'),
    (2, 'Email', 'sales@buildpro.com'),
    (3, 'Phone', '+1 555-8765'),
    (3, 'Email', 'support@ecobuild.com'),
    (3, 'Address', '123 Green Lane, Cityville'),
    (4, 'Phone', '+1 555-4321'),
    (4, 'Email','info@steelandmore.com'),
    (5, 'Phone', '+1 555-1243'),
    (5, 'Email', 'service@aceplumbing.com');

SELECT * FROM tb_supplier_contacts;

INSERT INTO tb_supplier_products (product_id, price_per_unit, delivery_time, supplier_id)
VALUES
    (1, 20, 7, 1),
    (2, 0.50, 5, 1),
    (3, 12.50, 10, 2),
    (4, 30, 3, 3),
    (5, 4.80, 8, 4), ,
    (6, 6.50, 4, 5),
    (7, 40, 7, 1),
    (8, 15, 10, 2),
    (9, 8, 5, 3),
    (10, 5, 3, 4);

SELECT * FROM tb_supplier_products;