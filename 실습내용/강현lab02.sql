-- 실습 23)
SELECT *
  FROM emp e
 WHERE e.SAL BETWEEN 2500 AND 3000
;
/*
EMPNO   ENAME      JOB      MGR     HIREDATE    SAL    COMM   DEPTNO
---------------------------------------------------------------------
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
*/


-- 실습 24)
SELECT *
  FROM emp e
 WHERE e.COMM IS NULL
;
/*
EMPNO   ENAME      JOB      MGR     HIREDATE    SAL    COMM   DEPTNO
---------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7698	BLAKE	MANAGER	    7839	81/05/01	2850	    	30
7782	CLARK	MANAGER	    7839	81/06/09	2450	    	10
7839	KING	PRESIDENT		    81/11/17	5000	    	10
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
*/


-- 실습 25)
SELECT *
  FROM emp e
 WHERE e.COMM IS NOT NULL
;
/*
EMPNO   ENAME      JOB      MGR     HIREDATE    SAL    COMM   DEPTNO
---------------------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
*/


-- 실습 26)
SELECT e.EMPNO AS 사번
     , e.ENAME || '의 월급은 ' || e.SAL || '입니다.' AS 월급여
  FROM emp e
;
/*
사번            월급여
--------------------------------
7369	SMITH의 월급은 800입니다.
7499	ALLEN의 월급은 1600입니다.
7521	WARD의 월급은 1250입니다.
7566	JONES의 월급은 2975입니다.
7654	MARTIN의 월급은 1250입니다.
7698	BLAKE의 월급은 2850입니다.
7782	CLARK의 월급은 2450입니다.
7839	KING의 월급은 5000입니다.
7844	TURNER의 월급은 1500입니다.
7900	JAMES의 월급은 950입니다.
7902	FORD의 월급은 3000입니다.
7934	MILLER의 월급은 1300입니다.
*/
