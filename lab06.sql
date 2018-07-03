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