if OBJECT_ID('aa.log') is not null drop table aa.log;
go
create table aa.Log (
	aa_res int not null default 0,
	aa_flagi int not null default 0,
	aa_czas int not null default 0,
	aa_komenda varchar(40),
	aa_proba int,
	aa_sesja int,
	aa_opis varchar(100),
	aa_login varchar(20)
);	
