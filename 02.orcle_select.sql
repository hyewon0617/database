-- 1. 특정 테이블의 모든 컬럼(열)정보 조회하기
--select col1....
--  from table1,... tablen
	
select * from emp;

select *
  from emp;
	
-- 2. 특정 컬럼(열)정보 조회하기
select empno, ename
  from emp;
	
-- 3. 표현식(Expression)사용하기
select ename, '안녕하세요'
  from emp;
-- 작은 따옴표사용시 주의하기
select ename, '안녕','하세요!'
  from emp;
	
-- 4. 컬럼별칭 사용하기
select ename from emp;
select ename 사원명 from emp;
select ename as "사원명" from emp;

-- '는 값, " 는 구분자로 인식
-- 5. 중복된 값을 제거하고 출력하기
select deptno from emp;
select distinct deptno from emp;

-- 6. 컬럼 or 정보를 연결하기(연결연산자 concatenation -> ||)
select ename, deptno from emp;
select ename || deptno from emp;

-- 7. where - 조건에 따라 원하는 자료만 조회하기
-- where 문법
-- select col1,...coln
--	 from table_name
-- where 컬럼명 비교연산(=, <, >...) 값(or 컬럼)
select empno, ename
	from emp
	where empno = 7900
	
select * from emp;
-- 연습문제
--  1. 급여가 1000보다작은 사원만 출력하기(ename, sal, hiredate만 출력)
select ename, sal, hiredate
  from emp
  where sal < 1000;
--  2. 부서(dept)데이블에서 부서번호와 부서명을 별칭으로 한 sql문을 작성
select deptno 부서번호, dname as "부서명"
  from dept;
--  3. 사원테이블에서 직급만 출력하는데 중복되지 않게 출력하는 sql문
select distinct job
  from emp;
	
--  4. 급여가 800인 사원만 조회
select ename, sal
  from emp
	where sal = 800;
	
--  5. 사원명이 SMITH인 사원만 출력
select ename, ENAME as "사원이름", sal, hiredate
  from emp
	where ename = 'SMITH';
	
-- [오라클문법]
-- 문자열(값)은 대소문자를 구분
-- 문자열은 작음 따옴표를(')를 사용해야 한다.
-- 키워드나 컬럼명, 테이블명은 대소문자를 구분하지 않는다.
select ename, sal
  from emp
	where sal = '800';	
-- 상기 예제는 실행은 되지만 내부적으로 숫자(변환가능한 숫자)를 문자로 변환작업-- 후에 연산을 하기 때문에 그만큼의 성능저하가 발생된다
-- 비교할때는 가급적이면 동일 자료형으로 비교하는 것이 좋다.

-- 날짜처리방법
select ename, hiredate from emp;
select ename, hiredate from emp where hiredate = '1980-12-17';
select ename, hiredate from emp where hiredate = '1980-dec-17';
select ename, hiredate from emp where hiredate = '80-12-17';
select ename, hiredate from emp where hiredate = '17-dec-1980';

-- 8. SQL에서 기본 산술연산자를 사용하기
-- 산술연산자 : +, -, *, /
-- deptno가 10인 사원의 급여를 10% 인상하기
select ename,sal, sal * 1.1 as "10%인상분"
  from emp
	where deptno = 10;

-- 테이블 구조조회
-- desc dept : SQL command line에서만 사용가능
-- 사용자가 만든 모든 테이블 조회하기
select * from tab; -- tab은 table을 의미

-- 9. 다양한 연산자
-- 9-1) 숫자와 문자 비교하기
select ename, sal
  from emp
	where sal >= 4000;
	
select ename, sal
  from emp
	where ename >= 'SN';
	
-- 9-2) between연산자 사용하기: 컬럼명 Between a And b-- emp에서 sal가 2000과 3000사이인 사원들을 출력(enameno, ename, sal)
select empno, ename, sal
  from emp
	where sal between 2000 and 3000; -- = 20<sal<30
	
-- between 사용없이
select empno, ename, sal
  from emp
	where sal >= 2000
	and sal <=3000;
	
-- 9-3) in연산자 사용하기 : 컬럼명 in (값1,...값n - 조건)
-- emp테이블에서 부서번호가 10, 20인 사원만 조회(empno, ename, sal, deptno)
select empno, ename, sal, deptno
  from emp
  where deptno in (10, 20);

-- or 연산자 (in연산자 없이)
select empno, ename, sal, deptno
  from emp
  where deptno = 10
    or deptno = 20;
		
-- 9-4) like연산자
select ename, sal
  from emp
	where ename >= 'SN';
	
-- 사원이름이 SM으로 시작되는 모든 사원을 출력
select ename, sal
  from emp
	where ename like 'A%';
	
-- 사원이름이 N으로 끝나는 모든 사원을 출력
select ename, sal
  from emp
	where ename like '%N';
	
-- 사원이름에 N이 있는 모든 사원을 출력
select ename, sal
  from emp
	where ename like '%N%';
	
-- sal가 1로 시작되는 모든 사원을 출력
select ename, sal
  from emp
	where sal like '1%';
	
-- 9-5) is null / is not null연산자 사용하기
select empno, ename, sal, comm, sal + comm
  from emp
	where comm is null;
	
-- 9-6) not연산자 사용하기
-- emp테이블에서 부서번호가 20이 아닌 사원만 출력하기
select empno, ename, sal, deptno
  from emp
	where not (deptno=20); 
	
select *
  from emp
  where deptno <> 20;

select *
  from emp
	where deptno != 20;
	
-- 10. 검색조건이 2개 이상인 경우
--  사원이름은 S로 시작되면서 급여가 800인 사원
select ename, sal
  from emp
  where ename like 'S%'
  and sal = 800;
-- 급여가 1000보다 크면서 comm이 1000 보다 작거나 com이 null인 사원
select ename, sal, comm
  from emp
 where sal > 1000 
   and (comm < 1000 or comm is null)
	 
-- 연습문제 emp 모든 사람들의 이름과 직업을 출력
select ENAME||'('||JOB||'), ' ||  
ENAME||''''||JOB||'''' as "NAME AND JOB"
 from emp;
 
-- 연습문제 emp 모든 사원의 이름과 급여를 출력
select ENAME||''''s sal is '$'||JOB|| as "Name and Sal"
 from emp;

/* 집합연산자(set operator) */
-- union     : 합집합, 중복값을 제거하고 정렬
-- union all : 합집합, 중복값을 제거하지 않고 정렬
-- intersect : 교집합후 정렬
-- minus     : 차집합후 정렬, 쿼리의 순서가 중요
-- 집합연산자사용조건
-- 1. 두 집합의 select절의 컬럼갯수가 동일해야 한다.
-- 2. 두 집합의 select절의 컬럼의 데이터형이 동일해야 한다.
-- 3. 두 집합의 컬럼명은 달라도 상관없다.
-- 1. union / union all
select studno, name, deptno1, 1 from student where deptno1 = 101
union all
select studno, name, deptno1, 2 from student where deptno1 = 101

select studno, name, deptno1 from student where deptno1 = 101
union
select studno, name, deptno1 from student where deptno1 = 101

-- 2. intersect : 교집합
select studno, name from student where deptno1 = 101
intersect
select studno, name from student where deptno2 = 201

-- 3. minus : 차집합
select empno, ename, sal from emp
minus
select empno, ename, sal from emp where sal > 2500;

