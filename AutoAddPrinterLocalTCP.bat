@ECHO OFF


REM Adds a printer port with name "IP_PRINTERIP" and IP address of "PRINTERIP"
Cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnport.vbs" -a -r 192.168.11.6 -h 192.168.11.6 -o raw -n 9100

REM Installs the printer driver, first getting the printer model and .inf file, then -h for the path to the .dll
Cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prndrvr.vbs" -a -m "HP LaserJet P2035n" -i "\\192.168.11.250\Source\Driver\Printer\ljP2035-gdi-pnp-win64-en\HP2030.INF" -h "\\192.168.11.250\Source\Driver\Printer\ljP2035-gdi-pnp-win64-en"

REM Finally giving the printer a name of "PHS - Online", linking the model and printer port
Cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnmngr.vbs" -a -p "HP_P2035n" -m "HP LaserJet P2035n" -r 192.168.11.6

@pause
