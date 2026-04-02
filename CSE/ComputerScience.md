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
1. CPU executes the commands from programs or applications. A few applications will keep running in the background. You can accelerate the speed by turning them off. The best indicator is the CPU clock speed or CPU frequency (unit GHz or billions of pulses per second), which shows how many cycles per second it can complete. Higher value means faster CPU is faster and applications are faster. For gaming 3.5 - 4.0 GHz is good. A single CPU can execute n tasks (= n cores). CPU contains controller (memory accessing and data I/O), cores, cache (shared with all cores). CPU estaibles the communication btwn cores and system
2. Cores actually processes the tasks. CPU controls the Cores. Uni processor 1 CPU = 1 Core. Multi processor 1 CPU. Core contains control unit (communication of core/hardware), Arithmetic logic unit (executes the A/L operations), memory (registers - keep addresses, instructions, and results of calculations and cache -high-speed random access memory that holds data that the core probably will (re)use). Core cahche memory is smaller, faster to access when compard to RAM. This memory caching improves the performance. Cache Memory Is Much Faster Than RAM. Memory path: Hard distk -> RAM -> Cache memory of CPU. Cache memory operates with a higher clock speed and lower access latency, resulting in faster data retrieval
3. Networking - exchange data and share resources with each other
4. RAM - short term memory or temporary storage where data is stored as the processor needs it. RAM is soldered directly into the main board of the computer. Hence faster than anything. RAM write and read speed = 2-20GB/s.

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

# 🚀 HPC Performance Monitoring & Optimization Guide

A concise, command-focused reference for **monitoring, analyzing, and optimizing** High-Performance Computing (HPC) systems.  
Use this guide to identify bottlenecks, measure performance, and apply system-level accelerations.

---

## 🧭 1. Establish a Baseline

Before tuning, collect key stats to understand normal system behavior.

### 🧠 CPU
```bash
top -d 1
htop
mpstat -P ALL 1
```
**Indicators:**
- `%us`: High = CPU-bound workload  
- `%sy`: High = kernel overhead  
- `%wa`: High = waiting on I/O  

### 💾 Memory
```bash
free -m
vmstat 1
sar -B 1
```
**Indicators:**
- High swap use → Not enough RAM  
- High page faults → Inefficient memory access  

### 📀 Disk I/O
```bash
iostat -xz 1
df -h
```
**Indicators:**
- High `await` → Slow disk responses  
- High `%util` → Disk saturation  

### 🌐 Network
```bash
sar -n DEV 1
ifstat 1
ss -tuna
```
**Indicators:**
- Packet drops  
- High bandwidth use  
- Connection latency or retransmissions  

---

## 🧩 2. Sampling & Profiling (`perf`)

Low-overhead profiling to find CPU hotspots.

```bash
perf stat ./app             # Summary of CPU usage
perf record -g ./app        # Capture stack traces
perf report                 # Analyze performance report
```

**Key metrics:**
- **IPC < 1.0:** CPU stalls  
- **Cache misses:** Poor memory access patterns  
- **Branch misses:** Inefficient control flow  

---

## 🎯 3. Tracing & Deep Inspection

For detailed event-level visibility.

### 🧵 ftrace (Kernel Scheduler Tracing)
```bash
cd /sys/kernel/debug/tracing
echo 1 > events/sched/sched_switch/enable
cat trace | head -n 20
```
**Shows:** Context switches, scheduling latency, CPU migrations.

### 🧠 eBPF Tools (Safe & Powerful)
```bash
sudo biolatency 10        # I/O latency histogram
sudo execsnoop             # Track process execution
sudo tcpconnect            # Trace TCP connections
sudo cachestat 1           # Cache hit/miss ratio
```

Install:
```bash
sudo apt install bpfcc-tools
```

---

## 📈 4. Continuous Monitoring & Logging

Track performance trends during runs.

```bash
sar -u -r -n DEV 10 > system.log &
pidstat -p <PID> 1 >> detail.log &
```

Check logs later:
```bash
sadf -d system.log | grep "<component>"
```

---

## ⚙️ 5. Optimization Techniques

Once bottlenecks are found, apply targeted improvements.

### 💪 CPU
- Improve **cache locality** (reorder data structures)
- Enable **SIMD/vectorization**: `gcc -O3 -march=native`
- Increase parallelism (OpenMP, MPI)

### 🧩 Memory
- Reuse buffers to reduce allocations
- Optimize data layout for fewer cache misses
- For NUMA systems:
  ```bash
  numactl --interleave=all ./app
  ```

### 💽 Disk
- Use **async I/O (io_uring)** or **batch requests**
- Combine small I/O operations into large sequential ones
- Prefer SSD/NVMe over HDD

### 🌐 Network
- Minimize round-trips (batch operations)
- Enable jumbo frames for HPC fabrics:
  ```bash
  sudo ifconfig eth0 mtu 9000 up
  ```
- Use RDMA/Infiniband if available

---

## 🔁 6. Performance Optimization Loop

| Step | Description | Example Command |
|------|--------------|----------------|
| Measure | Establish baseline | `perf stat ./app` |
| Analyze | Drill down to find hotspots | `perf record -g ./app` |
| Optimize | Apply hardware/software fixes | Code or tuning changes |
| Validate | Confirm improvements | `perf stat ./app` (compare IPC) |

Repeat until optimal performance is achieved.

Example workflow:
```bash
perf stat ./app
perf record -g ./app
perf report
# Apply optimizations (code or config)
perf stat ./app
```

---

## ⚡ 7. System Acceleration Tips

| Action | Command | Result |
|--------|----------|---------|
| Pin threads to cores | `taskset -c 0-7 ./app` | Reduce scheduler migration |
| Max CPU frequency | `cpupower frequency-set -g performance` | Avoid frequency scaling latency |
| Enable huge pages | `echo 2048 > /proc/sys/vm/nr_hugepages` | Improve memory TLB efficiency |
| Optimize parallel jobs | `mpirun -np 8 ./app` | Use all cores efficiently |

---

## 🧠 Quick Reference Summary

| Resource | Tool | Purpose |
|-----------|------|----------|
| CPU | `top`, `mpstat`, `perf` | Utilization & hotspots |
| Memory | `free`, `vmstat`, `numastat` | Pressure & locality |
| Disk | `iostat`, `biolatency` | I/O latency |
| Network | `sar -n`, `ss`, `tcpconnect` | Connectivity & throughput |
| Tracing | `ftrace`, `bpftrace` | Low-level event tracing |
| Optimization | `taskset`, `cpupower`, `numactl` | Core-level tuning |

---

## 🧩 Example HPC Tuning Workflow

1. **Monitor:**  
   ```bash
   vmstat 1
   ```
2. **Profile:**  
   ```bash
   perf record -g ./matrix_multiply
   ```
3. **Analyze:**  
   ```bash
   perf report
   ```
4. **Optimize Code:**  
   - Add loop unrolling / vectorization  
   - Parallelize inner loops  
   - Improve data layout  

5. **Re-test:**  
   ```bash
   perf stat ./matrix_multiply
   ```

---

## 🧰 8. Useful Packages

| Package | Description |
|----------|--------------|
| `sysstat` | `sar`, `iostat`, `mpstat` utilities |
| `bpfcc-tools` | eBPF tracing toolkit |
| `perf` | CPU profiling and PMU metrics |
| `cpupower` | CPU frequency and governor control |
| `numactl` | NUMA binding and interleave control |

---

## ✅ 9. Workflow Summary

1. Measure  
2. Identify bottleneck  
3. Analyze (perf/trace)  
4. Optimize hardware or code  
5. Validate results  
6. Document changes  

---

🧩 **Goal:** Lower latency, higher throughput, efficient resource use.  
🚀 **Repeat regularly** — performance tuning is an ongoing process.

---
