IF object_ID(N'[aa].[Status]') IS NOT NULL DROP PROCEDURE [aa].[Status]
GO

CREATE procedure [aa].[Status] 
	@res int=0,
	@flagi int=0,
	@czas int=0,
	@komenda varchar(40)='',
	@proba int=0,
	@sesja int=0,
	@opis varchar(100)='' 
as
begin
if OBJECT_ID('aa.log') is null 
create table aa.Log (
	aa_res int not null default 0,
	aa_flagi int not null default 0,
	aa_czas int not null default 0,
	aa_komenda varchar(40),
	aa_proba int,
	aa_sesja int,
	aa_opis varchar(100)
);	

declare @decyzja varchar(20);
	if @komenda='XLNowyDokument'
	begin
		if @res=0 set @decyzja='Continue';		--ok - nast�pny krok
		else if @res=2 set @decyzja='NextGid';	--b��d blokowania tabel - pomi� to zam�wienie
		else if @res=61 set @decyzja='Logout';	--b��d sesji - konieczne ponowne zalogowanie
		else if @res=106 set @decyzja='Repeat';	--deadlock, spr�buj jeszcze raz
		else set @decyzja='Exit'; -- nieopisany b��d - wyjd�
	end

	else if @komenda='XLDodajPozycje'
	begin
		if @res=0 set @decyzja='Continue';		--ok - nast�pny krok
		else if @res=106 set @decyzja='Repeat';	--deadlock, powt�rz operacj�
		else set @decyzja='Continue'			--pomijamy pozycje - nast�pny krok
	end

	else if @komenda='XLZamknijDokument'
	begin
		if @res=0 set @decyzja='Continue';		--ok - nast�pny krok
		else if @res=106 set @decyzja='Repeat';	--deadlock
		else set @decyzja='Exit'				--pomijamy pozycje
	end
	
	insert into aa.Log(aa_res, aa_flagi, aa_czas, aa_komenda, aa_proba, aa_sesja, aa_opis) 
					values(@res, @flagi, @czas, @komenda, @proba, @sesja, @opis);
	select @decyzja as decyzja;
end

