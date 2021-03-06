if OBJECT_ID('aa.ZStoFSDane') is not null drop procedure aa.ZStoFSDane;
go
create procedure [aa].[ZStoFsDane] @Gid int = 0
as
begin
select
	'XLNowyDokument' as _komenda, /* _komenda API którą trzeba wywołać */
	'aa.Status' as _status,
	cdn.nazwaobiektu(zan_gidtyp, zan_gidnumer,0,2) as _log,
	2033 as Typ,
	zan_gidtyp as ZamTyp, /* powiązanie FS z ZS */
	zan_gidnumer as ZamNumer,
	zan_gidlp as ZamLp
from
	cdn.zamnag
where
	zan_gidnumer=@Gid;

	-- **************** pozycje ****************
select
	'XLDodajPozycje' as _komenda, /* _komenda API którą trzeba wywołać */
	'aa.Status' as _status,
	zae_twrkod as _log,
	zae_gidtyp as ZamTyp, /* powiązanie pozycji FS z pozycją ZS */
	zae_gidnumer as ZamNumer,
	zae_gidlp as ZamLp
from
	cdn.zamelem
where
	zae_gidnumer=@gid

	-- **************** zamknięcie ****************
select
	'XLZamknijDokument' as _komenda, /* _komenda API którą trzeba wywołać */
	'aa.Status' as _status,
	0 as Tryb	
/* api help Tryb:
-10 – zatwierdzenie bez wydruku; 
-5 - zamknięcie dokumentu z ustalonym kosztem;
-3 - zamknięcie otwartego dokumentu;
-2 - anulowanie zatwierdzonego dokumentu;
-1 - skasowanie;
0 - zatwierdzenie;
1 - bufor;
2 - drukowanie dokumentu;
10 - zatwierdzenie i wydrukowanie dokumentu)
*/
end