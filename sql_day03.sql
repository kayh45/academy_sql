-- (3) 단일행 함수
--- 6) CASE
-- job 별로 경조사비를 급여대비 일정 비율로 지급하고 있다.
-- 각 직원들의 경조사비 지원금을 구하자
/*
    CLERK       : 5%
    SALESMAN    : 4%
    MANAGER     : 3.7%
    ANALYST     : 3%
    PRESIDENT   : 1.5%
*/

-- 1. Simple CASE 구문으로 구해보자 : DECODE와 거의 유사, 동일비교만 가능
--                                   괄호가 없고, 콤마 대신 키워드 WHEN, THEN, ELSE 등을 사용
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE e.JOB WHEN 'CLERK'     THEN e.SAL * 0.05
                  WHEN 'SALESMAN'  THEN e.SAL * 0.04
                  WHEN 'MANAGER'   THEN e.SAL * 0.037
                  WHEN 'ANALYST'   THEN e.SAL * 0.03
                  WHEN 'PRESIDENT' THEN e.SAL * 0.015        
       END as "경조사 지원금"
  FROM emp e
;

-- 2. Searched CASE 구문으로 구해보자
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE WHEN e.JOB = 'CLERK'       THEN e.SAL * 0.05
            WHEN e.JOB = 'SALESMAN'    THEN e.SAL * 0.04
            WHEN e.JOB = 'MANAGER'     THEN e.SAL * 0.037
            WHEN e.JOB = 'ANALYST'     THEN e.SAL * 0.03
            WHEN e.JOB = 'PRESIDENT'   THEN e.SAL * 0.015
            ELSE 10
       END as "경조사 지원금"
  FROM emp e
;
-- CASE 결과에 숫자 통화 패턴 씌우기 : $ 기호, 숫자 세 자리 끊어읽기, 소수점 둘째자리까지
SELECT e.EMPNO
     , e.ENAME
     , nvl(e.JOB, '미지정') as job
     , TO_CHAR(CASE WHEN e.JOB = 'CLERK'       THEN e.SAL * 0.05
                    WHEN e.JOB = 'SALESMAN'    THEN e.SAL * 0.04
                    WHEN e.JOB = 'MANAGER'     THEN e.SAL * 0.037
                    WHEN e.JOB = 'ANALYST'     THEN e.SAL * 0.03
                    WHEN e.JOB = 'PRESIDENT'   THEN e.SAL * 0.015
               ELSE 10
       END, '$9,999.99') as "경조사 지원금"
  FROM emp e
;

/* SALGRADE 테이블의 내용 : 이 회사의 급여 등급 기준 값
---------------------
GRADE   LOSAL   HISAL
---------------------
1	    700 	1200
2	    1201	1400
3   	1401	2000
4	    2001	3000
5	    3001	9999
*/

-- 제공되는 급여 등급을 바탕으로 각 사원들의 급여 등급을 구해보자
-- CASE를 사용하여

SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL >= 700  AND e.SAL <= 1200 THEN 1
            WHEN e.SAL >= 1201 AND e.SAL <= 1400 THEN 2
            WHEN e.SAL >= 1401 AND e.SAL <= 2000 THEN 3
            WHEN e.SAL >= 2001 AND e.SAL <= 3000 THEN 4
            WHEN e.SAL >= 3001 AND e.SAL <= 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

-- WHEN 안의 구분을 BETWEEN 으로 변경하여 작성

SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL BETWEEN 700   AND 1200 THEN 1
            WHEN e.SAL BETWEEN 1201  AND 1400 THEN 2
            WHEN e.SAL BETWEEN 1401  AND 2000 THEN 3
            WHEN e.SAL BETWEEN 2001  AND 3000 THEN 4
            WHEN e.SAL BETWEEN 3001  AND 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

-------- 2. 그룹함수 (복수행함수)
-- 1) COUNT(*) : 특정 테이블의 행의 개수(데이터의 개수)를 세어주는 함수
--               NULL을 처리하는 <유일한> 그룹함수
--    COUNT(expr) : expr으로 등장한 값을 NULL 제외하고 세어주는 함수

-- dept, salgrade 테이블의 전체 데이터 개수 조회
SELECT COUNT(*) as "부서 개수"
  FROM dept d
;
SELECT COUNT(*) as "급여등급 개수"
  FROM SALGRADE s
;


--- emp 테이블에서  job 컬럼의 데이터 개수를 카운드

SELECT COUNT(e.JOB) as "직무 개수"
  FROM emp e
; --> 15 (JOB컬럼의 NULL 값은 제외하고 카운트)
SELECT COUNT(*) as "직무 개수"
  FROM emp e
; --> 16

/*
EMPNO   ENAME    JOB
------------------------
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
9999	J_JUNE	CLERK
6666	JJ	    (null)    === > COUNT(e.JOB)에서 걸러짐
8888	J	    CLERK
7777	J%JONES	CLERK
*/

-- 회사에 매니저가 배정된 직원이 몇 명인가
SELECT COUNT(e.MGR) as "상사가 있는 직원 수"
  FROM emp e
;

-- 매니저 직을 맡고 있는 직원이 몇 명인가
--- 1. mgr 컬럼을 중복제거하여 조회
SELECT DISTINCT e.MGR
  FROM emp e
;
--- 2. 그 때의 결과를 카운트
SELECT COUNT(DISTINCT e.MGR) as "매니저인 직원 수"
  FROM emp e
;


-- 부서가 배정된 직원이 몇 명이나 있는가?
SELECT COUNT(e.DEPTNO) as "부서 배정 인원"
  FROM emp e
;
-- COUNT(*)가 아닌 COUNT(expr)를 사용한 경우에는
SELECT e.DEPTNO
  FROM emp e
 WHERE e.DEPTNO IS NOT NULL
;
-- 을 수행한 결과를 카운트 한 것으로 생각할 수 있다

SELECT COUNT(*) as "전체 인원"
     , COUNT(e.DEPTNO) as "부서 배정 인원"
     , COUNT(*) - COUNT(e.DEPTNO) as "부서 미배정 인원"
  FROM emp e
;

-- 2) SUM() : NULL 항목 제외하고
--            합산 가능한 행을 모두 더한 결과를 출력

-- SALESMAN 들의 수당 총합을 구해보자
SELECT SUM(e.COMM) as "SALESMAN들의 수당 총합"
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;
/*
(null)
300     ===>
500     ===>
(null)
1400    ===>  SUM(e.COMM) ====> 2200 : comm 컬럼이 NULL인 것들은 합산에서 제외    
(null)
(null)
(null)
0       ===>
(null)
(null)
(null)
(null)
(null)
(null)
(null)
*/

-- 수당 총합 계산 결과에 숫자 출력 패턴 주고 별칭
SELECT TO_CHAR(SUM(e.COMM), '$9,999') as "SALESMAN들의 수당 총합"
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;


-- 3) AVG(expr) : NULL값 제외하고 연산 가능한 항목의 산술 평균을 구함

-- 수당 평균을 구해보자
SELECT AVG(e.COMM) as "수당 평균"
  FROM emp e
;
SELECT TO_CHAR(AVG(e.COMM), '$9,999') as "수당 평균"
  FROM emp e
;

-- 4) MAX(expr) : expr에 등장한 값 중에서 최댓값을 구함
--                expr이 문자인 경우 알파벳 순 뒷쪽에 위치한 글자를 최댓값으로 계산

-- 이름이 가장 나중인 직원
SELECT MAX(e.ENAME)
  FROM emp e
;

---------- 3. GROUP BY 절의 사용
-- 1) emp 테이블에서 각 부서별로 급여의 총합을 조회
--      총합을 구하기 위하여 SUM()을 사용
--      그룹화 기준을 부서번호(deptno)를 사용
--      그룹화 기준으로 잡은 부서번호가 GROUP BY 절에 등장해야함

SELECT e.DEPTNO   as "부서"
     , SUM(e.SAL) as "급여 총합"
  FROM emp e
 GROUP BY e.DEPTNO
;

SELECT e.DEPTNO   as "부서"
     , SUM(e.SAL) as "급여 총합"
  FROM emp e
 GROUP BY e.DEPTNO
HAVING e.DEPTNO IS NOT NULL
;

SELECT d.DNAME       as "부서명"
     , MAX(e.DEPTNO) as "부서번호"
     , SUM(e.SAL)    as "급여 총합"
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO
 GROUP BY d.DNAME
;

SELECT d.DNAME       as "부서명"
     , MAX(e.DEPTNO) as "부서번호"
     , SUM(e.SAL)    as "급여 총합"
  FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO
 GROUP BY d.DNAME
;

-- 부서별 급여의 총합, 평균, 최대급여, 최소급여
SELECT SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
;
-- 위의 쿼리는 수행되지만 정확하게 어느 부서의 결과인지 알수가 없다는 단점이 존재
/* -----------------------------------------------------------------------------
  GROUP BY 절에 등장하는 그룹화 기준 컬럼은 반드시 SELCET 절에 똑같이 등장해야 한다.
  
  하지만 위의 쿼리가 실행되는 이유는 
  SELECT 절에 나열된 컬럼 중에서 그룹함수가 사용되지 않은 컬럼이 없기 때문!!
  즉, 모두다 그룹함수가 사용된 컬럼들이기 때문
--------------------------------------------------------------------------------*/
SELECT e.DEPTNO   as "부서 번호"
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;

SELECT d.DNAME as "부서"
     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO
 GROUP BY d.DNAME
;


-- 부서별, 직무별 급여의 총합, 평균, 최대, 최소 급여를 구해보자
SELECT e.DEPTNO   as "부서 번호"
     , e.JOB      as "직무"
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO, e.JOB
 ORDER BY e.DEPTNO, e.JOB
;

-- 오류 코드
SELECT e.DEPTNO   as "부서 번호"
     , e.JOB      as "직무"     -- SELECT에는 등장
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO              -- GROUP BY에는 누락된 컬럼 
 ORDER BY e.DEPTNO, e.JOB
; --- ORA-00979: not a GROUP BY expression
-- 그룹 함수가 적용되지 않았고 GROUP BY 절에도 등장하지 않은 JOB 컬럼이
-- SELECT 절에 있기 때문에 오류 발생

-- 오류 코드 2
SELECT e.DEPTNO   as "부서 번호"
     , e.JOB      as "직무"     -- SELECT에는 등장
     , SUM(e.SAL) as "급여 총합"
     , AVG(e.SAL) as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
-- GROUP BY 자체가 누락 
; --- ORA-00937: not a single-group group function
-- GROUP 함수가 적용되지 않은 컬럼들이 SELECT에 등장하면
-- 그룹화 기준으로 가정되어야 함
-- 그룹화 기준으로 사용되는 GROUP BY 절 자체가 누락


-- job 별 급여의 총합, 평균, 최대, 최소를 구해보자

-- 부서 미배정인 사원 '미배정'이라고 해주기
SELECT nvl(e.DEPTNO || '', '미배정')    as "부서 번호"
     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;

SELECT DECODE(nvl(e.DEPTNO, 0)
            , e.DEPTNO, e.DEPTNO || ''
            , 0, '미배정')              as "부서 번호"
     , TO_CHAR(SUM(e.SAL), '$9,999.00') as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.00') as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.00') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.00') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY e.DEPTNO
;


----- 4. HAVING 절의 사용
-- GROUP BY 결과에 조건을 걸어서
-- 결과를 제한(필터링) 할 목적으로 사용되는 절

-- 문제) 무서별 급여 평균이 2000 이상인 부서
--- a) 우선 부서별 급여 평균을 구한다
SELECT e.DEPTNO
     , AVG(e.SAL)
  FROM emp e
 GROUP BY e.DEPTNO
;
--- b) a의 결과에서 2000 이상인 부서만 남긴다
SELECT e.DEPTNO   as "부서 번호"
     , AVG(e.SAL) as "급여 평균"
  FROM emp e
 GROUP BY e.DEPTNO
HAVING AVG(e.SAL) >= 2000
;

-- HAVING 절을 사용하여 조건을 걸 때 주의 점 : 별칭을 사용할 수 없음
SELECT e.DEPTNO   as "부서 번호"
     , AVG(e.SAL) as "급여 평균"
  FROM emp e
 GROUP BY e.DEPTNO
HAVING "급여 평균" >= 2000
;
-- 오류코드 : HAVING의 조건에 별칭을 사용하였기 때문

--HAVING 절이 존재하는 경우 SELECT의 구문의 실행 순서 정리

/*
  1. FROM 절의 테이블 각 행을 대상으로
  2. WHERE 절의 조건에 맞는 행만 선택하고
  3. GROUP BY 절에 나온 컬럼, 식(함수 식 등)으로 그룹화를 진행
  4. HAVING 절의 조건을 만족시키는 그룹행만 선택
  5. 4까지 선택된 그룹 정보를 가진 행에 대해서
     SELECT절에 명시된 컬럼, 식(함수 식 등)만 출력
  6. ORDER BY가 있다면 정렬조건에 맞추어 최종 정렬하여 보여 준다.
*/


-----------------------------------------------------------------------------
-- 수업중 실습

-- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬
SELECT e.MGR    as "매니저 사원번호"
     , COUNT(*) as "부하직원의 수"
  FROM emp e
 GROUP BY e.MGR
HAVING e.MGR IS NOT NULL
 ORDER BY "부하직원의 수" DESC
;
-- 2. 부서별 인원을 구하고, 인원수 많은 순으로 정렬
SELECT e.DEPTNO as "부서 번호"
     , COUNT(*) as "직원 수"
  FROM emp e
 GROUP BY e.DEPTNO
HAVING e.DEPTNO IS NOT NULL
 ORDER BY "직원 수" DESC
;
-- 3. 직무별 급여 평균 구하고, 급여 평균 높은 순으로 정렬
SELECT e.JOB      as "직무"
     , TO_CHAR(AVG(e.SAL), '$9,999') as "급여 평균"
  FROM emp e
 GROUP BY e.JOB
HAVING e.JOB IS NOT NULL
 ORDER BY "급여 평균" DESC
;
-- 4. 직무별 급여 총합을 구하고, 총합 높은 순으로 정렬
SELECT e.JOB      as "직무"
     , TO_CHAR(SUM(e.SAL), '$9,999') as "급여 총합"
  FROM emp e
 GROUP BY e.JOB
HAVING e.JOB IS NOT NULL
 ORDER BY "급여 총합" DESC 
;  
-- 5. 급여의 앞 단위가 1000미만, 1000, 2000, 3000, 5000 별로 인원수를 구하시오
--    이때 급여 단위 오름차순으로 정렬
SELECT TRUNC(e.SAL, -3)   as "급여 단위"
     , COUNT(*)           as "인원수"
  FROM emp e
 GROUP BY TRUNC(e.SAL, -3)
 ORDER BY "급여 단위"
;
------ 급여 단위가 1000미만인 경우 0으로 출력되는 것을 변경
--     : 범위 연산이 필요해 보임 === > CASE 구문 선택
SELECT CASE WHEN TRUNC(e.SAL, -3) < 1000 THEN '1000 미만'        
            ELSE TRUNC(e.SAL, -3)||''
        END as "급여 단위"
     , COUNT(TRUNC(e.SAL, -3)) as "인원수"
  FROM emp e
 GROUP BY TRUNC(e.SAL, -3)
 ORDER BY TRUNC(e.SAL, -3)
;
----- 다른 함수로 풀이
-- a) sal 컬럼에 왼쪽으로 패딩을 붙여서 0을 채움
SELECT e.EMPNO
     , e.ENAME
     , LPAD(e.SAL, 4, '0')
  FROM emp e
;
-- b) 맨 앞의 글자를 잘라낸다.
SELECT e.EMPNO
     , e.ENAME
     , SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
  FROM emp e
;
-- c) 1000단위로 처리 + COUNT + 그룹화
SELECT SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1) "급여 단위"
     , COUNT(*) "인원(명)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
;
-- d) 1000단위로 출력 형태 변경
SELECT CASE WHEN SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1) = 0 THEN '1000 미만'
            ELSE TO_CHAR(SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)  * 1000)
        END     "급여 단위"
     , COUNT(*) "인원(명)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
;
-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬
SELECT NVL(e.JOB, '미배정')        as "직무"
     , TRUNC(SUM(e.SAL), -3) as "급여 합의 단위"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY "급여 합의 단위" DESC
;
-- 7. 직무별 급여 평균이 2000 이하인 경우를 구하고 평균이 높은 순으로 정렬
SELECT e.JOB      as "직무"
     , AVG(e.SAL) as "직무별 급여 평균"
  FROM emp e
 GROUP BY e.JOB
HAVING AVG(e.SAL) <= 2000
 ORDER BY "직무별 급여 평균" DESC
;
-- 8. 년도별 입사 인원을 구하시오
SELECT TO_CHAR(e.HIREDATE, 'YYYY')   as "입사 년도"
     , COUNT(*)                      as "입사 인원"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY')
 ORDER BY "입사 년도"
;
-- 9. 년도별 월별 입사 인원을 구하시오
SELECT TO_CHAR(e.HIREDATE, 'YYYY-MM')   as "입사 년월"
     , COUNT(*)                         as "입사 인원"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY-MM')
 ORDER BY "입사 년월"
;

SELECT TO_CHAR(e.HIREDATE, 'YYYY')      as "입사 년도"
     , TO_CHAR(e.HIREDATE, 'MM')        as "입사 월"
     , COUNT(*) 
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY'), TO_CHAR(e.HIREDATE, 'MM')
 ORDER BY "입사 년도", "입사 월"
;

SELECT TO_CHAR(e.HIREDATE, 'YYYY')      as "입사 년도"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '01', 1)),0) as "1월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '02', 1)),0) as "2월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '03', 1)),0) as "3월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '04', 1)),0) as "4월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '05', 1)),0) as "5월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '06', 1)),0) as "6월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '07', 1)),0) as "7월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '08', 1)),0) as "8월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '09', 1)),0) as "9월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '10', 1)),0) as "10월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '11', 1)),0) as "11월"
     , NVL(SUM(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '12', 1)),0) as "12월"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY')
 ORDER BY "입사 년도"
;

SELECT TO_CHAR(e.HIREDATE, 'YYYY')      as "입사 년도"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '01', 1)) as "1월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '02', 1)) as "2월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '03', 1)) as "3월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '04', 1)) as "4월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '05', 1)) as "5월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '06', 1)) as "6월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '07', 1)) as "7월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '08', 1)) as "8월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '09', 1)) as "9월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '10', 1)) as "10월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '11', 1)) as "11월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '12', 1)) as "12월"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY')
 ORDER BY "입사 년도"
;

SELECT TO_CHAR(e.HIREDATE, 'YYYY')      as "입사 년도"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '01', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '01', 1))) as "1월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '02', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '05', 1))) as "2월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '03', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '03', 1))) as "3월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '04', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '04', 1))) as "4월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '05', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '05', 1))) as "5월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '06', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '06', 1))) as "6월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '07', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '07', 1))) as "7월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '08', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '08', 1))) as "8월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '09', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '09', 1))) as "9월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '10', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '10', 1))) as "10월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '11', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '11', 1))) as "11월"
     , DECODE(COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '12', 1))
            , 0, '-'
            , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '12', 1))) as "12월"
  FROM emp e
 GROUP BY TO_CHAR(e.HIREDATE, 'YYYY')
 ORDER BY "입사 년도"
;

-- 월별 총 입사 인원의 합을 가로로 출력
SELECT '인원(명)' as "입사 월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '01', 1)) as "1월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '02', 1)) as "2월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '03', 1)) as "3월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '04', 1)) as "4월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '05', 1)) as "5월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '06', 1)) as "6월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '07', 1)) as "7월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '08', 1)) as "8월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '09', 1)) as "9월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '10', 1)) as "10월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '11', 1)) as "11월"
     , COUNT(DECODE(TO_CHAR(e.HIREDATE, 'MM'), '12', 1)) as "12월"
  FROM emp e
;

-------------------------- 7. 조인과 서브쿼리
-- (1) 조인 : JOIN
----2)
-- 하나 이상의 테이블을 논리적으로 묶어서 하나의 테이블인 것 처럼 다루는 기술
-- FROM 절에 조인에 사용할 테이블 이름을 나열

-- 문제) 직원의 부서번호가 아닌 소속 부서명을 알고 싶다.
SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
 WHERE e.DEPTNO = d.DEPTNO -- 오라클의 전통적인 조인 조건 작성 기법
 ORDER BY d.DEPTNO
;
SELECT e.ENAME
     , d.DNAME
  FROM emp e
  JOIN dept d
    ON e.DEPTNO = d.DEPTNO -- 최근 다른 DBMS들이 사용하고 있는 기법을 오라클에서 지원함
;

-- 문제) 위의 결과에서 ACCOUNTING 부서의 직원만 알고싶다.
--       조인 조건과 일반 조건이 같이 사용될 수 있다.
SELECT e.ENAME
     , d.DNAME
  FROM emp e
     , dept d
 WHERE e.DEPTNO = d.DEPTNO    -- 조인 조건
   AND d.DNAME = 'ACCOUNTING' -- 일반 조건
;

---- 2) 조인 : 카티션 곱 
--             조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것
--             조인 조건 누락 시 발생
--             9i버전 이후 CROSS JOIN 키워드 지원

SELECT e.ENAME 
     , d.DNAME
     , s.GRADE
  FROM emp e CROSS JOIN dept d
             CROSS JOIN salgrade s
;
-- emp 16 x dept 4 x salgrade 5 = 320행 발생


---- 3) EQUI JOIN : 조인의 가장 기본
------- 1. 오라클의 전통적인 WHERE에 조인 조건을 걸어주는 방법
SELECT e.ENAME
     , d.DNAME
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO
 ORDER BY d.DEPTNO
;

-------- 2. NATURAL JOIN 키워드로 자동조인
SELECT e.ENAME
     , d.DNAME
  FROM emp e NATURAL JOIN dept d
;

-------- 3. JOIN ~ USING 키워드로 조인
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d USING (deptno)
;

-------- 4. JOIN ~ ON 키워드로 조인
SELECT e.ENAME
     , d.DNAME
  FROM emp e JOIN dept d ON (e.DEPTNO = d.DEPTNO)
;


-- (2) 서브쿼리