show tables;

create table usertbl (
	idx 		int not null auto_increment,
	mid			varchar(20) not null,
	name		varchar(20) not null,
	age 		int default 20,
	address		varchar(50),
	primary key(idx)
);

desc user;