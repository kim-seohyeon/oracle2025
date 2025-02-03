select * -- 모든 컬럼 가져오기, * 뒤에는 아무것도 쓸 수 없다.
from hr.employees; --hr의 employees라는 직원 테이블에서

---- 직원 테이블에서 사원번호, 성, 입사일, 직무번호를 출력하시오. 프로젝션: 필요한 열 데이터만 가져오는 것
select employee_id, last_name, hire_date, job_id
from hr.employees;

--- 테이블 정보
describe hr.employees;
--- = desc hr.employees;

--- 출력할 때는 컬럼 순서는 상관 없다.
--- 직원 테이블에서 급여, 성, 직무번호, 입사일을 출력하세요.
select  salary, last_name, job_id, hire_date --- 컬럼을 무작위로 나열할 수 있다.
from hr.employees;

desc hr.departments;

select department_id, location_id
from hr.departments;

-- 대소문자를 구분하지 않는다.
--- 부서테이블에서 부서번호, 직역번호를 출력하시오.
SELECT DEPARTMENT_ID, LOCARION_ID
FROM HR.DEPARTMENTS;

select * from dba_tables where owner='HR'; //오라클을 설치하면 dba_table이 생성됨. //찾을 때는 대문자로 찾아야 됨.
select * from dba_tables where owner = 'HR' and table_name = 'DEPARTMENTS';

--- 한 줄 또는 여러 줄에 입력할 수 있다.
--- 직원 테이블에서 직원번호, 이름, 입사일, 직무번호, 급여, 직속상사, 부서번호
select employee_id, first_name, hire_date
       , job_id, salary, manager_id, department_id //가독성을 높이기 위해 들여쓰기를 사용함
from hr.employees;

--- 절은 별도의 줄에 입력함
--- 부서 테이블에서 부서번호, 부서명을 출력하시오
desc hr.department;
select department_id, department_name from hr.departments;
--select department_id, department_name 
--from hr.departments;

--- 산술식(expression)
--- 직원테이블에서 직원번호, 이름, 급여, 연봉 출력
select employee_id, first_name, salary, salary * 12
from hr.employees;

-- 직원 테이블에서 직원번호, 성, 입사일, 직무번호, 급여, 연봉에 상여급 100을 더해서 출력
select employee_id,last_name, hire_date, job_id, salary, (salary * 12)+100
from hr.employees;

-- 직원 테이블에서 직원번호, 성, 입사일, 직무번호, 급여, 매월 100씩 추가로 더해진 급여의 연봉을 출력
select employee_id,last_name, hire_date, job_id, salary, 12 * (salary+100)
from hr.employees;

-- 직원 테이블에서 직원번호, 성, 직무번호, 급여, 커미션퍼센트(commission_pct)을 출력
select employee_id, last_name, job_id, salary, commission_pct
from hr.employees;

-- null: 알 수 없는 값. 값이 없다가 아님
-- 직원 테이블에서 직원번호, 이름, 입사일, 급여, 커미션퍼센트, 급여당 커미션을 출력
select employee_id, first_name, hire_date
       , salary, commission_pct, salary*commission_pct
from hr.employees;

-- null 값에 무슨 짓을 해도 null 값을 출력
select 100 + null
from dual;

-- 직원 테이블에서 사원번호, 이름, 성, 급여, 커미션, 커미션을 포함한 연봉도 같이 출력
select employee_id, first_name, last_name, salary, commission_pct, salary*(1+commission_pct)*12
from hr.employees;

--- alias : heading name 변경하기 as 사용, as는 생략 가능
select employee_id, first_name, last_name, salary, commission_pct, salary*(1+commission_pct)*12 as year_sal
from hr.employees;

select employee_id as eid, first_name as fid, last_name as lid
       , salary as sal, commission_pct as comm, salary*(1+commission_pct)*12 as year_sal
from hr.employees;


-- 대소문자로 heading name 출력하려면 "" 사용, ""사용 지양
select employee_id as eid, first_name as fid, last_name as lid
       , salary as sal, commission_pct as comm
       , salary*(1+commission_pct)*12 as "Year_Sal" 
       , salary*(1+commission_pct)*12 as "Year Sal"
from hr.employees;


--- 연결 연산자 : ||
--- 직원 테이블에서 직원번호, 성이름, 입사일, 급여, 직무번호 출력
select employee_id, last_name || first_name, hire_date, salary, job_id
from hr.employees;

-- 성 이름: last_name ||' ' first_name
-- 리터널: 자연어, 자연수
-- 문자열 리터널: 자연어
select employee_id, last_name ||' ' first_name, hire_date, salary, job_id
from hr.employees;

--- 100의 이름은 king이고 직무는 ad_pres입니다.
select employee_id || '의 이름은 ' || last_name || '이고 직무는 ' || job_id || '입니다.'
from hr.employees;

-- king 1달 월급 = 24000
select last_name || '1달 월급 = ' || salary
from hr.employees;

-- 'department''s manager_id ' ==> department's manager_id
select department_name || ' department''s manager_id '|| manager_id
from hr.departments;

-- q키워드 사용 ' [] ' (x) --> '[]'
select department_name, q'[department's manager_id]', manager_id
from hr.departments;

select employee_id, department_id
from hr.employees;

-- 직원 테이블에서 사원들이 속해 있는 부서가 어떤 부서들이 있는지 한번씩 출력하시오 
-- distinct 중복 행 제거
select distinct department_id
from hr.employees;

--- 직원 테이블에서 부서번호, 직무번호 출력
select department_id, job_id
from hr.employees;

-- 각 부서의 직무들을 한번만 출력
select distinct department_id, job_id
from hr.employees;

--- 직원 테이블에서 성,직무번호, 부서번호를 출력할 때 중복 행 제거
select distinct last_name, job_id, department_id
from hr.employees;

-- 원하는 컬럼(열)을 출력 : projection
-- 원하는 레코드(행)을 출력 : selection : where절이 필요
select * 
from hr.employees
where employee_id = 100;

select * from hr.employees
where EMPLOYEE_ID = 100;

-- 성이 king인 사원을 모두 출력
select * from hr.employees 
where last_name = 'King';

-- 저장된 데이터에 대해서는 대소문자를 구분함으로 출력되지 않는다.
select * from hr.employees 
where last_name = 'king';

select * from hr.employees 
where last_name = 'KING';

-- 직무가 'FI_ACCOUNT'인 사원들의 사원번호, 이름, 급여, 직무를 출력하시오
select employee_id, first_name, salary, job_id
from hr.employees
where job_id = 'FI_ACCOUNT';

-- 특정 입사일 출력 '03/06/17' => 'yy/mm/dd', yy-mm-dd, yy.mm.dd, yyyy-mm-dd
select * from hr.employees where hire_date = '03/06/17';
select * from hr.employees where hire_date = '03-06-17';
select * from hr.employees where hire_date = '03.06.17';
select * from hr.employees where to_char(hire_date, 'yyyy') = '2003'; //2003년에 입사
desc hr.employees;

-- 20 25 02 03 14 45 30
-- 세기 년 월 일 시 분 초
-- 00 ~ 49년 : 2000 ~ 2049
-- 50 ~ 99년 : 1950 ~ 1999

-- 사장보다 먼저 입사한 직원들
select * from hr.employees where employee_id = 100;
select * from hr.employees where hire_date < '03/06/17';

-- 급여가 3000달러 이상인 사원을 출력하세요
select * from hr.employees where salary >= 3000;

-- 사원번호, 성, 급여, 직무번호를 출력하는 데 급여의 이름을 sal로 한다
-- 이때 급여가 3000달러 이상인 사원을 출력하세요
select employee_id, last_name, salary as sal, job_id  --- 3번째로 실행
from hr.employees  --- 1번째로 실행
where salary >= 3000; --- 2번째로 실행 => 별칭 사용 x

-- 급여가 2500부터 3000 사이에 있는 직원 이름과 급여를 출력하시오
select first_name, salary
from hr.employees
where salary >= 2500 and salary <= 3000;

select first_name, salary
from hr.employees
where  salary between 2500 and 3000;

-- 50, 70, 90인 부서의 직원을 출력하시오
select * from hr.employees where department_id = 50;
select * from hr.employees where department_id = 70;
select * from hr.employees where department_id = 90;

select * from hr.employees 
where department_id = 50 or department = 70 or department = 90;

select * from hr.employees where department_id in (50, 70, 90);

-- 직원 이름이  'Vance'인 직원과 90인 부서의 직원을 출력하시오
select * from hr.employees where first_name = 'Vance';
select * from hr.employees where department_id = 90;
select * from hr.employees where first_name = 'Vance' or department_id = 90; //가져오는 컬럼이 다르기 때문에 in을 사용하지 못 하고 or을 사용해야 함

-- 성이름이 'Hartstein', 'Vargas'인 사원들을 출력하시오
select * from hr.employees 
where last_name in ('Hartstein', 'Vargas');

-- 100, 101, 201인 상사(manager_id)를 둔 직원들을 모두 출력하시오
select * from hr.employees 
where manager_id in (100, 101, 102);







