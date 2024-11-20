@echo off

mkdir ..\..\A52sxq-Drivers-Release
del ..\..\A52sxq-Drivers-Release\A52sxq-Drivers-Desktop.7z

echo @echo off > ..\OnlineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> ..\OnlineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> ..\OnlineUpdater.cmd
echo .\tools\DriverUpdater\%%PROCESSOR_ARCHITECTURE%%\DriverUpdater.exe -r . -d .\definitions\Desktop\ARM64\Internal\A52sxq.xml >> ..\OnlineUpdater.cmd
echo pause >> ..\OnlineUpdater.cmd

echo @echo off > ..\OfflineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> ..\OfflineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> ..\OfflineUpdater.cmd
echo set /P DrivePath=Enter Drive letter ^^^(with the colon!^^^) of the connected device in mass storage mode ^^^(e.g. D:^^^): >> ..\OfflineUpdater.cmd
echo .\tools\DriverUpdater\%%PROCESSOR_ARCHITECTURE%%\DriverUpdater.exe -r . -d .\definitions\Desktop\ARM64\Internal\A52sxq.xml -p %%DrivePath%% >> ..\OfflineUpdater.cmd
echo pause >> ..\OfflineUpdater.cmd

echo components\Devices\A52sxq >> filelist_a52sxq.txt
echo components\QC7325 >> filelist_a52sxq.txt
echo definitions\Desktop\ARM64\Internal\A52sxq.xml >> filelist_a52sxq.txt
echo tools\DriverUpdater >> filelist_a52sxq.txt
echo LICENSE.md >> filelist_a52sxq.txt
echo OfflineUpdater.cmd >> filelist_a52sxq.txt
echo OnlineUpdater.cmd >> filelist_a52sxq.txt
echo README.md >> filelist_a52sxq.txt

cd ..
"tools\7z.exe" a -t7z ..\A52sxq-Drivers-Release\A52sxq-Drivers-Desktop.7z @tools\filelist_a52sxq.txt -scsWIN
cd tools

del ..\OfflineUpdater.cmd
del ..\OnlineUpdater.cmd
del filelist_a52sxq.txt