# step 1 
use sakila;
select * from sales_by_film_category
limit 5;

# step 2 
DROP PROCEDURE category_sales;

delimiter // 
create procedure category_sales(
	in genre varchar(255),
    out sales_rating varchar(15)) 
begin 
	declare tot_sales decimal;
	select total_sales into tot_sales 
    from sales_by_film_category
    where category = genre;
    
    if tot_sales > 4000 THEN 
		set sales_rating = 'HIGH';
	else 
		set sales_rating = 'LOW';
	end if;
end 
// delimiter ; 

call category_sales('Sports', @sales_rating);
select @sales_rating;