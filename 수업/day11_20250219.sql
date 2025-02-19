-- 시퀀스
drop table goods;
create table goods(
    goods_num varchar2(10) primary key,
    goods_name varchar2(100),
    goodS_price number
);

insert into goods(goods_num, goods_name, goods_price)
values(1, '청바지', 1000);

insert into goods(goods_num, goods_name, goods_price)
values(2, '청바지', 1000);

-- 해당 컬럼 값을 자동으로 증가하기 위해
insert into goods(goods_num, goods_name, goods_price)
values((select nvl(max(goods_num),0)+1 from goods), '청바지', 1000);

select * from goods;
-- 시퀀스
/*
create sequence seq_num
increment by 10 -- 10씩 증가
start with 10 -- 시작하는 값
maxvalue 9990 -- 최댓값
nocycle -- maxvalue 값이 되면 그만. cycle은 처음으로 돌아가기
nocache; -- 메모리에 저장하지 않음. cachae 메모리에 저장
*/
drop sequence seq_num;
create sequence seq_num;
select seq_num.nextval  -- 다음 값
        , seq_num.currval -- 현재 값
from dual;
-- primary key는 중복데이터를 허용하지 않아 
-- seq_num.nextval 5 = insert goods_num 5 => insert goods 6
select * from goods;
insert into goods(goods_num, goods_name, goods_price)
values(seq_num.nextval, '청바지', 1000);

select * from board;

insert into board
values((select nvl(max(board_num),0)+1 from board), 'mem_10003', '이숭무', '제목', '내용', null, null);

select * from board;

-- 시퀀스는 값을 증가시키고 모든 테이블에 공유해서 사용할 수 있다.
-- 단, 증가값은 처음부터 시작하지 않는다.
-- 시쿼스를 사용하면 테이블의 값이 연속직이지 않을 수 있다.
/*
select board_seq.nextval from dual;
create sequence board_seq;
insert into board
values(board_seq.nextval, 'mem_10003', '이숭무', '제목', '내용', null, null);

select * from board;
*/

--
create sequence seq_mem;

select * from members;

insert into members(user_num, user_id, user_pw, user_name, user_birth
                    , user_gender, user_addr, user_ph1, user_ph2, user_regist, user_email)
values(concat('mem_', seq_mem.nextval + 100000), 'highland'||seq_mem.nextval, '111111', '이숭무', '99/12/12 00:00:00.000000000', 'M', '서울', '02-9876-1234', null, default, null);

-- index
-- 수시로 update와 delete가 발생하는 컬럼에 대해서는 
-- index 때문에 성능에 문제가 야기될 수 있다.
select * from user_indexes where table_name = 'EMPLOYEES';

select * from members;

select * from members
order by user_num;

select * from employees; -- primary key, unique인 경우에는 index로 생성

create index emp_hire_date_idx
on employees(hire_date); 

select * from employees
where hire_date = '07/06/21'; -- select

select * from user_indexes where table_name = 'EMPLOYEES';

-- 이름의 앞에서 두 글자가 'Oc'인 직원을 출력하시오
-- 결과값 없음
select * from employees 
where substr(first_name, 1, 2) = 'Oc';

-- 함수 기반의 index
create index sub_idx
on employees(substr(first_name, 1, 2));

select * from user_indexes where table_name = 'EMPLOYEES';

-- 각 부서의 급여의 평균이 10000인 부서와 평균급여를 출력하시오
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) = 10000;

-- ORA-00934: 그룹 함수는 허가되지 않습니다
-- group 함수는 index 만들 수 없다. why? 데이터를 추가하거나 삭제할 때 값이 변경 되니까
-- 고정된 값에서만 index를 만들 수 있다
create index avgsal
on employees(avg(salary));

-------------------------
-- 이름, 급여, 직무, 입사일, 부서를 출력하시오
select first_name, salary, job_id, hire_date, department_id
from employees;

-- inline view : from절에 있는 서브쿼리
select *
from(select first_name, salary, job_id, hire_date, department_id
     from employees);

-- 부서별 최대급여를 구하시오
select department_id, max(salary)
from employees
group by department_id;

-- 각 부서에서 최대급여를 받는 직원의 이름, 급여, 직무, 입사일, 부서를 출력하시오
select first_name, salary, hire_date, e.department_id, max_sal
from employees e join (select department_id, max(salary) as max_sal
                       from employees
                       group by department_id) me
on e.department_id = me.department_id and salary = max_sal;

-- 각 부서에서 최소급여를 받는 직원의 이름, 급여, 직무, 입사일, 부서를 출력하시오
select department_id, min(salary)
from employees
group by department_id;

select first_name, salary, hire_date, department_id
from employees;

select first_name, salary, hire_date, e.department_id, min_sal
from employees e join (select department_id, min(salary) as min_sal
                       from employees
                       group by department_id) me
on e.department_id = me.department_id and salary = min_sal;

-- 각 직무에서 최소 급여를 받는 사원의 사번, 이름, 급여, 직무, 입사일, 이메일, 부서번호
select employee_id, first_name, salary, e.job_id, hire_date, email, department_id, min_sal
from employees e join (select job_id, min(salary) as min_sal
                       from employees
                       group by job_id) d
on e.job_id = d.job_id and salary = min_sal
order by job_id;

-- 각 부서에서 평균 급여보다 많이 받는 사원의 사번, 이름, 급여, 직무, 입사일, 이메일, 부서번호 출력
select employee_id, first_name, salary, job_id, hire_date, email, e.department_id, avg_sal
from employees e join (select department_id, avg(salary) as avg_sal
                        from employees
                        group by department_id) d
on e.department_id = d.department_id and salary > avg_sal;

-- 병합 merge : 없으면 insert, 있으면 update or delete
-- 장바구니 : 없으면 insert 있으면 update
-- 좋아요, 관심상품(찜하기) : 없으면 insert, 있으면 update or delete
drop table emp;
create table emp
as
select * from hr.employees
where employee_id = 100;

select * from emp;

merge into emp e
using hr.employees he
on (e.employee_id = he.employee_id)
when matched then
update set salary = salary * 1.1
when not matched then
insert values(he.EMPLOYEE_ID, he.FIRST_NAME, he.LAST_NAME, he.EMAIL, he.PHONE_NUMBER, he.HIRE_DATE
              , he.JOB_ID, he.SALARY, he.COMMISSION_PCT, he.MANAGER_ID, he.DEPARTMENT_ID );

select * from emp;

delete from emp where employee_id = 106;

merge into emp e
using (select * from hr.employees where employee_id = 106) he
on (e.employee_id = he.employee_id)
when matched then
update set salary = salary * 1.1
when not matched then
insert values(he.EMPLOYEE_ID, he.FIRST_NAME, he.LAST_NAME, he.EMAIL, he.PHONE_NUMBER, he.HIRE_DATE
              , he.JOB_ID, he.SALARY, he.COMMISSION_PCT, he.MANAGER_ID, he.DEPARTMENT_ID );

select * from emp;

delete from emp
where employee_id = 101;

select * from emp;

merge into emp e
using (select * from hr.employees where employee_id = 101) he
on (e.employee_id = he.employee_id)
when matched then
update set salary = salary * 1.1
when not matched then
insert values(he.EMPLOYEE_ID, he.FIRST_NAME, he.LAST_NAME, he.EMAIL, he.PHONE_NUMBER, sysdate
              , he.JOB_ID, 10000, null, he.MANAGER_ID, he.DEPARTMENT_ID );

select * from emp;

-- 넣었다 뺐다
merge into emp e
using (select * from hr.employees where employee_id = 101) he
on (e.employee_id = he.employee_id)
when matched then
update set salary = salary * 1.1
delete where employee_id = 101
when not matched then
insert values(he.EMPLOYEE_ID, he.FIRST_NAME, he.LAST_NAME, he.EMAIL, he.PHONE_NUMBER, sysdate
              , he.JOB_ID, 10000, null, he.MANAGER_ID, he.DEPARTMENT_ID );

select * from emp;

-- window 함수 : group by : partition by
-- 모든 사원을 출력할 때 사원번호, 이름, 직무 그리고 부서와 급여의 합계를 출력하시오
/* inline view
select employee_id, first_name, job_id, e.department_id, sum_sal
from employees e join (select department_id, sum(salary) as sum_sal
                        from employees
                        group by department_id) d
on e.department_id = d.department_id;
*/

select employee_id, first_name, job_id, department_id
        , sum(salary) over(partition by department_id) as sum_sal -- window 함수
from employees;

-- 직무별 급여의 평균 그리고 사원번호, 이름, 급여를 출력
select employee_id, first_name, salary, job_id, avg(salary) over(partition by job_id order by job_id) as avg_sal
from employees;

-- employees 테이블의 첫 행부터 마지막 행까지
-- 직원 번호, 이름, 급여, 급여의 총 합계를 출력하시오
select employee_id, first_name, salary                     -- 첫 행               -- 마지막 행
        , sum(salary) over(order by salary rows between unbounded preceding and unbounded following) 
from employees;

select employee_id, first_name, salary
        , sum(salary) over() 
from employees;

-- employees 테이블의 첫 행부터 마지막 행까지
-- 직원 번호, 이름, 급여, 급여의 누적 합계를 출력하시오
select employee_id, first_name, salary
        , sum(salary) over(order by salary rows between unbounded preceding and current row ) 
from employees;

select employee_id, first_name, salary
        , sum(salary) over(order by salary rows between current row and unbounded following) 
from employees;

-- 순위 : rank() : 동순위 같은 값이 출력, 1, 1, 1, 4
select employee_id, first_name, salary, department_id
        , rank() over(partition by department_id order by salary desc) as rank
from employees;

-- dense_rank() -- 1, 1, 1, 2
select employee_id, first_name, salary, department_id
        , dense_rank() over(partition by department_id order by salary desc) as dense_rank
from employees;

select employee_id, first_name, salary, department_id
        , rank() over(partition by department_id order by salary desc) as rank
        , dense_rank() over(partition by department_id order by salary desc) as dense_rank
from employees;

-- 부서와 부서별 최대 급여와 이름, 사번, 급여, 직무를 출력
select employee_id, salary, job_id, department_id
from employees
order by department_id, salary desc;

-- first_value : 첫 번째 행 값 가져오기 => 최댓값 가져와라
select employee_id, first_name, salary, job_id, department_id
        , first_value(salary) over(partition by department_id order by salary)
from employees;

-- last_value : 마지막 행 값 가져오기 => 최솟값
select employee_id, first_name, salary, job_id, department_id
        , last_value(salary) over(partition by department_id order by salary)
from employees;

