-- 실습문제

------------------------------------------------------------------------
--- DML


-- 실습 1)
INSERT INTO customer(USERID, NAME, BIRTHYEAR, ADDRESS)
VALUES ('C001', '김수현', 1988, '경기')
;
INSERT INTO customer(USERID, NAME, BIRTHYEAR, ADDRESS)
VALUES ('C002', '이효리', 1979, '제주')
;
INSERT INTO customer(USERID, NAME, BIRTHYEAR, ADDRESS)
VALUES ('C003', '원빈', 1977, '강원')
;
/*
USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE, GRADE
--------------------------------------------------------
C001	김수현	1988	18/07/02	경기		
C002	이효리	1979	18/07/02	제주		
C003	원빈	    1977	18/07/02	강원		
*/


-- 실습 2)
UPDATE customer c
   SET c.NAME = '차태현'
     , c.BIRTHYEAR = 1976
 WHERE c.USERID = 'C001'
;
/*
USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE, GRADE
--------------------------------------------------------
C001	차태현	1976	18/07/02	경기		
C002	이효리	1979	18/07/02	제주		
C003	원빈	    1977	18/07/02	강원		
*/


-- 실습 3)
UPDATE customer c
   SET c.ADDRESS = '서울'
;
/*
USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE, GRADE
--------------------------------------------------------
C001	차태현	1976	18/07/02	서울		
C002	이효리	1979	18/07/02	서울		
C003	원빈	    1977	18/07/02	서울		
*/


-- 실습 4)
DELETE customer c
 WHERE c.USERID = 'C003'
;
/*
USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS, PHONE, GRADE
--------------------------------------------------------
C001	차태현	1976	18/07/02	서울		
C002	이효리	1979	18/07/02	서울		
*/


-- 실습 5)
DELETE customer;
/*
인출된 모든 행 : 0
*/

-- 실습 6)
TRUNCATE TABLE customer;
/*
Table CUSTOMER이(가) 잘렸습니다.
*/


DESC customer;
/* == customer 테이블 정보 ==
---------------------------------
USERID    NOT NULL VARCHAR2(30) 
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(4)  
GRADE              VARCHAR2(30)
--------------------------------
*/
SELECT c.*
  FROM customer c
;


---------------------------------------------------
-- 시퀀스

-- 실습 1)
CREATE SEQUENCE seq_cust_userid
START WITH 1
MAXVALUE 99
NOCYCLE
;
-- Sequence SEQ_CUST_USERID이(가) 생성되었습니다.


-- 실습 2)
SELECT s.SEQUENCE_NAME
     , s.MIN_VALUE
     , s.MAX_VALUE
     , s.CYCLE_FLAG
  FROM user_sequences s
;
/*
SEQUENCE_NAME,      MIN_VALUE,  MAX_VALUE, CYCLE_FLAG
------------------------------------------------------
SEQ_CUST_USERID	        1	        99	        N
*/


-- 실습 3)
DROP TABLE new_cust;
CREATE TABLE new_cust
AS
SELECT c.*
  FROM customer c
 WHERE 1 = 0
;
-- INDEX가 자동으로 부여되지 않되 테이블 구조를 그대로 사용하기 위해
-- customer 테이블을 CTAS 구문을 사용하여 복사

CREATE INDEX idx_cust_userid
    ON new_cust(userid)
;
/*
Index IDX_CUST_USERID이(가) 생성되었습니다.
*/


-- 실습 4)
SELECT i.INDEX_NAME
     , i.INDEX_TYPE
     , i.TABLE_NAME
     , i.TABLE_OWNER
     , i.INCLUDE_COLUMN
  FROM user_indexes i
;
/*
INDEX_NAME, INDEX_TYPE, TABLE_NAME, TABLE_OWNER, INCLUDE_COLUMN
-----------------------------------------------------------------
IDX_CUST_USERID	NORMAL	NEW_CUST	SCOTT	
PK_EMP	        NORMAL	EMP	        SCOTT	
PK_DEPT	        NORMAL	DEPT	    SCOTT	
PK_CUSTOMER 	NORMAL	CUSTOMER	SCOTT	
*/
SELECT c.TABLE_NAME
     , c.INDEX_NAME
     , c.COLUMN_NAME
     , c.COLUMN_POSITION
  FROM user_ind_columns c
;
/*
TABLE_NAME, INDEX_NAME, COLUMN_NAME, COLUMN_POSITION
----------------------------------------------------
NEW_CUST	IDX_CUST_USERID	USERID	    1
CUSTOMER	PK_CUSTOMER	    USERID	    1
DEPT	    PK_DEPT	        DEPTNO	    1
EMP	        PK_EMP	        EMPNO	    1
*/


-- 실습 5)
SELECT i.INDEX_NAME
     , i.INDEX_TYPE
     , i.TABLE_NAME
     , i.TABLE_OWNER
     , i.INCLUDE_COLUMN
  FROM user_indexes i
 WHERE i.INDEX_NAME = 'IDX_CUST_USERID'
;
/*
INDEX_NAME,     INDEX_TYPE, TABLE_NAME, TABLE_OWNER, INCLUDE_COLUMN
-----------------------------------------------------------------	
IDX_CUST_USERID	    NORMAL	NEW_CUST	SCOTT	
*/


-- 실습 6)
SELECT c.TABLE_NAME
     , c.INDEX_NAME
     , c.COLUMN_NAME
     , c.COLUMN_POSITION
  FROM user_ind_columns c
 WHERE c.INDEX_NAME = 'IDX_CUST_USERID'
;
/*
TABLE_NAME  INDEX_NAME       COLUMN_NAM  COLUMN_POSITION
----------------------------------------------------
NEW_CUST	IDX_CUST_USERID	    USERID	        1
*/

-- 실습 7)
DROP INDEX idx_cust_userid
;
/*
Index IDX_CUST_USERID이(가) 삭제되었습니다.
*/


-- 실습 8)
SELECT c.TABLE_NAME
     , c.INDEX_NAME
     , c.COLUMN_NAME
     , c.COLUMN_POSITION
  FROM user_ind_columns c
 WHERE c.INDEX_NAME = 'IDX_CUST_USERID'
;
/*
    인출된 모든 행 : 0
*/

----------------------------------------------------------
-- PL/SQL

SET SERVEROUTPUT ON

-- 실습 1)
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL World!');
END;
/
/*
Hello, PL/SQL World!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 실습 2)
DECLARE
    hello   VARCHAR2(20) := 'Hello, ';
    plsql   VARCHAR2(20);
    world   VARCHAR2(20) := ' World!';
BEGIN
    plsql := 'PL/SQL';
    DBMS_OUTPUT.PUT_LINE(hello || plsql || world);
END;
/
/*
Hello, PL/SQL World!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 실습 3)
--  (1) 테이블 생성
CREATE TABLE log_table
(  userid VARCHAR2(20)
 , log_date DATE
);
/*
Table LOG_TABLE이(가) 생성되었습니다.
*/

--  (2) 프로시져 생성
CREATE OR REPLACE PROCEDURE log_execution
IS
    v_userid VARCHAR(20) := 'myid';
BEGIN
    INSERT INTO log_table
    VALUES (v_userid, sysdate);
END;
/
/*
Procedure LOG_EXECUTION이(가) 컴파일되었습니다.
*/

--  (3) 프로시져 실행
EXECUTE log_execution
;
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- (4) 실행된 결과 확인
SELECT l.USERID
     , TO_CHAR(l.LOG_DATE, 'YYYY-MM-DD HH24:MI:SS') AS log_date
  FROM log_table l 
;
/*
USERID        LOG_DATE
----------------------------
myid	2018-07-02 23:12:04
myid	2018-07-02 23:13:28
myid	2018-07-02 23:13:29
*/

-- 실습 4)
--  (1) 프로시져 변경
CREATE OR REPLACE PROCEDURE log_execution
(  v_log_user   IN  VARCHAR2
 , v_log_date   OUT DATE) 
IS
BEGIN
    v_log_date := sysdate;
    INSERT INTO log_table
    VALUES (v_log_user, v_log_date);    
END log_execution;
/
/*
Procedure LOG_EXECUTION이(가) 컴파일되었습니다.
*/

--  (2) BIND 변수 선언 후 프로시져 실행 및 BIND 변수 조회
VAR v_log_date VARCHAR2
EXECUTE log_execution('kayh45', :v_log_date)
PRINT v_log_date
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다. <- EXECUTE 실행시


V_LOG_DATE                                 <- PRINT 실행시
--------------------------------------------------------------------------------
18/07/02
*/


-- 실습 5)
--  (1) 프로시져 생성
CREATE OR REPLACE PROCEDURE chk_sal_per_month
(  v_sal        IN  NUMBER
 , v_sal_month  OUT NUMBER
)
IS
BEGIN
    v_sal_month := (v_sal/12); 
    DBMS_OUTPUT.PUT_LINE(v_sal_month);
END chk_sal_per_month;
/
/*
Procedure CHK_SAL_PER_MONTH이(가) 컴파일되었습니다.
*/

--  (2) BIND 변수 선언 후 프로시져 실행 및 BIND 변수 조회
VARIABLE v_month NUMBER
EXECUTE chk_sal_per_month(5000, :v_month)
PRINT v_month
/*
   V_MONTH
----------
416.666667

sql_developer에서는 안나오는데 sql*plus로 실행하니 나오네요..
*/