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































