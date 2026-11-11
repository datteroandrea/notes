# Study Path

This page maps the notes in this repository to the most common Software Engineer roles. For each role it points to the chapters and subchapters that matter most, so you can skip what is irrelevant and go deep where it counts.

## Index

- [1. How to Use This Path](#1-how-to-use-this-path)
- [2. Common Core (Every Software Engineer)](#2-common-core-every-software-engineer)
- [3. Backend Engineer](#3-backend-engineer)
- [4. Frontend Engineer](#4-frontend-engineer)
- [5. Full-Stack Engineer](#5-full-stack-engineer)
- [6. DevOps and Platform Engineer](#6-devops-and-platform-engineer)
- [7. Site Reliability Engineer (SRE)](#7-site-reliability-engineer-sre)
- [8. Cloud Engineer (Azure)](#8-cloud-engineer-azure)
- [9. Data Engineer](#9-data-engineer)
- [10. Data Scientist](#10-data-scientist)
- [11. Machine Learning and AI Engineer](#11-machine-learning-and-ai-engineer)
- [12. Security Engineer](#12-security-engineer)
- [13. Systems and Embedded Engineer](#13-systems-and-embedded-engineer)
- [14. Network Engineer](#14-network-engineer)
- [15. Database Engineer](#15-database-engineer)
- [16. FinTech Engineer (Banking and Treasury)](#16-fintech-engineer-banking-and-treasury)
- [17. Technical Interview Track](#17-technical-interview-track)
- [18. Notes-to-Roles Matrix](#18-notes-to-roles-matrix)

---

## 1. How to Use This Path

1. **Start with the [Common Core](#2-common-core-every-software-engineer).** Every role below assumes it.
2. **Pick your role** and work through its sections in order:

| Tier | Meaning | When to study it |
|------|---------|------------------|
| **Core** | Day-to-day knowledge for the role; interviews test it directly | First, in the order listed |
| **Recommended** | Separates a solid engineer from a beginner in the role | After the Core feels comfortable |
| **Deep Dive** | Specialist or senior-level material | When the job or your curiosity calls for it |

3. **Use the checkpoint** at the end of each role to check yourself. If you can't answer a question, go back to the linked subchapter.
4. A link to a whole **chapter** (for example `8. Distributed Systems Theory`) means read all of it. A link to a **subchapter** (for example `8.2 Consistency Models`) means that part is enough.
5. Every subchapter ends with a *Practice* block. Do the exercises; reading alone does not stick.

---

## 2. Common Core (Every Software Engineer)

> The shared base for every role: how a computer runs your code, how machines talk to each other, how data is stored, and how to reason about algorithms.

### Core

- **[Algorithms and Data Structures](./computer-science/algorithms-and-data-structures.md)**
  - [0. Interview Foundations](./computer-science/algorithms-and-data-structures.md#0-interview-foundations), [1. Array and Hashing](./computer-science/algorithms-and-data-structures.md#1-array-and-hashing), [2. Two Pointer](./computer-science/algorithms-and-data-structures.md#2-two-pointer), [4. Binary Search](./computer-science/algorithms-and-data-structures.md#4-binary-search): complexity analysis and the most frequent patterns
  - [6. Linked List](./computer-science/algorithms-and-data-structures.md#6-linked-list), [7. Trees](./computer-science/algorithms-and-data-structures.md#7-trees), [10. Heap or Priority Queue](./computer-science/algorithms-and-data-structures.md#10-heap-or-priority-queue): linked structures, trees and heaps
  - [14. Advanced Graphs](./computer-science/algorithms-and-data-structures.md#14-advanced-graphs), [11. 1D Dynamic Programming](./computer-science/algorithms-and-data-structures.md#11-1d-dynamic-programming): graphs and an introduction to dynamic programming
- **[Discrete Mathematics](./math/discrete-mathematics.md)**
  - [1.4 Proof Techniques](./math/discrete-mathematics.md#14-proof-techniques), [3.2 Mathematical Induction](./math/discrete-mathematics.md#32-mathematical-induction): proving that code is correct (invariants, induction)
  - [5.1 Counting Principles](./math/discrete-mathematics.md#51-counting-principles), [5.2 Permutations and Combinations](./math/discrete-mathematics.md#52-permutations-and-combinations): counting, the base of complexity estimates
  - [8.1 Graph Fundamentals](./math/discrete-mathematics.md#81-graph-fundamentals), [8.4 Traversals and Paths](./math/discrete-mathematics.md#84-traversals-and-paths), [9.1 Tree Fundamentals](./math/discrete-mathematics.md#91-tree-fundamentals): graphs and trees, which appear everywhere
  - [10. Algorithms and Complexity](./math/discrete-mathematics.md#10-algorithms-and-complexity): Big-O, growth of functions, complexity analysis
- **[Operative Systems](./computer-science/operative-systems.md)**
  - [2.1 Process Concept](./computer-science/operative-systems.md#21-process-concept), [2.3 Interprocess Communication](./computer-science/operative-systems.md#23-interprocess-communication): processes and IPC
  - [3.1 Thread Fundamentals](./computer-science/operative-systems.md#31-thread-fundamentals): threads
  - [5.1 The Critical Section Problem](./computer-science/operative-systems.md#51-the-critical-section-problem), [5.3 Synchronization Primitives](./computer-science/operative-systems.md#53-synchronization-primitives), [6.1 Deadlock Characterization](./computer-science/operative-systems.md#61-deadlock-characterization): race conditions, locks and deadlocks
  - [7.3 Paging](./computer-science/operative-systems.md#73-paging), [8.1 Demand Paging](./computer-science/operative-systems.md#81-demand-paging), [8.2 Page Replacement](./computer-science/operative-systems.md#82-page-replacement): paging and virtual memory
- **[Networking](./computer-science/networking.md)**
  - [2.3 The TCP/IP Model](./computer-science/networking.md#23-the-tcpip-model): the TCP/IP stack
  - [5.2 IPv4 Addressing](./computer-science/networking.md#52-ipv4-addressing): IP addressing and subnets
  - [7.3 TCP Mechanics](./computer-science/networking.md#73-tcp-mechanics): how TCP works (handshake, retransmission)
  - [8.2 Naming and the Domain Name System](./computer-science/networking.md#82-naming-and-the-domain-name-system), [8.3 The Web and HTTP](./computer-science/networking.md#83-the-web-and-http): DNS and HTTP, which every engineer debugs
- **[Database Systems in Postgres](./computer-science/dbms.md)**
  - [2.3 Normalization](./computer-science/dbms.md#23-normalization): normalization
  - [4.3 Joining Tables](./computer-science/dbms.md#43-joining-tables), [4.4 Aggregation and Grouping](./computer-science/dbms.md#44-aggregation-and-grouping): joins and aggregation
  - [6.2 Index Structures](./computer-science/dbms.md#62-index-structures): how indexes work (B-tree, hash)
  - [8.1 Transaction Basics](./computer-science/dbms.md#81-transaction-basics), [8.2 Isolation Levels](./computer-science/dbms.md#82-isolation-levels): ACID transactions and isolation levels

### Recommended

- **[System Design](./computer-science/system-design.md)**: [1.2 Core Quality Attributes](./computer-science/system-design.md#12-core-quality-attributes), [1.4 Design Process and Trade-offs](./computer-science/system-design.md#14-design-process-and-trade-offs): the vocabulary of trade-offs (latency, throughput, availability)
- **[Cyber Security](./computer-science/cyber-security.md)**: [1.1 Core Security Principles](./computer-science/cyber-security.md#11-core-security-principles), [3.1 Cryptographic Fundamentals](./computer-science/cyber-security.md#31-cryptographic-fundamentals): CIA triad, least privilege, basic cryptography
- **[Docker](./computer-science/docker.md)**: [1.1 Introduction to Containers](./computer-science/docker.md#11-introduction-to-containers), [5.1 Dockerfile Basics](./computer-science/docker.md#51-dockerfile-basics): what a container is and how to write a Dockerfile
- **[GitLab CI/CD](./computer-science/gitlab.md)**: [1.1 CI/CD Core Concepts](./computer-science/gitlab.md#11-cicd-core-concepts): what CI/CD is and why it matters

### Pick One Language and Go Deep

| If you choose... | Study |
|------------------|-------|
| Java | [2. Classes, Objects, and Encapsulation](./computer-science/java.md#2-classes-objects-and-encapsulation), [3. Inheritance and Polymorphism](./computer-science/java.md#3-inheritance-and-polymorphism), [4. Interfaces and Abstraction Contracts](./computer-science/java.md#4-interfaces-and-abstraction-contracts), [5. Exception Handling and Robustness](./computer-science/java.md#5-exception-handling-and-robustness), [7. The Collections Framework](./computer-science/java.md#7-the-collections-framework), [8. Functional Programming in an Object-Oriented Language](./computer-science/java.md#8-functional-programming-in-an-object-oriented-language) |
| Rust | [2. Core Language Syntax](./computer-science/rust.md#2-core-language-syntax), [3. Ownership and Memory Model](./computer-science/rust.md#3-ownership-and-memory-model), [4. Data Modeling with Types](./computer-science/rust.md#4-data-modeling-with-types), [5. Traits and Abstraction](./computer-science/rust.md#5-traits-and-abstraction), [7. Error Handling](./computer-science/rust.md#7-error-handling) |
| C | [2. Types, Values, and Expressions](./computer-science/c.md#2-types-values-and-expressions), [4. Functions and Program Organization](./computer-science/c.md#4-functions-and-program-organization), [5. Arrays, Strings, and Pointers](./computer-science/c.md#5-arrays-strings-and-pointers), [6. Composite and User-Defined Types](./computer-science/c.md#6-composite-and-user-defined-types), [7. Memory Management](./computer-science/c.md#7-memory-management) |
| JavaScript / TypeScript | [3. JavaScript Language Core](./computer-science/web-technologies.md#3-javascript-language-core), [4. Objects, Arrays and Object-Oriented JavaScript](./computer-science/web-technologies.md#4-objects-arrays-and-object-oriented-javascript), [5. Asynchronous Programming in JavaScript](./computer-science/web-technologies.md#5-asynchronous-programming-in-javascript), [9. TypeScript](./computer-science/web-technologies.md#9-typescript) |

### Checkpoint

- Can you state the time and space complexity of your own solution without being asked?
- What happens, from DNS lookup to rendered response, when you type a URL into a browser?
- Why can two threads incrementing the same counter lose updates, and how do you fix it?
- What anomaly does `READ COMMITTED` allow that `SERIALIZABLE` prevents?

---

## 3. Backend Engineer

> Builds the services, APIs and data layers behind applications. The job comes down to correctness under concurrency, good API contracts and data that stays consistent.

### Core

- **Language and framework** (pick one stack)
  - Java: [12. Concurrency & Parallelism](./computer-science/java.md#12-concurrency--parallelism), [16. Database Connectivity with JDBC](./computer-science/java.md#16-database-connectivity-with-jdbc), [17. The Spring Framework](./computer-science/java.md#17-the-spring-framework), [18. Spring Boot and Production Applications](./computer-science/java.md#18-spring-boot-and-production-applications)
  - Node.js: [11. Node.js Server-Side JavaScript Runtime](./computer-science/web-technologies.md#11-nodejs-server-side-javascript-runtime), [12. Middleware and Server Frameworks with Express](./computer-science/web-technologies.md#12-middleware-and-server-frameworks-with-express), [13. Storage and Data Persistence](./computer-science/web-technologies.md#13-storage-and-data-persistence)
  - Rust: [10. Concurrency and Parallelism](./computer-science/rust.md#10-concurrency-and-parallelism), [11. Asynchronous Rust](./computer-science/rust.md#11-asynchronous-rust), [16.4 Networking and Web](./computer-science/rust.md#164-networking-and-web)
- **[System Design](./computer-science/system-design.md)**
  - [3. APIs and Service Interfaces](./computer-science/system-design.md#3-apis-and-service-interfaces): API design, REST vs gRPC vs GraphQL, versioning, gateways
  - [4.2 Relational Databases](./computer-science/system-design.md#42-relational-databases), [4.3 NoSQL and Specialized Stores](./computer-science/system-design.md#43-nosql-and-specialized-stores): choosing between SQL and NoSQL
  - [5.1 Caching Fundamentals](./computer-science/system-design.md#51-caching-fundamentals), [5.2 Caching Strategies](./computer-science/system-design.md#52-caching-strategies): caching (cache-aside, write-through, invalidation)
  - [6.3 Traffic Control](./computer-science/system-design.md#63-traffic-control): rate limiting and backpressure
  - [7.1 Message Queues](./computer-science/system-design.md#71-message-queues), [7.3 Delivery Semantics](./computer-science/system-design.md#73-delivery-semantics): queues and at-least-once / exactly-once semantics
  - [9.2 Resilience Patterns](./computer-science/system-design.md#92-resilience-patterns): timeouts, retries, circuit breakers, idempotency
- **[Database Systems in Postgres](./computer-science/dbms.md)**
  - [4. SQL Querying Fundamentals](./computer-science/dbms.md#4-sql-querying-fundamentals): all of SQL querying
  - [5.1 Common Table Expressions](./computer-science/dbms.md#51-common-table-expressions), [5.2 Window Functions](./computer-science/dbms.md#52-window-functions): CTEs and window functions
  - [6.3 Index Design and Usage](./computer-science/dbms.md#63-index-design-and-usage), [7.3 Reading Execution Plans](./computer-science/dbms.md#73-reading-execution-plans), [7.4 Performance Tuning](./computer-science/dbms.md#74-performance-tuning): choosing indexes and reading `EXPLAIN`
  - [8.3 Multiversion Concurrency Control](./computer-science/dbms.md#83-multiversion-concurrency-control), [8.4 Locking](./computer-science/dbms.md#84-locking): MVCC and locking, the source of most production surprises
- **[Web Technologies](./computer-science/web-technologies.md)**
  - [10.1 The HTTP Protocol](./computer-science/web-technologies.md#101-the-http-protocol), [10.2 Cookies and Sessions](./computer-science/web-technologies.md#102-cookies-and-sessions), [10.3 Authentication and Authorization](./computer-science/web-technologies.md#103-authentication-and-authorization), [10.4 REST-Style APIs](./computer-science/web-technologies.md#104-rest-style-apis): HTTP semantics, sessions, auth, REST

### Recommended

- **[System Design](./computer-science/system-design.md)**: [4.4 Replication](./computer-science/system-design.md#44-replication), [4.5 Partitioning and Sharding](./computer-science/system-design.md#45-partitioning-and-sharding), [8.2 Consistency Models](./computer-science/system-design.md#82-consistency-models), [8.5 Distributed Transactions](./computer-science/system-design.md#85-distributed-transactions), [10.2 Service-Oriented Architectures](./computer-science/system-design.md#102-service-oriented-architectures), [10.3 Event-Driven Architectures](./computer-science/system-design.md#103-event-driven-architectures), [11.1 Authentication and Authorization](./computer-science/system-design.md#111-authentication-and-authorization), [12.1 Telemetry Pillars](./computer-science/system-design.md#121-telemetry-pillars)
- **[Object Oriented Programming in Java](./computer-science/java.md)**: [9.2 SOLID Principles](./computer-science/java.md#92-solid-principles), [9.3 Creational Patterns](./computer-science/java.md#93-creational-patterns), [9.4 Structural Patterns](./computer-science/java.md#94-structural-patterns), [9.5 Behavioral Patterns](./computer-science/java.md#95-behavioral-patterns), [15.1 Testing Object-Oriented Code](./computer-science/java.md#151-testing-object-oriented-code): SOLID, design patterns, testing
- **[Cyber Security](./computer-science/cyber-security.md)**: [8.2 Web Attacks](./computer-science/cyber-security.md#82-web-attacks), [8.3 SQL Injection and Defences](./computer-science/cyber-security.md#83-sql-injection-and-defences), [8.6 API and Mobile Back-End Security](./computer-science/cyber-security.md#86-api-and-mobile-back-end-security): injection and API security
- **[Networking](./computer-science/networking.md)**: [9.1 The Socket API](./computer-science/networking.md#91-the-socket-api), [9.2 Concurrency Models](./computer-science/networking.md#92-concurrency-models): sockets and server concurrency models
- **[Operative Systems](./computer-science/operative-systems.md)**: [3.2 Threading Models](./computer-science/operative-systems.md#32-threading-models), [11.2 I/O Software Layers](./computer-science/operative-systems.md#112-io-software-layers): threading models and how async I/O works underneath
- **[Docker](./computer-science/docker.md)**: [5. Building Images with Dockerfiles](./computer-science/docker.md#5-building-images-with-dockerfiles), [8. Docker Compose](./computer-science/docker.md#8-docker-compose): containerize the service and run it locally with its dependencies

### Deep Dive

- [8.4 Consensus and Coordination](./computer-science/system-design.md#84-consensus-and-coordination): Raft, leader election, distributed locks
- [15.4 Transactional and Real-Time Systems](./computer-science/system-design.md#154-transactional-and-real-time-systems): payment, booking and real-time system case studies
- [12. Replication and High Availability](./computer-science/dbms.md#12-replication-and-high-availability): replication and high availability
- [9. Event-Based Solutions](./computer-science/azure.md#9-event-based-solutions), [10. Message-Based Solutions](./computer-science/azure.md#10-message-based-solutions): event and message brokers in practice

### Checkpoint

- Design `POST /payments` so that a client retry never charges twice.
- Explain cache-aside and two ways the cache can go stale.
- Read an `EXPLAIN ANALYZE` output and say why the planner skipped your index.

---

## 4. Frontend Engineer

> Builds what users see and touch. You need to understand the browser as a runtime, JavaScript's concurrency model, rendering performance and accessibility.

### Core

- **[Web Technologies](./computer-science/web-technologies.md)**
  - [2. Document Structure and Presentation](./computer-science/web-technologies.md#2-document-structure-and-presentation): HTML, CSS, layout and responsive design
  - [3. JavaScript Language Core](./computer-science/web-technologies.md#3-javascript-language-core), [4. Objects, Arrays and Object-Oriented JavaScript](./computer-science/web-technologies.md#4-objects-arrays-and-object-oriented-javascript): JavaScript fundamentals, prototypes and classes
  - [5. Asynchronous Programming in JavaScript](./computer-science/web-technologies.md#5-asynchronous-programming-in-javascript): event loop, promises, `async/await`, `fetch`
  - [6. Browser APIs: DOM, Style and Events](./computer-science/web-technologies.md#6-browser-apis-dom-style-and-events): DOM and the event system (bubbling, delegation)
  - [9. TypeScript](./computer-science/web-technologies.md#9-typescript): TypeScript
- **[React Interview Study Guide](./computer-science/react.md)**
  - [1. JavaScript Fundamentals for React](./computer-science/react.md#1-javascript-fundamentals-for-react): closures and async, which React interviews always probe
  - [2. React Core Concepts](./computer-science/react.md#2-react-core-concepts), [3. React Hooks (Deep Dive)](./computer-science/react.md#3-react-hooks-deep-dive): components, state and every core hook
  - [4. Rendering & Performance](./computer-science/react.md#4-rendering--performance): re-render model, memoization, code splitting
  - [5. State Management](./computer-science/react.md#5-state-management): Context, `useReducer`, Redux Toolkit
  - [9. Data Fetching & Side Effects](./computer-science/react.md#9-data-fetching--side-effects): data fetching and TanStack Query

### Recommended

- **[React Interview Study Guide](./computer-science/react.md)**: [6. Routing](./computer-science/react.md#6-routing), [7. Forms & Validation](./computer-science/react.md#7-forms--validation), [10. Testing](./computer-science/react.md#10-testing), [11. TypeScript with React](./computer-science/react.md#11-typescript-with-react), [12. Architecture & Patterns](./computer-science/react.md#12-architecture--patterns), [14. Accessibility (a11y)](./computer-science/react.md#14-accessibility-a11y)
- **[Web Technologies](./computer-science/web-technologies.md)**: [10.1 The HTTP Protocol](./computer-science/web-technologies.md#101-the-http-protocol), [10.2 Cookies and Sessions](./computer-science/web-technologies.md#102-cookies-and-sessions), [10.5 Real-Time Communication and WebSocket](./computer-science/web-technologies.md#105-real-time-communication-and-websocket): HTTP, cookies, WebSocket
- **[Web Technologies](./computer-science/web-technologies.md)**: [17.1 Web Application Security](./computer-science/web-technologies.md#171-web-application-security), [17.2 Testing and Code Quality](./computer-science/web-technologies.md#172-testing-and-code-quality): front-end security and testing
- **[Cyber Security](./computer-science/cyber-security.md)**: [9. Web Security (Client Side)](./computer-science/cyber-security.md#9-web-security-client-side): XSS, CSRF, CSP, CORS and same-origin policy
- **[System Design](./computer-science/system-design.md)**: [5.4 Content Delivery Networks](./computer-science/system-design.md#54-content-delivery-networks): CDNs and edge caching

### Deep Dive

- [13. Next.js & SSR](./computer-science/react.md#13-nextjs--ssr): SSR, SSG, App Router
- [7. Graphics and Rendering APIs](./computer-science/web-technologies.md#7-graphics-and-rendering-apis): SVG, Canvas, WebGL for visualizations
- [15.2 Progressive Web Apps](./computer-science/web-technologies.md#152-progressive-web-apps): Progressive Web Apps
- [16. Cross-Platform Web-Based Native Applications](./computer-science/web-technologies.md#16-cross-platform-web-based-native-applications): Electron desktop apps
- [8. The jQuery Library](./computer-science/web-technologies.md#8-the-jquery-library): jQuery, only if you maintain legacy code

### Checkpoint

- In what order do `setTimeout`, a resolved promise and synchronous code run?
- Why does a component re-render when its props look unchanged, and how do you stop it?
- How does `HttpOnly` + `SameSite` on a cookie help against XSS and CSRF?

---

## 5. Full-Stack Engineer

> Ships features end to end. The goal is breadth: enough of each layer to build, deploy and debug a complete product without being blocked.

### Core (in order)

1. **Browser:** [2. Document Structure and Presentation](./computer-science/web-technologies.md#2-document-structure-and-presentation), [3. JavaScript Language Core](./computer-science/web-technologies.md#3-javascript-language-core), [5. Asynchronous Programming in JavaScript](./computer-science/web-technologies.md#5-asynchronous-programming-in-javascript), [6. Browser APIs: DOM, Style and Events](./computer-science/web-technologies.md#6-browser-apis-dom-style-and-events)
2. **UI framework:** [2. React Core Concepts](./computer-science/react.md#2-react-core-concepts), [3. React Hooks (Deep Dive)](./computer-science/react.md#3-react-hooks-deep-dive), [5. State Management](./computer-science/react.md#5-state-management), [9. Data Fetching & Side Effects](./computer-science/react.md#9-data-fetching--side-effects)
3. **Server:** [10. The HTTP Protocol and Web Communication](./computer-science/web-technologies.md#10-the-http-protocol-and-web-communication), [11. Node.js Server-Side JavaScript Runtime](./computer-science/web-technologies.md#11-nodejs-server-side-javascript-runtime), [12. Middleware and Server Frameworks with Express](./computer-science/web-technologies.md#12-middleware-and-server-frameworks-with-express)
4. **Data:** [13. Storage and Data Persistence](./computer-science/web-technologies.md#13-storage-and-data-persistence), [2. Relational Design and Data Modeling](./computer-science/dbms.md#2-relational-design-and-data-modeling), [4. SQL Querying Fundamentals](./computer-science/dbms.md#4-sql-querying-fundamentals), [8.2 Isolation Levels](./computer-science/dbms.md#82-isolation-levels)
5. **Ship it:** [5. Building Images with Dockerfiles](./computer-science/docker.md#5-building-images-with-dockerfiles), [8. Docker Compose](./computer-science/docker.md#8-docker-compose), [2. Pipeline Configuration Fundamentals](./computer-science/gitlab.md#2-pipeline-configuration-fundamentals), [12.1 Environments](./computer-science/gitlab.md#121-environments), [17.3 Build, Deployment and Operations](./computer-science/web-technologies.md#173-build-deployment-and-operations)

### Recommended

- **[Web Technologies](./computer-science/web-technologies.md)**: [9. TypeScript](./computer-science/web-technologies.md#9-typescript) (TypeScript on both sides), [17.1 Web Application Security](./computer-science/web-technologies.md#171-web-application-security)
- **[System Design](./computer-science/system-design.md)**: [3.1 API Design Principles](./computer-science/system-design.md#31-api-design-principles), [3.2 API Styles](./computer-science/system-design.md#32-api-styles), [5.2 Caching Strategies](./computer-science/system-design.md#52-caching-strategies), [15.1 Foundational Building Blocks](./computer-science/system-design.md#151-foundational-building-blocks)
- **[Cyber Security](./computer-science/cyber-security.md)**: [8.2 Web Attacks](./computer-science/cyber-security.md#82-web-attacks), [9.2 Cross-Site Scripting (XSS)](./computer-science/cyber-security.md#92-cross-site-scripting-xss), [9.3 Cross-Site Request Forgery (CSRF)](./computer-science/cyber-security.md#93-cross-site-request-forgery-csrf)
- **[React Interview Study Guide](./computer-science/react.md)**: [4. Rendering & Performance](./computer-science/react.md#4-rendering--performance), [10. Testing](./computer-science/react.md#10-testing), [13. Next.js & SSR](./computer-science/react.md#13-nextjs--ssr)

### Deep Dive

- [3.2 Azure App Service](./computer-science/azure.md#32-azure-app-service), [3.5 Static Web Apps](./computer-science/azure.md#35-static-web-apps): hosting web apps on a managed platform
- [12.2 Review Apps](./computer-science/gitlab.md#122-review-apps): review apps for every merge request
- Then specialize toward [Backend](#3-backend-engineer) or [Frontend](#4-frontend-engineer)

### Checkpoint

- Build and deploy a CRUD app with authentication, a relational database and a CI pipeline, and explain every layer it touches.

---

## 6. DevOps and Platform Engineer

> Builds the paved road other engineers ship on: build pipelines, container platforms and infrastructure as code.

### Core

- **[Docker](./computer-science/docker.md)**
  - [1.2 Linux Foundations of Containers](./computer-science/docker.md#12-linux-foundations-of-containers): namespaces, cgroups, union filesystems
  - [3. Working with Containers](./computer-science/docker.md#3-working-with-containers), [4. Docker Images](./computer-science/docker.md#4-docker-images), [5. Building Images with Dockerfiles](./computer-science/docker.md#5-building-images-with-dockerfiles): containers, images, Dockerfiles, multi-stage builds
  - [6. Data Persistence and Storage](./computer-science/docker.md#6-data-persistence-and-storage), [7. Docker Networking](./computer-science/docker.md#7-docker-networking): volumes and networking
  - [10. Docker Security](./computer-science/docker.md#10-docker-security): security hardening and supply chain
  - [13. Docker in Development and CI/CD](./computer-science/docker.md#13-docker-in-development-and-cicd): Docker in CI/CD
- **[Kubernetes](./computer-science/kubernetes.md)**
  - [2. Kubernetes Architecture](./computer-science/kubernetes.md#2-kubernetes-architecture): control plane, kubelet, reconciliation loop
  - [4. Workload Resources](./computer-science/kubernetes.md#4-workload-resources), [5. Configuration and Secrets Management](./computer-science/kubernetes.md#5-configuration-and-secrets-management): workloads, ConfigMaps, Secrets
  - [6. Networking](./computer-science/kubernetes.md#6-networking), [7. Storage](./computer-science/kubernetes.md#7-storage): Services, Ingress, NetworkPolicy, PersistentVolumes
  - [8. Scheduling and Resource Management](./computer-science/kubernetes.md#8-scheduling-and-resource-management): requests, limits, scheduling, autoscaling
  - [11. Helm and Package Management](./computer-science/kubernetes.md#11-helm-and-package-management), [12. CI/CD and GitOps](./computer-science/kubernetes.md#12-cicd-and-gitops): Helm, Kustomize, GitOps with Argo CD / Flux
- **[GitLab CI/CD](./computer-science/gitlab.md)**
  - [2. Pipeline Configuration Fundamentals](./computer-science/gitlab.md#2-pipeline-configuration-fundamentals), [3. Pipeline Architecture](./computer-science/gitlab.md#3-pipeline-architecture), [4. Job Control and Execution Flow](./computer-science/gitlab.md#4-job-control-and-execution-flow): jobs, stages, DAG, parent-child pipelines, `rules`
  - [5. Variables and Secrets](./computer-science/gitlab.md#5-variables-and-secrets), [6. GitLab Runners](./computer-science/gitlab.md#6-gitlab-runners): variables, secrets, runners and executors
  - [7. Docker and Container Workflows](./computer-science/gitlab.md#7-docker-and-container-workflows), [8. Artifacts, Caching and Releases](./computer-science/gitlab.md#8-artifacts-caching-and-releases): building images, artifacts and caching
  - [12. Deployment and Environments](./computer-science/gitlab.md#12-deployment-and-environments): environments and deployment strategies
- **[Networking](./computer-science/networking.md)**: [5.2 IPv4 Addressing](./computer-science/networking.md#52-ipv4-addressing), [5.6 Address Translation](./computer-science/networking.md#56-address-translation), [8.2 Naming and the Domain Name System](./computer-science/networking.md#82-naming-and-the-domain-name-system), [14.1 Diagnostic Tools](./computer-science/networking.md#141-diagnostic-tools): subnets, NAT, DNS, diagnostic tools
- **[Operative Systems](./computer-science/operative-systems.md)**: [1.5 System Interfaces](./computer-science/operative-systems.md#15-system-interfaces), [13.3 Containers and Lightweight Isolation](./computer-science/operative-systems.md#133-containers-and-lightweight-isolation): system interfaces and container isolation

### Recommended

- **[Kubernetes](./computer-science/kubernetes.md)**: [9. Security](./computer-science/kubernetes.md#9-security), [10. Observability](./computer-science/kubernetes.md#10-observability), [16. Cluster Operations and Maintenance](./computer-science/kubernetes.md#16-cluster-operations-and-maintenance)
- **[GitLab CI/CD](./computer-science/gitlab.md)**: [9. Reusable and Modular Configuration](./computer-science/gitlab.md#9-reusable-and-modular-configuration), [11. Security and Compliance (DevSecOps)](./computer-science/gitlab.md#11-security-and-compliance-devsecops), [13. Pipeline Optimization](./computer-science/gitlab.md#13-pipeline-optimization)
- **[Azure Developer](./computer-science/azure.md)**: [12. Infrastructure as Code and DevOps](./computer-science/azure.md#12-infrastructure-as-code-and-devops): ARM, Bicep, Terraform, pipelines
- **[Docker](./computer-science/docker.md)**: [9. Advanced Builds with BuildKit](./computer-science/docker.md#9-advanced-builds-with-buildkit), [11. Resource Management and Performance](./computer-science/docker.md#11-resource-management-and-performance), [12. Logging, Monitoring, and Debugging](./computer-science/docker.md#12-logging-monitoring-and-debugging)
- **[Cyber Security](./computer-science/cyber-security.md)**: [7.4 Virtualization and Container Security](./computer-science/cyber-security.md#74-virtualization-and-container-security), [10.3 DevSecOps](./computer-science/cyber-security.md#103-devsecops): container security and DevSecOps
- **[System Design](./computer-science/system-design.md)**: [12.3 Deployment and Release](./computer-science/system-design.md#123-deployment-and-release), [12.4 Infrastructure Management](./computer-science/system-design.md#124-infrastructure-management): release strategies, infrastructure management

### Deep Dive

- [13. Service Mesh](./computer-science/kubernetes.md#13-service-mesh), [14. Extending Kubernetes](./computer-science/kubernetes.md#14-extending-kubernetes), [15. Multi-Cluster and Federation](./computer-science/kubernetes.md#15-multi-cluster-and-federation), [17.1 eBPF in Kubernetes](./computer-science/kubernetes.md#171-ebpf-in-kubernetes): service mesh, operators, multi-cluster, eBPF
- [15. Docker Internals and Extensibility](./computer-science/docker.md#15-docker-internals-and-extensibility): engine internals
- [15. Administration, Automation and Migration](./computer-science/gitlab.md#15-administration-automation-and-migration): CI/CD governance at scale
- [13.5 Network Automation](./computer-science/networking.md#135-network-automation): network automation

### Checkpoint

- Trace a `kubectl apply` from the API server to a running container.
- Why does a pod get `OOMKilled`, and how do requests and limits relate to QoS classes?
- Design a pipeline that builds once, scans, and promotes the same image through staging to production.

---

## 7. Site Reliability Engineer (SRE)

> Keeps production fast and available, and treats operations as a software problem: SLOs, observability, capacity planning and incident response.

### Core

- **[System Design](./computer-science/system-design.md)**
  - [9. Reliability, Availability, and Fault Tolerance](./computer-science/system-design.md#9-reliability-availability-and-fault-tolerance): availability engineering, resilience patterns, failure modes, reliability practice
  - [12. Observability and Operations](./computer-science/system-design.md#12-observability-and-operations): telemetry, alerting, deployment, infrastructure
  - [6.1 Scaling Approaches](./computer-science/system-design.md#61-scaling-approaches), [6.2 Load Balancing](./computer-science/system-design.md#62-load-balancing), [6.3 Traffic Control](./computer-science/system-design.md#63-traffic-control): scaling, load balancing, traffic control
  - [13.1 Performance Analysis](./computer-science/system-design.md#131-performance-analysis), [13.3 Benchmarking and Testing](./computer-science/system-design.md#133-benchmarking-and-testing): performance analysis and load testing
- **[Operative Systems](./computer-science/operative-systems.md)**: [4. CPU Scheduling](./computer-science/operative-systems.md#4-cpu-scheduling), [8.4 Performance Concerns](./computer-science/operative-systems.md#84-performance-concerns), [15.2 Performance Analysis](./computer-science/operative-systems.md#152-performance-analysis): scheduling, thrashing, performance analysis
- **[Networking](./computer-science/networking.md)**: [7.5 Congestion Control](./computer-science/networking.md#75-congestion-control), [14. Network Operations, Analysis, and Troubleshooting](./computer-science/networking.md#14-network-operations-analysis-and-troubleshooting): congestion control and systematic troubleshooting
- **[Kubernetes](./computer-science/kubernetes.md)**: [8.5 Autoscaling](./computer-science/kubernetes.md#85-autoscaling), [10. Observability](./computer-science/kubernetes.md#10-observability), [16.4 Troubleshooting](./computer-science/kubernetes.md#164-troubleshooting): autoscaling, observability, troubleshooting
- **[Database Systems in Postgres](./computer-science/dbms.md)**: [7.5 Monitoring and Diagnostics](./computer-science/dbms.md#75-monitoring-and-diagnostics), [11.3 Backup and Recovery](./computer-science/dbms.md#113-backup-and-recovery), [12.3 High Availability Architecture](./computer-science/dbms.md#123-high-availability-architecture): database monitoring, backup and HA

### Recommended

- **[System Design](./computer-science/system-design.md)**: [8.1 Fundamental Constraints](./computer-science/system-design.md#81-fundamental-constraints), [8.4 Consensus and Coordination](./computer-science/system-design.md#84-consensus-and-coordination): CAP/PACELC, consensus
- **[Cyber Security](./computer-science/cyber-security.md)**: [13.3 Incident Response](./computer-science/cyber-security.md#133-incident-response), [13.5 Resilience and Continuity](./computer-science/cyber-security.md#135-resilience-and-continuity): incident response, resilience and continuity
- **[Kubernetes](./computer-science/kubernetes.md)**: [16.2 Backup and Disaster Recovery](./computer-science/kubernetes.md#162-backup-and-disaster-recovery): backup and disaster recovery
- **[Azure Developer](./computer-science/azure.md)**: [11. Monitoring, Troubleshooting, and Optimization](./computer-science/azure.md#11-monitoring-troubleshooting-and-optimization): Azure Monitor and Application Insights
- **[Docker](./computer-science/docker.md)**: [12. Logging, Monitoring, and Debugging](./computer-science/docker.md#12-logging-monitoring-and-debugging)
- **Math for SLOs and capacity:** [2.4 Position and Shape](./math/probability-and-statistics.md#24-position-and-shape) (percentiles), [5.1 Discrete Distributions](./math/probability-and-statistics.md#51-discrete-distributions), [9.3 Queueing Theory](./math/operative-research.md#93-queueing-theory) (queueing theory)

### Deep Dive

- [12. Simulation](./math/operative-research.md#12-simulation): simulating capacity scenarios
- [12. Quality of Service and Traffic Engineering](./computer-science/networking.md#12-quality-of-service-and-traffic-engineering): QoS and traffic engineering
- [13.4 Cost Optimization](./computer-science/system-design.md#134-cost-optimization): cost engineering

### Checkpoint

- Turn "the site should be fast" into an SLI, an SLO and an error budget policy.
- Why does latency explode as utilization approaches 100%? (Hint: [9.3 Queueing Theory](./math/operative-research.md#93-queueing-theory))
- Write the first 15 minutes of an incident runbook for "p99 latency doubled".

---

## 8. Cloud Engineer (Azure)

> Designs, builds and runs applications on Azure: identity, compute, storage, messaging and cost control.

### Core

- **[Azure Developer](./computer-science/azure.md)**
  - [1. Azure Fundamentals for Developers](./computer-science/azure.md#1-azure-fundamentals-for-developers): cloud concepts, regions, resource organization, SDKs
  - [2.1 Microsoft Entra ID Fundamentals](./computer-science/azure.md#21-microsoft-entra-id-fundamentals), [2.4 Managed Identities and Azure Identity Library](./computer-science/azure.md#24-managed-identities-and-azure-identity-library), [2.5 Authorization with Azure RBAC](./computer-science/azure.md#25-authorization-with-azure-rbac): Entra ID, managed identities, RBAC
  - [3. Azure Compute for Applications](./computer-science/azure.md#3-azure-compute-for-applications): VMs, App Service, Functions
  - [4. Containers on Azure](./computer-science/azure.md#4-containers-on-azure): ACR, Container Instances, Container Apps, AKS
  - [5. Azure Storage Solutions](./computer-science/azure.md#5-azure-storage-solutions), [6. Databases and Data Services](./computer-science/azure.md#6-databases-and-data-services): Blob Storage, Cosmos DB, SQL, Redis
  - [7. Application Security](./computer-science/azure.md#7-application-security): Key Vault, App Configuration, network security
  - [11. Monitoring, Troubleshooting, and Optimization](./computer-science/azure.md#11-monitoring-troubleshooting-and-optimization): monitoring and troubleshooting
  - [12. Infrastructure as Code and DevOps](./computer-science/azure.md#12-infrastructure-as-code-and-devops): Bicep, ARM, Terraform, pipelines
  - [14.4 Azure Well-Architected Framework](./computer-science/azure.md#144-azure-well-architected-framework): Well-Architected Framework

### Recommended

- **[Azure Developer](./computer-science/azure.md)**: [8. API Management and Integration](./computer-science/azure.md#8-api-management-and-integration), [9. Event-Based Solutions](./computer-science/azure.md#9-event-based-solutions), [10. Message-Based Solutions](./computer-science/azure.md#10-message-based-solutions), [14.1 Resiliency Patterns](./computer-science/azure.md#141-resiliency-patterns), [14.2 Data and Messaging Patterns](./computer-science/azure.md#142-data-and-messaging-patterns), [14.3 Application Design Patterns](./computer-science/azure.md#143-application-design-patterns), [14.5 Cost Management for Developers](./computer-science/azure.md#145-cost-management-for-developers)
- **[System Design](./computer-science/system-design.md)**: [10.4 Cloud-Native and Serverless](./computer-science/system-design.md#104-cloud-native-and-serverless), [13.4 Cost Optimization](./computer-science/system-design.md#134-cost-optimization): cloud-native, serverless, cost optimization
- **[Cyber Security](./computer-science/cyber-security.md)**: [11. Cloud and Infrastructure Security](./computer-science/cyber-security.md#11-cloud-and-infrastructure-security): cloud security, zero trust
- **[Networking](./computer-science/networking.md)**: [13.2 Virtualization and Overlays](./computer-science/networking.md#132-virtualization-and-overlays), [13.4 Cloud and Wide-Area Evolution](./computer-science/networking.md#134-cloud-and-wide-area-evolution): overlays, VNets, cloud networking
- **[Kubernetes](./computer-science/kubernetes.md)**: [3.2 Production Cluster Provisioning](./computer-science/kubernetes.md#32-production-cluster-provisioning), [6. Networking](./computer-science/kubernetes.md#6-networking)

### Deep Dive

- [13. AI and Intelligent Applications](./computer-science/azure.md#13-ai-and-intelligent-applications): Azure OpenAI and AI services
- [2.2 Authentication Protocols](./computer-science/azure.md#22-authentication-protocols), [2.3 Microsoft Authentication Library (MSAL)](./computer-science/azure.md#23-microsoft-authentication-library-msal): OAuth 2.0 / OIDC flows with MSAL
- [15. Multi-Cluster and Federation](./computer-science/kubernetes.md#15-multi-cluster-and-federation): multi-cluster patterns

### Checkpoint

- When would you pick Functions, Container Apps, App Service or AKS for the same workload?
- How does an app read a Key Vault secret without any credential in its code or config?
- Service Bus, Event Grid or Event Hubs: which one, and why? (See [10.3 Choosing a Messaging Service](./computer-science/azure.md#103-choosing-a-messaging-service))

---

## 9. Data Engineer

> Moves, stores and models data so analysts and ML systems can trust it. The core skills are SQL, pipelines, distributed processing and data quality.

### Core

- **[Database Systems in Postgres](./computer-science/dbms.md)**
  - [2. Relational Design and Data Modeling](./computer-science/dbms.md#2-relational-design-and-data-modeling), [4. SQL Querying Fundamentals](./computer-science/dbms.md#4-sql-querying-fundamentals), [5. Advanced SQL in Postgres](./computer-science/dbms.md#5-advanced-sql-in-postgres): modeling, SQL and analytical SQL
  - [6. Storage Internals and Indexing](./computer-science/dbms.md#6-storage-internals-and-indexing), [7. Query Processing and Performance](./computer-science/dbms.md#7-query-processing-and-performance): storage layout, indexes, partitioning, query plans
  - [8.1 Transaction Basics](./computer-science/dbms.md#81-transaction-basics), [8.2 Isolation Levels](./computer-science/dbms.md#82-isolation-levels), [8.3 Multiversion Concurrency Control](./computer-science/dbms.md#83-multiversion-concurrency-control): transactions and MVCC
- **[Data Science](./computer-science/data-science.md)**
  - [4.1 Python for Data Science](./computer-science/data-science.md#41-python-for-data-science), [4.3 SQL and Query Languages](./computer-science/data-science.md#43-sql-and-query-languages): Python and SQL for data work
  - [5. Data Acquisition and Storage](./computer-science/data-science.md#5-data-acquisition-and-storage): sources, storage systems, pipelines
  - [6.1 Data Cleaning](./computer-science/data-science.md#61-data-cleaning), [6.2 Data Transformation](./computer-science/data-science.md#62-data-transformation): cleaning and transformation
  - [14. Big Data and Distributed Computing](./computer-science/data-science.md#14-big-data-and-distributed-computing): Spark-style processing, streaming, performance
- **[System Design](./computer-science/system-design.md)**
  - [4.6 Data Lifecycle Management](./computer-science/system-design.md#46-data-lifecycle-management), [7.2 Event Streaming](./computer-science/system-design.md#72-event-streaming), [7.3 Delivery Semantics](./computer-science/system-design.md#73-delivery-semantics): data lifecycle, event streaming, delivery semantics
  - [14.1 Data Platform Architecture](./computer-science/system-design.md#141-data-platform-architecture), [14.2 Batch and Stream Processing](./computer-science/system-design.md#142-batch-and-stream-processing): lake and warehouse architecture, batch and stream processing

### Recommended

- **[Database Systems in Postgres](./computer-science/dbms.md)**: [3.4 Semi-Structured Data](./computer-science/dbms.md#34-semi-structured-data), [12.2 Logical Replication](./computer-science/dbms.md#122-logical-replication): JSONB and logical replication / CDC
- **[System Design](./computer-science/system-design.md)**: [4.5 Partitioning and Sharding](./computer-science/system-design.md#45-partitioning-and-sharding): partitioning and sharding
- **[Azure Developer](./computer-science/azure.md)**: [5. Azure Storage Solutions](./computer-science/azure.md#5-azure-storage-solutions), [6.1 Azure Cosmos DB Fundamentals](./computer-science/azure.md#61-azure-cosmos-db-fundamentals), [9.3 Azure Event Hubs](./computer-science/azure.md#93-azure-event-hubs): Blob/ADLS, Cosmos DB, Event Hubs
- **[Data Science](./computer-science/data-science.md)**: [15.2 ML Engineering Infrastructure](./computer-science/data-science.md#152-ml-engineering-infrastructure), [16.4 Governance and Regulation](./computer-science/data-science.md#164-governance-and-regulation): ML infrastructure, data governance
- **[Probability and Statistics](./math/probability-and-statistics.md)**: [7.4 Bias and Data Quality](./math/probability-and-statistics.md#74-bias-and-data-quality): bias and data quality

### Deep Dive

- [9. Storage Systems](./computer-science/operative-systems.md#9-storage-systems), [10. File Systems](./computer-science/operative-systems.md#10-file-systems): storage and filesystems, for performance tuning
- [7.4 Dashboards and Reporting](./computer-science/data-science.md#74-dashboards-and-reporting): dashboards and reporting
- [13.3 Monorepo Strategies](./computer-science/gitlab.md#133-monorepo-strategies): monorepo strategies for data platforms

### Checkpoint

- Design an idempotent daily pipeline that can be re-run for any past date.
- Explain exactly-once in a streaming system and what it actually guarantees.
- When does partitioning a table hurt query performance instead of helping?

---

## 10. Data Scientist

> Turns data into decisions. Statistical rigor comes first; modeling builds on it.

### Core: Mathematics

- **[Probability and Statistics](./math/probability-and-statistics.md)**
  - [2. Descriptive Statistics](./math/probability-and-statistics.md#2-descriptive-statistics), [3. Probability Theory](./math/probability-and-statistics.md#3-probability-theory), [4. Random Variables and Distributions](./math/probability-and-statistics.md#4-random-variables-and-distributions), [5. Common Probability Distributions](./math/probability-and-statistics.md#5-common-probability-distributions): descriptive statistics, probability, distributions
  - [6. Multivariate Probability](./math/probability-and-statistics.md#6-multivariate-probability): joint distributions, covariance, CLT
  - [8. Statistical Estimation](./math/probability-and-statistics.md#8-statistical-estimation), [9. Hypothesis Testing](./math/probability-and-statistics.md#9-hypothesis-testing): estimation, confidence intervals, hypothesis testing
  - [10. Regression and Predictive Modeling](./math/probability-and-statistics.md#10-regression-and-predictive-modeling): linear regression and GLMs
- **[Linear Algebra](./math/linear-algebra.md)**: [3. Systems of Linear Equations](./math/linear-algebra.md#3-systems-of-linear-equations), [4. Matrix Algebra](./math/linear-algebra.md#4-matrix-algebra), [8. Eigenvalues and Eigenvectors](./math/linear-algebra.md#8-eigenvalues-and-eigenvectors), [9.5 Least Squares Approximation](./math/linear-algebra.md#95-least-squares-approximation), [11.1 Singular Value Decomposition](./math/linear-algebra.md#111-singular-value-decomposition): systems, matrices, eigenvalues, least squares, SVD
- **[Calculus](./math/calculus.md)**: [3. The Derivative](./math/calculus.md#3-the-derivative), [12.3 Partial Derivatives](./math/calculus.md#123-partial-derivatives), [12.5 Directional Derivatives and Gradients](./math/calculus.md#125-directional-derivatives-and-gradients), [12.6 Multivariable Optimization](./math/calculus.md#126-multivariable-optimization): derivatives, gradients, optimization

### Core: Data Science

- **[Data Science](./computer-science/data-science.md)**
  - [1. Foundations of Data Science](./computer-science/data-science.md#1-foundations-of-data-science), [3. Statistical Foundations](./computer-science/data-science.md#3-statistical-foundations): lifecycle, framing questions, statistical foundations
  - [4.1 Python for Data Science](./computer-science/data-science.md#41-python-for-data-science), [4.3 SQL and Query Languages](./computer-science/data-science.md#43-sql-and-query-languages): Python and SQL
  - [6. Data Wrangling and Preparation](./computer-science/data-science.md#6-data-wrangling-and-preparation), [7. Exploratory Data Analysis and Visualization](./computer-science/data-science.md#7-exploratory-data-analysis-and-visualization): wrangling, feature engineering, EDA, visualization
  - [8. Experimentation and Decision Science](./computer-science/data-science.md#8-experimentation-and-decision-science): experimental design and A/B testing
  - [9. Machine Learning Fundamentals](./computer-science/data-science.md#9-machine-learning-fundamentals), [10. Supervised Learning](./computer-science/data-science.md#10-supervised-learning), [11. Unsupervised Learning](./computer-science/data-science.md#11-unsupervised-learning): ML fundamentals, supervised and unsupervised learning
  - [17. Communication and Professional Practice](./computer-science/data-science.md#17-communication-and-professional-practice): communicating results to stakeholders

### Recommended

- **[Data Science](./computer-science/data-science.md)**: [3.5 Causal Inference](./computer-science/data-science.md#35-causal-inference), [8.3 Quasi-Experiments and Observational Studies](./computer-science/data-science.md#83-quasi-experiments-and-observational-studies), [13.1 Time Series Analysis](./computer-science/data-science.md#131-time-series-analysis), [13.5 Recommender Systems](./computer-science/data-science.md#135-recommender-systems), [16.1 Model Interpretability](./computer-science/data-science.md#161-model-interpretability), [16.2 Fairness and Bias](./computer-science/data-science.md#162-fairness-and-bias)
- **[Probability and Statistics](./math/probability-and-statistics.md)**: [11. Bayesian Statistics](./math/probability-and-statistics.md#11-bayesian-statistics), [12.1 Time Series Analysis](./math/probability-and-statistics.md#121-time-series-analysis), [12.4 Causal Inference](./math/probability-and-statistics.md#124-causal-inference): Bayesian methods, time series, causal inference
- **[Database Systems in Postgres](./computer-science/dbms.md)**: [5.2 Window Functions](./computer-science/dbms.md#52-window-functions), [5.4 Analytical Query Patterns](./computer-science/dbms.md#54-analytical-query-patterns): window functions and analytical SQL

### Deep Dive

- [12. Deep Learning](./computer-science/data-science.md#12-deep-learning): deep learning
- [2. Linear Programming](./math/operative-research.md#2-linear-programming), [5.3 Convex Optimization](./math/operative-research.md#53-convex-optimization): linear programming and convex optimization
- [3.5 Measure-Theoretic Foundations](./math/probability-and-statistics.md#35-measure-theoretic-foundations): measure-theoretic probability

### Checkpoint

- An A/B test shows p = 0.04 after you checked results daily. Is the result valid?
- Explain the bias-variance trade-off and how regularization moves along it.
- When can't correlation in observational data be read as causation, and what can you do about it?

---

## 11. Machine Learning and AI Engineer

> Builds, trains, serves and monitors models in production. Part data scientist, part backend engineer.

### Core

- **Math for ML**
  - [2.3 Dot Product and Geometry](./math/linear-algebra.md#23-dot-product-and-geometry), [4. Matrix Algebra](./math/linear-algebra.md#4-matrix-algebra), [8. Eigenvalues and Eigenvectors](./math/linear-algebra.md#8-eigenvalues-and-eigenvectors), [11. Singular Value Decomposition and Matrix Analysis](./math/linear-algebra.md#11-singular-value-decomposition-and-matrix-analysis): dot products, matrix algebra, eigen-decomposition, SVD
  - [3.3 Differentiation Rules](./math/calculus.md#33-differentiation-rules), [12.4 Chain Rules and Implicit Functions](./math/calculus.md#124-chain-rules-and-implicit-functions), [12.5 Directional Derivatives and Gradients](./math/calculus.md#125-directional-derivatives-and-gradients): chain rule (backpropagation) and gradients
  - [3.4 Bayes' Theorem](./math/probability-and-statistics.md#34-bayes-theorem), [5.3 The Normal Distribution](./math/probability-and-statistics.md#53-the-normal-distribution), [8.2 Estimation Methods](./math/probability-and-statistics.md#82-estimation-methods): Bayes, the normal distribution, maximum likelihood
- **[Data Science](./computer-science/data-science.md)**
  - [9. Machine Learning Fundamentals](./computer-science/data-science.md#9-machine-learning-fundamentals), [10. Supervised Learning](./computer-science/data-science.md#10-supervised-learning): generalization, evaluation, tuning, supervised models
  - [12. Deep Learning](./computer-science/data-science.md#12-deep-learning): neural networks, architectures, training at scale, foundation models
  - [15. Productionizing Models and MLOps](./computer-science/data-science.md#15-productionizing-models-and-mlops): deployment, ML infrastructure, monitoring, drift
- **[System Design](./computer-science/system-design.md)**: [14.3 Search and Recommendation Systems](./computer-science/system-design.md#143-search-and-recommendation-systems), [14.4 ML and AI Serving Systems](./computer-science/system-design.md#144-ml-and-ai-serving-systems): search, recommendation and model-serving systems

### Recommended

- **[Data Science](./computer-science/data-science.md)**: [13.2 Natural Language Processing](./computer-science/data-science.md#132-natural-language-processing), [13.3 Computer Vision](./computer-science/data-science.md#133-computer-vision), [16.1 Model Interpretability](./computer-science/data-science.md#161-model-interpretability), [16.3 Privacy and Security](./computer-science/data-science.md#163-privacy-and-security): NLP, CV, interpretability, privacy
- **[Azure Developer](./computer-science/azure.md)**: [13. AI and Intelligent Applications](./computer-science/azure.md#13-ai-and-intelligent-applications): Azure OpenAI, RAG, building AI-powered apps
- **[Kubernetes](./computer-science/kubernetes.md)**: [17.2 GPU and Specialized Hardware](./computer-science/kubernetes.md#172-gpu-and-specialized-hardware), [17.4 AI/ML Workloads on Kubernetes](./computer-science/kubernetes.md#174-aiml-workloads-on-kubernetes): GPUs and ML workloads on Kubernetes
- **[Cyber Security](./computer-science/cyber-security.md)**: [14.2 AI and Machine Learning Security](./computer-science/cyber-security.md#142-ai-and-machine-learning-security): adversarial ML, prompt injection
- **[Docker](./computer-science/docker.md)**: [5.4 Multi-Stage Builds](./computer-science/docker.md#54-multi-stage-builds), [11. Resource Management and Performance](./computer-science/docker.md#11-resource-management-and-performance): lean images and resource limits for model servers
- **[System Design](./computer-science/system-design.md)**: [5. Caching and Content Delivery](./computer-science/system-design.md#5-caching-and-content-delivery): caching inference results and embeddings

### Deep Dive

- [5. Nonlinear Optimization](./math/operative-research.md#5-nonlinear-optimization): nonlinear and convex optimization theory
- [14. Big Data and Distributed Computing](./computer-science/data-science.md#14-big-data-and-distributed-computing): distributed training data pipelines
- [15. Performance and Low-Level Control](./computer-science/rust.md#15-performance-and-low-level-control): high-performance inference code

### Checkpoint

- Derive the gradient for logistic regression using the chain rule.
- Your model is accurate offline and poor in production. List five causes.
- Design a low-latency serving path for an LLM feature, including caching and fallbacks.

---

## 12. Security Engineer

> Protects systems by understanding how they break. Pick a specialization once the Core is solid.

### Core (All Security Roles)

- **[Cyber Security](./computer-science/cyber-security.md)**
  - [1. Foundations of Cyber Security](./computer-science/cyber-security.md#1-foundations-of-cyber-security), [2. Policy statements](./computer-science/cyber-security.md#2-policy-statements): principles, threat landscape, shell, Python tooling
  - [3. Exceptions](./computer-science/cyber-security.md#3-exceptions): symmetric and asymmetric cryptography, hashing, PKI
  - [6. System and Network Security](./computer-science/cyber-security.md#6-system-and-network-security): authentication, access control, firewalls, network attacks
  - [8. Web Security (Server Side)](./computer-science/cyber-security.md#8-web-security-server-side), [9. Web Security (Client Side)](./computer-science/cyber-security.md#9-web-security-client-side): server-side and client-side web security
  - [10. Secure Development Lifecycle](./computer-science/cyber-security.md#10-secure-development-lifecycle): threat modeling and secure SDLC
- **[Networking](./computer-science/networking.md)**: [11. Network Security](./computer-science/networking.md#11-network-security): network security
- **[Operative Systems](./computer-science/operative-systems.md)**: [12. Protection and Security](./computer-science/operative-systems.md#12-protection-and-security): OS protection mechanisms
- **[Discrete Mathematics](./math/discrete-mathematics.md)**: [4.3 Modular Arithmetic](./math/discrete-mathematics.md#43-modular-arithmetic), [4.4 Applications of Number Theory](./math/discrete-mathematics.md#44-applications-of-number-theory): modular arithmetic behind RSA and Diffie-Hellman

### Specialization: Application Security

- [8.3 SQL Injection and Defences](./computer-science/cyber-security.md#83-sql-injection-and-defences), [8.4 Blind SQL Injection](./computer-science/cyber-security.md#84-blind-sql-injection), [8.6 API and Mobile Back-End Security](./computer-science/cyber-security.md#86-api-and-mobile-back-end-security), [9.2 Cross-Site Scripting (XSS)](./computer-science/cyber-security.md#92-cross-site-scripting-xss), [9.3 Cross-Site Request Forgery (CSRF)](./computer-science/cyber-security.md#93-cross-site-request-forgery-csrf)
- [10.2 Cookies and Sessions](./computer-science/web-technologies.md#102-cookies-and-sessions), [10.3 Authentication and Authorization](./computer-science/web-technologies.md#103-authentication-and-authorization), [17.1 Web Application Security](./computer-science/web-technologies.md#171-web-application-security)
- [11. Security and Compliance (DevSecOps)](./computer-science/gitlab.md#11-security-and-compliance-devsecops): SAST, DAST and dependency scanning in pipelines
- [18.4 Security Essentials](./computer-science/java.md#184-security-essentials): Spring Security

### Specialization: Offensive Security / Exploitation

- [4. Compliance](./computer-science/cyber-security.md#4-compliance), [5. Related documents](./computer-science/cyber-security.md#5-related-documents), [12. Offensive Security](./computer-science/cyber-security.md#12-offensive-security): x86-64, program analysis, memory corruption, pentesting
- [5.2 Pointer Fundamentals](./computer-science/c.md#52-pointer-fundamentals), [7.3 Memory Errors](./computer-science/c.md#73-memory-errors), [12.2 Undefined and Unspecified Behavior](./computer-science/c.md#122-undefined-and-unspecified-behavior), [13.3 Secure and Maintainable C](./computer-science/c.md#133-secure-and-maintainable-c): pointers, memory errors, undefined behavior, secure C

### Specialization: Defensive / Cloud Security

- [7. System and Endpoint Hardening](./computer-science/cyber-security.md#7-system-and-endpoint-hardening), [11. Cloud and Infrastructure Security](./computer-science/cyber-security.md#11-cloud-and-infrastructure-security), [13. Defensive Operations and Incident Response](./computer-science/cyber-security.md#13-defensive-operations-and-incident-response): hardening, cloud security, SOC, incident response, forensics
- [9. Security](./computer-science/kubernetes.md#9-security), [10. Docker Security](./computer-science/docker.md#10-docker-security): cluster and container security
- [2. Identity and Access for Applications](./computer-science/azure.md#2-identity-and-access-for-applications), [7. Application Security](./computer-science/azure.md#7-application-security): identity and secrets in Azure

### Deep Dive

- [14. Emerging and Specialized Topics](./computer-science/cyber-security.md#14-emerging-and-specialized-topics): privacy engineering, AI security, frontier topics
- [3. Ownership and Memory Model](./computer-science/rust.md#3-ownership-and-memory-model), [14. Unsafe Rust and Systems Interop](./computer-science/rust.md#14-unsafe-rust-and-systems-interop): how memory safety is enforced, and where `unsafe` breaks it

### Checkpoint

- Walk through a TLS 1.3 handshake and say what each step protects against.
- Why do parameterized queries prevent SQL injection while escaping often fails?
- Explain how stack canaries, NX and ASLR each make a stack overflow harder to exploit.

---

## 13. Systems and Embedded Engineer

> Writes code close to the hardware: kernels, drivers, runtimes, firmware, high-performance infrastructure.

### Core

- **[C Programming Language](./computer-science/c.md)**
  - [1. Foundations and Toolchain](./computer-science/c.md#1-foundations-and-toolchain) to [7. Memory Management](./computer-science/c.md#7-memory-management): the language, pointers and manual memory management
  - [8. The Preprocessor](./computer-science/c.md#8-the-preprocessor): the preprocessor
  - [11. Systems Programming](./computer-science/c.md#11-systems-programming): processes, file I/O, sockets, threads
  - [12. Low-Level and Advanced Topics](./computer-science/c.md#12-low-level-and-advanced-topics): bit manipulation, undefined behavior, freestanding C
- **[Operative Systems](./computer-science/operative-systems.md)**
  - [1. Introduction to Operating Systems](./computer-science/operative-systems.md#1-introduction-to-operating-systems) to [8. Virtual Memory](./computer-science/operative-systems.md#8-virtual-memory): processes, threads, scheduling, synchronization, memory, virtual memory
  - [11. Input/Output Systems](./computer-science/operative-systems.md#11-inputoutput-systems): I/O hardware and kernel I/O subsystem
- **[Rust Programming Language](./computer-science/rust.md)**: [3. Ownership and Memory Model](./computer-science/rust.md#3-ownership-and-memory-model), [9. Smart Pointers and Interior Mutability](./computer-science/rust.md#9-smart-pointers-and-interior-mutability), [10. Concurrency and Parallelism](./computer-science/rust.md#10-concurrency-and-parallelism), [14. Unsafe Rust and Systems Interop](./computer-science/rust.md#14-unsafe-rust-and-systems-interop), [15.3 Embedded and no_std](./computer-science/rust.md#153-embedded-and-no_std): ownership, smart pointers, concurrency, unsafe/FFI, `no_std`
- **[Discrete Mathematics](./math/discrete-mathematics.md)**: [11. Boolean Algebra](./math/discrete-mathematics.md#11-boolean-algebra): Boolean algebra and logic circuits

### Recommended

- **[C Programming Language](./computer-science/c.md)**: [10. Data Structures and Algorithms in C](./computer-science/c.md#10-data-structures-and-algorithms-in-c), [13. Quality, Debugging, and Security](./computer-science/c.md#13-quality-debugging-and-security): data structures in C, debugging, sanitizers
- **[Operative Systems](./computer-science/operative-systems.md)**: [9. Storage Systems](./computer-science/operative-systems.md#9-storage-systems), [10. File Systems](./computer-science/operative-systems.md#10-file-systems), [13.1 Virtualization Concepts](./computer-science/operative-systems.md#131-virtualization-concepts), [13.2 Virtualization Implementation](./computer-science/operative-systems.md#132-virtualization-implementation), [14.2 Real-Time and Embedded Systems](./computer-science/operative-systems.md#142-real-time-and-embedded-systems): storage, filesystems, hypervisors, real-time systems
- **[Rust Programming Language](./computer-science/rust.md)**: [15.1 Optimization Techniques](./computer-science/rust.md#151-optimization-techniques), [15.2 Data-Oriented Design](./computer-science/rust.md#152-data-oriented-design): optimization and data-oriented design
- **[Cyber Security](./computer-science/cyber-security.md)**: [4.1 Assembly x86-64](./computer-science/cyber-security.md#41-assembly-x86-64), [5.4 Exploit Mitigations](./computer-science/cyber-security.md#54-exploit-mitigations): assembly and exploit mitigations
- **[Networking](./computer-science/networking.md)**: [9.1 The Socket API](./computer-science/networking.md#91-the-socket-api): the socket API

### Deep Dive

- [1.2 Linux Foundations of Containers](./computer-science/docker.md#12-linux-foundations-of-containers): namespaces and cgroups
- [15.1 System Case Studies](./computer-science/operative-systems.md#151-system-case-studies): Linux and Windows case studies
- [16.5 WebAssembly](./computer-science/rust.md#165-webassembly): WebAssembly
- [13. Formal Languages and Automata](./math/discrete-mathematics.md#13-formal-languages-and-automata): finite-state machines, a natural fit for protocol and firmware logic
- [10.4 Short-Range and IoT Networking](./computer-science/networking.md#104-short-range-and-iot-networking): IoT and short-range networking

### Checkpoint

- What happens on a page fault, from the MMU to the instruction being retried?
- Give three examples of undefined behavior in C that compilers actively exploit.
- How does Rust's `Send`/`Sync` prevent data races at compile time?

---

## 14. Network Engineer

> Builds and operates networks and network software: routing, load balancers, SDN, observability of traffic.

### Core

- **[Networking](./computer-science/networking.md)**
  - [1. Foundations of Computer Networking](./computer-science/networking.md#1-foundations-of-computer-networking), [2. Network Architecture and Layered Models](./computer-science/networking.md#2-network-architecture-and-layered-models): fundamentals and layered models
  - [4. The Data Link Layer](./computer-science/networking.md#4-the-data-link-layer): Ethernet, switching, ARP
  - [5. The Network Layer and IP Addressing](./computer-science/networking.md#5-the-network-layer-and-ip-addressing): IPv4/IPv6, subnetting, ICMP, NAT
  - [6. Routing](./computer-science/networking.md#6-routing): routing algorithms, OSPF, BGP
  - [7. The Transport Layer](./computer-science/networking.md#7-the-transport-layer): TCP, UDP, flow and congestion control, QUIC
  - [8. The Application Layer](./computer-science/networking.md#8-the-application-layer): DNS, HTTP, CDN
  - [14. Network Operations, Analysis, and Troubleshooting](./computer-science/networking.md#14-network-operations-analysis-and-troubleshooting): tools, packet analysis, troubleshooting

### Recommended

- **[Networking](./computer-science/networking.md)**: [9. Network Programming](./computer-science/networking.md#9-network-programming), [11. Network Security](./computer-science/networking.md#11-network-security), [12. Quality of Service and Traffic Engineering](./computer-science/networking.md#12-quality-of-service-and-traffic-engineering), [13. Modern Network Infrastructure](./computer-science/networking.md#13-modern-network-infrastructure): programming, security, QoS, SDN and data centers
- **[Cyber Security](./computer-science/cyber-security.md)**: [6.4 Firewalls and Perimeter Defense](./computer-science/cyber-security.md#64-firewalls-and-perimeter-defense), [6.5 Network Attacks](./computer-science/cyber-security.md#65-network-attacks), [6.6 Secure Communication Protocols](./computer-science/cyber-security.md#66-secure-communication-protocols): firewalls, network attacks, secure protocols
- **[Kubernetes](./computer-science/kubernetes.md)**: [6. Networking](./computer-science/kubernetes.md#6-networking): CNI, Services, Ingress, NetworkPolicy
- **[Docker](./computer-science/docker.md)**: [7. Docker Networking](./computer-science/docker.md#7-docker-networking): container network drivers
- **Algorithms behind routing:** [8.4 Traversals and Paths](./math/discrete-mathematics.md#84-traversals-and-paths), [3.2 Shortest Path Problems](./math/operative-research.md#32-shortest-path-problems), [3.4 Maximum Flow Problems](./math/operative-research.md#34-maximum-flow-problems)

### Deep Dive

- [3. The Physical Layer](./computer-science/networking.md#3-the-physical-layer): the physical layer
- [10. Wireless and Mobile Networking](./computer-science/networking.md#10-wireless-and-mobile-networking): Wi-Fi, cellular, mobility
- [15. Advanced and Emerging Topics](./computer-science/networking.md#15-advanced-and-emerging-topics): distributed systems networking, measurement
- [13. Service Mesh](./computer-science/kubernetes.md#13-service-mesh): service mesh
- [9.3 Queueing Theory](./math/operative-research.md#93-queueing-theory): queueing models of links and buffers

### Checkpoint

- Subnet `10.20.0.0/16` into 6 networks of at least 2000 hosts each.
- Why can BGP converge slowly, and what does that mean for an outage?
- Use a packet capture to tell packet loss apart from a slow application.

---

## 15. Database Engineer

> Owns the data tier: schema design, query performance, replication, backups and upgrades.

### Core

- **[Database Systems in Postgres](./computer-science/dbms.md)**
  - [2. Relational Design and Data Modeling](./computer-science/dbms.md#2-relational-design-and-data-modeling), [3. Data Types and Domain Modeling](./computer-science/dbms.md#3-data-types-and-domain-modeling): modeling, keys, normalization, data types
  - [4. SQL Querying Fundamentals](./computer-science/dbms.md#4-sql-querying-fundamentals), [5. Advanced SQL in Postgres](./computer-science/dbms.md#5-advanced-sql-in-postgres): SQL fundamentals and advanced SQL
  - [6. Storage Internals and Indexing](./computer-science/dbms.md#6-storage-internals-and-indexing), [7. Query Processing and Performance](./computer-science/dbms.md#7-query-processing-and-performance): storage internals, indexing, the planner, tuning
  - [8. Transactions and Concurrency](./computer-science/dbms.md#8-transactions-and-concurrency): isolation, MVCC, locking, vacuum
  - [11. Administration and Operations](./computer-science/dbms.md#11-administration-and-operations): configuration, WAL, backup and recovery
  - [12. Replication and High Availability](./computer-science/dbms.md#12-replication-and-high-availability): physical and logical replication, HA, scaling out

### Recommended

- **[Database Systems in Postgres](./computer-science/dbms.md)**: [9. Server-Side Programming](./computer-science/dbms.md#9-server-side-programming), [10. Security and Access Control](./computer-science/dbms.md#10-security-and-access-control), [13. Extensions and the Postgres Ecosystem](./computer-science/dbms.md#13-extensions-and-the-postgres-ecosystem): PL/pgSQL, row-level security, extensions
- **[System Design](./computer-science/system-design.md)**: [4. Content negotiation — the most "correct" by HTTP semantics, least used](./computer-science/system-design.md#4-content-negotiation--the-most-correct-by-http-semantics-least-used), [8.2 Consistency Models](./computer-science/system-design.md#82-consistency-models), [8.4 Consensus and Coordination](./computer-science/system-design.md#84-consensus-and-coordination), [8.5 Distributed Transactions](./computer-science/system-design.md#85-distributed-transactions): storage engines, consistency, consensus, distributed transactions
- **[Operative Systems](./computer-science/operative-systems.md)**: [9.3 Reliability and Performance](./computer-science/operative-systems.md#93-reliability-and-performance), [10.4 Consistency and Recovery](./computer-science/operative-systems.md#104-consistency-and-recovery): disk reliability, journaling and crash recovery
- **[Algorithms and Data Structures](./computer-science/algorithms-and-data-structures.md)**: [7. Trees](./computer-science/algorithms-and-data-structures.md#7-trees): tree structures behind indexes

### Deep Dive

- [6. Databases and Data Services](./computer-science/azure.md#6-databases-and-data-services): Cosmos DB partitioning and consistency levels
- [13. Storage and Data Persistence](./computer-science/web-technologies.md#13-storage-and-data-persistence): MongoDB and Redis
- [4.3 StatefulSets](./computer-science/kubernetes.md#43-statefulsets): running databases on StatefulSets

### Checkpoint

- Explain how MVCC lets readers and writers avoid blocking each other, and what vacuum cleans up.
- Design a backup strategy with a 5-minute RPO and a 30-minute RTO.
- A query got 10x slower after a data load. What do you check first?

---

## 16. FinTech Engineer (Banking and Treasury)

> Builds software for banks: payments, treasury, risk and regulatory reporting. Correctness, auditability and precision matter more than anything else.

### Core

- **[Banking for Software Engineers (Treasury Focus)](./finance/banking.md)**
  - [1. Banking Fundamentals](./finance/banking.md#1-banking-fundamentals): how banks make money, balance sheets, central banks
  - [2. Payments, Clearing and Settlement](./finance/banking.md#2-payments-clearing-and-settlement): payment rails, clearing and settlement
  - [3.2 Time Value of Money](./finance/banking.md#32-time-value-of-money), [3.4 Fixed Income Securities](./finance/banking.md#34-fixed-income-securities), [3.5 Foreign Exchange](./finance/banking.md#35-foreign-exchange): time value of money, bonds, FX
  - [4.3 Trade Lifecycle](./finance/banking.md#43-trade-lifecycle): trade lifecycle
  - [5. Liquidity Management](./finance/banking.md#5-liquidity-management): liquidity management
  - [11. Quantitative Building Blocks for Treasury Software](./finance/banking.md#11-quantitative-building-blocks-for-treasury-software): day-count conventions, yield curves, pricing, numerical correctness
  - [12. Messaging Standards and Integration](./finance/banking.md#12-messaging-standards-and-integration): SWIFT, ISO 20022, FIX, integration
  - [13. Treasury Systems Architecture](./finance/banking.md#13-treasury-systems-architecture): system landscape, data architecture, reconciliation
  - [15. Engineering Reliable and Secure Treasury Software](./finance/banking.md#15-engineering-reliable-and-secure-treasury-software): testing, resilience, security, change management in regulated banks
- **[System Design](./computer-science/system-design.md)**: [7.3 Delivery Semantics](./computer-science/system-design.md#73-delivery-semantics), [8.5 Distributed Transactions](./computer-science/system-design.md#85-distributed-transactions), [15.4 Transactional and Real-Time Systems](./computer-science/system-design.md#154-transactional-and-real-time-systems): delivery semantics, sagas, transactional systems
- **[Database Systems in Postgres](./computer-science/dbms.md)**: [8. Transactions and Concurrency](./computer-science/dbms.md#8-transactions-and-concurrency): transactions and concurrency

### Recommended

- **[Banking for Software Engineers (Treasury Focus)](./finance/banking.md)**: [6. Asset-Liability Management and Interest Rate Risk](./finance/banking.md#6-asset-liability-management-and-interest-rate-risk), [7. Funding and Capital Management](./finance/banking.md#7-funding-and-capital-management), [8. Market and Counterparty Risk in Treasury](./finance/banking.md#8-market-and-counterparty-risk-in-treasury), [9. Regulatory Framework](./finance/banking.md#9-regulatory-framework), [14. Accounting and Financial Reporting for Treasury](./finance/banking.md#14-accounting-and-financial-reporting-for-treasury)
- **[Object Oriented Programming in Java](./computer-science/java.md)**: [12. Concurrency & Parallelism](./computer-science/java.md#12-concurrency--parallelism), [17. The Spring Framework](./computer-science/java.md#17-the-spring-framework), [18. Spring Boot and Production Applications](./computer-science/java.md#18-spring-boot-and-production-applications): the dominant stack in banks
- **[Cyber Security](./computer-science/cyber-security.md)**: [10.1 Threat Modeling and Secure Design](./computer-science/cyber-security.md#101-threat-modeling-and-secure-design): threat modeling
- **Math:** [9.6 Taylor and Maclaurin Series](./math/calculus.md#96-taylor-and-maclaurin-series) (duration and convexity are Taylor expansions), [5.3 The Normal Distribution](./math/probability-and-statistics.md#53-the-normal-distribution), [12.1 Time Series Analysis](./math/probability-and-statistics.md#121-time-series-analysis)

### Deep Dive

- [16. Advanced Topics and Emerging Trends](./finance/banking.md#16-advanced-topics-and-emerging-trends): stress testing, real-time treasury, tokenization
- [2. Linear Programming](./math/operative-research.md#2-linear-programming), [9.4 Stochastic Programming](./math/operative-research.md#94-stochastic-programming): optimization for ALM and funding decisions

### Checkpoint

- Why must money never be a `double`? Name the type you would use instead.
- Describe the lifecycle of an FX trade from execution to settlement and reconciliation.
- How do you guarantee a payment message is processed exactly once across two systems?

---

## 17. Technical Interview Track

> A focused path for coding and system design interviews, whatever the role.

### Coding Interviews

- **[Algorithms and Data Structures](./computer-science/algorithms-and-data-structures.md)**: go through every chapter in order, [0. Interview Foundations](./computer-science/algorithms-and-data-structures.md#0-interview-foundations) to [17. Math and Geometry](./computer-science/algorithms-and-data-structures.md#17-math-and-geometry)
- [10.2 Growth of Functions](./math/discrete-mathematics.md#102-growth-of-functions), [6.2 Divide-and-Conquer Recurrences](./math/discrete-mathematics.md#62-divide-and-conquer-recurrences): growth of functions, Master theorem
- [5. Combinatorics](./math/discrete-mathematics.md#5-combinatorics): combinatorics for counting problems

### System Design Interviews

- [1.3 Requirement Gathering and Estimation](./computer-science/system-design.md#13-requirement-gathering-and-estimation): requirement gathering and back-of-the-envelope estimation
- [4. Content negotiation — the most "correct" by HTTP semantics, least used](./computer-science/system-design.md#4-content-negotiation--the-most-correct-by-http-semantics-least-used), [5. Caching and Content Delivery](./computer-science/system-design.md#5-caching-and-content-delivery), [6. Scalability and Load Management](./computer-science/system-design.md#6-scalability-and-load-management), [7. Asynchronous Processing and Messaging](./computer-science/system-design.md#7-asynchronous-processing-and-messaging): the building blocks
- [8.1 Fundamental Constraints](./computer-science/system-design.md#81-fundamental-constraints), [8.2 Consistency Models](./computer-science/system-design.md#82-consistency-models): CAP and consistency models
- [15. Applied System Design Case Studies](./computer-science/system-design.md#15-applied-system-design-case-studies): case studies, especially [15.5 Communicating a Design](./computer-science/system-design.md#155-communicating-a-design)

### Role-Specific Question Banks

- Java: [19. Capstone and Interview Preparation](./computer-science/java.md#19-capstone-and-interview-preparation)
- React: [15. Common Interview Questions](./computer-science/react.md#15-common-interview-questions)

---

## 18. Notes-to-Roles Matrix

Use this to see quickly which notes matter for which role. **Primary** means the note is central to the role's Core. **Secondary** means it appears in Recommended or Deep Dive.

| Note | Primary for | Secondary for |
|------|-------------|---------------|
| **[Algorithms and Data Structures](./computer-science/algorithms-and-data-structures.md)** | Common Core, Interview | Database |
| **[System Design](./computer-science/system-design.md)** | Backend, SRE, Data, ML/AI, FinTech | Full-Stack, DevOps, Cloud, Database, Frontend |
| **[Operative Systems](./computer-science/operative-systems.md)** | Systems, Security, SRE | Backend, DevOps, Data, Database |
| **[Networking](./computer-science/networking.md)** | Network, Security, SRE | Backend, DevOps, Cloud, Systems |
| **[Database Systems in Postgres](./computer-science/dbms.md)** | Backend, Data, Database, FinTech | Full-Stack, SRE, Data Scientist |
| **[C Programming Language](./computer-science/c.md)** | Systems | Security (Offensive) |
| **[Rust Programming Language](./computer-science/rust.md)** | Systems | Backend, Security, ML/AI |
| **[Object Oriented Programming in Java](./computer-science/java.md)** | Backend | FinTech, Security (AppSec), Interview |
| **[Web Technologies](./computer-science/web-technologies.md)** | Frontend, Full-Stack | Backend, Security (AppSec) |
| **[React Interview Study Guide](./computer-science/react.md)** | Frontend, Full-Stack | Interview |
| **[Docker](./computer-science/docker.md)** | DevOps | Backend, Full-Stack, ML/AI, Network, Security |
| **[Kubernetes](./computer-science/kubernetes.md)** | DevOps, SRE | Cloud, ML/AI, Network, Security |
| **[GitLab CI/CD](./computer-science/gitlab.md)** | DevOps | Full-Stack, Security (AppSec) |
| **[Azure Developer](./computer-science/azure.md)** | Cloud | DevOps, SRE, Data, ML/AI, Security |
| **[Cyber Security](./computer-science/cyber-security.md)** | Security | Backend, Frontend, DevOps, Cloud, ML/AI |
| **[Data Science](./computer-science/data-science.md)** | Data Scientist, ML/AI, Data | |
| **[Probability and Statistics](./math/probability-and-statistics.md)** | Data Scientist, ML/AI | SRE, Data, FinTech |
| **[Linear Algebra](./math/linear-algebra.md)** | Data Scientist, ML/AI | |
| **[Calculus](./math/calculus.md)** | Data Scientist, ML/AI | FinTech |
| **[Discrete Mathematics](./math/discrete-mathematics.md)** | Common Core | Security, Systems, Network, Interview |
| **[Operative Research](./math/operative-research.md)** | | SRE, Network, Data Scientist, ML/AI, FinTech |
| **[Banking for Software Engineers (Treasury Focus)](./finance/banking.md)** | FinTech | |
