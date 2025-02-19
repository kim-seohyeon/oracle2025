--문제 1) 회원 테이블을 만드시오. 각 컬럼에 제약 조건을 부여 하시오. 제약 조건은 alter문을 이용할것 , 열레벨과 테이블 레벨 둘다 실습해 보세요.
--회원 제약조건
--user_num     : primary key (MEMBER_user_num_PK)
--USER_EMAIL : unique (member_USER_EMAIL_UU)
--USER_ID : unique (member_USER_ID_UU)
--USER_REGIST  : 디펄트 값은 sysdate
--USER_GENDER : M/F만 들어가야한다.
--USER_PH1  : 11에서 13자리만 들어가야 한다.
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
desc member;


--문제2) 게시판 테이블을 만들고 각 컬럼에 제약조건을 부여 하시오.제약 조건은 alter문을 이용할것 , 열레벨과 테이블 레벨 둘다 실습해 보세요.
--게시판 제약조건 
--BOARD_NUM : primary key (BOARD_BOARD_NUM_PK)
--READ_COUNT ; 디펄트 값은 0
--USER_num : FOREIGN KEY (BOARD_USER_NUM_FK)

DROP TABLE BOARD;
CREATE Table BOARD(
    BOARD_NUM      	NUMBER NOT NULL,        
    USER_num       	VARCHAR2(20) NOT NULL, 	  
    BOARD_NAME    	VARCHAR2(20) NOT NULL, 	    --- 글 쓴이 
    BOARD_PASS    	VARCHAR2(200) NOT NULL, 	 
    BOARD_SUBJECT 	VARCHAR2(100) NOT NULL,	 -- 제목
    BOARD_CONTENT   VARCHAR2(2000), -- 내용
    BOARD_DATE      TIMESTAMP,   
    IP_ADDR         VARCHAR2(15),   
    READ_COUNT      NUMBER   
);
-- 기본키 테이블 레벨
alter table board
add(constraint BOARD_BOARD_NUM_PK primary key(BOARD_NUM));

select * from user_cons_columns where table_name = 'BOARD';

-- READ_COUNT ; 디펄트 값은 0
alter table board
modify(read_count number default 0);

-- USER_num : FOREIGN KEY (BOARD_USER_NUM_FK)
alter table board
add(constraint BOARD_USER_NUM_FK foreign key(USER_NUM) references members(USER_NUM));

select * from user_constraints where table_name = 'BOARD';
desc board;

--문제 3) 회원테이블에 아래 내용을 포함하여 5개의 데이터를 넣으시오.
--회원번호는 mem_100001부터 부여된다.
insert into MEMBERS (USER_num, user_id, USER_PW, USER_NAME, USER_BIRTH, USER_GENDER, USER_ADDR, USER_PH1, USER_PH2, USER_REGIST, USER_EMAIL)
values((select concat('mem_', nvl(max(substr(USER_num,5)),10000) + 1) from members),'highland1','111111','이숭무','1999-12-12','M','서울','010-1234-1234',null,default,null);
SELECT * FROM MEMBERS;

DESC MEMBERS;

COMMIT;

--문제4)게시판 테이블에 데이터를 아래 내용 포함 6개 이상을 넣는데 위 회원들은 최소 한개 이상 게시글이 등록되게 하시오.
--BOARD_NUM은 입력하지 않고 자동부여가 되게 작성하시오. 
insert into board(BOARD_NUM, USER_NUM, BOARD_NAME, BOARD_PASS, BOARD_SUBJECT, BOARD_CONTENT, IP_ADDR)
values((select nvl(max(BOARD_NUM)+1, 1) from board), 'mem_10004' , '상장범 아빠', '1111','제목', '내용', '192.168.3.117');
select * from board;

desc board;
desc members;

--문제5) highland0회원의 회원아이디, 회원명, 이메일, 게시글 번호, 게시글 제목, READ_COUNT를 출력하시오.
select user_id, user_name, user_email
        , board_num, board_subject, read_count
from members m join board b on m.user_num = b.user_num
where user_id = 'highland0';

--문제6) 게시글을 읽으면 READ_COUNT가 1씩 증가 할 것이다. 
--         update문을 실행 할 때마다 READ_COUNT 1증가 할수 있게 update문을 작성하시오.
--         1번 게시글을 증가 시키시오.
update board
set read_count = read_count +1
where board_num = 1;

select * from board;

--문제 7) 게시글 2번에 해당하는 회원을 출력하시오.
select * 
from members
where user_num = (select user_num from board where board_num = 2);

--문제 8) 등록된 게시글의 개수를 출력하시오.
select count(*)
from board;

--문제 9) 각 회원의 게시글의 갯수를 출력하시오. (조인 아님)
select user_num, count(*)
from board
group by user_num;

--문제 10) 회원의 수를 출력하시오.
select count(user_num)
from members;

--문제 11) 아이디가 'highland0'인 회원의 전화번호를 '02-9876-1234', 이메일을 'highland0@nate.com', 비밀번호를 '22222'로 변경하시오.
update members
set user_ph1 = '02-9876-1234', user_email = 'highland0@nate.com', user_pw = '22222'
where user_id = 'highland0';

select * from members;

--문제 12) 게시글 1번의 제목을 '나는 열심히 공부할래', 내용을 '열심히 공부해서 \n 빨리 취업이 될 수 있게 노력해야지'로  수정하시오.
update board
set board_subject = '나는 열심히 공부할래', board_content = '열심히 공부해서 \n 빨리 취업이 될 수 있게 노력해야지'
where board_num = 1;

select * from board;

--문제 13) 1번 게시글을 출력할 때 내용의 \n을 <br /> 로 출력되게 하시오.
select replace(board_content, '\n', '<br />')
from board
where board_num = 1;

--문제 14)  게시글 제목이 너무 길어서 화면에 다 출력되기 어렵다 . 
-- 제목을 첫번째 글자 부터 5글자를 출력하고 뒤에는 *를 5개가 출력되게 하시오.
select substr(board_subject,1,5) || '*****' from board;

--문제 15) '이숭무'회원이 아이디를 잊어버렸다고 한다. 
-- 이메일과 전화번호를 이용해서 아이디를 출력하는 데 아이디는 모두 출력해서는 안되고 첫글자부터 세글자 나머지는 '*'로 출력되게 하시오.
select * from members;

select rpad(substr(user_id,1,3), length(user_id), '*')
from members
where user_email = 'highland0' or user_ph1 = '02-9876-1234' ;

--문제 16) 게시판 테이블에서 게시글을 많이 쓴 게시글의 user_num를 게시글 갯수와 같이 출력하시오.
select max(count(*))
from board
group by user_num;

--문제 17) 지금까지의 작업을 모두 정상 종료 시키시오.
commit;

--문제 18) '이숭무'회원이 탈퇴하려고 한다. 이숭무 회원이 탈퇴 할수 있게 삭제하시오.


--문제 19) '이숭무' 회원이 탈퇴하는 것이 아니었는 데 잘 못 삭제를 하였다 . 정상적으로 '이숭무'회원에 대한 모든 내용이(게시판 포함) 존재 할 수 있게 하시오.


--문제 20) ‘highland0’인 회원이 로그인을 하여 자신이 쓴 글인 1번 게시글을 삭제하려고 한다.
--해당 게시물이 삭제 되게 하시오.
