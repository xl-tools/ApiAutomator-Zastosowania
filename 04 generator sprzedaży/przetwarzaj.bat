@echo off
chcp 1250
aa.exe --zrodlo=p:aa.RandomZSKolejka --dbUser=sa  --dbPass=aaaaaa  --cdnName=3lance  --cdnLogin=ADMIN  --cdnPass=""  --dbString="DRIVER={SQL Server};Server=cdnsrv\ex14;Database=ERPXL_3lance"   --logInfo="*.*=false;*.info=true" --logFile=RandomZS.log
