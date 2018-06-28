-- (3) 단일행 함수
--- 6) CASE
-- job 별로 경조사비를 급여대비 일정 비율로 지급하고 있다.
-- 각 직원들의 경조사비 지원금을 구하자
/*
    CLERK       : 5%
    SALESMAN    : 4%
    MANAGER     : 3.7%
    ANALYST     : 3%
    PRESIDENT   : 1.5%
*/

-- 1. Simple CASE 구문으로 구해보자 : DECODE와 거의 유사, 동일비교만 가능
--                                   괄호가 없고, 콤마 대신 키워드 WHEN, THEN, ELSE 등을 사용
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE e.JOB WHEN 'CLERK'     THEN e.SAL * 0.05
                  WHEN 'SALESMAN'  THEN e.SAL * 0.04
                  WHEN 'MANAGER'   THEN e.SAL * 0.037
                  WHEN 'ANALYST'   THEN e.SAL * 0.03
                  WHEN 'PRESIDENT' THEN e.SAL * 0.015        
       END as "경조사 지원금"
  FROM emp e
;

-- 2. Searched CASE 구문으로 구해보자
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE WHEN e.JOB = 'CLERK'       THEN e.SAL * 0.05
            WHEN e.JOB = 'SALESMAN'    THEN e.SAL * 0.04
            WHEN e.JOB = 'MANAGER'     THEN e.SAL * 0.037
            WHEN e.JOB = 'ANALYST'     THEN e.SAL * 0.03
            WHEN e.JOB = 'PRESIDENT'   THEN e.SAL * 0.015
            ELSE 10
       END as "경조사 지원금"
  FROM emp e
;
-- CASE 결과에 숫자 통화 패턴 씌우기 : $ 기호, 숫자 세 자리 끊어읽기, 소수점 둘째자리까지
SELECT e.EMPNO
     , e.ENAME
     , nvl(e.JOB, '미지정') as job
     , TO_CHAR(CASE WHEN e.JOB = 'CLERK'       THEN e.SAL * 0.05
                    WHEN e.JOB = 'SALESMAN'    THEN e.SAL * 0.04
                    WHEN e.JOB = 'MANAGER'     THEN e.SAL * 0.037
                    WHEN e.JOB = 'ANALYST'     THEN e.SAL * 0.03
                    WHEN e.JOB = 'PRESIDENT'   THEN e.SAL * 0.015
               ELSE 10
       END, '$9,999.99') as "경조사 지원금"
  FROM emp e
;

/* SALGRADE 테이블의 내용 : 이 회사의 급여 등급 기준 값
---------------------
GRADE   LOSAL   HISAL
---------------------
1	    700 	1200
2	    1201	1400
3   	1401	2000
4	    2001	3000
5	    3001	9999
*/

-- 제공되는 급여 등급을 바탕으로 각 사원들의 급여 등급을 구해보자
-- CASE를 사용하여

SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL >= 700  AND e.SAL <= 1200 THEN 1
            WHEN e.SAL >= 1201 AND e.SAL <= 1400 THEN 2
            WHEN e.SAL >= 1401 AND e.SAL <= 2000 THEN 3
            WHEN e.SAL >= 2001 AND e.SAL <= 3000 THEN 4
            WHEN e.SAL >= 3001 AND e.SAL <= 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;

-- WHEN 안의 구분을 BETWEEN 으로 변경하여 작성

SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , CASE WHEN e.SAL BETWEEN 700   AND 1200 THEN 1
            WHEN e.SAL BETWEEN 1201  AND 1400 THEN 2
            WHEN e.SAL BETWEEN 1401  AND 2000 THEN 3
            WHEN e.SAL BETWEEN 2001  AND 3000 THEN 4
            WHEN e.SAL BETWEEN 3001  AND 9999 THEN 5
            ELSE 0
        END as "급여 등급"
  FROM emp e
 ORDER BY "급여 등급" DESC
;