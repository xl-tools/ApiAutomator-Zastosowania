if OBJECT_ID('aa.ZStoFSKolejka') is not null drop procedure aa.ZStoFSKolejka;
go
create procedure [aa].[ZStoFsKolejka]
as
begin
declare @Gid as int;
select
	top 1
	@Gid=zan_gidnumer
from
	cdn.zamnag
where
	zan_gidtyp=960 and /* zamówienia */
	ZaN_Stan=3 and /* potwierdzone */
	ZaN_Aktywny=0 and /* nie jest w tej chwili edytowany */
	ZaN_ZamTyp=1280 and /* ZS */
	zan_url not like 'aa start%' /* nie jest w tej chwili pobierany */
if(@Gid is not null)
	update cdn.zamnag set zan_url='aa start ' + convert(varchar(20), getdate(),120) where zan_gidnumer=@Gid;
else
	set @Gid=0;
select @Gid as gid, 'aa.ZStoFSDane' as procedura
end