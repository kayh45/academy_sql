-- 실습 7) 
CREATE OR REPLACE PROCEDURE log_execution
(  v_log_user   IN  log_table.userid%TYPE
 , v_log_date   OUT log_table.log_date%TYPE) 
IS
BEGIN
    v_log_date := sysdate;
    INSERT INTO log_table
    VALUES (v_log_user, v_log_date)    
    ;
END log_execution;
/
----------------------------------------------
/*
Procedure LOG_EXECUTION이(가) 컴파일되었습니다.
*/

--  (2) BIND 변수 선언 후 프로시져 실행 및 BIND 변수 조회
VAR v_log_date VARCHAR2
EXECUTE log_execution('kayh45', :v_log_date)
PRINT v_log_date
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.


V_LOG_DATE
--------------------------------------------------------------------------------
18/07/03
*/


-- 실습 8)

-- (1) sp 이름 : sp_chng_date_format
-- (2) IN OUT 변수 : v_date

CREATE OR REPLACE PROCEDURE sp_chng_date_format
(  v_date   IN OUT VARCHAR2 )
IS
BEGIN
    SELECT TO_CHAR(TO_DATE(v_date, 'YYYY/MM/DD'), 'YYYY Mon dd')
      INTO v_date
      FROM dual
    ;
END sp_chng_date_format;
/

VAR v_date_bind VARCHAR2(20)

EXEC :v_date_bind := TO_CHAR(sysdate, 'YYYY/MM/DD')
EXEC sp_chng_date_format(:v_date_bind)
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

PRINT v_date_bind
/*
V_DATE_BIND
--------------------------------------------------------------------------------
2018 7월  03
*/


-- 실습 9)
CREATE OR REPLACE PROCEDURE sp_insert_dept
(  v_dname    IN    DEPT.DNAME%TYPE
 , v_loc      IN    DEPT.LOC%TYPE
)
IS
    v_max_deptno    NUMBER;
BEGIN
    SELECT MAX(d.deptno)
      INTO v_max_deptno
      FROM dept d
    ;
    INSERT INTO dept (deptno, dname, loc)
    VALUES (v_max_deptno + 10, v_dname, v_loc)
    ;
    COMMIT;
END sp_insert_dept;
/
/* 프로시저 생성 및 컴파일

Procedure SP_INSERT_DEPT이(가) 컴파일되었습니다.
*/

-- 실습 10)

-- 위치 전달 방식
EXEC sp_insert_dept('DESIGN', 'DAEJEON')
-- 변수명 전달 방식
EXEC sp_insert_dept(v_loc => 'MUJU', v_dname => 'DEVELOPING')
/* 
PL/SQL 프로시저가 성공적으로 완료되었습니다.
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

SELECT d.DEPTNO
     , d.DNAME
     , d.LOC
  FROM dept d
;
/* (3) 등록된 부서 확인

DEPTNO   DNAME   LOC
------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	DESIGN	    DAEJEON
60	DEVELOPING	MUJU
*/


-- 실습 11)

CREATE TABLE sp_emp
AS
SELECT e.* 
  FROM emp e
; 
-- 원본 데이터를 유지하기 위해 새 테이블을 만들었습니다.

CREATE OR REPLACE PROCEDURE sp_chng_emp_comm
(  v_empno  IN  SP_EMP.EMPNO%TYPE )
IS
    v_job    SP_EMP.JOB%TYPE;
    v_comm   SP_EMP.COMM%TYPE;
BEGIN
    -- 사번으로 사원을 조회하고 그 사원의 JOB을 가져와 v_job에 저장
    SELECT e.JOB
      INTO v_job
      FROM sp_emp e
     WHERE e.EMPNO = v_empno
    ;    
    -- 조건문을 통해 커미션 값 조정
    IF      v_job = 'SALESMAN' THEN v_comm := 1000;
    ELSIF   v_job = 'MANAGER' THEN v_comm := 1500;
    ELSE    v_comm := 500;
    END IF
    ;
    -- 커미션 값을 UPDATE문을 통해 테이블에 반영 및 커밋
    UPDATE sp_emp e 
       SET e.COMM = v_comm
     WHERE e.EMPNO = v_empno
    ;
    COMMIT;
END sp_chng_emp_comm;
/

EXEC sp_chng_emp_comm(7499);

SELECT e.EMPNO  AS "사번"
     , e.ENAME  AS "이름"
     , e.JOB    AS "직책"
     , e.COMM   AS "커미션"
  FROM sp_emp e
  WHERE e.EMPNO = 7499
;
/* 프로시저 실행 전 (7499)

사번    이름    직책      커미션
--------------------------------
7499	ALLEN	SALESMAN	300
*/
/* 프로시저 실행 후 (7499)

사번    이름    직책      커미션
--------------------------------
7499	ALLEN	SALESMAN   1000
*/

EXEC sp_chng_emp_comm(7566);

SELECT e.EMPNO  AS "사번"
     , e.ENAME  AS "이름"
     , e.JOB    AS "직책"
     , e.COMM   AS "커미션"
  FROM sp_emp e
  WHERE e.EMPNO = 7566
;
/* 프로시저 실행 전 (7566)

사번    이름    직책      커미션
--------------------------------
7566	JONES	MANAGER	 (null)
*/
/* 프로시저 실행 후 (7566)

사번    이름    직책      커미션
--------------------------------
7566	JONES	MANAGER	  1500
*/

EXEC sp_chng_emp_comm(7777);

SELECT e.EMPNO  AS "사번"
     , e.ENAME  AS "이름"
     , e.JOB    AS "직책"
     , e.COMM   AS "커미션"
  FROM sp_emp e
  WHERE e.EMPNO = 7777
;
/* 프로시저 실행 전 (7777)

사번    이름    직책      커미션
--------------------------------
7777	J%JONES	CLERK	 (null)
*/
/* 프로시저 실행 후 (7777)

사번    이름    직책      커미션
--------------------------------
7777	J%JONES	CLERK	  500
*/


-- 실습 12)
DECLARE
    v_cnt   NUMBER := 0;
BEGIN
    LOOP
        v_cnt := v_cnt + 1;
        DBMS_OUTPUT.PUT_LINE(v_cnt);
        EXIT WHEN v_cnt >= 10;
    END LOOP
    ;
END;
/
/*
1
2
3
4
5
6
7
8
9
10

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 실습 13)
DECLARE
    v_cnt NUMBER := 0;
BEGIN
    FOR v_cnt IN REVERSE 1 .. 10 LOOP
        IF MOD(v_cnt, 2) = 0 
           THEN DBMS_OUTPUT.PUT_LINE(v_cnt);
        END IF
        ;
    END LOOP
    ;
END;
/
/*
10
8
6
4
2

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 실습 14)
DECLARE 
    v_cnt NUMBER := 0;
BEGIN
    WHILE (v_cnt < 10) LOOP
        v_cnt := v_cnt + 1;
        DBMS_OUTPUT.PUT_LINE(v_cnt);
    END LOOP
    ;
END;
/
/*
1
2
3
4
5
6
7
8
9
10

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 실습 15)
CREATE OR REPLACE FUNCTION fn_emp_sal_avg
(  v_job        IN  EMP.JOB%TYPE
 , v_sal_avg)   OUT EMP.SAL%TYPE
RETURN NUMBER
IS
BEGIN
    SELECT 
      INTO
      FROM
     GROUP BY
    HAVING
END;