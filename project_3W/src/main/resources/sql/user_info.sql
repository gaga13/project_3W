--유저정보
create table user_info(
email			varchar2(100)	primary key,	--이메일(id로 사용)
password		varchar2(100)	not null,		--비밀번호
identification	varchar2(20)	default 'N',	--본인인증 이메일 확인 여부(Y/N)
username		varchar2(100)	,				--이름
userbirthdate	date							--생년월일
);
