create procedure aa.RandomZZKolejka
as
begin
if OBJECT_ID('tempdb..##Kolejka') is null create table ##Kolejka (nr int);	
insert into ##Kolejka values(1);
declare @liczba as int;
select @liczba=count(*) from ##Kolejka;
select 
	case when @liczba > 25 then 25 else @liczba end as gid,
	'aa.RandomZZDane' as procedura;
end
