/*
	Sequence
	
	시퀀스란 자동으로 순차적으로 증가하는 일련번호를 반환하는 오라클 데이터베이스의 객체이다.
	보통 PK값에 중복을 방지하기 위해서 사용된다. 예를들어 게시판에 글이 추가될때마다 글번호(PK)가
	생겨야 된다면 시퀀스를 사용하면 보다 쉽고 편리하게 PK를 관리할 수 있다.
	
	1. 유일(unique)한 값을 생성해주는 오라클 객체이다.
	2. 시퀀스를 생성하면 기본기와 같이 순차적으로 증가하는 컬럼을 자동으로 생성 가능
	3. 보통 PK값을 생성하기위해 사용한다.
	4. 시퀀스는 테이블과 독립적으로 저장되고 생성된다.
	
	sequence 문법
	
	create sequence 시퀀스이름
	[start with n]
	[increment by n]
	[maxvalue n | nomaxvalue]
	[minvalue n | nominvalue]
	[cycle | nocycle]
	[cache | nocache]
	
	-start with : 시퀀스의 시작값을 n을 1000으로 지장하면 1000부터 일련번호가 생성
	-increment by : 시퀀스의 자동증가값을 지정 n이 10이면, 1010, 1020...
	-maxvalue : 시퀀스의 최대값
	-minvalue : 시퀀스의 최소값
	-cycle | nocycle : 최대값이 도달할 경우 처음부터(start with) 다시 시작여부 정의
	-cache | nocache : cache 여부설정, 원하는 숫자만큼 미리 생성해서 메모리에 저장
	
	alter sequence 시퀀스이름
	[start with n]
	[increment by n]
	[maxvalue n | nomaxvalue]
	[minvalue n | nominvalue]
	[cycle | nocycle]
	[cache | nocache]
	
	
	drop sequence 시퀀스이름
	
	SELECT * FROM USER_SEQUENCES
*/

-- 시퀀스이름 jno_seq,  시작번호=100, 끝=110, 증가값=1, cycle=yes, cach=2
-- 반복될 때 다시 시작되는 값은 90
create sequence jno_seq
 start with 100
 increment by 1
 maxvalue 110
 minvalue 90
 cycle
 cache 2;
 
	
-- 실습 테스트테이블 s_order
create table s_order (
		ord_no		number,
		ord_name  varchar2(10),
		p_name    varchar2(20),
		p_qty     number
		
)

-- sequence에 접근명령
-- 현재번호 jno_seq.currval
-- 다음번호 jno_seq.nextval

select * from s_order;
SELECT * FROM USER_SEQUENCES

insert into s_order values(jno_seq.nextval, '소향', 'apple', 5);
insert into s_order values(jno_seq.nextval, '홍길동', 'banana', 3);

select jno_seq.currval from dual
select jno_seq.nextval from dual

-- maxavalue/minvalue 실습
begin
	for i in 1..9 loop
	insert into s_order values(jno_seq.nextval, '소향', 'cherry', 3);
	end loop;
end;

select * from s_order;

-- 별도의 시퀀스 적용하기
create sequence jno_seq1;
select * from user_sequences;
insert into s_order values(jno_seq1.nextval, '손흥민', '군대면제', 1);
select * from s_order;

-- 값이 감소되는 sequence
create sequence jno_seq_rev
increment by -2
minvalue 0
maxvalue 20
start with 10;
select * from user_sequences;

create table s_rev1(no number);
select * from s_rev1;
insert into s_rev1 values(jno_seq_rev.nextval);
select * from s_rev1;

-- 시퀀스 삭제
drop sequence jno_seq1;
select * from user_sequences;





















