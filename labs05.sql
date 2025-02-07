-- 1. 성, 이름 , 급여, 부서, 부서명, 지역번호, 우편주소를 출력하시오
select last_name, first_name, salary
        , d.department_id, d.department_name
        , l.location_id, l.street_address
from hr.employees e join hr.departments d on d.department_id = d.department_id
                    join hr.locations l on d.location_id = l.location_id;

-- 4. 이름, 성, 부서명, 지역번호를 사원번호가 152인 사원만 출력하시오
select first_name, last_name
        , d.department_name
        , l.location_id
from  hr.departments d join hr.employees e on e.department_id = d.department_id
                       join hr.locations l on d.location_id = l.location_id
where employee_id = 152;

-- 5. 직원번호, 이름, 성, 직무, 직무내용, 부서명, 우편번호, 지역번호, 지역명, 국가명을 출력하시오 
select e.employee_id, first_name, last_name
        , j.job_id, job_title
        , d.department_name
        , postal_code, l.location_id, city
        , country_name
from hr.employees e join hr.jobs j on e.job_id = j.job_id
                    join hr.departments d on e.department_id = d.department_id
                    join hr.locations l on d.location_id = l.location_id
                    join hr.countries c on c.country_id = l.country_id;
                
-- 6. 직원번호, 성, 이름, 이메일, 부서번호, 부서명을 출력해주세요.
select employee_id, last_name, first_name, email, d.department_id
        , department_name
from hr.employees e join hr.departments d on e.department_id = d.department_id;

-- 7. 직무번호, 직무내용, 성, 이름, 입사일을 출력하고,
-- 직무번호가 'SA_REP' 이며 입사일이 '020816' 일부터 '050921'까지인 직원정보를 출력해주세요.
select j.job_id, job_title
        , last_name, first_name, hire_date
from hr.jobs j join hr.employees e on j.job_id = e.job_id
where j.job_id = 'SA_REP' and hire_date >= '02/08/16' and hire_date <= '05/09/21';

--8. 직원번호, 성, 이름, 부서번호, 부서명을 출력하며 커미션을 받지 않는사람만 출력해주세요.
select employee_id, last_name, first_name
        , d.department_id, department_name
from hr.employees e join hr.departments d on e.department_id = d.department_id
where commission_pct is null;

--9. 직원번호, 성, 이름, 부서번호, 부서명, 지역번호, 주소를 출력하고 도시가 'Toronto'에 사는 사람만 출력해주세요. 
select employee_id, last_name, first_name
        , d.department_id, department_name
        , l.location_id, street_address
from hr.employees e join hr.departments d on e.department_id = d.department_id
                    join hr.locations l on d.location_id = l.location_id
where city = 'Toronto';

--11. 부서번호가 60인 사원의 성, 이름, 사원 번호, 급여, 부서명을 출력하시오.
select last_name, first_name, employee_id, salary
        , d.department_name
from hr.employees e join hr.departments d on e.department_id = d.department_id
where d.department_id = 60;

--12. 급여가 4800인 사원의 사원 번호,직무 번호, 직무명, 최소급여(min_salary), 최대급여(max_salary)를 출력하시오.
select employee_id
        , j.job_id, job_title, min_salary, max_salary
from hr.employees e join hr.jobs j on e.job_id = j.job_id
where salary >= 4800;

-- 13. 지역번호가 1700인 사원의 성과 이름, 전화번호, 고용일을 출력하시오.
select location_id, last_name, first_name, phone_number, hire_date
from hr.employees e join hr.departments d on e.department_id = d.department_id
where location_id = 1700;

--14. 직무 최소 급여가 4000인 직무를 가진 사원의 성, 이름, 직무명을 출력하시오.
select last_name, first_name
        , job_title
from hr.employees e join hr.jobs j on e.job_id = j.job_id
where min_salary = 4000;

--15.대륙 번호(REGION_ID)가 4인 국가의 번호(COUNTRY_ID) 와 이름(COUNTRY_NAME) 을 출력하시오.(hr.countries)
select country_id, country_name
from hr.countries
where region_id = 4;

--16. 지역 번호와 주소, 우편번호(POSTAL_CODE), 도시명(CITY)이 출력되도록 하시오.
-- 단, UK인(country_id) 국가만 나오도록 출력하시오.
select location_id, street_address, postal_code, city
from hr.locations
where country_id = 'UK';

--17.직무의 평균 급여 중 가장 높은 평균금액를 출력하시오.
select max(avg(salary))
from hr.employees
group by job_id;
                  
--18. 우편번호(postal_code)가 비어있는 주소(street_address)와 도시명(city)을 출력하시오.

--19. 부서번호가 50인 사원의 직무시작과 직무종료일을 출력하시오.

--20. 나라 번호, 나라명, 지역 번호, 지역명(city)을 출력하시오

--21. 이름이 'Daniel'부터 'Irene'인 사원들의
-- 사원번호, 이름, 급여
-- 부서 번호, 부서명을 출력하시오
-- 단, 이름을 기준으로 오름차순으로 정렬하시오.

--22. 부서별로 가장 높은 급여를 출력하시오.
-- 단, 부서 번호를 기준으로 내림차순으로 정렬하시오.

--23. 직무에 'MA'가 들어가는 사원 중
-- 급여가 8000이 넘는 사원의 
-- 사원번호, 이름, 성, 직무
-- 부서 번호, 부서명을 출력하시오.

--24. 커미션이 null인 값은 0으로 바꾸고
--  급여에 커미션을 포함한 연봉을 구하시오
-- 사원 번호, 이름, 급여, 커미션, 연봉 출력
-- 단, 연봉의 별칭을 YEAR_SAL 로 표시하시오

--25. 부서번호가 20, 50, 80인 부서의 부서번호와 
-- 평균 급여, 최대 급여, 최소 급여, 급여 총 합을 출력하시오

--26. 직무의 최소 급여가 4000인 직무명, 
-- 해당 직무를 가진 직원의 성, 이름, 급여를 출력하시오.

--28. 직원 번호가 150번부터 173번인 직원의
-- 부서 번호, 부서명
-- 직원 번호, 성, 이름
-- 직무번호, 직무 내용을 출력하시오
-- 단, 직원 번호를 기준으로 내림차순으로 정렬하시오.

--29. 지역번호가 2700인 부서의 부서번호와 주소를 출력하시오

--30. 이름에 'AN'이 들어가는 직원의
-- 직원 번호, 이름, 부서, 부서명을 출력하시오
-- 단, 이름은 소문자, 대문자 상관없음
