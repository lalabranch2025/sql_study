USE sakila;
SHOW TABLES;

SELECT * FROM payment LIMIT 10;
Select Sum(amount) FROM payment; # 총매출

SELECT 
	DATE_FORMAT(payment_date, "%Y-%m") AS payment_month, # "%Y-%m"연월만 추출한 것을 pament_month라고 부를거야
    SUM(amount)
FROM payment
GROUP BY payment_month
ORDER BY payment_month;

SELECT
	customer_id,
    COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;