-- 100, 101, 201인 상사를 둔 직원들을 모두 출력하시오
select * from hr.employees
where manager_id in (100, 101, 102);

-- 100, 101, 201이 아닌 상사를 둔 직원들을 모두 출력하시오
select * from hr.employees
where manager_id not in (100, 101, 102);

-- 50인 부서와 60인 부서와 70인 부서의 직원을 구하시오
select * from hr.employees
where department_id in (50, 60, 70);

-- 50인 부서와 60인 부서와 70인 부서가 아닌 직원을 구하시오
select * from hr.employees
where department_id not between 50 and 70;

-- 03/06/17, 01/01/13, 07/03/17에 입사하지 않은 직원들을 출력하시오
select * from hr.employees
where hire_date != '03/06/17' and hire_date != '01/01/13' and hire_date != '07/03/17'; //not일 때 and 사용

select * from hr.employees
where hire_date not in('03/06/17', '01/01/13', '07/03/17');

-- 급여가 3000미만이고 10000을 초과한 직원들을 구하시오. 비교연산자
select * from hr.employees
where salary < 3000 or salary > 10000; 

select * from hr.employees
where salary not between 3000 and 10000; 

-- 부서가 없는 직원을 출력하시오
//null은 알 수 없는 값이므로 = 을 사용하지 않고 is를 사용한다.
select * from hr.employees where department_id is null;

-- 부서를 가진 직원들을 출력하시오
select * from hr.employees where department_id is not null;

-- 성이 'K'로 시작하는 모든 사원들 like, %
select * from hr.employees where last_name like 'K%';

-- 성이 'g'로 끝나는 모든 사원들 like, %
select * from hr.employees where last_name like '%g';

-- 성이 'g'를 포함한 직원
select * from hr.employees where last_name like '%g%';

-- 성이 'in'를 포함한 직원
select * from hr.employees where last_name like '%in%';

-- 성이 'in'를 포함하지 않는 직원
select * from hr.employees where last_name not like '%in%';

-- 성에 두 번째가 글자가 u인 사원을 출력하시오
// _는 한 글자 아무거나 와도 됨
select * from hr.employees where last_name like '_u%';

-- 성에 세 번째가 글자가 u인 사원을 출력하시오
select * from hr.employees where last_name like '__u%';

-- 성에 뒤에서 두 번째가 글자가 i인 사원을 출력하시오
select * from hr.employees where last_name like '%i_';

-- 성에 u와 i사이에 한 글자를 포함하는 사원들을 출력하시오
select * from hr.employees where last_name like '%u_i%';

-- 직무번호가 'AC_ACCOUNT'것을 출력하시오
select * from hr.employees where job_id = 'AC_ACCOUNT';

-- AC_로 시작하는 직무를 가진 사원들을 구하시오
// escape '\'은 자바의 \n과 마찬가지로 다른 의미로 사용할 때 씀. 본연의 의미를 사용하지 않음
select * from hr.employees where job_id like 'AC\_%' escape '\';

-- 직무가 D_P를 포함한 사원들을 하시오
select * from hr.employees where job_id like '%D\_P%' escape '\';

-- and 연산자, or 연산자
-- 사원번호, 성, 직무, 급여를 출력할 때 급여가 10000 이상이면서 직무가 MK_MAN인 사원 출력하시오
select employee_id, last_name, job_id, salary
from hr.employees
where salary >= 10000 and job_id = 'MK_MAN';

-- 사원번호, 성, 직무, 급여를 출력할 때 급여가 10000 이상이면서 직무가 MK_MAN인 사원 출력하시오
select employee_id, last_name, job_id, salary
from hr.employees
where salary >= 10000 and job_id like '%MAN';

-- 급여가 10000 이상인 사원과 직무가 MK_MAN인 사원인 사원을 출력하시오
select *
from hr.employees
where salary >= 10000 or job_id = 'MK_MAN';

-- 사원번호, 성, 직무, 급여를 출력할 때 급여가 10000 이상인 직원과 직무가 MK_MAN인 사원 출력하시오
select employee_id, last_name, job_id, salary
from hr.employees
where salary >= 10000 or job_id like '%MAN';

-- 직원 테이블에서 성, 직무번호, 급여를 출력할 때 급여가 15000이면서 직무가 'SA_REP', 'AD_PRES'
-- and와 or의 우선순위 : and가 우선순위가 높다
-- 원래 결과 안 나옴
select last_name, job_id, salary
from hr.employees
where salary = 15000 and job_id = 'SA_REP' or salary = 15000 and job_id = 'AD_PRES';

select last_name, job_id, salary
from hr.employees
where salary = 15000 and (job_id = 'SA_REP' or job_id = 'AD_PRES');

select last_name, job_id, salary
from hr.employees
where salary = 15000 and job_id in ('SA_REP', 'AD_PRES');

/*
select
from
where
order by
*/

-- 정렬 오름차순(ascending) : asc, 내림차순(descending) : desc
--desc hr.employees;
--DESCRIBE hr.employees;

//department_id를 기준으로 오름차순, asc 연산자를 생략할 수 있음
select * from hr.employees order by department_id;
select * from hr.employees order by department_id asc;

//내림차순
select * from hr.employees order by department_id desc;

-- 입사일 빠른 사원부터 출력
select * from hr.employees order by hire_date asc;

----------
/*
select last_name, job_id as jobs, department_id, hire_date
from hr.employees
where jobs = 'SA_REP'; //where절에는 별칭을 사용할 수 없다
*/

select last_name, job_id as jobs, department_id, hire_date
from hr.employees
order by job_id asc; //기준이 될 컬럼 명 사용 가능

select last_name, job_id as jobs, department_id, hire_date
from hr.employees
order by jobs asc; //order by에서는 별칭도 사용 가능하다

select last_name, job_id as jobs, department_id, hire_date
----      1             2               3           4
from hr.employees
order by 2; //열 번호를 order by절에 사용 가능하다.

-- 사번, 이름, 연봉을 출력하시오
select employee_id, first_name, salary*12
from hr.employees;

-- 사번, 이름, 연봉을 출력할 때 연봉을 많이 받는 사람부터 출력하세요
select employee_id, first_name, salary*12
from hr.employees
order by salary*12 desc;

select employee_id, first_name, salary*12
from hr.employees
order by 3 desc;

select employee_id, first_name, salary*12 as year_sal
from hr.employees
order by year_sal desc;

------------
select * from hr.employees
order by department_id;

-- 부서를 오름차순으로 정렬한 후 입사일을 오름차순으로 정렬
select * from hr.employees
order by department_id, hire_date;



-- 이름, 부서번호, 급여를 출력하는 데 부서번호는 오름차순을하고
-- 같은 부서의 있는 직원의 급여는 내림차순으로 정렬하여 출력하시오
select first_name, department_id, salary
from hr.employees
order by department_id asc, salary desc;

select first_name, department_id, salary
from hr.employees
order by department_id, salary desc;

select first_name, department_id, salary
from hr.employees
order by 2, 3 desc;

-- 부서 80인 직원의 사원번호, 이름, 부서번호, 입사일을 출력
select employee_id, first_name, department_id, hire_date
from hr.employees
where department_id = 80;

-- 부서 80인 직원의 사원번호, 이름, 부서번호, 입사일을 출력할 때 입사일이 늦은 사람부터 출력하시오
select employee_id, first_name, department_id, hire_date
from hr.employees
where department_id = 80
order by 4 desc;

-- 사원번호, 이름, 직무, 입사일, 급여, 부서번호를 출력할 때 입사일이 02/08/17 이후인 사원 중에서
-- 입사일이 빠른 직원부터 출력할 때 입사일이 같은 직원의 급여는 받는 직원부터 출력
select employee_id, first_name, hire_date, salary, department_id
from hr.employees
where hire_date  >= '02/08/17'
order by hire_date, salary desc;

-- 대소문자 변화 함수
select last_name, lower(last_name), upper(last_name), job_id, lower(job_id), initcap(job_id) 
from hr.employees;

-- 성이 'abel'이라는 직원을 출력
select * from hr.employees
where lower(last_name) = 'abel';

select * from hr.employees
where last_name = initcap('abel');
-- 'ABEL'
select * from hr.employees
where last_name = initcap('ABEL');

-- 100, KingSteven, 24000으로 출력
select employee_id, last_name || first_name, salary
from hr.employees;

select employee_id, concat(last_name, first_name), salary
from hr.employees;

-- 직원 사원번호, 성, 이름, 급여를 출력할 때 성과 급여는 붙여서 출력하시오
select employee_id, last_name || salary
from hr.employees;

select employee_id, concat(last_name, salary)
from hr.employees;

-- 예를 들어 : "KingSteven입니다."로 출력 하시오. 단, concat만 사용
select concat(concat(last_name, first_name),'입니다.')
from hr.employees;

select concat(last_name, concat(first_name,'입니다.'))
from hr.employees;




