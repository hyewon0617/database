/*
INDEX

	1. 인덱스란 어떤 특정의 데이터가 HDD(하드디스크)의 어느 위치에 있는지에 대한
	정보를 가진 주소록과 같은 개념이다.

	인덱스는 데이터와 위치주소(rowid)정보를 key와 value의 형태로 한 쌍으로 저장하고 관리된다.

	인덱스의 가장 큰 목적은 데이터를 보다 빠르게 검색 또는 조작을 하기 위함이다.
	데이터위치정보 즉 주소는 rowid로서 총 10byte의 크기를 갖는다.

	2. rowid구조(AAA5rAAEAAAAFdAAC)
	AAAE5r : 데이터오브젝트번호
	AAE    : 파일번호
	AAAAGd : block번호
	AAC    : row번호
	
	3. 인덱스사용이유
	
		1) 조회속도를 향상시키기 위해
		2) 보통 index데이블의 특정 컬럼에  한개 이상을 주게 되면 index table이 따로 만들어지는데
			 이 index테이블에는 인덱스컬럼의 로우값과 rowid값이 저장되고 로우의 값은 정렬된
			 b-tree구조로 저장시켜두어 검색시에 좀더 빠르게 해당 데이터를 검색하는데 도움을 준다.
		3) 하지만 update, delete, insert시에는 속도가 느려진다는 단점이 있다.
		
	4. 인덱스가 필요한 경우
		
		1) 데이터가 대용량일 경우
		2) where조건에 자주 사용되는 컬럼들인 경우
		3) 조회결과가 전체 데이터수의 3-5% 미만일 경우 
			 인덱스스캔이 효율적이고 보다 적은 비용으로 빠르게 검색할 수 있다.
			 
  5. 인덱스가 불필요한 경우
	
		1) 데이터가 적은(수천건미만)경우에는 인덱스를 설정하지 않는게 오히려 성능이 좋다.
		2) 조회보다 insert, delete, update처리가 많은 테이블
		3) 조회결과가 전체행의 15%이상일 경우
		
	6. 인덱스가 자동생성될 때는 테이블 정의시에 pk, uk를 제약조건을 정의할 때 자동으로 생성된다.
	
	7. index 문법
	
		1) 생성 : create index 인덱스명 on 테이블명(컬럼1,...컬럼n)
		2) 삭제 : drop index 인덱스명
						  ... 테이블이 삭제되면 자동으로 인덱스도 삭제가 된다.
*/

-- rowid는 rowidtochar(rowid)함수를 사용해서 조회할 수 있다.
select length(rowidtochar(rowid)),			 rowidtochar(rowid), -- 7521자료가 저장된 HDD의 위치(주소)
			 empno, ename
	from scott.emp 
	where empno = 7521
	
-- 1. 인덱스 조회하기
select * from all_indexes
  where table_name = 'DEPT2'

select * from user_indexes;
	where table_name = 'EMP'
	
select * from user_ind_columns
	where table_name = 'EMP'

-- 2. unique index 생성
create unique index idx_dept2_dname on dept2(dname)
select * from dept2;

insert into dept2 values(9100, '테스트부서01', 1006, '서울지점')
insert into dept2 values(9101, '테스트부서01', 1006, '서울지점')
select * from dept2;

-- 3. non-unique index 생성
create index idx_dept2_area on dept2(area)
insert into dept2 values(9101, '테스트부서02', 1006, '서울지점')

-- 4. 결합(복합)인덱스
select ename
     , sal
		 , job
  from emp
 where ename = 'SMITH'	
   and job   = 'CLERK';
	

select ename
     , sal
		 , job
  from emp
 where job   = 'CLERK'
   and ename = 'SMITH';
	 
select count(*) from emp where job   = 'CLERK'

create index idx_emp_ename_job on emp(ename, job);
	
-- 5. Index Rebuilding 하기
-- 5-1. 인덱스 생성
create table idx_test ( no number);

begin 
   for i in 1..10000 loop
	    insert into idx_test values(i);
	 end loop
	 commit;
end;

select count(*) from idx_test;

select * from idx_test ORDER BY no;

-- 인덱스생성
create index idx_idx_test_no on idx_test(no);
select * from idx_test ORDER BY no;

-- 인덱스상태조회
analyze index idx_idx_test_no validate structure; -- 인덱스상태분석

select (del_lf_rows_len / lf_rows_len) * 100 balance 
	from index_stats
	where name = 'IDX_IDX_TEST_NO';
	
-- balance값이 0에 가까울수록 인덱스가 좋은 상태임을 의미

-- 1~4000건의 데이터를 삭제한 후에 인덱스상태를 조회
delete from idx_test where no between 1 and 4000;

analyze index idx_idx_test_no validate structure;

select (del_lf_rows_len / lf_rows_len) * 100 balance 
	from index_stats
	where name = 'IDX_IDX_TEST_NO';
	
-- 실습)
-- step 1. new_emp4를 생성, no(number), name(varchar2(10)), sal(number)
-- step 2. 데이터를 insert
-- 1000, 'SMITH', 300
-- 1001, 'ALLEN', 250
-- 1002, 'KING', 430
-- 1003, 'BLAKE', 220
-- 1004, 'JAMES', 620
-- 1005, 'MILLER', 810
-- step 3. name컬럼에 인덱스 생성

create table new_emp4 (
		no   number
		,name varchar2(10)
		,sal  number
)

select * from new_emp4

insert into new_emp4 values(1000, 'SMITH', 300);
insert into new_emp4 values(1001, 'ALLEN', 250);
insert into new_emp4 values(1002, 'KING', 430);
insert into new_emp4 values(1003, 'BLAKE', 220);
insert into new_emp4 values(1004, 'JAMES', 620);
insert into new_emp4 values(1005, 'MILLER', 810);

create index idx_new_emp4_name on new_emp4(name);
select * from new_emp4 ORDER BY name;

analyze index idx_new_emp4_name validate structure;

select (del_lf_rows_len / lf_rows_len) * 100 balance 
	from index_stats
	where name = 'IDX_NEW_EMP4_NAME';
	
select count(*) from new_emp4;

select * from all_indexes
  where table_name = 'IDX_NEW_EMP4_NAME'
