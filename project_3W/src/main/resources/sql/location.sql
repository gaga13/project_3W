create table location(
snum			number ,			--
startlocaion	varchar2(1000),	
endlocation		varchar2(1000),	
route			varchar2(1000),	
locationdate	date,
foreign key(snum) references schedule(snum)
);
