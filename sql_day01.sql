-- sql day01
-- 1. SCOTT ���� Ȱ��ȭ : sys �������� �����Ͽ� ��ũ��Ʈ ����
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql;
-- 2. ���� ���� Ȯ�� ���
show user
-- 3. HR ���� Ȱ��ȭ : sys �������� �����Ͽ�
--                   �ٸ� ����� Ȯ�� �� HR ������
--                   ���� ���, ��й�ȣ ���� ���� ����

----------------------------------------------------------------------

-- SCOTT ������ ������ ����
-- (1) EMP ���̺� ���� ��ȸ
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

-- (2) DEPT ���̺� ���� ��ȸ

SELECT * 
  FROM dept
;
/* ----------------------
10	    ACCOUNTING	NEW YORK
20	    RESEARCH	DALLAS
30	    SALES	    CHICAGO
40	    OPERATIONS	BOSTON
-------------------------*/

--(3) SALGRADE ���̺� ���� ��ȸ
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
-- (1) SELECT ����
--  1) emp ���̺��� ���, �̸�, ������ ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM emp e -- �ҹ��� e�� alias (��Ī)
;

--  2) emp ���̺��� ������ ��ȸ
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

-- (2) DISTINCT �� : SELECT �� ���� �ߺ��� �����Ͽ� ��ȸ
--  3) emp ���̺��� job �÷��� �ߺ��� �����Ͽ� ��ȸ
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

-- * SQL SELECT ������ �۵� ���� : ���̺��� �� ���� �⺻ ������ ������.
--                                ���̺� ���� ������ŭ �ݺ� ����.
SELECT 'Hello, SQL~'
  FROM emp e
;

--  4) emp ���̺��� job, deptno�� ���� �ߺ��� �����Ͽ� ��ȸ
SELECT DISTINCT 
       e.JOB
     , e.DEPTNO
  FROM emp e
;

-- (3) ORDER BY �� : ����
--  5) emp ���̺��� job�� ���������Ͽ� ��ȸ�ϰ� ����� ������������ ����
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

--  6) emp ���̺��� job�� �ߺ� �����Ͽ� ��ȸ�ϰ� ������������ ����
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

--  7) emp ���̺��� comm�� ���� ���� �޴� ������� ���
--    ���, �̸�, ����, �Ի���, Ŀ�̼� ������ ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM DESC
;

--  8) emp ���̺��� comm�� ���� �������, ������ ��������, �̸��� �������� ����
--     ���, �̸�, ����, �Ի���, Ŀ�̼���  ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM, e.JOB, e.ENAME
;

--  9) emp ���̺��� comm�� ���� �������, ������ ��������, �̸��� ������������ ����
--     ���, �̸�, ����, �Ի���, Ŀ�̼��� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM, e.JOB, e.ENAME DESC
;

-- (4) Alias : ��Ī
--  10) emp ���̺��� �Ʒ� �� �÷��� ��Ī�� Ǯ������ �־ ��ȸ
--      empno --> Employee No.
--      ename --> Employee Name
--      job   --> Job Name
SELECT e.EMPNO AS "Employee No."
     , e.ENAME AS "Employee Name"
     , e.JOB AS "Job Name"
  FROM emp e
;

--  11) 10���� ���� as Ű���� �����Ͽ� ��ȸ
--      empno --> ���
--      ename --> ��� �̸�
--      job   --> ����
SELECT e.EMPNO ���
     , e.ENAME "��� �̸�"
     , e.JOB "����"
  FROM emp e
;

--  12) ���̺� ���̴� ��Ī
SELECT empno
  FROM emp
;

SELECT emp.empno
  FROM emp
;

SELECT e.empno -- FROM ������ ������ ���̺� ��Ī�� SELECT ������ ����.
  FROM emp e -- �ҹ��� e�� emp ���̺긣�� ��Ī�̸� ���̺� ��Ī�� FROM ���� �����
;

SELECT d.deptno
  FROM dept d
;

--  13) ���� ��Ī ��� �� Ư����ȣ _ ����ϴ� ���
SELECT e.EMPNO Employee_No
     , e.ENAME "Employee Name"
  FROM emp e
;

--  14) ��Ī�� ������ ���� : SELECT ���� ��Ī�� �� ��� ORDER BY ������ ��밡��
--      emp ���̺��� ���, �̸�, ����, �Ի���, Ŀ�̼��� ��ȸ�� ��
--      �� �÷��� ���ؼ� �ѱ� ��Ī�� �־� ��ȸ
--      ������ Ŀ�̼�, ����, �̸��� ������������ ����
SELECT e.EMPNO    ���
     , e.ENAME    �̸�
     , e.JOB      ����
     , e.HIREDATE �Ի���
     , e.COMM     Ŀ�̼�
  FROM emp e
 ORDER BY Ŀ�̼�, ����, �̸�
;

--  15) DISTINCT, ��Ī, ������ ����
--      job�� �ߺ��� �����Ͽ� ������� ��Ī�� ��ȸ�ϰ�
--      ������������ ����
SELECT DISTINCT 
       e.JOB AS "����"
  FROM emp e
 ORDER BY ���� DESC
;
/*
  ����
---------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
*/

-- (5) WHERE ������
--  16) emp ���̺��� empno�� 7900�� �����
--      ���, �̸�, ����, �Ի���, �޿�, �μ���ȣ
SELECT e.EMPNO    AS ���
     , e.ENAME    AS �̸�
     , e.JOB      AS ����
     , e.HIREDATE AS �Ի���
     , e.SAL      AS �޿�
     , e.DEPTNO   AS �μ���ȣ
  FROM emp e
 WHERE e.EMPNO = 7900
;
/*
���     �̸�    ����     �Ի���     �޿�  �μ���ȣ
-------------------------------------------------
7900	JAMES	CLERK	81/12/03	950	    30
*/

--  17) emp ���̺��� empno�� 7900�̰ų� deptno�� 20�� ������ ������
--      ���, �̸�, ����, �Ի���, �޿�, �μ���ȣ�� ��ȸ
SELECT e.EMPNO    AS ���
     , e.ENAME    AS �̸�
     , e.JOB      AS ����
     , e.HIREDATE AS �Ի���
     , e.SAL      AS �޿�
     , e.DEPTNO   AS �μ���ȣ
  FROM emp e
 WHERE e.EMPNO = 7900
    OR e.DEPTNO = 20
;
/*
���     �̸�    ����     �Ի���     �޿�  �μ���ȣ
-------------------------------------------------
7369	SMITH	CLERK	80/12/17	800	    20
7566	JONES	MANAGER	81/04/02	2975	20
7900	JAMES	CLERK	81/12/03	950	    30
7902	FORD	ANALYST	81/12/03	3000	20
*/
SELECT e.EMPNO    AS ���
     , e.ENAME    AS �̸�
     , e.JOB      AS ����
     , e.HIREDATE AS �Ի���
     , e.SAL      AS �޿�
     , e.DEPTNO   AS �μ���ȣ
  FROM emp e
 WHERE e.EMPNO = 7900
   AND e.DEPTNO = 20
;
-- ����� ��� �� : 0

--  19) job�� 'CLERK' �̸鼭 deptno�� 10�� ������
--      ���, �̸�, ����, �μ���ȣ�� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.DEPTNO
  FROM emp e
 WHERE e.JOB = 'CLERK' -- ���ڰ� �񱳽� ''���, ���ڰ��� ��ҹ��� ����
   AND e.DEPTNO = 10   -- ���ڰ� �񱳽� ����ǥ ������� ����
;

--  20) 19������ ���� �� ���� �ҹ��� clerk�� ���Ͽ� ����� Ȯ��
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.DEPTNO
  FROM emp e
 WHERE e.JOB = 'clerk' -- ���ڰ� �񱳽� ''���, ���ڰ��� ��ҹ��� ����
   AND e.DEPTNO = 10   -- ���ڰ� �񱳽� ����ǥ ������� ����
;

-- �ҹ��� clerk���� ����� ������ �������� �����Ƿ�
-- ����� ��� �� : 0 ����� �߻���

-- (6) ������ 1. ���������
--- 21) ���, �̸�, �޿��� ��ȸ�ϰ�, �޿��� 3.3%�� �ش��ϴ� ��û¡�� ������ ����Ͽ� ��ȸ
SELECT e.EMPNO ���
     , e.ENAME �̸�
     , e.SAL   �޿�
     , e.SAL * 0.033 ��õ¡������
  FROM emp e
;
-- �Ǽ��ɾ׿� �ش��ϴ� 96.7%�� �޿��� ����Ͽ� ��ȸ
SELECT e.EMPNO ���
     , e.ENAME �̸�
     , e.SAL   �޿�
     , e.SAL * 0.033 ��õ¡������
     , e.SAL * 0.967 �Ǽ��ɾ�
  FROM emp e
;
-- ���ϰ���� ���� �ٸ� ���1
SELECT e.EMPNO ���
     , e.ENAME �̸�
     , e.SAL   �޿�
     , e.SAL * 0.033 ��õ¡������
     , e.SAL - (e.SAL * 0.033) �Ǽ��ɾ�
  FROM emp e
;
-- ���ϰ���� ���� �ٸ� ���2
SELECT e.EMPNO ���
     , e.ENAME �̸�
     , e.SAL   �޿�
     , e.SAL * 0.033 ��õ¡������
     , e.SAL * (1 - 0.033) �Ǽ��ɾ�
  FROM emp e
;

-- (6) ������ 2. �񱳿�����
--     �񱳿����ڴ� SELECT ���� ����� �� ����
--     WHERE, HAVING ������ �����

--- 22) �޿��� 2000�� �Ѵ� ������ ���, �̸�, �޿��� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL > 2000
;

--- �޿��� 1000 �̻��� ������ ���, �̸�, �޿��� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 1000
;

--- �޿��� 1000 �̻��̸� 2000 �̸��� ������ ���, �̸�, �޿��� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 1000
   AND e.SAL < 2000
;

--- comm���� 0���� ū ������ ���, �̸�, �޿��� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , e.COMM
  FROM emp e
 WHERE e.COMM > 0
;
/*
 ���� ���� ������� comm �� (null)�� ������� ���� 
 ó������ �񱳴�� ���� ������ ���� �ؾ��Ѵ�.
 (null) ���� �񱳿����ڷ� ���� �� ���� ���̴�.
*/

--- 23) �������(SALESMAN) ������ ���� ������� �޿��� ������ �Բ� �����Ƿ�
--      ��������� ���� ���ɱ��� ����غ���
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL + e.COMM "�޿� + ����"
  FROM emp e
;

/*
7369	SMITH	CLERK	
7499	ALLEN	SALESMAN	1900
7521	WARD	SALESMAN	1750
7566	JONES	MANAGER	
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER	
7782	CLARK	MANAGER	
7839	KING	PRESIDENT	
7844	TURNER	SALESMAN	1500
7900	JAMES	CLERK	
7902	FORD	ANALYST	
7934	MILLER	CLERK	

==> ���ڰ��� (null) ���� ��� ���� ����� �ᱹ (null) ���� ��������
*/

-- (6) ������ : 3. ��������
--- NOT ������

--- 24) �޿��� 2000 ���� ���� ���� ������ ���, �̸�, �޿��� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE NOT e.SAL < 2000
;

-- ���� ����� ���� �ٸ� ���� NOT ������� ����
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 2000
;

-- (6) ������ : 4. SQL ������
--- IN ������ : ���ϰ��� �ϴ� ���� ���� ���õ� �׸� ��Ͽ� �����ϸ� ������ �Ǵ�

--- 25) �޿��� 800, 3000, 5000 �߿� �ϳ��� ������ ���, �̸�, �޿��� ��ȸ
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL = 800
    OR e.SAL = 3000
    OR e.SAL = 5000
;
-- IN �����ڸ� ����Ͽ� �ذ�
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL IN (800, 3000, 5000)
;

--- LIKE ������ : ���� ���� �˻��ϴ� �� ���
/* LIKE �����ڴ� ���簪 �˻��� ���� �Բ� ����ϴ� ���� �ν� ���ڰ� �ִ�.
   % : 0�ڸ��� �̻��� ��� ���� ������ �� �� ����
   _ : 1�ڸ��� ��� ���� ������ �� �� ����
*/

--- 26) �̸��� J �� �����ϴ� ������ ���, �̸� ��ȸ
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%'
;
-- �̸��� M ���� �����ϴ� ������ ���, �̸� ��ȸ
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'M%'
;
-- �̸��� M �� ���� ������ ���, �̸� ��ȸ
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '%M%'
;
-- �̸��� �ι�° �ڸ��� M �� ���� ������ ���, �̸� ��ȸ
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '_M%'
;
-- �̸��� ����° �ڸ��� M �� ���� ������ ���, �̸� ��ȸ
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '__M%'
;
-- �̸��� ��° �ڸ����� LA �� ���� ������ ���, �̸� ��ȸ
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '_LA%'
;

-- �̸��� J_�� �����ϴ� ������ ���, �̸� ��ȸ
-- : ��ȸ ���� �����ν� ���ڰ� ����ִ� �������� ��� ��� ��ȸ�� ���ΰ�?
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J\%%' ESCAPE '\'
;
-- ��ȸ�Ϸ��� ���� ����ִ� �����ν� ���ڸ� ��ȿȭ �Ϸ��� ESCAPE ���� �����Ѵ�.