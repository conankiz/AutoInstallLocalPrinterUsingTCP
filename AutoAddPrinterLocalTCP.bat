<!-- : Begin batch script
@echo off

REM -------------------------------------------------------------------
REM
REM                        AutoInstallPrinterLocalTCP.bat
REM
REM AutoInstallPrinterLocalTCP // conankiz (07-02-2021)
REM -------------------------------------------------------------------
REM Options:
REM   -log        = redirect display output to the file autoupdate.log
REM   -taskadd    = add autorun of autoupdate.bat on startup in schedule task
REM   -taskremove = remove autorun of autoupdate.bat on startup in schedule task
REM
REM Info:
REM   The first to delete the printer if you're trying to add a printer with the same name.
REM   Adds a printer port with name "IP_PRINTERIP" and IP address of "PRINTERIP"
REM   Installs the printer driver, first getting the printer model
REM   Finally giving the printer a name of "Printer Name", linking the model and printer port
REM

set Printingvbs=C:\Windows\System32\Printing_Admin_Scripts\en-US
set DriversFolder="\\192.168.11.250\Source\Driver\Printer\ljP2035-gdi-pnp-win64-en"
set Ip_Printer=192.168.11.6
set NamePrinter="HP LaserJet P2035n"
set NamePrinterInstall="HP_P2035n"
set PrinterModel="HP2030.INF"

echo [*] Step 1:
echo The first Prnmngr.vbs is to delete the printer if you're trying to add a printer with the same name
cscript %Printingvbs%\Prnmngr.vbs -d -p %NamePrinterInstall%

echo [*] Step 2:
echo Adds a printer port with name "IP_PRINTERIP" and IP address of "PRINTERIP"
Cscript %Printingvbs%\Prnport.vbs -a -r %Ip_Printer% -h %Ip_Printer% -o raw -n 9100

echo [*] Step 3:
echo Installs the printer driver, first getting the printer model and .inf file, then -h for the path to the .dll
Cscript %Printingvbs%\Prndrvr.vbs -a -m %NamePrinter% -i %DriversFolder%\%PrinterModel% -h %DriversFolder%

echo [*]  Step4
echo Finally giving the printer a name of "PHS - Online", linking the model and printer port
REM Cscript %Printingvbs%\Prnmngr.vbs -a -p %NamePrintInstall% -m %NamePrinter% -r %Ip_Printer%
Cscript %Printingvbs%\Prnmngr.vbs -a -p %NamePrinterInstall% -m %NamePrinter% -r %Ip_Printer%

echo +++++ Finish install %NamePrinterInstall% +++++
@pause
