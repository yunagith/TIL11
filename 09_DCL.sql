
use mysql;

-- 사용자 계정 조회
select * from user;

-- 사용자 계정 생성
-- create user 계정@호스트 identified by 비밀번호;
-- 호스트
	-- localhost : 로컬에서 접근 가능
    -- 192.168.172.1 : 특정 IP에서 접근 가능
    -- '%' : 어디에서나 접근 가능
    
-- 계정 생성
create user newuser1@'%' identified by '1111';

-- 계정명에 따옴표 사용 가능 : 'newuser2'
create user 'newuser2'@'%' identified by '1111';
create user newuser3@'%' identified by '1111';

-- newuser1으로 connection 생성해서 서버에 연결되는지 확인
-- 스키마 접근 불가 : 아무 권한도 없기 때문에

-- 비밀번호 변경
-- set password for '계정명'@'%' = '새 비밀번호';
set password for 'newuser1'@'%' = '1234';
-- 서버 연결 해본다 (newconn) : 기존 비밀번호 1111로 하면 안되고 
-- 새 비밀번호 1234로 하면 접속 성공

-- 계정 삭제 : drop user '계정명'@'호스트' ;
drop user 'newuser1'@'%' ;

-- 권한 조회
show grants for newuser2;
show grants for dbuser;

-- 권한 부여 : grant 권한 on 데이터베이스. 테이블 to 계정@호스트;
-- 모든 권한 부여 : grant all privileges on *.* to 계정@호스트;
-- 특정 DB의 모든 테이블에 특정 권한 부여
	-- grant select, insert, update, delete on 특정 DB.* to 계정@호스트;
    
-- newuser2에게 모든 권한 부여
grant all privileges on *.* to newuser2@'%';
show grants for newuser2;
-- newuser2로 접속 : 모든 스키마/ 테이블 접근 가능

-- 권한 삭제 : revoke  권한 on 데이터베이스.테이블 to 계정@호스트;
-- 모든 권한 삭제 : revoke all privileges on *.* from 계정@호스트;
-- 특정 DB의 모든 테이블에 대한 특정 권한 삭제
	-- revoke select, insert, update, delete on 특정DB.* from 계정@호스트;
-- 특정 DB의 모든 테이블에 대한 모든 권한 삭제
	-- revoke all privileges on 특정DB.* from 계정@호스트;
    
-- select 권한 삭제
revoke select on *.* from newuser2@'%';
show grants for newuser2;