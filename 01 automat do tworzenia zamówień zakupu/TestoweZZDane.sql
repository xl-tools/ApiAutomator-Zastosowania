create procedure [aa].[TestoweZZDane] @Gid int = 0
as
begin

declare @MagNr int; -- losowy magazyn - zmienna
declare @KliNr int; -- losowy klient - zmienna

select	top 1 @MagNr=mag_gidnumer from cdn.magazyny order by newid();-- losowy magazyn
select	top 1 @KliNr=knt_gidnumer from cdn.kntkarty order by newid();-- losowy magazyn

	-- **************** nagłówek ****************	
select
	top 1
	'XLNowyDokumentZam' as _komenda, /* _komenda API którą trzeba wywołać */
	5 as Typ, -- 5 ZZ, 6 ZS ...
	knt_gidtyp as KntTyp,
	knt_gidnumer as KntNumer,
	mag_kod as Magazyn
from
	cdn.kntkarty
inner join -- połączenie z magazynem, ale bez relacji, tylko pobieramy kod potrzebny dla funkxji XLDodajPozycjeZam
	cdn.magazyny 
on
	knt_gidnumer=@KliNr and
	mag_gidnumer=@MagNr
	
	-- **************** pozycje ****************
select
	top 2
	'XLDodajPozycjeZam' as _komenda, /* _komenda API którą trzeba wywołać */
	format(abs(checksum(newid()) % 240) + 12,'G','pl-PL') as Ilosc, /* ilość w formacie tekstowym np. 1.52 */
	format(TwC_Wartosc,'G','pl-PL') as CenaOferowana, /* centa jako tekst - wymagane przez API */
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
	twc_wartosc > 0 -- pobieraj tylko tewary, które mają przypisaną cenę
order by
	newid()

	-- **************** zamknięcie ****************
select
	'XLZamknijDokumentZam' as _komenda, /* _komenda API którą trzeba wywołać */
	2 as TrybZamkniecia -- 0 zamknięcie, 1 usunięcie, 2 potwierdzenie ...
end