---------------------------------------------------------------
-- PL/SQL 계속
---------------------------------------------------------------
------ IN, OUT 모드 변수를 사용하는 프로시저
-- 문제) 한달 급여를 입력(IN 모드 변수) 하면 
--       일년 급여(OUT 모드 변수)를 계산해주는 프로시저를 작성

--  1) SP 이름 : sp_calc_year_sal
--  2) 변수    : IN  => v_sal
--               OUT => v_sal_year
--  3) PROCEDURE 작성
CREATE OR REPLACE PROCEDURE sp_calc_year_sal
(  v_sal        IN  NUMBER
 , v_sal_year   OUT NUMBER 
)
IS
BEGIN
    v_sal_year := v_sal * 12;
END sp_calc_year_sal;
/

--  4) 컴파일 : SQL*PLUS CLi라면 위 코드를 복사 붙여넣기
--              Oracle SQL Developer : ctrl + Enter 키 입력

-- Procedure SP_CALC_YEAR_SAL이(가) 컴파일되었습니다.
--              오류가 존재하면 SHOW errors 명령으로 확인


--  5) OUT 모드 변수가 있는 프로시저이므로 BIND 변수가 필요
--     VAR 명령으로 SQL*PLUS 의 변수를 선언하는 명령
--     DESC 명령 : SQL*PLUS
VAR v_sal_year_bind NUMBER
;

--  6) 프로시져 실행 : EXEC[UTE] : SQL*PLUS 명령
EXEC sp_calc_year_sal(1500000, :v_sal_year_bind)
;
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

--  7) 실행 결과가 담길 BIND 변수를 SQL*PLUS에서 출력
PRINT v_sal_year_bind
;
/*
V_SAL_YEAR_BIND
---------------
       18000000
*/



-- 1) 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_variables
(  v_deptno     IN  NUMBER
 , v_loc        IN  VARCHAR2)
IS
    -- IS ~ BEGIN 사이는 지역변수 선언/초기화
    v_hiredate       DATE;
    v_empno          NUMBER := 1999;
    v_msg            VARCHAR2(500)   DEFAULT 'Hello, PL/SQL';
    v_max CONSTANT   NUMBER := 5000; -- CONSTANT는 상수를 만드는 설정
BEGIN
    -- 위에서 정의된 값들을 출력   
    DBMS_OUTPUT.PUT_LINE('v_hiredate: ' || v_hiredate);
    
    v_hiredate := sysdate;
    DBMS_OUTPUT.PUT_LINE('v_hiredate: ' || v_hiredate);
    DBMS_OUTPUT.PUT_LINE('v_deptno: ' || v_deptno);
    DBMS_OUTPUT.PUT_LINE('v_loc: ' || v_loc);
    DBMS_OUTPUT.PUT_LINE('v_empno: ' || v_empno);
    
    v_msg := '내일 지구가 멸망하더라고 오늘 사과나무를 심겠다. by.스피노자';
    DBMS_OUTPUT.PUT_LINE('v_msg: ' || v_msg);
    DBMS_OUTPUT.PUT_LINE('v_max: ' || v_max);
END sp_variables;
/

-- 2) 컴파일 / 디버깅
/*
LINE/COL  ERROR
--------- -------------------------------------------------------------
22/5      PL/SQL: Statement ignored
22/5      PLS-00363: expression 'V_MAX' cannot be used as an assignment target
오류: 컴파일러 로그를 확인하십시오.
*/

-- Procedure SP_VARIABLES이(가) 컴파일되었습니다.

-- 3) VAR   : BIND 변수가 필요하면 선언

-- 4) EXEC  : SP 실행
SET SERVEROUTPUT ON
EXEC SP_VARIABLES('10', '하와이')
EXEC SP_VARIABLES('20', '스페인')
EXEC SP_VARIABLES('30', '제주도')
EXEC SP_VARIABLES('40', '몰디브')


-- 5) PRINT : BIND 변수에 값이 저장되었으면 출력

/*
v_hiredate: 
v_hiredate: 18/07/03
v_deptno: 10
v_loc: 하와이
v_empno: 1999
v_msg: 내일 지구가 멸망하더라고 오늘 사과나무를 심겠다. by.스피노자
v_max: 5000
*/





