# Linux

Linux is a UNIX-like operating system that is quicker, lighter, more secure (cannot break the kernel), open sourced, and more stable. It is strongly preferred when it comes to software development and scientific computing. Numerous Linux distributions exist, including Debian, Ubuntu, Centos, and others. <br />
The internal core of the Linux architecture contains the hardware, the central core is the kernel (machine code written in C and the assembled language both manage the hardware), the external layer is the application layer. Between the kernel and the application layer are these shell commands (cp, grep, ls, pwd, shell manage the user). The shell interprets the command entered by user and sends it to the kernel for execution. This is done by first validating the command, sending it to the kernel using the hardware, and finally executing or showing the output. The kernel manages memory, resources, device management and system calls (function that allows a process to communicate with the Linux kernel)<br />
![alt tag](https://static.javatpoint.com/linux/images/architecture-of-linux.png)
*The structure of Linux architecture. This image was taken from the static.javatpoint.com site*
### Linux directory structure 
Linux directory structure starts with /, the root directory. <br />
* **/bin/ (root)** contains executable or binary files such as cp, mv, bash, ps, pwd etc.
* **/etc (root)** has the system configuration file
* **/sbin/ (root)** has the system binaries such as fdisk, ifconfig, reboot, root, init, getty, fsck, mkfs, mkswap, halt, and etc
* **/usr/ (users)** has read only applications, data and binaries. It has many sub folders: bin, include, lib, local, share.
* **/var/ (users)** has variable data files such as cache, lock files, log files, tmp files. 
* **/dev (users)**  contains device files (USB drive, mouse, keyboard, hard drives)
* **/home (users)**  contains home and user, group directory
* **/lib (users)** contains libraries and kernel modules
* **/mnt (users)** contains mount files for temporary filesystems 
* **/proc (users)** - process and kernel information files 
* **/root (users)** - home directory of the root user <br />
![alt tag](https://helpdeskgeek.com/wp-content/pictures/2020/02/file-directory.png)
*The structure of typical Linux directory 
. This image was taken from the helpdeskgeek.com site*
### Important Linux Files You Should Know About
* **/etc/passwd** file contains information such as UID (user ID), GID (group ID), home directory, shell interpreter, and etc.
```
cat /etc/passwd |grep "username"
username:x:1001:1000:username,,,:/home/username:/bin/bash
x means the password is present in the shadow file
Third section 1000 is UID
Fourth section 1000 is GID
Here both UID and GID are same. When working in group, it should be different.
,,, should be contact details
/home/username is the users home directory
/bin/bash is the shell interpreter
```
Note that the UID number is assigned by Linux to each user on the system. The purpose of this UID and GID is explained here: when a user starts a process (a program is running or in execution, an running instance of the program), that process gets a real UID and an effective UID. Both the real UID and the effective UID are the same as the user's UID number (1000). The UID number indicates which resources or files the user's process can access. When a user process wants to access root-related resources or files, the effective UID changes to 0, which is the UID of the root. When the process of root wants to access resources or files related to normal users, the normal user's EUID will be stored in the root's saved UID. Hence, there are three different types of UID: real (process of user and will be same as the UID of user) effective (It allows a process of unprivileged user to access documents or resources that only root can access), saved user (process of root wants to do some underpreviliged work. Example: root wants to backup the user data, update something). 
```
ls -l /bin/passwd
-rwsr-xr-x root root number data /bin/passwd - user who runs the passwd command will run it with the same permission as root.
/etc/passwd and /etc/shadow are owned by the root. Normal user will be able to modify them using SUID flag
```
how to set SUID flag
```
chmod u+s filename
it will change -rwxrw-rw-  to -rwsrw-rw-
```
* **/etc/shadow** is a system file or a shadow password file in Linux that stores encrypted user passwords and is accessible only to the root user
* **/etc/ssh/ssh_config** allow us to connect to servers with pre-configured commands
* **/etc/inittab** configuration file which is to be used by initialization system. ```init``` create processes from this file.
```
init 0 will shutdown the machine
init 6 will reboot the machine
```
* **/etc/resolv.conf** configuration file which is used to configure DNS name servers. Hence, allows computer to covert or translate or resolve human readable format address to machine-readable IP addresses (IPv4 or IPv6) and viceversa. The file is maintained maually  or when DHCP is used. The file contains domain name and name server (in machine-readable IP addresses). This means which the IP-address of a name server to use for name resolution.
```
Resolver (translate) program in linux (or in our local computer) offer access to the Internet Domain Name System (DNS). The resolv.conf file is read by this program. The DNS querries requested by us will sent to DNS nameserver with the help of DNS resolver program. DNS resolver forwards our DNS querries to DNS nameserver.
DNS Nameserver is a host on the internet which resolve or translate or convert human readable format address to machine-readable IP addresses. It answers the DNS querries, sent by DNS clients. This process is name resolution.

what will be inside our DNS querry? Our IP address and what we requested for (examples: images, file downloads).
domain name is upb.de. It has IP address. DNS name server will resolve.
global host name is www. 
localhost - 127.0.0.1 
http protocol  - handles the communication between a web server and a web browser
HTTP secure protocol - handles the communication between a web server and a web browser.
FTP (file transfer protocol) - hands file transfer between two machines
SFTP (ssh file transfer protocol or secure FTP)
ssh - secure shell to access a machine
```
* **/etc/hosts** is used for name resolution and contains ip address and its corresponding domain name.
```
ip address host-name or user-defined-alias-name (alias name for the amazon.com is ama.com)
```
* **/home/user/.netrc** contains login and initialization information used by the auto-login process.
* **/home/user/.ssh/known_hosts** contains host keys and is located in the user's home directory
* **/home/user/.bashrc** is a script file that's executed when a user logs in. This includes setting up or enabling: coloring, completion, shell history, command aliases, and more.
```
vim ~/.bashrc
alias cddata='cd $HOME/tmp/data'
```
### Shell commands
Type the following command in the terminal to see all shell commands in linux. 
```
ls /bin/* 
```
### The most commonly used shell commands are explained here.
* **#!** header file of shell script or shebang and it will tell which interpreter should be used. <br />
 ```
 #!/bin/bash
 ```
* **man** display the user manual of any command <br />
* **ls --version** display the version of the binary <br />
* **whereis ls** finds the location of source/binary file of a command <br />
* **which** locates the executable location
* **sudo su** used for root previliges <br />
* **adduser** adding new user
```
sudo adduser newuser
sudo userdel newuser
```
* **usermod** adding user to sudo group
```
sudo usermod -aG sudo newuser
group newuser
su - newuser
sudo ls /root
```
* **finger** user info lookup command and provides details of all the users logged in. It is recommended to disable because remote login people might be able to look at all the user information.
* **set** is used to define the value of system variables <br />
* **export** is used the create environment variables <br />
 ```
 export PYTHONPATH=$(pwd):$(path2):$(path3)
 ```
* **PATH** This variable specifies directories for executable.
```
export PATH=$PATH:/home/user/dipole/bin/
```
* **LD_LIBRARY_PATH** This variable specifies the search paths for shared libraries. By setting the path, we will be calling the corresponding header files.
```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64:
``` 
* **unset** remove the variable which is set <br />
* **expr** computes the given expression and displays the output <br />
* **vim, emacs, nano, vi** file editors in terminal
* **cat, less, more, head, tail** diplays the content of file as output
* **Notation in linux**
```
s - special permission for the user (represent SUID) and it is used instead of x (executable) (-rwsrwxr--)
t - sticky bit. The sticky bit is only for directory. When it is set for a directory, all files in the directory can only be deleted or renamed by file owners or root. Example: tmp foler. user cannot delete temp file created by other users but root can delete.
b - block special file for storage, drives, usb. Can be mounted. 
c - character device file  ex. mouse, keyboard
d - directory
l -  links
r - read
w - write 
x - executable
+ - add permission
- - removes the permission
= - ignore all permissions
```
* **Linux file permission**
```
-rwxrwxrwx
first character defines the directory (d), files (-), links (l)
the latter are user rights, group rights, other rights
```
* **chmod** modify the file permission or directory.
```
Read (r) = 4, Write (w) = 2, eXecute (x) = 1 SUID (s) - 4 for adding and 0 for removing, Sticky bit (t)
u - user, g - group, o - others, a - all user
-----------------------------------
Symbolic:  r-- -w- --x  |  421
Binary:    100 010 001  |  -------
Decimal:    4   2   1   |  000 = 0
                        |  001 = 1
Symbolic:  rwx r-x r-x  |  010 = 2
Binary:    111 101 101  |  011 = 3
Decimal:    7   5   5   |  100 = 4
           /   /   /    |  101 = 5
Owner  ---/   /   /     |  110 = 6
Group  ------/   /      |  111 = 7
Others ---------/       |  Binary to Octal chart
------------------------------------
chmod 755 filename or folder or chmod u=rwx,g=rx,o=rx  filename or folder
chmod u+x file
chmod u-x file
755 u=rwx,g=rx,o=rx, 
751 u=rwx,g=rx,o=x
chmod 4766 test2.txt -> -rwsrw-rw-
chmod u-s test.txt or chmod 0766 test2.txt
```
* **chown** change a file's ownership, directory, or symbolic link for a user or group
```
chown username:groupname file
```
* **PID** when a command issued in a linux starts a new process, which creates a 5 digit (PID) number and it can be tracked. 
```
The process id of init process is 1
```
* **ps** displays the processes information but static
```
ps
ps -aux
ps -l
```
* **top** displays the processes information but run time 
* **sat** command records system activity, retrospective, cpu, memory, disks, network interface and etc.
* **nice and renice** used to change the priority of a process. Nice is used for before a process start or while schedulig. Renice is used to change the priority when the process is running. For setting negative value, one needs root permission.
```
nice -value firefox or other commands such as executable
renice -n value -p PID_of_process
The value should be taken from -20 (high priority) to 19 (lowest priority). Processes started by normal users have priority 0, which is the standard.
```
* **sed** performs editing operations
```
sed -i 's/old/new/g' file-name
```
* **grep** searches for expressions in a file
```
cat output | grep "info" | awk -F'[^0-9]*' '$0=$2'
history | grep "info"
```
* **find** searches for file and directory
```
find -name filename or folder name 
find * -perm /4000
```
* **env** prints the environment variables
* **cp** is used to copy the files or folder
* **mv** moves the files or folder
* **mkdir** creates a directory or directories
* **ls** lists the files or folder in the current directory
* **pwd** diplays the relative path of your current directory
* **ln -s and ln** create the soft (s) and hard symbolic links. 
```
ln -s filename softlink
If the original file is removed. the softfile or link will removed. Both the files have different innode and file permission
ln filename hardlink
Both file `filename` and hardlink file will have same permission and same innode number. If the original file is removed. still the content in hardlink can be seen.
If the original file is modified, it will also reflected in hard link. Hard link is like copying a data but when there is a change in original file, it will updated in hardlink.
```
* **innode number** is a uniquely existing number for all the files
```
ls -l
first number in file permission is inode number (5 digit number). Sometime in between date and user
```
* **absolute and relative path**
```
abs path = /home/username/.../../document
relative path = document/
```
### Shell scripting
* **Operator**
```
**Arithmetic Operators**
+   - addition
-   - subtraction
*   - multiplication
/   - division
%   - remainder
=   - assignment
**Relational operators**
==  - equality
!=  - not equality
-eq	- equal to
-ne	- not equal to
-gt	- greater than
-lt	- less than
-ge	- greater than or equal to
-le	- less than or equal to
**Boolean operators**
!   - logical negation
-o	 - OR operator
-a	 - and operator
**String operators**
=  - checks two string variable whether they are equal
!= - checks two string variable whether they are not equal
-z - checks string variable size zero
-n	- checks the string size variableis non zero
str - checks a string variable whether it is not an empty string
**File test operator**
b - Checks if file is a block special file (used for mounting)
c - Checks if file is a character file (mouse, keyboard)
d - directory, f - ordinary file, g - checks if the file has group id
k - check if the file has sticky bit, p - Checks if file is a named pipe
t - Check if file descriptor is open and associated with a terminal
u - checks if the file has SUID
r - readable w - writeable x - executable
s - checks if the file size is greater than 0
e - checks if the file exists or not
Example if  test -e $file ; then echo $file exists ; fi
```
* **setting variables**
```
declare -i x=1 ## declares integer
declare -i y=1 ## declares integer
z=$(( x + y ))
```
* **for**
```
for i in * ; do commands ; done ##  * means for loop goes via all files
for i in 1 2 3 4 5; do commands; done
for i in {1..5}; do commands; done
for i in {1..5..2}; do commands; done
for i in (( initializer; condition; step )); do commands; done
for i in (( i=1; i<=5; i++ )); do commands; done
for i in ((  ; ;  )); do commands; done ## ; ; means infinite loop
```
* **while and if**
```
n=1; while [ $n -le 5 ] ;  do echo $n ; n=$(( n+1 )) ; done
file=/etc/resolv.conf;
if  test -e $file ; then while IFS= read -r line ; do echo $line ; done < "$file" ; fi
if  test -e $file ; then while IFS= read -r f1 f2 ; do echo "field # 1 : $f1 ==> field #2 : $f2" ; done < "$file" ; fi
file=/etc/passwd
if  test -e $file ; then while IFS=: read -r user enpass uid gid desc home shell ; do [ $uid -ge 500 ] && echo "User $user ($uid) assigned \"$home\" home directory with $shell shell." ; done < "$file" ; fi
```
* **until**
* **select**
### [Networking in linux](https://doc.lagout.org/operating%20system%20/linux/Linux%20Networking%20Cookbook.pdf)
To understand networking in Linux, it is important to understand what are DNS resolvers, DNS nameservers, DNS records, ports and IP address, what do they do?
DNS resolver in local machine sents our DNS querries to DNS nameserver, which covert the human readbale names (google.com) to IP addresss.  PC and our notebooks use IPv4/IPv6 addresses for network communication. Increasing end-users connected to the Internet leads to the exhaustion of IPv4 addresses. This is the reason why IP version 6 is introduced. Names (google.com) are convenient for humans and Numbers are convenient for machines. <br />
What is the differene between IPv4 and IPv6?. <br />
* **IPv4** 
```
- 32-bit address length (1 byte = 8 bits (10101100->172, 00000001->1), 4 bytes = 32 bits, For 8 bits, 0 to 255 numbers, 2 power 8 is 256 numbers)
- less address space
- address representatin is decimal
- 4 fields which are separated by dot (.) Example of IPv4:  66.94.29.13, local host address is 127.0.0.1, IP address for modems and devices 192.168. 178.1
- manual or with DHCP configuration
- A -  used to map names to IPv4 addresses
```
* **IPv6** 
```
- 128-bit address length
- more address space 
- address representatin is hexadecimal
- 8 fields, which are separated by colon (:) Example of IPv6: 2001:0000:3238:DFE1:0063:0000:0000:FEFB, localhost address is ::1
- Autoconfiguration 
- AAAA -  used to map names to IPv6 addresses.  
```
What is the use of IP? 1. identifies any network devices 2. Computers use IP addresses to communicate with each other

When one types google.com in web browser or ssh userid@server-name in terminal, DNS resolver in our notebook asks DNS server (or DNS nameserver) for IP address of the google.com or server-name. This asking process involves a DNS query where our IP address is sent to the google.com. Then the destination sends us the reply with its IP address.

What is the use of DHCP
* DNS nameserves can be manually configured via DHCP.
* host use it learn the address of their DNS Server, IP address. subnet mask, default gateway. 
* assign IP address and helps IP address management. 
* DHCP server maintain records of all IP address and assigns IP address to DHCP client. <br />
A new machine doesnt have IP address. First it sents a DHCP message to the network and the DHCP server assigns the IP address to our machine. This will be our IP address and it will be sent with DNS querries to DNS name server. If you are using a private DNS nameserver, add it to the `/etc/resolv.conf` file. TCP/IP Transmission Control Protocol/Internet Protocol model is the base. DNS uses both UDP (standard) and TCP (used when data is greater than 512 byetes). port number 53 is used. 

* **ping** command pings a host and get its ipv4 address.
```
ping amazon.com 
```
* **host** command finds IPv4, IPv6 address and DNS records (such as alias name) of a host
```
ping amazon.com 
```
* **ipconfig** displays current network configuration information, such as notebook local host IP address, ethernet address, subnet mask, default gateway and etc
```
ipconfig 
```
* **ipconfig/all**  show information about the network configuration and DHCP and DNS Settings
```
ipconfig/all 
```
* **nslookup** displays the DNS records or the domain address records and IP address of the given host name
```
nslookup google.com
```
Note that both ipconfig/all nslookup will show the DNS records or the domain address records.
* **dhclient** used for assigning dynamic IP addresses.
* **ipconfig /displaydns** displays the contents of PC DNS resolver cache. It contains a table with DNS records (host name, ip address) of already visited domain names. Example., DNS querries, IP address of visited website. If we are visting the same website next time, there is no need for nslookup, we can get the DNS record quickly and response will be faster. If the data for a website is not available, then the DNS querry will be sent to DNS nameserver and it will be stored in DNS cache. Clearing the browsing history or /flushdns will clear the cache.
* **ipconfig /flushdns** removes the DNS resolver cache
* **route** command shows and manipulates ip routing table
* **port number** helps to transmit data between a network and a specified application. This number is used by TCP and UDP of IP suite. It is 16 bit unsigned integer (0-65535). Each computers have its own IP address and each application in them has its own port number. Some application like HTTPS (80) have same port number. The port number is assigned by OS to each processes.
```
port number  -  application
21 - FTP Server
22 - SSH Server 
23 - TELENET
25 -  SMTP
53 - DNS
80 -  HTTP
110 - POP3 mail server
443 - HTTPS
```
* **tcpdump** allows one to analyze network traffic going via machines.
* **netstat** diplays problems in the network and finds the amount of traffic in the network

How to configure ip address in router
```
ip dns server - command
ip name-server 8.8.8.8
ip domain loopup
ip domain name
````




### File systems in linux
information about /dev/sd - https://www.baeldung.com/linux/dev-sda
```
/dev  contains device files
/sd is  scsi disk
/dev/sd is a hard disk /sd[a-z] - naming format for our disks. Every storage has own sd[a-z] name
sudo fdisk -l shows the capacity of a hard disk
lsblk - Lists the available block devices in the system. It displays the output in a tree-like structure
```
mount allows filesystem accessible in the Linux directory tree. Normally `/mnt` directory is used for mounting

```
fdisk -l --->  find the location in /dev
/dev/sdb1 is a device file. and when you mount it, you access the files in the device.
mount /dev/sdb1 /mnt/location/ - then you can access the files in the filesystem. otherwise you cannot see the folders or files in drives such as USB, external.  
BTRFS, EXT4 (large file system, good performance for large size, unlimited sub directories) oder NTFS
mount - allowing acces to a filesystem
umount - remove all those access.
sudo mount /dev/sdb1 /mnt/media
-t option to specify the file system type
mount -t TYPE DEVICE_NAME DIRECTORY
mount -o OPTIONS DEVICE_NAME DIRECTORY
/dev contains device files
```

Proc file systems - virtual file system created on fly when system boots and is disappears when system shut downs.
```
ls –l /proc
ps -aux
ls -l /proc/pid/file-name Ex.,status, root, stat
```


copy (paste) to terminal 
```
ctrl-shift-c (v)
```




