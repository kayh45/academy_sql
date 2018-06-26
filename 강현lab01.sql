--�ǽ� 1)
SELECT e.EMPNO AS "���"
     , e.ENAME AS "�̸�"
     , e.JOB AS "����"
     , e.SAL AS "�޿�"
  FROM emp e
 ORDER BY e.SAL DESC
;
/* 
���    �̸�      ����      �޿�
--------------------------------
7839	KING	PRESIDENT	5000
7902	FORD	ANALYST	    3000
7566	JONES	MANAGER	    2975
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7499	ALLEN	SALESMAN	1600
7844	TURNER	SALESMAN	1500
7934	MILLER	CLERK	    1300
7654	MARTIN	SALESMAN	1250
7521	WARD	SALESMAN	1250
7900	JAMES	CLERK	    950
7369	SMITH	CLERK	    800
*/


-- �ǽ�2)
SELECT e.EMPNO AS "���"
     , e.ENAME AS "�̸�"
     , e.HIREDATE AS "�Ի���"
  FROM emp e
 ORDER BY e.HIREDATE
;
/*
���    �̸�     �Ի���
------------------------
7369	SMITH	80/12/17
7499	ALLEN	81/02/20
7521	WARD	81/02/22
7566	JONES	81/04/02
7698	BLAKE	81/05/01
7782	CLARK	81/06/09
7844	TURNER	81/09/08
7654	MARTIN	81/09/28
7839	KING	81/11/17
7900	JAMES	81/12/03
7902	FORD	81/12/03
7934	MILLER	82/01/23
*/


-- �ǽ� 3)
SELECT e.EMPNO AS "���"
     , e.ENAME AS "�̸�"
     , e.COMM AS "����"
  FROM emp e
 ORDER BY e.COMM
;
/*
���     �̸�   ����
--------------------
7844	TURNER	0
7499	ALLEN	300
7521	WARD	500
7654	MARTIN	1400
7839	KING	
7900	JAMES	
7902	FORD	
7782	CLARK	
7934	MILLER	
7566	JONES	
7369	SMITH	
7698	BLAKE	
*/


-- �ǽ� 4)
SELECT e.EMPNO AS "���"
     , e.ENAME AS "�̸�"
     , e.COMM AS "����"
  FROM emp e
 ORDER BY e.COMM DESC
;
/*
���     �̸�    ����
----------------------
7369	SMITH	
7698	BLAKE	
7902	FORD	
7900	JAMES	
7839	KING	
7566	JONES	
7934	MILLER	
7782	CLARK	
7654	MARTIN	1400
7521	WARD	500
7499	ALLEN	300
7844	TURNER	0
*/


--�ǽ� 5)
SELECT e.EMPNO AS "���"
     , e.ENAME AS "�̸�"
     , e.SAL AS "�޿�"
     , e.HIREDATE AS "�Ի���"
  FROM emp e
;
/*
���     �̸�   �޿�      �Ի���
-------------------------------
7369	SMITH	800 	80/12/17
7499	ALLEN	1600	81/02/20
7521	WARD	1250	81/02/22
7566	JONES	2975	81/04/02
7654	MARTIN	1250	81/09/28
7698	BLAKE	2850	81/05/01
7782	CLARK	2450	81/06/09
7839	KING	5000	81/11/17
7844	TURNER	1500	81/09/08
7900	JAMES	950 	81/12/03
7902	FORD	3000	81/12/03
7934	MILLER	1300	82/01/23
*/

-- �ǽ� 6) 
SELECT *
  FROM emp e
;
/*
EMPNO   ENAME    JOB        MGR     HIREDATE    SAL    COMM   DEPTNO
---------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER 	7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7839	KING	PRESIDENT	    	81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		30
7902	FORD	ANALYST 	7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
*/


--�ǽ� 7)
SELECT * 
  FROM emp e
 WHERE e.ENAME = 'ALLEN'
;
/*
EMPNO   ENAME      JOB      MGR     HIREDATE    SAL    COMM   DEPTNO
---------------------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
*/


--�ǽ� 8)
SELECT e.EMPNO AS "���"
     , e.ENAME AS "�̸�"
     , e.DEPTNO AS "�μ���ȣ"
  FROM emp e
 WHERE e.DEPTNO = 20
;
/*
���    �̸�  �μ���ȣ
----------------------
7369	SMITH	20
7566	JONES	20
7902	FORD	20
*/

-- �ǽ� 9)
SELECT e.EMPNO  AS "���"
     , e.ENAME  AS "�̸�"
     , e.SAL    AS "�޿�"
     , e.DEPTNO AS "�μ���ȣ"
  FROM emp e
 WHERE e.DEPTNO = 20
   AND e.SAL < 3000
;
/*
���     �̸�   �޿�  �μ���ȣ
-----------------------------
7369	SMITH	800	    20
7566	JONES	2975	20
*/


-- �ǽ� 10)
SELECT e.EMPNO        AS "���"
     , e.ENAME        AS "�̸�"
     , e.SAL + e.COMM AS "�޿�+Ŀ�̼�"
  FROM emp e
;
/*
���     �̸�  �޿�+Ŀ�̼�
-------------------------
7369	SMITH	
7499	ALLEN	1900
7521	WARD	1750
7566	JONES	
7654	MARTIN	2650
7698	BLAKE	
7782	CLARK	
7839	KING	
7844	TURNER	1500
7900	JAMES	
7902	FORD	
7934	MILLER	
*/


-- �ǽ� 11)
SELECT e.EMPNO        AS "���"
     , e.ENAME        AS "�̸�"
     , e.SAL * 12     AS "��޿�"
  FROM emp e
;
/*
���    �̸�    ��޿�
----------------------
7369	SMITH	9600
7499	ALLEN	19200
7521	WARD	15000
7566	JONES	35700
7654	MARTIN	15000
7698	BLAKE	34200
7782	CLARK	29400
7839	KING	60000
7844	TURNER	18000
7900	JAMES	11400
7902	FORD	36000
7934	MILLER	15600
*/


-- �ǽ� 12)
SELECT e.EMPNO AS ���
     , e.ENAME AS �̸�
     , e.JOB   AS ��å
     , e.SAL   AS �޿�
     , e.COMM  AS Ŀ�̼�
  FROM emp e
 WHERE e.ENAME = 'MARTIN'
    OR e.ENAME = 'BLAKE'
;
/*
���     �̸�      ��å      �޿�    Ŀ�̼�
7654	MARTIN	SALESMAN	1250	1400
7698	BLAKE	MANAGER	    2850	
*/


-- �ǽ� 13)
SELECT e.EMPNO AS "���"
     , e.ENAME AS "�̸�"
     , e.JOB   AS "��å"
     , e.SAL + e.COMM   AS "�޿�+Ŀ�̼�"
  FROM emp e
 WHERE e.ENAME = 'MARTIN'
    OR e.ENAME = 'BLAKE'
;
/*
���     �̸�     ��å    �޿�+Ŀ�̼�
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER	
*/