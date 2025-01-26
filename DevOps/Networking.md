# Networking
*********************

### Architecture
*********************
* **Client-server architecture**
1. Client: The client is the computer or device that requests a service from the server. Clients are often situated at workstations or on personal computers. 
2. Server: The server is the computer that provides the requested service to the client. Servers are typically more powerful machines located elsewhere on the network.
3. Network protocols: The client and server communicate over a network using standard communication protocols like TCP/IP.
* **OSI model** Open Systems Interconnection model. It contains seven distinct layers, each with specific responsibilities for facilitating communication between devices:
1. Physical Layer: This layer deals with the physical equipment involved in the data transfer, such as cables, connectors, and signal transmission. For example, when you plug an Ethernet cable into your computer, the physical layer is responsible for the electrical and mechanical specifications of that connection.
2. Data Link Layer: This layer is responsible for reliable node-to-node data transfer, detecting and correcting errors that may occur in the Physical layer. It organizes the bits into frames. For instance, when you send data over a local network, the Data Link layer will package the data into frames and handle error checking.
3. Network Layer: The Network layer is responsible for logical addressing and routing data between different networks. The most well-known protocol at this layer is IP (Internet Protocol). For example, when you access a website, the Network layer determines the route the data should take to reach the destination server.
4. Transport Layer: This layer ensures complete data transfer between applications, providing features like error correction and flow control. Protocols like TCP (Transmission Control Protocol) operate at this layer. For example, when you download a file, the Transport layer breaks the file into smaller segments, ensures they are delivered correctly, and reassembles them at the destination.
5. Session Layer: The Session layer establishes, maintains, and synchronizes communication sessions between applications. It provides checkpointing, restart, and restart capabilities. For instance, when you start a video call, the Session layer manages the connection between the two devices.
6. Presentation Layer: This layer is responsible for translating data between different formats and encodings, ensuring applications can understand each other. For example, when you view an image on a website, the Presentation layer ensures the image data is displayed correctly on your device.
7. Application Layer: The Application layer is the layer closest to the user, providing network services directly to applications like web browsers, email clients, and file transfer programs. For example, when you send an email, the Application layer protocols like SMTP (Simple Mail Transfer Protocol) handle the email transmission.
* **switch** is a data link layer (layer 2) device that connects multiple devices on a local area network (LAN) by forwarding data packets between them based on their destination MAC addresses.
 Switches create and manage a single network.
* **router** is a network layer (layer 3) device that connects multiple networks together by forwarding data packets between them based on their destination IP addresses.
 Routers are used to connect LANs, MANs, and WANs. The key differences are:
1. Switches operate at layer 2 while routers operate at layer 3 of the OSI model.
2. Switches are used within a single network, while routers are used to connect multiple networks.
3. Switches forward data in the form of frames, while routers forward data in the form of packets.
4. Switches have less collision and less routing complexity compared to routers.
5. Routers are generally more expensive than switches.
* **Better Picture**
1. **Application Layer (Layer 7)** : Your browser initiates the request for google.com. The Domain Name System (DNS) protocol is used to translate "google.com" into an IP address. An HTTP or HTTPS request is prepared to fetch the webpage.
```text
GET / HTTP/1.1
Host: www.google.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
```
2. **Presentation Layer (Layer 6)** The data is formatted and potentially encrypted for transmission. If using HTTPS, this layer handles the encryption of the request.
```text
TLS 1.2 Record Layer: Application Data Protocol: http-over-tls
    Content Type: Application Data (23)
    Version: TLS 1.2 (0x0303)
    Length: 517
    Encrypted Application Data: 8f3a7c2e9b0f1d5e6a4c2b8d0e3f7a9c1b5d8e2f4a6c0b3d7f1e9a2c4b8d0e3f7a9
    Encrypted Application Data: e2f4a6c0b3d7f1e9a2c4b8d0e3f7a9c1b5d8e2f4a6c0b3d7f1e9ddfdfdfbfbfgbgb
```
3. **Session Layer (Layer 5)** : A session is established between your browser and Google's servers. Session parameters and encryption algorithms are negotiated.
4. **Transport Layer (Layer 4)** : The HTTP request is broken down into smaller segments. TCP (Transmission Control Protocol) is typically used to ensure reliable delivery.
```text
TLS Record Header:
Content Type: Application Data (23)
Version: TLS 1.2 (0x0303)
Length: 517
Segment 1:8f3a7c2e9b0f1d5e6a4c2b8d0e3f7a9c1b5d8e2f4a6c0b3d7f1e9a2c4b8d0e3f7a9
Segment 2: e2f4a6c0b3d7f1e9a2c4b8d0e3f7a9c1b5d8e2f4a6c0b3d7f1e9ddfdfdfbfbfgbgb
```
5. **Network Layer (Layer 3)** The segments are broken down into packets. IP addresses of your computer and Google's servers are added to each packet. The best route for sending packets across the Internet is determined.
```text
IP Header:
  Source IP: [Client IP address]
  Destination IP: [Server IP address]
TCP Header:
  Source Port: [Client port]
  Destination Port: 443 (typical for HTTPS)
Payload:
  TLS Record Header + Encrypted Application Data

TLS Record:
Content Type: Application Data (23)
Version: TLS 1.2 (0x0303)
Length: 517 bytes
Encrypted Application Data:
8f3a7c2e9b0f1d5e6a4c2b8d0e3f7a9c1b5d8e2f4a6c0b3d7f1e9a2c4b8d0e3f7a9...
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Version|  IHL  |    DSCP   |ECN|          Total Length         |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         Identification        |Flags|     Fragment Offset     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  Time to Live |    Protocol   |        Header Checksum        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       Source IP Address                       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Destination IP Address                     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options                    |    Padding    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                             Data                              |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

``` 
6. **Data Link Layer (Layer 2)** Packets are further broken down into frames. Frame headers containing MAC addresses are added. 
```text
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                      Preamble (7 bytes)                       |
+                                               +-+-+-+-+-+-+-+-+
|                                               |    SFD        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                   Destination MAC Address (6 bytes)           +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                     Source MAC Address (6 bytes)              +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|        EtherType/Length       |                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                               +
|                                                               |
+                         Payload (46-1500 bytes)               +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                        FCS (4 bytes)                          |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

```
7. **Physical Layer (Layer 1)** The frames are converted into electrical signals (for wired connections) or radio waves (for wireless connections). These signals are transmitted over the physical medium.
```text
Ethernet Frame:
|--------------------|---------------------|---------------------|
| Preamble (7 bytes) | SFD (1 byte)        | Dest MAC (6 bytes)  |
| 10101010 10101010  | 10101011            | 00:1A:2B:3C:4D:5E   |
| (repeated 7 times) |                     | 00011010 00101011   |
|                    |                     | 00111100 01001101   |
|                    |                     | 01011110            |
|--------------------|---------------------|---------------------|
| Source MAC (6 bytes)     | EtherType (2 bytes)   |
| 00:E0:4C:68:0F:1D        | 0x0800 (IPv4)         |
| 00000000 11100000        | 00001000 00000000     |
| 01001100 01101000        |                       |
| 00001111 00011101        |                       |
|--------------------------|------------------------|

IPv4 Packet (Payload of Ethernet Frame):
|------------------------|------------------------|
| Version (4 bits)       | IHL (4 bits)           |
| 0100 (IPv4)            | 0101 (20 bytes)        |
|------------------------|------------------------|
| DSCP (6 bits) | ECN (2 bits) | Total Length (16 bits) |
| 000000        | 00           | 0000000000101000      |
|                              | (40 bytes)            |
|-------------------------------------------|-----------|
| Identification (16 bits)     | Flags (3 bits) |
| 0000000000000001             | 010 (Don't Fragment) |
|---------------------------|-------------------------|
| Fragment Offset (13 bits) | TTL (8 bits) |
| 0000000000000              | 01000000 (64) |
|---------------------------|-----------------|
| Protocol (8 bits)         | Header Checksum (16 bits) |
| 00000110 (TCP)            | 1010101010101010          |
|---------------------------|----------------------------|
| Source IP (32 bits)                                   |
| 11000000 10101000 00000001 00000001 (192.168.1.1)     |
|--------------------------------------------------------|
| Destination IP (32 bits)                               |
| 11000000 10101000 00000001 00000010 (192.168.1.2)     |
|--------------------------------------------------------|

TCP Segment (Payload of IPv4 Packet):
|---------------------------|---------------------------|
| Source Port (16 bits)     | Destination Port (16 bits)|
| 0000000000010100 (20)     | 0000000001011010 (90)     |
|---------------------------|---------------------------|
| Sequence Number (32 bits)                             |
| 00000000000000000000000000000001                      |
|--------------------------------------------------------|
| Acknowledgment Number (32 bits)                        |
| 00000000000000000000000000000000                      |
|--------------------------------------------------------|
| Data Offset | Reserved | Flags | Window Size (16 bits) |
| (4 bits)    | (6 bits) | (6 bits) | 0000000011111111   |
| 0101        | 000000   | 000010   | (255)              |
|             |          | (SYN)    |                    |
|--------------------------------------------------------|
| Checksum (16 bits)        | Urgent Pointer (16 bits)   |
| 1111111100000000          | 0000000000000000           |
|---------------------------|----------------------------|
| Options (if any) + Padding                             |
| (not shown in this example)                            |
|--------------------------------------------------------|
| Data (if any)                                          |
| (not shown in this example)                            |
|--------------------------------------------------------|

``` 
* **Host-to-host communication** refers to the ability for computers (hosts) to directly communicate with each other over a network, rather than requiring all traffic to pass through a central system.
1. ARPANET was the first network to enable direct communication between computers, rather than requiring all traffic to pass through a central system.
2. This was achieved through the use of a distributed routing algorithm, where each node (computer) on the network was equipped with a special-purpose computer called an Interface Message Processor (IMP) responsible for routing data packets.
3. The IMPs communicated with each other using a protocol called the Network Control Program (NCP), which was developed specifically for ARPANET.
4. The end-to-end principle was a key design concept of ARPANET, where most of the intelligence and complexity was located at the endpoints (the individual computers) rather than the network itself.
5. ARPANET also pioneered the use of a layered protocol stack, with each layer responsible for a different aspect of network communication. This led to the development of the TCP/IP protocol suite, which remains a fundamental standard for internet communication today.
 
 ### Important terminology
 * **MAC MEDIA ACCESS CONTROL address** Identifies a device's network interface at the local network level (data link layer). 48-bit hexadecimal number (e.g., 00:11:22:33:44:55). Assigned by the manufacturer of the network interface card (NIC). Unique within a local network segment. Generally permanent and does not change. Not easily visible to third parties outside the local network.  for local data link layer communication and broadcast/multicast
 * **IP address** Identifies a device's logical network connection at the global internet level (network layer). 32-bit (IPv4) or 128-bit (IPv6) numerical address (e.g., 192.168.1.1 or 2001:0db8:85a3:0000:0000:8a2e:0370:7334). Assigned by the network administrator or internet service provider (ISP). Unique within the global internet. Can change, especially for dynamic IP addresses. Can be more easily discovered by third parties. Used for global internet routing and communication. An IP address is composed of two main parts:
1. Network ID : The network ID is the part of the IP address that identifies the network the device is connected to. The network ID is the prefix or first part of the IP address. All devices on the same network will share the same network ID.
2. Host ID : The host ID is the part of the IP address that identifies the specific device or host on the network. The host ID is the last part of the IP address. Each device on the same network must have a unique host ID. For example, in the IP address 192.168.123.132: 192.168.123 is the network ID .132 is the host ID The network ID and host ID together uniquely identify the device on the overall network. The network ID specifies the network, while the host ID specifies the particular device within that network.
* **Private IP Addresses:** Used within a local network, such as a home or office, Assigned by the router and not visible to the public internet, Examples of private IP address ranges: 10.0.0.0 - 10.255.255.255, 172.16.0.0 - 172.31.255.255, 192.168.0.0 - 192.168.255.255, Example private IP address: 192.168.1.10, Private IP addresses are secure and only accessible within the local network.
* **Public IP Addresses:** Used to identify a device on the public internet, Assigned by the internet service provider (ISP), Example public IP address: 17.5.7.8, Public IP addresses are unique across the internet and allow devices to communicate with the broader internet, Public IP addresses can be traced back to the ISP and may reveal the geographical location.
* **Difference between MAC and public ip address** : MAC addresses are used to identify devices on a local network, while public IP addresses are used to identify devices on the public internet. MAC  addresses are assigned by the manufacturer to the network interface card (NIC) of a device and are unique at the local network level. They operate at the data link layer (layer 2) of the OSI model. Public IP addresses, on the other hand, are assigned by the internet service provider (ISP) to identify a device on the public internet. They operate at the network layer (layer 3) of the OSI model and are used for routing data packets across networks. While both MAC and public IP addresses serve to uniquely identify devices, they are used at different layers of the network stack and for different purposes. MAC addresses are used for local delivery of data packets within a local network, while public IP addresses are used for global communication across the internet
* The key differences among ip, port number, mac: IP addresses operate at the network layer, while MAC addresses operate at the data link layer. Public IP addresses are used for global internet. communication, while private IP addresses are used for local network communication. MAC addresses are used for local delivery of data packets within a network. Port numbers identify applications on a device, while IP addresses identify the device itself
* **port** in networking is a logical construct that identifies a specific process or network service. It is a 16-bit unsigned integer number ranging from 0 to 65535 that is assigned to uniquely identify a connection endpoint and direct data to a specific service. The key points about ports in networking are:
1. Ports are used by transport layer protocols like TCP and UDP to identify specific applications or services.
2. Each network connection is identified by a combination of the local IP address, local port, remote IP address, and remote port.
3. Well-known ports below 1024 are reserved for common services like HTTP (port 80), FTP (port 21), and SSH (port 22).
4. Ports above 1024 are available for general use by applications and are known as registered or ephemeral ports.
5. Ports provide a way for multiple services or communication sessions to utilize the same network address.
6. Firewalls use port numbers to control network access and security by allowing or blocking traffic on specific ports.
7. In summary, ports are an essential component of network communication, allowing multiple applications and services to utilize the same network address by uniquely identifying each connection.
* **IP packet** consists of a header and a payload. The header contains important information required for routing and delivering the packet, including the sender's IP address, the recipient's IP address, and other control information. The payload carries the actual data or content being transmitted, such as a web page, email message, or file. IP packets are the fundamental building blocks of communication over the internet and other IP-based networks. IP packets enable features like file transfer, voice/video communication, streaming, VPNs, and IoT by breaking down data into smaller units that can be efficiently transmitted and routed across networks. Routers use the source and destination IP addresses in the packet header to determine the best path to forward the packet to its final destination\
The main components of an IP packet are:
**IP Header**:
Version (4 bits for IPv4, 6 bits for IPv6)
Header Length (4 bits)
Type of Service (8 bits)
Total Length (16 bits)
Identification (16 bits)
Flags (3 bits)
Fragment Offset (13 bits)
Time to Live (8 bits)
Protocol (8 bits)
Header Checksum (16 bits)
Source IP Address (32 bits for IPv4, 128 bits for IPv6)
Destination IP Address (32 bits for IPv4, 128 bits for IPv6)
Options (variable length)

**Data Payload**:
The actual data being transmitted, such as a web page, email, or file. 
* **subnetting*** is a fundamental networking concept that allows larger networks to be divided into smaller, more manageable and efficient subnetworks through the use of subnet masks.The subnet mask separates the IP address into the network ID and host ID by setting the network bits to 1 and the host bits to 0. For example, the subnet mask 255.255.255.0 has the first three octets (24 bits) set to 1, indicating the network portion, and the last octet (8 bits) set to 0, indicating the host portion. **All the bits set to 1 in the subnet mask belong to the network portion, while all the bits set to 0 belong to the host portion. Subtracting 2 from the total number of addresses in a subnet accounts for the reserved network address and broadcast address. This ensures that these addresses are not assigned to individual hosts within the subnet, as doing so could lead to routing and communication issues.**
1.   Subnet Mask: 255.255.255.0 -> 11111111.11111111.11111111.00000000 -> 24 1s and 8 0s
This subnet mask allocates 24 bits for the network portion and 8 bits for the host portion.
With 8 bits for the host portion, the maximum number of host addresses is 2^8 - 2 = 254 (the -2 is to account for the network and broadcast addresses).
Therefore, the maximum number of devices that can be connected with this subnet mask is 254.
2. Subnet Mask: 255.255.254.0 -> 11111111.11111111.11111110.00000000 -> 23 1s and 9 0s
This subnet mask allocates 23 bits for the network portion and 9 bits for the host portion.
With 9 bits for the host portion, the maximum number of host addresses is 2^9 - 2 = 510 (the -2 is to account for the network and broadcast addresses).
Therefore, the maximum number of devices that can be connected with this subnet mask is 510.
3. Subnet Mask: 255.255.0.0 -> 11111111.11111111.00000000.00000000 -> 16 1s and 16 0s
This subnet mask allocates 16 bits for the network portion and 16 bits for the host portion.
With 16 bits for the host portion, the maximum number of host addresses is 2^16 - 2 = 65,534 (the -2 is to account for the network and broadcast addresses).
Therefore, the maximum number of devices that can be connected with this subnet mask is 65,534.
4. Subnet Mask: 255.0.0.0 -> 11111111.00000000.00000000.00000000 -> -> 8 1s and 24 0s
This subnet mask allocates 8 bits for the network portion and 24 bits for the host portion.
With 24 bits for the host portion, the maximum number of host addresses is 2^24 - 2 = 16,777,214 (the -2 is to account for the network and broadcast addresses).
Therefore, the maximum number of devices that can be connected with this subnet mask is 16,777,214.
* **default gateway** is a router or network node that serves as an access point to another network, typically the internet.  It is the node that a device uses to forward network packets when the destination is not on the same local network.
* **ICMP Internet Control Message Protocol** is a supporting protocol in the Internet protocol suite that is used by network devices, including routers, to send error messages and operational information indicating success or failure when communicating with another IP address.

The ICMP header comes after the IP header and contains the following main fields:
Type (8 bits): Specifies the type of ICMP message, such as Echo Request (type 8), Echo Reply (type 0), Destination Unreachable (type 3), etc. \
Code (8 bits): Provides more detail on the specific type of ICMP message. For example, the Destination Unreachable message has different codes like "Network Unreachable" (code 0), "Host Unreachable" (code 1), etc. \
Checksum ( 16 bits): A checksum calculated over the ICMP header and data to detect errors. The ICMP header is then followed by additional fields that depend on the specific ICMP message type. \
For example: For Echo Request/Reply, there are Identifier and Sequence Number fields. For Destination Unreachable, there is an unused field followed by the original IP header and first 64 bits of the original datagram. ICMP provides feedback and control messages to help IP deal with errors and problems in data transmission. ICMP is used to send and receive messages that report errors, test connectivity, or provide information about the network.  ICMP is a connectionless but reliable protocol, ensuring that control messages are delivered correctly. ICMP supplements IP by providing additional features like error reporting, network diagnostics, and troubleshooting. ICMP is a supporting protocol that works together with IP to enable communication between devices.

* **TTL (Time to Live)** in networking refers to the mechanism used to prevent data packets from circulating indefinitely in a network. Here's an explanation with an example:
TTL is an 8-bit field in the IP packet header that specifies the maximum number of hops a packet can traverse before being discarded. When a packet is sent, the source device sets an initial TTL value, typically 64 for Linux/Unix or 128 for Windows.

Here's an example of how TTL works:
1. Host A wants to send a packet to Host B. Host A sets the initial TTL value to 64.
2. The packet is sent to Router A, which is the gateway for Host A's network. Router A receives the packet and decrements the TTL value by 1, so the TTL is now 63.
3. Router A then forwards the packet to Router B, which is on the path to Host B. Router B decrements the TTL by 1 again, so the TTL is now 62.
4. This process continues as the packet hops from one router to the next, with each router decrementing the TTL value by 1.
5. If the packet reaches a router where the TTL value has been decremented to 0, that router will discard the packet and send an ICMP "Time Exceeded" message back to the source (Host A).
This TTL mechanism prevents packets from looping indefinitely in the network, which could lead to network congestion and other issues. The TTL value is used by network utilities like ping and traceroute to determine the number of hops a packet takes to reach a destination. In addition to IP packets, TTL is also used in other networking contexts, such as:
1. DNS caching: DNS records have a TTL value that determines how long a DNS resolver can cache the record before needing to refresh it.
2. CDN caching: Content Delivery Networks (CDNs) use TTL to control how long cached content is served from their edge servers before fetching a new copy from the origin server.
By properly configuring TTL values, network administrators can optimize network performance, security, and reliability.

* **Traceroute** is a network diagnostic tool used to determine the path that IP packets take from one host to another over an IP network. It works by sending a series of UDP packets to the destination host, with each packet having a Time to Live (TTL) value set to a specific number. Here's how it works:
1. The first packet has a TTL of 1, which causes the first router to send back an ICMP "Time Exceeded" message when it receives the packet
2. Traceroute records the IP address of this first router and the round-trip time for the packet
3. Each subsequent packet has its TTL incremented by 1, causing it to be dropped by the next router in the path
4. This process continues until the packet reaches the destination host, which responds with an ICMP "Port Unreachable" message, indicating that the destination has been reached
5. Traceroute displays the IP addresses of the routers along the path and the round-trip times for each hop \
`traceroute javatpoint.com` will give you \
```text
traceroute to javatpoint.com (13.232.200.100), 64 hops max, 52 byte packets
 1  10.0.0.1 (10.0.0.1)  0.321 ms  0.288 ms  0.271 ms
 2  192.168.1.1 (192.168.1.1)  1.005 ms  0.921 ms  0.899 ms
 3  100.64.0.1 (100.64.0.1)  5.321 ms  5.288 ms  5.271 ms
 4  209.85.252.165 (209.85.252.165)  10.005 ms  9.921 ms  9.899 ms
 5  72.14.232.84 (72.14.232.84)  15.321 ms  15.288 ms  15.271 ms
 6  142.251.49.206 (142.251.49.206)  20.005 ms  19.921 ms  19.899 ms
 7  13.232.200.100 (13.232.200.100)  25.321 ms  25.288 ms  25.271 ms
```
* **ARP (Address Resolution Protocol)** is a communication protocol used for discovering the link layer address, such as a MAC address, associated with a given internet layer address, typically an IPv4 address. Key points about ARP:
1. ARP is used to map an IP address to its corresponding MAC address
2. It operates at the data link layer (Layer 2) of the OSI model
3. ARP uses a request-response mechanism to discover the MAC address associated with an IP address
4. ARP requests are broadcast to all devices on the local network, while responses are unicast directly to the requesting device
5. The ARP protocol is defined in RFC 826 and is an Internet Standard (STD 37)
6. In IPv6 networks, ARP is replaced by the Neighbor Discovery Protocol (NDP) \
ARP is necessary because IP addresses are logical addresses used for routing, while MAC addresses are physical addresses used for local delivery of frames . Devices need to know the MAC address of the destination in order to send frames on the local network. ARP can be vulnerable to spoofing attacks, where a malicious user replies to an ARP request with a false MAC address in order to intercept traffic. Proxy ARP is a legitimate use of ARP where a router answers ARP requests on behalf of other devices
* **network interface** is the point of interconnection between a computer and a network, either a private or public network. It is the hardware component, typically a network interface card (NIC), that allows the computer to access and communicate over the network. Each network interface is assigned a unique address, as network interfaces are the endpoints of the network. The main function of a network interface is to inject packets into the network and retrieve packets from the network.

### UDP User Datagram Protocol
*********************************
UDP is a simple, connectionless transport layer protocol that is part of the Internet Protocol suite. Unlike the connection-oriented Transmission Control Protocol (TCP), UDP does not require prior communication to set up special transmission channels or data paths. The UDP header is 8 bytes and contains source and destination ports, length, and checksum fields. Some key characteristics of UDP:
1. It provides checksums for data integrity and port numbers for addressing different functions at the source and destination.
2. It has no handshaking dialogues, no guaranteed delivery, ordering, or duplicate protection.
3. It is suitable for time-sensitive applications that prefer dropped packets to delayed packets, such as video streaming, online games, and VOIP
4. It is transaction-oriented, suitable for simple query-response protocols like DNS and NTP.
5. It is stateless, suitable for very large numbers of clients, such as in streaming media applications.
6. It supports multicast, suitable for broadcast information like service discovery and shared information. \
Examples of applications that commonly use UDP include:
1. Video streaming and online gaming - UDP's low latency and lack of retransmission delays make it well-suited for real-time applications that can tolerate some packet loss.
2. Voice over IP (VoIP) - VoIP uses UDP to transmit voice data, as a static-y conversation is preferable to one with heavy delays.
3. Domain Name System (DNS) lookups - DNS servers use UDP for fast, efficient responses.
4. Network Time Protocol (NTP) - NTP uses UDP for simple query-response time synchronization.
5. Trivial File Transfer Protocol (TFTP) - TFTP uses UDP for lightweight file transfers. \
In summary, UDP is a lightweight, fast, connectionless protocol suitable for real-time, loss-tolerant applications, while TCP provides reliability and ordering at the cost of higher overhead and latency.

* Multiplexing and demultiplexing are key functions performed by the transport layer protocols TCP and UDP to enable communication between multiple applications on a host.
1. Multiplexing is the process of combining multiple data streams from different application processes on the sender side into a single stream for transmission over the network. It involves adding a header to each data unit that includes source and destination port numbers to identify the sending and receiving applications.
2. Demultiplexing is the reverse process on the receiving side. The transport layer uses the destination port number in the header to deliver the incoming data to the correct application process. This allows multiple applications on a host to utilize the network simultaneously.
3. The main differences between TCP and UDP multiplexing/demultiplexing: TCP uses the 4-tuple of source IP, source port, destination IP, destination port for connection identification. UDP only uses the destination IP and port. TCP maintains connection state, so the 4-tuple is needed to track the connection. UDP is connectionless. TCP demultiplexing is more complex, as incoming segments must be matched to the correct connection . UDP just delivers to the port. In summary, multiplexing combines data from multiple applications for transmission, while demultiplexing separates it back out on the receiving end using port numbers . The specific mechanisms differ between TCP and UDP based on their connection-oriented vs connectionless nature.
```python
# CHAT 1
import socket
from urllib.request import urlopen
import re

def getIP():
    url = urlopen('http://checkip.dyndns.com/')
    return re.compile(r'Address: (\d+\.\d+\.\d+\.\d+)').search(str(url.read())).group(1)


hostname = socket.gethostname()
ip_address = socket.gethostbyname(hostname)

CHAT1_IP_ADDRESS = str(ip_address) # string(get(IP))
CHAT1_PORT = 6400
MAX_BYTES=1024
print(CHAT1_IP_ADDRESS, CHAT1_PORT)
CHAT2_IP_ADDRESS = '127.0.0.1'
CHAT2_PORT = 6401
with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
    s.bind((CHAT1_IP_ADDRESS, CHAT1_PORT))
    print(f'Chatter 1 Listening on {CHAT1_IP_ADDRESS}:{CHAT1_PORT}')
    while True:
        data, addr = s.recvfrom(MAX_BYTES)
        print(f'Received from {addr}: {data.decode()}')
        message = input('Enter your message: ')
        s.sendto(message.encode(), (CHAT2_IP_ADDRESS, CHAT2_PORT))
``` 
```python
# CHAT 2
import socket
from urllib.request import urlopen
import re

def getIP():
    url = urlopen('http://checkip.dyndns.com/')
    return re.compile(r'Address: (\d+\.\d+\.\d+\.\d+)').search(str(url.read())).group(1)

hostname = socket.gethostname()
ip_address = socket.gethostbyname(hostname)

CHAT2_IP_ADDRESS = '127.0.0.1' # string(get(IP))
CHAT2_PORT = 6401
MAX_BYTES=1024

CHAT1_IP_ADDRESS = '127.0.0.1'
CHAT1_PORT = 6400

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:

    s.bind((CHAT2_IP_ADDRESS, CHAT2_PORT))
    print(f'Chatter 2 Listening on {CHAT2_IP_ADDRESS}:{CHAT2_PORT}')

    while True:
        message = input('Enter your message: ')
        s.sendto(message.encode(), (CHAT1_IP_ADDRESS, CHAT1_PORT))

        data, addr = s.recvfrom(MAX_BYTES)
        print(f'Received from {addr}: {data.decode()}')
```

### Commands
***********************
* **tcpdump** us a analyzer tool that can be used to capture and inspect network traffic on a Linux/Unix system by capturing IP, arp, icmp packets on the network interface.
1. **sudo tcpdump -D** To display all available interfaces
2. **sudo tcpdump -i <interfacename> arp** This will capture all ARP packets on the specified interface, and you can then analyze the output to extract the relevant MAC address information. However, the command itself does not directly provide the MAC number - you would need to parse the output to find the MAC addresses. **sudo tcpdump -n -i wlp1s0 arp** will display only the mac number and ip address.
3. **sudo tcpdump -n -i <interfacename> icmp** This command will capture and display all ICMP packets that are going through the "wlp1s0" interface on your system. The filter `icmp` that tells tcpdump to only capture ICMP packets.
4. **sudo tcpdump -c 4 -i wlo1** To capture a specific number of packets
5. **sudo tcpdump -n -i <interface> src <ip address>** and **sudo tcpdump -n -i <interface> src <ip address> dest <address>**  This command will capture and display all packets where the source IP address matches the specified <ip address>, the destination IP address matches the specified <address>, and the traffic is going through the specified
6. **sudo tcpdump -A** To print captured packets in ASCII format
7. **sudo tcpdump -i eth0 'tcp port 80 and (tcp[tcpflags] & (tcp-syn|tcp-fin) != 0)'** To capture only HTTP GET and POST packets
8. **sudo tcpdump -i eth0 -n -s 0 -l | egrep -o 'http://[^ ]*'** To extract HTTP request URLs
9. **sudo tcpdump -i eth0 icmp** To capture ICMP packets
10. **sudo tcpdump -nn -l port 25 grep -i 'MAIL FROM\RCPT TO'** To capture SMTP/POP3 email traffic
11. **sudo tcpdump -i eth0 -s0 -w capture.pcap** To write captured packets to a file
12. **sudo tcpdump -i eth0 -s0 -w - | wireshark -k -i -** To view captured packets in Wireshark
13. **sudo tcpdump -i eth0 -A** To capture and display only the ASCII text
14. **sudo tcpdump -i eth0 -X** To capture and display both hex and ASCII
* **nslookup**
1. **nslookup <domain name>** looks the ip address
2. **nslookup -type=mx <domain name>** This will look up the MX (Mail Exchange) record for the domain "example.com".
3. **nslookup <domain name> 8.8.8.8** This will use the DNS server at IP address "8.8.8.8" (Google's public DNS) to look up the domain name. Note that the DNS servers are responsible for the domain name to IP address mapping.
4. **nslookup -** This will put you into the interactive nslookup mode, where you can enter multiple queries.


### TCP 
****************************
* **TCP/IP (Transmission Control Protocol/Internet Protocol)** model is a conceptual framework used to describe the functions of network communication. It is a simpler, four-layer model compared to the more detailed seven-layer OSI (Open Systems Interconnection) model
1. Application Layer: This is the top layer that interacts directly with applications and protocols like HTTP, FTP, SMTP, etc. It provides network services to applications.
2. Transport Layer: Responsible for end-to-end communication and data transfer, providing features like error correction and flow control. The main protocols at this layer are TCP and UDP.
3. Internet Layer: Also known as the Network layer, this layer handles logical addressing and routing of data between networks. The primary protocol is IP (Internet Protocol).
4. Network Access Layer: This bottom layer deals with the physical network hardware and data link protocols for node-to-node data transfer. It corresponds to the Physical and Data Link layers of the OSI model.
5. The key differences between the TCP/IP and OSI models are:
- TCP/IP has a more simplified, four-layer structure compared to OSI's seven layers.
- TCP/IP combines the Presentation and Session layers of OSI into its Application layer.
- TCP/IP follows a more horizontal, connectionless approach, while OSI uses a vertical, connection-oriented model.
- Overall, the TCP/IP model provides a practical, widely-adopted framework for network communication that has been fundamental to the development and growth of the internet.
* TCP is one of the main protocols of the Internet protocol suite, providing reliable, ordered, and error-checked delivery of data between applications running on hosts communicating over an IP network. TCP header, which is typically 20 bytes long. Some key aspects of TCP include:Connection-oriented: TCP establishes a connection between the client and server before data can be exchanged, using a three-way handshake. This ensures reliable data transfer. Ordered data transfer: TCP rearranges out-of-order segments according to sequence numbers to present a reliable byte stream to the application. Retransmission of lost packets: TCP detects lost or corrupted packets and retransmits them to guarantee delivery. Flow control: TCP limits the rate at which the sender transfers data to match the receiver's processing capacity, using a sliding window mechanism. Congestion control: TCP adjusts the sending rate based on network congestion to prevent overloading the network. Abstraction from lower-level networking details: TCP presents a simple, reliable byte stream interface to the application, handling all the underlying networking complexities. TCP is widely used by major internet applications like the web, email, file transfer, and more. It is optimized for reliable, in-order delivery rather than low latency, making it less suitable for real-time applications like VoIP which prefer the connectionless UDP protocol
* TCP connection establishment is a crucial process that enables reliable and synchronized communication between a client and a server. It is achieved through a three-way handshake: **Initiation (SYN)**: The client initiates the connection by sending a TCP packet with the SYN (synchronize) flag set. This packet includes the client's initial sequence number. **Acknowledgment (SYN-ACK)**: The server responds with a TCP packet that has both the SYN and ACK (acknowledge) flags set. This packet acknowledges the client's request and includes the server's own initial sequence number. **Confirmation (ACK)**: Finally, the client sends an ACK packet to the server, acknowledging the server's readiness. The connection is now established, and both the client and server have agreed upon initial sequence numbers and other parameters for secure data exchange. The three-way handshake ensures that both parties are synchronized and ready for reliable communication. It helps prevent data loss, ensures data integrity, and sets the foundation for a secure and orderly data transfer.


### DNS (Domain Name System)
* DNS is built on UDP and port number 53. 
1. DNS Lookup: The client (e.g., a web browser) wants to connect to a website using a domain name (e.g., example.com). The client first performs a DNS lookup to resolve the domain name to an IP address. The client's DNS resolver (typically provided by the ISP or configured manually) queries the DNS hierarchy, starting with the root servers, to find the authoritative DNS server for the domain. The authoritative DNS server for the domain provides the IP address(es) associated with the domain name.
2. TCP Connection Establishment: After obtaining the IP address through the DNS lookup, the client initiates a TCP connection to the server. The client sends a SYN (synchronize) packet to the server's IP address and port. The server responds with a SYN-ACK (synchronize-acknowledge) packet. The client then sends an ACK (acknowledge) packet to the server, completing the three-way handshake and establishing the TCP connection.
3. Data Transfer: Once the TCP connection is established, the client and server can exchange data over the reliable, ordered, and error-checked TCP connection. The client can now send HTTP requests or other application-level data to the server, and the server can respond with the requested content.
* A DNS resolver is a crucial component of the Domain Name System (DNS). It's responsible for converting domain names (like "example.com") into corresponding IP addresses (like "93.184.216.34") that computers use to communicate with each other over a network. When you type a URL into your web browser, your device communicates with a DNS resolver to find the IP address associated with that domain name. The resolver then retrieves the corresponding IP address from a DNS server. This process is essential for browsing the internet because computers communicate using IP addresses, while humans find it easier to remember domain names.  **/etc/resolv.conf** contains the nameserver **IPv4 or IPv6 address or both**
**Local DNS resolver**: Often provided by your Internet Service Provider (ISP) or configured on your local network. It caches DNS records to improve performance and reduce the need to query external DNS servers repeatedly. The **192.168.0.1 address** is likely the IP address of the user's router or modem, which is acting as the default DNS server for the local network. **Public DNS resolver**: These are DNS resolvers operated by third-party organizations like Google, Cloudflare, or OpenDNS. They offer alternative DNS resolution services to those provided by your ISP, often with features like enhanced security, privacy, and faster response times. **Forwarding DNS resolver**: Sometimes used by organizations or larger networks. It forwards DNS queries from clients to another DNS resolver or DNS server for resolution. This setup can improve performance and provide centralized control over DNS traffic. **Recursive DNS resolver**: This type of resolver performs the entire process of DNS resolution on behalf of the client, starting from the root DNS servers and iteratively querying other DNS servers until it obtains the final IP address associated with the domain name. Most DNS resolvers, including those provided by ISPs and public DNS services, are recursive resolvers. Various other DNS server :     Google DNS: 8.8.8.8, Cloudflare DNS: 1.1.1.1,    OpenDNS:208.67.222.222  and etc. 

* **nslookup www.google.com** This will perform a standard DNS lookup for the A record of the domain www.google.com.
* **nslookup www.example.com 8.8.8.8** This will perform the lookup using the Google DNS server at 8.8.8.8 instead of the default DNS server.
* **nslookup -type=soa example.com** This will retrieve the SOA record for the domain example.com.
* **nslookup 8.8.8.8** This will perform a reverse DNS lookup to find the domain name associated with the IP address 8.8.8.8.
* **nslookup -debug www.example.com** This will enable debug mode and provide more detailed output during the DNS lookup.
* **nslookup -port=5353 www.example.com** This will perform the DNS lookup using the custom port 5353 instead of the default port 53.
* **nslookup -timeout=5 www.example.com** This will set the timeout for the DNS lookup to 5 seconds.
