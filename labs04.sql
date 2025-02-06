-- 1. 커미션이 null이라면 커미션 값을 0으로 대입하여 이름, 부서, 입사일, 직무,
--     급여, 커미션, 그리고 연봉을 출력하세요.
select first_name, department_id, hire_date, job_id, salary, nvl(commission_pct, 0), salary*12
from hr.employees;

---2. 03/06/17이후에 입사한 사람은?
select * from hr.employees
where hire_date > '03/06/17';

---3. 17/06/03(일월년)이후에 입사한 사람은?
select *
from hr.employees
where hire_date > to_date('17/06/03', 'dd-mm-yy');

--4. 06/17/03(월일년)이후에 입사한 사람은?
select *
from hr.employees
where hire_date > to_date('06/17/03', 'mm-dd-yy');

--5.. 문자 변환함수 : 날짜를 문자 변환
--   현재날짜를 년-월-일, 일-월-년, 세기년-월-일, 세기년-월-일 시:분:초 오전/오후, 
---  세기년-월-일 24시:분:초 오전/오후 등으로 출력
select sysdate, to_char(sysdate, 'yy-mm-dd'), to_char(sysdate, 'dd-mm-yy')
              , to_char(sysdate, 'yyyy-mm-dd'), to_char(sysdate, 'yyyy-mm-dd hh:mi:ss AM')
              , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss AM')
from dual;


-- 6. 25-04-2003 보다 늦게 입사한 사람을 출력하는 쿼리이다 두 쿼리는 어떻게 다른지 기술하시오. 
-- 1)
SELECT * FROM HR.EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'DD-MM-YYYY') > '25-04-2003';
-- 2)
SELECT * FROM HR.EMPLOYEES WHERE HIRE_DATE > TO_DATE('25-04-2003', 'DD-MM-YYYY');

-- 7. 숫자를 문자열로
--- 1,234,567를 w1,234,567, $1,234,567, $1,234,567- 각각으로 출력하시오. 
select 123467, to_char(1234567, 'L999,999,999')
             , to_char(1234657, '$999,999,999')
             , to_char(-123467, '$999,999,999mi')
from dual;

-- 8. 이름, 성, 직무, 부서 그리고 급여를 세자리씩 ,를 찍고 $가 출력되게 하시오.
select first_name, last_name, job_id, department_id, salary, to_char(salary, '$999,999,999')
from hr.employees;

-- 9. janette또는 JANETTE 또는 jaNette 값을 전달 받았다.
---   이름이 'Janette'인 사원을 출력하시오.
select *
from hr.employees
where first_name = 'janette' or first_name = initcap('janette') or first_name = initcap('jaNette');

-- 10. --- job_id이 'IT_PROG' 급여를 10%상승
--                  'ST_CLERK' 급여를 15%상승
--                  'SA_REP' 급여를 20%상승
--                   그이외는 급여
-- 성, 이름, 급여도 같이 출력 
select last_name, first_name, salary
    , case when job_id = 'IT_PROG' then salary*0.1
           when job_id = 'ST_CLERK' then salary*0.15
           when job_id = 'SA_REP' then salary*0.2
           else salary end as sal
from hr.employees;

-- 11. 성, 이름, 직무, 급여, 급여에 따른 직책도 같이 출력하세요.
--- 급여가 3000이하이면 사원 
--        5000이하이면 주임
--        7000이하이면 대리
--        9000이하이면 과장
--       11000이하이면 차장
--       13000이하이면 부장
--       그 이상 이면 임원
select last_name, first_name, job_id, salary
        , case when salary <= 3000 then '사원'
               when salary <= 5000 then '주임'
               when salary <= 7000 then '대리'
               when salary <= 9000 then '과장'
               when salary <= 11000 then '차장'
               when salary <= 13000 then '부장'
               else '임원' end as grade
from hr.employees;

-- 12. 급여에 따른 세금을 출력하고 싶다. 이름 , 성, 급여, 직무, 세금을 출력하시오.
---  급여를 2000으로 나눈 몫이 0이면 급여의 0%
---                         1이면 급여의 9%
---                         2이면 급여의 20%
---                         3이면 급여의 30%
---                         4이면 급여의 40%
---                         5이면 급여의 42%
---                         6이면 급여의 44%
---                         이외 급여의 45% 세금이다.
-- trunc(salary / 2000)
select first_name, last_name, salary, job_id
            , case  trunc(salary/2000) when 0 then salary*0
                                       when 1 then salary*0.9
                                       when 2 then salary*0.2
                                       when 3 then salary*0.3
                                       when 4 then salary*0.4
                                       when 5 then salary*0.42
                                       when 6 then salary*0.44
                                       else salary*0.45 end as tax
from hr.employees;

-- 13. 성과 이름을 붙여서 출력하시오.
select '나의 이름은 ' || last_name || first_name || '입니다.'
from hr.employees;

-- 위 코드를 concat을 사용해서 출력하시오.
select concat('나의 이름은 ', last_name) || concat(first_name, '입니다.')
from hr.employees;

-- 14. nvl
-- 성, 이름, 직무, 급여, 커미션을 포함한 년봉, null인 경우 0으로 
select last_name, first_name, job_id, salary*(1 + nvl(commission_pct,0)*12)
from hr.employees;

-- 15. nvl2
-- last_name, first_name, job_id, salary 를 출력할 때 nvl2를 이용해서 commission을 포함한 년봉을 구하시오.
select last_name, first_name, job_id
        , salary*(1+nvl2(commission_pct, commission_pct, 0))*12
from hr.employees;

-- 16. nullif 
-- 이름의 크기와 이메일의 크기를 비교해서 값이 같으면 null을 다르면 이름의 크기가 출력되게 하시오.
-- 이름과 이메일도 같이 출력
select first_name, email
from hr.employees
where nullif(length(first_name), length(email)) is null;

-- 17.coalesce함수를 이용해서 커미션을 포함한 연봉을 구하시오. 이름, 급여 커미션도 같이 출력
select first_name, salary, commission_pct, salary*(1+coalesce(commission_pct,0))*12
from hr.employees;

--  다중행 함수
-- 18. 급여를 제일 많이 받는 사람과 적게 받는 사람을 출력, 급여 평균
select max(salary), min(salary), avg(salary)
from hr.employees;

-- 19. 급여를 받는 사람의 수와, 부서를 가지고 있는 사람의 수를 출력하시오.
select count(salary), count(department_id)
from hr.employees;

-- 20. 커미션을 받는 사원들의 커미션의 평균과 직원 전체의 커미션 평균을 구하시오.
select avg(commission_pct), avg(nvl(commission_pct,0))
from hr.employees;

-- 21. 전체의 사원의 수를 구하시오. (행 전체의 갯수)
select count(*)
from hr.employees;

-- 22. 제일 늦게 입사한 사원과 제일 처음에 입사한 사원을 출력하시오.
select max(employee_id), min(employee_id)
from hr.employees;

-- 23.직무에 'REP'를 가지고 있는 사원들 중 제일 많이 받는 급여와 적게 받는 급여를 출력,
--    평균 급여와 사원의 수, 급여의 합계 
select max(salary), min(salary), avg(salary), count(employee_id), sum(salary)
from hr.employees
where job_id like '%REP%';

-- 24.80번 부서에서 커미션을 받는 사원의 수와 최대 커미션 값과 최소 커미션 값을 출력
--     부서에 속해 있는 사원의 수 
select max(commission_pct), min(commission_pct), count(department_id)
from hr.employees
where department_id = 80;

-- 25. 중복되지 않은 부서들을 출력?
select distinct department_id
from hr.employees;

-- 26. 중복되지 않은 부서의 수는?
select distinct count(department_id)
from hr.employees;

-- 27. 커미션의 받는 사원의 커미션 평균과 
--    커미션을 받지 않는 사원을 포함한 커미션의 평균을 구하시오.
--    반올림 하지 않고 소수점 이하 4자리만 출력
--select avg(commission_pct), sum(commission_pct)/count(commission_pct)
--from hr.employees;

-- 28. 90인부서의 급여의 평균, 합계, 최대, 최소, 사원의 수
select avg(salary), max(salary), min(salary), count(*)
from hr.employees
where department_id = 90;

-- 29. 80인부서의 급여의 평균, 합계, 최대, 최소, 사원의 수
select avg(salary), max(salary), min(salary), count(*)
from hr.employees
where department_id = 80;

-- 30. 70인부서의 급여의 평균, 합계, 최대, 최소, 사원의 수
select avg(salary), max(salary), min(salary), count(*)
from hr.employees
where department_id = 70;
