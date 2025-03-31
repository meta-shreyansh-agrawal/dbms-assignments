use storefront; 

-- Session 3 Assignment 2

select p.id,p.name as title,count(*) as categories_count from products p left join product_categories pc on p.id = pc.product_id left join categories c on pc.category_id = c.id group by p.id having count(*)>1 ; 

select case 
when price between 0 and 100 then '0 - 100' 
when price between 100 and 500 then '100 - 500' 
else 'above 500' 
end as price_range, count(*) as product_count 
from products group by case 
when price between 0 and 100 then '0 - 100' 
when price between 100 and 500 then '100 - 500' 
else 'above 500' 
end; 

select c.id,c.name,count(*) from categories c right join product_categories pc on pc.category_id = c.id left join products p on p.id = pc.product_id group by c.id ; 

-- session 3 assignment 3

select u.id,u.name,u.email,u.password,u.role,count(*) as order_count from users u right join orders o on u.id = o.user_id where u.role = 'Shopper' and o.created_at > now()-interval 1 month group by u.id ;

select u.id,u.name,sum(p.price*oi.quantity) as revenue from users u join orders o on o.user_id = u.id join order_items oi on o.id = oi.order_id join products p on oi.product_id = p.id where u.role = 'Shopper' and o.created_at > now()-interval 30 day group by u.id order by revenue desc limit 10; 

select oi.product_id,p.name,sum(oi.quantity) as quantity from order_items oi join products p on p.id = oi.product_id where oi.created_at > now()-interval 60 day group by product_id order by quantity desc limit 20; 

select date_format(oi.created_at,'%Y-%m') as month, sum(oi.quantity*p.price) as total_revenue from order_items oi join products p on oi.product_id = p.id where oi.created_at > now()-interval 6 month group by date_format(oi.created_at, '%Y-%m') order by date_format(oi.created_at, '%Y-%m'); 

alter table products add column status enum('Active','Inactive') default 'Active'; 
SET SQL_SAFE_UPDATES = 0;
update products set status = 'Inactive' where id not in ( select distinct product_id from order_items oi where oi.created_at > now() - interval 90 day); 
SET SQL_SAFE_UPDATES = 1;

select * from categories c join product_categories pc on c.id = pc.category_id join products p on p.id = pc.product_id where c.name = "Computers"; 

select product_id,p.name, count(*) as quantity from orders o join order_items oi on o.id = oi.order_id join products p on oi.product_id = p.id where o.status = 'Canceled' group by product_id order by quantity desc limit 10; 

-- Session 3 Assignment 3

drop database zipcode; 
create database zipcode; 
use zipcode; 

CREATE TABLE States (
    StateID INT PRIMARY KEY AUTO_INCREMENT,
    StateName VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Cities (
    CityID INT PRIMARY KEY AUTO_INCREMENT,
    CityName VARCHAR(100) UNIQUE NOT NULL,
    StateID INT NOT NULL,
    FOREIGN KEY (StateID) REFERENCES States(StateID)
);

CREATE TABLE ZipCodes (
    ZipCode VARCHAR(10) PRIMARY KEY,
    CityID INT NOT NULL,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

INSERT INTO States (StateName) VALUES 
('Andhra Pradesh'),
('Telangana'),
('Karnataka'),
('Tamil Nadu');

INSERT INTO Cities (CityName, StateID) VALUES 
('Hyderabad', 2), 
('Visakhapatnam', 1), 
('Bangalore', 3), 
('Chennai', 4),
('Warangal', 2);

INSERT INTO ZipCodes (ZipCode, CityID) VALUES 
('500001', 1), 
('531001', 2), 
('560001', 3), 
('600001', 4), 
('506001', 5);

SELECT z.ZipCode,c.CityName,s.StateName
FROM ZipCodes z
INNER JOIN Cities c ON z.CityID=c.CityID
INNER JOIN States s ON c.StateID=s.StateID
ORDER BY s.StateName,c.CityName;
    
-- Session 3 Assignment 5

USE storefront; 

drop view recent_orders; 

CREATE VIEW recent_orders AS 
SELECT o.id as id,p.name as product_name,p.price,u.name as username,u.email,o.created_at,o.status FROM orders o 
join order_items oi on o.id = oi.order_id 
join products p on oi.product_id = p.id
join users u on o.user_id = u.id where o.created_at > now()-interval 60 day order by o.created_at desc ; 

select * from recent_orders where status = 'Shipped'; 

select product_name , count(*) as quantity from recent_orders group by product_name order by quantity desc limit 5; 





