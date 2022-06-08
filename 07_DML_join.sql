-- 조인 : 여러 개의 테이블을 결합하여 조건에 맞는 행 검색

-- 다양한 조인 문 표기 방식 (1) 
-- where 조건 사용
-- 양쪽 테이블에 공통되는 열 이름 앞에 테이블명 표기 (모호성을 없애기 위해서)
-- 테이블명 없으면 오류 발생
select client.clientNo, clientName, bsQty
from client, bookSale
where client.clientNo = bookSale.clientNo;
-- 2개의 테이블을 조인할 경우 : 제약조건은 1개
-- 3개의 테이블을 조인할 경우 : 제약조건은 2개

-- 다양한 조인 문 표기 방식 (2) 
-- 양쪽 테이블에 공통되지는 않지만 모든 열 이름에 테이블명 붙임
-- 서버에서 찾고자 하는 열의 정확한 위치를 알려주므로 성능이향샹
select client.clientNo, client.clientName, bookSale.bsQty
from client, bookSale
where client.clientNo = bookSale.clientNo;

-- 다양한 조인 문 표기 방식 (3) 
-- 테이블명 대신 별칭(Alias) 사용
select C.client, C.clientName, BS.bsQty
from client C, bookSale BS
where C.clientNo = BS.clientNo ;

-- 다양한 조인 문 표기 방식 (4) 
-- join on 명시
select C.client, C.clientName, BS.bsQty
from bookSale BS
	join client C
    on C.clientNo = BS.clientNo;
    
-- 다양한 조인 문 표기 방식 (5) 
-- inner join on 명시 : 가장 많이 사용되는 방법으로 우리는 이 방법을 사용
select C.client, C.clientName, BS.bsQty
from bookSale BS
	inner join client C
    on C.clientNo = BS.clientNo;
    
-- 조인 예제
-- client 테이블과 bookSale 테이블 조인
-- 두 테이블의 공통으로 들어있는 값의 의미는 
-- 한번이라도 도서를 주문한 적이 있는 고객
-- 2개 테이블 모든 열 표시
select *
from client 
	inner join bookSale
    on client.clientNo = bookSale.clientNo;
    
-- 필요한 열만 추출
-- 테이블명 대신 별칭(Alias) 사용
-- 한번이라도 도서를 주문한 적이 있는 고객의 고객번호와 고객명 출력
select C.clientName, C.clientNo
from client C
inner join booksale BS
on C.clientNo = BS.clientNo;

-- 한번이라도 도서를 주문한 적이 있는 고객의 고객 번호와 고객명 출력
-- 중복되는 행은 한번만 출력
-- 고객번호 오름차순 정렬
select distinct C.clientName, C.clientNo
from client C
inner join booksale BS
on C.clientNo = BS.clientNo
order by C.clientNo asc;

select distinct C.clientName, C.clientNo
from client C
inner join booksale BS
on C.clientNo = BS.clientNo
order by C.clientName asc; -- 고객명으로 오름차순 정렬

-- 3개의 테이블 결합 : 조인 조건 2개
-- 주문된 도서에 대하여 고객명과 도서명 출력
select C.clientName, B.bookName
from booksale BS
	inner join client C on C.clientNo = BS.clientNo
    inner join book B on B.bookNo = BS.bookNo;
    
-- 도서를 주문한 고객의 고객 정보, 주문 정보, 도서 정보 출력
-- 주문번호, 주문일, 고객번호, 고객명, 도서명, 주문수량
select BS.bsNo, Bs.bsDate, C.clientNo, C.clientName, B.bookName, BS.bsQty
from booksale BS
	inner join client C on C.clientNo = BS.clientNo
    inner join book B on B.bookNo = BS.bookNo;
    
-- 고객별로 총 주문 수량 계산하여 
-- 고객명과 총 주문 수량 출력
-- 총 주문 수량 기준 내림차순 정렬
select sum(bsQty) as "총 주문 수량", C.clientName
from bookSale BS
	inner join client C on C.clientNo = BS.clientNo
    group by C.clientNo, C.clientName -- 오라클의 경우 반드시 group by 뒤에 C.clientName 있어야함 
    order by 1 desc;
    
    select sum(bsQty) as "총 주문 수량", C.clientName
from bookSale BS
	inner join client C on C.clientNo = BS.clientNo
    group by C.clientNo -- MySQL의 경우 group by 뒤에 C.clientName 없어도 됨 
    order by 1 desc;
    
-- order by 사용
-- 주문된 도서의 주문일, 고객명, 도서가격, 주문수량, 주문액 계산하여 출력
-- 주문일 오름차순 정렬
select BS.bsDate, C.clientName, B.bookPrice, Bs.bsQty, (B.bookPrice*BS.bsQty) as "주문액"
from bookSale BS
	inner join client C on C.clientNo = BS.clientNo
    inner join book B on B.bookNo = BS. bookNo
    order by BS.bsDate asc;

-- 주문액 내림차순 정렬
select BS.bsDate, C.clientName, B.bookPrice, Bs.bsQty, (B.bookPrice*BS.bsQty) as 주문액
from bookSale BS
	inner join client C on C.clientNo = BS.clientNo
    inner join book B on B.bookNo = BS. bookNo
    order by 주문액 desc;
    
-- where 절 추가 
--  2019년 ~ 현재까지 판매된 도서의 주문일, 고객명, 도서명, 도서가격, 주문수량, 주문액에 관하여 출력
select BS.bsDate, C.clientName, B.bookPrice, Bs.bsQty, (B.bookPrice*BS.bsQty) as 주문액
from bookSale BS
	inner join client C on C.clientNo = BS.clientNo
    inner join book B on B.bookNo = BS.bookNo
    where BS.bsDate >= "2019-01-01"
    order by 주문액 desc;
    
-- 조인 연습문제
-- 1. 모든 도서에 대하여 도서의 도서번호, 도서명, 출판사명 출력
select B.bookNo, B.bookName, P.pubName
from book B
inner join publisher P on B.pubNo = P.pubNo;

-- 2. ‘서울 출판사'에서 출간한 도서의 도서명, 저자명, 출판사명 출력 (조건에 출판사명 사용)
select B.bookName, B.bookAuthor, P.pubName
from book B
inner join publisher P on B.pubNo = p.pubNo
where P.pubName = '서울 출판사';

-- 3. ＇정보출판사'에서 출간한 도서 중 판매된 도서의 도서명 출력 (중복된 경우 한 번만 출력) (조건에 출판사명 사용)
SELECT DISTINCT B.bookName
FROM book B
	INNER JOIN booksale BS ON BS.bookNo = B.bookNo
	INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '정보출판사';

-- 4. 도서가격이 30,000원 이상인 도서를 주문한 고객의 고객명, 도서명, 도서가격, 주문수량 출력
SELECT C.clientName, B.bookName, B.bookPrice, BS.bsQty
FROM booksale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
	INNER JOIN book B ON B.bookNo = BS.bookNo
WHERE B.bookPrice >= 30000;

-- 5. '안드로이드 프로그래밍' 도서를 구매한 고객에 대하여 도서명, 고객명, 성별, 주소 출력 (고객명으로 오름차순 정렬)
SELECT B.bookName, C.clientName, C.clientGender, C.clientAddress
FROM booksale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
	INNER JOIN book B ON B.bookNo = BS.bookNo
WHERE B.bookName = '안드로이드 프로그래밍'
ORDER BY C.clientName;

-- 6. ‘도서출판 강남'에서 출간된 도서 중 판매된 도서에 대하여 ‘총 매출액’ 출력
SELECT SUM(B.bookPrice * BS.bsQty) AS '총 매출액'
FROM book B
	INNER JOIN publisher P ON P.pubNo = B.pubNo
	INNER JOIN booksale BS ON B.bookNo = BS.bookNo
WHERE P.pubName = '도서출판 강남';

-- 7. ‘서울 출판사'에서 출간된 도서에 대하여 판매일, 출판사명, 도서명, 도서가격, 주문수량, 주문액 출력
SELECT BS.bsDate, P.pubName, B.bookName, B.bookPrice, BS.bsQty, 
       B.bookPrice * BS.bsQty AS '주문액'
FROM book B
	INNER JOIN publisher P ON P.pubNo = B.pubNo
	INNER JOIN booksale BS ON B.bookNo = BS.bookNo
WHERE P.pubName = '서울 출판사';

-- 8. 판매된 도서에 대하여 도서별로 도서번호, 도서명, 총 주문 수량 출력
SELECT B.bookNo, B.bookName, SUM(BS.bsQty) AS "총 주문 수량"
FROM book B
	INNER JOIN booksale BS ON B.bookNo = BS.bookNo
GROUP BY B.bookNo;

-- 9. 판매된 도서에 대하여 고객별로 고객명, 총구매액 출력 ( 총구매액이 100,000원 이상인 경우만 해당)
select C.clientName, sum(B.bookPrice*Bs.bsQty) as '총구매액'
from booksale BS
inner join book B on B.bookNo = BS.bookNo
inner join client C on C.clientNo = BS.clientNo
group by C.clientNo
having sum(B.bookPrice*Bs.bsQty)>=100000;

-- 10. 판매된 도서 중 ＇도서출판 강남'에서 출간한 도서에 대하여 
-- 고객명, 주문일, 도서명, 주문수량, 출판사명 출력 (고객명으로 오름차순 정렬)
select C.clientName, BS.bsDate, B.bookName, BS.bsQty, P.pubName
from booksale BS
inner join book B on B.bookNo = BS.bookNo
inner join client C on C.clientNo = BS.clientNo
inner join publisher P on P.pubNo = B.pubNo
where P.pubName = "도서출판 강남"
order by C.clientName asc;

-- -----------------------------------------------------
-- 외부 조인

-- (1) 왼쪽 (left) 테이블 기준
-- 왼쪽 테이블 (client) 데이터 모두 출력
-- client에는 있지만 오른쪽 테이블 (bookSale)에 없는 값는 null로 출력
-- 의미 : 고객 중에서 한번도 구매한 적이 없는 고객은 null 로 출력

select *
from client C
	left outer join booksale BS
    on C.clientNo = BS.clientNo
order by C.clientNo;

-- 고객 중에서 한번도 구매한 적이 없는 고객 출력
select C.clientNo, C.clientName
from client C
	left outer join booksale BS
    on C.clientNo = BS.clientNo
    where Bs.bsNo is null
order by C.clientNo;

-- 도서 중에서 한번도 판매된 적이 없는 도서 출력 (도서번호, 도서명)
select B.bookName, B.BookNo
from book B
	left outer join booksale BS
    on B.bookNo = BS.bookNo
    where BS.bsNo is null
order by B.bookNo;

-- (2) 오른쪽 (right) 테이블 기준
-- 오른쪽 테이블 (booksale) 데이터 모두 출력
-- 왼쪽 테이블에서는 출력되는 고객의 의미 : 한 번이라도 주문한 적이 있는 고객
select *
from client C
	right outer join booksale BS
    on C.clientNo = BS.clientNo
order by C.clientNo;

-- 한 번이라도 주문한 적이 있는 고객의 번호, 이름 출력
-- 중복된 경우 한번만 출력
select distinct C.clientNo, C.clientName
from client C
	right outer join booksale BS
    on C.clientNo = BS.clientNo
order by C.clientNo;

-- 완전 외부 조인 (full outer join)
-- my sql에서는  full outer join 지원하지 않음
-- left join과 right join을 union해서 사용
select *
from client C
	left join booksale BS
    on C.clientNo = BS.clientNo
    
union

select *
from client C
	right join booksale BS
    on C.clientNo = BS.clientNo;
