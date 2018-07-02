-------------------------------------------------------
-- PL/SQL
-------------------------------------------------------
-- 1. ANONYMOUS PROCEDURE : 이름 없이 1회 실행 저장 프로시저

--    출력 설정 SQL*PLUS 설정
-- 기본 OFF 설정일 것임
SHOW SERVEROUTPUT
;
-- ON 설정으로 변경
SET SERVEROUTPUT ON 
;

-- 1) 변수 선언이 있는 ANONYMOUS PROCEDURE 작성
DECLARE
    -- 변수 선언부
    name    VARCHAR2(20) := 'Hannam UNIV';
    -- name 변수는 선언하며 값을 저장
    year    NUMBER;
    -- year 변수는 선언만 하고 값을 저장하지 않음
BEGIN
    -- 프로시저에서 실행할 로직을 작성
    -- 일반적으로 SQL 구문처리가 들어감
    -- 변수 처리, 비교, 반복 등의 로직이 들어감
    
    -- year 변수에 값 저장
    year := 1956;
    
    -- 화면 출력
    DBMS_OUTPUT.PUT_LINE(name || ' since ' || year);
    
END;
/
/*
Hannam UNIV since 1956


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- DECLARE 에서는 변수만 선언
-- BEGIN에서 값을 저장
-- 출력

DECLARE
    name    VARCHAR2(20);
    year    NUMBER;
BEGIN
    name := '강현';
    year := 1993;
    
    DBMS_OUTPUT.PUT_LINE(name || ' since ' || year);
END;
/
