# Computer Science

### Unit for data volume

******************************
1. a **Kilobyte** is one thousand bytes (10^3 bytes).
2. a **Megabyte** is a million bytes (10^6 bytes).
3. a **Gigabyte** is a billion bytes (10^9 bytes).
4. a **Terabyte** is a trillion bytes (10^12 bytes).
5. a **Petabyte** is 1,000 Terabytes (10^15 bytes).
6. an **Exabyte** is 1,000 Petabytes (10^18 bytes).
7. a **Zettabyte** is 1,000 Exabytes (10^21 bytes).
8. a **Yottabyte** is 1,000 Zettabytes (10^24 bytes).
******************************

### To process anything in computer
******************************
1. CPU executes the commands from programs or applications. A few applications will keep running in the background. You can accelerate the speed by turning them off. The best indicator is the CPU clock speed or CPU frequency (unit GHz or billions of pulses per second), which shows how many cycles per second it can complete. Higher value means faster CPU is faster and applications are faster. For gaming 3.5 - 4.0 GHz is good. 
2. Networking - exchange data and share resources with each other
3. RAM - short term memory or temporary storage where data is stored as the processor needs it. RAM is soldered directly into the main board of the computer. Hence faster than anything. RAM write and read speed = 2-20GB/s.

$$ t = { 1000  \over 20  }  =  50 seconds for 1 Petabyte$$

5. Hard disk is a permanent computer storage. Hard disk drives are mechanical devices that runs slowly than RAM. 

$$ t = { 1048576 * 3600 \over 160 }  =  1.82 hours for 1 Petabyte $$

******************************


### Read, Write Speed of storage devices
******************************
1. HDDs, found in desktop computers, are either designed to read and write faster or to store data. Standard HDD reads and writes at typical rates typical 80MB/s to 160MB/s.
 
$$ t = { 1048576 * 3600 \over 160 }  =  1.82 hours for 1 Petabyte $$

3. SSDs are built for both short-term and long-term backups, they are more frequently used in applications that require speed.  SSD reads and writes data at a rate of between 200MB/s and 550MB/s.

$$ t = { 1048576 * 3600 \over 550 }  = 0.529 hours for 1 Petabyte$$

******************************

### Computer Basics
******************************
1. Operating system manages the computer hardware and software and acts a middle man between hardware and user.

Desktop OS - Windows, MAC OS, Ubuntu

Server OS - Windows server, Centos, Red hat linx distribution

Mobile OS - Android, MAC

Embedded OS - router, TV, automobiles.

Real time OS - medical device, aerospace

******************************

### Memory consumption of an application 
[Massif](https://courses.cs.washington.edu/courses/cse326/05wi/valgrind-doc/ms_main.html) displays how much a program or process uses memory (includes both virtual (Hard Disk Swapped) and resident (RAM) memory)
```
valgrind --tool=massif --time-unit=ms --pages-as-heap=yes executable
ms_print massif.out |less 
```

