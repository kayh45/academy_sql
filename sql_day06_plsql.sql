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

-- 실습 6)

-- 1) 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_variables
(  v_deptno     IN  NUMBER
 , v_loc        IN  VARCHAR2)
IS
    -- IS ~ BEGIN 사이는 지역변수 선언/초기화
    v_hiredate       VARCHAR2(30);
    v_empno          NUMBER := 1999;
    v_msg            VARCHAR2(500)   DEFAULT 'Hello, PL/SQL';
    v_max CONSTANT   NUMBER := 5000; -- CONSTANT는 상수를 만드는 설정
BEGIN
    -- 위에서 정의된 값들을 출력   
    DBMS_OUTPUT.PUT_LINE('v_hiredate: ' || v_hiredate);
    
    v_hiredate := TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS DY');
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



---------------------------------------------------------------------
-- PL/SQL 변수 : REFERENCES 변수의 사용
-- 1) %TYPE 변수
--      DEPT 테이블의 부서번호를 입력(IN 모드)받아서 부서명을 출력(OUT 모드)하는 프로시저

---- (1) SP 이름 : sp_get_dname
---- (2) IN 변수 : v_deptno
---- (3) OUT 변수 : v_dname
-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_get_dname
(  v_deptno     IN   DEPT.DEPTNO%TYPE
 , v_dname      OUT  DEPT.DNAME%TYPE
)
IS
BEGIN
    SELECT d.dname
      INTO v_dname
      FROM dept d
     WHERE d.deptno = v_deptno
     ;
END sp_get_dname;
/
-- 2. 컴파일 / 디버깅
/*
Procedure SP_GET_DNAME이(가) 컴파일되었습니다.
*/

-- 3. BIND 변수가 필요하면 선언
VAR v_dname_bind VARCHAR2(30)

-- 4. 프로시저 실행
EXEC sp_get_dname(10, :v_dname_bind)
EXEC sp_get_dname(20, :v_dname_bind)
EXEC sp_get_dname(50, :v_dname_bind)

-- 5. BIND 변수가 있으면 출력
PRINT v_dname_bind


/*
V_DNAME_BIND
--------------------------------------------------------------------------------
ACCOUNTING
*/



/*
V_DNAME_BIND
--------------------------------------------------------------------------------
RESEARCH
*/



/*
명령의 145 행에서 시작하는 중 오류 발생 -
BEGIN sp_get_dname(50, :v_dname_bind); END;
오류 보고 -
ORA-01403: no data found
ORA-06512: at "SCOTT.SP_GET_DNAME", line 7
ORA-06512: at line 1
01403. 00000 -  "no data found"
*Cause:    No data was found from the objects.
*Action:   There was no data from the objects which may be due to end of fetch.
*/


-- 2) %ROWTYPE 변수
/*  특정 테이블의 한 행(row)를 컬럼의 순서대로
    타입, 크기를 그대로 매핑한 변수

*/
--      DEPT 테이블의 부서번호를 입력(IN 모드)받아서 부서 전체 정보를 출력하는 저장 프로시저
---- (1) SP 이름 : sp_get_dinfo
---- (2) IN 변수 : v_deptno

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_get_dinfo
(  v_deptno     IN   DEPT.DEPTNO%TYPE
)
IS
    -- v_dinfo 변수는 dept 테이블의 한 행의 정보를 한번에 담는 변수
    v_dinfo     DEPT%ROWTYPE;
BEGIN
    -- IN 모드로 입력된 v_deptno 에 해당하는 부서정보
    -- 1행을 조회하여
    -- DEPT 테이블의ROWTYPE 변수인 v_dinfo 에 저장
    SELECT d.DEPTNO
         , d.DNAME
         , d.LOC
      INTO v_dinfo -- INTO 절에 명시되는 변수에는 1행만 저장가능
      FROM dept d
     WHERE d.deptno = v_deptno
     ;
     
     -- 조회된 결과 화면 출력    
     DBMS_OUTPUT.PUT_LINE('부서번호: ' || v_dinfo.deptno);
     DBMS_OUTPUT.PUT_LINE('부서이름: ' || v_dinfo.dname);
     DBMS_OUTPUT.PUT_LINE('부서위치: ' || v_dinfo.loc);
END sp_get_dinfo;
/
-- 2. 컴파일 / 디버깅
/*
Procedure SP_GET_DINFO이(가) 컴파일되었습니다.
*/

-- 3. BIND 변수가 필요하면 선언


-- 4. 프로시저 실행
EXEC sp_get_dinfo(10)
EXEC sp_get_dinfo(20)
EXEC sp_get_dinfo(30)
/*
부서번호: 10
부서이름: ACCOUNTING
부서위치: NEW YORK


PL/SQL 프로시저가 성공적으로 완료되었습니다.

부서번호: 20
부서이름: RESEARCH
부서위치: DALLAS


PL/SQL 프로시저가 성공적으로 완료되었습니다.

부서번호: 30
부서이름: SALES
부서위치: CHICAGO


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 5. BIND 변수가 있으면 출력



-----------------------------------------------------------
-- 수업 중 실습

-- 문제 ) 한 사람의 사번을 입력 받으면 그 사람의 소속 부서명, 부서위치를 
--        함께 화면 출력

SELECT e.ename
     , d.dname
     , d.loc
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno
   AND e.empno = 7654
;   
   
-- (1) SP 이름  : sp_get_emp_info
-- (2) IN 변수  : v_empno
-- (3) %TYPE, %ROWTYPE 변수 활용


CREATE OR REPLACE PROCEDURE sp_get_emp_info
(  v_empno      IN      emp.empno%TYPE
)
IS
    v_res_ename     emp.ename%TYPE;
    v_res_dname     dept.dname%TYPE;
    v_res_loc       dept.loc%TYPE;
BEGIN
    SELECT e.ename
         , d.dname
         , d.loc
      INTO v_res_ename
         , v_res_dname
         , v_res_loc
      FROM emp e
         , dept d
     WHERE e.deptno = d.deptno
       AND e.empno = v_empno
    ;  
    DBMS_OUTPUT.PUT_LINE('이름: ' || v_res_ename);
    DBMS_OUTPUT.PUT_LINE('부서명: ' || v_res_dname);
    DBMS_OUTPUT.PUT_LINE('지역: ' || v_res_loc);
END sp_get_emp_info;
/

EXEC sp_get_emp_info(7654)
/*
이름: MARTIN
부서명: SALES
지역: CHICAGO
*/

-- (1) SP 이름  : sp_get_emp_info_ins
-- (2) IN 변수  : v_empno
-- (3) %TYPE, %ROWTYPE 변수 활용


CREATE OR REPLACE PROCEDURE sp_get_emp_info_ins
(  v_empno      IN      emp.empno%TYPE
)
IS
    v_emp   emp%ROWTYPE;
    v_dept  dept%ROWTYPE;
BEGIN
    -- SP 의 좋은 점은 여러개의 쿼리를
    -- 순차적으로 실행하는 것이 가능
    -- 변수를 활용할 수 있기 때문에
    
    -- 1. IN 모드 변수로 들어오는 한 직원의 정보 조회
    SELECT e.*
      INTO v_emp
      FROM emp e
     WHERE e.EMPNO = v_empno
    ;
    -- 2. 1 결과에서 직원의 부서를 번호를 얻을 수 있으므로
    --    부서 정보 조회
    SELECT d.*
      INTO v_dept
      FROM dept d
     WHERE d.DEPTNO = v_emp.deptno
    ;
    
    DBMS_OUTPUT.PUT_LINE('이름: ' || v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('부서명: ' || v_dept.dname);
    DBMS_OUTPUT.PUT_LINE('지역: ' || v_dept.loc);
END sp_get_emp_info_ins;
/

EXEC sp_get_emp_info_ins(7654)
/*
이름: MARTIN
부서명: SALES
지역: CHICAGO

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


---------------------------------------------------------
-- PL/SQL   변수 : RECORD TYPE 변수의 사용
---------------------------------------------------------
-- RECORD TYPE : 한 개 혹은 그 이상 테이블에서
--               원하는 컬럼만 추출하여 구성

-- 문제) 사번을 입력(IN 모드 변수) 받아서
--       그 직원의 매니저 이름, 부서이름, 부서위치, 급여등급 함께 출력

---- (1) SP 이름 : sp_get_emp_info_detail
---- (2) IN 변수 : v_empno
---- (2) RECORD 변수 : v_emp_record

CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
(  v_empno      IN      emp.empno%TYPE
)
IS
    -- 1. RECORD 타입 선언
    TYPE emp_record_type IS RECORD
    (  r_empno       EMP.EMPNO%TYPE
     , r_ename       EMP.ENAME%TYPE
     , r_mgrname     EMP.ENAME%TYPE
     , r_dname       DEPT.DNAME%TYPE
     , r_loc         DEPT.LOC%TYPE
     , r_salgrade    SALGRADE.GRADE%TYPE
     );
    -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record    emp_record_type;
       
BEGIN
    SELECT e.EMPNO
         , e.ENAME
         , e1.ENAME
         , d.DNAME
         , d.LOC
         , s.GRADE
      INTO v_emp_record
      FROM emp e
         , emp e1
         , dept d
         , salgrade s
     WHERE e.MGR = e1.EMPNO(+)
       AND e.DEPTNO = d.DEPTNO(+)
       AND e.SAL BETWEEN s.LOSAL AND s.HISAL
       AND e.EMPNO = v_empno
    ;
    DBMS_OUTPUT.PUT_LINE('사 번 : ' || v_emp_record.r_empno);
    DBMS_OUTPUT.PUT_LINE('이 름 : ' || v_emp_record.r_ename);
    DBMS_OUTPUT.PUT_LINE('매 니 저 : ' || v_emp_record.r_mgrname);
    DBMS_OUTPUT.PUT_LINE('부 서 명 : ' || v_emp_record.r_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_emp_record.r_loc);
    DBMS_OUTPUT.PUT_LINE('급여 등급 : ' || v_emp_record.r_salgrade);
       
END sp_get_emp_info_detail;
/

EXEC sp_get_emp_info_detail(7369)
EXEC sp_get_emp_info_detail(7902)

/*
사 번 : 7369
이 름 : SMITH
매 니 저 : FORD
부 서 명 : RESEARCH
부서 위치 : DALLAS
급여 등급 : 1

PL/SQL 프로시저가 성공적으로 완료되었습니다.

사 번 : 7902
이 름 : FORD
매 니 저 : JONES
부 서 명 : RESEARCH
부서 위치 : DALLAS
급여 등급 : 4

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

----------------------------------------------------
-- 프로시저는 다른 프로시저에서 호출 가능

-- ANONYMOUS PROCEDURE 를 사용하여 지금 정의한
-- sp_get_emp_info_detail 실행

DECLARE
    v_empno     EMP.EMPNO%TYPE;
BEGIN
    SELECT e.empno
      INTO v_empno
      FROM emp e
     WHERE e.empno = 7902
    ;
    sp_get_emp_info_detail(v_empno);
END;
/

-----------------------------------------------------
-- PL/SQL 변수 : 아규먼트 변수 IN OUT  모드의 사용
-----------------------------------------------------
-- IN : SP로 값이 전달될 때 사용
--      프로시저를 사용하는 쪽(SQL*PLUS) 에서 프로시저로 전달
-----------------------------------------------------
-- OUT : SP에서 수행 결과 값이 저장되는 용도, 
--       출력용 프로시저는 리턴(반환)이 없기 때문에
--       SP를 호출한 쪽에 돌려주는 방법으로 사용
-----------------------------------------------------
-- IN OUT : 하나의 매개 변수에 입력, 출력을 함께 사용
-----------------------------------------------------
-- 문제) 기본 숫자값을 입력 받아서 숫자 포맷화 '$9,999.99'
--       출력하는 프로시저를 작성 IN OUT 모드 변수를 활용

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_chng_number_format
(  v_number IN OUT VARCHAR2 )
IS
BEGIN
    -- 1. 입력된 초기 상태의 값 출력
    DBMS_OUTPUT.PUT_LINE('초기 입력 값 : ' || v_number);
    
    -- 2. 숫자 패턴화 변경
    v_number := TO_CHAR(TO_NUMBER(v_number), '$9,999.99');
    
    -- 3. 화면 출력으로 변경된 패턴 확인
    DBMS_OUTPUT.PUT_LINE('패턴 적용 값 : ' || v_number);
END sp_chng_number_format;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_CHNG_NUMBER_FORMAT이(가) 컴파일되었습니다.

-- 3. VAR : BIND 변수 선언
-- IN OUT 으로 사용될 변수
VAR v_number_bind   VARCHAR2(20)

-- 4. EXEC : 실행
-- 4.1  BIND 변수에 1000을 먼저 저장
EXEC :v_number_bind := 1000
-- 4.2 1000이 저장된 BIND 변수를 프로시저에 전달
EXEC SP_CHNG_NUMBER_FORMAT(:v_number_bind)
/*
V_NUMBER_BIND
--------------------------------------------------------------------------------
    $10,00
*/
-- 5. PRINT : BIND 변수 출력
PRINT v_number_bind
/*
초기 입력 값 : 1000
패턴 적용 값 :  $1,000.00

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 위의 문제를 다른 방법으로 풀이 : SELECT ~ INTO 절을 사용
CREATE OR REPLACE PROCEDURE sp_chng_number_format
(  in_number    IN  NUMBER
 , out_number   OUT VARCHAR2)
IS
BEGIN
    -- in_number로 입력된 값을 INTO 절을 사용하여
    -- out_number 변수로 입력
    SELECT TO_CHAR(in_number, '$9,999.99')
      INTO out_number
      FROM dual
    ;
END sp_chng_number_format;
/

VAR v_out_number_bind VARCHAR2(10)

EXEC SP_CHNG_NUMBER_FORMAT(1000, :v_out_number_bind)
PRINT v_out_number_bind


------------------------------------------------------------------
-- 매개변수 전달법 : SP 에서는 위치, 변수명에 의한 전달 방식이 있다.
------------------------------------------------------------------

-- 1. 위치에 의한 전달 법
EXEC SP_CHNG_NUMBER_FORMAT(1000, :v_out_number_bind)
PRINT v_out_number_bind
-- 2. 변수명에 의한 전달
EXEC SP_CHNG_NUMBER_FORMAT(out_number => :v_out_number_bind, in_number => 1000)
PRINT v_out_number_bind


-- job별로 경조사비를 급여대비 일정 비율로 지금하고 있다.
-- 각 직원들의 경조사비 지원금을 구하는 프로시저 작성
/*
    CLERK       : 5%
    SALESMAN    : 4%
    MANAGER     : 3.7%
    ANALYST     : 3%
    PRESIDENT   : 1.5%
*/

-- (1) SP 이름  : sp_get_tribute_fee
-- (2) IN 변수  : v_empno (사번타입)
-- (3) OUT 변수 : v_tribute_fee (급여 타입)

-- 1. 프로시져 작성
CREATE OR REPLACE PROCEDURE sp_get_tribute_fee
(  v_empno          IN  EMP.EMPNO%TYPE
 , v_tribute_fee    OUT EMP.SAL%TYPE)
IS
    -- 사번인 직원의 직무를 저장할 지역 변수 선언
    v_job   EMP.JOB%TYPE;
    -- 사번인 직원의 급여를 저장할 지역 변수 선언
    v_sal   EMP.SAL%TYPE;
    
BEGIN
    -- 1. 입력된 사번 직원의 직무를 조회하여 v_job에 저장
    SELECT e.JOB, e.SAL
      INTO v_job, v_sal
      FROM emp e
     WHERE e.EMPNO = v_empno
    ;
    
    -- 2. 일정 비율로 v_tribute_fee 를 계산
    IF     v_job = 'CLERK'     THEN v_tribute_fee := v_sal * 0.05;
    ELSIF  v_job = 'SALSEMAN'  THEN v_tribute_fee := v_sal * 0.04; 
    ELSIF  v_job = 'MANAGER'   THEN v_tribute_fee := v_sal * 0.037; 
    ELSIF  v_job = 'ANALYST'   THEN v_tribute_fee := v_sal * 0.03; 
    ELSIF  v_job = 'PRESIDENT' THEN v_tribute_fee := v_sal * 0.015;
    END IF
    ;
END sp_get_tribute_fee;
/
-- 2. 컴파일 / 디버깅
-- Procedure SP_GET_TRIBUTE_FEE이(가) 컴파일되었습니다.

-- 3. VAR
VAR v_tribute_fee_bind NUMBER

-- 4. EXEC
EXEC sp_get_tribute_fee(v_tribute_fee => :v_tribute_fee_bind, v_empno => 7566)
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 5. PRINT
PRINT v_tribute_fee_bind

/*
V_TRIBUTE_FEE_BIND
------------------
            110.08
*/



----------------------------------------------------------------------------------------
-- 2. LOOP 기본 반복문
----------------------------------------------------------------------------------------
-- ANONYMOUS PROCEDURE로 실행예

-- 문제 ) 1에서 10까지 합을 출력
DECLARE
    -- 1. 초기 값 변수 선언 및 초기화
    v_init  NUMBER := 0;
    -- 2. 합산을 저장할 변수
    v_sum   NUMBER := 0;
BEGIN
    LOOP
        v_init := v_init + 1;
        v_sum  := v_sum + v_init;
        
        DBMS_OUTPUT.PUT_LINE('v_sum : ' || v_sum);
        
    -- 반복문 종료 조건
    EXIT WHEN v_init = 10;
    END LOOP
    ;
    -- 합산 결과 출력
    DBMS_OUTPUT.PUT_LINE('1 ~ 10 합산 결과 : ' || v_sum);
END;
/
/*
v_sum : 1
v_sum : 3
v_sum : 6
v_sum : 10
v_sum : 15
v_sum : 21
v_sum : 28
v_sum : 36
v_sum : 45
v_sum : 55
1 ~ 10 합산 결과 : 55


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


----------------------------------------------------------------------------------------
-- 2. LOOP : FOR LOOP 카운터 변수를 사용하는 반복문
----------------------------------------------------------------------------------------
-- 지정된 횟수만큼 실행 반복문
-- 문제) 1 ~ 20 사이의 3의 배수를 출력 : 어나니머스 프로시져

DECLARE
    -- 1. FOR LOOP 에서 사용할 카운터 변수 선언 / 초기화
    cnt NUMBER := 0;    
BEGIN
    -- 2. LOOP 작성
    FOR cnt IN 1 .. 20 LOOP
        -- 3. 3의 배수 판단
        IF (MOD(cnt, 3) = 0) 
            THEN DBMS_OUTPUT.PUT_LINE(cnt);
        END IF
        ;
    END LOOP
    ;
END;
/

/*
3
6
9
12
15
18


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


----------------------------------------------------------------------------------------
-- 2. LOOP : WHILE LOOP 조건에 따라 수행되는 반복문
----------------------------------------------------------------------------------------
-- 문제) 1 ~ 20 사이의 수 중에서 2의 배수를 화면 출력
DECLARE
    cnt NUMBER := 0;
BEGIN
    WHILE cnt < 20 LOOP
    cnt := cnt + 2;
        DBMS_OUTPUT.PUT_LINE(cnt);        
    END LOOP
    ;
END;
/
/*
2
4
6
8
10
12
14
16
18
20

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-----------------------------------------------------------
-- PL/SQL : Stored Function (저장 함수)
-----------------------------------------------------------
-- 대부분 SP랑 유사
-- IS 블록 전에 RETURN 구문이 존재
-- RETURN 구문에는 문장종료기호 (;) 없음
-- 실행은 기존 사용하는 함수와 동일하게 SELECT, WHERE 절 등에 사용함

-- 문제) 부서 번호를 입력 받아서 해당 부서의 급여 평균을 구하는 함수 작성
---- (1) FN 이름 : fn_avg_sal_by_dept
---- (2) IN 변수 : v_deptno (부서번호 타입)
---- (3) 지역변수 : v_avg_sql (급여 타입) 계산된 평균 급여를 저장

-- 1. 함수 작성
CREATE OR REPLACE FUNCTION fn_avg_sal_by_dept
(  v_deptno     IN      DEPT.DEPTNO%TYPE )
RETURN NUMBER
IS
    v_avg_sal   EMP.SAL%TYPE;
BEGIN
    -- 부서별 급여 평균을 AVG() 함수를 사용하여 구하고 저장
    SELECT avg(e.sal)
      INTO v_avg_sal
      FROM emp e
     WHERE e.DEPTNO = v_deptno
     ;
     
     -- 계산 결과를 반올림 하여 리턴
     RETURN ROUND(v_avg_sal);
END fn_avg_sal_by_dept;
/

-- 2. 컴파일 / 디버깅
-- Function FN_AVG_SAL_BY_DEPT이(가) 컴파일되었습니다.


-- 3. 이 함수를 사용하는 쿼리를 작성하여 실행해 본다.

SELECT fn_avg_sal_by_dept(10) as "부서 급여 평균"
  FROM dual
;
/*
부서 급여 평균
-------------
2917
*/
SELECT AVG(e.SAL)
  FROM emp e
 WHERE e.deptno = 10
;


-- 10번 부서의 급여 평균보다 높은 급여 평균을 받는 부서는?
SELECT e.DEPTNO
     , AVG(e.SAL) as "급여 평균"
  FROM emp e
 GROUP BY e.DEPTNO
HAVING AVG(e.SAL) > FN_AVG_SAL_BY_DEPT(30)
;


------------------------------------------------------------
-- SP / FN 에서 예외처리
------------------------------------------------------------
-- 예외 처리 : 


CREATE OR REPLACE PROCEDURE sp_get_emp_info_detail
(  v_empno      IN      emp.empno%TYPE
)
IS
    -- 1. RECORD 타입 선언
    TYPE emp_record_type IS RECORD
    (  r_empno       EMP.EMPNO%TYPE
     , r_ename       EMP.ENAME%TYPE
     , r_mgrname     EMP.ENAME%TYPE
     , r_dname       DEPT.DNAME%TYPE
     , r_loc         DEPT.LOC%TYPE
     , r_salgrade    SALGRADE.GRADE%TYPE
     );
    -- 2. 1에서 선언한 타입의 변수를 선언
    v_emp_record    emp_record_type;
       
BEGIN
    SELECT e.EMPNO
         , e.ENAME
         , e1.ENAME
         , d.DNAME
         , d.LOC
         , s.GRADE
      INTO v_emp_record
      FROM emp e
         , emp e1
         , dept d
         , salgrade s
     WHERE e.MGR = e1.EMPNO      -- mgr 배정 안된 직원
       AND e.DEPTNO = d.DEPTNO   -- dept 배정 안된 직원
       AND e.SAL BETWEEN s.LOSAL AND s.HISAL
       AND e.EMPNO = v_empno
    ;
    DBMS_OUTPUT.PUT_LINE('사 번 : ' || v_emp_record.r_empno);
    DBMS_OUTPUT.PUT_LINE('이 름 : ' || v_emp_record.r_ename);
    DBMS_OUTPUT.PUT_LINE('매 니 저 : ' || v_emp_record.r_mgrname);
    DBMS_OUTPUT.PUT_LINE('부 서 명 : ' || v_emp_record.r_dname);
    DBMS_OUTPUT.PUT_LINE('부서 위치 : ' || v_emp_record.r_loc);
    DBMS_OUTPUT.PUT_LINE('급여 등급 : ' || v_emp_record.r_salgrade);
    
    -- 5. NO_DATE_FOUND 예외 처리
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('!! 해당 직원의 매니저 혹은 부서가 배정되지 않았습니다. !!');
       
END sp_get_emp_info_detail;
/

EXEC sp_get_emp_info_detail(7839)
EXEC sp_get_emp_info_detail(6666)

/*
!! 해당 직원의 매니저 혹은 부서가 배정되지 않았습니다. !!
PL/SQL 프로시저가 성공적으로 완료되었습니다.

!! 해당 직원의 매니저 혹은 부서가 배정되지 않았습니다. !!
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 2. DUP_VAL_ON_INDEX
-- 문제) member 테이블에 member_id, member_name을 
--       입력 받아서 신규로 1행을 추가하는
--       sp_insert_member 작성

-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_insert_member
(  v_member_id   IN member.member_id%TYPE
 , v_member_name IN MEMBER.MEMBER_NAME%TYPE )
IS
BEGIN
    -- 입력된 IN모드 변수 값을 INSERT 시도
    INSERT INTO member (member_id, member_name)
    VALUES (v_member_id, v_member_name)
    ;
    COMMIT;
    -- 처리 내용을 화면 출력
    DBMS_OUTPUT.PUT_LINE(v_member_id || ' 신규 추가 진행');
    
    -- 입력시도에는 항상 DUP_VAL_ON_INDEX 예외 위험 존재
    EXCEPTION 
        WHEN DUP_VAL_ON_INDEX
        THEN -- 이미 종재하는 키의 값이면 신규 추가가 아니라
             -- 수정으로 진행
            UPDATE member m
               SET m.member_name = v_member_name
             WHERE m.member_id = v_member_id
            ;
            -- 처리 내용을 화면 출력
            DBMS_OUTPUT.PUT_LINE(v_member_id || '가 이미 존재하므로 멤버 정보 수정 진행');
END sp_insert_member;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_INSERT_MEMBER이(가) 컴파일되었습니다.

-- 3. EXEC
EXEC sp_insert_member('M13', '유재성');

SELECT m.*
  FROM member m
;