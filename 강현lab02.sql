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



/*===============================
            함수
================================*/


-- 실습 1)
SELECT INITCAP(e.ENAME) as "이름"
  FROM emp e
;
/*
이름
-----
Smith
Allen
Ward
Jones
Martin
Blake
Clark
King
Turner
James
Ford
Miller
J_June
J
J%Jones
*/


-- 실습 2)
SELECT LOWER(e.ENAME) as "이름"
  FROM emp e
;
/*
이름
-----
smith
allen
ward
jones
martin
blake
clark
king
turner
james
ford
miller
j_june
j
j%jones
*/


-- 실습 3)
SELECT UPPER(e.ENAME) as "이름"
  FROM emp e
;
/*
이름
-----
SMITH
ALLEN
WARD
JONES
MARTIN
BLAKE
CLARK
KING
TURNER
JAMES
FORD
MILLER
J_JUNE
J
J%JONES
*/


-- 실습 4)
SELECT LENGTH('korea') AS "LENGTH"
     , LENGTHB('korea') AS "LENGTHB"
  FROM dual
;
/*
LENGTH  LENGTHB
----------------
5	    5
*/


-- 실습 5)
SELECT LENGTH('강현') AS "LENGTH"
     , LENGTHB('강현') AS "LENGTHB"
  FROM dual
;
/*
LENGTH  LENGTHB
----------------
2	    6
*/


-- 실습 6)
SELECT CONCAT('SQL', '배우기') as result
  FROM dual
;
/*
RESULT
----------
SQL 배우기
*/


-- 실습 7)
SELECT SUBSTR('SQL 배우기', 5, 2) as result
  FROM dual
;
/*
RESULT
----------
배우
*/


-- 실습 8)
SELECT LPAD('SQL', 7, '$') as result
  FROM dual
;
/*
RESULT
----------
$$$$SQL
*/


-- 실습 9)
SELECT RPAD('SQL', 7, '$') as result
  FROM dual
;
/*
RESULT
----------
SQL$$$$
*/


-- 실습 10)
SELECT LTRIM('     SQL 배우기   ') as result
  FROM dual
;
/*
RESULT
----------
SQL 배우기   
*/


-- 실습 11)
SELECT RTRIM('     SQL 배우기   ') as result
  FROM dual
;
/*
RESULT
----------
     SQL 배우기   
*/


-- 실습 12)
SELECT TRIM('     SQL 배우기   ') as result
  FROM dual
;
/*
RESULT
----------
SQL 배우기   
*/


-- 실습 13)
SELECT NVL(e.COMM, 0) as "커미션"
  FROM emp e
;
/*
커미션
----------
0
300
500
0
1400
0
0
0
0
0
0
0
0
0
0 
*/


-- 실습 14)
SELECT NVL2(e.COMM, e.SAL + e.COMM, 0) as "급여 + 커미션"
  FROM emp e
;
/*
급여 + 커미션
----------
0
1900
1750
0
2650
0
0
0
1500
0
0
0
0
0
0
*/