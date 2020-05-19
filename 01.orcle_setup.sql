-- select * from v$nls_parameters; / 한줄 주석 처리 --
/* 여러줄 주석 */

-- A. Oracle 기본 Date 형식
-- 1. 오라클 환경변수 조회하기
select * from v$nls_parameters;

-- 2. 날짜형식변경하기
alter session set nls_date_format = 'YYYY-MM-DD';
alter session set nls_timestamp_format = 'YYYY-MM-DD HH:MI:SS';
-- 3. Oracle Date Format 변경 문법
-- alter [session/system]
-- 1) session : 현재 접속한 세션만 적용
-- 2) system  : Database환경 자체에 적용
--      .. option: scope=[both/spfile]
-- 							   -both   : 바로 적용 or 재시작 --> 오류날 가능성이 높다.
-- 								 -spfile : DB를 재시작 후에 변경
-- 4. 영구적으로 DB환경 설정하기
alter system set nls_date_format = 'YYYY-MM-DD' scope=spfile;
alter system set nls_timestamp_format = 'YYYY-MM-DD HH:MI:SS' scope=spfile;
--    상기명령을 실행한 후에 DB를 재시작해야 적용이 완료된다. (stop database, start database)
-- 5. 정상적으로 변경되었는지 확인하기
select * from v$nls_parameters;

-- B. Oracle User : 오라클에서만 사용되는 명령어
-- show user       : 현재 세션에 접속한 사용자 보기
-- conn or connect : 오라클 DB에 접속하는 명령
--   ... conn 사용자ID/비밀번호 as 접속권한
--   ... conn sys/12345 as sysdba or conn hr/hr--   ... 비밀번호없이 접속하면 비밀번호를 입력하라는 옵션이 나옴

-- 1. oracle 사용자조회
select * from dba_users;
select username, account_status, lock_date from dba_users;

-- 2. lock된 사용자를 해제하기
alter user hr account unlock; --사용자 잠금 해제하기
alter user hr identified by hr; --비번변경하기
-- user탭 가서 직접해제 가능

-- 3. 사용자권한확인하기
select * form dba_sys_privs; -- 사용자별 전체 권한을 조회
select * form dba_sys_privs where grantee= 'HR'; -- HR사용자의 권한만 조회

-- 4. 사용자 Role 확인하기
select * from dba_role_privs;
select * from dba_role_privs where grantee= 'HR';

-- C. soctt계정 생성하기
-- 1. soctt.sql : c:\oraclexe\app\oracle\11.2.0\server\rdbms\admin\scott.sql

-- 1) scott계정 생성하기
create user scott identified by tiger; -- tiger 비밀번호를 가진 scott사용자를 생성

-- 2) scott에 권한 부여하기
grant connect, resource to scott;

-- 3) scott에서 작업장소를 지정
alter user scott default tablespace users;
alter user scott temporary tablespace temp;

-- 4) table 생성하기
CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
    DNAME VARCHAR2(14) ,
    LOC VARCHAR2(13) ) ;

CREATE TABLE EMP  
   (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,  
    ENAME VARCHAR2(10),  
    JOB VARCHAR2(9),  
    MGR NUMBER(4),  
    HIREDATE DATE,  
    SAL NUMBER(7,2),  
    COMM NUMBER(7,2),  
    DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');   
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');  
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987', 'dd-mm-yyyy')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987', 'dd-mm-yyyy')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES    
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);

CREATE TABLE BONUS
    (
    ENAME VARCHAR2(10)  ,
    JOB VARCHAR2(9)  ,
    SAL NUMBER,
    COMM NUMBER
    ) ;
		
CREATE TABLE SALGRADE
      ( GRADE NUMBER,
    LOSAL NUMBER,
    HISAL NUMBER );
	
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);	
