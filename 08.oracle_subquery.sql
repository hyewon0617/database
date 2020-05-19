-- 사용자권한
grant select on employees to scott     
revoke select on employees from scott  

-- dba권한
grant select any table to scott	
revoke select any table from scott	
/*
		Sub Query 
	
		1. Main Query에 반대되는 개념으로 이름을 부여한 것임.
		2. 메인쿼리를 구성하는 소단위 쿼리
		3. 서브쿼리안에는 select, insert, delete, update절에 모두 사용 가능
		4. 서브쿼리의 결과 집합을 메인쿼리가 중간값으로 사용
		5. 서브쿼리 자체는 일반쿼리와 다를 바가 없다.
		
		서브쿼리의 종류
		1. 연관성에 따른 분류
		   1) 연관성이 없는 서브쿼리
			 2) 연관성이 있는 서브쿼리
	
    2. 서브쿼리위치에 따라 분류
	     1) 인라인뷰 : from절에 위치
	     2) 중첩쿼리 : where절에 위치		 
*/

select *
  from professor
 where position = (select position 
                     from professor 
										where name = 'Sharon Stone')
										
										
select * from EMPLOYEES;										
select first_name
     , department_id 
		 , (select department_name 
		      from departments t2 
				 where t2.department_id = t1.department_id)	
  from EMPLOYEES t1								

-- 실습) 사원테이블에서 평균급여보다 작은 사원만 출력
select department_id, round(avg(salary)), max(salary)
  from employees
 group by department_id


-- 단일로우, 단일컬럼일 경우
select employee_id
     , first_name
		 , last_name
		 , salary
  from EMPLOYEES
 where salary < (select round(avg(salary))
										from employees)
										
-- 다중컬럼
select * 
  from departments
 where location_id in (1000, 1100)

select * 
  from departments

select * 
  from locations
 where state_province is null
	
select t1.department_name
		 , t2.state_province
  from departments t1, locations t2
 where t1.location_id = t2.location_id
				
-- state_province is null인 부서를 출력(서브쿼리로 작성)
select * 
  from departments
 where location_id in (select location_id from locations 
                        where state_province is null)
	
-- state_province is null인 부서를 출력
select *
	from departments
where location_id in (select location_id from locations
											where state_province is null)elect * from EMPLOYEES;

select frist_name, department_id,			 (select * from departments t2 where t2.department_id = t1.department_id)

	from EMPLOYEES t1
	
select employee_id, first_name, last_name, salary
	from EMPLOYEES
	
-- 실습) 사원테이블에서 평균급여보다 작은 사원만 출력
-- 단일로우, 단일컬럼일 경우
select employee_id, first_name, last_name, salary
	from EMPLOYEES
	where salary < (select round(avg(salary)) from EMPLOYEES)
	
	
-- 다중컬럼
select *
	from DEPARTMENTS
where location_id in (1000, 1100)
	
select *
	from DEPARTMENTS

select *
  form locations
	where state_province is null
	
select t1.department_name
		 , t2.state_province
	from departments t1, locations t2
	where t1.location_id = t2.location_id
	
-- state_province is null인 부서를 출력
select *
	from departments
where location_id in (select location_id from locations
											where state_province is null)
											
-- 실습1) 월급이 가장 많은 사원 (first_name, last_name, job_title)
select job_id, job_title, max_salary
	from JOBS
	where max_salary = (select round(max(max_salary)) from JOBS)
	
select * from employees;
select * from jobs;

select t1.first_name
     , t1.last_name
		 , t1.salary
		 , t2.job_title
  from employees t1, jobs t2
 where t1.salary = (select max(salary) from employees)
   and t1.job_id = t2.job_id	

-- 실습2) 월급이 가장 적은 사원
select job_id, job_title, min_salary
	from JOBS
	where min_salary = (select round(min(min_salary)) from JOBS)
	
select t1.first_name
     , t1.last_name
		 , t1.salary
		 , t2.job_title
  from employees t1, jobs t2
 where t1.salary = (select min(salary) from employees)
   and t1.job_id = t2.job_id

-- 실습3) 월급이 평균급여보다 많은 사원
-- (first_name, last_name, job_title)
-- locations 의 countriy_id = 'US'
-- hint) 서브쿼리안에는 employees, departments, locations
select * from employees;
select * from departments;
select * from locations where country_id = 'US';

select round(avg(t3.salary))
  from departments t1
	   , locations   t2
		 , employees   t3
 where t2.country_id = 'US'
   and t2.location_id = t1.location_id
	 and t1.department_id = t3.department_id
				
select t1.first_name
     , t1.last_name
		 , t1.salary
		 , t2.job_title
  from employees t1, jobs t2
 where t1.salary > (select round(avg(t3.salary))
											from departments t1
												 , locations   t2
												 , employees   t3
										 where t2.country_id = 'US'
											 and t2.location_id = t1.location_id
											 and t1.department_id = t3.department_id)
   and t1.job_id = t2.job_id			
	
-- 다중로우, 단일컬럼 반환
create table month_salary(
		magam_date     date not null /* 마감일 */
	, department_id  number				 /* 부서번호 */
	, emp_count      number        /* 사원수 */
	, total_salary   number(9,2)   /* 급여총액 */
	, average_salary number(9,2)   /* 급여평균 */
	);
	
	select * from month_Salary
	
	insert into month_salary(magam_date, department_id)
	select last_day(sysdate)
			 , department_id
	  from EMPLOYEES
		GROUP BY department_id
	
-- 실습) 부서별 총사원수, 급여총액, 평균급여를 update
update month_salary t1
	 set t1.emp_count      = (select count(*) 
	                            from employees t2
														 where t1.department_id = t2.department_id	
														 group by department_id)
		 , t1.total_salary   = (select sum(t2.salary) 
	                            from employees t2
														 where t1.department_id = t2.department_id	
														 group by department_id)
		 , t1.average_salary = (select round(avg(t2.salary))
	                            from employees t2
														 where t1.department_id = t2.department_id	
														 group by department_id)

delete from month_salary
select * from month_salary

update month_salary t1
   set (t1.emp_count, t1.total_salary, t1.average_salary)  
         = (select count(*), sum(salary) , round(avg(salary))
							from employees t2
						 where t1.department_id = t2.department_id	
						 group by department_id)
				

select * from month_salary	
		
		
-- 단일로우, 단일컬럼
-- 비교연산자 : in, exists,-- >any : 결과중에 최소값을 리턴
-- <any : 결과중에 최대값을 리턴
-- <all : 결과중에 최소값을 리턴
-- >all : 결과중에 최소값을 리턴
	 
	 -- 실습01) in 비교연사자를 사용한 sub query작성
select dep.department_name
  from departments dep
	   , locations   loc
 where dep.location_id = loc.location_id
   and loc.country_id = 'US';
	 
-- 답)
select dep.department_name
  from departments dep
	   , locations   loc
 where dep.location_id in (select location_id 
														 from locations
													  where country_id = 'US')

-- 실습02) >any연산자(힌트:min()함수) 사용 서브쿼리로 작성
select salary
  from employees
 where department_id = 30;
 
 
select min(salary)
  from employees
 where department_id = 30; 
-- 답)
select first_name||'.'||last_name, salary
  from employees
 where salary > (select min(salary)
									 from employees
									where department_id = 30);

select first_name||'.'||last_name 사원명, salary
  from employees
 where salary >any (select salary
									    from employees
									   where department_id = 30);	 
	 
	 
select first_name||'.'||last_name, salary
  from employees
 where salary > (select max(salary)
									 from employees
								  where department_id = 30);	 
	 
select first_name||'.'||last_name, salary
  from employees
 where salary > all (select salary
									    from employees
								    	where department_id = 30);	 	 

-- 인라인 뷰

-- 실습03)
-- 급여가 평균보다 같거나 큰 그리고 최대급여보다 작거나 같은 사원출력
-- 사원번호 사원명(f_name + l_name), salary / 순서는 급여많은 순으로

select employee_id
     , first_name||'.'||last_name 사원명
		 , salary
  from employees
 where salary >= (select avg(salary) from employees) 
   and salary <= (select max(salary) from employees) 
 order by salary desc

-- 인라인뷰로 작성
select t1.employee_id
     , t1.first_name||'.'||t1.last_name 사원명
		 , t1.salary
  from employees t1
		, (select round(avg(salary)) avgs
		        , max(salary) maxs
			   from employees) t2
 where t1.salary between t2.avgs and t2.maxs
 order by t1.salary desc


-- 실습04) 사원테이블에서 입사월별로 인원수를 출력
-- group by 입사월, order by 입사월
select decode(to_char(hire_date, 'mm'), '01', count(*), 0) M01
     , decode(to_char(hire_date, 'mm'), '02', count(*), 0) M02
     , decode(to_char(hire_date, 'mm'), '03', count(*), 0) M03
     , decode(to_char(hire_date, 'mm'), '04', count(*), 0) M04
     , decode(to_char(hire_date, 'mm'), '05', count(*), 0) M05
     , decode(to_char(hire_date, 'mm'), '06', count(*), 0) M06
     , decode(to_char(hire_date, 'mm'), '07', count(*), 0) M07
     , decode(to_char(hire_date, 'mm'), '08', count(*), 0) M08
     , decode(to_char(hire_date, 'mm'), '09', count(*), 0) M09
     , decode(to_char(hire_date, 'mm'), '10', count(*), 0) M10
     , decode(to_char(hire_date, 'mm'), '11', count(*), 0) M11
     , decode(to_char(hire_date, 'mm'), '12', count(*), 0) M12
  from employees
 group by to_char(hire_date, 'mm')
 order by to_char(hire_date, 'mm') 
 
 
 select sum(M01) "01월"
      , sum(M02) "02월"
      , sum(M03) "03월"
      , sum(M04) "04월"
      , sum(M05) "05월"
      , sum(M06) "06월"
      , sum(M07) "07월"
      , sum(M08) "08월"
      , sum(M09) "09월"
      , sum(M10) "10월"
      , sum(M11) "11월"
      , sum(M12) "12월"
   from ( select decode(to_char(hire_date, 'mm'), '01', count(*), 0) M01
							 , decode(to_char(hire_date, 'mm'), '02', count(*), 0) M02
							 , decode(to_char(hire_date, 'mm'), '03', count(*), 0) M03
							 , decode(to_char(hire_date, 'mm'), '04', count(*), 0) M04
							 , decode(to_char(hire_date, 'mm'), '05', count(*), 0) M05
							 , decode(to_char(hire_date, 'mm'), '06', count(*), 0) M06
							 , decode(to_char(hire_date, 'mm'), '07', count(*), 0) M07
							 , decode(to_char(hire_date, 'mm'), '08', count(*), 0) M08
							 , decode(to_char(hire_date, 'mm'), '09', count(*), 0) M09
							 , decode(to_char(hire_date, 'mm'), '10', count(*), 0) M10
							 , decode(to_char(hire_date, 'mm'), '11', count(*), 0) M11
							 , decode(to_char(hire_date, 'mm'), '12', count(*), 0) M12
						from employees
					 group by to_char(hire_date, 'mm') 
       )	
			
		
/* 
		가상테이블
		
	  1회성 테이블처럼 임시로 사용하고자 할 경우에는 "with" 절을 정의하여
		가상테이블 처럼 사용할 수가 있다.
		
		사용방법
		with 별명 as (
				sub query
		)
		select 컬럼명 from 별명

*/
with aa as 
(
	select t1.employee_id
			 , t1.first_name||'.'||t1.last_name 사원명
			 , t1.salary
		from employees t1
)
select 사원명 from aa where employee_id = 100;

with aa as
(
	select rownum, 'test1' as name, sysdate from dual
	union all
	select rownum, 'test2' as name, sysdate from dual
	union all	
	select rownum, 'test3' as name, sysdate from dual
	union all	
	select rownum, 'test4' as name, sysdate from dual
), 
bb as
(
	select rownum, 'test1' as name, sysdate from dual
	union all
	select rownum, 'test2' as name, sysdate from dual
	union all	
	select rownum, 'test3' as name, sysdate from dual
	union all	
	select rownum, 'test4' as name, sysdate from dual
)
select * from aa, bb where aa.name = bb.name






/* 연습문제 */
-- ex01) student, department에서 'Anthony Hopkins'학생과 1전공이 
--       동일한 학생들의 이름과 1전공이름을 출력
select deptno1 from student where name = 'Anthony Hopkins';
select * from department;
select t1.name 학생명, t2.dname 학과명
	from student t1, department t2
	where t1.deptno1 = t2.deptno
   and t1.deptno1 = (select deptno1 
											 from student 
											where name = 'Anthony Hopkins')
											
-- ex02) professor, department를 조회해서 'Meg Ryan'교수보다 나중에
--       입사한 사람들의 이름과 입사일과 학과명을 출력
select * from department;
select hiredate from professor where name = 'Meg Ryan';
select t1.name     교수명
     , t1.hiredate 입사일
		 , t2.dname    학과명
  from professor   t1
	   , department  t2
 where t1.deptno = t2.deptno
   and hiredate > (select hiredate 
										 from professor 
										where name = 'Meg Ryan')
										
-- ex03) student에서 1전공(deptno1)이 201번인 학과의 평균몸무게보다
--       몸무가게 많은 학생들의 이름과 몸무게를 출력
select std.name    학생명
     , std.weight  체중
  from student std
 where weight > (select avg(weight)
                   from student
									where deptno1 = 201)
									
-- ex04) emp2에서 전체직원중 'Section head'직급의 최소연봉자보다
--       연봉이 높은 사람의 이름과 직급, 연봉을 출력 
--       단, 급역는 $9,999,999형식으로 출력
-- >any : 결과중 최소값 반환
-- <any : 결과중 최대값 반환
-- <all : 결과중 최소값 반환
-- >all : 결과중 최대값 반환
select min(pay) from emp2 where position = 'Section head'

select emp.name     사원명
     , emp.position 직급
		 , to_char(emp.pay, '$999,999,999')  년봉
  from emp2 emp
 where pay > (select min(pay) 
                from emp2 
							 where position = 'Section head')
	
select emp.name     사원명
     , emp.position 직급
		 , to_char(emp.pay, '$999,999,999')  년봉
  from emp2 emp
 where pay >any (select pay 
                   from emp2 
							    where position = 'Section head')
									
-- ex05) student에서 전체학생중 체중이 2학년학생들의 체중에서 가장 적게
--           나가는 학생보다 몸무게게 적은 학생의 이름과 학년과 몸무게 출력
select min(weight) from student where grade = 2

select name, grade, weight from student
 where weight < (select min(weight) from student where grade = 2)

select name, grade, weight from student
 where weight <all (select weight from student where grade = 2)
 
-- ex06) emp2,dept2에서 각 부서별 평균연봉과 그중에서 평균연봉이 가장
--       적은 부서의 평균연봉보다 적게 받는 직원들의 부서명, 직원명 
--           연봉을 출력 (연봉은 $999,999,999)
select d.dname   부서명
     , e.name    사원명
		 , to_char(e.pay, '$999,999,999')  년봉
  from emp2 e, dept2 d
 where e.deptno = d.dcode
   and e.pay <all (select avg(pay) from emp2 group by deptno)
	 
-- ex07) 물류 부서에 속한 사원들 중, 물류 부서의 평균 급여보다 낮은 월급을 받는 -- 사원 명단을 조회하는 쿼리를 작성(인라인뷰로 작성, 물류부서는 50)
select round(avg(salary)) from employees where department_id = 50

select t1.employee_id    							    사원번호
     , t1.first_name||'.'||t1.last_name  	사원명
		 , t1.salary													급여
  from employees t1
	   , (select round(avg(salary)) avg_sal
		      from employees 
				 where department_id = 50) t2
 where t1.department_id = 50
   and t1.salary < t2.avg_sal
	 
-- ex08) 다음 문장은 부서 테이블을 조회해서 부서가 위치한 도시명조회 쿼리
--       이 쿼리를 조인을 사용하지 말고, 서브쿼리를 사용해서 바꿔보자. 
SELECT dep.department_name, 
       loc.city
  FROM departments dep,
       locations loc
 WHERE dep.location_id = loc.location_id
 
 SELECT dep.department_name, 
       loc.city
  FROM departments dep
	   , (select location_id, city from locations) loc
 WHERE dep.location_id = loc.location_id	

SELECT dep.department_name 
       -- loc.city
		 , (select city from locations loc 
		     where loc.location_id = dep.location_id) 도시
  FROM departments dep
	
-- ex09) 부서별 월급 총액이 가장 많은 순서대로 3위까지 해당되는 부서와 
-- 월급 총액을 구하는 쿼리를 작성
	 
select rownum from departments
 where rownum <= 3

select t2.department_name 부서명
     , t1.department_id   부서코드
		 , t1.부서급여총액
  from ( select department_id
							 , sum(salary)   부서급여총액
						from employees
					 group by department_id
					 order by sum(salary) desc
			 ) t1,
			 departments t2
 where rownum <= 3
   and t1.department_id = t2.department_id
