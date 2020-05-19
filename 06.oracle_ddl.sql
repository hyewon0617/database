/* 
	오라클에서의 data type 

  A. 문자형 데이터타입
	
		 1. char(n)     : 고정길이 / 최대 2000byte / 기본값은 1byte
		 2. varchar2(n) : 가변길이 / 최대 4000byte / 기본값은 1byte`
		 3. long        : 가변길이 / 최대 2GByte

  B. 숫자형 데이터타입	
		 1. number(p,s) : 가변숫자 / P(1~38, 기본값=38), S(-84~127, 기본값=0) / 최대22byte
		 2. float(p)    : Number하위타입 / P(1~128, 기본값=128) / 최대22byte

  C. 날짜형 데이터타입	
		 
		 1. date      : bc 4712.01.01 ~ 9999.12.31. 연,월,일,시,분,초까지 입력가능
		 2. timestamp : 연,월,일,시,분,초, 밀리초까지 입력 가능
	
  D. LOB 데이터타입	: LOB란 Large Object의 약자로 대용량 데이터를 저장할 수 있는
	   데이터 타입이다. 일반적으로 그래픽, 이미지, 사운드등 비정형 데이터를 저장할
		 때 LOB타입을 사용한다. 
		 
		 문자형 대용량 데이터는 CLOB나 NLOB를 사용하고 그래픽, 이미지, 동영상등의 
		 데이터는 BLOB를 주로 사용한다.
     1. clob  : 문자형 대용량 객체 고정길이와 가변길이 문자입합을 지원
		 2. blob  : 이진형 대용량 객체
		 3. bfile : 대용량 이진파일에 대한 위치, 이름을 저장
*/

-- A. 테이블 생성하기
-- create table 테이블명 (col1 데이터타입, ... coln 테이터타입);
-- 1. myFirstTable을 생성
create table myFirstTable (
		  no		number(3,1)
		, name  varchar2(10)
		, hiredate date
);

select * from myfirsttable;

-- 2. 테이블에 data를 추가
-- insert into 테이블명(col1, ... coln) values(val1, ... valn);
-- insert명령은 컬럼갯수와 값갯수가 동수이어야 한다.
insert into MYFIRSTTABLE(name) values('소향');
insert into MYFIRSTTABLE(no, name) values(1, '소향');
insert into MYFIRSTTABLE(no, name, hiredate) values(1, '소향', sysdate);
insert into MYFIRSTTABLE(no, name, hiredate) values(99.1, '소향', sysdate);
insert into MYFIRSTTABLE(no, name, hiredate) values(1000.1, '소향', sysdate);
insert into MYFIRSTTABLE(no, name, hiredate) values(100.11, '소향', sysdate);

-- 2. mySecondTable을 생성
create table mySecondTable (
		  no		number(3,1)  default 0
		, name  varchar2(10) default '홍길동'
		, hiredate date      default sysdate
);

select * from mySecondTable;

insert into mySecondTable(name) values('소향');
insert into mySecondTable(no, name) values(1, '소향');

-- 3. 한글이름으로 생성하기
create table 한글이름 (
			 컬럼1 number
			,컬럼2 varchar(10)
			,컬럼3 date
);
			
select * from 한글이름

insert into 한글이름(컬럼2) values('소향');
insert into 한글이름(컬럼1, 컬럼2) values(1, '소향');
insert into 한글이름(컬럼1, 컬럼2, 컬럼3) values(1, '소향', sysdate);
-- emp table을 참조해서 myemp테이블 생성하기
create table myemp (
			no  
			
			
			
			
			)
			

/*
  테이블 생성시 제한사항
	
	1. 테이블명은 반드시 문자로 시작, 중간에 숫자는 가능하다.
	한글, 특수문자도 가능, 특수문자를 사용할 경우는 큰따옴표로 감싸야하며
	특수문자 사용은 권장하지 않는다.
	2. 테이블명 or 컬럼명은 최대 30자(한글은 15자)까지 가능
	3. 테이블명 중복 불가
	4. 테이블명, 컬럼명에는 오라클 키워드를 사용할 수 없다.
*/
-- 5. 테이블 구조만 복사하기
create table myemp1
as
select * from emp where 1=2;
	
select * from emp;
select * from myemp1;

-- 6. 테이블 복사하기
create table myemp2
as
select * from emp

select * from myemp2

-- 6-1. 특정 컬럼만 복사하기
create table myemp3
as
select empno, ename from emp;

select * from myemp3


-- 7. 특정 조건으로 테이블 생성하기
create table mydept1
as
select * from dept where deptno in(10, 20, 40);

select * from mydept1

-- B. 테이블 수정하기
-- alter table 테이블명[add|rename|modify|drop]
create table dept6 as select * from dept2;
select * from dept6;

-- 1. 테이블수정(컬럼추가)
alter table dept6
			add(location varchar2(10));
select * from dept6;

-- 2. 테이블수정(컬럼명변경)
alter table dept6
			rename column location to loc;
select * from dept6;

-- 2-1. 컬럼수정(modify)
create table dept6 as select * from dept2;
select * from dept6;
alter table dept6
			add(location varchar2(10));
			
alter table dept6
			modify(dname number);
			
-- 오라클 SQL 명령어이기 때문에 실행 불가
-- desc dept6
			
-- 3. 테이블수정(컬럼명삭제)
alter table dept6
			drop column loc;
select * from dept6;

-- 4. 테이블명변경
alter table dept6
			rename to dept7
			
select * from dept7;
select * from dept6;
			
-- 5. 테이블 전체 자료삭제(자료만 전체삭제)
truncate table dept7
select * from dept7;

-- 6. 테이블삭제(테이블 객체를 완전히 삭제)
select * from dept7;
select * from 한글이름;
drop table dept7;
drop table 한글이름;

/* 연습문제 */
-- 1. 테이블생성
create table new_emp (
		  no		number(5)
		, name  varchar2(20)
		, hiredate date
		, bonus number(6,2)
);

select * from new_emp

-- 2. 특정 컬럼 복사 후 테이블 생성
create table new_emp2
as
select no, name, hiredate from new_emp;

-- 3. 테이블 구조만 가져오기
create table new_emp3
as
select * from new_emp2 where 1=2;

-- 4. 컬럼추가
alter table new_emp2
			add(birthday date);
insert into new_emp2(birthday) values(sysdate);
select * from new_emp2

-- 5. 컬럼명변경
alter table new_emp2
			rename column birthday to birth;

-- 6. 컬럼길이변경
alter table new_emp2
			modify(no number(7));
			
-- 7. 컬럼삭제
alter table new_emp2
			drop column birth
			
-- 8. 데이터만 삭제
truncate table new_emp2

-- 9. 테이블을 완전히 삭제
drop table new_emp2

select * from new_emp2

/*
 C. 데이터 딕셔너리
 
	1. 데이터 딕셔너리
	
		1) 데이터베이스의 자원을 효율적으로 관리하기 위해 다양한 정보를 저장하는 시스템이다.
		2) 사용자가 테이블을 생성하거나 변경하는 등의 작업을 할 때 데이터베이스 서버(엔진)에 
			 의해 자동 갱신되는 테이블이다
		3) 사용자가 데이터 딕셔너리의 내용을 수정하거나 삭제할 수 없다.
		4) 사용자 데이터 딕셔너리를 조회할 경우에 시스템이 직접 관리하는 테이블은 
			 암호화 되어 있기 때문에 내용을 알 수가 없다.
			 
	2. 데이터 딕셔너리 뷰
		- 오라클은 데이터 딕셔너리의 내용을 사용자가 이해할 수 있는 내용으로 
			변환하여 제공한다. 
			
		1)user_xxx
			a. 자신의 계정이 소유한 객체등에 관한 정보를 조회할 수 있다.
			b. user가 붙은 데이터 딕셔너리 중에서 자신이 생성한 테이블, 인덱스, 뷰등과 같은
			자신의 계정이 소유한 객체의 정보를 저장하는 user_tables가 있다.
				-select * from user_tables;
		2)all_xxx
			a. 자신 계정 소유 또는 권한을 부여 받은 객체등에 대한 정보를 조회할 수 있다.
		  b. 타 계정의 객체는 원천적으로 접근이 불가능하지만, 그 객체의 소유자가
				 접근할 수 있도록 권한을 부여하면 타 계정의 객체에도 접근이 가능하다.
				-select * from all_tables
				-select owner, table_name from all_tables where owner = 'scott'
		3)dba_xxx
			a. 데이터베이스 관리자만 접속 가능한 객체들의 정보를 조회
			b. DBA는 모두 접근이 가능하다. 즉, DB에 있는 모든 객체에 대한 정보를 조회할 수 있다.
			c. 따라서 DBA권한을 가진 sys, system계정으로 접속하면 dba_xxx 등의
				 내용을 조회할 수 있다.
*/
select * from user_tables;
select * from all_tables;





























