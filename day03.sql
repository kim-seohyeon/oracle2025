--- 정렬
select employee_id, first_name, job_id, department_id
from hr.employees
order by department_id; // asc 생략 가능

select employee_id, first_name, job_id, department_id
from hr.employees
order by department_id asc; //오름차순

select employee_id, first_name, job_id, department_id
from hr.employees
order by department_id desc; //내림차순

select employee_id, first_name, job_id, department_id
from hr.employees
order by department_id desc, job_id asc; 

select employee_id, first_name, department_id, job_id, hire_date
from hr.employees
order by department_id desc, job_id asc, hire_date desc;

-- 단일행 함수 : 하나의 행 데이터를 변환하는 함수
-- 소문자로 변환 (lower()), 대문자로 변환 (upper()), 첫 글자는 대문자 나머지는 소문자(initcap())
select last_name, lower(last_name), upper(last_name), job_id, lower(job_id), initcap(job_id)
from hr.employees;

select last_name, first_name, last_name || first_name, concat(last_name, first_name)
       , first_name, salary, first_name || salary, concat(first_name, salary)
from hr.employees;

-- length() 함수
select '이숭무', length('이숭무')
from dual;

select last_name, length(last_name), first_name, legth(first_name), salary, length(salary)
from hr.employees;

-- 성(last_name) 문자의 갯수가 5 이상인 직원들을 출력하시오
select *
from hr.employees
where length(last_name) >= 5;

-- 자르기 ==> 자바 : substring(index번호, index번호-1), oracle : substr(데이터, index번호, 갯수)
//substring str = "hello java"; System.out.println(substring(2, 5))
select 'hello java', substr('hello java', 3, 3)
from dual;

select 'HelloWorld' from dual;
--- Hellp를 출력
select substr('HelloWorld', 1, 5) from dual;
-- Wo
select substr('HelloWorld',6, 2) from dual;
-- ld
select substr('HelloWorld', 9, 2) from dual;
--             12345678910
--             987654321-
select substr('HelloWorld', -2, 2) from dual;
select substr('HelloWorld', -4, 1) from dual; //o
select substr('HelloWorld', -4, 4) from dual; //orld
select substr('HelloWorld', 7, 4) from dual; //orld

---------------------
select * from hr.departments;

-- 부서명을 2번째부터 5글자만 출력하시오
select department_name, substr(department_name, 2, 5)
from hr.departments; 

-- 직무가 4번째 글자부터 2글자가 'PR'인 직무를 가진 직원들을 출력하시오
select * from hr.employees
where job_id like '___PR%';

select * from hr.employees
where substr(job_id, 4, 2) = 'PR';

-- indexOf : 자바, orcle : instr
-- String str = "Hello Java"; System.out.println(str.indexOf('J')); //6
-- W의 index를 출력
select 'HelloWorld', instr('HelloWorld', 'W') from dual; //6

-- 사원번호, 성, 이름, 급여를 출력할 때 성에 's'가 있는 경우 's'의 index를 출력 하시오
select employee_id, last_name, first_name, salary, instr(last_name, 's')
from hr.employees;
-- 해당 문자열이 없는 경우에는 0 index를 가져온다

-- 사원번호, 성, 이름, 급여를 출력할 때 성에 'st'가 있는 경우의 index를 출력 하시오
select employee_id, last_name, first_name, salary, instr(last_name, 's'), instr(last_name, 'st')
from hr.employees;
-- 문자열로 index를 찾을 때는 첫 번째 문자의 index를 가져온다

-- substr과 instr을 같이 사용
-- 사원번호, 성, 이름, 급여를 출력할 때 성에 's'가 있는 위치부터 2글자 출력하시오
select employee_id, last_name, first_name, salary, substr(last_name, instr(last_name, 's'), 2)
from hr.employees;

-- 이름에서 's'가 3번째 index에 있는 직원들을 출력하시오
select * 
from hr.employees
where instr(first_name, 's') = 3;

-- 사원번호, 성, 이름, 급여를 출력할 때 이름은 3번째부터 마지막 글자까지 출력하시오
select employee_id, last_name, first_name, salary, substr(first_name, 3)
from hr.employees;

-- 문자열 함수 : lower, upper, initcap, concat, length, substr, instr ...
-- lpad, rpad
-- highland0의 아이디 찾기 : high***** //rpad
--                         *****and0 //lpad
select 'highland0', rpad('high', 9, '*'), lpad('and0', 9, '*')
from dual;

select 'highland0', rpad(substr('highland0', 1, 4), length('highland0'), '*'), lpad(substr('highland0', -4, 4), length('highland0'), '*')
from dual;

-- 사번, 이름에 3글자만 출력하고 나머지 뒤에는 별표, 급여, 직무를 출력
select employee_id, first_name, rpad(substr(first_name,1, 3), length(first_name), '*'), salary, job_id
from hr.employees;

-- trim()
select * from hr.employees
where first_name = trim('   Steven     ');

select 'Steven  ', trim('    Steven  '), rtrim('    Steven  '), ltrim('    Steven  ')
from dual;

select 'ahighland0', trim('a' from 'ahighland0a')
from dual;

-- replace()
-- 'JACK and JUE'에서 'J'를 'BL'로 변경하시오
select 'JACK and JUE', replace('JACK and JUE', 'J', 'BL')
from dual;

-- 사원번호, 이름, 급여 ,직무, 부서번호를 출력할 때 직무의 _AS를 abc로 변경해서 출력
select employee_id, first_name, salary, job_id, department_id, replace(job_id, '_AS', 'abc')
from hr.employees 
where job_id like '%\_AS%' escape '\';

-- 011-746-1970, 011-***-1970
-- 010-7146-1970, 010-****-1970
-- 02-314-1970, 02-***-1970
select '011-746-1970'
       , rpad(
                substr('011-746-1970', 1, instr('011-746-1970', '-'))
              , length(substr('011-746-1970', 1, instr('011-746-1970', -1) -1))
              , '*'
       )
       || substr('011-746-1970', -5, 5)     
from dual;

-- 문자열 함수 : lower, upperm initcap, concat, substr, instr, length, lpad, rpad, trim, replace

-- 숫자 함수
-- round : 반올림(5 이상)
-- trunc : 버림
-- mod : 나머지 연산자

select 15.19345, round(15.19345, 3), round(15.19355, 3)
     , round(145.5553, 2), round(145.5553, 1)
     , round(145.5553, 0), round(145.5553)
     , round(145.5553, -1), round(145.5553, -2)
from dual;

select 15.19345, trunc(15.19345, 3), trunc(15.19355, 3)
     , trunc(145.5553, 2), trunc(145.5553, 1)
     , trunc(145.5553, 0), trunc(145.5553)
     , trunc(145.5553, -1), trunc(145.5553, -2)
from dual;

select mod(10, 3)
from dual;

-- 직원의 급여를 5000으론 나눈 나머지가 2000부터 3000사이인 직원들을 구하시오
select * from hr.employees
where mod(salary, 5000) between 2000 and 3000;

-- 직무가 SA_REP인 사원들의 급여를 5000으로 나눈 나머지가 얼마인가
-- 사원번호, 이름, 직무, 급여를 같이 출력
select employee_id, first_name, job_id, salary, mod(salary, 5000)
from hr.employees
where job_id = 'SA_REP';

-- 현재 날짜 : sysdate
select sysdate from dual;

select first_name, last_name, salary, job_id, '2005-07-06', sysdate
from hr.employees;

-- '2024-05-27'는 현재날짜로부터 며칠이 지났을까요?
select sysdate - to_date('2024-05-27', 'yyyy-mm-dd')
from dual;

-- '2024-05-27'는 현재날짜로부터 몇주가 지났을까요?
select (sysdate - to_date('2024-05-27', 'yyyy-mm-dd'))/7
from dual;

-- 입사일로부터 현재까지 며칠동안 근무를 했나
-- 사원번호, 급여, 이름도 같이 출력
select employee_id, salary, first_name, sysdate -hire_date
from hr.employees;

--입사일로부터 현재까지 몇주 동안 근무를 했나
-- 사원번호, 급여, 이름도 같이 출력
select employee_id, salary, first_name, trunc((sysdate - hire_date)/7)
from hr.employees;

-- months_between()
--입사일로부터 현재까지 몇주 동안 근무를 했나
-- 사원번호, 급여, 이름도 같이 출력
select employee_id, salary, first_name, trunc(months_between(sysdate, hire_date))
from hr.employees;

--입사일로부터 현재까지 몇년 동안 근무를 했나
-- 사원번호, 급여, 이름도 같이 출력
select employee_id, salary, first_name, trunc(months_between(sysdate, hire_date)/12)
from hr.employees;

-- 이번달의 마지막 날은? last_day()
select sysdate, last_day(sysdate)
from dual;

-- 사원번호, 급여, 이름, 입사한 날의 마지막 날을 출력
select employee_id, salary, first_name, hire_date, last_day(hire_date)
from hr.employees;

-- 입사한 달이 윤년인 사원을 출력
-- 사원번호, 급여, 이름, 입사일
select employee_id, salary, first_name, hire_date
from hr.employees
where last_day(hire_date) like '%/02/29';

-- 돌아오는 금요일의 날짜는?
select next_day(sysdate, '금'), next_day(sysdate, '금요일')
from dual;

-- 돌아오는 수요일의 날짜는?
select next_day(sysdate, '수'), next_day(sysdate, '수요일')
from dual;

-- 입사한 날에서 돌아오는 월요일이 8월 2일인 직원은?
select employee_id, salary, first_name, hire_date, next_day(hire_date, '월')
from hr.employees
where next_day(hire_date, '월') like '%/08/02';

-- 현재 날짜의 주의 시작일인 일요일이 날짜와 주의 마지막 날짜인 토요일 날짜를 출력하시오
select sysdate, next_day(sysdate -7, '일요일'), next_day(sysdate -7, '토요일')+6
from dual;

