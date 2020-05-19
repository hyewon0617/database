/*
	1. PL/SQL?
	
	오라클의 Procedural Language extension to SQL의 약자
	SQL문장에서 변수정의, 조건처리(if), 반복처리(loop, for, while)등을 지원하며
	절차형언어(Procedural Language)라고 한다.
	
	declare문을 이용하여 정의되고 선언문은 사용자가 정의한다.
	PL/SQL문은 블럭구조로 되어 있고 PL/SQL자신이 자체 compile엔진을 가지고 있다.
	
	2. PL/SQL의 장점
	
		1) block 구조로 다수의 SQL문을 한번에 oracle db server로 보내서 처리하기 때문에
			 처리속도가 빠르다.
	  2) PL/SQL의 모든 요소는 하나 또는 두개 이상의 블럭으로 구성하여 모듈화가 가능하다.
		3) 보다 강력한 프로그램을 작성하기 위해 큰 블럭안에 소블럭을 위치 시킬 수 있다.
		4) variable(변수), constant(상수), cursor(커서), exception(예외처리)등을
			 정의할 수 있고 SQP문장과 Procedural문장에서 사용할 수 있다.
	  5) 변수선언은 단순변수선언과 레코드타입변수로 선언할 수 있다.
		6) 변수선언은 테이블의 데이터구조와 컬럼명에 준하여 동적으로 변수를 선언
		7) exception처리를 이용하여 oracle server error처리를 할 수 있다.
		8) 사용자가 에러를 정의할 수 있고 excetion처리를 할 수 있다.
		
 3. PL/SQL의 block구조
 
	1) PL/SQL은 프로그램을 논리적인 블럭으로 나누는 구조화된 언어
	2) 선언부(선택), 실행부(필수), 예외(선택)으로 구성되어 있고 
		 begin...end키워드는 반드시 기술해야 한다.
  3) 문법
	
			declare
				- 선택부분
				- 변수, 상수, 커서, 사용자정의예외처리
			begin
				- 필수부분
				- PL/SQL문장을 기술(select, if, for, while...)
			exception
				- 선택부분
				- 예외처리로직을 작성
			end;
			
 4. PL/SQL의 block의 종류
 
	1) anonymous block(익명블럭) : 이름이 없는 블럭으로서 보통 일회성으로 실행
	2) procedure : 매개변수를 받을 수 있고 재사용이 가능하며 보통은 연속실행 
		 또는 구현이 복잡한 트랜잭션을 수행하는 PL/SQL블럭으로 데이터베이스안에 저장된다.
		 이런 의미로 stored procedure라고도 한다.
  3) function : procedure와 유사하지만 다른 점은 계싼결과를 호출한 곳으로 반환해주는 값이 있다는 점이다.
		 다만 in 파라미터만 사용할 수 있고, 반드시 반환될 값이 데이터 타입을 return문에 선언해야 한다.
		 또한, PL/SQL블럭내에서 return문을 사용하여 반드시 값을 반환해야 한다.
  4) package : 패키지는 오라클 데이터베이스에 저장되어 있는 procedure와 function의 집합이다.
		 패키지는 선언부와 본문이 두부분으로 나누어 관리한다.
	5) trigger : insert, update, delete문이 특정 table에 수행될 때마다 자동적으로 수행되는 프로시저이다.
		 트리거는 테이블과 별도로 database에 저장된다. 트리거는 테이블에 대해서만 정의할 수 있다.
		
*/


create or replace procedure pro_01 is
begin
	dbms_output.put_line('Hello World');
	end;
	
	
create or replace procedure pro_02 is
	counter integer;
begin
	counter := 10;
	counter := counter / 0;
	dbms_output.put_line(counter);
exception when others then
	dbms_output.put_line('0으로 나눌 수 없습니다!');	
end;
	
	
create or replace procedure pro_03 is
	a boolean;
begin
	a := true;
	if a
		then dbms_output.put_line('true');
		else dbms_output.put_line('false');
	end if;
end;
/*
	PL/SQL 데이터타입
	
	1. 스칼라데이터타입
	
	  스칼라 datatype은 일반 단일 datatype과 %type 데이터형변수가 있다.
		
		1) 일반 datatype
		
	  a. 선언방법 : [constant] 데이터타입 [not null] [:=상수값 or 표현식]
		b. 변수명(variable or identifier)의 이름은 SQL명명규칙에 따른다.
		c. identifier를 상수로 지정하고 싶은 경우는 constant라는 키워드를 명시하고
			 반드시 초기값을 할당해야 한다.
	  d. not null로 정의되어 있으면 초기값을 반드시 지정, 정의되어 있지 않을 경우는 생략할 수 있다.
		e. 초기값은 할당연산자(:=)를 사용하여 지정
		f. 일반적으로 한라인에 한개의 identifire를 정의한다.
		g. 일반변수선언방법
		
			v_price constant number(4,2) := 12.34;
			v_name varchar2(10);
			v_flag boolean not null := true;
			
		2) %type 데이터형변수
		
		a. DB 테이블의 컬럼데이터를 모를 경우에도 사용할 수가 있고 테이블의 컬럼타입이 변경될 경우에도
			 다시 수정없이 사용할 수 있다.
	  b. 이미 선언된 다른 변수나 테이블의 컬럼을 이용하여 선언할 수 있다.
		c. DB테이블과 컬럼 그리고 이미 선언한 변수명이 %type앞에 올 수 있다.
		d. %type속성을 이용하여 얻을 수 있는 장점은
			 -- table의 column속성을 정확히 알지 못할 경우
			 -- table의 column속성이 변경되어도 PL/SQL을 수정할 필요가 없다.
	  e. 선언방법
	  
		v_empno emp.empno%type
		
 2. %rowtype
 
		하나 이상의 데이터값을 갖는 데이터형으로 배열과 비슷한 역할을 하면 재사용이 가능하다.
		%rowtype데이터형과 PL/SQL 테이블과 레코드는 복합데이터형에 속한다.
		
		1) 테이블이나 뷰 내부의 컬럼의 데이터형, 크기, 속성 등을 그대로 사용가능
		2) %rowtype앞에는 테이블이름이 온다.
		3) 지정된 테이블의 구조와 동일한 구조를 갖는 변수를 선언할 수 있다.
		4) 데이터베이스 컬럼들의 갯수나 datatype을 알지 못할 때 사용이 편리하다.
		5) 테이블의 데이터컬럼의 테이터타입이 변경될 때 PL/SQL을 수정할 필요가 없다
 3. table
 
	  PL/SQL에서의 table은 DB에서의 table과 성격이 다르다. PL/SQL에서의 table은 1차원배열이다.
		table은 크기에 제한이 없으며 row의 수는 데이터가 추가됨에 따라 자동으로 증가한다.
		binary_integer타입의 인덱스번호로 순서가 정해진다.
		
		하나의 테이블에 한개의 컬럼데이터를 저장할 수 있다.
		
		문법)
		
		type 테이블명 is table of varchar2(30) index by binary_integer;
		v_emp_tab emp_table
		 
		 선언의 의미는 emp_table타입으로 변수 v_emp_tab를 선언한다는 의미이다.
 4. record
 
		1) record 데이터타입은 여러개의 데이터 타입을 갖는 변수들의 집합
		2) 스칼라, 테이블 또는 레코드타입중 하나 이상의 요소로서 구성
		3) 논리적 단위로서 컬럼집합을 처리할 수 있도록 한다.
		4) PL/SQL의 table과는 다르게 개별 필드의 이름을 부여, 선언시에 초기화가 가능
		5) 문법
		
			type 레코드명 is record (
				col1 데이터타입 [not null {:= | default} 표현식],
				...
				coln 데이터타입 [not null {:= | default} 표현식]
				);
 5. table of record
 
		1) PL/SQL의 테이블타입 선언과 유사하며 데이터타입을 %rowtype으로 선언한다.
		2) PL/SQL의 테이블타입과 레코드타입의 복합기능을 한다.
		3) 문법
		
			type 테이블레코드명 is table of 오라클테이블%rowtype
			index by binary_integer;
			
			변수명  테이블레코드명
*/

--   
-- 스칼러 데이터타입 실습
-- procedure에서 select문장 문법
-- select col1...coln 
--   into val1...valn
--   from table
create or replace procedure pro_04 is
	v_empno  emp.empno%type;
	v_ename  emp.ename%type;
	v_sal    emp.sal%type;
begin
		
		select empno,   ename,   sal
		  into v_empno, v_ename, v_sal
		  from emp 
		 where empno = 7654;

		 dbms_output.put_line('사원번호=' || v_empno);
		 dbms_output.put_line('사원이름=' || v_ename);
		 dbms_output.put_line('사원급여=' || v_sal);
end;

-- %rowtype 데이터타입 실습
create or replace procedure pro_05 is	
	v_emp emp%rowtype;
begin

	select empno,   ename,   sal
		  into v_emp.empno, v_emp.ename, v_emp.sal
		  from emp 
		 where empno = 7654;

		 dbms_output.put_line('사원번호=' || v_emp.empno);
		 dbms_output.put_line('사원이름=' || v_emp.ename);
		 dbms_output.put_line('사원급여=' || v_emp.sal);
end;
	
-- table 데이터 타입실습	
create or replace procedure pro_06 is
type empno_table is table of emp.empno%type index by binary_integer;
type ename_table is table of emp.ename%type index by binary_integer;
type sal_table is table of emp.sal%type index by binary_integer;
	
v_empno_tab empno_table;v_ename_tab ename_table;
v_sal_tab sal_table;
i binary_integer := 0;
begin

	for emp_list in(select empno, ename, sal from emp) loop
		i := i + 1;
		v_empno_tab(i)  := emp_list.empno;
		v_ename_tab(i)  := emp_list.ename;
		v_sal_tab(i)  := emp_list.sal;

	end loop;
	
	for cnt in 1..i loop
		 dbms_output.put_line('사원번호=' || v_empno_tab(cnt));
		 dbms_output.put_line('사원이름=' || v_empno_tab(cnt));
		 dbms_output.put_line('사원급여=' || v_sal_tab(cnt));
	end loop;
end;	
	
	
-- record 데이터타입 실습create or replace procedure pro_07 is
	type emp_record is record (
		v_empno number,
		v_ename varchar2(30),
		v_hiredate date
		);

	v_emp_rec		emp_record;
	
begin

	select empno, ename, hiredate
		into v_emp_rec.v_empno, v_emp_rec.v_ename, v_emp_rec.v_hiredate
		from emp
		where empno = 7654;
		
		 dbms_output.put_line('사원번호=' || v_emp_rec.v_empno);
		 dbms_output.put_line('사원이름=' || v_emp_rec.v_ename);
		 dbms_output.put_line('사원급여=' || v_emp_rec.v_hiredate);end;

-- table of record 데이터타입 실습
create or replace procedure pro_08 is
	type dept_table_type is table of dept%rowtype index by binary_integer;
	
	v_dept_table dept_table_type; 
	i binary_integer :=0;
begin

	for dept_list in (select * from dept) loop
		i := i + 1;
		v_dept_table(i).deptno := dept_list.deptno;
		v_dept_table(i).dname  := dept_list.dname;
		v_dept_table(i).loc    := dept_list.loc;	
  end loop;	
	
	for c in 1..i loop
		dbms_output.put_line('부서번호='||v_dept_table(c).deptno||
		                     ', 부서이름='||v_dept_table(c).dname||
		                     ', 부서위치='||v_dept_table(c).loc);
	end loop;
end;

	

	
	
	
	
	
	