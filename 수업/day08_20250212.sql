create table jobs
as
select * from hr.jobs;

select * from hr.jobs;
desc jobs;

--- DML(Data M): select를 제외한 나머지 명령어는 TCL문을 사용해야 한다.
--- DDL(Data Define Language): create, alter, drop
--- DDL문에서는 TCL문을 사용하지 않음. 
--- TCL(Transaction Control Language): commit, rollback
-- Integer num <===> num integer
drop table jobs;
desc hr.jobs;
/* 자바
public class jobs{
        String jobId;
        String jobTitle;
        int minSalary;
        int maxSalary;
}
*/
create table jobs(
    job_id varchar2(10),
    job_title varchar2(35),
    min_salary number(6), -- 6자리
    max_salary number -- 기본으로 6자리
);
desc jobs;

select * from hr.jobs;
select * from jobs;
insert into jobs
values('AD_PRES', 'President', 20080, 40000);

insert into jobs(job_id, job_title, min_salary, max_salary)
values('AD_VP', 'Administration Vice President', null, null);
select * from jobs;

-- drop
drop table jobs;
select * from jobs;

create table jobs(
    job_id varchar2(10),
    job_title varchar2(35),
    min_salary number(6)not null, -- 6자리
    max_salary number not null-- 기본으로 6자리
);

insert into jobs
values('AD_PRES', 'President', 20080, 40000);

insert into jobs(job_id, job_title, min_salary, max_salary)
values('AD_VP', 'Administration Vice President', null, null); -- null 오류

insert into jobs(job_id, job_title, min_salary, max_salary)
values('AD_VP', null, 23000, 170000);

select * from jobs;

/*
class Board{
    int boardNum,
    String userId,
    String boardName,
    String boardSubjoct,
    String boardContent,
    Date boardDate,
    int readCount = 0
}
*/
drop table board;
create table board(
    board_Num number,
    user_Id varchar2(10),
    BOARD_NAME varchar2(20),
    BOARD_SUBJECT varchar2(100),
    BOARD_CONTENT varchar2(2000),
    BOARD_DATE date default sysdate,
    READ_COUNT number default 0
);
-- 임의의 데이터 넣기
insert into board(board_Num, user_Id, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(1, 'highland0', '이숭무', '제목', '내용');

select * from board;

insert into board(board_Num, user_Id, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT, BOARD_DATE, READ_COUNT)
values(1, 'highland0', '이숭무', '제목', '내용', default, default);

select * from board;

-- 삭제
delete from board;
commit;

insert into board(board_Num, user_Id, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT)
values(1, 'highland0', '이숭무', '제목', '내용');

insert into board(board_Num, user_Id, BOARD_NAME, BOARD_SUBJECT, BOARD_CONTENT, BOARD_DATE, READ_COUNT)
values(2, 'highland0', '이숭무', '제목', '내용', default, default);

select * from board;

-- 상세보기
select * from board where board_Num = 1;

-- 조회수 증가
update board
set read_count = read_count + 1
where board_num = 1;

select * from board
order by board_num desc;

update board
set board_content = '내용1', board_subject = '제목1', board_name = '이숭무1'
where board_num = 1;

select * from board
where board_num = 1;

--- 글쓰기 
insert into board(board_num, user_id, board_name, board_subject, board_content)
values(3, 'highland0', '이상범', '제목', '내용');

select * from board;

update board
set read_count = read_count +1
where board_num = 3;

select * from board
where board_num = 3;

update board
set board_content = '내용2', board_subject = '제목3'
where board_num = 3;

select * from board
where board_num = 3;

delete from board
where board_num = 3;

select * from board;

select max(board_num)+1 from board;

insert into board(board_num, user_id, board_name, board_subject, board_content)
values((select max(board_num)+1 from board), 'highland0', '이상범', '제목', '내용');

