# DB : 데이터를 관리할 수 있는 가장 큰 카테고리
# 소문자로 해도 되던데 왜 굳이 대문자?
# 현업 -> 대문자
# 영어 베이스 기반 : 예약어 | 명령어 // 업데이트 : x 예약어와 변수명 등 혼동을 방지
# ctrl + enter : 현재 작성한 쿼리문 실행
# 서로 다른 테이블간 어떤 연결관계를 가지도록 할 것인가!!

CREATE DATABASE dbname;

# 존재하는 데이터베이스 보기
SHOW DATABASES;

# db를 사용
USE dbname;

# 테이블 만들기
CREATE TABLE mytable (
	id INT,
    name VARCHAR(50),
    # variable character 가변문자 이걸 여태 몰랐네
    PRIMARY KEY(id)
);

# 현업스타일 프라이머리키 지정 방식(반복해서 값, 행ㅇㄹ 쓰는걸 싫어함)
CREATE TABLE mytable (
	id INT PRIMARY KEY AUTO_INCREMENT,
    # AUTO_INCREMENT 값이 들어올때마다 id값을 1씩 증가
    name VARCHAR(50)
    # variable character 가변문자 이걸 여태 몰랐네
);

# 현재 생성된 테이블이 어떤 규칙으로 정의되어 있는가?
DESC mytable;

# 현재 생성된 테이블 안에서 값 조회
SELECT * FROM mytable;

# 데이터베이스 삭제
DROP DATABASE dbname;


