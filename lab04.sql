-- 실습 3)
SELECT e1.EMPNO as "직원 사번"
     , e1.ENAME as "직원 이름"
     , e1.MGR   as "상사 사번"
     , e2.ENAME as "상사 이름"
  FROM emp e1
     , emp e2
 WHERE e1.MGR = e2.EMPNO(+)
;
/*
직원 사번|직원 이름|상사 사번|상사 이름
-------------------------------------
7902	FORD	7566	JONES
7900	JAMES	7698	BLAKE
7844	TURNER	7698	BLAKE
7654	MARTIN	7698	BLAKE
7521	WARD	7698	BLAKE
7499	ALLEN	7698	BLAKE
7934	MILLER	7782	CLARK
7782	CLARK	7839	KING
7698	BLAKE	7839	KING
7566	JONES	7839	KING
7369	SMITH	7902	FORD
7777	J%JONES		
8888	J		
6666	JJ		
9999	J_JUNE		
7839	KING		
*/


-- 실습 4)
SELECT e1.EMPNO as "직원 사번"
     , e1.ENAME as "직원 이름"
     , e1.MGR   as "상사 사번"
     , e2.ENAME as "상사 이름"
  FROM emp e1
     , emp e2
 WHERE e1.MGR(+) = e2.EMPNO
;
/*
직원 사번|직원 이름|상사 사번|상사 이름
-------------------------------------
7369	SMITH	7902	FORD
7499	ALLEN	7698	BLAKE
7521	WARD	7698	BLAKE
7566	JONES	7839	KING
7654	MARTIN	7698	BLAKE
7698	BLAKE	7839	KING
7782	CLARK	7839	KING
7844	TURNER	7698	BLAKE
7900	JAMES	7698	BLAKE
7902	FORD	7566	JONES
7934	MILLER	7782	CLARK
                        J
                        TURNER
                        J%JONES
                        WARD
                        MARTIN
                        JJ
                        ALLEN
                        MILLER
                        J_JUNE
                        SMITH
                        JAMES
*/

-- 실습 5)
SELECT e.ENAME
     , e.JOB
  FROM emp e
 WHERE e.JOB = (SELECT e.JOB
                  FROM emp e
                 WHERE e.ENAME = 'JAMES')
;  
/*
 ENAME   JOB
-------------
SMITH	CLERK
JAMES	CLERK
MILLER	CLERK
J_JUNE	CLERK
J	    CLERK
J%JONES	CLERK
*/


-- 실습 6) emp 테이블에서 모든 직원 대상으로 사번, 이름, 상사이름을 출력
SELECT e1.EMPNO "사번"
     , e1.ENAME "이름"
     , NVL((SELECT e.ENAME
              FROM emp e
             WHERE e.EMPNO = e1.MGR), '-') as "상사이름"
  FROM emp e1
 ORDER BY "사번"
;
/*
사번 | 이름 | 상사이름
---------------------
6666	JJ	     -
7369	SMITH	FORD
7499	ALLEN	BLAKE
7521	WARD	BLAKE
7566	JONES	KING
7654	MARTIN	BLAKE
7698	BLAKE	KING
7777	J%JONES	 -
7782	CLARK	KING
7839	KING	 -
7844	TURNER	BLAKE
7900	JAMES	BLAKE
7902	FORD	JONES
7934	MILLER	CLARK
8888	J	     -
9999	J_JUNE	 -
*/


-- 실습 7) emp테이블에서 모든 직원 대상으로 사번, 이름, 직무, 급여, 부서명, 부서 위치를 출력 (서브쿼리만 이용 조인 X)
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , (SELECT d.DNAME
          FROM dept d
         WHERE e.DEPTNO = d.DEPTNO) as dname
     , (SELECT d.LOC
          FROM dept d
         WHERE e.DEPTNO = d.DEPTNO) as loc
  FROM emp e
;
/*
EMPNO   ENAME    JOB        SAL     DNAME        LOC
-------------------------------------------------------
7369	SMITH	CLERK	    800	    RESEARCH	DALLAS
7499	ALLEN	SALESMAN	1600	SALES	    CHICAGO
7521	WARD	SALESMAN	1250	SALES	    CHICAGO
7566	JONES	MANAGER	    2975	RESEARCH	DALLAS
7654	MARTIN	SALESMAN	1250	SALES	    CHICAGO
7698	BLAKE	MANAGER	    2850	SALES	    CHICAGO
7782	CLARK	MANAGER	    2450	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT	5000	ACCOUNTING	NEW YORK
7844	TURNER	SALESMAN	1500	SALES	    CHICAGO
7900	JAMES	CLERK	    950	    SALES	    CHICAGO
7902	FORD	ANALYST	    3000	RESEARCH	DALLAS
7934	MILLER	CLERK	    1300	ACCOUNTING	NEW YORK
9999	J_JUNE	CLERK	    500		
6666	JJ		            2800		
8888	J	    CLERK	    400		
7777	J%JONES	CLERK	    300		
*/


-----------------------------------------------------------------


-- 실습 1)
DROP TABLE customer;
CREATE TABLE customer
(  userid       VARCHAR2(4)
 , name         VARCHAR2(30)    NOT NULL
 , birthyear    NUMBER(4)            
 , regdate      DATE            DEFAULT(SYSDATE)
 , address      VARCHAR2(30)
 , CONSTRAINT pk_customer PRIMARY KEY (userid)
);
/*
Table CUSTOMER이(가) 생성되었습니다.
*/

-- 실습 2)
DESC customer;
/*
이름        널?       유형            
--------- -------- ------------- 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(20)  
BIRTHYEAR          NUMBER(4)          
REGDATE            DATE          
ADDRESS            VARCHAR2(30) 
*/

-- 실습 3)
CREATE TABLE new_cust
AS
SELECT *
  FROM customer
 WHERE 1 = 0
;
/*
Table NEW_CUST이(가) 생성되었습니다.
*/

--실습 4)
DESC new_cust;
/*
이름        널?       유형            
--------- -------- ------------- 
USERID             VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30)  
BIRTHYEAR          NUMBER          
REGDATE            DATE          
ADDRESS            VARCHAR2(30) 
*/

-- 실습 5)
CREATE TABLE salesman
AS
SELECT *
  FROM emp e
 WHERE e.JOB = 'SALESMAN'
;
/*
Table SALESMAN이(가) 생성되었습니다.
*/

-- 실습 6)
SELECT * 
  FROM salesman;
/*
EMPNO   ENAME      JOB      MGR     HIREDATE    SAL    COMM   DEPTNO
-----------------------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
*/


-- 실습 7)
ALTER TABLE customer ADD 
(  phone    VARCHAR2(11)
 , grade    VARCHAR2(30)
 , CONSTRAINT ck_customer_grade CHECK (grade IN ('VIP', 'GOLD', 'SILVER'))
);
/*
Table CUSTOMER이(가) 변경되었습니다.
*/

-- 실습 8)
ALTER TABLE customer DROP (grade);
/*
Table CUSTOMER이(가) 변경되었습니다.
*/
ALTER TABLE customer ADD
(  grade    VARCHAR2(30)
 , CONSTRAINT ck_customer_grade CHECK (grade IN('VIP', 'GOLD', 'SILVER'))
);
/*
Table CUSTOMER이(가) 변경되었습니다.
*/
DESC customer;
SELECT uc.CONSTRAINT_NAME
     , uc.CONSTRAINT_TYPE
     , uc.TABLE_NAME
  FROM user_constraints uc
 WHERE uc.TABLE_NAME = 'CUSTOMER'
;


-- 실습 9)
ALTER TABLE customer MODIFY
(  phone    VARCHAR2(4)
 , userid   VARCHAR2(30)
);
/*
Table CUSTOMER이(가) 변경되었습니다.
*/
ALTER TABLE customer MODIFY
(  userid   number(4)
);
/*
Table CUSTOMER이(가) 변경되었습니다.
*/
ALTER TABLE customer MODIFY
(  userid    VARCHAR2(30)
);
/*
Table CUSTOMER이(가) 변경되었습니다.
*/