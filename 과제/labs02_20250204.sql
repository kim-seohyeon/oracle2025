-- like
-- 38. 성에 s가 포함되어 있는 직원을 출력하세요.
select * from hr.employees where last_name like '%s%';

-- 39. 직무에 'CL'이 포함된 사원들을 출력하시오.
select * from hr.employees where job_id like '%CL%';

-- 40. 직무에 'ST'이 포함된 사원들을 출력하시오
select * from hr.employees where job_id like '%ST%';

-- 41. 이름이 'B'로 시작하는 지원을 출력하세요.
select * from hr.employees where first_name like 'B%';

-- 42. 이름이 'a'로 끝나는 지원을 출력하세요.
select * from hr.employees where first_name like '%a';

-- 43. 02년도에 입사한 사원?
select * from hr.employees where hire_date like '02%';

-- 44. 02월에 입사한 사원은? --52번에 답
select * from hr.employees where hire_date like '___02%';

-- 45. 이메일에 두번째 글자가 'K'인 사원을 출력하시오.
select * from hr.employees where email like '_K%';

-- 46. 성에 두번째 글자가 'o'인 사원을 출력하시오.
select * from hr.employees where last_name like '_o%';

-- 47. 이메일에 세번째 글자가 'A'시작하는 사원?
select * from hr.employees where email like '___A%';

-- 48. 이메일에 세번째 글자가 'O'시작하는 사원?
select * from hr.employees where email like '___O%';

-- 49. 이메일의 마지막에서 두번째 글자 'O'인 사원은?
select * from hr.employees where email like '%O_';

-- 50. 이메일의 앞에서 두번재가 K이고 뒤에서 두번째가 'O'인 사원을 출력하시오.
select * from hr.employees where email like '_K%' and email like '%O_';

-- 51. IT_로 시작하는 직무를 구하시오
select * from hr.employees where job_id like 'IT\_%' escape '\';

-- 52. 02월에 입사한 사원들을 출력하세요.
select * from hr.employees where hire_date like '___02%';

-- null
-- 53. 커미션을 받지 못하는 직원들을 출력하시오.
select * from hr.employees where commission_pct is null;

-- 54. 상사가 없는 직원을 출력하시오.
select * from hr.employees where manager_id is null;

-- 55. 부서에 부서장이 없는 부서정보를 출력하세요.
select employee_id from hr.employees where manager_id is null;

---56. 부서가 없는 직원을 출력하시오.
select * from hr.employees where department_id is null;

--- 논리 연산자.. or, and : 부울타입과의 연산
-- 57. 직무가 AD_VP이면서 부서번호가 90인 사원들을 출력하세요.
select * from hr.employees where job_id = 'AD_VP' and department_id = 90;

-- 58. 급여가 10000이상이면서 직무에 'MAN'포함되어 있는 사원은?
select * from hr.employees where salary >= 10000 and job_id like '%MAN%';

-- 59. 급여가 5000과 10000 사이인 사원을 구하시오.
select * from hr.employees where salary between 5000 and 10000;

-- 60. 입사일이 03/06/17에서 05/09/21사이에 입사한 사원을 출력하시오.and사용
select * from hr.employees where hire_date between '03/06/17' and '05/09/21';

-- 61. 급여가 10000이상인 사원을 출력
select * from hr.employees where salary >= 10000;

-- 62. 직무에 'MAN'을 포함하고 있는 사원을 출력 
select * from hr.employees where job_id like '%MAN%';

-- 63. 61의 결과와 62의 결과를 같이 출력하세요.
-- 급여가 10000이상인 사람과 직무가 MAN을 포함하고 있는 사람을 출력하세요.
select * from hr.employees where salary >= 10000 or job_id like '%MAN%';

---64. 부서가 100인 사원과 직무가 'SA_REP'인 사원을 출력하시오.
select * from hr.employees where department_id = 100 or job_id = 'SA_REP';

-- 65.  부서가 100이면서 직무가 'SA_REP'인 사원을 출력하시오. //결과값 없음
select * from hr.employees where department_id = 100 and job_id = 'SA_REP';

-- 66. 직무가 'AD_PRES', 'AD_VP', 'IT_PROG'인 사원을 출력하세요
select * from hr.employees where job_id in ('AD_PRES', 'AD_VP', 'IT_PROG');
--or
select * from hr.employees where job_id='AD_PRES' or job_id='AD_VP' or job_id='IT_PROG';

-- 67. 직무가 IT_PROG이거나 직무가 ST_MAN이면서 급여가 6000이상인 사원을 출력하시오.
select * from hr.employees where (job_id='IT_PROG' or job_id = 'ST_MAN') and salary >= 6000;

-- 67. 직무가 'AD_PRES', 'AD_VP', 'IT_PROG'에 해당하지 않은 사원을 출력하세요
select * from hr.employees where job_id not in ('AD_PRES', 'AD_VP', 'IT_PROG');

-- 68. 급여가 6000보다 작거나  10000보다 큰 사원을 출력하세요.
select * from hr.employees where salary < 6000 or salary > 10000;

-- 69. 커미션을 받지않는 사원들을 구하시오.
select * from hr.employees where commission_pct is null;

-- 70. 커미션을 받는 사원들을 출력하세요.
select * from hr.employees where commission_pct is not null;

-- 70.  부서테이블에서 부서장이 있는 부서를 출력하시오.
select * from hr.departments where manager_id is not null;

-- 71. 급여를 기준으로 오름차순으로 정렬되어 급여, 사원번호, 이름, 입사일을 출력하세요.
select salary, employee_id, first_name, hire_date from hr.employees order by salary;

-- 72. 80번 부서의 사원들을 출력할 때 입사일이 제일 빠른 사람부터 출력하시오.
select * from hr.employees where department_id = 80 order by hire_date;

-- 73. 50번 부서의 사원들을 출력할 때 입사일이 제일 늦은 사람부터 출력하시오.
select * from hr.employees where department_id = 50 order by hire_date desc;

-- 74. 50번 부서의 사원들을 출력할 때  급여가 제일 작은 사람부터 출력하시오.
select * from hr.employees where department_id = 50 order by salary;

-- 75. 급여가 6000이상이고 10000이하인 사원들을 입사일이 빠른 사원들을 기준으로 출력하세요.
select * from hr.employees where salary between 6000 and 10000 order by hire_date;

-- 76. 
--- 사원번호, 이름, 입사일 , 급여, 부서번호 를 출력할 때 급여를 제일 많이 받는 사원부터 출력하시오. 급여에 sal로 별칭을 사용한다.
select employee_id, first_name, hire_date, salary as sal, department_id from hr.employees order by sal;

-- 77. 부서가 오름차순으로 정렬된 상태에서 부서내에 있는 직무를 오름차순으로 정렬히세요.
select * from hr.employees order by department_id, job_id;

-- 78. 부서가 오름차순으로 정렬된 상태에서 부서내에 있는 직무를 내림차순으로 정렬
select * from hr.employees order by department_id, job_id desc;

-- 79. 부서를 오름차순으로 정렬하고 각부서에서 직무가 내림차순으로 정렬된 상태에서
--- 직무에 따른 급여를 제일 많이 받는 사람부터 출력되게 하세요.
select * from hr.employees order by department_id, job_id desc, salary desc;

-- 80. 부서를 오름차순으로 정렬하여 출력하고 같은 부서에서 다른 직무를 가진 사원들이 있다면
--- 직무를 내림차순으로 정렬하고 같은 직무에서도 급여가 서로 다르므로 급여를 오름차순으로
--- 정렬하되 급여를 받는 사람들의 입사일을 오름차순으로 정렬하시오. 
select * from hr.employees order by department_id, job_id desc, salary, hire_date;

--- 81. 이름이 'steven'인 사람을  출력하시오.
select * from hr.employees where lower(first_name) = 'steven';
select * from hr.employees where first_name = initcap('steven');

-- 82. 성이 KING인 직원을 출력하세요.
select * from hr.employees where UPPER(last_name) = 'KING';
select * from hr.employees where last_name = initcap('KING');
