## [DNS](https://www.youtube.com/watch?v=4C6eeQes4cs)

DNS is used to covert the human readbale names (google.com) to IP addresss. 
PC or Laptop uses addresses IPv4/IPv6
Names are convenient for humans
When you type google.com in web browser, the device asks DNS server for IP address of the google.com.

increasing end-users connected to the Internet leads to the exhaustion of IPv4 addresses. This is the reason why IP version 6 is introduced.

IPv4 (32-bit address length, less address space, address representatin is decimal, mnaual or with DHCP configuration,  4 fields which are separated by dot (.), Example of IPv4:  66.94.29.13	)

IPv6 (128-bit address length, more address space,address representatin is hexadecimal, Autoconfiguration , 8 fields, which are separated by colon (:), Example of IPv6: 2001:0000:3238:DFE1:0063:0000:0000:FEFB
)

DNS serves can be manually configured via DHCP.

ipconfig - PC IP address, subnet mask and default gateway
ipconfig/all - command used to show information about the network configuration and DHCP and DNS Settings.
nslookup google.com -  used for obtaining DNS records
both ipconfig/all nslookup will show the DNS records
ping google.com -  ping the google.com
ipconfig /displaydns - PC DNS cache
DHCP - host use it learn the address of thir  DNS Server, IP address. subnet mask, default gateway


when we type the google.com, a querry with our IP address will be send to the IP address of google.com. 
then the desination will send the response with their IP address to us. 
A -  used to map names to IPv4 addresses
AAAA -  used to map names to IPv6 addresses
DNS uses both UDP (standard) and TCP (used when data is greater than 512 byetes). port number 53 is used

Devices has a host file in /etc/hosts/ - lists hosts and IP address. 
you can also add host ip address and name in hosts file. 

Two types of DNS server: Internal or External. 
How to configure ip address in router

ip dns server - command
ip name-server 8.8.8.8
ip domain loopup
ip domain name
