--유저정보
create table user_info(
email			varchar2(100)	primary key,	--이메일(id로 사용)
password		varchar2(100)	not null,		--비밀번호
identification	varchar2(20)	default 'N',	--본인인증 이메일 확인 여부(Y/N)
username		varchar2(100)	,				--이름
userbirthdate	date			,				--생년월일
twitterId  		varchar2(10)		default 'N',     --트위터 계정 연결 여부(Y/N)
savedImage      blob
);

--twitterId(트위터 계정 연결여부) 칼럼 추가!
--아래 sql문 복붙해서 칼럼 추가하삼
alter table user_info add (twitterId varchar2(10));  
alter table user_info modify(twitterId default 'N');
commit;