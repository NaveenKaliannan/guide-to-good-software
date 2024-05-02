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
 * **MAC address** Identifies a device's network interface at the local network level (data link layer). 48-bit hexadecimal number (e.g., 00:11:22:33:44:55). Assigned by the manufacturer of the network interface card (NIC). Unique within a local network segment. Generally permanent and does not change. Not easily visible to third parties outside the local network.  for local data link layer communication and broadcast/multicast
 * **IP address** Identifies a device's logical network connection at the global internet level (network layer). 32-bit (IPv4) or 128-bit (IPv6) numerical address (e.g., 192.168.1.1 or 2001:0db8:85a3:0000:0000:8a2e:0370:7334). Assigned by the network administrator or internet service provider (ISP). Unique within the global internet. Can change, especially for dynamic IP addresses. Can be more easily discovered by third parties. Used for global internet routing and communication

  
