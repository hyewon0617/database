/* 문제01) 일별 누적 접속자 통계 구하기

사용자접속기록을 관리하는 업무중에서 사용자가 접속할 때 마다 기록이 된다고
했을 경우에 동일 사용자가 하루에 몇번 접속했는지에 대한 통계자료를 작성한다.

1. 접속건수 : 접속기록은 일별로 카운트한다.
2. 접속자수 : 동일유저는 한번만 카운트
3. 누적접속건수 : 현재일까지의 누적 건수
4. 누적접속자수 : 현재일까지의 누적 접속자 수

결과 

DT                 접속건수   접속자수 누적접속건수 누적접속자수
---------------- ---------- ---------- ------------ ------------
20150801                  3          2            3            2
20150802                  3          2            6            2
20150803                  1          1            7            3
20150804                  2          2            9            4
20150805                  1          1           10            4

*/
-- 가상(임시)테이블
with temp as (
select '20190801' dt, 1 id from dual union all
select '20190801' dt, 2 id from dual union all
select '20190801' dt, 1 id from dual union all
select '20190802' dt, 1 id from dual union all
select '20190802' dt, 2 id from dual union all
select '20190802' dt, 2 id from dual union all
select '20190803' dt, 3 id from dual union all
select '20190804' dt, 4 id from dual union all
select '20190804' dt, 1 id from dual union all
select '20190805' dt, 1 id from dual
)
select dt, count(*) 접속건수, sum(dt), sum(id), sum(dt) over(order by dt) from temp
GROUP BY dt
ORDER BY dt

select dt
     , count(*) 접속건수
		 , count(distinct id) 접속자수
		 , sum(count(*)) over (order by dt) 누적접속건수
		 , sum(count(y)) over (order by dt) 누적접속자수
  from (select dt
	           , id
						 , decode(row_number() over(partition by id order by dt), 1, 1) y
	        from temp) 
 group by dt
 order by dt


/* 문제02) 

다음과 같이 테이블이 3개가 있다.
1. 스터디 학생 테이블은 s_id가 PK.
2. 스터디 과목 테이블은 c_id가 PK.
3. 스터디마스터테이블은 학생과 과목 테이블을 각각 참조하며 
PK는 s_id, c_id, chasu 3개 항목의 조합dl다.


쿼리 작성 조건.
1. 학생별로 2개행씩(스터티과목수만큼) 조회되어야 한다.
2. 스터디 차수별로 가입여부에 '○'표로 표시합니다. 3차까지 표시.
3. 과목별 참여건수를 표시.
4. 서브쿼리 없이 작성.

결과

ID  성명    스터디   1차  2차 3차 참여횟수
---------------------------------------------
001	기민용	Database	○		  ○	2
		        Java		      ○	  	1
002	이현석	Database	○	○	○	3
		        Java				          0
003	김정식	Database				      0
		        Java	    ○	○		  2
004	강정식	Database	○			    1
		        Java				          0

*/
WITH student AS
(
    SELECT '001' s_id, '기민용' s_nm FROM dual
    UNION ALL SELECT '002', '이현석' FROM dual
    UNION ALL SELECT '003', '김정식' FROM dual
    UNION ALL SELECT '004', '강정식' FROM dual
)
, course AS
(
    SELECT '001' c_id, 'Database' c_nm FROM dual
    UNION ALL SELECT '002', 'Java' FROM dual
)
, study AS
(
    SELECT '001' s_id, '001' c_id, 1 chasu FROM dual
    UNION ALL SELECT '001', '001', 3 FROM dual
    UNION ALL SELECT '001', '002', 2 FROM dual
    UNION ALL SELECT '002', '001', 1 FROM dual
    UNION ALL SELECT '002', '001', 2 FROM dual
    UNION ALL SELECT '002', '001', 3 FROM dual
    UNION ALL SELECT '003', '002', 1 FROM dual
    UNION ALL SELECT '003', '002', 2 FROM dual
    UNION ALL SELECT '004', '001', 1 FROM dual
)
select *
  from student
	   , course
		 , study;
결과SQL작성 : CROSS JOIN



select std.s_id, std.s_nm, std.c_id, std.c_nm
     , min(case when stu.chasu = 1 then '○' end) as "1차"
     , min(case when stu.chasu = 2 then '○' end) as "2차"
     , min(case when stu.chasu = 3 then '○' end) as "3차"
		 , count(stu.s_id) as "참여횟수"
  from (select std.s_id, std.s_nm, crs.c_id, crs.c_nm 
	       from student std, course crs) std
	   , study stu
 where std.s_id = stu.s_id(+)
   and std.c_id = stu.c_id(+)
 group by std.s_id, std.s_nm, std.c_id, std.c_nm
 order by std.s_id, std.c_id;
/* 1. join
select std.s_id
     , std.s_nm
		 , crs.c_id
		 , crs.c_nm
		 , stu.chasu
  from student std, course crs, study stu
 where std.s_id = stu.s_id
   and crs.c_id = stu.c_id
 order by std.s_id, crs.c_id, stu.chasu;
*/
/* 2. 행을 열로 변경
select std.s_id, std.s_nm, crs.c_id, crs.c_nm
     , min(case when stu.chasu = 1 then '○' end) as "1차"
     , min(case when stu.chasu = 2 then '○' end) as "2차"
     , min(case when stu.chasu = 3 then '○' end) as "3차"
		 , count(stu.s_id) as "참여횟수"
  from student std, course crs, study stu
 where std.s_id = stu.s_id
   and crs.c_id = stu.c_id
 group by std.s_id, std.s_nm, crs.c_id, crs.c_nm
 order by std.s_id, crs.c_id;
*/
-- 3. 최종
-- 없는 스터디과목(Java)나와야 된다. outer join 이용
-- 인라인뷰를 사용
--
select std.s_id, std.s_nm, std.c_id, std.c_nm
     , min(case when stu.chasu = 1 then '○' end) as "1차"
     , min(case when stu.chasu = 2 then '○' end) as "2차"
     , min(case when stu.chasu = 3 then '○' end) as "3차"
		 , count(stu.s_id) as "참여횟수"
  from (select std.s_id, std.s_nm, crs.c_id, crs.c_nm 
	       from student std, course crs) std
	   , study stu
 where std.s_id = stu.s_id(+)
   and std.c_id = stu.c_id(+)
 group by std.s_id, std.s_nm, std.c_id, std.c_nm
 order by std.s_id, std.c_id;




------------------------------------------------------





SELECT dt
     , COUNT(*) 접속건수
     , COUNT(DISTINCT id) 접속자수
     , SUM(COUNT(*)) OVER(ORDER BY dt) 누적접속건수
     , SUM(COUNT(x)) OVER(ORDER BY dt) 누적접속자수
  FROM (SELECT dt, id
             , DECODE(
               ROW_NUMBER() OVER(
               PARTITION BY id ORDER BY dt)
               , 1, 1) x
          FROM t
        )
 GROUP BY dt
 ORDER BY dt
;


