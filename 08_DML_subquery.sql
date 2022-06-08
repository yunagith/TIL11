-- 서브 쿼리

-- 고객 호날두의 주문 수향 조회
--  1. client 테이블에서 고객명 '호날두'의 clientNo를 찾아서
-- 2. booksale 테이블에서 이 clientNo에 해당되는 주문에 대해
-- 주문일, 주문수량 출력

select bsDate, bsQty
from booksale
where clientNo =(select clientNo
				from client
				where clientName = '호날두');
                
-- 고객 '호날두'가 주문한 총 주문수량 출력
select sum(bsQty) as "총 주문수량"
from booksale
where clientNo  = (select clientNo
					from client
					where clientName = '호날두');
-- = 사용 : 서브쿼리 결과가 단일행으로 처리 : 호날두가 1명만 존재한다고 가정
-- 만약 여러명 존재할 경우 =을 사용하면 오류 발생
                    
-- 또는 in 사용
select sum(bsQty) as "총 주문수량"
from booksale
where clientNo  in (select clientNo
					from client
					where clientName = '호날두');
-- in 사용 : 서브쿼리 결과가 다중행으로 처리 : 호날두가 여러명 존재한다고 가정
-- 1명만 존재해도 오류 없음
-- 따라서 서브쿼리 결과가 다중행일지 단일행일지 모를때 사용 가능
                    
-- 가장 비싼 도서의 도서명과 가격 출력
-- max(bookPrice)
-- 1. max() r가격을 찾아서
-- 2. 이 가격에 해당되는 도서의 도서명과 가격 출력
select bookName, bookPrice
from book
where bookPrice = (select max(bookPrice)
						from book);
                        
-- 단일 행 서브 쿼리 예 : 비교 연산자 사용
-- 1. 도서의 평균 가격보다 비싼 도서에 대해서
-- 2. 도서명, 가격 출력
select bookName, bookPrice
from book
where bookprice >(select avg(bookprice)
					from book);
-- 참고 : 평균 도서 가격
select round(avg(bookprice)) from book; -- 26,400

-- 단일행과 다중행의 의미 : 서브쿼리 결과가 단일행(1행)이냐 다중행이냐

-- 다중 행 서브 쿼리 (in/ not in)
-- 도서를 구매한 적이 있는 고객의 고객번호, 고객명 출력
-- 도서를 구매한 적이 있는 고객'의 의미 : booksale 테이블에 존재하는 고객
-- 1. booksale 테이블에서 고객번호 찾아서 
-- 2. client 테이블에서 찾은 고객번호에 해당되는 고객을 찾아
-- 고객번호, 고객명 출력
select clientNo, clientName
from client
where clientNo in (select clientNo
				  from booksale);
-- 서브쿼리 결과가 다중행 : 구매 고객이 여러 명 존재하기 때문에 

-- 한 번도 도서를 주문한적이 없는 고객의 고객번호, 고객명 출력
select clientNo, clientName
from client
where clientNo not in (select clientNo
				  from booksale);

-- 중첩 서브 쿼리
-- 도서명이 '안드로이드 프로그래밍'인 도서를 구매한 고객의 고객명 출력
-- 1. book 테이블에서 '안드로이드 프로그래밍'의 bookNo 찾아서
-- 2. booksale 테이블에서 이 bookNo 해당되는 도서를 구매한 clientNo 찾아서
-- 3. client 테이블에서 이 clientNo에 해당되는 고객명 찾아서 출력
select clientName
from client
where clientNo in (select clientNo
				from booksale
                where bookNo 
                = (select bookNo
				from book 
				where bookName='안드로이드 프로그래밍'));
                
-- 다중 행 서브 쿼리 (exists / not exists)
-- 도서를 구매한 적이 있는 고객
-- 1. booksale 테이블에 조건에 해당되는 행이 존재하면 참 반환
-- 2. client 테이블에서 이 clientNo에 해당되는 고객의
-- 고객번호, 고객명 출력
-- in 연산자 사용했을 때와 동일한 결과
select clientNo, clientName
from client
where exists (select clientNo
			from booksale
            where client.clientNo = booksale.clientNo);
            
-- 한번도 주문한적이 없는 고객의 고객번호, 고객명 출력
-- 서브 쿼리에서 조건에 해당되는 행이 없으면 true 반환
select clientNo, clientName
from client
where not exists (select clientNo
			from booksale
            where client.clientNo = booksale.clientNo);


-- null인 경우 in과  exist 차이
-- clientHobby에 null 포함되어 있음
select clientHobby from client;

-- exists : 서브쿼리 결과에 null 값 포함
-- null 값을 가진 clientHobby도 포함하여 모든 client 출력
-- null과 공백 다 포함 : 9
select clientNo
from client
where exists (select clientHobby
			from client);

-- in : 서브 쿼리 결과에 null 값 포함되지 않음
-- null 값을 갖지 않는 client만 출력
-- null 값은 제외, 공백은 포함
select clientNo
from client
where clientHobby in (select clientHobby
			from client);

-- all
-- 검색 조건이 서브 쿼리의 결과의 모든 값에 만족하면 참이 되는 연산자
-- 2번 고객이 주문한 도서의 최고 주문수량보다 더 많은 도서를 구입한 고객의
-- 고객번호, 주문번호, 주문수량 출력
select clientNo, bsNo, bsQty
from bookSale
where bsQty > all (select bsQty
					from booksale
                    where clientNo = '2');

select bsQty from booksale where clientNo = '2'

-- any 연산자
-- 2번 고객보다 한 번이라도 더 많은 주문을 한 적이 있는 고객의
-- 고객번호, 주문번호, 주문수향 출력
-- (최소 한번이라도 크면 됨)
select clientNo, bsNo, bsQty
from bookSale
where bsQty > any (select bsQty
					from booksale
                    where clientNo = '2');
                    
-- 2번 고객 자신은 제외
select clientNo, bsNo, bsQty
from bookSale
where clientNo !='2' and bsQty > any (select bsQty
					from booksale
                    where clientNo = '2');

-- 서브쿼리 연습문제
-- 1. 호날두(고객명)가 주문한 도서의 총 구매량 출력
select sum(bsQty) as "총 구매량"
from booksale
where clientNo  in (select clientNo
					from client
					where clientName = '호날두');

-- 2. ‘정보출판사’에서 출간한 도서를 구매한 적이 있는 고객명 출력
select clientName
from client
where clientNo in (select clientNo
				from booksale
                where bookNo in (select bookNo
								from book
								where pubNo in (select pubNo
												from publisher 
												where pubName='정보출판사')));
                
-- 3. 베컴이 주문한 도서의 최고 주문수량 보다 더 많은 도서를 구매한 고객명 출력
select clientName
from client
where clientNo in (select clientNo
				from bookSale
				where bsQty > all (select max(bsQty)
									from booksale
									where clientNo in (select clientNo
														from client
														where clientName = '베컴')));
                                        
-- 4. 서울에 거주하는 고객에게 판매한 도서의 총 판매량 출력
select sum(bsQty) as "총 판매량"
from booksale
where clientNo in (select clientNo
					from client
					where clientAddress like "%서울%");

-- -------------------------------------------------------------
-- 스칼라 서브 쿼리 예제
-- 고객별로 총 주문 수량 출력
select clientNo, (select clientName
				from client
				where client.clientNo = booksale.clientNo) as "고객명 " , sum(bsQty) as "총 주문액"
from booksale
group by clientNo;

-- 인라인 뷰 서브쿼리 예제
-- 도서 가격이 25,000원 이상인 도서에 대하여
-- 도서별로 도서명, 도서가격, 총 판매수량 , 총 판매액 출력
-- 총 판매액 기준으로 내림차순 정렬
select bookName, bookPrice, 
		sum(bsQty) as  "총판매수량",
        sum(bookPrice*bsQty) as "총판매액"
from (select bookNo, bookName, bookPrice
	from book
    where bookPrice >= 25000) book, booksale
where book.bookNo = booksale.bookNo
group by book.bookNo
order by 총판매액 desc;

-- --------------------------------------------------
-- 내장 함수

-- round (값, 자릿수)
-- 자릿수 양수 값 : 소수점 오른쪽 자릿수
-- 자릿수 음수 값 : 소수점 왼쪽 자릿수

-- 고객별 평균 주문액을 백원 단위에서 반올림하여 출력 (천원 자리까지 출력)
select clientNo, round(avg(bookprice*bsQty)) as "평균 주문액",
				 round(avg(bookprice*bsQty),0) as "1자리까지 출력",
                 round(avg(bookprice*bsQty),-1) as "10자리까지 출력",
                 round(avg(bookprice*bsQty),-2) as "100자리까지 출력",
                 round(avg(bookprice*bsQty),-3) as "1000자리까지 출력"
FROM book, bookSale
WHERE book.bookNo = bookSale.bookNo
GROUP BY clientNo;

/*
*/

-- replace() : 문자열을 치환하는 함수
-- 실제 데이터는 변경되지 않음
-- 도서명에 '안드로이드'가 포함된 도서에 대해
-- 'Android'로 변경해서 출력
select bookNo, replace(bookName, '안드로이드', 'Android') bookName, bookAuthor, bookPrice
from book
where bookName like '%안드로이드%';

select bookNo, bookName from book;

-- char_length() : 글자의 수를 반환하는 함수
-- length() : 바이트 수 반환하는 함수
-- '서울 출판사'에서 출간한 도서의 도서명과 도서명의 글자 수, 바이트 수, 출판사명 출력
select B.bookName as "도서명",
		length(B.bookName) as "바이트 수",
		char_length(B.bookName) as "길이",
        P.pubName as "출판사"
from book B
	inner join publisher P on B.pubNo = P.pubNo
where P.pubName = '서울 출판사';

-- substr() : 지정한 길이만큼의 문자열을 반환하는 함수
-- substr(전체 문자열, 시작 ,길이)

-- 저자에서 성만 출력
select substr(bookAuthor,1,1) as "성"
from book;

-- 저자에서 이름만 출력
select substr(bookAuthor,2,2) as "이름"
from book;


-- 연습문제 
-- 1. 저자 중에서 성이 '손'인 모든 저자 출력
select bookAuthor
from book
where substr(bookAuthor,1,1) = '손';

-- 2. 저자 중에서 같은 성을 사진 사람이 몇 명이나 되는지 알아보기 위해
-- 성 별로 그룹지어 인원수 출력
select substr(bookAuthor,1,1) as "성", count(bookAuthor) as "인원수"
from book
group by substr(bookAuthor,1,1);

select substr(bookAuthor,1,1) as "성", count(bookAuthor) as "인원수"
from book
group by 성;

-- 현재 날짜와 시간 출력
select date(now()), time(now()); -- 2022-06-08 -- 13:31:25

select now(); -- 2022-06-08 13:31:10

-- 연 월 일 출력
select year(curdate()), month(curdate()), dayofmonth(curdate());
select curdate();

-- 시간 분 초 마이크로초 출력
select hour(curtime()), minute(current_time()), second(current_time()), microsecond(current_time());

select datediff('2022-01-01', now()), timediff('23:23:59','12:11:10');
select datediff(now(), '2022-01-01'), timediff('23:23:59','12:11:10');

-- load_file() 함수
--  테이블 생성
create table flower (
flowerNo varchar(10) not null primary key,
flowerName varchar(30),
flowerInfo longtext,
flowerImage longblob
);

insert into flower values('f001','장미',
			load_file('C:/dbWorkspace/file/rose.txt'),
            load_file('C:/dbWorkspace/file/rose.jpg'));
            
-- secure_file_priv=”C:/dbWorkspace/file” 경로 확인
show variables like 'secure_file_priv';

create table movie (
	movieId varchar(10) not null primary key,
    movieTitle varchar(30),
    movieDirector varchar(20),
    movieStar varchar(20),
    movieScript longtext,
    movieFilm longblob
);

insert into movie values('1', '쉰들러 리스트', '스필버그', '리암니슨',
	load_file('C:/dbWorkspace/file/Schindler.txt'),
	load_file('C:/dbWorkspace/file/Schindler.mp4'));
    

-- 파일 내보내기
-- longtext 타입의 영화 대본 데이터를 텍스트 파일로 내보내기
select movieScript from movie where movieId='1'
	into outfile 'C:/dbWorkspace/file/Schindler_out.txt'; -- 안됨

select movieScript from movie where movieId='1'
	into outfile 'C:/dbWorkspace/file/Schindler_out2.txt'
    lines terminated by '\\n'; -- 줄바꿈 문자 지정
    
-- 바이너리 파일로 내보내기
select movieScript from movie where movieId='1'
	into dumpfile 'C:/dbWorkspace/file/Schindler_out.mp4';
    
-- 도서 테이블 데이터를 텍스트 파일로 내보내기
select * from book
	into outfile 'C:/dbWorkspace/file/book_out.txt';
    
select * from book
	into outfile 'C:/dbWorkspace/file/book_out2.csv';
    
-- 테이블 복사 기본 키 제약조건 복사 안 됨
-- 복사 후 기본키 제약조건 설정해야 함

-- book 테이블 전체를 new_book1 테이블로 복사
create table new_book1 as 
select * from book;

select * from new_book1;
describe new book1;

-- new_book1 테이블에 기본키 제약조건 추가 
-- PK_new_book1_bookNo
alter table new_book1 
	add constraint PK_new_book1_bookNo
	primary key(bookNo);
    
-- 테이블 복사2 : 새 테이블로 일부만 복사
-- where 절에서 조건 설정
create table new_book2 as
select * from book where bookDate >= '2020-01-01';

select*from new_book2;
describe new_book2;

-- new_book2 테이블에 기본키 제약조건 추가 
-- PK_new_book2_bookNo
alter table new_book2 
	add constraint PK_new_book2_bookNo
	primary key(bookNo);
    
-- 테이블 복사 3 : 기본 테이블로 데이터만 복사

-- (1) new_book2 테이블의 데이터 삭제하고
delete from new_book2;
select*from new_book2;

-- (2) 기존의 book 테이블에서 데이터만 new_book2 테이블로 복사
insert into new_book2 
select * from book;

-- booksale 테이블에서 새 테이블 new_booksale 테이블 생성
-- 단 주문수량이 5개 이상인 행만 복사
create table new_booksale as
select * from booksale where bsQty >= 5;

-- 기본키 제약조건 추가
alter table new_booksale 
	add constraint PK_new_booksale_bsNo
	primary key(bsNo);

select * from new_booksale;
describe new_booksale;

-- 다른 데이터베이스에 있는 테이블 복사
create table product as 
select * from sqldb2.product; -- 스키마명.테이블명

alter table product 
	add constraint PK_product_prdNo
	primary key(prdNo);

select * from product;
describe product;