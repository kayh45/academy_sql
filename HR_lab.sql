--1. employees 테이블에서 job_id 를 중복 배제하여 조회 하고
--   job_title 같이 출력
--19건
SELECT DISTINCT e.JOB_ID
              , j.JOB_TITLE
  FROM employees e
     , jobs j
 WHERE e.JOB_ID = j.JOB_ID
;

--2. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터,
--   급여x커미션팩터(null 처리) 조회
--   커미션 컬럼에 대해 null 값이면 0으로 처리하도록 함
--107건
SELECT e.EMPLOYEE_ID                         as "사번"
     , e.LAST_NAME                           as "라스트네임"
     , e.SALARY                              as "급여"
     , NVL(e.COMMISSION_PCT, 0)              as "커미션 팩터"
     , NVL((e.SALARY * e.COMMISSION_PCT), 0) as "급여x커미션팩터"
  FROM employees e
;
 
--3. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터(null 값 처리) 조회
--   단, 2007년 이 후 입사자에 대하여 조회, 고용년도 순 오름차순 정렬
--30건
SELECT e.EMPLOYEE_ID                         as "사번"
     , e.LAST_NAME                           as "라스트네임"
     , e.SALARY                              as "급여"
     , NVL(e.COMMISSION_PCT, 0)              as "커미션 팩터"
     , NVL((e.SALARY * e.COMMISSION_PCT), 0) as "급여x커미션팩터"
  FROM employees e
 WHERE e.HIRE_DATE > TO_DATE('2007-01-01', 'YYYY-MM-DD')
 ORDER BY e.HIRE_DATE
;

--4. Finance 부서에 소속된 직원의 목록 조회
--조인으로 해결
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.LAST_NAME
  FROM employees e
     , departments d
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
   AND d.DEPARTMENT_NAME = 'Finance'
;
--서브쿼리로 해결
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.LAST_NAME
  FROM employees e
 WHERE e.DEPARTMENT_ID = (SELECT d.DEPARTMENT_ID
                     FROM departments d
                    WHERE d.DEPARTMENT_NAME = 'Finance')
;
/*
EMPLOYEE_ID, FIRST_NAME, LAST_NAME
----------------------------------
108	        Nancy	    Greenberg
109     	Daniel	    Faviet
110	        John	    Chen
111	        Ismael	    Sciarra
112	        Jose Manuel	Urman
113	        Luis	    Popp
*/
--6건
 
--5. Steven King 의 직속 부하직원의 모든 정보를 조회
--14건
-- 조인 이용
SELECT e1.*
  FROM employees e1
     , employees e2
 WHERE e1.MANAGER_ID = e2.EMPLOYEE_ID
   AND e2.FIRST_NAME = 'Steven'
   AND e2.LAST_NAME = 'King'
;
-- 서브쿼리 이용
SELECT *
  FROM employees e
 WHERE e.MANAGER_ID = (SELECT e.EMPLOYEE_ID
                         FROM employees e
                        WHERE e.FIRST_NAME = 'Steven'
                          AND e.LAST_NAME = 'King')
;
/*
EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
-----------------------------------------------------------------------------------------------------------------------------
101	    Neena	    Kochhar 	NKOCHHAR	515.123.4568	    05/09/21	AD_VP	17000		100	90
102	    Lex	        De Haan	    LDEHAAN	    515.123.4569	    01/01/13	AD_VP	17000		100	90
114 	Den	        Raphaely	DRAPHEAL	515.127.4561	    02/12/07	PU_MAN	11000		100	30
120	    Matthew	    Weiss	    MWEISS	    650.123.1234	    04/07/18	ST_MAN	8000		100	50
121	    Adam	    Fripp	    AFRIPP	    650.123.2234	    05/04/10	ST_MAN	8200		100	50
122	    Payam	    Kaufling	PKAUFLIN	650.123.3234	    03/05/01	ST_MAN	7900		100	50
123	    Shanta	    Vollman	    SVOLLMAN	650.123.4234	    05/10/10	ST_MAN	6500		100	50
124	    Kevin	    Mourgos	    KMOURGOS	650.123.5234	    07/11/16	ST_MAN	5800		100	50
145	    John	    Russell	    JRUSSEL	    011.44.1344.429268	04/10/01	SA_MAN	14000	0.4	100	80
146	    Karen	    Partners	KPARTNER	011.44.1344.467268	05/01/05	SA_MAN	13500	0.3	100	80
147	    Alberto	    Errazuriz	AERRAZUR	011.44.1344.429278	05/03/10	SA_MAN	12000	0.3	100	80
148	    Gerald	    Cambrault	GCAMBRAU	011.44.1344.619268	07/10/15	SA_MAN	11000	0.3	100	80
149	    Eleni	    Zlotkey	    EZLOTKEY	011.44.1344.429018	08/01/29	SA_MAN	10500	0.2	100	80
201	    Michael	    Hartstein	MHARTSTE	515.123.5555	    04/02/17	MK_MAN	13000		100	20
*/

--6. Steven King의 직속 부하직원 중에서 Commission_pct 값이 null이 아닌 직원 목록
--5건
SELECT e1.EMPLOYEE_ID                        "직원 사번"
     , e1.FIRST_NAME || ' ' || e1.LAST_NAME  "직원 이름"
     , e2.EMPLOYEE_ID                        "상사 사번"
     , e2.FIRST_NAME || ' ' || e2.LAST_NAME  "상사 이름"
  FROM employees e1
     , employees e2
 WHERE e1.MANAGER_ID = e2.EMPLOYEE_ID
   AND e2.FIRST_NAME = 'Steven'
   AND e2.LAST_NAME = 'King'
   AND e1.COMMISSION_PCT IS NOT NULL
;  
/*
직원 사번  직원 이름        상사 사번  상사 이름
------------------------------------------------
145	    John Russell	    100	    Steven King
146	    Karen Partners	    100	    Steven King
147	    Alberto Errazuriz	100	    Steven King
148	    Gerald Cambrault	100	    Steven King
149	    Eleni Zlotkey	    100	    Steven King
*/

--7. 각 job 별 최대급여를 구하여 출력 job_id, job_title, job별 최대급여 조회
--19건
SELECT e.JOB_ID
     , j.JOB_TITLE
     , MAX(e.SALARY)
  FROM employees e
     , jobs j
 WHERE e.JOB_ID = j.JOB_ID
 GROUP BY e.JOB_ID, j.JOB_TITLE 
 ORDER BY 1   
;
/*
JOB_ID,     JOB_TITLE,                  MAX(E.SALARY)
------------------------------------------------------
AC_ACCOUNT	Public Accountant	            8300
AC_MGR	    Accounting Manager	            12008
AD_ASST	    Administration Assistant	    4400
AD_PRES	    President	                    24000
AD_VP	    Administration Vice President	17000
FI_ACCOUNT	Accountant	                    9000
FI_MGR	    Finance Manager	                12008
HR_REP	    Human Resources Representative	6500
IT_PROG	    Programmer	                    9000
MK_MAN	    Marketing Manager	            13000
MK_REP	    Marketing Representative	    6000
PR_REP	    Public Relations Representative	10000
PU_CLERK	Purchasing Clerk	            3100
PU_MAN	    Purchasing Manager	            11000
SA_MAN	    Sales Manager	                14000
SA_REP	    Sales Representative	        11500
SH_CLERK	Shipping Clerk	                4200
ST_CLERK	Stock Clerk	                    3600
ST_MAN	    Stock Manager	                8200
*/


 
--8. 각 Job 별 최대급여를 받는 사람의 정보를 출력,
--  급여가 높은 순서로 출력
----서브쿼리 이용
SELECT e.JOB_ID
      , e.FIRST_NAME
      , e.LAST_NAME
      , e.SALARY
  FROM employees e
 WHERE (e.JOB_ID, e.SALARY) IN (SELECT e.JOB_ID
                                      , MAX(e.SALARY)
                                  FROM employees e
                                 GROUP BY e.JOB_ID)
 ORDER BY e.SALARY
;

----join 이용
SELECT e1.JOB_ID
      , e1.FIRST_NAME
      , e1.LAST_NAME
      , e1.SALARY
  FROM employees e1
      , (SELECT e.JOB_ID
               , MAX(e.SALARY) "최대 급여"
            FROM employees e
           GROUP BY e.JOB_ID) e2                       
 WHERE e1.JOB_ID = e2.JOB_ID
   AND e1.SALARY = e2."최대 급여"
 ORDER BY e1.SALARY
;

/*
JOB_ID  FIRST_NAME    LAST_NAME      SALARY
-----------------------------------------
PU_CLERK	Alexander	Khoo	    3100
ST_CLERK	Renske	    Ladwig	    3600
SH_CLERK	Nandita	    Sarchand	4200
AD_ASST	    Jennifer	Whalen	    4400
MK_REP	    Pat	Fay	    6000
HR_REP	    Susan	    Mavris	    6500
ST_MAN	    Adam	    Fripp	    8200
AC_ACCOUNT	William	    Gietz	    8300
IT_PROG	    Alexander	Hunold	    9000
FI_ACCOUNT	Daniel	    Faviet	    9000
PR_REP	    Hermann	    Baer	    10000
PU_MAN	    Den	        Raphaely	11000
SA_REP	    Lisa	    Ozer	    11500
FI_MGR	    Nancy	    Greenberg	12008
AC_MGR	    Shelley	    Higgins	    12008
MK_MAN	    Michael	    Hartstein	13000
SA_MAN	    John	    Russell	    14000
AD_VP	    Neena	    Kochhar	    17000
AD_VP	    Lex	        De Haan	    17000
AD_PRES	    Steven	    King	    24000
*/
--20건

--9. 7번 출력시 job_id 대신 Job_name, manager_id 대신 Manager의 last_name, department_id 대신 department_name 으로 출력
--20건

SELECT j.JOB_TITLE       "직무"
      , e.LAST_NAME       "사원이름"
      , d.DEPARTMENT_NAME "부서"
      , e1.LAST_NAME      "상사이름"
      , e.SALARY          "급여"
  FROM employees e
      , employees e1
      , jobs j
      , departments d
 WHERE (e.JOB_ID, e.SALARY) IN (SELECT e.JOB_ID
                                      , MAX(e.SALARY)
                                  FROM employees e
                                 GROUP BY e.JOB_ID)
   AND e.JOB_ID = j.JOB_ID
   AND e.DEPARTMENT_ID = d.DEPARTMENT_ID
   AND e.MANAGER_ID = e1.EMPLOYEE_ID(+)
 ORDER BY e.SALARY
;
/*
직무, 사원이름, 부서, 상사이름, 급여
----------------------------------------------------------
Purchasing Clerk	Khoo	Purchasing	Raphaely	3100
Stock Clerk	Ladwig	Shipping	Vollman	3600
Shipping Clerk	Sarchand	Shipping	Fripp	4200
Administration Assistant	Whalen	Administration	Kochhar	4400
Marketing Representative	Fay	Marketing	Hartstein	6000
Human Resources Representative	Mavris	Human Resources	Kochhar	6500
Stock Manager	Fripp	Shipping	King	8200
Public Accountant	Gietz	Accounting	Higgins	8300
Programmer	Hunold	IT	De Haan	9000
Accountant	Faviet	Finance	Greenberg	9000
Public Relations Representative	Baer	Public Relations	Kochhar	10000
Purchasing Manager	Raphaely	Purchasing	King	11000
Sales Representative	Ozer	Sales	Cambrault	11500
Finance Manager	Greenberg	Finance	Kochhar	12008
Accounting Manager	Higgins	Accounting	Kochhar	12008
Marketing Manager	Hartstein	Marketing	King	13000
Sales Manager	Russell	Sales	King	14000
Administration Vice President	Kochhar	Executive	King	17000
Administration Vice President	De Haan	Executive	King	17000
President	King	Executive		24000
*/


--10. 전체 직원의 급여 평균을 구하여 출력
SELECT AVG(e.SALARY)
  FROM employees e
;
--11. 전체 직원의 급여 평균보다 높은 급여를 받는 사람의 목록 출력. 급여 오름차순 정렬
--51건

SELECT *
  FROM employees e
 WHERE e.SALARY > (SELECT AVG(e.SALARY) "평균 급여"
                      FROM employees e)
 ORDER BY e.SALARY 
;
--12. 각 부서별 평균 급여를 구하여 출력
--12건

SELECT AVG(e.SALARY) "평균 급여"
  FROM employees e
 GROUP BY e.DEPARTMENT_ID
;
--13. 12번의 결과에 department_name 같이 출력
--12건
SELECT d.DEPARTMENT_NAME "부서"
      , TO_CHAR(AVG(e.SALARY), '$999,999.99') "평균 급여"
  FROM employees e
     , departments d
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
 GROUP BY e.DEPARTMENT_ID, d.DEPARTMENT_NAME
;
/*
부서                  평균 급여
-------------------------------
Finance	              $8,601.33
                      $7,000.00
Shipping	          $3,475.56
Public Relations	  $10,000.00
Purchasing	          $4,150.00
Executive	          $19,333.33
Administration	      $4,400.00
Accounting	          $10,154.00
Human Resources	      $6,500.00
Marketing	          $9,500.00
IT	                  $5,760.00
Sales	              $8,955.88
*/
--14. employees 테이블이 각 job_id 별 인원수와 job_title을 같이 출력하고 job_id 오름차순 정렬


--15. employees 테이블의 job_id별 최저급여,
--   최대급여를 job_title과 함께 출력 job_id 알파벳순 오름차순 정렬


 
--16. Employees 테이블에서 인원수가 가장 많은 job_id를 구하고
--   해당 job_id 의 job_title 과 그 때 직원의 인원수를 같이 출력




--17.사번,last_name, 급여, 직책이름(job_title), 부서명(department_name), 부서매니저이름
--  부서 위치 도시(city), 나라(country_name), 지역(region_name) 을 출력
----------- 부서가 배정되지 않은 인원 고려 ------


--18.부서 아이디, 부서명, 부서에 속한 인원숫자를 출력



--19.인원이 가장 많은 상위 다섯 부서아이디, 부서명, 인원수 목록 출력


 
--20. 부서별, 직책별 평균 급여를 구하여라.
--   부서이름, 직책이름, 평균급여 소수점 둘째자리에서 반올림으로 구하여라.



--21.각 부서의 정보를 부서매니저 이름과 함께 출력(부서는 모두 출력되어야 함)


 
--22. 부서가 가장 많은 도시이름을 출력



--23. 부서가 없는 도시 목록 출력
--조인사용

--집합연산 사용

--서브쿼리 사용

  
--24.평균 급여가 가장 높은 부서명을 출력



--25. Finance 부서의 평균 급여보다 높은 급여를 받는 직원의 목록 출력


-- 26. 각 부서별 인원수를 출력하되, 인원이 없는 부서는 0으로 나와야 하며
--     부서는 정식 명칭으로 출력하고 인원이 많은 순서로 정렬.



--27. 지역별 등록된 나라의 갯수 출력(지역이름, 등록된 나라의 갯수)



 
--28. 가장 많은 나라가 등록된 지역명 출력