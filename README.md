## Script auto install local printer using TCP
Delete The Port & Printer Name (Just In Case They Already Exist)
### Mục lục

[I. Introduction](#Modau)

[II. Start](#batdau)
- [Step 1: Prepare The Files](#step1)
- [Step 2:](#step2)
- [Step 3:](#step3)
- [Step 4:](#step4)

[Summary](#Tongket)

===========================
<a name="Modau"></a>
## I. Introduction
First I was looking for a way to install printers by IP faster than the normal "add a printer", "add a local printer", "create a new port" and that whole time-consuming process.

There are several ways to do this, I chose to use Windows already installed printer commands and wrote scripts for each of the printers I was trying to install.

There are several ways to do this, I chose to use Windows already installed printer commands and wrote scripts for each of the printers I was trying to install.
<a name="batdau"></a>
## II. Start
- File server to share driver
- Windows client : install Printer on this machine
<a name="step1"></a>
### Step 1: Prepare The Files:
(Repeating what I referenced in my NOTES above)

a. Copy prnport.vbs, prndrvr.vbs and prnmngr.vbs from %WINDIR%\System32\Printing_Admin_Scripts\en-US\ (from a Windows 7 computer) to a folder called scripts.

b. Download the correct printer drivers, and unpack/extract them to a folder called drivers.

### Step 2: Transfer The Files To The Remote Computer
Open Windows Explorer and navigate to the admin share of the remote computer: \192.168.1.100\c$

Copy the scripts and drivers folders to wherever you want on the remote computer. In our example, we copy them to C:\hp

### Step 4: Delete The Port & Printer Name (Just In Case They Already Exist)
Now that you’re connected remotely, essentially what you’re going to use for this step is the specific port name and printer name that you plan to use, just to make sure neither already exists.

(This step has been edited based on a tip provided by IUCN5406 - it's best to try to delete the printer name before deleting the port, otherwise the name may still be in use. Thanks for the info IUCN5406!)

(delete the printer name, in case it already exists) cscript C:\hp\scripts\Prnmngr.vbs -d -p Our Site - Checkin Dept - Ricoh 4002

(delete the printer port, in case it already exists) cscript C:\hp\scripts\Prnport.vbs -d -r IP_192.168.1.200

NOTE: In some circumstances, you may need to delete the printer name before you are able to delete the printer port

### Step 5: Create The Printer Port
Adds a printer port with name "IP_PRINTERIP" and IP address of "PRINTERIP":
``` sh
cscript C:\System32\Printing_Admin_Scripts\en-US\Prnport.vbs -a -r IP_PRINTERIP -h IP_PRINTERIP -o raw -n 9100
```
### Step 6: Install The Printer Driver
Getting the printer model and .inf file, then -h for the path to the .dll:
``` sh
cscript C:\hp\scripts\Prndrvr.vbs -a -m RICOH Aficio MP 4002 PCL 5e -i C:\hp\drivers\z53149en\disk1\oemsetup.inf -h C:\hp\drivers\z53149en\disk1
```
### Step 7: "Tie It All Together"
Lastly, we’re going to name the printer and tie it to the printer port we created:

cscript C:\hp\scripts\Prnmngr.vbs -a -p Our Site - Checkin Dept - Ricoh 4002 -m RICOH Aficio MP 4002 PCL 5e -r IP_192.168.1.200
<a name="tongket"></a>
## Summary
