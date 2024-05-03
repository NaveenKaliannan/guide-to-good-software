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
* **port** in networking is a logical construct that identifies a specific process or network service. It is a 16-bit unsigned integer number ranging from 0 to 65535 that is assigned to uniquely identify a connection endpoint and direct data to a specific service. The key points about ports in networking are:
1. Ports are used by transport layer protocols like TCP and UDP to identify specific applications or services.
2. Each network connection is identified by a combination of the local IP address, local port, remote IP address, and remote port.
3. Well-known ports below 1024 are reserved for common services like HTTP (port 80), FTP (port 21), and SSH (port 22).
4. Ports above 1024 are available for general use by applications and are known as registered or ephemeral ports.
5. Ports provide a way for multiple services or communication sessions to utilize the same network address.
6. Firewalls use port numbers to control network access and security by allowing or blocking traffic on specific ports.
7. In summary, ports are an essential component of network communication, allowing multiple applications and services to utilize the same network address by uniquely identifying each connection.
* **IP packet** consists of a header and a payload. The header contains important information required for routing and delivering the packet, including the sender's IP address, the recipient's IP address, and other control information. The payload carries the actual data or content being transmitted, such as a web page, email message, or file. IP packets are the fundamental building blocks of communication over the internet and other IP-based networks. IP packets enable features like file transfer, voice/video communication, streaming, VPNs, and IoT by breaking down data into smaller units that can be efficiently transmitted and routed across networks. Routers use the source and destination IP addresses in the packet header to determine the best path to forward the packet to its final destination

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

### UDP User Datagram Protocol
*********************************

