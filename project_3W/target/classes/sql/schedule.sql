--스케쥴 
create table schedule( 
email			varchar2(100),						--이메일
snum			number 			primary key,		--스케쥴 번호
scontent		varchar2(1000) 	not null,			--스케쥴 내용
slocation		varchar2(1000),						--스케쥴 위치
startdate		date			default sysdate,	--스케쥴 시작 날짜
enddate			date			default sysdate,	--스케쥴 끝 날짜
slatitude 		varchar2(100), 						--스케쥴 위치에 대한 위도
slongitude		varchar2(100),						--스케쥴 위치에 대한 경도
subpath                varchar2(100),
subroute            varchar2(4000),
foreign key(email) references user_info(email)
);

--스케쥴 번호 시퀀스
create sequence snum_seq;
--slatitude, slongitude 칼럼 추가
alter table schedule add (slatitude varchar2(100));
alter table schedule add (slongitude varchar2(100));
alter table schedule add (subpath varchar2(100));
alter table schedule add (subroute varchar2(4000));
commit;