/*
	1. 시노님(synonym)
	
	시노님은 오라클 객체(테이블, 뷰, 시퀀스, 프로시저)에 대한 별칭(alias)를 말한다.
	실질적인 객체가 아니라 해당 객체에 대한 간접적인 접근을 하기 위해 synonym을 정의한다.
	
	2. 시노님을 사용하는 이유
	
		1) 데이터베이스에 투명성을 제공하기 위해 사용하며, 다른 유저의 객체를 참조할 때 많이 사용한다.
		2) 실무에서 다른 유저의 객체를 참조할 경우 시노님을 생성해서 사용을 하면 추후에 참조하고 있는
			 오브젝트가 이름이 변경되거나 이동할 경우에 객체를 사용하는 SPQ문을 모두다 고쳐야 되는 것이 아니라
			 시노님만 다시 정의하면 되기 때문에 매우 편리하다.
	  3) 객체의 이름이 길 경우 사용하기 편한 짧은 이름으로 정의해서 SQL코딩을 단순화할 수 있다.
		4) 또한 객체를 참조하는 사용자의 오브젝트를 감출 수 있기 때문에 이에 대한 보안을 유지할 수 있다.
			 시노님을 사용하는 유저는 참조하는 객체에 대한
			 소유자, 이름, 서버이름을 모르고 시노님 이름만 알아도 사용할 수 있다.
			 
	3. 시노님을 사용하는 경우
	
		1) 객체의 실제 이름과 소유자 그리고 위치를 감춤으로써 데이터베이스 보안을 개선하는데 사용한다.
		2) 객체의 Public access를 제공한다.
		3) remote 데이터베이스의 테이블, 뷰등에 대한 투명성을 제공한다.
		4) 데이터베이스 사용자를 위해 sql문을 단순화 할 수 있다.
		
	4. 시노님의 종류
	
		1) private synonym : 전용 시노님은 특정 사용자만 이용할 수 있다.
		2) public synonym  : 공용 시노님은 사용자 그룹이 소유하고 
			 그 데이터베이스 안에 있는 모든 사용자가 공유한다.
			 
  5. 시노님문법
	
		create [public|private] synonym 시노님이름 for 객체명(table, view...)
		
*/

-- 1. 스키마 lec502 생성 즉, 사용자 lec502, 비번은 12345

CREATE USER lec502 identified by 12345;
-- 2. 사용자에 권한 부여 : connect, resource, create view
grant connect, resource, create view, create synonym to lec502

-- 3. navicat 접속환경 설정
--   1) 접속이름 및 옵션은 lec502로 작성(scott을 참조)
lec502/localhost/xe/lec502/12345

-- lec502에 emp 접근권한 all로 부여
grant all on emp to lec502;
-- all : select / delete / update...

-- 시노님 생성
-- lec502로 사용자 변경후 실행
create synonym scott_emp for scott.emp
select * from user_synonyms

select * from scott_emp;
select * from scott.emp;




