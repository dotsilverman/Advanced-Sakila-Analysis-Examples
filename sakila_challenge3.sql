# daniel challenge #3 - In one query, list the top 5 films, by length, at each store
with cte1 as (
	select f.title, f.length, f.film_id, i.store_id as location from film as f
	join inventory as i 
	on f.film_id = i.film_id
)
(select distinct * from cte1
where location = 1 
order by length desc 
limit 5
)
union all 
(select distinct * from cte1
where location = 2 
order by length desc 
limit 5
);



