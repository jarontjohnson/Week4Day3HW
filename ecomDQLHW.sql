-- 1. List all customers who live in Texas (use
-- JOINs)

SELECT first_name, last_name
FROM customer
FULL OUTER JOIN address
ON customer.customer_id = address.address_id


-- 2. Get all payments above $6.99 with the Customer's Full
-- Name

SELECT first_name, last_name
FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer_id IN (
    SELECT amount
    FROM payment
    GROUP BY first_name, last_name
    HAVING SUM(amount) > 6.99
)


-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY payment.customer_id
    HAVING SUM(amount) > 175
)

-- 4. List all customers that live in Nepal (use the city
-- table)

SELECT customer.customer_id, customer.first_name, customer.last_name, address.address_id, city.city_id
FROM customer
JOIN address
ON customer.customer_id = address.address_id
JOIN address
ON address.address_id = city.city_id
JOIN city
ON city.city_id = city.city_id


-- 5. Which staff member had the most
-- transactions?

SELECT staff_id COUNT(rental_id) as rental_id
FROM rental
GROUP BY staff_id
ORDER BY rental_id DESC

-- 6. How many movies of each rating are
-- there?

SELECT rating, COUNT(*) as film_id
FROM film
GROUP BY rating;

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(*) = 1
);

-- 8. How many free rentals did our stores give away?

SELECT COUNT(*) as rental_id
FROM rental
WHERE amount = 1;