DROP DATABASE storefront; 

CREATE DATABASE storefront; 

USE storefront; 

-- Sesssion 2 Assginement 1

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role ENUM('Shopper','Admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
CREATE TABLE products(
	id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    description TEXT, 
    price DECIMAL(10,2) NOT NULL, 
    stock_quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

CREATE TABLE categories(
	id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) UNIQUE NOT NULL, 
    parent_id INT NULL,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE product_categories(
	product_id INT NOT NULL, 
    category_id INT NOT NULL, 
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE, 
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE, 
    PRIMARY KEY (product_id,category_id)
); 

CREATE TABLE images(
	id INT AUTO_INCREMENT PRIMARY KEY, 
    product_id INT NOT NULL, 
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE, 
    image_url TEXT NOT NULL
); 

CREATE TABLE shipping_addresses(
	id INT AUTO_INCREMENT PRIMARY KEY, 
    user_id INT NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, 
    street VARCHAR(100) NOT NULL, 
    city VARCHAR(100) NOT NULL, 
    state VARCHAR(100) NOT NULL, 
    zipcode VARCHAR(100) NOT NULL, 
    country VARCHAR(100) NOT NULL
); 

CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY, 
    user_id INT NOT NULL, 
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    status ENUM('Pending','Shipped','Canceled','Returned') DEFAULT 'Pending',
    shipping_address_id INT NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, 
    FOREIGN KEY (shipping_address_id) REFERENCES shipping_addresses(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

CREATE TABLE order_items(
	id INT AUTO_INCREMENT PRIMARY KEY, 
    order_id INT NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE, 
    product_id INT NOT NULL, 
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE, 
    quantity INT NOT NULL CHECK (quantity > 0), 
    status ENUM('Pending','Shipped','Canceled','Returned') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

SHOW TABLES; 

-- DROP TABLE products; -- with same command delete all tables referencing products and then recreating all tables


-- Session 2 Assignment 2


INSERT INTO users (name, email, password, role) VALUES
('Alice', 'alice@example.com', 'password123', 'Shopper'),
('Bob', 'bob@example.com', 'securepassword', 'Admin'),
('Charlie', 'charlie@example.com', 'charliepass', 'Shopper'),
('Diana', 'diana@example.com', 'dianasecure', 'Shopper'),
('Eve', 'eve@example.com', 'evepwd', 'Shopper'),
('Frank', 'frank@example.com', 'frank123', 'Admin'),
('Grace', 'grace@example.com', 'gracepwd', 'Shopper'),
('Hank', 'hank@example.com', 'hanksecure', 'Shopper'),
('Ivy', 'ivy@example.com', 'ivypass', 'Shopper'),
('Jack', 'jack@example.com', 'jacksecure', 'Shopper');

INSERT INTO products (name, description, price, stock_quantity) VALUES
('Laptop', 'A high-performance laptop', 999.99, 10),
('Smartphone', 'A latest-model smartphone', 699.99, 20),
('Tablet', 'A lightweight tablet', 399.99, 15),
('Headphones', 'Noise-cancelling headphones', 199.99, 30),
('Keyboard', 'Mechanical keyboard', 89.99, 50),
('Mouse', 'Wireless mouse', 29.99, 40),
('Monitor', '4K monitor', 249.99, 25),
('Smartwatch', 'Fitness-focused smartwatch', 149.99, 35),
('Camera', 'DSLR camera', 499.99, 12),
('Printer', 'All-in-one printer', 199.99, 8);

INSERT INTO categories (name, parent_id) VALUES
('Electronics', NULL),
('Computers', 1),
('Phones', 1),
('Accessories', NULL),
('Audio', 4),
('Wearables', 1),
('Cameras', 1),
('Printers', 1),
('Input Devices', 4),
('Displays', 1);

INSERT INTO product_categories (product_id, category_id) VALUES
(1, 2), -- Laptop belongs to Computers
(2, 3), -- Smartphone belongs to Phones
(3, 2), -- Tablet belongs to Computers
(4, 5), -- Headphones belong to Audio
(5, 9), -- Keyboard belongs to Input Devices
(6, 9), -- Mouse belongs to Input Devices
(7, 10), -- Monitor belongs to Displays
(8, 6), -- Smartwatch belongs to Wearables
(9, 7), -- Camera belongs to Cameras
(10, 8); -- Printer belongs to Printers

INSERT INTO images (product_id, image_url) VALUES
(1, 'https://example.com/laptop.jpg'),
(2, 'https://example.com/smartphone.jpg'),
(3, 'https://example.com/tablet.jpg'),
(4, 'https://example.com/headphones.jpg'),
(5, 'https://example.com/keyboard.jpg'),
(6, 'https://example.com/mouse.jpg'),
(7, 'https://example.com/monitor.jpg'),
(8, 'https://example.com/smartwatch.jpg'),
(9, 'https://example.com/camera.jpg'),
(10, 'https://example.com/printer.jpg');

INSERT INTO shipping_addresses (user_id, street, city, state, zipcode, country) VALUES
(1, '123 Main St', 'Hyderabad', 'Telangana', '500001', 'India'),
(2, '456 Elm St', 'Mumbai', 'Maharashtra', '400001', 'India'),
(3, '789 Maple St', 'Chennai', 'Tamil Nadu', '600001', 'India'),
(4, '321 Oak St', 'Delhi', 'Delhi', '110001', 'India'),
(5, '654 Pine St', 'Kolkata', 'West Bengal', '700001', 'India'),
(6, '987 Cedar St', 'Bangalore', 'Karnataka', '560001', 'India'),
(7, '147 Birch St', 'Ahmedabad', 'Gujarat', '380001', 'India'),
(8, '258 Walnut St', 'Pune', 'Maharashtra', '411001', 'India'),
(9, '369 Spruce St', 'Jaipur', 'Rajasthan', '302001', 'India'),
(10, '159 Chestnut St', 'Lucknow', 'Uttar Pradesh', '226001', 'India');

INSERT INTO orders (user_id, status, shipping_address_id) VALUES
(1, 'Pending', 1),
(2, 'Shipped', 2),
(3, 'Pending', 3),
(4, 'Canceled', 4),
(5, 'Returned', 5),
(6, 'Pending', 6),
(7, 'Shipped', 7),
(8, 'Pending', 8),
(9, 'Shipped', 9),
(10, 'Pending', 10);

INSERT INTO order_items (order_id, product_id, quantity, status) VALUES
(1, 1, 1, 'Pending'),
(2, 1, 2, 'Shipped'),
(3, 3, 1, 'Pending'),
(4, 4, 3, 'Canceled'),
(5, 5, 2, 'Returned'),
(6, 6, 2, 'Pending'),
(7, 7, 1, 'Shipped'),
(8, 8, 1, 'Pending'),
(9, 9, 1, 'Shipped'),
(10, 10, 1, 'Pending');

select p.id as id ,p.name as title ,c.name category_title ,p.price as price from products p left join product_categories pc on pc.product_id = p.id left join categories c on c.id = pc.category_id where p.stock_quantity > 0 order by created_at DESC; 

select p.id,p.name,p.description,p.price,p.stock_quantity from products p left join images i on p.id = i.product_id where i.product_id is null; 

select a.id, a.name as category, b.name as parent_category from categories a, categories b where a.parent_id = b.id order by b.name;  

select b.id , b.name as title, c.name as parent_category_title from categories a right join categories b on a.parent_id = b.id left join categories c on b.parent_id = c.id where a.parent_id is null; 

select p.name as title, p.price , p.description, c.name as category from products p left join product_categories pc on p.id = pc.product_id left join categories c on pc.category_id = c.id where c.name = 'Computers';  

select * from products where stock_quantity <= 50; 

-- Session 2 Assignment 3

select o.id,o.created_at,sum(p.price*oi.quantity) as total_bill from orders o left join order_items oi on o.id = oi.order_id left join products p on oi.product_id = p.id group by o.id limit 50; 

select o.id,o.created_at,sum(p.price*oi.quantity) as total_bill from orders o left join order_items oi on o.id = oi.order_id left join products p on oi.product_id = p.id group by o.id order by total_bill desc limit 10; 

select * from orders o where o.created_at < now()-interval 10 day and status = 'Pending';

select * from users u left join orders o on u.id = o.user_id where u.role = 'Shopper' and o.created_at < now()-interval 1 month and o.id = null; 

select * from users u left join orders o on u.id = o.user_id where u.role = 'Shopper' and o.created_at > now()-interval 15 day; 

select * from order_items oi where oi.status = 'Shipped' and oi.id = 2; 

select * from order_items oi left join orders o on oi.order_id = o.id left join products p on oi.product_id = p.id where p.price between 20 and 50; 







