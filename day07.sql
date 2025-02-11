-- 부서번호가 50인 부서의 최소 급여
select min(salary)
from hr.employees
where department_id = 50;

-- FI_ACCOUNT인 직무를 가진 사원들의 급여
select salary
from hr.employees
where job_id = 'FI_ACCOUNT';

-- 50인 부서의 최소 급여와 같은 급여를 받는 직원들은?
select * 
from hr.employees 
where salary = (select min(salary) 
                from hr.employees 
                where department_id = 50); -- 단일행 서브쿼리

-- FI_ACCOUNT인 직무를 가진 사원들의 급여와 같은 급여를 받는 직원들은?
select * 
from hr.employees 
where salary in (select salary
                 from hr.employees
                 where job_id = 'FI_ACCOUNT'); -- 다중행 서브쿼리
                 
-- 다중 서브쿼리
-- 직무가 FI_ACCOUNT인 사원의 급여를 출력
select salary
from hr.employees
where job_id = 'FI_ACCOUNT';

-- < any(): 다중행에서 큰 값보다 작은 값에 대한 것
-- 예제에서 9000보다 작은 값
-- 직무가 FI_ACCOUNT인 사원의 급여 중 제일 많이 받는 급여보다 적게 받는 직원은?
select *
from hr.employees
where salary < any(9000, 8200, 7700, 7800, 6900);

select *
from hr.employees
where salary < any (select salary from hr.employees where job_id = 'FI_ACCOUNT');

-- > any(): 다중행에서 작은 값보다 큰 값에 대한 것
-- 예제에서 6900보다 큰 값
-- 직무가 FI_ACCOUNT인 사원의 급여 중 제일 적게 받는 급여보다 많이 받는 직원은?
select *
from hr.employees
where salary > any (select salary from hr.employees where job_id = 'FI_ACCOUNT');

-- 직무가 FI_ACCOUNT인 사원의 급여와 같은 급여를 받는 직원?
-- in == = any
select * from hr.employees
where salary in (select salary from hr.employees where job_id = 'FI_ACCOUNT');

select *
from hr.employees
where salary = any (select salary from hr.employees where job_id = 'FI_ACCOUNT');

select salary from hr.employees where job_id = 'FI_ACCOUNT';
-- 9000, 8200, 7700, 7800, 6900
-- 큰 값보다 더 크다 : > all
-- 작은 값보다 더 작다 : < all
select * FROM hr.employees where salary > all(9000, 8200, 7700, 7800, 6900);

-- 9000, 8200, 7700, 7800, 6900 중에서 9000보다 더 큰 값을 받는 직원들
select * from hr.employees where salary > all (select salary from hr.employees where job_id = 'FI_ACCOUNT');

-- 9000, 8200, 7700, 7800, 6900 중에서 6900보다 더 작은 값을 받는 직원들
select * from hr.employees where salary < all (select salary from hr.employees where job_id = 'FI_ACCOUNT');

-- 다중행 연산자
-- > any(): 여러 개의 값들 중에서 작은 값보다 큰 값에 대한 것
-- < any(): 여러 개의 값들 중에서 큰 값보다 작은 값에 대한 것
-- = any(): in과 같다
-- > all(): 여러 개의 값들 중에서 큰 값보다 더 큰 값
-- < all(): 여러 개의 값들 중에서 작은 값보다 더 작은 값

--------------------------------------------------------
-- 부하직원이 있는 사원을 모두 구하시오
select * from hr.employees;

select manager_id from hr.employees;

select * from hr.employees 
where employee_id in (select distinct manager_id from hr.employees);

-- 부하직원이 없는 사원을 모두 구하시오
-- 서브쿼리 결과에 null 값이 포함되어 있어 결과가 안 나올 수 있다. 
-- 이런 경우에는 null값을 제외한 나머지로 값을 가져오도록 해야 한다.
select * from hr.employees 
where employee_id not in (select distinct manager_id 
                          from hr.employees 
                          where manager_id is not null);

-------------------------------------------------------------------
-- 집합 연산자
-- 합집합 union
-- 교집합 intersect
-- 차집합 minus
-------------------------------------------------------------------
-- 직무가 'ST_CLERK'와 'PU_CLERK'에 해당하는 급여를 출력하시오
-- 결과 중복
select salary from hr.employees where job_id in('ST_CLERK', 'PU_CLERK');

-- A 집합
select salary from hr.employees where job_id = 'ST_CLERK';
-- B 집합
select salary from hr.employees where job_id = 'PU_CLERK';

-- union 합집합: 중복 제거O
select salary from hr.employees where job_id = 'ST_CLERK'
union
select salary from hr.employees where job_id = 'PU_CLERK';

select distinct salary from hr.employees where job_id in('ST_CLERK', 'PU_CLERK');

-- union all : 중복 제거X
select salary from hr.employees where job_id = 'ST_CLERK'
union all
select salary from hr.employees where job_id = 'PU_CLERK';


-- 합집합으로 변경하시오
select salary from hr.employees where job_id in('ST_CLERK', 'PU_CLERK', 'IT_PROG');
-- 
select salary from hr.employees where job_id = 'ST_CLERK'
union
select salary from hr.employees where job_id = 'PU_CLERK'
union
select salary from hr.employees where job_id = 'IT_PROG';

-- 교집합 : intersect
select salary from hr.employees where job_id = 'ST_CLERK'
intersect
select salary from hr.employees where job_id = 'PU_CLERK';

-- 차집합 : minus
select salary from hr.employees where job_id = 'ST_CLERK'
minus
select salary from hr.employees where job_id = 'PU_CLERK';

-- 다른 데이블로부터 같은 종류의 데이터를 가져오기 위해서 사용하는 것이 집합 연산자이다.
-- job_history에서 employee_id, job_id를 출력하고 employees에서도 employee_id, job_id을 출력
select employee_id, job_id from hr.job_history
union
select employee_id, job_id from hr.employees;

-- 50, 90, 80인 부서에 해당하는 employee_id, job_id, department_id를 
-- job_history테이블과 employees테이블에서 가져오시오
select  employee_id, job_id, department_id 
from hr.job_history
where department_id in(50, 90, 80)
union
select  employee_id, job_id, department_id 
from hr.employees 
where department_id in(50, 90, 80);
-------------------------------------------------------
-- 같은 열 번호에 해당하는 컬럼들은 같은 유형의 데이터이어야 한다.
-- heading name은 첫 번째 쿼리문의 열이름을 따른다.
--          1           2           3
select  department_id, hire_date, employee_id 
from hr.employees
where department_id in(50, 90, 80)
union
--          1             2         3
select  employee_id, end_date, department_id 
from hr.job_history 
where department_id in(50, 90, 80);


-- 같은 열번호에 해당하는 컬럼의 유형이 다르면 오류 발생
select  department_id, hire_date, employee_id 
from hr.employees
where department_id in(50, 90, 80)
union
select  employee_id, end_date, department_id 
from hr.job_history 
where department_id in(50, 90, 80);

-- to_date(null), to_char(null)을 써서 갯수를 맞춰준다
select  department_id, to_date(null) as dt, email 
from hr.employees
where department_id in(50, 90, 80)
union
select  employee_id, end_date, to_char(null)
from hr.job_history 
where department_id in(50, 90, 80);

-- salary는 숫자임으로 to_numbr(null)값 대신 0을 써도 된다
select  department_id, job_id, salary 
from hr.employees
union
select  employee_id, end_date, 0
from hr.job_history ;

-- union 응용
-- 회원 테이블(members): user_id, user_pw, user_name, user_phone
-- 관리자 테이블(employees): emp_id, emp_pw, emp_name, emp_phone
-- highland0
select user_id, user_pw, user_name, user_phone
from members
where user_id = 'highland0'
union
select emp_id, emp_pw, emp_name, emp_phone
from employees
where emp_id = 'highland0';

-- DML : Create(insert) Read(select) Uptade Drop(detele)
create table employees
as
select * from hr.employees;

select * from employees;
drop table employees; -- table 삭제

select * from hr.employees
where 1 = 2;

create table employees
as
select * from hr.employees
where 1 = 2;

select * from employees;

desc employees;
select * from employees;

select * from hr.departments;

create table departments
as
select * from hr.departments
where 1 = 2;

desc hr.departments;
desc departments;

select * from hr.departments;
select * from departments;

insert into departments (department_id, department_name, manager_id, location_id)
values(70, 'Public relations', 100, 1700);
select * from departments;

rollback; -- DML문의 실행을 취소한다.

-- insert할 때 컬럼의 순서는 중요하지 않고 1대1 대응하도록 값을 적어줌
insert into departments (department_name, department_id,location_id, manager_id)
values('Public relations',70, 1700, 100);
select * from departments;

insert into departments (department_name, department_id)
values('Purchasing', 30); -- 원하는 컬럼에만 값을 부여할 수 있다.
select * from departments;

insert into departments (department_name, department_id,location_id, manager_id)
values('Finance', 100, null, null);
select * from departments;

-- 컬럼명을 생략할 때 values 값에 테이블에 저장된 컬럼명 순서대로 넣는다.
insert into departments
values(80, 'Sales', 145, 2500);

commit; -- 작업 마무리
---------------------------------------------- 여기서 다시 시작
alter table departments
add (aaa integer);

desc departments;

insert into departments (department_name, department_id,location_id, manager_id)
values('Finance', 100, null, null);

-- 오류 발생 컬럼명 alter 되었음
insert into departments 
values(80, 'Sales', 145, 2500);

rollback; -- 작업 초기화

-- 삭제
alter table departments
drop column aaa;

desc departments;

--
-- employee_id, first_name, last_name, email, phone_number, hire_date, job_id
-- salary, commission_pct, manager_id, department_id
select * from hr.employees where employee_id = 113;
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id
                     , salary, commission_pct, manager_id, department_id)
values(113,'Luis', 'Popp', 'LPOPP', '515.124.4567', '07/12/07', 'FI_ACCOUNT', 6900, null, 108, 100);

select * from employees;

select * from hr.employees where employee_id = 114;
-- 입사일이 07일 12월 02년으로 입력해야 한다.
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id
                     , salary, commission_pct, manager_id, department_id)
values(114,'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', to_date('02/12/07', 'dd-mm-yy'), 'PU_MAN', 11000, null, 100, 30);

select * from hr.employees where employee_id = 115;
-- 입사일을 현재 날짜로 입력하시오
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id
                     , salary, commission_pct, manager_id, department_id)
values(115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', sysdate, 'PU_CLERK', 3100, null, 114, 30);
select * from employees;

 -- 행 삭제
delete from employees
where employee_id = 114; -- 조건에 해당되는 행만 삭제된다.

select * from employees;
delete from employees; -- 조건이 없으면 다 지원진다.

-- insert에 서브쿼리 사용
-- hr.departments에서 부서장이 null이 아닌 부서를 출력하시오
-- department_id, department_name
select department_id, department_name
from hr.departments
where manager_id is not null;

insert into departments(department_id, department_name)
select department_id, department_name
from hr.departments
where manager_id is not null;

-- 113, 114, 115
insert into employees
select * from hr.employees 
where employee_id in (113, 114, 115);

select * from employees;

-- hr.employtees에서 'AD"로 시작하는 직무를 가진 직원들을 내 테이블에 입력하시오
insert into employees
select * from hr.employees 
where job_id like 'AD%';

select * from employees;

-- 'AD"로 시작하는 직무를 가진 직원들을 내 테이블에서 삭제하시오
delete from employees
where job_id like 'AD%';

select * from employees;

commit;

-- 115번 사원의 입사일을 현재 날짜로 변경
update employees
set hire_date = sysdate
where employee_id = 115;

select * from employees;

rollback;

update employees
set hire_date = sysdate;

-- 114번의 직원의 부서를 60번 부서번호로 변경하시오
update employees
set department_id = 60
where employee_id = 114;

select * from employees;

-- 30인 부서의 직원들을 모두 80 부서번호로 변경하시오
update employees
set department_id = 80
where department_id = 30;

select * from employees;

update employees
set hire_date = sysdate, department_id = 70
where employee_id = 115;

select * from employees;

-- hr.employees에 있는 104번 직원의 직무번호와 105번 직원의 급여를 
-- 114번 직원에 적용하시오
select job_id
from hr.employees
where employee_id = 104;

select salary
from hr.employees
where employee_id = 105;

update employees
set job_id = (select job_id from hr.employees where employee_id = 104)
  , salary = (select salary from hr.employees where employee_id = 105)
where employee_id = 114;

select * from employees;

-- hr.employees에서 'IT'로 직무번호를 가진 직원의 부서를 employees에서 삭제하시오
select job_id from hr.employees where job_id like '%IT%';
select department_id from hr.employees where job_id like '%IT%';

delete from employees
where department_id in (select department_id from hr.employees where job_id like '%IT%');

select * from employees;

commit;



