/* DML */

/*
	A. insert
		1) 테이블에 새로운 로우(레코드)를 추가할 때 사용하는 SQL문
		2) 테이블에 새로운 데이터를 입력하기 위해 사용하는 데이터조작어(DML)
		3) 테이블의 모든 컬럼에 자료를 입력하는 경우에는 컬럼목록을 기술하지 않아도 된다.
			 컬럼목록이 생략되면 values절 다음의 값들이 테이블의 비온 컬럼순서대로 입력된다.
	  
		insert into 테이블명(col1, ... coln) values(val1, ... valn);
		insert명령은 컬럼갯수와 값갯수가 동수이어야 한다
		
*/

-- 1. 레코드추가
-- 부서번호=9000, 부서명=temp_1, 상위부서=1006, 지역=temp area 추가
select * from dept2

insert into dept2(dcode, dname, pdept, area)
						values(9000, 'temp_1', 1006, 'temp area')
						
-- 모든 컬럼에 값을 입력할 경우에는 컬럼 이름을 생략할 수 있다.
insert into dept2
						values(9999, 'temp_9', 1006, 'temp area 9')
						
-- 실습 professor 테이블, 교수번호=5001, 교수이름=홍길동, id=honggildong,
-- position=정교수, pay=510, 입사일은 2014-11-20

	insert into professor(profno, name, id, position, pay, hiredate)
					values(5111, '홍길동', 'honggildong', '정교수', 510, sysdate)
					select * from professor
					
	alter table professor
				modify()
	
-- 테이블구조만 복사 & 조건별로 일괄추가(서브쿼리사용)
-- professor4 구조만 복사
create table professor4 as select * from professor where 1=2;

insert into professor4
select * from professor4 where profno > 4000
select * from professor4

-- 3. insert all : 여러 테이블에 특정조건의 데이터를 일괄로 추가하기
create table prof_3 (
		  profno number
		, name   varchar2(25)
);
create table prof_4 (
		  profno number
		, name   varchar2(25)
);
select * from prof_4

insert all
	when profno between 1000 and 1999 then into prof_3 values(profno, name)
	when profno between 2000 and 2999 then into prof_4 values(profno, name)
select profno, name
  from professor
	
select * from prof_3;
select * from prof_4;

truncate table prof_3;
truncate table prof_4;

-- 실습 professor에서 3000~3999의 교수를 동시에 prof_3, prof_4테이블에 추가하기

insert all
	into prof_3 values(profno, name)
	into prof_4 values(profno, name)
select profno, name
	from professor

where profno between 3000 and 3999

/*
  B. update
		1) 테이블에 저장된 데이터를 수정하기 위해서 사용되는 명령문이다.
		2) 기존의 행을 수정하기위해 사용된다.
		3) 주의할점, where절을 사용하지 않을 경우에는 테이블의 모든 행이 수정된다.
		
		update 사용법
		
		update table
			set col1 = value1
			  , coln = valuen
		where 조건
*/

create table emp999
as
select * from emp where 1=2;

insert into emp999
select * from emp;
select * from emp999 

update emp999
	set deptno = 10;

truncate table emp999;
insert into emp999
select * from emp;
select * from emp999; 

-- 실습) emp999에서 모든 사원의 급여를 10% 인상
update emp999
	set sal = sal * 1.1
	
select t1.ename, t1.sal, t2.sal
	from emp t1, emp999 t2
	where t1.empno = t2.empno
-- 실습) emp999에서 모든 사원의 입사일을 현재일로 수정하기
update emp999
	 set hiredate = sysdate
	 
select * from emp999;

-- professor에서 직급이 assistant professor인 사람
select * from professor
	where position = 'assistant professor'
	
-- 	assistant professor bonus = 200 으로 인상
update professor
	set bonus = 200
	where position = 'assistant professor'
	
-- professor에서 'Sharon Stone' 직급과 동일한 직급을 가진 교수를 조회
select instructor
from professor
where position = (select position from professor where name = 'Sharon Stone')
	
-- 실습) professor에서 'Sharon Stone' 직급과 동일한 직급을 가진 교수중에서
-- 급여를 15% 인상하세요
update professor
	set pay = pay * 1.15
where position = (select position from professor where name = 'Sharon Stone')
	
/*
  C. delete
		테이블에서 특정 자료를 삭제하는 명령어이다.
		
		사용법
			: delete from 테이블명
				 where 조건
	
*/
-- dept2에서 부서코드가 9000-9999사이 부서를 삭제
select * from dept2 where dcode between 9000 and 9999 
delete from dept2
where dcode between 9000 and 9999

/*
	D. marge
	  여러개의 테이블을 한개의 테이블로 병합하는 명령
			
		 사용법
			: marge into 테이블1
						using 테이블2
							 on 병합조건
						where matched then update set 업데이트내용
						delete when 조건
							when not matched then
					  insert values(컬럼이름)
						
*/
create table charge_01 (
		u_date 		VARCHAR2(6)
	, cust_no		number
	, u_time 		number
	, charge 		number
);
create table charge_02 (
		u_date 		VARCHAR2(6)
	, cust_no		number
	, u_time 		number
	, charge 		number
);
create table ch_total (
		u_date 		VARCHAR2(6)
	, cust_no		number
	, u_time 		number
	, charge 		number
);

insert into charge_01 values('141001', 1000, 2, 1000);
insert into charge_01 values('141001', 1001, 2, 1000);
insert into charge_01 values('141001', 1002, 1, 1000);

insert into charge_02 values('141002', 1000, 3, 1500);
insert into charge_02 values('141002', 1001, 4, 2000);
insert into charge_02 values('141002', 1003, 1, 500);

select * from charge_01
union all
select * from charge_02

select * from ch_total

-- 첫번째 merge 작업 : charge_01 + ch_total
merge into ch_total tot
using charge_01     c01
   on (tot.u_date = c01.u_date)
 when     matched then update set tot.cust_no = c01.cust_no
 when not matched then insert values(c01.u_date, c01.cust_no, 
	                                    c01.u_time, c01.charge);

select * from ch_total order by u_date, cust_no;

-- 두번째 merge 작업 : charge_02 + ch_total
merge into ch_total tot
using charge_02     c02
   on (tot.u_date = c02.u_date)
 when     matched then update set tot.cust_no = c02.cust_no
 when not matched then insert values(c02.u_date, c02.cust_no, 
	                                   c02.u_time, c02.charge);

select * from ch_total order by u_date, cust_no;

select * from charge_01
union all
select * from charge_02;

/* 연습문제 */
-- 실습테이블 생성 : emp에서 emp99 테이블을 복사
create table emp99
as
select * from emp where 1=2;
insert into emp99
select * from emp;
select * from emp99
select * from professor
-- ex01) job이 'MANAGER'인 사원은 급여를 15%인상하기
update emp99
	set sal = sal * 1.15
	where job = 'MANAGER'
	
-- ex02) SCOTT 사원의 부서번호=30번, JOB=MANAGER로 한꺼번에 수정하는 쿼리
update emp99
	set deptno = 30, job = 'MANAGER'
	where ename = 'SCOTT'

-- ex03) professor에서 'Sharon Stone'교수의 직급과 동일한 직급을 가진 교수들중
-- 현재급여가 250이 안되는 교수들의 급여를 15%인상하세요!
update professor	set pay = pay * 1.15
	where position = (select position from professor where name = 'Sharon Stone')
	and pay < 350
	
-- ex04) dept2 에서 부서번호=9010, 부서명=temp_10, 상위부서=1006, 지역=temp area로 입력
insert into dept2
					values(9010, 'temp_10', 1006, 'temp area')
					
select * from dept2

-- ex05) dept2 테이블에 특정컬럼에만 정보를 입력
-- 부서번호=9020, 부서명=temp_20, 상위부서:Business Department(1006번 부서)
insert into dept2(dcode, dname, pdept)
				 values(9020, 'temp_20', 1006)
-- ex06) professor 에서 profno가 3000번 이하의 교수들의 profno, name, pay를 가져와
-- 			 professor4 테이블에 한꺼번에 입력하는 쿼리 작성
create table professor4
as 
select profno, name, pay
from professor
where 1= 2;

insert into professor4
select profno, name, pay
from professor
where profno > 4000;


-- ex07) professor 테이블에서 'Sharon Stone'교수의 Bonus를 100만원으로 인상
update professor
	set bonus = 100
	where name = 'Sharon Stone'
select * from professor
	
	































