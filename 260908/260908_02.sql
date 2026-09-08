# student_db를 드랍
DROP DATABASE student_db;

# student_db를 그대로 둔 상대에서 stidents 테이블을 제거
DELETE FROM stidents;

# 하면 1175에러가 뜨고 키값을 어쩌고 내용이 뜸
DELETE FROM stidents WHERE name = "Davide";

# 기존 테이블의 구조는 유지하면서 값만 제거
TRUNCATE TABLE stidents;