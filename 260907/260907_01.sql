# 주석 : 문법관련 내용, 마케팅 관점ALTER

-- 단문 = 한줄 주석

/*
복문 주석
*/

# MyAQL 프로그램 : RDBMS를 지원하기 위해서 만들어진 프로그램
# DB : Database = 여러 Data들이 모여있는 그룹 혹은 집합 = 저장소
# Data : 관찰.측정.조사를 통해서 수집된 값, 사실, 기록
# Schema : 약속 = 데이터별 특정 요소들을 어떤 제약조건하에 기록.저장할 것인가 약속
# Table : 공통 주제에 속해있는 데이터들을 별도로 관리하기 위해서 만들어놓은 저장단위
# MongoDB 프로그램 NoSQL을 지원하지 위해서 만들어진 프로그램(not only SQL)
# DBMS > RDBMS (MySQL) > DB > Table > Schema > Data 
# AI Agent & MCP : MySQL > AI // RCTCO : Prompt

# SQL 문법 종류 4가지 분야
# DDL : Data Definition Language 생성, 삭제 등 : CREATE, DROP, ALTER
# DML : Data Manipulation Language 조작 : SELECT, INSERT, UPDATE, DELETE
# DCL : Data Control Language 데이터를 취급할 수 있는 권한 설정 : GRANT, REVOKE
# TCL : Transaction Control Language 거래, 취급 : COMMIT, ROLLBACK, SAVEPOINT

# Table : 실제 Data가 저장되어있는 공간
# 행.열 구성
# 1개의 행 = 레코드 (Record) = Row = 튜플(Tuple)
# 1개의 열 = 속성 (attribute) = column > Field Name (필드명) 컬럼의 제목