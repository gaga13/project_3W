--트위터로 일정공유시 accessToken
create table user_twitter(
email 			varchar2(100), 
accToken 		blob,
foreign key(email) references user_info(email)
);