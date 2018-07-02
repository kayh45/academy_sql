-- day 05 :  SQL
--------------------------------------------
-- ORACLE의 특별한 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
--            물리적으로 저장된 위치이므로 한 행당 반드시 유일할 수 밖에 없음
--            ORDER BY 절에 의해서 변경되지 않는값

-- 예) emp 테이블에서 'SMITH'인 사람의 정보를 조회

SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH'
;

-- rowid 를 같이 조회
SELECT e.ROWID
     , e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH'
;

-- rowid 는 ORDER BY 에 의해 변경되지 않는다.
SELECT e.ROWID
     , e.EMPNO
     , e.ENAME
  FROM emp e
 ORDER BY e.EMPNO
;
-- 2. ROWNUM : 
SELECT rownum
     , e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH' 
 ORDER BY e.ENAME
;
/*
1	7369	SMITH
*/
SELECT rownum
     , e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%' 
;
/*
1	7566	JONES
2	7900	JAMES
3	9999	J_JUNE
4	6666	JJ
5	8888	J
6	7777	J%JONES
*/

SELECT rownum
     , e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%' 
 ORDER BY e.ENAME
;
/*
5	8888	J
6	7777	J%JONES
2	7900	JAMES
4	6666	JJ
1	7566	JONES
3	9999	J_JUNE
*/
-- 위의 두 결과를 비교하면 rownum도 ORDER BY에 영향을 
-- 받지 않는 것처럼 보일 수 있으나
-- SUB-QUERY로 사용할 때 영향을 받음.
SELECT rownum
     , a.EMPNO
     , a.ENAME
     , a."행번호"
  FROM (SELECT e.EMPNO
             , e.ENAME
             , rownum  AS "행번호"
          FROM emp e
         WHERE e.ENAME LIKE 'J%' 
         ORDER BY e.ENAME) a
;
/*
ROWNUM  EMPNO    ENAME     행번호
---------------------------------
1	    8888	J	        5
2	    7777	J%JONES	    6
3	    7900	JAMES	    2
4	    6666	JJ	        4
5	    7566	JONES	    1
6	    9999	J_JUNE	    3
*/



------------------------------------------------------------
-- DML : 데이터 조작어

-- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령

DROP TABLE member;
CREATE TABLE member
(  member_id    VARCHAR2(3)     
 , member_name  VARCHAR2(15)    NOT NULL
 , phone        VARCHAR2(4)
 , reg_date     DATE            DEFAULT sysdate
 , address      VARCHAR2(30)
 , birth_month  NUMBER(2)       
 , gender       VARCHAR2(1)     
 , CONSTRAINT pk_member         PRIMARY KEY (member_id)
 , CONSTRAINT ck_member_gender  CHECK (gender IN ('M', 'F'))
 , CONSTRAINT ck_member_birth   CHECK (birth_month > 0 AND birth_month <= 12)
);

--- 1. INTO 구문에 컬럼 이름 생략시 데이터 추가
--전체 데이터 추가
INSERT INTO member
VALUES ('M01', '전현찬', '5250', sysdate, '덕명동', 11, 'M');

INSERT INTO member
VALUES ('M02', '조성철', '9034', sysdate, '오정동', 8, 'M');

INSERT INTO member
VALUES ('M03', '김승유', '5219', sysdate, '오정동', 1, 'M');

-- 몇 몇 컬럼에 NULL 데이터 추가
INSERT INTO member
VALUES ('M04', '박길수', '4003', sysdate, NULL, NULL, 'M');

INSERT INTO member
VALUES ('M05', '강현', NULL, NULL, '홍도동', 6, 'M');

INSERT INTO member
VALUES ('M06', '김소민', NULL, sysdate, '월평동', NULL, NULL);

-- CHECK 옵션에 위배되는 데이터 추가 시도
INSERT INTO member
VALUES ('M07', '강병우', '2260', NULL, '사정동', 2, 'N'); -- gender 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_GENDER) violated
*/
INSERT INTO member
VALUES ('M07', '강병우', '2260', NULL, '사정동', 2, 'M');

INSERT INTO member
VALUES ('M08', '정준호', NULL, sysdate, '나성동', 0, NULL); -- birth_month 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_BIRTH) violated
*/
INSERT INTO member
VALUES ('M08', '정준호', NULL, sysdate, '나성동', 1, NULL);


-- 입력데이터 조회
SELECT m.*
  FROM member m
;
/*
M01	전현찬	5250	18/07/02	덕명동	11	M
M02	조성철	9034	18/07/02	오정동	8	M
M03	김승유	5219	18/07/02	오정동	1	M
M04	박길수	4003	18/07/02			M
M05	강현			                홍도동	6	M
M06	김소민		    18/07/02	월평동		
M07	강병우	2260		        사정동	2	M
M08	정준호		    18/07/02	나성동	1		
*/

--- 2. INTO 구문에 컬럼 이름 명시하여 데이터 추가
--     : VALUES 절에 INTO 의 순서대로
--       값의 타입, 개수를 맞추어서 작성
INSERT INTO member (member_id, member_name, gender)
VALUES ('M09', '윤홍식', 'M');
-- reg_date 컬럼 : DEFAULT 설정이 자공하여 시스템 날짜가 자동 입력
-- phone, address 컬럼 : NULL 값으로 입력되는것 확인

-- INTO 절에 컬럼 나열 시 테이블 정의 순서와 별개로 나열 가능
INSERT INTO member (member_name, member_id)
VALUES ('남정규', 'M10');
/*
오류 보고 -
ORA-00001: unique constraint (SCOTT.PK_MEMBER) violated
*/
-- 수정 : 이름 컬럼에 주소가 들어가는 데이터
--        이름, 주소 모두 문자 데이터이기 때문에 타입이 맞아서
--        논리오류 발생
INSERT INTO member (member_name, member_id)
VALUES ('목동', 'M11');