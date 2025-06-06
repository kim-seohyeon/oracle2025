--- 1. 이름이 'steven'인 사람을  출력하시오.
select * 
from hr.employees
where first_name = initcap('steven');

-- 2. 성이 KING인 직원을 출력하세요.
select * 
from hr.employees
where last_name = initcap('KING');

-- 3. 이름의 글자의 갯수가 5인 사원들을 출력하세요.
select * 
from hr.employees
where length(first_name) = 5;

-- 4.  급여가 5자리 이상인 사원을 구하시오.
select * 
from hr.employees
where length(salary) >= 5;

-- 5. 이름에 's'를 가지 사원들 중 이름에 몇번째에 있는지 출력하세요.
select first_name, instr(first_name, 's') from hr.employees;

-- 6.  이름에 's'가 3번째에 있는 사원들을 출력하세요.
select * 
from hr.employees
where  instr(first_name, 's') = 3;

-- 7. 이름과 성과 급여와 직무를 출력할 때 이메일은 3번째 글자 부터 출력하시오.
select first_name, last_name, salary, job_id, email, substr(email, 3)
from hr.employees;

-- 8. 이메일에 'S'부터 출력하고, 급여, 입사일, 이름 ,성을 출력하세요.
select email, substr(email, instr(email,'S')), salary, hire_date, first_name, last_name 
from hr.employees;

-- 9. 이름 , 급여, 직무, 부서를 출력할 때 이메일은 3번째 부터 4글짜를 출력하시오.
select first_name, salary, job_id, department_id,substr(email, 3, 4)
from hr.employees;

--10. 이메일에 3번째부터 4글자에 'ARTS'가 있는 상원을 출력하세요.
select *
from hr.employees
where substr(email, 3, 4) = 'ARTS';

--11.이메일에 's'가 5번째에 있는 사원을 출력하시오.
select email, instr(email, 'S')
from hr.employees
where instr(email, 'S')=5;

-- 아이디 찾기 highland0 : high*****
-- 12. 이메일에서 앞에서 2글자를 출력하고 나머지는 오른쪽에 *로 채워서 출력하세요.
select email, rpad(substr(email, 1, 2), length(email), '*')
from hr.employees;

-- 13. 입사일이 03/06/17 전화번호가 515.123.4567인 사원의 이메일을 
--     앞에서 3글자만 출력하고 나머지는 *로 출력하세요
select email, rpad(substr(email, 1, 3), length(email), '*')
from hr.employees
where hire_date = '03/06/17' and phone_number = '515.123.4567';

-- 14. 직무가 _AS가 있다면 abc로 변경하시오,
select job_id, replace(job_id, '_AS', 'abc')
from hr.employees
where job_id like '%\_AS%' escape '\';

-- 15.이메일에 'A'가 처음과 끝에 있다면 이메일에서 삭제하여 출력하자.
select email, trim('A' from email), trim(email)
from hr.employees;

-- 16. 이메일에서 뒤에서 한글자가지고 오고 또 이메일에서 뒤에서 부터 2글자 가지고 오며,
--     이메일에서 뒤에서 3번째부터 2글자만 출력하세요.
select email, substr(email, length(email),1)
            , substr(email, length(email)-1, 2)
            , substr(email, length(email)-2, 2) 
from hr.employees;

-- 16. 이름, 입사일, 부서번호, 급여, 년봉을 출력하세요.
select first_name, hire_date, department_id, salary, salary*12
from hr.employees;

-- 17. 이름, 입사일, 부서번호, 급여 그리고 년봉을 출력할 때 
-- 년봉에는 커미션이 포함되어야 한다.
select first_name, hire_date, department_id, salary, salary * (1+commission_pct) * 12
from hr.employees;

-- 18. 입사일로부터 오늘날짜까지 몇일이 지났는지 일로 출력하세요.
--  입사일, 이름, 성, 직무도 같이 출력
select hire_date, sysdate-hire_date, first_name, last_name, job_id
from hr.employees;

-- 19. 입사일, 이름, 성, 직무을 출력할 때 입사일로 부터 몇 주가 지났는지 출력하시오.
select hire_date, (sysdate-hire_date)/7, first_name, last_name, job_id
from hr.employees;

-- 20. 입사일, 이름, 성, 직무을 출력할 때 입사일로 부터 몇 년차인지 출력하시오.
select hire_date, months_between(sysdate, hire_date)/12, first_name, last_name, job_id
from hr.employees;

-- 21.년차가 17년 이상인 사원을 출력하시오.
select hire_date, months_between(sysdate, hire_date)/12, first_name, last_name, job_id
from hr.employees
where months_between(sysdate, hire_date)/12 >= 17;

-- 22. 이름, 성, 입사일 , 급여를 출력할 때 급여를 400으로 나눈 나머지를 출력하세요.
select first_name, last_name, hire_date, salary, mod(salary, 400)
from hr.employees;

-- 23. 급여를 500으로 나눈 나머지가 400 이상인 사원들을 출력하시오
select *
from hr.employees
where mod(salary, 500) >= 400;


--- 날짜 함수 
--24. 오늘 날짜부터 다음 금요일은 몇일입니까?
select next_day(sysdate, '금')
from dual;

-- 25. 이름 , 성, 직무, 입사일을 출력할 때 입사일로부터 다음 목요일이 언제였는지 출력하세요.
select first_name, last_name, job_id, hire_date, next_day(hire_date, '목요일')
from dual;

-- 26 오늘부터 5개월후는 몇일입니까?
-- add_months
select add_months(sysdate, 5)
from dual;

--27. Neena가 입사하고 3개월 후가 정직원이 되는 날이다.
--    정직원이 되는 날이 언제인지, 이름 , 성 , 입사일, 직무, 사원번호와 같이 출력하시오.
select first_name, hire_date, job_id, employee_id, add_months(hire_date, 3)
from hr.employees
where first_name = 'Neena';

-- 28. 입사한 이후 다음 목요일이 '01/01/18'인사원을 구하시오.
select hire_date
from hr.employees
where next_day(hire_date, '목') = '01/01/18';

-- 29 이번 달의 마지막 날을 출력
select last_day(sysdate)
from dual;

-- 30. 윤달에 입사한 사원을 출력하시오.
select *
from hr.employees
where last_day(hire_date) like '%/02/29';

-- 31. 입사일로 부터 현재까지 몇달이 지났나요, 이름, 성, 직무, 입사일도 같이 출력
select first_name, last_name, job_id, hire_date, trunc(months_between(sysdate,hire_date))
from hr.employees;

-- 32 각 사원이 직무를 담당한 달은 몇달인지 출력하시오.
select job_id, trunc(months_between(sysdate, hire_date))
from hr.employees;

-- 33. 입사한지 200개월이 지난 사원들을 출력하시오.
select *
from hr.employees
where months_between(sysdate, hire_date) >= 200;

--- 34. 성이 모두 소문자인 grant와 모두 대문자인 'GRANT'로 직원테이블에서
--- 해당 사원을 찾으려 한다.
select *
from hr.employees
where last_name in( initcap('grant') , initcap('GRANT'));

---35. 'GranT'로 입력했을때 사원테이블에서 성이 'Grant'인 사원을 찾으시오.
select *
from hr.employees
where last_name= initcap('GranT');

-- 36. 성은 모두 대문자로 변환하고 이름 모두 소문자로 변환하여
-- 성과 이름을 붙여 출력할 때 ' 나는 GRANT douglas 입니다'로 
-- 출력되게 하시오
select concat('나는 ' 
            , concat(upper(last_name)
            , concat(' ' 
            , concat(lower(first_name), '입니다.'))))
from hr.employees;

-- 37. 성과 이름을 붙여 출력
select concat(last_name, first_name)
from hr.employees;

--- 38. 성이 Davies에서 av만 출력하시오.
select substr(last_name, 2, 2)
from hr.employees
where last_name = 'Davies';

--- 39. 성이 두번째 글자부터 모두 출력하시오.
select substr(last_name, 2)
from hr.employees;

--- 40. 성의 마지막 글자에서 두글자만 가져오시오.
select last_name, substr(last_name,-2,2)
from hr.employees;

--- 41. 성의 뒤에 on으로 끝나는 사람을 찾으시오
select *
from hr.employees
where substr(last_name, -2, 2) = 'on';

-- 42. 성의 뒤에 세번째 글자가 so인 사람을 출력하시오
select *
from hr.employees
where substr(last_name, -3, 2) = 'so';

-- 43. 직원 정보를 출력하는데 이메일은 왼쪽에서 3글자만 출력하시오.
--     직원번호, 성, 급여, 직무, 이메일
select employee_id, last_name, salary, job_id, email, substr(email,1,3)
from hr.employees;

-- 44. 직원 정보를 출력하는데 이메일은 오른쪽에서 3글자만 출력하시오.
-- 직원번호, 성, 급여, 직무, 이메일
select employee_id, last_name, salary, job_id, email, substr(email,-3,3)
from hr.employees;

-- 45. 직원 정보를 출력하는데 이메일은 오른쪽에서 3글자만 출력하고 나머지는 ‘-’로 출력
---    직원번호, 성, 급여, 직무, 이메일
select employee_id, last_name, salary, job_id, email, rpad(substr(email,-3,3), length(email), '-')
from hr.employees;

--- 46. o가 있는 성 중 o가 몇번째에 있는 위치인지 출력하시오. 
--      직원번호 성, 성의 위치, 직무
select employee_id, last_name, instr(last_name, 'o'), job_id
from hr.employees;

--- 47. oc가 있는 성중 oc가 몇번째에 있는 위치인지 출력하시오.  
-- 직원번호 성, 성의 위치, 직무
select employee_id, last_name, instr(last_name, 'oc'), job_id
from hr.employees;

-- 48. 직무에 RE가 있는 경우 RE부터 3글자만 출력하시오.
--    직원번호 성,  직무, 가공된 직무
select employee_id, last_name, job_id, substr(job_id, instr(job_id, 'RE'), 3)
from hr.employees;

--- 49. 직원번호, 성, 입사일 , 급여, 
--- 급여를 10칸에 출력하고 나머지 공간 앞에 * 표시가 되게 하자.
select employee_id, last_name, hire_date, salary, lpad(salary, 10, '*')
from hr.employees;

-- 50. 직원번호, 성, 입사일 , 급여, 
--- 급여를 10칸에 출력하고 나머지 공간 뒤에 * 표시가 되게 하자.
select employee_id, last_name, hire_date, salary, rpad(salary, 10, '*')
from hr.employees;

-- 51. 직원번호, 성, 입사일, 직무를 출력하는데 
---    직무에 RE가 있다면 RE를 AB로 변경하여 출력.
select employee_id, last_name, hire_date, job_id, replace(job_id, 'RE', 'AB')
from hr.employees;

-- 52. 직원번호, 연락처, 커미션, 부서번호,급여
-- 급여를 3000으로 나누었을 때의 나머지를 출력하시오.
select employee_id, phone_number, commission_pct, department_id, salary, mod(salary, 3000)
from hr.employees;

-- 53. 2002년도부터 입사한 직원들을 출력하시오
select *
from hr.employees
where hire_date like '02%';

-- 54. 올해는 오늘까지 몇주가 지났는지 확인하시오.
select trunc((sysdate-to_date('2025/01/01'))/7,0)
from dual;

-- 55. 직원마다 몇년 근무했지를 출력하시오. 직원번호, 성, 연락처,부서, 근무년수
select employee_id, last_name, phone_number, department_id, months_between(sysdate, hire_date)/12
from hr.employees;

-- 56. 근속년수 8년 이상인 사원들만 출력하시오
select *
from hr.employees
where months_between(sysdate, hire_date)/12 >= 8;

-----------------------------------------------------------------------
--- 57. 예시 : 게시판리스트에서 제목을 5글자****인 것 처럼 
--- 직원의 성을 3글자만 출력 뒤에 *을 세번찍어서 출력하시오.
--- 직원번호, 입사일, 성
select employee_id, hire_date, last_name, rpad(substr(last_name, 1, 3), 6, '*')
from hr.employees;

--- 58. 홍길동은 몇글자입니까?
select length('홍길동')
from dual;

--- 59. )"홍길동 \n"으로 되어 있는 것을 html에서 행 바꿈이되도록
---      "홍길동 <br>"변경하시오.

--- 60.  결제가 이루어진 후 결제된 카드번호를 화면에 출력해야 하는 데 모든 번호를 출력하면 안된다.
---- 만약 카드번호가 1234 5678 9874 6321이라면 1234 **** 9874 6321로 출력되게 하시오.
