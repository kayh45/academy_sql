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
CREATE OR REPLACE PROCEDURE sp_chng_emp_comm
(  v_empno  IN  EMP.EMPNO%TYPE )
IS
    v_job   EMP.JOB%TYPE;
    v_comm  EMP.COMM%TYPE;
BEGIN
    -- 조건문, UPDATE 처리
END sp_chng_emp_comm;
/