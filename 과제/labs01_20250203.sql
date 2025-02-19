-- 프로젝션 : 원하는 열만 가져오도록 한다.
-- 직원 정보
select * from hr.employees;
-- 1. 직원번호, 이름 , 이메일, 입사일 
select employee_id, first_name, email, hire_date
from hr.employees;

-- 2. 직원번호, 이름 , 급여, 각 사원 급여에 100더하시오
select employee_id, first_name, salary, salary+100
from hr.employees;

-- 3. 직원번호, 성, 입사일, 직무, 연봉을 출력하시오
-- 각행에 있는 열에 수식을 사용가능
select employee_id, last_name, hire_date, job_id, salary*12
from hr.employees;

-- 부서정보
select * from hr.departments;
--- 4. 주소, 부서번호, 부서장번호, 부서명순으로 출력
-- 컬럼의 순서를 무작위로 사용가능
select location_id, department_id, MANAGER_ID, DEPARTMENT_NAME
from hr.departments;

-- 5. 사원테이블에서 직원번호 , 입사일, 성, 급여순으로 출력
-- 컬럼의 순서를 무작위로 사용가능
select employee_id, hire_date, last_name, salary
from hr.employees;

-- 6. 연산:
-- 사원테이블에서 사원번호, 부서번호 , 직무, 연봉을 출력하는데 
-- 매월 300씩 보너스가 지급이 된다.
select employee_id, department_id, job_id, (salary+300)*12
from hr.employees;

-- 7. 사원테이블에서 사원번호, 부서번호 , 직무, 연봉을 출력하는데 
-- 마지막 달에 300이 특별 보너스로 지급이 된다.
select employee_id, department_id, job_id, (salary*12)+300
from hr.employees;

-- 8. 사원테이블에서 사원번호, 성, 이메일 , 급여에 대한 커미션이 30%씩 지급이될 때
-- 커미션 까지 출력하시오.
select employee_id, last_name, email, salary, salary*0.3
from hr.employees;

-- 9.  사원테이블에서 직원번호 이메일 이름 입사일 급여, 커미션퍼센트를 출력
select employee_id, email, first_name, hire_date, salary, commission_pct
from hr.employees;

-- 10.  사원테이블에서 직원번호 이메일 이름 입사일 급여, 커미션퍼센트를 출력하는데
-- 각 사원이 받는 커미션의 금액도 같이 출력하시오.
select employee_id, email, first_name, hire_date, salary, commission_pct, salary*commission_pct
from hr.employees;

-- 11. 직원번호, 이메일, 이름, 입사일, 연락처, 부서번호, 급여, 커미션퍼센트, 
-- 그리고 커미션이 포한된 연봉을 출력하시오,
select employee_id, email, first_name, hire_date, phone_number, department_id, salary, commission_pct, salary * (1+ commission_pct)*12
from hr.employees;

--12.  heading name에 별칭 주기 (as를 사요하는 것과 사용하지 않는것을 혼합해 볼것) 
-- 사원번호 eid로 이메일, 성은 lname으로 입사일은 hd로 연락처는 ph로 부서번호는 did로 급여는 sal로 커미션은 comm으로
-- 커미션을 포함한 년봉은 year_sal로 별칭를 줘서 출력하시오. 단 eamil은 별칭을 주지 않는다.
select employee_id as eid, email, last_name lname, hire_date as hd
       , phone_number as ph, department_id did, salary as sal, commission_pct as comm
       , salary*(1+commission_pct)*12 as year_sal
from hr.employees;

-- 13. employee_id,  '나의 성은 last_name' , first_name , 급여를 출력하세요.
select employee_id, '나의 성은 last_name', first_name, salary
from hr.employees;

-- 14 사원번호, 이름 급여 부서번호를 출력할 때  리터널 날짜 2021-11-19와 숫자 35를  같이 출력하세요.,
select employee_id, first_name, salary, department_id, '2021-11-19', 35
from hr.employees;

--- 15. 직원번호, last_name first_name(KingSteven),급여, 직무 출력
select employee_id, last_name || first_name, salary, job_id
from hr.employees;

--16. 15번문제에서 성과 이름에 공백문자를 넣자.
select employee_id, last_name ||' '|| first_name, salary, job_id
from hr.employees;

-- 17. 사원번호와 급여를 출력하는 사이에 아래 내용이 출력되게 하시오. 
-- "KingSteven의 직무는 AD_PRES입니다"로 출력하자.
select employee_id, last_name || first_name || '의 직무는 ' || job_id ||'입니다.', salary
from hr.employees;

-- 18. 직원의 부서번호만 출력하시오.
select department_id from hr.employees;

-- 19. 직원의 부서를 모두 출력하지 말고 한번씩만 출력하시오.
--     직원이 속해있는 부서가 어떠한 부서들인지 알고 싶다.
select distinct department_id from hr.employees;

-- 20.직무와 부서가 같은 직원 정보는 한번만 출력하시오.
select distinct job_id, department_id from hr.employees; 

---21. 직무와 입사일이 중복되지 않게 출력하시오.
select distinct job_id, hire_date from hr.employees; 

-- 22. 90인 부서의 사원들을 출력하시오. 
select * 
from hr.employees
where department_id = 90;

-- 23. 사원번호, 성, 이름, 급여를 출력
select employee_id, last_name, first_name, salary
from hr.employees;

-- 24. 90인 부서의 사원들을 출력할 때 사원번호, 이름 , 성, 급여 출력
select employee_id, first_name, last_name, salary
from hr.employees
where department_id = 90;

-- 25. 이름이 'Nancy'인 사원의 입사일 , 직무, 급여, 커미션퍼센트를 출력하세요.
-- 문자열 리터널인 경우에는 대소문자를 구분하여 사용해야 한다.
select hire_date, job_id, salary, commission_pct
from hr.employees
where first_name = 'Nancy';

-- 26. 입사일이 06/01/03인 사원을 출력하시오.
select *
from hr.employees
where hire_date = '06/01/03';

-- 비교 연산(관계연산) :  =, >, >=, <, <=, <>, !=, ^=
-- 27. 급여가 3000이상인 사원들의 성, 급여를 출력하시오.
select last_name, salary
from hr.employees
where salary >= 3000;

-- 28. 입사일이 06/01/03보다 늦게 입사한 직원의 사원번호 이름 급여를 출력하시오.
select employee_id, first_name, salary
from hr.employees
where hire_date > '06.01.03';

-- 30. 급여가 3000이 아닌 사원을 모두 출력하시오.
select *
from hr.employees
where salary != 3000;
--where salary <> 3000;
--where salary ^= 3000;

-- 31. 급여가 2500에서 3500사이인 사원들 중 사원번호와 이름, 급여, 직무, 입사일을 출력
select employee_id, first_name, salary, job_id, hire_date
from hr.employees
where salary >= 2500 and salary <= 3500;
--where salary between 2500 and 3500;

-- 32. 성이 King부터  Smith사이에 있는 사원들을 출력하시오.
select * 
from hr.employees
where last_name >= 'King' and last_name <= 'Smith';
--where last_name Between 'King' and 'Smith';

-- 33. 입사일이 02/06/07부터 06/01/03사이에 입사한 사원들을 출력하시오.
select *
from hr.employees
where hire_date >= '02/06/07' and hire_date <= '06/01/03';
--where hire_date between '02/06/07' and '06/01/03';

-- 34. 50, 70, 90인 부서의 사원들을 출력하세요.
select *
from hr.employees
where department_id in (50, 70, 90);
--where department_id = 50 or department_id = 70, department_id = 90;

-- 35. 상사가 100,101,102인 사원들을 구하시오.
select *
from hr.employees
where manager_id in (100, 101, 102);

-- 36. 성이 'Hartstein', 'Vargas'인 사원들을 출력하시오.
select *
from hr.employees
where last_name in ('Hartstein', 'Vargas');

-- 37. 사장의 직원번호는 100번이다. 사장이 직속상사인 사원은?
select *
from hr.employees
where manager_id = 100;


