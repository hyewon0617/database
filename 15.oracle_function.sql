/*
	1. Funcition
	
		보통의 경우 값을 계산하고 그 결과 값을 반환하기 위해서 function을 사용한다.
		대부분 프로시저와 유사하지만 in 파라미터만 사용할 수 있다.
		반드시 반환될 값의 데이터타입을 return문에 선언해야 한다.
		또한, PL/SQL block내에 return문을 통해서 값을 반환한다.
		
	2. 문법
		1) PL/SQL block에서 적어도 한개의 return문이 있어야한다.
		2) PL/SQL block은 함수가 수행할 내용을 정의한 body부분이다.
		3) 선언방법
		
		create or replace function 펑션이름 
			(v_empno in number) --> 리턴값을 선언
			return 데이터타입 --> 테이터타입은 반환되는 값의 데이터타입이어야함
		is
			변수선언
		begin
		
			return 변수명 --> 리턴문이 반드시 존재해야 한다.
		
		end;

*/


-- 실습01) 사원번호를 입력받아서 사원급여를 10%인상하는 함수
create or replace function fn_01
	(v_empno in number)
	return number
is
	v_sal emp.sal%type;
begin

	update emp
		 set sal = sal * 1.1
	 where empno = v_empno;
	 commit;
	 
	 select sal into v_sal
		 from emp
	  where empno = v_empno;

	return v_sal;
end fn_01;

-- 실습02) 부피를 계산하는 함수
create or replace function fn_02
	(length in number, width in number, height in number)
	return number
is
	result number;
begin
result := length * width * height;
return result;
end fn_02;


select fn_02(20,30,10) from dual


-- 실습03) 현재일(sysdate)입력 받아서 해당월의 마지막일자 구하기
create or replace function fn_03 (v_date in date)
return date
is 
lastdate date;
begin
lastdate := last_day(v_date);
return lastdate;
end fn_03;

select fn_03(sysdate) from dual;
select fn_03('2020-02-01') from dual;
select fn_03('20200201') from dual;

--------------------------------------------------

create or replace function fn_03
	(v_date in date)
  return date
is
  lastdate date;  -- 2020-01-31 15:02:30;
begin
	lastdate := (add_months(v_date, 1) - to_char(v_date, 'DD'));
	return lastdate;
end fn_03;

select add_months(sysdate, 1) - to_char(sysdate, 'DD') from dual;
select last_day(sysdate) from dual;
select fn_03(sysdate) from dual;
select fn_03('2020-02-01') from dual;
select fn_03('20200201') from dual;


-- 실습04) '홍길동'입력받아서 '길동'을 리턴하는 함수
create or replace function fn_04
	(v_char in varchar2)
  return varchar2 
is
    aaa varchar2(10);
begin
   aaa := substr(v_char, 2 , 2);
return aaa;
end fn_04;

select fn_04('홍길동') from dual;


/* 
	조건문
*/
-- 1. if then end if
create or replace procedure pro_09 
is
	v_empno     emp.empno%type; 
	v_ename     emp.ename%type; 
	v_deptno    emp.deptno%type;
	v_dname     varchar2(20) := null;
begin
	select empno, ename, deptno
	  into v_empno, v_ename, v_deptno
		from emp
	 where empno = 7369;
	 
	 -- 조건
	 if (v_deptno = 10) then
			v_dname := '회계부';
	 end if;

	 if (v_deptno = 20) then
			v_dname := '연구실';
	 end if;
	 
	 if (v_deptno = 30) then
			v_dname := '영업부';
	 end if;

	 if (v_deptno = 40) then
			v_dname := '전산부';
	 end if;
	 
	 dbms_output.put_line('사번     이름     부서명');
	 dbms_output.put_line('------------------------');
	 dbms_output.put_line(v_empno || '   ' || v_ename || '    ' || v_dname);
end;

-- emp에 값을 전달 받아서 insert 하는 실습
create or replace procedure pro_10 
		(v_empno  in emp.empno%type
	 , v_ename  in emp.ename%type
	 , v_deptno in emp.deptno%type)
is
begin
	insert into emp (empno, ename, hiredate, deptno)
	         values (v_empno, v_ename, sysdate, v_deptno);			 
end pro_10;

select * from emp
 where empno = 9999;
 
 
 
-- 2. if then else end if
-- SMITH의 comm=null이면 연봉만을 계산, null이 아니면 (sal+comm) *12
create or replace procedure pro_11
is
	v_emp  emp%rowtype;
	annsal number(7,2);
begin

	select * into v_emp from emp where empno = 7369;
	
	if (v_emp.comm is null) then
	   annsal := v_emp.sal * 12;
  else 
	   annsal := (v_emp.sal + v_emp.comm) * 12;
  end if;
	
	dbms_output.put_line('사원이름 = ' || v_emp.ename);
	dbms_output.put_line('사원년봉 = ' || annsal);
	
end pro_11;


-- 3. if then elsif end if
create or replace procedure pro_12
is
	v_emp  emp%rowtype;
	v_dname varchar2(20);
begin
	
	select * into v_emp from emp where empno = 7369;
	
	if (v_emp.deptno = 10) then
	   v_dname := '회계부';
  elsif (v_emp.deptno = 20) then
	   v_dname := '연구실';	
  elsif (v_emp.deptno = 30) then
	   v_dname := '영업부';	
  elsif (v_emp.deptno = 40) then
		 v_dname := '전산부';
	end if;

	dbms_output.put_line('부서명 = ' || v_dname);

end pro_12;




/* 연습문제 */
-- ex_001 ~ 999
-- 1. emp에서 9999사원을 삭제하는 procedure 작성하세요!
CREATE OR REPLACE PROCEDURE ex_001
    ( p_empno IN  emp.empno%TYPE )

        IS

        -- 삭제 데이터를 확인하기 레코드 선언 
        TYPE del_record IS  RECORD
        ( v_empno      emp.empno%TYPE,
          v_ename      emp.ename%TYPE,
          v_hiredate    emp.hiredate%TYPE) ;

          v_emp  del_record ;

        BEGIN

        DBMS_OUTPUT.ENABLE;

         -- 삭제된 데이터 확인용 쿼리 
         SELECT empno, ename, hiredate
         INTO v_emp.v_empno, v_emp.v_ename, v_emp.v_hiredate
         FROM emp
         WHERE empno = p_empno ;

        DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_emp.v_empno );
        DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_emp.v_ename );
        DBMS_OUTPUT.PUT_LINE( '입 사 일 : ' || v_emp.v_hiredate );

        -- 삭제 쿼리 
        DELETE
        FROM emp
        WHERE empno = p_empno ;

        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE( '데이터 삭제 성공 ' );

       END;
			 
		 select * from emp;
	
	
-- 2. 특정사원의 급여를 일정율이상 or 인하하는 프로시저를 작성하세요
-- 전달받는 파라미터는 사원번호 / 급여인상(하)율
-- emp테이블의 sal컬럼을 update하세요
	 create or replace procedure ex_002
	(p_empno in emp.empno%type,
	 p_rate  in number) 
is
	v_emp emp%rowtype;
begin
  -- 인상전
	select empno, ename, sal
	  into v_emp.empno, v_emp.ename, v_emp.sal
		from emp
	 where emp.empno = p_empno;
	 
	 dbms_output.put_line('인상전 급여');
	 dbms_output.put_line('--------------------------------------');
	 dbms_output.put_line('사원번호='||v_emp.empno||', '
	                    ||'사원이름='||v_emp.ename||', '
	                    ||'사원급여='||v_emp.sal);	
											
	-- update
	update emp
	   set sal = sal + (sal * p_rate / 100) -- 인상/인하 급여계산
	 where empno = p_empno;
		 
	-- 수정확인
	select empno, ename, sal
	  into v_emp.empno, v_emp.ename, v_emp.sal
		from emp
	 where emp.empno = p_empno;
	 
	 dbms_output.put_line('');
	 dbms_output.put_line('인상후 급여');
	 dbms_output.put_line('--------------------------------------');	 
	 dbms_output.put_line('사원번호='||v_emp.empno||', '
	                    ||'사원이름='||v_emp.ename||', '
	                    ||'인상급여='||v_emp.sal);	
end;


-- 3. test_pro 테이블을 아래와 같이 생성한 후
-- 자료 한개를 추가한후에 결과를 아래와 같이 결과창에 출력하세요(
-- dbms_output.put_line()함수를 사용할 것
-- 결과
-- DATA : 11 과 11 를 입력했음
-- DATA 입력 시간은 : 2020-01-21입니다
CREATE  TABLE  TEST_PRO 
(A  NUMBER(10),  B  NUMBER(10), C  DATE  DEFAULT  SYSDATE) ;

create or replace procedure ex_003
	(p_first  in number, p_second in number) 
is
begin
	insert into test_pro(a, b) values(p_first, p_second);
	dbms_output.put_line('DATA : '||p_first||' 과 '||p_second||' 를 입력했음');
	dbms_output.put_line('DATA 입력시간은 '
	                   || to_char(sysdate,'YYYY-MM-DD') ||'입니다');	
end;
-- 4. 현재일을 입력받아서 '2020년 12월 25일'형태의 문자열을
-- 리턴 받는 function을 작성하세요! 
		 
 create or replace function ex_004
	(p_date in date)
	return varchar2
is
  date_format varchar2(20);
begin
	date_format := to_char(p_date, 'YYYY"년" MM"월" DD"일"');
	return date_format;
end;

select ex_004(sysdate) from dual;
-- 5. 주민번호를 입력받아서 남자 또는 여자를 리턴 받는 함수를 작성하세요!
-- 1,3은 남자, 2,4는 여자
create or replace function ex_005
  (p_ssn in varchar2)
	return varchar2
is
  gender varchar2(10);
begin
	gender := substr(p_ssn, 8, 1);

  if gender in('1', '3') 
		then gender := '남자';
		else gender := '여자';
	end if;
	
	return gender;
end;

select ex_005('990101-1234567') from dual;
select ex_005('990101-2234567') from dual;
select ex_005('990101-3234567') from dual;
select ex_005('990101-4234567') from dual;

-- 6. emp에서 전사원의 hiredate를 현재일 기준으로 근손년월을 계산하는 
-- 함수를 작성한 후에 전사원의 근속년월을 출력하세요!
-- select ename, hiredate, ex_006(hiredate) from emp 
create or replace function ex_006
  (p_hiredate in date)
	return varchar2
is 
  workdays varchar2(20);
begin
	workdays := floor(months_between(sysdate, p_hiredate)/12)||'년'||
	              floor(mod(months_between(sysdate, p_hiredate), 12))||'개월';
  return workdays;
end;
select floor(months_between(sysdate, hiredate)/12) from emp
select floor(mod(months_between(sysdate, hiredate), 12)) from emp
select ename, hiredate, ex_006(hiredate) from  emp

/*
	반복문
	
	1. loop
	
	   loop 
		   pl/sql 실행문.....
			 loop
			   -- 중첩 loop
			 end;
			 exit [when 조건]
		 end;
		 
		 exit     : 무조건 반복에서 빠져나가는 경우
		 exit when: 조건에 맞을 경우만 빠져나가는 경우
		 
	2. while
	
		 while 조건 loop 
		   pl/sql 실행문.....
		   while 조건 loop
		   end loop;
		   exit[when 조건]
	end loop
		 
	3. for
	
		 for index in [reverse] start..end loop
			pl/sql 실행문...
			fro c in start...end loop
			end loop;
		 end loop;
		 
		 -- index는 자동 선언되는 binary_integer형변수이고 1씩 증가
		 -- reverse옵션이 사용될 경우 index는 종료값에서 시작값으로 1씩감소
		 -- in 다음에는 select문 또는 cursor문이 올 수 있다
 */
create or replace procedure pro_15
is
  v_cnt number := 100;
begin

	loop
 		v_cnt := v_cnt + 1;
-- 	dbms_output.put_line('카운트 = ' || v_cnt);
--  emp테이블에 v_cnt, '사원101', sysdate, 10 인서트해보세요!
    insert into emp(empno, ename, hiredate, deptno)
		         values(v_cnt, '사원'||v_cnt, sysdate, 10);
		exit when v_cnt >= 110;
	end loop;
	dbms_output.put_line('데이터추가완료');
	dbms_output.put_line(v_cnt-100 || ' 개의 데이터가 추가되었습니다!');
end;
		 
/*		 
create or replace procedure pro_16
is
  v_cnt number := 201;
begin
		while v_cnt < 210 loop
-- 	dbms_output.put_line('카운트 = ' || v_cnt);
--  emp테이블에 v_cnt, '사원101', sysdate, 10 인서트해보세요!
    insert into emp(empno, ename, hiredate, deptno)
		         values(v_cnt, '사원'||v_cnt, sysdate, 10);				 
	  	v_cnt := v_cnt + 1;
		exit when v_cnt > 210;
		
		end loop;
	dbms_output.put_line('데이터추가완료');
	dbms_output.put_line(v_cnt-200 || ' 개의 데이터가 추가되었습니다!');
end;

select * from emp where empno between 201 and 210
*/
-- for문 실습) emp를 조회해서 전체사원의 이름과 급여를 출력
create or replace procedure pro_17
is
  -- 1.사원명을 출력하기 위한 table 선언
	type ename_table is table of emp.ename%type index by binary_integer;
  -- 2. 사원급여를 출력하기 위한 table 선언
	type sal_table is table of emp.sal%type index by binary_integer;

  -- 3. 변수선언
	v_ename_tab ename_table;
	v_sal_tab   sal_table;
	i binary_integer := 0;
begin

  -- 1. ename, sal를 depto=10인 사원만큼 반복
	for emp_list in (select ename, sal from emp where deptno = 10) loop
		i := i + 1;
		v_ename_tab(i) := emp_list.ename;
		v_sal_tab(i)   := emp_list.sal;
	end loop;
	
	-- 2. 출력
	for cnt in 1..i loop
		dbms_output.put_line('사원이름:'||v_ename_tab(cnt)||', 급여:'
		                  ||v_sal_tab(cnt));
	end loop;
end pro_17;

-- 실습01)
-- create table test1(no number)
-- for문을 사용해서 100개의 자료를 추가하는 procedure ex_007을 작성
-- 결과확인
-- select조회
-- drop table
create table test1(no number)
select * from test1
create or replace procedure ex_007
is
begin
  for i in 1..100 loop
		insert into test1 values(i);
	end loop;
end;
select * from test1
drop table test1
-- 실습02)
-- for문을 사용해서 lower값, upper값을 전달 받아서 반복 후 결과를 출력
-- procedure ex_008을 작성
-- 전달받는 변수는 p_lower, p_upper숫자를 받아서 총카운터와 총출력
-- v_counter, v_output : for문에 반복되는 변수
-- for문 v_counter(1씩증가), v_output(최종값)
create or replace procedure ex_008
	(p_lower number, p_upper number)
is
	v_counter number(10) := 0;
	v_output number(10) := 0;
	
begin

	for i in p_lower..p_upper loop
		v_counter := v_counter + 1;
		v_output := i;
	end loop;
	dbms_output.put_line('총 카운터='||v_counter|| ' / ' || v_output);
	
end;











