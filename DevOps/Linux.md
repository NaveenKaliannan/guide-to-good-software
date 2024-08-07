# Linux

Linux is a UNIX-like operating system that is quicker, lighter, more secure (cannot break the kernel), open sourced, and more stable. It is strongly preferred when it comes to software development and scientific computing. Numerous Linux distributions exist, including Debian, Ubuntu, Centos, and others. <br />
The internal core of the Linux architecture contains the hardware, the central core is the kernel (machine code written in C and the assembled language both manage the hardware), the external layer is the application layer. Between the kernel and the application layer are these shell commands (cp, grep, ls, pwd, shell manage the user). The shell interprets the command entered by user and sends it to the kernel for execution. This is done by first validating the command, sending it to the kernel using the hardware, and finally executing or showing the output. The kernel manages memory, resources, device management and system calls (function that allows a process to communicate with the Linux kernel). Here **Shell + Kernel = Operating system and Shell + Application = Software**. <br />
![alt tag](https://static.javatpoint.com/linux/images/architecture-of-linux.png)
*The structure of Linux architecture. This image was taken from the static.javatpoint.com site*

**Linux** can be installed via VMWare/Oracle Virtual BOX (virthualization software)/could services (google/AWS) on Windows/MAC.

[Oracle Virtual BOX](https://www.virtualbox.org/wiki/Downloads) and [VMWare workstation player](https://www.vmware.com/de/products/workstation-pro/workstation-pro-evaluation.html) are free.
Always take a snapshot.

## VMWARE workstation set up
The Ubuntu image can be downloaded from [Ubuntu site](https://releases.ubuntu.com/)
- Create a New VM
- Typical
- Installer disc image file
- Full name
- User name
- Password
- Location
- Maximum disk size = 1.9 TB. 1.9 TB is the max size VMWare can handle. 
- Select = Store virtual disk as a single file
4GB RAM is minimum system requirements space for running VMware. 
8GB RAM or more is recommended for the host computers that runs VMware.
The RAM depends on the applications that we gonna work on.
For accelerated graphics features, VMware recommends two virtual CPUs and 4 GB of RAM. 
- Under Customize Hardware : Memory= 4-8GB, Processors = 4-8, Virtualization engine = activate "VT-x" and "IOMMU", Number of monitors= 2-4
- To get internet connection, go to **Network** and Switched to **Bridged Adaptor in the attached to** drop down menu. 

## How to connect to Linux Machine
- Remote via PUTTY, WISCP
- Terminal

# Installing packages
* **dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -nr | head -n 200** shows the top 200 big packages in linux.
* **deborphan --guess-all** find orphaned packages that are no longer needed

## Linux directory structure 
Filesystem is a system that manages the files in OS. OS stores files in organized way.
Linux directory structure starts with /, the root directory. <br />
* **/etc (root)** has the system configuration file  :exclamation:
* **/sbin/ (root)** has the system binaries such as fdisk, ifconfig, reboot, root, init, getty, fsck, mkfs, mkswap, halt, and etc :exclamation:
* **/bin/ (root)** contains executable or binary files such as cp, mv, bash, ps, pwd etc. :exclamation:
* **/opt (users)** - allocated for the installation of additional application software packages :exclamation:
* **/boot** cotains the file used by boot loader (grub.cfg). It tells the computer which OS is stored.
* **/usr/ (users)** has read only applications, data and binaries. It has many sub folders: bin, include, lib, local, share.
* **/var/ (users)** has variable data files such as cache, lock files, log files, tmp files. 
* **/dev (users)**  contains device files (USB drive, mouse, keyboard, hard drives)
* **/home (users)**  contains home and user, group directory
* **/lib (users)** contains libraries and kernel modules
* **/mnt (users)** contains mount files for temporary filesystems 
* **/proc (users)** - process and kernel information files. Only exists if there is something running. When computer turned off, there will be nothing.  
* **/root (users)** - home directory of the root user <br />
![alt tag](https://helpdeskgeek.com/wp-content/pictures/2020/02/file-directory.png)
*The structure of typical Linux directory 
. This image was taken from the helpdeskgeek.com site*

## Important Linux Files You Should Know About
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
* **/etc/group** is a system file or a shadow password file in Linux that stores encrypted user passwords and is accessible only to the root user
* **/etc/shadow** is a system file or a shadow password file in Linux that stores encrypted user passwords and is accessible only to the root user
* **/etc/login.defs** The parameter in this defaults file controls behaviour of shadow file, passwd agin controls: passwd max, min days, pass min len, pass warn age, user permission, encryption type
* **/etc/sudoers** sudo information folder. 
* **/etc/environment** file sets the variable permanently in the system. **~/.profile** is a similar file but belongs to each user. However, **/etc/profile** is a gloabl intialization file in the system. All are basically loading environmental variable. **bash_profile** file runs when login into the account. **bashrc** file runs when opening the terminal and set the variable.  
* **/etc/systemd/system/docker.service.d/proxy.conf or http-proxy.conf** for setting proxy for  docker
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
* **/etc/nsswitch.conf** a critical system configuration file that controls how the Linux system looks up various types of information, and should be modified with caution
* **/etc/hostname** simple way for local applications to identify the hostname of the Linux machine, without needing to resolve a full domain name. It is a local configuration file, separate from the /etc/hosts file which maps hostnames to IP addresses
* **/etc/sysconfig/network** is used to specify information about the desired network configuration on the Linux server. It contains settings such as: NETWORKING=yes/no - whether to configure networking or not. FORWARD_IPV4=yes/no - whether to perform IP forwarding or not. HOSTNAME=hostname - the hostname of the server. GATEWAY=gwip - the IP address of the remote network gateway. GATEWAYDEV=gwdev - the device name (e.g. eth0) used to access the remote gateway
* **/etc/sysconfig/network-scripts/ifcfg-nic** is used to configure the network interface settings for a specific network interface (NIC) on a Linux system. The file contains various parameters that define the configuration of the network interface, such as: DEVICE=nic - the name of the network interface device (e.g. eth0, enp1s0). BOOTPROTO=none/dhcp - the boot protocol to use, either static IP or DHCP. 
ONBOOT=yes/no - whether to bring up the interface at system boot. IPADDR=ipaddr - the static IP address if using a fixed IP configuration. NETMASK=netmask - the subnet mask if using a fixed IP configuration. GATEWAY=gwip - the default gateway IP address if using a fixed IP configuration.
* **/etc/hosts** is used for name resolution and contains ip address and its corresponding domain name.
```
ip address host-name or user-defined-alias-name (alias name for the amazon.com is ama.com)
```
* **/etc/xdg/pip/pip.conf** configuration file for pip installations. The pip file can located using the command `python3 -m pip config debug`
```
[global]
index-url = artifactory website
--extra-index-url = second artifactory website
```
* **/etc/apt/sources.list file and /etc/apt/sources.list.d folder** contains the repositories, i.e. sources for packages.
* **/etc/apt/auth.conf** configuration file for login and initialization information used by the auto-login process.
* **/home/user/.netrc** contains login and initialization information used by the auto-login process.
* **/home/user/.ssh/known_hosts** contains host keys and is located in the user's home directory
* **/home/user/.bashrc** is a script file that's executed when a user logs in. This includes setting up or enabling: coloring, completion, shell history, command aliases, and more.
```
vim ~/.bashrc
alias cddata='cd $HOME/tmp/data'
```

## Root and User Account Managemet

Root user is the powerfull user that has access to all the commands, files, folders, and etc. 

* **whoami** provide the user details
* **hostname** provide the hostname
* **/** - Root directory.
* **/root** - Root home directory
* **useradd**
```
useradd -m testuser # m creates the home directory
id testuser # shows whether the user exists or not
cat /etc/passwd  # shows whether the user exists or not
cat /etc/group # shows whether the user exists or not
passwd testuser #to set paasswd for the new test user
``` 
* **groupadd**
```
groupadd testgroup
cat /etc/group # shows whether the user exists or not
``` 
* **userdel**
```
userdel -r testuser # delete the user and their home directory as well
/etc/passwd  # shows whether the user exists or not
``` 
* **groupdel** 
```
groupdel testgroup
cat /etc/group # shows whether the user exists or not
``` 
* **usermod** adds user to a certain group
```
usermode -G testgroup testuser # adds testuser to testgroup
chgrp -R testgroup testuser # to make the home directory of testuser to group ownership from testuser
```  
* **passwd userid** change the password. It will ask you for the old and new password
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
* **change** per user can change the /etc/login.defs paramertes for a specific user. The change will be refected in **/etc/shadow** file
* **su username** switch to username
* **sudo su** to become a root
* **visudo** can help to get permission to commands that only root has access.
* **who** login information
* **last** last login information
* **finger** gives details of all the users who are logged in
* **id** user ID

## Shell commands

Type the following command in the terminal to see all shell commands in linux. 
```
ls /bin/* 
```
* **#!** header file of shell script or shebang and it will tell which interpreter should be used. <br />
 ```
 #!/bin/bash
 ```

### Help Commands

* **man** display the user manual of any command <br />
* **whatis** displays information on commands <br />
* **--help** displays information on commands <br />
* **ls --version** display the version of the binary <br />
* **whereis ls** finds the location of source/binary file of a command <br />
* **which** locates the executable location <br />

### Input and Output 

* **echo** prints the given string
```
echo -e "8\n\n" | $gmxexe/gmx_d energy -f $ensemble.edr -o $ensemble.xvg  used to enter in the promt
```  
* **echo "Hello" >> or > Filename.txt** prints the given string in a txt file. > overwrites the files but >> appends into txt file
* **<** is stdin for command
* **2> errorfile** storing the error message into an errorfile
* **| tee filename** storing the the output in a text file. **| tee -a filename** appends the old text file

### Text processor commands 
* **wildcard**
```
* - zero or more characters Eg., ls na*n.py shows the naveen.py
? - single character Eg., ls na?een.py shows the naveen.py
[] - range of character Eg., ls *[zy]* shows the file that has a name with word y or z
\ - escape character
^ - beginning of the line
$ - dollar sign
```
* **cut -c1,2,4 or -c1-4 or c1-2, 4-5 filename**  prints the characater file for given range
* **cut -d: -f 6 /etc/passwd** shows the 6th field sepearated by limiter ":"
* **cut -d, -f 2 test** shows the 6th field sepearated by limiter ","
```
-> cat test
helo1,helo2
-> cut -d, -f 2 test
helo2
```
* **awk** used for data extraction from a file
```
-> cat test
helo1,helo2
awk '{print $1}' test - prints the first field of the text file
awk '{print $1,$2}' test - prints the first and second field of the text file
awk '{print $NF}' test - prints the last field of the text file
awk '/helo2/ {print}' test searches for keywords
awk -F: '{print $6}' /etc/passwd prints the fields sepearated by delimiter
echo "heelo worl" | awk '{$2 = "world" ; print $0}' replace the words
awk 'length($0) > 6' test prints the words greater than length 6
awk '{if(length($0) > 5) print $0}' test
awk '{print NF}' test - prints the number of field
file=../simdata/0mol/f_5_1; head -1 $file | awk '{print NF}' ; prints the number of coloumns in a file
file=../simdata/0mol/f_5_1; head -1 $file | awk '{print NF}' ; wc $file | awk '{print $1}' prints the number of coloumns and rows in a file
sed 1,24d nve_pulse.xvg | awk 'NR % 80 == 0' prints every 80th line
```
* **grep and egrep**
```
grep "keyword" filename
grep -c "keyword" filename
grep -i "keyword" filename -> ignores the case sensitive
grep -n "keyword" filename -> line number
grep -v "keyword" filename -> exculded the keyword line
egrep -i "keyword1|keyword2" -> searches for two keywords
``` 
* **sort**
```
sort filename
sort -r filename -> reverse the sort
sort -k2 filenae -> sort the file by second coloumn
```
* **uniq**
```
uniq filename
uniq -c filename 
uniq -d filename shows the repeated line
```
* **wc**
 ```
wc filename
wc -c filename
wc -m filename 
wc -l filename
ls -l | grep "dr"  | wc -l
```
* **diff** shows the difference in line between files
* **cmp** shows the difference in byte between files

### Access Control Linux
It allows permission to any user or group to the disk or file or folders
* **getfacl** displays the file read write information of users
```
$ getfacl z.py
# file: z.py
# owner: naveenk
# group: naveenk
user::rw-
group::rw-
other::r--
```  
* **setfacl** sets the write read permission of files for users or groups
```
setfacl -m u:username:rwx filename # adds the user to read write and execute the file
setfacl -m g:groupname:rw filename # adds the group to read write and execute the file
setfacl -dm "entry" filename 
setfacl -x u:username filename # remove the user to process the file
setfacl -b path-to-file # remove the user or group or everthing to process the file
```

### File or Folder commands
* **mkdir** creates a directory or directories Example mkdir {1..3}{1..3} creates 9 directory with all the pairs of 1 to 3.
* **cp** is used to copy the files or folder
* **mv** moves the files or folder
* **pwd** diplays the absolute path of your current directory. Print Working Directory
* **wc** counts the character (-m), number of lines (-l), bytes (-c), maximum line length (-L) in a text file
* **cat, less, more, head, tail** diplays the content of file as output. More and Less is paging through the file, one page at a time. j or k to go page through line by line. Spacebar to page via page by page
* **find** searches for file and directory iteratively
```
find -name filename or folder name 
find * -perm /4000
```
* **locate** locates the files. It uses pre built database to find it. It provide the false info if the database is not updated.
* **updatedb** updates the databases
* **ln -s and ln** create the soft (s) and hard symbolic links. 
```
ln -s filename softlink
If the original file is removed. the softfile or link will removed. Both the files have different innode and file permission
ln filename hardlink
Both file `filename` and hardlink file will have same permission and same innode number. If the original file is removed. still the content in hardlink can be seen.
If the original file is modified, it will also reflected in hard link. Hard link is like copying a data but when there is a change in original file, it will updated in hardlink.
```
* **innode number** is a uniquely existing number for all the files.  It basically gives the maximum number of files (2^32 or 4.3 billion files) can be stored in the computer. 
```
df -i
```
* **Compress and uncompress the files or folders**
```
tar cvf myfiles.tar folder-name -> compress
tar xvf myfiles.tar -> extract
gzip myfiles.tar -> reduce the size
gzip -d or gunzip myfiles.tar -> enhance the size
```
* **Combine and split files**
```
cat file1 file2 file 2 > file4
split -l 300 file4 outputfile -> outputfileaa outputfileab
```

* **Notation in linux**
```
Anything that starts with a '-' is a file
s - special permission for the user (represent SUID) and it is used instead of x (executable) (-rwsrwxr--)
t - sticky bit. The sticky bit is only for directory. When it is set for a directory, all files in the directory can only be deleted or renamed by file owners or root. Example: tmp foler. user cannot delete temp file created by other users but root can delete.
b - block special file for storage, drives, usb. Can be mounted. 
c - character device file  ex. mouse, keyboard
d - directory
l -  links
s -  socket
p - named pipe
r - read
w - write 
x - executable
+ - add permission
- - removes the permission
= - ignore all permissions
```
* **Linux file or directory information**
```
filetype-filepermission #number_of_links owner group memory date time Name_of_file
```
* **Linux file permission**
```
-rwxrwxrwx
first character defines the directory (d), files (-), links (l)
the latter are user rights, group rights, other rights
```
* **chgrp** modify the group ownership of the file.
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
* **grep** searches for expressions in a file
```
cat output | grep "info" | awk -F'[^0-9]*' '$0=$2'
history | grep "info"
for i in $(vulture filename.py| awk '{print $4}' | sed  's/'\''//' | sed  's/'\''//'  ); do echo $i ; grep -nr "$i"   ; done
```
* **Truncate the files**
```
truncate -s 10 filename -> only the 10 character exists
```
* **sed** manipulate the files
```
sed 's/keyword/replaceword/g' filename
sed -i 's/keyword/replaceword/g' filename # interactive mode
sed -i 's/keyword//g' filename # removes the keyword
sed -i '/keyword/d' filename # deletes the line with keyword
sed -i '/^$/d' filename # deletes the line that is empty
sed -i '1d' filename # deletes the first line
sed -i '2d' filename # deletes the first two line
sed -i '1d' filename # deletes the first line
sed -i 's/\t/ /g' filename # replaces the tab with space
sed -n 12,18p filename # prints the line between 12 and 18
sed  12,18d filename # prints the line except between 12 and 18
sed  G filename # Makes empty line between lines
sed '8!s/keyword/replaceword/g' filename # replace the keyword except 8th line
```

## Mathematical expression
* **expr** computes the given expression and displays the output <br />

## VIM editor
* **vim filename**
* Enter **i** or **a** to go into insert mode, **A** go to insert mode at the end of line and Hit **Esc** to escape the insert mode
* **Shift->z->z** to save the file or **:wq** to save the file. Here wq means write quit
* **Shift->z->z**  or **:q!** to unsave the file. Here q means quit
*  **yy** to copy a line, **p** to paste the line, **dd** line to delte the line
* **Esc->:/search-keywords** search the keyword
* **Esc->:100** go to line 
* **Comment the sourcecode**
```
Press Ctrl and v
Select until the line of interest
Press Shift and i
Add  # 
Click esc twice
```
* **Copy several line**
```
Press Ctrl and v
Select until the line of interest
Press y
Press p at the line of interest
```
* **Uncomment the sourcecode**
```
Press Ctrl and V
Select until the line of interest
Press x
Click esc twice
```
* **Replace keywords with new keywords**
```
Esc
%s/keyword/replacekeyword/g
Enter
```  

## Important Commands worth knowing
* **unset** remove the variable which is set <br />
* **vim, emacs, nano, vi** file editors in terminal
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
for i in $(vulture filename.py| awk '{print $4}' | sed  's/'\''//' | sed  's/'\''//'  ); do echo $i ; grep -nr "$i"   ; done
for i in $(vulture filename.py| awk '{print $4}' | sed  's/'\''//' | sed  's/'\''//'  ); do  if [ *$(grep -nr "$i" | wc -l)* == *1* ] ; then echo $i ; fi   ; done
```
* **env** prints the environment variables
* **absolute and relative path**
```
abs path = /home/username/.../../document
relative path = document/
```

### Shell scripting
* **shell** is a interface between kernel and user. **echo $0, cat /etc/shells, cat /etc/passwd** allows you to find your shell.  
* **type of shells via cat /etc/shells**
```
gnome
KDE
sh
bash
csh and tcsh
ksh
```
* **shellscript** is an executble file. The commands are executed one by one. First line should contain shell or shebang #!/bin/bash an interpreter used to execute the commands in shell script.
* **read variable-name** reads the input and stores it in the variable
* **|** is used for pipes in Linux. Command 1 | Command 2 | Command 3
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
declare -a bool=([1]=true [0]=false)
echo ${bool[ (($no_of_string_in_calculated_key == $no_of_string_in_expected_key )) ]}
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
for i in $(vulture filename.py| awk '{print $4}' | sed  's/'\''//' | sed  's/'\''//'  ); do echo $i ; grep -nr "$i"   ; done
for i in $(vulture filename.py| awk '{print $4}' | sed  's/'\''//' | sed  's/'\''//'  ); do  if [ *$(grep -nr "$i" | wc -l)* == *1* ] ; then echo $i ; fi   ; done
```
* **while and if**
```
n=1; while [ $n -le 5 ] ;  do echo $n ; n=$(( n+1 )) ; done
file=/etc/resolv.conf;
if  test -e $file ; then while IFS= read -r line ; do echo $line ; done < "$file" ; fi
if  test -e $file ; then while IFS= read -r f1 f2 ; do echo "field # 1 : $f1 ==> field #2 : $f2" ; done < "$file" ; fi
file=/etc/passwd
if  test -e $file ; then while IFS=: read -r user enpass uid gid desc home shell ; do [ $uid -ge 500 ] && echo "User $user ($uid) assigned \"$home\" home directory with $shell shell." ; done < "$file" ; fi
for i in $(vulture filename.py| awk '{print $4}' | sed  's/'\''//' | sed  's/'\''//'  ); do  if [ *$(grep -nr "$i" | wc -l)* == *1* ] ; then echo $i ; fi   ; done
```
* **case**
```

```  
* **until**
* **select**

## [Networking in linux](https://doc.lagout.org/operating%20system%20/linux/Linux%20Networking%20Cookbook.pdf)
### Network Components
1. IP
2. subnet mask
3. Gateway
4. Static and DHCP (dynamic)
5. Network Interface Example NIC card. 
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
* **host** command finds IPv4, IPv6 address and DNS records (such as alias name) of a host
* **ipconfig** displays current network configuration information, such as notebook local host IP address, ethernet address, subnet mask, default gateway and etc
* **ipconfig/all**  show information about the network configuration and DHCP and DNS Settings
* **nslookup** displays the DNS records or the domain address records and IP address of the given host name
Note that both ipconfig/all nslookup will show the DNS records or the domain address records.
* **dhclient** used for assigning dynamic IP addresses.
* **ipconfig /displaydns** displays the contents of PC DNS resolver cache. It contains a table with DNS records (host name, ip address) of already visited domain names. Example., DNS querries, IP address of visited website. If we are visting the same website next time, there is no need for nslookup, we can get the DNS record quickly and response will be faster. If the data for a website is not available, then the DNS querry will be sent to DNS nameserver and it will be stored in DNS cache. Clearing the browsing history or /flushdns will clear the cache.
* **ipconfig /flushdns** removes the DNS resolver cache
* **route** command shows and manipulates ip routing table
* **port number** helps to transmit data between a network and a specified application. This number is used by TCP and UDP of IP suite. It is 16 bit unsigned integer (0-65535). Each computers have its own IP address and each application in them has its own port number. Some application like HTTPS (80) have same port number. The port number is assigned by OS to each processes.
* **hostname -I** specifically displays the IP address(es) of our system. **netstat -r** or **route -n** show the "Gateway" IP address, which is the router's IP address. **ip route** find the router's IP address. Note that the 192.168.0.1 IP address is commonly used as the default gateway or router IP address within this 192.168.0.0/24 subnet. The 192.168.0.0 address is the network address, and 192.168.0.255 is the broadcast address. 192.168.0.1 and 192.168.0.255 are reserved. **broadcast address** is primarily used to send data, messages, and requests to all devices connected to a local network or subnet, enabling communication and discovery without needing to know individual IP addresses.  **default gateway or router IP** is for intercommunication that communicating to outside world.
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
* **ifconfig**
*  **ifup or ifdown**
*  **NIC Network Interface Card** A NIC is a hardware component installed in a computer that provides a physical network connection, typically Ethernet or Wi-Fi. NICs allow the computer to connect to and communicate over a local area network (LAN) or wide area network (WAN). Common examples of NICs include Ethernet adapters that connect to wired Ethernet networks, and wireless network cards that provide Wi-Fi connectivity. The /etc/sysconfig/network-scripts/ifcfg-nic file is used to configure the settings for a specific network interface (NIC) on a Linux system. NICs are a fundamental component for enabling network connectivity on computers and other devices. **ethtool enp0s3**, **lo**, **virb0** virtual bridge 0 for NAT network address translation. **When you connect a device to a local network, the router (or DHCP server) on that network will assign a private IP address to the device's network interface.**
* **ethtool** is the primary command-line tool in Linux for managing and configuring network interface cards (NICs) and their associated device drivers. NICs ifnormaiton can be seen via **ifconfig**
* NIC bonding procedure : Identify the network interfaces (NICs) on the Linux system that you want to bond together
How to configure ip address in router
```
ip dns server - command
ip name-server 8.8.8.8
ip domain loopup
ip domain name
````


## File systems in linux

Filesystem is a system that manages the files in OS. OS stores files in organized way.

Linux file system type = ext2, ext3, nfs

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




# My Bashrc file 
```
sourcebashrc /home/naveenk/.bashrc

export USER_ID="naveenk"
export USER_PW="12***89"

alias sshcluster='ssh naveenk@hostname.de'
alias scpcluster='{read -r a1 a2; echo "$a1"; echo "$a2"; sshpass -p '12***89' scp  -r naveenk@hostname.de:$a1 $a2; }  <<<'

unused_variable()
{
        for i in $(vulture $1 | awk '{print $4}' | sed  's/'\''//' | sed  's/'\''//'  ); do  if [ *$(grep -nr "$i" | wc -l)* == *1* ] ; then echo "Unused variable or function ->" $i " in " $1 ; fi; done
}

find_files_with()
{
        for i in $(ls -ltr $(find . -type f )) ; do FILE=$i ; FILENAME=$(echo "$FILE" | sed 's/\.[^.]*$//') ; EXTENSION=$(echo "$FILE" | sed 's/^.*\.//') ;   if [ $FILE != ".:" ]; then  if [ $EXTENSION == "py" ] ; then echo "FILENAME ->" $FILE ; fi ; fi  ; done
}

find_unsued_variable_in_a_directory()
{
        for i in $(ls -ltr $(find . -type f )) ; do FILE=$i ; FILENAME=$(echo "$FILE" | sed 's/\.[^.]*$//') ; EXTENSION=$(echo "$FILE" | sed 's/^.*\.//') ;   if [ $FILE != ".:" ]; then  if [ $EXTENSION == "py" ] ; then unused_variable $FILE ; fi ; fi  ; done
}

```


