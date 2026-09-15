# VIEW = 가상 테이블 = Virtual Table
# SubQuery | JOIN => 쿼리 구문 행수가 많아짐 => 코드 가독성 저하
# 사람이 코드를 보면서 쿼리구문 작성 => 실수가 많아질 수 있음
# 사전에 가상으로 갑을 저장시켜놓은 테이블 준비
# 해당 테이블을 필요에 따라서 가져다가 사용 => 쿼리구문 독립성 유지 // 실수저하
# VIEW => 실제 데이터가 저장 안됨 // SELLET 형식의 쿼리 구문 저장

# 이 쿼리문의 이름은 이제부터 Actorinfo임
# 가상테이블이 만들어짐
CREATE VIEW Actorinfo AS
SELECT first_name, last_name
FROM actor
WHERE actor_id < 100;

SELECT * FROM Actorinfo;

# VIEW 한 번 생성이 되면, 다른 프로젝트 구문에서도 사용!!
# VIEW는 동일한 이름으로 이미 생성되어 있다면, 같은 이름 사용 불가

CREATE OR REPLACE VIEW Actorinfo AS
SELECT first_name
FROM actor
WHERE actor_id < 50;

DROP VIEW Actorinfo;

SELECT * FROM customer; # MARY SMITH

CREATE OR REPLACE VIEW Myview AS
SELECT * FROM customer
WHERE customer_id = 1;

SELECT * FROM Myview; # MARY SMITH

# 1번 고객의 이름을 DAVID로 바꾸고 싶어 
UPDATE customer
SET first_name = "DAVID"
WHERE customer_id = 1;