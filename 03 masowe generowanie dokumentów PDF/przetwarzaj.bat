@echo off
chcp 1250
aa.exe --zrodlo=n:1,aa.WydrukPZDane ^
	--dbUser=sa ^
	--dbPass=aaaaaa ^
	--cdnName=3lance ^
	--cdnLogin=ADMIN ^
	--cdnPass="" ^
	--logInfo="*.debug=false;*.info=true" ^
	--dbString="DRIVER={SQL Server};Server=cdnsrv\ex14;Database=ERPXL_3lance" 
