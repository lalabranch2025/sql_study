# bit, bytes
# bit = 컴퓨터 취급 최소한의 연산처리 단위 = 0, 1
# byte = bit 8 = 1 byte = 2^8 = 256
# int의 종류가 여러가지지만 메모리를 아끼기 위해서 세분화 했던 것, 현업에서는 int를 주로 사용

CREATE TABLE mytable (
	id INT UNSIGNED # UNSIGNED 부호와 음의 정수를 사용하지 않고 양의 정수만 사용하겠다.
);

CREATE DATABASE IF NOT EXISTS customer_db;
SHOW DATABASES;
USE customer_db;

# IF NOT EXISTS 는 잘 안씀, 있는지 없는지 내가 더 잘 아는데 왜씀? 안전장치임
# NULL = 결측값
# 0, not, none 아닌 값이 결여되어있는 상태 (언제라도 값이 들어올 수 있다는 전제조건)
# 제목 타입 프라이머리키 조건 
CREATE TABLE IF NOT EXISTS customer (
	no INT PRIMARY KEY NOT NULL AUTO_INCREMENT, # NOT NULL 결측을 허용하지 않겠다
    name VARCHAR(20) NOT NULL,
    age INT,
    phone VARCHAR(20),
    email VARCHAR(30) NOT NULL,
    address VARCHAR(50)
);
# Table 내 컬럼 속성변경
ALTER TABLE customer MODIFY COLUMN name VARCHAR(30) NOT NULL;

# Table 내 컬럼명 + 속성변경
ALTER TABLE customer CHANGE COLUMN name user_name VARCHAR(20) NOT NULL;

# Table 내 여러 필드 컬럼명 + 속성변경
ALTER TABLE customer
	CHANGE COLUMN age user_age INT,
	CHANGE COLUMN phone user_phone VARCHAR(30) NOT NULL;

# 동시에 여러 구문을 같이 실행하고자 할 때
# 구문의 가독성을 위해서 들여쓰기를 적절하게 해주면 좋음
ALTER TABLE customer
	MODIFY email VARCHAR(40) NOT NULL,
	CHANGE address user_address VARCHAR(40);

DESC customer;