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