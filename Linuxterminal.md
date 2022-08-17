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
```
information about /dev/sd - https://www.baeldung.com/linux/dev-sda
```
/dev  contains device files
/sd is  scsi disk
/dev/sd is a hard disk /sd[a-z] - naming format for our disks.
sudo fdisk -l shows the capacity of a hard disk
lsblk - available block devices connected to the system. It displays the output in a tree-like structure
```

mount allows filesystem accessible in the Linux directory tree. Normally `/mnt` directory is used for mounting

```
mount
sudo mount /dev/sdb1 /mnt/media
-t option to specify the file system type
mount -t TYPE DEVICE_NAME DIRECTORY
mount -o OPTIONS DEVICE_NAME DIRECTORY
/dev contains device files
```


