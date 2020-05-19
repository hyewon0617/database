-- F. decode 함수
-- 1. decode 함수는 프로그램언어에서 가장 많이 사용되는 switch case 문과 같은 기능을한다.
-- 2. decode 함수는 조건에 따라 데이터를 다른 값이나 컬럼값으로 추출할 수 있다.
-- 3. decode(표현식, 조건1, 결과1,
--                   조건n, 결과n,
--                   기본결과)
-- 표현식(값) 조건1일때 결과1을 반환하고...조건n일때 결과n을 반환하고 조건을 만족하지 못한 경우 마지막 즉, 기본결과를 반환한다.
-- 4. decode함수안에 decode를 중첩해서 사용할 수 있다.

-- 연습문제 decode 1
select NAME, jumin,
			 decode(substr(jumin, 7, 1), 1, 'MAN',
											'WOMAN')
	from student
	where deptno1 = 101;
	
-- 연습문제 decode 2
select name, tel,
			 decode(substr(tel, 1, 3), '02)', 'SEOUL',
																	'055', 'GYEONGNAM',
																	'051', 'BUSAN',
																	'031', 'GYEONGGI',
																	'052', 'ULSAN'
			 )
 from student
 where deptno1 = 101;
 
 -- 연습문제 max, min, avg
select max(sal + nvl(comm,0)) MAX, min(sal+nvl(comm,0)) MIN, round(avg(sal+nvl(comm,0)),1) avg
 from emp
 
-- 연습문제 birthday, 월별 생일자수
select count(*)||'EA' "TOTAL",
			 count(sum(decode(substr(birthday, 6, 2), '01', 1))) ||'EA' "JAN",
			 count(decode(substr(birthday, 6, 2), '02', 1)) ||'EA' "FEB",
			 count(decode(substr(birthday, 6, 2), '03', 1)) ||'EA' "MAR",
			 count(decode(substr(birthday, 6, 2), '04', 1)) ||'EA' "APR",
			 count(decode(substr(birthday, 6, 2), '05', 1)) ||'EA' "MAY",
			 count(decode(substr(birthday, 6, 2), '06', 1)) ||'EA' "JUN",
			 count(decode(substr(birthday, 6, 2), '07', 1)) ||'EA' "JUL",
			 count(decode(substr(birthday, 6, 2), '08', 1)) ||'EA' "AUG",
			 count(decode(substr(birthday, 6, 2), '09', 1)) ||'EA' "SEP",
			 count(decode(substr(birthday, 6, 2), '10', 1)) ||'EA' "OCT",
			 count(decode(substr(birthday, 6, 2), '11', 1)) ||'EA' "NOV",
			 count(decode(substr(birthday, 6, 2), '12', 1)) ||'EA' "DEC"

				
from student
GROUP BY birthday

-- 연습문제 지역별 인원수 출력
select count(*) "TOTAL",
			 count(sum(decode(substr(tel, 1, 3), '02)', 1))) "SEOUL",
			 count(decode(substr(tel, 1, 3), '055', 1)) "GYEONGGI",
			 count(decode(substr(tel, 1, 3), '051', 1)) "BUSAN",
			 count(decode(substr(tel, 1, 3), '052', 1)) "ULSAN",
			 count(decode(substr(tel, 1, 3), '053', 1)) "DAEGU",
			 count(decode(substr(tel, 1, 3), '055', 1)) "GYEONAM"
  from student
GROUP BY tel


-- 연습문제 직원들의 급여와 전체 급여의 누적 급여를 오름차순으로 출력
select deptno, ename, sal, sum(sal) over(order by sal) TOTAL
from emp
GROUP BY sal, deptno, ename
order by sum(sal) asc

-- 연습문제 지역별 인원수, 전체 대비 차지하는 비율
select count(*) || 'EA (' || (count(name) / count(name) * 100) || '%)' total 
     , count(decode(substr(tel, 1, instr(tel, ')')-1), '02', 0)) || 'EA (' ||
         (count(decode(substr(tel, 1, instr(tel, ')')-1), '02', 0)) / count(name) * 100) || '%)' 서울  
     , count(decode(substr(tel, 1, instr(tel, ')')-1), '031', 0)) || 'EA (' ||
         (count(decode(substr(tel, 1, instr(tel, ')')-1), '031', 0)) / count(name) * 100) || '%)' 경기  
     , count(decode(substr(tel, 1, instr(tel, ')')-1), '051', 0)) || 'EA (' ||
         (count(decode(substr(tel, 1, instr(tel, ')')-1), '051', 0)) / count(name) * 100) || '%)' 부산  
     , count(decode(substr(tel, 1, instr(tel, ')')-1), '052', 0)) || 'EA (' ||
         (count(decode(substr(tel, 1, instr(tel, ')')-1), '052', 0)) / count(name) * 100) || '%)' 울산  
     , count(decode(substr(tel, 1, instr(tel, ')')-1), '053', 0)) || 'EA (' ||
         (count(decode(substr(tel, 1, instr(tel, ')')-1), '053', 0)) / count(name) * 100) || '%)' 대구  
     , count(decode(substr(tel, 1, instr(tel, ')')-1), '055', 0)) || 'EA (' ||
         (count(decode(substr(tel, 1, instr(tel, ')')-1), '055', 0)) / count(name) * 100) || '%)' 경남  
  from student

-- 연습문제 부서별급여누적합계, 부서번호순으로
select deptno, ename, sal,
			 sum(sal) over(partition by deptno order by sal) total
	 from emp

--  연습문제사원급여액이 총급여액의 점유율출력, 급여비중이 높은 순으로
select deptno, ename, sal, sum(sum(sal)) over() total_sal,
--       round(sal / sum(sum(sal)) over(), 2)
			 round((ratio_to_report(sum(sal)) over()) * 100, 2) 점유율
from emp
GROUP BY deptno, ename, sal
order by 점유율 desc

-- 연습문제 각 사원들의 급여가 해당부서합계급액의 비율, 부서번호기준 오름차순
select deptno
     , ename
		 , sal
		 , sum(sum(sal)) over (partition by deptno order by sal) 부서총급여액
		 , round((ratio_to_report(sum(sal)) over(partition by deptno)) * 100 ,2) "점유율"
  from emp
 group by deptno, ename, sal
 order by 점유율 desc












