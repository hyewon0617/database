/* Join 문법 */

-- 1. 카티션곱
select * from dept
select * from emp
select * 
  from dept t1, emp t2
	
-- 2. 등가조인(Equi Join)
-- emp와 dept에서 사원번호, 사원명, 부서명을 출력
-- join되는 테이블에 같은 이름을 가진 컬럼이 있다면 반드시 테이블이름과 함께 정의해야 한다.
-- "테이블명.컬럼명"형태로 명시하는데 테이블명은 별칭으로도 가능하다.
select empno
     , ename
		 , dname
		 , dept.deptno
  from emp, dept
 where emp.deptno = dept.deptno
 
-- oracle sql문법
select empno
     , ename
		 , dname
		 , t1.deptno
  from emp T1, dept T2
 where t1.deptno = t2.deptno 

-- ANSI sql문법
select e.empno
     , e.ename
		 , d.dname
		 , d.deptno
  from emp e join dept d on e.deptno = d.deptno
	
-- 실습) student와 professor를 조인해서 학생명, 지도교수명을 출력(oracle문법과 ansi문법 각각작성)
select count(*) from student -- 20
select * from student
select * from professor
-- Oracle Join
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std, professor pro 
 where std.profno = pro.profno
  
-- ANSI Join
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std join professor pro on std.profno = pro.profno

-- 실습) student, department(학과), professor를 join 학생명, 학과명, 교수명을 출력
select * from student;
select * from professor;
select * from department;
-- Oracle Join
select std.name   학생명
     , pro.name   교수명
		 , dpt.dname  학과명
  from student std, professor pro, department dpt
 where std.profno  = pro.profno
   and std.deptno1 = dpt.deptno 
-- ANSI Join
select std.name   학생명
     , pro.name   교수명
		 , dpt.dname  학과명
  from student std 
	     join professor pro  on std.profno  = pro.profno 
	     join department dpt on std.deptno1 = dpt.deptno

-- 실습) student의 deptno1=101인 학생의 이름과 지도교수번호와 지도교수명을 출력
-- Oracle Join
select std.name   학생명
     , pro.name   교수명
  from student std, professor pro
 where std.deptno1 = 101 
   and std.profno  = pro.profno
-- ANSI Join
select std.name   학생명
     , pro.name   교수명
  from student std
			 join professor pro on std.deptno1 = 101 and std.profno  = pro.profno

-- 3. 비등가조인(Non-Equi Join)
select * from customer;
select * from gift;

-- customer와 gift를 join해서 고객별로 마일리지기준으로 상품을 조회후 
-- 고객명과 상품명을 출력
-- Oracle Join
select cus.gname  고객명
	   , gif.gname  상품명
		 , cus.point  마일리지
  from customer cus, gift gif
 where cus.point between gif.g_start and g_end

select cus.gname  고객명
	   , gif.gname  상품명
		 , cus.point  마일리지
  from customer cus, gift gif
 where cus.point >= gif.g_start 
   and cus.point <= g_end
	 
-- ANSI Join
select cus.gname  고객명
	   , gif.gname  상품명
		 , cus.point  마일리지
  from customer cus, gift gif
 where cus.point between gif.g_start and g_end

-- 실습) student에 score, hakjum을 조회해서 학생명과 점수, 학점을 출력
select * from student;
select * from score;
select * from hakjum;
-- Oracle Join
select std.name   학생명
     , sco.total  점수
		 , jum.grade  학점
  from student std, score sco, hakjum jum
 where std.studno = sco.studno
   and sco.total between jum.min_point and jum.max_point
	 
select std.name   학생명
     , sco.total  점수
		 , jum.grade  학점
  from student std, score sco, hakjum jum
 where std.studno = sco.studno
   and sco.total >= jum.min_point 
	 and sco.total <= jum.max_point	 
-- ANSI Join
select std.name   학생명
     , sco.total  점수
		 , jum.grade  학점
  from student std
	     join score sco  on std.studno = sco.studno
			 join hakjum jum on sco.total between jum.min_point and jum.max_point

-- 4. outer join vs inner join
-- Oracle Join
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std, professor pro 
 where std.profno = pro.profno(+) -- outer join


-- ANSI Join
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std left outer join professor pro on std.profno = pro.profno

-- 실습) student, professor을 join하여 학생명과 지도교수명을 출력, 
-- 지도학생이 결정되지 않은 교수의 명단도 같이 출력
-- Oracle Join
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std, professor pro 
 where std.profno(+) = pro.profno
 order by std.name
-- ANSI Join
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std right outer join professor pro on std.profno = pro.profno
	ORDER BY std.name
	
-- 실습) student, professor를 join해서 학생명과, 교수명을 출력
-- 단, 지도학생이 없는 교수, 지도교수가 없는 학생도 같이 출력
-- union / union all / full outer join
-- Oracle Join'
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std, professor pro 
 where std.profno = pro.profno(+) -- left outer join
 union
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std, professor pro 
 where std.profno(+) = pro.profno -- right outer join
-- ANSI Join(full outer join)
select std.name 학생이름
     , pro.name 교수이름
		 , pro.profno
  from student std
	     full outer join professor pro on std.profno = pro.profno

-- 5. self join
select * from emp

-- emp에서 사원번호, 사원명과 상사명을 출력
select emp.empno  사원번호
     , emp.ename  사원명
     , mgr.ename  상사명
  from emp emp, emp mgr
 where emp.mgr = mgr.empno
 
 select * from p_grade


-- 연습문제 student와 department를 사용하여 학생이름, 전공학과번호, 학과 이름
select std.name 학생이름, std.deptno1 전공학과번호, dpt.dname 학과이름from student std, department dpt
where std.deptno1 = dpt.deptno(+)
order by 전공학과번호


-- 연습문제 emp2, p_grade 사원이름, 직급, 현재연봉, 해당 직급의 연봉의 하한금액과 상한금액
select emp2.name 사원이름, emp2.position 직급,
			 emp2.pay 현재연봉, pga.s_pay 하한금액, pga.e_pay 상한금액
	from emp2 emp2, p_grade pga
	 where emp2.position = pga.position
	 
	 
	  select t1.name     사원명
      , t1.position 직급
			, t1.pay      년봉
			, to_char(t2.s_pay, '999,999,999')    년봉하한
			, to_char(t2.e_pay, '999,999,999')    년봉상한
   from emp2 t1, p_grade t2
  where t1.position = t2.position

 select t1.name     사원명
      , t1.position 직급
			, t1.pay      년봉
			, to_char(t2.s_pay, '999,999,999')    년봉하한
			, to_char(t2.e_pay, '999,999,999')    년봉상한
   from emp2 t1
	      join p_grade t2 on t1.position = t2.position
	 
	 
-- 연습문제 emp2, p_grade 사원들의 이름과 나이, 현재직급, 예상직급
SELECT E.NAME, E.BIRTHDAY, 
TRUNC((SYSDATE-E.BIRTHDAY)/365) + 1, E.POSITION, P.POSITION 
FROM EMP2 E, P_GRADE P 
WHERE TRUNC((SYSDATE-E.BIRTHDAY)/365) + 1 BETWEEN P.S_AGE AND P.E_AGE;

 select t1.birthday
      , (sysdate - t1.birthday) / 365
      , trunc((sysdate - t1.birthday) / 365, 0)			
   from emp2 t1--, p_grade t2
 
 select t1.name 사원명
      , trunc((sysdate - t1.birthday) / 365, 0)	나이
			, t1.position 현재직급
			, t2.position 예상직급
    from emp2 t1, p_grade t2
   where trunc((sysdate - t1.birthday) / 365, 0) between t2.s_age and t2.e_age

 -- 연습문제 customer, gift 자기 포인트보다 낮은 포인트의 상품 중 선택가능
 -- notebook을 선택할 수 있는 고객명과 포인트, 상품명을 출력
select * from customer;
select * from gift;
	
select cus.gname, cus.point, 'notebook' Gift_Name
from customer cus, gift gif
where cus.gno= gif.gno(+)
and cus.point-600001>0;

select t1.gname  고객명
     , t1.point  마일리지
		 , t2.gname  상품명
  from customer t1, gift t2
 where t2.g_start <= t1.point
   and t2.gname = 'Notebook'
 
select t1.gname  고객명
     , t1.point  마일리지
		 , t2.gname  상품명
  from customer t1
	     join gift t2 on t2.g_start <= t1.point
									 and t2.gname = 'Notebook'


-- ex05) professor에서 교수번호, 교수명, 입사일, 자신보다 빠른 사람의 인원수
--       단, 입사일이 빠른 사람수를 오름차순으로

select t1.profno   교수번호
     , t1.name     교수명
		 , to_char(t1.hiredate, 'YYYY.MM.DD') 입사일
-- 		 , t2.name
-- 		 , to_char(t2.hiredate, 'YYYY.MM.DD') 
     , count(t2.hiredate) 인원수
  from professor t1
	   , professor t2
 where t2.hiredate(+) < t1.hiredate
 group by t1.profno, t1.name, t1.hiredate -- 또는 to_char(t1.hiredate, 'YYYY.MM.DD')
 order by 4	 
 
select t1.profno   교수번호
     , t1.name     교수명
		 , to_char(t1.hiredate, 'YYYY.MM.DD') 입사일
     , count(t2.hiredate) 인원수
  from professor t1
	     left outer join professor t2 on t2.hiredate < t1.hiredate
 group by t1.profno, t1.name, t1.hiredate 
 order by 4	

-- ex06) 
select * from emp

select t1.empno  사원번호
     , t1.ename  사원이름
		 , to_char(t1.hiredate, 'YYYY-MM-DD')  입사일
		 , count(t2.hiredate) 인원수
  from emp t1
	   , emp t2
 where t2.hiredate(+) < t1.hiredate
   and t1.hiredate is not null
 group by t1.empno, t1.ename, to_char(t1.hiredate, 'YYYY-MM-DD') 
 order by 4

select t1.empno  사원번호
     , t1.ename  사원이름
		 , to_char(t1.hiredate, 'YYYY-MM-DD')  입사일
		 , count(t2.hiredate) 인원수
  from emp t1
	     left outer join emp t2 on t2.hiredate(+) < t1.hiredate
 where t1.hiredate is not null
 group by t1.empno, t1.ename, to_char(t1.hiredate, 'YYYY-MM-DD') 
 order by 4

-- count(case when p1.hiredate>p2.hiredate)















