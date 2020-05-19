/* schema가 다른 사용자가 자기 schema의 객체(table, views...)를 접근할 수
있도록 부여하는 방법

   권한부여 grant, 권한해제 revoke명령을 사용
	 
   1. 사용자권한
	    1) grant [select|insert|update|delete] on 테이블명 to 사용자
	    2) revoke [select|insert|update|delete] on 테이블명 from 사용자
	 
	 2. dba권한
	    1) grant [select|insert|update|delete] any 테이블명 to scott
	    2) revoke [select|insert|update|delete] any 테이블명 from scott

*/

/*
		Constraint(제약조건)
		
	  테이블에 올바른 데이터만 입력될 수 있도록 하고 잘못된 데이터는 사전에 막을
		수 있게 하기 위하여 테이블에 사전에 제약하도록 정하는 규칙을 말한다.
		
		제약조건의 종류
		1. not null : null값이 입력되지 못하도록 하는 규칙
		2. unique : 이 조건이 설정된 컬럼에는 중복값이 입력불가 규칙
		3. primary key : 이 조건은 not null + unique의 특징을 갖는다.
		                 pk는 테이블당 1개만 설정할 수 있다.
										 (컬럼은 여러개로 1개의 pk로 정의할 수 있다.)
		4. foregin key : 이 조건설정은 다른 테이블의 컬럼을 참조한다는 규칙
		5. check : 설정된 값만 입력가능하고 나머지는 불가
		           예를 들어 성별 F or M만 가능하게 하고 나머지는 불가
*/

-- 1. 테이블 생성시 지정하기
-- new_emp1에서 primary key, not null, unique, check, foregin key
create table new_emp1
(
			no				number(4)    constraint emp1_no_pk     primary key
		, name			varchar2(20) constraint emp1_name_nn   not null
		, jumin     varchar2(13) constraint emp1_jumin_nn  not null
													   constraint emp1_jumin_uk  unique
		, loc_code  number(1)    constraint emp1_loc_ck    check(loc_code < 5)
		, deptno    varchar2(6)  constraint emp1_deptno_fk references dept2(dcode)
)

insert into new_emp1 values(1, '홍길동', '8010111234567', 1, 1000);
insert into new_emp1 values(2, '홍길순', '9010111234567', 1, 1000);
insert into new_emp1 values(3, '홍길순', '9110111234567', 1, 1000);
insert into new_emp1 values(4, '홍길자', '9210111234567', 2, 1000);
insert into new_emp1 values(5, '홍길자', '9310111234567', 2, 1000);
select * from new_emp1

-- 약식으로 제약사항 설정
create table new_emp2
(
			no				number(4)    primary key
		, name			varchar2(20) not null
		, jumin     varchar2(13) not null unique
		, loc_code  number(1)    check(loc_code < 5)
		, deptno    varchar2(6)  references dept2(dcode)
)
select * from new_emp2

-- 테이블의 제약사항 조회
select * from all_constraints
 where owner = 'SCOTT'
   and table_name = 'NEW_EMP1'

select * from all_constraints
 where owner = 'SCOTT'
   and table_name = 'NEW_EMP2'

-- 2. 테이블 생성후 지정하기
-- 2-1 제약사항 추가하기 

-- name에 unique 추가
alter table new_emp2 add constraint emp2_name_uk unique(name)

-- loc_code에 not null 추가(기존에 같은 제약타입이 check가 있어 수정)
alter table new_emp2 
     modify (loc_code constraint emp2_loc_nn not null)

-- 실습)
create table c_test1 (
			no   	 number
		, name 	 varchar2(6)	
		, deptno number
)
create table c_test2 (
			no   	 number
		, name 	 varchar2(10)	
)
select * from c_test1;
select * from c_test2;

-- c_test1에 fk를 생성 (c_test2에 있는 no를 reference)
alter table c_test1
add constraint ctest1_deptno fk foreign key(deptno) reference c_test2(no)
-- 에러가 발생 : fk는 참조테이블의 pk 또는 unique인 컬럼만 적용이 가능
-- 즉, c_test2에는 pk와 unique컬럼이 없기 때문에 에러
-- fk를 생성하려면 c_test2에 사전에 pk/unique제약사항을 설정해야 한다.
alter table c_test2
add constraint ctest2_no_uk unique(no)

alter table c_test1
add constraint ctest1_deptno_fk foreign key(deptno) references c_test2(no)

select * from all_constraints
 where owner = 'SCOTT'
   and table_name like 'C_%'

insert into c_test2 values(10, '인사부');
insert into c_test2 values(20, '회계부');
insert into c_test2 values(30, '영업부');
select * from c_test2;

insert into c_test1 values(1, '길동', 10);
insert into c_test1 values(1, '길순', 20);
insert into c_test1 values(1, '길자', 30);
select * from c_test1;

insert into c_test1 values(1, '길녀', 40);

-- c_test2에서 30번부서를 삭제하기
-- 자식테이블에 값이 존재하기 때문에 에러
delete from c_test2 where no = 30

-- fk(fall in key)관계가 있는 경우에는 자식에서 삭제후 부모를 삭제할 수 있다
delete from c_test1 where deptno = 30
delete from c_test2 where no = 30

-- 부모를 삭제할 때 자식도 동시에 삭제하기(옵션:on delete cascade)
alter table c_test1 drop constraint ctest1_deptno_fk

alter table c_test1
add constraint ctest1_deptno_fk foreign key(deptno) references c_test2(no)
on delete cascade 
-- on delete set null 차이점

select * from all_constraints
 where owner = 'SCOTT'
   and table_name like 'C_%'
	 
delete from c_test2 where no = 30
select * from c_test2;
select * from c_test1;





