-- job_id가 FI_ACCOUNT이고 IT_PROG 그리고 PU_CLERK 직원의
-- 급여의 평균, 급여의 합계, 최댓값, 최솟값, 직원 수를 출력하시오
select job_id, avg(salary), sum(salary), max(salary), min(salary), count(*)
from hr.employees
where job_id in ('FI_ACCOUNT', 'IT_PROG', 'PU_CLERK')
group by job_id;

-- 직원들의 모든 정보를 출력할 때 부서를 오름차순으로 정렬하고
-- 정렬된 같은 부서안에서 다른 직무하는 직원이 있다면 직무를 오름차순으로 정렬
select *
from hr.employees
order by department_id, job_id;

select department_id, job_id, sum(salary), avg(salary), min(salary), max(salary), count(*)
from hr.employees
group by department_id, job_id;
-- group by 절에 있는 컬럼들은 select 절에 사용할 수 있다

-- 부서별 평균 급여를 출력하시오
select department_id, avg(salary)
from hr.employees
group by department_id;

-- 이때 평균급여가 8000을 초과한 부서와 평균 급여는?
select department_id, avg(salary)
from hr.employees
group by department_id
having avg(salary) > 8000
order by department_id;
-- 그룹함수는 group by 다음에 실행되므로 group by 이전에 실행되는
-- where절에서 그룹함수를 조건을 사용하지 못 함 => having을 사용함

-- 직무별 최대 급여, 최소 급여, 급여의 합계, 직원 수를 출력할 때
-- 직무별 직원의 수가 3 이상인 것만 출력하시오
select job_id, max(salary), min(salary), sum(salary), count(*)
from hr.employees
group by job_id
having count(employee_id) >= 3;

-- REP를 포함하지 않고 있지 않은 직무들 중에서 각 직무별 최대 급여, 최소 급여, 급여 합계를 출력하시오
-- 이때 급여 합계가 13000 이상인 것만 출력하시오
-- 단, 급여의 합계가 많은 것부터 출력
select job_id, max(salary), min(salary), sum(salary)
--          1       2           3           4
from hr.employees
where job_id not like '%REP%' -- 컬럼
group by job_id
having sum(salary) >= 1300 --그룹함수 조건
-- order by 4 desc;
order by sum(salary) desc;

-- 각 부서별 부서의 급여의 합계, 최대, 최소, 사원의 수 , 평균을 출력하는데
-- 평균을 소수점 2자리만 출력
select department_id, sum(salary), max(salary), min(salary), count(*), trunc(avg(salary),2)
from hr.employees
group by department_id;

-- 부서에서 같은 직무를 하는 사원들의 최대 급여, 최소 급여
-- 평균 급여, 급여의 합계, 같은 직무를 하는 사원의 수를 출력
select department_id, job_id, max(salary), min(salary), avg(salary), sum(salary), count(*)
from hr.employees
group by department_id, job_id -- 컬럼명만 쓸 수 있음
order by department_id;

-- 각 부서에서 직무가 같은 사원들 중 입사일이 같은 사원의 수를 구하시오
-- 사원 수가 2명 이상만 출력
-- 단, 80인 부서만 출력
select department_id, job_id, hire_date, count(*)
from hr.employees
where department_id = 80
group by department_id, job_id, hire_date 
-- department_id는 안 써도 됨. 왜? where절에서 department_id가 80인 걸 아니까
having count(employee_id) >= 2;

-- 각 부서의 평균 급여가 7000이상인 부서만 출력하시오. 평균 급여가 높은 것부터 출력하시오.
select department_id, avg(salary)
from hr.employees
group by department_id
having avg(salary) >= 7000
order by avg(salary) desc;

-- 각 부서의 평균 급여 중 최대 평균 급여를 출력하시오
select max(avg(salary))
from hr.employees
group by department_id;

-- 단일함수: 문자열 함수, 일반함수(nvl, nvl2, coreleces?), 변환함수(to_number, to_char, to_date)
-- 다중함수: 그룹함수(max, min, sum, svg, count)

-- join: 두 개 이상의 데이블로부터 데이터를 가져오는 것
select employee_id, job_id, salary, department_id
from hr.employees;
select department_id, department_name
from hr.departments;

select employee_id, job_id, salary, hr.employees.department_id
        , hr.departments.department_id, hr.departments.department_name
from hr.employees join hr.departments
on hr.employees.department_id = hr.departments.department_id; -- join 조건 on

select employee_id, job_id, salary, e.department_id
        , d.department_id, d.department_name
from hr.employees e join hr.departments d
on e.department_id = d.department_id; 

-- join
-- 사원번호, 이름, 급여, 부서번호, 직무번호
-- 직무 번호, 직무명
select employee_id, first_name, salary, department_id, e.job_id
        , j.job_id, job_title
from hr.employees e join hr.jobs j
on e.job_id = j.job_id;

-- ansi-join
-- e.job_id 하나 지워도 됨
select employee_id, first_name, salary, department_id
        , j.job_id, job_title
from hr.employees e join hr.jobs j
on e.job_id = j.job_id;

-- T-SQL join
-- where절 쓰고 싶음 -> join on 없애고 , where
select employee_id, first_name, salary, department_id
        , j.job_id, job_title
from hr.employees e , hr.jobs j
where e.job_id = j.job_id;

-- T-SQL join
-- 사원번호, 이름, 급여, 직무, 부서번호, 부서명
select employee_id, first_name, salary, d.department_id, department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id;

-- 부서번호, 부서명, 부서장 출력
select department_id, department_name, manager_id
from hr.departments;

-- 직원번호, 성, 이름, 직무 출력
select employee_id, last_name, first_name, job_id
from hr.employees;

-- 부서번호, 부서명, 부서장, 부서장의 성, 부서장의 이름, 부서장의 직무를 출력
select e.department_id, department_name, e.manager_id, employee_id, last_name, first_name, job_id
from hr.departments d join hr.employees e
on d.manager_id = e.employee_id;

select e.department_id, department_name, e.manager_id, employee_id, last_name, first_name, job_id
from hr.departments d, hr.employees e
where d.manager_id = e.employee_id;

-- 부서번호, 부서명, 지역번호(location_id)
select department_id, department_name, location_id
from hr.departments;

-- 주소명(street_address), 우편번호(postal_code) : locations
select street_address, postal_code
from hr.locations;

-- 부서번호, 부서명, 지역번호에 해당하는 주소명, 우편번호 출력
-- anti-join
select department_id, department_name, d.location_id, street_address, postal_code
from hr.departments d join hr.locations l
on d.location_id = l.location_id;

-- T-SQL join
select department_id, department_name, d.location_id, street_address, postal_code
from hr.departments d, hr.locations l
where d.location_id = l.location_id;

-- 부서번호, 부서명, 지역번호에 해당하는 주소명, 우편번호를 같이 출력하고 싶다.
-- 이때 100인 부서만 출력하시오
-- T-SQL join
select department_id, department_name
        , d.location_id, street_address, postal_code
from hr.departments d, hr.locations l
where d.location_id = l.location_id and department_id = 100;

-- ansi-join
select department_id, department_name
        , d.location_id, street_address, postal_code
from hr.departments d join hr.locations l
on d.location_id = l.location_id
where department_id = 100;

-- 직무명, 최소 급여, 최대 급여: jobs
select job_title, min_salary, max_salary
from hr.jobs;

-- 직무번호, 시작일, 마친일, 부서번호: job_history
select job_id, start_date, end_date, department_id
from hr.job_history;

-- 부서번호, 부서명: departments
select department_id, department_name
from hr.departments;

-- t-sql join
select job_title, min_salary, max_salary
        , jh.job_id, start_date, end_date, jh.department_id
        , d.department_id, department_name
from hr.jobs j, hr.job_history jh, hr.departments d
where j.job_id = jh.job_id and jh.department_id = d.department_id;

-- ansi join
select job_title, min_salary, max_salary
        , jh.job_id, start_date, end_date, jh.department_id
        , d.department_id, department_name
from hr.jobs j join hr.job_history jh on j.job_id = jh.job_id
               join hr.departments d  on jh.department_id = d.department_id;

-- 직무명, 최소급여, 촤대급여
-- 직무번호, 시작일, 종료일, 부서번호
-- 부서번호, 부서명
select job_title, min_salary, max_salary
        , jh.job_id, start_date, end_date
        , d.department_id, department_name
from hr.jobs j join hr.job_history jh on j.job_id = jh.job_id
               join hr.departments d on jh.department_id = d.department_id;

-- inner join: T-SQL join, ansi join
-- 사원번호, 이름, 직무, 부서번호, 부서명, 부서장
select employee_id, first_name, job_id
        , d.department_id, department_name, d.manager_id
from hr.employees e inner join hr.departments d on e.department_id = d.department_id;

-- 사원번호, 부서번호, 이름, 직무번호
-- 직무번호, 직무명(job_title)
select employee_id, department_id, first_name, e.job_id
        , j.job_id, job_title
from hr.employees e join hr.jobs j on e.job_id = j.job_id;

-- Natural join: 별칭x, 두 테이블에서 컬럼 이름이 같은 것끼리 비교한다.
select employee_id, department_id, first_name
        ,job_id, job_title
from hr.employees natural join hr.jobs;

-- 같은 부서의 부서장을 상사 둔 직원들의 정보와 부서명을 출력하시오
-- 사원번호, 이름, 직무번호, 급여, 상사번호(manager_id)
-- 부서번호, 부서명, 부서장
select employee_id, first_name, job_id, salary, e.manager_id
        , d.department_id, department_name, d.manager_id
from hr.employees e inner join hr.departments d on e.manager_id = d.manager_id
                                               and e.department_id = d.department_id;

select employee_id, first_name, job_id, salary, manager_id
        , department_id, department_name, manager_id
from hr.employees natural join hr.departments;

