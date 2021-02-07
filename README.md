## Script auto install local printer using TCP

### Table of contents

[I. Introduction](#Modau)

[II. Start](#batdau)
- [Step 1: Download The Script Files and Printer driver](#step1)
- [Step 2: Transfer The Files To The File Server](#step2)
- [Step 3: Delete The Port & Printer Name](#step3)
- [Step 4: Create The Printer Port](#step4)
- [Step 5: Install The Printer Driver](#step5)
- [Step 6: Tie It All Togethe](#step6)

[III.Summary](#Tongket)

===========================
<a name="Modau"></a>
## I. Introduction
First I was looking for a way to install printers by IP faster than the normal "add a printer", "add a local printer", "create a new port" and that whole time-consuming process.

There are several ways to do this, I chose to use Windows already installed printer commands and wrote scripts for each of the printers I was trying to install.

There are several ways to do this, I chose to use Windows already installed printer commands and wrote scripts for each of the printers I was trying to install.
<a name="batdau"></a>
## II. Start
- File server: IP: 192.168.11.250 to share driver
- Windows client : install Printer on this machine
- HP P2035n : IP 192.168.11.6
<a name="step1"></a>
### Step 1: Download The Script Files and Printer driver:
(Repeating what I referenced in my NOTES above)

a. Download scripts from https://raw.githubusercontent.com/conankiz/AutoInstallLocalPrinterUsingTCP/main/AutoAddPrinterLocalTCP.bat

b. Download the correct printer drivers, and unpack/extract them to a drivers folder.
<a name="step2"></a>
### Step 2: Transfer The Files To The File Server:
Open Windows Explorer and navigate to the admin share of the remote computer: \\IP_FILE_SERVER\Share_Name
<img src="https://i.imgur.com/XbBogIO.png">

Copy the scripts and drivers folders to wherever you want on the File Server. In our example, we copy them to Share_Name\Driver\Printer
<a name="step3"></a>
### Step 3: Delete The Port & Printer Name (Just In Case They Already Exist)
Now that you’re connected remotely, essentially what you’re going to use for this step is the specific port name and printer name that you plan to use, just to make sure neither already exists.

(This step has been edited based on a tip provided by IUCN5406 - it's best to try to delete the printer name before deleting the port, otherwise the name may still be in use. Thanks for the info IUCN5406!)

- (delete the printer name, in case it already exists) cscript 
``` sh
Cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnmngr.vbs -d -p "HP_P2035n"
```
- (delete the printer port, in case it already exists) 
``` sh
Cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnport.vbs -d -r IP_192.168.11.6
```

NOTE: In some circumstances, you may need to delete the printer name before you are able to delete the printer port
<a name="step4"></a>
### Step 4: Create The Printer Port
Adds a printer port with name "IP_PRINTERIP" and IP address of "PRINTERIP":
``` sh
Cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnport.vbs" -a -r 192.168.11.6 -h 192.168.11.6 -o raw -n 9100
```
<a name="step5"></a>
### Step 5: Install The Printer Driver
Getting the printer model and .inf file, then -h for the path to the .dll:
``` sh
Cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prndrvr.vbs" -a -m "HP LaserJet P2035n" -i "\\192.168.11.250\Source\Driver\Printer\ljP2035-gdi-pnp-win64-en\HP2030.INF" -h "\\192.168.11.250\Source\Driver\Printer\ljP2035-gdi-pnp-win64-en
```
<a name="step6"></a>
### Step 6: "Tie It All Together"
Lastly, we’re going to name the printer and tie it to the printer port we created:
``` sh
Cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnmngr.vbs" -a -p "HP_P2035n" -m "HP LaserJet P2035n" -r 192.168.11.6
```
<img src="https://i.imgur.com/h2afYuP.png">
<a name="tongket"></a>
## III. Summary
The above article I summarize the knowledge gained when using windows for my work (sys admin), hope it helps you a bit.

Certainly the article there are many shortcomings, looking for sympathy and submit feedback for me to complete more.

Watch Video here: 
https://youtu.be/dClZRLYp_uM
Contact me:
- Email: manhhungbl@gmail.com
- Skype: spyerx3
- Youtube Channel: youtube.com/howtoused

Thank you very much!
