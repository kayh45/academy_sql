-- 실습 16)
SELECT e.EMPNO as "사원번호"
     , e.ENAME as "이름"
     , e.SAL   as "급여"
     , TO_CHAR(CASE e.JOB 
                    WHEN 'CLERK'     THEN 300
                    WHEN 'SALESMAN'  THEN 450    
                    WHEN 'MANAGER'   THEN 600
                    WHEN 'ANALYST'   THEN 800
                    WHEN 'PRESIDENT' THEN 1000
                END, '$9999') as "자기 계발비"
  FROM emp e
;
/*
사원번호  이름   급여   자기 계발비
----------------------------------
7369	SMITH	800	      $300
7499	ALLEN	1600	  $450
7521	WARD	1250	  $450
7566	JONES	2975	  $600
7654	MARTIN	1250	  $450
7698	BLAKE	2850	  $600
7782	CLARK	2450	  $600
7839	KING	5000	 $1000
7844	TURNER	1500	  $450
7900	JAMES	950	      $300
7902	FORD	3000	  $800
7934	MILLER	1300	  $300
9999	J_JUNE	500	      $300
6666	JJ	    2800	
8888	J	    400	      $300
7777	J%JONES	300	      $300
*/



-- 실습 17)
SELECT e.EMPNO as "사원번호"
     , e.ENAME as "이름"
     , e.SAL   as "급여"
     , TO_CHAR(CASE WHEN e.JOB = 'CLERK'     THEN 300
                    WHEN e.JOB = 'SALESMAN'  THEN 450    
                    WHEN e.JOB = 'MANAGER'   THEN 600
                    WHEN e.JOB = 'ANALYST'   THEN 800
                    WHEN e.JOB = 'PRESIDENT' THEN 1000
                END, '$9999') as "자기 계발비"
  FROM emp e
;
/*
사원번호  이름   급여   자기 계발비
----------------------------------
7369	SMITH	800	      $300
7499	ALLEN	1600	  $450
7521	WARD	1250	  $450
7566	JONES	2975	  $600
7654	MARTIN	1250	  $450
7698	BLAKE	2850	  $600
7782	CLARK	2450	  $600
7839	KING	5000	 $1000
7844	TURNER	1500	  $450
7900	JAMES	950	      $300
7902	FORD	3000	  $800
7934	MILLER	1300	  $300
9999	J_JUNE	500	      $300
6666	JJ	    2800	
8888	J	    400	      $300
7777	J%JONES	300	      $300
*/

-- 실습 18)
SELECT COUNT(*) as "전체 행 개수"
  FROM emp e
;
/*
전체 행 개수
------------
16
*/


-- 실습 19)
SELECT COUNT(e.JOB) as "직책의 개수"
  FROM emp e
;
/*
직책의 개수
------------
15
*/


-- 실습 20)



-- 실습 23)
SELECT e.DEPTNO                         as "부서"
     , TO_CHAR(SUM(e.SAL), '$9,999.99') as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '$9,999.99') as "급여 평균"
     , TO_CHAR(MAX(e.SAL), '$9,999.99') as "최대 급여"
     , TO_CHAR(MIN(e.SAL), '$9,999.99') as "최소 급여"
  FROM emp e
 GROUP BY e.DEPTNO
HAVING e.DEPTNO = 20
;
/*
부서  급여 총합   급여 평균     최대 급여  최소 급여
--------------------------------------------------
20	 $6,775.00	 $2,258.33	 $3,000.00	   $800.00
*/
