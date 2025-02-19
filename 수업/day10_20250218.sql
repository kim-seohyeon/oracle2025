--문제 1) 회원 테이블을 만드시오. 각 컬럼에 제약 조건을 부여 하시오. 제약 조건은 alter문을 이용할것 , 열레벨과 테이블 레벨 둘다 실습해 보세요.
--회원 제약조건
--user_num     : primary key (MEMBER_user_num_PK)
--USER_EMAIL : unique (member_USER_EMAIL_UU)
--USER_ID : unique (member_USER_ID_UU)
--USER_REGIST  : 디펄트 값은 sysdate
--USER_GENDER : M/F만 들어가야한다.
--USER_PH1  : 11에서 13자리만 들어가야 한다.

/*
MEMBERS
user_num          not null          VARCHAR2(20)  
USER_ID     	NOT NULL 	VARCHAR2(20)  
USER_PW     	NOT NULL 	VARCHAR2(200) 
USER_NAME   	NOT NULL 	VARCHAR2(40)  
USER_BIRTH  	NOT NULL 	TIMESTAMP 
USER_GENDER 	NOT NULL 	VARCHAR2(1)   
USER_ADDR   	NOT NULL 	VARCHAR2(200) 
USER_PH1    	NOT NULL 	VARCHAR2(13)  
USER_PH2             		VARCHAR2(13)  
USER_REGIST          		TIMESTAMP  
USER_EMAIL           		VARCHAR2(200) 
JOIN_OK              			VARCHAR2(500)
*/
drop table MEMBERS;
create table MEMBERS(
    user_num VARCHAR2(20) not null,
    USER_ID VARCHAR2(20)  not null,
    USER_PW VARCHAR2(200)  not null,
    USER_NAME VARCHAR2(200)  not null,
    USER_BIRTH TIMESTAMP NOT NULL,
    USER_GENDER VARCHAR2(1)  not null,
    USER_ADDR  VARCHAR2(1)  not null,
    USER_PH1  VARCHAR2(13)  not null
);

-- Date : 20 25 02 18 09 19 30
--        세기 년 월  일  시 분 초
-- timestamp : 2543871523817 : 1970년 1월 1일 0시 1분 1초 lms : 1
                            -- 1970년 1월 1일 0시 1분 2초 2ms : 2
                            -- 1970년 1월 1일 0시 1분 3초 3ms : 3
-- timestamp => Date

desc members;
-- 행 데이터에 값이 없을 경우에만 not null을 사용할 수 있음
alter table members
add (USER_PH2 VARCHAR2(13), USER_EMAIL  VARCHAR2(200) not null);
     
alter table members
add (USER_REGIST  TIMESTAMP DEFAULT sysdate);

alter table members
modify ( USER_PW VARCHAR2(300), USER_EMAIL  null);
        
-- 여러개의 컬럼은 동시에 삭제 할 수 없다.
alter table members
drop COLUMN USER_EMAIL; 

-- 제약조건 테이블에 만들어진다. 
-- 테이블을 삭제하면 제약조건도 삭제된다.
ALTER TABLE MEMBERS
MODIFY (user_num CONSTRAINT user_num_PK PRIMARY KEY ); -- 열레벨

-- 기본키 삭제
ALTER TABLE MEMBERS
DROP CONSTRAINT user_num_PK;

-- user_num 테이블 레벨
ALTER TABLE MEMBERS
ADD CONSTRAINT user_num_PK PRIMARY KEY(user_num);

-- 기본키 확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME= 'MEMBERS';

-- user_addr 수정
ALTER TABLE MEMBERS
MODIFY (user_addr VARCHAR2(200));

-- user_email 추가
alter table members
add(user_email varchar2(200));

desc members;

-- user_email 열레벨
--alter table members
--modify(user_email constraint user_email_uu unique);

-- user_email, user_id 테이블 레벨
alter table members
add(constraint user_email_uu unique(user_email)
, constraint user_id_uu unique(user_id)); 

-- gender_ck
alter table members
add(constraint user_gender_ck check(user_gender in ('F', 'M')));

-- user_ph_ck
alter table members
add(constraint USER_PH1_ck CHECK (LENGTH(USER_PH1) BETWEEN 11 AND 13 ));

select * from user_constraints where table_name = 'MEMBERS';
desc members;

insert into MEMBERS (USER_num, user_id, USER_PW, USER_NAME, USER_BIRTH, USER_GENDER, USER_ADDR, USER_PH1, USER_PH2, USER_REGIST, USER_EMAIL)
values((select concat('mem_', nvl(max(substr(USER_num,5)),10000) + 1) from member),'highland0','111111','이숭무','1999-12-12','M','서울','010-1234-1234',null,default,null);
SELECT * FROM MEMBERS;
------------------------------------------
create table aa(
    a1 number, -- pk
    a2 number

);

create table bb(
    a1 number, -- pk/fk
    b1 number, -- pk
    b2 number
);

-- 단일 식별자
alter table aa
add(constraint a1_pk primary key(a1)); 

-- 복합키, 복합식별자 : 기본키 하나에 속성 2개
alter table bb
add(constraint a1_b1_pk primary key(a1, b1));

select * from user_cons_columns where table_name = 'BB';
select * from user_cons_columns where table_name = 'AA';

alter table bb
add constraint bb_a1_fk foreign key(a1)
    references aa(a1);

insert into aa(a1, a2) values(1,1);    
insert into bb(a1, b1, b2) values(1, 11, 22);
-- ORA-00001: 무결성 제약 조건(RHSM.A1_B1_PK)에 위배됩니다
insert into bb(a1, b1, b2) values(1, 11, 33);
-- 복합키의 값이 같지 않아야 함
insert into bb(a1, b1, b2) values(1, 12, 33);

select * from aa;
select * from bb;

desc bb;
-- 컬럼 이름 변경
alter table bb
rename column b2 to b3;

-- 제약 조건명 변경
alter table bb
rename constraint bb_a1_fk to bb_a11_fk;

-- 테이블 이름 변경
alter table bb
rename to bbb;

select * from bbb;
----------------------------------------
/*
alter tale table명
add (column, constraint)
modify colmn명 옵션
drop column 컬럼명 constraint 제약명
*/

----------------------------------
-- view
truncate table departments;
insert into departments
select * from hr.departments;

insert into employees
select * from hr.employees;

-- 부서 80
select employee_id, last_name, salary
from employees
where department_id = 80;

create table vw_emp80
as
select employee_id, last_name, salary
from employees
where department_id = 80;
select * from vw_emp80;

-- 90 부서의 모든 직원을 가져오시오
select * from employees
where department_id = 90;

create view vw_emp90
as
select * from employees where department_id = 90;
select * from vw_emp90;

-- job_id가 SA_REP
create view vw_emp_SA_REP
as
select * from employees where job_id = 'SA_REP';
select * from vw_emp_SA_REP;

-- 뷰를 생성하거나 수정할 때 모두 create or replace view view명
-- 뷰를 생성하거나 덮어쓰기
create or replace view empvu80
(eid, sal, fname, did) -- 별칭
as
select employee_id, salary, first_name, department_id
from employees
where department_id = 80;

select * from empvu80;

-- 복합뷰(join이 포함 되어 있는 뷰)로 직원번호, 이름, 급여, 부서번호, 부서명 출력
create or replace view dep_emp
as
select employee_id, first_name, salary
        , d.department_id, department_name
from employees e join departments d on e.department_id = d.department_id;

select * from dep_emp;

-- 사번, 이름, 직무, 급여, 입사일, 커미션을 포함한 연봉
-- (year_sal : 연봉은 null이 될 수 없음)을 출력할 때
-- 직무에 'REP'가 포함된 사원들만 출력
create or replace view rep_view
as
select employee_id, first_name, job_id, salary, hire_date, salary * (1 + nvl(commission_pct,0))*12 as year_sal
from employees
where job_id like '%REP%';

select * from rep_view;

create or replace view vw_emp30
as
select * from employees
where department_id = 30;

select * from vw_emp30;

delete from employees where department_id = 90;
delete from employees where department_id = 114;

select * from employees where department_id = 30;
select * from hr.employees where department_id = 90;
select * from hr.employees where department_id = 114;
select * from employees where department_id = 114;

-- view를 통해서 실제 테이블에 dml문을 사용할 수 있다.
-- 삽입
insert into vw_emp30
values(114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '02/12/07', 'PU_MAN', 11000, null, 100, 30);

select * from vw_emp30;
-- 수정
update vw_emp30
set hire_date = sysdate
where employee_id = 114;

select * from vw_emp30;
-- 삭제
delete from vw_emp30
where employee_id = 30;

select * from vw_emp30;
-- 
select * from employees where department_id = 90;
select * from hr.employees where department_id = 90;

-- 뷰에서 insert는 보이지 않아도 가능하다
select * from vw_emp30; -- 부서 30만 출력
insert into vw_emp30
values(100, 'Steven', 'King', 'SKING', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

select * from vw_emp30;

select * from employees;

-- 뷰는 보이는 것만 삭제할 수 있다.
delete from vw_emp30
where department_id = 90;

-- 보여지는 컬럼에만 DML문을 사용할 수 있다.
-- 부서가 50인 사원의 사원번호, 성, 이메일, 입사일, 직무가 보이는 뷰를 만드시오
-- 뷰명은 emp50vw
create or replace view emp50vw
as
select employee_id, last_name, email, hire_date, job_id
from employees
where department_id = 50;

select * from emp50vw;

-- 값의 수가 너무 많습니다.
insert into emp50vw
values(300, '장', 'jang', sysdate, 'ST_MAN', 100);

insert into emp50vw
values(300, '장', 'jang', sysdate, 'ST_MAN');

-- 보여지지 않는 컬럼 값은 저장되지 않는다.
-- 보여지는 컬럼에만 값을 저장할 수 있다.
insert into emp50vw(employee_id, last_name, email, hire_date, job_id, manager_id)
values(300, '장', 'jang', sysdate, 'ST_MAN', 100);

-- SQL 오류: ORA-00904: "SALARY": 부적합한 식별자
-- 보여지는 컬럼에만 update 할 수 있다.
update emp50vw
set salary = 300;

-- email은 보여지는 컬럼이므로 수정이 되는 것을 알 수 있다.
-- insert는 뷰를 통해 보여지지 않는 데이터도 저장이 가능하다. 컬럼은 보여지는 컬럼이어야 한다.
update emp50vw
set email = 'aaaa'
where employee_id = 198;

select * from emp50vw;

-- 각 부서의 급여의 합계, 최소 급여, 최대 급여, 급여의 평균, 부서의 사원수를 출력하시오
create or replace view vw_grp
(did, sum_sal, min_sal, max_sal, avg_sal, cnt)
as
select department_id, sum(salary), min(salary), max(salary), avg(salary), count(*)
from employees
group by department_id;

select * from vw_grp;

-- 단순뷰일 때는 뷰를 통해서 DML이 가능하다. 
-- 그럴 때 select만 되도록 읽기 전용으로 만들자.
create or replace view empvu10
as
select employee_id, last_name, email, hire_date, job_id, department_id
from employees
where department_id = 10;

insert into empvu10
values(301, '이', 'high', sysdate, 'AD_ASST', 10);

select * from empvu10;

-- 읽기모드 : with read only를 했음
create or replace view empvu10
as
select employee_id, last_name, email, hire_date, job_id, department_id
from employees
where department_id = 10
with read only;
-- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
insert into empvu10
values(302, '이', 'high', sysdate, 'AD_ASST', 10);

-- with check option : 뷰에 보이는 것만 DML을 할 수 있게 하자
select * from empvu10;
create or replace view empvu10
as
select employee_id, last_name, email, hire_date, job_id, department_id
from employees
where department_id = 10
with check option;

insert into empvu10
values(303, '이', 'high1', sysdate, 'AD_ASST', 10);

insert into empvu10
values(303, '이', 'high2', sysdate, 'AD_ASST', 100);

select * from empvu10;

create or replace view empvu10
as
select employee_id, last_name, email, hire_date, job_id, department_id
from employees
where department_id = 10
with check option constraint empvu30_ck;
select * from empvu10;





