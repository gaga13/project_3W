--스케쥴 
create table schedule( 
email			varchar2(100),					--이메일
snum			number 			primary key,	--스케쥴 번호
scontent		varchar2(1000) 	not null,			--스케쥴 내용
slocation		varchar2(1000),						--스케쥴 위치
startdate		date			default sysdate,		--스케쥴 시작 날짜
enddate			date			default sysdate,		--스케쥴 끝 날짜

foreign key(email) references user_info(email)
);

--스케쥴 번호 시퀀스
create sequence snum_seq;