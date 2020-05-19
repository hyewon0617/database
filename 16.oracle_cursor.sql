/*
	1. Cursor(커서)?
	
	   오라클 서버는 SQL문을 실행하고 처리한 정보를 저장하기 위헤 'Private 
		 SQL Area'라는 메모리 작업공간을 이용한다. 이 영역에 이름을 부여하고
		 저장된 정보를 처리할 수 있게 해주는 데 이를 커서(Cursor)라고 한다.
		 
		 Cursor는 DML문과 select문에 의해 내부적으로 선언되는 묵시적커서와 
		 명시적커서가 있다. 
		 
		 PL/SQL에서 select문은 한개의 row만 검색할 수 있기 때문에 하나 이상의
		 row를 검색하기 위해서는 명시적 커서를 사용해야 한다. 
		 
		 묵시적커서의 경의 pl/sql블럭의 begin..end에 sql문이 있다면 pl/sql은
		 "SQL"이라는 이름의 커서를 자동을 생성한다.
	
	2. Cursor종류
	   
		 1) 암시적(Implicit)커서
		 
		    암시적커서는 오라클이나 pl/sql실행 매커니즘에 의해 처리되는 SQL문장이
				처리되는 곳에 대한 익명의 주소이다. 오라클데이터베이스에서 실행되는
				모든 SQL문장은 암시적인 커서가 생성이 되면 커서속성을 사용할 수 있다.
				암시적커서는 SQL문이 실행되는 순간에 자동으로 open과 close를 실행한다.
		 
			  암시적커서의 속성은
				
				a. SQL%rowcount : 해당 sql문에서 영향을 받는 행의 수
				b. SQL%found    : 해당 sql문에서 행의수가 한개 이상일 때 true를 리턴
				c. SQL%notfoune : 해당 sql문에서 행의수가 없을 경우에 true를 리턴
				d. SQL%isopen   : 항상 false, 암시적커서가 열려있는지 여부를 검색
								
		 2) 명시적(Explicit)커서
  
	      프로그래머에 의해 선언되고 이름이 부여된 커서를 말한다.
				명시적커서의 진행순서는 "선언 -> open -> fetch -> close"로 진행한다.
				
				a. 문법 : cusor 커서명 is select문
				b. 커서명령
				   a) 커서열기(open)
					 
						  ... 커서의 열기는 open문을 사용
							... 커서안의 검색이 실행되면 데이터가 추출되진 않아도 에러는 
							    발생하지 않는다.
						  ... 문법 : open 커서명;
					 
					 b) 커서패치(fetch)
					 
					    ... 커서의 fetch는 현재 데이터행을 output변수에 반환 
							... 커서의 select문의 컬럼수와 output변수의 수가 동일 해야 한다.
							... 커서컬럼의 타입과 output변수의 타입은 동일해야 한다.
						  ... 커서는 한라인씩 데이터를 fetch한다.
						  ... 문법 : fetch 커서명 into 변수1...변수n	
							
					 c) 커서닫기(close)
					 
					    ... 사용이 끝난 커서는 반드시 닫아 주어야 한다.
							... 필요할 경우 커서를 다시 오픈할 수 있다.
							... 커서를 닫은 경우에는 fetch할 수 없다.
							... 문법: close 커서명;
	
*/
-- 암묵적커서
create or replace procedure pro_18
  (p_empno in emp.empno%type)
is
	v_sal        emp.sal%type;
	v_update_row number;
begin
  select sal
	  into v_sal
		from emp
	 where empno = p_empno;
	 
	 -- 1. 검색자료가 있는 경우
	 if sql%found 
	    then dbms_output.put_line('자료가 있습니다!'||v_sal);
	 end if;
	 
	 update emp
	    set sal = sal * 1.1
		where empno = p_empno;
		
	 -- 2. 수정한 데이터의 카운트를 변수에 저장
	 v_update_row := sql%rowcount;
	 dbms_output.put_line('급여인상된 사원수 = '||v_update_row);
   exception 
     when no_data_found then dbms_output.put_line('자료가 없습니다!');
end pro_18;

select * from emp;

-- 명시적커서
-- 1. 특정 부서의 평균급여와 사원수를 출력
create or replace procedure pro_19 
  (p_deptno in dept.deptno%type)
is
	cursor dept_avg is
	select dpt.dname
	     , count(emp.empno) 
			 , round(avg(emp.sal), 2)
	  from emp emp, dept dpt
   where dpt.deptno = emp.deptno
	   and dpt.deptno = p_deptno
	 group by dpt.dname;
   
	 -- 커서를 패치한후 저장할 변수를 선언
	 v_dname    dept.dname%type;
	 v_emp_cnt  number;
	 v_sal_avg  number;
begin
	-- 1. 커서오픈
	open dept_avg;
	
	-- 2. 커서패치
	fetch dept_avg into v_dname, v_emp_cnt, v_sal_avg;
	
	dbms_output.put_line('부서이름 : ' || v_dname);
	dbms_output.put_line('부서인원 : ' || v_emp_cnt);
	dbms_output.put_line('평균급여 : ' || v_sal_avg);
	
	-- 3. 커서닫기
	close dept_avg;
	
exception
	when others then dbms_output.put_line(sqlerrm|| ' 에러발생!');
end;


-- 2. for문안에 커서를 사용
-- for문을 사용하면 커서의 open, fetch, close가 자동으로 진행되기 때문에 
-- 별도로 기술할 필요가 없고 레코드이름도 자동으로 선언되기 때문에 별도로
-- 선언할 필요가 없다.
-- for 레코드이름 in 커서명 loop 실행문... end loop;
create or replace procedure pro_20
is
	cursor dept_sum is
	select dpt.dname
	     , count(emp.empno) cnt
			 , sum(emp.sal) salary
	  from emp emp, dept dpt
	 where emp.deptno = dpt.deptno
	 group by dpt.dname;
begin

	-- 커서를 for문으로 사용
	for emp_list in dept_sum loop
		dbms_output.put_line('부서이름 : ' || emp_list.dname);
		dbms_output.put_line('부서인원 : ' || emp_list.cnt);
		dbms_output.put_line('평균급여 : ' || emp_list.salary);		
	end loop;

exception
	when others then dbms_output.put_line(SQLERRM|| ' 에러발생!!!');
end;
	
-- 3. 속성사용
-- 커서명%isopen, 커서명%notfound, 커서명%found, 커서명%rowcount
create or replace procedure pro_21
is
	v_empno    emp.empno%type;
	v_ename    emp.ename%type;
	v_sal      emp.sal%type;
	
	cursor emp_list is
	select empno, ename, sal from emp;
	
begin

   open emp_list; 
	 
	 loop
	    fetch emp_list into v_empno, v_ename, v_sal;
		  exit when emp_list%notfound;
	 end loop;
	 
	 dbms_output.put_line('전체처리건수 = ' || emp_list%rowcount);
	
   close emp_list;	
exception
	when others then dbms_output.put_line(SQLERRM|| ' 에러발생!!!');
end;

-- 4. 파라미터가 있는 커서사용하기
-- 커서가 오픈되고 질의가 실행이 되면 매개변수값을 커서에 전달할 수가 있다.
-- 다른 커서를 원할 경우 별도의 커서를 따로 선언해야 된다.
create or replace procedure pro_22
	(p_deptno emp.deptno%type)
is
	v_ename emp.ename%type;
	cursor emp_list(v_deptno emp.deptno%type) is
	select ename from emp where deptno = v_deptno;
	
begin

	dbms_output.put_line('------[ 선택된 부서에 소속된 사원명부 ]-----');
	
	-- 파라미터가 있은 커서를 for문에서 사용
	for emplist in emp_list(p_deptno) loop
			dbms_output.put_line('사원이름 : '||emplist.ename);
	end loop;
	
exception
	when others then dbms_output.put_line(SQLERRM|| ' 에러발생!!!');	
end;

-- 5. 커서를 이용한 참조데이터의 행을 수정하거나 삭제하기
-- where current of 명령
-- 1) 특정조건을 사용하지 않고도 현재 참조된 자료의 행수정, 삭제를 할 수가 있다.
-- 2) fetch문으로 최근에 사용된 행을 참조하기 위해서 사용하는 명령
-- 3) delete, update를 사용할 수 있다.
-- 4) where current of절을 사용할 떄 참조하는 커서가 있어야 하고 for update절이
--    커서선언절안에 있어야 한다. 없을 경우에는 에러가 발생
create or replace procedure pro_23
is
	cursor emp_list is
	select empno, ename from emp 
	 where empno = 7934
	   for update; -- for update는 커서가 오픈될 떄 행삭제, 수정하기 전에 행을 lock
begin

	for emplist in emp_list loop
		update emp
		   set job = 'SALESMAN'
		 where current of emp_list;
		 dbms_output.put_line('자료수정이 성공적으로 완료되었습니다!');
	end loop;

exception
	when others then dbms_output.put_line(SQLERRM|| ' 에러발생!!!');	
	
end;
select * from emp where empno = 7934;

-- 실습) 성적관리하기위한 프로시저 만들기
-- 성적테이블
create table sungjuk (
			hakbun   varchar2(10)
		, name     varchar2(10)
		, kor      number(3)
		, eng      number(3)
		, mat      number(3)
);
insert into sungjuk values(1001, '홍길동',90,80,70);
insert into sungjuk values(1002, '홍길순',100,100,100);
insert into sungjuk values(1003, '홍길자',90,80,70);
insert into sungjuk values(1004, '홍길녀',70,60,50);
insert into sungjuk values(1005, '홍길영',70,70,70);
select * from sungjuk;

-- 성적결과테이블
create table sungresult(
			hakbun   varchar2(10)
		, name     varchar2(10)
		, kor      number(3)
		, eng      number(3)
		, mat      number(3)		
		, tot      number(3)
		, avg      number(4,1)
		, hak      varchar2(2)	-- A+, ~ F
	  , pass     varchar2(10)
	  , rank     number	
);

-- 프로시저 ex_009
-- 1. sungjuk파일을    커서 c_sungjuk    로 정의
-- 2. sungresult파일을 커서 c_sungresult
-- 3. >=95 A+, >=90 A0, >=85 B+ 5점단위... >= 60 D0 else 'F
-- 4. 성적의 평균이 >= 70 pass= 'pass' else pass='fail';
-- 5. insert into sungresult() value()
-- 6. update sungresult rank = 순위를 update
create or replace procedure ex_009
is
	cursor cur_sungjuk is
	select * from sungjuk; 
	
		v_hakbun   sungjuk.hakbun%type;
		v_name     sungjuk.name%type;
		v_kor      sungjuk.kor%type;
		v_eng      sungjuk.eng%type;
		v_mat      sungjuk.mat%type;
		v_tot      sungresult.tot%type;
		v_avg      sungresult.avg%type;
		v_hak      sungresult.hak%type;
	  v_pass     sungresult.pass%type;
	  v_rank     sungresult.rank%type;
		
		cursor cur_sungjuk2 is 
		select hakbun, tot from sungresult;
begin
	open cur_sungjuk;
	
	loop fetch cur_sungjuk into v_hakbun, v_name, v_kor, v_eng, v_mat;
		exit when cur_sungjuk%notfound;
		
		v_tot := v_kor + v_eng + v_mat;
		v_avg := round(v_tot / 3, 1);
		
		if v_avg >= 95 then v_hak := 'A+';
		elsif v_avg >= 90 then v_hak := 'A0';
		elsif v_avg >= 85 then v_hak := 'B+';
		elsif v_avg >= 80 then v_hak := 'B';
		elsif v_avg >= 75 then v_hak := 'C+';
		elsif v_avg >= 70 then v_hak := 'C';
		elsif v_avg >= 65 then v_hak := 'D+';
		elsif v_avg >= 60 then v_hak := 'D';
		else  v_hak := 'F';
		end if;
		
		if v_avg >= 70 
		   then v_pass := 'PASS';
		   else v_pass := 'FAIL'; 
	  end if;
		
		insert into sungresult(hakbun, name, kor, eng, mat, tot, avg, hak, pass)
		       values(v_hakbun, v_name, v_kor, v_eng, v_mat,v_tot, v_avg, v_hak, v_pass);
			 
	  commit;
		
	end loop;
	close cur_sungjuk;	

  -- 순위구하기
	open cur_sungjuk2;
	
	loop fetch cur_sungjuk2 into v_hakbun, v_tot;
	  exit when cur_sungjuk2%notfound;
		
		select count(*) + 1 into v_rank from sungresult where tot > v_tot;
		update sungresult
		   set rank = v_rank
		 where hakbun = v_hakbun;
	  
		commit;
		
	end loop;
	
  close cur_sungjuk2;
	
end ex_009;
select * from sungresult0;
	
	
/* 연습문제 */
-- ex01) 두 숫자를 제공하면 덧셈을 해서 결과값을 반환하는 함수를 정의
-- 함수명은 add_num
CREATE OR REPLACE FUNCTION add_num
	(num1 IN NUMBER, num2 IN NUMBER)
RETURN NUMBER
IS
    result NUMBER;
BEGIN
    DBMS_OUTPUT.ENABLE;
    result := num1+num2;
    DBMS_OUTPUT.PUT_LINE(result);
    RETURN result;
END;
/
SELECT SUM_FUNC(10, 20) FROM DUAL;

select * from empselect * from emp
-- ex02) 부서번호를 입력하면 해당 부서에서 근무하는 사원 수를 반환하는 함수를 정의
-- 함수명은 get_emp_count
create or replace function get_emp_count
	(v_empno in emp.deptno%type)
return numberis
	emp_count number;
begin
	select count(*)
	  into emp_count
		from emp
		where deptno = v_empno;
		return emp_count;
end;

CREATE OR REPLACE FUNCTION get_emp_count01
	(deptno EMPLOYEES.DEPARTMENT_ID%TYPE)
	RETURN NUMBER
IS
    emp_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO emp_count
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID=deptno;
    RETURN emp_count;
END;
/
SELECT get_emp_count(10) FROM DUAL;

-- ex03) emp에서 사원번호를 입력하면 해당 사원의 관리자 이름을 구하는 함수
-- 함수명 get_mgr_name
create or replace function get_mgr_name
	(v_empno in emp.empno%type)
	return varchar2
is
  emp_mgr varchar2(10);
begin
select ename
	into emp_mgr
	from emp
	where empno = ( select mgr
										from  emp
										where empno=v_empno);
	return emp_mgr;
end;



CREATE OR REPLACE FUNCTION get_mgr_name
(empno EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
IS
    mgr_name VARCHAR2(10);
BEGIN
    SELECT LAST_NAME
    INTO mgr_name
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = (   SELECT MANAGER_ID
                            FROM EMPLOYEES
                            WHERE EMPLOYEE_ID=empno);
    RETURN mgr_name;
END;
-- ex04) emp테이블을 이용해서 사원번호를 입력하면 급여 등급을 구하는 함수
-- 4000~5000 A, 3000~4000미만 B, 2000~3000미만 C, 1000~200미만 D, 1000미만 F 
-- 함수명 get_sal_grade
create or replace function get_sal_grade
	(v_empno in emp.empno%type)
	return varchar2
	is
		p_sal number;
		emp_grade varchar2(10);
	begin
	select sal
		into p_sal
		from emp
		where empno = v_empno;
		
		case
			when 4000 <= p_sal then emp_grade:='A';
			when 3000 <= p_sal AND p_sal < 4000 then emp_grade:='B';
			when 2000 <= p_sal AND p_sal < 3000 then emp_grade:='C';
			when 1000 <= p_sal AND p_sal < 2000 then emp_grade:='D';
			else emp_grade:='F';
		 end case;
		 return emp_grade;
	end;
	

	
-- ex05) star_wars테이블에서 episoce란 이름으로 레코드객체를 생성후 
-- episode_id가 7 이름이 '새로운 공화국(New Republic)', 개봉일이 2099년도란
-- 데이터를 생성하는 프로시저를 작성
-- 프로시저이름은 new_star_wars	
select * from star_wars
create or replace procedure new_star_wars is
  episode star_wars%rowtype;
begin
	episode.episode_id   := 7;
	episode.episode_name := '새로운 공화국(New Republic)';
	episode.on_year      := 2099;
	
	insert into star_wars values episode;
	commit;
exception when others then 
	dbms_output.put_line('ERROR');	
	rollback;
	
end;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	