# Redis

## Index

- [1. Introduction to Redis](#1-introduction-to-redis)
  - [1.1 Core Concepts](#11-core-concepts)
  - [1.2 Installation and Setup](#12-installation-and-setup)
  - [1.3 Interacting with Redis](#13-interacting-with-redis)
- [2. Keys and Core Data Types](#2-keys-and-core-data-types)
  - [2.1 Key Management](#21-key-management)
  - [2.2 Strings](#22-strings)
  - [2.3 Lists](#23-lists)
  - [2.4 Hashes](#24-hashes)
  - [2.5 Sets](#25-sets)
  - [2.6 Sorted Sets](#26-sorted-sets)
- [3. Advanced Data Structures](#3-advanced-data-structures)
  - [3.1 Bitmaps and Bitfields](#31-bitmaps-and-bitfields)
  - [3.2 Probabilistic Structures](#32-probabilistic-structures)
  - [3.3 Geospatial Indexes](#33-geospatial-indexes)
  - [3.4 Streams](#34-streams)
  - [3.5 JSON and Time Series](#35-json-and-time-series)
- [4. Messaging and Atomic Operations](#4-messaging-and-atomic-operations)
  - [4.1 Publish/Subscribe](#41-publishsubscribe)
  - [4.2 Transactions](#42-transactions)
  - [4.3 Pipelining](#43-pipelining)
  - [4.4 Server-Side Scripting](#44-server-side-scripting)
- [5. Internals and Architecture](#5-internals-and-architecture)
  - [5.1 Execution Model](#51-execution-model)
  - [5.2 Internal Encodings](#52-internal-encodings)
  - [5.3 Memory Management](#53-memory-management)
- [6. Persistence and Durability](#6-persistence-and-durability)
  - [6.1 RDB Snapshots](#61-rdb-snapshots)
  - [6.2 Append-Only File](#62-append-only-file)
  - [6.3 Persistence Strategies](#63-persistence-strategies)
- [7. Replication, High Availability and Scaling](#7-replication-high-availability-and-scaling)
  - [7.1 Replication](#71-replication)
  - [7.2 Redis Sentinel](#72-redis-sentinel)
  - [7.3 Redis Cluster](#73-redis-cluster)
  - [7.4 Scaling Strategies](#74-scaling-strategies)
- [8. Application Design Patterns](#8-application-design-patterns)
  - [8.1 Caching Patterns](#81-caching-patterns)
  - [8.2 Coordination Patterns](#82-coordination-patterns)
  - [8.3 Common Application Use Cases](#83-common-application-use-cases)
  - [8.4 Data Modeling](#84-data-modeling)
- [9. Search and AI Workloads](#9-search-and-ai-workloads)
  - [9.1 Query Engine](#91-query-engine)
  - [9.2 Vector Search](#92-vector-search)
  - [9.3 AI Application Patterns](#93-ai-application-patterns)
- [10. Client Development](#10-client-development)
  - [10.1 Client Libraries](#101-client-libraries)
  - [10.2 Connection Management](#102-connection-management)
  - [10.3 Testing and Development Workflow](#103-testing-and-development-workflow)
- [11. Security](#11-security)
  - [11.1 Access Control](#111-access-control)
  - [11.2 Network and Hardening](#112-network-and-hardening)
- [12. Operations and Performance](#12-operations-and-performance)
  - [12.1 Monitoring and Diagnostics](#121-monitoring-and-diagnostics)
  - [12.2 Performance Tuning](#122-performance-tuning)
  - [12.3 Production Deployment](#123-production-deployment)
  - [12.4 Extending Redis](#124-extending-redis)

---

<a id="1-introduction-to-redis"></a>
## 1. Introduction to Redis

<a id="11-core-concepts"></a>
### 1.1 Core Concepts

#### What Is Redis

#### In-Memory Data Stores

#### Key-Value Model

#### Redis vs Relational Databases

#### Redis vs Memcached

#### Common Use Cases

#### Redis Licensing and Forks (Valkey)

<a id="12-installation-and-setup"></a>
### 1.2 Installation and Setup

#### Installing on Linux and macOS

#### Running Redis with Docker

#### Starting redis-server

#### The redis.conf File

#### Managed Cloud Offerings

<a id="13-interacting-with-redis"></a>
### 1.3 Interacting with Redis

#### redis-cli Basics

#### RESP Protocol

#### Redis Insight GUI

#### Command Syntax and Documentation

#### Databases and SELECT

---

<a id="2-keys-and-core-data-types"></a>
## 2. Keys and Core Data Types

<a id="21-key-management"></a>
### 2.1 Key Management

#### Key Naming Conventions

#### EXISTS, DEL and UNLINK

#### TYPE and RENAME

#### KEYS vs SCAN

#### Key Expiration with EXPIRE and TTL

#### PERSIST and Expiration Semantics

<a id="22-strings"></a>
### 2.2 Strings

#### SET and GET

#### SET Options (NX, XX, EX, PX, GET)

#### MSET and MGET

#### Atomic Counters (INCR, DECR, INCRBY)

#### APPEND and GETRANGE

#### Binary-Safe Values

<a id="23-lists"></a>
### 2.3 Lists

#### LPUSH and RPUSH

#### LPOP and RPOP

#### LRANGE and LINDEX

#### LTRIM for Capped Lists

#### Blocking Operations (BLPOP, BLMOVE)

#### Lists as Queues and Stacks

<a id="24-hashes"></a>
### 2.4 Hashes

#### HSET and HGET

#### HGETALL and HSCAN

#### HINCRBY

#### Field-Level Expiration

#### Modeling Objects with Hashes

<a id="25-sets"></a>
### 2.5 Sets

#### SADD and SREM

#### SMEMBERS and SISMEMBER

#### Set Operations (SUNION, SINTER, SDIFF)

#### Random Members (SRANDMEMBER, SPOP)

#### Tagging and Uniqueness Patterns

<a id="26-sorted-sets"></a>
### 2.6 Sorted Sets

#### ZADD and Scores

#### Range Queries by Rank and Score

#### ZINCRBY

#### Lexicographical Ranges

#### ZRANGESTORE and Aggregations

#### Leaderboards

---

<a id="3-advanced-data-structures"></a>
## 3. Advanced Data Structures

<a id="31-bitmaps-and-bitfields"></a>
### 3.1 Bitmaps and Bitfields

#### SETBIT and GETBIT

#### BITCOUNT and BITPOS

#### BITOP Operations

#### BITFIELD Integers

#### Daily Active User Tracking

<a id="32-probabilistic-structures"></a>
### 3.2 Probabilistic Structures

#### HyperLogLog (PFADD, PFCOUNT, PFMERGE)

#### Bloom Filters

#### Cuckoo Filters

#### Count-Min Sketch

#### Top-K

#### t-digest

<a id="33-geospatial-indexes"></a>
### 3.3 Geospatial Indexes

#### GEOADD

#### GEODIST

#### GEOSEARCH by Radius and Box

#### Geohash Encoding

#### Proximity Search Use Cases

<a id="34-streams"></a>
### 3.4 Streams

#### XADD and Stream IDs

#### XRANGE and XREAD

#### Consumer Groups

#### XACK and Pending Entries

#### XCLAIM and XAUTOCLAIM

#### Stream Trimming

#### Streams vs Pub/Sub vs Lists

<a id="35-json-and-time-series"></a>
### 3.5 JSON and Time Series

#### JSON Documents with JSON.SET and JSON.GET

#### JSONPath Queries

#### Time Series Data Model

#### Downsampling and Retention Rules

#### Time Series Aggregation Queries

---

<a id="4-messaging-and-atomic-operations"></a>
## 4. Messaging and Atomic Operations

<a id="41-publishsubscribe"></a>
### 4.1 Publish/Subscribe

#### PUBLISH and SUBSCRIBE

#### Pattern Subscriptions

#### Sharded Pub/Sub

#### Delivery Guarantees and Limitations

#### Keyspace Notifications

<a id="42-transactions"></a>
### 4.2 Transactions

#### MULTI and EXEC

#### DISCARD

#### Optimistic Locking with WATCH

#### Error Handling in Transactions

#### Atomicity Guarantees

<a id="43-pipelining"></a>
### 4.3 Pipelining

#### Round-Trip Time Costs

#### Pipelining Commands

#### Pipelining vs Transactions

#### Batch Size Considerations

<a id="44-server-side-scripting"></a>
### 4.4 Server-Side Scripting

#### Lua Scripting with EVAL

#### EVALSHA and Script Caching

#### KEYS and ARGV

#### Redis Functions (FUNCTION LOAD, FCALL)

#### Script Atomicity and Timeouts

---

<a id="5-internals-and-architecture"></a>
## 5. Internals and Architecture

<a id="51-execution-model"></a>
### 5.1 Execution Model

#### Single-Threaded Event Loop

#### I/O Multiplexing

#### Threaded I/O

#### Blocking vs Non-Blocking Commands

#### Command Time Complexity

<a id="52-internal-encodings"></a>
### 5.2 Internal Encodings

#### Simple Dynamic Strings

#### Listpack Encoding

#### Quicklist

#### Intset

#### Skiplists in Sorted Sets

#### Hash Table Rehashing

#### OBJECT ENCODING

<a id="53-memory-management"></a>
### 5.3 Memory Management

#### maxmemory Configuration

#### Eviction Policies (LRU, LFU, TTL, Random)

#### Approximated LRU and LFU

#### Expiration Algorithm (Lazy and Active)

#### Memory Fragmentation and Active Defrag

#### MEMORY USAGE and MEMORY DOCTOR

---

<a id="6-persistence-and-durability"></a>
## 6. Persistence and Durability

<a id="61-rdb-snapshots"></a>
### 6.1 RDB Snapshots

#### How Snapshotting Works

#### SAVE vs BGSAVE

#### Fork and Copy-on-Write

#### Snapshot Configuration

#### RDB File Format

<a id="62-append-only-file"></a>
### 6.2 Append-Only File

#### AOF Mechanics

#### fsync Policies

#### AOF Rewriting

#### Multi-Part AOF

#### AOF Corruption Recovery

<a id="63-persistence-strategies"></a>
### 6.3 Persistence Strategies

#### RDB vs AOF Trade-offs

#### Hybrid Persistence

#### Running Without Persistence

#### Backup and Restore Procedures

---

<a id="7-replication-high-availability-and-scaling"></a>
## 7. Replication, High Availability and Scaling

<a id="71-replication"></a>
### 7.1 Replication

#### Primary-Replica Architecture

#### REPLICAOF

#### Full and Partial Resynchronization

#### Replication Backlog

#### Read-Only Replicas

#### WAIT and Write Consistency

<a id="72-redis-sentinel"></a>
### 7.2 Redis Sentinel

#### Sentinel Architecture

#### Monitoring and Quorum

#### Automatic Failover

#### Client Discovery via Sentinel

#### Split-Brain Scenarios

<a id="73-redis-cluster"></a>
### 7.3 Redis Cluster

#### Hash Slots and Sharding

#### Hash Tags for Multi-Key Operations

#### MOVED and ASK Redirections

#### Cluster Bus and Gossip Protocol

#### Resharding and Slot Migration

#### Cluster Failover

#### Cluster Limitations

<a id="74-scaling-strategies"></a>
### 7.4 Scaling Strategies

#### Vertical vs Horizontal Scaling

#### Client-Side Sharding

#### Proxy-Based Sharding

#### Active-Active Geo-Replication

#### CRDTs in Redis

---

<a id="8-application-design-patterns"></a>
## 8. Application Design Patterns

<a id="81-caching-patterns"></a>
### 8.1 Caching Patterns

#### Cache-Aside

#### Read-Through and Write-Through

#### Write-Behind

#### Cache Invalidation Strategies

#### Cache Stampede Prevention

#### Client-Side Caching and Tracking

<a id="82-coordination-patterns"></a>
### 8.2 Coordination Patterns

#### Distributed Locks with SET NX

#### Redlock Algorithm and Critiques

#### Rate Limiting (Fixed Window, Sliding Window, Token Bucket)

#### Idempotency Keys

#### Semaphores

<a id="83-common-application-use-cases"></a>
### 8.3 Common Application Use Cases

#### Session Storage

#### Job and Task Queues

#### Real-Time Analytics

#### Leaderboards and Ranking

#### Activity Feeds

#### Deduplication

<a id="84-data-modeling"></a>
### 8.4 Data Modeling

#### Choosing the Right Data Type

#### Secondary Indexes

#### Modeling Relationships

#### Denormalization Strategies

#### Avoiding Big Keys and Hot Keys

---

<a id="9-search-and-ai-workloads"></a>
## 9. Search and AI Workloads

<a id="91-query-engine"></a>
### 9.1 Query Engine

#### Creating Indexes with FT.CREATE

#### Full-Text Search

#### Numeric, Tag and Geo Filters

#### Aggregations with FT.AGGREGATE

#### Indexing Hashes and JSON

<a id="92-vector-search"></a>
### 9.2 Vector Search

#### Vector Embeddings

#### Vector Fields (FLAT, HNSW)

#### Distance Metrics

#### K-Nearest Neighbor Queries

#### Hybrid Queries

#### Vector Sets

<a id="93-ai-application-patterns"></a>
### 9.3 AI Application Patterns

#### Retrieval-Augmented Generation

#### Semantic Caching

#### LLM Conversation Memory

#### Feature Stores

---

<a id="10-client-development"></a>
## 10. Client Development

<a id="101-client-libraries"></a>
### 10.1 Client Libraries

#### Python (redis-py)

#### Node.js (node-redis, ioredis)

#### Java (Jedis, Lettuce)

#### Go (go-redis)

#### Object Mapping Libraries

<a id="102-connection-management"></a>
### 10.2 Connection Management

#### Connection Pooling

#### Timeouts and Retries

#### RESP3 Features

#### Cluster-Aware Clients

#### Handling Failover in Clients

<a id="103-testing-and-development-workflow"></a>
### 10.3 Testing and Development Workflow

#### Local Development Environments

#### Integration Testing with Testcontainers

#### Mocking Redis

#### Data Seeding and Fixtures

---

<a id="11-security"></a>
## 11. Security

<a id="111-access-control"></a>
### 11.1 Access Control

#### Protected Mode

#### Password Authentication

#### ACL Users and Permissions

#### Command Categories

#### Key and Channel Patterns in ACLs

<a id="112-network-and-hardening"></a>
### 11.2 Network and Hardening

#### TLS Encryption

#### Binding and Firewalling

#### Renaming and Disabling Dangerous Commands

#### Lua Sandbox Security

#### Common Vulnerabilities and Misconfigurations

---

<a id="12-operations-and-performance"></a>
## 12. Operations and Performance

<a id="121-monitoring-and-diagnostics"></a>
### 12.1 Monitoring and Diagnostics

#### INFO Command Sections

#### SLOWLOG

#### LATENCY Monitoring

#### MONITOR Command and Its Costs

#### CLIENT LIST and CLIENT KILL

#### Metrics Export with Prometheus

<a id="122-performance-tuning"></a>
### 12.2 Performance Tuning

#### Benchmarking with redis-benchmark

#### Finding Big Keys and Hot Keys

#### Avoiding O(N) Commands

#### Linux Kernel Tuning (THP, overcommit)

#### Network Latency Optimization

<a id="123-production-deployment"></a>
### 12.3 Production Deployment

#### Deploying on Kubernetes

#### Configuration Management

#### Upgrades and Version Migration

#### Data Migration Between Instances

#### Disaster Recovery Planning

#### Capacity Planning

<a id="124-extending-redis"></a>
### 12.4 Extending Redis

#### Redis Modules API

#### Loading and Managing Modules

#### Writing a Custom Module

#### Redis Stack and Bundled Modules
