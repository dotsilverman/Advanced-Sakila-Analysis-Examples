# get the most popular film for each category, in terms of number of times rented.
use sakila;
with cte1 as (
	select f.title, c.name, count(r.rental_id) as times_rented from film as f
	join film_category as fc 
	on f.film_id = fc.film_id 
	join category as c 
	on fc.category_id = c.category_id
	join inventory as i 
	on f.film_id = i.film_id 
	join rental as r 
	on i.inventory_id = r.inventory_id
    group by title
	order by title
)
select * from cte1 
where cte1.times_rented = (
	select max(cte2.times_rented) 
    from cte1 as cte2 
    where cte1.name = cte2.name
)
group by name
order by name; 

# or you can do it like: 

select store, movie, length 
from (
	select 
		s.store_id as store, 
		f.title as movie, 
		f.length as length,
		row_number () over (partition by s.store_id order by f.length desc) as row_num
    from 
		sakila.film f 
	join sakila.inventory i 
		on f.film_id = i.film_id
	join sakila.store s 
		on i.store_id = s.store_id
) as row_order 
where row_num between 1 and 5; 