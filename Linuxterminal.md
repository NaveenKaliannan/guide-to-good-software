copy (paste) to terminal 
```
ctrl-shift-c (v)
```
find and replace 
```
sed -i 's/old/new/g' file-name
```
Notation
```
b - block special file
d - directory
r - read
w - write 
x - executable
+ - add permission
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


