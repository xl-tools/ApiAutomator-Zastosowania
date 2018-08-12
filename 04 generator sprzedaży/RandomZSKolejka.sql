if OBJECT_ID('aa.RandomZSKolejka') is not null drop procedure aa.RandomZSKolejka;
go
create procedure [aa].[RandomZSKolejka]
as
begin
if OBJECT_ID('tempdb..##Kolejka') is null create table ##Kolejka (nr int);	
insert into ##Kolejka values(1);
declare @liczba as int;
select @liczba=count(*) from ##Kolejka;
select 
	case when @liczba > 50 then 50 else @liczba end as gid,
	'aa.RandomZSDane' as procedura;
end