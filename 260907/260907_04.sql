# DB -> Table -> Schema -> Modify / Change -> INSERT -> UPDATE
# 데이터가 없다!!

CREATE DATABASE student_db;
USE student_db;

CREATE TABLE students (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30),
	age INT UNSIGNED,
	grade VARCHAR(10)
);

INSERT INTO students VALUES(1, "David", 15, "2학년");

# 1은 자동생성이라 넣기 시른뎅..
INSERT INTO students (name, age, grade)
VALUES("Dave", 16, "3학년");

# 한꺼번에 다 넣쟝
INSERT INTO students (name, age, grade)
VALUES
	("Jane", 14, "1학년"),
    ("Juliet", 15, "2학년"),
    ("Romeo", 16, "3학년");

SELECT * FROM students;

UPDATE students
SET grade = "2학년", age = 15
WHERE id = 3;

# MySQL 프로그램 설치 > 구글 포털 > 

# 얼리어쩌구 깔면 이 코드가 먹혀버림, 한꺼번에 뭘 어쩌구 하기 때문에 매우 위험함
# Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. 
# To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect. 절대 하면 안됨
 
UPDATE students
SET grade = "3학년", age = 16;

# 진짜진짜 위 코드를 실행하고 싶다면 아래코드부터 실행 후 가능(세이프모드를 끔)
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

# 이것도 안되어야 정상, 진짜진짜 이 코드를 실행하고 싶다면 위 코드부터 실행 후 가능(세이프모드를 끔)
UPDATE students
SET grade = "1학년", age = 14
# 2학년, 15살의 조건에 한해서 실행
WHERE grade = "2학년" AND age = 15;

# DB -> Table -> Schema -> Modify / Change -> INSERT -> UPDATE -> SELECT
SELECT * FROM students; # 전체 열을 찾아와라
SELECT * FROM students WHERE age >= 15; # WHERE 조건절
SELECT * FROM students WHERE age <> 15;
# 조건절 : 비교연산자 & 논리연산자
# 비교연산자 : =같다 >=크거나 같다 <=작거나 같다 >크다 <작다 != <>부정연산자 아니다으!
# 1 == "1" // 1 === "1"

SELECT * FROM students WHERE NOT age = 16;
# NOT는 연산자가 아니고 논리 부정 키워드, 예약어 안에 포함
# 단순 부정 연산을 위한 목적보다, NULL의 연산처리를 위한 목적
# IS NOT NULL 이 하나의 문법이 아니고 각각 독립적인 용도가 있음

SELECT * FROM students WHERE age IS NOT NULL;
SELECT * FROM students WHERE age <> NULL; # 틀린 문법

# 논리연산
SELECT * FROM students
WHERE age >15 AND grade = "2학년";
# AND : 좌항 AND 우항 -> 좌학도 True / 우항도 True

SELECT * FROM students
WHERE (age >15 AND grade = "3학년") OR grade = "1학년";
# 우선 연산을 위해 ()넣어주기

SELECT * FROM students
WHERE name LIKE "D%"; # % => 0개 혹은 그 이상의 존재 정의 D로만 시작하면 찾아와라

SELECT * FROM students
WHERE name LIKE "%D%"; # %0개 이상 D존재 %0개 이상 찾아와람