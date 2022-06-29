/*Write a stored procedure using the sakila database that returns the customer (both first and last name) 
that spent the maximum amount of money on rentals. */ 

delimiter $$
create procedure get_cus_max_pay()
begin
	with cte1 as (
		SELECT 
			SUM(p.amount) as total_spent,
			CONCAT(c.first_name, ' ', c.last_name) AS full_name
		FROM
			customer AS c
				JOIN
			payment AS p ON c.customer_id = p.customer_id
		GROUP BY full_name
		ORDER BY total_spent desc
	)
	select * from cte1 
	where total_spent = (select max(total_spent) from cte1);
end 
$$ delimiter ;

call get_cus_max_pay();
