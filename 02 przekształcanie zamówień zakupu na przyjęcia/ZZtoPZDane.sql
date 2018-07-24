if OBJECT_ID('aa.ZZtoPZDane') is not null drop procedure aa.ZZtoPZDane;
go
create procedure aa.ZZtoPzDane @Gid int = 0
as
begin
select
	'XLNowyDokument' as _komenda, /* _komenda API kt�r� trzeba wywo�a� */
	1489 as Typ,
	zan_gidtyp as ZamTyp, /* powi�zanie PZ z ZZ */
	zan_gidnumer as ZamNumer,
	zan_gidlp as ZamLp
from
	cdn.zamnag
where
	zan_gidnumer=@Gid;

	-- **************** pozycje ****************
select
	'XLDodajPozycje' as _komenda, /* _komenda API kt�r� trzeba wywo�a� */
	zae_gidtyp as ZamTyp, /* powi�zanie pozycji PZ z pozycj� ZZ */
	zae_gidnumer as ZamNumer,
	zae_gidlp as ZamLp
from
	cdn.zamelem
where
	zae_gidnumer=@gid

	-- **************** zamkni�cie ****************
select
	'XLZamknijDokument' as _komenda, /* _komenda API kt�r� trzeba wywo�a� */
	0 as Tryb	
/* api help Tryb:
-10 � zatwierdzenie bez wydruku; 
-5 - zamkni�cie dokumentu z ustalonym kosztem;
-3 - zamkni�cie otwartego dokumentu;
-2 - anulowanie zatwierdzonego dokumentu;
-1 - skasowanie;
0 - zatwierdzenie;
1 - bufor;
2 - drukowanie dokumentu;
10 - zatwierdzenie i wydrukowanie dokumentu)
*/
end