show tables;

drop table usertbl;
create table user (
	idx 		int not null auto_increment,
	mid			varchar(20) not null,
	name		varchar(20) not null,
	age 		int default 20,
	address		varchar(50),
	primary key(idx)
);

desc user;
select * from user;
select count(*) as totRecCnt from user;
select * from user order by idx desc limit 0, 3;