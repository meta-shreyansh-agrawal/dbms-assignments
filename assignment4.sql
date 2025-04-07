USE storefront; 

-- Session 4 Assignment 1

DELIMITER $$

CREATE FUNCTION OrdersInMonth(input_month int, input_year int)
returns int deterministic
begin
	declare order_count int;
    select count(*) into order_count from orders where month(created_at) = input_month and year(created_at) = input_year; 
    return order_count; 
end$$

DELIMITER ; 

DELIMITER $$

CREATE FUNCTION MonthWithMaxOrders(input_year int)
RETURNS INT DETERMINISTIC
begin 
	declare output_month int; 
    select month(created_at) into output_month from orders o where year(o.created_at) = input_year group by month(o.created_at) order by count(*) desc limit 1; 
	return output_month; 
end$$

DELIMITER ; 

-- Session 4 Assignment 2

DELIMITER $$

CREATE PROCEDURE average(input_month int,input_year int)
begin

select p.id,p.name,avg(oi.quantity*p.price) as average_sales from order_items oi join products p on oi.product_id = p.id where month(oi.created_at) = input_month and year(oi.created_at) = input_year group by p.id; 

end$$

DELIMITER ; 

DELIMITER $$
CREATE PROCEDURE order_details(start_date Date,end_date Date)
begin
if start_date > end_date then set start_date = date_format(end_date,'%Y-%m-01'); 
end if; 

select * from orders;

end$$

DELIMITER ; 


create index order_index on orders(user_id,status); 

create index product_index on products(name);

create index category_index on categories(name,parent_id);  

























