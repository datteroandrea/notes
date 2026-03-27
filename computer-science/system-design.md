# Chapter 1: Foundations of System Design

System design is the discipline of defining the architecture, components, and data flows of a software system to satisfy a given set of requirements. This chapter establishes the vocabulary and mental models you will use throughout the rest of the curriculum: from understanding what you are being asked to build, to reasoning about whether that system can survive real-world load, failure, and growth. Mastery of these foundations is what separates engineers who can write code from engineers who can build reliable, scalable systems.

---

## 1.1 Core Concepts

Before touching any technology choice, a system designer must understand the problem space. This subchapter introduces the fundamental analytical tools used at the very start of any design exercise.

---

### What is System Design

**Theory**

When you write a function, you solve a bounded, local problem. System design asks a larger question: how do many components — servers, databases, caches, queues, clients — work together to solve a problem for potentially millions of users, reliably and efficiently?

System design is the process of defining:
- **Architecture** — the high-level structure of components and how they interact
- **Data modeling** — how information is stored, accessed, and transformed
- **Trade-offs** — every design decision involves giving something up; good designers make those trade-offs consciously

Think of it like urban planning. A single house is easy to design. A city that must accommodate 10 million people, survive earthquakes, recover from power outages, and keep growing — that requires systems thinking.

System design problems are intentionally open-ended. There is rarely a single correct answer. The goal is to demonstrate clear reasoning, awareness of constraints, and the ability to justify decisions.

**Common contexts where system design matters:**
- Building a new product from scratch
- Scaling an existing system under load
- Migrating from a monolith to a distributed architecture
- Preparing for engineering interviews at senior/staff level

**Example**

The following diagram shows the difference between a simple single-server system and a distributed one.

```
Single-Server Architecture:
+--------+       +--------+
| Client | ----> | Server | (handles everything: logic, DB, files)
+--------+       +--------+

Distributed Architecture:
+--------+       +----------------+       +-----------+
| Client | ----> | Load Balancer  | ----> | App Server|---+
+--------+       +----------------+       +-----------+   |
                                          | App Server|   +--> [ Database Cluster ]
                                          +-----------+   |
                                          | App Server|---+
                                          +-----------+
                                                |
                                          [ Cache Layer ]
                                          [ Object Storage ]
                                          [ Message Queue ]
```

The distributed system introduces complexity, but enables horizontal scaling, redundancy, and independent deployment of components.

> **Exercises**
>
> 1. (Beginner) Name three real-world products and describe, at a high level, what makes each one a "system" rather than a simple application. What components do you think each product requires beyond a single server?
>
> 2. (Beginner) What is the difference between designing a system and writing an algorithm? In which situations is system design the appropriate tool?
>
> 3. (Intermediate) A startup asks you to design a URL shortener (like bit.ly). Before drawing any architecture, list the questions you would ask the interviewer to clarify requirements. Why does each question matter for the design?
>    - *Hint: Think about scale, read-to-write ratio, and persistence guarantees.*
>
> 4. (Intermediate/Interview) "Design a global leaderboard for a mobile game." Walk through the first two minutes of your approach. What do you identify first, and why?
>    - *Hint: You do not need a solution — focus on how you structure your thinking before proposing anything.*

**Answers**

1. Examples: Twitter — requires servers, databases, CDN, search index, notification service, message queues; Spotify — requires file storage for audio, streaming servers, recommendation engine, licensing/DRM service; Google Maps — requires tile servers, routing engine, real-time traffic ingestion, geospatial database. Each goes far beyond a single process because they serve global users, require different storage/processing guarantees per subsystem, and must remain available under partial failures.

2. An algorithm is a finite set of steps to solve a bounded computational problem (e.g., sort a list). System design addresses the question of how multiple processes, services, and data stores collaborate to deliver a feature reliably at scale. System design is appropriate when the problem involves multiple users, persistence, networking, concurrency, or availability requirements — i.e., when the boundary of the problem extends beyond a single process.

3. Questions to ask for a URL shortener:
   - How many URLs are shortened per day / total stored? (Affects storage, ID generation strategy)
   - What is the expected read-to-write ratio? (URL redirects are typically far more frequent than creation — informs caching strategy)
   - Should shortened URLs expire? (Affects storage and cleanup jobs)
   - Do we need analytics (click counts, geo data)? (Adds a write path for every redirect)
   - Is custom aliasing required? (Affects ID uniqueness constraints)
   - Global or single-region? (Affects latency and replication strategy)

4. First two minutes structure: (1) Clarify scale — how many players, how often does the leaderboard update, is it global or per-region? (2) Identify the core operations — write a score, read the top-N, read a player's rank. (3) Note the hardest constraint — computing global rank in real time at high write volume is the central challenge. (4) State the trade-off you will explore first — exact real-time ranking (hard, expensive) vs. approximate or periodically refreshed ranking (easier, may be acceptable). Only then begin proposing components.

---

### Functional vs Non-Functional Requirements

**Theory**

Before designing anything, you must know what the system must *do* and what constraints it must operate under. These are captured in two categories:

**Functional Requirements (FR)** describe *what* the system does — its behaviors and features. They answer: "What actions can users and other systems perform?"

**Non-Functional Requirements (NFR)** describe *how well* the system does it — its quality attributes. They answer: "Under what conditions must the system operate, and to what standard?"

The distinction matters because FRs drive your data model and API design, while NFRs drive your infrastructure and architecture choices. A system that fulfills all FRs but ignores NFRs will fail in production.

| Dimension          | Functional Requirement Example                     | Non-Functional Requirement Example                    |
|--------------------|-----------------------------------------------------|-------------------------------------------------------|
| Storage            | Users can upload profile photos                    | Photos must be retrievable within 200ms globally       |
| Messaging          | Users can send direct messages                     | Messages must be delivered at least once               |
| Authentication     | Users can log in with email and password           | Login must handle 10,000 concurrent sessions           |
| Search             | Users can search posts by keyword                  | Search results must appear within 500ms for 99% of queries |

**Common NFR categories to consider in every system design:**

- **Performance** — latency percentiles (p50, p99), throughput (requests/second)
- **Scalability** — ability to grow with load
- **Availability** — percentage of time the system is operational (e.g., 99.99%)
- **Durability** — guarantee that data, once written, is not lost
- **Consistency** — all nodes see the same data at the same time (vs. eventual consistency)
- **Security** — authentication, authorization, encryption
- **Maintainability** — ease of making changes without introducing failures

**Example**

```
System: Ride-sharing application (e.g., Uber)

Functional Requirements:
  - Rider can request a ride from point A to B
  - Driver can accept or reject a ride request
  - System matches the nearest available driver to a rider
  - Rider can view real-time driver location on a map
  - Rider can pay through the app after trip completion

Non-Functional Requirements:
  - Driver location updates must be ingested at ~5 second intervals for all active drivers
  - Ride matching must complete within 3 seconds
  - The system must support 1 million concurrent users during peak hours
  - Payment processing must be exactly-once (no duplicate charges)
  - Location data need not be strongly consistent (eventual is acceptable)
  - Payment data must be strongly consistent
```

Notice that the NFRs directly change the architecture: strong consistency for payments implies a relational database with ACID transactions, while eventual consistency for location data allows cheaper, more scalable options.

> **Exercises**
>
> 1. (Beginner) For a simple to-do list application, list three functional requirements and three non-functional requirements.
>
> 2. (Beginner) Why can two systems have identical functional requirements but completely different architectures? What drives the architectural difference?
>
> 3. (Intermediate) A social media platform has the following requirement: "Users should be able to see their feed within 2 seconds, 99% of the time." Is this functional or non-functional? Break it down into its component parts.
>
> 4. (Intermediate/Interview) You are designing a distributed logging system for a microservices platform. Write at least four functional requirements and four non-functional requirements. For each NFR, name one architectural decision it would influence.
>    - *Hint: Think about what services produce logs, who consumes them, and what guarantees make logs useful for debugging.*

**Answers**

1. To-do list:
   - FR: User can create a task with a title and due date; user can mark a task as complete; user can delete a task.
   - NFR: The UI must respond to interactions within 100ms; data must be persisted across browser sessions (durability); the application must work offline (availability/resilience).

2. Two systems with identical FRs can require completely different architectures because NFRs drive infrastructure decisions. A to-do app for a single user and one for 10 million concurrent users may both need "create/read/update/delete tasks," but the latter requires load balancing, database sharding, caching, and a CDN — none of which the single-user version requires.

3. "Users should be able to see their feed within 2 seconds, 99% of the time" is a non-functional requirement. Broken down: (a) *Latency target*: 2 seconds end-to-end; (b) *Percentile*: 99th — not average, meaning even the slowest 1% of requests must meet this; (c) *Scope*: feed generation, which is typically a read-heavy, complex aggregation. This NFR implies pre-computation (fan-out on write) or very fast on-demand aggregation, and a cache layer to avoid re-generating the feed on every request.

4. Distributed logging system:
   - FR: Services can emit structured log events; operators can query logs by time range, service, and severity; logs can be streamed in near-real-time to a dashboard; logs older than a configurable threshold can be archived.
   - NFR (with architectural implication):
     - Ingest must handle 1M events/sec at peak → implies a distributed message queue (e.g., Kafka) to buffer and absorb bursts before persistence.
     - Logs must be queryable within 5 seconds of emission → implies a fast indexing layer (e.g., Elasticsearch or ClickHouse).
     - Log data must be retained for 90 days at full fidelity → implies tiered storage (hot storage for recent, cold/object storage for older).
     - The logging pipeline must not cause backpressure on the emitting service → implies fire-and-forget (UDP or async TCP) at the client side with at-least-once delivery guarantees.

---

### Back-of-the-Envelope Estimation

**Theory**

Before committing to an architecture, a designer must develop a rough quantitative intuition about the system's scale. Back-of-the-envelope estimation is the practice of making quick, order-of-magnitude calculations to determine whether a proposed design is feasible.

The goal is not precision — it is to avoid being wrong by an order of magnitude, which can mean choosing the wrong class of solution entirely (e.g., a single database vs. a distributed one).

Key reference values every system designer should memorize:

| Metric                           | Approximate Value          |
|----------------------------------|----------------------------|
| Single-core CPU operations/sec   | ~1 billion (10^9)          |
| SSD random read latency          | ~0.1 ms                    |
| Network round-trip (same DC)     | ~0.5 ms                    |
| Network round-trip (cross-region)| ~150 ms                    |
| SSD sequential throughput        | ~500 MB/s                  |
| Typical HTTPS request size       | ~1-10 KB                   |
| Seconds in a day                 | ~86,400                    |
| Seconds in a year                | ~31.5 million (~3 x 10^7)  |

**The estimation process:**

1. Identify the dominant operations (reads, writes, storage, bandwidth)
2. Estimate daily volume, then convert to per-second rates
3. Estimate data sizes per unit
4. Derive storage, bandwidth, and compute requirements
5. State your assumptions explicitly

**Example**

Problem: Estimate the storage requirements for a Twitter-like service.

```
Assumptions:
  - 300 million daily active users (DAU)
  - Each user sends an average of 2 tweets per day
  - Each tweet: 300 bytes (text) + metadata
  - 20% of tweets include an image (average 200 KB compressed)
  - Retention period: 5 years

--- Step 1: Daily tweet volume ---
  Tweets/day = 300M users * 2 tweets = 600M tweets/day

--- Step 2: Text storage per day ---
  600M * 300 bytes = 180 GB/day (text + metadata)

--- Step 3: Image storage per day ---
  Images/day = 600M * 0.20 = 120M images/day
  Storage     = 120M * 200 KB = 24,000 GB/day = 24 TB/day

--- Step 4: Total daily storage ---
  ~24 TB/day (dominated by images, as is typical)

--- Step 5: 5-year storage (text + images) ---
  Text: 180 GB/day * 365 * 5 ≈ 328 TB
  Images: 24 TB/day * 365 * 5 ≈ 43,800 TB ≈ 43.8 PB

Conclusion:
  Text alone is manageable on a large database cluster.
  Images require a dedicated object storage system (e.g., S3-equivalent)
  with ~44 PB capacity over 5 years, not counting CDN caching or replication overhead.
```

> **Exercises**
>
> 1. (Beginner) A video streaming platform has 50 million DAU. Each user watches an average of 30 minutes of video per day. A video stream is delivered at 5 Mbps. Estimate the total outbound bandwidth required per second at peak load. Assume peak is 2x the daily average.
>
> 2. (Beginner) A relational database can handle approximately 1,000 write transactions per second on a single node. Your application is expected to receive 50 million writes per day. Is a single database node sufficient? Show your calculation.
>
> 3. (Intermediate) Estimate the storage required for a photo-sharing app (Instagram-like) over 10 years. Assume: 100M DAU, each user uploads 1 photo per day on average, each photo is 3 MB after compression, and photos are never deleted.
>    - *Hint: Convert daily uploads to annual, then to 10-year. Check whether the result requires object storage.*
>
> 4. (Intermediate/Interview) A ride-sharing app tracks the GPS location of 500,000 active drivers. Each driver sends a location update every 5 seconds. Each update is 50 bytes. Estimate (a) the write throughput in requests/second, (b) the ingest bandwidth in MB/s, and (c) the storage needed if every update is retained for 30 days.
>    - *Hint: Be careful to convert consistently. Start with updates per second, not per day.*

**Answers**

1. Bandwidth estimation:
   - Daily average concurrent viewers (rough): 50M users * 30 min / 86,400 sec ≈ ~17,400 concurrent streams at any moment (assuming evenly distributed).
   - At peak (2x): ~34,800 concurrent streams.
   - Bandwidth at peak: 34,800 * 5 Mbps = 174,000 Mbps = 174 Gbps.
   - This requires a multi-Tbps CDN backbone and confirms that direct server delivery is infeasible — content must be cached at edge nodes.

2. Writes per second:
   - 50M writes/day ÷ 86,400 sec/day ≈ 579 writes/sec (average).
   - A single node at 1,000 writes/sec can handle the average load. However, traffic is never uniform. At a conservative 2x peak factor: 1,158 writes/sec — this exceeds the single node's capacity. Even without peak analysis, leaving zero headroom is a poor design. The answer is: a single node is borderline insufficient and should not be used without read replicas, connection pooling tuning, and a caching layer to absorb redundant reads. For production, at least a primary-replica setup is warranted.

3. Photo storage:
   - Uploads per day: 100M users * 1 photo = 100M photos/day.
   - Storage per day: 100M * 3 MB = 300 TB/day.
   - Per year: 300 TB * 365 ≈ 109.5 PB/year.
   - Over 10 years: ~1.1 exabytes.
   - This is firmly in the territory of distributed object storage (S3, GCS, Azure Blob). It also implies that a CDN is essential — serving even a fraction of this from origin servers is not viable.

4. Ride-sharing GPS ingest:
   - (a) Write throughput: 500,000 drivers / 5 sec per update = 100,000 writes/sec (100K RPS). This far exceeds a single relational DB node and implies a time-series database or a distributed log (e.g., Kafka).
   - (b) Bandwidth: 100,000 updates/sec * 50 bytes = 5,000,000 bytes/sec = ~4.77 MB/s ingest. This is manageable bandwidth but the request rate is the bottleneck.
   - (c) Storage for 30 days:
     - Updates per second: 100,000
     - Updates per day: 100,000 * 86,400 = 8.64 billion
     - Per 30 days: 8.64B * 30 = 259.2 billion updates
     - Storage: 259.2B * 50 bytes ≈ 12.96 TB for raw data.
     - With indexing overhead (assume 2x): ~26 TB. A time-series store with compression could reduce this significantly.

---

### Capacity Planning Basics

**Theory**

Capacity planning is the discipline of determining what resources (CPU, memory, storage, network) a system needs to meet current and projected demand — and provisioning them ahead of time.

Estimation (the previous topic) answers "how big is the problem?" Capacity planning answers "how many machines/resources do I need to solve it?"

The core approach:

1. **Baseline the load** — queries per second, data volume, concurrency
2. **Benchmark the unit** — how much load can one server/node handle?
3. **Divide and add overhead** — total load ÷ per-unit capacity, then add safety margin
4. **Plan for growth** — project 6 months to 2 years forward

**Key terms:**

| Term              | Definition                                                                        |
|-------------------|-----------------------------------------------------------------------------------|
| Headroom          | Extra capacity provisioned beyond expected peak to absorb spikes                  |
| Overprovisioning  | Allocating far more resources than needed, increasing cost without benefit         |
| Underprovisioning | Insufficient resources, leading to degradation or outages under load               |
| Resource ceiling  | The single resource that limits throughput (often called the bottleneck)           |
| Burn rate         | Rate at which a metric (e.g., storage, budget) is consumed over time               |

**Example**

```python
# Simple capacity planning model for an API service

DAILY_REQUESTS = 86_400_000      # 86.4 million requests/day
PEAK_MULTIPLIER = 3              # Peak is 3x daily average
SINGLE_SERVER_RPS = 1000         # Benchmarked: 1 server handles 1,000 RPS
SAFETY_MARGIN = 0.30             # Keep 30% headroom above peak

# Step 1: Average RPS
average_rps = DAILY_REQUESTS / 86_400              # 1,000 RPS

# Step 2: Peak RPS
peak_rps = average_rps * PEAK_MULTIPLIER           # 3,000 RPS

# Step 3: Servers needed at peak (no safety margin)
servers_at_peak = peak_rps / SINGLE_SERVER_RPS     # 3.0 -> 3 servers

# Step 4: Apply safety margin
# We want actual load to be at most (1 - margin) of total capacity
required_servers = servers_at_peak / (1 - SAFETY_MARGIN)  # 4.28 -> 5 servers

print(f"Average RPS:         {average_rps:.0f}")
print(f"Peak RPS:            {peak_rps:.0f}")
print(f"Servers at peak:     {servers_at_peak:.1f}")
print(f"Servers with margin: {required_servers:.1f} -> provision {int(required_servers) + 1}")
# Output:
# Average RPS:         1000
# Peak RPS:            3000
# Servers at peak:     3.0
# Servers with margin: 4.28 -> provision 5
```

**Storage growth projection:**

```python
# Storage burn rate and capacity planning

daily_storage_gb = 300           # GB/day ingested
monthly_growth_rate = 0.05       # 5% month-over-month growth in data volume
initial_capacity_tb = 100        # Current storage capacity in TB
months = 24                      # Planning horizon

current_daily_gb = daily_storage_gb
total_used_gb = 0

for month in range(1, months + 1):
    monthly_ingested = current_daily_gb * 30
    total_used_gb += monthly_ingested
    total_used_tb = total_used_gb / 1024

    if total_used_tb > initial_capacity_tb * 0.80:  # 80% threshold
        print(f"Month {month:2d}: {total_used_tb:.1f} TB used -- CAPACITY ALERT")
    else:
        print(f"Month {month:2d}: {total_used_tb:.1f} TB used")

    current_daily_gb *= (1 + monthly_growth_rate)
```

> **Exercises**
>
> 1. (Beginner) What is the difference between capacity planning and back-of-the-envelope estimation? In what order are they typically performed?
>
> 2. (Beginner) A single database node can process 500 read queries per second. Your application has 2 million DAU, each generating an average of 20 read queries per day. How many database read replicas do you need, assuming a peak multiplier of 4x and a 25% safety margin?
>
> 3. (Intermediate) Your object storage is currently at 40 TB and growing at 2 TB/day. You have a total provisioned capacity of 200 TB. At what point (in days) will you hit 80% utilization? What would you do at that threshold?
>    - *Hint: Set up a simple equation: 40 + 2d = 0.80 * 200, solve for d.*
>
> 4. (Intermediate/Interview) You are planning capacity for a new service launching in 3 months. Initial projections show 10,000 DAU at launch, growing to 500,000 DAU over 12 months. Each user generates 100 requests/day. A single app server handles 500 RPS, costs $200/month, and you want no more than 60% CPU utilization at peak (peak is 5x average). How many servers do you need at launch and at month 12?
>    - *Hint: Work through each time point separately. Do not forget to apply the utilization cap.*

**Answers**

1. Back-of-the-envelope estimation is about quantifying the problem (how large is the load, how much storage is needed?). Capacity planning is about determining resource requirements given that load (how many servers, how much storage do I need to procure?). Estimation always comes first — you cannot plan capacity without knowing the demand.

2. Database read replicas:
   - Total reads/day: 2M * 20 = 40M reads/day.
   - Average RPS: 40M / 86,400 ≈ 463 RPS.
   - Peak RPS: 463 * 4 = 1,852 RPS.
   - Nodes needed at peak: 1,852 / 500 = 3.7 → 4 nodes.
   - With 25% safety margin: 4 / 0.75 = 5.33 → **6 read replicas** (always round up).

3. Storage utilization threshold:
   - 80% of 200 TB = 160 TB.
   - Equation: 40 + 2d = 160 → 2d = 120 → **d = 60 days**.
   - At 60 days, you hit the 80% threshold. Actions: trigger a capacity expansion order immediately (procurement lag can be 2–4 weeks for on-prem, or provision additional cloud storage); implement data lifecycle policies (archive or delete old data to slow the burn rate); review whether growth projections are accurate.

4. Server capacity at launch and month 12:
   - At launch (10,000 DAU):
     - Avg RPS: 10,000 * 100 / 86,400 ≈ 11.6 RPS (trivially low).
     - Peak RPS: 11.6 * 5 = 58 RPS.
     - Server at 60% utilization handles: 500 * 0.60 = 300 RPS.
     - Servers needed: 58 / 300 = 0.2 → **1 server** (minimum viable).
   - At month 12 (500,000 DAU):
     - Avg RPS: 500,000 * 100 / 86,400 ≈ 579 RPS.
     - Peak RPS: 579 * 5 = 2,894 RPS.
     - Servers needed at 60% utilization: 2,894 / 300 ≈ 9.6 → **10 servers**.
     - Monthly cost at month 12: 10 * $200 = $2,000/month.
   - Key insight: the system must support gradual scaling between 1 and 10 servers — this justifies auto-scaling over static provisioning.

---

### Latency vs Throughput

**Theory**

Latency and throughput are the two primary performance dimensions of any system, and they are frequently in tension.

**Latency** is the time it takes to complete a single operation — from request initiation to response receipt. It is typically measured in milliseconds and reported as percentiles (p50, p95, p99).

**Throughput** is the number of operations a system can complete per unit of time — typically requests per second (RPS) or transactions per second (TPS).

The intuition for their relationship: imagine a highway.
- **Latency** is how long it takes one car to travel from point A to point B.
- **Throughput** is how many cars pass a checkpoint per hour.

A wide highway (many lanes = parallelism) can have high throughput while individual cars still experience the same travel time (latency). But if the highway is congested (near capacity), every car slows down — throughput is saturated and latency degrades.

**Little's Law** formalizes this relationship:

```
L = λ × W

Where:
  L = number of requests in the system (concurrency)
  λ = throughput (requests/second)
  W = average latency (seconds)

Example:
  If your system processes 500 RPS and average latency is 0.1s,
  then at any moment there are 500 * 0.1 = 50 requests in-flight.
```

**Latency percentiles** matter more than averages in practice:

| Percentile | Meaning                                              |
|------------|------------------------------------------------------|
| p50        | Median latency — 50% of requests are faster          |
| p95        | 95% of requests complete faster than this value      |
| p99        | 99% of requests complete faster than this value      |
| p999       | The 0.1% tail — critical for high-SLA systems        |

Averages hide tail latency. A system with p50=10ms and p99=5000ms will feel broken to 1% of users.

**Optimization trade-offs:**

| Optimization Approach         | Effect on Latency | Effect on Throughput | Trade-off                              |
|-------------------------------|-------------------|----------------------|----------------------------------------|
| Add caching                   | Decreases         | Increases            | Stale data risk                        |
| Batching requests             | Increases         | Increases            | Individual request waits longer        |
| Increase parallelism          | Decreases         | Increases            | More resource consumption              |
| Compression                   | May increase      | Increases            | CPU cost for encode/decode             |
| Synchronous processing        | Predictable       | Lower                | Simpler but does not scale             |
| Asynchronous processing       | Variable          | Higher               | Complexity, harder to debug            |

**Example**

```java
// Demonstrating the latency-throughput trade-off with batching

import java.util.ArrayList;
import java.util.List;

public class BatchProcessor {

    private static final int BATCH_SIZE = 100;
    private final List<Event> buffer = new ArrayList<>();

    // HIGH THROUGHPUT approach: batch writes to DB
    // Trade-off: individual event latency increases (waits for batch to fill)
    public void addEvent(Event event) {
        buffer.add(event);

        if (buffer.size() >= BATCH_SIZE) {
            flushBatch(); // One DB write for 100 events = high throughput
        }
    }

    // LOW LATENCY approach: write each event immediately
    // Trade-off: each event causes a DB round-trip = lower throughput
    public void addEventLowLatency(Event event) {
        writeToDatabase(event); // Immediate, but 100x more DB operations
    }

    private void flushBatch() {
        writeAllToDatabase(buffer); // Single bulk insert
        buffer.clear();
    }

    private void writeToDatabase(Event e) { /* single-row insert */ }
    private void writeAllToDatabase(List<Event> events) { /* bulk insert */ }
}
```

> **Exercises**
>
> 1. (Beginner) Define latency and throughput in your own words. Give one example of a system where low latency is the primary goal, and one where high throughput is the primary goal.
>
> 2. (Beginner) Why are percentile-based latency measurements (p99, p999) more useful than average latency for production systems?
>
> 3. (Intermediate) Using Little's Law, calculate the average number of requests in flight for a system processing 2,000 RPS with an average latency of 50ms. If the system's concurrency limit (connection pool size) is 80 requests, what will happen?
>    - *Hint: Apply L = λ × W carefully with consistent units.*
>
> 4. (Intermediate/Interview) You are tasked with reducing the p99 latency of a read-heavy API from 800ms to under 200ms. You cannot change the database schema. What strategies would you consider, and what trade-offs does each introduce?
>    - *Hint: Think in layers — network, application, data access. Consider what is likely causing tail latency.*

**Answers**

1. Latency: the elapsed time between sending a request and receiving a response — how fast a single operation is. Throughput: the rate at which the system processes operations over time — how many operations per second.
   - Low latency primary: real-time stock trading systems, where a millisecond delay can mean a missed trade.
   - High throughput primary: log ingestion pipelines, where millions of events must be written per second and no single event is time-critical.

2. Average latency is skewed by the distribution and hides outliers. If 99% of requests complete in 10ms but 1% take 5 seconds, the average might be 60ms — which sounds acceptable. But in a system serving 10,000 RPS, that 1% means 100 users/second experience 5-second delays. Percentiles expose this: p99=5000ms immediately flags the problem. For SLAs promising response times "for all users," p99 or p999 is the authoritative measure.

3. Little's Law:
   - L = λ × W = 2,000 RPS × 0.050 s = **100 requests in flight** at any moment.
   - The connection pool limit is 80. Since the system needs 100 concurrent connections but can only have 80, the excess 20 requests must queue. This causes latency to increase (requests wait for a connection), which further increases L, which creates more queuing — a feedback loop leading to latency degradation or timeouts. Resolution: increase pool size, reduce average latency (so L drops below 80), or reduce RPS via rate limiting.

4. Strategies to reduce p99 from 800ms to under 200ms:
   - **Add a read-through cache** (e.g., Redis): Cache the results of common queries. Cache hits bypass the database entirely, reducing tail latency dramatically. Trade-off: stale data; cache invalidation complexity.
   - **Connection pooling / persistent connections**: If each request opens a new DB connection, the connection overhead alone can add 100–500ms. A connection pool keeps connections warm. Trade-off: resource consumption, pool exhaustion under high concurrency.
   - **Query result pre-computation**: Identify the queries causing tail latency and pre-compute their results on a schedule, serving from a fast store. Trade-off: data freshness.
   - **Read replicas**: Route read traffic to replicas to reduce load on the primary, which reduces queue depth and tail latency. Trade-off: replication lag means replicas may serve slightly stale data.
   - **Async processing for non-critical work**: If the request handler does work beyond the query (logging, analytics events), move that work to a background queue. Trade-off: the work is no longer synchronously confirmed.
   - **Identify slow outlier queries**: p99 is often caused by a small set of pathological queries (missing index, hot row). Use slow query logs to find and fix these. Trade-off: schema/index changes may affect write performance.

---

## 1.2 Scalability Fundamentals

A system that works for 1,000 users often breaks at 1,000,000. Scalability is the property that allows a system to maintain acceptable performance as its load grows. This subchapter covers the core strategies and limitations of scaling a system.

---

### Vertical Scaling

**Theory**

Vertical scaling (also called "scaling up") means increasing the resources of a single machine: more CPU cores, more RAM, faster storage, higher network bandwidth.

It is the simplest form of scaling — the application requires no changes, and there is no added complexity in coordination between multiple machines. For small to medium systems, it is often the right first move.

However, vertical scaling has hard limits:
- **Physical ceiling** — the largest server you can buy has a finite number of cores and a maximum RAM capacity
- **Cost curve** — high-end server hardware exhibits diminishing returns; doubling performance typically more than doubles cost at the top end
- **Single point of failure** — a bigger machine is still one machine; if it fails, the entire service goes down
- **Downtime for upgrades** — adding hardware to a running server often requires a maintenance window

Vertical scaling is best suited for:
- Databases with strong consistency requirements that are difficult to shard
- Applications where the team lacks the operational maturity to manage distributed systems
- Early-stage products where simplicity of operations outweighs theoretical scale limits

```
Vertical Scaling Illustration:

Before:
+------------------+
| Server (4 cores) |  <-- handles 1,000 RPS
| 16 GB RAM        |
| 500 GB SSD       |
+------------------+

After (vertical scale):
+------------------+
| Server (32 cores)|  <-- handles 8,000 RPS
| 128 GB RAM       |
| 4 TB NVMe SSD    |
+------------------+

Same machine, more capacity. No code changes.
But there is now a larger single point of failure.
```

> **Exercises**
>
> 1. (Beginner) List three advantages and three disadvantages of vertical scaling.
>
> 2. (Beginner) At what point does vertical scaling become impractical? What signals should trigger a decision to move to horizontal scaling instead?
>
> 3. (Intermediate) A PostgreSQL database is experiencing high CPU utilization due to complex analytical queries. The team proposes vertically scaling from 16 to 64 CPU cores. Is this a good decision? What alternative approaches might be more appropriate?
>    - *Hint: Consider the nature of the workload — OLTP vs OLAP — and whether vertical scaling addresses the root cause.*
>
> 4. (Intermediate/Interview) A startup's application server is running at 85% CPU on a 16-core machine. The lead engineer suggests vertically scaling to a 32-core machine. As a senior engineer, what questions would you ask before approving this decision?
>    - *Hint: Think about root cause, future trajectory, cost, and the risk of treating a symptom rather than the cause.*

**Answers**

1. Advantages: no code changes required; no distributed systems complexity (no consensus, no network partitions); simpler operations and monitoring. Disadvantages: hard physical ceiling on available hardware; single point of failure; hardware upgrades often require downtime.

2. Vertical scaling becomes impractical when: (a) you have reached or are approaching the maximum available instance size for your workload type; (b) the cost per unit of performance is significantly higher than a distributed alternative; (c) the single point of failure risk is unacceptable for the system's availability SLA; (d) upgrade-related downtime violates your availability targets.

3. This is not necessarily a good decision. Complex analytical queries running on a transactional (OLTP) PostgreSQL instance are an architectural mismatch. More cores help with CPU-bound queries, but the real issue is that analytical (OLAP) queries perform full-table scans and aggregations that are poorly suited to a row-store OLTP database. Better approaches: offload analytics to a columnar database (e.g., ClickHouse, Redshift, BigQuery); use read replicas dedicated to analytical workloads; implement pre-aggregation via materialized views or ETL pipelines. Vertical scaling here treats a symptom (CPU saturation) rather than the cause (wrong tool for the workload).

4. Questions before approving:
   - What is causing the CPU utilization — is it a specific query, endpoint, or a general load problem? (A profiler answer, not a hardware answer)
   - Is the CPU usage uniform over time or are there spikes? (Spikes may be addressable with caching or async processing)
   - What is the growth trajectory? Will a 32-core machine be adequate in 6 months, or will we be back in the same position?
   - Is the application CPU-bound, or are there upstream bottlenecks (database, external APIs) that will become the new ceiling after this upgrade?
   - What is the availability impact if this server fails? Has a move to horizontal scaling been evaluated for HA as well as capacity?
   - What is the cost difference, and have we evaluated whether this spend should go toward a distributed architecture instead?

---

### Horizontal Scaling

**Theory**

Horizontal scaling (also called "scaling out") means adding more machines to distribute the load, rather than making a single machine more powerful.

Each machine in a horizontally scaled fleet is typically identical (or near-identical), running the same application code. A load balancer distributes incoming traffic across the pool.

This approach underpins the architecture of almost every large-scale system: web tiers, microservices, distributed databases, and distributed caches all rely on horizontal scaling.

**Key requirements for horizontal scaling to work:**

1. **Statelessness** — application servers must not store user session state locally. State must live in a shared store (database, Redis, etc.) so any server can handle any request.
2. **Load balancing** — a mechanism must exist to distribute traffic across servers. Common strategies: round-robin, least-connections, IP hash, consistent hashing.
3. **Shared data layer** — all servers must read from and write to the same underlying data stores.
4. **Service discovery** — servers must be able to find each other (critical in auto-scaling environments where IPs change dynamically).

**Comparing vertical and horizontal scaling:**

| Dimension               | Vertical Scaling            | Horizontal Scaling                       |
|-------------------------|-----------------------------|------------------------------------------|
| Complexity              | Low                         | High                                     |
| Physical ceiling        | Yes (hardware limits)       | No (add more machines)                   |
| Fault tolerance         | Single point of failure     | Fault tolerant (redundant nodes)         |
| Downtime for scaling    | Often yes                   | No (add nodes without downtime)          |
| Cost model              | Non-linear at high end      | Linear (each unit adds proportional cost)|
| Code changes required   | No                          | Yes (statelessness, distributed-awareness)|
| Data consistency        | Easy (single machine)       | Harder (distributed consistency needed) |

**Example**

```python
# Stateless vs Stateful request handling

# WRONG: Stateful server — stores session in memory
# This BREAKS horizontal scaling: user must always hit the same server
class StatefulServer:
    def __init__(self):
        self.sessions = {}  # in-memory — not shared across servers

    def login(self, user_id: str, token: str):
        self.sessions[user_id] = token  # stored locally

    def is_authenticated(self, user_id: str, token: str) -> bool:
        return self.sessions.get(user_id) == token  # fails on a different server


# CORRECT: Stateless server — session lives in shared Redis
import redis

class StatelessServer:
    def __init__(self):
        self.cache = redis.Redis(host="redis-cluster", port=6379)

    def login(self, user_id: str, token: str):
        # Store in Redis — any server can read this
        self.cache.setex(f"session:{user_id}", 3600, token)

    def is_authenticated(self, user_id: str, token: str) -> bool:
        stored = self.cache.get(f"session:{user_id}")
        return stored is not None and stored.decode() == token
```

> **Exercises**
>
> 1. (Beginner) Explain, using an analogy, the difference between vertical and horizontal scaling.
>
> 2. (Beginner) What does it mean for an application server to be "stateless," and why is statelessness a prerequisite for horizontal scaling?
>
> 3. (Intermediate) Your team's application stores user cart data in local server memory to avoid database round-trips. The application needs to be horizontally scaled to 10 servers. What problem will users experience, and how would you fix it?
>    - *Hint: Think about what happens when two consecutive requests from the same user land on different servers.*
>
> 4. (Intermediate/Interview) A company's API layer is horizontally scaled to 20 servers behind a round-robin load balancer. Some endpoints are computationally expensive (they generate PDF reports). Users report that report generation is slow and sometimes times out. How would you redesign this?
>    - *Hint: Not all servers have to run the same code. Consider what "horizontal scaling" means at the service level.*

**Answers**

1. Analogy: Imagine a single bank teller (vertical scaling = hiring a faster, more experienced teller). Eventually, even the fastest teller has limits. Horizontal scaling is opening more teller windows and having customers queue for any available teller. The bank can serve far more customers simultaneously, and if one teller goes home sick, the others continue working.

2. A stateless server does not retain any per-user information between requests — every request arrives with all the context the server needs, or the server fetches context from a shared store. Without statelessness, horizontal scaling breaks because a user's second request may land on a different server, which has no record of their first request (e.g., login session, shopping cart). Statelessness allows any server in the fleet to handle any request interchangeably.

3. Users will experience cart data disappearing or resetting between pages. If a user adds an item to their cart and the request hits Server 3, that data is in Server 3's memory. Their next request (e.g., viewing the cart) may hit Server 7, which has no record of the item — the cart appears empty. Fix: move cart state out of local server memory and into a shared data store (e.g., Redis for fast access, or a database for persistence). All 10 servers then read and write to the same store, making the application stateless.

4. The problem is that CPU-heavy PDF generation competes with low-latency API requests on the same servers. Redesign:
   - **Decouple PDF generation** into a separate worker service that runs on dedicated, compute-optimized instances. The API server receives the report request, enqueues a job to a message queue (e.g., SQS, RabbitMQ), and immediately returns a "job accepted" response with a job ID.
   - The worker pool polls the queue, generates PDFs independently, stores them in object storage (e.g., S3), and updates the job status in a database.
   - The client polls or uses a webhook to retrieve the result when ready.
   - This pattern (async task queue) means expensive work no longer blocks API server threads, and the worker pool can be independently scaled based on queue depth.

---

### Elasticity and Auto-scaling

**Theory**

Vertical and horizontal scaling describe *how* to scale. Elasticity describes the system's *ability to scale automatically* in response to changing demand — adding resources when load increases and releasing them when load decreases.

Auto-scaling policies typically monitor one or more metrics and trigger scaling actions when thresholds are crossed:

- **Reactive scaling** — scale after a metric crosses a threshold (e.g., CPU > 70% for 5 minutes → add a server). Simple but introduces a lag.
- **Predictive scaling** — use historical patterns to scale ahead of anticipated load (e.g., scale up every weekday at 8am). Reduces lag but requires accurate forecasts.
- **Scheduled scaling** — manually define scale-up/down times. Useful for known events (product launches, sale events).

**Key concepts:**

| Term                   | Definition                                                                 |
|------------------------|----------------------------------------------------------------------------|
| Scale-out event        | Adding instances to the pool in response to increased load                 |
| Scale-in event         | Removing instances from the pool as load decreases                         |
| Cooldown period        | Minimum time between successive scaling actions (prevents thrashing)        |
| Scale-up lag           | Time from when scaling is triggered to when new instances are healthy       |
| Minimum capacity       | The floor — always keep at least N instances running                        |
| Maximum capacity       | The ceiling — never scale beyond M instances (cost/safety guardrail)        |

**The danger of thrashing:** if the cooldown period is too short, the system may oscillate — adding a server, then removing it, then adding it again — wasting resources and introducing instability. Cooldowns force stability between actions.

**Example**

```
Auto-scaling policy (AWS EC2 Auto Scaling Group, conceptually):

Metric:      Average CPU utilization across the fleet
Scale-out:   If avg CPU > 65% for 3 consecutive minutes -> add 2 instances
Scale-in:    If avg CPU < 30% for 10 consecutive minutes -> remove 1 instance
Cooldown:    300 seconds after any scale action (no new action for 5 minutes)
Min:         2 instances (always keep 2 running for redundancy)
Max:         50 instances (cost guardrail)

Timeline example:
  09:00 - Load increases, avg CPU rises to 70%
  09:03 - Scale-out triggers, 2 instances added (fleet: 4 -> 6)
  09:08 - CPU stabilizes at 55% with 6 instances
  09:13 - Cooldown expires. CPU still 55%, no action.
  11:00 - Load drops, avg CPU falls to 20%
  11:10 - Scale-in triggers, 1 instance removed (fleet: 6 -> 5)
  11:15 - Cooldown expires. CPU 22%, still below 30%
  11:25 - Scale-in triggers again (fleet: 5 -> 4)
```

> **Exercises**
>
> 1. (Beginner) What is the difference between manual horizontal scaling and auto-scaling? In what scenarios is auto-scaling most valuable?
>
> 2. (Beginner) What is "scale-up lag" and why does it matter? How can a system be designed to minimize the impact of lag during sudden traffic spikes?
>
> 3. (Intermediate) An e-commerce platform has stable weekday traffic but experiences 10x traffic spikes every Friday at noon (a weekly flash sale). Design an auto-scaling strategy that handles this pattern efficiently. What combination of scaling types would you use?
>    - *Hint: Reactive scaling alone will not respond fast enough for a sudden 10x spike. Consider what you know in advance.*
>
> 4. (Intermediate/Interview) Your team deploys auto-scaling for your API servers. During an incident, you observe that servers are being added and removed every 2 minutes, causing repeated deployment overhead and brief service disruptions. What is happening, and how do you fix it?
>    - *Hint: This is a specific, named failure mode in auto-scaling systems.*

**Answers**

1. Manual horizontal scaling requires a human to recognize load trends, decide to add capacity, and execute the provisioning. Auto-scaling automates this entire loop based on metrics. Auto-scaling is most valuable when: traffic patterns are unpredictable or have high variance; the system must maintain cost efficiency (scale in during low traffic); response time to load changes is critical; the team cannot manually monitor and act 24/7.

2. Scale-up lag is the delay between when a scaling event is triggered and when the new instances are healthy and serving traffic (includes boot time, application initialization, health checks, and load balancer registration). This can be 2–10 minutes in typical cloud environments. To minimize impact: maintain a warm minimum fleet above the baseline (so burst absorption is immediate); use pre-warmed AMIs or container images with short startup times; implement predictive/scheduled scaling to add capacity before anticipated spikes; design application startup to be as fast as possible (lazy initialization of non-critical components).

3. Strategy for weekly flash sale spikes:
   - **Scheduled scaling**: 30 minutes before noon on Fridays, pre-scale to 80% of the estimated peak fleet. This eliminates scale-up lag for the predictable spike.
   - **Reactive scaling**: Keep a sensitive reactive policy active to handle variance in actual vs. forecasted load (the sale may be bigger or smaller than expected).
   - **Scale-in**: After the sale window (say, 2 hours), use a conservative reactive scale-in to wind down. Do not scale in too aggressively immediately after the peak, in case stragglers continue purchasing.
   - **Load testing**: Validate the system can handle 10x by running load tests before the event; do not discover capacity limits during the sale.

4. This is called "auto-scaling thrashing." It occurs when the cooldown period is too short relative to how quickly the metric fluctuates. The system scales out (CPU drops), then scales in (CPU rises again), then out again — in a rapid loop. Fix: increase the cooldown period so the fleet has time to stabilize after each scaling event before the next action is evaluated. Also review thresholds — if the scale-out and scale-in thresholds are too close together (e.g., scale out at 60%, scale in at 55%), any metric noise will trigger constant oscillation; widen the band (e.g., scale out at 70%, scale in at 30%).

---

### Scalability Bottlenecks

**Theory**

A bottleneck is the component in a system that limits the throughput of the entire system, regardless of how much capacity exists elsewhere. This is a direct application of Amdahl's Law: the speedup of a system is limited by the fraction of the system that cannot be parallelized or scaled.

Even a perfectly horizontally scalable application tier is useless if it overwhelms a single database that cannot scale.

**Common bottleneck categories:**

| Category              | Examples                                                            | Symptoms                                      |
|-----------------------|---------------------------------------------------------------------|-----------------------------------------------|
| Database              | Single-node write DB, unindexed queries, lock contention            | High DB CPU/latency, queue depth growing       |
| Network               | Saturated uplink, chatty protocols, large payload sizes             | High network utilization, packet loss           |
| CPU                   | Unoptimized computation, synchronous blocking work                  | High CPU utilization, request queuing          |
| Memory                | Memory leaks, insufficient heap, GC pressure                        | High memory utilization, GC pauses, OOM kills |
| I/O                   | Disk-bound operations, synchronous file reads, unindexed DB scans   | High I/O wait, slow disk metrics               |
| Concurrency           | Thread pool exhaustion, lock contention, synchronization overhead   | High thread counts, deadlocks, timeouts        |
| External dependencies | Slow third-party APIs, rate-limited services                        | High outbound latency, cascading timeouts      |

**How to find a bottleneck:**

1. **Measure, do not guess** — use profiling, APM tools, and resource metrics before assuming the cause
2. **Load test incrementally** — find the point at which the first resource saturates
3. **Follow the slowest dependency** — trace a slow request end-to-end and identify where time is spent
4. **Address bottlenecks one at a time** — fixing one often reveals the next

**Example**

```
System under load test: API service + PostgreSQL database

Observations at 5,000 RPS:
  App server CPU:   45%   (headroom exists)
  App server RAM:   60%   (headroom exists)
  DB CPU:           98%   ← BOTTLENECK
  DB I/O wait:      high
  DB active queries: 200+ (connection pool exhausted)
  API p99 latency:  8,000ms

Diagnosis:
  The application tier has spare capacity but the database is saturated.
  Adding more app servers would make this WORSE (more DB connections, more load).

Actions to try in order:
  1. Add a read cache (Redis) for frequently-read, rarely-changed data
  2. Add read replicas and route read queries to them
  3. Audit and optimize slow queries (add missing indexes)
  4. Consider database sharding if write load is the bottleneck
```

```sql
-- Example: detecting a missing index that causes a bottleneck
-- Slow query (full table scan on a 100M row table):
SELECT * FROM orders WHERE customer_id = 12345;
-- EXPLAIN shows: Seq Scan on orders  (cost=0.00..2100000.00 rows=1 ...)

-- Adding an index:
CREATE INDEX CONCURRENTLY idx_orders_customer_id ON orders(customer_id);

-- After index: EXPLAIN shows: Index Scan using idx_orders_customer_id
-- Query time drops from ~800ms to ~1ms
```

> **Exercises**
>
> 1. (Beginner) What is a bottleneck in the context of system scalability? Use a real-world analogy to explain why fixing non-bottleneck components does not improve overall throughput.
>
> 2. (Beginner) A web application is slow. The team upgrades the application servers from 8-core to 32-core instances. Performance does not improve. What might explain this, and what should they investigate next?
>
> 3. (Intermediate) A microservices system processes an order through 5 sequential services: Auth (5ms), Inventory (10ms), Pricing (8ms), Payment (200ms), Notification (15ms). What is the system's end-to-end latency? Which service is the bottleneck? How would you reduce end-to-end latency?
>    - *Hint: Identify which services are on the critical path and which could be moved off it.*
>
> 4. (Intermediate/Interview) Your distributed system is handling 10,000 writes/second through a message queue into a database. You notice that as you add more consumers, throughput stops increasing beyond 3,000 writes/second. Where is the bottleneck and how do you investigate?
>    - *Hint: Consider the full write path: queue consumer -> processing -> database write. Check each segment.*

**Answers**

1. A bottleneck is the component with the lowest capacity in a pipeline — all other components are limited by it regardless of their own capacity. Analogy: a factory production line where one station can only process 100 units/hour while all others can process 500/hour. Adding workers to the faster stations does nothing — the 100-unit station is still the constraint. To increase the factory's output, you must address that single station. This is Amdahl's Law applied to systems.

2. If upgrading the application servers did not improve performance, the bottleneck is not the application server CPU/compute — it lies elsewhere. Likely culprits: the database (check CPU, I/O, slow queries, connection pool limits), a downstream external API (network latency, rate limiting), the network between components, or the load balancer itself. The team should examine distributed traces or APM data to identify where time is being spent in the request lifecycle, then measure metrics at the database and network layer before drawing further conclusions.

3. End-to-end latency: 5 + 10 + 8 + 200 + 15 = **238ms**. The Payment service (200ms) is the dominant bottleneck — it accounts for 84% of total latency. The Notification service (15ms) can be moved off the critical path entirely: fire it asynchronously after the order is confirmed (put a message on a queue). This brings the critical path to 5 + 10 + 8 + 200 = 223ms. To reduce Payment latency: investigate what the Payment service is doing (external payment gateway call? consider caching, connection reuse, or an async pre-authorization pattern). Inventory and Pricing could potentially be parallelized after Auth, reducing their combined contribution to max(10, 8) = 10ms, bringing the total to ~215ms.

4. Bottleneck investigation with throughput ceiling at 3,000 writes/sec despite more consumers:
   - The plateau indicates that adding consumers is no longer the constraint. Measure each segment:
     - **Consumer processing time**: is each consumer CPU-bound during message processing? If not, this is not the bottleneck.
     - **Database write throughput**: run `SHOW STATUS LIKE 'Innodb_rows_inserted'` (MySQL) or equivalent. If writes are at 3,000/sec and CPU/I/O are saturated, the database is the bottleneck.
     - **Lock contention**: check for lock waits. If all consumers write to the same table without proper partitioning, row-level or page-level locks may be serializing writes.
     - **Connection pool saturation**: check whether the DB connection pool is exhausted; consumers may be queuing for connections.
     - Resolution paths: shard the database by a natural partition key (e.g., user ID mod N); use batched inserts (each consumer accumulates 100 rows and inserts in one statement — reducing per-row overhead); switch to a write-optimized database engine (e.g., Cassandra for append-heavy workloads).

---

## 1.3 Reliability and Availability

A system that is fast but frequently unavailable or loses data is not production-ready. This subchapter covers the formal frameworks and engineering patterns used to define and achieve reliability — the property that a system does what it is supposed to do, consistently and durably.

---

### SLA, SLO, and SLI

**Theory**

These three acronyms define the contract between a service provider and its users, and the internal engineering targets used to meet that contract.

**SLI (Service Level Indicator)** — a specific, measurable metric that reflects an aspect of service health. It is the *raw measurement*. Examples: request success rate, latency at the 99th percentile, data durability over 12 months.

**SLO (Service Level Objective)** — an internal *target* for an SLI. It defines what "good" looks like. Example: "99.9% of requests must complete successfully within 200ms." SLOs are owned by engineering teams.

**SLA (Service Level Agreement)** — a formal *contract* with external customers or stakeholders that specifies consequences (financial penalties, credits, remediation) if service levels are not met. SLAs are typically set below SLOs to provide a buffer. Example: "We guarantee 99.5% uptime; below this, customers receive service credits."

The relationship:

```
SLI (measurement) --> compared against --> SLO (target) --> enforced by --> SLA (contract)

If your SLI (actual uptime) is 99.92% and your SLO is 99.9%, you are meeting the objective.
Your SLA promises 99.5%, so you are well within the contractual guarantee.
```

**Error budget** — the allowed fraction of failure implied by an SLO. It operationalizes the trade-off between reliability and velocity:

```
SLO:          99.9% availability over 30 days
Error budget: 100% - 99.9% = 0.1% = 43.8 minutes of allowed downtime per month

If you have consumed 40 minutes of downtime this month:
  -> You have 3.8 minutes of error budget remaining
  -> This should trigger a freeze on risky deployments until next month

If you have consumed only 2 minutes:
  -> You have ample budget for experimentation and fast releases
```

**Common SLI examples by category:**

| Service Type   | Common SLIs                                                       |
|----------------|-------------------------------------------------------------------|
| Web API        | Request success rate, p99 latency, error rate                     |
| Storage        | Write durability (data not lost), read availability, write latency|
| Streaming      | End-to-end delivery latency, message loss rate                    |
| Batch jobs     | Job completion rate, execution time within SLO window             |

> **Exercises**
>
> 1. (Beginner) Define SLI, SLO, and SLA in your own words. What is the key difference between an SLO and an SLA?
>
> 2. (Beginner) A cloud storage provider offers an SLA of 99.9% monthly uptime. How many minutes of downtime per month does this allow? What about 99.99%?
>
> 3. (Intermediate) Your team's API has an SLO of 99.95% success rate and 150ms p99 latency over a rolling 28-day window. In the last 28 days, your monitoring shows: 99.96% success rate, 180ms p99 latency. Which SLO is in compliance? What actions should you take for the one that is not?
>    - *Hint: Calculate error budget consumption for both. An SLO breach requires an incident response and root cause analysis.*
>
> 4. (Intermediate/Interview) An engineering team wants to set an SLO of 99.9999% (six nines) availability for their internal analytics dashboard. As a reliability engineer, how would you respond? What factors would you consider when setting an SLO?
>    - *Hint: SLOs should reflect user needs and be achievable. Consider the cost of achieving each additional "nine."*

**Answers**

1. SLI: the actual measurement — what you observe in production (e.g., the fraction of requests that succeeded this minute). SLO: the target you set for an SLI — the internal definition of acceptable performance (e.g., success rate must stay above 99.9%). SLA: the external contract that includes consequences for failure (e.g., if uptime falls below 99.5%, customers receive a 10% service credit). The key difference between SLO and SLA: SLOs are internal engineering targets (no contractual penalty for breaching them, though there should be engineering response); SLAs are legally/contractually binding commitments to customers.

2. Monthly uptime calculations (assuming 30-day month = 43,200 minutes):
   - 99.9% = 0.1% downtime = 43,200 * 0.001 = **43.2 minutes/month**
   - 99.99% = 0.01% downtime = 43,200 * 0.0001 = **4.32 minutes/month**

3. Success rate SLO: 99.96% actual vs. 99.95% target → **in compliance** (actual exceeds target).
   Latency SLO: 180ms p99 actual vs. 150ms p99 target → **breached** (actual exceeds limit). Actions for the latency breach: trigger a post-incident review to identify what changed in the last 28 days; identify queries, upstream dependencies, or deployment changes that may have degraded p99; implement a fix; freeze new risky deployments until the SLO is restored; update alerting to catch this earlier in the next cycle.

4. Six nines (99.9999%) means approximately 31 seconds of allowed downtime per year. This is an unrealistic and unnecessarily costly target for an internal analytics dashboard. Factors to consider: (a) **User impact** — what happens if the dashboard is down for 5 minutes? For analytics, the answer is likely "inconvenience," not "revenue loss" or "safety risk." (b) **Cost** — each additional nine of availability typically requires exponentially more redundancy, complexity, and operational effort. (c) **Achievability** — even the most reliable infrastructure (AWS, GCP) does not guarantee six nines at the infrastructure level; building above it is extremely difficult. (d) **Appropriate targets** — an internal dashboard should have an SLO of perhaps 99.5% to 99.9%, not 99.9999%. Reserve high SLOs for systems where downtime has direct financial, safety, or regulatory consequences (e.g., payment processing, life-critical systems).

---

### Fault Tolerance

**Theory**

Fault tolerance is the property of a system that allows it to continue operating correctly (or degrade gracefully) in the presence of component failures.

The key insight is that failures are not exceptional events — they are inevitable. In large distributed systems, some component is always failing. The question is not *if* failures will occur, but *how the system responds* when they do.

**The spectrum of failure responses:**

```
Full outage         Graceful degradation         Full operation
     |---------------------------|---------------------------|
   Worst                    Acceptable                    Best
```

A fault-tolerant system aims to stay as close to "full operation" as possible, and when it cannot, it degrades gracefully (partial functionality) rather than failing completely.

**Core fault tolerance patterns:**

| Pattern                  | Description                                                                                     |
|--------------------------|-------------------------------------------------------------------------------------------------|
| Redundancy               | Run multiple copies of a component; if one fails, others continue                               |
| Failover                 | Automatically switch to a backup component when the primary fails                               |
| Circuit Breaker          | Stop calling a failing dependency to prevent cascading failures; retry after a cool-off period  |
| Retry with backoff       | Retry failed operations with increasing delays (exponential backoff + jitter)                   |
| Bulkhead                 | Isolate components so failure in one does not propagate to others                               |
| Timeout                  | Never wait indefinitely for a response; fail fast and handle the failure                        |
| Health checks            | Continuously probe components; remove unhealthy ones from the serving pool                      |

**Example: Circuit Breaker**

```python
import time
from enum import Enum

class CircuitState(Enum):
    CLOSED = "CLOSED"      # Normal: requests pass through
    OPEN = "OPEN"          # Failing: requests are blocked immediately
    HALF_OPEN = "HALF_OPEN"  # Testing: allow one request to probe recovery

class CircuitBreaker:
    def __init__(self, failure_threshold=5, recovery_timeout=30):
        self.failure_threshold = failure_threshold  # failures before opening
        self.recovery_timeout = recovery_timeout    # seconds before retrying
        self.failure_count = 0
        self.state = CircuitState.CLOSED
        self.last_failure_time = None

    def call(self, func, *args, **kwargs):
        if self.state == CircuitState.OPEN:
            # Check if recovery timeout has elapsed
            if time.time() - self.last_failure_time > self.recovery_timeout:
                self.state = CircuitState.HALF_OPEN  # Allow one probe request
            else:
                raise Exception("Circuit is OPEN — fast failing, not calling dependency")

        try:
            result = func(*args, **kwargs)
            self._on_success()
            return result
        except Exception as e:
            self._on_failure()
            raise e

    def _on_success(self):
        self.failure_count = 0
        self.state = CircuitState.CLOSED  # Reset on success

    def _on_failure(self):
        self.failure_count += 1
        self.last_failure_time = time.time()
        if self.failure_count >= self.failure_threshold:
            self.state = CircuitState.OPEN  # Trip the breaker
```

> **Exercises**
>
> 1. (Beginner) What is the difference between fault tolerance and fault prevention? Why is fault tolerance necessary even in well-engineered systems?
>
> 2. (Beginner) Explain the circuit breaker pattern using an analogy from everyday life. What are its three states and what transition triggers each?
>
> 3. (Intermediate) A payment service calls an external fraud detection API on every transaction. The fraud API occasionally becomes slow (latency spikes from 50ms to 10s). Without fault tolerance, what happens to the payment service? Design a fault-tolerant integration using at least two patterns.
>    - *Hint: Consider what a timeout alone achieves, and what additional protection the circuit breaker adds.*
>
> 4. (Intermediate/Interview) Design a fault-tolerant job scheduling system that runs daily data processing jobs. What happens if a job fails midway? If the scheduling node itself fails? How does the system recover?
>    - *Hint: Think about idempotency, checkpointing, and leader election.*

**Answers**

1. Fault prevention attempts to eliminate the conditions that cause failures (e.g., rigorous testing, code review, redundant power supplies). Fault tolerance accepts that failures will occur despite prevention efforts and focuses on designing the system to survive them. Fault tolerance is necessary because: hardware fails (disks, network cards, power supplies); software has bugs that only manifest under specific conditions; external dependencies are outside your control; human error causes misconfigurations. At the scale of large distributed systems, the probability of at least one component failing at any given time approaches 1.

2. Analogy: a circuit breaker in your home's electrical panel. When too much current flows through a circuit (representing too many failures), the breaker trips (opens), cutting power to prevent damage. You cannot use that circuit until you manually reset it. After some investigation, you reset the breaker (half-open) and see if the problem is resolved.
   - **Closed**: normal operation, requests pass through.
   - **Open**: triggered by exceeding the failure threshold; all requests fail fast without calling the dependency.
   - **Half-Open**: after the recovery timeout, one probe request is allowed through. Success → return to Closed. Failure → return to Open.

3. Without fault tolerance: slow fraud API responses hold threads/connections open for up to 10 seconds each. If 100 requests/second arrive and each blocks for 10s, the thread pool (say, 50 threads) is exhausted within 5 seconds. The payment service stops processing all transactions, not just those awaiting fraud checks — cascading failure.
   - **Timeout**: set a strict timeout on fraud API calls (e.g., 300ms). If exceeded, either allow the transaction through (with a flag for manual review) or reject it. This prevents thread exhaustion but still causes elevated error rates when the API is slow.
   - **Circuit Breaker**: after N consecutive timeouts/failures, trip the breaker. All subsequent fraud check requests fast-fail immediately (return a default response: allow with flag, or reject). This protects the payment service completely while the fraud API recovers. After the recovery window, probe again.
   - Combined: the timeout prevents individual requests from blocking too long; the circuit breaker prevents repeated attempts when the service is clearly degraded.

4. Fault-tolerant job scheduling:
   - **Idempotent job execution**: design each job to be re-runnable without duplicating effects (e.g., use upserts instead of inserts, process records with a processed flag). This means a job can be safely retried after a midway failure.
   - **Checkpointing**: the job writes progress to durable storage at regular intervals (e.g., "processed 500,000 of 2,000,000 records"). On restart, it reads the checkpoint and resumes from the last saved position rather than starting over.
   - **Scheduling node failure**: use a distributed lock or leader election (e.g., via ZooKeeper, etcd, or a database-backed lock) to ensure only one scheduling node is active at a time. If the primary scheduler fails, a standby node detects the lost heartbeat and acquires the lock, becoming the new leader.
   - **Job state machine**: track each job's state (PENDING, RUNNING, SUCCEEDED, FAILED) in a database. A watchdog process detects RUNNING jobs whose heartbeat has expired (indicating the worker died) and requeues them.
   - **At-least-once delivery**: accept that a job may run more than once (e.g., if the worker dies after completing work but before marking the job SUCCEEDED). Idempotency ensures this is safe.

---

### High Availability Patterns

**Theory**

High availability (HA) refers to the architectural design of systems to minimize downtime and ensure continuous operation despite component failures. It is achieved through redundancy, automatic failover, and eliminating single points of failure (SPOFs).

A **Single Point of Failure** is any component whose failure would cause the entire system to become unavailable. Identifying and eliminating SPOFs is the first step in designing for HA.

**Core HA patterns:**

**Active-Active**: Multiple identical instances are all actively serving traffic simultaneously. If one fails, the others absorb its load. Highest availability; requires all nodes to be in sync or stateless.

**Active-Passive**: One primary instance serves all traffic; one or more standby instances are ready to take over if the primary fails. Simpler than active-active but introduces failover lag.

**Multi-region deployment**: Replicate the system across geographically separate data centers or cloud regions. Provides resilience against region-level failures (natural disasters, regional outages).

```
Active-Active Architecture:
                          +------------+
                          | Load       |
        Client ---------> | Balancer   |
                          +-----+------+
                                |
              +-----------------+-----------------+
              |                 |                 |
        +-----+-----+    +------+----+    +-------+---+
        | App Node 1|    | App Node 2|    | App Node 3|
        | (ACTIVE)  |    | (ACTIVE)  |    | (ACTIVE)  |
        +-----------+    +-----------+    +-----------+
              |                 |                 |
              +--------+--------+--------+--------+
                                |
                        +-------+-------+
                        | Shared DB     |
                        | (with replica)|
                        +---------------+


Active-Passive Architecture:
        Client ------> Load Balancer
                             |
                    +--------+--------+
                    |                 |
              +-----+-----+    +------+----+
              | Primary   |    | Standby   |
              | (ACTIVE)  |    | (PASSIVE) |
              +-----------+    +-----------+
                    |                 |
                    +--------+--------+
                         Replication
```

**The CAP Theorem** (brief introduction):
In a distributed system, you can only guarantee two of the following three properties simultaneously:
- **C**onsistency — every read returns the most recent write
- **A**vailability — every request receives a response (not an error)
- **P**artition tolerance — the system continues operating despite network partitions

In practice, network partitions are inevitable, so the real choice is between consistency and availability during a partition.

> **Exercises**
>
> 1. (Beginner) What is a single point of failure? Identify three potential SPOFs in a typical three-tier web architecture (load balancer, app servers, database).
>
> 2. (Beginner) What is the difference between active-active and active-passive high availability? In what situations would you prefer each?
>
> 3. (Intermediate) A company's primary database fails. With active-passive failover, the standby is promoted in 45 seconds. During those 45 seconds, all writes are rejected. Is this acceptable? What would you need to know to answer that question, and how could you reduce the failover time or the impact?
>    - *Hint: Consider the system's SLO, the nature of the writes, and whether writes can be buffered.*
>
> 4. (Intermediate/Interview) Design a high availability architecture for a payment processing API that must achieve 99.99% uptime. Identify all SPOFs in a naive design and describe how you would eliminate each.
>    - *Hint: Work layer by layer: DNS, load balancer, application, cache, database, message queue. Identify SPOF and its HA counterpart for each.*

**Answers**

1. A Single Point of Failure is any component whose failure causes the entire system to fail. In a three-tier architecture: (a) **Load balancer**: if there is only one load balancer, its failure means no traffic reaches the application tier. HA fix: use a pair of load balancers with a virtual IP that fails over between them. (b) **Database**: if there is a single database instance, its failure means all reads and writes fail. HA fix: primary-replica setup with automatic failover. (c) Application servers are typically already redundant (multiple nodes behind the load balancer) but become a SPOF if reduced to a single instance during aggressive scale-in.

2. Active-Active: all nodes serve traffic simultaneously; load is distributed; failover is instantaneous (surviving nodes absorb load without any switching logic). Best for stateless services (API servers, caches) where synchronizing state between nodes is straightforward. Active-Passive: one node serves traffic; the other is warm and ready but idle. Failover introduces a brief lag. Best for stateful systems where keeping multiple nodes in sync is complex or expensive (e.g., databases with a write leader, legacy systems that cannot be made stateless).

3. Whether 45 seconds of write rejection is acceptable depends on the SLO. For a 99.99% monthly SLO (~4.32 minutes/month allowed downtime), a single 45-second failover event consumes 17% of the monthly error budget — significant but survivable if rare. For a payment system, 45 seconds of write rejection is likely unacceptable from a user experience perspective even if the SLO math holds. To reduce impact: (a) Use write buffering — have the application layer queue writes during failover with idempotency keys, replaying them against the new primary once it is ready; (b) Use a distributed SQL database (e.g., CockroachDB, Aurora Global Database) with faster automatic failover (<10s); (c) Implement read-your-writes consistency patterns so users' in-flight transactions are not silently lost during failover.

4. Payment API HA architecture (layer by layer):
   - **DNS**: Single DNS record → SPOF. Fix: use a service with automatic DNS failover (e.g., Route 53 health checks with failover routing) across two regions.
   - **Load balancer**: Single LB → SPOF. Fix: deploy an LB pair in active-active or active-passive with a floating IP. Cloud-managed LBs (ALB, GCP Load Balancer) are inherently HA.
   - **Application servers**: Single instance → SPOF. Fix: deploy minimum 2 instances in an auto-scaling group across 2+ availability zones.
   - **Cache (e.g., Redis)**: Single cache node → SPOF. Fix: Redis Cluster or Redis Sentinel for automatic failover.
   - **Database**: Single primary → SPOF. Fix: synchronous replication to a standby in a different AZ; automated failover (e.g., Aurora Multi-AZ, PostgreSQL Patroni). For 99.99%, synchronous replication is required to prevent data loss on failover.
   - **Message queue** (if used for async processing): Single queue node → SPOF. Fix: use a managed, replicated queue service (e.g., AWS SQS, Kafka with replication factor ≥ 3).
   - **Multi-region**: for 99.99%, a single-region deployment is risky (regional outages do occur). Implement active-passive multi-region with automated DNS failover for the ultimate reliability tier.

---

### Mean Time to Recovery (MTTR)

**Theory**

Mean Time to Recovery (MTTR) measures the average time it takes to restore a system to normal operation after a failure. It encompasses the full timeline: detection, diagnosis, remediation, and verification.

MTTR is a lagging indicator of your incident response process. A low MTTR means your team detects failures quickly and can fix them fast. A high MTTR means failures have prolonged impact on users.

**MTTR components:**

```
Failure occurs
      |
      v
[Detection time]    <-- How long before anyone knows something is wrong?
      |                 (Depends on alerting and monitoring quality)
      v
[Diagnosis time]    <-- How long to identify the root cause?
      |                 (Depends on observability: logs, traces, metrics)
      v
[Remediation time]  <-- How long to fix or mitigate?
      |                 (Depends on runbooks, tooling, access, automation)
      v
[Verification time] <-- How long to confirm normal operation is restored?
      |                 (Depends on monitoring and smoke tests)
      v
System restored
      |
MTTR = Sum of all above durations, averaged over incidents
```

**How to reduce MTTR:**

| Component          | Reduction Strategy                                                   |
|--------------------|----------------------------------------------------------------------|
| Detection time     | Proactive alerting on SLIs, synthetic monitoring, anomaly detection  |
| Diagnosis time     | Structured logging, distributed tracing, runbooks, dashboards        |
| Remediation time   | Automated rollbacks, feature flags, runbook automation, on-call drills|
| Verification time  | Automated smoke tests post-deployment, SLI dashboards               |

**MTTR vs. availability:**

```
Availability ≈ MTBF / (MTBF + MTTR)

Where:
  MTBF = Mean Time Between Failures

Example:
  MTBF = 720 hours (failures every 30 days on average)
  MTTR = 1 hour
  Availability = 720 / (720 + 1) = 99.86%

  If MTTR is reduced to 0.1 hours (6 minutes):
  Availability = 720 / (720 + 0.1) = 99.986%

Reducing MTTR has a significant and direct impact on availability.
```

> **Exercises**
>
> 1. (Beginner) What does MTTR measure? List the four phases of an incident that contribute to MTTR.
>
> 2. (Beginner) A system has an MTBF of 200 hours and an MTTR of 4 hours. What is its availability? What would the availability be if MTTR were reduced to 30 minutes?
>
> 3. (Intermediate) Your team's MTTR for database incidents is averaging 90 minutes. A postmortem analysis reveals that 60 of those 90 minutes are spent diagnosing the root cause. What specific investments would you make to reduce the diagnosis phase?
>    - *Hint: Think about observability tooling, runbooks, and what information an on-call engineer needs at 3am.*
>
> 4. (Intermediate/Interview) Describe the relationship between MTTR, deployment frequency, and system availability. Why do teams that deploy frequently often have lower MTTR?
>    - *Hint: Consider what changes about familiarity, tooling, and blast radius as deployment frequency increases.*

**Answers**

1. MTTR measures the average time from when a failure begins to when the system is fully restored to normal operation. The four phases: (1) Detection — the time from failure occurrence to when the team is aware of it; (2) Diagnosis — the time to identify the root cause; (3) Remediation — the time to implement a fix or mitigation; (4) Verification — the time to confirm the system is healthy and the incident is resolved.

2. Availability with MTTR = 4 hours: 200 / (200 + 4) = **98.04%**.
   Availability with MTTR = 0.5 hours: 200 / (200 + 0.5) = **99.75%**. Reducing MTTR from 4 hours to 30 minutes improves availability by 1.71 percentage points — a substantial improvement achieved purely by faster response, with no change to reliability (MTBF).

3. Investments to reduce 60-minute diagnosis phase:
   - **Structured logging with correlation IDs**: ensure every log line includes a trace ID, service name, and environment. This enables reconstructing the full request path during an incident.
   - **Distributed tracing** (e.g., Jaeger, Datadog APM): allows the on-call engineer to see exactly where in the call chain time was spent and where errors originated.
   - **Pre-built incident dashboards**: a dashboard showing database connection pool utilization, slow query counts, replication lag, and lock waits — all in one view — eliminates the need to manually query each metric.
   - **Runbooks**: documented, step-by-step guides for common failure modes (e.g., "replication lag > 30s: check these five things in this order"). A well-maintained runbook can reduce diagnosis from 60 minutes to 5 minutes for known failure types.
   - **Alert enrichment**: alerts should include context (recent deployments, current traffic levels, affected services) rather than just "database CPU high."

4. Teams that deploy frequently tend to have lower MTTR for several reasons: (a) **Smaller blast radius**: frequent deployments mean each change is small. When something breaks, the change set to investigate is narrow, dramatically reducing diagnosis time. (b) **Familiarity with tooling**: teams that deploy daily have well-practiced deployment and rollback procedures. Rolling back becomes a routine action rather than a stressful, error-prone event. (c) **Better automation**: high deployment frequency forces investment in automated testing, deployment pipelines, and rollback mechanisms — all of which reduce remediation time. (d) **Fresher on-call knowledge**: engineers who deploy frequently are more familiar with recent changes and can correlate an incident to a deployment immediately. The inverse is also true: infrequent deployments often correlate with large, complex changes, longer diagnosis times, and manual rollback procedures — all of which increase MTTR.

---

### Mean Time Between Failures (MTBF)

**Theory**

Mean Time Between Failures (MTBF) measures the average time a system operates correctly between failures. It is a measure of reliability: how often does the system fail?

While MTTR measures how quickly you recover, MTBF measures how often you need to. A high MTBF means failures are rare; a low MTBF means the system fails frequently.

**Calculating MTBF:**

```
MTBF = Total operational time / Number of failures

Example:
  A service runs for 1,000 hours and fails 5 times:
  MTBF = 1,000 / 5 = 200 hours between failures on average
```

**MTBF vs. MTTR — the two levers of availability:**

```
Availability = MTBF / (MTBF + MTTR)

To increase availability, you can:
  1. Increase MTBF (make the system more reliable — fail less often)
  2. Decrease MTTR (make the system more recoverable — recover faster)

These are complementary, not competing strategies.
```

**Reliability strategies to improve MTBF:**

| Strategy                      | How it improves MTBF                                                 |
|-------------------------------|----------------------------------------------------------------------|
| Thorough testing              | Catches defects before production, reducing failure frequency        |
| Canary deployments            | Expose new code to a small fraction of traffic before full rollout   |
| Feature flags                 | Enable/disable features without deployment; instant rollback         |
| Chaos engineering             | Deliberately inject failures to find weaknesses before they manifest |
| Dependency hardening          | Reduce reliance on flaky external dependencies                       |
| Hardware redundancy           | RAID storage, redundant power, multi-path networking                 |

**Bathtub curve** — a well-known reliability model from hardware engineering:

```
Failure
Rate
  |
  |  \                               /
  |    \                           /
  |      \______________________ /
  |
  +-----+----------+----------+-------> Time
     Infant     Normal       Wear-out
     mortality  operation    phase
     phase      (low MTBF)

Infant mortality: early failures due to defects (software: early bugs in new features)
Normal operation: stable, rare failures
Wear-out phase:   increasing failures as components age (software: technical debt)
```

> **Exercises**
>
> 1. (Beginner) What does MTBF measure? How does it differ conceptually from MTTR?
>
> 2. (Beginner) A server has failed 3 times in the past 900 hours of operation. Calculate its MTBF. Using the availability formula, what is its availability if MTTR is 2 hours?
>
> 3. (Intermediate) Your team is choosing between two reliability improvement initiatives: (A) Invest in better monitoring and runbooks to reduce MTTR from 60 minutes to 15 minutes; (B) Invest in integration testing and canary deployments to increase MTBF from 300 hours to 600 hours. If current MTTR is 60 minutes (1 hour), which initiative has a greater impact on availability?
>    - *Hint: Calculate availability under each scenario using Availability = MTBF / (MTBF + MTTR) and compare.*
>
> 4. (Intermediate/Interview) Explain chaos engineering. How does deliberately introducing failures into a production system improve MTBF? What guardrails are necessary before a team starts practicing chaos engineering?
>    - *Hint: Consider what chaos engineering reveals that conventional testing cannot. Also consider what could go wrong without guardrails.*

**Answers**

1. MTBF measures the average time a system operates between failures — it is a frequency-of-failure metric (reliability). MTTR measures the average time to restore service after a failure — it is a recovery-speed metric. MTBF answers "how often does the system break?"; MTTR answers "how quickly can we fix it when it does?"

2. MTBF = 900 hours / 3 failures = **300 hours**.
   Availability = 300 / (300 + 2) = 300 / 302 = **99.34%**.

3. Availability calculations:
   - Baseline: MTBF=300h, MTTR=1h → 300 / 301 = **99.67%**
   - Option A (reduce MTTR to 0.25h): 300 / (300 + 0.25) = 300 / 300.25 = **99.92%**
   - Option B (increase MTBF to 600h): 600 / (600 + 1) = 600 / 601 = **99.83%**
   - **Option A** has greater impact (99.92% vs 99.83%). This is a useful general principle: when MTBF is already reasonably high and MTTR is a significant fraction of the total, reducing MTTR has a disproportionate impact on availability. The result may differ with different baselines, so always calculate both.

4. Chaos engineering is the practice of deliberately injecting failures (killing processes, introducing network latency, dropping packets, terminating instances) into a system — typically in production or a production-like environment — to discover weaknesses before they manifest as unplanned outages. It improves MTBF by: (a) revealing hidden SPOFs and incorrect assumptions about how the system handles failures (e.g., assuming a retry mechanism works correctly when it has a bug); (b) validating that redundancy and failover mechanisms actually function as designed; (c) building team confidence and familiarity with the system's failure modes.
   Guardrails required before practicing chaos engineering: (1) **Observability**: you must be able to detect and measure the impact of injected failures — without good monitoring, you may cause real user harm without knowing it; (2) **On-call readiness**: someone must be available to halt the experiment if it causes more damage than expected; (3) **Defined steady state**: agree on what normal looks like (e.g., 99.9% success rate) so you can detect deviation; (4) **Blast radius limiting**: start with small, targeted experiments (kill one instance, not the whole fleet); (5) **Rollback mechanism**: all injected failures must be fully reversible.

# Chapter 2: Networking and Communication

Modern software rarely runs in isolation. Whether a mobile app fetches user data, a microservice emits an event, or a browser streams a video, every meaningful system depends on structured communication between components. This chapter covers the full stack of that communication — from the low-level protocols that move bytes reliably across networks, to the API design patterns that make those bytes meaningful, to the architectural patterns that govern how systems talk to each other at scale. Mastering these concepts is foundational to building systems that are fast, resilient, and maintainable.

---

## 2.1 Network Protocols

A protocol is a formal agreement about how communication happens — what format data takes, how errors are handled, and how connections are established and torn down. Without protocols, two machines exchanging bytes would have no shared understanding of what those bytes mean. This section covers the core protocols you will encounter in backend and distributed systems work.

---

### TCP vs UDP

#### Theory

To understand TCP and UDP, start with the problem they both solve: the internet is an unreliable network. Packets can be dropped, arrive out of order, or get duplicated. The two transport-layer protocols represent two different philosophies for dealing with this.

**TCP (Transmission Control Protocol)** is the cautious, reliable choice. Before any data is sent, TCP performs a *three-way handshake* to establish a connection:

```
Client ──── SYN ────────────────────> Server
Client <─── SYN-ACK ─────────────── Server
Client ──── ACK ────────────────────> Server
(Connection established)
```

After the handshake, TCP guarantees:
- **Ordered delivery**: packets are reassembled in the correct sequence.
- **Reliability**: lost packets are retransmitted automatically.
- **Flow control**: the sender does not overwhelm the receiver.
- **Congestion control**: the sender backs off when the network is saturated.

This safety comes at a cost: latency. Each acknowledgment and retransmission adds round trips.

**UDP (User Datagram Protocol)** takes the opposite stance. It sends packets (datagrams) with no handshake, no acknowledgment, and no ordering guarantee. It is "fire and forget." If a packet is lost, UDP does not care — the application must decide what to do.

| Feature | TCP | UDP |
|---|---|---|
| Connection setup | Three-way handshake | None |
| Reliability | Guaranteed, retransmits lost packets | Best-effort, no retransmission |
| Ordering | Preserved | Not guaranteed |
| Speed | Slower (overhead) | Faster (minimal overhead) |
| Use cases | HTTP, email, file transfer | DNS, video streaming, gaming, VoIP |
| Header size | 20–60 bytes | 8 bytes |

**Analogy**: TCP is a certified letter — the post office confirms delivery and will resend if lost. UDP is a postcard — it is sent and forgotten; if it gets lost, that is acceptable.

UDP is not "worse" than TCP — it is a deliberate trade-off. In real-time audio/video, a retransmitted packet that arrives 500ms late is useless. It is better to drop it and move on.

#### Example

```python
# TCP server (Python) — reliable, connection-oriented
import socket

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # SOCK_STREAM = TCP
server.bind(('localhost', 9000))
server.listen(1)

conn, addr = server.accept()          # blocks until a client connects
data = conn.recv(1024)                # receive up to 1024 bytes
conn.sendall(b'ACK: ' + data)         # guaranteed delivery
conn.close()
```

```python
# UDP server (Python) — fast, connectionless
import socket

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # SOCK_DGRAM = UDP
server.bind(('localhost', 9001))

data, addr = server.recvfrom(1024)    # no connection state, just read datagrams
server.sendto(b'Got it', addr)        # send reply, no guarantee it arrives
```

> Exercises
>
> 1. (Beginner) A video conferencing app drops a single audio frame. Should the app use TCP to retransmit it, or accept the loss and move on? Explain why.
> 2. (Beginner) What are the three messages exchanged during a TCP handshake, and what does each one signal?
> 3. (Intermediate) A multiplayer game server needs to broadcast the positions of 50 players to all clients 60 times per second. Which protocol would you choose? What does the application layer need to handle that the protocol does not?
> 4. (Interview) Explain why HTTP/1.1 (built on TCP) can suffer from "head-of-line blocking," and why UDP-based protocols like QUIC were designed partly to address this. *(Hint: think about what happens when a single TCP packet is lost in a multi-request scenario.)*

> Answers
>
> 1. Accept the loss and move on. The audio frame, if retransmitted, would arrive too late to be played in sequence, causing worse perceptual quality than a brief gap. Real-time applications prioritize low latency over completeness.
> 2. SYN (client initiates, proposes sequence number), SYN-ACK (server acknowledges and proposes its own sequence number), ACK (client acknowledges the server's sequence number). The handshake synchronizes sequence numbers so both sides can track ordering and detect loss.
> 3. UDP. At 60 updates/second with 50 players, latency matters far more than guaranteed delivery — a stale position packet is worse than a missing one. The application layer must handle sequence numbers (to discard out-of-order packets), client-side interpolation to smooth gaps, and its own loss detection if needed.
> 4. In HTTP/1.1 over TCP, a single connection processes requests in order. If packet #5 is lost, TCP stalls all subsequent data on that connection until packet #5 is retransmitted and acknowledged — even if later packets have already arrived. This blocks all multiplexed streams. QUIC runs over UDP and implements multiplexing at the application layer, so a lost packet for stream A does not block data delivery for stream B.

---

### HTTP/1.1 vs HTTP/2 vs HTTP/3

#### Theory

HTTP (HyperText Transfer Protocol) is the application-layer protocol underlying the web. Each version addresses the performance bottlenecks of its predecessor.

**HTTP/1.1** (1997) introduced persistent connections (keep-alive), so a single TCP connection could serve multiple requests. However, responses must arrive in order — if you make 6 requests over one connection, you must wait for request 1 to complete before receiving the response for request 2. This is *head-of-line blocking*. Browsers work around it by opening up to 6 parallel TCP connections per domain.

**HTTP/2** (2015) introduced *multiplexing*: multiple requests and responses can be in flight simultaneously over a single TCP connection, interleaved as binary frames. Each stream is independent at the HTTP layer. HTTP/2 also introduced:
- **Header compression** (HPACK): headers are encoded using a shared compression dictionary, reducing overhead for repeated values like `Authorization` or `Content-Type`.
- **Server push**: the server can proactively send resources the client will likely need.
- **Binary framing**: messages are binary, not text, making parsing faster and more robust.

However, HTTP/2 still runs over TCP. A single dropped TCP packet blocks all HTTP/2 streams on that connection — moving the head-of-line blocking problem from HTTP down to the transport layer.

**HTTP/3** (2022) solves this by replacing TCP with **QUIC**, a protocol built on UDP. QUIC implements its own reliability, ordering, and congestion control *per stream*, so a lost packet for one stream never blocks another. QUIC also combines the TLS handshake with the connection handshake, reducing connection setup from 2–3 round trips (TCP + TLS) to 1 (or even 0 for repeat connections via 0-RTT).

```
Connection latency comparison (cold start):

HTTP/1.1 + TLS 1.2:  TCP SYN/ACK (1 RTT) + TLS handshake (2 RTT) = 3 RTT
HTTP/2   + TLS 1.3:  TCP SYN/ACK (1 RTT) + TLS 1.3 handshake (1 RTT) = 2 RTT
HTTP/3   (QUIC+TLS): QUIC+TLS combined (1 RTT), or 0-RTT for known servers
```

| Feature | HTTP/1.1 | HTTP/2 | HTTP/3 |
|---|---|---|---|
| Multiplexing | No (pipelining unreliable) | Yes, over TCP | Yes, over QUIC/UDP |
| Head-of-line blocking | At HTTP layer | At TCP layer | Eliminated |
| Header compression | None | HPACK | QPACK |
| Transport | TCP | TCP | QUIC (UDP-based) |
| TLS | Optional | Effectively required | Mandatory (built into QUIC) |
| Connection migration | No | No | Yes (QUIC connection ID) |

**Connection migration** is a notable HTTP/3 advantage: a mobile client that switches from Wi-Fi to cellular keeps its QUIC connection alive (identified by a connection ID), whereas a TCP connection is tied to an IP/port tuple and breaks on network change.

#### Example

```javascript
// Checking the protocol in a Node.js HTTPS server
const https = require('https');
const fs = require('fs');

const server = https.createServer({
  key: fs.readFileSync('key.pem'),
  cert: fs.readFileSync('cert.pem'),
});

server.on('request', (req, res) => {
  // httpVersion is '1.1' or '2.0' depending on the client
  console.log(`Protocol: HTTP/${req.httpVersion}`);
  res.end('Hello');
});
```

```
HTTP/2 multiplexed streams over a single connection:

Connection (one TCP connection)
│
├── Stream 1: GET /index.html ──────> [frames interleaved]
├── Stream 3: GET /style.css  ──────> [frames interleaved]
├── Stream 5: GET /app.js     ──────> [frames interleaved]
└── Stream 7: GET /logo.png   ──────> [frames interleaved]

All responses arrive concurrently, in any order.
```

> Exercises
>
> 1. (Beginner) Name two concrete improvements HTTP/2 made over HTTP/1.1 and explain why each matters for web performance.
> 2. (Beginner) Why does HTTP/3 use UDP instead of TCP? What does QUIC add on top of UDP to compensate for UDP's lack of reliability?
> 3. (Intermediate) A single-page application loads 40 small JavaScript modules. Estimate the performance difference between HTTP/1.1 and HTTP/2 for this workload, and explain your reasoning.
> 4. (Interview) A client connects to a server over HTTP/2, and a single TCP packet is dropped. Which streams are affected? How does HTTP/3 improve this? *(Hint: think about what TCP does when a packet is lost.)*

> Answers
>
> 1. **Multiplexing**: multiple requests can be in-flight simultaneously over one connection, eliminating the need for browsers to open 6 parallel TCP connections per domain. **Header compression (HPACK)**: repeated headers (e.g., `Cookie`, `Authorization`) are transmitted as short dictionary references rather than full strings, reducing per-request overhead — important on high-latency mobile networks.
> 2. TCP's reliable, ordered delivery causes head-of-line blocking at the transport layer in HTTP/2: a single lost TCP packet stalls all HTTP/2 streams. QUIC is built on UDP (which has no ordering guarantees) and implements its own per-stream reliability — a lost packet for stream A does not delay stream B. QUIC adds: reliable delivery per stream, congestion control, flow control, and integrated TLS 1.3.
> 3. HTTP/1.1 opens at most 6 parallel connections per origin; 40 modules would require 7 serial "rounds," adding multiple RTTs of latency. HTTP/2 multiplexes all 40 requests over one connection in a single round trip, dramatically reducing total load time. The actual speedup depends on bandwidth and server processing time, but for many small files over a high-latency network, HTTP/2 can be 3–5x faster.
> 4. All streams are affected. TCP treats the connection as a single ordered byte stream; when packet N is lost, TCP stalls delivery of all subsequent data (even if later packets arrived) until packet N is retransmitted and acknowledged. HTTP/3 (QUIC) solves this because streams are independent at the QUIC layer — a lost packet belongs to exactly one stream, and only that stream waits for retransmission. All other streams continue receiving data uninterrupted.

---

### WebSockets

#### Theory

HTTP is inherently a request-response protocol: the client initiates every exchange. This is fine for fetching resources, but awkward for real-time use cases — chat, live dashboards, collaborative editing — where the *server* needs to push data to the client unprompted.

WebSockets solve this by upgrading an HTTP connection into a persistent, full-duplex (bidirectional) channel. The upgrade happens over standard HTTP, making it firewall-friendly:

```
Client ──── HTTP GET /chat
            Upgrade: websocket
            Connection: Upgrade ────> Server

Server <─── 101 Switching Protocols ─ Server
            (TCP connection stays open, now a WebSocket)

Client <──────────── data ──────────> Server  (bidirectional, any time)
```

Once the handshake completes (HTTP 101), both sides can send *frames* at any time. The WebSocket protocol defines small binary frames with a 2–10 byte header, making it far lighter than polling-based alternatives.

Key characteristics:
- **Full-duplex**: client and server can send simultaneously.
- **Low overhead**: no HTTP headers on each message after the initial handshake.
- **Stateful**: the connection persists; the server tracks connected clients.
- **Not HTTP after handshake**: operates at a lower level, directly over TCP.

WebSockets introduce operational complexity: load balancers must handle sticky sessions or shared state (e.g., via Redis pub/sub), and horizontal scaling requires routing messages to the correct server node.

#### Example

```javascript
// Server (Node.js with the 'ws' library)
const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', (ws) => {
  console.log('Client connected');

  ws.on('message', (message) => {
    // Echo the message back to all connected clients
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(`Broadcast: ${message}`);  // push without waiting for a request
      }
    });
  });

  ws.on('close', () => console.log('Client disconnected'));
});
```

```javascript
// Client (browser)
const ws = new WebSocket('ws://localhost:8080');

ws.onopen = () => ws.send('Hello, server!');

ws.onmessage = (event) => {
  console.log('Received:', event.data);   // server-initiated push
};

ws.onerror = (err) => console.error('WebSocket error:', err);
```

> Exercises
>
> 1. (Beginner) What HTTP status code signals a successful WebSocket upgrade? What does it mean?
> 2. (Beginner) Name two real-world applications where WebSockets are a better fit than traditional HTTP polling. Justify each choice.
> 3. (Intermediate) A collaborative text editor uses WebSockets. The backend runs three server instances behind a load balancer. User A (on server 1) edits a document that User B (on server 2) is viewing. How do you ensure User B receives User A's changes? Describe one concrete solution.
> 4. (Interview) Compare WebSockets and Server-Sent Events (SSE) for a live sports score ticker. Which would you choose and why? *(Hint: consider directionality, browser support, and reconnection behavior.)*

> Answers
>
> 1. HTTP 101 Switching Protocols. It means the server has accepted the upgrade request and the connection is no longer HTTP — both sides switch to the WebSocket protocol for all subsequent communication over the same TCP connection.
> 2. **Online chat**: messages must be delivered to recipients immediately without them polling; the server needs to push. **Live sports score dashboards**: score updates originate on the server; polling at 1-second intervals wastes bandwidth and adds unnecessary latency compared to a pushed update on each score change.
> 3. Use a **shared pub/sub broker** (e.g., Redis Pub/Sub or a message queue). When User A sends an edit, server 1 publishes the change to a Redis channel keyed by the document ID. All server instances subscribe to that channel; server 2 receives the published message and pushes it to User B's WebSocket connection.
> 4. SSE is the better fit here. Score updates are unidirectional (server to client only), which is exactly what SSE is designed for. SSE runs over plain HTTP/2, supports automatic reconnection natively in the browser, and is simpler to implement and proxy than WebSockets. WebSockets would be appropriate only if the client also needed to send data to the server (e.g., placing bets or chatting), which a score ticker does not require.

---

### gRPC and Protocol Buffers

#### Theory

REST APIs are convenient but carry significant overhead: JSON must be serialized and deserialized on every call, and field names are repeated as strings in every message. For internal service-to-service communication in a microservices architecture — where services may exchange millions of messages per day — this overhead adds up.

**Protocol Buffers (Protobuf)** are a language-neutral, binary serialization format developed by Google. Instead of sending `{"user_id": 42, "name": "Alice"}` as a 30-byte JSON string, Protobuf encodes the same data as a compact binary message (often 5–10 bytes) using a pre-agreed schema.

**gRPC** is an RPC (Remote Procedure Call) framework built on top of Protobuf and HTTP/2. Rather than designing endpoints and payloads manually, you define services and message types in a `.proto` file, and gRPC generates client and server code in your target language.

Advantages of gRPC:
- **Performance**: binary encoding is smaller and faster to parse than JSON.
- **Strong typing**: the `.proto` schema is the contract — mismatches are compile-time errors, not runtime surprises.
- **Streaming**: gRPC supports server-streaming, client-streaming, and bidirectional streaming natively over HTTP/2.
- **Code generation**: clients and stubs are generated automatically, reducing boilerplate.
- **Polyglot**: generated code is available in Go, Java, Python, C++, and many others.

Trade-offs:
- Not human-readable (binary format requires tooling to inspect).
- Browser support is limited (gRPC-Web is a workaround).
- Schema evolution requires discipline (field numbering in Protobuf).

```
JSON vs Protobuf for the same data:

JSON:    {"user_id": 42, "name": "Alice", "active": true}
         ~47 bytes (plus parsing time)

Protobuf: binary encoding
          ~7 bytes (field tags + varint-encoded values)
```

#### Example

```protobuf
// user.proto — the schema definition
syntax = "proto3";

package user;

// Define the request message
message GetUserRequest {
  int32 user_id = 1;   // field number 1 (used in binary encoding, not the value)
}

// Define the response message
message User {
  int32  user_id = 1;
  string name    = 2;
  bool   active  = 3;
}

// Define the service (generates both client stub and server interface)
service UserService {
  rpc GetUser (GetUserRequest) returns (User);
  rpc ListUsers (GetUserRequest) returns (stream User);  // server-streaming RPC
}
```

```python
# Server implementation (Python, generated stub used)
import grpc
from concurrent import futures
import user_pb2
import user_pb2_grpc   # auto-generated from user.proto

class UserServiceServicer(user_pb2_grpc.UserServiceServicer):

    def GetUser(self, request, context):
        # request.user_id is already typed as int — no JSON parsing needed
        return user_pb2.User(user_id=request.user_id, name="Alice", active=True)

    def ListUsers(self, request, context):
        # Generator — each yield sends one User message to the client
        for i in range(5):
            yield user_pb2.User(user_id=i, name=f"User {i}", active=True)

server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
user_pb2_grpc.add_UserServiceServicer_to_server(UserServiceServicer(), server)
server.add_insecure_port('[::]:50051')
server.start()
server.wait_for_termination()
```

> Exercises
>
> 1. (Beginner) What is the role of the `.proto` file in a gRPC system? What does it produce?
> 2. (Beginner) Why does Protobuf use field numbers (e.g., `= 1`, `= 2`) rather than field names in its binary encoding?
> 3. (Intermediate) You are designing a gRPC service for a file upload feature. The files can be up to 500MB. Which of the four gRPC streaming modes (unary, server-streaming, client-streaming, bidirectional) would you use? Why?
> 4. (Interview) A team argues that REST+JSON is "good enough" for internal microservice communication and gRPC is unnecessary complexity. What are the strongest arguments for and against adopting gRPC? When would you choose each? *(Hint: consider payload size, latency SLAs, schema evolution, and developer experience.)*

> Answers
>
> 1. The `.proto` file is the **service contract** — it defines message types and RPC method signatures in a language-neutral schema language. Running the `protoc` compiler against it generates: server-side interfaces (stubs the developer implements), client-side stubs (type-safe methods the caller invokes), and serialization/deserialization code — in any supported target language.
> 2. Field names are variable-length strings; including them in every serialized message would inflate size. Field numbers are integers encoded as compact varints (1–2 bytes for small values). This also enables backward compatibility: you can rename a field in the `.proto` without breaking existing serialized data, as long as the number stays the same.
> 3. **Client-streaming**. The client splits the file into chunks and streams them to the server as a sequence of messages; the server assembles the full file and returns a single response (e.g., a file ID or checksum). This avoids loading 500MB into a single request message, enables progress tracking, and allows the server to begin processing (e.g., hashing) before all chunks arrive.
> 4. **For gRPC**: binary Protobuf is 5–10x smaller than JSON and faster to parse (important at high RPC rates); the generated client stubs enforce the API contract at compile time, eliminating whole classes of integration bugs; HTTP/2 multiplexing reduces connection overhead; streaming support is first-class. **For REST+JSON**: universally understood, human-readable, easy to test with `curl`, no build step, excellent browser and proxy support, and simpler for teams with limited distributed systems experience. **Choose gRPC** when: services are high-throughput, latency-sensitive, polyglot, or need streaming. **Choose REST** when: services are customer-facing, need browser access, or the team values operational simplicity over performance.

---

### DNS and How It Works

#### Theory

When you type `www.example.com` into a browser, your computer has no idea which IP address that maps to. DNS (Domain Name System) is the distributed, hierarchical system that translates human-readable hostnames into IP addresses — the phone book of the internet.

The resolution process involves several actors:

1. **Recursive Resolver** (your ISP or Google's 8.8.8.8): receives your query and does the heavy lifting of traversing the hierarchy.
2. **Root Name Servers** (13 sets, worldwide): know the authoritative servers for top-level domains (.com, .org, .io, etc.).
3. **TLD Name Servers**: know the authoritative servers for each second-level domain (e.g., `example.com`).
4. **Authoritative Name Server**: holds the actual DNS records for the domain.

```
DNS Resolution for "www.example.com":

Your Computer
    │
    │ 1. Query: www.example.com?
    ▼
Recursive Resolver (e.g., 8.8.8.8)
    │
    │ 2. Ask Root: who handles .com?
    ▼
Root Name Server ──> "Ask the .com TLD server at 192.5.6.30"
    │
    │ 3. Ask .com TLD: who handles example.com?
    ▼
.com TLD Server ──> "Ask ns1.example.com at 205.251.196.1"
    │
    │ 4. Ask authoritative server: what is www.example.com?
    ▼
Authoritative NS ──> "93.184.216.34"
    │
    │ 5. Return: www.example.com = 93.184.216.34 (cached for TTL seconds)
    ▼
Your Computer ──> connects to 93.184.216.34
```

**Caching** is critical to DNS performance. Every record has a **TTL (Time To Live)** in seconds. The recursive resolver caches the answer; subsequent queries for the same name are resolved locally until the TTL expires. This is why DNS changes can take time to propagate — clients are serving cached records.

Common DNS record types:

| Record | Purpose | Example |
|---|---|---|
| A | Maps hostname to IPv4 address | `example.com -> 93.184.216.34` |
| AAAA | Maps hostname to IPv6 address | `example.com -> 2606:2800::1` |
| CNAME | Alias to another hostname | `www.example.com -> example.com` |
| MX | Mail server for domain | `example.com -> mail.example.com` |
| TXT | Arbitrary text (SPF, DKIM, verification) | `"v=spf1 include:..."` |
| NS | Authoritative name servers for domain | `example.com -> ns1.example.com` |
| PTR | Reverse lookup (IP to hostname) | `34.216.184.93.in-addr.arpa -> example.com` |

#### Example

```bash
# Query A records for a domain
dig example.com A

# Trace the full resolution path step-by-step
dig +trace example.com

# Query with a specific resolver (Google's public DNS)
dig @8.8.8.8 example.com

# Reverse DNS lookup
dig -x 93.184.216.34

# Check the TTL remaining on a cached record
dig example.com A | grep -i ttl
```

```
Sample dig output (simplified):

;; ANSWER SECTION:
example.com.    86400   IN   A   93.184.216.34
                ^^^^^
                TTL: this record is cached for 86400 seconds (1 day)
```

> Exercises
>
> 1. (Beginner) What is a DNS TTL, and why does lowering it before a planned IP change make sense?
> 2. (Beginner) What is the difference between an A record and a CNAME record? When would you use a CNAME instead of an A record?
> 3. (Intermediate) You update a DNS A record from `1.2.3.4` to `5.6.7.8`. Some users continue hitting the old IP for up to 24 hours. Explain why, and describe one operational strategy to minimize this window in the future.
> 4. (Interview) What happens if a recursive resolver's cache is poisoned — i.e., it stores a forged record mapping `bank.com` to an attacker's IP? What protocol extension was designed to prevent this, and how does it work? *(Hint: look up DNSSEC.)*

> Answers
>
> 1. TTL is the number of seconds a DNS record may be cached by resolvers and clients before they must re-query the authoritative server. Lowering it before a planned change (e.g., to 300 seconds) means cached copies expire quickly. After the IP change propagates, the blast radius of clients still hitting the old IP is small and clears within minutes rather than hours.
> 2. An **A record** maps a hostname directly to an IPv4 address. A **CNAME** maps a hostname to another hostname (an alias), which is then resolved further. Use CNAME when you want multiple hostnames to resolve to the same target without duplicating the IP — e.g., `www.example.com CNAME example.com` means changing the A record of `example.com` automatically updates `www` too. You cannot use a CNAME on the zone apex (bare domain, e.g., `example.com` itself) — only on subdomains.
> 3. The 24-hour window equals the TTL of the old record. Resolvers cached the record when TTL was high and continue serving it until expiry. To minimize future propagation delay: lower the TTL to a small value (e.g., 300s) 48 hours before any planned change, perform the change, then raise TTL again after confirming propagation. This ensures the maximum propagation window is 5 minutes rather than 24 hours.
> 4. DNS cache poisoning allows an attacker to serve malicious IP mappings from a poisoned recursive resolver, redirecting users to phishing or malware sites. **DNSSEC (DNS Security Extensions)** prevents this by adding cryptographic signatures to DNS records. Each DNS zone signs its records with a private key; resolvers verify signatures using a chain of trust anchored at the root zone. A forged record would lack a valid signature and be rejected. DNSSEC does not encrypt DNS data — it only authenticates it. Note: adoption remains incomplete, and DNS-over-HTTPS (DoH) or DNS-over-TLS (DoT) address privacy (encryption), but not authenticity — that remains DNSSEC's job.

---

## 2.2 API Design

An API (Application Programming Interface) is the contract between a service and its consumers. Good API design makes systems easier to understand, integrate, and evolve. Poor API design leaks implementation details, breaks clients on every change, and becomes a maintenance burden. This section covers the dominant styles and operational patterns that govern real-world API design.

---

### REST API Principles

#### Theory

REST (Representational State Transfer) is an architectural style for designing networked APIs, formalized by Roy Fielding in his 2000 dissertation. It is not a protocol or standard — it is a set of six constraints. APIs that satisfy these constraints are called "RESTful."

The core constraints relevant to web API design are:

1. **Stateless**: each request must contain all information needed to process it. The server stores no session state between requests. Authentication (e.g., a JWT) travels with every request.
2. **Uniform Interface**: resources are identified by URIs; interactions use standard HTTP methods.
3. **Client-Server**: the client and server are separate concerns; they evolve independently.
4. **Cacheable**: responses should indicate whether they are cacheable.
5. **Layered System**: the client does not know (or care) whether it is talking to the origin server or a proxy/CDN.

In practice, REST APIs are designed around **resources** (nouns) exposed through URLs, manipulated using HTTP methods (verbs):

| HTTP Method | Meaning | Example |
|---|---|---|
| GET | Read a resource | `GET /users/42` |
| POST | Create a new resource | `POST /users` |
| PUT | Replace a resource entirely | `PUT /users/42` |
| PATCH | Partially update a resource | `PATCH /users/42` |
| DELETE | Remove a resource | `DELETE /users/42` |

URL design principles:
- Use **nouns**, not verbs: `/users`, not `/getUsers`.
- Use **plural nouns**: `/users/42`, not `/user/42`.
- Use **nesting for relationships**: `/users/42/orders`, not `/getUserOrders?user_id=42`.
- Keep URLs **lowercase** and use hyphens for readability: `/blog-posts`, not `/blogPosts`.

**HTTP status codes** are part of the contract:

| Code | Meaning | When to use |
|---|---|---|
| 200 | OK | Successful GET, PUT, PATCH |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE |
| 400 | Bad Request | Client sent invalid data |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Authenticated but lacks permission |
| 404 | Not Found | Resource does not exist |
| 409 | Conflict | State conflict (duplicate, optimistic lock) |
| 422 | Unprocessable Entity | Validation failed |
| 500 | Internal Server Error | Server-side bug |

#### Example

```
RESTful resource hierarchy for an order management system:

GET    /orders              → list all orders (paginated)
POST   /orders              → create a new order
GET    /orders/{id}         → get a specific order
PUT    /orders/{id}         → replace an order
PATCH  /orders/{id}         → update order status only
DELETE /orders/{id}         → cancel/delete an order

GET    /orders/{id}/items   → list items in a specific order
POST   /orders/{id}/items   → add an item to an order
DELETE /orders/{id}/items/{itemId}  → remove a specific item
```

```python
# Flask REST API example
from flask import Flask, jsonify, request, abort

app = Flask(__name__)
users = {1: {"id": 1, "name": "Alice", "email": "alice@example.com"}}

@app.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user = users.get(user_id)
    if not user:
        abort(404)                      # return 404, not an empty 200
    return jsonify(user), 200

@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    if not data or 'name' not in data:
        abort(400)                      # client error, not server error
    new_id = max(users.keys()) + 1
    users[new_id] = {"id": new_id, **data}
    return jsonify(users[new_id]), 201  # 201 Created, not 200 OK

@app.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    if user_id not in users:
        abort(404)
    del users[user_id]
    return '', 204                      # 204 No Content on successful delete
```

> Exercises
>
> 1. (Beginner) A developer designs an endpoint `POST /deleteUser?id=5`. Identify two REST design violations and propose a corrected version.
> 2. (Beginner) What is the difference between a `401 Unauthorized` and a `403 Forbidden` response?
> 3. (Intermediate) Design the URL structure for a blogging platform with users, posts, and comments. Include at least one nested resource and one query parameter example.
> 4. (Interview) REST's statelessness constraint means the server stores no client session state. What are the performance and scalability implications of this constraint, and how do JWTs relate to it? *(Hint: consider what changes when you add a second server instance.)*

> Answers
>
> 1. Violations: (1) the endpoint uses a **verb** (`delete`) in the URL — REST uses HTTP methods as verbs, not URL segments; (2) the action is expressed as `POST` but it is a deletion — the correct method is `DELETE`. Corrected: `DELETE /users/5`.
> 2. `401 Unauthorized` means the request lacks valid credentials — the client is not identified (not logged in, or token is missing/expired). The client should authenticate and retry. `403 Forbidden` means the client is identified but is not allowed to perform the action — the resource exists but the caller lacks permission. Retrying with the same credentials will not help.
> 3. Structure: `GET /users/{id}`, `GET /users/{id}/posts` (posts by a user), `POST /users/{id}/posts` (create post), `GET /posts/{id}`, `GET /posts/{id}/comments`, `POST /posts/{id}/comments`. Query parameter: `GET /posts?author_id=42&status=published&page=2&limit=20` (filtering and pagination via query params, not path segments).
> 4. Statelessness means each request is self-contained. The server holds no session memory — no "who is logged in" state. This has two key implications: (1) **Scalability**: any server instance can handle any request; you can add servers without shared session storage. (2) **Performance trade-off**: the server cannot cache client state, so more information must travel in each request. JWTs embody this principle — they are self-contained tokens carrying the user's identity and claims, cryptographically signed so the server can verify them without a database lookup. Adding a second server instance requires no session sharing; both instances verify the JWT independently using the same secret/public key.

---

### GraphQL Basics

#### Theory

REST APIs are resource-centric: you have one endpoint per resource type, and the server decides what fields the response includes. This leads to two common problems:

- **Over-fetching**: you request `/users/42` and receive 20 fields, but only need 3.
- **Under-fetching**: you need user data, their posts, and their comments — requiring 3 separate requests.

**GraphQL** is a query language and runtime for APIs, developed by Facebook (2012, open-sourced 2015), that lets the *client* specify exactly what data it needs in a single request.

GraphQL exposes a single endpoint (usually `POST /graphql`) and accepts queries written in the GraphQL query language. The server executes the query against a typed schema and returns exactly the requested shape.

Core concepts:

- **Schema**: defines all types and the operations available. Acts as the API contract.
- **Query**: read operation (equivalent to GET).
- **Mutation**: write operation (equivalent to POST/PUT/DELETE).
- **Subscription**: real-time streaming (over WebSockets).
- **Resolver**: a function that fetches data for a specific field in the schema.

```
GraphQL vs REST for fetching a user's name and their latest 3 post titles:

REST (3 requests):
  GET /users/42           → 20 fields including name
  GET /users/42/posts     → all posts, all fields
  (client filters latest 3 and extracts title)

GraphQL (1 request, exact shape):
  POST /graphql
  {
    user(id: 42) {
      name
      posts(limit: 3, orderBy: CREATED_AT_DESC) {
        title
      }
    }
  }

Response:
  { "user": { "name": "Alice", "posts": [{"title": "..."}, ...] } }
```

Trade-offs of GraphQL:

| Advantage | Disadvantage |
|---|---|
| No over/under-fetching | Complexity of caching (no URL per query) |
| Single endpoint | N+1 query problem without DataLoader |
| Strongly typed schema | Learning curve for server and client teams |
| Self-documenting (introspection) | File uploads are non-standard |
| Evolve without versioning | Deeply nested queries can be expensive |

#### Example

```graphql
# Schema definition (SDL — Schema Definition Language)
type User {
  id:    ID!          # ! means non-nullable
  name:  String!
  email: String!
  posts: [Post!]!
}

type Post {
  id:      ID!
  title:   String!
  content: String!
  author:  User!
}

type Query {
  user(id: ID!): User        # returns null if not found
  posts: [Post!]!
}

type Mutation {
  createPost(title: String!, content: String!, authorId: ID!): Post!
}
```

```javascript
// Client query (fetch API)
const query = `
  query GetUser($userId: ID!) {
    user(id: $userId) {
      name
      posts {
        title
      }
    }
  }
`;

const response = await fetch('/graphql', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    query,
    variables: { userId: '42' }   // variables are typed and validated server-side
  })
});

const { data, errors } = await response.json();
// GraphQL always returns 200 OK; check the 'errors' field for application errors
```

> Exercises
>
> 1. (Beginner) Define over-fetching and under-fetching. Give a concrete example of each in a REST context.
> 2. (Beginner) In GraphQL, what is the difference between a Query, a Mutation, and a Subscription?
> 3. (Intermediate) Explain the N+1 problem in GraphQL. Given a query that fetches 10 posts and each post's author, describe how a naive resolver implementation causes N+1 database queries and how the DataLoader pattern solves it.
> 4. (Interview) A team is building a mobile app that serves multiple client types (iOS, Android, web) with different data requirements. What specific advantages does GraphQL offer over REST in this scenario? What risks would you need to manage? *(Hint: consider bandwidth, versioning, and query complexity.)*

> Answers
>
> 1. **Over-fetching**: `GET /users/42` returns a 20-field object (address, phone, preferences, etc.) when the client only needs `name` and `email` — wasted bandwidth and parsing. **Under-fetching**: a screen needs to display a user's profile alongside their 5 most recent posts — `GET /users/42` gives the profile but not the posts, requiring a second call to `GET /users/42/posts`.
> 2. A **Query** is a read-only operation — it fetches data without side effects. A **Mutation** modifies server-side state (create, update, delete) and returns the result. A **Subscription** establishes a persistent connection (typically WebSocket) and receives a stream of events as data changes — used for real-time features like live notifications.
> 3. N+1: a resolver for `posts` makes 1 DB query to fetch 10 posts. Then the `author` resolver is called once per post, each making a separate query — 10 additional queries. Total: 11 queries for data that could be fetched in 2. **DataLoader** batches and caches these: during a single execution tick, all 10 `author(id)` calls are collected, then a single batched query (`SELECT * FROM users WHERE id IN (1,2,...,10)`) fetches all authors at once. Results are cached per request to avoid redundancy.
> 4. **Advantages**: mobile clients on constrained networks can request minimal payloads (only the fields a screen needs); a single query can aggregate data from multiple resources, reducing round trips; different client types (iOS/Android/web) can request different shapes from the same endpoint without the backend maintaining multiple REST endpoints per client type; the schema provides a self-documenting contract; fields can be deprecated without versioning. **Risks to manage**: unbounded query depth/complexity must be limited (query depth limits, query cost analysis) to prevent expensive DB joins; caching is harder without URL-based cache keys (use persisted queries or client-side caching with Apollo/Relay); the N+1 problem requires DataLoader; the learning curve for resolver design and schema management is real.

---

### API Versioning Strategies

#### Theory

APIs evolve. New features are added, old endpoints become obsolete, and sometimes a breaking change is unavoidable. API versioning is the practice of managing these changes in a way that does not break existing clients.

A **breaking change** is any change that requires existing clients to update their code: removing a field, renaming a parameter, changing a response type, or altering authentication requirements.

A **non-breaking change** can be deployed without client updates: adding an optional field, adding a new endpoint, or relaxing a validation rule.

The four main versioning strategies:

**1. URI Versioning**
Version is embedded in the URL path. Simple, visible, cache-friendly.
```
GET /v1/users/42
GET /v2/users/42
```

**2. Query Parameter Versioning**
Version is a query parameter. Clean URLs but easy to forget.
```
GET /users/42?version=2
```

**3. Header Versioning**
Version is passed in a custom request header. Clean URLs, but non-obvious to consumers and not cacheable by default.
```
GET /users/42
X-API-Version: 2
```

**4. Media Type Versioning (Content Negotiation)**
Version is embedded in the `Accept` header. Most REST-compliant but complex.
```
GET /users/42
Accept: application/vnd.myapi.v2+json
```

| Strategy | Visibility | Cacheability | REST Purity | Ease of Use |
|---|---|---|---|---|
| URI | High | Easy | Low (URI = resource) | High |
| Query Param | Medium | Medium | Medium | Medium |
| Header | Low | Harder | High | Low |
| Media Type | Low | Harder | Highest | Low |

In practice, URI versioning dominates because of its simplicity, discoverability, and cache-friendliness, despite being the least "pure" REST approach.

#### Example

```
Version lifecycle management:

v1 (active, maintained):   /v1/users     — legacy clients still using it
v2 (current):              /v2/users     — current production version
v3 (beta):                 /v3/users     — next version in testing

Deprecation process:
1. Deploy v2 alongside v1 (never remove v1 immediately)
2. Set a deprecation date and communicate it via:
   - Response headers: Deprecation: Sat, 01 Jan 2026 00:00:00 GMT
   - Developer documentation
   - Email to registered API consumers
3. Monitor v1 traffic; reach out to teams still using it
4. Remove v1 only after traffic drops to zero (or a hard cutoff date passes)
```

```python
# Flask blueprint per version — clean separation of v1 and v2
from flask import Flask, Blueprint, jsonify

v1 = Blueprint('v1', __name__, url_prefix='/v1')
v2 = Blueprint('v2', __name__, url_prefix='/v2')

@v1.route('/users/<int:user_id>')
def get_user_v1(user_id):
    return jsonify({"id": user_id, "name": "Alice"})   # old format

@v2.route('/users/<int:user_id>')
def get_user_v2(user_id):
    # v2 adds a 'profile' nested object — a breaking change from v1
    return jsonify({"id": user_id, "profile": {"name": "Alice", "avatar": "..."}})

app = Flask(__name__)
app.register_blueprint(v1)
app.register_blueprint(v2)
```

> Exercises
>
> 1. (Beginner) What is a "breaking change" in an API? Give two examples of changes that are breaking and two that are non-breaking.
> 2. (Beginner) Compare URI versioning and header versioning. What are the practical advantages of URI versioning for API consumers and operators?
> 3. (Intermediate) Your team ships a public REST API at `GET /v1/users/{id}` that returns `{ "fullName": "Alice Smith" }`. You need to rename the field to `name` (a breaking change). Describe the full deprecation lifecycle you would follow without breaking existing clients.
> 4. (Interview) Some engineers argue that a well-designed API should never need versioning because it should be designed to evolve without breaking changes. Is this realistic? What design patterns help minimize the need for breaking changes? *(Hint: consider additive-only changes, field deprecation, and Postel's Law.)*

> Answers
>
> 1. A breaking change requires clients to update their code to avoid failure. **Breaking**: removing a required response field (clients parsing it will error); changing a field's type from string to integer. **Non-breaking**: adding a new optional field to a response (clients ignoring unknown fields are unaffected); adding a new optional query parameter; adding a new endpoint.
> 2. URI versioning embeds the version in the URL, making it immediately visible in logs, browser history, curl commands, and documentation. API consumers can test different versions simply by changing a URL. Caching infrastructure (CDNs, reverse proxies) can cache versioned URLs by path without custom configuration. Header versioning requires clients to set a custom header, which is invisible in browser address bars, harder to share as a link, and requires cache keys to include the header value.
> 3. Lifecycle: (1) Deploy v2 at `/v2/users/{id}` returning `{ "name": "Alice Smith" }`. (2) Update v1 to return **both fields**: `{ "fullName": "Alice Smith", "name": "Alice Smith" }` — this is additive and non-breaking. (3) Add a `Deprecation` response header to all v1 responses with the sunset date. Update documentation and notify consumers. (4) Monitor `/v1` usage via analytics; proactively contact teams still calling v1. (5) On the published sunset date, disable `/v1` (or return 410 Gone). (6) Remove `fullName` from the codebase in a subsequent cleanup.
> 4. Fully version-free evolution is aspirational but difficult at scale. It works well when you follow **additive-only changes** (never remove or rename; only add), **Postel's Law** ("be conservative in what you send, liberal in what you accept" — tolerate unknown fields gracefully), and **field deprecation markers** (mark fields as deprecated in docs/schema, giving consumers time to migrate before removal). However, true breaking changes — security fixes, removing insecure endpoints, fundamental redesigns — are sometimes unavoidable. The realistic goal is to minimize them through upfront design discipline and to manage them gracefully through versioning when they occur.

---

### Rate Limiting and Throttling

#### Theory

Public and internal APIs must be protected from abuse and overload. **Rate limiting** restricts how many requests a client can make in a given time window. **Throttling** is the broader concept of controlling resource consumption — rate limiting is one implementation of throttling.

Without rate limiting, a single misbehaving client (or a DDoS attack, or a buggy retry loop) can exhaust server resources and degrade service for all users.

Common rate limiting algorithms:

**1. Fixed Window Counter**
Count requests in a fixed time window (e.g., per minute). Simple, but vulnerable to burst attacks at window boundaries — a client can make 100 requests at 11:59:59 and 100 more at 12:00:00.

**2. Sliding Window Log**
Record a timestamp for each request; count how many fall within the last N seconds. Accurate, but memory-intensive at high request rates.

**3. Sliding Window Counter**
Interpolate between the current and previous window's count. More memory-efficient than the log, approximates sliding behavior.

**4. Token Bucket**
A bucket holds up to N tokens. Each request consumes one token. Tokens are added at a constant rate (e.g., 10/second). If the bucket is full, new tokens are discarded. If it is empty, requests are rejected. Allows bursting up to bucket capacity.

**5. Leaky Bucket**
Requests enter a queue (the bucket) and are processed at a constant rate. Smooths traffic into a uniform outflow but adds latency and drops requests when the bucket overflows.

| Algorithm | Burst Handling | Memory | Accuracy | Common Use |
|---|---|---|---|---|
| Fixed Window | Poor (boundary burst) | Low | Low | Simple counters |
| Sliding Window Log | Good | High | High | Precision-critical |
| Token Bucket | Good (controlled burst) | Low | Medium | Most API gateways |
| Leaky Bucket | Smoothed | Low | Medium | Streaming rate control |

Standard HTTP response headers for rate limit information:

```
HTTP/1.1 429 Too Many Requests
Retry-After: 30
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 0
X-RateLimit-Reset: 1704067260
```

#### Example

```python
# Token bucket rate limiter using Redis (Python + redis-py)
import time
import redis

r = redis.Redis()

def is_allowed(client_id: str, capacity: int = 10, refill_rate: float = 1.0) -> bool:
    """
    Returns True if request is allowed, False if rate limit exceeded.
    capacity:    max tokens in the bucket
    refill_rate: tokens added per second
    """
    key = f"ratelimit:{client_id}"
    now = time.time()

    pipe = r.pipeline()
    pipe.hgetall(key)
    tokens_data = pipe.execute()[0]

    if tokens_data:
        tokens = float(tokens_data[b'tokens'])
        last_refill = float(tokens_data[b'last_refill'])
        # Add tokens for time elapsed since last request
        elapsed = now - last_refill
        tokens = min(capacity, tokens + elapsed * refill_rate)
    else:
        tokens = capacity   # new client starts with a full bucket
        last_refill = now

    if tokens >= 1:
        tokens -= 1         # consume one token
        r.hset(key, mapping={'tokens': tokens, 'last_refill': now})
        r.expire(key, int(capacity / refill_rate) + 1)
        return True
    else:
        return False        # bucket empty, reject request
```

> Exercises
>
> 1. (Beginner) What HTTP status code should a server return when a client exceeds its rate limit? What header should indicate when the client can retry?
> 2. (Beginner) Explain the boundary burst problem with the fixed window algorithm. Give a concrete example with numbers.
> 3. (Intermediate) You are designing rate limiting for a multi-tenant SaaS API. You need to enforce per-user limits (100 requests/minute) and global limits (10,000 requests/minute total). How would you implement both layers simultaneously, and what data store would you use?
> 4. (Interview) A client's token bucket allows 100 requests/second with a burst capacity of 500 tokens. The client makes 0 requests for 10 seconds, then suddenly sends 1,000 requests. How many are allowed, and when can the client resume normal traffic? *(Hint: trace the token count step by step.)*

> Answers
>
> 1. **429 Too Many Requests**. The `Retry-After` header should specify either a number of seconds to wait or an HTTP date after which the client may retry. Clients should also receive `X-RateLimit-Limit`, `X-RateLimit-Remaining`, and `X-RateLimit-Reset` headers on every response so they can proactively throttle themselves before hitting the limit.
> 2. With a 100 req/minute fixed window, windows reset at :00 of each minute. A client sends 100 requests at 12:00:59 (last second of window 1) — allowed. The window resets at 12:01:00. The client immediately sends 100 more requests — also allowed. In under 2 seconds, the client made 200 requests: double the intended rate. A sliding window prevents this by looking back exactly 60 seconds from the current moment.
> 3. Use **Redis** (atomic operations, sub-millisecond latency, TTL support). Implement two counters per request: `ratelimit:user:{user_id}` (token bucket or sliding window, limit 100/min) and `ratelimit:global` (sliding window counter, limit 10,000/min). In a Lua script or Redis pipeline, decrement both atomically. Reject the request if either limit is exceeded. Returning the appropriate limit headers requires reading which counter triggered the rejection.
> 4. After 10 seconds of inactivity, the token bucket refills by `10s × 100 tokens/s = 1,000 tokens`, but is capped at the burst capacity of 500. So at the moment the burst arrives, the bucket holds exactly **500 tokens**. The first 500 requests are allowed immediately. The remaining 500 requests are rejected (429). After the burst, the bucket is at 0. Normal traffic (100 req/s) can resume as soon as tokens refill — within 1 second the client has 100 tokens again, so normal 100 req/s traffic resumes immediately in the next second.

---

### API Gateway Pattern

#### Theory

In a microservices architecture, a client might need to call a dozen backend services to render a single screen. Exposing all services directly to external clients creates serious problems: clients must know the addresses of all services, every service must independently implement authentication, rate limiting, and logging, and changing the internal service topology breaks clients.

The **API Gateway** is a single entry point that sits between external clients and internal services. It is the enforcement point for cross-cutting concerns.

```
Without API Gateway:
  Client ──> Auth Service  (direct call)
  Client ──> User Service  (direct call)
  Client ──> Order Service (direct call)
  Client ──> Product Service (direct call)

With API Gateway:
  Client ──> [API Gateway] ──> Auth Service
                           ──> User Service
                           ──> Order Service
                           ──> Product Service
```

Responsibilities of an API Gateway:

- **Authentication and Authorization**: validate JWTs or API keys before requests reach backend services.
- **Rate Limiting**: enforce per-client request quotas.
- **Request Routing**: route `/users/*` to the user service, `/orders/*` to the order service.
- **Load Balancing**: distribute traffic across service instances.
- **SSL Termination**: handle HTTPS externally; internal traffic can use plain HTTP.
- **Request/Response Transformation**: translate between client formats and internal formats.
- **Aggregation (Backend for Frontend)**: fan out to multiple services, aggregate results into a single response.
- **Observability**: centralized logging, metrics, and distributed tracing.

The **Backend for Frontend (BFF)** pattern is a specialized API Gateway variant: instead of one generic gateway, you maintain a separate gateway per client type (mobile, web, third-party). Each BFF is optimized for its client's data needs and interaction patterns.

```
BFF Pattern:

Mobile App ──> Mobile BFF  ──> User Service
                           ──> Notification Service

Web App    ──> Web BFF     ──> User Service
                           ──> Analytics Service

Third Party ──> Public API Gateway ──> (limited subset of services)
```

Trade-offs:

| Benefit | Risk |
|---|---|
| Single entry point simplifies clients | Single point of failure (must be HA) |
| Centralized cross-cutting concerns | Performance bottleneck if not scaled |
| Hides internal topology | Added network hop and latency |
| Enables independent service evolution | Risk of business logic creeping in |

> Exercises
>
> 1. (Beginner) What is the API Gateway pattern? List three cross-cutting concerns it centralizes.
> 2. (Beginner) What is the difference between an API Gateway and a load balancer?
> 3. (Intermediate) Your company has a mobile app, a web app, and a public developer API. Each has different rate limits, authentication requirements, and response shapes. How would the Backend for Frontend (BFF) pattern address these differences compared to a single generic gateway?
> 4. (Interview) An API Gateway is described as a "single point of failure." How would you architect a gateway deployment to ensure high availability and avoid this becoming an actual single point of failure? *(Hint: think about redundancy, health checks, and geographic distribution.)*

> Answers
>
> 1. The API Gateway pattern places a single service as the entry point for all external client requests to a microservices system. It centralizes: **authentication/authorization** (validate credentials once before any backend service sees the request), **rate limiting** (enforce quotas per client/API key), and **request routing** (map URL patterns to the appropriate backend service).
> 2. A **load balancer** distributes traffic across multiple instances of a *single service*, focusing on availability and capacity. It operates at L4 (TCP) or L7 (HTTP) but has no application-level awareness. An **API Gateway** routes traffic across *multiple different services* based on URL paths, headers, and business rules, and adds application-layer logic: auth, rate limiting, transformation, aggregation. API Gateways are often deployed behind a load balancer for redundancy.
> 3. With a single generic gateway, you would need complex conditional logic to handle three different auth schemes, three rate limit tiers, and three response shapes. With BFF: the **Mobile BFF** returns compact payloads optimized for bandwidth, uses OAuth with mobile-specific token lifetimes, and rate limits per device ID. The **Web BFF** returns richer payloads, uses session cookies, and focuses on aggregation for complex screens. The **Public API Gateway** enforces API key auth, strict rate limits, and SLA-level contracts — isolated from internal service changes. Each BFF team owns and evolves their gateway independently.
> 4. Deploy the API Gateway as a cluster of **multiple stateless instances** behind a hardware or cloud load balancer. Use **health checks** (HTTP/TCP probes) so the load balancer automatically removes unhealthy instances. Deploy across **multiple availability zones** (AZs) within a region to survive AZ failures. For global resilience, use **multiple regional deployments** with DNS-based global load balancing (e.g., AWS Route 53 latency routing or Cloudflare). Store all state (rate limit counters, session data) in an external distributed store (Redis Cluster) so any gateway instance is interchangeable. Automate instance replacement via a container orchestrator (Kubernetes) with autoscaling.

---

## 2.3 Communication Patterns

Protocols and APIs define the mechanics of communication — what format data takes and how connections are established. Communication patterns are at a higher level of abstraction: they define *when* and *why* components communicate and how they react to each other. Choosing the wrong pattern leads to tight coupling, poor scalability, and systems that fail ungracefully under load.

---

### Synchronous vs Asynchronous Communication

#### Theory

The most fundamental distinction in system communication is whether the caller waits for a response.

**Synchronous communication** means the caller blocks — it sends a request and waits, doing nothing else until the response arrives (or the request times out). The caller and callee are temporally coupled: they must both be available and responsive at the same time.

**Asynchronous communication** means the caller does not block — it sends a message and continues processing. The response, if any, arrives later (via callback, event, or polling). The caller and callee are decoupled in time; the callee does not need to be available when the message is sent.

```
Synchronous:                    Asynchronous:
                                
  Client ──── request ────>       Client ──── message ────> Queue
  Client       (waiting)                  (continues)          │
  Client <─── response ───         ...                         │
  Client (resumes)                 Client <─── event ─── Worker
                                                  (later)
```

| Dimension | Synchronous | Asynchronous |
|---|---|---|
| Coupling | Tight temporal coupling | Loose temporal coupling |
| Latency | Low for simple operations | Higher perceived latency |
| Availability dependency | Callee must be up | Callee can be offline |
| Backpressure | Natural (caller blocks) | Requires explicit queue depth limits |
| Debugging | Easier (linear call stack) | Harder (distributed traces needed) |
| Use cases | CRUD APIs, reads, user-facing queries | Email, notifications, batch jobs, event sourcing |

Neither is universally better. In practice, most systems use both: synchronous communication for user-facing reads (latency-sensitive, simple), and asynchronous communication for writes, notifications, and inter-service workflows (resilience and decoupling matter more than immediate response).

#### Example

```python
# Synchronous — caller waits for each step
import requests

def process_order_sync(order_id):
    user    = requests.get(f"/users/{order_id}").json()     # blocking
    payment = requests.post("/payments", json=order_id).json()  # blocking
    notify  = requests.post("/notify", json=user["email"]).json()  # blocking
    return {"status": "done"}
    # Total time = sum of all three round trips
    # If /notify is slow, the user waits
```

```python
# Asynchronous — publish events, let workers handle them
import json
import boto3   # AWS SDK

sqs = boto3.client('sqs')
QUEUE_URL = 'https://sqs.us-east-1.amazonaws.com/.../order-events'

def process_order_async(order_id):
    # Publish an event and return immediately
    sqs.send_message(
        QueueUrl=QUEUE_URL,
        MessageBody=json.dumps({"event": "ORDER_PLACED", "order_id": order_id})
    )
    return {"status": "accepted"}   # responds to user immediately
    # Payment and notification happen asynchronously in a separate worker process
```

> Exercises
>
> 1. (Beginner) What does "temporal coupling" mean, and which communication style introduces it?
> 2. (Beginner) A user submits a form to reset their password. The server sends a confirmation email. Should the email be sent synchronously or asynchronously? Explain.
> 3. (Intermediate) A checkout service calls three downstream services synchronously: inventory, payment, and notification. If the notification service has a P99 latency of 800ms, how does this affect the user-perceived checkout latency? How would asynchronous communication improve this?
> 4. (Interview) In a distributed system, why is asynchronous communication more resilient to downstream failures than synchronous communication? What is the trade-off? *(Hint: consider what happens to a synchronous caller when the callee is down for 5 minutes.)*

> Answers
>
> 1. Temporal coupling means two components must be available and responsive at the same time for communication to succeed. It is introduced by **synchronous communication**: if the callee is slow, crashed, or restarting, the caller is blocked or fails immediately.
> 2. Asynchronously. The user only needs to know the request was received — they do not need to wait for the email to be delivered before getting a response. Sending synchronously means the response latency includes email server round trips (which can be high), and if the email service is down, the entire password reset fails. Publishing to a queue decouples the response from the send, and the email worker can retry on failure.
> 3. The checkout API's response time is at least the sum of all three synchronous call latencies. If inventory takes 50ms, payment 200ms, and notification 800ms at P99, the user-perceived P99 checkout latency is at minimum 1,050ms — dominated by notification. Making notification asynchronous (publish an event to a queue) means the checkout service waits only for inventory and payment (~250ms), returns a response to the user, and the notification worker processes the event independently with no impact on user latency.
> 4. In synchronous communication, if the callee is down, the caller fails immediately — errors cascade upstream. If the callee is slow, the caller blocks and may exhaust its thread pool, causing cascading failures (this is called thread starvation or a cascading timeout). Asynchronous communication uses a durable queue as a buffer: if the consumer is down, messages accumulate in the queue and are processed when the consumer recovers — no data is lost and the producer continues working. The trade-off is **eventual consistency and complexity**: the system cannot guarantee that downstream effects (e.g., payment processed) are complete at the moment the producer returns a response. Consumers must be idempotent (handle duplicate messages) and the system needs observability tooling (dead-letter queues, tracing) to debug failures.

---

### Request-Response Pattern

#### Theory

Request-Response is the most familiar communication pattern: a client sends a request to a server and waits for a single response. It is the pattern underlying HTTP, database queries, and most synchronous API calls.

The pattern is straightforward when everything works. Its robustness under failure conditions requires careful design:

- **Timeouts**: without a timeout, a caller can block indefinitely on a crashed server. Every synchronous call must have a timeout.
- **Retries**: if a request fails, should the client retry? Only for idempotent operations (GET, PUT, DELETE) or explicitly idempotent writes. Retrying a non-idempotent POST can cause duplicate orders, double charges, etc.
- **Idempotency keys**: for non-idempotent operations you need to retry (e.g., payment), include a client-generated idempotency key. The server stores results keyed by this ID and returns the same result for duplicate requests.
- **Circuit Breaker**: if a downstream service is repeatedly failing, stop calling it for a period and return a cached result or error immediately. This prevents cascading failures and gives the downstream service time to recover.

```
Circuit Breaker state machine:

  CLOSED ──(failures exceed threshold)──> OPEN
    ^                                        │
    │                                        │ (after timeout)
    │                                        v
    └──────(probe succeeds)────────── HALF-OPEN
    
CLOSED:    Requests flow normally. Failures are counted.
OPEN:      Requests are rejected immediately (fail fast). No calls to downstream.
HALF-OPEN: One probe request is allowed through. If it succeeds, circuit closes.
           If it fails, circuit stays open for another timeout period.
```

#### Example

```python
# Idempotency key pattern for safe payment retries
import uuid
import requests

def submit_payment(order_id: str, amount: float) -> dict:
    idempotency_key = str(uuid.uuid5(uuid.NAMESPACE_OID, f"payment:{order_id}"))
    # uuid5 is deterministic — same order_id always generates the same key
    # So retries send the same key, and the server deduplicates automatically

    for attempt in range(3):
        try:
            response = requests.post(
                '/payments',
                json={"order_id": order_id, "amount": amount},
                headers={"Idempotency-Key": idempotency_key},
                timeout=5.0    # always set a timeout — never block indefinitely
            )
            response.raise_for_status()
            return response.json()
        except requests.Timeout:
            if attempt == 2:
                raise   # exhaust retries, propagate error
            # exponential backoff would go here in production
```

> Exercises
>
> 1. (Beginner) Why must every synchronous network call include a timeout? What happens without one?
> 2. (Beginner) What is an idempotent operation? Give two examples of HTTP methods that are idempotent and one that is not.
> 3. (Intermediate) Describe the three states of a circuit breaker and what triggers transitions between them. Why is the HALF-OPEN state necessary?
> 4. (Interview) A payment service is called synchronously. The network request succeeds (the server received it), but the response is lost due to a network partition. The client retries. How do idempotency keys prevent a double charge? Walk through the server-side logic. *(Hint: trace both the original request and the retry through the server.)*

> Answers
>
> 1. Without a timeout, a thread or connection waits indefinitely for a response that may never arrive (if the server crashed, the network partition persists, etc.). In a threaded server, all threads can become stuck waiting on unresponsive downstreams, exhausting the thread pool and making the calling service itself unavailable — a cascading failure. Timeouts are the minimum necessary defense.
> 2. An idempotent operation produces the same result regardless of how many times it is applied with the same input. Idempotent HTTP methods: **GET** (reading the same resource N times returns the same data) and **DELETE** (deleting the same resource N times — after the first deletion, subsequent deletes return 404 but the server state is unchanged). Non-idempotent: **POST** (submitting the same order form twice creates two orders).
> 3. **CLOSED**: normal operation. Failures are tracked; when failures exceed a threshold (e.g., 5 failures in 10 seconds), the circuit opens. **OPEN**: all requests fail immediately without reaching the downstream service. After a configured timeout (e.g., 30 seconds), the circuit moves to HALF-OPEN. **HALF-OPEN**: a single probe request is allowed. If it succeeds, the circuit closes and normal traffic resumes. If it fails, the circuit reopens and the timeout resets. HALF-OPEN is necessary because "open for X seconds" alone would oscillate — without a probe, you would never know if the downstream recovered, and you would either never close (too conservative) or reopen immediately on the first call (no protection).
> 4. Server-side logic with idempotency: (1) **Original request arrives**: server checks a durable store (DB/cache) for `idempotency_key = "abc123"` — not found. Server processes the payment, stores the result under `"abc123"`, and prepares a response. The response is lost in transit. (2) **Retry arrives** with the same `idempotency_key = "abc123"`: server checks the store — **found**. Server returns the stored result immediately without re-executing the payment logic. The client receives the success response. The card is charged exactly once. The critical requirement is that the server stores the result **atomically** with the operation in a single transaction, so there is no window where the operation completed but the key was not yet saved.

---

### Publish-Subscribe Pattern

#### Theory

In the request-response pattern, the sender knows exactly who the receiver is. The **Publish-Subscribe (Pub/Sub)** pattern decouples senders from receivers: a *publisher* emits events to a named *topic* without knowing which *subscribers* are listening. Zero or more subscribers can receive each event independently.

This decoupling is architectural: adding a new subscriber (e.g., an analytics service that processes orders) requires no changes to the publisher (the order service). The publisher does not know the analytics service exists.

```
Pub/Sub topology:

  Order Service ──── publishes "order.placed" ────> [Topic: order.placed]
                                                          │
                               ┌──────────────────────────┤
                               │                          │
                               ▼                          ▼
                       Email Service             Analytics Service
                    (sends confirmation)       (updates dashboard)
```

Key concepts:
- **Topic**: a named channel. Publishers write to it; subscribers read from it.
- **Message broker**: the infrastructure layer (Kafka, RabbitMQ, Google Pub/Sub, AWS SNS/SQS) that stores and delivers messages.
- **Durability**: messages are persisted so consumers can process them even if they are temporarily down.
- **Fan-out**: one published message is delivered to all subscribers independently.
- **Consumer groups**: in Kafka, a consumer group ensures that each message is processed by exactly one consumer in the group, enabling parallel processing of a topic's partitions.

Pub/Sub vs Message Queue (point-to-point):

| Dimension | Pub/Sub | Message Queue |
|---|---|---|
| Receivers | Multiple subscribers (fan-out) | Single consumer (competing consumers) |
| Decoupling | Publisher unknown to consumers | Sender targets a specific queue |
| Use case | Event broadcasting, notifications | Work distribution, task queues |
| Examples | Kafka topics, SNS | SQS, RabbitMQ queue |

#### Example

```python
# Redis Pub/Sub — simple in-process example
import redis
import threading

r = redis.Redis()

def subscriber(channel: str):
    """Subscriber runs in a separate thread, waiting for messages."""
    pubsub = r.pubsub()
    pubsub.subscribe(channel)
    for message in pubsub.listen():
        if message['type'] == 'message':
            print(f"[Subscriber] Received: {message['data'].decode()}")

# Start subscriber in background thread
thread = threading.Thread(target=subscriber, args=('order.placed',), daemon=True)
thread.start()

# Publisher — has no knowledge of who is subscribed
import time
time.sleep(0.5)   # allow subscriber thread to start

publisher = redis.Redis()
publisher.publish('order.placed', '{"order_id": 123, "user_id": 42}')
publisher.publish('order.placed', '{"order_id": 124, "user_id": 99}')

time.sleep(1)   # let messages be received before process exits
```

```
Output:
[Subscriber] Received: {"order_id": 123, "user_id": 42}
[Subscriber] Received: {"order_id": 124, "user_id": 99}
```

> Exercises
>
> 1. (Beginner) How does Pub/Sub decouple publishers from subscribers? What changes (and what does not change) in the publisher when a new subscriber is added?
> 2. (Beginner) What is the difference between a topic (Pub/Sub) and a queue (point-to-point messaging)? When would you use each?
> 3. (Intermediate) An e-commerce system publishes an `order.placed` event. Three services subscribe: Email, Inventory, and Analytics. The Inventory service is down for 10 minutes. What happens to the event? What broker feature ensures Inventory eventually processes it?
> 4. (Interview) Apache Kafka uses a "consumer group" concept where each message is processed by exactly one consumer in the group. How does this enable parallel processing while still guaranteeing that each message is processed once? *(Hint: think about how Kafka partitions topics and assigns partitions to consumers.)*

> Answers
>
> 1. Publishers write to a named topic, not to specific consumers. The publisher has no reference to subscriber addresses, interfaces, or even whether any subscribers exist. When a new subscriber is added, the broker routes the topic's messages to it automatically — **the publisher code is unchanged**. What does change: broker configuration (subscribe the new service to the topic) and the new service itself.
> 2. A **topic** delivers each message to all subscribers independently (fan-out). Used when multiple services need to react to the same event (e.g., order placed → email + inventory + analytics). A **queue** delivers each message to exactly one competing consumer. Used for work distribution where tasks should be processed once (e.g., resize this image, send this email via a worker pool).
> 3. If the broker is **durable** (e.g., Kafka, RabbitMQ with durable queues), the message is persisted on disk. Email and Analytics receive it immediately. The Inventory service's consumer offset (its position in the topic) does not advance while it is down. When Inventory recovers, it resumes from its last committed offset and processes all messages that arrived during the outage — including the missed event. This is guaranteed by **durable message retention** and **consumer offset tracking**.
> 4. Kafka partitions a topic into N ordered logs. Each partition is assigned to exactly one consumer within a consumer group at any time. Messages within a partition are processed in order by that consumer. Parallel processing scales with partition count: if a topic has 10 partitions and a consumer group has 10 consumers, each consumer handles exactly one partition, processing 10 messages in parallel. Adding consumers beyond the partition count yields no benefit — excess consumers are idle. The broker's group coordinator manages partition assignment and rebalancing when consumers join or leave.

---

### Event-Driven Architecture

#### Theory

**Event-Driven Architecture (EDA)** is a design paradigm in which components communicate exclusively through the production and consumption of events. An *event* is an immutable record of something that happened in the past: `OrderPlaced`, `PaymentFailed`, `UserRegistered`.

This is a generalization of Pub/Sub, applied as an architectural style. In a pure EDA system:
- Services have no direct knowledge of each other.
- All state changes are represented as events.
- Services update their own state by consuming events.
- The event log is the source of truth.

This enables **event sourcing**: instead of storing the current state of an entity, you store the sequence of events that produced it. The current state is always derivable by replaying events.

```
Traditional (state-based):               Event-Sourced:

users table:                             events table:
┌────┬───────────────┐                   ┌────────────────────────────────────────┐
│ id │ balance       │                   │ UserCreated { id: 1, balance: 0 }      │
│ 1  │ 350           │                   │ MoneyDeposited { id: 1, amount: 500 }  │
└────┴───────────────┘                   │ MoneyWithdrawn { id: 1, amount: 150 }  │
(balance updated in place)               └──── replay to get current balance: 350 ┘
```

Benefits of EDA:
- **Loose coupling**: services interact only through events, not direct calls.
- **Temporal decoupling**: events can be consumed hours or days after being produced.
- **Auditability**: the event log is a complete audit trail.
- **Replayability**: reprocess events to rebuild state, backfill new systems, or debug issues.
- **Scalability**: consumers scale independently based on their processing needs.

Challenges:
- **Eventual consistency**: consumers may lag; the system is not immediately consistent.
- **Event schema evolution**: changing event structures requires backward-compatible design.
- **Debugging complexity**: a system with 20 event types and 15 services requires distributed tracing to understand flows.
- **Ordering guarantees**: global event ordering is expensive; most systems guarantee per-partition ordering only.

#### Example

```python
# Simplified event-sourced bank account
from dataclasses import dataclass, field
from typing import List

@dataclass
class Event:
    type: str
    data: dict

@dataclass
class BankAccount:
    account_id: str
    events: List[Event] = field(default_factory=list)

    def deposit(self, amount: float):
        self.events.append(Event("MoneyDeposited", {"amount": amount}))

    def withdraw(self, amount: float):
        if self.get_balance() < amount:
            raise ValueError("Insufficient funds")
        self.events.append(Event("MoneyWithdrawn", {"amount": amount}))

    def get_balance(self) -> float:
        """Derive current state by replaying all events."""
        balance = 0.0
        for event in self.events:
            if event.type == "MoneyDeposited":
                balance += event.data["amount"]
            elif event.type == "MoneyWithdrawn":
                balance -= event.data["amount"]
        return balance

# Usage
account = BankAccount("acc-001")
account.deposit(500)
account.withdraw(150)
print(account.get_balance())   # 350.0
print(len(account.events))     # 2 — the full audit trail
```

> Exercises
>
> 1. (Beginner) What is an "event" in event-driven architecture? How does it differ from a command?
> 2. (Beginner) What is event sourcing? What are the two main advantages over traditional state-based persistence?
> 3. (Intermediate) In a pure EDA system, Service A emits `OrderPlaced`. Services B (inventory) and C (payment) both consume it. Service C crashes immediately after debiting the payment but before emitting `PaymentConfirmed`. How does this scenario affect system consistency? What pattern helps resolve it?
> 4. (Interview) Explain how event sourcing and CQRS (Command Query Responsibility Segregation) complement each other. Why are they often used together? *(Hint: consider how query performance is affected when state must be derived by replaying events.)*

> Answers
>
> 1. An **event** is an immutable record of something that has already happened: `OrderPlaced`, `UserDeleted`. It is a fact — it cannot be rejected once emitted. A **command** is a request for something to happen: `PlaceOrder`, `DeleteUser`. Commands can be rejected (validation failure, business rule violation). Events describe past reality; commands express intent about the future.
> 2. Event sourcing stores the sequence of domain events that caused an entity to reach its current state, rather than storing the current state directly. Advantages: (1) **Complete audit trail**: every change is recorded with timestamp and context — regulatorily valuable. (2) **Replayability**: you can rebuild current state, backfill new read models, or replay into a test environment by re-running the event stream.
> 3. This is a **partial failure** problem. Inventory may have already reserved stock (or not). Payment was debited but `PaymentConfirmed` was never emitted. The system is in an inconsistent intermediate state. The **Saga pattern** addresses this: each step in a distributed transaction either succeeds and publishes a success event, or fails and publishes a compensating event (e.g., `PaymentFailed` triggers a `RefundIssued` and `InventoryReleased`). Sagas can be choreography-based (services react to each other's events) or orchestration-based (a coordinator service drives the workflow).
> 4. Event sourcing stores state as a sequence of events — querying current state requires replaying potentially thousands of events, which is too slow for reads. **CQRS** separates the write model (commands + event sourcing) from the read model: a separate service consumes the event stream and maintains a **denormalized read model** (e.g., a SQL table or Elasticsearch index) optimized for query patterns. Writes go through the event store; reads go directly to the read model. This makes reads fast (direct lookup) while preserving the audit and replay benefits of event sourcing. The trade-off is eventual consistency: the read model may lag behind the write model by milliseconds to seconds.

---

### Long Polling and Server-Sent Events

#### Theory

Traditional HTTP is pull-based: the client asks, the server answers. But some use cases require near-real-time updates pushed from the server. Before WebSockets were widely supported, two techniques bridged this gap using standard HTTP.

**Long Polling**
The client sends a request. Instead of responding immediately (short polling), the server holds the connection open until it has new data or a timeout occurs. When the server responds, the client immediately sends another request. This simulates push over standard HTTP.

```
Long Polling:

Client: GET /updates ───────────────────────> Server (holds connection)
                              [server waits for new data]
                              [new data arrives]
Client: <─── {event: "..."} ─────────────── Server (responds)
Client: GET /updates ───────────────────────> Server (immediately re-opens)
```

Drawbacks: each "push" requires a complete HTTP request/response cycle and opens a new connection. Header overhead accumulates. Not suitable for very high frequency updates.

**Server-Sent Events (SSE)**
SSE is a standardized, unidirectional streaming protocol built on HTTP. The client opens a persistent HTTP connection; the server streams newline-delimited events over it indefinitely. The `EventSource` browser API handles the connection natively, including automatic reconnection on failure.

```
SSE wire format:

HTTP/1.1 200 OK
Content-Type: text/event-stream
Cache-Control: no-cache

data: {"price": 150.25}\n\n   ← two newlines = end of one event
data: {"price": 151.00}\n\n
event: alert\n
data: {"message": "Price spike detected"}\n\n
```

| Feature | Short Polling | Long Polling | SSE | WebSocket |
|---|---|---|---|---|
| Direction | Client → Server | Client → Server | Server → Client | Bidirectional |
| Protocol | HTTP | HTTP | HTTP | WebSocket |
| Browser support | Universal | Universal | Universal (except IE) | Universal |
| Reconnection | Manual | Manual | Automatic | Manual |
| Overhead | High (per poll) | Medium | Low (one connection) | Lowest |
| Complexity | Low | Medium | Low | High |
| Use cases | Legacy polling | Notifications, chat | Live feeds, dashboards | Chat, games |

**When to choose SSE over WebSockets**: if the data flow is strictly server-to-client (stock tickers, news feeds, build logs), SSE is simpler to implement, works over HTTP/2 without connection upgrade, and has native browser reconnection. WebSockets add bidirectionality that most push-only use cases do not need.

#### Example

```python
# SSE server (Flask)
from flask import Flask, Response, stream_with_context
import time, json, random

app = Flask(__name__)

def generate_price_stream():
    """Generator that yields SSE-formatted events."""
    price = 100.0
    while True:
        price += random.uniform(-1, 1)          # simulate price movement
        data = json.dumps({"price": round(price, 2)})
        yield f"data: {data}\n\n"               # SSE format: "data: ...\n\n"
        time.sleep(1)

@app.route('/prices')
def stream_prices():
    return Response(
        stream_with_context(generate_price_stream()),
        mimetype='text/event-stream',           # tells the browser this is SSE
        headers={
            'Cache-Control': 'no-cache',
            'X-Accel-Buffering': 'no'           # disable Nginx buffering
        }
    )
```

```javascript
// SSE client (browser)
const source = new EventSource('/prices');

source.onmessage = (event) => {
  const { price } = JSON.parse(event.data);
  document.getElementById('price').textContent = `$${price}`;
};

source.onerror = () => {
  // EventSource automatically reconnects after a brief delay
  console.warn('SSE connection lost, reconnecting...');
};
```

> Exercises
>
> 1. (Beginner) What is the key difference between short polling and long polling? When does long polling reduce unnecessary server load compared to short polling?
> 2. (Beginner) What does the `text/event-stream` Content-Type tell the browser? What browser API is used to consume SSE?
> 3. (Intermediate) A long-polling server holds connections open waiting for data. Under sustained load, 10,000 clients are connected simultaneously. What resource on the server is most at risk of exhaustion, and what architectural technique can mitigate it?
> 4. (Interview) A product manager asks you to build a live cryptocurrency price ticker for the company's website. The page only displays prices — users do not interact with it. Compare SSE and WebSockets for this requirement, and justify your choice. Consider implementation complexity, infrastructure requirements, and failure handling. *(Hint: think about what HTTP/2 does to SSE's connection limit concern.)*

> Answers
>
> 1. Short polling sends a new HTTP request at fixed intervals (e.g., every 2 seconds) regardless of whether new data exists — many requests return empty responses, wasting bandwidth and server resources. Long polling holds the request open until data is available, so responses are never empty (they either contain data or timeout). Long polling reduces unnecessary load when updates are infrequent relative to the polling interval: if data changes 3 times per minute but short polling fires 30 times per minute, long polling eliminates 27 wasted round trips per minute.
> 2. `text/event-stream` signals that the response is a continuous SSE stream rather than a one-shot payload — the browser should not close the connection when it receives data. The browser API is `EventSource`: `const source = new EventSource('/endpoint')`. `EventSource` parses the SSE wire format automatically and fires `onmessage` events. It also handles automatic reconnection with exponential backoff, sending a `Last-Event-ID` header so the server can resume from where the client left off.
> 3. **File descriptors / open connections** are at risk. Each long-polling connection holds an open socket (file descriptor) on the server. Traditional thread-per-connection servers exhaust their thread pool at high connection counts (the "C10K problem"). The architectural solution is an **event-driven / non-blocking I/O server** (Node.js, asyncio in Python, Nginx, Netty in Java) that multiplexes thousands of connections onto a small, fixed thread pool using an event loop. Connection hold cost becomes I/O-bound (memory for connection state) rather than CPU-bound (one thread per connection).
> 4. **Choose SSE**. The requirement is strictly unidirectional (server pushes prices; users do not send data). SSE advantages for this use case: (1) Simpler server implementation — no protocol upgrade, no WebSocket library, just a streaming HTTP response. (2) Works over HTTP/2, which multiplexes streams over a single TCP connection — the historical concern that browsers limited SSE to 6 connections per domain is irrelevant on HTTP/2. (3) Native automatic reconnection in `EventSource` with `Last-Event-ID` support for resuming after drops. (4) Cacheable and compatible with standard CDN and proxy infrastructure. WebSockets would add bidirectional complexity, a protocol upgrade step, WebSocket-aware load balancers, and a more complex reconnection implementation — none of which this use case needs.

---

# Chapter 3: Data Storage and Management

Modern software systems live or die by how well they store and retrieve data. This chapter builds a rigorous foundation across four layers: the landscape of database types and when to choose each, the design principles that keep schemas maintainable and performant, the scaling techniques that let systems handle millions of users, and the distributed-systems theory that governs trade-offs when data spans multiple machines. Together, these topics equip you to make informed architectural decisions and reason confidently about database behavior under real-world conditions.

---

## 3.1 Database Types

Not every data problem looks the same. A social graph, a financial ledger, a sensor stream, and a product catalog each have fundamentally different shapes — and forcing all of them into one storage model leads to painful mismatches between data and engine. This subchapter surveys the major database families, explaining the structural assumptions each one makes and the workloads each serves best.

---

### Relational Databases (RDBMS)

**Theory**

Before relational databases existed, applications stored data in ad-hoc file formats, making it nearly impossible to share data across programs or ask questions the original programmer had not anticipated. Edgar Codd's 1970 relational model solved this by organizing data into tables (relations) of rows and columns, enforcing a strict schema, and providing a declarative query language (SQL) that separated *what* data you want from *how* to find it.

The core abstraction is that every piece of data lives in exactly one place — a single row in a single table — and relationships between entities are expressed via foreign keys, with the database engine joining tables at query time. This avoids duplication and enables referential integrity: the database itself enforces that a foreign key always points to a row that exists.

RDBMS engines (PostgreSQL, MySQL, Oracle, SQL Server) are optimized for:
- Complex, ad-hoc queries across many tables
- Transactions that must be fully consistent (ACID — covered in 3.2)
- Structured data with a predictable, stable schema

The trade-off: horizontal scaling is hard. Because joins require data to be co-located or transferred across the network, spreading an RDBMS across many machines is complex. Traditional RDBMS systems scale *vertically* (bigger machines) more naturally than *horizontally* (more machines).

**Example**

Schema and a join query in PostgreSQL:

```sql
-- Users table
CREATE TABLE users (
    user_id   SERIAL PRIMARY KEY,
    email     VARCHAR(255) UNIQUE NOT NULL,
    name      VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Orders table — references users via foreign key
CREATE TABLE orders (
    order_id   SERIAL PRIMARY KEY,
    user_id    INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    total_cents INT NOT NULL,
    placed_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Join: find all orders placed by a specific user
SELECT u.name, o.order_id, o.total_cents / 100.0 AS total_dollars
FROM   users  u
JOIN   orders o ON o.user_id = u.user_id
WHERE  u.email = 'alice@example.com'
ORDER  BY o.placed_at DESC;
```

**Relational Model at a glance:**

```
users
+---------+-------------------+-------+
| user_id | email             | name  |
+---------+-------------------+-------+
|       1 | alice@example.com | Alice |
|       2 | bob@example.com   | Bob   |
+---------+-------------------+-------+

orders
+----------+---------+-------------+
| order_id | user_id | total_cents |
+----------+---------+-------------+
|      101 |       1 |        4999 |   <-- belongs to Alice (user_id=1)
|      102 |       1 |        1250 |
|      103 |       2 |        8750 |   <-- belongs to Bob   (user_id=2)
+----------+---------+-------------+
```

> **Exercises**
>
> 1. (Beginner) What constraint prevents an order row from referencing a `user_id` that does not exist in the `users` table?
> 2. (Beginner) Write a SQL query to count how many orders each user has placed. Return `name` and `order_count`.
> 3. (Intermediate) Explain the difference between an `INNER JOIN` and a `LEFT JOIN`. When would a `LEFT JOIN` return rows that an `INNER JOIN` would not?
> 4. (Interview) A colleague suggests removing all foreign keys from a production RDBMS to "improve insert performance." What are the risks? What alternatives exist?
>    - *Hint: Think about where the integrity guarantee moves when the database stops enforcing it.*

> **Answers**
>
> 1. A `FOREIGN KEY` constraint (here defined as `REFERENCES users(user_id)`) prevents the insert. The database will reject any `INSERT` into `orders` whose `user_id` has no matching row in `users`.
> 2. ```sql
>    SELECT u.name, COUNT(o.order_id) AS order_count
>    FROM   users  u
>    LEFT JOIN orders o ON o.user_id = u.user_id
>    GROUP BY u.user_id, u.name;
>    ```
>    (`LEFT JOIN` is used so users with zero orders still appear in the result.)
> 3. `INNER JOIN` returns only rows that have a matching row in *both* tables. `LEFT JOIN` returns all rows from the left table and the matching rows from the right table; where no match exists, the right-side columns are `NULL`. A `LEFT JOIN` is needed when you want to include left-side rows even if no right-side row matches — e.g., users who have placed no orders.
> 4. Risks: application bugs or race conditions can insert orphaned rows (orders for non-existent users), causing silent data corruption that is expensive to detect and fix later. Alternatives include enforcing integrity in the application layer (risky — every code path must cooperate) or using soft-deletes with application-level checks. A better performance fix is to profile specifically: foreign key checks are usually not a bottleneck; missing indexes on join columns are far more commonly the cause.

---

### Document Databases

**Theory**

Imagine building a product catalog where each product has a variable number of attributes — a shirt has size and color, a laptop has RAM and CPU, a book has ISBN and author. In a relational model you either create many nullable columns (wasteful), add a key-value attribute table (expensive joins), or use a JSON column (losing query ability). Document databases solve this natively by storing each record as a self-describing document — typically JSON or BSON — where no two documents in the same collection need to share the same structure.

MongoDB, CouchDB, and Firestore are the dominant examples. The document model is a natural fit when:
- The schema evolves frequently (new fields can be added to new documents without migrating old ones)
- Data is read and written as a whole unit (a user profile, a product listing, a blog post)
- Embedded sub-documents eliminate the need for joins on the hot path

The trade-off: ad-hoc relational queries across collections are awkward and expensive. If your primary question is "give me all orders for a user" and orders are a separate collection, you pay a round-trip or a `$lookup` (MongoDB's join equivalent). Document databases reward thinking about access patterns upfront.

**Example**

```javascript
// MongoDB — inserting a product document
db.products.insertOne({
    _id: "prod-42",
    name: "Mechanical Keyboard",
    category: "peripherals",
    price_cents: 12999,
    attributes: {          // flexible: not every product has these fields
        switch_type: "Cherry MX Brown",
        layout: "TKL",
        backlit: true
    },
    tags: ["keyboard", "mechanical", "tenkeyless"],
    reviews: [             // embedded sub-documents — no separate collection needed
        { user: "alice", rating: 5, body: "Great feel." },
        { user: "bob",   rating: 4, body: "A bit loud."  }
    ]
});

// Query: find all backlit TKL keyboards under $100
db.products.find({
    "attributes.layout":   "TKL",
    "attributes.backlit":  true,
    price_cents:           { $lt: 10000 }
});

// Update: add a new attribute without touching other documents
db.products.updateOne(
    { _id: "prod-42" },
    { $set: { "attributes.rgb_zones": 4 } }  // other products unaffected
);
```

> **Exercises**
>
> 1. (Beginner) Name two situations where a document database is a better fit than an RDBMS.
> 2. (Beginner) In the product example above, why are reviews embedded inside the product document rather than stored in a separate collection?
> 3. (Intermediate) You are building a blogging platform. A post has many comments, and a comment can have many replies. Describe two ways to model this in MongoDB and explain the trade-off between them.
> 4. (Interview) Your document database collection has grown to 50 million records and queries are slowing down. What is the first thing you should investigate, and how would you diagnose it?
>    - *Hint: Think about what happens when the database engine must examine every document to answer a query.*

> **Answers**
>
> 1. (a) When the data schema changes frequently and different records genuinely need different fields (e.g., a multi-category product catalog). (b) When a record and all its related data are almost always read and written together as a unit (e.g., a user profile with embedded address and preferences), so the cost of joins would not be justified.
> 2. Because a product's reviews are always read and displayed together with the product. Embedding them avoids a second round-trip to a `reviews` collection and keeps the data co-located for fast retrieval. The assumption is that the reviews array stays manageable in size (not thousands of entries per product).
> 3. **Option A — Embed all comments and replies inside the post document.** Pro: single read to get the full thread. Con: MongoDB documents have a 16 MB size limit; deeply nested structures are hard to update atomically; large comment arrays make full-document updates expensive. **Option B — Separate `comments` collection with a `post_id` field; replies reference a `parent_comment_id`.** Pro: each entity is independently addressable and updatable; scales to any depth. Con: requires multiple queries or a `$lookup` to assemble a full thread. The right choice depends on expected comment volume and update patterns.
> 4. Check whether queries are using indexes. Run `db.collection.explain("executionStats").find({...})` and look for `COLLSCAN` (collection scan — every document examined) vs. `IXSCAN` (index scan). A missing index on a frequently-queried field is by far the most common cause of slow queries at scale. Create a compound index matching the query's filter and sort fields.

---

### Key-Value Stores

**Theory**

The simplest possible data model: a dictionary. You store a value under a key, and you retrieve it by that key. Nothing more. Redis, DynamoDB (in its simplest access pattern), and Memcached are the canonical examples.

Because the data model is so minimal — the store does not parse or interpret the value, it just holds bytes — key-value stores can be implemented with extraordinary performance. Redis, for instance, operates entirely in memory and can serve millions of operations per second on commodity hardware.

They excel at:
- Caching (storing expensive query results, session tokens, rate-limit counters)
- Session management (user authentication state keyed by session ID)
- Leaderboards and counters (Redis's atomic increment and sorted sets)
- Feature flags and configuration

The trade-off: because the store cannot inspect the value, you cannot query by the value's contents. If you store JSON under a key but need to find "all sessions where user_id = 5", you cannot. You must know the key upfront, or maintain your own secondary index.

**Example**

```python
# Redis via redis-py
import redis

r = redis.Redis(host='localhost', port=6379, decode_responses=True)

# --- Basic get/set with TTL ---
r.set("session:abc123", '{"user_id": 42, "role": "admin"}', ex=3600)  # expires in 1 hour
session = r.get("session:abc123")   # returns the JSON string, or None if expired

# --- Atomic counter (safe under concurrency) ---
r.incr("page_views:homepage")       # increments by 1; creates key if absent
views = r.get("page_views:homepage") # "42"

# --- Sorted set: real-time leaderboard ---
r.zadd("leaderboard", {"alice": 1500, "bob": 1200, "carol": 1750})
top3 = r.zrevrange("leaderboard", 0, 2, withscores=True)
# [('carol', 1750.0), ('alice', 1500.0), ('bob', 1200.0)]

# --- Hash: store structured data without full serialization ---
r.hset("user:42", mapping={"name": "Alice", "email": "alice@example.com"})
r.hget("user:42", "name")   # "Alice"  — without loading the whole object
```

> **Exercises**
>
> 1. (Beginner) Why can key-value stores not answer the question "find all keys whose value contains the word 'admin'"?
> 2. (Beginner) You want to cache the result of an expensive SQL query for 5 minutes. Describe how you would use a key-value store to implement this.
> 3. (Intermediate) Explain why Redis's `INCR` command is safe for use as a counter under concurrent access, even though the conceptual operation "read, add 1, write" involves multiple steps.
> 4. (Interview) A service uses Redis to cache database query results. After a deployment, the cache is cleared (cold start) and the site goes down due to database overload. What is this failure mode called, and what are two strategies to prevent it?
>    - *Hint: Think about what happens when many requests simultaneously find the cache empty.*

> **Answers**
>
> 1. The key-value store treats the value as an opaque byte string. It stores and retrieves it without indexing or parsing its contents, so there is no way to perform a predicate scan over values. Only a full scan of every key (O(n), very slow) would work, which defeats the purpose of the store.
> 2. Construct a deterministic cache key from the query parameters (e.g., `"user_orders:user_id=42"`). Before running the SQL query, attempt `GET` on that key. If it returns a value, deserialize and return it. If it returns `nil` (cache miss), run the SQL query, serialize the result, and store it with `SET key value EX 300` (300 seconds = 5 minutes).
> 3. Redis is single-threaded for command execution. Even though `INCR` conceptually involves read-modify-write, Redis executes it as a single atomic operation on the server side. No two clients can interleave their execution of `INCR` on the same key. This is the same guarantee a database provides with `UPDATE counter SET val = val + 1`.
> 4. This is called a **cache stampede** (or thundering herd). Two prevention strategies: (a) **Probabilistic early expiration** — slightly before TTL expires, probabilistically refresh the cache so the refresh happens before mass expiration. (b) **Cache locking / mutex** — when a cache miss occurs, one process acquires a lock, fetches from the database, and populates the cache; other processes wait or serve slightly stale data rather than all hitting the database simultaneously.

---

### Column-Family Databases

**Theory**

A column-family database organizes data differently from both relational tables and document stores. Think of it as a sorted map of maps: a row key maps to a set of column families, and each column family maps to a set of column-name/value pairs. Rows with the same key are physically co-located on disk, and columns within a family are stored together. Apache Cassandra and HBase are the main examples.

This model is optimized for a specific access pattern: **write-heavy workloads at massive scale, where reads are always by a known key or key range**. Time-series data, event logs, sensor readings, and audit trails fit this model naturally because:
- Writes are append-only — no lock contention, no update-in-place
- Columns can vary per row (sparse data is stored efficiently — only defined columns take space)
- The data model makes it natural to store a timeseries as a single wide row (one row per entity, one column per time point)

The trade-off: the query model is very constrained. Cassandra, for example, requires that queries filter on the partition key (primary read key) and can only range-scan within a partition key. Cross-partition queries are expensive or impossible.

**Example**

```sql
-- Cassandra CQL: storing IoT sensor readings
-- The primary key design is the most critical decision in Cassandra

CREATE TABLE sensor_readings (
    sensor_id   UUID,         -- partition key: all readings for a sensor go to the same node
    recorded_at TIMESTAMP,    -- clustering column: rows within a partition sorted by time
    temperature FLOAT,
    humidity    FLOAT,
    PRIMARY KEY (sensor_id, recorded_at)
) WITH CLUSTERING ORDER BY (recorded_at DESC);  -- newest readings first

-- Write: very fast — single partition, append-only
INSERT INTO sensor_readings (sensor_id, recorded_at, temperature, humidity)
VALUES (uuid(), toTimestamp(now()), 22.5, 60.1);

-- Read: retrieve last 100 readings for a specific sensor — fast (single partition scan)
SELECT * FROM sensor_readings
WHERE sensor_id = 123e4567-e89b-12d3-a456-426614174000
LIMIT 100;

-- This query is NOT possible without a secondary index (cross-partition):
-- SELECT * FROM sensor_readings WHERE temperature > 30;  -- AVOID
```

**Column-family vs Relational mental model:**

```
Relational:               Column-Family (Cassandra):
+----+-----+------+       Row key     Columns (can differ per row)
| id | col | col2 |       sensor_001  {2024-01-01: 22.5, 2024-01-02: 23.0}
+----+-----+------+       sensor_002  {2024-01-01: 19.0}   (sparse — no day 2)
|  1 |  a  |  b   |
|  2 |  c  |  d   |
+----+-----+------+
```

> **Exercises**
>
> 1. (Beginner) Why is storing time-series data as wide rows in Cassandra more efficient than storing one row per time point in a relational database?
> 2. (Beginner) What is a partition key in Cassandra and why does its choice dramatically affect performance?
> 3. (Intermediate) You are designing a Cassandra table to store chat messages. Messages belong to a chat room and should be retrieved in reverse chronological order. Design the primary key and explain your reasoning.
> 4. (Interview) A Cassandra cluster has one partition that is receiving far more reads and writes than others. What is this problem called, and what is the usual cause and fix?
>    - *Hint: Think about what determines which node receives a request.*

> **Answers**
>
> 1. In a relational database, each row has overhead (row header, index entries, potential page splits on insert). Writing one row per time point multiplies this overhead. In Cassandra, all readings for a single sensor live in one partition. Writes within a partition are sequential appends to a sorted structure (SSTable), with no locking and minimal per-entry overhead. Reading the last N readings is a single sequential scan from the start of the partition.
> 2. The partition key determines which node (or set of nodes) stores the row, via consistent hashing of the key. If the partition key is too coarse (e.g., a single constant), all data goes to one node — no parallelism, a bottleneck. If it is too granular (e.g., a UUID), data is evenly spread but queries that need to aggregate across partitions require fan-out to many nodes. The goal is a key that distributes load evenly *and* allows the most common queries to be served by a single partition.
> 3. `PRIMARY KEY (room_id, sent_at)` with `CLUSTERING ORDER BY (sent_at DESC)`. `room_id` is the partition key — all messages in a room are co-located and can be fetched in a single partition scan. `sent_at` is the clustering column, sorted descending so the most recent messages are at the "top" of the partition and returned first without additional sorting. To avoid unbounded partition growth, a bucketing strategy (e.g., partitioning by `(room_id, week)`) should be added in production.
> 4. This is called a **hot partition** (or hot spot). The usual cause is a partition key with low cardinality or skewed write distribution — e.g., using the current date as a partition key means all writes today go to one partition. The fix is to add a **shard suffix** to the partition key (e.g., `(date, shard_id)` where `shard_id` is randomly chosen from 0–N), spreading writes across multiple partitions while keeping related data accessible via parallel queries.

---

### Graph Databases

**Theory**

Some data is fundamentally about *relationships*. A social network, a fraud detection system, a recommendation engine, a knowledge graph — in all of these, the connections between entities are as important as the entities themselves, and chains of connections ("who are Alice's friends' friends?") are first-class query operations.

In a relational database, traversing a chain of relationships means performing recursive self-joins. At depth 3 or 4 this becomes brutally slow. Graph databases like Neo4j store data as nodes (entities) and edges (relationships), both of which can carry properties. The storage engine is optimized for graph traversal: following an edge from one node to the next is a pointer dereference, not a join.

The query language Cypher (Neo4j) uses a pattern-matching syntax designed to read like a picture of the graph, making complex traversal queries intuitive to write.

**Example**

```cypher
// Neo4j Cypher — social graph

// Create nodes and relationships
CREATE (alice:Person {name: "Alice", age: 30})
CREATE (bob:Person   {name: "Bob",   age: 28})
CREATE (carol:Person {name: "Carol", age: 32})
CREATE (alice)-[:FRIENDS_WITH {since: 2020}]->(bob)
CREATE (bob)  -[:FRIENDS_WITH {since: 2021}]->(carol)

// Query: Find friends of Alice
MATCH (alice:Person {name: "Alice"})-[:FRIENDS_WITH]->(friend)
RETURN friend.name;
// Result: Bob

// Query: Friends-of-friends (depth 2), excluding Alice herself
MATCH (alice:Person {name: "Alice"})-[:FRIENDS_WITH*2]->(fof)
WHERE fof <> alice
RETURN DISTINCT fof.name;
// Result: Carol

// Query: Shortest path between two people
MATCH p = shortestPath(
    (alice:Person {name: "Alice"})-[:FRIENDS_WITH*]-(target:Person {name: "Carol"})
)
RETURN length(p) AS hops, [n IN nodes(p) | n.name] AS path;
```

**Graph topology example:**

```
(Alice) --FRIENDS_WITH--> (Bob) --FRIENDS_WITH--> (Carol)
                           |
                     FRIENDS_WITH
                           |
                           v
                         (Dave) --WORKS_AT--> [Acme Corp]
```

> **Exercises**
>
> 1. (Beginner) Give two real-world use cases where a graph database would significantly outperform a relational database.
> 2. (Beginner) In Cypher, what does `[:FRIENDS_WITH*1..3]` mean in a `MATCH` clause?
> 3. (Intermediate) Fraud detection systems often look for "circular payment rings" — person A pays B, B pays C, C pays A. Write a Cypher query to detect such triangles.
> 4. (Interview) When would you *not* choose a graph database, even if your data has relationships?
>    - *Hint: Think about the nature and volume of reads versus relationship traversals.*

> **Answers**
>
> 1. (a) **Social network friend recommendations** — "People You May Know" at depth 2–3 requires multi-hop traversal; SQL recursive CTEs are slow and difficult at scale. (b) **Fraud detection ring analysis** — detecting circular transaction patterns between accounts requires traversing arbitrary-length paths, which a graph engine handles natively and efficiently.
> 2. It matches any path along `FRIENDS_WITH` edges with a minimum depth of 1 hop and a maximum depth of 3 hops. It will match direct friends, friends of friends, and friends of friends of friends in a single pattern.
> 3. ```cypher
>    MATCH (a:Person)-[:PAYS]->(b:Person)-[:PAYS]->(c:Person)-[:PAYS]->(a)
>    RETURN a.name, b.name, c.name
>    ```
>    The pattern directly encodes the cycle. Neo4j's traversal engine evaluates this efficiently without recursive self-joins.
> 4. If relationship traversal is not actually a core query pattern — e.g., most queries are simple lookups by ID or bulk analytics over all nodes — then a graph database provides no advantage and adds operational complexity. Graph databases also typically do not scale horizontally as easily as key-value or document stores, and they lack the mature analytics ecosystem of relational or columnar databases. If your "graph" queries are mostly single-hop (just fetching related entities), a relational foreign key join is equally fast and simpler to operate.

---

### Time-Series Databases

**Theory**

A time-series database (TSDB) is purpose-built for a specific and extremely common pattern: a sequence of (timestamp, value) pairs arriving continuously and almost always queried as a range over time. Metrics from servers, financial tick data, IoT sensor readings, and application performance data all share this shape.

General-purpose databases can store this data, but TSDBs like InfluxDB, TimescaleDB, and Prometheus provide:
- **Compression**: consecutive values often change little; delta encoding and run-length encoding shrink storage by 10–100x
- **Automatic downsampling / rollup**: summarize old high-resolution data into lower-resolution averages automatically
- **Time-aware query operators**: built-in functions like `rate()`, `derivative()`, `moving_average()` that are painful to write in SQL
- **Retention policies**: automatically delete data older than N days

The key mental model: time is always the primary axis. Every write is an append (time only moves forward), and the most common query is "give me this metric between time A and time B."

**Example**

```sql
-- TimescaleDB (PostgreSQL extension) — server metrics

-- Create a hypertable (partitioned automatically by time)
CREATE TABLE cpu_usage (
    recorded_at  TIMESTAMPTZ NOT NULL,
    host         TEXT        NOT NULL,
    cpu_percent  FLOAT       NOT NULL
);
SELECT create_hypertable('cpu_usage', 'recorded_at');  -- TimescaleDB extension call

-- Insert a batch of readings
INSERT INTO cpu_usage (recorded_at, host, cpu_percent) VALUES
    (NOW() - INTERVAL '2 minutes', 'web-01', 72.3),
    (NOW() - INTERVAL '1 minute',  'web-01', 85.1),
    (NOW(),                         'web-01', 91.0);

-- Query: average CPU per 5-minute bucket for the last hour
SELECT
    time_bucket('5 minutes', recorded_at) AS bucket,  -- TSDB-specific function
    host,
    AVG(cpu_percent)                      AS avg_cpu
FROM   cpu_usage
WHERE  recorded_at > NOW() - INTERVAL '1 hour'
  AND  host = 'web-01'
GROUP  BY bucket, host
ORDER  BY bucket;
```

```
InfluxDB Line Protocol (common write format for many TSDBs):
measurement,tag_key=tag_value field_key=field_value timestamp_ns

cpu_usage,host=web-01 cpu_percent=91.0 1700000000000000000
```

> **Exercises**
>
> 1. (Beginner) Explain why time-series databases can achieve 10–100x better compression than general-purpose databases for the same data.
> 2. (Beginner) What is "downsampling" and why is it important for long-term metric storage?
> 3. (Intermediate) You are storing per-second CPU readings for 1,000 servers over 2 years. Estimate the storage savings if: raw data is stored for 7 days, 1-minute averages for 30 days, and 1-hour averages for 2 years.
> 4. (Interview) Prometheus, a popular TSDB for monitoring, uses a pull model (it scrapes targets) while most databases use a push model (clients write data). What are the operational advantages of the pull model for monitoring?
>    - *Hint: Think about what the monitoring system now knows that it would not know in a push model.*

> **Answers**
>
> 1. Time-series data has two compression-friendly properties: (a) **temporal ordering** — data arrives in timestamp order, so delta-encoding timestamps (storing the difference between consecutive timestamps rather than the absolute values) gives very small numbers; (b) **value locality** — successive readings of the same metric typically change little, so the delta between consecutive values is small and often zero. Techniques like Gorilla compression (Facebook) exploit both, achieving ~1.37 bytes per data point vs. ~16 bytes for a naive float+timestamp pair.
> 2. Downsampling is the process of replacing many fine-grained data points with a single aggregated value (e.g., replacing 60 per-second readings with a single per-minute average). It is important because: old high-resolution data consumes significant storage but is rarely needed for trending and alerting over long time horizons; a 2-year-old metric reading at per-second resolution has negligible additional value over a per-minute average for most use cases.
> 3. Per server: 1 reading/sec × 86,400 sec/day × ~8 bytes ≈ 691 KB/day. 1,000 servers × 7 days raw = ~4.8 GB. 1-minute averages for 1,000 servers for 30 days = 1,000 × 43,200 readings × 8 bytes ≈ 346 MB. 1-hour averages for 2 years = 1,000 × 17,520 readings × 8 bytes ≈ 140 MB. Total: ~5.3 GB vs. what 2 years at full resolution would cost: 1,000 × 730 days × 691 KB ≈ **505 GB**. Tiered downsampling delivers roughly a 95% reduction.
> 4. In a pull model, the monitoring system is in control. It knows: (a) whether a target is *reachable* — if Prometheus cannot scrape a target, it records a failure, which itself is an alert condition; in a push model, the absence of data is indistinguishable from the target being down or just slow. (b) The exact collection interval — there is no drift from clients pushing at different rates. (c) Service discovery — Prometheus can automatically discover new targets and stop scraping decommissioned ones, whereas a push model requires each client to know the monitoring endpoint.

---

## 3.2 Database Design Principles

Choosing the right database type is only the first decision. How you structure data *inside* the database determines whether queries are fast or slow, whether the schema survives a year of product evolution, and whether concurrent writes corrupt each other. This subchapter covers the foundational design principles that apply across most database systems.

---

### Normalization and Denormalization

**Theory**

Normalization is the process of organizing a relational schema to minimize redundancy and protect data integrity. It was formalized through a series of "normal forms" — increasingly strict rules about which columns may depend on which other columns.

The intuition: redundancy creates inconsistency. If a user's email address is stored in three different tables, updating it requires three writes, and a partial failure leaves the data in an inconsistent state. If instead email is stored in exactly one place (the `users` table) and other tables reference it by `user_id`, there is only one place to update and no inconsistency is possible.

The most commonly discussed forms:

| Normal Form | Rule (informal) | Problem it prevents |
|-------------|-----------------|---------------------|
| 1NF | Each column contains atomic (indivisible) values; no repeating groups | Arrays or comma-separated values in cells that make queries impossible |
| 2NF | Every non-key column depends on the *entire* primary key (no partial dependency) | Duplicate data when a composite PK is used and some columns only depend on part of it |
| 3NF | Every non-key column depends *directly* on the primary key, not transitively on another non-key column | Update anomalies when changing a derived fact requires updating many rows |

**Denormalization** is the deliberate reversal of this process: storing redundant data to eliminate expensive joins on read-heavy paths. It trades write complexity for read performance. For example, a comments feed that needs to display the author's name with every comment might embed the author's name in the `comments` table, accepting that a name change requires updating multiple rows, in exchange for avoiding a join on every page load.

**Example**

```sql
-- UNNORMALIZED: order lines store full product name and customer city (redundant)
CREATE TABLE orders_bad (
    order_id      INT,
    product_name  TEXT,   -- duplicated: if name changes, update every row
    customer_city TEXT    -- depends on customer, not on order
);

-- 3NF: each fact stored once
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name        TEXT,
    city        TEXT
);

CREATE TABLE products (
    product_id  INT PRIMARY KEY,
    name        TEXT,
    price_cents INT
);

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id  INT REFERENCES products(product_id),
    quantity    INT,
    ordered_at  TIMESTAMPTZ
);

-- Denormalized read model (e.g., a materialized view for a feed):
-- Storing product_name here is a deliberate trade-off for a read-heavy reporting query
CREATE TABLE order_summary_cache AS
SELECT o.order_id, c.name AS customer_name, p.name AS product_name, o.quantity
FROM   orders o
JOIN   customers c ON c.customer_id = o.customer_id
JOIN   products  p ON p.product_id  = o.product_id;
```

> **Exercises**
>
> 1. (Beginner) A table has columns `(order_id, product_id, product_price, quantity)` where `product_price` depends only on `product_id`, not on the full `(order_id, product_id)` composite key. Which normal form is violated, and how would you fix it?
> 2. (Beginner) What is an "update anomaly"? Give an example using a denormalized table.
> 3. (Intermediate) Explain a scenario in a high-traffic e-commerce system where denormalizing a product's category name into the `products` table is justified.
> 4. (Interview) When is it a mistake to normalize to 3NF, and what signals in an application should prompt you to consider denormalization?
>    - *Hint: Think about the read-to-write ratio and the cost of joins under high concurrency.*

> **Answers**
>
> 1. Second Normal Form (2NF) is violated. `product_price` depends only on `product_id`, which is part of the composite primary key — this is a partial dependency. Fix: extract `product_price` into a separate `products(product_id, price)` table, leaving `order_items(order_id, product_id, quantity)`.
> 2. An update anomaly is a situation where updating one real-world fact requires updating multiple rows, creating a window where the data is inconsistent. Example: a table stores `(customer_id, order_id, customer_city)`. If a customer moves, every order row for that customer must be updated. If only some are updated before a failure, different rows show different cities for the same customer.
> 3. If product listings are displayed millions of times per day and categories rarely change (e.g., "Electronics," "Books"), joining the `categories` table on every product page load wastes CPU and I/O. Denormalizing `category_name` into `products` eliminates this join on the hot path. When a category is renamed (a rare event), a batch update corrects all affected product rows — a small, infrequent write cost in exchange for a large, continuous read benefit.
> 4. 3NF is a mistake when the dominant workload is complex read queries that require joining many tables, and when data is written infrequently relative to how often it is read. Signals: slow `SELECT` queries despite good indexes (usually caused by expensive multi-table joins), query plans showing large hash joins, reporting queries that scan the entire database. These indicate the schema should be partially or fully denormalized (or a read replica with a denormalized schema, or a materialized view, should serve the read workload).

---

### Indexing Strategies

**Theory**

Without indexes, every query against a table requires a full table scan — reading every row to find the ones that match the filter. At millions of rows, this becomes unacceptably slow.

An index is a separate data structure (most commonly a B-tree) that maintains a sorted copy of one or more columns, with pointers back to the full rows. A B-tree index lets the database jump directly to the first matching row in O(log n) time, then scan forward.

Key index types:

| Index Type | Best For | Trade-Off |
|------------|----------|-----------|
| B-tree (default) | Equality, range, `ORDER BY`, prefix matching | Adds overhead to every write; requires periodic maintenance |
| Hash index | Exact equality only | Cannot be used for range queries or sorting |
| Composite index | Queries filtering on multiple columns | Column order matters critically |
| Partial index | Queries over a filtered subset of rows | Only covers rows matching the index predicate |
| Full-text index | `LIKE '%keyword%'` searches | Separate index structure; not suitable for numeric range queries |

**The most important rule about composite indexes**: the **leftmost prefix rule** — a composite index on `(a, b, c)` can be used for queries filtering on `a`, `a AND b`, or `a AND b AND c`. It cannot be used for queries filtering only on `b` or only on `c`.

Every index you add speeds up reads but slows down writes (the index must be updated on every INSERT/UPDATE/DELETE) and consumes storage. Index design is always a trade-off analysis of your actual query patterns.

**Example**

```sql
-- Table: 10 million orders
CREATE TABLE orders (
    order_id   BIGINT PRIMARY KEY,
    user_id    INT    NOT NULL,
    status     TEXT   NOT NULL,  -- 'pending', 'shipped', 'delivered', 'cancelled'
    created_at TIMESTAMPTZ NOT NULL,
    total_cents INT   NOT NULL
);

-- B-tree index: speed up lookup by user_id
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Composite index: queries that filter by user AND status
-- Supports: WHERE user_id = ? AND status = ?
-- Also supports: WHERE user_id = ? (leftmost prefix)
-- Does NOT efficiently support: WHERE status = ? (no user_id filter)
CREATE INDEX idx_orders_user_status ON orders(user_id, status);

-- Partial index: only index pending orders (far fewer rows)
-- Perfect for: SELECT * FROM orders WHERE status = 'pending' ORDER BY created_at
CREATE INDEX idx_orders_pending ON orders(created_at)
WHERE status = 'pending';

-- Examine how PostgreSQL uses (or ignores) an index:
EXPLAIN ANALYZE
SELECT * FROM orders
WHERE user_id = 42
  AND status = 'pending'
ORDER BY created_at DESC
LIMIT 20;
-- Look for "Index Scan" (good) vs "Seq Scan" (index not used — investigate why)
```

> **Exercises**
>
> 1. (Beginner) You have a `products` table with millions of rows and a query `SELECT * FROM products WHERE sku = 'ABC-123'`. What type of index would you create, and why would a hash index be arguably better here than a B-tree?
> 2. (Beginner) A composite index exists on `(last_name, first_name)`. Will the query `WHERE first_name = 'Alice'` use this index? Why or why not?
> 3. (Intermediate) You are adding an index to a 500 GB production table. What risks exist and how does PostgreSQL's `CREATE INDEX CONCURRENTLY` help?
> 4. (Interview) A query has the filter `WHERE status IN ('pending', 'processing') AND created_at > NOW() - INTERVAL '1 day'`. You can create one composite index. What column order would you choose, and why?
>    - *Hint: Consider the cardinality (number of distinct values) of each column.*

> **Answers**
>
> 1. `CREATE INDEX ON products(sku)` (B-tree) or `CREATE INDEX ON products USING HASH (sku)`. A hash index is arguably better here because the query uses only equality (`= 'ABC-123'`), never a range or sort. Hash indexes are O(1) for equality lookups vs. O(log n) for B-trees — faster at scale. The caveat is that hash indexes cannot be used for `ORDER BY`, `LIKE 'ABC%'`, or `>=` queries; if any of those are needed in the future, a B-tree is more versatile.
> 2. No. The leftmost prefix rule requires the query to filter on `last_name` first. A query filtering only on `first_name` cannot use the `(last_name, first_name)` index because the index is sorted by `last_name` first; without knowing the `last_name`, there is no shortcut — the database would have to scan the whole index. A separate index on `first_name` alone would be needed.
> 3. Risk: a standard `CREATE INDEX` takes an `ACCESS EXCLUSIVE` lock on the table, blocking all reads and writes for the duration of the build — potentially minutes or hours on a 500 GB table, causing an outage. `CREATE INDEX CONCURRENTLY` builds the index in multiple passes without a full lock. It holds only brief row-level locks, allowing normal reads and writes to continue. The trade-off: it takes longer to complete, uses more I/O, and can fail if a conflicting transaction occurs (leaving an invalid index that must be dropped and rebuilt).
> 4. `(created_at, status)` or `(status, created_at)` — the right answer depends on data distribution. `created_at > NOW() - INTERVAL '1 day'` is a high-selectivity range filter that narrows to a small fraction of all rows (one day out of years of data). `status IN ('pending', 'processing')` may also be selective, but if most orders are in those states, it is less so. As a general rule, put the high-cardinality, high-selectivity column first to maximize rows eliminated early. If `created_at` eliminates 99.9% of rows, `(created_at, status)` is better. If `status` is highly selective (e.g., only 0.1% of orders are `pending`), `(status, created_at)` is better. Always verify with `EXPLAIN ANALYZE`.

---

### ACID Properties

**Theory**

ACID is a set of guarantees that relational databases make about transactions. A transaction is a sequence of operations (reads and writes) that must be treated as a single unit.

Without these guarantees, concurrent writes could silently corrupt data and system crashes could leave data half-written. ACID makes it safe to build applications on top of a database without having to implement your own locking and crash-recovery logic.

| Property | Guarantee | Analogy |
|----------|-----------|---------|
| **Atomicity** | A transaction either fully completes or fully rolls back — no partial writes | A bank transfer either moves the money completely or not at all |
| **Consistency** | A transaction takes the database from one valid state to another — all constraints hold | An account balance can never become negative if a `CHECK (balance >= 0)` constraint exists |
| **Isolation** | Concurrent transactions do not see each other's intermediate (uncommitted) state | Two people booking the last concert ticket cannot both succeed |
| **Durability** | Once a transaction commits, the data survives crashes — it is persisted to disk | After the bank confirms your transfer, it survives a server reboot |

**Isolation levels** are a spectrum of trade-offs between concurrency and anomaly protection:

| Isolation Level | Dirty Read | Non-Repeatable Read | Phantom Read | Performance |
|----------------|-----------|---------------------|-------------|-------------|
| Read Uncommitted | Possible | Possible | Possible | Highest |
| Read Committed | Prevented | Possible | Possible | High |
| Repeatable Read | Prevented | Prevented | Possible | Medium |
| Serializable | Prevented | Prevented | Prevented | Lowest |

**Example**

```python
# SQLAlchemy (Python) — atomic bank transfer using a transaction
# Without a transaction, a crash between the two UPDATE statements
# would leave money removed from one account but not added to the other.

from sqlalchemy import create_engine, text

engine = create_engine("postgresql://localhost/mydb")

def transfer(from_account: int, to_account: int, amount_cents: int):
    with engine.begin() as conn:  # begin() auto-commits on success, rolls back on exception
        # Step 1: debit source account (enforces CHECK constraint via the database)
        conn.execute(text("""
            UPDATE accounts
            SET    balance_cents = balance_cents - :amount
            WHERE  account_id = :from_id
              AND  balance_cents >= :amount   -- only debit if funds available
        """), {"amount": amount_cents, "from_id": from_account})

        # Step 2: credit destination account
        conn.execute(text("""
            UPDATE accounts
            SET    balance_cents = balance_cents + :amount
            WHERE  account_id = :to_id
        """), {"amount": amount_cents, "to_id": to_account})

        # If an exception is raised anywhere above, the 'with' block
        # automatically rolls back — neither account is modified.
```

> **Exercises**
>
> 1. (Beginner) Explain atomicity using the bank transfer example. What would happen without it if the system crashed between the two `UPDATE` statements?
> 2. (Beginner) What is a "dirty read"? Which isolation level prevents it?
> 3. (Intermediate) Two transactions run concurrently at `READ COMMITTED` isolation. Transaction A reads a row, Transaction B updates and commits that row, then Transaction A reads the same row again. What anomaly is this, and what isolation level prevents it?
> 4. (Interview) Why do most applications use `READ COMMITTED` rather than `SERIALIZABLE`, even though `SERIALIZABLE` provides the strongest guarantees?
>    - *Hint: Think about concurrency and what `SERIALIZABLE` must do to enforce its guarantee.*

> **Answers**
>
> 1. Without atomicity, a crash between the debit and credit would leave money permanently removed from the source account but never added to the destination — the money simply disappears from the system. With atomicity, the database guarantees that either both operations complete or neither does. On recovery after a crash, the database replays its write-ahead log (WAL) and either finishes or rolls back the incomplete transaction.
> 2. A dirty read occurs when a transaction reads data that another, not-yet-committed transaction has written. If that other transaction later rolls back, the first transaction has acted on data that never "officially" existed. `READ COMMITTED` prevents dirty reads by only allowing a transaction to see data from committed transactions.
> 3. This is a **non-repeatable read**: the same row, read twice within the same transaction, returns different values because another transaction committed a change in between. `REPEATABLE READ` isolation prevents this by snapshotting the data at the start of the transaction and always returning values from that snapshot.
> 4. `SERIALIZABLE` prevents all anomalies by ensuring transactions execute as if they ran one at a time (serially). To enforce this, the database must detect and abort transactions that would produce a non-serializable outcome — leading to more transaction retries, higher latency, and reduced throughput under contention. Most applications at `READ COMMITTED` tolerate the minor anomalies (non-repeatable reads) in exchange for significantly better performance and fewer aborted transactions. Application developers handle the minority of cases that truly need stronger guarantees by using explicit `SELECT FOR UPDATE` locks or optimistic concurrency control.

---

### BASE Properties

**Theory**

ACID trades availability and performance for consistency. But what if your system must remain operational even when network partitions occur, and it spans hundreds of machines? Enforcing ACID across a distributed cluster is extremely expensive or practically impossible for certain workloads.

BASE is the alternative philosophy, formalized in the context of large-scale distributed systems:

| Property | Meaning |
|----------|---------|
| **Basically Available** | The system guarantees availability (responses to every request), though some responses may be stale or partial |
| **Soft state** | The state of the system may change over time, even without new input, as replicas converge |
| **Eventually consistent** | The system will become consistent over time, given no new updates — replicas will converge to the same value |

The canonical analogy: a DNS system. When you update a DNS record, the change does not propagate instantly to all resolvers worldwide. For minutes or hours, different clients may see the old or new address. But the system remains available (DNS still resolves names), and eventually all resolvers converge to the new value. This is acceptable because most DNS consumers can tolerate brief stale lookups.

BASE does not mean "no consistency" — it means accepting temporary inconsistency in exchange for availability and partition tolerance. Shopping carts, social media likes, and user preference updates are natural fits. Bank transfers and inventory reservation (where you must never oversell) are not.

**Example**

```
Scenario: Two replicas of a product's stock count

Node A (primary):                Node B (replica):
stock = 10                       stock = 10

--- Network partition occurs ---

User 1 (hits Node A):            User 2 (hits Node B):
  purchase 1 item                  purchase 1 item
  stock = 9 (locally)              stock = 9 (locally)

--- Network recovers ---
--- Replication runs ---

Conflict: both nodes decreased stock by 1 from the same starting value (10)
Eventual consistency resolution: stock should be 8

Resolution strategies:
  - Last Write Wins (LWW): compare timestamps, take the later write
  - Conflict-free Replicated Data Type (CRDT): for counters, merge by
    taking the sum of decrements from each replica: 10 - 1 - 1 = 8
```

> **Exercises**
>
> 1. (Beginner) In your own words, explain the difference between ACID's "consistency" and BASE's "eventual consistency."
> 2. (Beginner) Name two application features where eventual consistency is acceptable and two where it is not.
> 3. (Intermediate) Explain why a shopping cart is a good candidate for a BASE/eventually-consistent system, while payment processing is not.
> 4. (Interview) A product manager says "users are seeing stale profile data in our eventually-consistent system. Can we just add a consistency check?" What trade-off are they implicitly asking you to make?
>    - *Hint: Recall the CAP theorem (covered in 3.4).*

> **Answers**
>
> 1. ACID consistency means the database enforces declared constraints (foreign keys, check constraints, uniqueness) at all times — a transaction cannot leave the database in a state that violates its rules. BASE eventual consistency means that, at any given moment, different replicas may hold different values for the same piece of data, but given no new writes, they will converge to the same value over time. One is about constraint enforcement; the other is about replica convergence.
> 2. Acceptable: social media like counts (off by a few for a few seconds is unnoticeable); user preferences and settings (serving a slightly stale theme preference briefly is harmless). Not acceptable: bank account balances (double-spending must be prevented); seat or ticket reservations (two users must not both confirm the last seat).
> 3. A shopping cart is naturally optimistic — a customer adding an item to their cart does not need to immediately reserve inventory; the actual reservation and payment confirmation happen at checkout. Stale cart contents (e.g., showing a price that changed 10 seconds ago) is tolerable. Payment processing, by contrast, requires that a money transfer either fully completes or fully does not — no partial state is acceptable, and the result must be immediately consistent across all nodes (the money cannot appear in both accounts after a transfer).
> 4. Adding a consistency check means that before returning data, the system must verify all replicas agree (or read from a quorum). This requires more inter-node communication, increases read latency, and — critically — if a network partition occurs, the system must choose between returning potentially stale data (staying available) or refusing to respond until consistency is confirmed (sacrificing availability). The CAP theorem states this choice is fundamental and unavoidable: you cannot simultaneously guarantee consistency and availability in the presence of a partition.

---

### Schema Design Best Practices

**Theory**

A schema is a contract between the database and every piece of software that uses it. A poorly designed schema does not just cause slow queries — it causes cascading complexity as applications work around its limitations, and it makes future changes expensive.

Key principles:

**Choose appropriate data types.** Storing a phone number as `INT` loses leading zeros and limits flexibility. Storing a price as `FLOAT` introduces floating-point rounding errors (always use `DECIMAL` or integer cents for money). Storing a UUID as `CHAR(36)` with dashes is wasteful when a `UUID` native type uses only 16 bytes.

**Use surrogate primary keys.** Prefer an auto-incrementing integer or UUID as the primary key rather than a "natural" key (like email or SSN). Natural keys leak business logic into the schema, may change over time, and complicate foreign key relationships.

**Prefer NOT NULL with defaults.** Nullable columns require every query to handle the `NULL` case, and `NULL` semantics in SQL are subtle. If a column has a sensible default, set it and mark the column `NOT NULL`.

**Use constraints, not just application logic.** `CHECK`, `UNIQUE`, `NOT NULL`, and `FOREIGN KEY` constraints are enforced by the database itself — regardless of which application or script writes to it. Application-level checks are only as reliable as every code path that touches the table.

**Design for your access patterns.** A beautiful normalized schema that requires a 7-table join to serve the most common request is a practical failure. Understand what queries will run before finalizing the schema.

**Example**

```sql
-- Poor schema design
CREATE TABLE users_bad (
    id       INT,                  -- no PRIMARY KEY, no NOT NULL
    name     VARCHAR(500),         -- overly permissive length
    phone    BIGINT,               -- phone as integer: loses leading zeros, no dashes
    balance  FLOAT,                -- NEVER use FLOAT for money: 0.1 + 0.2 != 0.3
    signup   TEXT                  -- date stored as text: no range queries, no sorting
);

-- Well-designed schema
CREATE TABLE users (
    user_id    UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    email      TEXT         NOT NULL UNIQUE,
    name       TEXT         NOT NULL CHECK (length(name) > 0),
    phone      TEXT,                                    -- nullable: not everyone has one
    balance_cents BIGINT    NOT NULL DEFAULT 0          -- money as integer cents
        CHECK (balance_cents >= 0),                    -- enforce non-negative at DB level
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_active  BOOLEAN      NOT NULL DEFAULT TRUE
);

-- Enum as a constrained text column (more flexible than a DB enum type)
ALTER TABLE users ADD COLUMN role TEXT NOT NULL DEFAULT 'viewer'
    CHECK (role IN ('viewer', 'editor', 'admin'));
```

> **Exercises**
>
> 1. (Beginner) Why should monetary values never be stored as `FLOAT` or `DOUBLE`? What should be used instead?
> 2. (Beginner) A colleague argues for using `email` as the primary key of the `users` table since it is unique. Give two reasons this is a poor choice.
> 3. (Intermediate) You need to add a new required column `subscription_tier` (values: 'free', 'pro', 'enterprise') to a `users` table that already has 10 million rows. Describe how you would do this safely in a live production system without locking the table.
> 4. (Interview) What is the difference between a `UNIQUE` constraint and a `UNIQUE INDEX`? Are they interchangeable?
>    - *Hint: Think about what the database creates under the hood when you add a constraint.*

> **Answers**
>
> 1. Floating-point types (`FLOAT`, `DOUBLE`) cannot represent most decimal fractions exactly in binary. For example, `0.1 + 0.2` in IEEE 754 floating-point equals `0.30000000000000004`, not `0.3`. Over many transactions, these rounding errors accumulate and cause financial discrepancies. Use `DECIMAL(precision, scale)` (exact decimal arithmetic) or store values as integer cents (`BIGINT`) and divide by 100 only at the display layer.
> 2. (a) Email addresses change. If a user changes their email and it is a primary key, every foreign key in every related table must be updated — an expensive, error-prone cascade. (b) Email addresses are longer than an integer or UUID. Using a text primary key increases the size of every index that references it (all foreign keys store a copy of the PK value), wasting storage and slowing index comparisons.
> 3. Step 1: Add the column as nullable with no default: `ALTER TABLE users ADD COLUMN subscription_tier TEXT`. In most databases, adding a nullable column with no default is a metadata-only operation (instant, no lock on rows). Step 2: Backfill existing rows in batches to avoid locking: `UPDATE users SET subscription_tier = 'free' WHERE subscription_tier IS NULL AND user_id BETWEEN :min AND :max`. Step 3: Once all rows are backfilled, add the `NOT NULL` constraint and `CHECK` constraint: `ALTER TABLE users ALTER COLUMN subscription_tier SET NOT NULL; ALTER TABLE users ADD CHECK (subscription_tier IN ('free', 'pro', 'enterprise'))`. This avoids a long-held table lock.
> 4. In most databases (including PostgreSQL), adding a `UNIQUE` constraint automatically creates a unique index — they are functionally equivalent and largely interchangeable for enforcing uniqueness. The subtle difference is semantic and behavioral: a `UNIQUE` constraint is part of the table's definition and is visible as a constraint (via `information_schema.table_constraints`); a `UNIQUE INDEX` created directly is just an index. Some operations (like deferrable constraints in PostgreSQL) are only possible on constraints, not on plain indexes. In practice, either approach enforces uniqueness, but declaring it as a constraint is clearer intent.

---

## 3.3 Database Scaling

A single well-tuned database server can handle remarkable workloads, but eventually every successful system outgrows one machine. This subchapter covers the primary techniques for scaling databases: replication, which adds read capacity and fault tolerance by maintaining multiple copies of data, and sharding, which distributes data across multiple nodes to scale write capacity and storage.

---

### Database Replication

**Theory**

Replication is the process of maintaining multiple synchronized copies of a database. It serves two independent goals:

1. **High availability** — if the primary server fails, a replica can take over (failover)
2. **Read scaling** — read queries can be distributed across replicas, reducing load on the primary

The fundamental mechanism: every write that the primary accepts is recorded in a log (the write-ahead log in PostgreSQL, the binary log in MySQL). This log is streamed to replicas, which replay it to arrive at the same state.

Two key dimensions of replication:

**Synchronous vs. Asynchronous**

| Mode | How it works | Trade-off |
|------|-------------|-----------|
| Synchronous | Primary waits for at least one replica to confirm before acknowledging the write | Zero data loss on failover; higher write latency |
| Asynchronous | Primary acknowledges the write immediately; replica catches up in the background | Lower write latency; potential data loss if primary fails before replica catches up |

**Streaming vs. Logical Replication** (PostgreSQL terms):
- *Streaming replication* sends raw WAL bytes — fast, but the replica must be the same PostgreSQL version and cannot be selectively replicated
- *Logical replication* sends decoded change events (INSERT/UPDATE/DELETE) — more flexible, but with slightly higher overhead

**Example**

```
Primary-Replica topology:

          WRITES
            |
            v
     +------------+         WAL stream (async)    +------------+
     |  Primary   | --------------------------------> | Replica 1  |
     |  (read+    |                                  |  (read     |
     |   write)   | --------------------------------> |   only)    |
     +------------+         WAL stream (async)    +------------+
           |
           | (sync replication to at least one replica)
           v
     +------------+
     |  Replica 2  |
     |  (standby   |
     |  for failover)|
     +------------+

          READ traffic split:
          App  ---------> Primary  (writes + reads that need up-to-date data)
          App  ---------> Replica  (reads that tolerate slight staleness)
```

```sql
-- PostgreSQL: promoting a replica to primary during failover
-- (run on the replica)
SELECT pg_promote();

-- Check replication lag on a replica
SELECT NOW() - pg_last_xact_replay_timestamp() AS replication_lag;

-- On the primary: view connected standbys and their lag
SELECT client_addr, state, sent_lsn, replay_lsn,
       (sent_lsn - replay_lsn) AS lag_bytes
FROM   pg_stat_replication;
```

> **Exercises**
>
> 1. (Beginner) What is "replication lag" and what problems can it cause for an application?
> 2. (Beginner) Why can replicas only serve read queries, not write queries, in a standard primary-replica setup?
> 3. (Intermediate) An application reads a user's profile immediately after updating it, but it reads from a replica and gets the old value. What is this problem called and what are two strategies to fix it?
> 4. (Interview) You need zero data loss on primary failure but also low write latency. How would you configure replication to balance these goals?
>    - *Hint: Consider a hybrid synchronous/asynchronous approach.*

> **Answers**
>
> 1. Replication lag is the delay between when a write is committed on the primary and when it is applied on the replica. It causes read-after-write inconsistency: a user who writes data and immediately reads it from a lagging replica sees stale data. It can also cause stale cache invalidation if caches are populated from replicas. Under high load or network issues, lag can grow from milliseconds to seconds.
> 2. In a standard setup, only the primary accepts writes to ensure a single authoritative source of truth. If replicas accepted writes, the system would need a distributed consensus protocol to resolve conflicts when the same row is modified on two nodes simultaneously — this is complex and expensive. The replica is read-only specifically to avoid this problem; it is a passive follower, not a peer.
> 3. This is **read-your-own-writes inconsistency** (or read-after-write inconsistency). Strategy 1: **Route writes and the reads immediately following them to the primary.** For example, for one second after any write by a given user, direct all that user's reads to the primary. Strategy 2: **Track the WAL position of the last write per session and wait for the replica's applied position to catch up past it before serving the read from the replica** (PostgreSQL's `pg_last_xact_replay_timestamp()` and application-level watermarking support this).
> 4. Configure **one synchronous replica and one or more asynchronous replicas**. The primary waits for exactly one replica (the synchronous standby) to acknowledge each write before returning success — guaranteeing that at least one copy always has the data. Write latency increases only by the round-trip time to the synchronous standby (typically 1–5 ms in the same data center). The asynchronous replicas serve read traffic without affecting write latency. This is PostgreSQL's `synchronous_standby_names = 'ANY 1 (replica1, replica2)'` configuration.

---

### Master-Slave vs Master-Master Replication

**Theory**

**Master-Slave (Primary-Replica)** is the topology covered in the previous section: one node accepts writes, others follow. Simple, well-understood, and used by the vast majority of production systems.

**Master-Master (Multi-Primary / Active-Active)** allows writes to be accepted on any node. This is appealing because it eliminates the single point of write bottleneck and allows the system to continue accepting writes even if one master fails.

The problem: two clients writing to different masters simultaneously can create conflicts. If Master A and Master B both receive `UPDATE users SET email = 'x@x.com' WHERE user_id = 1` at the same millisecond, the final value depends on which write "wins." Conflict resolution strategies — last-write-wins (LWW), application-level merges, or CRDTs — all require explicit design decisions.

| Feature | Master-Slave | Master-Master |
|---------|-------------|---------------|
| Write availability | Single point of failure (primary) | Writes survive loss of one master |
| Conflict handling | Not needed (only one writer) | Required; adds complexity |
| Consistency | Strong (single source of truth) | Weaker; conflicts may briefly diverge |
| Common use case | Most OLTP web apps | Geographically distributed writes (multi-region) |
| Operational complexity | Low | High |

Master-Master is most justified when you have geographically distributed users and need writes to be accepted in the local data center to minimize latency (e.g., a write in Tokyo should not have to round-trip to Virginia).

**Example**

```
Master-Slave:                     Master-Master:

   Client A (writes)                  Client A            Client B
       |                                  |                    |
       v                                  v                    v
  [Master/Primary] --> replication --> [Master 1] <--> [Master 2]
       |                                         bidirectional
       v                               replication + conflict resolution
  [Slave/Replica]
  (reads only)

Conflict scenario (Master-Master):
  t=0ms: Master 1 receives: UPDATE product SET stock = 9 WHERE id = 1  (stock was 10)
  t=0ms: Master 2 receives: UPDATE product SET stock = 8 WHERE id = 1  (stock was 10)
  t=5ms: Both masters replicate their changes to each other
  -- Conflict: which value wins? 8 or 9? Neither is "correct" without business logic.
```

> **Exercises**
>
> 1. (Beginner) In a master-slave setup, what happens to write availability if the master goes down and no automatic failover is configured?
> 2. (Beginner) Why is last-write-wins (LWW) conflict resolution problematic for inventory counters?
> 3. (Intermediate) Describe a real-world application scenario where master-master replication is genuinely necessary and not just convenient.
> 4. (Interview) MySQL Group Replication offers "single-primary" and "multi-primary" modes. What makes multi-primary mode harder to use correctly, even when MySQL handles the conflict detection?
>    - *Hint: Think about what the application must be designed to handle.*

> **Answers**
>
> 1. All write operations fail until the master is restored or a replica is manually promoted to master. Read operations from replicas continue normally. This is why automatic failover (using tools like Patroni for PostgreSQL or MHA for MySQL) is critical for high-availability production systems.
> 2. LWW resolves a conflict by keeping the value with the later timestamp and discarding the other. For an inventory counter, this silently loses writes: if two nodes both decrement stock from 10 to 9, LWW keeps one decrement and discards the other — the stock shows 9 but two items were actually sold. The correct resolution for counters is to merge the deltas (both decrements happened, so stock = 10 - 1 - 1 = 8), which requires CRDT-style counter semantics.
> 3. A global e-commerce platform with data centers in North America and Europe needs to accept user account updates (profile changes, address updates) in each region without forcing a transatlantic round-trip for every write. Since profile updates are infrequent and conflicts rare (two simultaneous updates to the same profile are unlikely), the complexity of master-master is justified by the latency gains for users writing in their local region.
> 4. Even when the database detects a conflict and rolls back one of the conflicting transactions, the application must detect the rollback (via an error return code), retry the transaction, and handle the retry correctly. This requires all write paths in the application to implement retry logic with exponential backoff — a non-trivial requirement that existing application code may not have been written to handle. Silent failures (where the application treats a rolled-back write as successful) can cause data loss.

---

### Database Sharding

**Theory**

Vertical scaling (bigger machines) and read replicas eventually hit their limits — a single machine can only be so large, and reads are not the bottleneck for write-heavy workloads. Sharding (also called horizontal partitioning) splits the *data itself* across multiple independent database nodes, each called a shard. Each shard holds a subset of the rows; together, all shards hold the complete dataset.

Unlike replication, sharding increases *write capacity* and *storage capacity* — each shard handles only a fraction of the total write volume.

**Shard key selection is the most important decision.** The shard key determines how data is distributed. A poor choice leads to:
- **Hot shards**: one shard receives a disproportionate share of traffic (e.g., sharding by first letter of name means 'A' through 'D' surnames are overrepresented)
- **Cross-shard queries**: a query that cannot be answered from a single shard must fan out to multiple shards, then aggregate the results — expensive

Common sharding strategies:

| Strategy | How it works | Best for |
|----------|-------------|----------|
| Range sharding | Rows with key in range [0–999] → Shard 1, [1000–1999] → Shard 2 | Range queries on the shard key; risk of hot shards |
| Hash sharding | `shard = hash(shard_key) % num_shards` | Even distribution; poor for range queries |
| Directory sharding | A lookup table maps each key to its shard | Maximum flexibility; lookup table is a bottleneck/single point of failure |

**Example**

```python
# Application-level hash sharding: route writes and reads to the correct shard

SHARDS = {
    0: "postgresql://db-shard-0:5432/app",
    1: "postgresql://db-shard-1:5432/app",
    2: "postgresql://db-shard-2:5432/app",
    3: "postgresql://db-shard-3:5432/app",
}

def get_shard(user_id: int) -> int:
    """Deterministically map a user_id to a shard index."""
    return user_id % len(SHARDS)          # simple modulo hash

def get_connection(user_id: int):
    shard_index = get_shard(user_id)
    return connect(SHARDS[shard_index])   # connect to the correct shard

# Read: all of user 42's data is on shard 2 (42 % 4 = 2)
conn = get_connection(42)
orders = conn.execute("SELECT * FROM orders WHERE user_id = 42")

# Problem: cross-shard query (cannot be answered from one shard)
# "Find all orders placed in the last hour" requires querying ALL shards:
for shard_conn in [connect(url) for url in SHARDS.values()]:
    recent = shard_conn.execute("""
        SELECT * FROM orders WHERE placed_at > NOW() - INTERVAL '1 hour'
    """)
    # ... merge results from all shards
```

**Resharding** — changing the number of shards — is one of the hardest operations in sharded systems, because changing `num_shards` changes the mapping for nearly every key. Consistent hashing (next section) was designed to minimize this disruption.

> **Exercises**
>
> 1. (Beginner) What is the difference between replication and sharding? Can they be used together?
> 2. (Beginner) You shard a users table by `user_id % 4`. Which shard holds user_id = 17? user_id = 100?
> 3. (Intermediate) A social network shards posts by `post_id`. A user's profile page needs to display all posts by that user. Why is this query problematic, and how would you redesign the sharding strategy?
> 4. (Interview) Your sharded database is using `user_id % N` and you want to add a 5th shard. What percentage of all data must be remapped, and what technique minimizes this disruption?
>    - *Hint: Compare modulo hashing with consistent hashing.*

> **Answers**
>
> 1. Replication copies data — all replicas have all the data; it increases read capacity and availability. Sharding partitions data — each shard has a subset of the data; it increases write capacity and storage. They are complementary: in production, each shard is typically also replicated (primary + replicas per shard) for both scalability and fault tolerance.
> 2. `17 % 4 = 1` → Shard 1. `100 % 4 = 0` → Shard 0.
> 3. Because the posts are sharded by `post_id`, a user's posts are spread across all shards. Fetching all posts by a user requires a fan-out query to all N shards, then merging and sorting the results in the application — expensive and slow. A better approach for this access pattern is to shard by `user_id` instead: all of a user's posts reside on the same shard, making user-profile queries single-shard. The trade-off is that a feed of globally recent posts would then require a cross-shard query. The shard key must match the dominant access pattern.
> 4. With modulo hashing on `N=4`, adding a 5th shard changes the formula to `user_id % 5`. For a uniformly distributed `user_id`, approximately 80% of all keys map to a different shard (since `N` changes, most remainders change). This requires migrating 80% of all data — a massive, disruptive operation. Consistent hashing solves this: it arranges shards on a virtual ring, and adding one shard only displaces the keys adjacent to it on the ring — approximately `1/N` of the total keys (20% when going from 4 to 5 shards). This is why distributed key-value stores and caches (Cassandra, Redis Cluster, Memcached) use consistent hashing.

---

### Consistent Hashing

**Theory**

Consistent hashing is the algorithm that makes adding and removing shards (nodes) minimally disruptive. Understanding it requires first seeing why naive modulo hashing fails at scale.

With `shard = key % N`, adding even one server changes N, which changes the shard for most keys. In a caching system, this means a near-total cache miss rate after any topology change — the "cache stampede" problem at system scale.

Consistent hashing places both keys and nodes on a conceptual circle (a ring of hash values from 0 to 2^32). Each node is assigned a position on the ring by hashing its identifier. A key is stored on the first node that appears clockwise from the key's position on the ring.

When a node is added: only the keys between the new node and its counter-clockwise neighbor are remapped. All other keys are unaffected.
When a node is removed: only the keys that were on that node are remapped to the next node clockwise.

**Virtual nodes** are a refinement: each physical node is mapped to multiple positions on the ring. This ensures more even distribution (a physical node with 150 virtual positions gets roughly 1/N of the keys) and allows fine-grained control over load distribution.

**Example**

```
Consistent Hashing Ring (simplified, 0–360 degrees):

        0 / 360
           |
     Node C (270)  -----  Node A (90)
           |                   |
     Node B (180) ----------- (ring)

Key "user:42" hashes to position 130
  -> First node clockwise from 130 is Node C at 270
  -> Stored on Node C

Adding Node D at position 200:
  -> Keys between 180 and 200 that were on Node C (270) now go to Node D
  -> All other keys are UNAFFECTED

Without consistent hashing (modulo):
  -> Adding Node D changes N from 3 to 4
  -> Most keys change their target shard
```

```python
import hashlib
import bisect

class ConsistentHashRing:
    def __init__(self, nodes: list[str], virtual_nodes: int = 150):
        self.ring = {}             # hash_position -> node_name
        self.sorted_keys = []      # sorted list of hash positions
        for node in nodes:
            self.add_node(node, virtual_nodes)
        self._vnodes = virtual_nodes

    def _hash(self, key: str) -> int:
        return int(hashlib.md5(key.encode()).hexdigest(), 16)

    def add_node(self, node: str, virtual_nodes: int = 150):
        for i in range(virtual_nodes):
            vnode_key = f"{node}:vnode:{i}"
            pos = self._hash(vnode_key)
            self.ring[pos] = node
            bisect.insort(self.sorted_keys, pos)  # maintain sorted order

    def get_node(self, key: str) -> str:
        if not self.ring:
            return None
        pos = self._hash(key)
        # Find first position >= pos (clockwise)
        idx = bisect.bisect_left(self.sorted_keys, pos)
        if idx == len(self.sorted_keys):
            idx = 0                # wrap around the ring
        return self.ring[self.sorted_keys[idx]]

ring = ConsistentHashRing(["db-shard-0", "db-shard-1", "db-shard-2"])
print(ring.get_node("user:42"))     # deterministic node assignment
print(ring.get_node("user:9999"))
```

> **Exercises**
>
> 1. (Beginner) With 4 nodes and modulo hashing, what percentage of keys must be remapped if a 5th node is added? With consistent hashing?
> 2. (Beginner) What are virtual nodes and why are they important for even load distribution?
> 3. (Intermediate) A consistent hash ring has 3 nodes. Node B is removed due to a hardware failure. Describe which keys are affected and where they go.
> 4. (Interview) Consistent hashing is used in distributed caches (Memcached, Redis Cluster) and storage systems (Cassandra, DynamoDB). In Cassandra specifically, the replication factor interacts with consistent hashing. Explain how Cassandra stores replicated data using the ring.
>    - *Hint: A replication factor of 3 means each key is stored on three nodes.*

> **Answers**
>
> 1. Modulo hashing: adding a 5th node changes `N` from 4 to 5, causing approximately `1 - N_old/N_new = 1 - 4/5 = 80%` of keys to be remapped. Consistent hashing: only the keys that were assigned to the range now covered by the new node are affected — approximately `1/N_new = 1/5 = 20%` of keys.
> 2. Virtual nodes are multiple hash positions assigned to each physical node. Without them, nodes land at random positions on the ring, which can result in highly uneven distribution (one node covering 50% of the ring, another covering 5%). With 150 virtual nodes per physical node, the distribution averages out, giving each physical node approximately equal share of the keyspace. They also allow nodes with more capacity to be assigned more virtual nodes.
> 3. When Node B is removed, only the keys that were stored on Node B are affected. Those keys were the ones that hashed to positions on the ring between Node A's position (the previous node counterclockwise) and Node B's position. Those keys are now reassigned to Node C (the next node clockwise from Node B's former position). All keys that were already on Node A or Node C remain exactly where they are.
> 4. Cassandra uses a token ring (consistent hashing) where each node owns a range of tokens. For a replication factor of 3, each key is stored on the first 3 nodes encountered clockwise from the key's token position. When a write arrives for a key, the coordinator node identifies those 3 nodes and writes to all of them. Reads can be served by any of those 3 nodes that holds a replica. This means that any single node failure only affects keys for which that node was one of the 3 replicas — and those keys are still available on the other 2 replicas.

---

### Read Replicas

**Theory**

A read replica is a continuously-updated copy of the primary database that accepts only read queries. Unlike sharding — which partitions data — a read replica contains a complete copy of all data, making it useful for offloading read-heavy workloads without the complexity of coordinating cross-shard queries.

Read replicas are the right first scaling step when:
- Read traffic significantly exceeds write traffic (common in content-heavy applications: news sites, e-commerce product catalogs, social feeds)
- Some reads can tolerate slight staleness (replication lag)
- Reporting or analytics queries are hurting production performance

Common operational uses:
- **Analytics offloading**: run expensive reporting queries against a replica, not the primary
- **Geographic read distribution**: a replica in Europe serves European reads faster than the US-based primary
- **Backup source**: take backups from a replica to avoid I/O impact on the primary
- **Blue-green deployments**: test schema migrations on a replica before applying to the primary

**Example**

```python
# Python: routing reads to replica, writes to primary
import random
from sqlalchemy import create_engine

PRIMARY_URL  = "postgresql://primary-host:5432/app"
REPLICA_URLS = [
    "postgresql://replica-1-host:5432/app",
    "postgresql://replica-2-host:5432/app",
]

primary_engine  = create_engine(PRIMARY_URL,  pool_size=20)
replica_engines = [create_engine(url, pool_size=10) for url in REPLICA_URLS]

def get_write_conn():
    """Always use the primary for writes."""
    return primary_engine.connect()

def get_read_conn(prefer_fresh: bool = False):
    """
    Use a replica for reads.
    If prefer_fresh=True (e.g., immediately after a write), use the primary
    to avoid read-your-own-writes issues with replication lag.
    """
    if prefer_fresh:
        return primary_engine.connect()
    return random.choice(replica_engines).connect()   # simple round-robin

# Usage
with get_write_conn() as conn:
    conn.execute("INSERT INTO events ...")             # write to primary

with get_read_conn(prefer_fresh=True) as conn:
    row = conn.execute("SELECT * FROM events WHERE id = :id", {"id": event_id})

with get_read_conn() as conn:
    rows = conn.execute("SELECT * FROM articles ORDER BY published_at DESC LIMIT 20")
```

> **Exercises**
>
> 1. (Beginner) A read replica has a replication lag of 500ms. What types of queries are safe to route to it, and which are not?
> 2. (Beginner) Why is taking database backups from a replica preferable to taking them from the primary?
> 3. (Intermediate) Your primary PostgreSQL database is at 80% CPU from a mix of OLTP writes and reporting queries. Describe how you would use a read replica to reduce primary CPU without changing application code.
> 4. (Interview) Connection poolers like PgBouncer are commonly deployed in front of read replicas. What problem do they solve, and what would happen without them in a high-traffic application?
>    - *Hint: Consider what happens as the number of application servers scales up.*

> **Answers**
>
> 1. Safe with 500ms lag: product listings, article content, aggregate statistics, user-profile reads that do not reflect a change the user just made. Not safe: reading your own recent writes (a user who just changed their password must not get a "login failed" from stale authentication data), inventory checks before a purchase (stale stock levels could allow overselling), anything where the application logic branches based on data that may have changed in the last half-second.
> 2. Backup tools (like `pg_dump` or streaming base backups) must read a large portion of the database, creating significant I/O load. Running this on the primary during peak hours degrades query performance for production traffic. Running it on a replica imposes the same I/O cost on a node that serves no write traffic — the impact is isolated to read replicas, which can absorb it without affecting primary availability.
> 3. Identify the reporting queries via `pg_stat_statements` (PostgreSQL's query statistics view) — these will be the queries with the highest total execution time. Change the connection string for the reporting/analytics layer (data warehouse ETL jobs, internal dashboards, BI tools) to point to a read replica instead of the primary. These queries typically tolerate data being a few seconds stale. No application code changes are required — only configuration changes in the reporting tools. Primary CPU should drop immediately as the heavy analytical queries move to the replica.
> 4. Each PostgreSQL connection is a separate OS process consuming ~5–10 MB of memory. Without a connection pooler, each application server thread or process holds its own database connection — with 100 application servers each using 10 threads, that is 1,000 open connections, each consuming memory on the database server. Above a few hundred connections, PostgreSQL's performance degrades due to context switching and memory pressure. PgBouncer acts as a lightweight proxy that maintains a small pool of actual database connections (e.g., 50) and multiplexes thousands of client connections onto them, reusing connections across requests. This dramatically reduces database memory usage and connection overhead.

---

## 3.4 Distributed Data Concepts

When a database spans multiple machines, new classes of problems emerge that do not exist in single-node systems. A network can partition (messages between nodes can be lost). Nodes can fail independently. Clocks on different machines can drift. This subchapter builds the theoretical vocabulary for reasoning about these trade-offs, from the high-level CAP theorem to the practical mechanics of quorum-based systems.

---

### CAP Theorem

**Theory**

The CAP theorem, proved by Eric Brewer in 2000, states that a distributed data system can guarantee at most **two** of the following three properties simultaneously:

| Property | Definition |
|----------|------------|
| **Consistency** (C) | Every read receives the most recent write (or an error). All nodes see the same data at the same time. |
| **Availability** (A) | Every request receives a non-error response — though it may not be the most recent data. |
| **Partition Tolerance** (P) | The system continues to operate even when network messages between nodes are lost or delayed. |

The critical insight: **partition tolerance is not optional in a real distributed system**. Networks fail. Packets get dropped. Data centers lose connectivity. Therefore, the real choice is between consistency and availability *when a partition occurs*:

- **CP systems** (Consistency + Partition tolerance): When a partition occurs, the system refuses to serve requests it cannot guarantee are consistent. It returns an error rather than potentially stale data. Examples: HBase, Zookeeper, etcd.
- **AP systems** (Availability + Partition tolerance): When a partition occurs, the system continues serving requests, but some nodes may serve stale data. It prioritizes uptime over correctness. Examples: Cassandra, CouchDB, DynamoDB (with eventual consistency settings).

The CA combination (Consistency + Availability, sacrificing partition tolerance) is only achievable in a single-node system where there is no network to partition.

**Analogy**: Two ATMs are connected but the network between them goes down. ATM A has $100 in your account.
- A **CP** ATM refuses your withdrawal until the network recovers (consistent, but unavailable)
- An **AP** ATM lets you withdraw $100 even though ATM B might also let someone else withdraw from the same account (available, but potentially inconsistent)

**Example**

```
Network partition scenario:

 [Node A] ----X---- [Node B]    (X = network partition)

Client writes "x = 5" to Node A.
Client reads "x" from Node B.

CP response (e.g., Zookeeper):
  Node B: "I cannot confirm my data is current. Returning error."
  Client receives: ERROR (system sacrifices availability)

AP response (e.g., Cassandra with eventual consistency):
  Node B: "My last known value is x = 3" (stale, pre-partition value)
  Client receives: 3 (system sacrifices consistency)

After partition heals:
  Both nodes reconcile and converge to x = 5 (eventual consistency)
```

> **Exercises**
>
> 1. (Beginner) Why can a single-node database be considered "CA"? What assumption does this depend on?
> 2. (Beginner) Which side of the CAP trade-off (CP or AP) is more appropriate for a banking system? For a social media "likes" counter?
> 3. (Intermediate) A distributed system claims to be "CA." A colleague says this is impossible. Who is right and why?
> 4. (Interview) The CAP theorem is often criticized as too simplistic. What does the PACELC theorem add that CAP does not capture?
>    - *Hint: Think about what happens in the system when there is NO partition.*

> **Answers**
>
> 1. A single-node database has no network between nodes to partition, so partition tolerance is trivially guaranteed (a problem that does not exist does not need to be tolerated). With P effectively free, the system can be both consistent and available. The assumption is that the single node itself does not fail — if it does, neither consistency nor availability is guaranteed.
> 2. Banking: CP. A withdrawal must be consistent — the system should refuse to process a transaction it cannot safely complete rather than risk double-spending or incorrect balances. Social media likes: AP. A like count being off by a few for a few seconds is imperceptible to users, and refusing to increment or display a count during a partition would be a worse user experience than showing a slightly stale number.
> 3. The colleague is right. In a distributed system, network partitions are not a theoretical possibility — they are a certainty over time. Any system that does not tolerate partitions (CA) will, when a partition inevitably occurs, either lose consistency (become AP) or lose availability (become CP) — there is no third option. A "CA" distributed system is one that has simply not yet been tested by a real partition.
> 4. PACELC extends CAP by observing that the trade-off does not stop when the network is healthy. Even without a partition (the "ELC" part): systems must choose between **Latency** and **Consistency**. To guarantee consistency, writes must wait for acknowledgment from multiple replicas — which increases latency. To minimize latency, systems acknowledge writes before they are fully replicated — which risks serving stale data. PACELC captures that this latency vs. consistency trade-off is the *everyday* operational reality, whereas CAP's partition scenario is a relatively rare event.

---

### PACELC Theorem

**Theory**

PACELC (pronounced "pass-elk"), proposed by Daniel Abadi in 2010, extends CAP:

> **If** there is a Partition, the system must choose between **Availability** and **Consistency** (the CAP choice).
> **Else** (normal operation, no partition), the system must choose between **Latency** and **Consistency**.

The ELC part is the daily reality: even when the network is healthy, replicating writes across multiple nodes takes time. If the system waits for all replicas to confirm (strong consistency), writes are slow. If it acknowledges writes after the first node accepts them (low latency), reads may get stale data.

PACELC classification of common systems:

| System | Partition behavior | Normal behavior | Classification |
|--------|-------------------|-----------------|----------------|
| DynamoDB (default) | Available | Low latency | PA/EL |
| Cassandra | Available | Low latency | PA/EL |
| MongoDB (default) | Consistent | Low latency | PC/EL |
| Zookeeper | Consistent | Consistent | PC/EC |
| MySQL/PostgreSQL (sync replication) | Consistent | Consistent | PC/EC |
| Riak (eventual) | Available | Low latency | PA/EL |

**Example**

```
PACELC in practice: a write to a 3-node Cassandra cluster

Consistency Level = ONE (PA/EL — maximize availability and minimize latency):
  Write sent to coordinator
  Coordinator writes to 1 node, acknowledges SUCCESS immediately
  Other 2 nodes receive the write asynchronously
  Reads may be stale until all nodes sync (eventual consistency)

Consistency Level = QUORUM (PC/EC — maximize consistency):
  Write sent to coordinator
  Coordinator writes to 2 of 3 nodes, waits for BOTH to confirm
  Acknowledges SUCCESS only after quorum reached
  Higher write latency; reads from a quorum are always up-to-date

                    +----------+  write  +----------+
  Client --> Coord  |  Node A  |-------> |  Node B  |
              |     +----------+  write  +----------+
              |                             |
              |      Wait for 2 acks        |
              +<-- ack -- Node A            |
              +<-- ack ---------- Node B    |
              |
              SUCCESS (latency = max(A, B) round-trip time)
```

> **Exercises**
>
> 1. (Beginner) In Cassandra, what does `Consistency Level = QUORUM` mean for a cluster with 5 nodes?
> 2. (Beginner) Explain why the ELC trade-off (latency vs. consistency) exists even when the network is perfectly healthy and there are no failures.
> 3. (Intermediate) A system is classified as PA/EL. What does this mean, and give an example of when this classification is the right choice?
> 4. (Interview) Compare the PACELC classifications of Zookeeper (PC/EC) and Cassandra (PA/EL). For what types of data and workloads would you choose each?
>    - *Hint: Think about what ZooKeeper is actually used for in practice.*

> **Answers**
>
> 1. With 5 nodes, a quorum is `floor(5/2) + 1 = 3` nodes. `Consistency Level = QUORUM` means: a write must be written to at least 3 nodes before the coordinator acknowledges success to the client; a read must contact at least 3 nodes and return the most recent value among their responses. This guarantees that a read-quorum and write-quorum always overlap by at least one node, ensuring the read always sees the most recent write.
> 2. Even on a healthy network, the physical act of transmitting data and waiting for a confirmation reply takes time — typically 1–5 ms within a data center, 50–150 ms cross-region. If a write must wait for acknowledgment from 3 replicas in 3 different data centers, the write latency is at least the cross-region round-trip time. The database can only avoid this by acknowledging before all replicas confirm — accepting the risk that the system has a brief window where replicas diverge.
> 3. PA/EL means: during a partition, the system chooses availability over consistency (AP); during normal operation, it chooses low latency over consistency (EL). This is the right choice for: shopping cart contents (a user's cart being briefly inconsistent across data centers is acceptable), social media activity feeds (stale by a few seconds is unnoticeable), user session storage (high-frequency reads must be fast). The shared property is that these workloads can tolerate brief inconsistency in exchange for high availability and low latency.
> 4. ZooKeeper (PC/EC) is used for distributed coordination: storing configuration, leader election, distributed locks, and service discovery. These use cases are inherently correctness-critical — a misconfigured service registry or a split-brain leader election can cascade into catastrophic failures. ZooKeeper accepts that it will refuse requests during a partition and will have higher write latency (due to consensus) in exchange for guaranteeing that all readers see the same, authoritative value. Cassandra (PA/EL) is designed for user-facing data at massive scale — it must be always-on and low-latency for millions of concurrent users. The data it stores (user profiles, timelines, activity events) can tolerate brief staleness. Choosing Cassandra for a distributed lock would be dangerous; choosing ZooKeeper for a high-traffic user activity feed would be an over-engineered bottleneck.

---

### Eventual Consistency

**Theory**

Eventual consistency is a consistency model that guarantees: *if no new updates are made to a piece of data, all replicas will eventually converge to the same value.* It deliberately says nothing about how long "eventually" takes.

This sounds alarming — and in the wrong context, it is. But it is the right model for a large class of real-world data, because in many cases, brief divergence between replicas is acceptable, and the alternative (strong consistency) would require inter-node coordination that limits throughput and availability.

The DNS example is the canonical illustration. When you update an A record, name servers worldwide do not instantly agree. Over minutes to hours, the change propagates. During that window, different clients resolve the domain to different IP addresses. No end-user considers DNS "broken" because of this — the brief inconsistency is tolerable and usually invisible.

Key properties of eventually consistent systems:
- **Convergence**: given enough time without new writes, all replicas agree
- **No single "true" ordering**: writes that reach different replicas in different orders must be reconciled
- **Conflict resolution is mandatory**: the system or application must define what happens when two nodes accept different values for the same key (LWW, CRDTs, version vectors)

**Example**

```
Version Vector example (tracking causality in eventual consistency):

 Each node tracks a vector clock: {node_id: write_count}

 Initial state: key "x" = 10 on all nodes
 Vectors: Node A: {A:1}, Node B: {A:1}  (both reflect A's initial write)

 t=1: Client writes x = 20 to Node A
      Node A state: x=20, vector={A:2}

 t=2: Network partition — Node B cannot reach Node A

 t=3: Client writes x = 30 to Node B (concurrent with A's update)
      Node B state: x=30, vector={B:1} (B does not know about A's update)

 t=4: Partition heals. Nodes exchange states.
      Conflict: {A:2, val=20} vs {B:1, val=30}
      Neither vector dominates the other (A:2 does not contain B:1, and vice versa)
      -> CONFLICT: system (or application) must choose resolution strategy:
         - Last Write Wins (LWW): compare timestamps, take 30 if B's write was later
         - Merge: domain-specific (e.g., for a "max bid" field, take max(20,30) = 30)
         - Expose conflict to application: CouchDB returns both values; app resolves
```

> **Exercises**
>
> 1. (Beginner) Describe a real-world scenario (outside of databases) that naturally exhibits eventual consistency.
> 2. (Beginner) What is a "conflict" in an eventually consistent system, and when does it arise?
> 3. (Intermediate) Explain what a CRDT (Conflict-free Replicated Data Type) is and give one example of a data type that can be implemented as a CRDT.
> 4. (Interview) A product manager reports that users occasionally see a post they just deleted reappear briefly. What eventual consistency phenomenon is causing this, and what would "read repair" do in this context?
>    - *Hint: Think about what happens when a read hits a node that has not yet received the delete.*

> **Answers**
>
> 1. A shared Google Doc edited by two people simultaneously who are offline. Each person's device accepts local edits immediately. When both come back online, their changes must be merged. Neither person's device had the "latest" version while offline — eventual consistency governs how their edits converge when the network reconnects.
> 2. A conflict occurs when two nodes independently accept different values for the same key without one update having knowledge of the other. This happens when a network partition allows concurrent writes to isolated nodes. Without a causal ordering (as provided by vector clocks), neither write can be automatically classified as "more recent" in a meaningful sense — the system cannot determine which value to keep without additional information or a policy (like LWW).
> 3. A CRDT is a data structure designed so that concurrent updates from multiple nodes can always be merged to a correct result without conflict, as long as the merge operation is commutative, associative, and idempotent. Example: a **G-Counter** (grow-only counter). Each node maintains its own counter. To increment, a node increments its own slot. To read the total, sum all slots. To merge two states, take the max of each slot. Because max is commutative and idempotent, any two replicas merged in any order always produce the same result — no conflict is possible.
> 4. This is a **deleted-item resurrection** caused by read-repair or anti-entropy revealing a replica that missed the delete. When the user deleted the post, the delete may have only reached some replicas. When a subsequent read hits a replica that did not receive the delete, it returns the post. Read repair in this context works as follows: when a read is served from multiple replicas and they disagree (one has the post, another does not), the coordinator detects the inconsistency. It takes the most causally recent value (the delete) and asynchronously replicates it to the replica that still has the old value. After repair, future reads from that replica return the correct result (deleted). The brief reappearance is a window before read repair completes.

---

### Strong Consistency

**Theory**

Strong consistency (also called linearizability) is the strictest consistency model: every operation appears to take effect instantaneously at some point between its invocation and its response. From any client's perspective, the system behaves as if there is a single, authoritative copy of each piece of data, and reads always reflect the most recent write.

This requires that distributed nodes coordinate before acknowledging a write — all nodes (or a quorum) must agree before the client is told the write succeeded. This coordination has a cost: write latency increases with the number of nodes that must confirm and the network distance between them.

Comparison of consistency models:

| Model | Guarantee | Example |
|-------|-----------|---------|
| Linearizability (strong) | Real-time ordering: reads always reflect the latest committed write, globally | A distributed lock (either held or not — no ambiguity) |
| Sequential consistency | All operations appear in the same order to all nodes, but not necessarily real-time | Raft consensus log |
| Causal consistency | Operations that are causally related appear in order; concurrent ones may differ | Vector clock-based systems |
| Eventual consistency | No ordering guarantee, only eventual convergence | Cassandra, DNS |

Protocols that achieve strong consistency in distributed systems:

- **Two-Phase Commit (2PC)**: A coordinator asks all participants to "prepare" (vote yes/no), then commits only if all vote yes. Provides strong consistency but is slow and vulnerable to coordinator failure.
- **Raft / Paxos**: Consensus algorithms where a quorum of nodes must agree on each operation. Used by etcd, CockroachDB, and Google Spanner.

**Example**

```
Raft consensus: achieving strong consistency across 3 nodes

Step 1 — Leader election:
  Nodes start as followers. After a timeout, one becomes a candidate.
  Candidate requests votes. Majority (2/3) vote makes it the Leader.

  [Leader: Node A]  [Follower: Node B]  [Follower: Node C]

Step 2 — Write (Log Replication):
  Client: "SET x = 42"
  Node A (Leader): appends to its log, sends AppendEntries to B and C
       A -----> B: AppendEntries{index:5, entry: "SET x=42"}
       A -----> C: AppendEntries{index:5, entry: "SET x=42"}
  B and C append to their logs, reply "success"
  Node A receives quorum (2 of 3): commits the entry, applies to state machine
  Node A: responds SUCCESS to client

Step 3 — Guarantee:
  Any future read from A, B, or C will see x = 42 (or a later value)
  Even if Node A fails, B or C will have the committed entry and can be elected leader

  Note: Node C could be slow or partitioned. If A and B form a quorum, the write
  still succeeds — Node C gets it later when it reconnects.
```

> **Exercises**
>
> 1. (Beginner) What is the key difference between strong consistency and eventual consistency in terms of what a client can observe immediately after a write?
> 2. (Beginner) Two-Phase Commit (2PC) is used to coordinate distributed transactions. What is its main weakness?
> 3. (Intermediate) Raft requires a quorum of nodes to agree before committing a write. With 5 nodes, how many node failures can the system tolerate while remaining available for writes?
> 4. (Interview) Google Spanner achieves globally-distributed strong consistency. What physical infrastructure does it rely on that most other distributed databases cannot assume?
>    - *Hint: Think about how it eliminates clock drift problems.*

> **Answers**
>
> 1. With strong consistency, a client that just wrote a value `x = 5` is guaranteed that any subsequent read from any node in the cluster will return `5` (or a later value if another write occurred). With eventual consistency, a read immediately after the write may return an older value if it hits a replica that has not yet received the update.
> 2. 2PC's main weakness is blocking on coordinator failure. In Phase 2 (commit), if the coordinator fails after some participants have received "commit" and others have not, the participants that received "prepare" (voted yes) are in a locked state — they cannot commit or roll back without hearing from the coordinator, which may be unavailable. The system is stuck until the coordinator recovers. This makes 2PC a poor choice for high-availability systems.
> 3. With 5 nodes, a quorum is `floor(5/2) + 1 = 3` nodes. The system requires 3 nodes to be healthy and reachable to commit writes. Therefore, it can tolerate `5 - 3 = 2` simultaneous node failures while remaining available for writes.
> 4. Google Spanner uses **TrueTime** — GPS receivers and atomic clocks deployed in every Google data center — to give each data center a globally synchronized clock with a known, bounded uncertainty (typically ±7 ms). By waiting out the uncertainty interval before committing (ensuring no other node could have committed a conflicting transaction at the same logical time), Spanner achieves external consistency (a form of linearizability) across globally distributed nodes. Standard distributed databases cannot assume this because they rely on NTP (Network Time Protocol), which has much larger and less bounded clock drift, making real-time ordering of distributed events unreliable without a consensus protocol.

---

### Quorum-Based Systems

**Theory**

A quorum is the minimum number of nodes that must participate in an operation for it to be considered valid. Quorum-based systems use this concept to balance consistency and availability without requiring all nodes to be available.

The fundamental quorum rule for a system with N replicas, write quorum W, and read quorum R:

> **R + W > N** ensures that every read quorum and write quorum share at least one node — guaranteeing the read always sees the latest write.

Tuning W and R trades off between write performance, read performance, and consistency:

| W | R | R+W | Behavior |
|---|---|-----|---------|
| N | 1 | N+1 | Writes require all nodes (durable but slow writes); reads are fast |
| 1 | N | N+1 | Writes are fast; reads require all nodes (rarely used) |
| N/2+1 | N/2+1 | N+1 | Balanced (quorum reads and writes — both tolerate minority failures) |
| 1 | 1 | 2 < N | Fastest (but R+W ≤ N: stale reads possible) |

In Cassandra, this maps directly to `Consistency Level` settings. With N=3 replicas:
- `QUORUM` means W=2 and R=2 (R+W=4 > 3 — strongly consistent)
- `ONE` means W=1 or R=1 (eventually consistent, highest availability)
- `ALL` means W=3 or R=3 (most durable but lowest availability)

**Example**

```
Quorum with N=5 replicas, W=3, R=3 (R+W=6 > 5):

WRITE: "x = 100"
  Write sent to all 5 nodes
  Wait for 3 to acknowledge
  +-------+  ack
  | Node1 |---+
  | Node2 |---+--> Coordinator: received 3 acks -> SUCCESS
  | Node3 |---+
  | Node4 |   (in flight, not yet ack'd)
  | Node5 |   (slow/unreachable)

READ: "get x"
  Read sent to all 5 nodes
  Wait for 3 responses, return the highest-versioned value
  +-------+  returns x=100 (latest)
  | Node1 |---+
  | Node2 |---+--> Coordinator: 3 responses received; max version = x=100 -> RETURN 100
  | Node3 |---+

Overlap guarantee: at least one of the 3 read-responding nodes was in the write quorum.
  Node4 and Node5 could both be down and the system still reads correctly.
  (Can tolerate N - min(W,R) = 5 - 3 = 2 failures)
```

```python
# Simulating quorum behavior in a distributed key-value store

class QuorumStore:
    def __init__(self, nodes: list, W: int, R: int):
        self.nodes = nodes    # list of node objects with .write() and .read() methods
        self.W = W
        self.R = R

    def write(self, key: str, value, version: int):
        acks = 0
        for node in self.nodes:
            try:
                node.write(key, value, version)
                acks += 1
                if acks >= self.W:    # quorum reached: don't wait for remaining nodes
                    return True
            except NodeUnavailable:
                continue
        raise QuorumNotReached(f"Only {acks} of {self.W} required acks received")

    def read(self, key: str):
        responses = []
        for node in self.nodes:
            try:
                responses.append(node.read(key))       # (value, version) tuple
                if len(responses) >= self.R:
                    break
            except NodeUnavailable:
                continue
        if len(responses) < self.R:
            raise QuorumNotReached(...)
        # Return the value with the highest version number
        return max(responses, key=lambda r: r.version).value
```

> **Exercises**
>
> 1. (Beginner) With N=5, W=3, R=3: how many node failures can the system tolerate for (a) writes and (b) reads?
> 2. (Beginner) Why does R+W > N guarantee that a read will always see the latest write?
> 3. (Intermediate) You want to optimize a Cassandra cluster (N=3) for maximum write throughput at the cost of allowing stale reads. What consistency levels would you set for writes and reads?
> 4. (Interview) Sloppy quorums are used in DynamoDB. How do they differ from strict quorums, and what availability benefit do they provide at the cost of consistency?
>    - *Hint: Consider what happens when the "preferred" nodes for a key are unavailable.*

> **Answers**
>
> 1. (a) Writes require W=3 nodes. The system can tolerate `N - W = 5 - 3 = 2` node failures for writes. (b) Reads require R=3 nodes. The system can also tolerate `N - R = 5 - 3 = 2` node failures for reads. With this configuration, the system can tolerate up to 2 simultaneous failures for both reads and writes.
> 2. Because R+W > N, the set of W nodes that acknowledged a write and the set of R nodes that respond to a read must have at least one node in common (by the pigeonhole principle). That overlapping node has the latest written value. The read coordinator takes the highest-versioned response, which is guaranteed to be from a node that received the write — ensuring the read sees the latest data.
> 3. Set writes to `Consistency Level = ONE` (W=1): the write is acknowledged after the first replica confirms. Set reads to `Consistency Level = ONE` (R=1) as well. With W=1 and R=1, R+W = 2 ≤ 3 = N, so the guarantee breaks — reads may return stale data because the read and write quorums may not overlap. This maximizes write throughput and minimizes write latency at the cost of consistency. Appropriate for: social activity feeds, analytics event writes, logging.
> 4. In a strict quorum, only the designated "preference list" nodes for a key (determined by the consistent hash ring) can serve reads and writes. If those nodes are unavailable, the operation fails. In a sloppy quorum, if the preference list nodes are unreachable, another available node (outside the preference list) temporarily accepts the write on behalf of the unavailable node and stores a "hint" — when the unavailable node recovers, the hint is replayed to it (hinted handoff). This keeps writes available during node failures. The consistency cost: during the outage, reads from the preference list miss the writes on the hint-holding node, so the data is temporarily inconsistent across the logical quorum. Sloppy quorums trade strict consistency guarantees for higher write availability.

---

# Chapter 4: Caching

Caching is one of the most impactful techniques in computer science for improving system performance and scalability. At its core, caching stores the results of expensive or slow operations in fast-access storage so that future requests for the same data can be served more quickly. This chapter covers the fundamental concepts behind caching, the strategies used to populate and synchronize caches, and the real-world technologies that implement these ideas across different layers of a system.

---

## 4.1 Caching Fundamentals

Before reaching for a specific caching tool or strategy, it is essential to understand why caches work, how their performance is measured, and the policies that govern what data they retain and for how long.

---

### Why Caching Matters

#### Theory

Every system has a storage hierarchy. At the top sits the CPU register — tiny, but nearly instantaneous. Further down the chain come L1/L2/L3 CPU caches, RAM, SSDs, spinning hard drives, and finally remote network storage. Each level holds more data but costs more time to access.

Caching exploits a property called **locality of reference**: in practice, programs and users tend to access the same data repeatedly over a short period (temporal locality) or access data stored near recently accessed data (spatial locality). Because of this predictable pattern, a relatively small, fast store can satisfy the majority of data requests — without hitting the slow, authoritative source every time.

Consider a web application that renders a product page. The product data lives in a relational database. A single product page load might issue five or more SQL queries, each taking 20–50 ms. If the page receives 500 requests per second, the database is under enormous strain, even for identical reads. A cache in front of the database can serve those reads in under 1 ms while the database handles writes and cache misses.

**The fundamental tradeoff:** caches trade memory for latency. They are most effective when:
- Data is read far more often than it is written.
- Regenerating or fetching the data is expensive (slow query, external API call, complex computation).
- A tolerable degree of staleness exists — not every use case requires real-time data.

#### Example: Latency Comparison

```
Storage Layer         Typical Access Latency
---------------------+------------------------
CPU L1 Cache          ~1 ns
CPU L2 Cache          ~4 ns
RAM                   ~100 ns
NVMe SSD              ~100 µs
Network (LAN)         ~500 µs
Spinning HDD          ~10 ms
Cross-region network  ~100 ms
```

A cache-hit serving from RAM is roughly 100,000x faster than fetching from a spinning disk, and 1,000x faster than a local SSD.

#### Example: Simple In-Process Cache (Python)

```python
import time

# Simulated slow data source
def fetch_from_db(key: str) -> str:
    time.sleep(0.05)  # Simulate 50ms database query
    return f"data_for_{key}"

# Naive in-memory cache (dict as cache store)
_cache: dict[str, str] = {}

def get_with_cache(key: str) -> str:
    if key in _cache:
        return _cache[key]           # Cache hit: fast path
    value = fetch_from_db(key)       # Cache miss: slow path
    _cache[key] = value              # Populate cache for next time
    return value

# First call: misses cache, takes ~50ms
print(get_with_cache("product:42"))

# Second call: hits cache, takes ~0ms
print(get_with_cache("product:42"))
```

> **Exercises**
>
> 1. A database query takes 40 ms on average. A cache lookup takes 0.5 ms. If the cache hit rate is 90%, what is the average latency per request? Show your calculation.
> 2. Name two application domains where caching would be ineffective or even harmful, and explain why.
> 3. (Intermediate) Explain the concept of "temporal locality" with an example from a social media feed. How does it justify caching user profile data?
> 4. (Interview) You are building a leaderboard for a mobile game with 10 million daily active users. The leaderboard updates every minute. A product manager asks why the leaderboard cannot be computed fresh on every page load. Articulate the argument using concrete numbers. *(Hint: think about fan-out — how many users might request the leaderboard simultaneously?)*

> **Answers**
>
> 1. Average latency = (hit rate × cache latency) + (miss rate × DB latency)
>    = (0.90 × 0.5 ms) + (0.10 × 40 ms)
>    = 0.45 ms + 4.0 ms
>    = **4.45 ms**
>    Without a cache the average would be 40 ms. The cache provides roughly a 9x improvement.
> 2. Two domains where caching is ineffective or harmful:
>    - **Real-time financial transactions:** Account balances change with every transaction. Serving a stale cached balance could allow overdrafts or double-spending. Correctness trumps speed.
>    - **One-time or highly unique queries:** If every request queries completely different data (e.g., ad-hoc analytics with arbitrary filters), the cache hit rate approaches zero and the cache overhead adds latency with no benefit.
> 3. Temporal locality on a social media feed: when a user posts, their friends are likely to view the post in the minutes immediately following publication. The profile data (name, avatar, bio) of the poster will be requested by many clients in rapid succession. Caching that profile for a short window captures this burst of repeated access without querying the database for every impression.
> 4. Suppose 10 million DAU spread requests across 16 active hours gives roughly 625,000 users per hour, or ~174 users per second. If the leaderboard takes 500 ms to compute (aggregating scores for millions of players), 174 concurrent requests would mean 174 × 500 ms = 87 seconds of compute time per second — the system could not keep up. Caching the leaderboard result for 60 seconds means the expensive computation runs once per minute regardless of traffic volume.

---

### Cache Hit and Cache Miss

#### Theory

Every cache request results in one of two outcomes:

- **Cache Hit:** The requested data is found in the cache. The system returns it immediately without touching the underlying data source. This is the desired outcome.
- **Cache Miss:** The data is not in the cache. The system must fall back to the slower source (database, API, disk), retrieve the data, potentially store it in the cache, and then return it. This is slower and puts load on the origin.

**Hit Rate** (or Hit Ratio) is the most important metric for measuring cache effectiveness:

```
Hit Rate = (Number of Cache Hits) / (Total Number of Cache Requests)
```

A hit rate of 0.95 (95%) means 95 out of every 100 requests are served from the cache. The remaining 5 fall through to the origin. For most production systems, a hit rate below 80% suggests the cache is poorly configured, holds too little data, or is serving a use case where caching is not appropriate.

There are two subtypes of cache miss worth distinguishing:

| Miss Type | Cause | Notes |
|---|---|---|
| Cold Miss (Compulsory) | Data has never been cached | Unavoidable on first access |
| Capacity Miss | Cache is full; data was evicted | Solvable with larger cache or better eviction policy |
| Conflict Miss | Eviction policy removed data that was still needed | Solvable with a better eviction policy |

#### Example: Hit Rate Monitoring (Python)

```python
class InstrumentedCache:
    def __init__(self):
        self._store: dict = {}
        self._hits: int = 0
        self._misses: int = 0

    def get(self, key: str):
        if key in self._store:
            self._hits += 1          # Record a hit
            return self._store[key]
        self._misses += 1            # Record a miss
        return None

    def set(self, key: str, value):
        self._store[key] = value

    @property
    def hit_rate(self) -> float:
        total = self._hits + self._misses
        return self._hits / total if total > 0 else 0.0

cache = InstrumentedCache()
cache.set("user:1", {"name": "Alice"})

cache.get("user:1")   # hit
cache.get("user:1")   # hit
cache.get("user:2")   # miss

print(f"Hit rate: {cache.hit_rate:.0%}")  # Hit rate: 67%
```

> **Exercises**
>
> 1. A cache receives 12,000 requests in one hour. 9,600 are hits. What is the hit rate?
> 2. Explain the difference between a cold miss and a capacity miss. Which one can be eliminated by increasing cache size, and which one cannot?
> 3. (Intermediate) A cache has a 70% hit rate. Cache lookups cost 1 ms, database queries cost 80 ms. What hit rate would you need to achieve an average latency under 10 ms?
> 4. (Interview) A newly deployed cache shows a 0% hit rate for the first 10 minutes after startup. No bugs are found. What is the most likely explanation? *(Hint: think about the lifecycle of a fresh cache.)*

> **Answers**
>
> 1. Hit rate = 9,600 / 12,000 = **80%**.
> 2. A **cold miss** occurs because the data has simply never been loaded into the cache — this is unavoidable the first time any piece of data is requested. Increasing cache size does not help because the miss is caused by novelty, not capacity. A **capacity miss** occurs because the cache ran out of room and evicted data that was later needed again. Increasing cache size directly addresses this by allowing more data to reside in the cache simultaneously.
> 3. Solve for hit rate `h` in: h × 1 + (1 − h) × 80 < 10
>    → h + 80 − 80h < 10
>    → −79h < −70
>    → h > 70/79
>    → h > **~88.6%**. A hit rate above approximately 89% is required.
> 4. The cache is experiencing a **cold start** (all misses are cold/compulsory misses). When a cache is first deployed, its store is empty. Every request is a miss until the working set of hot data is loaded. This warm-up period is normal. Mitigation strategies include cache pre-warming (proactively loading common keys at startup) or using a persistent cache that survives restarts.

---

### Cache Eviction Policies (LRU, LFU, FIFO)

#### Theory

A cache has finite size. When it is full and a new item needs to be inserted, an eviction policy determines which existing item is removed to make room. Choosing the wrong policy for your access pattern wastes cache space and degrades hit rates.

**LRU — Least Recently Used**

Evicts the item that was accessed least recently. The underlying assumption is that data accessed recently is more likely to be accessed again soon (temporal locality). LRU is the most widely used policy in practice.

**LFU — Least Frequently Used**

Evicts the item that has been accessed the fewest total times. The assumption is that popular data (accessed many times) should be retained. LFU is better at retaining long-lived popular items but struggles with recently added data that has not had time to accumulate frequency counts — a "frequency bias" against new entries.

**FIFO — First In, First Out**

Evicts the item that has been in the cache the longest, regardless of how recently or frequently it was accessed. Simple to implement but generally performs poorly compared to LRU and LFU, since age alone does not correlate well with future access probability.

| Policy | Core Idea | Best For | Weakness |
|---|---|---|---|
| LRU | Evict least recently used | General-purpose, recency-biased workloads | Poorly handles "scan" patterns (large sequential reads pollute the cache) |
| LFU | Evict least frequently used | Workloads with stable, highly skewed popularity | New items are vulnerable to early eviction before accumulating frequency |
| FIFO | Evict oldest inserted item | Simplicity; streaming pipelines where order matters | Ignores access patterns entirely |

#### Example: LRU Cache (Python using OrderedDict)

```python
from collections import OrderedDict

class LRUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = OrderedDict()  # Maintains insertion/access order

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        self.cache.move_to_end(key)   # Mark as most recently used
        return self.cache[key]

    def put(self, key: int, value: int) -> None:
        if key in self.cache:
            self.cache.move_to_end(key)   # Refresh recency on update
        self.cache[key] = value
        if len(self.cache) > self.capacity:
            self.cache.popitem(last=False)  # Evict least recently used (front)

cache = LRUCache(capacity=3)
cache.put(1, "a")
cache.put(2, "b")
cache.put(3, "c")
cache.get(1)        # Access key 1 — moves to most-recently-used end
cache.put(4, "d")   # Cache full: evicts key 2 (least recently used)

print(list(cache.cache.keys()))  # [3, 1, 4]
```

#### Example: Access Pattern Visualization

```
Cache capacity: 3
Access sequence: A, B, C, D, A, B

Step | Access | Cache State (MRU -> LRU) | Action
-----|--------|--------------------------|--------
  1  |   A    |  [A]                     | Cold miss, insert A
  2  |   B    |  [B, A]                  | Cold miss, insert B
  3  |   C    |  [C, B, A]               | Cold miss, insert C
  4  |   D    |  [D, C, B]               | Miss, evict A (LRU), insert D
  5  |   A    |  [A, D, C]               | Miss, evict B (LRU), insert A
  6  |   B    |  [B, A, D]               | Miss, evict C (LRU), insert B
```

> **Exercises**
>
> 1. Given a cache of capacity 3 and the access sequence `[1, 2, 3, 1, 4, 2]`, trace through the LRU eviction step by step and identify every hit and miss.
> 2. Explain why LFU might be a poor choice for a cache serving a news website that publishes new articles throughout the day.
> 3. (Intermediate) Describe a workload where FIFO would perform as well as LRU. When would they produce identical eviction decisions?
> 4. (Interview) A junior engineer proposes replacing the team's LRU cache with LFU because the hit rate is low. What questions would you ask before agreeing? *(Hint: think about access patterns and how the low hit rate might be diagnosed.)*

> **Answers**
>
> 1. Trace (capacity = 3):
>    - Access 1: Miss. Cache: [1]
>    - Access 2: Miss. Cache: [2, 1]
>    - Access 3: Miss. Cache: [3, 2, 1]
>    - Access 1: **Hit**. Cache: [1, 3, 2] (1 moves to MRU)
>    - Access 4: Miss. Evict 2 (LRU). Cache: [4, 1, 3]
>    - Access 2: Miss. Evict 3 (LRU). Cache: [2, 4, 1]
>    Total: 1 hit, 5 misses. Hit rate: ~17%.
> 2. On a news site, freshly published articles receive a surge of traffic and are highly relevant, but they start with a frequency count of zero. LFU would be biased toward retaining older articles that accumulated high frequency counts over time, even if those articles are no longer being read. New popular content would be evicted before building up frequency, harming the hit rate for trending stories.
> 3. FIFO and LRU produce identical eviction decisions when every cached item is accessed exactly once and accesses occur in strict insertion order. In a purely sequential scan (access pattern: 1, 2, 3, 4, 5, 6, ...), neither policy has a recency advantage because every item has been accessed the same number of times (once). FIFO's simple age-ordering matches LRU's behavior when access order and insertion order are identical.
> 4. Questions to ask before switching to LFU:
>    - What is the access pattern? Is it skewed toward a small hot set (favors LFU) or uniformly random (neither helps)?
>    - Is the low hit rate caused by a capacity problem (cache too small), a cold start, or a genuine mismatch between the eviction policy and the workload?
>    - Are there frequently accessed "stale" items that LFU would retain too long?
>    - Has cache size been profiled relative to the working set size?
>    - Has cache key design been audited (e.g., are keys too granular, reducing the chance of repeated hits)?

---

### Cache Invalidation Strategies

#### Theory

Cache invalidation is widely considered one of the hardest problems in computer science. The difficulty stems from a fundamental tension: a cache improves performance by serving old data quickly, but the usefulness of cached data depends on how closely it mirrors the truth in the underlying system.

When the source data changes (a user updates their profile, a price changes, an order is placed), the cached copy becomes **stale**. Stale data served to users causes correctness bugs — displaying wrong prices, outdated inventory, or overridden settings. Cache invalidation is the process of ensuring stale data is removed or updated.

**Strategy 1: Purge on Write (Active Invalidation)**

When data changes in the database, the application immediately deletes or updates the corresponding cache entry. The next read will be a miss and will refresh the cache with the new value.

- Pros: Cache is never stale beyond the instant of a write. Straightforward to reason about.
- Cons: Requires write code to be cache-aware. In distributed systems, purging across multiple cache nodes is complex.

**Strategy 2: TTL-Based Expiry (Passive Invalidation)**

Every cache entry is assigned a Time-To-Live (TTL). After the TTL expires, the entry is automatically considered stale and will be refreshed on the next access. No write-path action is required.

- Pros: Simple to implement. Decouples cache invalidation from write logic.
- Cons: Data can be stale for up to the full TTL duration. Choosing the right TTL is difficult: too short and you lose cache benefits; too long and you serve stale data.

**Strategy 3: Event-Driven Invalidation**

Cache invalidation is triggered by domain events (e.g., a message on a queue like Kafka or an SNS notification). When a record changes, an event is published and a cache invalidation consumer deletes or refreshes the affected key.

- Pros: Decoupled architecture. Works well in microservice environments where different services own caches.
- Cons: Introduces messaging infrastructure. Eventual consistency — a small lag between the write and the invalidation event.

**Strategy 4: Version-Based / Cache Tags**

Instead of invalidating by key, entries are grouped by tags or versions. Updating a group version effectively invalidates all entries bearing that tag without deleting them individually.

- Pros: Efficient bulk invalidation (invalidate all entries for "category:electronics" with one version bump).
- Cons: More complex key design. Requires the cache layer to support tagging.

| Strategy | Staleness Window | Write-Path Coupling | Complexity |
|---|---|---|---|
| Purge on Write | Near-zero | High | Medium |
| TTL Expiry | Up to TTL | None | Low |
| Event-Driven | Near-zero | Low (via events) | High |
| Version/Tag-Based | Near-zero | Medium | Medium-High |

#### Example: Purge on Write (Python)

```python
cache: dict = {}

def update_user(user_id: int, new_data: dict):
    # 1. Update the source of truth
    db_write(user_id, new_data)

    # 2. Immediately invalidate the cache entry
    cache_key = f"user:{user_id}"
    cache.pop(cache_key, None)       # Delete; next read will be a cache miss and refresh

def get_user(user_id: int) -> dict:
    cache_key = f"user:{user_id}"
    if cache_key in cache:
        return cache[cache_key]      # Serve cached value
    data = db_read(user_id)
    cache[cache_key] = data          # Repopulate cache
    return data
```

> **Exercises**
>
> 1. A product page caches price data with a 10-minute TTL. A flash sale begins and prices drop. What is the worst-case scenario for a customer, and how long does it last?
> 2. Explain why purge-on-write in a distributed system with three cache replicas is more complex than in a single-node cache.
> 3. (Intermediate) A system uses event-driven invalidation via a message queue. The queue experiences a 30-second processing delay. Describe what happens during that delay from a user's perspective and from the system's perspective.
> 4. (Interview) You are designing a cache for a hotel booking platform. Prices update frequently, but availability (room count) must be accurate to prevent double-bookings. How would you apply different invalidation strategies to price vs. availability data? *(Hint: consider the cost of staleness for each data type.)*

> **Answers**
>
> 1. A customer could see the original (higher) pre-sale price for up to **10 minutes** after the flash sale begins — the full TTL duration. If the customer purchases at the stale cached price, the business must decide whether to honor the original price or the sale price. This is a real business risk. A short TTL (e.g., 60 seconds) or active invalidation triggered when the sale starts would reduce the window.
> 2. In a single-node cache, a purge is a single in-process operation. In a distributed system with three replicas, the application must send a delete command to all three nodes. This introduces: (a) the possibility of partial failure (two nodes invalidated, one still serving stale data), (b) network latency between the write and the purge reaching all nodes, and (c) race conditions where a new request re-populates a stale value on one node before all purges complete.
> 3. During the 30-second delay: users who request the affected data will receive the stale cached version (if the TTL has not expired) or the old database value (if the cache was already invalidated by TTL). The system is in a temporarily inconsistent state. Any data written between the event publication and queue processing will not yet be reflected in the cache. After 30 seconds, the consumer processes the invalidation event and the cache is corrected. For low-frequency updates this is usually acceptable; for high-frequency writes, queue backlog could cause prolonged staleness.
> 4. Differentiated strategy:
>    - **Prices:** Use a short TTL (e.g., 60 seconds) combined with active invalidation when prices are updated via the pricing service. Stale prices are annoying but recoverable — a user sees a slightly wrong price but the correct price is confirmed at checkout.
>    - **Availability (room count):** Do not cache availability in the traditional sense, or use a very short TTL (e.g., 5 seconds) with write-through updates. Better yet, treat availability as write-critical: decrement availability counts only in the transactional database and serve availability queries directly from the DB (or a strongly consistent read replica), bypassing a stale cache entirely. The cost of a double-booking far exceeds the cost of a slightly slower availability check.

---

### TTL and Expiry

#### Theory

Time-To-Live (TTL) is the simplest and most widely used cache invalidation mechanism. When a cache entry is created, it is assigned a duration (the TTL). After that duration elapses, the entry is considered expired. Depending on the implementation, expired entries are either:

- **Lazily evicted:** Removed on the next access attempt (the request discovers the entry is stale and triggers a refresh).
- **Actively evicted:** A background process periodically sweeps the cache and deletes expired entries proactively.

Most production caches (Redis, Memcached) combine both approaches: they check expiry on access (lazy) and run periodic sweeps to reclaim memory (active).

**Choosing a TTL**

TTL selection involves balancing two competing concerns:

- **Too short:** Cache entries expire quickly. Hit rates drop, and the origin (database, API) receives more traffic. The cache provides less benefit.
- **Too long:** Stale data is served for extended periods. Users see outdated information. In sensitive domains (pricing, inventory, auth tokens), this causes correctness errors.

Common heuristics:

| Data Type | Typical TTL Range | Rationale |
|---|---|---|
| Static assets (CSS, JS, images) | Hours to days | Change only on deployment |
| Session tokens | Minutes to hours | Security requires bounded lifetime |
| Product prices | 60–300 seconds | Balance freshness vs. DB load |
| User profile data | 5–15 minutes | Rarely changes, staleness is low-risk |
| Real-time dashboards | 1–10 seconds | Near-real-time, some lag acceptable |
| One-time tokens (password reset) | Seconds to minutes | Must expire quickly for security |

**Cache Stampede (Thundering Herd)**

A critical failure mode associated with TTL: when a popular cache entry expires, many concurrent requests simultaneously discover a miss and all attempt to regenerate the same data from the origin at once. This can overwhelm the database and cause cascading failures.

Mitigation strategies:
- **Probabilistic early expiration (PER):** Begin refreshing the entry before it actually expires, based on probability proportional to how close the TTL is to expiry.
- **Locking / Mutex:** Only one request regenerates the entry; others wait (or serve the stale value while the refresh happens).
- **Jitter:** Add random variation to TTLs so that entries for similar data do not all expire simultaneously.

#### Example: TTL with Jitter (Python)

```python
import time
import random

class TTLCache:
    def __init__(self):
        self._store: dict = {}         # {key: (value, expiry_timestamp)}

    def set(self, key: str, value, ttl_seconds: int, jitter: int = 0):
        # Add random jitter to avoid synchronized expiry across many keys
        actual_ttl = ttl_seconds + random.randint(0, jitter)
        expiry = time.monotonic() + actual_ttl
        self._store[key] = (value, expiry)

    def get(self, key: str):
        if key not in self._store:
            return None                # Never cached
        value, expiry = self._store[key]
        if time.monotonic() > expiry:
            del self._store[key]       # Lazy eviction: remove expired entry
            return None                # Treat as a miss
        return value

cache = TTLCache()
# Store "active_promo" for 5 minutes, with up to 30s of jitter
cache.set("active_promo", {"discount": 0.20}, ttl_seconds=300, jitter=30)
```

> **Exercises**
>
> 1. A cache entry has a TTL of 120 seconds. It was created at 14:00:00. Is it still valid at 14:01:59? At 14:02:01?
> 2. Explain, step by step, how a cache stampede occurs. What is the trigger, and what makes it dangerous?
> 3. (Intermediate) You are caching the result of a currency exchange rate API that you may call at most once per minute (rate limit). What TTL would you set, and why? What happens if the TTL is accidentally set to 50 seconds?
> 4. (Interview) A senior engineer suggests adding random jitter of ±10% to all TTLs in the system. A junior engineer objects that jitter makes the cache "inconsistent." Who is correct, and why? *(Hint: consider what jitter prevents and what "inconsistency" actually means here.)*

> **Answers**
>
> 1. Created at 14:00:00 with TTL of 120 seconds → expires at 14:02:00. At **14:01:59** (1 second before expiry): **still valid**. At **14:02:01** (1 second after expiry): **expired** — a cache miss will be returned and the entry should be refreshed.
> 2. Cache stampede steps:
>    1. A popular key (e.g., "homepage_featured_products") is cached with a TTL and expires at time T.
>    2. At time T, multiple concurrent requests (say, 500 requests/second arrive) all check the cache simultaneously and all receive a miss.
>    3. Each request independently decides it must regenerate the value — all 500 issue the same expensive database query or API call.
>    4. The origin (database) receives 500 simultaneous identical queries. This spike can saturate connection pools, cause query queue buildup, raise latency across the whole system, and potentially crash the database.
>    5. After the value is regenerated by many threads redundantly, all populate the cache — wasted compute. The danger is the sudden, concentrated load spike at the moment of expiry.
> 3. The API rate limit is once per 60 seconds, so the TTL should be set to **60 seconds** — matching the allowed refresh interval. If the TTL is accidentally set to **50 seconds**, the cached value expires 10 seconds before a new one can safely be fetched. During that 10-second window, every cache miss will attempt to call the API. If the rate limit is enforced strictly, these calls will be rejected with HTTP 429 errors, degrading or breaking the feature entirely.
> 4. The **senior engineer is correct**. Jitter does not cause logical inconsistency — it does not mean different users see different data from the same cache. It means that identical TTLs are spread slightly apart in time across many keys or instances. Without jitter, all cache entries created during a deployment or a traffic burst expire at the same time, triggering simultaneous stampedes. Jitter staggers expirations to smooth out the load. The junior engineer's concern about "inconsistency" confuses temporal distribution of expiry times with data consistency, which are unrelated concerns.

---

## 4.2 Caching Strategies

A caching strategy defines who is responsible for reading from and writing to the cache, when the cache is populated, and how it relates to the underlying data store. The right strategy depends on your read/write ratio, your tolerance for stale data, and where in your system the cache sits.

---

### Cache-Aside (Lazy Loading)

#### Theory

Cache-aside is the most common caching pattern. The application code manages the cache explicitly. The cache sits "aside" from the data flow — it is never involved automatically. The application is responsible for checking the cache, loading from the database on a miss, and writing to the cache.

**Read flow:**
1. Application checks the cache for the key.
2. If hit: return the cached value.
3. If miss: query the database, store the result in the cache, return the value.

**Write flow:**
1. Application writes the new value directly to the database.
2. Application either deletes the cache entry (invalidation) or updates it.

**Characteristics:**
- The cache is populated lazily — only data that is actually requested gets cached. This avoids wasting cache memory on data that is never read.
- On a cold start, the first N requests will all be cache misses until the working set is loaded. This causes a temporary performance degradation.
- The application must handle cache misses and write-through logic explicitly, making it more complex than transparent caching patterns.
- If the cache layer fails completely, the application continues to function (reading directly from the database), providing resilience.

#### Example: Cache-Aside Pattern (Python)

```python
import redis
import json

cache = redis.Redis(host="localhost", port=6379, decode_responses=True)

def get_user_profile(user_id: int) -> dict:
    cache_key = f"user:profile:{user_id}"

    # Step 1: Check cache
    cached = cache.get(cache_key)
    if cached:
        return json.loads(cached)   # Cache hit — return immediately

    # Step 2: Cache miss — query the database
    user = db.query("SELECT * FROM users WHERE id = %s", user_id)

    # Step 3: Populate cache for future requests (TTL of 5 minutes)
    cache.setex(cache_key, 300, json.dumps(user))

    return user

def update_user_profile(user_id: int, data: dict):
    # Write to the database first (source of truth)
    db.execute("UPDATE users SET ... WHERE id = %s", user_id)

    # Invalidate cache so next read fetches fresh data
    cache_key = f"user:profile:{user_id}"
    cache.delete(cache_key)
```

> **Exercises**
>
> 1. List the steps that occur when a cache-aside system receives a read request for data that has never been cached.
> 2. What happens to the system if the cache node crashes in a cache-aside architecture? Compare this to what would happen in a read-through architecture (covered in section 4.2.4).
> 3. (Intermediate) In a cache-aside pattern, if two concurrent requests both experience a cache miss for the same key, what problem can occur? What is this called, and how can it be mitigated?
> 4. (Interview) A team debates whether to delete a cache entry on write or update it with the new value. What is the safer default choice and why? *(Hint: consider race conditions between the write and the cache update.)*

> **Answers**
>
> 1. Steps for a cache-aside read miss:
>    1. Application receives read request for key K.
>    2. Application checks the cache — key K is not present (miss).
>    3. Application queries the underlying database for K.
>    4. Database returns the data.
>    5. Application serializes and stores the data in the cache with a TTL.
>    6. Application returns the data to the caller.
> 2. If the cache crashes in a **cache-aside** architecture, the application continues to function normally — it falls back to reading directly from the database for every request. Performance degrades (all requests bear full DB latency) but the system remains correct. In a **read-through** architecture, the cache is in the critical path. If the cache crashes and there is no fallback mechanism, the application cannot retrieve data at all. Read-through caches require higher-availability cache infrastructure.
> 3. Two concurrent requests both miss the cache for the same key and both issue a database query. Both receive the result and both attempt to write to the cache. This is called a **cache stampede** (or "dog-piling"). While less severe than the TTL-based stampede, it wastes database resources. It can be mitigated with a **cache lock**: the first request acquires a lock, loads the data, populates the cache, and releases the lock. Subsequent requests either wait for the lock or serve a slightly stale value during the loading period.
> 4. **Delete (invalidate) the cache entry** is the safer default. If you attempt to update the cache with the new value, a race condition can occur: a concurrent read might re-populate the cache with the old value after your write but before your cache update, leaving stale data in the cache indefinitely. Deleting the entry ensures the next read always fetches fresh data from the database. The tradeoff is one extra cache miss, but correctness is preserved.

---

### Write-Through Cache

#### Theory

In a write-through strategy, every write to the application goes through the cache layer first. The cache immediately writes the data to the underlying database synchronously before acknowledging the write to the caller. The cache and the database are always kept in sync.

**Write flow:**
1. Application writes new data to the cache.
2. The cache synchronously writes the data to the database.
3. Only after the database acknowledges the write does the cache acknowledge success to the application.

**Read flow:**
1. Application reads from the cache.
2. If hit: return cached data (always fresh, since writes go through the cache).
3. If miss: data may not have been written through this path — fetch from DB.

**Characteristics:**
- **Strong consistency:** The cache and database are never out of sync after a write completes successfully. There is no window of staleness created by writes.
- **Write latency:** Every write incurs both a cache write and a database write synchronously. Write latency equals the slower of the two (typically the database). This makes write-through unsuitable for write-heavy workloads.
- **Wasted cache space:** Data may be written to the cache and never read again, occupying space unnecessarily. A TTL on written entries mitigates this.
- Write-through is often combined with read-through (section 4.2.4) into a unified transparent cache layer.

```
Application
     |
     | write("user:1", data)
     v
  [Cache Layer]  ----sync write----> [Database]
     |
     | ACK (only after DB confirms)
     v
Application receives success
```

#### Example: Write-Through Cache (Python)

```python
class WriteThroughCache:
    def __init__(self, db_connection):
        self._cache: dict = {}
        self._db = db_connection

    def write(self, key: str, value) -> None:
        # 1. Write to cache
        self._cache[key] = value

        # 2. Synchronously write to DB — write is not complete until this succeeds
        self._db.write(key, value)
        # If db.write() raises an exception, the cache write above may leave
        # an inconsistent state. In practice, wrap this in a transaction or
        # rollback the cache write on failure.

    def read(self, key: str):
        if key in self._cache:
            return self._cache[key]    # Always consistent if written via write()
        return self._db.read(key)      # Fallback for keys not yet in cache
```

> **Exercises**
>
> 1. A system uses write-through caching. A user updates their email address. Trace the exact sequence of operations that occur.
> 2. Write-through adds latency to write operations. Under what circumstances is this tradeoff acceptable?
> 3. (Intermediate) Explain the "write amplification" problem in write-through caching and describe a scenario where it causes significant inefficiency.
> 4. (Interview) A write-through cache writes to both the cache and the database. What happens if the database write fails but the cache write succeeds? How should the system handle this state? *(Hint: think about atomicity and rollback.)*

> **Answers**
>
> 1. Sequence for email update with write-through:
>    1. User submits email change via the application.
>    2. Application calls `cache.write("user:profile:42", updated_data)`.
>    3. Cache layer stores the updated data in its own store.
>    4. Cache layer immediately issues a `UPDATE users SET email=... WHERE id=42` to the database.
>    5. Database commits and returns success.
>    6. Cache layer returns success to the application.
>    7. Application returns a success response to the user.
> 2. Write-through latency is acceptable when: (a) **read frequency far exceeds write frequency** — the read latency savings outweigh the write penalty; (b) **consistency is critical** — the domain cannot tolerate stale reads after writes (financial data, inventory counts); (c) **write volume is low** — write-through on a system that processes millions of writes per second would be impractical.
> 3. Write amplification: every write operation must be executed twice (once in the cache, once in the database). This is inefficient when data is written far more often than it is read. For example, a real-time IoT sensor publishing temperature readings every second to a user dashboard: if each reading is written through the cache but only 1% of readings are ever read (users only check current values), 99% of cache writes are wasted compute and memory churn. A write-behind or no-cache strategy would be more appropriate.
> 4. If the database write fails after the cache write succeeds, the cache contains data that does not exist in the database — a **split-brain inconsistency**. Handling options: (a) **Rollback the cache write** — delete or revert the cache entry in the error handler, so the next read fetches from the (consistent) database. This requires careful error handling but preserves correctness. (b) **Use a transactional cache** — some systems (e.g., Redis with Lua scripts or WATCH/MULTI/EXEC) allow atomic cache operations that can be rolled back. (c) **Accept eventual consistency** — mark the cache entry as "dirty" and retry the database write asynchronously. The key principle: the **database is the source of truth**, so a failed database write must not leave the cache in a permanently inconsistent state.

---

### Write-Behind Cache

#### Theory

Write-behind (also called write-back) is an asynchronous variant of write-through. When the application writes data, the cache stores it immediately and acknowledges success to the caller — without waiting for the database write to complete. The cache then asynchronously flushes the written data to the database in the background, typically after a short delay or when a buffer threshold is reached.

**Write flow:**
1. Application writes to the cache.
2. Cache immediately acknowledges success.
3. Cache adds the write to a "dirty" queue.
4. Background process drains the queue and writes to the database asynchronously.

**Characteristics:**
- **Low write latency:** The caller only waits for the cache write (fast in-memory operation). Write throughput can be dramatically higher than write-through.
- **Write coalescing:** Multiple rapid updates to the same key can be merged into a single database write. If a key is updated 100 times in 5 seconds, only the final value needs to be persisted — reducing DB write volume.
- **Risk of data loss:** If the cache node fails before the dirty queue is flushed to the database, those writes are permanently lost. This makes write-behind unsuitable for financial transactions or any data requiring durability guarantees.
- **Implementation complexity:** The dirty queue, flushing logic, and failure handling add significant operational complexity.

```
Application
     |
     | write("order:99", data)
     v
  [Cache Layer]  --> [Dirty Queue]  -->  (async flush)  -->  [Database]
     |
     | Immediate ACK (DB write not yet complete)
     v
Application continues (does not wait for DB)
```

#### Example: Write-Behind Cache (Python — simplified)

```python
import threading
import time

class WriteBehindCache:
    def __init__(self, db, flush_interval: float = 2.0):
        self._cache: dict = {}
        self._dirty: dict = {}         # Keys that have been written but not flushed
        self._db = db
        self._lock = threading.Lock()

        # Background flusher thread
        self._flusher = threading.Thread(target=self._flush_loop, daemon=True)
        self._flusher.start()

    def write(self, key: str, value) -> None:
        with self._lock:
            self._cache[key] = value   # Write to cache immediately
            self._dirty[key] = value   # Mark as dirty (needs DB flush)
        # Return immediately — no DB write here

    def _flush_loop(self):
        while True:
            time.sleep(2.0)            # Flush every 2 seconds
            with self._lock:
                dirty_snapshot = dict(self._dirty)
                self._dirty.clear()
            for key, value in dirty_snapshot.items():
                self._db.write(key, value)   # Async flush to database
```

> **Exercises**
>
> 1. List two use cases where write-behind caching is appropriate and two where it should be avoided.
> 2. Explain how write coalescing works and why it is beneficial for database performance.
> 3. (Intermediate) A write-behind cache has a flush interval of 5 seconds. The cache server loses power at second 3 of the interval. What data is at risk? How does this relate to the concept of RPO (Recovery Point Objective)?
> 4. (Interview) A team is building a multiplayer game leaderboard. Score updates happen thousands of times per second. They are debating write-through vs. write-behind. What factors should drive the decision? *(Hint: consider durability requirements and the cost of losing a score update.)*

> **Answers**
>
> 1. Appropriate use cases: (a) **Real-time analytics counters** (page view counts, click counts) — losing a few counts is acceptable, and high write throughput is critical. (b) **Session activity timestamps** (last-seen time) — minor data loss on failure is inconsequential. Avoid for: (a) **Financial transactions** — every write must be durably persisted; losing a payment record is unacceptable. (b) **Inventory management in e-commerce** — a lost write could cause overselling of out-of-stock items.
> 2. Write coalescing: if a key is written multiple times within the flush interval, only the most recent value is flushed to the database. Example: a product's "view count" is incremented 1,000 times in 5 seconds. Without coalescing, this means 1,000 `UPDATE` statements to the database. With write-behind coalescing, a single `UPDATE` sets the final value — a 1,000x reduction in write load. This is beneficial because it dramatically reduces database write pressure, enabling higher throughput and lower contention on hot rows.
> 3. If the flush interval is 5 seconds and the cache loses power at second 3, all writes made in the last 3 seconds (since the previous flush) are permanently lost. This is directly related to RPO: the **Recovery Point Objective** defines how much data loss is acceptable after a failure. A 5-second flush interval implies an RPO of up to 5 seconds. If the business requires RPO = 0 (no data loss), write-behind is unsuitable. If RPO = 5 seconds is acceptable (e.g., for non-critical telemetry), write-behind is fine.
> 4. Decision factors for the leaderboard:
>    - **Durability requirement:** Is it acceptable to lose the last few seconds of score updates if the cache crashes? For a casual game, yes. For a competitive esports tournament with prize money, no.
>    - **Write volume:** Thousands of writes per second makes write-through expensive (all hitting the database synchronously). Write-behind reduces this massively.
>    - **Read pattern:** Leaderboards are often read as aggregates, not individual scores. A short write-behind delay before aggregation may be imperceptible.
>    - **Recommendation:** For high-volume casual gaming, write-behind with a short flush interval (100–500 ms) and an accepted small RPO is a reasonable tradeoff. For competitive, prize-bearing events, write-through (or a persistent queue like Kafka with at-least-once delivery) is safer.

---

### Read-Through Cache

#### Theory

In a read-through strategy, the cache sits transparently in front of the database. The application only ever reads from the cache — it never reads from the database directly. On a cache miss, the cache layer itself is responsible for loading the data from the database, populating itself, and returning the value. The application code does not need to be aware of the database lookup.

**Read flow:**
1. Application requests key from the cache.
2. If hit: cache returns the value.
3. If miss: cache (not the application) queries the database, populates itself, and returns the value to the application.

**Comparison with Cache-Aside:**

| Aspect | Cache-Aside | Read-Through |
|---|---|---|
| Who handles miss logic | Application code | Cache layer |
| Application DB awareness | Yes | No |
| Code simplicity | More complex | Simpler |
| Cache infrastructure | Simpler | Requires cache-loader support |
| First-request behavior | Miss + manual load | Miss + automatic load |

Read-through is particularly powerful when combined with write-through: together they form a fully transparent cache layer that the application treats as its primary data store.

#### Example: Read-Through Cache (Java-style pseudocode)

```java
// Cache library with built-in read-through support (e.g., Caffeine with CacheLoader)
LoadingCache<String, UserProfile> cache = Caffeine.newBuilder()
    .maximumSize(10_000)
    .expireAfterWrite(5, TimeUnit.MINUTES)
    // CacheLoader: called automatically on cache miss
    .build(key -> {
        String userId = key.replace("user:profile:", "");
        return database.loadUserProfile(userId);  // Cache fetches from DB on miss
    });

// Application code — no explicit DB logic needed
UserProfile profile = cache.get("user:profile:42");  // Transparent: hit or miss handled internally
```

> **Exercises**
>
> 1. What is the primary advantage of read-through caching over cache-aside from the perspective of application code?
> 2. Read-through caches still experience cold misses on first access. Describe a technique to pre-warm a read-through cache before it receives production traffic.
> 3. (Intermediate) In a read-through cache, if the database is unavailable during a cache miss, what should the cache return? What are the options and tradeoffs?
> 4. (Interview) An engineer argues that read-through caching introduces a single point of failure because "if the cache is down, nothing works." How would you address this concern in a production system design? *(Hint: consider fallback mechanisms and cache availability.)*

> **Answers**
>
> 1. Read-through removes cache-miss handling logic from the application. In cache-aside, every read site in the application must check the cache, handle a miss, query the database, and populate the cache — duplicated across every service or function that needs the data. With read-through, that logic lives once in the cache configuration (the cache loader). Application code simply calls `cache.get(key)` and the cache handles everything else, resulting in cleaner, less error-prone application code.
> 2. Pre-warming a read-through cache: run a **warm-up job** before routing production traffic to the new cache instance. The job iterates over the expected "hot" key set (e.g., top 10,000 most accessed products, all active user sessions) and calls `cache.get(key)` for each. Since the cache uses a read-through loader, each call triggers a database fetch and populates the cache. By the time real users arrive, the working set is already resident. Alternatively, some systems support **cache snapshotting** — persisting the in-memory cache to disk and reloading it on startup (Redis RDB/AOF files support this).
> 3. Options when the database is unavailable during a miss:
>    - **Return an error:** The cache propagates the database exception to the caller. Correct but potentially disruptive.
>    - **Return a default/null value:** The cache returns an empty or default response. Avoids errors but risks silent data loss.
>    - **Return stale data (serve expired entries):** If the entry is expired but not yet evicted, serve the old value with a staleness warning. This is the most resilient option and is sometimes called "stale-while-revalidate." Redis supports this pattern.
>    - **Circuit breaker:** After repeated DB failures, the cache opens a circuit and serves stale or default values for all misses, preventing cascading failure.
>    The best choice depends on the domain: for user-facing reads, stale data is usually better than an error. For financial data, an error is safer than silently serving stale values.
> 4. The concern is valid but manageable. Production read-through caches are made resilient through:
>    - **Replication:** Redis Sentinel or Redis Cluster provide automatic failover. If the primary cache node fails, a replica is promoted. Downtime is typically seconds.
>    - **Client-side fallback:** The cache client library can be configured to fall back to direct database reads when the cache is unreachable, functioning like cache-aside temporarily.
>    - **Multiple replicas / sharding:** Distributing the cache across multiple nodes means no single node failure takes down the entire cache.
>    - **High availability SLAs:** Managed cache services (AWS ElastiCache, GCP Memorystore) provide 99.9%+ availability with automatic failover.
>    The key point: the engineer's concern assumes zero fault tolerance. Production caches are deployed as highly-available clusters, not single nodes.

---

### Refresh-Ahead Cache

#### Theory

Refresh-ahead (also called prefetch caching) proactively refreshes cache entries before they expire, based on predicted future access patterns. Rather than waiting for a TTL to expire and experiencing a cache miss, the system detects that an entry is approaching expiry and triggers a background refresh — so the next request always hits a warm, fresh cache entry.

**How it works:**

1. A cache entry is created with TTL T.
2. A threshold is defined: when the entry has been alive for a fraction of T (e.g., 80% of TTL), the system triggers a background reload.
3. The background reload fetches fresh data from the database and updates the cache entry.
4. Requests during and after the reload always hit the cache — there is no miss.

**Characteristics:**
- **Eliminates miss latency for hot keys:** Popular keys are never stale — they are refreshed while still valid.
- **Potential for wasted refreshes:** If a key is refreshed proactively but never accessed again, the refresh was wasted. Refresh-ahead works best for data with predictable, high access rates.
- **Complexity:** Requires a background refresh mechanism and careful threshold tuning. If the refresh threshold is too aggressive (e.g., 10% of TTL), refreshes happen unnecessarily frequently.
- Often implemented alongside read-through: the same cache loader used for miss handling is invoked proactively before TTL expiry.

```
Timeline:
  t=0    Entry created, TTL = 100s
  t=80   Refresh threshold reached (80%) → background reload triggered
  t=90   Background reload completes → new TTL starts
  t=100  Original TTL would have expired — but entry was already refreshed
  t=180  Next refresh threshold (80% of new TTL)...

Result: requests at t=95, t=100, t=105 all hit a warm cache (no miss)
```

> **Exercises**
>
> 1. What is the key difference between refresh-ahead and read-through with respect to when the database is queried?
> 2. Explain why refresh-ahead is poorly suited for caching user-specific data (e.g., each user's personal settings).
> 3. (Intermediate) A refresh-ahead cache has a TTL of 60 seconds and a refresh threshold at 75%. At what elapsed time is a refresh triggered? If the background reload takes 3 seconds, is there any window where a stale value could be returned?
> 4. (Interview) A refresh-ahead system is proactively refreshing 100,000 cache keys. The underlying database has a connection pool of 50. Describe the problem that could arise and how you would mitigate it. *(Hint: think about what happens when all 100,000 refresh timers fire simultaneously.)*

> **Answers**
>
> 1. In **read-through**, the database is queried reactively — only when a request arrives and finds a cache miss (after TTL expiry). In **refresh-ahead**, the database is queried proactively — before the TTL expires, triggered by a background timer when the entry approaches its expiry threshold. The result is that refresh-ahead eliminates miss latency for hot keys entirely, while read-through still incurs one miss per expiry cycle.
> 2. Refresh-ahead is poorly suited for user-specific data because it requires knowing in advance which keys to refresh. For 10 million users each with unique settings keys, proactively refreshing all of them would require 10 million database reads per TTL cycle — far more expensive than simply letting inactive users' entries expire. Refresh-ahead is most efficient when a small, predictable set of hot keys drives the majority of traffic (e.g., the homepage, top 100 products), not when the hot set is the entire user base.
> 3. TTL = 60 seconds, threshold = 75% → refresh triggered at **60 × 0.75 = 45 seconds** elapsed. If the background reload takes 3 seconds, it completes at second 48. The original TTL expires at second 60. Between seconds 45 and 48 (the 3-second reload window), if a request arrives, it receives the **still-valid but aging** cached value (the original entry has not expired yet). There is no stale window — the original entry is valid until second 60, and the refresh completes at second 48. As long as the reload completes before TTL expiry (reload time < 15 seconds in this case), no stale value is returned.
> 4. If all 100,000 cache entries were created at roughly the same time (e.g., after a deployment or cache flush), their 75% thresholds fire simultaneously. This causes 100,000 concurrent background refresh jobs, each trying to query the database — far exceeding the pool of 50 connections. The database connection pool is exhausted, refresh jobs queue or fail, and the cache may return stale or missing data. Mitigations: (a) **Jitter on TTL creation** — stagger the initial TTLs so refresh thresholds are spread over time. (b) **Rate-limited refresh queue** — background refreshes go into a queue processed at a controlled rate (e.g., 100 refreshes/second). (c) **Adaptive refresh** — only refresh keys that have been accessed recently, reducing the active refresh set.

---

## 4.3 Caching Technologies and Layers

Modern systems apply caching at multiple layers simultaneously. Understanding which technology to apply at which layer — and the tradeoffs each involves — is essential for designing performant, scalable systems.

---

### In-Memory Caches (Redis, Memcached)

#### Theory

In-memory caches store data in RAM on dedicated cache servers. Because RAM access is orders of magnitude faster than disk or network storage, they can serve hundreds of thousands to millions of requests per second with sub-millisecond latency. They are the backbone of most backend caching architectures.

**Redis**

Redis (Remote Dictionary Server) is a feature-rich, open-source in-memory data structure store. It supports strings, hashes, lists, sets, sorted sets, streams, and more. Beyond simple key-value caching, Redis is used for:
- Pub/Sub messaging
- Distributed locks
- Rate limiting
- Session storage
- Leaderboards (sorted sets)
- Task queues

Redis supports persistence (RDB snapshots and AOF logs), replication, and clustering. This makes it suitable for use cases that require durability and high availability.

**Memcached**

Memcached is a simpler, more focused in-memory key-value store. It supports only strings (blobs) and has no persistence, replication, or advanced data structures built in. Its simplicity makes it extremely fast and easy to scale horizontally (by adding more nodes). Memcached is appropriate when:
- Only simple key-value caching is needed.
- The cache is purely ephemeral (data loss on restart is acceptable).
- Horizontal scale-out is preferred over rich features.

| Feature | Redis | Memcached |
|---|---|---|
| Data structures | Rich (strings, hashes, lists, sets, sorted sets, etc.) | Strings only |
| Persistence | Yes (RDB + AOF) | No |
| Replication | Yes (master-replica) | No (client-side sharding only) |
| Clustering | Yes (Redis Cluster) | Client-side consistent hashing |
| Pub/Sub | Yes | No |
| Lua scripting | Yes | No |
| Multi-threading | Single-threaded core (I/O threaded in Redis 6+) | Fully multi-threaded |
| Ideal for | Feature-rich caching, sessions, queues, leaderboards | Simple, high-throughput key-value caching |

#### Example: Redis Caching (Python with redis-py)

```python
import redis
import json
from typing import Optional

r = redis.Redis(host="localhost", port=6379, decode_responses=True)

def get_product(product_id: int) -> dict:
    key = f"product:{product_id}"

    # Try cache first
    cached = r.get(key)
    if cached:
        return json.loads(cached)     # Deserialize JSON string back to dict

    # Miss: load from database
    product = db.fetch_product(product_id)

    # Cache with 10-minute TTL
    r.setex(key, 300, json.dumps(product))   # setex: SET with EXpiry

    return product

# Using Redis Sorted Set for a real-time leaderboard
def add_score(player_id: str, score: float):
    r.zadd("leaderboard:global", {player_id: score})   # Add/update score

def get_top_players(n: int = 10) -> list:
    # ZREVRANGE returns members sorted by score descending
    return r.zrevrange("leaderboard:global", 0, n - 1, withscores=True)
```

> **Exercises**
>
> 1. A team is choosing between Redis and Memcached for a session storage use case. Their sessions must survive cache node restarts. Which should they choose and why?
> 2. Redis is single-threaded (core processing). How can it achieve such high throughput despite this limitation?
> 3. (Intermediate) Describe a scenario where Memcached's horizontal scaling model (client-side sharding) has an operational advantage over Redis Cluster.
> 4. (Interview) You are designing a distributed rate limiter to enforce "no more than 100 API requests per user per minute." Which Redis data structure and commands would you use? *(Hint: think about atomic increment operations and expiry.)*

> **Answers**
>
> 1. **Redis** should be chosen. Session storage requires durability: if the cache node restarts and sessions are lost, all users are effectively logged out — a severe user experience issue. Redis's AOF (Append-Only File) persistence can be configured to persist every write to disk, ensuring session data survives restarts. Memcached has no persistence mechanism; data is permanently lost on restart.
> 2. Redis achieves high throughput despite single-threaded command processing because: (a) **All data is in RAM** — no disk I/O blocks the thread. (b) **I/O multiplexing (epoll/kqueue)** — a single thread handles thousands of concurrent network connections via non-blocking I/O. (c) **Command execution is extremely fast** — most Redis operations are O(1) or O(log N), completing in nanoseconds. The bottleneck is network I/O and serialization, not CPU computation. Redis 6+ also offloads network I/O to multiple threads, further improving throughput.
> 3. Memcached's client-side sharding advantage: each client is responsible for determining which node holds a given key (via consistent hashing). Adding a new Memcached node requires only updating the client configuration — no data migration, no cluster rebalancing. In Redis Cluster, adding a node requires resharding: slots must be redistributed across nodes, and keys must be migrated. For very large datasets with frequent horizontal scaling events (e.g., a system that adds cache nodes weekly), Memcached's simpler scaling model can be operationally lighter.
> 4. Rate limiting with Redis: use the **String** data type with atomic `INCR` and `EXPIRE` commands. For each user, key = `rate:user:{user_id}`. On each request: `INCR rate:user:123` (increments atomically). If the result is 1 (first request in the window), also call `EXPIRE rate:user:123 60` to set a 60-second window. If the result exceeds 100, reject the request. A more precise approach uses a **Sorted Set** with timestamps as scores (sliding window rate limiter): `ZADD rate:user:123 <timestamp> <request_id>`, then `ZREMRANGEBYSCORE` to remove entries older than 60 seconds, then `ZCARD` to count remaining entries.

---

### CDN Caching

#### Theory

A Content Delivery Network (CDN) is a geographically distributed network of edge servers (called Points of Presence, or PoPs) that cache content close to end users. Rather than every user fetching static assets from your origin server (which may be in a single data center on the other side of the world), the CDN serves that content from the nearest edge node.

CDNs primarily cache:
- Static assets: JavaScript, CSS, images, fonts, videos.
- API responses with appropriate cache headers.
- Entire HTML pages (for static or edge-rendered sites).

**How CDN Caching Works:**

1. User requests `https://example.com/logo.png`.
2. DNS resolves to the nearest CDN edge node (e.g., Frankfurt PoP for a user in Germany).
3. Edge node checks its cache for `logo.png`.
4. **Cache hit:** Edge node returns `logo.png` directly. No request reaches the origin server.
5. **Cache miss:** Edge node fetches `logo.png` from the origin server, caches it, and returns it to the user. Subsequent requests from nearby users hit the cache.

**Cache-Control Headers**

CDN caching behavior is controlled by HTTP headers sent by the origin server:

```
Cache-Control: public, max-age=86400
```

- `public`: The response can be cached by shared caches (CDN, proxies).
- `private`: The response is user-specific; only browser cache may store it (not CDN).
- `max-age=N`: Cache is valid for N seconds.
- `s-maxage=N`: CDN-specific max-age (overrides `max-age` for shared caches).
- `no-cache`: Must revalidate with origin before serving cached version.
- `no-store`: Do not cache at all.
- `stale-while-revalidate=N`: Serve stale content while fetching a fresh version in background.

#### Example: CDN Cache-Control Headers (HTTP)

```
# Static asset: cache aggressively for 1 year (immutable with content hash in filename)
Cache-Control: public, max-age=31536000, immutable

# API response: cache for 60 seconds at CDN, allow stale for 10s while revalidating
Cache-Control: public, s-maxage=60, stale-while-revalidate=10

# Private user data: do not cache at CDN
Cache-Control: private, no-store

# HTML page: revalidate every request, but serve stale if origin is slow
Cache-Control: public, max-age=0, must-revalidate
```

#### Example: CDN Cache Invalidation (AWS CloudFront)

```python
import boto3

def invalidate_cdn_cache(paths: list[str]):
    """Invalidate specific paths in a CloudFront distribution."""
    client = boto3.client("cloudfront")

    client.create_invalidation(
        DistributionId="E1234ABCDEF",
        InvalidationBatch={
            "Paths": {
                "Quantity": len(paths),
                "Items": paths          # e.g., ["/images/*", "/api/products"]
            },
            "CallerReference": "deploy-20240301-v2"  # Unique string to prevent duplicate invalidations
        }
    )

# Invalidate all product images after a content update
invalidate_cdn_cache(["/images/products/*"])
```

> **Exercises**
>
> 1. A CDN serves a JavaScript bundle with `Cache-Control: public, max-age=31536000`. The team deploys a bug fix to the bundle. How long will users see the old (buggy) bundle? How should this be addressed in the deployment pipeline?
> 2. Explain why user-specific API responses (e.g., `/api/me/profile`) should not be cached at the CDN level.
> 3. (Intermediate) A marketing team updates the homepage hero image. The CDN TTL is 24 hours and the change was made 2 hours ago. Describe two ways to ensure users see the new image without waiting 22 more hours.
> 4. (Interview) Explain the difference between `max-age` and `s-maxage` in a `Cache-Control` header. When would you use one vs. the other? *(Hint: consider shared vs. private caches.)*

> **Answers**
>
> 1. Without intervention, users who already have the bundle cached will see the old version for up to **1 year** (31,536,000 seconds). The standard solution is **cache busting via filename hashing**: the build pipeline generates a content hash and includes it in the filename (e.g., `app.a3f9c2d1.js`). When the code changes, the hash changes, the filename changes, and all users fetch the new file (a cold miss on the CDN for the new filename). The old filename's 1-year TTL is irrelevant because the new bundle has a new URL.
> 2. User-specific responses contain data that is unique to a single authenticated user. If `/api/me/profile` were cached at the CDN, the first user's profile response would be stored in the CDN cache. The next user to request the same URL would receive the first user's profile data — a severe data leak and privacy violation. CDNs cache by URL; they cannot differentiate between users unless the response includes `Cache-Control: private`, which instructs the CDN not to cache the response.
> 3. Two ways to force the updated image to appear:
>    - **CDN Invalidation:** Use the CDN's API (e.g., `aws cloudfront create-invalidation`) to explicitly purge the cached path (`/images/hero.jpg`). The CDN discards its cached copy and fetches fresh content from the origin on the next request. This typically propagates to all edge nodes within seconds to minutes.
>    - **Cache-Busting via Versioned URL:** Deploy the new image with a different filename or query parameter (e.g., `/images/hero.jpg?v=2` or `/images/hero-v2.jpg`). Update the HTML to reference the new URL. The CDN has no cached entry for the new URL, so it fetches from the origin — an immediate cold miss on all edges.
> 4. `max-age` applies to **all caches** — both shared caches (CDN, proxy) and private caches (browser). `s-maxage` applies **only to shared caches** (CDN, proxy) and overrides `max-age` for those caches. The browser still uses `max-age`. Use case: `Cache-Control: public, max-age=60, s-maxage=3600` — the browser caches the response for 60 seconds (short, because the user might navigate back quickly and should get reasonably fresh data), but the CDN caches it for 1 hour (reducing origin traffic for content that rarely changes). This allows different TTL policies for different cache types on the same response.

---

### Browser Caching

#### Theory

Every modern web browser maintains a local cache of HTTP responses. When a user visits a website, static resources (images, scripts, stylesheets, fonts) are downloaded and stored locally. On subsequent visits or page loads, the browser serves these resources from its local cache, avoiding network round-trips entirely. This is the closest cache to the user — it has zero network latency.

Browser caching is controlled by HTTP response headers set by the server:

**Key Headers:**

- **`Cache-Control`:** The primary directive. Specifies caching behavior, TTL, and visibility (public/private).
- **`ETag`:** A fingerprint (hash) of the response content. The browser sends the ETag back in subsequent requests via `If-None-Match`. If the content hasn't changed, the server responds with `304 Not Modified` (no body) — saving bandwidth.
- **`Last-Modified`:** Timestamp of when the content was last changed. Browser sends it back via `If-Modified-Since`. Server responds with `304` if unchanged.
- **`Expires`:** Legacy header specifying an absolute expiry date. Superseded by `Cache-Control: max-age`.

**Validation vs. Freshness:**

- **Fresh resource:** The cached copy is within its `max-age`. Browser uses it without any network request.
- **Stale resource:** The `max-age` has elapsed. Browser sends a **conditional request** to the server (using `If-None-Match` or `If-Modified-Since`). If the resource hasn't changed, server sends `304 Not Modified` (fast, no body). If it has changed, server sends `200 OK` with the new content.

```
Browser Cache Logic:

GET /styles/main.css
  |
  +-- Cached? No --> Fetch from server --> Cache response --> Render
  |
  +-- Cached? Yes --> Fresh (within max-age)? Yes --> Use cached copy
                                                  No --> Conditional request to server
                                                           |
                                                           +-- 304 Not Modified --> Use cached copy
                                                           +-- 200 OK --> Update cache --> Use new copy
```

#### Example: HTTP Response Headers for Browser Caching

```
# Versioned static asset (never changes at this URL)
HTTP/1.1 200 OK
Cache-Control: public, max-age=31536000, immutable
ETag: "abc123def456"
Content-Type: application/javascript

# HTML page (frequently changing, always validate)
HTTP/1.1 200 OK
Cache-Control: no-cache
ETag: "page-v42"

# Private user data (never cache)
HTTP/1.1 200 OK
Cache-Control: no-store
```

> **Exercises**
>
> 1. A user visits a page, then closes and reopens their browser and visits the same page 30 minutes later. The page's CSS has `Cache-Control: max-age=3600`. Is the CSS re-downloaded?
> 2. Explain the difference between `no-cache` and `no-store` in `Cache-Control`. Which is more restrictive?
> 3. (Intermediate) What is the purpose of an ETag, and how does it reduce bandwidth compared to always sending the full resource on expiry?
> 4. (Interview) A user reports that a deployed bug fix is not visible in their browser even though the server is serving the correct file. What are the possible causes, and what can the developer do to immediately force all users to receive the updated file? *(Hint: think about both the cache state and the cache-busting mechanism.)*

> **Answers**
>
> 1. **No, the CSS is not re-downloaded.** The `max-age=3600` means the cached copy is valid for 3,600 seconds (1 hour). The user returns 30 minutes (1,800 seconds) later — well within the TTL. The browser serves the CSS directly from its local cache with zero network traffic. Browser caches persist across browser restarts (they are stored on disk, not just in memory).
> 2. `no-cache` means "do not serve this from cache without revalidating with the server first." The resource may be stored, but every use requires a conditional request (If-None-Match / If-Modified-Since). If the server confirms it is unchanged (304), the cached copy is used. `no-store` means "do not store this response anywhere — not in browser cache, not in CDN, not in proxies." Every request must fetch the full resource from the server. **`no-store` is more restrictive.** Use `no-store` for sensitive data (bank account pages, authentication tokens). Use `no-cache` when you always want the latest version but are willing to use a conditional request for efficiency.
> 3. An ETag is a hash (or version identifier) of the resource content. When the browser's cached copy of a resource expires, instead of re-downloading the entire file, it sends a conditional request: `GET /app.js` with header `If-None-Match: "abc123"`. If the file has not changed, the server responds with `304 Not Modified` — no response body. The browser reuses its cached copy. Bandwidth saved = the size of the response body (could be hundreds of KB for large JS files). This is especially important for mobile users or slow connections where re-downloading unchanged large assets is wasteful.
> 4. Possible causes: (a) The browser's cache has a long `max-age` and the cached (buggy) version is still fresh — the browser is not even checking the server. (b) A CDN or proxy is caching the old file and serving it, so the correct file never reaches the user. (c) The user's browser has explicitly cached the buggy version and has not yet expired. Immediate remedies: (a) **Cache-busting via filename hash:** change the filename of the fixed asset (e.g., `app.a3f9c2.js` → `app.b7d81a.js`) and update the HTML reference. All users will fetch the new filename as a cold miss. (b) **CDN invalidation:** purge the path from the CDN so the new version is fetched from the origin. (c) **Instruct the user:** clear browser cache or use Ctrl+Shift+R (hard refresh). For permanent solutions, the team should adopt hashed filenames in the build pipeline to make this a non-issue for future deployments.

---

### Application-Level Caching

#### Theory

Application-level caching refers to caching implemented within the application process itself — in the same memory space as the application code, without a separate cache server. These are often called **in-process caches** or **local caches**.

Common implementations:
- A simple dictionary or map object (Python `dict`, Java `HashMap`).
- Purpose-built libraries with eviction and TTL support: Google Guava Cache (Java), Caffeine (Java), `cachetools` (Python), `node-cache` (Node.js).
- Framework-level caching abstractions (e.g., Spring Cache, Django's per-view caching).

**When to use application-level caching:**
- Caching the result of expensive in-process computations (parsing, regex compilation, deserialization).
- Caching configuration or feature flags that are read thousands of times per request.
- Reducing round-trips to a shared Redis/Memcached cache for extremely hot keys (L1 in-process cache in front of an L2 distributed cache).
- Applications with a small, stable working set that fits in process memory.

**Tradeoffs:**

| Aspect | Application Cache | Distributed Cache (Redis) |
|---|---|---|
| Latency | ~nanoseconds (in-process) | ~0.5–2 ms (network) |
| Consistency | Per-instance (each instance has its own copy) | Shared across all instances |
| Memory | Limited to application heap | Dedicated, scalable |
| Cache invalidation | Must notify all instances (complex) | Single invalidation point |
| Suitable for | Immutable or slowly-changing data | Frequently changing, shared data |

**The multi-instance problem:** In a horizontally scaled application (10 instances running), each instance has its own in-process cache. If a key is updated, only the instance that processed the write invalidates its local copy. The other 9 instances continue to serve stale data from their local caches until TTL expiry. This is acceptable for truly immutable data but problematic for mutable data.

#### Example: Application-Level Cache (Python with cachetools)

```python
from cachetools import TTLCache, cached
from cachetools.keys import hashkey

# TTLCache: max 500 entries, each valid for 60 seconds
config_cache = TTLCache(maxsize=500, ttl=60)

@cached(cache=config_cache, key=lambda feature_flag: hashkey(feature_flag))
def get_feature_flag(feature_flag: str) -> bool:
    """Cached feature flag lookup — DB is only hit once per flag per 60 seconds."""
    return db.query("SELECT enabled FROM feature_flags WHERE name = %s", feature_flag)

# Compiled regex: expensive to compile, cheap to cache indefinitely in-process
import re
_regex_cache: dict[str, re.Pattern] = {}

def get_compiled_regex(pattern: str) -> re.Pattern:
    if pattern not in _regex_cache:
        _regex_cache[pattern] = re.compile(pattern)    # Compile once, reuse forever
    return _regex_cache[pattern]
```

> **Exercises**
>
> 1. An application runs 8 instances behind a load balancer. Each instance has an in-process TTL cache for user roles with a TTL of 5 minutes. A user's role is changed from "viewer" to "admin." What is the worst-case time before all instances reflect the change?
> 2. Name two types of data that are ideal candidates for application-level caching (as opposed to a distributed cache), and explain why.
> 3. (Intermediate) Describe a "two-level cache" architecture using both application-level and distributed caching. What is the purpose of each level?
> 4. (Interview) A Python web application notices that the same external API (weather data) is being called 10,000 times per second across all instances, even though the data changes only once per minute. Propose a solution using both application-level and distributed caching. *(Hint: think about what each layer saves.)*

> **Answers**
>
> 1. Worst case: **5 minutes**. Each instance checks its own local cache independently. If an instance's cache entry for this user was populated just before the role change (e.g., 1 second before), it will not expire for another ~299 seconds. All 8 instances have independent TTL timers, and the last one to expire could take up to the full 5-minute TTL. During that window, that instance may grant or deny access incorrectly based on the old role. For security-sensitive role changes, application-level caching with a long TTL is risky; active invalidation via a pub/sub channel (e.g., Redis pub/sub broadcast to all instances) is safer.
> 2. Ideal candidates for application-level caching:
>    - **Compiled regular expressions:** Regex compilation is CPU-intensive and the compiled object is immutable. There is no shared-state concern. Every instance benefits from compiling each pattern once and reusing the compiled object for the lifetime of the process.
>    - **Application configuration / feature flags:** Configuration is read thousands of times per request cycle but changes very rarely (once per deployment or on-demand feature toggle). The slight staleness risk (TTL of 60 seconds) is acceptable, and caching in-process eliminates thousands of Redis round-trips per second per instance.
> 3. Two-level cache architecture:
>    - **L1 (application-level):** An in-process cache (e.g., TTLCache with 10-second TTL) within each application instance. Serves the most recently accessed keys with nanosecond latency — no network I/O.
>    - **L2 (distributed cache, Redis):** A shared Redis cluster with a 5-minute TTL. When L1 misses, the application checks Redis before going to the database. Shared across all instances, so invalidation is centralized.
>    - **Purpose:** L1 handles the ultra-hot repeat reads (the same key accessed 1,000 times per second on one instance) without hitting Redis. L2 handles cross-instance sharing and reduces database load. The database is only hit on an L2 miss.
> 4. Solution using two cache levels:
>    - **L1 (in-process, per instance):** Cache the weather API response in each instance's memory with a TTL of 30 seconds. If a single instance handles 1,000 requests/second and the weather data is the same for all requests, the in-process cache reduces API calls from 1,000/s to ~1 per 30 seconds per instance. But with 10 instances, that's still 10 calls per 30 seconds = ~0.33 calls/second to the next layer. No network overhead.
>    - **L2 (distributed, Redis):** Cache the weather API response in Redis with a TTL of 60 seconds. On an in-process cache miss, all instances check Redis before calling the external API. The first instance to miss Redis fetches from the weather API, stores in Redis, and all other instances pick it up from Redis on their L1 miss. Total external API calls: at most 1 per 60 seconds regardless of instance count. This respects the "once per minute" nature of the data and nearly eliminates direct API calls.

---

### Database Query Caching

#### Theory

Database query caching refers to storing the results of database queries so that identical queries can be served without re-executing them against the database. This can occur at several levels:

**Level 1: Database Internal Query Cache**

Some databases (older MySQL versions) had a built-in query cache. When an identical SQL query was received, the database returned the cached result instead of re-executing the query plan. This was removed in MySQL 8.0 because it caused significant contention under concurrent write workloads — every write to a table had to invalidate all cached queries touching that table.

**Level 2: ORM-Level / Application-Level Query Caching**

ORM frameworks (Hibernate, SQLAlchemy) may cache query results within the application layer. This works well for read-heavy, rarely-changing data but requires careful invalidation when underlying records change.

**Level 3: External Cache Layer (Redis / Memcached)**

The most common and effective approach: the application caches query results in Redis or Memcached using a key derived from the query parameters. This is essentially cache-aside (section 4.2.1) applied specifically to database query results.

**Key design for query caching:**

Cache keys must uniquely identify the query and its parameters:

```
# Single record by ID
user:{user_id}                        → SELECT * FROM users WHERE id = ?

# Paginated list
products:category:{cat_id}:page:{n}  → SELECT * FROM products WHERE category_id=? LIMIT 20 OFFSET ?

# Aggregation result
stats:daily_signups:{date}            → SELECT COUNT(*) FROM users WHERE created_at::date = ?
```

**Invalidation challenge:** When a record changes, all cache keys that might include that record must be invalidated. For a single-record key this is trivial. For collection/aggregation keys, it is far more complex — you may not know which paginated or aggregated keys are affected by a single row update. Common approaches:
- Use short TTLs for collection keys and accept brief staleness.
- Use version-based keys (increment a "category version" counter; include it in the cache key — updating the counter invalidates all derived keys).
- Use event-driven invalidation triggered by database change events (CDC — Change Data Capture).

#### Example: Database Query Cache with Redis (Python)

```python
import redis
import json
import hashlib

r = redis.Redis(decode_responses=True)

def cached_query(sql: str, params: tuple, ttl: int = 60):
    """Generic query cache wrapper using SQL + params as cache key."""
    # Create a deterministic cache key from the SQL and parameters
    key_source = f"{sql}:{json.dumps(params, sort_keys=True)}"
    cache_key = "query:" + hashlib.md5(key_source.encode()).hexdigest()

    # Check cache
    cached = r.get(cache_key)
    if cached:
        return json.loads(cached)       # Return deserialized cached result

    # Execute query
    result = db.execute(sql, params)

    # Cache result
    r.setex(cache_key, ttl, json.dumps(result))

    return result

# Usage: cache the result of this exact query for 60 seconds
users = cached_query(
    sql="SELECT id, name, email FROM users WHERE role = %s ORDER BY created_at DESC LIMIT 50",
    params=("admin",),
    ttl=60
)
```

> **Exercises**
>
> 1. MySQL's built-in query cache was removed in version 8.0. What was the primary reason for its removal?
> 2. A cache key is `products:list:page:1`. A new product is added to the database. How does this affect the cached result, and how should the system handle it?
> 3. (Intermediate) Design a cache key schema for a blog application. The application needs to cache: (a) a single post by ID, (b) a list of the 10 most recent posts, (c) the total post count per category. Include invalidation considerations for each.
> 4. (Interview) A reporting dashboard runs an expensive SQL aggregation query (30-second execution time) that is requested by 500 users simultaneously each morning. Describe a complete caching strategy for this query, including key design, TTL choice, and how you would handle the first user's experience. *(Hint: consider the stampede problem and how to decouple the slow query from the user-facing request.)*

> **Answers**
>
> 1. MySQL's query cache was removed because it became a **global serialization point** under write-heavy workloads. Every `INSERT`, `UPDATE`, or `DELETE` on a table required invalidating all cached queries that touched that table — holding a global lock while doing so. Under concurrent write workloads, this lock caused severe contention and actually reduced overall throughput. The cache that was meant to speed up reads was slowing down the entire database. Application-level caches (Redis) avoid this because invalidation is handled selectively by the application rather than globally by the database engine.
> 2. The cached result for `products:list:page:1` is now stale — it reflects the list of products before the new product was added. If the new product would appear on page 1 (e.g., sorted by `created_at DESC`), the cached result does not include it. Options: (a) **Delete the cache key** on write — the next page 1 request fetches a fresh result. (b) **Accept staleness for the TTL duration** — if the TTL is short (30 seconds), the new product appears with a slight delay. (c) **Publish a cache invalidation event** — the product write service publishes an event; a consumer deletes all `products:list:*` keys. Option (a) or (c) is correct for data where freshness matters.
> 3. Cache key schema for a blog:
>    - **(a) Single post by ID:** Key: `post:{post_id}`. Invalidation: on update or delete of post with that ID, delete `post:{post_id}`. Simple 1:1 mapping.
>    - **(b) 10 most recent posts:** Key: `posts:recent:10`. Invalidation: whenever any post is created, updated, or deleted, delete `posts:recent:10` (the list may change). Accept that this key is invalidated frequently and use a short TTL (30–60 seconds) as a fallback.
>    - **(c) Post count per category:** Key: `posts:count:category:{category_id}`. Invalidation: when a post is created or deleted in category X, delete `posts:count:category:{X}`. Changes to other categories do not affect this key.
> 4. Complete caching strategy for the 30-second reporting query:
>    - **Key design:** `report:morning_summary:{date}` — includes the date to automatically scope the cache to the specific day's data.
>    - **TTL:** 1 hour (or until end of business day). The underlying data for a date is unlikely to change after the report is generated; staleness is acceptable.
>    - **Stampede prevention:** Use a **mutex/lock** (Redis `SET NX` — set if not exists) to ensure only one request executes the 30-second query. The first user acquires the lock and triggers the query. Subsequent requests either: (a) poll briefly (e.g., retry every 500 ms) until the cache is populated, or (b) are given a "report generating" response with a polling endpoint to check back.
>    - **Pre-generation (best UX):** Schedule a cron job to run the query at 07:50 AM (before the 08:00 AM user surge) and populate the cache proactively. By the time users arrive, the 30-second query has already completed and the cache is warm. All 500 concurrent users hit the cache instantly with sub-millisecond latency.
>    - **First user experience without pre-generation:** The first user triggers the cache miss and sees a loading state. The query runs for 30 seconds. Once complete, the cache is populated and the result is returned. All 499 subsequent users receive the cached result immediately.

# Chapter 5: Load Balancing and Traffic Management

Modern distributed systems rarely run on a single server. As user traffic grows, applications must spread that load across multiple machines to remain fast, reliable, and available. This chapter covers the core mechanisms that make that possible: how traffic is distributed across servers, how requests are routed through networks, and how individual services protect themselves when things go wrong. Mastering these concepts is essential for designing systems that scale gracefully and recover from failure automatically.

---

## 5.1 Load Balancing Concepts

A load balancer sits between clients and a pool of backend servers, deciding which server should handle each incoming request. Without one, all traffic hits a single server until it becomes a bottleneck — or crashes entirely. This section covers what load balancers do, how they operate at different network layers, the strategies they use to distribute work, and how they detect when a server is no longer healthy.

---

### What is a Load Balancer

#### Theory

Imagine a busy restaurant with multiple cashiers. Without a host directing customers, everyone queues at the first cashier they see, while others stand idle. A host (the load balancer) observes the queues and directs each new customer to the least busy cashier.

A **load balancer** is a component that accepts incoming client connections and forwards them to one of several backend servers (often called an *upstream pool* or *server farm*). Its primary goals are:

- **Horizontal scalability** — add more servers behind the load balancer rather than buying a bigger single machine.
- **High availability** — if one server fails, the load balancer stops sending traffic to it and distributes the load among healthy servers.
- **Performance** — spread requests so no single server becomes a bottleneck.

Load balancers can be implemented as dedicated hardware appliances (e.g., F5 BIG-IP), software running on commodity hardware (e.g., HAProxy, NGINX), or cloud-managed services (e.g., AWS Elastic Load Balancer, GCP Cloud Load Balancing).

```
Client Requests
      |
      v
+------------+
|  Load      |   <-- Single entry point (Virtual IP / DNS name)
|  Balancer  |
+------------+
   /    |    \
  v     v     v
[S1]  [S2]  [S3]   <-- Backend server pool
```

#### Examples

A minimal NGINX configuration acting as a load balancer:

```nginx
# /etc/nginx/nginx.conf

http {
    upstream backend_pool {
        server 10.0.0.1:8080;   # Server 1
        server 10.0.0.2:8080;   # Server 2
        server 10.0.0.3:8080;   # Server 3
    }

    server {
        listen 80;

        location / {
            proxy_pass http://backend_pool;   # Forward all requests to the pool
        }
    }
}
```

> Exercises

1. (Beginner) Name two problems that arise when a high-traffic web application runs on a single server.
2. (Beginner) What is the difference between a hardware load balancer and a software load balancer? Give one advantage of each.
3. (Intermediate) A company runs three application servers. Server 1 handles 80% of requests and is often at 95% CPU, while Servers 2 and 3 sit at 20%. The team says "we have a load balancer." What might be misconfigured, and what would you check first?
4. (Interview) Explain the concept of a Virtual IP (VIP) and why it is important in a load-balanced architecture. *(Hint: think about what happens to clients when the load balancer itself is replaced or fails over.)*

#### Answers

1. A single server creates a **bottleneck** — its CPU, memory, and network bandwidth are finite. It is also a **single point of failure**: if it crashes, the entire application becomes unavailable.
2. A **hardware load balancer** (e.g., F5) is purpose-built silicon optimized for high throughput with very low latency — advantage: raw performance at millions of connections per second. A **software load balancer** (e.g., HAProxy, NGINX) runs on standard servers — advantage: lower cost, easy to configure, and horizontally scalable.
3. The load balancing algorithm is likely **round-robin** or misconfigured, but the more likely issue is that **sticky sessions** or **IP Hash** is directing the same heavy clients to Server 1. You would first inspect the load balancer's access logs to see the distribution of requests per upstream, then review the balancing algorithm and session-persistence settings.
4. A **Virtual IP (VIP)** is a single IP address that clients connect to, owned by the load balancer (or a floating IP shared between a pair of load balancers). Clients never need to know the real IPs of backend servers. When a load balancer fails or is replaced, the VIP is reassigned to a standby, and clients continue connecting to the same address without any reconfiguration. This decouples clients from the physical topology of the backend.

---

### Layer 4 vs Layer 7 Load Balancing

#### Theory

The OSI model organizes networking into layers. Load balancers can operate at two practically significant layers:

| Feature | Layer 4 (Transport) | Layer 7 (Application) |
|---|---|---|
| Works on | TCP/UDP packets | HTTP/HTTPS, gRPC, WebSocket |
| Reads | IP addresses, ports | Headers, URLs, cookies, body |
| Routing decisions | Source/dest IP and port | URL path, Host header, JWT claim |
| TLS termination | No (pass-through) | Yes |
| Performance | Faster (less inspection) | Slightly higher overhead |
| Use cases | Generic TCP services, databases | Web apps, APIs, microservices |

**Layer 4 (L4) load balancing** operates at the transport layer. The load balancer sees IP addresses and port numbers but does not read the HTTP payload. It simply forwards the TCP stream to a chosen backend. This is very fast because there is minimal parsing.

**Layer 7 (L7) load balancing** operates at the application layer. The load balancer fully parses the HTTP request, which allows for sophisticated routing decisions:

- Route `/api/*` to the API server pool and `/static/*` to a CDN origin pool.
- Route requests with `X-Beta-User: true` header to a canary deployment.
- Terminate TLS at the load balancer, so backends receive plain HTTP.

#### Examples

**Layer 4 — HAProxy TCP mode:**

```haproxy
frontend tcp_frontend
    bind *:3306          # Listen on the MySQL port
    mode tcp             # Operate at Layer 4 — no HTTP parsing
    default_backend mysql_servers

backend mysql_servers
    mode tcp
    balance roundrobin
    server db1 10.0.1.1:3306 check
    server db2 10.0.1.2:3306 check
```

**Layer 7 — NGINX path-based routing:**

```nginx
upstream api_servers {
    server 10.0.2.1:8080;
    server 10.0.2.2:8080;
}

upstream static_servers {
    server 10.0.3.1:80;
}

server {
    listen 443 ssl;                          # L7: TLS is terminated here

    location /api/ {
        proxy_pass http://api_servers;       # Route /api/* to API pool
    }

    location /static/ {
        proxy_pass http://static_servers;    # Route /static/* to asset pool
    }
}
```

> Exercises

1. (Beginner) Can a Layer 4 load balancer route requests based on the URL path (e.g., `/checkout` vs `/search`)? Why or why not?
2. (Beginner) What does "TLS termination" mean, and at which layer does it typically occur?
3. (Intermediate) You need to load balance WebSocket connections and HTTP/1.1 REST API traffic simultaneously. Would you prefer L4 or L7? What are the tradeoffs?
4. (Interview) A security team wants to inspect and block requests containing a specific HTTP header before they reach backend servers. Which OSI layer must the load balancer operate at, and why? *(Hint: consider what each layer can and cannot see.)*

#### Answers

1. No. An L4 load balancer operates on TCP/IP packets and does not parse the HTTP payload. The URL path is part of the HTTP request body, which is invisible at Layer 4. Routing by URL path requires an L7 load balancer.
2. **TLS termination** is the process of decrypting an incoming TLS (HTTPS) connection at the load balancer so that backend servers receive unencrypted HTTP traffic. It typically occurs at Layer 7, because TLS wraps the HTTP payload — to read headers and URLs, the load balancer must decrypt the traffic first.
3. L7 is generally preferred because: (a) WebSocket connections begin as HTTP Upgrade requests, which an L7 balancer can handle correctly by maintaining the persistent connection; (b) L7 allows path-based routing for REST endpoints. The tradeoff is slightly higher latency due to full HTTP parsing, and the load balancer must handle TLS termination if used. For pure performance (millions of concurrent TCP connections), L4 could be used in front of separate L7 balancers for each protocol type.
4. The load balancer must operate at **Layer 7 (Application)**. HTTP headers are part of the HTTP protocol payload, which is encrypted inside TLS and only visible after decryption. An L4 balancer forwards the raw TCP byte stream without parsing it and therefore cannot inspect or act on HTTP headers. The L7 balancer decrypts TLS, parses the full HTTP request, inspects headers, and can drop or redirect the request before proxying it to a backend.

---

### Load Balancing Algorithms (Round Robin, Least Connections, IP Hash)

#### Theory

Once a load balancer decides that a request should go to one of the backend servers, it must pick *which* server. The selection strategy is the **load balancing algorithm**. Different algorithms make different tradeoffs between simplicity, fairness, and stickiness.

**Round Robin**
The simplest algorithm. Requests are distributed in a rotating order: S1, S2, S3, S1, S2, S3, ... It assumes all servers are equally powerful and that all requests are equally expensive — neither is always true.

**Weighted Round Robin**
Assigns a numeric weight to each server proportional to its capacity. A server with weight 3 receives three times as many requests as one with weight 1.

**Least Connections**
Instead of rotating blindly, the load balancer sends each new request to the server with the fewest active connections. Better suited to workloads where requests have highly variable processing times (e.g., some requests take 1 ms, others take 10 s).

**Weighted Least Connections**
Combines capacity weights with active connection counts. The server with the lowest ratio of `active_connections / weight` is chosen.

**IP Hash (Source IP Affinity)**
The client's IP address is hashed to deterministically select a backend server. The same client IP always maps to the same server (unless that server is removed from the pool). This provides a simple form of session persistence without requiring cookies.

**Random with Two Choices (Power of Two)**
Two servers are chosen at random, and the one with fewer active connections is selected. This approximates Least Connections with lower coordination overhead in distributed load balancers.

| Algorithm | State needed | Best for | Weakness |
|---|---|---|---|
| Round Robin | None | Uniform requests, identical servers | Ignores server load |
| Weighted Round Robin | Weights | Mixed-capacity servers | Still ignores real-time load |
| Least Connections | Active connection count | Long-lived or variable requests | Coordination overhead |
| IP Hash | Hash function | Session persistence | Uneven distribution if few IPs |
| Power of Two | Active connections (sampled) | Large distributed load balancers | Approximate, not optimal |

#### Examples

A simulation in Python illustrating Round Robin and Least Connections:

```python
from collections import deque

servers = ["S1", "S2", "S3"]

# --- Round Robin ---
rr_queue = deque(servers)

def round_robin():
    server = rr_queue[0]
    rr_queue.rotate(-1)   # Move the front element to the back
    return server

# --- Least Connections ---
# Maps server name -> current active connection count
active_connections = {"S1": 0, "S2": 0, "S3": 0}

def least_connections():
    # Pick the server with the minimum active connections
    return min(active_connections, key=active_connections.get)

def release_connection(server):
    active_connections[server] -= 1

# Simulate 6 requests
for i in range(1, 7):
    chosen = round_robin()
    print(f"Request {i} -> {chosen} (Round Robin)")

print()

# Simulate: S1 is busy with 3 ongoing connections before new requests arrive
active_connections = {"S1": 3, "S2": 1, "S3": 0}
for i in range(1, 4):
    chosen = least_connections()
    active_connections[chosen] += 1   # Increment on assignment
    print(f"Request {i} -> {chosen} (Least Connections) | State: {active_connections}")
```

Expected output:
```
Request 1 -> S1 (Round Robin)
Request 2 -> S2 (Round Robin)
Request 3 -> S3 (Round Robin)
Request 4 -> S1 (Round Robin)
Request 5 -> S2 (Round Robin)
Request 6 -> S3 (Round Robin)

Request 1 -> S3 (Least Connections) | State: {'S1': 3, 'S2': 1, 'S3': 1}
Request 2 -> S2 (Least Connections) | State: {'S1': 3, 'S2': 2, 'S3': 1}
Request 3 -> S3 (Least Connections) | State: {'S1': 3, 'S2': 2, 'S3': 2}
```

> Exercises

1. (Beginner) You have three servers: S1 (16-core), S2 (8-core), S3 (8-core). Which algorithm would you choose, and what weights would you assign?
2. (Beginner) A user's shopping cart is stored in memory on whatever server handles their first request. Which algorithm would you use to ensure subsequent requests from that user hit the same server?
3. (Intermediate) A load balancer uses Round Robin across 3 servers. A new long-running WebSocket connection is established every second for 10 seconds. After 30 seconds, how many active long-lived connections does each server hold? What algorithm would have produced a more even distribution during the spike?
4. (Interview) Explain why IP Hash can produce uneven load distribution in practice. In what scenario is this most problematic? *(Hint: consider who sits between the user and the server.)*

#### Answers

1. **Weighted Round Robin** with weights S1=2, S2=1, S3=1. S1 has twice the cores of S2 and S3, so it should handle twice the share of requests.
2. **IP Hash**. The client's IP is hashed to a consistent server, so all requests from that IP go to the same server where the in-memory cart data lives. (Sticky sessions via cookies are a more robust alternative for cart state.)
3. With Round Robin across 3 servers and 1 connection/second for 10 seconds: each server receives connections at positions 1,4,7,10 (S1: 4), 2,5,8 (S2: 3), 3,6,9 (S3: 3). After 30 seconds (assuming connections stay open), S1 holds 4, S2 and S3 hold 3. **Least Connections** would have produced a more even result because as each server accumulates connections it becomes less likely to be selected, naturally balancing the long-lived connection count.
4. IP Hash distributes based on source IP addresses. In practice, many users sit behind **NAT (Network Address Translation)** — a corporate firewall, office router, or mobile carrier — so thousands of users share a single external IP. All of those users hash to the same backend server, causing severe imbalance. This is most problematic in B2B SaaS applications where large enterprise customers route through a single corporate IP, potentially sending 10,000+ users to one server.

---

### Sticky Sessions

#### Theory

Many applications store session state — shopping carts, authentication tokens, upload progress — in the memory of the server that handled the first request. If a subsequent request from the same user lands on a different server, that state is missing and the user's session breaks.

**Sticky sessions** (also called **session persistence** or **session affinity**) solve this by ensuring all requests from a given client are consistently routed to the same backend server.

The two most common mechanisms are:

**Cookie-based stickiness**
On the first request, the load balancer injects a cookie (e.g., `SERVERID=S2`) into the HTTP response. On subsequent requests, the browser sends this cookie, and the load balancer reads it to route back to S2.

**IP-based stickiness**
Uses the client's source IP address as the routing key (equivalent to IP Hash). Simpler, but shares IP Hash's weaknesses with NAT.

**Drawbacks of sticky sessions:**
- Defeats the purpose of load balancing if one server has a disproportionate number of heavy sessions.
- When a server fails or is removed from the pool, all sessions pinned to it are lost.
- Complicates horizontal scaling — adding new servers does not relieve existing sessions.

The preferred modern approach is to **externalize session state** to a shared store (e.g., Redis, Memcached) so any backend server can serve any request. Sticky sessions become unnecessary.

```
Without sticky sessions (stateless):
  Client --> LB --> Any server --> Redis (shared session store)

With sticky sessions (stateful):
  Client --> LB --> Same server always --> In-memory session
```

#### Examples

Configuring cookie-based sticky sessions in HAProxy:

```haproxy
backend web_servers
    balance roundrobin
    cookie SERVERID insert indirect nocache   # Insert a cookie named SERVERID
    server s1 10.0.0.1:80 check cookie s1    # Cookie value "s1" maps to this server
    server s2 10.0.0.2:80 check cookie s2    # Cookie value "s2" maps to this server
    server s3 10.0.0.3:80 check cookie s3
```

When a new client connects, HAProxy picks a server via Round Robin, then inserts `Set-Cookie: SERVERID=s2` in the response. All future requests from that client carrying `Cookie: SERVERID=s2` are routed directly to server s2.

> Exercises

1. (Beginner) What problem do sticky sessions solve? What problem do they introduce?
2. (Beginner) A server with sticky sessions crashes. What happens to users whose sessions were pinned to it?
3. (Intermediate) Your team wants to eliminate sticky sessions. What architectural change is required, and what technology would you use to implement it?
4. (Interview) A team argues that sticky sessions are "just as good" as externalizing state, and they are simpler to implement. Construct the strongest counter-argument to this position. *(Hint: think about failure modes and scalability events.)*

#### Answers

1. Sticky sessions solve the problem of **stateful servers** — when a server holds session data in memory, all requests for that session must reach the same server. They introduce the problem of **uneven load distribution** and **reduced resilience**: if the pinned server becomes hot or fails, those sessions are impacted.
2. When a server with pinned sessions crashes, all users whose sessions were stored on that server **lose their session state**. They are effectively logged out or lose in-progress work (cart contents, upload state, etc.), even though other servers are healthy. The load balancer will route their next request to a healthy server, but that server has no knowledge of the lost session.
3. Move session storage to a **shared external cache** such as **Redis** or **Memcached**. Every backend server reads and writes session data to the same Redis cluster using the session ID (typically stored in a cookie). Since any server can retrieve any session, the load balancer can route requests to any healthy server without concern for affinity.
4. The strongest counter-arguments are: (1) **Failure amplification** — when a sticky server fails, the users on it are disproportionately impacted, turning a partial failure (one server down) into a complete session loss for a subset of users. With externalized state, a server failure causes only momentary errors while the load balancer reroutes, and sessions survive intact. (2) **Scaling events** — when you add a new server, sticky sessions cannot rebalance existing sessions; the new server sits underutilized while hot servers remain hot. Externalized state allows immediate, even rebalancing. (3) **Deployments** — rolling deployments that drain a server evict sticky sessions, causing user disruption. With externalized state, draining a server is transparent to users.

---

### Health Checks

#### Theory

A load balancer's value depends entirely on only routing traffic to servers that are actually capable of handling it. **Health checks** are the mechanism by which a load balancer continuously monitors each backend server and automatically removes unhealthy ones from the pool.

There are two types:

**Passive health checks**
The load balancer observes real traffic. If a server returns 5xx errors or times out repeatedly, it is marked unhealthy. No synthetic requests are generated.

**Active health checks**
The load balancer proactively sends synthetic probe requests to each backend on a schedule (e.g., every 5 seconds) and evaluates the response. The backend can be removed from the pool before any real user is affected.

Active checks can operate at different depths:

| Check Type | What it verifies | Example |
|---|---|---|
| TCP Ping | Server is accepting connections | Connect to port 8080, expect TCP SYN-ACK |
| HTTP/HTTPS | Server returns a valid HTTP status | GET /health returns 200 OK |
| Application-level | App can reach database, cache, etc. | GET /health returns JSON with dependency status |

A well-designed health check endpoint (`/health` or `/healthz`) should:
- Return HTTP 200 if the server is fully operational.
- Return HTTP 503 (Service Unavailable) if the server cannot safely serve traffic.
- Complete within a short timeout (50–200 ms).
- Check real dependencies (DB connection pool, cache reachability) — not just whether the process is running.

**Key parameters:**
- `interval` — how often to run the check (e.g., every 5 s)
- `timeout` — how long to wait for a response (e.g., 2 s)
- `healthy_threshold` — number of consecutive successes before marking a server healthy
- `unhealthy_threshold` — number of consecutive failures before removing a server

#### Examples

A Spring Boot health endpoint (application-level check):

```java
// HealthController.java
@RestController
public class HealthController {

    @Autowired
    private DataSource dataSource;   // Inject the database connection pool

    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> health() {
        Map<String, String> status = new HashMap<>();

        try (Connection conn = dataSource.getConnection()) {
            // Run a trivial query to verify DB connectivity
            conn.prepareStatement("SELECT 1").execute();
            status.put("database", "ok");
        } catch (SQLException e) {
            status.put("database", "unreachable");
            // Return 503 so the load balancer removes this instance from the pool
            return ResponseEntity.status(503).body(status);
        }

        status.put("status", "healthy");
        return ResponseEntity.ok(status);   // 200 OK — safe to receive traffic
    }
}
```

NGINX upstream health check configuration (using the commercial `nginx_upstream_check_module` or NGINX Plus):

```nginx
upstream backend {
    server 10.0.0.1:8080;
    server 10.0.0.2:8080;

    # NGINX Plus active health check
    # (requires NGINX Plus or the open-source ngx_http_upstream_check_module)
    check interval=5000     # Check every 5 seconds
          fall=3            # 3 consecutive failures -> mark down
          rise=2            # 2 consecutive successes -> mark up
          timeout=2000      # 2 second timeout per probe
          type=http;

    check_http_send "GET /health HTTP/1.0\r\nHost: backend\r\n\r\n";
    check_http_expect_alive http_2xx;   # Accept any 2xx response as healthy
}
```

> Exercises

1. (Beginner) What is the difference between an active and a passive health check? Give a scenario where passive checks are insufficient.
2. (Beginner) Why should a `/health` endpoint check database connectivity rather than simply returning `200 OK` unconditionally?
3. (Intermediate) A health check runs every 5 seconds with `unhealthy_threshold=3`. A server's database connection pool is exhausted at T=0. What is the maximum time before the load balancer removes this server from the pool? How many real user requests could fail in that window?
4. (Interview) A server is responding to health checks successfully (HTTP 200) but users are experiencing errors. What are three possible explanations for this split behavior, and how would you detect each? *(Hint: think about what a shallow health check misses.)*

#### Answers

1. **Active** health checks proactively send synthetic requests to backends on a schedule, detecting failures before any real user is affected. **Passive** health checks wait for real traffic to fail before marking a server down. Passive checks are insufficient when traffic volume is low — a server can be broken for a long time before enough real requests fail to trigger the threshold. For example, an overnight batch job server with minimal traffic could be down for hours before passive checks catch it.
2. A server process can be alive and accepting connections while its database connection pool is exhausted or the database is unreachable. Returning `200 OK` unconditionally would signal to the load balancer that the server is healthy, when in reality every request that touches the database will fail with a 500 error. A meaningful health check reflects the real ability of the server to serve production traffic.
3. The server fails its first health check at T=5 s, second at T=10 s, third at T=15 s. The load balancer removes it after the third failure. **Maximum window = 15 seconds**. With a check interval of 5 s and a threshold of 3, up to 15 seconds of real user traffic is routed to the broken server. At, say, 100 requests/second, that is up to **1,500 failed user requests** before the server is removed.
4. Three possible explanations: (1) **Shallow health check** — the `/health` endpoint only verifies the process is running, not that dependencies (DB, cache) are functional. Detect by adding dependency checks to the health endpoint and comparing its response latency/content against normal. (2) **Partial failure affecting only some request paths** — the health check hits `/health`, but only requests to `/checkout` (which call a broken payment service) fail. Detect by monitoring error rates by URL path in application logs or an APM tool. (3) **Resource exhaustion on real traffic** — the health check is a trivial lightweight request; real requests are heavy and exhaust connection pool or memory. The server handles the tiny probe but fails under real load. Detect by monitoring server CPU, memory, connection pool saturation, and comparing health check response time against p99 real request latency.

---

## 5.2 Traffic Routing

Knowing how to spread load across a cluster is only part of the picture. Before requests even reach your servers, they travel through layers of routing infrastructure. This section covers how reverse and forward proxies intercept traffic, how DNS is used to distribute load geographically, and how advanced techniques like Anycast enable traffic to be delivered to the closest available server on a global scale.

---

### Reverse Proxy

#### Theory

A **proxy** is an intermediary that acts on behalf of someone else. The direction of that delegation distinguishes a reverse proxy from a forward proxy.

A **reverse proxy** sits in front of one or more backend servers and accepts requests on their behalf from clients. Clients believe they are talking directly to the origin server — they are not. The reverse proxy receives the request, decides which backend to forward it to, and returns the backend's response to the client.

```
Client -----> [Reverse Proxy] -----> Backend Server(s)
         (client sees proxy)
```

Reverse proxies provide several benefits beyond load balancing:

- **TLS termination** — handle HTTPS decryption centrally.
- **Caching** — serve static assets or cached API responses without hitting the backend.
- **Compression** — apply gzip/Brotli compression at the proxy layer.
- **Authentication** — enforce API key or OAuth token validation before the request reaches the service.
- **Rate limiting** — reject excessive requests at the edge.
- **Logging and observability** — centralize access logs across all backends.

Common reverse proxy implementations: NGINX, HAProxy, Envoy, Caddy, AWS CloudFront (as a CDN/proxy), Traefik.

#### Examples

NGINX as a reverse proxy with caching and compression:

```nginx
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=api_cache:10m max_size=1g;

server {
    listen 443 ssl;
    server_name api.example.com;

    ssl_certificate     /etc/ssl/certs/example.crt;
    ssl_certificate_key /etc/ssl/private/example.key;   # TLS terminated here

    gzip on;                     # Enable response compression
    gzip_types application/json text/plain;

    location /api/v1/products {
        proxy_cache api_cache;           # Enable caching for this route
        proxy_cache_valid 200 5m;        # Cache 200 responses for 5 minutes
        proxy_pass http://backend_pool;  # Forward to backend
        proxy_set_header Host $host;     # Pass original Host header to backend
        proxy_set_header X-Real-IP $remote_addr;   # Forward client IP
    }

    location /api/v1/orders {
        proxy_pass http://backend_pool;  # No cache — orders must be real-time
    }
}
```

> Exercises

1. (Beginner) What does a reverse proxy hide from the client? What does a client see as the origin server?
2. (Beginner) List three capabilities that a reverse proxy can provide that a plain TCP load balancer cannot.
3. (Intermediate) Your backend servers are returning responses at 200 ms. After adding a reverse proxy with caching, cached responses return in 5 ms. Describe two operational concerns this introduces.
4. (Interview) A microservices architecture has 12 internal services. Should each service have its own reverse proxy, or should they share one? Justify your answer. *(Hint: consider the sidecar proxy pattern.)*

#### Answers

1. A reverse proxy hides the **real IP addresses, number, and topology of backend servers**. The client sends requests to the reverse proxy's IP/domain and receives responses from it — from the client's perspective, the proxy *is* the origin server.
2. Three capabilities a reverse proxy provides that a plain TCP (L4) load balancer cannot: (1) **HTTP caching** — serving responses without hitting the backend; (2) **TLS termination** with certificate management; (3) **Request/response transformation** — modifying headers, compressing responses, or injecting authentication context.
3. Two operational concerns with caching at the reverse proxy: (1) **Cache invalidation** — if a product's price or inventory changes in the backend, the proxy may serve stale data for up to 5 minutes until the cache entry expires. You need a strategy to purge or bust the cache on writes. (2) **Cache hit ratio visibility** — if the cache is not monitored, you may not know what fraction of requests bypass the backend. A low hit ratio could mask a backend performance problem; a high hit ratio could mask a broken backend that nobody notices because the cache is serving all traffic.
4. Both approaches have merit. A **shared reverse proxy** (API Gateway pattern) is simpler to operate — one place for TLS certs, rate limiting, and auth. However, it becomes a **single point of failure and a bottleneck**, and it tightly couples all services to one configuration. The modern cloud-native answer is the **sidecar proxy pattern** (used by service meshes like Istio and Linkerd): each service gets its own proxy instance deployed alongside it (in the same pod in Kubernetes). This provides per-service observability, routing, and resilience configuration without a shared bottleneck. The two approaches are often combined: an edge API gateway for external traffic, and sidecar proxies for internal service-to-service traffic.

---

### Forward Proxy

#### Theory

A **forward proxy** (often just called a "proxy") acts on behalf of clients, not servers. A client routes its outbound requests through the forward proxy, which makes the request on the client's behalf.

```
Client -----> [Forward Proxy] -----> Internet / Server
         (server sees proxy IP)
```

In this case, the target server sees the proxy's IP address, not the client's. The forward proxy knows the client's real identity; the server does not.

Common use cases:

- **Corporate egress control** — organizations route all outbound employee traffic through a proxy that enforces acceptable use policies and logs destinations.
- **Anonymity and privacy** — hide the client's IP from the destination server (e.g., Tor network).
- **Content filtering** — block access to certain domains or categories.
- **Caching in corporate networks** — a proxy shared by hundreds of employees can cache common responses (software updates, public API responses) locally.

| | Forward Proxy | Reverse Proxy |
|---|---|---|
| Acts on behalf of | Clients | Servers |
| Hides from server | Client's IP | Backend server details |
| Configuration | Client must be configured | Client is unaware |
| Typical use | Egress control, anonymity | Ingress control, LB, caching |

#### Examples

A corporate forward proxy policy using Squid (a widely used open-source proxy):

```squid
# /etc/squid/squid.conf

# Define allowed corporate IP ranges
acl corporate_network src 192.168.0.0/16

# Define blocked categories
acl blocked_domains dstdomain .facebook.com .twitter.com .tiktok.com

# Deny blocked domains for all users
http_access deny blocked_domains

# Allow corporate network
http_access allow corporate_network

# Deny everything else
http_access deny all

http_port 3128   # Port clients configure in their browser/OS proxy settings
```

Configuring an application to use a forward proxy in Python:

```python
import requests

proxies = {
    "http":  "http://proxy.corp.example.com:3128",
    "https": "http://proxy.corp.example.com:3128",  # HTTPS tunneled via CONNECT method
}

# All requests from this application will be routed through the corporate proxy
response = requests.get("https://api.external-vendor.com/data", proxies=proxies)
print(response.json())
```

> Exercises

1. (Beginner) Which party configures a forward proxy — the client or the server? Which party configures a reverse proxy?
2. (Beginner) A user in a corporate network tries to visit `facebook.com` and receives a "blocked by proxy" error. Which component is enforcing this restriction?
3. (Intermediate) Explain how a forward proxy handles HTTPS traffic. Can it decrypt the content? What are the two modes it can operate in?
4. (Interview) A developer says "we use a VPN, so we don't need a forward proxy." Is this correct? How are a VPN and a forward proxy architecturally different? *(Hint: think about what each is designed to control.)*

#### Answers

1. A **forward proxy** is configured by the **client** (or configured centrally and pushed to clients via policy). The destination server requires no knowledge of the proxy's existence. A **reverse proxy** is configured by the **server operator** (or platform team). The client requires no configuration and is unaware of the proxy.
2. The **forward proxy** (e.g., Squid) is enforcing the restriction. It intercepts the DNS query or TCP connection, checks the destination against its ACL (access control list), and returns a block page instead of fetching the content.
3. A forward proxy handles HTTPS in two modes: (1) **CONNECT tunneling (transparent)** — the client sends an HTTP `CONNECT proxy.corp.com:443` request asking the proxy to open a TCP tunnel to the destination. The proxy connects and passes encrypted bytes through. The proxy cannot read the content. (2) **SSL inspection (MITM)** — the proxy terminates the client's TLS connection using a corporate CA certificate (installed on all client devices via MDM), decrypts the content, inspects it (for DLP or malware), re-encrypts it with a fresh certificate, and forwards to the server. This is the only way a proxy can inspect HTTPS content, and it requires clients to trust the corporate CA.
4. This is partially correct but conflates two different tools. A **VPN** establishes an encrypted tunnel from the client to a VPN gateway, routing all traffic through the corporate network — its primary purpose is **network access control** (allowing remote clients to reach internal resources) and **traffic encryption in transit**. A **forward proxy** provides **application-layer controls**: URL filtering, content inspection, caching, and granular logging of what specific applications access. A VPN does not inherently block `facebook.com` or inspect HTTP headers. Many organizations use both: a VPN for secure remote access and a forward proxy (inside the VPN tunnel) for policy enforcement and observability.

---

### DNS Load Balancing

#### Theory

Every hostname must be resolved to an IP address before a connection can be made. The Domain Name System (DNS) itself can be used as a crude form of load balancing by returning multiple IP addresses for a single hostname.

**How it works:**
A DNS record for `api.example.com` can list multiple A records, each pointing to a different server. The DNS resolver returns all of them, and the client typically connects to the first one in the list. By rotating the order of the returned records on each DNS query, the DNS server distributes connections across servers over time.

This is called **DNS Round Robin**.

**Limitations of DNS load balancing:**

| Problem | Explanation |
|---|---|
| No health awareness | DNS has no knowledge of whether a server is up — it returns all IPs regardless |
| TTL-based caching | Clients and resolvers cache DNS responses for the TTL duration (often 60–300 s), so a server failure is not reflected immediately |
| Client-side load selection | Clients (or their OS resolver) may ignore the order and always pick the same IP (e.g., the first) |
| No session persistence | Impossible to guarantee the same client always reaches the same server |

Despite these limitations, DNS load balancing is useful when combined with short TTLs, health-checked DNS providers (Route 53 health checks, Cloudflare), and geolocation-based routing.

#### Examples

A DNS zone file using Round Robin:

```dns
; DNS Zone File for example.com
$TTL 60   ; 60-second TTL — short to enable faster failover

api.example.com.  IN  A  203.0.113.10   ; Server 1
api.example.com.  IN  A  203.0.113.11   ; Server 2
api.example.com.  IN  A  203.0.113.12   ; Server 3
```

When a client queries `api.example.com`, the authoritative DNS server rotates the order of these three A records on each response, spreading connections across the three IPs over time.

AWS Route 53 health-checked DNS (pseudocode):

```
Route 53 Policy: Weighted Routing

Record 1: api.example.com -> 203.0.113.10, Weight=100, Health Check: GET /health -> must return 200
Record 2: api.example.com -> 203.0.113.11, Weight=100, Health Check: GET /health -> must return 200
Record 3: api.example.com -> 203.0.113.12, Weight=100, Health Check: GET /health -> must return 200

If health check for Record 1 fails:
  -> Route 53 removes 203.0.113.10 from responses automatically
  -> Traffic is re-weighted across remaining healthy records
```

> Exercises

1. (Beginner) A server behind DNS Round Robin fails. Why might clients continue to send traffic to it for several minutes?
2. (Beginner) What is a DNS TTL, and why is it important for DNS-based load balancing?
3. (Intermediate) Your startup serves users from one region using DNS Round Robin with a 300-second TTL. You need to implement zero-downtime deploys. What problem does the DNS TTL create, and how would you mitigate it before the deploy?
4. (Interview) Compare DNS load balancing with a hardware/software load balancer. In what specific architectural scenario would DNS load balancing be the *right* primary strategy rather than a fallback? *(Hint: think globally.)*

#### Answers

1. DNS responses are **cached** by client operating systems, local resolvers, and ISP resolvers for the duration of the TTL. If the TTL is 300 seconds, clients that already resolved `api.example.com` to the failed server's IP will continue attempting to connect to it for up to 5 minutes before their cache expires and they re-query DNS. The DNS server has no mechanism to push an invalidation to all caches.
2. A **DNS TTL (Time-To-Live)** is a value (in seconds) attached to a DNS record indicating how long resolvers and clients should cache the response before querying again. For DNS load balancing, a short TTL enables faster propagation of changes (removing failed servers) but increases the query load on DNS servers. A long TTL reduces DNS query load but slows down failover.
3. With a 300-second TTL, some clients will hold stale DNS entries pointing to old server IPs for up to 5 minutes after a deploy. During that window, some requests go to new servers and some to old. The mitigation is to **lower the TTL** well before the deploy — change it to 30–60 seconds at least 1–2× the old TTL before the deployment window. This allows the low TTL to propagate before you make any server changes. After the deploy stabilizes, raise the TTL back.
4. DNS load balancing is the **correct primary strategy for Global Server Load Balancing (GSLB)**. When you have data centers in multiple geographic regions (e.g., US-East, EU-West, Asia-Pacific) and want to route users to the nearest region, no single hardware load balancer can see all global traffic — it would itself need to be globally distributed. DNS is inherently global and can use the client's IP to return region-specific records (GeoDNS), making it the natural layer for inter-region routing. Within a region, a traditional load balancer then handles intra-cluster distribution. The two layers are complementary: DNS routes globally across regions, hardware/software load balancers distribute locally within a region.

---

### Global Server Load Balancing (GSLB)

#### Theory

When a single region or data center is no longer sufficient — either due to traffic volume or the need for geographic proximity to reduce latency — organizations deploy in multiple regions worldwide. **Global Server Load Balancing (GSLB)** is the practice of distributing traffic across these geographically distributed deployments.

GSLB combines several mechanisms:

- **GeoDNS** — resolve a hostname to different IP addresses based on the geographic location of the DNS query. A user in Tokyo receives an IP pointing to the Tokyo data center; a user in Frankfurt receives the Frankfurt IP.
- **Latency-based routing** — route to the endpoint with the lowest measured round-trip time from the user's location.
- **Health-aware failover** — if an entire data center goes down, DNS responses are automatically changed to redirect traffic to the next nearest healthy region.
- **Weighted routing** — send a percentage of global traffic to a new region (e.g., 5%) for testing before full cutover.

```
User in Tokyo  -----> DNS Query -> [GeoDNS] -> Tokyo DC
User in Berlin -----> DNS Query -> [GeoDNS] -> Frankfurt DC
User in NYC    -----> DNS Query -> [GeoDNS] -> US-East DC

If Frankfurt DC fails:
User in Berlin -----> DNS Query -> [GeoDNS] -> US-East DC (failover)
```

GSLB is typically implemented by:
- **Managed DNS providers**: AWS Route 53, Cloudflare, Google Cloud DNS — all support geolocation and latency-based routing with health checks.
- **CDN providers**: Akamai, Fastly, Cloudflare — these have global Points of Presence (PoPs) that serve as GSLB-capable edge nodes.
- **Dedicated GSLB appliances**: Citrix NetScaler, F5 DNS Services.

#### Examples

AWS Route 53 latency-based routing (Terraform):

```hcl
# Create a latency-based routing policy across three AWS regions

resource "aws_route53_record" "api_us_east" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.example.com"
  type    = "A"

  latency_routing_policy {
    region = "us-east-1"   # Route users closest to US-East here
  }

  set_identifier  = "us-east"
  ttl             = 60
  records         = ["54.10.20.30"]   # US-East load balancer IP

  health_check_id = aws_route53_health_check.us_east.id   # Only route if healthy
}

resource "aws_route53_record" "api_eu_west" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.example.com"
  type    = "A"

  latency_routing_policy {
    region = "eu-west-1"   # Route users closest to EU-West here
  }

  set_identifier  = "eu-west"
  ttl             = 60
  records         = ["54.20.30.40"]   # EU-West load balancer IP

  health_check_id = aws_route53_health_check.eu_west.id
}
```

> Exercises

1. (Beginner) What is the primary benefit of GSLB over a single regional load balancer? Name two scenarios where GSLB is necessary.
2. (Beginner) A GeoDNS system routes a Berlin user to the Frankfurt data center. Frankfurt goes down. What happens next?
3. (Intermediate) A company uses GSLB with a 60-second TTL. Their Frankfurt data center fails. What is the maximum time a European user could be routing to the failed data center?
4. (Interview) GSLB solves the routing problem, but it does not solve the data problem. Explain what this means and what additional architecture is required to fully support a globally distributed application. *(Hint: think about database reads and writes across regions.)*

#### Answers

1. The primary benefit of GSLB is **reduced latency through geographic proximity** combined with **inter-region failover and high availability**. Two scenarios where it is necessary: (1) A global consumer application (e.g., a social media platform) where users in Asia, Europe, and the Americas all need low-latency access — routing all traffic to a single US data center would result in 200–400 ms latency for non-US users. (2) **Regulatory compliance** — GDPR or data residency laws may require that EU user data never leaves the EU, making it necessary to route EU traffic exclusively to EU-region deployments.
2. The GSLB provider's health check detects Frankfurt as down. On the next DNS query (or as TTL-cached entries expire), the DNS response for European users changes to the next best region — likely US-East or another available region. Users may experience elevated latency during the failover window (determined by the TTL), but service continues.
3. If the TTL is 60 seconds and a European user resolved Frankfurt's IP 1 second before the failure, their DNS cache holds the failed IP for up to **59 more seconds**. After that, their next DNS query returns a healthy region. The maximum exposure is **one TTL period = 60 seconds**. In practice, the health check itself takes a few cycles to detect failure, so the real window may be slightly longer.
4. GSLB routes traffic to the closest region, but data still lives somewhere. A write in Tokyo must eventually reach the Frankfurt and New York databases, and a user who switches regions mid-session must find their data in the new region. This requires: (1) **Multi-region database replication** — active-active (all regions accept writes, merged via conflict resolution) or active-passive (one primary region accepts writes, others replicate reads). Active-active is complex due to write conflicts. (2) **Eventual consistency management** — a user may read stale data in a region that has not yet received the latest replication. Applications must tolerate or compensate for this (e.g., read-your-own-writes guarantees). Technologies include CockroachDB (distributed SQL), Cassandra (active-active with tunable consistency), or DynamoDB Global Tables.

---

### Anycast Routing

#### Theory

**Anycast** is a network addressing and routing methodology in which the same IP address is announced from multiple geographic locations simultaneously. The Internet's routing infrastructure (BGP) automatically delivers packets from a client to the **topologically nearest** server advertising that IP.

The client sends to a single IP address. BGP routing tables determine which physical data center handles the packet — the client has no awareness of this selection.

```
IP 192.0.2.1 announced from:
  - Data Center in New York
  - Data Center in London
  - Data Center in Singapore

User in Paris sends a packet to 192.0.2.1
  -> BGP routes it to London (shortest AS path)

User in Los Angeles sends a packet to 192.0.2.1
  -> BGP routes it to New York (shortest AS path)
```

Anycast is the backbone of:
- **CDN edge networks** — Cloudflare, Fastly, and Akamai use Anycast so all their PoPs share the same IPs; users are automatically routed to the nearest PoP.
- **DNS root servers** — the 13 DNS root server addresses (e.g., `198.41.0.4` for root server A) are served from hundreds of physical locations worldwide via Anycast.
- **DDoS mitigation** — because attack traffic is absorbed by the nearest PoP rather than concentrated at one location, the attack volume is distributed across the entire network.

**Anycast vs GeoDNS:**

| | Anycast | GeoDNS |
|---|---|---|
| Routing decision | Made by BGP routers | Made by DNS resolver |
| Granularity | Network (BGP path) | Geographic region |
| Failover speed | Seconds (BGP convergence) | Minutes (DNS TTL) |
| Works at | IP layer (L3) | Application layer |
| Client change required | None | None |

#### Examples

A simplified view of how Anycast is configured with BGP (conceptual — requires a real Autonomous System):

```
# Each data center runs BGP and announces the same Anycast prefix

# New York DC's BGP configuration (Bird2)
router id 203.0.113.1;

protocol bgp upstream_nyc {
    local as 65001;
    neighbor 203.0.114.1 as 65000;   # Upstream ISP

    ipv4 {
        export filter {
            # Announce the Anycast /24 prefix to the Internet
            if net = 192.0.2.0/24 then accept;
            reject;
        };
    };
}

# London DC runs the identical config, announcing 192.0.2.0/24 from AS 65001
# BGP's path selection will route each client to their nearest PoP
```

> Exercises

1. (Beginner) A user in Sydney sends a packet to an Anycast IP that is announced from Sydney, Singapore, and Los Angeles. Which data center likely handles the request, and why?
2. (Beginner) Why are DNS root servers a good use case for Anycast rather than Unicast?
3. (Intermediate) During a DDoS attack, 10 million packets per second are sent to an Anycast IP announced from 10 locations. Approximately how many packets per second does each location absorb? Why is this better than Unicast?
4. (Interview) What happens to a long-lived TCP connection (e.g., a WebSocket) when the BGP routing changes and the Anycast path shifts to a different data center mid-connection? How is this problem typically handled? *(Hint: TCP connections are stateful — think about what a route change does to packet delivery.)*

#### Answers

1. The Sydney data center. BGP routing selects the path with the fewest network hops (AS path length) and lowest latency. The Sydney PoP is geographically and topologically closest to a Sydney user, so BGP will route packets there. The user has no awareness of this — they simply send to the Anycast IP.
2. DNS root servers receive queries from every device on the Internet — billions per day. With Unicast, all queries would travel to a small number of physical servers, concentrating load and increasing latency for distant users. With Anycast, the same 13 IP addresses are served from hundreds of physical locations worldwide; each user is automatically routed to the nearest one, dramatically reducing latency and distributing the query load globally. No client configuration is needed.
3. Approximately **1 million packets/second per location** (assuming reasonably even geographic distribution of attack sources — in practice it varies). This is dramatically better than Unicast: with a single Unicast IP, all 10 million pps would converge on one server or data center, overwhelming it. With Anycast, the attack traffic is absorbed across 10 separate networks and mitigation hardware, each of which only needs to handle 1/10th the load. This is why Anycast is a foundational technique in DDoS scrubbing.
4. When BGP re-converges and the Anycast route shifts, subsequent packets for the existing TCP connection arrive at a **different data center** than where the connection state (TCP sequence numbers, TLS session, WebSocket state) lives. The new data center has no knowledge of the connection and will send a TCP RST (reset), breaking it. This is a fundamental limitation of Anycast for stateful connections. Solutions: (1) **Use Anycast only for connection establishment** — the Anycast endpoint immediately redirects the client to a Unicast IP for the actual data transfer (used by Cloudflare for some services). (2) **Session resumption** — for TLS, TLS session tickets allow the client to quickly re-establish with any server without a full handshake. (3) **Application-layer reconnection** — WebSocket clients implement reconnection logic with exponential backoff. (4) **Route dampening** — BGP route changes are suppressed for a short period to reduce flapping.

---

## 5.3 Resilience Patterns

Distributing traffic solves the scaling problem, but scale also amplifies failure. A single slow dependency can cascade into a full system outage if requests pile up waiting for it. This section covers the design patterns that make individual services self-protecting: how to detect and short-circuit failing dependencies, how to retry safely, how to isolate failure to a single component, how to bound the time spent waiting, and how to serve degraded-but-functional responses when full functionality is unavailable.

---

### Circuit Breaker Pattern

#### Theory

The circuit breaker pattern is named after the electrical safety device that trips to cut power when current exceeds safe levels — preventing further damage. In software, it protects a service from being overwhelmed by calls to a dependency (a downstream service, database, or third-party API) that is failing or slow.

**The three states of a circuit breaker:**

```
CLOSED  -----(failure threshold exceeded)-----> OPEN
  ^                                               |
  |                                   (reset timeout expires)
  |                                               v
  +----------(probe succeeds)------------ HALF-OPEN
```

- **CLOSED** (normal) — requests flow through. The breaker counts failures. If failures exceed a threshold within a time window, the breaker trips to OPEN.
- **OPEN** (tripped) — all requests are immediately rejected (fail fast) without calling the dependency. After a configurable timeout, the breaker moves to HALF-OPEN.
- **HALF-OPEN** (probing) — a limited number of test requests are allowed through. If they succeed, the breaker resets to CLOSED. If they fail, it returns to OPEN.

**Why does this help?**
Without a circuit breaker, if a downstream service is slow (e.g., 10 s timeout), each caller thread is blocked for 10 s. Under load, all threads fill up waiting, request queues overflow, and the calling service crashes — even though it had nothing wrong with it. The circuit breaker makes failing fast a first-class behavior.

#### Examples

A circuit breaker implementation in Java using Resilience4j:

```java
import io.github.resilience4j.circuitbreaker.CircuitBreaker;
import io.github.resilience4j.circuitbreaker.CircuitBreakerConfig;
import io.github.resilience4j.circuitbreaker.CircuitBreakerRegistry;

import java.time.Duration;
import java.util.function.Supplier;

public class PaymentService {

    private final CircuitBreaker circuitBreaker;
    private final ExternalPaymentGateway gateway;

    public PaymentService(ExternalPaymentGateway gateway) {
        this.gateway = gateway;

        CircuitBreakerConfig config = CircuitBreakerConfig.custom()
            .failureRateThreshold(50)              // Trip if 50%+ of calls fail
            .waitDurationInOpenState(Duration.ofSeconds(30))  // Stay open 30 s
            .slidingWindowSize(10)                 // Evaluate over the last 10 calls
            .permittedNumberOfCallsInHalfOpenState(3)  // Allow 3 probes in HALF-OPEN
            .build();

        this.circuitBreaker = CircuitBreakerRegistry.of(config)
            .circuitBreaker("paymentGateway");
    }

    public PaymentResult charge(Order order) {
        // Wrap the gateway call with the circuit breaker
        Supplier<PaymentResult> decoratedCall = CircuitBreaker
            .decorateSupplier(circuitBreaker, () -> gateway.charge(order));

        try {
            return decoratedCall.get();
        } catch (Exception e) {
            // Circuit is OPEN or call failed — return a fallback response
            return PaymentResult.failed("Payment service temporarily unavailable");
        }
    }
}
```

State transition diagram:

```
Normal operation:
  Request -> [CB: CLOSED] -> Payment Gateway -> Success

Gateway starts failing:
  Request -> [CB: CLOSED, 6/10 failures] -> Payment Gateway -> Error
  (threshold crossed: 60% > 50%)
  CB transitions to OPEN

While OPEN (first 30 seconds):
  Request -> [CB: OPEN] -> Immediate failure (fallback) -- no call to gateway

After 30 seconds:
  CB transitions to HALF-OPEN
  Request 1 -> [CB: HALF-OPEN] -> Payment Gateway -> Success
  Request 2 -> [CB: HALF-OPEN] -> Payment Gateway -> Success
  Request 3 -> [CB: HALF-OPEN] -> Payment Gateway -> Success
  (3 probes succeeded) -> CB transitions back to CLOSED
```

> Exercises

1. (Beginner) What is "fail fast" and why is it preferable to waiting for a timeout when a dependency is down?
2. (Beginner) Describe what happens to a circuit breaker in the HALF-OPEN state if the first probe request fails.
3. (Intermediate) A circuit breaker is configured with `failureRateThreshold=50`, `slidingWindowSize=10`. The last 10 calls produced: F, S, F, S, F, S, F, S, F, F (F=fail, S=success). Does the breaker trip? Show your calculation.
4. (Interview) A circuit breaker protects Service A from a failing Service B. Service A's circuit breaker to Service B is OPEN. What should Service A return to its own callers? List two strategies and their tradeoffs. *(Hint: think about what data you can still provide vs. what is impossible without B.)*

#### Answers

1. **Fail fast** means immediately returning an error when a dependency is known to be unavailable, rather than waiting for a connection or read timeout to expire (which may take 10–30 seconds). It is preferable because: (a) it frees the calling thread immediately so it can handle other requests, (b) it prevents thread pool and connection pool exhaustion, and (c) it returns a faster (even if degraded) response to the user rather than making them wait 30 seconds for an inevitable error.
2. If the first probe request fails during HALF-OPEN, the circuit breaker immediately transitions back to **OPEN** and restarts the reset timeout. It treats the failure as confirmation that the dependency is still broken and does not allow any more requests through until the timeout expires again.
3. Failures: F, F, F, F, F, F = **6 failures** out of 10 calls. Failure rate = 6/10 = **60%**. Since 60% > 50% (the threshold), **yes, the breaker trips to OPEN**.
4. Two strategies: (1) **Return a cached/stale response** — if Service A can serve a previous result from a local cache (even if slightly outdated), it returns that with an indicator that the data may be stale. Tradeoff: users get a usable response, but it may not reflect the current state. Suitable when eventual consistency is acceptable (e.g., product catalog, recommendations). (2) **Return a partial or degraded response** — Service A returns the parts of its response that do not depend on Service B, omitting the Service B-dependent section. For example, a product page returns the description and price (from its own DB) but omits real-time inventory counts (from Service B). Tradeoff: the response is incomplete but functional, and the degradation is explicit. Unsuitable when Service B data is required for the operation to make any sense (e.g., payment authorization — you cannot partially authorize a charge).

---

### Retry with Exponential Backoff

#### Theory

Transient failures are common in distributed systems: a network hiccup, a brief database overload, a pod restarting. In many cases, simply retrying the request after a short wait is sufficient to succeed. However, naive retries — immediately re-attempting on failure — can worsen the situation.

**The thundering herd problem:** If 1,000 clients all fail at the same time and all immediately retry, they generate a sudden synchronized burst of traffic that further overwhelms an already-struggling server.

**Exponential backoff** addresses this by increasing the wait time between retries geometrically:

```
Attempt 1 fails -> wait 1 s   -> retry
Attempt 2 fails -> wait 2 s   -> retry
Attempt 3 fails -> wait 4 s   -> retry
Attempt 4 fails -> wait 8 s   -> retry
Attempt 5 fails -> give up
```

**Jitter** adds a random component to the wait time to desynchronize clients:

```
Wait = min(cap, base * 2^attempt) + random(0, jitter_range)
```

This prevents thousands of clients from retrying in lock-step after recovering from a shared failure event.

**Retry budgets and idempotency:**
- Only retry **idempotent** operations — operations where retrying produces the same result (HTTP GET, PUT, DELETE are typically idempotent; POST is not unless the server handles deduplication).
- Set a maximum number of retries and an absolute deadline. Never retry indefinitely.
- Consider whether retries should respect a **retry budget** (a rate limit on retries at the service level) to avoid retry storms.

#### Examples

Retry with exponential backoff and jitter in Python:

```python
import time
import random
import requests

def call_with_backoff(url: str, max_attempts: int = 5) -> requests.Response:
    base_delay = 1.0    # Initial wait in seconds
    cap = 30.0          # Maximum wait in seconds

    for attempt in range(max_attempts):
        try:
            response = requests.get(url, timeout=5)
            response.raise_for_status()   # Raise on 4xx/5xx
            return response               # Success — return immediately

        except (requests.RequestException, requests.HTTPError) as e:
            if attempt == max_attempts - 1:
                raise   # All attempts exhausted — propagate the exception

            # Exponential backoff with full jitter
            delay = min(cap, base_delay * (2 ** attempt))
            jittered_delay = random.uniform(0, delay)   # Add jitter

            print(f"Attempt {attempt + 1} failed: {e}. "
                  f"Retrying in {jittered_delay:.2f}s...")
            time.sleep(jittered_delay)

# Usage
try:
    response = call_with_backoff("https://api.example.com/data")
    print(response.json())
except Exception as e:
    print(f"All retries failed: {e}")
```

Wait times with `base=1, cap=30, max_attempts=5`:

| Attempt | Max delay (no jitter) | With full jitter |
|---|---|---|
| 1 | 1 s | 0–1 s |
| 2 | 2 s | 0–2 s |
| 3 | 4 s | 0–4 s |
| 4 | 8 s | 0–8 s |
| 5 | Give up | Give up |

> Exercises

1. (Beginner) Why is retrying non-idempotent operations (like POST) dangerous without server-side deduplication?
2. (Beginner) What is jitter in the context of exponential backoff, and what problem does it solve?
3. (Intermediate) A downstream service is rate-limiting your requests with HTTP 429 (Too Many Requests). Should you retry on 429? If so, what information in the response should you use to determine the retry delay?
4. (Interview) A team's retry policy is: `max_attempts=10, base_delay=0.1s, no cap, no jitter`. Analyze the failure modes of this policy under a 30-second downstream outage with 1,000 concurrent callers. *(Hint: calculate the cumulative delay for a single caller, and then think about what 1,000 synchronized callers do together.)*

#### Answers

1. Retrying a POST without deduplication can cause the operation to execute multiple times. For example, retrying a "Create Order" POST could result in two identical orders being created. The user's payment could be charged twice. Without a server-side mechanism (such as an idempotency key — a unique ID sent with the request that the server stores to detect and ignore duplicates), retries on non-idempotent operations are unsafe.
2. **Jitter** is a random amount of time added to the calculated backoff delay. It solves the **thundering herd problem**: when many clients experience the same failure simultaneously, without jitter they would all compute identical backoff delays (e.g., all wait exactly 2 seconds) and then all retry at the exact same moment, creating a synchronized burst. Jitter spreads retries across a time window, smoothing the retry traffic and allowing the server to recover progressively.
3. Yes, 429 should be retried — it means the server is healthy but is throttling you, so the request can succeed once the rate limit window resets. The response should include a `Retry-After` header (either a number of seconds or an HTTP date). Your retry logic should read this header and wait at least that long before retrying — rather than applying your own backoff, which might retry too early and receive another 429, wasting quota and adding load.
4. Analysis: With `base=0.1s` and no cap, the 10th attempt waits `0.1 * 2^9 = 51.2 seconds`. A single caller's cumulative wait is `0.1 + 0.2 + 0.4 + 0.8 + 1.6 + 3.2 + 6.4 + 12.8 + 25.6 = ~51 seconds` — which is longer than the 30-second outage, so the caller will likely succeed on attempt 8 or 9. However, the real problem is **no jitter with 1,000 synchronized callers**: all 1,000 callers fail at T=0, all wait exactly 0.1 s, all retry at T=0.1 and fail again, all wait exactly 0.2 s, and so on. Each retry is a synchronized wave of 1,000 requests hitting the server simultaneously. When the server recovers at T=30 s, the next synchronized wave (potentially 1,000 × 10 = 10,000 pending requests from all 10 attempts) hits the server at once, potentially re-crashing it. This is the **retry storm** or thundering herd. The fix: add jitter and a cap.

---

### Bulkhead Pattern

#### Theory

On a ship, **bulkheads** are watertight compartments that prevent water from flooding the entire vessel if one section is breached. The same principle applied to software means isolating resources so that a failure or overload in one subsystem cannot consume all resources and bring down the entire application.

In practice, this means giving each class of work its own isolated pool of resources (threads, connections, semaphores) so that an explosion in one workload cannot starve another.

**Thread pool isolation (Bulkhead Type 1):**
Assign a dedicated thread pool (or executor) to each downstream dependency. If calls to the Payment Service slow down and fill the Payment thread pool, the Product Service thread pool remains unaffected — product pages still load.

```
Before Bulkhead (shared pool):
  Payment threads ---|
  Product threads    |---> [Shared Thread Pool: 50 threads]
  User threads       |

If Payment takes all 50 threads -> Product and User requests queue/fail

After Bulkhead (isolated pools):
  [Payment Pool: 10 threads]   -> Payment Service
  [Product Pool: 20 threads]   -> Product Service
  [User Pool: 20 threads]      -> User Service

Payment saturation cannot affect Product or User pools
```

**Semaphore isolation (Bulkhead Type 2):**
Instead of separate threads, use a semaphore to limit the number of concurrent calls to a dependency. Cheaper than thread pools (no context switching overhead), but does not provide timeout isolation.

**Connection pool isolation:**
Give each downstream database or service its own connection pool with a fixed maximum. A runaway query against the Analytics DB cannot exhaust the connections available to the Transactional DB.

#### Examples

Bulkhead with Resilience4j (Java) using thread pool isolation:

```java
import io.github.resilience4j.bulkhead.ThreadPoolBulkhead;
import io.github.resilience4j.bulkhead.ThreadPoolBulkheadConfig;

import java.time.Duration;
import java.util.concurrent.CompletableFuture;

public class OrderService {

    // Dedicated thread pool for Payment Service calls (max 10 concurrent threads)
    private final ThreadPoolBulkhead paymentBulkhead = ThreadPoolBulkhead.of(
        "paymentBulkhead",
        ThreadPoolBulkheadConfig.custom()
            .maxThreadPoolSize(10)        // Hard cap on concurrent payment calls
            .coreThreadPoolSize(5)        // Keep 5 threads warm
            .queueCapacity(20)            // Allow 20 more to queue before rejection
            .keepAliveDuration(Duration.ofMillis(20))
            .build()
    );

    // Dedicated thread pool for Inventory Service calls (max 20 concurrent threads)
    private final ThreadPoolBulkhead inventoryBulkhead = ThreadPoolBulkhead.of(
        "inventoryBulkhead",
        ThreadPoolBulkheadConfig.custom()
            .maxThreadPoolSize(20)
            .coreThreadPoolSize(10)
            .queueCapacity(50)
            .build()
    );

    public CompletableFuture<OrderResult> placeOrder(Order order) {
        // Payment call is isolated to the payment bulkhead's thread pool
        CompletableFuture<PaymentResult> payment = paymentBulkhead
            .executeSupplier(() -> paymentService.charge(order));

        // Inventory call is isolated to the inventory bulkhead's thread pool
        CompletableFuture<InventoryResult> inventory = inventoryBulkhead
            .executeSupplier(() -> inventoryService.reserve(order));

        return CompletableFuture.allOf(payment, inventory)
            .thenApply(v -> buildOrderResult(payment.join(), inventory.join()));
    }
}
```

> Exercises

1. (Beginner) Without bulkheads, how can a slow downstream service cause an unrelated part of the application to fail?
2. (Beginner) What is the difference between thread pool isolation and semaphore isolation? When would you prefer each?
3. (Intermediate) A bulkhead for the Payment Service is configured with `maxThreadPoolSize=10, queueCapacity=20`. What happens to the 31st concurrent request to the Payment Service?
4. (Interview) A team applies bulkheads to all 8 external service dependencies in their application. Each bulkhead has its own thread pool of 20 threads. The host has 4 CPU cores. Analyze the resource implications. *(Hint: think about what 160 threads means on a 4-core machine.)*

#### Answers

1. Most web servers use a shared thread pool (e.g., Tomcat's HTTP thread pool) to handle all requests. If Service B is slow and takes 10 seconds per call, each thread calling Service B is blocked for 10 seconds. Under sustained load, all threads in the shared pool are blocked waiting for Service B. Requests to Service A — which is completely unrelated to Service B — cannot be processed because there are no free threads to handle them. Service A appears down to users even though it and its dependencies are fully functional.
2. **Thread pool isolation** spins up a dedicated pool of threads for calls to a dependency. Each call runs in a worker thread, so the calling thread returns immediately (async). This provides true isolation — a slow dependency only fills its own pool — and enables timeout enforcement. However, it has overhead from thread creation and context switching. **Semaphore isolation** uses a semaphore counter to limit the number of concurrent in-flight calls; the calling thread itself makes the call (no thread switch). It is lighter weight but does not isolate thread consumption from the caller's thread pool. Use thread pool isolation when calls can be truly async and timeout isolation is critical; use semaphore isolation for lightweight calls with predictable, short durations.
3. The 31st request exceeds `maxThreadPoolSize(10) + queueCapacity(20) = 30`. Resilience4j will throw a **`BulkheadFullException`** (or reject the callable), and the request fails immediately rather than queuing further. The application code should catch this exception and apply a fallback (return a cached result, return an error to the caller, etc.).
4. 8 bulkheads × 20 threads = **160 threads total**, on a machine with 4 CPU cores. At any moment, only 4 threads can run in parallel (one per core). The other 156 are either blocking on I/O or context-switching. This is actually acceptable for I/O-bound workloads (HTTP calls, DB queries) — threads spend most of their time waiting for network responses, not consuming CPU. However, the problems are: (1) **Memory overhead** — 160 threads × ~0.5–1 MB JVM stack = 80–160 MB of stack memory. (2) **Context switching overhead** — the OS scheduler must manage 160 threads, adding CPU overhead. (3) **Threads are a blunt instrument** — reactive/non-blocking I/O (e.g., Project Reactor, Vert.x) can achieve the same bulkhead isolation with far fewer threads using event loops and semaphore-based concurrency limits. For a new system, consider whether a reactive architecture would be more efficient.

---

### Timeout Strategies

#### Theory

Every call to an external dependency — a database, an API, a cache — can potentially take an arbitrarily long time if that dependency is malfunctioning. Without a timeout, a caller's thread (or goroutine, or coroutine) blocks indefinitely, eventually exhausting all available resources.

**Timeouts are not optional in distributed systems.** Every network call must have an explicit timeout.

**Types of timeouts:**

| Timeout Type | What it limits |
|---|---|
| Connection timeout | Time to establish a TCP connection |
| Read timeout | Time to wait for the first byte of a response after connecting |
| Request timeout | Total time for the entire request (connect + send + receive) |
| Idle timeout | Time a persistent connection can remain open without activity |

**Timeout budgets and deadline propagation:**
A request to Service A may trigger calls to B, C, and D. Each hop consumes time. A timeout at the upstream caller (e.g., a 5-second API gateway timeout) should inform the budget allocated to each downstream call.

```
API Gateway: 5 s total budget
  Service A: 3 s timeout
    -> Service B: 1 s timeout
    -> Service C: 1 s timeout
  Service D: 1 s timeout
```

If A takes 3 s and D takes 1 s, the total is 4 s — within the 5 s budget. This practice is called **deadline propagation** and is a key concept in gRPC and Google's Dapper tracing system.

**Choosing timeout values:**
- Set timeouts based on measured p99 (99th percentile) latency of the dependency, not the average.
- A timeout shorter than the p99 will cause healthy requests to fail.
- A timeout much longer than the p99 provides poor protection.
- Typical starting points: database queries 1–2 s, internal service calls 500 ms–2 s, external third-party APIs 3–10 s.

#### Examples

Timeout configuration in a Java HTTP client (OkHttp):

```java
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import java.util.concurrent.TimeUnit;

// Build a client with explicit timeout configuration
OkHttpClient client = new OkHttpClient.Builder()
    .connectTimeout(2, TimeUnit.SECONDS)    // TCP handshake must complete in 2 s
    .readTimeout(5, TimeUnit.SECONDS)       // Response must start arriving in 5 s
    .writeTimeout(5, TimeUnit.SECONDS)      // Request body must be sent in 5 s
    .build();

public String fetchUserProfile(String userId) {
    Request request = new Request.Builder()
        .url("https://user-service.internal/users/" + userId)
        .build();

    try (Response response = client.newCall(request).execute()) {
        if (!response.isSuccessful()) {
            throw new RuntimeException("Unexpected response: " + response.code());
        }
        return response.body().string();
    } catch (java.net.SocketTimeoutException e) {
        // Timeout exceeded — apply fallback logic
        log.warn("User service timed out for user {}", userId);
        return getUserFromCache(userId);   // Fallback: return cached profile
    }
}
```

Deadline propagation in gRPC (Go):

```go
// Client sets a 2-second deadline for the entire RPC
ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
defer cancel()   // Always cancel to release resources

// The deadline is automatically propagated via gRPC metadata headers
response, err := productClient.GetProduct(ctx, &pb.GetProductRequest{Id: productId})
if err != nil {
    if status.Code(err) == codes.DeadlineExceeded {
        // The call or a downstream call exceeded the 2-second deadline
        log.Printf("GetProduct timed out: %v", err)
    }
}
```

> Exercises

1. (Beginner) What is the difference between a connection timeout and a read timeout? Give an example where each would trigger but the other would not.
2. (Beginner) Why should you set a timeout based on the p99 latency of a dependency rather than the average (p50)?
3. (Intermediate) Service A calls Service B with a 5-second timeout. Service B calls Service C with a 5-second timeout. Service C hangs indefinitely. What is the maximum time Service A waits? Why might this be problematic for Service A's callers?
4. (Interview) A team sets all timeouts to 30 seconds "to be safe." Explain why very long timeouts can be more dangerous than short timeouts in a high-traffic system. *(Hint: think about threads, connections, and what happens when many requests pile up.)*

#### Answers

1. A **connection timeout** limits the time to establish the initial TCP connection (the three-way handshake). It triggers when the server is unreachable — e.g., the host is down, the port is firewalled, or the network is partitioned. A **read timeout** starts after the connection is established and limits how long to wait for response data. It triggers when the server accepts the connection but is slow to respond — e.g., the server is overloaded and has queued the request but not yet processed it. Example: connecting to a healthy-but-overloaded server succeeds immediately (connection timeout does not trigger), but the server takes 10 seconds to send a response (read timeout triggers).
2. The p99 latency is the latency experienced by the slowest 1% of requests. If you set your timeout to the average (p50), you will prematurely time out half of all requests from healthy dependencies. The p99 represents the realistic worst case under normal conditions. Setting the timeout at or slightly above the p99 (with some margin) ensures healthy requests succeed while still catching the truly hung calls that would otherwise block indefinitely.
3. Service C hangs indefinitely. Service B waits 5 seconds, times out, and returns an error. Service A waits 5 seconds for Service B to respond (B was waiting for C), then Service A times out too. **Total wait for Service A: up to 5 seconds** (its own timeout, which runs in parallel with B's timeout). However, Service A's caller (e.g., an API gateway) may have a shorter overall timeout. If the API gateway has a 3-second timeout, it gives up and returns an error to the user after 3 seconds, but Service A's thread is still blocked for 5 seconds — unnecessarily holding resources. This illustrates why deadline propagation matters: if A's caller has 3 seconds, A should propagate a deadline of (3 - overhead) to B, not its own independent 5-second timeout.
4. Very long timeouts are dangerous because they allow **thread/resource exhaustion**. Consider 1,000 requests/second to Service A, which calls a broken Service B with a 30-second timeout. After 30 seconds, 30,000 requests are in-flight, all blocked with their threads held open, waiting for Service B to respond. Each thread holds memory (stack + heap references) and may hold a database connection. Exhausting the thread pool means new requests to Service A queue or fail — even requests that do not call Service B at all. The system collapses under its own accumulated backlog. Short timeouts fail fast (freeing threads immediately), which prevents resource exhaustion and maintains system capacity for requests that can succeed.

---

### Graceful Degradation

#### Theory

**Graceful degradation** is the design principle that a system should continue to provide partial, reduced functionality when some of its dependencies or components are unavailable — rather than failing completely.

It is the application-level complement to circuit breakers and bulkheads: instead of just refusing a request, the system asks "what can I still do?"

**Strategies for graceful degradation:**

| Strategy | Mechanism | Example |
|---|---|---|
| Cached fallback | Serve stale data from cache | Show yesterday's trending articles if the recommendation service is down |
| Default response | Return a generic safe response | Return an empty cart instead of erroring when cart service is down |
| Feature flag disable | Toggle off non-critical features | Hide the "Live Chat" widget if the chat service is unavailable |
| Read-only mode | Disable writes, allow reads | Accept reads from DB replica when the primary is down |
| Static fallback | Serve a static page or file | Serve a cached HTML snapshot during a full outage |
| Partial response | Omit missing sections | Return product details without inventory count when inventory service is down |

**The key principle:** identify which features are **core** (without which the application cannot function) and which are **peripheral** (enrichments that can be absent). Degrade peripheral features; protect core features.

**Relationship to other patterns:**

```
Request arrives
     |
     v
[Circuit Breaker] -- OPEN --> Fallback needed
     |
  CLOSED
     |
     v
[Actual call to dependency]
     |
  Fails / times out
     |
     v
[Graceful Degradation] -- What can I still return?
     |
     +---> Cached data? Feature disabled? Partial result?
```

#### Examples

A product page that degrades gracefully when the recommendation service is unavailable (Python/Flask):

```python
from flask import Flask, jsonify
from redis import Redis
import requests

app = Flask(__name__)
cache = Redis(host='redis', port=6379)

def get_recommendations(user_id: str) -> list:
    """Fetch personalized recommendations, falling back to cached or default."""
    try:
        # Attempt to call the recommendation service with a short timeout
        response = requests.get(
            f"http://recommendation-service/users/{user_id}/recs",
            timeout=1.0   # Fail fast — recommendations are non-critical
        )
        response.raise_for_status()
        recs = response.json()

        # Cache the successful response for future fallback
        cache.setex(f"recs:{user_id}", 3600, str(recs))   # Cache 1 hour
        return recs

    except Exception:
        # Recommendation service is unavailable — try the cache first
        cached = cache.get(f"recs:{user_id}")
        if cached:
            return eval(cached.decode())   # Return stale but useful data

        # No cache either — return popular items as a safe default
        return get_popular_items()   # Static fallback: no personalization

def get_popular_items() -> list:
    """Return globally popular items as a non-personalized fallback."""
    return [{"id": 1, "name": "Bestseller A"}, {"id": 2, "name": "Bestseller B"}]

@app.route("/products/<product_id>")
def product_page(product_id):
    product = get_product(product_id)   # Critical — must succeed

    # Recommendations are peripheral — degrade gracefully if unavailable
    recommendations = get_recommendations(product.get("user_id"))

    return jsonify({
        "product": product,                     # Core data
        "recommendations": recommendations,     # May be stale or generic
        "recommendations_personalized": recommendations != get_popular_items()
    })
```

> Exercises

1. (Beginner) What is the difference between a system that "fails closed" (returns an error) and one that "degrades gracefully"? Give an example of each from a real-world application.
2. (Beginner) Identify which of the following features in an e-commerce site are "core" vs "peripheral" for the purpose of graceful degradation: product search, product recommendations, add to cart, payment processing, live chat support, product ratings display.
3. (Intermediate) A video streaming service's subtitle service goes down. Design a graceful degradation strategy. What information should the UI display to the user?
4. (Interview) A team argues: "We shouldn't invest in graceful degradation — we should just make our dependencies reliable enough that it's never needed." Critique this position and explain why graceful degradation remains necessary even with highly reliable dependencies. *(Hint: think about dependency chains and probability.)*

#### Answers

1. A system that **fails closed** returns an error to the user when any dependency fails. Example: an e-commerce checkout that returns a 500 error if the recommendation service is down — the user cannot complete their purchase even though recommendations are unrelated to checkout. A system that **degrades gracefully** continues to provide core value. Example: the same e-commerce site completes the checkout successfully but simply does not show "You might also like..." recommendations on the confirmation page.
2. **Core** (system cannot serve its primary purpose without these): product search, add to cart, payment processing. **Peripheral** (enrichments that can be absent without preventing the core flow): product recommendations, live chat support, product ratings display. A user can still find, buy, and pay for a product without recommendations, live chat, or ratings. Graceful degradation should protect the core and be willing to shed the peripheral.
3. Graceful degradation for subtitle service unavailability: (1) The video still plays — video playback is core. (2) The subtitle track is simply absent or shows a loading spinner, then a "Subtitles unavailable" indicator. (3) The UI should display a non-intrusive but visible message: "Subtitles are currently unavailable. We are working to restore them." (4) If cached subtitle files were previously downloaded to the client (offline/CDN caching), serve those instead. (5) Avoid blocking playback or showing an error screen — the primary value (watching the video) must be preserved.
4. The position is flawed for several reasons: (1) **Dependency chain probability** — even if each individual dependency has 99.9% uptime (8.7 hours downtime/year), a service with 10 dependencies has a compound availability of `0.999^10 ≈ 99%`, i.e., ~87 hours of potential downtime per year due to dependency failures — even if none of the individual services are "unreliable." (2) **The long tail of failure modes** — dependencies fail in ways that SLAs do not capture: slow responses (not outright down), partial failures affecting only some operations, and cascading failures during traffic spikes. No SLA eliminates these. (3) **Maintenance and deployments** — planned restarts, certificate rotations, and configuration changes cause brief interruptions that are not counted as SLA violations but still affect callers. (4) **Graceful degradation is also a user experience principle** — even a 1-second degraded experience (stale recommendations) is better than a 0-second failed experience (error page). Building resilience into the design is cheaper than chasing perfect upstream reliability.

---

# Chapter 6: Message Queues and Streaming

Modern distributed systems rarely consist of a single process handling everything sequentially. Instead, they are composed of independent services that must communicate reliably, often across network boundaries and at wildly different processing speeds. This chapter covers the infrastructure that makes asynchronous, decoupled communication possible: message queues, streaming platforms, and the workflow patterns built on top of them. Understanding these systems is fundamental to designing software that is fault-tolerant, scalable, and maintainable under real-world load.

---

## 6.1 Message Queue Fundamentals

A message queue is a buffer that sits between components of a system, allowing them to exchange data without requiring both to be available or ready at the same time. This section covers the foundational concepts that underpin every queuing system you will encounter in practice.

---

### Producer-Consumer Model

#### Theory

Imagine a bakery. The baker (producer) makes loaves of bread and places them on a shelf. Customers (consumers) come in and take loaves off the shelf whenever they are ready. The baker does not need to hand a loaf directly to a customer, and a customer does not need to wait for the baker to be idle. The shelf decouples their work.

The **producer-consumer model** applies this same idea to software. A **producer** generates work items (messages) and deposits them into a shared buffer (the queue). One or more **consumers** read from that buffer and process each item. The key properties this enables are:

- **Temporal decoupling**: the producer and consumer do not need to be active simultaneously.
- **Rate decoupling**: a fast producer can burst without overwhelming a slow consumer — the queue absorbs the difference.
- **Load distribution**: multiple consumers can share the work from a single queue.

```
Producer  -->  [ Queue ]  -->  Consumer A
                           -->  Consumer B
                           -->  Consumer C
```

Without a queue, the producer must block until the consumer is ready, which turns a distributed system into a chain of synchronous dependencies. One slow service can freeze the entire pipeline.

#### Example

```python
import queue
import threading
import time

# A bounded in-memory queue — holds at most 10 items
work_queue = queue.Queue(maxsize=10)

def producer():
    for i in range(20):
        item = f"task-{i}"
        work_queue.put(item)          # blocks if queue is full
        print(f"Produced: {item}")
        time.sleep(0.1)               # simulate fast production rate

def consumer(name):
    while True:
        item = work_queue.get()       # blocks until an item is available
        print(f"{name} consumed: {item}")
        time.sleep(0.5)               # simulate slow processing
        work_queue.task_done()        # signals that this item is finished

# Start one producer and two consumers
threading.Thread(target=producer, daemon=True).start()
threading.Thread(target=consumer, args=("Consumer-A",), daemon=True).start()
threading.Thread(target=consumer, args=("Consumer-B",), daemon=True).start()

work_queue.join()  # wait until every item has been processed
```

Notice that the producer sleeps 0.1 s per task but each consumer takes 0.5 s. Without two consumers sharing the queue, messages would accumulate. This models real systems where reads are cheaper than writes, or vice versa.

> **Exercises**
>
> 1. (Beginner) What happens to messages in a bounded queue when the producer is faster than all consumers combined and the queue fills up?
> 2. (Beginner) Describe two real-world scenarios — one where a single consumer is sufficient, and one where multiple consumers are required.
> 3. (Intermediate) In the Python example above, `task_done()` is called after processing. What bug could arise if you called `work_queue.join()` without ever calling `task_done()`?
> 4. (Interview) A producer generates 10,000 events per second. A single consumer can process 3,000 per second. How many consumers are the minimum needed to keep up, and what happens to latency as the queue drains vs. fills?
>    - *Hint: think about throughput ceilings and queue depth as a leading indicator.*

> **Answers**
>
> 1. The `queue.put()` call blocks, causing the producer to pause until a consumer frees up a slot. In distributed systems, this backpressure either stalls the upstream caller or causes the producer to drop/reject new work depending on policy.
> 2. Single consumer sufficient: sending a confirmation email per user signup (low volume, ordering matters). Multiple consumers required: processing video transcoding jobs at scale (high volume, independent tasks, no ordering constraint).
> 3. `work_queue.join()` waits until the internal "unfinished tasks" counter reaches zero. `task_done()` decrements it. If `task_done()` is never called, the counter never reaches zero, and `join()` blocks forever — a deadlock.
> 4. Minimum consumers = ceil(10,000 / 3,000) = 4. When the queue is draining (depth decreasing), latency decreases toward the processing time of a single item. When the queue is filling, end-to-end latency grows proportionally to queue depth divided by net drain rate.

---

### Message Queue vs. Message Broker

#### Theory

The terms "message queue" and "message broker" are often used interchangeably, but they describe different layers of abstraction.

A **message queue** is a data structure — a FIFO buffer — that holds messages until they are consumed. It is a low-level primitive. You can implement one in memory (like Python's `queue.Queue`) or back it by a database table.

A **message broker** is a server that manages one or more queues, handles routing, enforces delivery guarantees, supports multiple protocols, and provides operational features like persistence, authentication, monitoring, and dead-lettering. A broker adds orchestration on top of the raw queue concept.

| Property | Message Queue (primitive) | Message Broker |
|---|---|---|
| Scope | Single buffer | Server managing many queues/topics |
| Persistence | Typically in-memory | Disk-backed, survives restarts |
| Routing | None — one producer, one consumer path | Flexible: topic-based, header-based, fan-out |
| Protocols | Language-native APIs | AMQP, STOMP, MQTT, proprietary |
| Operational features | None | Auth, monitoring, dead-lettering, TTL |
| Examples | `java.util.concurrent.LinkedBlockingQueue` | RabbitMQ, ActiveMQ, Amazon SQS |

The analogy: a message queue is a single post box. A message broker is a post office — it has many boxes, knows how to route mail between senders and recipients, keeps records, and ensures delivery.

When engineers say "we use a message queue," they often mean they have deployed a broker. The key question in system design is not the vocabulary, but what delivery guarantees, persistence model, and routing logic you need.

#### Example: RabbitMQ vs. SQS at a glance

```
RabbitMQ (AMQP broker):
  Producer --> Exchange --> [Binding rules] --> Queue A --> Consumer
                                            --> Queue B --> Consumer

Amazon SQS (managed queue service):
  Producer --> SQS Queue --> Consumer(s) polling the queue
```

RabbitMQ's exchange layer allows sophisticated routing. SQS trades that flexibility for simplicity and fully managed infrastructure.

> **Exercises**
>
> 1. (Beginner) List three features a message broker provides that a bare in-memory queue does not.
> 2. (Beginner) Why would you prefer a disk-backed broker over an in-memory queue for financial transaction events?
> 3. (Intermediate) Your team is building a microservices system. Service A calls Service B synchronously via HTTP. Rewrite this interaction using a broker and explain what guarantees you gain and what you lose.
> 4. (Interview) A candidate says: "I'll just use a PostgreSQL table as a message queue." Under what conditions is this a reasonable choice, and when does it break down?
>    - *Hint: consider polling overhead, row locking, and throughput limits.*

> **Answers**
>
> 1. Persistence across restarts; authentication and access control; dead-letter queue support (any of: routing, TTL, acknowledgment-based redelivery, monitoring).
> 2. If the process crashes, an in-memory queue loses all messages. Financial events represent real-world state changes (money moved, orders placed) that cannot be replicated. A disk-backed broker persists messages so they survive crashes and can be reprocessed.
> 3. Gain: temporal decoupling (B can be down without failing A), automatic retry on B failure, backpressure if B is slow. Lose: synchronous response — A can no longer get B's return value in the same request, so request-reply patterns become more complex (correlation IDs, reply queues). You also introduce a new infrastructure dependency (the broker).
> 4. Reasonable for low throughput (hundreds of messages/minute), short-lived jobs, or when you already pay for PostgreSQL and want to avoid a new infrastructure component. Breaks down at high throughput: polling causes read amplification, `SELECT FOR UPDATE SKIP LOCKED` is effective but creates hot spots, and the table grows without careful archival. It also lacks native fan-out, TTL, and dead-lettering.

---

### Point-to-Point vs. Broadcast Messaging

#### Theory

There are two fundamental topologies for message delivery, and choosing between them is one of the first decisions you make when designing a messaging system.

**Point-to-point (P2P)**: A message is placed in a queue and consumed by exactly one receiver. Once consumed, it is gone. This is appropriate when a message represents a unit of work that should be done once — for example, "resize this image" or "charge this credit card."

**Broadcast (Publish-Subscribe, or Pub/Sub)**: A message is published to a topic and delivered to all subscribers. Each subscriber maintains its own independent position in the message stream. This is appropriate when multiple downstream systems all need to react to the same event — for example, when an order is placed, the inventory service, the email service, and the analytics service all need to know.

```
Point-to-Point:
  Publisher --> [Queue] --> Consumer A  (only one receives it)

Pub/Sub:
  Publisher --> [Topic]
                    --> Consumer A (receives a copy)
                    --> Consumer B (receives a copy)
                    --> Consumer C (receives a copy)
```

| Property | Point-to-Point | Pub/Sub |
|---|---|---|
| Receivers per message | Exactly one | All current subscribers |
| Use case | Work queues, task distribution | Event notification, fan-out |
| Message retention | Deleted after consumption | Retained until all subscribers read (or by TTL) |
| Example systems | SQS standard queues, RabbitMQ direct exchange | SNS, RabbitMQ fanout exchange, Kafka topics |

Many real systems combine both: an SNS topic (pub/sub) fans out to multiple SQS queues (point-to-point), giving each downstream service its own isolated work queue fed from a shared event stream.

#### Example: SNS + SQS fan-out

```
Order Service
    |
    v
[SNS Topic: order.placed]
    |                    |
    v                    v
[SQS: inventory]    [SQS: email]
    |                    |
    v                    v
Inventory Service   Email Service
```

Each SQS queue acts as a buffer for its respective service. If the Email Service is down, messages accumulate in its queue without affecting inventory processing.

> **Exercises**
>
> 1. (Beginner) You are sending a "welcome email" task when a user registers. Should you use point-to-point or pub/sub? Why?
> 2. (Beginner) You need to notify three internal services when a payment is completed. Which topology is more appropriate?
> 3. (Intermediate) A pub/sub system has five subscribers. Subscriber C is down for two hours. Describe what happens to the messages published during that time, and what conditions are required for C to eventually receive them.
> 4. (Interview) Explain the trade-offs of combining SNS and SQS (fan-out pattern) versus using Kafka topics directly.
>    - *Hint: consider operational complexity, ordering guarantees, and replay capability.*

> **Answers**
>
> 1. Point-to-point. The task must be executed exactly once. If two consumers both received the message, two emails would be sent. A P2P queue guarantees only one consumer handles it.
> 2. Pub/sub. The event ("payment completed") is the same for all three services, but each needs its own independent copy. Fan-out ensures all three receive it without the producer knowing or caring about the downstream consumers.
> 3. Messages published during the outage accumulate in C's subscription queue (if the broker supports per-subscriber queues with retention, e.g., SQS backing an SNS subscription). When C comes back online, it reads from its queue and catches up. Conditions required: the broker must persist messages for absent subscribers (not all pub/sub systems do — pure in-memory topics drop messages for offline subscribers). Also, the message retention window must not have expired.
> 4. SNS + SQS: simpler per-service isolation, independent scaling, built-in dead-lettering per queue, no replay beyond the SQS visibility window. Kafka: native replay from any point in time, strong ordering within partitions, much higher throughput, but operationally heavier. Use SNS/SQS when you need simplicity and at-least-once delivery. Use Kafka when you need replay, event sourcing, or very high throughput.

---

### Dead Letter Queues

#### Theory

No matter how carefully you design a consumer, some messages will fail to be processed. A payload might be malformed, a downstream dependency might be unavailable, or business logic might reject the data as invalid. If you simply retry indefinitely, a single bad message can block the entire queue — this is called a **poison message**.

A **Dead Letter Queue (DLQ)** is a secondary queue to which a broker automatically routes messages that cannot be successfully processed after a configurable number of attempts or after their time-to-live (TTL) expires. Rather than losing the message or blocking the queue, the broker "parks" it in the DLQ for human or automated inspection.

```
Normal flow:
  Producer --> [Main Queue] --> Consumer
                                   |
                          (fails 3 times)
                                   |
                                   v
                             [Dead Letter Queue]
                                   |
                          (alert / manual review / replay)
```

The DLQ pattern preserves three important properties:
1. **Liveness**: the main queue keeps draining even when a bad message is present.
2. **Observability**: failed messages are not silently dropped; they are visible and inspectable.
3. **Recoverability**: once the underlying issue is fixed (bug patched, schema corrected), messages can be replayed from the DLQ back into the main queue.

Key configuration parameters to understand:

| Parameter | Description |
|---|---|
| `maxReceiveCount` | Number of delivery attempts before routing to DLQ |
| `messageRetentionPeriod` | How long messages survive in the DLQ |
| `visibilityTimeout` | How long a consumer has to process a message before it becomes visible again |

#### Example: SQS DLQ configuration (AWS CloudFormation snippet)

```yaml
# Main queue with a redrive policy pointing to the DLQ
MainQueue:
  Type: AWS::SQS::Queue
  Properties:
    VisibilityTimeout: 30          # consumer has 30s to process
    RedrivePolicy:
      deadLetterTargetArn: !GetAtt DeadLetterQueue.Arn
      maxReceiveCount: 3           # after 3 failed attempts, move to DLQ

DeadLetterQueue:
  Type: AWS::SQS::Queue
  Properties:
    MessageRetentionPeriod: 1209600  # 14 days to investigate
```

```python
def process_message(message):
    try:
        payload = json.loads(message["Body"])
        handle_event(payload)
        # Delete the message only on success
        sqs.delete_message(
            QueueUrl=MAIN_QUEUE_URL,
            ReceiptHandle=message["ReceiptHandle"]
        )
    except Exception as e:
        # Do NOT delete — let it become visible again after visibilityTimeout
        # After maxReceiveCount failures, SQS moves it to the DLQ automatically
        logger.error(f"Failed to process: {e}")
```

The critical insight: you must **not** delete a message on failure. Leaving it in the queue allows the broker to track the receive count and eventually redirect it to the DLQ.

> **Exercises**
>
> 1. (Beginner) What is a poison message, and how does it threaten queue liveness?
> 2. (Beginner) A message has `maxReceiveCount = 5`. The consumer fails on attempts 1, 2, and 3, then the consumer crashes before attempt 4. What is the receive count when the message becomes visible again?
> 3. (Intermediate) Design a DLQ monitoring strategy: what metrics would you alert on, and what automated actions could you take when a message lands in the DLQ?
> 4. (Interview) A service processes payment events. Occasionally a message arrives with a currency code the service does not support. Should this be retried? Sent to a DLQ? Dropped? Justify your answer.
>    - *Hint: consider idempotency, business impact, and whether the root cause is transient or permanent.*

> **Answers**
>
> 1. A poison message is one that consistently fails processing and is never successfully consumed. It threatens liveness because in a FIFO queue (or with a blocked consumer), it can prevent all subsequent messages from being processed. Even in non-FIFO queues, it consumes consumer capacity on repeated failed retries.
> 2. The receive count is 4. Each time a message becomes visible and is received by a consumer (regardless of whether the consumer succeeds or crashes), the broker increments the receive count. The crash counts as a failed attempt.
> 3. Metrics to alert on: DLQ depth (non-zero should trigger at least a warning), DLQ message age (old messages indicate a long-standing issue), rate of messages entering the DLQ (spike indicates a systemic regression). Automated actions: page on-call when DLQ depth exceeds threshold; trigger a Lambda to inspect the message body and classify the error; after a deploy, optionally auto-replay DLQ messages back to the main queue.
> 4. An unsupported currency code is likely a **permanent** failure for the current version of the service — retrying will not fix it. It should go to a DLQ rather than being dropped, because the payment event represents real money and must not be silently lost. Once the service is updated to support the currency, the message can be replayed from the DLQ. Do not auto-retry indefinitely; do not drop.

---

### Message Ordering and Deduplication

#### Theory

Two of the most subtle and operationally important properties of a messaging system are whether it preserves message order and whether it ensures each message is delivered exactly once.

**Ordering**

Most brokers guarantee ordering within a limited scope:

- **Global ordering**: all messages across the entire queue are delivered in the order they were sent. This is very hard to achieve at scale because it prevents parallelism.
- **Partition-level ordering**: messages with the same "routing key" or partition key are ordered relative to each other, but messages across different partitions may arrive out of order. This is the model used by Kafka and SQS FIFO queues.
- **No ordering guarantee**: messages may arrive in any order (SQS standard queues). Highest throughput, simplest to scale.

**Deduplication**

Due to network failures and retries, a producer may send the same message more than once, or a broker may redeliver a message the consumer already processed. There are three common delivery semantics:

| Semantic | Meaning | Practical implication |
|---|---|---|
| At-most-once | Message delivered 0 or 1 times | May be lost; no retry |
| At-least-once | Message delivered 1 or more times | May be duplicated; consumer must be idempotent |
| Exactly-once | Message delivered precisely once | Hardest to achieve; requires coordination |

**Idempotency** is the key technique for handling at-least-once delivery: if processing the same message twice produces the same result as processing it once, duplicates become harmless.

```
Idempotent: "Set order-123 status to SHIPPED"
  -> processed twice -> order is SHIPPED (correct)

Non-idempotent: "Charge customer $50 for order-123"
  -> processed twice -> customer charged $100 (incorrect)

Fix: "Charge customer $50 for order-123, idempotency key: txn-abc-456"
  -> processed twice -> second charge is rejected by idempotency check
```

#### Example: Idempotent consumer with a deduplication store

```python
import redis

dedup_store = redis.Redis()

def process_with_dedup(message):
    message_id = message["MessageId"]
    dedup_key = f"processed:{message_id}"

    # Check if already processed (NX = only set if Not eXists, EX = expiry in seconds)
    if not dedup_store.set(dedup_key, "1", nx=True, ex=86400):
        # Already processed within the last 24 hours — skip
        print(f"Duplicate skipped: {message_id}")
        return

    # Safe to process — this is the first time we've seen this ID
    perform_business_logic(message)
    print(f"Processed: {message_id}")
```

SQS FIFO queues also offer native deduplication: if a producer sends a message with a `MessageDeduplicationId`, SQS rejects duplicates within a 5-minute window.

> **Exercises**
>
> 1. (Beginner) A standard SQS queue (no ordering guarantee) processes "transfer $100 from A to B" followed by "transfer $200 from A to B." Why does lack of ordering not matter here, but would matter for "create account" followed by "update account"?
> 2. (Beginner) Explain in your own words why "at-least-once" delivery requires idempotent consumers.
> 3. (Intermediate) Design an idempotency key scheme for a payment processing service that receives messages from Kafka. The key must be stable across retries and globally unique.
> 4. (Interview) A consumer processes a message, successfully writes to the database, but crashes before deleting the message from the queue. The message is redelivered. Describe the failure mode and two strategies to prevent double-processing.
>    - *Hint: consider where the idempotency check lives relative to the database write.*

> **Answers**
>
> 1. Both transfers are independent financial operations — their relative order does not affect correctness (A ends up $300 poorer either way). But "create account" must complete before "update account": if the update arrives first, the account does not exist yet and the operation fails. The operations have a causal dependency that requires ordering.
> 2. At-least-once means the same message may arrive multiple times. If the consumer is not idempotent — that is, if processing the same message twice has different effects (double-charging, double-inserting) — then duplicates cause incorrect behavior. Idempotency ensures the second (and third, etc.) delivery is a no-op, making the delivery semantic safe even in the presence of duplicates.
> 3. A good idempotency key for a Kafka-sourced payment service: `{topic}-{partition}-{offset}`. This is unique (no two messages share the same topic+partition+offset) and stable (the same message always produces the same key on retry). Include it in the payment record and check before processing.
> 4. Failure mode: the database row is written twice (or the second write fails with a constraint violation, or triggers a duplicate business action). Two strategies: (1) **Database-level idempotency** — use a unique constraint on the message ID column; the second insert fails gracefully, which the consumer catches and ignores. (2) **Check-then-act within a transaction** — read a "processed" flag and write the business data in the same database transaction, so the flag and the data are atomically committed together.

---

## 6.2 Streaming Systems

Where message queues are optimized for discrete work items consumed and discarded by individual workers, streaming systems treat data as a continuous, ordered, replayable flow of events. This section covers the architecture of streaming platforms, how they achieve their properties, and the delivery guarantees they offer.

---

### Batch Processing vs. Stream Processing

#### Theory

Before streaming systems existed, the dominant paradigm for processing large volumes of data was **batch processing**: collect data for a period, then run a computation over the entire accumulated dataset. Think of a bank running its end-of-day report at midnight: it waits until all transactions for the day are in, then computes balances, statements, and fees.

**Stream processing** computes results continuously as data arrives, maintaining and updating state incrementally rather than reprocessing the full dataset each time.

| Dimension | Batch Processing | Stream Processing |
|---|---|---|
| Data scope | Bounded (finite dataset) | Unbounded (infinite event stream) |
| Latency | High (minutes to hours) | Low (milliseconds to seconds) |
| Throughput | Very high | High, but with latency constraints |
| Complexity | Lower (simpler mental model) | Higher (windowing, state, out-of-order events) |
| Tools | Spark, Hadoop MapReduce | Kafka Streams, Flink, Spark Streaming |
| When to use | Periodic reporting, ETL, ML training | Fraud detection, real-time dashboards, alerting |

A useful mental model: batch processing is like developing photographs in a darkroom — you wait until the roll is full, develop all at once. Stream processing is like a live video feed — you see each frame the moment it is captured.

Many real architectures use both, often called the **Lambda architecture**: a batch layer for accurate historical results and a speed layer for real-time approximations that get corrected when the batch layer catches up.

#### Example: Word count — batch vs. streaming (pseudocode)

```python
# --- Batch version (Spark-like) ---
# Reads all log files at rest, computes counts
rdd = spark.textFile("s3://logs/2024-01-01/*.log")  # bounded input
counts = (rdd.flatMap(lambda line: line.split())
             .map(lambda word: (word, 1))
             .reduceByKey(lambda a, b: a + b))
counts.saveAsTextFile("s3://output/wordcount")      # result written once

# --- Streaming version (Kafka Streams-like) ---
# Continuously updates counts as new events arrive
stream = KafkaStream(topic="log-events")            # unbounded input
counts = (stream.flatMapValues(lambda line: line.split())
                .groupBy(lambda word: word)
                .count())                           # count table updated continuously
# Result is a live, queryable table, not a static file
```

> **Exercises**
>
> 1. (Beginner) A news website wants to show "most read articles in the last 10 minutes." Is this a batch or stream processing problem? Why?
> 2. (Beginner) Name one scenario where batch processing is preferable to stream processing despite higher latency.
> 3. (Intermediate) What is a "tumbling window" and a "sliding window" in stream processing? Give an example use case for each.
> 4. (Interview) Describe the trade-off in the Lambda architecture. Why do teams sometimes abandon it in favor of the Kappa architecture?
>    - *Hint: think about code duplication and operational complexity.*

> **Answers**
>
> 1. Stream processing. The result must be computed continuously and reflect events from only the last 10 minutes. A batch job run every hour would be too stale. This is a classic **windowed aggregation** problem suited to a streaming system.
> 2. Monthly payroll calculation. Payroll is inherently periodic, depends on the full month's data, and accuracy matters more than latency. A batch job that runs on the 1st of each month is simpler and more correct than attempting to maintain a live running total that handles amendments, corrections, and edge cases in real time.
> 3. A **tumbling window** groups events into non-overlapping, fixed-size time buckets (e.g., one bucket per minute). Use case: "count purchases per minute" for a per-minute billing report. A **sliding window** advances continuously, so each event is part of multiple overlapping windows (e.g., "total sales in the last 5 minutes" recomputed every second). Use case: real-time fraud detection that checks if a card has made more than 10 transactions in any 5-minute span.
> 4. Lambda architecture trade-off: the batch layer is accurate and replayable, the speed layer is low-latency but approximate. The two layers require maintaining essentially the same business logic in two different frameworks (e.g., Spark for batch, Flink for streaming), which leads to bugs when they diverge. Teams abandon it for the **Kappa architecture**, which uses only the streaming layer with a log (Kafka) that retains events long enough to "replay" history, eliminating the batch layer and the code duplication.

---

### Apache Kafka Architecture

#### Theory

Apache Kafka is a distributed event streaming platform originally developed at LinkedIn. It is designed around a small number of composable primitives that together provide high throughput, durability, and replay capability.

At its core, Kafka is a **distributed, durable, ordered log**. Producers append events to the end of a log. Consumers read from the log at their own pace, tracking their position independently. The log is never modified; events are retained for a configurable period.

Key components:

| Component | Role |
|---|---|
| **Broker** | A single Kafka server. Stores log segments on disk, serves producers and consumers |
| **Cluster** | A group of brokers working together for replication and load distribution |
| **ZooKeeper / KRaft** | Cluster coordination (ZooKeeper is legacy; Kafka now uses KRaft mode natively) |
| **Producer** | Client that writes events to a topic |
| **Consumer** | Client that reads events from a topic |
| **Consumer Group** | A group of consumers that cooperatively consume a topic |

Kafka's architecture is intentionally simple on the write side (always append) and pushes complexity to the read side (consumers track their own offset). This is the opposite of traditional message queues, where the broker tracks what each consumer has received.

```
Producers                  Kafka Cluster                 Consumers
---------                  -------------                 ---------
Service A  --write-->  [Topic: orders]            Consumer Group "billing"
Service B  --write-->    Partition 0  <--read--   billing-instance-1
                         Partition 1  <--read--   billing-instance-2
                         Partition 2  <--read--   billing-instance-3
                         (replicated across brokers)
```

**Replication**: each partition has one **leader** (handles all reads and writes) and zero or more **followers** (replicate the leader). If the leader fails, a follower is elected leader — this is what gives Kafka fault tolerance.

> **Exercises**
>
> 1. (Beginner) What is the fundamental difference between Kafka's consumer model (offset tracking on the consumer side) and a traditional broker's model (broker tracks delivery)?
> 2. (Beginner) What does it mean for Kafka to be "durable"? What infrastructure configuration enables this?
> 3. (Intermediate) A Kafka broker fails. What happens to the partitions it was leading? Walk through the recovery sequence.
> 4. (Interview) Kafka is often called a "log" rather than a queue. What properties of a log distinguish it from a queue, and why do those properties matter for building event-driven systems?
>    - *Hint: consider replay, immutability, and multiple consumers.*

> **Answers**
>
> 1. In traditional brokers (e.g., RabbitMQ), the broker marks messages as delivered and removes them once acknowledged. If a new consumer joins, it cannot read already-delivered messages. In Kafka, the broker stores all events on disk; consumers maintain their own offset (position in the log). A new consumer can start from offset 0 and read all historical events, or from the latest offset, or from any point in between.
> 2. Durable means events are persisted to disk and replicated across brokers so they survive process crashes and machine failures. This requires: `replication.factor >= 2` (each partition has at least one follower), `min.insync.replicas >= 2` (writes are only acknowledged when at least two replicas have the data), and `acks=all` on the producer.
> 3. When a broker fails: (1) ZooKeeper/KRaft detects the broker as unavailable. (2) For each partition the failed broker was leading, a controller node elects a new leader from the in-sync replicas (ISR). (3) Producers and consumers detect the metadata change and reconnect to the new leader. (4) When the failed broker recovers, it rejoins as a follower and replicates data it missed before becoming eligible as a leader again.
> 4. A log is **append-only** and **immutable** — events are never deleted during their retention period. This means: (1) **replay** — any consumer can re-read the entire history; (2) **multiple independent consumers** — each reads at its own pace without affecting others; (3) **auditability** — the log is a source of truth. A queue, by contrast, deletes messages on consumption, preventing replay and limiting the system to one effective consumer per message. For event-driven architectures (event sourcing, CQRS), replay is essential for rebuilding state and onboarding new services.

---

### Topics, Partitions, and Offsets

#### Theory

These three concepts form the core data model of Kafka and are central to understanding its scalability and ordering guarantees.

A **topic** is a named, logical category of events. Think of it as a table in a database, or a channel in a messaging system. Events of the same type go to the same topic: `order.created`, `payment.processed`, `user.registered`.

A **partition** is a physical subdivision of a topic. Each topic is split into one or more partitions, each of which is an independent ordered log stored on a specific broker. Partitions are the unit of parallelism in Kafka: more partitions means more consumers can work in parallel.

An **offset** is a monotonically increasing integer that identifies a message's position within a partition. Kafka assigns offsets sequentially. A consumer records its current offset to track progress.

```
Topic: "orders" with 3 partitions

Partition 0:  [msg@0] [msg@1] [msg@2] [msg@3] ...
Partition 1:  [msg@0] [msg@1] [msg@2] ...
Partition 2:  [msg@0] [msg@1] ...

Note: offsets are per-partition, not global.
"Partition 1, Offset 2" and "Partition 0, Offset 2" are different messages.
```

**How producers choose partitions**:
- If a **key** is provided, the key is hashed to a partition. All messages with the same key go to the same partition, preserving ordering for that key.
- If no key is provided, messages are distributed round-robin across partitions.

```
order-id: "A101" --> hash("A101") % 3 = 1 --> Partition 1
order-id: "A102" --> hash("A102") % 3 = 0 --> Partition 0
order-id: "A101" --> hash("A101") % 3 = 1 --> Partition 1  (same key, same partition)
```

This guarantees that all events for order A101 are in Partition 1 and are ordered relative to each other.

#### Example: Producer with explicit key

```java
Properties props = new Properties();
props.put("bootstrap.servers", "kafka:9092");
props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

KafkaProducer<String, String> producer = new KafkaProducer<>(props);

// Keyed by orderId — ensures all events for this order land in the same partition
String orderId = "order-A101";
String eventPayload = "{\"status\": \"created\", \"amount\": 99.99}";

ProducerRecord<String, String> record = new ProducerRecord<>(
    "orders",    // topic
    orderId,     // key: determines partition
    eventPayload // value: the message body
);

producer.send(record, (metadata, exception) -> {
    if (exception == null) {
        System.out.printf("Sent to partition %d, offset %d%n",
            metadata.partition(), metadata.offset());
    } else {
        exception.printStackTrace();
    }
});
producer.close();
```

> **Exercises**
>
> 1. (Beginner) A topic has 4 partitions and receives messages with no key. How are messages distributed across partitions?
> 2. (Beginner) Consumer A is reading Partition 0 at offset 10. Consumer B is reading Partition 1 at offset 5. Are these consumers "behind" relative to each other? What metric would you use to compare them?
> 3. (Intermediate) You have a topic with 6 partitions processing user activity events, keyed by `userId`. A new requirement says you need to process events for the same user in strict order. You add a 7th partition. What breaks, and how do you fix it?
> 4. (Interview) A topic has 3 partitions. You want to increase this to 12 to handle higher load. What are the risks of doing this on a live topic with existing consumers?
>    - *Hint: think about key-to-partition assignment and consumer group rebalancing.*

> **Answers**
>
> 1. Without a key, the Kafka producer uses a round-robin (or sticky batch) strategy to distribute messages across the 4 partitions, aiming for even distribution.
> 2. Raw offset numbers are not comparable across partitions because each partition has its own independent offset sequence. The correct metric is **consumer lag** per partition: `(latest offset) - (consumer's current offset)`. A lag of 0 means the consumer is caught up; a high lag means it is behind.
> 3. When you add a 7th partition, the hash function `userId % numPartitions` changes for many users. Events that were previously routed to Partition 2 may now go to Partition 6. A consumer reading Partition 2 will miss new events for those users; a consumer reading Partition 6 has no historical context. Strict per-user ordering is broken. Fix: repartition during a maintenance window — stop producers, wait for consumers to drain existing partitions, then increase the partition count and restart. Alternatively, use a custom partitioner that maps users to partitions independently of partition count, or accept the rebalance cost with a cutover strategy.
> 4. Risks: (1) **Key reassignment** — changing from 3 to 12 partitions remaps many keys to different partitions, breaking per-key ordering for events that straddle the cutover. (2) **Consumer group rebalancing** — all consumers in a group must rebalance when partition count changes, causing a brief processing pause. (3) **Broker storage rebalancing** — partitions must be redistributed across brokers. Mitigation: increase partitions in a planned window, coordinate with consumers, and if strict ordering across the cutover is required, use a compacted topic or temporary dual-write to both the old and new topic.

---

### Consumer Groups

#### Theory

A **consumer group** is a set of consumers that cooperate to consume a topic. Kafka assigns each partition to exactly one consumer within a group at any given time. This provides two critical properties simultaneously:

1. **Parallelism**: multiple consumers share the work.
2. **No duplication within the group**: each message is processed by exactly one group member.

If you want multiple independent applications to each consume all messages (e.g., a billing service and an analytics service both need all orders), you give each application its own consumer group with a distinct `group.id`. Each group maintains its own offset, advancing independently.

```
Topic "orders" — 4 partitions: P0, P1, P2, P3

Consumer Group "billing" (3 consumers):
  billing-1 --> P0, P1
  billing-2 --> P2
  billing-3 --> P3

Consumer Group "analytics" (2 consumers):
  analytics-1 --> P0, P1, P2
  analytics-2 --> P3
```

**Rebalancing** occurs when the group membership changes (a consumer joins, leaves, or crashes). Kafka redistributes partition assignments among the remaining members. During a rebalance, consumption pauses briefly.

The number of consumers in a group is bounded by the number of partitions: if you have 4 partitions and 5 consumers, one consumer is always idle. Conversely, if you have more partitions than consumers, some consumers handle multiple partitions.

#### Example: Consumer group setup in Java

```java
Properties props = new Properties();
props.put("bootstrap.servers", "kafka:9092");
props.put("group.id", "billing-service");          // all instances share this ID
props.put("enable.auto.commit", "false");          // manual offset control for reliability
props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");

KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
consumer.subscribe(Collections.singletonList("orders"));  // subscribe, not assign

try {
    while (true) {
        ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
        for (ConsumerRecord<String, String> record : records) {
            process(record.value());
        }
        // Commit offsets only after all records in this batch are processed
        consumer.commitSync();
    }
} finally {
    consumer.close();  // triggers a clean rebalance for remaining group members
}
```

> **Exercises**
>
> 1. (Beginner) A topic has 6 partitions and a consumer group has 8 consumers. How many consumers are active, and how many are idle?
> 2. (Beginner) You want both a fraud detection service and a reporting service to consume every order event. How do you configure their consumer groups?
> 3. (Intermediate) A consumer crashes mid-batch after processing 50 of 100 records but before committing offsets. What happens when a new consumer takes over its partition?
> 4. (Interview) You observe that consumer lag is growing on one partition but not others in the same group. What are three possible causes, and how would you diagnose each?
>    - *Hint: think about the partition itself, the consumer assigned to it, and the data characteristics.*

> **Answers**
>
> 1. 6 consumers are active (one per partition). 2 consumers are idle. Adding partitions to the topic would immediately activate the idle consumers.
> 2. Give each service a unique `group.id`: fraud detection uses `group.id = "fraud-detection"` and reporting uses `group.id = "reporting"`. Kafka maintains a separate committed offset for each group, so both receive all events independently.
> 3. The replacement consumer reads the last **committed** offset for that partition (not the last processed offset), which was before the batch started. It re-processes all 100 records from the beginning of the batch. This is the "at-least-once" delivery in practice. If the consumer logic is idempotent, this is safe. If not, the 50 records that were already processed will have their side effects applied again.
> 4. Three causes: (1) **Hot partition** — the partition receives disproportionately more messages (e.g., a popular user key hashes to it). Diagnose by checking the ingress rate per partition via Kafka metrics. (2) **Slow consumer** — the consumer assigned to that partition is on a resource-constrained host or has a particularly slow message type. Diagnose by checking host CPU/memory and per-record processing time. (3) **Message processing error causing retries** — the consumer is encountering errors and spending extra time retrying certain messages. Diagnose by checking consumer error logs and exception rates.

---

### At-Least-Once vs. Exactly-Once Delivery

#### Theory

Delivery semantics describe what guarantee a system makes about how many times a consumer processes a given message. This is one of the most important (and frequently misunderstood) concepts in distributed systems.

**At-most-once**: The system may drop messages but never delivers them more than once. Achieved by acknowledging before processing. Appropriate for metrics or telemetry where some data loss is acceptable.

**At-least-once**: The system guarantees delivery but may deliver duplicates. Achieved by acknowledging after processing. The consumer must be idempotent. This is the default and most common semantic in practice.

**Exactly-once**: Each message is processed precisely once, with no losses and no duplicates. This requires coordination between the producer, broker, and consumer — and transactional semantics. It is the hardest to achieve and carries performance costs.

Kafka achieves exactly-once through two mechanisms:
1. **Idempotent producer**: Kafka assigns each producer a `ProducerID` and a sequence number per partition. Duplicate sends (due to retries) are detected and ignored by the broker.
2. **Transactions**: a producer can atomically write to multiple partitions and commit consumer offsets within a single transaction.

```
Exactly-once in Kafka:
  Producer (idempotent + transactional)
      --> Writes to topic A, topic B, commits consumer offset for topic C
      --> All succeed, or none do (atomic commit)
      --> Consumer reads only committed messages
```

| Semantic | How to configure (Kafka) | Trade-off |
|---|---|---|
| At-most-once | `acks=0`, consumer commits before processing | Risk of data loss |
| At-least-once | `acks=all`, consumer commits after processing | Risk of duplicates; requires idempotent consumers |
| Exactly-once | `enable.idempotence=true`, `transactional.id=...`, `isolation.level=read_committed` | Additional latency, coordination overhead |

#### Example: Kafka exactly-once producer

```java
Properties props = new Properties();
props.put("bootstrap.servers", "kafka:9092");
props.put("enable.idempotence", "true");           // dedup at the broker
props.put("transactional.id", "billing-producer"); // unique per producer instance
props.put("acks", "all");

KafkaProducer<String, String> producer = new KafkaProducer<>(props);
producer.initTransactions();

try {
    producer.beginTransaction();
    producer.send(new ProducerRecord<>("billing-events", key, value));
    producer.send(new ProducerRecord<>("audit-log", key, auditValue));
    producer.commitTransaction(); // both writes committed atomically
} catch (Exception e) {
    producer.abortTransaction(); // neither write is visible to consumers
    throw e;
}
```

The consumer must also set `isolation.level=read_committed` to avoid reading messages from aborted transactions.

> **Exercises**
>
> 1. (Beginner) A metrics collection pipeline can tolerate losing 0.1% of data points. Which delivery semantic is most appropriate? Why?
> 2. (Beginner) Explain why "at-least-once + idempotent consumer" is often equivalent in practice to "exactly-once" from the perspective of business outcomes.
> 3. (Intermediate) You have a Kafka consumer that reads a payment event, updates a database, and then commits the offset. Identify all the windows in this sequence where a failure leads to a duplicate or a loss, and classify the delivery semantic.
> 4. (Interview) A team says: "We need exactly-once delivery from the queue to our PostgreSQL database." Is Kafka's exactly-once sufficient for this? What additional mechanism is required?
>    - *Hint: Kafka transactions only cover the Kafka side. What about the database write?*

> **Answers**
>
> 1. At-most-once. The cost of deduplication and retry coordination is not justified when data loss is acceptable. Committing offsets before processing maximizes throughput at the cost of potential drops.
> 2. If the consumer is idempotent, receiving a message twice produces the same database state as receiving it once. From the database's perspective, the outcome is identical to exactly-once processing. The distinction matters only if (a) processing has observable side effects that cannot be made idempotent (e.g., charging a credit card via an external API that charges on each call) or (b) you care about logging or metrics counting duplicate processing attempts.
> 3. Sequence: read from Kafka → update DB → commit offset. Failure windows: (a) If the process crashes **after** the DB write but **before** the offset commit, on restart the message is redelivered and the DB write happens again (duplicate → at-least-once). (b) If the process crashes **before** the DB write, the offset was not committed, so the message is redelivered and eventually processed (at-least-once, no loss). There is no window that produces data loss in this sequence. The delivery semantic is at-least-once.
> 4. Kafka's exactly-once covers Kafka-to-Kafka operations (producer writes and consumer offset commits within a transaction). It does not cover external systems. To achieve exactly-once semantics end-to-end with PostgreSQL, you need one of: (a) idempotent DB writes (upsert with a unique message ID column, so duplicate inserts are ignored); (b) a transactional outbox pattern where the Kafka offset commit and DB write happen in the same PostgreSQL transaction (requires the consumer to manage offsets in the DB, not in Kafka); or (c) distributed transactions (two-phase commit across Kafka and Postgres — technically possible but operationally complex and slow).

---

## 6.3 Async Workflow Patterns

Message queues and streams provide the infrastructure. This section covers the higher-level patterns that engineers use to build reliable, distributed workflows on top of that infrastructure.

---

### Task Queues

#### Theory

A **task queue** is a message queue specialized for distributing discrete units of work (tasks) to a pool of workers. The producer enqueues a task description; workers dequeue and execute it.

The distinction from a general message queue is primarily one of framing and tooling. Task queue frameworks (Celery, Bull, Sidekiq, Temporal) provide:

- **Task serialization**: converting function calls into messages and back
- **Worker management**: spawning, scaling, and monitoring worker processes
- **Retry logic**: configurable exponential backoff on failure
- **Result storage**: optionally storing task outputs for retrieval by the caller
- **Scheduling**: running tasks at a specific time or on a recurring schedule
- **Priority**: high-priority tasks jump ahead in the queue

```
Client             Task Queue Backend         Workers
------             ------------------         -------
send_email.delay()  --> [email-queue]  -->  worker-1: send email A
                                       -->  worker-2: send email B
                                       -->  worker-3: (idle, polling)
```

Task queues are the backbone of background job processing: sending emails, generating reports, processing uploaded images, sending webhooks, running ML inference.

#### Example: Celery with Redis

```python
# tasks.py
from celery import Celery

app = Celery(
    "myapp",
    broker="redis://localhost:6379/0",  # Redis as the queue backend
    backend="redis://localhost:6379/1"  # Store results here
)

@app.task(bind=True, max_retries=3, default_retry_delay=60)
def send_welcome_email(self, user_id: int):
    try:
        user = fetch_user(user_id)       # might fail if DB is slow
        email_client.send(
            to=user.email,
            subject="Welcome!",
            body=render_template("welcome.html", user=user)
        )
    except Exception as exc:
        # Retry with exponential backoff; raises after max_retries
        raise self.retry(exc=exc, countdown=2 ** self.request.retries * 60)

# In your view/API handler:
# send_welcome_email.delay(user_id=42)  # enqueues the task, returns immediately
```

```bash
# Start a worker process that picks up tasks
celery -A tasks worker --loglevel=info --concurrency=4
```

> **Exercises**
>
> 1. (Beginner) Why should sending a welcome email be processed via a task queue rather than inline in the registration API endpoint?
> 2. (Beginner) What is the difference between `send_welcome_email.delay(42)` and `send_welcome_email(42)` in a Celery application?
> 3. (Intermediate) A Celery task resizes uploaded images. The worker receives a task, starts processing, the pod is killed (Kubernetes rolling deploy), and the image is half-written. How would you design this task to be safe under this failure mode?
> 4. (Interview) A user triggers a long-running report generation task and the frontend polls for the result. Design the end-to-end flow, including how the frontend knows when the task is done without spinning the API.
>    - *Hint: consider task IDs, result backends, and WebSocket or Server-Sent Events.*

> **Answers**
>
> 1. Inline processing couples the API response time to the email provider's latency and availability. If the email provider is slow (500 ms) or down, every registration request either fails or is slow. With a task queue, the API returns a 201 immediately; the email is sent asynchronously. The user experience is not degraded by a downstream dependency.
> 2. `.delay(42)` serializes the call and enqueues it as a message; the current process returns a task ID immediately. A Celery worker picks it up and executes it asynchronously in a different process. Calling `send_welcome_email(42)` executes the function synchronously in the current process — useful for testing, but bypasses all Celery retry, queueing, and worker management.
> 3. Write to a temporary file first, then atomically rename it to the final destination. If the worker is killed mid-write, the temporary file is incomplete and the final path is not updated — the original file is untouched. On retry, the task starts fresh. Also: use a unique job ID as the temp file name so concurrent retries do not collide. Use cloud object storage (S3) with multipart upload + abort-on-failure for distributed environments.
> 4. Flow: (1) Client POSTs to `/reports/generate`; API enqueues the task and returns `{task_id: "abc-123"}`. (2) Client subscribes to a WebSocket channel scoped to `task_id` (or uses SSE). (3) When the worker finishes, it writes the result to the result backend and publishes a "done" event to a pub/sub channel (Redis pub/sub, or a broker topic). (4) A gateway process subscribed to that channel pushes the event over the WebSocket to the client. Fallback: the client can poll `GET /reports/abc-123/status` if the WebSocket connection drops.

---

### Job Scheduling

#### Theory

Task queues handle work that is triggered by an event (user action, API call). **Job scheduling** handles work that must run at a specific time or on a recurring cadence, regardless of user activity.

Examples: nightly database cleanup, hourly analytics aggregation, monthly invoice generation, daily backup, periodic health checks.

The two primary models are:

**Cron-based scheduling**: a cron expression defines when a job runs. Simple and widely understood, but has limitations: no built-in deduplication (two scheduler instances can fire the same job), no retry on failure, and missed runs (if the scheduler was down at the scheduled time) are typically not recovered.

**Durable scheduling**: the schedule is stored persistently, and a scheduling system guarantees that each job fires at least once, even if the scheduler crashes and restarts. Tools like Temporal, Quartz, and AWS EventBridge Scheduler offer this.

| Feature | Cron (system/OS level) | Distributed Job Scheduler (Temporal, Quartz) |
|---|---|---|
| Persistence | No (lost on restart) | Yes |
| Deduplication | No (multiple hosts = duplicate runs) | Yes (leader election or distributed locks) |
| Retry on failure | No | Yes (configurable) |
| Missed run recovery | No | Configurable |
| Complexity | Low | Higher |
| Use case | Single-host scripts, simple periodic tasks | Multi-instance services, business-critical schedules |

A common pattern for distributed environments: use a cron job (or a scheduled event from a cloud service) to enqueue a task into a task queue. The scheduler only fires the gun; the task queue handles reliability, retry, and deduplication.

```
CloudWatch Events (cron: 0 1 * * *)
  --> Invokes Lambda / sends SQS message
  --> Worker picks up from SQS queue
  --> Executes nightly-report task
  --> On failure, SQS retries up to maxReceiveCount
  --> Then routes to DLQ for investigation
```

#### Example: Celery Beat for recurring schedules

```python
# celery_config.py
from celery.schedules import crontab

app.conf.beat_schedule = {
    # Run every day at 2:00 AM UTC
    "nightly-invoice-generation": {
        "task": "tasks.generate_invoices",
        "schedule": crontab(hour=2, minute=0),
        "args": (),
    },
    # Run every 5 minutes
    "poll-external-api": {
        "task": "tasks.sync_external_data",
        "schedule": 300.0,  # seconds
    },
}

# Start the scheduler:
# celery -A celery_config beat --loglevel=info
# Start workers separately:
# celery -A tasks worker --loglevel=info
```

> **Exercises**
>
> 1. (Beginner) You have a Python cron job running on a single server that sends daily digest emails. The server is rebooted at 3 AM, which is exactly when the cron fires. What happens, and how would you fix it?
> 2. (Beginner) What is the difference between a cron expression `0 9 * * 1-5` and `0 9 * * *`?
> 3. (Intermediate) Your Celery Beat scheduler is running on two instances for high availability. What problem arises, and how do you solve it?
> 4. (Interview) A financial service must generate regulatory reports at 11:59 PM on the last business day of each month. What scheduling approach would you use, and how do you guarantee the report is generated exactly once even if infrastructure fails?
>    - *Hint: think about idempotency, durable state, and auditability.*

> **Answers**
>
> 1. The cron fires at 3 AM, the server begins rebooting, the job is killed mid-execution or never starts. Emails are not sent. Fixes: (a) use a managed cron service (AWS EventBridge, GCP Cloud Scheduler) that retries on failure; (b) enqueue the job into a durable task queue so even if the scheduler fires late (after reboot), the task completes; (c) make the job idempotent so re-running it the next morning catches up safely.
> 2. `0 9 * * 1-5` runs at 9:00 AM Monday through Friday (weekdays only). `0 9 * * *` runs at 9:00 AM every day of the week including weekends.
> 3. Two Beat instances will each schedule and enqueue the same tasks, causing duplicate job execution. Solutions: (a) use a distributed lock (Redis `SETNX`) so only the instance that holds the lock enqueues tasks; (b) use `celery-redbeat`, which uses Redis to store the schedule and enforces a single scheduler at a time via leader election; (c) run Beat as a singleton with a process supervisor and avoid horizontal scaling of the scheduler process.
> 4. Use a durable scheduler (Temporal or AWS EventBridge Scheduler) to trigger the job. Store the trigger event and report generation status in the database with the reporting period as a unique key (e.g., `report_period = "2024-01-31"`). Before generating, check if a report for that period already exists — if so, skip (idempotency). Temporal's workflow provides built-in retry and the full execution history as an audit log. Alternatively: write a Temporal workflow that sleeps until the last business day of the month, generates the report, writes to the database with a unique constraint on the period, and records success. If the workflow worker fails mid-execution, Temporal replays the workflow from its event history.

---

### Saga Pattern

#### Theory

Distributed transactions are hard. In a microservices architecture, a single business operation (like placing an order) may need to update data in multiple services: inventory must be reserved, payment must be charged, and shipping must be scheduled. All three must succeed together, or the system is left in an inconsistent state.

The **Saga pattern** breaks a distributed transaction into a sequence of local transactions, each executed by a separate service. Each step publishes an event or sends a message to trigger the next step. If any step fails, the saga executes **compensating transactions** — actions that undo the effects of the preceding steps — to restore consistency.

A saga is not a true ACID transaction. It provides **eventual consistency**: the system converges to a consistent state, but there may be a window during which partial results are visible.

```
Order Saga — Happy Path:
  1. Order Service:     Create order (status: PENDING)
  2. Inventory Service: Reserve items
  3. Payment Service:   Charge customer
  4. Order Service:     Confirm order (status: CONFIRMED)
  5. Shipping Service:  Create shipment

Order Saga — Failure at step 3 (payment fails):
  1. Order Service:     Create order (PENDING)       -- executed
  2. Inventory Service: Reserve items                -- executed
  3. Payment Service:   Charge fails                 -- FAILED
  Compensations (in reverse):
  3a. Payment Service:  (nothing to undo)
  2a. Inventory Service: Release reservation         -- compensate step 2
  1a. Order Service:    Cancel order (CANCELLED)     -- compensate step 1
```

Each compensating transaction must be idempotent, because it may be retried if the compensation itself fails.

> **Exercises**
>
> 1. (Beginner) What is a compensating transaction? Give a real-world analogy.
> 2. (Beginner) Why does a saga provide "eventual consistency" rather than "strong consistency"?
> 3. (Intermediate) In the order saga above, the payment succeeds (step 3), but then the shipment creation (step 5) fails. Write out the compensation sequence.
> 4. (Interview) A saga's compensating transaction for "reserve inventory" is "release reservation." But by the time the compensation fires, the item has been sold to another customer. How do you handle this semantic failure, and what does it reveal about the limits of the saga pattern?
>    - *Hint: consider countermeasures, semantic locks, and the concept of "pivot transactions."*

> **Answers**
>
> 1. A compensating transaction is a business-level operation that semantically reverses a previously executed step. It is not a database rollback (the original transaction has already committed). Real-world analogy: if you buy a non-refundable plane ticket (a committed transaction), the compensating action is applying for a chargeback through your bank or requesting a travel credit — you cannot "un-buy" the ticket, but you take an action that restores approximate financial equivalence.
> 2. After step 2 (inventory reserved) but before step 4 (order confirmed), another system querying the database will see a PENDING order with reserved inventory. This intermediate state is visible and does not reflect a "real" completed order or a "real" cancelled order. Strong consistency would require all services to atomically commit or rollback together — impossible across service boundaries without a distributed lock or 2PC.
> 3. Compensation sequence (steps 1–4 succeeded, step 5 failed): 5a. Shipping: nothing to undo (failed before creating a shipment). 4a. Order Service: revert order to PENDING or FAILED. 3a. Payment Service: issue refund to customer. 2a. Inventory Service: release reservation. 1a. Order Service: cancel order (set status to CANCELLED).
> 4. This is a **semantic failure**: the compensating transaction cannot be applied because the world has changed. The inventory is no longer available to release back — it belongs to another customer. Solutions: (1) Use **semantic locks** — mark the reserved inventory as "locked by saga-X" so other sagas cannot claim it until saga-X is resolved. (2) Use **countermeasures** — accept that this can happen and handle it out-of-band: contact the second customer, offer compensation, source from a different warehouse. (3) Identify the saga's **pivot transaction** (the point of no return — here, payment) and design the workflow so that all steps after the pivot are expected to succeed with high reliability (retry aggressively, alert on failure, never compensate past the pivot if avoidable).

---

### Choreography vs. Orchestration

#### Theory

Once you decide to use a saga, you must choose how the individual steps are coordinated. There are two fundamental approaches: **choreography** and **orchestration**.

**Choreography** (decentralized): There is no central coordinator. Each service reacts to events and emits new events. Services "know" what to do when they receive a certain event. The saga emerges from the interactions between services.

```
Choreography:
  Order Service  --[order.created]-->  Inventory Service
  Inventory Svc  --[inventory.reserved]-->  Payment Service
  Payment Svc    --[payment.processed]-->  Shipping Service
  Shipping Svc   --[shipment.created]-->  Order Service (update status)
```

**Orchestration** (centralized): A dedicated **orchestrator** (or workflow engine) directs each step, explicitly calling each service in sequence and handling failures and compensations.

```
Orchestration:
                 /--> calls Inventory Service
Order Orchestrator --> calls Payment Service
                 \--> calls Shipping Service
                 (manages the full saga state machine)
```

| Dimension | Choreography | Orchestration |
|---|---|---|
| Coupling | Loose — services only know events | Tighter — orchestrator knows all participants |
| Visibility | Hard — no single view of saga state | Easy — orchestrator holds full state |
| Failure handling | Complex — each service must implement local compensation | Centralized — orchestrator manages retries and compensation |
| Testing | Harder — must trace events across services | Easier — orchestrator is a testable unit |
| Scalability | Services scale independently | Orchestrator can become a bottleneck |
| Tools | Kafka, EventBridge | Temporal, AWS Step Functions, Camunda |

Neither is universally superior. Choreography works well for simple, stable workflows with few steps. Orchestration is preferred for complex workflows with many failure modes or where visibility and auditability are important.

> **Exercises**
>
> 1. (Beginner) In a choreography-based saga, how does the Order Service know that the full saga (all five steps) has completed successfully?
> 2. (Beginner) What is the main risk of adding a new service to a choreography-based system?
> 3. (Intermediate) You are using orchestration with AWS Step Functions for an order saga. The Payment step times out (no response within 30s). Design the error handling in the state machine.
> 4. (Interview) A team is choosing between choreography and orchestration for a payment processing workflow that involves 7 services and has strict regulatory requirements for auditability. Which would you recommend, and why?
>    - *Hint: consider what "auditability" requires and how each pattern stores workflow state.*

> **Answers**
>
> 1. In choreography, the Order Service listens for the final event in the chain — in the example above, `shipment.created`. When it receives that event, it updates the order status to CONFIRMED. Implicit in this: if any intermediate service emits a failure event (e.g., `payment.failed`), the Order Service (and other upstream services) must also subscribe to those failure events to trigger compensations. There is no single "done" signal from an orchestrator; the Order Service must explicitly model all terminal conditions.
> 2. The new service must know which events to subscribe to and which events to emit. If existing services are not designed with extensibility in mind, the new service may miss events, emit events with incompatible schemas, or subtly break existing saga flows. In choreography, there is no registry of "who subscribes to what," so the blast radius of schema changes is hard to assess.
> 3. In Step Functions: configure a `Retry` block on the Payment task with exponential backoff and a maximum attempt count. If all retries are exhausted, configure a `Catch` block that routes to a `Compensation` state machine branch. The Compensation branch invokes the Inventory Service to release the reservation and then updates the order status to PAYMENT_FAILED. Log the timeout with the full execution ARN for the audit record.
> 4. Orchestration (e.g., Temporal or Step Functions). Auditability requires a durable, queryable record of every step, its input, its output, and the time it occurred. An orchestrator stores this as its native execution history. With choreography, reconstructing the complete history of a specific order saga requires correlating events across 7 different service logs, which is operationally complex and error-prone. The regulatory requirement for a clear audit trail makes the centralized state of an orchestrator essential.

---

### Outbox Pattern

#### Theory

One of the most common bugs in event-driven systems arises from the following sequence:

```
1. Save record to database  [succeeds]
2. Publish event to queue   [fails — network hiccup, broker down]
```

The database is updated but the event is never published. Downstream services never learn about the change. The system is now inconsistent.

The naive fix — publish the event before saving — just reverses the problem:

```
1. Publish event to queue   [succeeds]
2. Save record to database  [fails — timeout, constraint violation]
```

Now the event is published but the database change never happened. The root problem is that writing to a database and writing to a message broker are two separate systems, and you cannot atomically commit to both without distributed transactions (expensive and complex).

The **Outbox Pattern** solves this by making the event publishing part of the database transaction:

1. Within the same database transaction that writes the business record, also write the event to an **outbox table** in the same database.
2. A separate **relay process** (sometimes called a "transactional outbox publisher") reads from the outbox table and publishes events to the broker.
3. Once the event is published and acknowledged by the broker, the relay marks the row as processed (or deletes it).

```
Application Transaction (atomic):
  INSERT INTO orders (id, status) VALUES (42, 'CREATED');
  INSERT INTO outbox (event_type, payload, status)
    VALUES ('order.created', '{"order_id": 42}', 'PENDING');

Relay Process (separate):
  SELECT * FROM outbox WHERE status = 'PENDING';
  --> publish to Kafka/SQS
  --> UPDATE outbox SET status = 'PUBLISHED' WHERE id = ?;
```

Because both writes happen in the same ACID transaction, they are atomic: either both succeed or neither does. The relay delivers at-least-once (it may retry), so events are never lost but may be published more than once. This makes idempotent consumers necessary.

#### Example: Outbox table schema and relay

```sql
-- Outbox table in the same database as your business tables
CREATE TABLE outbox (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_type  VARCHAR(255) NOT NULL,
    payload     JSONB        NOT NULL,
    status      VARCHAR(50)  NOT NULL DEFAULT 'PENDING',
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    published_at TIMESTAMPTZ
);

-- Index for efficient relay polling
CREATE INDEX idx_outbox_status_created
    ON outbox (status, created_at)
    WHERE status = 'PENDING';
```

```python
# relay.py — runs as a separate process or scheduled job
def relay_loop():
    while True:
        with db.transaction():
            # Lock pending rows to prevent concurrent relay instances
            rows = db.execute("""
                SELECT id, event_type, payload
                FROM outbox
                WHERE status = 'PENDING'
                ORDER BY created_at
                LIMIT 100
                FOR UPDATE SKIP LOCKED   -- other relay instances skip these rows
            """)

            for row in rows:
                try:
                    kafka_producer.send(
                        topic=row["event_type"],
                        value=json.dumps(row["payload"]).encode()
                    )
                    kafka_producer.flush()  # wait for broker acknowledgment
                    db.execute("""
                        UPDATE outbox
                        SET status = 'PUBLISHED', published_at = NOW()
                        WHERE id = %s
                    """, (row["id"],))
                except Exception:
                    # Leave as PENDING — will be retried next cycle
                    pass

        time.sleep(1)  # poll interval
```

An alternative to polling is **Change Data Capture (CDC)**: tools like Debezium read the database's replication log (WAL in Postgres) and stream changes directly to Kafka, eliminating the polling loop entirely.

> **Exercises**
>
> 1. (Beginner) Without the outbox pattern, what are the two failure scenarios when a service saves data and publishes an event as two separate operations?
> 2. (Beginner) The relay reads from the outbox and publishes to Kafka. The Kafka publish succeeds, but the relay crashes before marking the row as `PUBLISHED`. What happens on restart, and why is this safe?
> 3. (Intermediate) The outbox table grows large over time because old `PUBLISHED` rows are never deleted. Design a cleanup strategy that is safe to run without downtime.
> 4. (Interview) Compare the polling relay approach to using Change Data Capture (Debezium). What does each trade off in terms of latency, database load, and operational complexity?
>    - *Hint: consider replication lag, WAL consumption, and the polling interval's impact on both latency and database query volume.*

> **Answers**
>
> 1. Scenario A: the database write succeeds but the event publish fails. The system state is updated but no downstream service is notified — silent inconsistency. Scenario B: the event is published successfully but the subsequent database write fails. Downstream services react to an event for a state change that never actually persisted — phantom events causing downstream inconsistency.
> 2. On restart, the relay queries for `PENDING` rows. It finds the row again (still `PENDING`) and re-publishes the event to Kafka. This is a duplicate publish. It is safe because downstream consumers must be idempotent (the outbox pattern provides at-least-once delivery). The Kafka topic may receive the same event twice, but an idempotent consumer handles duplicates gracefully.
> 3. Cleanup strategy: (1) Add a background job that runs on a low-traffic schedule (e.g., nightly) and deletes rows where `status = 'PUBLISHED'` and `published_at < NOW() - INTERVAL '7 days'`. (2) Partition the outbox table by `created_at` using PostgreSQL table partitioning; drop old partitions wholesale (zero row-by-row locking). (3) Before deleting, optionally archive rows to cold storage (S3, a data warehouse) for auditability. The cleanup is safe because `PUBLISHED` rows have already been delivered; they no longer affect system behavior.
> 4. **Polling relay**: simple to implement and operate; adds periodic load (SELECT queries) to the primary database; latency equals the polling interval (typically 1–5 seconds); missed rows on failure are self-healing (next poll picks them up). **CDC with Debezium**: near-zero latency (events emitted as the WAL is written); no polling load on the primary; much higher operational complexity (Debezium cluster, Kafka Connect, managing WAL retention, schema registry); fragile to schema changes (adding a column can break the connector). Use polling for moderate throughput and simpler operations. Use CDC when sub-second latency is required or database query load from polling is prohibitive.

---
