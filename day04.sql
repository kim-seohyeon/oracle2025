-- 현재 날짜로부터 돌아오는 월요일
select next_day(sysdate, '월')
from dual;

-- 현재 날짜로부터 주의 시작인 일요일의 날짜와 주의 마지막인 토요일의 날짜를 출력
select next_day(sysdate-7, '일'), next_day(sysdate-7, '일')+6
from dual;

-- 직원이 입사한 날이 그 주가 며칠부터(일요일) 며칠 사이(토요일)에 있는 날인지 출력
-- 성, 이름, 입사일, 입사한 주의 일요일, 입사한 주의 토요일
select last_name, first_name, hire_date, next_day(hire_date-7, '일'), next_day(hire_date-7, '토')+6
from hr.employees;

-- 변환함수
select '30'+30, to_number('30')+30
from dual;

-- 날짜를 문자로 변환 : to_char()
select sysdate, to_char(sysdate, 'dd-mm-yy'), to_char(sysdate, 'yyyy-mm-dd')
                , to_char(sysdate, 'yyyy-mm-dd hh:mi:ss PM') -- 1시 오후
                , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss PM') -- 13시 오후
                , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss PM dy') -- 목
                , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss PM day') -- 목요일
from dual;

-- 입사일을 년-월-일-시-분-초 오전으로 출력
select to_char(hire_date, 'yyyy-mm-dd hh:mi:ss AM')
from hr.employees;

-- 사원번호, 직무, 이름, 입사일(일-월-년 요일)을 출력
select employee_id, job_id, first_name
        , to_char(hire_date, 'dd-mm-yy day')
        , to_char(hire_date, 'dd-mm-yy dy')
from hr.employees;

-- 숫자를 문자로 변환 : 999999 => $999,999
--                   123456 => 0123456
select 1234567, to_char(1234567, '999,999,999'), to_char(1234567, '999,999')
              , to_char(1234567, '09,999,999')
              , to_char(1234567, '$999,999,999')
              , to_char(1234567, 'L999,999,999') -- Local 돈 단위
              , to_char(-1234567, '999,999,999mi')    
              , to_char(-1234567, 'L999,999,999mi')
from dual;

-- 사원번호, 부서번호, 상사, 입사일, 급여를 출력
-- 급여를 3자리씩 표현
select employee_id, department_id, manager_id, hire_date
        , to_char(salary, '$999,999'), to_char(commission_pct, '999,999.00')
from hr.employees;

-- 29-07-2004로 입력 받았을 때 2004-07-29에 입사한 사원을 출력
-- 문자를 날짜로 변환
                --문자--       --문자형태--           --날짜--  -- 원하는 포맷--
select to_date('29-07-2004', 'dd-mm-yyyy'), to_char(sysdate, 'yyyy-mm-dd')
from dual;

select *
from hr.employees
where hire_date = to_date('29-07-2004', 'dd-mm-yyyy');

-- 17/06/03(dd-mm-yy)의 날짜의 일요일과 토요일을 출력
select next_day(to_date('17/06/03','dd-mm-yy') - 7, '일')
      ,to_date('17/06/03','dd-mm-yy')
      ,next_day(to_date('17/06/03','dd-mm-yy') -7, '일') + 6
from dual;

-- 변환 함수 : to_char, to_date, to_number
-----------
-- 문자열 함수, 변환 함수
-- 일반함수 : nvl,nvl2, coalesce, nullif
-- nvl(데이터, 숫자): 인자 2개, 데이터가 null 값일 때 반환해라, 문자 -> 숫자 자동으로 형 변환 가능
-- coalesce(데이터, 숫자): 인자 여러 개, 문자 -> 숫자로 형변환 시켜줘야 함 => to_number

-- 사원번호, 이름, 직무, 급여, 커미션, 월 커미션을 포함한 연봉
select employee_id, first_name, job_id, salary, commission_pct
        , salary*(1+nvl(commission_pct, 0))*12 as year_sal
from hr.employees;

select employee_id, first_name, job_id, salary, commission_pct
        , salary*(1+coalesce(commission_pct, 0))*12 as year_sal
from hr.employees;

select coalesce(null, 10, 20, 30), coalesce(null, null, 20, 30)
        , coalesce(null, null, null, 30), coalesce(null, 10)
        , nvl(null, 10)
from dual;        

-- nvl2: 1번째 인자가 null값이 아니면 2번째 인자 출력, null값이면 3번째 인자 출력
select nvl2('이', 10, 20), nvl2(null, 10, 20)
from dual;

-- nvl1을 nvl2로 변경하시오
select employee_id, first_name, job_id, salary, commission_pct
        , salary*(1+nvl2(commission_pct, commission_pct, 0))*12 as year_sal1
        , salary*nvl2(commission_pct, 1+commission_pct, 1)*12 as year_sal2
from hr.employees;

-- nullif(): 두 개의 인자가 같으면 null, 다르면 1번째 인자 출력
select nullif(100, 100), nullif(10, 2000)
from dual;

-- 이름과 성의 길이가 같은 사람만 출력
select first_name, last_name
from hr.employees
where length(first_name) = length(last_name);

select first_name, last_name
from hr.employees
where nullif(length(first_name), length(last_name)) is null;

/*
String str = "서울"
switch(str){
    case "서울" : system.out.println("02"); break;
    case "인천": system.out.println("031"); break;
    default : system.out.println("032"); 
}
*/

select first_name, job_id, salary
        , 
        case job_id when 'IT_PROG' then salary* 0.1
                    when 'IT_CLERK' then salary* 0.2
                    when 'SA_REP' then salary* 0.3
                    else salary end as sal
from hr.employees;        

select first_name, job_id, salary
        , case when job_id = 'IT_PROG' then salary* 0.1
               when job_id = 'IT_CLERK' then salary* 0.2
               when job_id = 'SA_REP' then salary* 0.3
               else salary end as sal
from hr.employees;        

-- 급여가 5000이하이면 'Low'를, 10000이하이면 'Medium', 20000이하이면 'Good'
-- 그 이상이면 'Excellent'를 출력
select first_name, job_id, salary
        , case when salary <= 5000 then 'Low'
               when salary <= 10000 then 'Medium'
               when salary <= 20000 then 'Good'
               else 'Excellent' end as sal
from hr.employees;

-- salary / 2000 나눈 값의 몫이 0이면 0
--                            1이면 0.09
--                            2이면 0.20
--                            3이면 0.30
--                            4이면 0.40
--                            아니면 0.50
select first_name, salary
       , case trunc(salary / 2000) when 0 then 0
                                   when 1 then 0.09
                                   when 2 then 0.20
                                   when 3 then 0.30
                                   when 4 then 0.40
                                   else 0.50 end as TAX
from hr.employees;

-- decode는 값을 =(등호)로 비교할 때 사용 가능, when, then, end => ,로 바꿈
select first_name, salary
       , decode(trunc(salary / 2000), 0, 0
                                   , 1, 0.09
                                   , 2, 0.20
                                   , 3, 0.30
                                   , 4, 0.40
                                   , 0.50 ) as TAX
from hr.employees;

select first_name, job_id, salary
        , case job_id when 'IT_PROG' then salary* 0.1
                    when 'IT_CLERK' then salary* 0.2
                    when 'SA_REP' then salary* 0.3
                    else salary end as sal
from hr.employees;

select first_name, job_id, salary
        , decode( job_id , 'IT_PROG', salary* 0.1
                    , 'IT_CLERK', salary* 0.2
                    , 'SA_REP', salary* 0.3
                    , salary) as sal
from hr.employees;

-- 단일 함수 : 문자, 일반, 변환함수
select first_name, lower(first_name)
from hr.employees;

-- 그룹함수 = 다중행 함수: 여러 개의 행값을 받아 하나의 결과값을 가져오는 값
-- count, max, min, avg, sum
select count(*)
from hr.employees;

select min(salary), max(salary), sum(salary), count(salary), count(*)
from hr.employees;

select count(*), count(employee_id), count(last_name), count(job_id), count(phone_number)
        , count(department_id), count(commission_pct), count(manager_id) -- null값 포함x
from hr.employees;

-- 커미션을 받는 사원의 수
select count(commission_pct) from hr.employees;

-- 커미션을 받는 사원의 수
select count(department_id) from hr. employees;

-- 부서가 없는 사원의 수
select count(*)
from hr.employees
where department_id is null;

select *
from hr.employees
where department_id is null;

-- 80인 부서의 직원 수와 최대 급여와 최소급여를 구하시오
select * from hr.employees where department_id = 80;

select count(*), max(salary), min(salary) 
from hr.employees 
where department_id = 80;

-- 부서를 출력하시오
select department_id from hr.employees;

-- 부서를 한번씩만 출력하시오
select distinct department_id from hr.employees;

-- 직원이 속해 있는 부서의 수를 출력하시오
select count(distinct(department_id)) from hr.employees;

-- 직무가 RE를 포함한 직원을 출력하시오
select *
from hr.employees
where job_id like '%RE%';

-- 직무가 RE를 포함한 직원의 최대 급여와 최소 급여 그리고 직원의 수와 평균 급여를 출력하시오
select max(salary), min(salary), count(*), round(avg(salary),3)
from hr.employees
where job_id like '%RE%';

-- 제일 먼저 입사한 사원과 제일 나중에 입사한 사원 입사일을 출력하시오
select min(hire_date), max(hire_date)
from hr.employees;

-- 커미션 퍼센트의 평균을 구하시오
select avg(commission_pct), sum(commission_pct)/count(commission_pct) --35
    ,avg(nvl(commission_pct,0)), sum(commission_pct)/count(*) --107
-- 사원수를 107로 하기 위해 null 값을 0으로 대체
from hr.employees;

-- 80인 부서의 급여의 평균, 급여의 합계, 최대 급여, 최소 급여
select avg(salary), sum(salary), max(salary), min(salary)
from hr.employees
where department_id = 80;

-- 90인 부서의 급여의 평균, 급여의 합계, 최대 급여, 최소 급여
select avg(salary), sum(salary), max(salary), min(salary)
from hr.employees
where department_id = 80;

-- 70인 부서의 급여의 평균, 급여의 합계, 최대 급여, 최소 급여
select avg(salary), sum(salary), max(salary), min(salary)
from hr.employees
where department_id = 70;

select department_id, avg(salary), sum(salary), max(salary), min(salary)
from hr.employees
where department_id in (80, 90, 70)
group by department_id;
-- group by절에 있는 컬럼은 select절에 사용 가능하다

-- 모든 부서의 급여의 평균, 급여의 합계, 최대 급여, 최소 급여
select department_id, avg(salary), sum(salary), max(salary), min(salary)
from hr.employees
group by department_id;
