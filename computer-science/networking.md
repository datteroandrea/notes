# Networking

## Index

- [1. Foundations of Computer Networking](#1-foundations-of-computer-networking)
  - [1.1 What Is a Network](#11-what-is-a-network)
  - [1.2 Network Types and Scale](#12-network-types-and-scale)
  - [1.3 Network Topologies](#13-network-topologies)
  - [1.4 Switching Paradigms](#14-switching-paradigms)
  - [1.5 Performance Metrics](#15-performance-metrics)
- [2. Network Architecture and Layered Models](#2-network-architecture-and-layered-models)
  - [2.1 Principles of Layering](#21-principles-of-layering)
  - [2.2 The OSI Reference Model](#22-the-osi-reference-model)
  - [2.3 The TCP/IP Model](#23-the-tcpip-model)
  - [2.4 Standards and Governance](#24-standards-and-governance)
- [3. The Physical Layer](#3-the-physical-layer)
  - [3.1 Signals and Data Transmission](#31-signals-and-data-transmission)
  - [3.2 Encoding and Modulation](#32-encoding-and-modulation)
  - [3.3 Transmission Media](#33-transmission-media)
  - [3.4 Multiplexing and Link Sharing](#34-multiplexing-and-link-sharing)
  - [3.5 Physical Layer Devices](#35-physical-layer-devices)
- [4. The Data Link Layer](#4-the-data-link-layer)
  - [4.1 Framing and Link Services](#41-framing-and-link-services)
  - [4.2 Error Detection and Correction](#42-error-detection-and-correction)
  - [4.3 Reliable Delivery and Flow Control](#43-reliable-delivery-and-flow-control)
  - [4.4 Medium Access Control](#44-medium-access-control)
  - [4.5 Ethernet](#45-ethernet)
  - [4.6 Switching and Bridging](#46-switching-and-bridging)
  - [4.7 Address Resolution](#47-address-resolution)
- [5. The Network Layer and IP Addressing](#5-the-network-layer-and-ip-addressing)
  - [5.1 Network Layer Fundamentals](#51-network-layer-fundamentals)
  - [5.2 IPv4 Addressing](#52-ipv4-addressing)
  - [5.3 The IPv4 Protocol](#53-the-ipv4-protocol)
  - [5.4 IPv6](#54-ipv6)
  - [5.5 Supporting Protocols](#55-supporting-protocols)
  - [5.6 Address Translation](#56-address-translation)
- [6. Routing](#6-routing)
  - [6.1 Routing Fundamentals](#61-routing-fundamentals)
  - [6.2 Routing Algorithms](#62-routing-algorithms)
  - [6.3 Interior Gateway Protocols](#63-interior-gateway-protocols)
  - [6.4 Exterior Gateway Routing](#64-exterior-gateway-routing)
  - [6.5 Multicast and Advanced Forwarding](#65-multicast-and-advanced-forwarding)
- [7. The Transport Layer](#7-the-transport-layer)
  - [7.1 Transport Services](#71-transport-services)
  - [7.2 UDP](#72-udp)
  - [7.3 TCP Mechanics](#73-tcp-mechanics)
  - [7.4 Flow Control](#74-flow-control)
  - [7.5 Congestion Control](#75-congestion-control)
  - [7.6 Modern Transport Protocols](#76-modern-transport-protocols)
- [8. The Application Layer](#8-the-application-layer)
  - [8.1 Application Architectures](#81-application-architectures)
  - [8.2 Naming and the Domain Name System](#82-naming-and-the-domain-name-system)
  - [8.3 The Web and HTTP](#83-the-web-and-http)
  - [8.4 Messaging and File Transfer](#84-messaging-and-file-transfer)
  - [8.5 Remote Access and Management](#85-remote-access-and-management)
  - [8.6 Content Delivery and Streaming](#86-content-delivery-and-streaming)
- [9. Network Programming](#9-network-programming)
  - [9.1 The Socket API](#91-the-socket-api)
  - [9.2 Concurrency Models](#92-concurrency-models)
  - [9.3 Protocol and API Design](#93-protocol-and-api-design)
- [10. Wireless and Mobile Networking](#10-wireless-and-mobile-networking)
  - [10.1 Wireless Link Characteristics](#101-wireless-link-characteristics)
  - [10.2 Wi-Fi (IEEE 802.11)](#102-wi-fi-ieee-80211)
  - [10.3 Cellular Networks](#103-cellular-networks)
  - [10.4 Short-Range and IoT Networking](#104-short-range-and-iot-networking)
  - [10.5 Mobility Management](#105-mobility-management)
- [11. Network Security](#11-network-security)
  - [11.1 Security Principles](#111-security-principles)
  - [11.2 Cryptography for Networks](#112-cryptography-for-networks)
  - [11.3 Secure Protocols](#113-secure-protocols)
  - [11.4 Attacks and Defenses](#114-attacks-and-defenses)
  - [11.5 Perimeter and Monitoring Systems](#115-perimeter-and-monitoring-systems)
- [12. Quality of Service and Traffic Engineering](#12-quality-of-service-and-traffic-engineering)
  - [12.1 QoS Fundamentals](#121-qos-fundamentals)
  - [12.2 Traffic Management Mechanisms](#122-traffic-management-mechanisms)
  - [12.3 QoS Architectures](#123-qos-architectures)
- [13. Modern Network Infrastructure](#13-modern-network-infrastructure)
  - [13.1 Software-Defined Networking](#131-software-defined-networking)
  - [13.2 Virtualization and Overlays](#132-virtualization-and-overlays)
  - [13.3 Data Center Networking](#133-data-center-networking)
  - [13.4 Cloud and Wide-Area Evolution](#134-cloud-and-wide-area-evolution)
  - [13.5 Network Automation](#135-network-automation)
- [14. Network Operations, Analysis, and Troubleshooting](#14-network-operations-analysis-and-troubleshooting)
  - [14.1 Diagnostic Tools](#141-diagnostic-tools)
  - [14.2 Packet Analysis](#142-packet-analysis)
  - [14.3 Systematic Troubleshooting](#143-systematic-troubleshooting)
  - [14.4 Monitoring and Capacity Planning](#144-monitoring-and-capacity-planning)
- [15. Advanced and Emerging Topics](#15-advanced-and-emerging-topics)
  - [15.1 Distributed Systems Networking](#151-distributed-systems-networking)
  - [15.2 Network Measurement and Modeling](#152-network-measurement-and-modeling)
  - [15.3 Frontier Directions](#153-frontier-directions)

---

<a id="1-foundations-of-computer-networking"></a>
## 1. Foundations of Computer Networking

<a id="11-what-is-a-network"></a>
### 1.1 What Is a Network

- Definition and Purpose of Networks
- Hosts, Links, and Nodes
- Clients, Servers, and Peers
- Network Edge vs Network Core
- Brief History of the Internet

<a id="12-network-types-and-scale"></a>
### 1.2 Network Types and Scale

- PAN, LAN, MAN, and WAN
- Enterprise, Campus, and Data Center Networks
- Internet, Intranet, and Extranet
- Internet Service Providers and Tiers
- Autonomous Systems and Peering

<a id="13-network-topologies"></a>
### 1.3 Network Topologies

- Bus and Ring Topologies
- Star and Extended Star
- Mesh and Partial Mesh
- Tree and Hybrid Topologies
- Physical vs Logical Topology

<a id="14-switching-paradigms"></a>
### 1.4 Switching Paradigms

- Circuit Switching
- Packet Switching
- Message Switching
- Datagram vs Virtual Circuit Service
- Store-and-Forward Transmission

<a id="15-performance-metrics"></a>
### 1.5 Performance Metrics

- Bandwidth and Throughput
- Latency Components: Transmission, Propagation, Queuing, Processing
- Round-Trip Time
- Jitter and Packet Loss
- Bandwidth-Delay Product
- Goodput and Protocol Overhead

---

<a id="2-network-architecture-and-layered-models"></a>
## 2. Network Architecture and Layered Models

<a id="21-principles-of-layering"></a>
### 2.1 Principles of Layering

- Protocols, Services, and Interfaces
- Service Primitives and Service Access Points
- Encapsulation and Decapsulation
- Protocol Data Units per Layer
- Benefits and Costs of Layering

<a id="22-the-osi-reference-model"></a>
### 2.2 The OSI Reference Model

- Physical Layer Responsibilities
- Data Link Layer Responsibilities
- Network Layer Responsibilities
- Transport Layer Responsibilities
- Session, Presentation, and Application Layers

<a id="23-the-tcpip-model"></a>
### 2.3 The TCP/IP Model

- Link, Internet, Transport, and Application Layers
- Mapping TCP/IP to OSI
- The Hourglass Model and IP Narrow Waist
- End-to-End Argument
- Protocol Stack Traversal Walkthrough

<a id="24-standards-and-governance"></a>
### 2.4 Standards and Governance

- IETF, RFCs, and the Standards Track
- IEEE 802 Standards Family
- ITU-T, ISO, and W3C Roles
- IANA and ICANN Responsibilities
- Regional Internet Registries

---

<a id="3-the-physical-layer"></a>
## 3. The Physical Layer

<a id="31-signals-and-data-transmission"></a>
### 3.1 Signals and Data Transmission

- Analog vs Digital Signals
- Bit Rate, Baud Rate, and Symbols
- Nyquist Theorem
- Shannon Capacity and Noise
- Attenuation, Distortion, and Interference

<a id="32-encoding-and-modulation"></a>
### 3.2 Encoding and Modulation

- NRZ, NRZI, and Manchester Encoding
- 4B/5B and 8B/10B Line Codes
- Clock Recovery and Synchronization
- ASK, FSK, and PSK Modulation
- QAM and Constellation Diagrams

<a id="33-transmission-media"></a>
### 3.3 Transmission Media

- Twisted Pair Categories and Shielding
- Coaxial Cable
- Single-Mode vs Multi-Mode Fiber
- Optical Transceivers and Connectors
- Radio, Microwave, and Satellite Links
- Structured Cabling and Cable Standards

<a id="34-multiplexing-and-link-sharing"></a>
### 3.4 Multiplexing and Link Sharing

- Frequency Division Multiplexing
- Time Division Multiplexing
- Wavelength Division Multiplexing
- Code Division Multiple Access
- Simplex, Half-Duplex, and Full-Duplex Modes

<a id="35-physical-layer-devices"></a>
### 3.5 Physical Layer Devices

- Repeaters and Hubs
- Media Converters and Transceivers
- Patch Panels and Structured Wiring
- Collision Domains at the Physical Layer
- Power over Ethernet

---

<a id="4-the-data-link-layer"></a>
## 4. The Data Link Layer

<a id="41-framing-and-link-services"></a>
### 4.1 Framing and Link Services

- Framing Methods: Byte Count, Byte Stuffing, Bit Stuffing
- Connectionless vs Connection-Oriented Link Service
- LLC and MAC Sublayers
- MTU and Fragmentation at the Link Layer
- Point-to-Point Protocol

<a id="42-error-detection-and-correction"></a>
### 4.2 Error Detection and Correction

- Parity Bits and Two-Dimensional Parity
- Internet Checksum
- Cyclic Redundancy Check
- Hamming Codes and Forward Error Correction
- Error Detection vs Correction Trade-offs

<a id="43-reliable-delivery-and-flow-control"></a>
### 4.3 Reliable Delivery and Flow Control

- Stop-and-Wait Protocol
- Sliding Window Concept
- Go-Back-N ARQ
- Selective Repeat ARQ
- Sequence Numbers and Timeouts
- Link Utilization Analysis

<a id="44-medium-access-control"></a>
### 4.4 Medium Access Control

- Channel Partitioning: TDMA and FDMA
- ALOHA and Slotted ALOHA
- CSMA and CSMA/CD
- CSMA/CA and Hidden Terminal Problem
- Token Passing and Polling
- Binary Exponential Backoff

<a id="45-ethernet"></a>
### 4.5 Ethernet

- Ethernet Frame Format
- MAC Addresses and OUI Structure
- Ethernet Standards from 10BASE-T to 400GbE
- Collision and Broadcast Domains
- Auto-Negotiation and Duplex Mismatch
- Jumbo Frames

<a id="46-switching-and-bridging"></a>
### 4.6 Switching and Bridging

- Transparent Bridging and MAC Learning
- Switch Forwarding Modes
- Spanning Tree Protocol
- RSTP and MSTP
- Link Aggregation and LACP
- VLANs and 802.1Q Tagging
- Trunking and Inter-VLAN Routing

<a id="47-address-resolution"></a>
### 4.7 Address Resolution

- ARP Request and Reply Operation
- ARP Cache and Gratuitous ARP
- Proxy ARP
- IPv6 Neighbor Discovery Protocol
- ARP Spoofing Fundamentals

---

<a id="5-the-network-layer-and-ip-addressing"></a>
## 5. The Network Layer and IP Addressing

<a id="51-network-layer-fundamentals"></a>
### 5.1 Network Layer Fundamentals

- Forwarding vs Routing
- Router Architecture and Forwarding Tables
- Longest Prefix Match
- Best-Effort Delivery Model
- Control Plane vs Data Plane

<a id="52-ipv4-addressing"></a>
### 5.2 IPv4 Addressing

- IPv4 Address Structure and Notation
- Classful Addressing and Its Limits
- Subnet Masks and Prefix Notation
- Subnetting and VLSM
- Supernetting and CIDR
- Private Address Ranges and Special Addresses
- Broadcast, Unicast, Multicast, and Anycast

<a id="53-the-ipv4-protocol"></a>
### 5.3 The IPv4 Protocol

- IPv4 Header Fields
- TTL and Loop Prevention
- Fragmentation and Reassembly
- Type of Service and DSCP
- IP Options

<a id="54-ipv6"></a>
### 5.4 IPv6

- Motivation and Address Exhaustion
- IPv6 Address Notation and Types
- IPv6 Header and Extension Headers
- Stateless Address Autoconfiguration
- ICMPv6 and Neighbor Discovery
- Transition Mechanisms: Dual Stack, Tunneling, Translation

<a id="55-supporting-protocols"></a>
### 5.5 Supporting Protocols

- ICMP Message Types and Operation
- ping and traceroute Mechanics
- DHCP Lease Process (DORA)
- DHCP Relay and Options
- Path MTU Discovery

<a id="56-address-translation"></a>
### 5.6 Address Translation

- Static and Dynamic NAT
- Port Address Translation
- NAT Traversal: STUN, TURN, ICE
- Carrier-Grade NAT
- NAT Implications for End-to-End Connectivity

---

<a id="6-routing"></a>
## 6. Routing

<a id="61-routing-fundamentals"></a>
### 6.1 Routing Fundamentals

- Static vs Dynamic Routing
- Default Routes and Gateways
- Administrative Distance and Route Metrics
- Routing Table Construction
- Equal-Cost Multi-Path Routing

<a id="62-routing-algorithms"></a>
### 6.2 Routing Algorithms

- Graph Abstraction of Networks
- Dijkstra's Link-State Algorithm
- Bellman-Ford Distance-Vector Algorithm
- Count-to-Infinity and Split Horizon
- Poison Reverse and Hold-Down Timers
- Convergence and Routing Loops

<a id="63-interior-gateway-protocols"></a>
### 6.3 Interior Gateway Protocols

- RIP Versions and Operation
- OSPF Areas and LSAs
- OSPF Adjacency Formation and DR/BDR
- IS-IS Overview
- EIGRP and DUAL
- Route Redistribution and Summarization

<a id="64-exterior-gateway-routing"></a>
### 6.4 Exterior Gateway Routing

- Autonomous Systems and AS Numbers
- BGP Session Establishment and Messages
- Path Attributes: AS-PATH, NEXT-HOP, LOCAL-PREF, MED
- BGP Route Selection Process
- eBGP vs iBGP and Route Reflectors
- Routing Policy and Traffic Engineering
- BGP Hijacking and RPKI

<a id="65-multicast-and-advanced-forwarding"></a>
### 6.5 Multicast and Advanced Forwarding

- Multicast Addressing and Groups
- IGMP and MLD
- PIM Sparse and Dense Mode
- MPLS Labels and Label Switched Paths
- Segment Routing Overview

---

<a id="7-the-transport-layer"></a>
## 7. The Transport Layer

<a id="71-transport-services"></a>
### 7.1 Transport Services

- Multiplexing and Demultiplexing
- Port Numbers and Well-Known Ports
- Sockets and Connection Identification
- Reliable vs Unreliable Transport
- Connection-Oriented vs Connectionless Semantics

<a id="72-udp"></a>
### 7.2 UDP

- UDP Header and Checksum
- Use Cases for UDP
- UDP and Application-Level Reliability
- UDP Amplification Concerns

<a id="73-tcp-mechanics"></a>
### 7.3 TCP Mechanics

- TCP Header Fields and Flags
- Three-Way Handshake
- Connection Termination and TIME_WAIT
- TCP State Machine
- Sequence and Acknowledgment Numbers
- Retransmission Timeout and RTT Estimation
- Fast Retransmit and Fast Recovery
- Selective Acknowledgment

<a id="74-flow-control"></a>
### 7.4 Flow Control

- Receive Window Advertisement
- Sliding Window in TCP
- Silly Window Syndrome
- Nagle's Algorithm and Delayed ACKs
- Window Scaling Option

<a id="75-congestion-control"></a>
### 7.5 Congestion Control

- Causes and Costs of Congestion
- Slow Start and Congestion Avoidance
- AIMD and Fairness
- TCP Reno, NewReno, and CUBIC
- BBR and Model-Based Congestion Control
- Explicit Congestion Notification
- Active Queue Management and Bufferbloat

<a id="76-modern-transport-protocols"></a>
### 7.6 Modern Transport Protocols

- QUIC Design Goals and Streams
- Head-of-Line Blocking and Its Elimination
- SCTP Multi-Streaming and Multihoming
- Multipath TCP
- Transport Protocol Ossification and Middleboxes

---

<a id="8-the-application-layer"></a>
## 8. The Application Layer

<a id="81-application-architectures"></a>
### 8.1 Application Architectures

- Client-Server Model
- Peer-to-Peer Model
- Hybrid Architectures
- Application Requirements: Loss, Delay, Throughput
- Request-Response vs Streaming Interaction

<a id="82-naming-and-the-domain-name-system"></a>
### 8.2 Naming and the Domain Name System

- DNS Namespace Hierarchy
- Root, TLD, and Authoritative Servers
- Iterative vs Recursive Resolution
- Resource Record Types
- DNS Caching and TTL
- DNSSEC Fundamentals
- DNS over TLS and DNS over HTTPS

<a id="83-the-web-and-http"></a>
### 8.3 The Web and HTTP

- URLs, URIs, and Resources
- HTTP Request and Response Structure
- Methods, Status Codes, and Headers
- Persistent Connections and Pipelining
- Cookies and Session State
- Web Caching and Conditional Requests
- HTTP/2 Multiplexing and Header Compression
- HTTP/3 over QUIC
- WebSockets and Server-Sent Events

<a id="84-messaging-and-file-transfer"></a>
### 8.4 Messaging and File Transfer

- SMTP and Mail Delivery Path
- POP3 and IMAP
- MIME and Message Formats
- SPF, DKIM, and DMARC
- FTP and FTPS
- SFTP and SCP over SSH

<a id="85-remote-access-and-management"></a>
### 8.5 Remote Access and Management

- SSH Architecture and Key Exchange
- Telnet and Its Deprecation
- SNMP Agents, Managers, and MIBs
- Syslog and Centralized Logging
- NTP and Clock Synchronization
- NETCONF, RESTCONF, and YANG

<a id="86-content-delivery-and-streaming"></a>
### 8.6 Content Delivery and Streaming

- Content Delivery Network Architecture
- DNS-Based and Anycast Server Selection
- Adaptive Bitrate Streaming (DASH, HLS)
- VoIP and RTP/RTCP
- SIP Signaling
- WebRTC Peer Connections

---

<a id="9-network-programming"></a>
## 9. Network Programming

<a id="91-the-socket-api"></a>
### 9.1 The Socket API

- Socket Types: Stream, Datagram, Raw
- Address Families and Structures
- Server Calls: socket, bind, listen, accept
- Client Calls: socket, connect
- send, recv, and Partial Transfers
- Byte Order and Endianness Conversion
- Graceful Shutdown and Socket Options

<a id="92-concurrency-models"></a>
### 9.2 Concurrency Models

- Process-per-Connection Servers
- Thread-per-Connection Servers
- select and poll Multiplexing
- epoll and kqueue
- Event Loops and Async I/O
- Thundering Herd and C10K Problem

<a id="93-protocol-and-api-design"></a>
### 9.3 Protocol and API Design

- Text vs Binary Protocol Formats
- Message Framing over Streams
- Serialization: JSON, Protocol Buffers, MessagePack
- REST Design Principles
- gRPC and RPC Semantics
- Idempotency, Retries, and Timeouts
- Backpressure and Rate Limiting

---

<a id="10-wireless-and-mobile-networking"></a>
## 10. Wireless and Mobile Networking

<a id="101-wireless-link-characteristics"></a>
### 10.1 Wireless Link Characteristics

- Path Loss, Fading, and Multipath
- Signal-to-Noise Ratio and Bit Error Rate
- Interference and Spectrum Regulation
- Adaptive Modulation and Coding
- MIMO and Beamforming

<a id="102-wi-fi-ieee-80211"></a>
### 10.2 Wi-Fi (IEEE 802.11)

- 802.11 Architecture: BSS, ESS, and SSID
- Channels and Frequency Bands
- Association, Authentication, and Roaming
- 802.11 Frame Types and RTS/CTS
- Standards from 802.11a to Wi-Fi 7
- WPA2, WPA3, and 802.1X
- Wireless Site Survey and Channel Planning

<a id="103-cellular-networks"></a>
### 10.3 Cellular Networks

- Cellular Architecture and Handoff
- Evolution from 2G to 5G
- LTE EPC and 5G Core Components
- Radio Access Network Concepts
- Network Slicing and Edge Computing

<a id="104-short-range-and-iot-networking"></a>
### 10.4 Short-Range and IoT Networking

- Bluetooth and BLE
- Zigbee and Thread
- LoRaWAN and LPWAN
- 6LoWPAN and RPL
- MQTT and CoAP
- Constrained Device Trade-offs

<a id="105-mobility-management"></a>
### 10.5 Mobility Management

- Mobile IP and Home/Foreign Agents
- Triangle Routing and Optimization
- Impact of Mobility on TCP
- Seamless Handover Strategies

---

<a id="11-network-security"></a>
## 11. Network Security

<a id="111-security-principles"></a>
### 11.1 Security Principles

- CIA Triad in Networking
- Threat Models and Attack Surfaces
- Authentication, Authorization, and Accounting
- Defense in Depth
- Zero Trust Networking

<a id="112-cryptography-for-networks"></a>
### 11.2 Cryptography for Networks

- Symmetric Ciphers and Modes of Operation
- Public-Key Cryptography and Key Exchange
- Hash Functions and MACs
- Digital Signatures
- Certificates, PKI, and Certificate Authorities
- Perfect Forward Secrecy

<a id="113-secure-protocols"></a>
### 11.3 Secure Protocols

- TLS Handshake and Record Protocol
- TLS 1.3 Improvements
- HTTPS and Certificate Validation
- IPsec AH and ESP
- Transport vs Tunnel Mode and IKE
- VPN Types: Site-to-Site and Remote Access
- WireGuard Design

<a id="114-attacks-and-defenses"></a>
### 11.4 Attacks and Defenses

- Packet Sniffing and Man-in-the-Middle
- Spoofing: IP, ARP, and DNS
- TCP SYN Flood and SYN Cookies
- DoS and DDoS Techniques and Mitigation
- Session Hijacking and Replay Attacks
- Port Scanning and Reconnaissance
- Botnets and Command-and-Control

<a id="115-perimeter-and-monitoring-systems"></a>
### 11.5 Perimeter and Monitoring Systems

- Packet Filtering and Stateful Firewalls
- Application-Layer Gateways and Proxies
- Network Address Translation as a Boundary
- Intrusion Detection and Prevention Systems
- DMZ and Network Segmentation
- Honeypots and Deception
- SIEM and Traffic Analytics

---

<a id="12-quality-of-service-and-traffic-engineering"></a>
## 12. Quality of Service and Traffic Engineering

<a id="121-qos-fundamentals"></a>
### 12.1 QoS Fundamentals

- Traffic Classes and Service Requirements
- Delay, Jitter, and Loss Budgets
- Best-Effort vs Guaranteed Service
- Service Level Agreements

<a id="122-traffic-management-mechanisms"></a>
### 12.2 Traffic Management Mechanisms

- Classification and Marking
- Policing vs Shaping
- Token Bucket and Leaky Bucket
- Queuing Disciplines: FIFO, PQ, WFQ, CBWFQ
- Congestion Avoidance with RED and WRED
- Admission Control

<a id="123-qos-architectures"></a>
### 12.3 QoS Architectures

- Integrated Services and RSVP
- Differentiated Services and PHBs
- MPLS Traffic Engineering
- End-to-End QoS Design Considerations

---

<a id="13-modern-network-infrastructure"></a>
## 13. Modern Network Infrastructure

<a id="131-software-defined-networking"></a>
### 13.1 Software-Defined Networking

- Separation of Control and Data Planes
- SDN Controller Architecture
- OpenFlow and Flow Tables
- Northbound and Southbound APIs
- P4 and Programmable Data Planes

<a id="132-virtualization-and-overlays"></a>
### 13.2 Virtualization and Overlays

- Network Function Virtualization
- Virtual Switches and Bridges
- Tunneling: GRE, VXLAN, GENEVE
- Overlay vs Underlay Networks
- Container Networking and CNI
- Service Mesh and Sidecar Proxies

<a id="133-data-center-networking"></a>
### 13.3 Data Center Networking

- Three-Tier vs Leaf-Spine Topology
- East-West vs North-South Traffic
- ECMP and Load Distribution
- Load Balancing: L4 vs L7
- RDMA and Lossless Fabrics
- Oversubscription and Bisection Bandwidth

<a id="134-cloud-and-wide-area-evolution"></a>
### 13.4 Cloud and Wide-Area Evolution

- Virtual Private Clouds and Subnets
- Cloud Interconnect and Direct Connect
- SD-WAN Architecture
- Edge and Fog Computing
- Multi-Region and Global Load Balancing

<a id="135-network-automation"></a>
### 13.5 Network Automation

- Infrastructure as Code for Networks
- Configuration Management Tools
- Telemetry and Streaming Analytics
- Intent-Based Networking
- CI/CD for Network Changes

---

<a id="14-network-operations-analysis-and-troubleshooting"></a>
## 14. Network Operations, Analysis, and Troubleshooting

<a id="141-diagnostic-tools"></a>
### 14.1 Diagnostic Tools

- ping, traceroute, and mtr
- netstat, ss, and lsof
- dig, nslookup, and host
- curl and telnet for Service Checks
- iperf and Throughput Measurement
- tcpdump Filters and Capture

<a id="142-packet-analysis"></a>
### 14.2 Packet Analysis

- Capture Points and Port Mirroring
- Wireshark Display Filters
- Following Streams and Reassembly
- Identifying Retransmissions and Resets
- Decrypting TLS in Captures

<a id="143-systematic-troubleshooting"></a>
### 14.3 Systematic Troubleshooting

- Bottom-Up and Top-Down Methodologies
- Divide-and-Conquer Isolation
- Common Layer 1 and Layer 2 Faults
- Diagnosing Routing and DNS Failures
- Performance Problem Triage
- Documenting and Escalating Incidents

<a id="144-monitoring-and-capacity-planning"></a>
### 14.4 Monitoring and Capacity Planning

- SNMP Polling vs Streaming Telemetry
- NetFlow, sFlow, and IPFIX
- Baselines, Thresholds, and Alerting
- Availability, MTBF, and MTTR
- Traffic Growth Forecasting
- Redundancy and High Availability Design

---

<a id="15-advanced-and-emerging-topics"></a>
## 15. Advanced and Emerging Topics

<a id="151-distributed-systems-networking"></a>
### 15.1 Distributed Systems Networking

- Failure Models and Partial Failure
- Consistency and Network Partitions
- Distributed Hash Tables
- Gossip and Epidemic Protocols
- Consensus over Unreliable Networks

<a id="152-network-measurement-and-modeling"></a>
### 15.2 Network Measurement and Modeling

- Active vs Passive Measurement
- Internet Topology Discovery
- Queuing Theory Basics and Little's Law
- Network Simulation and Emulation Tools
- Traffic Characterization and Self-Similarity

<a id="153-frontier-directions"></a>
### 15.3 Frontier Directions

- Information-Centric Networking
- Delay-Tolerant Networking
- Satellite Constellations and LEO Networks
- Post-Quantum Cryptography in Transit
- AI-Driven Network Operations
- Network Neutrality and Internet Governance
