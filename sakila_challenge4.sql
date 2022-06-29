# write a case statement when staff id = 1, do something. 
select *, 
	case staff_id 
		when 1 then 'staff 1' 
		when 2 then 'staff 2' 
		else 'no staff 3' 
    end as staff_case
from sakila.payment;


# if statement - see who has the highest payment made. 
select customer_id, sum(amount) as total_amount from sakila.payment
group by customer_id
order by total_amount;

# separate customers into 3 groups. Could use if or case statement 
delimiter $$ 
create procedure get_cust_level(in cust_id int) 
begin
	declare cust_total decimal(5,2);
    declare cust_level varchar(25); 
    
    select sum(amount) 
    into cust_total 
    from sakila.payment 
    where customer_id = cust_id 
    group by customer_id; 
    
	# could do this with case statements as well 
    if cust_total < 100 then 
		set cust_level = 'low';
    elseif cust_total between 100 and 200 then
		set cust_level = 'medium';
    else
		set cust_level = 'high';
    end if; 
    
    select cust_id, cust_total, cust_level;
end 
$$ delimiter ; 

drop procedure get_cust_level;

call get_cust_level(526);
call get_cust_level(248);
call get_cust_level(581);

# next make a loop to run through all customers 