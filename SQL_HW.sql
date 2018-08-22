#SQL HW 
USE sakila;


#1a. 
select first_name, last_name
from actor

#1b.
select concat(first_name, ' ', last_name) as 'Actor Name'
from actor

#2a. 
select first_name, last_name
from actor
where actor.first_name = "Joe"

#2b.
select first_name, last_name
from actor
where actor.last_name LIKE "%GEN%"

#2c.
select first_name, last_name
from actor
where actor.last_name LIKE "%LI%"
order by actor.last_name, actor.first_name

#2d
select country_id, country
from country
where country.country IN ('Afghanistan' , 'Bangladesh', 'China');


#3a
alter table actor
add description blob;

#3b.
alter table actor
drop description;

#4a. 
select last_name, count(last_name)
from actor
group by last_name;

#4b. 
SELECT last_name, COUNT(*) AS `Count`
FROM actor
GROUP BY last_name
HAVING Count > 2;

#4c.
UPDATE actor 
SET first_name= 'HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

#4c.
UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

#5a
DESCRIBE sakila.address

#6a
select staff.first_name, staff.last_name, address.address
from staff
inner join address on staff.address_id = address.address_id

#6b
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'TOTAL'
FROM staff s inner JOIN payment p  ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name;
#where p.payment_date between #2005-07-01# AND #2005-07-31#; 

select *
from payment

#6c
SELECT title, COUNT(actor_id) as 'Actor Count'
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY title;

#6d
SELECT title, COUNT(inventory_id) as 'Movie Count'
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";

#6e
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'TOTAL'
FROM customer c LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name


#7a
SELECT title
FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') 
AND language_id=(SELECT language_id FROM language where name='English')

#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id
	IN (SELECT actor_id FROM film_actor WHERE film_id 
		IN (SELECT film_id from film where title='ALONE TRIP'));

#7c
SELECT first_name, last_name, email, country 
FROM customer cu
JOIN address a ON (cu.address_id = a.address_id)
JOIN city cit ON (a.city_id=cit.city_id)
JOIN country cntry ON (cit.country_id=cntry.country_id)
where country = 'Canada';

#7d
SELECT title, category
FROM film_list
WHERE category = 'Family';

#7e
SELECT i.film_id, f.title, COUNT(r.inventory_id) as 'Movie Count'
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f 
ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;


#7f
SELECT store.store_id, SUM(amount) as 'Revenue'
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id

#7g
SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);

#7h
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross Revenue" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY 'Gross Revenue'  LIMIT 5;

#8a
CREATE VIEW top_five_genres as
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross Revenue" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY 'Gross Revenue'  LIMIT 5;

#8b
select * from top_five_genres

#8c
drop view top_five_genres