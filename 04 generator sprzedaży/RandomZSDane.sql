if OBJECT_ID('aa.RandomZSDane') is not null drop procedure aa.RandomZSDane;
go
create procedure [aa].[RandomZSDane] @Gid int = 0
as
begin

declare @MagNr int; -- losowy magazyn
declare @KliNr int; -- losowy klient
declare @RndNr int; -- losowa ilość pozycji

select	top 1 @MagNr=mag_gidnumer from cdn.magazyny order by newid();
select	top 1 @KliNr=knt_gidnumer from cdn.kntkarty order by newid();
set @RndNr = abs(checksum(newid()) % 50) + 1

	-- **************** nagłówek ****************	
select
	top 1
	'XLNowyDokumentZam' as _komenda, /* _komenda API którą trzeba wywołać */
	knt_akronim as _log, /* informacja (tu kod klienta) jaką pokazujemy w logu aa */
	6 as Typ,
	knt_gidtyp as KntTyp,
	knt_gidnumer as KntNumer,
	mag_kod as Magazyn
from
	cdn.kntkarty
inner join
	cdn.magazyny
on
	knt_gidnumer=@KliNr and
	mag_gidnumer=@MagNr
	-- **************** pozycje ****************
select
	top (@RndNr)
	'XLDodajPozycjeZam' as _komenda, /* _komenda API którą trzeba wywołać */
	twr_kod as _log, /* informacja (tu kod towaru) jaką pokazujemy w logu aa */
	format(abs(checksum(newid()) % 240) + 12,'G','pl-PL') as Ilosc,
	format(TwC_Wartosc,'G','pl-PL') as CenaKatalogowa,
	twr_gidtyp as TwrTyp,
	twr_gidnumer as TwrNumer
from
	cdn.twrkarty
inner join
	cdn.twrceny
on
	TwC_TwrNumer = Twr_GIDNumer
where
	twc_twrlp=1 and
	twc_wartosc > 0
order by
	newid()
	-- **************** zamknięcie ****************
select
	'XLZamknijDokumentZam' as _komenda, /* _komenda API którą trzeba wywołać */
	2 as TrybZamkniecia
end
