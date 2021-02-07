## Script auto install local printer using TCP
Delete The Port & Printer Name (Just In Case They Already Exist)
### Mục lục

[I. Mở đầu](#Modau)

[II. Ngôn ngữ Markdown](#ngonngumarkdown)
- [1. Thẻ tiêu đề](#thetieude)
- [2. Chèn link, chèn ảnh](#chenlinkchenanh)
- [3. Ký tự in đậm, in nghiêng](#kytuindaminnghieng)
- [4. Trích dẫn, bo chữ](#trichdanbochu)
- [5. Gạch đầu dòng](#gachdaudong)
- [6. Tạo bảng](#taobang)
- [Mẹo](#meo)
	
[III. Các thao tác với git và github](#cacthaotacvoigitvagithub)
- [0. Repo](#repo)
- [1. Cài đặt](#caidat)

  - [1.1. Linux](#linux)
  - [1.2. Windows](#windows)

- [2. Thao tác với Repo](#thaotacvoirepo)

  - [2.1. Trên Linux](#21trenlinux)
    - [2.1.1. Tạo mới](#211taomoi)
    - [2.1.2. Clone](#212clone)
    - [2.1.3. Add, commit, push](#213addcommitpush)
    - [2.1.4. Pull](#214pull)
  - [2.2. Trên Windows](#22trenwindows)
    - [2.2.1. Tạo một repo mới](#221taomotrepomoi)
    - [2.2.2. Clone](#222clone)
    - [2.2.3. Add, commit, push, pull ](#223)

- [3. Thao tác với tổ chức trong Github](#3)
- [4. Thao tác với nhánh (branch)](#4)
- [5. Issues](#5)
	
[Tổng kết](#Tongket)

===========================
<a name="Modau"></a>
## I. Mở đầu
First I was looking for a way to install printers by IP faster than the normal "add a printer", "add a local printer", "create a new port" and that whole time-consuming process.

There are several ways to do this, I chose to use Windows already installed printer commands and wrote scripts for each of the printers I was trying to install.
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
OK, now we’re going to create the port we want to use:

cscript C:\hp\scripts\Prnport.vbs -a -r IP_192.168.1.200 -h 192.168.1.200 -o raw -n 9100

### Step 6: Install The Printer Driver
Next, we’re going to install the driver we want to use:

cscript C:\hp\scripts\Prndrvr.vbs -a -m RICOH Aficio MP 4002 PCL 5e -i C:\hp\drivers\z53149en\disk1\oemsetup.inf -h C:\hp\drivers\z53149en\disk1

### Step 7: "Tie It All Together"
Lastly, we’re going to name the printer and tie it to the printer port we created:

cscript C:\hp\scripts\Prnmngr.vbs -a -p Our Site - Checkin Dept - Ricoh 4002 -m RICOH Aficio MP 4002 PCL 5e -r IP_192.168.1.200
