if OBJECT_ID('aa.WydrukPZDane') is not null drop procedure aa.WydrukPZDane;
go
create procedure aa.WydrukPZDane @Gid int = 0
as
begin
select
	'XLWykonajPodanyWydruk' as _komenda,
	0 as Zrodlo,
	538 as Wydruk,
	1 as Format,
	'TrN_GIDTyp=1489 AND TrN_GIDNumer=' + cast(trn_gidnumer as varchar(10)) as FiltrSQL,
	'e:\wydruki\' + replace(cdn.nazwaobiektu(1489,trn_gidnumer,0,2),'/','_')  + '.pdf' as PlikDocelowy,
	2 as Urzadzenie,
	1 as DrukujDoPliku
from
	cdn.TraNag
where
	trn_gidtyp = 1489
end