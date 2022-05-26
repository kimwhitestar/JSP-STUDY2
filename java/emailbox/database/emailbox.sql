show tables;

create table emailbox (
	idx		int not null auto_increment primary key, /*메세지고유번호*/
	title	varchar(100) not null, 			/*메세지제목*/
	content text	not null, 					/*메세지내용*/
	sendId varchar(20) not null, 			/*보내는사람 아이디*/
	sendSw char(1) not null, /*보낸메세지(s), 휴지통(g), 휴지통삭제(x) 표시*/
	sendDate datetime default now(), /*메세지 보낸날짜*/  
	receiveId varchar(20) not null, /*받는사람 아이디*/
	receiveSw char(1) not null, /*받은메세지(n), 읽은메세지(r), 휴지통(g), 휴지통삭제(x) 표시*/
	receiveDate datetime default now() /*메세지 받은날짜*/  
);
desc emailbox;

select * from emailbox;
insert into emailbox values ( default, '안녕? 주말에 뭐해?', '주말에 뭐할 예정?', 'kim1', 's', default, 'kim2', 'r', default );
insert into emailbox values ( default, '답장! 방가방가~', '주말에 바빠 다음에 봐', 'kim2', 's', default, 'kim1', 'r', default );
insert into emailbox values ( default, '답장! 그래? 수고해!', '다음에 봐', 'kim1', 's', default, 'kim2', 'n', default );
insert into emailbox values ( default, '오랫만이야', '물어볼게 있는데...', 'kim2', 's', default, 'kim1', 'r', default );
insert into emailbox values ( default, '답장! 뭔데?', '무슨 말? 물어봐?', 'kim1', 's', default, 'kim2', 'n', default );

