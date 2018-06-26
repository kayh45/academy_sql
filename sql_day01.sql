-- sql day01
-- 1. SCOTT 계정 활성화 : sys 계정으로 접속하여 스크립트 실행
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql;
-- 2. 접속 유저 확인 명령
show user
-- 3. HR 계정 활성화 : sys 계정으로 접속하여
--                   다른 사용자 확장 후 HR 계정의
--                   계정 잠김, 비밀번호 만료 상태 해제

----------------------------------------------------------------------

-- SCOTT 계정의 데이터 구조
-- (1) EMP 테이블 내용 조회
SELECT *
  FROM emp
;
/*----------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
----------------------------------------------------------------------*/

-- (2) DEPT 테이블 내용 조회

SELECT * 
  FROM dept
;
/* ----------------------
10	    ACCOUNTING	NEW YORK
20	    RESEARCH	DALLAS
30	    SALES	    CHICAGO
40	    OPERATIONS	BOSTON
-------------------------*/

--(3) SALGRADE 테이블 내용 조회
SELECT *
  FROM salgrade
;
/*--------------
GRADE, LOSAL, HISAL
1	    700	    1200
2	    1201	1400
3	    1401	2000
4	    2001	3000
5	    3001	9999
----------------*/


-- 01. DQL
-- (1) SELECT 구문
--  1) emp 테이블에서 사번, 이름, 직무를 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM emp e -- 소문자 e는 alias (별칭)
;

--  2) emp 테이블에서 직무만 조회
SELECT e.JOB
  FROM emp e
;
/*
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT
SALESMAN
CLERK
ANALYST
CLERK
*/

-- (2) DISTINCT 문 : SELECT 문 사용시 중복을 배제하여 조회
--  3) emp 테이블에서 job 컬럼의 중복을 배제하여 조회
SELECT DISTINCT e.JOB 
  FROM emp e
;
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
*/

-- * SQL SELECT 구문의 작동 원리 : 테이블의 한 행을 기본 단위로 실행함.
--                                테이블 행의 개수만큼 반복 실행.
SELECT 'Hello, SQL~'
  FROM emp e
;

--  4) emp 테이블에서 job, deptno에 대해 중복을 제거하여 조회
SELECT DISTINCT 
       e.JOB
     , e.DEPTNO
  FROM emp e
;

-- (3) ORDER BY 절 : 정렬
--  5) emp 테이블에서 job을 종복배제하여 조회하고 결과는 오름차순으로 정렬
SELECT DISTINCT
       e.JOB
  FROM emp e
 ORDER BY e.JOB
;
/*
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
*/

--  6) emp 테이블에서 job을 중복 배제하여 조회하고 내림차순으로 정렬
SELECT DISTINCT
       e.JOB
  FROM emp e
 ORDER BY e.JOB DESC
;
/*
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
*/

--  7) emp 테이블에서 comm을 가장 많이 받는 순서대로 출력
--    사번, 이름, 직무, 입사일, 커미션 순으로 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM DESC
;

--  8) emp 테이블에서 comm이 작은 순서대로, 직무별 오름차순, 이름별 오름차순 정렬
--     사번, 이름, 직무, 입사일, 커미션을  조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM, e.JOB, e.ENAME
;

--  9) emp 테이블에서 comm이 적은 순서대로, 직무별 오름차순, 이름별 내림차순으로 정렬
--     사번, 이름, 직무, 입사일, 커미션을 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM, e.JOB, e.ENAME DESC
;

-- (4) Alias : 별칭
--  10) emp 테이블에서 아래 각 컬럼에 별칭을 풀네임을 주어서 조회
--      empno --> Employee No.
--      ename --> Employee Name
--      job   --> Job Name
SELECT e.EMPNO AS "Employee No."
     , e.ENAME AS "Employee Name"
     , e.JOB AS "Job Name"
  FROM emp e
;

--  11) 10번과 동일 as 키워드 생략하여 조회
--      empno --> 사번
--      ename --> 사원 이름
--      job   --> 직무
SELECT e.EMPNO 사번
     , e.ENAME "사원 이름"
     , e.JOB "직무"
  FROM emp e
;

--  12) 테이블에 붙이는 별칭
SELECT empno
  FROM emp
;

SELECT emp.empno
  FROM emp
;

SELECT e.empno -- FROM 절에서 설정된 테이블 별칭은 SELECT 절에서 사용됨.
  FROM emp e -- 소문자 e가 emp 테이브르이 별칭이며 테이블 별칭은 FROM 절에 사용함
;

SELECT d.deptno
  FROM dept d
;

--  13) 영문 별칭 사용 시 특수기호 _ 사용하는 경우
SELECT e.EMPNO Employee_No
     , e.ENAME "Employee Name"
  FROM emp e
;

--  14) 별칭과 정렬의 조합 : SELECT 절에 별칭을 준 경우 ORDER BY 절에서 사용가능
--      emp 테이블에서 사번, 이름, 직무, 입사일, 커미션을 조회할 때
--      각 컬럼에 대해서 한글 별칭을 주어 조회
--      정렬은 커미션, 직무, 이름을 오름차순으로 정렬
SELECT e.EMPNO    사번
     , e.ENAME    이름
     , e.JOB      직무
     , e.HIREDATE 입사일
     , e.COMM     커미션
  FROM emp e
 ORDER BY 커미션, 직무, 이름
;

--  15) DISTINCT, 별칭, 정렬의 조합
--      job을 중복을 제거하여 직무라는 별칭을 조회하고
--      내림차순으로 정렬
SELECT DISTINCT 
       e.JOB AS "직무"
  FROM emp e
 ORDER BY 직무 DESC
;
/*
  직무
---------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
*/