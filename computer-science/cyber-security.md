# Cyber Security

## Index

- [1. Foundations of Cyber Security](#1-foundations-of-cyber-security)
  - [1.1 Core Security Principles](#11-core-security-principles)
  - [1.2 Threat Landscape](#12-threat-landscape)
  - [1.3 Security Governance and Risk](#13-security-governance-and-risk)
  - [1.4 Legal, Ethical, and Professional Context](#14-legal-ethical-and-professional-context)
- [2. Background and Tools](#2-background-and-tools)
  - [2.1 Introduction to the Unix Shell](#21-introduction-to-the-unix-shell)
  - [2.2 Stream Editing and Regular Expressions](#22-stream-editing-and-regular-expressions)
  - [2.3 Introduction to Python for Security](#23-introduction-to-python-for-security)
- [3. Cryptography](#3-cryptography)
  - [3.1 Cryptographic Fundamentals](#31-cryptographic-fundamentals)
  - [3.2 Symmetric Cryptography](#32-symmetric-cryptography)
  - [3.3 Asymmetric Cryptography](#33-asymmetric-cryptography)
  - [3.4 Hashing and Integrity](#34-hashing-and-integrity)
  - [3.5 Public Key Infrastructure](#35-public-key-infrastructure)
- [4. Program Analysis](#4-program-analysis)
  - [4.1 Assembly x86-64](#41-assembly-x86-64)
  - [4.2 Static Program Analysis](#42-static-program-analysis)
  - [4.3 Dynamic Program Analysis](#43-dynamic-program-analysis)
- [5. Program Exploitation](#5-program-exploitation)
  - [5.1 Memory Corruption Foundations](#51-memory-corruption-foundations)
  - [5.2 Stack Overflow Exploitation](#52-stack-overflow-exploitation)
  - [5.3 Format String Vulnerabilities](#53-format-string-vulnerabilities)
  - [5.4 Exploit Mitigations](#54-exploit-mitigations)
  - [5.5 Secure Coding](#55-secure-coding)
- [6. System and Network Security](#6-system-and-network-security)
  - [6.1 Networking Refresher for Security](#61-networking-refresher-for-security)
  - [6.2 Identification and Authentication](#62-identification-and-authentication)
  - [6.3 Access Control](#63-access-control)
  - [6.4 Firewalls and Perimeter Defense](#64-firewalls-and-perimeter-defense)
  - [6.5 Network Attacks](#65-network-attacks)
  - [6.6 Secure Communication Protocols](#66-secure-communication-protocols)
  - [6.7 Wireless and Mobile Network Security](#67-wireless-and-mobile-network-security)
- [7. System and Endpoint Hardening](#7-system-and-endpoint-hardening)
  - [7.1 Operating System Security](#71-operating-system-security)
  - [7.2 Malware](#72-malware)
  - [7.3 Endpoint Defense](#73-endpoint-defense)
  - [7.4 Virtualization and Container Security](#74-virtualization-and-container-security)
- [8. Web Security (Server Side)](#8-web-security-server-side)
  - [8.1 Web Architecture and Attack Surface](#81-web-architecture-and-attack-surface)
  - [8.2 Web Attacks](#82-web-attacks)
  - [8.3 SQL Injection and Defences](#83-sql-injection-and-defences)
  - [8.4 Blind SQL Injection](#84-blind-sql-injection)
  - [8.5 Server-Side Hardening](#85-server-side-hardening)
  - [8.6 API and Mobile Back-End Security](#86-api-and-mobile-back-end-security)
- [9. Web Security (Client Side)](#9-web-security-client-side)
  - [9.1 Browser Security Mechanisms](#91-browser-security-mechanisms)
  - [9.2 Cross-Site Scripting (XSS)](#92-cross-site-scripting-xss)
  - [9.3 Cross-Site Request Forgery (CSRF)](#93-cross-site-request-forgery-csrf)
  - [9.4 Other Client-Side Attacks](#94-other-client-side-attacks)
- [10. Secure Development Lifecycle](#10-secure-development-lifecycle)
  - [10.1 Threat Modeling and Secure Design](#101-threat-modeling-and-secure-design)
  - [10.2 Security Testing and Assurance](#102-security-testing-and-assurance)
  - [10.3 DevSecOps](#103-devsecops)
- [11. Cloud and Infrastructure Security](#11-cloud-and-infrastructure-security)
  - [11.1 Cloud Security Foundations](#111-cloud-security-foundations)
  - [11.2 Cloud Defense Practices](#112-cloud-defense-practices)
  - [11.3 Zero Trust and Modern Architecture](#113-zero-trust-and-modern-architecture)
  - [11.4 Operational Technology and IoT](#114-operational-technology-and-iot)
- [12. Offensive Security](#12-offensive-security)
  - [12.1 Penetration Testing Methodology](#121-penetration-testing-methodology)
  - [12.2 Reconnaissance and Enumeration](#122-reconnaissance-and-enumeration)
  - [12.3 Exploitation and Post-Exploitation](#123-exploitation-and-post-exploitation)
  - [12.4 Social Engineering](#124-social-engineering)
- [13. Defensive Operations and Incident Response](#13-defensive-operations-and-incident-response)
  - [13.1 Security Monitoring](#131-security-monitoring)
  - [13.2 Threat Intelligence and Hunting](#132-threat-intelligence-and-hunting)
  - [13.3 Incident Response](#133-incident-response)
  - [13.4 Digital Forensics](#134-digital-forensics)
  - [13.5 Resilience and Continuity](#135-resilience-and-continuity)
- [14. Emerging and Specialized Topics](#14-emerging-and-specialized-topics)
  - [14.1 Data Protection and Privacy Engineering](#141-data-protection-and-privacy-engineering)
  - [14.2 AI and Machine Learning Security](#142-ai-and-machine-learning-security)
  - [14.3 Advanced and Frontier Areas](#143-advanced-and-frontier-areas)
  - [14.4 Career and Continuous Practice](#144-career-and-continuous-practice)

---

<a id="1-foundations-of-cyber-security"></a>
## 1. Foundations of Cyber Security

<a id="11-core-security-principles"></a>
### 1.1 Core Security Principles

- Confidentiality, Integrity, Availability (CIA Triad)
- Authentication, Authorization, Accounting (AAA)
- Non-repudiation and Accountability
- Defense in Depth
- Least Privilege and Need to Know
- Separation of Duties
- Fail-Safe Defaults
- Security vs. Usability Trade-offs

<a id="12-threat-landscape"></a>
### 1.2 Threat Landscape

- Assets, Vulnerabilities, Threats, and Risk
- Threat Actor Types and Motivations
- Script Kiddies, Hacktivists, and Insiders
- Organized Cybercrime Groups
- Nation-State Actors and APTs
- Attack Surface and Attack Vectors
- Cyber Kill Chain Model
- MITRE ATT&CK Framework Overview

<a id="13-security-governance-and-risk"></a>
### 1.3 Security Governance and Risk

- Security Policies, Standards, and Procedures
- Qualitative vs. Quantitative Risk Assessment
- Risk Treatment: Accept, Mitigate, Transfer, Avoid
- Business Impact Analysis
- Security Controls: Preventive, Detective, Corrective
- Administrative, Technical, and Physical Controls
- Security Awareness Training Programs

<a id="14-legal-ethical-and-professional-context"></a>
### 1.4 Legal, Ethical, and Professional Context

- Computer Crime Legislation
- Ethical Hacking and Rules of Engagement
- Responsible Disclosure and Bug Bounties
- Privacy Regulations: GDPR and CCPA
- Industry Frameworks: NIST CSF, ISO 27001
- Sector Compliance: PCI DSS, HIPAA, SOX
- Chain of Custody and Evidence Handling Ethics

---

<a id="2-background-and-tools"></a>
## 2. Background and Tools

<a id="21-introduction-to-the-unix-shell"></a>
### 2.1 Introduction to the Unix Shell

- Unix Philosophy and File System Layout
- Shell Invocation, Prompts, and Environment Variables
- Essential Commands: ls, cd, cp, mv, rm, find
- File Permissions, Ownership, and chmod/chown
- Standard Input, Output, and Error Streams
- Redirection, Pipes, and Command Composition
- Process Control, Signals, and Job Management
- Text Utilities: cat, cut, sort, uniq, wc, tr
- Shell Scripting: Variables, Conditionals, Loops
- Quoting, Globbing, and Command Substitution
- Shell Injection Risks in Scripts
- SSH, scp, and Remote Shell Workflows

<a id="22-stream-editing-and-regular-expressions"></a>
### 2.2 Stream Editing and Regular Expressions

- Regular Expression Syntax and Metacharacters
- Character Classes, Anchors, and Quantifiers
- Groups, Backreferences, and Alternation
- Greedy vs. Lazy Matching
- POSIX Basic vs. Extended Regex
- grep and egrep for Log and Code Search
- sed: Substitution, Addressing, and In-Place Editing
- awk for Field-Oriented Text Processing
- Building Log Parsing and Triage Pipelines
- Regex Denial of Service (ReDoS)
- Regex Pitfalls in Input Validation

<a id="23-introduction-to-python-for-security"></a>
### 2.3 Introduction to Python for Security

- Python Syntax, Types, and Control Flow
- Functions, Modules, and Virtual Environments
- Strings, Bytes, and Encoding Handling
- File and Binary Data Manipulation
- struct and Binary Packing/Unpacking
- Sockets and Network Client Scripting
- HTTP Automation with requests
- HTML and Data Parsing Libraries
- subprocess and Safe Command Execution
- hashlib and cryptography Library Basics
- Scapy for Packet Crafting and Sniffing
- pwntools for Exploit Development
- Writing Reusable Security Tooling and CLIs

---

<a id="3-cryptography"></a>
## 3. Cryptography

<a id="31-cryptographic-fundamentals"></a>
### 3.1 Cryptographic Fundamentals

- Terminology: Plaintext, Ciphertext, Keys
- Kerckhoffs's Principle
- Classical Ciphers: Caesar, Vigenère, Substitution
- Frequency Analysis and Cryptanalysis Basics
- Entropy and Randomness
- Cryptographically Secure Random Number Generation
- One-Time Pad and Perfect Secrecy

<a id="32-symmetric-cryptography"></a>
### 3.2 Symmetric Cryptography

- Block Ciphers vs. Stream Ciphers
- DES, 3DES, and Their Weaknesses
- AES Structure and Key Sizes
- Block Cipher Modes: ECB, CBC, CTR, GCM
- Initialization Vectors and Nonces
- Padding Schemes and Padding Oracle Attacks
- ChaCha20 and Modern Stream Ciphers
- Key Distribution Problem

<a id="33-asymmetric-cryptography"></a>
### 3.3 Asymmetric Cryptography

- Public and Private Key Pairs
- Modular Arithmetic and Number Theory Basics
- RSA Algorithm and Key Generation
- Diffie-Hellman Key Exchange
- Elliptic Curve Cryptography
- Digital Signatures: RSA, DSA, ECDSA, EdDSA
- Hybrid Cryptosystems
- Post-Quantum Cryptography Overview

<a id="34-hashing-and-integrity"></a>
### 3.4 Hashing and Integrity

- Properties of Cryptographic Hash Functions
- MD5 and SHA-1 Collision Attacks
- SHA-2 and SHA-3 Families
- Message Authentication Codes (HMAC)
- Authenticated Encryption (AEAD)
- Password Hashing: bcrypt, scrypt, Argon2
- Salting, Peppering, and Key Stretching
- Rainbow Tables and Their Mitigation

<a id="35-public-key-infrastructure"></a>
### 3.5 Public Key Infrastructure

- Digital Certificates and X.509 Format
- Certificate Authorities and Trust Chains
- Certificate Signing Requests and Issuance
- Revocation: CRL and OCSP
- Certificate Pinning and Transparency Logs
- Self-Signed Certificates and Internal CAs
- Key Lifecycle Management and Escrow
- Hardware Security Modules and TPMs

---

<a id="4-program-analysis"></a>
## 4. Program Analysis

<a id="41-assembly-x86-64"></a>
### 4.1 Assembly x86-64

- CPU Architecture, Registers, and Flags
- Memory Model, Endianness, and Word Sizes
- Instruction Set Basics: mov, arithmetic, logic
- Addressing Modes and Effective Addresses
- Control Flow: jmp, conditional Jumps, loops
- The Stack: push, pop, rsp, and rbp
- Function Prologue and Epilogue
- Calling Conventions: System V AMD64 ABI
- System Calls and Linux ABI
- Compilation Pipeline: Source to Object to Binary
- ELF File Format and Sections
- Linking, Relocations, and the PLT/GOT
- Reading Compiler-Generated Assembly
- Writing and Assembling Minimal Programs

<a id="42-static-program-analysis"></a>
### 4.2 Static Program Analysis

- Disassembly with objdump and Ghidra
- Control Flow Graph Reconstruction
- Identifying Functions, Strings, and Constants
- Decompilation and Its Limitations
- Symbol Stripping and Obfuscation Effects
- Taint Analysis Concepts
- Symbolic Execution Fundamentals

<a id="43-dynamic-program-analysis"></a>
### 4.3 Dynamic Program Analysis

- Debugging with GDB and Extensions
- Breakpoints, Watchpoints, and Stepping
- Inspecting Registers, Stack, and Heap at Runtime
- Syscall Tracing with strace and ltrace
- Memory Error Detection with Valgrind
- Sanitizers: ASan, MSan, UBSan
- Instrumentation and Binary Hooking
- Runtime Tracing with ptrace
- Fuzzing Fundamentals and Coverage Feedback
- Crash Triage and Root Cause Analysis
- Anti-Debugging Techniques and Bypasses

---

<a id="5-program-exploitation"></a>
## 5. Program Exploitation

<a id="51-memory-corruption-foundations"></a>
### 5.1 Memory Corruption Foundations

- Process Memory Layout: Text, Data, Heap, Stack
- Unsafe C Functions and Memory Safety Gaps
- Undefined Behavior as a Security Problem
- Buffer Overflow Concept and Impact
- Heap Overflows and Allocator Metadata
- Use-After-Free and Double Free
- Integer Overflow and Type Confusion
- Off-by-One and Boundary Errors

<a id="52-stack-overflow-exploitation"></a>
### 5.2 Stack Overflow Exploitation

- Overwriting Saved Return Addresses
- Controlling the Instruction Pointer
- Shellcode Construction and Constraints
- NOP Sleds and Payload Placement
- Local vs. Remote Exploitation
- Return-to-libc Attacks
- Return-Oriented Programming (ROP) Chains
- Gadget Discovery and Chain Building
- Stack Pivoting and Limited Overflows
- Building Exploits Against Real Binaries

<a id="53-format-string-vulnerabilities"></a>
### 5.3 Format String Vulnerabilities

- printf Family and Format Specifier Semantics
- Variadic Functions and Argument Retrieval
- Arbitrary Memory Read with %x and %s
- Direct Parameter Access
- Arbitrary Write with %n
- Leaking Stack Contents and Canaries
- Defeating ASLR via Information Leaks
- Combining Leaks with Overflow Primitives

<a id="54-exploit-mitigations"></a>
### 5.4 Exploit Mitigations

- Stack Canaries and Their Bypasses
- Non-Executable Memory (DEP/NX)
- Address Space Layout Randomization
- Position Independent Executables and RELRO
- Control Flow Integrity
- Fortify Source and Compiler Hardening Flags
- Sandboxing and seccomp Filtering
- Layered Mitigation Effectiveness

<a id="55-secure-coding"></a>
### 5.5 Secure Coding

- Safe String and Buffer Handling in C
- Bounds Checking and Defensive Programming
- Input Validation and Canonicalization
- Safe Integer Arithmetic
- Error Handling and Fail-Closed Design
- Avoiding Race Conditions and TOCTOU
- Secure Use of Temporary Files and Privileges
- Memory-Safe Languages: Rust and Managed Runtimes
- Secure Coding Standards: CERT C and MISRA
- Compiler Warnings and Static Analysis in Practice
- Code Review Checklists for Memory Safety

---

<a id="6-system-and-network-security"></a>
## 6. System and Network Security

<a id="61-networking-refresher-for-security"></a>
### 6.1 Networking Refresher for Security

- OSI and TCP/IP Models
- IP Addressing, Subnetting, and NAT
- TCP Handshake and Session States
- UDP and ICMP Behavior
- DNS Resolution Flow
- ARP and Layer 2 Operation
- Common Ports and Services
- Packet Capture and Analysis with Wireshark

<a id="62-identification-and-authentication"></a>
### 6.2 Identification and Authentication

- Identification vs. Authentication vs. Authorization
- Authentication Factors and Categories
- Password Storage, Policies, and Cracking Resistance
- Challenge-Response Protocols
- Multi-Factor Authentication Methods
- TOTP, HOTP, and Push Authentication
- FIDO2, WebAuthn, and Passkeys
- Biometric Authentication and Error Rates
- Certificate-Based and Token-Based Authentication
- Credential Stuffing and Password Spraying
- Kerberos Authentication Flow
- RADIUS, LDAP, and Directory Services

<a id="63-access-control"></a>
### 6.3 Access Control

- Reference Monitor and Security Kernel
- Access Control Matrix, ACLs, and Capabilities
- Discretionary Access Control (DAC)
- Mandatory Access Control (MAC)
- Bell-LaPadula and Biba Models
- Role-Based Access Control (RBAC)
- Attribute-Based Access Control (ABAC)
- Unix Permissions, setuid, and Sudo
- Windows Security Descriptors and Tokens
- SELinux and AppArmor Policies
- Privilege Escalation via Misconfiguration
- Privileged Access Management and Access Reviews

<a id="64-firewalls-and-perimeter-defense"></a>
### 6.4 Firewalls and Perimeter Defense

- Packet Filtering Fundamentals
- Stateless vs. Stateful Inspection
- Application-Layer Gateways and Proxies
- Next-Generation Firewalls and WAFs
- Rule Design, Ordering, and Default Deny
- iptables/nftables and pf Configuration
- NAT, Port Forwarding, and Their Security Impact
- Network Segmentation, VLANs, and DMZ Design
- Network Access Control (NAC)
- Firewall Evasion Techniques and Limitations
- Intrusion Detection vs. Prevention Systems
- Signature-Based vs. Anomaly-Based Detection
- Honeypots and Deception Technology

<a id="65-network-attacks"></a>
### 6.5 Network Attacks

- Packet Sniffing and Eavesdropping
- ARP Spoofing and MAC Flooding
- DNS Spoofing and Cache Poisoning
- Man-in-the-Middle Attacks
- Session Hijacking
- IP and MAC Spoofing
- DoS and Distributed DoS Techniques
- Amplification and Reflection Attacks
- Rogue Access Points and Evil Twin

<a id="66-secure-communication-protocols"></a>
### 6.6 Secure Communication Protocols

- TLS Handshake and Record Protocol
- TLS 1.2 vs. TLS 1.3 Improvements
- Forward Secrecy
- HTTPS, HSTS, and Mixed Content
- SSH Architecture and Key Authentication
- IPsec: AH, ESP, Transport and Tunnel Modes
- VPN Types: Site-to-Site and Remote Access
- DNSSEC, DoH, and DoT
- Email Security: SPF, DKIM, DMARC

<a id="67-wireless-and-mobile-network-security"></a>
### 6.7 Wireless and Mobile Network Security

- WEP, WPA, WPA2, and WPA3
- 4-Way Handshake and KRACK Attack
- Enterprise Wi-Fi with 802.1X
- Bluetooth Attack Surface
- Cellular Network Security Concerns
- NFC and RFID Risks
- Wireless Site Survey and Rogue Detection

---

<a id="7-system-and-endpoint-hardening"></a>
## 7. System and Endpoint Hardening

<a id="71-operating-system-security"></a>
### 7.1 Operating System Security

- Kernel vs. User Mode and Privilege Rings
- Process Isolation and Memory Protection
- Windows Security Model and Group Policy
- Linux Hardening and Kernel Parameters
- Auditing and Logging Subsystems
- Patch Management Strategies
- Secure Boot and Measured Boot
- System Hardening and CIS Benchmarks

<a id="72-malware"></a>
### 7.2 Malware

- Viruses, Worms, and Trojans
- Ransomware Operation and Economics
- Rootkits and Bootkits
- Spyware, Keyloggers, and Adware
- Botnets and Command-and-Control
- Fileless and Living-off-the-Land Techniques
- Packing, Obfuscation, and Polymorphism
- Static vs. Dynamic Malware Analysis
- Sandboxing and Anti-Analysis Evasion

<a id="73-endpoint-defense"></a>
### 7.3 Endpoint Defense

- Antivirus Signature and Heuristic Detection
- Endpoint Detection and Response (EDR)
- Application Allowlisting
- Host-Based Firewalls and HIDS
- Full Disk Encryption: BitLocker and LUKS
- Mobile Device Management (MDM)

<a id="74-virtualization-and-container-security"></a>
### 7.4 Virtualization and Container Security

- Hypervisor Types and Isolation Guarantees
- VM Escape and Side-Channel Risks
- Container Fundamentals: Namespaces and cgroups
- Container Image Scanning and Signing
- Docker Daemon and Rootless Containers
- Kubernetes RBAC and Pod Security
- Secrets Handling in Orchestrators
- Service Mesh and mTLS

---

<a id="8-web-security-server-side"></a>
## 8. Web Security (Server Side)

<a id="81-web-architecture-and-attack-surface"></a>
### 8.1 Web Architecture and Attack Surface

- HTTP Request and Response Anatomy
- Methods, Status Codes, and Headers
- Sessions, Cookies, and State Management
- Server-Side Rendering and Template Engines
- Web Server and Application Server Roles
- Proxies, Load Balancers, and Caching Layers
- Mapping the Application Attack Surface

<a id="82-web-attacks"></a>
### 8.2 Web Attacks

- OWASP Top 10 Overview
- Broken Access Control and IDOR
- Path Traversal and Local File Inclusion
- Remote File Inclusion and File Upload Abuse
- OS Command Injection
- Server-Side Template Injection
- Server-Side Request Forgery (SSRF)
- XML External Entity (XXE) Attacks
- Insecure Deserialization
- Authentication and Session Flaws
- HTTP Request Smuggling
- Security Misconfiguration and Information Leakage
- Business Logic Vulnerabilities

<a id="83-sql-injection-and-defences"></a>
### 8.3 SQL Injection and Defences

- SQL Fundamentals for Attackers
- Injection Points and Context Discovery
- In-Band Injection: Tautologies and Comments
- UNION-Based Data Extraction
- Error-Based Injection
- Stacked Queries and Second-Order Injection
- Database Fingerprinting and Schema Enumeration
- Reading and Writing Files via SQLi
- Privilege Escalation from the Database
- Parameterized Queries and Prepared Statements
- Stored Procedures and ORM Safety
- Input Validation and Allowlisting
- Least Privilege Database Accounts
- WAF Rules and Their Bypasses

<a id="84-blind-sql-injection"></a>
### 8.4 Blind SQL Injection

- Detecting Injection Without Visible Output
- Boolean-Based Inference
- Binary Search Extraction Strategies
- Time-Based Blind Injection with Delays
- Out-of-Band Exfiltration Channels
- Automating Extraction with Python Scripts
- sqlmap Usage and Tuning
- Detecting and Rate-Limiting Blind Attacks

<a id="85-server-side-hardening"></a>
### 8.5 Server-Side Hardening

- Output Encoding by Context
- Secure Session Generation and Rotation
- Rate Limiting and Bot Mitigation
- Secrets and Configuration Management
- Error Handling Without Information Disclosure
- Logging and Monitoring of Web Attacks
- Security Headers Reference

<a id="86-api-and-mobile-back-end-security"></a>
### 8.6 API and Mobile Back-End Security

- REST API Threat Model
- GraphQL-Specific Risks
- API Authentication and Key Management
- OAuth 2.0 Grant Types and Misuse
- OpenID Connect and ID Tokens
- JSON Web Tokens: Structure and Validation Pitfalls
- Mass Assignment and Excessive Data Exposure
- Mobile App Storage and Transport Security

---

<a id="9-web-security-client-side"></a>
## 9. Web Security (Client Side)

<a id="91-browser-security-mechanisms"></a>
### 9.1 Browser Security Mechanisms

- Browser Architecture and Process Sandboxing
- DOM, JavaScript Execution, and Event Model
- Same-Origin Policy and Origin Definition
- Cross-Origin Resource Sharing (CORS)
- Cookie Attributes: HttpOnly, Secure, SameSite
- Cookie Scoping, Domains, and Paths
- Content Security Policy Directives
- Subresource Integrity
- iframe Sandboxing and X-Frame-Options
- Referrer Policy and Permissions Policy
- Site Isolation and Cross-Origin Isolation Headers
- Local Storage, Session Storage, and IndexedDB Risks

<a id="92-cross-site-scripting-xss"></a>
### 9.2 Cross-Site Scripting (XSS)

- Reflected XSS
- Stored (Persistent) XSS
- DOM-Based XSS and Sinks
- Mutation XSS and Parser Differentials
- Payload Construction and Context Escaping
- Filter and Sanitizer Bypass Techniques
- Session Theft and Keylogging via XSS
- Browser Exploitation Frameworks
- Contextual Output Encoding as Defence
- Sanitization Libraries and Trusted Types
- CSP as XSS Mitigation and Its Bypasses

<a id="93-cross-site-request-forgery-csrf"></a>
### 9.3 Cross-Site Request Forgery (CSRF)

- Ambient Authority and the Root Cause
- GET vs. POST-Based CSRF
- Login CSRF and Logout CSRF
- Anti-CSRF Token Patterns
- Double Submit Cookies and Synchronizer Tokens
- SameSite Cookies as Defence
- Origin and Referer Header Validation
- CSRF in APIs and JSON Endpoints

<a id="94-other-client-side-attacks"></a>
### 9.4 Other Client-Side Attacks

- Clickjacking and UI Redressing
- Open Redirects and Tabnabbing
- postMessage and Cross-Window Abuse
- Prototype Pollution in JavaScript
- Client-Side Prototype Pollution to XSS
- Third-Party Script and Supply Chain Risk
- Browser Extension Threats
- Fingerprinting and Tracking Techniques

---

<a id="10-secure-development-lifecycle"></a>
## 10. Secure Development Lifecycle

<a id="101-threat-modeling-and-secure-design"></a>
### 10.1 Threat Modeling and Secure Design

- Threat Modeling with STRIDE
- Attack Trees and DREAD Scoring
- Trust Boundaries and Data Flow Diagrams
- Secure Design Patterns
- Abuse Cases and Security Requirements

<a id="102-security-testing-and-assurance"></a>
### 10.2 Security Testing and Assurance

- Secure Code Review Practices
- Static Application Security Testing (SAST)
- Dynamic and Interactive Testing (DAST/IAST)
- Software Composition Analysis and SBOM
- Dependency and Supply Chain Risk
- Coverage-Guided Fuzzing in CI
- Security Unit and Regression Tests

<a id="103-devsecops"></a>
### 10.3 DevSecOps

- Security Gates in CI/CD Pipelines
- Build Reproducibility and Artifact Signing
- Secrets Scanning in Repositories
- Infrastructure as Code Security Scanning
- Vulnerability Management and SLAs
- CVSS Scoring and Prioritization

---

<a id="11-cloud-and-infrastructure-security"></a>
## 11. Cloud and Infrastructure Security

<a id="111-cloud-security-foundations"></a>
### 11.1 Cloud Security Foundations

- Service Models: IaaS, PaaS, SaaS
- Deployment Models: Public, Private, Hybrid
- Shared Responsibility Model
- Cloud Identity and IAM Policies
- Multi-Tenancy Isolation Risks
- Cloud Storage Exposure and Misconfiguration
- Data Residency and Sovereignty

<a id="112-cloud-defense-practices"></a>
### 11.2 Cloud Defense Practices

- Cloud Security Posture Management
- Cloud Workload Protection Platforms
- Serverless Function Security
- Cloud Logging and Trail Analysis
- Encryption and Key Management Services
- Landing Zones and Guardrails

<a id="113-zero-trust-and-modern-architecture"></a>
### 11.3 Zero Trust and Modern Architecture

- Zero Trust Principles and Tenets
- Microsegmentation
- Continuous Verification and Device Trust
- Software-Defined Perimeter
- Secure Access Service Edge (SASE)
- Migrating from Perimeter-Based Models

<a id="114-operational-technology-and-iot"></a>
### 11.4 Operational Technology and IoT

- ICS and SCADA Architecture
- Purdue Model and OT Segmentation
- IoT Device Constraints and Weak Defaults
- Firmware Extraction and Analysis
- Embedded Protocol Risks: Modbus, MQTT, CAN
- Automotive and Medical Device Security
- Physical Security and Tamper Resistance

---

<a id="12-offensive-security"></a>
## 12. Offensive Security

<a id="121-penetration-testing-methodology"></a>
### 12.1 Penetration Testing Methodology

- Engagement Scoping and Authorization
- Testing Types: Black, Grey, and White Box
- Standard Methodologies: PTES, OSSTMM
- Reporting and Risk Rating Findings
- Red, Blue, and Purple Team Models

<a id="122-reconnaissance-and-enumeration"></a>
### 12.2 Reconnaissance and Enumeration

- Passive OSINT Techniques
- WHOIS, DNS, and Subdomain Enumeration
- Google Dorking and Metadata Harvesting
- Host Discovery and Port Scanning with Nmap
- Service and Version Fingerprinting
- SMB, SNMP, and SMTP Enumeration
- Web Content and Directory Discovery
- Vulnerability Scanning Tools and Triage

<a id="123-exploitation-and-post-exploitation"></a>
### 12.3 Exploitation and Post-Exploitation

- Exploit Selection and Payload Choice
- Metasploit Framework Workflow
- Password Cracking with Hashcat and John
- Privilege Escalation on Linux
- Privilege Escalation on Windows
- Credential Dumping and Pass-the-Hash
- Lateral Movement and Pivoting
- Persistence Mechanisms
- Data Exfiltration Techniques
- Covering Tracks and Anti-Forensics Awareness

<a id="124-social-engineering"></a>
### 12.4 Social Engineering

- Psychological Principles of Influence
- Phishing, Spear Phishing, and Whaling
- Vishing, Smishing, and Pretexting
- Business Email Compromise
- Baiting, Tailgating, and Physical Intrusion
- Deepfakes and Synthetic Media Fraud
- Simulated Phishing Campaign Design

---

<a id="13-defensive-operations-and-incident-response"></a>
## 13. Defensive Operations and Incident Response

<a id="131-security-monitoring"></a>
### 13.1 Security Monitoring

- Security Operations Center Structure
- Log Sources and Normalization
- SIEM Architecture and Correlation Rules
- SOAR and Automated Playbooks
- Alert Triage and False Positive Tuning
- User and Entity Behavior Analytics
- Network Traffic Analysis and NetFlow
- Detection Engineering and Sigma Rules

<a id="132-threat-intelligence-and-hunting"></a>
### 13.2 Threat Intelligence and Hunting

- Intelligence Types: Strategic, Tactical, Operational
- Indicators of Compromise vs. Behavior
- Pyramid of Pain
- Threat Feeds, STIX, and TAXII
- Hypothesis-Driven Threat Hunting
- ATT&CK-Based Detection Coverage Mapping
- Attribution Challenges

<a id="133-incident-response"></a>
### 13.3 Incident Response

- IR Lifecycle: Preparation to Lessons Learned
- Incident Classification and Severity Levels
- Containment, Eradication, and Recovery
- Communication and Escalation Plans
- Ransomware Response Playbook
- Breach Notification Obligations
- Tabletop Exercises and IR Testing
- Post-Incident Review and Metrics

<a id="134-digital-forensics"></a>
### 13.4 Digital Forensics

- Forensic Principles and Order of Volatility
- Evidence Acquisition and Imaging
- Chain of Custody Documentation
- Disk and File System Forensics
- Memory Forensics with Volatility
- Windows Artifacts and Registry Analysis
- Linux and macOS Artifact Analysis
- Network and Log Forensics
- Mobile and Cloud Forensics
- Timeline Reconstruction and Reporting

<a id="135-resilience-and-continuity"></a>
### 13.5 Resilience and Continuity

- Backup Strategies and the 3-2-1 Rule
- Immutable and Offline Backups
- RTO and RPO Definitions
- Disaster Recovery Planning
- High Availability and Redundancy
- Business Continuity Testing

---

<a id="14-emerging-and-specialized-topics"></a>
## 14. Emerging and Specialized Topics

<a id="141-data-protection-and-privacy-engineering"></a>
### 14.1 Data Protection and Privacy Engineering

- Data Classification and Labeling
- Data Loss Prevention Systems
- Anonymization and Pseudonymization
- Differential Privacy Basics
- Data Minimization and Retention Policies
- Privacy by Design
- Secure Data Destruction

<a id="142-ai-and-machine-learning-security"></a>
### 14.2 AI and Machine Learning Security

- ML in Threat Detection and Its Limits
- Adversarial Examples and Evasion Attacks
- Data Poisoning and Model Backdoors
- Model Inversion and Membership Inference
- Prompt Injection and LLM Attack Surface
- Securing AI Agents and Tool Access
- AI-Assisted Offensive Operations
- AI Governance and Model Supply Chain

<a id="143-advanced-and-frontier-areas"></a>
### 14.3 Advanced and Frontier Areas

- Side-Channel and Fault Injection Attacks
- Hardware Vulnerabilities: Spectre and Meltdown
- Blockchain and Smart Contract Security
- Cryptocurrency Tracing and Laundering
- Quantum Computing Impact on Cryptography
- Supply Chain Attack Case Studies
- Cyber Warfare and Critical Infrastructure

<a id="144-career-and-continuous-practice"></a>
### 14.4 Career and Continuous Practice

- Security Role Specializations
- Certification Pathways
- Home Lab and Range Construction
- Capture The Flag Competitions
- Vulnerability Research and CVE Process
- Staying Current with the Threat Landscape
