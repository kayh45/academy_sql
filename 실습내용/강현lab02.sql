/*

18-06-27 10:20 lab 브런치 생성

*/


-- �ǽ� 23)
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


-- �ǽ� 24)
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


-- �ǽ� 25)
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


-- �ǽ� 26)
SELECT e.EMPNO AS ���
     , e.ENAME || '�� ������ ' || e.SAL || '�Դϴ�.' AS ���޿�
  FROM emp e
;
/*
���            ���޿�
--------------------------------
7369	SMITH�� ������ 800�Դϴ�.
7499	ALLEN�� ������ 1600�Դϴ�.
7521	WARD�� ������ 1250�Դϴ�.
7566	JONES�� ������ 2975�Դϴ�.
7654	MARTIN�� ������ 1250�Դϴ�.
7698	BLAKE�� ������ 2850�Դϴ�.
7782	CLARK�� ������ 2450�Դϴ�.
7839	KING�� ������ 5000�Դϴ�.
7844	TURNER�� ������ 1500�Դϴ�.
7900	JAMES�� ������ 950�Դϴ�.
7902	FORD�� ������ 3000�Դϴ�.
7934	MILLER�� ������ 1300�Դϴ�.
*/