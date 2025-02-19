select * from employees;
delete from employees; -- undo 테이블에 적용되지만 employees 테이블에는 적용이 되지 않음
select * from employees; 
rollback;
select * from employees;
truncate table employees; -- employees 테이블에 바로 적용
select * from employees;
rollback;
select * from employees;

insert into employees
select * from hr.employees;

select * from employees;
commit;
select * from employees;

-- 113인 사원 직무와 급여를 205번 사원의 급여와 직무로 변경하자
update employees
set job_id = (select job_id from employees where employee_id = 205)
    , salary = (select salary from employees where employee_id = 205)
where employee_id = 113;

select * from employees;

-- 사원번호가 100인 직원이 속해 있는 부서의 사원들의 직무를 사원번호가 200인 사원이 가지고 있는 직무로 변경하시오
select job_id
from employees
where manager_id = 100;

update employees
set job_id = (select job_id from employees where employee_id = 200)
where department_id = (select department_id from employees where employee_id = 100);

rollback;

--
select * from board;
desc board;
insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values((select max(board_num) + 1 from board), 'highland0', '이숭무', '제목', '내용');
select * from board;
delete from board;
commit;
select * from board;

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values((select max(board_num) + 1 from board), 'highland0', '이숭무', '제목', '내용');
rollback;

select nvl(max(board_num),0) + 1 from board;

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values((select nvl(max(board_num), 0) + 1 from board), 'highland0', '이숭무', '제목', '내용');

select * from board;

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(1, 'highland0', '이숭무', '제목', '내용');

select * from board;

-- primary key : 기본키
-- 기본 컬럼의 값은 중복 값을 허용하지 않는다.
desc board;
drop table board;
create table board(
    BOARD_NUM        NUMBER PRIMARY KEY,       -- SYS_C008364
    USER_ID          VARCHAR2(10) not null,   
    BOARD_NAME       VARCHAR2(20) not null,   
    BOARD_SUBJECT    VARCHAR2(100) not null,  
    BOARD_CONTENT    VARCHAR2(2000), 
    BOARD_DATE       DATE,           
    READ_COUNT       NUMBER  
);

select * from USER_CONSTRAINTS where table_name = 'BOARD';

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(1, 'highland0', '이숭무', '제목', '내용');

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(2, 'highland0', '이숭무', '제목', '내용');

select * from board;

-- 기본키 이름 변경
drop table board;
create table board(
    BOARD_NUM        NUMBER CONSTRAINT BOARD_PK PRIMARY KEY,       -- SYS_C008364
    USER_ID          VARCHAR2(10) not null,   
    BOARD_NAME       VARCHAR2(20) not null,   
    BOARD_SUBJECT    VARCHAR2(100) not null,  
    BOARD_CONTENT    VARCHAR2(2000), 
    BOARD_DATE       DATE,           
    READ_COUNT       NUMBER  
);

select * from USER_CONSTRAINTS where table_name = 'BOARD';

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(1, 'highland0', '이숭무', '제목', '내용');

-- 테이블에는 하나의 기본 키만 가질 수 있다.
drop table board;
create table board(
    BOARD_NUM        NUMBER CONSTRAINT BOARD_PK PRIMARY KEY,       -- 열 레벨
    USER_ID          VARCHAR2(10) not null /*CONSTRAINT BOARD1_PK PRIMARY KEY*/,   
    BOARD_NAME       VARCHAR2(20) not null,   
    BOARD_SUBJECT    VARCHAR2(100) not null,  
    BOARD_CONTENT    VARCHAR2(2000), 
    BOARD_DATE       DATE,           
    READ_COUNT       NUMBER  
);

-- 기본 키는 null값을 가질 수 없다
insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(null, 'highland0', '이숭무', '제목', '내용');

-- 테이블 레벨 적용
drop table board;
create table board(
    BOARD_NUM        NUMBER, -- 열 레벨
    USER_ID          VARCHAR2(10) not null /*CONSTRAINT BOARD1_PK PRIMARY KEY*/,   
    BOARD_NAME       VARCHAR2(20) not null,   
    BOARD_SUBJECT    VARCHAR2(100) not null,  
    BOARD_CONTENT    VARCHAR2(2000), 
    BOARD_DATE       DATE,           
    READ_COUNT       NUMBER,
    constraint board_pk primary key(board_num) -- 테이블 레벨
);

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(1, 'highland0', '이숭무', '제목', '내용');

select * from board;

insert into board(BOARD_NUM, USER_ID, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(1, 'highland0', '이숭무', '제목', '내용');

--------------
desc employees;
drop table employees;
create table employees(
    EMPLOYEE_ID             NUMBER(6) primary key,    
    FIRST_NAME              VARCHAR2(20), 
    LAST_NAME               VARCHAR2(25) NOT NULL, 
    EMAIL                   VARCHAR2(25) NOT NULL unique, 
    PHONE_NUMBER            VARCHAR2(20), 
    HIRE_DATE               DATE NOT NULL,         
    JOB_ID                  VARCHAR2(10)NOT NULL, 
    SALARY                  NUMBER(8,2),  
    COMMISSION_PCT          NUMBER(2,2),  
    MANAGER_ID              NUMBER(6),    
    DEPARTMENT_ID           NUMBER(4)  
);

select * from hr.employees;
insert into employees
values(100, 'Steven', 'King', 'SKING', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

--ORA-00001: 무결성 제약 조건(RHSM.SYS_C008381)에 위배됩니다.
select * from employees;
insert into employees
values(100, 'Steven', 'King', 'SKING', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

-- ORA-00001: 무결성 제약 조건(RHSM.SYS_C008382)에 위배됩니다. 이메일unique
-- unique도 primary key처럼 중복 허용X
insert into employees
values(101, 'Steven', 'King', 'SKING', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

drop table employees;
create table employees(
    EMPLOYEE_ID             NUMBER(6) constraint employees_PK primary key,  -- 열레벨  
    FIRST_NAME              VARCHAR2(20), 
    LAST_NAME               VARCHAR2(25) constraint emloyees_nn NOT NULL, 
    EMAIL                   VARCHAR2(25) NOT NULL constraint emloyees_uu unique, 
    PHONE_NUMBER            VARCHAR2(20), 
    HIRE_DATE               DATE NOT NULL,         
    JOB_ID                  VARCHAR2(10)NOT NULL, 
    SALARY                  NUMBER(8,2),  
    COMMISSION_PCT          NUMBER(2,2),  
    MANAGER_ID              NUMBER(6),    
    DEPARTMENT_ID           NUMBER(4)  
);

insert into employees
values(100, 'Steven', 'King', 'SKING', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

-- ORA-00001: 무결성 제약 조건(RHSM.EMLOYEES_UU)에 위배됩니다
insert into employees
values(101, 'Steven', 'King', 'SKING', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

select * from user_constraints where table_name = 'EMPLOYEES';
select * from user_cons_columns where table_name = 'EMPLOYEES';

-- not null은 열 레벨만 가능
drop table employees;
create table employees(
    EMPLOYEE_ID             NUMBER(6),
    FIRST_NAME              VARCHAR2(20), 
    LAST_NAME               VARCHAR2(25) constraint emloyees_nn NOT NULL,   -- 열 레벨  
    EMAIL                   VARCHAR2(25), 
    PHONE_NUMBER            VARCHAR2(20), 
    HIRE_DATE               DATE NOT NULL,         
    JOB_ID                  VARCHAR2(10)NOT NULL, 
    SALARY                  NUMBER(8,2),  
    COMMISSION_PCT          NUMBER(2,2),  
    MANAGER_ID              NUMBER(6),    
    DEPARTMENT_ID           NUMBER(4),
    constraint employees_PK primary key(employee_id), -- 테이블 레벨
    constraint emloyees_uu unique(email)
);

-- unique는 중복을 허용하지 않지만 null은 얼마든지 허용한다.
insert into employees
values(100, 'Steven', 'King', null, '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

insert into employees
values(101, 'Steven', 'King', null, '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);


-- foreign key
desc departments;

drop table departments;
create table departments(
    DEPARTMENT_ID            NUMBER(4) CONSTRAINT DEPT_ID_PK primary key,    
    DEPARTMENT_NAME          VARCHAR2(30) CONSTRAINT DEPT_NAME_NN NOT NULL, 
    MANAGER_ID               NUMBER(6),    
    LOCATION_ID              NUMBER(4)   
);

select * from dba_cons_columns where owner = 'HR' and table_name = 'DEPARTMENTS';
select * from dba_cons_columns where owner = 'HR' and table_name = 'EMPLOYEES';

select * from hr.departments;

insert into departments
values(90, 'Executive', 100, 1700);
select * from departments;

select * from employees;
insert into employees
values(102, 'Steven', 'King', 'SKING1', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 100);

drop table employees;
create table employees(
    EMPLOYEE_ID             NUMBER(6),
    FIRST_NAME              VARCHAR2(20), 
    LAST_NAME               VARCHAR2(25) constraint emloyees_nn NOT NULL,   -- 열 레벨  
    EMAIL                   VARCHAR2(25), 
    PHONE_NUMBER            VARCHAR2(20), 
    HIRE_DATE               DATE NOT NULL,         
    JOB_ID                  VARCHAR2(10)NOT NULL, 
    SALARY                  NUMBER(8,2),  
    COMMISSION_PCT          NUMBER(2,2),  
    MANAGER_ID              NUMBER(6),    
    DEPARTMENT_ID           NUMBER(4) references departments(DEPARTMENT_ID),
    constraint employees_PK primary key(employee_id), -- 테이블 레벨
    constraint emloyees_uu unique(email)
);
select * from departments;

-- ORA-02291: 무결성 제약조건(RHSM.SYS_C008424)이 위배되었습니다- 부모 키가 없습니다
insert into employees
values(102, 'Steven', 'King', 'SKING1', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 100);

select * from hr.employees;

insert into employees
values(102, 'Steven', 'King', 'SKING1', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

select * from employees;
select * from departments;

select * from user_constraints where table_name = 'EMPLOYEES';

drop table employees;
create table employees(
    EMPLOYEE_ID             NUMBER(6),
    FIRST_NAME              VARCHAR2(20), 
    LAST_NAME               VARCHAR2(25) constraint emloyees_nn NOT NULL,   -- 열 레벨  
    EMAIL                   VARCHAR2(25), 
    PHONE_NUMBER            VARCHAR2(20), 
    HIRE_DATE               DATE NOT NULL,         
    JOB_ID                  VARCHAR2(10)NOT NULL, 
    SALARY                  NUMBER(8,2),  
    COMMISSION_PCT          NUMBER(2,2),  
    MANAGER_ID              NUMBER(6),    
    DEPARTMENT_ID           NUMBER(4) constraint DEPARTEMENT_ID_FK references departments(DEPARTMENT_ID), -- 열 레벨
    constraint employees_PK primary key(employee_id), -- 테이블 레벨
    constraint emloyees_uu unique(email)
);
select * from user_constraints where table_name = 'EMPLOYEES';

drop table employees;
create table employees(
    EMPLOYEE_ID             NUMBER(6),
    FIRST_NAME              VARCHAR2(20), 
    LAST_NAME               VARCHAR2(25) constraint emloyees_nn NOT NULL,   -- 열 레벨  
    EMAIL                   VARCHAR2(25), 
    PHONE_NUMBER            VARCHAR2(20), 
    HIRE_DATE               DATE NOT NULL,         
    JOB_ID                  VARCHAR2(10)NOT NULL, 
    SALARY                  NUMBER(8,2),  
    COMMISSION_PCT          NUMBER(2,2),  
    MANAGER_ID              NUMBER(6),    
    DEPARTMENT_ID           NUMBER(4),
    constraint employees_PK primary key(employee_id), -- 테이블 레벨
    constraint emloyees_uu unique(email),        
    constraint PHONE_NUMBER_uu unique(PHONE_NUMBER),
    constraint DEPARTEMENT_ID_FK foreign key(DEPARTMENT_ID) references departments(DEPARTMENT_ID)
);

select * from user_constraints where table_name = 'EMPLOYEES';

insert into employees
values(102, 'Steven', 'King', 'SKING1', '515.123.4567', '03/06/17', 'AD_PRES', 24000, null, null, 90);

desc hr.jobs;
select * from hr.jobs;
select * from dba_constraints where table_name = 'JOBS' and owner = 'HR';

-- reference 하려면 기본키가 되어야 함
drop table jobs;
create table jobs(
    JOB_ID              VARCHAR2(10)  NOT NULL constraint JOB_ID_PK primary key,  
    JOB_TITLE           VARCHAR2(35) CONSTRAINT JOB_TITLE_NN NOT NULL, 
    MIN_SALARY          NUMBER(6),    
    MAX_SALARY          NUMBER(6)    
);

insert into jobs
select * from hr.jobs;

-- 제약조건은 가져오지 않음. not null만 적용
create table jobs
as
select * from hr.jobs;

drop table employees;
create table employees(
    EMPLOYEE_ID             NUMBER(6),
    FIRST_NAME              VARCHAR2(20), 
    LAST_NAME               VARCHAR2(25) constraint emloyees_nn NOT NULL,   -- 열 레벨  
    EMAIL                   VARCHAR2(25), 
    PHONE_NUMBER            VARCHAR2(20), 
    HIRE_DATE               DATE NOT NULL,         
    JOB_ID                  VARCHAR2(10)NOT NULL /*constraint job_id_fk references jobs*/, 
    SALARY                  NUMBER(8,2),  
    COMMISSION_PCT          NUMBER(2,2),  
    MANAGER_ID              NUMBER(6),    
    DEPARTMENT_ID           NUMBER(4),
    constraint employees_PK primary key(employee_id), -- 테이블 레벨
    constraint emloyees_uu unique(email),        
    constraint PHONE_NUMBER_uu unique(PHONE_NUMBER),
    constraint DEPARTEMENT_ID_FK foreign key(DEPARTMENT_ID) references departments(DEPARTMENT_ID),
    constraint job_ID_FK foreign key(job_id) references jobs -- 참조하는 테이블의 컬럼명과 같은 경우 컬럼명을 생략할 수 있다.

);

drop table a;
create table a(  -- 부모 테이블
    a1 number primary key,
    a2 number
);

create table b(  -- 자식 테이블
    b1 number,
    b2 number,
    a1 number references a
);

-- ORA-02291: 무결성 제약조건(RHSM.SYS_C008482)이 위배되었습니다- 부모 키가 없습니다
-- 부모 데이터를 추가하고 자식 데이터를 추가해야 함
insert into a values(1, 1);
insert into b values(11, 11, 1);

select * from a;
select * from b;

-- ORA-02292: 무결성 제약조건(RHSM.SYS_C008482)이 위배되었습니다- 자식 레코드가 발견되었습니다
delete from a;

-- 자식 데이터를 먼저 삭제하고 부모 데이터를 삭제해야 함
delete from b;
delete from a;

insert into a values(1, 1);
insert into b values(11, 11, 1);

-- on delete cascade : 부모 데이터가 삭제될 때 자식 데이터도 같이 삭제
drop table b;
create table b(  -- 자식 테이블
    b1 number,
    b2 number,
    a1 number references a on delete cascade -- 식별 관계
);

select * from b;
insert into b values(11, 11, 1);
select * from b;

delete from a;

select * from a;
select * from b;

-- on delete set null : 부모 데이터는 삭제하고 자식 데이터는 null 값
drop table b;
create table b(  -- 자식 테이블
    b1 number,
    b2 number,
    a1 number references a on delete set null --  비식별 관계
);
insert into a values(1, 1);
insert into b values(11, 11, 1);

select * from a;
select * from b;

delete from a;

select * from a;
select * from b;

-- check
drop table check_tb;
create table check_tb(
    eid number,
    city varchar2(20) check (city in ('서울', '인천', '부산', '대구', '대전') ),
    value1 integer not null check (value1 between 1 and 100),
    value2 number, 
    salary number check (salary > 0),
    gender char(1) check ( gender in ( 'M','F')) -- M,F
);


-- ORA-02290: 체크 제약조건(RHSM.SYS_C008488)이 위배되었습니다
insert into check_tb (value1, gender)
values(1, 'T');
select * from check_tb;

insert into check_tb (value1, gender)
values(1, 'M');
select * from check_tb;

insert into check_tb (city, value1, gender)
values('인천', 1, 'M');
select * from check_tb;

drop table check_tb;
create table check_tb(
    eid number,
    city varchar2(20),
    value1 integer not null ,
    value2 number, 
    salary number ,
    gender char(1) CONSTRAINT gender_CK check ( gender in ( 'M','F')) , -- M,F
    CONSTRAINT city_cK check (city in ('서울', '인천', '부산', '대구', '대전') ),
    CONSTRAINT value1_CK check (value1 between 1 and 100),
    CONSTRAINT salary_CK check (salary > 0)
    
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME= 'CHECK_TB'; 
