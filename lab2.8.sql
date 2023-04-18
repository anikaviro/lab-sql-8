-- Lab 2.8 - Lab 8 SQL
USE sakila;
-- 1. Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country
FROM store s
INNER JOIN address a
ON s.address_id = a.address_id
INNER JOIN city c
ON a.city_id = c.city_id
INNER JOIN country co
ON c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT store_id, sum(amount) 
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY store_id;

-- 3. Which film categories are longest?

SELECT name, avg(length) as length FROM film f
INNER JOIN film_category fc
ON f.film_id = fc.film_id
INNER JOIN category c
ON fc.category_id = c.category_id
GROUP BY name
ORDER BY length DESC;


-- 4. Display the most frequently rented movies in descending order.
SELECT i.film_id, f.title, COUNT(r.inventory_id)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f 
ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;


-- 5. List the top five genres in gross revenue in descending order.

SELECT name, SUM(p.amount) as amount
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
INNER JOIN film f
ON f.film_id = fc.film_id
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY amount
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?

    select f.film_id, f.title, s.store_id, i.inventory_id
from inventory i
join store s
on s.store_id = i.store_id
join film f
on f.film_id = i.film_id
where f.title = 'Academy Dinosaur' 
and s.store_id = 1;
   
-- Yes there are 4 copies
    
-- 7. Get all pairs of actors that worked together.

-- i need to use a self join with actor tables and then find number of film ids in common for actors but having different actor id (so they are different actors)

SELECT DISTINCT a1.actor_id, a1.first_name, a1.last_name, a2.actor_id, a2.first_name, a2.last_name 
FROM film_actor fa 
JOIN actor a1
on a1.actor_id = fa.actor_id
JOIN actor a2 
on fa.actor_id = a2.actor_id
WHERE fa.film_id in (SELECT DISTINCT film_id FROM film_actor);


