# DB => Table > RDBMS = 관계형 데이터베이스 관리 시스템
# MySQL 프로그램의 SQL문법
# 관계

# 관계를 맺게 해주는 문법
# 서브쿼리 : 1개의 SELECT FROM 조회구문 안에 또 다른 SELECT FROM 조회 구문 사용! 값을 조회
# JOIN : 
# 서브쿼리 구문은 1개의 쿼리문 안에서 횟수 제약 없이 사용 가능
# 서브쿼리가 많아질수록 구문을 이해하는데 있어서 가독성이 매우 안좋아짐

# 문제점 개선
# INNER JOIN : 서로 다른 테이블간 공통 요소만 살려두는 문법
# OUT JOIN : 먼저 사용 및 선택된 테이블 요소를 중심으로 살려두는 문법
# LEFT OUTER JOIN
# RIGHT OUTER JOIN

SHOW TABLES;
SELECT * FROM film_category LIMIT 10;
# film_id, category_id, last_update

SELECT * FROM category LIMIT 10;
# category_id, name, last_update

SELECT category_id, COUNT(*)
FROM film_category
WHERE film_category.category_id > ( # 어디에 있는 category_id인지 정확히 표기해야 함
		SELECT category.category_id 
        FROM category
        WHERE category.name = "Comedy"
	)
GROUP BY film_category.category_id; # 그룹을 해야 카운트를 할 수 있고 대상은 category_id여야 한다

# 현업개발자 : 서브쿼리를 선호(JOIN 속도가 느려서 서브쿼리 선호)
# 현업 데이터사이언티스트 : JOIN선호(보기 좋음)

SELECT * FROM customer LIMIT 10;
# customer_id, store_id, first_name, email, address_id, active, create_date, last_update

SELECT * FROM payment LIMIT 10;
# payment_id, ** customer_id **, staff_id, rental_id, amount, payment_date, last_update

SELECT first_name, last_update
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > (
		SELECT AVG(amount)
        FROM payment
	)
);

SELECT 
	C.first_name, C.last_name
FROM customer C
JOIN payment P ON C.customer_id = P.customer_id
JOIN(
	SELECT AVG(amount) avg_amount
    FROM payment
) A ON P.amount > A.avg_amount;

# Sakila DB > 가장 많은 결제 (횟수) = 집계 를 한 고객 찾기!!
# 서브쿼리로 해결할 것!! //

# payment에서 payment와 customer의 customer_id로 join해서 first_name과 last_name을 합침
select customer_id, COUNT(*)
FROM payment
GROUP BY customer_id, payment_id;

# 망함

# 1-출력하고자 하는 값 : 풀네임 (성, 이름) -> customer
# 2-출력하고자 하는 값 : 결제가 일어났을 때의 정보

SHOW TABLES;

SELECT
	first_name, last_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
    FROM (
		SELECT
			customer_id,
			COUNT(*) payment_count
		FROM payment
		GROUP BY customer_id
    ) AS payment_counts
    ORDER BY payment_count DESC
    LIMIT 1
);

SELECT P.customer_id, P.amount, P.payment_date
FROM payment P
WHERE amount > (
	SELECT AVG(amount)
    FROM payment
    WHERE customer_id = P.customer_id
);
# SELECT FROM > SELECT FROM (상관서브쿼리)
# 서브쿼리가 자체적으로 값을 도출하지 못하고, 밖에 있는 컬럼을 참조해서 도출

# film 테이블에서 평균영화길이보다 긴 영화들의 제목을 조회!!
SELECT title FROM film
WHERE length < (
	SELECT
		AVG(length)
	FROM film
);

# sakila DB, 각 고객들이 자신이 대여한 영화들 존재
# 그동안 대여했었던 영화들의 평균 길이보다 긴 영하들의 제목만 취합해서 출력!
# first_name, last_name, film_title
# 1. customer 에서 last_name, film_title을 찾자
# 2. film에서 글자 길이를 찾을 수 있다
# 3. customer와 film을 바로 이을 수 없어서 중간에 뭔가 더 필요


# SELECT * FROM payment;


# customer.customer_id와 payment.customer_id로 rental.rental_id로 수량 체크
# rental.inventory_id와 inventory.film_id, film.film_id로 작품 특정
# film
# 아닌거 같다..ㅜㅜ
SHOW TABLES;
# customer, rental, inventory, film 활용!

SELECT * FROM customer;
# customer_id, first_name, last_name

SELECT * FROM film LIMIT 10;
# film_id, title, length

SELECT * FROM inventory;
# inventory_id, film_id, store_id

SELECT * FROM rental;
# inventory_id, customer_id

# 4개의 테이블을 붙이자

SELECT
	C.first_name, C.last_name, F.title
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
# 테이블을 합침, 이제 조건을 달아보자 WHERE와 HAVING을 잘 구별할 것
# 출력된 영화의 길이가 평균보다 커야 함
WHERE F.length > (
	SELECT AVG(FIL.length)
    FROM film FIL
    JOIN inventory INV ON INV.film_id = FIL.film_id
    JOIN rental REN ON REN.inventory_id = INV.inventory_id
    WHERE REN.customer_id = C.customer_id
);

# payment, rental, inventory(inventory_id, film_id)
# customer, rental, inventory, film

SELECT * FROM film LIMIT 10;
# replacement_cost : 20달러 이상인 영화를 대여한 고객의 이름 조회ALTER# 출력값 고객 이름ALTER
SELECT
	DISTINCT CONCAT(C.first_name, "_", C.last_name) fullname
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R. inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.replacement_cost >= 20;

# film 테이블에서 rating이 "PG-13"등급인 영화들이 있음
# 전체 영화들은 각각 description(영화 설명)이 존재
# 전체 영화들의 개별적인 description의 길이가 rating이 "PG-13"등급에 한한 영화들의 평균 description길이보다 긴 영화들의 제목만 조회.출력
# LENGTH() : 특정 컬럼 안에 입력되어있는 문자열의 길이를 조회.추출하는 함수
# 해당 조건에 충족되는 영화 "제목"만 출력

-- SELECT title
-- FROM film
-- WHERE rating = "PG-13";

-- SELECT LENGTH(description)
-- FROM film;

-- SELECT title
-- FROM film
-- WHERE length < (
-- AVG(description);

-- SELECT * from film;

-- WHERE length < (
-- 	SELECT
-- 		AVG(length)
-- 	FROM film
-- );

-- WHERE customer_id IN (
-- 	SELECT customer_id
-- 	FROM payment
-- 	WHERE amount > (
-- 		SELECT AVG(amount)
--         FROM payment
-- 	)
-- );

# 정답

USE sakila;

SELECT title
FROM film
WHERE LENGTH(description) > (
	SELECT LENGTH(description)
    FROM film
    WHERE rating = "PG-13"
);

# 2025년 8월에 대여된 모든 "R"등급 영화의 제목과 해당 영화를 대여한 고객의 이메일을 조회
# 날짜와 관련된 컬럼 -> 특정 연도 및 월을 추출하고자 할 때
# YEAR(customer.rental_date)
# MONTH(customer.rental_date)

# rental(rental_date,inventoru_id,customer_id)
# customer(email,customer_id)
# film(film_id, rating, inventoru_id)
# inventory(film_id, inventoru_id)

SELECT * FROM film LIMIT 10; # film_id, inventoru_id
SELECT * FROM inventory LIMIT 10; # inventoru_id, customer_id
SELECT * FROM rental LIMIT 10; # inventoru_id, customer_id
SELECT * FROM customer LIMIT 10; # customer_id

SHOW TABLES;

-- SELECT F.title
-- FROM film F
-- JOIN inventory I ON I.film_id;


-- SELECT *
-- FROM film F
-- JOIN inventory I ON I.film_id = F.film_id
-- JOIN rental R ON R. inventory_id = I.inventory_id
-- JOIN customer C ON C.customer_id = R.customer_id;

SELECT *
FROM film F
JOIN inventory I USING(film_id)
JOIN rental R ON R. inventory_id = I. inventory_id
JOIN customer C ON C.customer_id = R.customer_id
WHERE
	MONTH (R. rental_date) = 8 AND
	YEAR (R. rental_date) = 2005 AND
	F.rating = "R";
    
# 고객들의 렌탈 결제 정보 존재
# 각 고객별 마지막 결제 시점, 해당 시점으로부터 30일 이전 기간동안 결제내역을 찾아서
# 해당 결제 내역들의 전체 결제 내역 합계, 평균 결제 금액 조회
# 출력 시, 소수점 두번째 자리까지 반올림해서 출력

SELECT * FROM customer LIMIT 10; # customr_id
SELECT * FROM payment LIMIT 10; # customr_id

SELECT
	customer_id,
    ROUND(SUM(amount), 1) customer_sum,
    ROUND(AVG(amount), 1) customer_avg
FROM payment
WHERE payment_date >= DATE_SUB(
	(SELECT MAX(payment_date) FROM payment), INTERVAL 30 DAY
)
GROUP BY customer_id;

# 영화는 모두 카테고리를 가지고 있습니다.
# 카테고리가 공상과학인 영화들에 출연한 배우의 이름을 찾아서 조회!
# 배우의 이름은 성, 이름 => 하나로 연결 (CONCAT)
# 배우의 이름 출력 시, 대문자로 출력 (UPPER)(LOWER)

SELECT
	UPPER(CONCAT(A.first_name, "_", A.last_name)) fullname
FROM actor A
JOIN film_actor F USING(actor_id)
JOIN film_category FC USING(film_id)
JOIN category C USING(category_id)
WHERE name = "Sci-Fi";


# SELECT * FROM film LIMIT 10; # film_id
-- SELECT * FROM actor LIMIT 10; # actor_id 배우이름
-- SELECT * FROM category LIMIT 10; # category_id 장르
-- SELECT * FROM film_category LIMIT 10; # film_id, category_id
-- SELECT * FROM film_actor LIMIT 10; # actor_id, film_id

-- SELECT *
-- FROM actor AC
-- JOIN film_actor FA ON FA.actor_id = AC.actor_id
-- JOIN film_category FC ON 

-- SELECT
-- 	DISTINCT CONCAT(C.first_name, "_", C.last_name) fullname
-- FROM customer C
-- JOIN rental R ON R.customer_id = C.customer_id
-- JOIN inventory I ON I.inventory_id = R. inventory_id
-- JOIN film F ON F.film_id = I.film_id
-- WHERE F.replacement_cost >= 20;



