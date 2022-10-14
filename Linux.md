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
* **/home/user/.netrc** contains login and initialization information used by the auto-login process.
* **/etc/ssh/ssh_config** allow us to connect to servers with pre-configured commands
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
u - user, g - group, o - others a - all user
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
* **ps** displays the processes information but static
```
ps
ps -aux
ps -l
```
* **top** displays the processes information but run time 
* **nice and renice** used to change the priority of a process. Nice is used for before a process start or while schedulig. Renice is used to change the priority when the process is running.
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
first number in file permission is inode number
```
### Networking in linux
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




