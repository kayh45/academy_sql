/*
2018-06-27

*/

-- SQL day02
-----------------------------------------------

---IS NULL, IS NOT NULL 연산자
/*   IS NULL : 비교하려는 컬럼의 값이 NULL이면 true, 아니면 false
     IS NOT NULL : 비교하려는 컬럼의 값이 NULL이 아니면 true, 맞으면 true
     
     NULL 값은 비교연산자와 연산이 불가능 하므로
     NULL 값 비교 연산자가 따로 존재함
     
*/
--- 27) 어떤 직원의 mgr가 지정되지 않은 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR IS NULL
;
/*
EMPNO   ENAME    MGR
---------------------
7839	KING	
9999	J_JUNE	
8888	J	
7777	J%JONES	
*/

---  mgr이 배정된 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR IS NOT NULL -- e.MGR != null 이나 e.MGR <> null 같은 형식으로 사용할 수 없음
;
/*
EMPNO   ENAME    MGR
---------------------
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

-- IS NOT NULL  대신 <>, != 연산자를 사용한 경우의 조회 결과 비교
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR <> NULL
;
-- > 인출된 모든 행 : 0
-- > 실행에 오류는 없지만 올바른 결과가 아님
-- > 이런 경우는 오류를 찾기가 어렵기 때문에 NULL 데이터를 다룰떄는 항상 주의



--- BTWEEN a AND b : 범위 비교 연산자 (범위 포함)
--  a <= sal <= b  : 이러한 범위 연산과 동일

-- 28) 급여가 500 ~ 1200 사이인 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL BETWEEN 500 AND 1200
;
-- BETWEEN 500 AND 1200 과 같은 결과를 내는 비교연산자
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 500
   AND e.SAL <= 1200 
;

--- EXISTS 연산자 : 조회한 결과가 1행 이상 있다.
--                  어떤 SELECT 구문을 실행했을 때 조회결과가 1행이상 있으면
--                  이 연산자의 결과가 true
--                  조회 결과 : <인출된 모든 행: 0> 인 경우 false
--                  따라서 서브쿼리와 함꼐 사용됨

SELECT e.ENAME
  FROM emp e
 WHERE e.SAL >10000
;

/*
위의 쿼리 실행 결과가 1행이라도 존재하면 화면에 
"급여가 3000이 넘는 직원이 존재함" 이라고 출력
*/

SELECT '급여가 10000이 넘는 직원이 존재함' as "시스템 메시지"
  FROM dual
 WHERE EXISTS (SELECT e.ENAME
                 FROM emp e
                WHERE e.SAL > 3000)
;

/*
위의 쿼리 실행 결과가 1행이라도 존재하지 않으면 화면에 
"급여가 10000이 넘는 직원이 존재하지 않음" 이라고 출력
*/

SELECT '급여가 10000이 넘는 직원이 존재하지 않음' as "시스템 메시지"
  FROM dual
 WHERE NOT EXISTS (SELECT e.ENAME
                 FROM emp e
                WHERE e.SAL > 10000)
;

-- (6) 연산자 : 결합연산자 (||)
--- 오라클에만 존재, 문자열 결합(접합)
--- 다른 자바 등의 프로그래밍 언어에서는 OR 논리 연산자로 사용되므로
--- 혼동에 주의

--- 오늘의 날짜를 화면에 조회
SELECT '오늘의 날짜는 ' || sysdate || '입니다.' as "오늘의 날짜"
  FROM dual
;

-- 직원의 사번을 알려주는 구문을 결합연산자를 사용하여 작성
SELECT '안녕하세요. ' || e.ENAME || '씨, 당신의 사번은 ' || e.EMPNO || '입니다.' as "사번 알리미"
  FROM emp e
;

-- (6) 연산자 : 6. 집합연산자
-- 첫번째 쿼리
SELECT *
  FROM dept d
;

-- 두번째 쿼리 : 부서번호가 10번인 부서정보만 조회
SELECT *
  FROM dept d
 WHERE d.DEPTNO = 10
;

-- 1) UNION ALL : 두 집합의 중복 데이터 허용하여 합집합
SELECT *
  FROM dept d
 UNION ALL
SELECT *
  FROM dept d
 WHERE d.DEPTNO = 10
;

-- 2) UNION : 중복을 제거한 합집합
SELECT *
  FROM dept d
 UNION
SELECT *
  FROM dept d
 WHERE d.DEPTNO = 10
;

-- 3) INTERSECT : 종복된 데이터만 남김 (교집합)
SELECT *
  FROM dept d  
INTERSECT
SELECT *
  FROM dept d
 WHERE d.DEPTNO = 10
;

-- 4) MINUS : 첫번째 쿼리 실행 결과에서 두번째 쿼리 실행결과를 뺀 차집합
SELECT *
  FROM dept d  
 MINUS
SELECT *
  FROM dept d
 WHERE d.DEPTNO = 10
;

-- 주의 ! : 각 쿼리 조회 결과의 컬럼 개수, 데이터 타입이 서로 일치해야함
SELECT *           -- 첫번째 쿼리 조회 컬럼 개수는 3 
  FROM dept d  
 UNION ALL
SELECT d.DEPTNO    -- 두번째 쿼리 조회 컬럼 개수는 2 
     , d.DNAME
  FROM dept d
 WHERE d.DEPTNO = 10
;
-- > ORA-01789: query block has incorrect number of result columns

SELECT d.DNAME     -- 문자형 데이터
     , d.DEPTNO    -- 숫자형 데이터
  FROM dept d  
 UNION ALL
SELECT d.DEPTNO    -- 숫자형 데이터  
     , d.DNAME     -- 문자형 데이터
  FROM dept d
 WHERE d.DEPTNO = 10
;
-- > ORA-01790: expression must have same datatype as corresponding expression

-- 서로 다른 테이블에서 조회한 결과를 집합연산 가능
-- 첫번째 쿼리 : emp 테이블에서 조회
SELECT e.EMPNO  -- 숫자
     , e.ENAME  -- 문자
     , e.JOB    -- 문자
  FROM emp e
;
-- 두번째 쿼리 : dept 테이블에서 조회
SELECT d.DEPTNO  -- 숫자
     , d.DNAME   -- 문자
     , d.LOC     -- 문자
  FROM dept d
;  

-- 서로 다른 테이블의 조회 내용을 UNION
SELECT e.EMPNO  -- 숫자
     , e.ENAME  -- 문자
     , e.JOB    -- 문자
  FROM emp e
 UNION
SELECT d.DEPTNO  -- 숫자
     , d.DNAME   -- 문자
     , d.LOC     -- 문자
  FROM dept d
;
/*
EMPNO     ENAME       JOB
-----------------------------
10	    ACCOUNTING	NEW YORK
20	    RESEARCH	DALLAS
30	    SALES	    CHICAGO
40	    OPERATIONS	BOSTON
7369	SMITH	    CLERK
7499	ALLEN	    SALESMAN
7521	WARD	    SALESMAN
7566	JONES	    MANAGER
7654	MARTIN	    SALESMAN
7698	BLAKE	    MANAGER
7777	J%JONES	    CLERK
7782	CLARK	    MANAGER
7839	KING	    PRESIDENT
7844	TURNER	    SALESMAN
7900	JAMES	    CLERK
7902	FORD	    ANALYST
7934	MILLER	    CLERK
8888	J	        CLERK
9999	J_JUNE	    CLERK
*/


-- 서로 다른 테이블의 조회 내용을 MINUS
SELECT e.EMPNO  -- 숫자
     , e.ENAME  -- 문자
     , e.JOB    -- 문자
  FROM emp e
 MINUS
SELECT d.DEPTNO  -- 숫자
     , d.DNAME   -- 문자
     , d.LOC     -- 문자
  FROM dept d
;
/*
EMPNO     ENAME       JOB
-----------------------------
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7777	J%JONES	CLERK
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
*/

-- 서로 다른 테이블의 조회 내용을 INTERSECT
SELECT e.EMPNO  -- 숫자
     , e.ENAME  -- 문자
     , e.JOB    -- 문자
  FROM emp e
 INTERSECT
SELECT d.DEPTNO  -- 숫자
     , d.DNAME   -- 문자
     , d.LOC     -- 문자
  FROM dept d
;
-- 조회 결과 없음
-- 인출된 모든 행 : 0
-- no rows selected


-- (6) 연산자 : 7. 연산자 우선순위

/*
    주어진 조건 3가지
    1. mgr = 7698
    2. job = 'CLERK'
    3. sal > 1300
*/

--- 1) 매니저가 7698 번이며, 직무는 CLERK 이거나
--     급여는 1300이 넘는 조건을 만족하는 직원의 정보를 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.MGR = 7698 
   AND e.JOB = 'CLERK'
    OR e.SAL > 1300
;
/*
EMPNO   ENAME     JOB       SAL      MGR
------------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7566	JONES	MANAGER	    2975	7839
7698	BLAKE	MANAGER 	2850	7839
7782	CLARK	MANAGER	    2450	7839
7839	KING	PRESIDENT	5000	
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950 	7698
7902	FORD	ANALYST	    3000	7566
*/


--- 2) 매니저가  7698 번인 직원중에서
--     직무가 CLERK 이거나 급여가 1300이 넘는 조건을 만족하는 직원 정보
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.MGR = 7698 
   AND (e.JOB = 'CLERK' OR e.SAL > 1300)
;
/*
EMPNO   ENAME     JOB       SAL      MGR
------------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
*/

--- 3) 직무가 CLERK 이거나 
--     급여가 1300이 넘으면서 매니저가 7698인 직원의 정보 조회

SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.JOB = 'CLERK'
    OR (e.SAL > 1300 AND e.MGR = 7698)
;
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , e.MGR
  FROM emp e
 WHERE e.JOB = 'CLERK'
    OR e.SAL > 1300 
    AND e.MGR = 7698
; -- > 괄호를 안써줘도 우선순위에 따라서 똑같이 실행된다.

/*
EMPNO   ENAME     JOB       SAL      MGR
------------------------------------------
7369	SMITH	CLERK	    800	    7902
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
7934	MILLER	CLERK	    1300	7782
9999	J_JUNE	CLERK	    500	
8888	J	    CLERK	    400	
7777	J%JONES	CLERK	    300	
*/