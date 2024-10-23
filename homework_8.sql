--Question 1
ALTER TABLE rental
add status varchar(255);
update rental
set status = CASE
when (return_date-rental_date) > interval '7 days' then 'late'
when (return_date-rental_date) = interval '7 days' then 'on time'
else 'early'
END;
select * from rental;
--Question 2
select sum(p.amount)
from payment p
left join customer c on p.customer_id = c.customer_id
left join address a on c.address_id = a.address_id
left join city t on a.city_id = t.city_id
where t.city in ('Kansas City','Saint Louis');


--Question 3
select category.name, count(film.film_id) as film_count
from category 
join film_category on category.category_id=film_category.category_id
join film on film_category.film_id=film.film_id
group by category.name
order by film_count DESC;

--Question 4
-- Category and film category are two different tables probably so that category can define all the different genres for movies
-- and the film category table can take the films in the film table and allocate them to categories
--the reason they are separate is because one movie might fall into multiple categories ex: a romantic comedy film

--Question 5
select film.film_id, film.title, film.length
from rental
join inventory on rental.inventory_id=inventory.inventory_id
join film on inventory.film_id=film.film_id
where rental.return_date between '2005-05-15' and '2005-05-31';

--Question 6
select film.title, film.rental_rate
from film 
where film.rental_rate < (select avg(rental_rate) from film);

--Question 7
select status, count(*) as film_num
from rental
group by status;

--Question 8
select film.title, film.length,
percent_rank() over (order by film.length)
	as percentile_rank
from film
where film.length IS NOT NULL;

--Question 9
explain
select film.film_id,film.title, rental.rental_date
from film
join inventory on film.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
where rental.customer_id=87;

explain
select film.title, count(rental.rental_id) as rental_count
from film 
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
GROUP BY film.title;

--both queries need to join tables in order to run and be able to extract information from the tables that are selected
--but the first query is searching for the options that connect with customer number 87 which is a more specific request
--than just counting the rentals for films so the explain feature shows more steps for the first query