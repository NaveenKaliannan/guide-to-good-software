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
* **/etc/shadow** is a system file or a shadow password file in Linux that stores encrypted user passwords and is accessible only to the root user
* **/home/user/.netrc** contains login and initialization information used by the auto-login process.
* **/etc/ssh/ssh_config** allow us to connect to servers with pre-configured commands
* **/home/user/.ssh/known_hosts** contains host keys and is located in the user's home directory
* **/home/user/.bashrc** is a script file that's executed when a user logs in. This includes setting up or enabling: coloring, completion, shell history, command aliases, and more.
### Shell commands
Type the following command in the terminal to see all shell commands in linux. 
```
ls /bin/* 
```
### The most common shell commands are explained here.
* **#!** header file of shell script or shebang and it will tell which interpreter should be used. <br />
 ```
 #!/bin/bash
 ```
* **man** display the user manual of any command <br />
* **ls --version** display the version of the binary <br />
* **whereis ls** finds the location of source/binary file of a command <br />
* **sudo su** used for root previliges <br />
* **set** is used to define the value of system variables <br />
* **export** is used the create environment variables <br />
 ```
 export PYTHONPATH=$(pwd):$(path2):$(path3)
 ```
* **unset** remove the variable which is set <br />
* **expr** computes the given expression and displays the output <br />



copy (paste) to terminal 
```
ctrl-shift-c (v)
```
find and replace 
```
sed -i 's/old/new/g' file-name
```
greping only number
```
cat output | grep "info" | awk -F'[^0-9]*' '$0=$2'
```
Notation
```
b - block special file for storage, drives, usb. Can be mounted. 
c - character device file  ex. mouse, keyboard
d - directory
r - read
w - write 
x - executable
+ - add permission
- - removes the permission
= - ignore all permissions
```
Chaning the permission of file or directory 
https://askubuntu.com/questions/932713/what-is-the-difference-between-chmod-x-and-chmod-755
```
chmod +rwx filename or folder - read, write, executable
read = 4, write = 2, execute = 1
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
```
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

Hard Link and symbolic or soft link
```
ln -s filename softlink
if the original file is removed. the softfile or link will removed.
Both the files have different innode and file permission
ln filename hardlink
Both file `filename` and hardlink file will have same permission and same  innode number
If the original file is removed. still the content in hardlink can be seen.
If the original file is modified, it will also reflected in hard link
Hard link is like copying a data but when there is a change in original file, it will updated in hardlink.
```
See the environmental variables
```
env
```
Make changes to bashrc
```
vim ~/.bashrc
alias cddata='cd $HOME/tmp/data'
```
Proc file systems - virtual file system created on fly when system boots and is disappears when system shut downs.
```
ls –l /proc
ps -aux
ls -l /proc/pid/file-name Ex.,status, root, stat
```
A path variable can several paths. This is can done by using a colon (:)
```
export PYTHONPATH=$(pwd):/home/naveen/newpython
```
