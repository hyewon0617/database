/* 그룹함수 */-- 1. count()    : 조회되는 데이터들의 총 건수
-- 2. sum()      : 조회되는 데이터들의 총 합계
-- 3. avg()      : 조회되는 데이터들의 평균
-- 4. max()      : 조회되는 데이터들의 최대값
-- 5. min()      : 조회되는 데이터들의 최소값
-- 6. stddev()   : 조회되는 데이터들의 표준편차값
-- 7. variance() : 조회되는 데이터들의 분산값
-- 8. rollup()   : 
-- 9. cube()     :
-- 10. groupingset() :
-- 11. listagg() :
-- 12. pivot()   :
-- 13. lag()     :
-- 14. lead()    :
-- 15. rank()    :
-- 16. dense_rank() :
-- 17. sum() over() :
-- 18. ration_to_report() :

-- A. 그룹함수
-- 1. count() : null 은 합산 xselect * from emp
select count(*) from emp
select count(sal), count(comm) from emp
select count(sal), count(comm), count(nvl(comm,0)) from emp

-- order by  : 정렬
select *
  from emp
--  order by sal 	
--  order by sal asc
--  order by sal desc
--  order by hiredate desc, sal desc
 order by 5 desc, 6 desc 
 
select ename, sal, hiredate 
  from emp
 order by 3 desc, 2 
	
-- 2. sum()
select count(comm), sum(comm)
	from emp
	
-- 3. avg()
select count(comm), sum(comm), avg(comm)
	from emp
	
select count(comm), sum(comm), avg(nvl(comm,0))
	from emp
	
select count(sal), sum(sal), avg(sal)
	from emp

-- 4. min() / max()
select max(hiredate)
			,min(hiredate)
	from emp

select max(sal), min(sal)
	from emp
	
-- 5. stbdev() / variance()
select round(stddev(sal))
		 , round(variance(sal))
  from emp

-- B. 그룹화하기(group by)
select sum(sal) from emp

-- 부서별 급여합계 구하기
select deptno
     , sum(sal)
  from emp
 group by deptno

select deptno
		 , job
     , sum(sal)
  from emp
 group by deptno, job

select deptno
		 , job
     , sum(sal)
  from emp
 group by job, deptno

select deptno
     , sum(sal)
  from emp
 group by deptno
 order by 1
 
 select deptno
		 , job
     , sum(sal)
		 , count(deptno)
		 , count(job)		 
  from emp
 group by deptno, job
 order by deptno, job
 
select deptno   부서번호
		 , job      직급
     , sum(sal) 급여
  from emp
 group by deptno, job -- group by절에는 반드시 컬럼명이 사용되어야 한다. 즉, 별칭사용불가
 order by 부서번호, 직급 -- order by절에는 별칭도 사용가능

-- 부서별 사원수 조회
select deptno   부서번호
     , count(*) 사원수
  from emp
 group by deptno
--  order by count(*)  또는
 order by 사원수  
 
-- 실습) 부서별로 사원수, 급여평슌, 급여의 합계를 구해보세요
select deptno
			 , count(*) 사원수
			 , round(avg(sal),2) 급여평균
			 , round(avg(sal))
			 , sum(sal) 급여합계
			 from emp
			 group by deptno
			 
 -- 업무별로 인원수, 평균급여, 최고급여, 최저급여 및 합계
 select job 직급
			, count(*) 인원수
			, round(avg(sal)) 평균급여
			, max(sal) 최고급여
			, min(sal) 최소급여
			, sum(sal) 급여합계
			from emp
		 group by job
		 order by 직급
		 
 -- group by 절은 집계함수 없이도 사용할 수 있다.
 select deptno from emp group by deptno
 union all
 select distinct deptno from emp
 
 -- distinct와 group by절
 -- distinct 주로 중복제거한 컬럼이나 레코드를 조회하는 경우에 사용
 -- group by는 데이터를 그룹핑해서 그 결과를 가져오는 경우에 사용
 -- 두 작업은 동일한 형태의 작업이다. 어떤 것을 사용할지 고민해야한다.	 
		 
select deptno 부서번호, count(*) 사원수, sum(sal), avg(nvl(comm,0))
	from emp
	group by deptno
	ORDER BY 사원수

	
-- 2. 조건별 결과 구하기
-- 그룹화에서 조건을 주기 위해서는 having 절을 사용한다.
-- where절에서는 집계함수를 사용할 수 없다.
-- having절은 집계함수를 가지고 조건을 비교할 때 사용한다.
-- having은 group by와 같이 사용된다.

-- 사원수가 다섯명이상인 부서와 사원수를 조회
select deptno 부서번호
		 , count(empno) 사원수
	from emp
	group by deptno
	having count(empno) > 5
	
-- 실습) 전체 월급이 5000을 초과하는 job과 월급여합계를 조회 단, "SALES"는 제외, 내림차순정렬
select job 직급, sum(sal) 급여합계
	from emp
	where job != 'SALES'
	group by job
	having sum(sal) > 5000
	order by sum(sal) desc
	
-- C. rollup() / cube()
-- 1. rollup함수
-- rollup구문은 group by 절과 같이 사용되며 group by 절에 의해서 그룹지어진 집합결과에 대해서
-- 좀 더 상세한 정보를 반환한다. 즉 소계, 총합계를 그룹별로 구할 수 있다.
-- select 절에 rollup을 사용함으로 보통의 select된 데이터와 그 데이터의 소계, 합계를 구할 수 있다.

-- 직급별로 급여합계와 총합계를 구하기
select job
		 , sum(sal)
		 from emp
		 group by job
union all		 
select 'Total', sum(sal) from emp

-- 상기예제를 rollup을 이용하여 한번에 구하기
select job, sum(sal)
	from emp
	group by rollup(job)
	
-- 좀 더 복잡한 예제
-- 1. 부서별, 직업별로 평균급여와 사원수 구하기
-- 2. 부서별 평균급여와 사원수
-- 3. 전체 평균급여와 사원수
-- union all 사용시 order by 못쓰고 컬럼수 맞춰줘야함

-- 첫번째 방법
select deptno, job, round(avg(sal)) 평균급여, count(*) 사원수
  from emp group by deptno, job order by 1, 2;

select deptno, round(avg(sal)) 평균급여, count(*) 사원수
  from emp group by deptno order by 1;
	
select round(avg(sal)) 평균급여, count(*) 사원수
  from emp ;	


select deptno, job, round(avg(sal)) 평균급여, count(*) 사원수
  from emp group by deptno, job
union all
select deptno, '부서합계', round(avg(sal)) 평균급여, count(*) 사원수
  from emp group by deptno
union all 	
select null, null, round(avg(sal)) 평균급여, count(*) 사원수
  from emp ;

-- 두번째 방법 : 여러개의 쿼리를 한개의 테이블처럼 사용하기
select *
  from (
				select deptno, job, round(avg(sal)) 평균급여, count(*) 사원수
					from emp group by deptno, job
				union all
				select deptno, '부서합계', round(avg(sal)) 평균급여, count(*) 사원수
					from emp group by deptno
				union all 	
				select null, null, round(avg(sal)) 평균급여, count(*) 사원수
					from emp
       ) t1
 order by deptno, job

-- 세번째 방법 : rollup
select deptno, job, round(avg(sal)) 평균급여, count(*) 사원수
	from emp group by rollup(deptno, job);
	
select deptno, job, round(avg(sal)) 평균급여, count(*) 사원수
	from emp group by job rollup(deptno)
	
-- 실습 ) professor 테이블 deptno/position별 교수인원수, 급여합계를 rollup을 적용
select deptno, position, sum(pay), count(*)
from professor
GROUP BY rollup(deptno, position);

select deptno, position, sum(pay), count(*)
from professor
GROUP BY rollup(position, deptno);

select deptno, position, count(*) 인원수, sum(pay) 급여합계
  from professor group by position, rollup(deptno);

-- 2. cube함수
-- 1) 부서별, 직급별, 평균급여와 사원수 구하기
-- 2) 부서별 평균급여와 사원수
-- 3) 직급별 평균급여와 사원수
-- 4) 전체 평균급여와 사원수

select deptno, job, sum(sal), count(*)
	from emp group by rollup(deptno, job)
union all
select null, job, sum(sal), count(*)
	from emp group by rollup(job)
	
-- cube()함수 적용쿼리
select deptno, job, sum(sal), count(*)
	from emp group by cube(deptno, job);
-- D. 순위함수
-- rank()함수는 순위를 부여하는 함수로 동일순위처리가 가능(중복순위, 1,2,2,4)
-- dense_rank()함수는 rank함수와 같은 역할을 하지만 동일등수의 순위에 영향이 없다.(1,2,2,3)
-- row_number()함수는 특정순위로 일련번호를 제공하는 함수로 동일순위처리가 불가(중복순위없이 1,2,3,4)
-- 순위함수 사용시에는 order by절 필수로 입력해야 함


-- 1. rank() : 순위를 출력하는 함수
-- rank(조건값) within group (orderby 조건값 컬럼명 [asc/desc])
select rank('SMITH') within group(order by ename)
from emp;

-- 전체순위 over예약어
-- rank() over(order by 표현식[asc/desc])
-- 급여가 높은 순서로 순위 구하기
select empno, ename, sal from emp order by sal


select empno, ename, sal
			,rank() over(order by sal)
			,rank() over(order by sal desc)
from emp

-- 실습 ) emp에서 10번부서 사원들의 사번, 이름 급여 해당부서내의 급여순위
select deptno, ename, sal, rank() over(order by sal)
	from emp
-- where deptno = 10
order by deptno

-- rank() over(partition by 표현식1...n order by 표현1...n)
select empno, ename, sal, rank() over(partition by deptno order by sal)
 from emp
-- 부서별/직급별 순위
select empno, ename, sal, rank() over(partition by deptno, order by sal)
 from emp
 
-- 2. danse_rank()
select  empno, ename, sal, deptno
			, rank() over(order by sal)
			, dense_rank() over(order by sal)
 from emp
 
-- 3. row_number()
select  empno, ename, sal, deptno
			, rank() over(order by sal)
			, row_number() over(order by sal)
 from emp
 
-- E. 기타함수
-- 1) sum() over : 누계를 구하는 함수
-- 2) ratio_to_report : 비율을 구하는 함수


-- 1. panmae 1000번대리점 판매내역출력
-- sum() over (order by 표현식|열)
select * from panmae where p_store = 1000

select p_date, p_code, p_qty, p_total
		,	sum(p_total) over(order by p_total) 누계
		from panmae
		where p_store = 1000
		
-- 실습) 1000대리점 p_code로 분류후 판매일, 제품코드, 판매금액, 누적판매액을 출력
-- sum() over(partition by ... order by ...)
select p_date, p_code, p_total,
			 sum(p_total) over(partition by p_code order by p_total) 누적판매액
			 from panmae
			 where p_store = 1000
			 
-- 실습) 상기예제를 기준으로 전체판매내역을 판매점 제품코드와 판매일자별로 누계
select P_qty, p_date, sum(p_total) over(partition by p_code order by p_total) 판매일자별
			,p_code, sum(p_total) over(partition by p_date order by p_total) 제품코드별
			 from panmae
			 where p_store = 1000

-- 2. 판매비율 구하기
select p_code,
			 sum(p_qty) over() tot_qty,
			 sum(p_total) over() tot_amt,
			 p_store,
			 p_total,
			 round((ratio_to_report(sum(p_qty)) over()) * 100, 2), "수량(%)"
			 round((ratio_to_report(sum(p_total)) over()) * 100, 2) "금액(%)"
			 from panmae
			 GROUP BY p_code, p_store, p_qty, p_total
			 
 select round((4500 / 67400) * 100, 2) from dual




















