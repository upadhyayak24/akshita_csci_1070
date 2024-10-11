--Question 1
select first_name, last_name
from customer
where last_name LIKE 'T%'
ORDER BY first_name ASC;

-- Question 2
select *
from rental
WHERE rental_date BETWEEN '2005-05-8' AND '2005-06-01';

--Question 3
-- For this question, to find which movies are rented the most you would use rental and film because you need to join both queries to get the answer.
select f.title, count(r.rental_id) as rental_count
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.title
order by rental_count DESC
limit 10;

--Question 4
select c.customer_id, c.first_name, c.last_name, sum(p.amount) as total_spent
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_spent ASC;

--Question 5
select a.first_name, a.last_name as actor_name, count(f.film_id) as movie_count
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
where f.release_year = 2006
group by a.actor_id, a.first_name, a.last_name
order by movie_count DESC;

--Question 6
-- For Question 4 and 5, the queries follow a plan where we join multiple queries together in order to filter answers from multiple queries.
-- In Question 4, we have to combine the customer and the payment query in order to name which customers spent how much. After joining them, the query groups people by their id and name. 
--Then it scans all the customers in the customer query and filters them to be in a descending order meaning the top will be the customer with the highest payment and so forth. 
--It is important to account p.amount as something else otherwise there will be an error because it isn't in the group by statement and the query won't run.

--For Question 5, if we want to find the actor in the most movies in 2006, we have to join the actor, film actor, and film queries in order to access the actor names, the movies, and the movie count
--Then, the where clause will filter all the films to the ones that are from 2006, and then by grouping by actors that are also connected to films, it will count all the movies that each actor is in.
-- By putting it in a descending order, it starts from the highest movie count to the lowest, which will give the correct formatting of list.

--Question 7
select c.name , avg(f.rental_rate)
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by c.name;

--Question 8
select c.category_id, c.name as category_name, COUNT(8) as total_rentals
from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.category_id, c.name
order by total_rentals DESC
limit 5;

