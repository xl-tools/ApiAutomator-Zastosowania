@echo off
chcp 1250
aa.exe --zrodlo=n:1,aa.RandomZZDane --dbUser=sa  --dbPass=aaaaaa  --cdnName=3lance  --cdnLogin=ADMIN  --cdnPass=""  --dbString="DRIVER={SQL Server};Server=cdnsrv\ex14;Database=ERPXL_3lance"  --logFile=test.log --logInfo="*.*=false;*.info=true"
