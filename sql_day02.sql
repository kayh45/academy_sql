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

---------- 6. 함수
-- (2) dual 테이블 : 1행 1열로 구성된 시스템 테이블
DESC dual; --> 문자데이터 1칸으로 구성된 dummy 컬럼을 가진 테이블

-- dummy 컬럼에 X값이 하나 들어있음을 확인할 수 있다.
SELECT *
  FROM dual
;

-- dual 테이블을 사용하여 날짜 조회
SELECT sysdate
  FROM dual
;

  
-- (3) 단일행 함수
--- 1) 숫자함수 : 
---- 1. MOD(m,n) : m을 n으로 나눈 나머지 계산함수
SELECT mod(10, 3) as result
  FROM dual
;
SELECT mod(10, 3) as result
  FROM emp
;
SELECT mod(10, 3) as result
  FROM dept
;

-- 각 사원의 급여를 3으로 나눈 나머지를 조회
SELECT e.EMPNO
     , e.ENAME
     , MOD(e.SAL, 3) as result
  FROM emp e
;
/*
EMPNO   ENAME  RESULT
----------------------
7369	SMITH	2
7499	ALLEN	1
7521	WARD	2
7566	JONES	2
7654	MARTIN	2
7698	BLAKE	0
7782	CLARK	2
7839	KING	2
7844	TURNER	0
7900	JAMES	2
7902	FORD	0
7934	MILLER	1
9999	J_JUNE	2
8888	J	1
7777	J%JONES	0
*/

---- 2. ROUND(m,n) : 실수 m을 소수점 n + 1 자리에서 반올림 한 결과를 계산
SELECT ROUND(1234.56, 1) FROM dual; -- 1234.6
SELECT ROUND(1234.56, 0) FROM dual; -- 1235
SELECT ROUND(1234.46, 0) FROM dual; -- 1234
--     ROUND(m) : n값을 생략하면 소수점 이하 첫째자리 반올림 바로 수행
--                즉, n값을 0으로 수행함
SELECT ROUND(1234.56) FROM dual; -- 1235
SELECT ROUND(1234.46) FROM dual; -- 1234

---- 3. TRUNC(m, n) : 실수 m을 n에서 지정한 자리 이하 소수점 버림
SELECT TRUNC(1234.56, 1) FROM dual; -- 1234.5
SELECT TRUNC(1234.56, 0) FROM dual; -- 1234
SELECT TRUNC(1234.56) FROM dual; -- 1234

---- 4. CEIL(n) : 입력된 실수 n에서 같거나 가장 큰 가까운 정수
SELECT CEIL(1234.56) FROM dual; -- 1235
SELECT CEIL(1234) FROM dual; -- 1234
SELECT CEIL(1234.001) FROM dual; -- 1235

---- 5. FLOOR(n) : 입력된 실수 n에서 같거나 가장 가까운 작은 정수
SELECT FLOOR(1234.56) FROM dual; -- 1234
SELECT FLOOR(1234) FROM dual;    -- 1234
SELECT FLOOR(1235.56) FROM dual; -- 1235

---- 6. WIDTH_BUCKET(expr, min , max, buckets)
-- : min, max 값 사이를 buckets 개수만큼의 구간으로 나누고
--   expr이 출력하는 값이 어느 구간인지 위치를 숫자로 찾아줌

-- 급여 범위를 0 ~ 5000 으로 잡고, 5개의 구간으로 나누어서
-- 각 직원의 급여가 어느 구간에 해당하는지 보고서를 출력해보자.

SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , WIDTH_BUCKET(e.SAL, 0, 5000, 5) as "급여 구간"
  FROM emp e
 ORDER BY "급여 구간" DESC
;


--- 2) 문자 함수
---- 1. INITCAP(str) : str의 첫 글자를 대문자화 (영문인 경우)
SELECT INITCAP('the soap') FROM dual; -- The Soap

---- 2. LOWER(str) : str을 소문자화 (영문인 경우)
SELECT LOWER('MR. SCOTT MCMILLAN') "소문자로 변경" FROM dual;
---- 3. UPPER(str) : str을 대문자화 (영문인 경우)
SELECT UPPER('lee') "성을 대문자로 변경" FROM dual;
SELECT UPPER('sql is cooooooooooooooooool~!!') "씐나!" FROM dual;
---- 4. LENGTH(str), LENGTHB(str) : str의 글자길이를 계산
SELECT LENGTH('hello, sql') as "글자 길이" FROM dual;
SELECT 'hello, sql의 글자 길이는 ' || LENGTH('hello, sql') || '입니다.' as "글자 길이" FROM dual;

-- oracle에서 한글은 3byte으로 계산
SELECT LENGTHB('hello, sql') as "글자 byte" FROM dual;
SELECT LENGTHB('오라클') as "글자 byte" FROM dual;

---- 5. CONCAT(str1, str2) : str1, str2 문자열을 접합, || 연산자와 동일
SELECT CONCAT('안녕하세요, ', 'SQL') FROM dual;
SELECT '안녕하세요, ' || 'SQL' FROM dual;

---- 6. SUBSTR(str, i, n) : str에서 i번째 위치에서 n개의 글자를 추출
--      SQL에서 문자열 인덱스를 나타내는 i는 1부터 시작에 주의함!!!!!!!!!
SELECT SUBSTR('sql is cooooooooooooooooool~!!', 3, 4) FROM dual;
--     SUBSTR(str, i) : i 번째 위치에서 문자열 끝까지 추출
SELECT SUBSTR('sql is cooooooooooooooooool~!!', 3) FROM dual;


---- 7. INSTR(str1, str2) : 2번째 문자열이 1번째 문자열 어디에 위치하는가 등장하는 위치를 계산
SELECT INSTR('sql is cooooooooooooooooool~!!', 'is') FROM dual;
SELECT INSTR('sql is cooooooooooooooooool~!!', 'ia') FROM dual;
-- 2번째 문장이 등장하지 않으면 0으로 계산

---- 8. LPAD, RPAD(str, n, c)
--      : 입력된 str에 대해서, 전체 글자의 자릿수를 n으로 잡고
--        남는 공간에 왼쪽, 혹은 오른쪽으로 c의 문자를 채워넣는다.
SELECT LPAD('sql is cooool', 20, '!') FROM dual;
SELECT RPAD('sql is cooool', 25, '!') FROM dual;

---- 9. LTRIM, RTRIM, TRIM : 입력된 문자열의 왼쪽, 오른쪽, 양쪽 공백 제거
SELECT '>' || LTRIM('         sql is cool       ') || '<' FROM dual;
SELECT '>' || RTRIM('         sql is cool       ') || '<' FROM dual;
SELECT '>' || TRIM('         sql is cool       ') || '<' FROM dual;

---- 10. NVL(expr1, expr2), NVL2(expr1, expr2, expr3), NULLIF(expr1, expr2)
-- nvl(expr1, expr2) : 첫 번째 식의 값이 NULL이면 두 번째 식으로 대체하여 출력
-- mgr가 배정안된 직원의 경우 '매니저 없음'으로 변경해서 출력
SELECT e.EMPNO
     , e.ENAME
     , NVL(e.MGR, '매니저 없음')  -- mgr 숫자 데이터, 변경 출력이 문자, 타입 불일치로 실행이 안됨
  FROM emp e
;
---------------
SELECT e.EMPNO
     , e.ENAME
     , NVL(e.MGR, 0)  
  FROM emp e
;
---------------
SELECT e.EMPNO
     , e.ENAME
     , NVL(e.MGR || '', '매니저 없음') 
     -- || 결합연산자로 '' 빈문자를 붙여서 형 변환 
  FROM emp e
;

--nvl2(expr1, expr2, expr3) : 첫 번째 식의 값이 NOT NULL이면 두 번째 식의 값으로 대체하여 출력하고
--                                             NULL이면 세 번째 식의 값으로 대체하여 출력

SELECT e.EMPNO
     , e.ENAME
     , NVL2(e.MGR,'매니저 있음' , '매니저 없음') 
  FROM emp e
;

--nullif(expr1, expr2) : 첫 번째 식, 두 번째 식의 값이 동일하면 NULL을 출력
--                                          식이 다르면 첫 번째 식의 값을 출력

SELECT NULLIF('AAA', 'bbb') 
  FROM dual
;  

SELECT NULLIF('AAA', 'AAA') 
  FROM dual
;  
-- 조회된 결과 1행이 NULL인 결과를 얻게 됨
-- 1행이라도 NULL이 조회된 결과는 인출된 모든 행 :0 과는 상태가 다름!

--- 3) 날짜함수 : 날짜 출력 패턴 조합으로 다양하게 출력 가능

-- TO_CAHR() : 숫자나 날짜를 문자형으로 변환
SELECT sysdate FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY') FROM dual;
SELECT TO_CHAR(sysdate, 'YY') FROM dual;
SELECT TO_CHAR(sysdate, 'MM') FROM dual;
SELECT TO_CHAR(sysdate, 'MONTH') FROM dual;
SELECT TO_CHAR(sysdate, 'MON') FROM dual;
SELECT TO_CHAR(sysdate, 'DD') FROM dual;
SELECT TO_CHAR(sysdate, 'D') FROM dual;
SELECT TO_CHAR(sysdate, 'DAY') FROM dual;
SELECT TO_CHAR(sysdate, 'DY') FROM dual;

-- 패턴을 조합
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD') FROM dual;
SELECT TO_CHAR(sysdate, 'FMYYYY-MM-DD') FROM dual;
SELECT TO_CHAR(sysdate, 'YY-MONTH-DD') FROM dual;
SELECT TO_CHAR(sysdate, 'YY-MONTH-DD DAY') FROM dual;
SELECT TO_CHAR(sysdate, 'YY-MONTH-DD DY') FROM dual;

/* 시간 패턴 :  
    HH : 시간을 두 자리로 표기
    MI : 분을 두 자리로 표기
    SS : 초를 두 자리로 표기
    HH24 : 시간을 24시간 체계로 표기
    AM : 오전인지 오후인지 표기
*/

SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD AM HH:MI:SS') FROM dual;

-- 날짜 값과 숫자의 연산 : + - 연산 가능
-- 10일 후
SELECT sysdate + 10 FROM dual;
-- 10일 전
SELECT sysdate - 10 FROM dual;
-- 10시간 후
SELECT TO_CHAR(sysdate + (10/24), 'YYYY-MM-DD AM HH:MI:SS') FROM dual;

---- 1. MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜 사이의 달의 차이
SELECT MONTHS_BETWEEN(sysdate, e.HIREDATE)
  FROM emp e;

---- 2. ADD_MONTHS(날짜1, 숫자) : 날짜 1에 숫자만큼 더한 후의 날짜를 구함
SELECT ADD_MONTHS(sysdate, 3) FROM dual;

---- 3. NEXT_DAY, LAST_DAY : 다음 요일에 해당하는 날짜를 구함, 이 달의 마지막 날짜
SELECT NEXT_DAY(sysdate, '일요일') FROM dual;
SELECT NEXT_DAY(sysdate, 1) FROM dual;
SELECT LAST_DAY(sysdate) FROM dual;

---- 4. ROUND, TRUNC : 날짜 관련 반올림 , 버림
SELECT ROUND(sysdate) FROM dual;
SELECT TO_CHAR(ROUND(sysdate), 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TRUNC(sysdate) FROM duaL;
SELECT TO_CHAR(TRUNC(sysdate), 'YYYY-MM-DD HH24:MI:SS') FROM duaL;


--- 4) 데이터 타입 변환 함수
/*
    TO_CHAR()   : 숫자, 날짜                ===> 문자
    TO_DATE()   : 날짜 형식의 문자           ===> 날짜
    TO_NUMBER() : 숫자로만 구성된 문자 데이터 ===> 숫자
*/

---- 1. TO_CHAR() : 숫자패턴 적용
--      숫자 패턴 : 9 ==> 한 자리 숫자
SELECT TO_CHAR(12345, '9999') FROM dual;
SELECT TO_CHAR(12345, '99999') FROM dual;

SELECT TO_CHAR(12345, '9999999') data
  FROM dual
;
-- 앞에 빈칸을 0으로 채우기
SELECT TO_CHAR(12345, '0999999') data
  FROM dual
;
-- 소수점 이하 표현
SELECT TO_CHAR(12345, '999999.99') data
  FROM dual
;
-- 숫자 패턴에서 3자리씩 끊어 읽기 + 소수점 이하 표현
SELECT TO_CHAR(12345, '9,999,999,999') data
  FROM dual
;

---- 2. TO_DATE() : 날자 패턴에 맞는 문자 값을 날짜 데이터로 변경
SELECT TO_DATE('2018-06-27', 'YYYY-MM-DD') AS TODAY FROM dual;

