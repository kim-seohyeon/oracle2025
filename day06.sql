-- 직원이 속해 있는 부서 정보를 가져오시오.
select employee_id, first_name, job_id, salary, e.department_id, e.manager_id -- 직속상사 -- 직원번호
        , d.department_id, department_name, d.manager_id -- 부서장 --직원번호
from hr.employees e inner join hr.departments d on e.department_id = d.department_id;
                                                    -- 90           =       90

-- 부서장의 이름과 같은정보를 가져오시오
-- 부서 테이블에 있는 부서장의 이름과 직무 급여를 가져오시오
select d.department_id, department_name, d.manager_id -- 부서장: 직원번호
        , first_name, e.job_id, salary
from hr.departments d join hr.employees e on d.manager_id = e.employee_id;

select d.department_id, department_name, d.manager_id -- 부서장: 직원번호
        , first_name, e.job_id, salary
from hr.departments d join hr.employees e on d.manager_id = e.employee_id and d.department_id = e.department_id;

-- 부서장을 직속 상사로 둔 사원의 정보
select employee_id, first_name, salary, job_id, e.department_id, e.manager_id -- 직속 상사
        , d.department_id, department_name, d.manager_id -- 부서장
from hr.employees e join hr.departments d on e.manager_id = d.manager_id and d.department_id = e.department_id;

-- natural join : 두 개 이상의 테이블에서 같은 이름의 컬럼끼리 비교를 하는 join
select employee_id, first_name, salary, job_id, department_id, manager_id -- 직속 상사
        , department_id, department_name, manager_id -- 부서장
from hr.employees natural join hr.departments;

-- using절 사용: using절에 들어간 컬럼에는 테이블 별칭을 사용할 수 없다.
select employee_id, first_name, salary, job_id, department_id, manager_id -- 직속 상사
        , department_id, department_name, manager_id -- 부서장
from hr.employees e join hr.departments d
-- on e.manager_id = d.manager_id and d.department_id = e.department_id;
using(manager_id, department_id);

select employee_id, first_name, salary, job_id, e.department_id, manager_id -- 직속 상사
        , d.department_id, department_name, manager_id -- 부서장
from hr.employees e join hr.departments d 
-- on e.manager_id = d.manager_id;
using(manager_id);

-- using절을 사용해서 사원번호, 이름, 급여, 직무, 부서번호, 부서명, 부서장
--- 직원이 속해 있는 부서정보를 가져오시오
select employee_id, first_name, salary, job_id
        , department_id, department_name, d.manager_id
from hr.employees e join hr.departments d
using(department_id);

-- 사원번호, 부서번호, 이름, 직무번호
-- 직무번호, 직무내용
-- inner join, using, natural, t-sql
select employee_id, department_id, first_name
        , j.job_id, job_title
from hr.employees e inner join hr.jobs j on e.job_id = j.job_id;

select employee_id, department_id, first_name
        , job_id, job_title
from hr.employees e inner join hr.jobs j 
using(job_id);

select employee_id, department_id, first_name
        , job_id, job_title
from hr.employees natural join hr.jobs;

select employee_id, department_id, first_name
        , j.job_id, job_title
from hr.employees e, hr.jobs j
where e.job_id = j.job_id;

-- 각 직원의 직원번호, 직무번호, 부서번호, 부서명
-- t-sql, ansi join, using
select employee_id, job_id
        , d.department_id, department_name
from hr.employees e, hr.departments d 
where e.department_id = d.department_id and d.department_id in (20, 30, 50, 80);

select employee_id, job_id
        , d.department_id, department_name
from hr.employees e join hr.departments d on e.department_id = d.department_id
where d.department_id in(20, 30, 50, 80);

select employee_id, job_id
        , department_id, department_name
from hr.employees e join hr.departments d
using(department_id)
where department_id in(20, 30, 50, 80);

-- 직원번호, 이름, 급여, 직무, 입사일
-- 부서번호, 부서명을 출력할 때 50인 부서와 90인 부서는 제외한다
-- inner join, using
select employee_id, first_name, salary, job_id, hire_date
        , d.department_id, department_name
from hr.employees e inner join hr.departments d on e.department_id = d.department_id
where d.department_id not in (50,90);

select employee_id, first_name, salary, job_id, hire_date
        , department_id, department_name
from hr.employees e inner join hr.departments d
using(department_id)
where department_id not in (50,90);

-- 3중 조인
-- 직원의 직무 정보와 부서정보를 가져오시오
-- jobs, employees, departments
select *
from hr.jobs j join hr.employees e on j.job_id = e.job_id
                join hr.departments d on e.department_id = d.department_id;

-- 직무번호, 직무명
-- 직무번호, 사원번호, 이름, 부서번호
-- 부서번호, 부서명
-- t-sql join, ansi join
select j.job_id, job_title
        , employee_id, first_name
        , d.department_id, department_name
from  hr.jobs j , hr.employees e, hr.departments d  where j.job_id = e.job_id and d.department_id = e.department_id;

select j.job_id, job_title
        , employee_id, first_name, e.department_id
        , department_name
from  hr.jobs j join hr.employees e on j.job_id = e.job_id
                join hr.departments d on e.department_id = d.department_id;

-- 직원정보와 직원의 직무정보와 직원의 부서정보 그리고 부서의 지역정보 그리고 지역의 나라 정보를 가져오고
-- 그 나라의 대륙 정보도 출력하시오
-- jobs : job_id, job_title
-- employees : employee_id, first_name, salary
-- departments : department_id, department_name, manager_id
-- locations : location_id, street_address
-- countries : country_id, country_name
-- regions : region_id, region_name
select j.job_id, job_title
        , employee_id, first_name, salary
        , d.department_id, department_name, d.manager_id
        , l.location_id, street_address
        , c.country_id, country_name
        , r.region_id, region_name
from hr.jobs j join hr.employees e on j.job_id = e.job_id
               join hr.departments d on e.department_id = d.department_id
               join hr.locations l on d.location_id = l.location_id
               join hr.countries c on l.country_id = c.country_id
               join hr.regions r on c.region_id = r.region_id;

-- self join
-- 직원의 정보를 출력하면서 직원의 직속 상사의 정보도 같이 출력
select e1.employee_id, e1.first_name, e1.salary, e1.manager_id -- 직원의 정보
        , e2.employee_id, e2.first_name, e2.job_id -- 상사정보
from hr.employees e1 join hr.employees e2 on e1.manager_id = e2.employee_id;

select * from hr.employees; -- 107
select * from hr.departments; -- 27

-- 직원에 대한 부서 정보를 가져오시오
select employee_id, first_name, salary
        , d.department_id, department_name
from hr.employees e left outer join hr.departments d on e.department_id = d.department_id;

select employee_id, first_name, salary
        , d.department_id, department_name
from hr.departments d right outer join hr.employees e on e.department_id = d.department_id;

select employee_id, first_name, salary
        , d.department_id, department_name
from hr.departments d, hr.employees e 
where e.department_id = d.department_id(+);

select employee_id, first_name, salary
        , d.department_id, department_name
from hr.departments d left outer join hr.employees e on e.department_id = d.department_id;

select employee_id, first_name, salary
        , d.department_id, department_name
from hr.departments d, hr.employees e 
where e.department_id(+) = d.department_id;

-- 직원 테이블의 모든 직원 정보와 부서 테이블의 모든 부서 정보를 출력되게 하시오
select employee_id, first_name, salary
        , d.department_id, department_name
from hr.departments d full outer join hr.employees e on e.department_id = d.department_id;

-- join : T-SQL join, ansi join(=inner join), natural join, inner join에 using절
--          , 다중 조인, self join, outer join(left, right, full)

-- sub query
-- 사원들 중 급여가 제일 많이 받는 사원의 사원번호, 이름, 급여, 직무, 입사일을 출력하시오
select max(salary) from hr.employees;
select * from hr.employees where salary = 24000;
select * from hr.employees where salary = (select max(salary) from hr.employees);

-- 90인 부서에 최대 급여를 사원의 급여는?
select max(salary) from hr.employees where department_id = 90;

-- 90인 부서에 최대 급여를 사원의 이름, 사원번호, 직무, 입사일을 출력
select employee_id, first_name, job_id, hire_date 
from hr.employees 
where salary = (select max(salary) from hr.employees where department_id = 90);

-- 성이 Abel의 급여와 같은 직원을 출력
select * from hr.employees
where last_name = 'Abel';

select salary from hr.employees where salary = 11000;

select * from hr.employees 
where salary = (select salary from hr.employees where last_name = 'Abel');

-- 사원번호 103인 직원의 상사와 같은 상사를 둔 직원의 이름, 사번, 부서, 상사번호를 출력
select manager_id from hr.employees where employee_id = 103;

select first_name, employee_id, department_id, manager_id from hr.employees where manager_id = 102;

select first_name, employee_id, department_id, manager_id
from hr.employees where manager_id = (select manager_id from hr.employees where employee_id = 103);

-- 90인 부서의 평균 급여보다 더 많이 받는 사원의 성, 직무, 사번, 부서를 출력
select avg(salary) from hr.employees
where department_id = 90;

select last_name, job_id, employee_id, department_id
from hr.employees
where salary > 19333.33333333333333;

select last_name, job_id, employee_id, department_id
from hr.employees
where salary > (select avg(salary) from hr.employees where department_id = 90);

-- 성이 Rogers인 사원의 급여를 출력하시오
select salary from hr.employees
where last_name = 'Rogers';

-- 성이 Rogers인 사원의 직무를 출력하시오
select job_id from hr.employees
where last_name = 'Rogers'; 

-- 급여가 2900이고 직무가 ST_CLERK인 사원들의 이름, 직무, 급여, 입사일을 출력
select first_name, job_id, salary, hire_date
from hr.employees 
where salary = 2900 and job_id = 'ST_CLERK';

-- 성이 Rogers인 사원의 급여와 직무를 출력
select first_name, job_id, salary, hire_date
from hr.employees 
where salary = (select salary 
                from hr.employees
                where last_name = 'Rogers') 
   and job_id = (select job_id 
                 from hr.employees
                 where last_name = 'Rogers');

-- 단일 행 서브쿼리 : =, <, >, >=, <=, <>
-- 성이 Kumar인 사원의 직무와 같고 Kumar인 사원보다 입사일이 빠른 사원들의
-- 성, 이름, 직무, 입사일, 부서를 출력하시오
select last_name, first_name, job_id, hire_date, department_id
from hr.employees
where job_id = (select job_id from hr.employees where last_name = 'Kumar')
and hire_date < (select hire_date from hr.employees where last_name = 'Kumar');

-- 30인 부서에서 수행하는 직무들을 출력하시오
select distinct job_id from hr.employees
where department_id = 30;

-- 30인 부서에서 수행하는 직무와 같은 직무를 하는 직원을 출력
select * from hr.employees
where  job_id in('PU_MAN', 'PU_CLERK');

-- 다중행 서브쿼리: 하나 이상의 결과를 가져오는 서브쿼리 : in
select * from hr.employees
where  job_id in(select distinct job_id 
                 from hr.employees
                 where department_id = 30);

-- 각 부서의 최소급여에 해당하는 사원들의 모든 정보를 출력하는데 30, 80, 90인 부서는 제외하고
-- 직무가 'RE'를 포함하는 직무도 제외한다.
select min(salary) 
from hr.employees 
group by department_id;

select * 
from hr.employees 
where salary in (select min(salary) -- 각 부서의 최소 급여
                 from hr.employees 
                 group by department_id) 
             and department_id not in (30, 80, 90)
             and job_id not like '%RE%';

-- 직원번호가 104인 직원의 직무와 같고 각 부서의 최대 급여에 해당하는 직원의 모든 정보를 출력
select job_id from hr.employees where employee_id = 104; -- IT_PROG
-- 각 부서의 최대 급여
select max(salary) from hr.employees group by department_id; -- 24000

select * 
from hr.employees
where job_id = (select job_id 
                from hr.employees 
                where employee_id = 104)
 and salary in (select max(salary) 
                from hr.employees   -- 다중행 서브쿼리, 결과값이 여러개일 때: in 사용 
                group by department_id);












