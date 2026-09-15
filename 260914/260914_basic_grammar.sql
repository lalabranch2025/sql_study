USE sakila;

SELECT 
	rating,
    COUNT(*) rating_count,
    AVG(rental_rate) avg_rental_rate
FROM film
GROUP BY rating
ORDER BY avg_rental_rate DESC; #default ASC DESC


SELECT 
	rating,
    COUNT(*) rating_count,
    AVG(rental_rate) avg_rental_rate
FROM film
WHERE release_year = 2006 OR release_year = 2007
GROUP BY rating
HAVING rating_count >= 200
ORDER BY avg_rental_rate DESC;
# GROUP화를 하고자 하는 대상 조냊 :  해당 그룹화 대상의 조건이 직접 x, WHERE
# 표기순서 : Select > From > Where > Group > Having > Order
# 실행순서 : From > ... > Select
# GROUP화 되어있는 대상의 조건을 설정 : HAVING