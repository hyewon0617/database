-- dual 테이블 : dummy라는 단 하나의 컬럼에 한개의 row만을 저장하고 있기 때문에 값이 아무런 의미가 없다.
-- 쿼리의 수행결과가 하나의 값으로 임시로 실행하고자 할 때 임시테이블로서의 역할을 제공한다.
select * from dual;
select sysdate from dual;

/* 단일행 함수 */
-- A. 문자함수
--  1) upper   : 소문자를 대문자로 변환 : upper('aBcdE') -> 'ABCDE'
--  2) lower   : 대문자를 소문자로 변환 : lower('aBcdE') -> 'abcde'
--  3) initcap : 첫글자를 대문자, 나머지는 소문자로 변환 : initcap('aBcdE') -> 'Abcde'
--  4) length  : 문자길이를 리턴(한글인 경우 1byte) : length('한글') -> 2
--  5) lengthb : 문자길이를 리턴(한글인 경우 2byte) : length('한글') -> 4
--  6) concat  : 문자의 값을 연결(||와 동일) : concat('A', 'B') -> AB
--  7) substr  : 주어진 문자를 잘라서 추출 : substr('ABC', 1,2) -> AB
--  8) substrb : 주어진 문자에서 특정 위치의 바이트만 잘라서 추출 : substr('한글', 1,2) -> 한
--  9) instr   : 주어진 문자에서 특정문자의 위치를 리턴 : instr("A*B#C#D", '#') -> 4
-- 10) insrtb  : 주어진 문자에서 특정문자의 위치 바이트를 리턴 : instr("한글로", "로") -> 5
-- 11) lpad    : 주어진 문자열에서 왼쪽으로 특정 문자를 채움 : lpad('love', 6, '*') -> **love = 6에서 나머지 숫자만큼 특정문자를 채움
-- 12) rpad    : 주어진 문자열에서 오른쪽으로 특정 문자를 채움 : rpad('love', 6, '*') -> love**
-- 13) ltrim   : 주어진 문자열에서 왼쪽의 특정 문자를 삭제 : ltrim('*love', '*') -> love
-- 14) rtrim   : 주어진 문자열에서 오른쪽의 특정 문자를 삭제 : ltrim('love*', '*') -> love
-- 15) replace : 주어진 문자열에서 A를 B로 치환 : replace("AB", "A", "E") -> EB

-- 1. initcap() 함수
select ename, initcap(ename)
  from emp
  where deptno = 10;
-- PROFESSOR에서 name을 initcap()함수를 적용, deptno = 101
select name, initcap(name)
  from professor
	where deptno = 101;
	
-- 2. lower(), upper() 함수
-- emp에서 ename을 lower(), upper()함수를 각각 적용 deptno = 10
select ename, lower(ename)
  from emp
	where deptno = 10;
	
select ename, upper(ename)
  from emp
	where deptno = 10;
	
select ename, lower(ename), upper(ename), upper(lower(ename))
  from emp
	where deptno = 10;
	
-- 3. length() / lengthb() : UTF-8은 한글자당 3byte
select ename, length(ename), lengthb(ename), length('소향') , lengthb('소향')
  from emp
	where deptno = 10;
	
-- 4. concat() : ||와 동일
select ename || job, concat(ename, job)
  from emp
	where deptno = 10;
	
-- 5. substr() /substrb()
select substr('abcde', 3, 2) "CD"
			,substr('abcde', -3, 2) "-CD"
			,substr('abcde', -3, 4) "-CDE"
			,substr('abcde', 1, 2) "AB"
  from dual;
	
select name, jumin, substr(jumin, 3, 4) "생일"
	from student
	where deptno1 = 101; 
	
select '홍길동', substr('홍길동', 1, 2), substrb('홍길동', 1, 2), substrb('홍길동', 1, 3)
	from dual;
	
-- 6. instr : instr(문자열 or 컬럼, 검색할 글자, 시작, 몇번째(기본값은 1)) / union = 결과를 결합하는 명령어 중복은 제거 union all = 결과를 결합하고 중복도 row형으로 표현
select 'A*B*C*D' , instr('A*B*C*D', '*', 1, 3)
	from dual
union all
select 'A*B*C*D' , instr('A*B*C*D', '*', 3, 1)
	from dual
union all
select 'A*B*C*D' , instr('A*B*C*D', '*', 3, 2)
	from dual

-- 7. lpad() / rpad() : 채우기
select '***hong###', lpad('***hong###', 10, '*'), rpad('***hong###', 10, '#'), 
	lpad('***hong###', 20, '*'), rpad('***hong###', 20, '#')
	from dual

-- 8. ltrim()/ rtrim() : 자르기
select ename from emp where deptno = 10

select ltrim(ename, 'C') from emp where deptno = 10
union all
select rtrim(ename, 'R') from emp where deptno = 10

-- 9. replace() : replace(문자열 or 컬럼, 변경할 문자, 변경될 문자)
select ename, replace(ename, 'CL', '**'), replace(ename, substr(ename, 1, 2), '**')
	from emp
	where deptno = 10


-- 연습문제 단일행함수 1 : substr, instr 활용하여 deptno1이 201인 학생의 이름과 전화번호와 지역번호를 출력
select name, tel, substr(tel, 1, 2), instr(tel, ')') - 1, substr(tel, 1,instr(tel, ')')-1)
	from student
	where deptno1 = 201

-- 연습문제 단일행함수 2 : lpad를 활용하여 deptno가 10인 사원들의 이름을 9byte로 출력, 빈자리에는 숫자를 채우기
select ename, lpad(ename, 9, '12345')
	from emp
	where deptno = 10
	
-- 연습문제 단일행함수 3 : rpad를 활용하여 deptno가 10인 사원들의 이름을 9byte로 출력, 빈자리에는 숫자를 채우기
select ename, rpad(ename, 9 , substr('123456789', lengthb(ename)+1, 9))
	from emp
	where deptno = 10
	
	
select ename, rpad(ename, 9, '*+'), rpad(ename, 9, '12456789'), lengthb(ename) + 1,
			 substr('123456789', lengthb(ename) + 1), rpad(ename, 9, substr('123456789', lengthb(ename) + 1))
			from emp
			where deptno = 10 
	
-- 연습문제 단일행함수 4 : replace를 활용하여 20부서 사원의 이름과 3,4번째 글자만 '-'로 변경후출력
select ename, replace(ename, substr(ename, 2, 2) , '--')
	from emp
	where deptno = 20

-- 연습문제 단일행함수 5 : deptno1가 101인 학생들의 이름과 주민번호를 출력하는데 주민번호 뒤 7자리는 '-'와'/'로 표현
select name, jumin, replace(jumin, substr(jumin, 7, 7),'-/-/-/-')
	from student
	where deptno1 = 101

-- 연습문제 단일행함수 6 : deptno1이 102인 학생이름과 전화번호, 전화번호에서 국번부분 별표처리하여 출력 단, 국번은 3자리
select name, tel, replace(tel, substr(tel, 5, 3), '***')
	from student
	where deptno1 = 102
	
select name, tel, replace(tel, instr(tel, ')',1)+1,3), '***')
	from student
	where deptno1 = 102	

-- 연습문제 단일행함수 7 : deptno1이 101인 학생이름과 전화번호, 전화번호에서 국번,지역 별표처리하여 출력
select name, tel, replace(tel, substr(tel, 9, 4), '****')
	from student
	where deptno1 = 101;

select name, tel, instr(tel, '-', 1)+1, substr(tel, instr(tel, '-', 1)+1), 
replace(tel, substr(tel, instr(tel, '-', 1)+1,4),'****')
	from student
	where deptno1 = 101

-- B. 숫자함수
--  1) round() : 주어진 숫자를 반올림 : round(12.345, 2) -> 12.35
--  2) trunc() : 주어진 숫자를 버림 : round(12.345, 2) -> 12.34
--  3) mod()   : 주어진 숫자를 나누기 후 나머지 : mod(12,10) -> 2
--  4) ceil()  : 주어진 숫자와 가장 근접한 큰 정수 : ceil(12.345) -> 13
--  5) floor() : 주어진 숫자와 가장 근접한 작은 정수 : floor(12.345) -> 12
--  6) power() : 주어진 숫자1의 숫자의 제곱근을 출력 : power(3, 2) -> 9

-- 1. round(숫자, 출력을 원하는 자리수)
select round(987.654, 2), round(987.654, 0), round(987.654, -1)
  from dual
	
-- 2. trunc(숫자, 원하는 자리수)
-- round()함수와 사용법은 동일하지만 차이점은 무조건 버림을 한다는 것
select trunc(987.654, 2), trunc(987.654, 0), trunc(987.654, -1)
  from dual
	
-- 3. mod(), ceil(), floor()
select mod(121, 10), ceil(123.45), floor(123.45)
	from dual
	
-- oracle에서는 모든 객체에 rownum 속성을 제공
select rownum, ename
  from emp

-- 4. power()
select power2(2,3) form dual

-- C. 날짜함수
--    1) sysdate() : 시스템의 현재 날짜와 시간 결과는 날짜
--    2) months_between() : 두 날짜사이의 개월수, 결과는 숫자
--    3) add_months() : 주어진 날짜에 개월수를 더함, 결과는 날짜
--    4) next_day() : 주어진 날짜를 기준으로 돌아오는 날짜를 출력, 결과는 날짜
--    5) last_day() : 주어진 날짜가 속한달의 마지막 날짜를 출력, 결과는 날짜
--    6) round() : 주어진 날짜를 반올림, 결과는 날짜
--    7) trunc() : 주어진 날짜를 버림, 결과는 날짜

-- 1. sysdate
select sysdate from dual

-- 2. months_between()
select months_between('2020-01-01', '2020-09-01'), months_between('2020-09-01', '2020-01-10')
       months_between('2020-02-29', '2020-02-01')
	from dual
	
-- 3. add_months()
select sysdate, add_months(sysdate, 2)
	from dual
	
-- 4. next_day()
select sysdate, next_day(sysdate, 2), next_day(sysdate, 'SAT')
	from dual
	
-- 5. last_day()
select sysdate, last_day(sysdate), last_day('2021-02-01'), last_day('2020-02-01')
	from dual
	
-- 6. round(), trunc()
select sysdate, round(sysdate), trunc(sysdate)
	from dual

-- D. 형변환함수
--  1) to_char()   : 날짜형 or 숫자형을 문자로 변환
--  2) to_date()   : 문자형을 날짜형으로 변환
--  3) to_number() : 문자형을 숫자형으로 변환
-- 묵시적/명시적형변환
select 2 +'2' from dual -- 묵시적
select 2 + to_number('2') from dual -- 명시적
-- select 2 + 'A' from dual - 에러

-- 1. to_char() : 날짜를 문자로 변환
-- 년도
select sysdate 
			,to_char(sysdate, 'YYYY')
			,to_char(sysdate, 'RRRR')
			,to_char(sysdate, 'YY')
			,to_char(sysdate, 'YEAR')
	from dual
-- 월
select sysdate 
			,to_char(sysdate, 'MM')
			,to_char(sysdate, 'MON')
			,to_char(sysdate, 'MONTH')
	from dual
-- 일
select sysdate 
			,to_char(sysdate, 'DD')
			,to_char(sysdate, 'DAY')
			,to_char(sysdate, 'DDTH')
			from dual
-- 시간/분/초
select sysdate 
			,to_char(sysdate, 'HH:MI')
			,to_char(sysdate, 'HH:MM:SS')
			,to_char(sysdate, 'YYYY/MM/DD HH:MI')
			,to_char(sysdate, 'YYYY.MM.DD HH:MI')
			,to_char(sysdate, 'YYYY-MM-DD HH:MI')
			,to_char(sysdate, 'HH24:MI:SS')
			from dual

-- 2. to_char() : 숫자를 문자로 변환
select empno, ename, sal, comm, sal * 12, to_char ( sal * 12, '999,999')  from emp
	
-- 3. to_number()
select to_number('5') from dual
select to_number('1,234,000') from dual --invalid number 에러
select to_number('1234000') from dual

-- 4. to_date()
select to_date('20/05/31') from dual
select to_date('2020/05/31') from dual
select to_date('2020.05.31') from dual
select to_date('2020-05-31') from dual

-- E. 일반함수
--  1) nvl()    : null 값을 다른 값으로 변환 
--  2) nvl2()   : null 값을 다른 값으로 변환 nvl(col1, col2, col3)
--  3) decode() :

-- 1. nvl()
select ename
			, sal
			, comm
			, sal + comm
			, sal + nvl(comm, 0)
			, nvl(ename, 'NoneName')
			, nvl(hiredate, sysdate)
  from emp
	
-- 2. nvl2()
select ename
     , sal
		 , comm
		 , sal + comm
		 , nvl2(comm, sal+comm, sal)
		 
-- F. decode 함수
-- 1. decode 함수는 프로그램언어에서 가장 많이 사용되는 switch case 문과 같은 기능을한다.
-- 2. decode 함수는 조건에 따라 데이터를 다른 값이나 컬럼값으로 추출할 수 있다.
-- 3. decode(표현식, 조건1, 결과1,
--                   조건n, 결과n,
--                   기본결과)
-- 표현식(값) 조건1일때 결과1을 반환하고...조건n일때 결과n을 반환하고 조건을 만족하지 못한 경우 마지막 즉, 기본결과를 반환한다.
-- 4. decode함수안에 decode를 중첩해서 사용할 수 있다.

select * from dept 
select deptno,
			 decode(deptno, 10, '회계부',
											20, '연수실',
											30, '영업부',
										 '전산실')
	from dept
	
-- G. case함수
-- 1. case함수 역시 여러가지 경우에 대해서 하나의 값을 선택하는 함수이다.
-- 2. decode함수와 차이점은 decode함수는 조건이 일치(= 비교연산자)하는 경우에만 적용되는데
-- 3. case함수는 다양한 비교연산자를 사용하여 조건을 지정할 수 있다.
-- 4. decode함수는 switch문이라면 case 함수는 if else 문장과 같다.
-- 5. case when 조건 1 then 결과 1
-- 		     when 조건 n then 결과 n
-- 				 else 결과

-- case 활용하여 부서명구하기
select deptno, case when deptno = 10 then '회계부'
									  when deptno = 20 then '연수실'
									  when deptno = 30 then '영업부'
									  else '전산실'
									  end as 부서명



  from dept
	
-- 급여별로 인상율을 다르게 적용하기
-- 1000미만dms 0.8, 1000~2000은 0.5, 2001~3000 0.3 그이상은 0.1
select ename, sal 현급여,
			 case when sal < 1000 then sal+(sal*0.8)
						when sal between 1000 and 2000 then sal + (sal*0.5)
						when sal between 2001 and 3000 then sal + (sal*0.3)
						else sal + (sal*0.1)
						end as 인상급여
  from emp;

-- 연습문제 형변환 birthbay 컬럼 중 1월인 학생명과 생일을 출력
select name, birthday, to_char(birthday, 'MM'), to_char(birthday, 'YYYY/MM/DD')
	from student
	where to_char(birthday, 'MM') = '01'

-- 연습문제 형변환 입사일이 1~3월인 사원번호와 이름, 입사일을 출력
select empno, ename, hiredate, to_char(hiredate, 'MM'), to_char(hiredate, 'YYYY/MM/DD')
	from emp
	where to_char(hiredate, 'MM') in ('01', '02', '03')
	
-- 연습문제 nvl함수 201학번 교수들의 이름, 급여, 보너스, 총연봉(pay*12+bonus) 보너스가 없는 교수의 보너스는 0으로 표시
select name, profno, pay, bonus, 
			 pay * 12 + bonus
			 , nvl(bonus, 0)
			 , pay * 12 + nvl(bonus, 0)
			 , to_char(pay * 12 + nvl(bonus, 0), '999,999') 연봉
	from professor
	where deptno = 201
	
-- 연습문제 nvl2함수 deptno가 30인 사원중 comm이 있을 경우 'Exist' null일 경우 'NULL'을 출력
select empno, ename, comm, nvl2(comm, 'Exist', 'NULL')
	from emp
	where deptno = 30

-- 





























