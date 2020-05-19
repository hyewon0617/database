/*

	1. View
	
		1) View 하나의 가상 Table이다.
		2) View는 실제로 데이터가 저장되지 않고 뷰를 통해서만 데이터를 조회할 수 있다.
		3) View는 복잡한 Query를 통해 조회할 수 있는 결과를 사전에 정의한 View를 통해
			 간단히 조회할 수 있게 한다.
	  4) 한개의 View로 여러개의 Table의 데이터를 검색할 수 있게 한다.
		5) 특정 기준에 따라 사용자별로 다른 데이터를 얻을 수 있게 한다.
	
	2. View의 제한조건
	
		1) 테이블에 not null로 만든 컬럼들이 View에 포함되어 있어야 한다.
		2) rowid, rownum, nextval, currval등과 같은 가상컬럼에 대해 참조하고 있는
			 view일 경우에는 어떤 데이터도 insert할 수 없다.
	  3) with read only옵션을 설정한 View도 어떠한 데이터를 갱신할 수 없다.
		4) with check option을 설정한 뷰는 뷰의 조건에 해당하는 데이터만 삽입, 삭제, 수정할 수 있다.
		
	3. View 문법
	
		create [or replace] [force|noforce] view 뷰이름
		as subquery
		
		- or replace : 같은 이름의 view가 있다면 삭제후 다시 생성
		- force : 테이블의 존재유무와 상관없이 view를 생성
		- noforce : 테이블이 존재할 경우에만 view를 생성(기본값)
		- with read only : select만 가능한 읽기 전용 view
		- with check option : 주어진 제약조건에 맞는 데이터만 입력 및 수정 가능
		
	4. View정보조회방법
	
		select * from user_views;
	
	5. create view 권한주기 (sysdba로 접근)
	
	grant create view to scott;
*/

-- 1. 단순뷰 생성하기
select * from emp

create or replace view v_emp
as
select empno, ename, job from emp

select empno, ename, job from emp
select * from v_emp

-- 2. 복합뷰 생성하기
-- 실습) emp, dpet를 조인해서 emp.ename, dpt.dname만 조회할 수 있는 v_emp를 생성하시오
select * from emp;
select * from dept;

create or replace view v_emp
as
select emp.ename 사원명, dpt.dname 부서명
from emp emp, department dpt
where emp.deptno = dpt.deptno

select * from v_emp

select * from v_emp
	where 사원명 = 'SMITH'
	
-- 3. view 객체 삭제
drop view 뷰이름

-- 4. MView(Materialized View) - 구체화된 View
--  1) 뷰는 inline view와 create view로 생성되는 view가 있는데 
--     실제 데이터는 원본 테이블에 존재하고 생성된 view는 질의문만 저장해둔 객체를 의미한다.
--  2) MView라는 구체화된 View는 View의 질의결과로 만들어진 자료를 실제로 데이터
--     를 저장하고 있어 테이블처럼 사용할 수 있다.
--     원본데이터에 insert, delete, update 등이 발생되면 새로운 데이터를 MView에 반영되도록 한다
--  3) MView는 집계데이터를 추출할 때 질의속도를 빠르게 해주기 때문에
--     그룹함수 등의 질의 결과를 저장하는데 사용할 수 있다.

--   create meterialized view 뷰이름
--   build [immediate|defferred] [refresh] [fast] [complete] [force] [never]
--   enable query rewrite
--   a. build immediate : MView생성과 동시에 데이터를 생성
--   b. build defferred : MView생성후에 데이터는 나중에 생성(조회결과는 없음)
--   c. build immediate refresh : MView가 생성되자마자 바로 실핼가능한 상태로 된다.--      refresh절에는 옵션이 있다.
--   ... on commit : 원본테이블에 commit가 발생될때 refresh가 발생


-- 연습문제 1 professor 테이블과 department테이블을 조인하여 교수번호, 이름, 소속 학과이름 조회하는
-- view 생성, view이름은 v_prof_dept2
select * from professor;
select * from department;

create or replace view v_prof_dept2
as
select pro.deptno 교수번호, pro.name 교수이름, dpt.dname 학과이름
from professor pro, department dpt
where pro.deptno = dpt.deptno

select * from v_prof_dept2

-- 연습문제 2 inline view를 사용하여 student와 department 테이블을 사용해
-- 학과별로 학생들의 최대 키와 몸무게, 학과이름 출력
select * from student
select * from department;

select d.dname, s.max(height), s.max(weight)
from( select d.deptno, max(height) MAX_HEIGHT, max(weight) MAX_WEIGHT
			from student
			GROUP BY deptno1) t01, department d
			where s.deptno1 = d.deptno
			
create or replace view v_std_max_info
as
select dpt.dname
     , std.max_height
		 , std.max_weight
  from (select deptno1
						 , max(height) max_height
						 , max(weight) max_weight
				  from student
				 group by deptno1) std
		  , department 
where std.deptno1 = dpt.deptno

select * from v_std_max_info

-- ex03) inline view를 사용, 학과명, 학과별최대키, 학과별로 가장 키가 큰 학생들으;
-- 이름과 키를 출력
create or replace view v_bydept_info
as
select dpt.dname      학과명
     , t01.max_height 최대키
		 , std.name				학생명
		 , std.height     학생키
  from (select deptno1
						 , max(height) max_height
				  from student
				 group by deptno1) t01
		 , student std
		 , department dpt
 where std.deptno1 = t01.deptno1
   and std.height  = t01.max_height
	 and std.deptno1 = dpt.deptno 

select * from v_bydept_info

-- ex04) student에서 학생키가 동일학년의 평균키보다 큰 학생들의 학년과 이름과 키
-- 해당 학년의 평균키를 출력 단, inline view로
create or replace view v_std_avg
as
select std.grade  학년
     , std.name   학생명
	   , std.height 신장
		 , t01.평균키
  from (select grade              학년
	           , round(avg(height)) 평균키
				  from student
				 group by grade) T01
		 , student std
 where std.grade = t01.학년
   and std.height > t01.평균키
 order by 1
	
select * from v_std_avg	

-- ex05) professor에서 교수들의 급여순위와 이름, 급여출력 단, 급여순위 1~5위까지
create or replace view v_pro_sal
as
select rownum  급여순위
     , pro.name 교수명
		 , pro.pay  급여
	from (select name
	           , pay
					from professor
				 order by 2 desc)	pro
 where rownum between 1 and 5

select * from v_pro_sal

-- ex06) 교수번호정렬후 3건씩해서 급여합계와 급여평균을 출력
select pro.num
     , pro.profno
		 , pro.name
		 , pro.pay
		 , sum(pro.pay)
		 , round(avg(pay))
		 , ceil(num/3)
  from (select profno
	           , name
						 , pay
						 , rownum num
				  from professor) pro
 group by pro.num
     , pro.profno
		 , pro.name
		 , pro.pay
 order by ceil(num/3)

create or replace view v_pro_oay_by3
as
select pro.num
     , pro.profno
		 , pro.name
		 , pro.pay
		 , sum(pro.pay)    급여합계
		 , round(avg(pay)) 평균급여
  from (select profno
	           , name
						 , pay
						 , rownum num
				  from professor) pro
 group by ceil(num/3), rollup ((pro.num, pro.profno, pro.name, pro.pay))
 order by ceil(num/3)
 
select * from v_pro_oay_by3
 
 
/* 실습문제 */
1. CHARACTERS 테이블의 CHARACTER_ID, CHARACTER_NAME, EMAIL 컬럼의 데이터를 
   HR 사용자가 볼 수 있도록 JEDAI_V란 이름으로 뷰를 생성해 보자. 
2. JEDAI_V 뷰를 사용하여 ‘루크 스카이워커’의 이메일 정보를 ‘luke2@jedai.com’로  
   변경하는 UPDATE 문을 작성 및 실행 (HR, SCOTT 사용자에서 각각 실행해보기)
3. 2 번 문제의 결과는 어떻게 되는가?




































