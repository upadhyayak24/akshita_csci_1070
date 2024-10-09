--Q1
select *
from payment
where amount>=9.99;

--Q2
select title
from payment
left join rental
on payment.rental_id = rental.rental_id
left join inventory
on rental.inventory_id = inventory.inventory_id
left join film
on inventory.film_id = film.film_id
where amount = 11.99;


--Q3
select first_name, last_name, address.address_id, email, city.city_id, country.country_id
from staff
left join address
on staff.address_id = address.address_id
left join city
on address.city_id = city.city_id
left join country
on city.country_id = country.country_id

--Q4
-- I'm interested in medical research fields and bioinformatics so companies that work with data and research specifically designed towards medical fields is my hope for the future.
--Q5
-- The crows feet link these data sets together and to the primary key and is a representation of class or object.

