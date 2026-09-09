# Operative Systems

## Index

- [1. Introduction to Operating Systems](#1-introduction-to-operating-systems)
  - [1.1 Role and Purpose](#11-role-and-purpose)
  - [1.2 Historical Evolution](#12-historical-evolution)
  - [1.3 System Architecture](#13-system-architecture)
  - [1.4 Operating System Structures](#14-operating-system-structures)
  - [1.5 System Interfaces](#15-system-interfaces)
- [2. Processes](#2-processes)
  - [2.1 Process Concept](#21-process-concept)
  - [2.2 Process Lifecycle](#22-process-lifecycle)
  - [2.3 Interprocess Communication](#23-interprocess-communication)
- [3. Threads and Concurrency](#3-threads-and-concurrency)
  - [3.1 Thread Fundamentals](#31-thread-fundamentals)
  - [3.2 Threading Models](#32-threading-models)
  - [3.3 Thread Programming](#33-thread-programming)
- [4. CPU Scheduling](#4-cpu-scheduling)
  - [4.1 Scheduling Foundations](#41-scheduling-foundations)
  - [4.2 Scheduling Algorithms](#42-scheduling-algorithms)
  - [4.3 Advanced Scheduling](#43-advanced-scheduling)
  - [4.4 Evaluation and Practice](#44-evaluation-and-practice)
- [5. Synchronization](#5-synchronization)
  - [5.1 The Critical Section Problem](#51-the-critical-section-problem)
  - [5.2 Hardware Support](#52-hardware-support)
  - [5.3 Synchronization Primitives](#53-synchronization-primitives)
  - [5.4 Classic Problems](#54-classic-problems)
  - [5.5 Alternative Approaches](#55-alternative-approaches)
- [6. Deadlocks](#6-deadlocks)
  - [6.1 Deadlock Characterization](#61-deadlock-characterization)
  - [6.2 Prevention and Avoidance](#62-prevention-and-avoidance)
  - [6.3 Detection and Recovery](#63-detection-and-recovery)
- [7. Memory Management](#7-memory-management)
  - [7.1 Main Memory Fundamentals](#71-main-memory-fundamentals)
  - [7.2 Contiguous Allocation](#72-contiguous-allocation)
  - [7.3 Paging](#73-paging)
  - [7.4 Segmentation](#74-segmentation)
- [8. Virtual Memory](#8-virtual-memory)
  - [8.1 Demand Paging](#81-demand-paging)
  - [8.2 Page Replacement](#82-page-replacement)
  - [8.3 Frame Management](#83-frame-management)
  - [8.4 Performance Concerns](#84-performance-concerns)
- [9. Storage Systems](#9-storage-systems)
  - [9.1 Secondary Storage Structure](#91-secondary-storage-structure)
  - [9.2 Disk Scheduling](#92-disk-scheduling)
  - [9.3 Reliability and Performance](#93-reliability-and-performance)
- [10. File Systems](#10-file-systems)
  - [10.1 File System Interface](#101-file-system-interface)
  - [10.2 File System Implementation](#102-file-system-implementation)
  - [10.3 Allocation and Free Space](#103-allocation-and-free-space)
  - [10.4 Consistency and Recovery](#104-consistency-and-recovery)
  - [10.5 Real-World File Systems](#105-real-world-file-systems)
- [11. Input/Output Systems](#11-inputoutput-systems)
  - [11.1 I/O Hardware](#111-io-hardware)
  - [11.2 I/O Software Layers](#112-io-software-layers)
  - [11.3 Kernel I/O Subsystem](#113-kernel-io-subsystem)
- [12. Protection and Security](#12-protection-and-security)
  - [12.1 Protection Mechanisms](#121-protection-mechanisms)
  - [12.2 Security Threats](#122-security-threats)
  - [12.3 Defensive Techniques](#123-defensive-techniques)
- [13. Virtualization](#13-virtualization)
  - [13.1 Virtualization Concepts](#131-virtualization-concepts)
  - [13.2 Virtualization Implementation](#132-virtualization-implementation)
  - [13.3 Containers and Lightweight Isolation](#133-containers-and-lightweight-isolation)
- [14. Distributed and Specialized Systems](#14-distributed-and-specialized-systems)
  - [14.1 Distributed Operating Systems](#141-distributed-operating-systems)
  - [14.2 Real-Time and Embedded Systems](#142-real-time-and-embedded-systems)
  - [14.3 Mobile Operating Systems](#143-mobile-operating-systems)
- [15. Case Studies and Performance](#15-case-studies-and-performance)
  - [15.1 System Case Studies](#151-system-case-studies)
  - [15.2 Performance Analysis](#152-performance-analysis)

---

<a id="1-introduction-to-operating-systems"></a>
## 1. Introduction to Operating Systems

This chapter establishes what an operating system actually is: the layer of software that stands between raw hardware and every program you run, turning a pile of transistors, wires, and spinning or flashing storage into a set of clean, safe, shareable abstractions. It traces how that layer evolved from punched-card batch monitors into the kernels running in phones and data centres, examines the hardware mechanisms (interrupts, dual-mode execution, DMA) that make the whole arrangement possible, and surveys the architectural styles used to organise kernels. Everything in later chapters — processes, scheduling, memory, files, security — is a specialisation of the ideas introduced here.

<a id="11-role-and-purpose"></a>
### 1.1 Role and Purpose

Before studying any mechanism, it helps to be precise about the job the operating system was invented to do, and about the two very different vantage points from which people describe it.

#### Definition of an Operating System

**Theory**

Start with the problem, not the definition. A bare computer is genuinely hostile to work. To read a byte from a disk you must know the controller's register layout, issue commands in the right order, and busy-wait for a status bit. To run two programs at once you must ensure neither overwrites the other's memory. To print, you must arbitrate a device that only one program can hold at a time. If every application had to solve these problems itself, every application would solve them differently, incompatibly, and mostly wrongly.

An **operating system** is the software layer that solves these problems once, on behalf of everyone. It has two complementary mandates:

1. **Convenience** — provide abstractions (files, processes, sockets, virtual memory) that are easier and safer to program against than the hardware underneath.
2. **Control** — arbitrate access to finite hardware among competing programs and users, enforcing protection and fairness.

The **kernel** is the part of the OS that is always resident in memory and runs with full hardware privilege. Around it sit *system programs* (shells, compilers, service daemons) that ship with the system but run as ordinary user processes. The word "operating system" is used loosely for both; when precision matters, say "kernel".

A useful analogy: the OS is the **government of the machine**. It provides infrastructure nobody wants to build privately (roads, water — files, memory), and it enforces rules so citizens do not trample each other (property law, courts — protection, scheduling). Like a government, it is overhead: it consumes resources and constrains you, and it is still vastly better than the alternative.

**Example**

```text
        +-------------------------------------------------+
        |   Users                                         |
        +-------------------------------------------------+
        |   Application programs                          |
        |   (browser, compiler, database, games)          |
        +-------------------------------------------------+
        |   System programs / libraries                   |
        |   (shell, libc, systemd, window server)         |
        +-------------------------------------------------+
        |   O P E R A T I N G   S Y S T E M   K E R N E L |
        |   process mgmt | memory mgmt | file systems      |
        |   device drivers | networking | security         |
        +-------------------------------------------------+
        |   Hardware                                      |
        |   CPU | RAM | disks | NIC | GPU | timers         |
        +-------------------------------------------------+
```

The same program, written twice — once against the hardware, once against the OS:

```c
/* Without an OS: talk to an (imaginary) disk controller directly. */
outb(DISK_CMD_PORT, CMD_READ);          /* issue a read command      */
outb(DISK_LBA_PORT, block_number);      /* select the block          */
while (!(inb(DISK_STATUS_PORT) & RDY))  /* busy-wait for the device  */
    ;
insw(DISK_DATA_PORT, buffer, 256);      /* pull 512 bytes, 16 bits at a time */

/* With an OS: the same intent, portable across every disk ever made. */
int fd = open("/data/report.txt", O_RDONLY);
read(fd, buffer, 512);
close(fd);
```

**Key takeaways**

- An OS exists to provide *abstraction* (convenience) and *arbitration* (control) over hardware.
- The kernel is the privileged, always-resident core; system programs are unprivileged software shipped alongside it.
- Abstractions such as files and processes do not exist in hardware — the OS invents and maintains them.
- The OS is deliberate overhead, paid in exchange for portability, safety, and sharing.

> 🧪 Practice
>
> 1. List five hardware resources on your own machine and, for each, name the abstraction the OS exposes to programs instead of the raw device.
> 2. Run `ps aux` (Linux/macOS) or `Get-Process` (Windows) and classify ten entries as kernel threads, system programs, or user applications. Which column told you?
> 3. Interview-style: "Is a device driver part of the operating system?" Argue both positions. *Hint: consider where the code executes and whose privilege it borrows, not who wrote it.*

#### Resource Management

**Theory**

The hardware offers a fixed budget: some number of CPU cores, some gigabytes of RAM, some bandwidth to disk and network. The demand is unbounded — every process would happily take everything. **Resource management** is the OS's job of dividing that fixed budget among competing claimants, and it is the single thread connecting most chapters of this book.

There are two ways to share a resource, and every OS mechanism is one of them:

| Sharing style | Meaning | Examples |
|---|---|---|
| **Time multiplexing** | Claimants take turns using the whole resource | CPU scheduling, disk request queues, network transmission |
| **Space multiplexing** | The resource is divided; each claimant holds a piece simultaneously | RAM partitions and pages, disk blocks, port numbers |

For each resource the OS must answer four questions: *who is asking*, *how much do they get*, *when do they get it*, and *what happens when they conflict*. Answering them requires policy (what is fair? what is efficient?) implemented by mechanism (queues, tables, locks). A recurring design principle is the **separation of policy and mechanism**: the mechanism that switches processes should not hard-code the rule that decides which process runs next, so the rule can change without rewriting the machinery.

Analogy: an airport. Runways are time-multiplexed (one aircraft at a time, scheduled); gates and parking stands are space-multiplexed (many aircraft simultaneously, each with its own slot). Air traffic control is pure policy; the radios and lights are mechanism.

**Example**

```text
   Time multiplexing the CPU (one core, three processes)

   core: [ P1 ][ P2 ][ P3 ][ P1 ][ P2 ][ P3 ][ P1 ] ...
         |----|                                        one time slice
         switch points are enforced by a timer interrupt

   Space multiplexing RAM (one physical memory, three processes)

   RAM:  +--------+--------+--------+-----------------+
         |   P1   |   P2   |   P3   |   free          |
         +--------+--------+--------+-----------------+
         all three resident at once, each confined to its own region
```

```bash
# Ask the OS what it is currently managing.
nproc                 # CPUs available for time multiplexing
free -h               # RAM: used / free / cached (space multiplexing)
ulimit -a             # per-process resource caps this shell enforces
cat /proc/loadavg     # runnable processes competing for the CPU
```

**Key takeaways**

- Resource management = dividing a fixed hardware budget among unbounded demand.
- Every sharing scheme is time multiplexing (take turns) or space multiplexing (take a piece).
- The OS must decide who, how much, when, and how to resolve conflicts.
- Keep policy separate from mechanism so policies can evolve independently.

> 🧪 Practice
>
> 1. Classify each as time- or space-multiplexed: a printer, L3 cache, an SSD, TCP port numbers, a GPU running compute kernels.
> 2. Use `ulimit -v 100000` in a throwaway shell, then run a memory-hungry program. Explain what the OS did and which side (policy or mechanism) `ulimit` represents.
> 3. Design a starvation-free policy for a single printer shared by ten users, then explain which parts of your design are policy and which are mechanism.

#### Abstraction of Hardware

**Theory**

Hardware is diverse, awkward, and unstable across generations. An SSD, a spinning disk, and a network file server share almost nothing at the electrical level. Abstraction is the OS's answer: expose one uniform, idealised interface, and hide every difference behind it.

The abstractions an OS provides are, without exception, *useful lies*:

| Abstraction | The lie it tells | The reality underneath |
|---|---|---|
| **Process** | You have your own CPU, running continuously | One core shared by dozens of processes, switched thousands of times a second |
| **Virtual memory** | You have a large, private, contiguous address space | Scattered physical frames, some pages on disk, some shared |
| **File** | A named, arbitrarily long, growable byte stream | Fixed-size blocks scattered across a device, indexed by metadata |
| **Socket** | A reliable byte pipe to another machine | Lossy packets, retransmission, reordering, congestion control |

Two properties make an abstraction good. **Uniformity**: the same `read()` call works on a file, a pipe, a terminal, and a socket — this is what "everything is a file" means in UNIX. **Fidelity of cost**: the abstraction should hide complexity without hiding cost so thoroughly that programmers cannot reason about performance. Memory-mapped files hide the difference between RAM and disk beautifully — right up until a page fault costs a hundred thousand times a memory access.

Analogy: a car's steering wheel and pedals. They are the same in every car, whether the engine is diesel, petrol, or electric. You learn once and drive anything. The abstraction leaks only where physics demands it — an electric car still brakes differently.

**Example**

```text
                       read(fd, buf, n)
                              |
                +-------------+-------------+
                |     Virtual File System   |   one uniform interface
                +-------------+-------------+
        +---------+-----------+-----------+---------+
        |         |           |           |         |
     ext4 on    NFS over    tmpfs in    pipe     /dev/tty
       SSD      network       RAM      buffer    terminal
```

```python
# One interface, four wildly different devices underneath.
def count_lines(source):
    """`source` may be a regular file, a pipe, a socket file, or a device."""
    total = 0
    with open(source, "r") as handle:   # the OS resolves what this really is
        for _ in handle:                # read() underneath in every case
            total += 1
    return total

count_lines("/etc/passwd")       # ext4 on an SSD: block reads plus caching
count_lines("/dev/stdin")        # a pipe from another process: kernel buffer
count_lines("/proc/cpuinfo")     # not a file at all: generated by the kernel
```

**Key takeaways**

- Abstractions replace diverse, awkward hardware with a small number of uniform interfaces.
- Every OS abstraction is a convenient fiction maintained by the kernel at runtime.
- Uniformity ("everything is a file") lets one tool work across unrelated resources.
- Abstractions hide complexity but should not hide cost; leaky performance behaviour is where they bite.

> 🧪 Practice
>
> 1. Run `cat /proc/cpuinfo` and `cat /proc/self/status`. No such files exist on disk — explain what the kernel is really doing and what abstraction it is exploiting.
> 2. Name three ways the "file" abstraction leaks (cases where you must know what is underneath to write correct or fast code).
> 3. Interview-style: "Why is `/dev/null` a file?" *Hint: think about what you gain by making a discard sink obey the same interface as everything else.*

#### User vs Kernel Perspective

**Theory**

The same system looks entirely different depending on where you stand, and confusing the two viewpoints is a common source of muddled reasoning.

From the **user (or application) perspective**, the OS is a *service provider*. It is defined by the API: what calls exist, what guarantees they make, what errors they return. A program asks for a file to be opened, memory to be allocated, a connection to be made. It does not know or care how many processes exist, where its pages physically live, or which core it runs on. Its mental model is sequential and private.

From the **kernel perspective**, the OS is a *resource arbiter and event handler*. There is no single flow of control. The kernel is mostly a large collection of handlers that run in response to events: a system call arrives, a timer fires, a disk finishes a transfer, a page fault traps. Between events, the kernel is not "running" at all — a CPU is executing some process's code, or sitting idle. The kernel's mental model is concurrent, global, and interrupt-driven.

Analogy: a restaurant. The diner's view is a menu and a waiter — order, wait, receive. The kitchen's view is a queue of tickets, contention for a limited number of pans, and constant interruptions. Both descriptions are true; neither is complete alone.

This split explains many otherwise puzzling behaviours. `sleep(1)` looks like a one-line pause to the application; to the kernel it is "remove from run queue, arm a timer, schedule someone else, and re-queue on expiry". A "slow" program may be perfectly fast in user terms and simply starved in kernel terms.

**Example**

```text
  USER VIEW  (process P)                KERNEL VIEW (whole machine)

  n = read(fd, buf, 4096);              P: state RUNNING -> BLOCKED
  /* ...one line, program pauses... */  submit disk request, queue it
  /* ...then continues... */            pick next runnable process, switch
  use(buf);                             (Q runs for 8 ms)
                                        disk interrupt: transfer complete
                                        copy to P's buffer, P -> READY
                                        scheduler eventually resumes P
```

```c
/* One user-level line; a great deal of kernel-level activity. */
#include <stdio.h>
int main(void) {
    printf("hello\n");   /* user: format string, buffer it in libc,
                            then write(1, "hello\n", 6);
                            kernel: validate fd 1, find the terminal or pipe,
                            copy from user memory, wake any blocked reader,
                            possibly block this process, return byte count */
    return 0;
}
```

Watch the two views side by side:

```bash
strace -c ./hello    # every kernel-visible event this "one line" program caused
```

**Key takeaways**

- Users see a service interface: calls, guarantees, errors, and a private sequential world.
- The kernel sees a global, concurrent, event-driven system with no single flow of control.
- The kernel runs in response to events (system calls, interrupts, traps), not as a continuous program.
- Most OS surprises come from reasoning about one view while the behaviour is explained by the other.

> 🧪 Practice
>
> 1. Write a program that calls `getpid()` in a loop one million times, then run it under `strace -c`. Explain the user view and the kernel view of the elapsed time.
> 2. For `malloc(16)`, describe what the application believes happened and what the kernel may (or may not) have done. Why are the answers different for `malloc(16)` and `malloc(16 * 1024 * 1024)`?
> 3. Interview-style: "Is the kernel a process?" Defend your answer. *Hint: ask what would schedule it, and in whose context system-call code executes.*

<a id="12-historical-evolution"></a>
### 1.2 Historical Evolution

Operating systems were not designed in one sitting; each generation added a mechanism to solve the dominant pain of its era, and every one of those mechanisms is still present in modern kernels.

#### Batch Processing Systems

**Theory**

In the 1950s a computer cost more than the building it stood in, and the scarce resource was unambiguously the machine, not the human. Yet early operation was catastrophically inefficient: a programmer signed up for an hour, walked in with a card deck, mounted tapes, ran the job, debugged at the console, and walked out. Between jobs the multi-million-dollar CPU sat idle while a human shuffled paper.

**Batch processing** removed the human from the inner loop. Jobs were collected onto a tape, and a small permanently resident program — the **resident monitor**, the direct ancestor of the kernel — read the next job, loaded it, ran it, collected its output, and immediately started the next one. This introduced ideas we still rely on:

- A **resident** piece of software that outlives individual programs.
- **Automatic job sequencing** without human intervention.
- **Job control language (JCL)**: cards that described the job rather than being part of it — the first system interface.
- Rudimentary **protection**: if a job crashed or looped forever, the monitor had to survive and move on, which required a timer and a privileged mode.

The weakness is glaring in hindsight: batch systems ran one job at a time. When the job requested I/O, the CPU stalled entirely, doing nothing until the tape or card reader finished — often 99% of the elapsed time. Turnaround was measured in hours, and interactive debugging did not exist.

**Example**

```text
   Memory layout of a batch system

   +----------------------------+  high address
   |                            |
   |     user job area          |   one job at a time
   |                            |
   +----------------------------+
   |   resident monitor         |   loader, sequencer, device drivers
   |   (ancestor of the kernel) |
   +----------------------------+  address 0

   Timeline of one job (CPU utilisation is terrible)

   CPU:  [compute]......idle......[compute]........idle........[compute]
   I/O:  ........[read tape].............[write tape]..................
```

```text
//JOB   ACCT=1234,NAME=SMITH        <- job card: who is paying
//FORT  EXEC FORTRAN                <- run the compiler
        READ(5,10) X                   the actual program follows
        ...
//LOAD  EXEC LINKEDIT               <- link it
//RUN   EXEC PGM=*.LOAD             <- and execute it
//DATA  DD *                        <- input data follows
        3.14159
/*                                  <- end of job
```

**Key takeaways**

- Batch systems automated job sequencing to eliminate idle time caused by human operators.
- The resident monitor is the first recognisable kernel: permanent, privileged, in charge of loading and sequencing.
- Job control language was the first explicit interface between users and the system.
- Fatal limitation: one job at a time, so the CPU idled through every I/O operation.

> 🧪 Practice
>
> 1. A job computes for 2 seconds, then reads tape for 18 seconds, then computes for 2 more. Compute CPU utilisation on a batch system running it alone.
> 2. Name two mechanisms the resident monitor needed in order to survive a buggy job, and explain what hardware support each requires.
> 3. Modern batch queues (Slurm, LSF, cloud batch) reintroduce the same model deliberately. What has changed, and why is it a good design again?

#### Multiprogramming

**Theory**

The batch system's fatal flaw was that I/O left the CPU idle. **Multiprogramming** fixes it with one idea: keep several jobs resident in memory simultaneously, and when the running job blocks on I/O, switch the CPU to another job that is ready. The device and the processor then work in parallel instead of taking turns.

This single change forced most of the machinery that defines an operating system:

- **Memory management and protection** — several jobs are in RAM at once, so each must be confined to its own region. Base and limit registers (later, paging) appear here.
- **CPU scheduling** — when one job blocks, some policy must choose the next.
- **Job/process state** — the system must record where a suspended job left off, giving rise to the process control block.
- **Interrupt handling** — the CPU learns of I/O completion asynchronously, so it must be able to abandon what it is doing and resume it later.
- **Device management and spooling** — devices become shared resources needing queues.

Crucially, multiprogramming optimises **throughput** (jobs completed per hour) and **utilisation**, not **response time**. A job that blocks may not be resumed for a long while; no one is watching interactively, so nobody cares yet.

Analogy: a chef cooking three dishes. Rather than standing over one pot waiting for water to boil (blocking on I/O), the chef starts the water, chops vegetables for the second dish, and seasons the third. Nothing is faster individually; the kitchen's total output rises sharply.

**Example**

```text
   UNIPROGRAMMING (one job resident)
   CPU:  [J1]......wait......[J1]......wait......[J1]
   util: about 25%

   MULTIPROGRAMMING (three jobs resident)
   CPU:  [J1][J2][J3][J1][J2][J3][J1][J2]
   I/O1:     [J1 reads.....]      [J1 reads....]
   I/O2:         [J2 writes...]
   util: about 90%  -- the CPU always finds someone ready

   Memory now holds several jobs, each needing protection:

   +-------------------+
   |   job 3           |  <- base3 / limit3
   +-------------------+
   |   job 2           |  <- base2 / limit2
   +-------------------+
   |   job 1           |  <- base1 / limit1
   +-------------------+
   |   monitor/kernel  |
   +-------------------+
```

```python
# Why utilisation rises: probability that all jobs are simultaneously blocked.
def cpu_utilisation(degree, io_fraction):
    """degree = jobs resident; io_fraction = share of time a job waits on I/O.
       Simple independence model: CPU idles only if every job is waiting."""
    return 1 - io_fraction ** degree

for n in range(1, 7):
    print(n, round(cpu_utilisation(n, 0.8), 3))
# 1 0.2   2 0.36   3 0.488   4 0.59   5 0.672   6 0.738
# Diminishing returns: each extra job helps less, and costs memory.
```

**Key takeaways**

- Multiprogramming keeps several jobs in memory and switches the CPU to a ready job whenever the running one blocks.
- It exists to raise CPU utilisation and throughput, not to improve response time.
- It forced the invention of memory protection, scheduling, saved process state, and interrupt handling.
- Returns diminish as the degree of multiprogramming rises, and memory is the binding constraint.

> 🧪 Practice
>
> 1. Using the model above, how many resident jobs are needed to exceed 90% utilisation when each job spends 70% of its time on I/O?
> 2. Explain why multiprogramming without memory protection is unsafe, and describe the minimum hardware that makes it safe.
> 3. Interview-style: "Does multiprogramming make an individual job finish sooner?" *Hint: distinguish throughput from turnaround time for a single job.*

#### Time-Sharing Systems

**Theory**

Multiprogramming kept the machine busy but left humans waiting hours for results. **Time-sharing** (or multitasking) applies the same switching machinery with a different goal: give many interactive users the *illusion* that each has the whole machine.

The key change is *why* the CPU switches. Multiprogramming switches when a job blocks. Time-sharing switches **preemptively**, on a timer, after a short quantum (typically tens of milliseconds), whether or not the job is willing. The scheduler now optimises **response time** — the delay between a keystroke and a visible reaction — rather than raw throughput.

Time-sharing brought a cluster of now-standard requirements:

- **Preemptive scheduling** driven by a hardware timer interrupt.
- **Virtual memory / swapping**, because more users than fit in RAM want to be logged in.
- **On-line file systems**, since users need to keep work between sessions instead of carrying card decks.
- **Concurrency control** for files and devices shared by simultaneous users.
- **Protection and authentication**, because users are now mutually distrusting strangers.

CTSS (MIT, 1961) demonstrated the idea; Multics attempted the grand version of it; UNIX (1969) distilled it into something small enough to survive, and every desktop, phone, and server OS today is a time-sharing system by this definition.

Human factors drive the design: a response under roughly 100 ms feels instantaneous, so a quantum must be short enough that all runnable users are served within that window — which in turn bounds how many users a machine can serve interactively.

**Example**

```text
   Preemption by timer, three interactive users

   t=0ms   timer set to 20ms, user A runs
   t=20ms  TIMER INTERRUPT -> save A, run B
   t=32ms  B blocks reading the terminal -> run C
   t=52ms  TIMER INTERRUPT -> save C, run A
           ...
   Each user perceives a slow-but-continuous private machine.

   round-robin queue:  [A] -> [B] -> [C] -> back to [A]
```

```c
/* The heart of time-sharing: a periodic timer forces the switch. */
void timer_interrupt_handler(void) {
    current->ticks_used++;                 /* charge CPU time to the running task */
    if (current->ticks_used >= QUANTUM) {  /* quantum exhausted? */
        current->state = READY;            /* it is willing or not, it yields */
        enqueue(ready_queue, current);
        schedule();                        /* pick and switch to another task */
    }
    acknowledge_timer();                   /* re-arm for the next tick */
}
```

**Key takeaways**

- Time-sharing switches preemptively on a timer to optimise interactive response time.
- It differs from multiprogramming in goal and trigger, not in underlying mechanism.
- It requires a hardware timer, virtual memory or swapping, on-line file systems, and per-user protection.
- Quantum length trades context-switch overhead against responsiveness.

> 🧪 Practice
>
> 1. With a 20 ms quantum and 200 microseconds per context switch, compute the overhead percentage. Repeat for a 2 ms quantum, and state the trade-off in one sentence.
> 2. Twenty users must each see a response within 100 ms. What is the maximum average quantum, ignoring I/O and switch cost?
> 3. Interview-style: "Why does a hardware timer interrupt have to be privileged?" *Hint: imagine a process that could disable or reprogram it.*

#### Personal and Mobile Systems

**Theory**

By the late 1970s hardware had inverted the original economics: the machine became cheap and the human expensive. If a computer serves one person, protecting users from each other looks like pure overhead — and early personal systems (CP/M, MS-DOS, classic Mac OS) duly discarded it. They were single-user, single-tasking, with no memory protection and no privilege separation; any program could scribble anywhere, and one bad pointer took down the machine.

That simplification was rolled back over two decades, for a reason worth remembering: **protection is not primarily about users, it is about faults and malice**. Even with one human present, the machine runs dozens of mutually distrusting programs, some downloaded minutes ago. Windows NT, Mac OS X, and Linux all reintroduced full multitasking, memory protection, and privilege levels on personal machines. Emphasis shifted from throughput to *user experience*: latency, responsiveness of the GUI, and rich device support.

**Mobile** systems then added a new dominant constraint: **energy**. On a phone, the scarcest resource is battery charge, and the second scarcest is thermal headroom. This inverts several classic assumptions:

| Classic desktop assumption | Mobile reality |
|---|---|
| Idle CPU is wasted capacity | Idle CPU should be powered down aggressively |
| Background processes may run freely | Background execution is restricted and batched to allow deep sleep |
| Swap to disk when memory is short | Flash wear and latency discourage swap; kill or compress instead |
| App runs until it exits | The OS may suspend or terminate an app at any time; apps must checkpoint state |

Android and iOS are UNIX-derived kernels (Linux and XNU respectively) wrapped in aggressive power management, a strict application lifecycle, and per-application sandboxing that is far stricter than traditional user-based protection.

**Example**

```text
   Where the scarce resource moved

   1960s mainframe : CPU time      -> maximise utilisation
   1980s PC        : nothing much  -> maximise simplicity (and it showed)
   2000s desktop   : user attention-> maximise responsiveness
   2010s+ mobile   : battery/heat  -> maximise idle, minimise wakeups

   Mobile app lifecycle (the OS, not the app, is in charge)

   [not running] --launch--> [foreground] --user leaves--> [background]
        ^                         ^                              |
        |                         |                        (seconds later)
        |                    --resume--                          v
        +---------memory pressure: killed--------------- [suspended]
```

```kotlin
// Mobile apps must assume they can be suspended or killed at any moment.
override fun onPause() {
    super.onPause()
    saveDraftToDisk()      // the OS may never give us another chance to run
}

override fun onStop() {
    super.onStop()
    releaseCamera()        // holding a device awake or busy drains the battery
}
```

**Key takeaways**

- Early personal systems dropped protection because there was one user; that reasoning was wrong, because protection guards against faults and hostile code, not just other people.
- Modern desktop systems are time-sharing systems optimised for interactive latency rather than throughput.
- Mobile systems treat energy and thermal budget as the primary scarce resources.
- Mobile OSes own the application lifecycle: apps must save state defensively because they can be suspended or killed without warning.

> 🧪 Practice
>
> 1. List three OS features that make sense on a laptop but are actively harmful on a phone, and explain the energy reasoning for each.
> 2. MS-DOS had no memory protection. Describe two concrete failure modes this caused, and name the hardware feature that eliminates each.
> 3. Interview-style: "Why does a phone kill background apps instead of swapping them out?" *Hint: consider flash write endurance, wake-ups, and latency together.*

#### Distributed and Cloud Systems

**Theory**

Once machines are networked, the natural question is whether the OS abstraction should stop at the box. Two answers emerged.

A **distributed operating system** tries to make a cluster of machines look like one computer: a single process namespace, transparent remote execution, a shared file system. Research systems (Amoeba, Plan 9, Sprite) pursued this. The approach collides with hard realities — partial failure (one node dies while others continue), unbounded network latency, and the impossibility of a global instantaneous view — which is why the pure form never became mainstream.

The pragmatic answer, which won, is a **network operating system**: each machine keeps its own conventional OS, and distribution is provided by services and middleware above it — remote file systems (NFS), RPC frameworks, message brokers, distributed databases, orchestration layers. Transparency is partial and explicit, and failures are visible so applications can handle them.

**Cloud computing** reframes all of this as a resource market. The provider runs an enormous multiprogrammed system whose "jobs" are entire virtual machines or containers; the classic OS problems reappear one level up:

| Classic OS problem | Cloud equivalent |
|---|---|
| CPU scheduling among processes | Placing and scheduling VMs/containers across a fleet |
| Memory allocation and protection | VM memory partitioning, ballooning, cgroup limits |
| File systems | Object storage and distributed file systems |
| Device drivers | Virtual devices and paravirtualised I/O |
| Process isolation | Hypervisor and namespace isolation between tenants |

The result is a two-level structure: a hypervisor or container runtime multiplexes hardware among guests, and each guest OS multiplexes its slice among processes. Chapters 13 and 14 return to both layers in detail.

**Example**

```text
   DISTRIBUTED OS (single system image)      NETWORK OS / CLOUD (explicit)

   +-----------------------------+           +--------+ +--------+ +--------+
   |   one logical system        |           | Linux  | | Linux  | | Linux  |
   |  proc A   proc B   proc C   |           | + apps | | + apps | | + apps |
   +-----------------------------+           +--------+ +--------+ +--------+
     node1     node2     node3                    \        |        /
     (the boundary is hidden)                      \    network    /
                                                    +-- services --+
                                                    NFS, RPC, queues,
                                                    orchestration

   Cloud stack (OS problems, one level up)

   +----------------------------------------+
   |  containers / processes per tenant     |
   +----------------------------------------+
   |  guest OS kernels                      |
   +----------------------------------------+
   |  hypervisor: schedules vCPUs, memory   |
   +----------------------------------------+
   |  physical host                         |
   +----------------------------------------+
```

```python
# Local call vs remote call: the abstraction looks similar, the failure modes do not.
value = local_dict["k"]        # fails only if the key is missing

resp = requests.get(url,       # may hang, time out, partially succeed,
                    timeout=2) # or succeed while the reply is lost
resp.raise_for_status()        # remote work needs explicit failure handling,
                               # retries, idempotency, and timeouts
```

**Key takeaways**

- Distributed OSes aimed for a single system image; partial failure and latency kept the pure model out of the mainstream.
- Network OSes plus middleware won: each node keeps its own kernel, distribution is explicit.
- Cloud platforms replay classic OS resource management at fleet scale, with VMs and containers as the scheduled units.
- The defining difference from a single machine is partial failure — parts of the system fail while others keep running.

> 🧪 Practice
>
> 1. Name three guarantees a local OS gives you that a distributed system cannot give cheaply, and say what breaks each one.
> 2. Map four classic OS mechanisms onto their cloud counterparts, in your own words.
> 3. Interview-style: "Why is transparent remote memory access harder than transparent remote file access?" *Hint: compare the latency and failure semantics each interface implicitly promises.*

<a id="13-system-architecture"></a>
### 1.3 System Architecture

An operating system is only as capable as the hardware allows; this section covers the machine features — interrupts, the storage hierarchy, and I/O paths — that every kernel mechanism is built on.

#### Computer System Organization

**Theory**

A modern computer is not a CPU with peripherals attached; it is a set of **independent processors sharing memory**. The CPU is one of them. The disk controller, the network interface, the GPU, and the DMA engine are others, each with its own local buffers and its own execution, all contending for the same system bus and the same RAM.

The consequences shape the entire kernel:

- **Concurrency is physical, not simulated.** While the CPU executes instructions, a disk controller can be writing into memory. The kernel must reason about memory being modified by something other than the CPU.
- **Devices need a way to report completion.** Since they run independently, they signal the CPU asynchronously via **interrupt request lines** feeding an interrupt controller.
- **The bus is a shared, finite resource.** Bandwidth contention between CPU and devices is real, which is why DMA and cache design matter.

The boot sequence reveals the structure. On power-up the CPU begins executing firmware (BIOS/UEFI) from a fixed address in ROM — the **bootstrap program**. It runs power-on self-test, initialises devices enough to read from them, locates a bootloader, and hands over; the bootloader loads the kernel image into memory and jumps to its entry point. The kernel then initialises its subsystems, mounts a root file system, and starts the first user process (`init`/`systemd`/`launchd`), after which the machine is event-driven forever: it does nothing until an interrupt, trap, or system call demands attention.

**Example**

```text
   Structure of a modern machine

     +---------+   +---------+          +--------------------+
     |  CPU 0  |   |  CPU 1  |          |   Memory (RAM)     |
     | +-----+ |   | +-----+ |          |                    |
     | | L1  | |   | | L1  | |          +---------+----------+
     | +--+--+ |   | +--+--+ |                    |
     +----+----+   +----+----+                    |
          |             |                         |
     =====+=============+=========================+========= system bus
               |                |                |
        +------+-----+   +------+-----+   +------+-----+
        | disk ctrl  |   | NIC        |   | GPU        |
        | +buffer    |   | +buffer    |   | +VRAM      |
        +------+-----+   +------+-----+   +------------+
               |                |
          [ SSD ]          [ network ]

        every controller runs concurrently with the CPUs
        and raises interrupts through the interrupt controller

   Boot sequence

   power on -> firmware (ROM) -> POST -> bootloader (GRUB/UEFI app)
            -> kernel image loaded -> kernel init (memory, drivers, FS)
            -> mount root -> start PID 1 -> idle, waiting for events
```

```bash
dmesg | head -40            # the kernel's own account of initialising the machine
lspci                       # the independent controllers sharing your bus
cat /proc/interrupts        # per-device, per-CPU interrupt counts
```

**Key takeaways**

- A computer is several independent processors (CPUs and device controllers) sharing memory and a bus.
- Device concurrency is genuine hardware parallelism, not an OS illusion.
- Bootstrapping proceeds from firmware in ROM through a bootloader to the kernel, ending at the first user process.
- After boot, the system is purely event-driven: it reacts to interrupts, traps, and system calls.

> 🧪 Practice
>
> 1. Inspect `/proc/interrupts` and identify which devices interrupt most. Explain why those, and what it implies about kernel CPU cost.
> 2. Why must the bootstrap program live in non-volatile memory at a fixed address? What would break otherwise?
> 3. Interview-style: "What is the first user-mode process, and why does the kernel need one at all?" *Hint: think about who starts everything else and what happens if it exits.*

#### Interrupts and Traps

**Theory**

The kernel needs a way to regain control of the CPU: when a device finishes work, when a program misbehaves, when a program requests a service, and when a time slice expires. All four use the same underlying machinery — an **interrupt**, which diverts the CPU from its current instruction stream to a handler.

There are two families, distinguished by their source:

| | **Interrupt (asynchronous)** | **Trap / exception (synchronous)** |
|---|---|---|
| Source | External hardware device | The currently executing instruction |
| Timing | Any time; unrelated to running code | Exactly at a known instruction |
| Examples | Disk complete, timer tick, key press, NIC packet | Divide by zero, page fault, invalid opcode, `syscall` |
| Reproducible | No | Yes, given the same state |

Traps split further into **faults** (correctable — resume the offending instruction, as with a page fault), **traps proper** (deliberate — resume the *next* instruction, as with a system call), and **aborts** (unrecoverable hardware errors).

The mechanism is uniform. Each cause has a number; the number indexes an **interrupt vector table** (Linux/x86: the IDT) that the kernel populates at boot with handler addresses. On an event, the hardware saves minimal state (program counter, flags), switches to kernel mode and a kernel stack, and jumps through the vector. The handler saves the remaining registers, does its work, restores state, and executes a return-from-interrupt instruction that atomically restores mode and resumes the interrupted stream.

Two practical concerns dominate handler design. **Latency**: handlers run with some interrupts disabled, so a slow handler delays everything, which is why Linux splits work into a *top half* (fast, in interrupt context) and a *bottom half* (deferred, softirq/tasklet/workqueue). **Priority and nesting**: an interrupt controller assigns priorities so urgent events can preempt less urgent handlers.

**Example**

```text
   Interrupt-driven control flow

   user process        |  hardware/kernel
   ------------------- + ---------------------------------------------
   ... executing ...   |
   MOV  R1, [X]        |
                       |  <-- device asserts IRQ line
   (instruction        |  CPU: finish current instruction,
    boundary)          |       push PC + FLAGS, switch to kernel mode,
                       |       look up vector N in the IDT, jump
                       |  handler: save registers
                       |           acknowledge the device
                       |           copy data / wake blocked process
                       |           restore registers
                       |  IRET: restore PC, FLAGS, and user mode
   ADD  R2, R1         |  <-- resumes as if nothing happened
```

```c
/* A simplified vector table and dispatch, the shape every CPU uses. */
typedef void (*handler_t)(struct regs *);
handler_t idt[256];                  /* one entry per interrupt/trap number */

void init_interrupts(void) {
    idt[0]   = divide_by_zero_trap;  /* trap: fault, raised by the instruction */
    idt[14]  = page_fault_trap;      /* trap: fault, kernel may fix and retry  */
    idt[32]  = timer_interrupt;      /* interrupt: asynchronous, from the PIT  */
    idt[46]  = disk_interrupt;       /* interrupt: asynchronous, from the disk */
    idt[128] = system_call_trap;     /* trap: deliberate, requested by software*/
}

void dispatch(int vector, struct regs *r) {
    idt[vector](r);                  /* hardware supplies the vector number    */
}
```

**Key takeaways**

- Interrupts are asynchronous and device-driven; traps are synchronous and instruction-driven.
- Faults resume the offending instruction, traps resume the next one, aborts do not resume at all.
- The vector table maps each cause to a handler; hardware switches mode and stack automatically.
- Handlers must be short; long work is deferred to bottom halves to keep interrupt latency low.

> 🧪 Practice
>
> 1. Classify each: pressing a key, `int 0x80`, dereferencing a null pointer, a machine-check error, a page fault on a valid but swapped-out page.
> 2. Explain why the return-from-interrupt instruction must restore the privilege level and the program counter atomically. What attack becomes possible otherwise?
> 3. Interview-style: "Why can't an interrupt handler call a function that might block?" *Hint: ask which process's context the handler is borrowing, and who would be put to sleep.*

#### Storage Hierarchy

**Theory**

No single memory technology is simultaneously fast, large, cheap, and persistent — physics forbids it. Systems therefore stack several technologies into a **hierarchy**, each level larger, slower, and cheaper per byte than the one above.

| Level | Typical size | Typical latency | Volatile | Managed by |
|---|---|---|---|---|
| Registers | < 1 KB | ~0.3 ns | Yes | Compiler |
| L1 cache | 32-64 KB | ~1 ns | Yes | Hardware |
| L2/L3 cache | 0.5-64 MB | 4-40 ns | Yes | Hardware |
| Main memory | 8-512 GB | ~80 ns | Yes | OS (paging) |
| Flash/SSD | 0.25-8 TB | 20-100 microseconds | No | OS (file system) |
| Hard disk | 1-20 TB | 5-10 ms | No | OS (file system) |
| Tape/archive | petabytes | seconds to minutes | No | OS + operator |

The hierarchy works only because of **locality of reference**. *Temporal locality*: a byte used now is likely to be used again soon. *Spatial locality*: a byte used now makes its neighbours likely next. Real programs exhibit both, so a small fast level can serve the great majority of accesses from a large slow one behind it.

Every level is a **cache** of the level below, and each raises the same three questions: what to keep, what to evict, and how to stay consistent when a copy is modified. The OS is directly responsible for two of these levels — RAM as a cache of disk (Chapter 8) and the buffer cache as a cache of file blocks (Chapter 10) — and must respect the hardware-managed ones through cache-friendly data structures.

The numbers are the point. If a memory access is one second in human terms, an SSD access is about a day and a disk seek about four months. Any design that turns a memory access into a disk access has changed its cost by five orders of magnitude, which is why page-fault behaviour dominates performance in Chapter 8.

**Example**

```text
        smaller, faster, costlier per byte
              ^
              |   +-------------+
              |   |  registers  |  <1 KB      0.3 ns
              |   +-------------+
              |   |  L1 cache   |  64 KB      1 ns
              |   +-------------+
              |   |  L2/L3      |  32 MB      10-40 ns
              |   +-------------+
              |   | main memory |  32 GB      80 ns
              |   +-------------+
              |   |  SSD        |  1 TB       50 us     <- persistent below here
              |   +-------------+
              |   |  hard disk  |  8 TB       8 ms
              |   +-------------+
              |   |  tape       |  PB         minutes
              v   +-------------+
        larger, slower, cheaper per byte
```

```python
# Locality is not theoretical: identical work, different access order.
N = 4096
matrix = [[1.0] * N for _ in range(N)]

total = 0.0
for i in range(N):            # row-major traversal: consecutive addresses
    for j in range(N):        # each cache line brings in the next values needed
        total += matrix[i][j] # high spatial locality -> mostly cache hits

total = 0.0
for j in range(N):            # column-major traversal over row-major storage
    for i in range(N):        # each access lands on a different cache line
        total += matrix[i][j] # poor locality -> often several times slower
```

**Key takeaways**

- The hierarchy trades speed against capacity and cost; no level is optional.
- It only works because programs exhibit temporal and spatial locality.
- Every level is a cache of the one below, with placement, eviction, and coherence questions.
- Latency gaps span orders of magnitude, so crossing a level is a performance event, not a detail.

> 🧪 Practice
>
> 1. Given a 90% cache hit rate, 1 ns hits and 80 ns misses, compute the average access time. Recompute at 99%. Comment on the sensitivity.
> 2. Run the two loops above with a large matrix in C or NumPy and measure both. Explain the ratio in terms of cache lines.
> 3. Interview-style: "Which levels of the hierarchy does the OS manage, and which does it only influence?" *Hint: ask which transfers require a software decision and which happen without any instruction executing.*

#### I/O Structure

**Theory**

I/O is where the CPU meets a world that is millions of times slower than it is, and the structure of I/O handling is essentially a set of strategies for not wasting the CPU while waiting.

A device is reached through its **controller**, which exposes registers: a *data* register, a *status* register (busy, ready, error), a *command* register, and often a *control* register. The CPU accesses them either through dedicated I/O instructions on separate port addresses (`in`/`out` on x86) or, more commonly today, through **memory-mapped I/O**, where the registers appear at physical addresses and ordinary loads and stores reach them.

Given that interface, there are three ways to run a transfer:

| Strategy | How it works | CPU cost | Good for |
|---|---|---|---|
| **Programmed I/O (polling)** | CPU loops reading the status register until ready, then moves the data itself | Very high; CPU burns cycles waiting | Tiny transfers, very fast devices, early boot |
| **Interrupt-driven I/O** | CPU issues the request, blocks the process, and is interrupted on completion | One interrupt per transfer unit; CPU still copies bytes | Character devices, moderate rates |
| **DMA** | A DMA engine moves the data directly to or from memory; one interrupt for the whole block | Lowest; CPU is free during the transfer | Disks, networking, any bulk transfer |

Polling is not always wrong: at very high device speeds (NVMe, 100 Gb networking) the cost of taking an interrupt can exceed the wait, which is why modern drivers use hybrid schemes (Linux NAPI switches from interrupts to polling under load).

The OS layers this into a **device driver** per device that hides the register-level protocol behind a uniform kernel interface, so the file system and network stack never touch a status register.

**Example**

```text
   Three ways to read one block

   POLLING                INTERRUPT-DRIVEN            DMA
   -------                ----------------            ---
   issue cmd              issue cmd                   program DMA (addr,len)
   while(!ready);         block the process           block the process
   for each word:         (CPU runs other work)       (CPU runs other work;
     copy word            interrupt on ready           device writes RAM itself)
   done                   handler copies words        interrupt when block done
                          resume process              resume process
   CPU busy: 100%         CPU busy: per word/IRQ      CPU busy: 2 events total
```

```c
/* Programmed I/O: correct, simple, and wasteful. */
int pio_read_block(uint8_t *dst, int nwords) {
    outb(CMD_REG, CMD_READ);                    /* tell the device what to do   */
    while ((inb(STATUS_REG) & STATUS_READY) == 0)
        ;                                       /* spin: the CPU does nothing   */
    for (int i = 0; i < nwords; i++)
        dst[i] = inw(DATA_REG);                 /* CPU personally moves each word */
    return nwords;
}

/* Memory-mapped I/O: the same registers reached as memory. */
volatile uint32_t *ctrl = (volatile uint32_t *)0xFED00000; /* volatile: never cache
                                                              or reorder these */
ctrl[CMD] = CMD_READ;                            /* a store that starts a device */
```

**Key takeaways**

- Devices are driven through controller registers, accessed via port I/O or memory-mapped I/O.
- Polling wastes CPU but has the lowest latency and no interrupt overhead; it wins for very fast devices.
- Interrupt-driven I/O frees the CPU during the wait but costs one interrupt per unit of transfer.
- Device drivers exist to hide all of this behind a uniform kernel-internal interface.

> 🧪 Practice
>
> 1. A device delivers a byte every 5 microseconds. Compare polling and interrupt-driven I/O for a 4 KB transfer, assuming 2 microseconds of interrupt overhead per event.
> 2. Explain why device register pointers must be declared `volatile` in C, and give a concrete bug caused by omitting it.
> 3. Interview-style: "When is polling faster than interrupts?" *Hint: compare interrupt entry/exit cost with expected wait time on an NVMe device.*

#### Direct Memory Access

**Theory**

Interrupt-driven I/O still leaves the CPU doing the actual copying: for a 4 KB block, that is a thousand loads and stores of data the CPU has no interest in. **Direct Memory Access** removes the CPU from the data path entirely. A DMA controller — today usually built into the device itself, as a bus-mastering peripheral — is told a memory address, a length, and a direction, and it performs the transfer over the bus while the CPU executes unrelated code. One interrupt is raised when the whole block is done.

The gain is dramatic: interrupts per 4 KB block fall from hundreds or thousands to one, and the CPU is available throughout. This is what makes gigabyte-per-second storage and 10+ Gb/s networking feasible at all.

DMA is not free of consequences, and each one shapes kernel code:

- **Cache coherence.** The device writes RAM directly, so stale copies may sit in the CPU cache. Either the hardware snoops the bus (usual on x86) or the driver must explicitly flush/invalidate ranges (common on ARM embedded parts).
- **Physical addresses and pinning.** The DMA engine typically works with physical addresses and knows nothing of page tables, so target pages must be pinned in memory and physically contiguous (or described by a scatter-gather list).
- **Protection.** A device that can write anywhere in RAM is a security hole — the basis of DMA attacks over Thunderbolt/PCIe. An **IOMMU** solves this by giving devices their own address translation, so a device can only touch memory explicitly mapped for it.
- **Ordering.** The completion interrupt must not be observed before the data lands; memory barriers and correctly ordered descriptor writes are essential.

Analogy: interrupt-driven I/O is carrying boxes yourself, one at a time, whenever the courier rings. DMA is giving the courier a key to the storeroom and asking to be told once when everything is delivered. Faster, and exactly as risky as it sounds — which is what the IOMMU is for.

**Example**

```text
   WITHOUT DMA                          WITH DMA

   device --> CPU register --> RAM      device -----------------> RAM
              (every word)                        (bus master)
                                        CPU: free to run other processes
   CPU: consumed by copying             one completion interrupt at the end

   Transfer setup and completion

   1. driver allocates a pinned buffer, gets its physical address
   2. driver programs: src=device, dst=0x3F2A0000, len=4096, dir=to-memory
   3. driver starts the engine, blocks the process, returns to the scheduler
   4. DMA engine moves 4096 bytes across the bus (CPU runs other work)
   5. engine raises ONE interrupt: "transfer complete"
   6. handler invalidates caches if needed, marks the process READY
```

```c
/* Typical driver-side DMA setup (Linux-flavoured, simplified). */
dma_addr_t dma_handle;
void *buf = dma_alloc_coherent(dev, 4096, &dma_handle, GFP_KERNEL);
/* dma_alloc_coherent gives a buffer that is:
     - physically contiguous
     - pinned (never swapped or moved)
     - coherent between CPU cache and device, or accompanied by sync calls
   dma_handle is the address the DEVICE uses; buf is the address the CPU uses.
   With an IOMMU they differ, and the device can reach nothing else. */

writel(dma_handle, dev->base + REG_DMA_ADDR);   /* where to put the data */
writel(4096,       dev->base + REG_DMA_LEN);    /* how much              */
wmb();                                          /* barrier: all of the above
                                                   must be visible before start */
writel(START_READ, dev->base + REG_CMD);        /* go; CPU is now free    */
```

**Key takeaways**

- DMA lets a device transfer directly to or from memory, reducing the CPU to setup plus one completion interrupt.
- It is what makes high-bandwidth storage and networking possible.
- Its costs are cache coherence, buffer pinning with physical or scatter-gather addressing, and ordering barriers.
- Unrestricted DMA is a serious security risk; an IOMMU confines each device to explicitly mapped memory.

> 🧪 Practice
>
> 1. A 1 MB transfer moves in 64-byte units. Compute the number of interrupts with interrupt-driven I/O versus DMA, and the CPU time saved at 2 microseconds per interrupt.
> 2. Explain why a DMA target buffer must be pinned. What would go wrong if the OS swapped that page out mid-transfer?
> 3. Interview-style: "How does an IOMMU differ from an MMU, and what attack does it stop?" *Hint: one translates for the CPU, the other for devices; think about a malicious PCIe card.*

<a id="14-operating-system-structures"></a>
### 1.4 Operating System Structures

Kernels must decide how much code runs with full privilege and how that code is decomposed; the answers form a spectrum from one large privileged blob to a minimal core surrounded by unprivileged servers.

#### Monolithic Kernels

**Theory**

In a **monolithic kernel**, the entire operating system — scheduler, memory manager, file systems, network stack, device drivers — is compiled into a single program that runs in kernel mode, in one address space. Any part can call any other part with an ordinary function call.

This is the oldest structure and, measured by deployed machines, overwhelmingly the winner: Linux, the BSDs, and traditional UNIX are all monolithic (Linux is more precisely a *modular* monolith, covered below).

The advantage is **performance and simplicity of interaction**. A file system read that needs a disk block calls the block layer directly: one function call, nanoseconds, no marshalling, shared data structures. There is no boundary to cross between subsystems.

The costs are equally structural:

- **No fault isolation.** A bug in any driver can corrupt any kernel data structure. Drivers are the majority of kernel code and the least reviewed, and they run with full privilege over everything.
- **Weak enforced modularity.** Nothing stops a subsystem from reaching into another's internals; discipline is by convention and review, not by hardware.
- **Large trusted computing base.** Millions of lines run privileged, so the attack surface is enormous.
- **Maintenance friction.** Changing a widely used internal interface means touching many subsystems at once.

Analogy: an open-plan workshop where every tool is within arm's reach. Work is fast because nothing is locked away, and one careless person with an angle grinder can ruin everyone's project.

**Example**

```text
   MONOLITHIC KERNEL

   user mode   | applications                         |
   ------------+--------------------------------------+  system call boundary
   kernel mode | +----------------------------------+ |
               | | syscall interface                | |
               | | file systems | network stack     | |
               | | scheduler    | memory manager    | |
               | | device drivers (bulk of the code)| |
               | +----------------------------------+ |
               |   one address space, one privilege   |
   -------------------------------------------------+
                            hardware

   A file read never leaves kernel mode:
     sys_read() -> vfs_read() -> ext4_file_read() -> block layer -> driver
     all plain function calls
```

```c
/* Inside a monolithic kernel: direct calls, shared structures, zero ceremony. */
ssize_t vfs_read(struct file *f, char __user *buf, size_t n, loff_t *pos) {
    if (!(f->f_mode & FMODE_READ))
        return -EBADF;
    return f->f_op->read(f, buf, n, pos);  /* straight into the file system,
                                              which calls the block layer,
                                              which calls the driver --
                                              all at full privilege, no IPC */
}
```

**Key takeaways**

- All OS services run privileged in one address space and call each other directly.
- Excellent performance: no boundary crossings between subsystems.
- No fault isolation — a single driver bug can compromise the whole kernel.
- The trusted computing base is very large, which is a security and maintenance liability.

> 🧪 Practice
>
> 1. Run `wc -l` over a kernel source tree's `drivers/` directory versus the rest. What does the ratio imply about where kernel bugs come from?
> 2. Give two concrete failure scenarios that a monolithic design cannot contain but a microkernel could.
> 3. Interview-style: "If monolithic kernels have no fault isolation, why did they win?" *Hint: weigh IPC cost per operation against the frequency of driver faults in mature code.*

#### Layered Architecture

**Theory**

The **layered approach** imposes structure by decomposing the OS into N levels, where layer 0 is the hardware and layer N is the user interface. The defining rule: **layer k may use only the services of layer k-1**, and it exports a cleaner interface upward.

The appeal is intellectual control. Each layer can be designed, implemented, and debugged using only the layers beneath it, which are already correct — so verification proceeds bottom-up, and the dependency graph is acyclic by construction. Dijkstra's THE system (1968) demonstrated this with six layers, from processor allocation up through memory, console, I/O, and user programs.

Two problems keep pure layering rare in practice:

- **Layer definition is genuinely hard.** Many services are mutually dependent. The memory manager may need to swap to disk, which needs the disk driver; but the disk driver needs memory for its buffers. Which layer is lower? Real systems break the cycle with pinned buffers and special cases — that is, by violating the model.
- **Performance.** A request from the top must traverse every intermediate layer, each adding parameter checking and copying. A read might cross five layers and be copied at several of them.

The idea survives in weakened form nearly everywhere: the network stack is layered by protocol, the storage stack is layered (VFS, file system, block layer, driver), and hypervisors layer guests over hosts. The discipline is applied where the dependency structure genuinely permits it, and abandoned where it does not.

**Example**

```text
   Layered OS (strict form)

   layer 5 | user programs                     |
   layer 4 | user interface / shell            |
   layer 3 | I/O management and buffering      |
   layer 2 | operator-console device driver    |
   layer 1 | memory management and swapping    |
   layer 0 | CPU allocation, multiprogramming  |
           +-----------------------------------+
             hardware

   Rule: each layer calls only downward, never sideways or upward.

   Cost of the discipline:

   read() -> layer4 checks args -> layer3 buffers -> layer2 driver call
          -> layer1 ensures pages -> layer0 blocks the process
   five interface crossings for one logical operation
```

```text
   Layering that DID survive: the storage stack

   application            read("/data/f", buf, 4096)
       |
   VFS layer              uniform file operations, path resolution
       |
   file system (ext4)     inode -> logical block numbers
       |
   block layer            request queue, merging, I/O scheduling
       |
   device driver (NVMe)   submission/completion queues, registers
       |
   hardware
```

**Key takeaways**

- Layering restricts each level to using only the level below, making the design acyclic and debuggable bottom-up.
- Strict layering is rarely achievable because real OS services have circular dependencies.
- Every layer crossing costs argument checking and often copying, which harms performance.
- The idea persists in subsystem stacks (networking, storage) rather than as whole-kernel structure.

> 🧪 Practice
>
> 1. Sketch a five-layer OS and place: process scheduler, page swapper, disk driver, file system, shell. Justify each position.
> 2. Explain the memory-manager/disk-driver circular dependency concretely, and describe two ways real kernels break it.
> 3. Interview-style: "The TCP/IP stack is layered and fast. Why doesn't the layering argument hurt it as much?" *Hint: consider where the copies happen and how much work each layer does per crossing.*

#### Microkernels

**Theory**

The **microkernel** approach asks: what is the *minimum* that must run privileged? The answer is roughly address-space management, thread scheduling, and inter-process communication. Everything else — file systems, device drivers, network stacks, even paging policy — is moved into ordinary user-mode **server processes**, which communicate with each other and with applications by message passing through the kernel.

This inverts the monolithic trade-off:

- **Fault isolation is real and hardware-enforced.** A crashing disk driver takes down one unprivileged process, which a supervisor can restart while the system keeps running.
- **The trusted computing base shrinks dramatically** — seL4 is roughly 10,000 lines and has a machine-checked proof of functional correctness, which is inconceivable for a monolithic kernel.
- **Extensibility improves.** Adding or replacing a file system means starting a different server, not rebuilding and rebooting the kernel.
- **Security policy becomes explicit**, since every cross-component interaction is a message that can be mediated.

The historical cost is **IPC overhead**. What was one function call in a monolith becomes: user process → kernel → server → kernel → driver server → kernel → back, with context switches and data copying at each hop. First-generation microkernels (Mach) were slow enough that this became the standard objection. Second-generation designs (L4 and descendants) attacked it directly with tiny, register-based synchronous IPC, cutting the cost by more than an order of magnitude and making the argument much closer.

Microkernels dominate where **assurance beats raw throughput**: QNX in cars and medical devices, seL4 in security-critical systems, MINIX 3 running inside Intel's Management Engine, and the hypervisor-like cores of several phone secure worlds.

**Example**

```text
   MICROKERNEL

   user mode | app | file | device | network | paging  |
             |     |server| driver | server  | server  |
   ----------+--+--+--+---+---+----+----+----+----+----+
                |     |       |         |         |
                +-----+---- messages ---+---------+
   kernel mode |  address spaces | threads | IPC          |
               |  (only these three things)               |
   ------------+------------------------------------------+
                            hardware

   A file read now crosses the boundary several times:

   app --msg--> [kernel] --> file server
   file server --msg--> [kernel] --> disk driver server
   disk driver talks to hardware, replies
   ... and back again

   Monolithic: 1 syscall, N function calls
   Microkernel: 1 syscall, 4-6 IPC round trips
```

```c
/* Microkernel-style client: a "system call" is a message to a server. */
struct fs_request  req = { .op = FS_READ, .fd = fd, .len = 4096 };
struct fs_response resp;

ipc_call(FILE_SERVER, &req, sizeof req, &resp, sizeof resp);
/* The kernel: validates the sender, blocks this thread, copies (or maps)
   the message, and schedules the file server. The file server itself may
   ipc_call() the disk driver server. Every hop is a scheduling event --
   which is exactly why L4-family IPC is optimised so ferociously. */
```

**Key takeaways**

- The kernel keeps only address spaces, threads, and IPC; all other services run as unprivileged servers.
- Fault isolation and a tiny trusted computing base are the payoff — small enough for formal verification.
- Message passing replaces function calls, so IPC performance determines whether the design is viable.
- Microkernels dominate safety- and security-critical domains rather than general-purpose desktops.

> 🧪 Practice
>
> 1. Trace `open("/etc/passwd")` through a microkernel, listing every IPC hop and context switch. Compare with the monolithic path.
> 2. Explain how a microkernel can restart a crashed disk driver transparently. What state must be reconstructed, and who holds it?
> 3. Interview-style: "Why is seL4 formally verifiable when Linux is not?" *Hint: think about lines of privileged code, and about what a proof must range over.*

#### Modular Kernels

**Theory**

The **modular** (or loadable-module) approach is the pragmatic synthesis that most production systems actually use. The kernel remains monolithic — one address space, full privilege, direct calls — but is built from components that can be **loaded and unloaded at runtime** through well-defined internal interfaces.

This captures much of the microkernel's flexibility at none of its IPC cost:

- **Dynamic extensibility.** A driver for hardware plugged in five minutes ago is loaded on demand; an unused subsystem never occupies memory.
- **Defined interfaces.** Modules register through registration APIs (a `file_system_type`, a `pci_driver` struct) rather than by patching the kernel, so coupling is documented.
- **No performance penalty.** Once loaded, a module is ordinary kernel code called directly. There is no boundary.
- **Faster development.** Rebuild and reload one module rather than the whole kernel.

What it explicitly does *not* buy is isolation. A loaded module has full kernel privilege; a bug in it can panic the machine or corrupt anything. Modularity here is a *software engineering* property, not a *protection* property — a distinction worth being crisp about, because it is a common interview trap.

Linux is the canonical example, with thousands of modules; Solaris was built around the idea; FreeBSD's KLDs are the same concept. The recent trend is to add real safety to this model without a redesign — eBPF programs are verified before being allowed to run in kernel context, and Rust drivers use language-level guarantees, both aiming at "modules that cannot corrupt the kernel".

**Example**

```text
   MODULAR MONOLITHIC KERNEL

   kernel mode | +-------------------------------------------+
               | | core: scheduler, memory, VFS, IPC, net    |
               | +----+------------+------------+------------+
               |      | registration interfaces              |
               |  +---+---+   +----+----+   +---+-----+
               |  | ext4  |   | nvme    |   | wifi    |  <- loadable modules,
               |  | module|   | driver  |   | driver  |     same privilege,
               |  +-------+   +---------+   +---------+     loaded on demand
               +-------------------------------------------+

   Loaded modules are NOT isolated. The dashed lines are interfaces,
   not protection boundaries.
```

```bash
lsmod | head                 # modules currently loaded
modinfo nvme                 # its declared interface, parameters, dependencies
sudo modprobe -r nvme        # unload (fails if in use -- reference counting)
sudo modprobe nvme           # load again on demand
```

```c
/* A Linux module registers through a defined interface, then runs privileged. */
static struct file_system_type myfs_type = {
    .owner   = THIS_MODULE,
    .name    = "myfs",
    .mount   = myfs_mount,
    .kill_sb = kill_block_super,
};

static int __init myfs_init(void) {
    return register_filesystem(&myfs_type);  /* plug into the VFS at runtime */
}
static void __exit myfs_exit(void) {
    unregister_filesystem(&myfs_type);       /* clean removal, refcount permitting */
}
module_init(myfs_init);
module_exit(myfs_exit);
```

**Key takeaways**

- Modular kernels keep the monolithic address space but load components dynamically through registration interfaces.
- They gain extensibility and development speed with no IPC cost.
- Modules run at full kernel privilege — this is modularity, not isolation.
- eBPF verification and Rust drivers are attempts to add real safety to the module model.

> 🧪 Practice
>
> 1. Compare `lsmod` output on a laptop and a container host. Explain the differences in terms of hardware and workload.
> 2. Why can `modprobe -r` fail even when a module appears idle? Explain reference counting and give a scenario.
> 3. Interview-style: "Does loading a module as a `.ko` file make it safer than compiling it in?" *Hint: separate deployment flexibility from privilege; ask what changes at run time.*

#### Hybrid Designs

**Theory**

No shipping general-purpose OS is purely monolithic, purely layered, or purely microkernel. **Hybrid designs** deliberately mix structures, keeping performance-critical services in the kernel while pushing others out, and adopting microkernel-style message passing internally where the flexibility pays.

Three mainstream examples show the pattern:

- **Windows NT and successors.** Structurally microkernel-influenced: a hardware abstraction layer, a small "kernel" layer handling scheduling and interrupts, and an Executive of subsystems above it. But the Executive, the graphics subsystem (moved into the kernel in NT 4.0 for performance), and drivers all run in kernel mode. Environment subsystems (Win32, and formerly POSIX/OS-2) run as user-mode processes, giving microkernel-style personalities on a monolithic core.
- **macOS/iOS (XNU — "X is Not UNIX").** Literally a hybrid: a Mach microkernel core providing IPC, virtual memory, and thread scheduling, with a full BSD kernel *in the same address space* providing the POSIX interface, file systems, and networking, plus the I/O Kit driver framework in C++. Mach's IPC and memory-object abstractions are used, but calls between Mach and BSD parts are function calls, not messages — the isolation is given up to reclaim the performance.
- **Linux with user-space components.** Formally a modular monolith, but FUSE puts file systems in user space, DPDK and SPDK put network and storage drivers there for performance, and microVMs push isolation outward. The result is monolithic in structure and increasingly hybrid in deployment.

The honest reading: "hybrid" describes engineering compromise rather than a distinct theory. The recurring question is not which label applies but **which components deserve the privilege and cost of living inside the kernel**, and that answer changes as IPC cost, hardware features, and threat models change.

**Example**

```text
   WINDOWS NT (simplified)

   user mode   | Win32 apps | subsystem processes (Win32, WSL) | services |
   ------------+-------------------------------------------------------+
   kernel mode | Executive: I/O mgr, object mgr, memory mgr, security  |
               | Kernel layer: scheduling, interrupts, synchronisation |
               | Drivers | Graphics (moved in for speed)               |
               | Hardware Abstraction Layer (HAL)                      |
   ------------+-------------------------------------------------------+

   XNU (macOS/iOS)

   kernel mode | BSD layer: POSIX API, VFS, sockets, signals           |
               | Mach layer: IPC, VM, threads, scheduling              |
               | I/O Kit: C++ driver framework                         |
               | (all three share ONE address space -- the "hybrid")   |
```

```text
   Where does a component belong? The recurring trade-off

   in-kernel                         out-of-kernel (user space)
   ---------                         --------------------------
   + no boundary crossings           + faults are contained
   + direct access to structures     + restart without reboot
   + lowest latency                  + easier to develop and debug
   - a fault kills the system        - IPC and copy costs per operation
   - enlarges the trusted base       - harder to reach hardware directly

   Examples of the same component on both sides:
     file systems : ext4 (in kernel)      vs sshfs/FUSE (user space)
     network      : Linux stack (kernel)  vs DPDK (user space)
     graphics     : Win32k (kernel)       vs X server (user space)
```

**Key takeaways**

- Every mainstream OS is a hybrid; pure structural models are teaching devices, not products.
- Windows NT layers a microkernel-influenced Executive but runs subsystems and drivers in kernel mode.
- XNU combines a Mach core and a BSD kernel in a single address space, trading isolation for speed.
- The real design question is per-component: does this service earn kernel privilege, given current IPC and hardware costs?

> 🧪 Practice
>
> 1. NT 4.0 moved the graphics subsystem from user mode into the kernel. State the gain and the cost, and say whether you would make the same call today.
> 2. Compare an in-kernel file system with the same file system over FUSE: list the performance and reliability differences you would expect, and design a benchmark to measure them.
> 3. Interview-style: "Is XNU a microkernel?" *Hint: separate the provenance of the code from the address-space boundaries that actually exist at run time.*

#### Exokernels

**Theory**

Every structure so far assumes the kernel should provide abstractions. The **exokernel** (MIT, mid-1990s) challenges exactly that assumption, with a sharp argument: *abstractions are policy, and policy in the kernel is imposed on everyone, including applications that would do better with a different one*.

A database knows its own access patterns and would like to control disk layout and its own buffer replacement; the kernel's general-purpose page cache and file system get in the way. A garbage collector could avoid double paging if it knew about physical frames. A web server would like to lay out its own disk blocks.

The exokernel therefore does one thing: **securely multiplex hardware resources** — it tracks ownership of physical pages, disk blocks, and CPU time, and enforces protection — while providing no abstractions at all. Applications link against a **library operating system (libOS)** that implements files, virtual memory, and processes *in user space*, and may replace any of it.

- **Separation of protection from management.** The kernel decides *who may use* a block; the libOS decides *what it means*.
- **Application-level flexibility.** Different applications on one machine can use entirely different file systems or paging policies.
- **Performance from specialisation.** Aegis/ExOS demonstrated order-of-magnitude improvements on operations where the general abstraction was a poor fit.
- **Costs:** protection without abstraction is genuinely hard (tracking ownership of raw blocks securely is subtle), sharing between differently-abstracted applications becomes awkward, and application programmers must either use a libOS or handle hardware detail.

Exokernels never shipped commercially, but the idea is now everywhere in disguise: unikernels (MirageOS, IncludeOS) are libOS designs; user-space networking (DPDK) and storage (SPDK) bypass kernel abstractions for exactly the stated reason; io_uring reduces kernel mediation; and virtual machines are arguably exokernels that expose a hardware-shaped interface to guest libOSes.

**Example**

```text
   TRADITIONAL                          EXOKERNEL

   app                                  app + libOS A   app + libOS B
    | files, VM, processes               | own FS,       | own FS,
   ---------------------                 | own paging    | log-structured
   kernel: abstractions                 -----------------------------------
   kernel: multiplexing                  exokernel: secure multiplexing only
   ---------------------                 (owns: which app holds which frame,
   hardware                               block, and time slice)
                                        -----------------------------------
                                         hardware

   The kernel enforces WHO may touch a resource.
   The libOS decides WHAT that resource means.
```

```c
/* Exokernel-flavoured: the application manages physical resources itself. */
/* Ask for specific physical disk blocks, not a file. */
blockno_t blocks[64];
exo_disk_alloc(disk_id, 64, blocks);        /* kernel: ownership + protection */

/* The libOS -- not the kernel -- decides what these blocks mean. */
my_db_layout_index(blocks, 32);             /* application-specific layout    */
my_db_layout_heap(blocks + 32, 32);         /* tuned to this workload exactly */

/* Same idea, shipping today: user-space storage via SPDK. */
spdk_nvme_ns_cmd_read(ns, qpair, buf, lba, count, cb, arg, 0);
/* The kernel is out of the data path entirely; the application owns
   queueing, buffering, and scheduling policy. */
```

**Key takeaways**

- Exokernels remove abstractions from the kernel, keeping only secure multiplexing of physical resources.
- Applications link a library OS and can implement or replace file systems, paging, and process models.
- The motivating insight is that kernel abstractions embed policy that suits average applications, not specific ones.
- The design never went mainstream, but unikernels, DPDK/SPDK, io_uring, and VMs all reuse its core idea.

> 🧪 Practice
>
> 1. Name two applications that would clearly benefit from managing their own disk layout, and state the specific abstraction that hurts them today.
> 2. Explain how an exokernel enforces protection over raw disk blocks without understanding files. What must it track, and what attack must it prevent?
> 3. Interview-style: "In what sense is a hypervisor an exokernel?" *Hint: compare what each multiplexes, and what plays the role of the library OS.*

<a id="15-system-interfaces"></a>
### 1.5 System Interfaces

This section examines the boundary itself: how a program crosses from its own world into the kernel's, what hardware makes the crossing safe, and which layers of software sit on top of it.

#### System Calls

**Theory**

A user program cannot touch hardware, allocate physical memory, or read a disk — it lacks the privilege. Yet programs plainly do all of these things. The bridge is the **system call**: a controlled, deliberate request for the kernel to perform a privileged operation on the caller's behalf.

The crucial property is that it is not a function call into a library. It is an *interface between protection domains*, with three defining characteristics:

1. **Privilege transition.** The CPU changes from user mode to kernel mode as part of the call, and back on return.
2. **Controlled entry point.** Control does not land wherever the caller says. The hardware jumps to one fixed kernel entry point, which dispatches on a call number. A program cannot enter the middle of a kernel routine, only the front door.
3. **Distrust of arguments.** Every argument comes from a potentially hostile program and must be validated: pointers checked against the caller's address space, lengths bounded, file descriptors verified as open and permitted.

System calls group into a small number of categories, and this list is essentially a table of contents for the rest of the book:

| Category | Examples | Covered in |
|---|---|---|
| Process control | `fork`, `execve`, `exit`, `wait`, `kill` | Chapter 2 |
| File management | `open`, `read`, `write`, `close`, `lseek`, `stat` | Chapter 10 |
| Device management | `ioctl`, `read`, `write`, `mmap` | Chapter 11 |
| Information | `getpid`, `time`, `uname`, `sysinfo` | this chapter |
| Communication | `pipe`, `socket`, `send`, `recv`, `shmget` | Chapter 2 |
| Protection | `chmod`, `setuid`, `umask`, `capset` | Chapter 12 |

Linux has roughly 350 system calls; Windows has far more native calls but exposes them through documented APIs instead. The count matters less than the principle: the system call interface is the *entire* legitimate surface between applications and the kernel, and it is therefore both the compatibility contract and the security perimeter.

**Example**

```text
   The system call boundary

   user mode   |  program                                     |
               |    write(1, "hi", 2)                         |
               |       |                                      |
               |    libc wrapper: put 1 in rax (call number), |
               |    args in rdi/rsi/rdx, execute SYSCALL      |
   ============|=======|======================================| privilege change
   kernel mode |    single entry point: entry_SYSCALL_64      |
               |    validate rax < NR_syscalls                |
               |    call sys_call_table[rax] -> sys_write()   |
               |    validate fd, validate user pointer+len    |
               |    do the work, put result in rax            |
               |    SYSRET                                    |
   ============|======================================================
   user mode   |    check return value, set errno if negative |
```

```c
#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <errno.h>

int main(void) {
    /* The ordinary way: a libc wrapper that hides the mechanism. */
    write(1, "via libc\n", 9);

    /* The same kernel service, invoked directly by call number. */
    syscall(SYS_write, 1, "via syscall()\n", 14);

    /* Error convention: kernel returns a negative errno; libc converts it. */
    int n = write(-1, "x", 1);            /* an invalid file descriptor */
    if (n < 0)
        perror("write");                  /* prints: write: Bad file descriptor */
    return 0;
}
```

```bash
gcc demo.c -o demo && strace -e trace=write ./demo
# Every crossing of the boundary is visible, and nothing else is.
```

**Key takeaways**

- A system call is a protected request to the kernel, not a library function call.
- It performs a privilege transition, enters at one fixed dispatch point, and validates every argument.
- The system call set is the complete legitimate interface between user space and the kernel.
- Return values follow a convention (negative errno in Linux) that the C library turns into `-1` plus `errno`.

> 🧪 Practice
>
> 1. Run `strace ls` and count distinct system calls used. Group them into the six categories above.
> 2. Write a C program that calls `getpid()` via libc and via `syscall(SYS_getpid)`, and time a million iterations of each. Explain the difference.
> 3. Interview-style: "Why must the kernel copy arguments from user memory rather than dereferencing user pointers directly?" *Hint: consider a pointer to kernel memory, and a second thread modifying the buffer after validation.*

#### System Call Implementation

**Theory**

Following one system call from instruction to instruction removes most of the mystery, and explains why the crossing is expensive.

**The call number and the table.** Since the kernel exposes one entry point, the caller must indicate which service it wants. It places an integer — the system call number — in a designated register (`rax` on x86-64, `x8` on ARM64), and arguments in a fixed sequence of registers. The kernel uses that number to index the **system call table**, an array of function pointers. Bounds-checking that index is essential; an unchecked index is an immediate full-system compromise.

**The instruction.** Older x86 used a software interrupt (`int 0x80`) — correct but slow, since it goes through the full interrupt path. Modern CPUs provide dedicated fast instructions (`syscall`/`sysret` on x86-64, `svc` on ARM64) that switch mode with far less work by caching the kernel entry point and stack pointer in model-specific registers.

**The crossing itself.** The hardware switches to kernel mode, loads the kernel stack pointer for this thread, and jumps to the registered entry point. Kernel entry code then saves the user register set, switches to the kernel's view of memory, and dispatches. On return, the reverse happens.

**Why it costs.** Even a fast system call costs on the order of 100-300 ns — hundreds of times a function call. The costs are register save/restore, the mode switch, and, since Meltdown/Spectre, kernel page-table isolation (KPTI) which changes address space on every crossing, plus speculation barriers. This cost is why batching interfaces exist: `readv`/`writev` transfer multiple buffers per call, `epoll` reports many ready descriptors at once, `io_uring` uses shared submission and completion ring buffers to submit thousands of operations with no crossing at all, and **vDSO** maps a small kernel-provided page into every process so calls like `gettimeofday()` can be answered in user mode without any transition.

**Example**

```text
   Anatomy of write(1, buf, 2) on x86-64

   USER                                  KERNEL
   ----                                  ------
   mov rax, 1        ; __NR_write
   mov rdi, 1        ; fd
   mov rsi, buf      ; buffer pointer
   mov rdx, 2        ; length
   syscall  ------------------------->   hardware: mode -> kernel,
                                         load kernel RSP, jump to entry
                                         entry_SYSCALL_64:
                                           save user registers
                                           swapgs; switch page tables (KPTI)
                                           cmp rax, __NR_syscall_max
                                           ja  bad_syscall        ; bounds check!
                                           call *sys_call_table[rax*8]
                                             sys_write():
                                               fdget(fd)          ; validate fd
                                               access_ok(buf,len) ; validate ptr
                                               vfs_write(...)     ; do the work
                                           restore registers
                                         sysret
   test rax, rax  <-------------------   result in rax (negative = -errno)
   js   error
```

```c
/* The dispatch table, conceptually. */
typedef long (*syscall_fn)(long, long, long, long, long, long);

const syscall_fn sys_call_table[] = {
    [0]  = sys_read,
    [1]  = sys_write,
    [2]  = sys_open,
    [57] = sys_fork,
    /* ... roughly 350 entries ... */
};

long do_syscall(struct pt_regs *regs) {
    unsigned long nr = regs->rax;
    if (nr >= ARRAY_SIZE(sys_call_table))   /* MUST bounds check: an unchecked
                                               index is arbitrary kernel jump */
        return -ENOSYS;
    return sys_call_table[nr](regs->rdi, regs->rsi, regs->rdx,
                              regs->r10, regs->r8,  regs->r9);
}
```

```python
# Why batching interfaces exist: the crossing, not the work, dominates.
# 1,000,000 single-byte writes  -> 1,000,000 crossings (~200 ns each = 0.2 s of pure overhead)
# 1,000 writes of 1000 bytes    ->     1,000 crossings (~0.0002 s)
# io_uring: submit 1,000,000 ops via a shared ring -> potentially 0 crossings
```

**Key takeaways**

- The call number selects an entry in the system call table; bounds-checking it is a security requirement.
- Modern CPUs provide dedicated fast entry instructions instead of software interrupts.
- A crossing costs hundreds of nanoseconds — register save/restore, mode switch, KPTI page-table switch.
- Batching (`writev`, `epoll`, `io_uring`) and the vDSO exist specifically to avoid or amortise crossings.

> 🧪 Practice
>
> 1. Measure the cost of a crossing: time 10 million `getpid()` calls, then 10 million calls to an empty local function. Explain the ratio.
> 2. `gettimeofday()` is often faster than `getpid()` despite doing more work. Explain why, in terms of the vDSO.
> 3. Interview-style: "What breaks if the kernel forgets to bounds-check the system call number?" *Hint: the table is an array of function pointers, and the index came from the attacker.*

#### API vs System Call

**Theory**

Application programmers almost never invoke system calls directly. They call an **API** — most often the C standard library, or a language runtime, or a framework — and the API calls the kernel. Understanding the distinction prevents a great deal of confusion about performance, portability, and errors.

| | **API (e.g. libc, Win32, java.io)** | **System call (e.g. `write`)** |
|---|---|---|
| Runs in | User mode | Transitions to kernel mode |
| Defined by | A library specification (POSIX, Win32) | A specific kernel's ABI |
| Portability | Portable across systems implementing it | Tied to one kernel and architecture |
| Stability | Very stable, versioned | Stable on Linux, private on Windows/macOS |
| May do extra work | Yes: buffering, caching, retries, formatting | No: exactly the requested service |

Three consequences matter in practice:

- **APIs may not call the kernel at all.** `printf()` formats and buffers in user space and may issue no `write` until the buffer fills or is flushed — which is why output can appear out of order or be lost on a crash. `malloc()` usually satisfies requests from a user-space pool, calling `brk`/`mmap` only occasionally.
- **APIs may retry or adapt.** A library `read` wrapper may loop over short reads or restart on `EINTR`; the raw call does not.
- **Portability lives in the API layer.** Windows has no `fork`; macOS's raw call numbers are not stable and Apple explicitly requires going through libSystem. Writing against POSIX rather than a specific kernel ABI is what makes source portability possible at all.

Analogy: the system call is the factory loading dock; the API is the retail shop. The shop may keep stock on hand (buffering), split or combine your order (batching), and speak your language (portable naming), but the goods ultimately come from the same dock.

**Example**

```text
   Layers between your code and the kernel

   application     printf("n = %d\n", n)
        |
   C library       format into a user-space buffer
        |          (may return here with NO kernel involvement)
        |          on flush: write(1, buf, len)
        |
   syscall stub    load rax=1, args in registers, SYSCALL
   ================================================== boundary
   kernel          sys_write -> vfs_write -> tty/pipe/file
```

```c
#include <stdio.h>
#include <unistd.h>

int main(void) {
    /* API: buffered, formatted, portable. May issue zero system calls here. */
    printf("through the API\n");

    /* System call: unbuffered, exact, one crossing, right now. */
    write(1, "through the syscall\n", 20);

    /* Without a flush, the API line can appear AFTER the syscall line,
       because it is still sitting in a user-space buffer. */
    fflush(stdout);   /* forces the buffered data across the boundary */
    return 0;
}
```

```bash
strace -e trace=write ./demo          # to a terminal: line-buffered
strace -e trace=write ./demo > out    # to a file: fully buffered -- watch the
                                      # write() count collapse to one
```

**Key takeaways**

- Applications call APIs; APIs call system calls. They are different layers with different guarantees.
- An API call may perform no system call at all (buffering, caching, user-space allocation).
- Portability is provided by the API layer, since kernel ABIs differ and some are unstable by policy.
- Buffering explains many classic surprises: interleaved output, data lost on crash, and misleading write counts.

> 🧪 Practice
>
> 1. Run the demo above with output to a terminal and redirected to a file, under `strace`. Explain the different `write` counts.
> 2. Write a program that `printf`s then crashes via `abort()` without flushing. Explain what is lost and why.
> 3. Interview-style: "Why does Apple discourage direct system calls on macOS, while Linux guarantees its ABI forever?" *Hint: ask what each vendor wants to be free to change, and where the compatibility contract is drawn.*

#### Shells and Command Interpreters

**Theory**

The **shell** is the program that reads commands and asks the kernel to run them. It is worth studying not because command lines are important in themselves, but because the shell is the clearest small example of an OS interface built entirely out of system calls — and it demonstrates that the command interpreter is *not* part of the kernel.

A shell's main loop is short in principle: read a line, parse it, and either execute a **builtin** (a command the shell must implement itself) or run an **external program**. The distinction between the two is instructive. `cd` must be a builtin, because changing directory means calling `chdir()` in the *shell's own* process — a child process changing its own directory and exiting would accomplish nothing. `ls` is external, so the shell forks a child and replaces its image.

The classic UNIX pattern is `fork()` + `execve()` + `wait()`:

- `fork()` creates a near-identical child process; both continue from the same point, distinguished only by the return value.
- `execve()` in the child replaces its memory image with a new program, keeping the process identity and open file descriptors.
- `wait()` in the parent blocks until the child terminates and collects its exit status.

The apparent inefficiency of copying a process just to overwrite it is exactly what makes UNIX composable: between the fork and the exec, the child is an ordinary process that the shell can modify — redirect its file descriptors, change its working directory, drop privileges, join a process group. That window is how `>`, `<`, `|`, and job control are implemented, with no special support in the kernel or in the programs being run. Chapter 2 develops this in full.

Windows takes the alternative route: `CreateProcess()` does creation and program loading in one call with a large parameter block, which avoids the copy but folds all customisation into arguments.

**Example**

```text
   Shell running `ls -l > out.txt`

   shell process
     |  fork()
     +-----------------> child process (a copy of the shell)
     |                     |  open("out.txt", O_WRONLY|O_CREAT|O_TRUNC)
     |                     |  dup2(fd, 1)      <- redirect stdout, the window
     |                     |  close(fd)           between fork and exec
     |                     |  execve("/bin/ls", ["ls","-l"], env)
     |                     |     (image replaced; fd 1 still points at out.txt)
     |  wait(&status) <----+  child exits
     |  print prompt
```

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>

int main(void) {
    char line[256];
    while (printf("mysh$ "), fflush(stdout), fgets(line, sizeof line, stdin)) {
        line[strcspn(line, "\n")] = '\0';           /* strip the newline */
        if (line[0] == '\0') continue;

        if (strncmp(line, "cd ", 3) == 0) {         /* BUILTIN: must run in
                                                       this process to matter */
            if (chdir(line + 3) != 0) perror("cd");
            continue;
        }

        pid_t pid = fork();                          /* one call, two returns */
        if (pid == 0) {                              /* child: pid == 0 */
            char *argv[] = { line, NULL };
            execlp(argv[0], argv[0], (char *)NULL);  /* replaces this image */
            perror("exec");                          /* only reached on failure */
            _exit(127);
        } else if (pid > 0) {                        /* parent: pid == child */
            int status;
            waitpid(pid, &status, 0);                /* reap it; avoid zombies */
            if (WIFEXITED(status) && WEXITSTATUS(status))
                fprintf(stderr, "exit %d\n", WEXITSTATUS(status));
        } else {
            perror("fork");
        }
    }
    return 0;
}
```

**Key takeaways**

- The shell is an ordinary user program, not part of the kernel; it can be replaced freely.
- Builtins (`cd`, `exit`, `export`) must run in the shell's own process; everything else is fork + exec.
- The gap between `fork()` and `execve()` is where redirection, pipes, and job control are implemented.
- Windows `CreateProcess()` merges creation and loading, trading that customisation window for fewer copies.

> 🧪 Practice
>
> 1. Extend the shell above to support `>` redirection using `open` and `dup2`. Verify with `strace -f`.
> 2. Explain precisely why `cd` cannot be an external program. What would happen if you wrote `/bin/cd` and ran it?
> 3. Interview-style: "Why does UNIX separate `fork` from `exec` when almost every fork is followed immediately by an exec?" *Hint: think about what the child can do in between, and how pipes would otherwise be implemented.*

#### User Mode vs Kernel Mode

**Theory**

Everything in this chapter — protection, system calls, the kernel's authority — rests on one hardware feature: the CPU has at least two **modes of execution**, indicated by a mode bit (on x86, the current privilege level, rings 0 through 3; in practice ring 0 for the kernel and ring 3 for user code).

The mode determines what the running code is allowed to do:

| | **User mode (ring 3)** | **Kernel mode (ring 0)** |
|---|---|---|
| Privileged instructions | Trap if attempted | Permitted |
| Memory reachable | Only pages mapped and marked user-accessible | All of physical memory |
| I/O access | Denied (no port I/O, no device registers) | Permitted |
| Interrupt control | Cannot disable interrupts | Can disable and mask |
| Page tables | Cannot modify | Owns them |
| Effect of a bug | One process dies | System panic or silent corruption |

**Privileged instructions** are the enforcement point: loading the page-table base register, disabling interrupts, executing `halt`, writing device registers, changing the mode bit itself. Attempting any of them in user mode raises a trap, and the kernel typically terminates the offending process. This is what makes the protection non-negotiable — a program cannot *choose* to become privileged; it can only *request* a service through the controlled system call entry.

Two implications are worth internalising:

- **Mode is a property of the CPU right now, not of the process.** When your process makes a system call, the CPU runs kernel code *in your process's context*, then returns to user mode. The same thread of execution spans both.
- **The transition is always through a hardware-defined path.** System calls, interrupts, and traps are the only ways in; the return instruction is the only way out. There is no instruction "become privileged".

Some architectures add more rings: hypervisors run at a level below ring 0 (VMX root mode, EL2 on ARM), and secure worlds (TrustZone EL3, SMM) sit below that. Each is a further partition of the same idea, and Chapter 13 returns to it.

**Example**

```text
   Mode transitions -- the only doors in and out

              +----------------------------------------+
   USER MODE  |  application code                      |
   (ring 3)   |  restricted instruction set            |
              +--+---------+---------+-----------+-----+
                 |         |         |           ^
        syscall  |  trap   | interrupt |         | IRET / SYSRET
        (voluntary) (fault)  (external)          | (the only way back)
                 v         v         v           |
              +--+---------+---------+-----------+-----+
   KERNEL     |  handlers, drivers, subsystems         |
   MODE       |  full instruction set, all memory      |
   (ring 0)   +----------------------------------------+

   Note: the SAME thread crosses the line. Kernel code usually runs
   in the context of whichever process happened to be executing.
```

```c
#include <stdio.h>

int main(void) {
    /* A privileged instruction attempted from user mode.
       On x86-64, CLI (clear interrupt flag) is ring-0 only. */
    asm volatile ("cli");     /* general protection fault -> SIGSEGV
                                 The kernel is not asking politely; the
                                 hardware refused before any effect occurred. */
    printf("never printed\n");
    return 0;
}
```

```bash
# Observe where time is actually spent on each side of the boundary.
time ./cpu_bound_program
# real 0m2.10s   user 0m2.08s   sys 0m0.01s   <- almost all user mode

time ./io_bound_program
# real 0m3.40s   user 0m0.12s   sys 0m1.90s   <- much of it in kernel mode
```

**Key takeaways**

- A hardware mode bit distinguishes user mode from kernel mode and gates privileged instructions, memory access, and I/O.
- Attempting a privileged instruction in user mode traps; there is no instruction to elevate privilege voluntarily.
- Mode belongs to the CPU at an instant: kernel code usually runs inside the calling process's context.
- The only entries to kernel mode are system calls, traps, and interrupts; the only exit is the return-from-trap instruction.

> 🧪 Practice
>
> 1. Compile and run the `cli` example. Interpret the signal you receive, and identify which component (hardware or kernel) refused first.
> 2. Use `time` on a compute-heavy program and an I/O-heavy one. Explain the `user` versus `sys` split in terms of execution mode.
> 3. Interview-style: "Without a mode bit, could an OS still enforce protection?" *Hint: consider software fault isolation, interpretation, and language-based safety — then ask what each costs and what it must trust.*

---

<a id="2-processes"></a>
## 2. Processes

The process is the operating system's central abstraction: the unit of execution, of resource ownership, and of protection, and the thing that every other mechanism in this book ultimately serves or constrains. This chapter defines what a process is as opposed to a program, examines the data structures and memory layout that give it substance, follows it through creation and termination, and ends with the mechanisms by which processes — deliberately isolated from one another — communicate anyway. Understanding processes precisely makes scheduling, memory management, and security follow naturally.

<a id="21-process-concept"></a>
### 2.1 Process Concept

This section builds the mental model: what a process actually is, how its memory is arranged, what states it moves through, what the kernel records about it, and what happens when the CPU switches from one to another.

#### Program vs Process

**Theory**

The distinction seems pedantic until it becomes the source of confusion, so it is worth nailing down first.

A **program** is a passive entity: a file on disk containing instructions, initialised data, and metadata describing how to load it. It has no state, consumes no CPU, and can sit unchanged for years. `/bin/ls` is a program.

A **process** is an active entity: a program *in execution*, together with everything that execution needs — the current values of the registers, a program counter marking the next instruction, a stack of pending function calls, a heap of dynamically allocated memory, a set of open files, an identity (which user is running it), and the accounting the kernel keeps about it.

The relationship is one-to-many, in both directions:

- **One program, many processes.** Ten users running `ls` simultaneously produce ten processes from one program file. They share the read-only instruction pages in physical memory but have entirely separate stacks, heaps, and register sets. Nothing one does affects another.
- **One process, many programs over its lifetime.** A process can replace its program image (via `execve`) while keeping its identity, open files, and relationships — the basis of how shells work.

Analogy: a program is a recipe; a process is a cook actively making the dish. The recipe is one document in the drawer; three cooks can work from copies of it simultaneously, each at a different step, each with their own pans and half-chopped onions. Burning one dish does not affect the others, and a cook could put down one recipe and pick up another without ceasing to be that cook.

The practical payoff: when reasoning about a running system, never ask "what does the program do" but "what state is this process in". Bugs, resource usage, and scheduling all attach to the process, not to the file.

**Example**

```text
   ON DISK (passive)                  IN MEMORY (active)

   /bin/ls                            process 4412 (user alice)
   +------------------+                 PC=0x4011a8  registers, stack, heap
   | ELF header       |    execve       open files: 0,1,2  cwd=/home/alice
   | .text  (code)    |  ----------->
   | .data  (init'd)  |               process 4419 (user bob)
   | .rodata          |                 PC=0x401340  its own stack and heap
   | symbol table     |                 open files: 0,1,2,7  cwd=/tmp
   +------------------+
     ONE file                          TWO independent processes
                                       (the .text pages are shared read-only)
```

```c
#include <stdio.h>
#include <unistd.h>

/* This same program, run three times, yields three processes with
   three different PIDs and three independent copies of `counter`. */
int counter = 0;                 /* .data section in the FILE;
                                    a private, writable page in each PROCESS */
int main(void) {
    printf("program image: same for everyone\n");
    printf("process identity: pid=%d, parent=%d\n", getpid(), getppid());
    counter++;                   /* each process increments ITS OWN copy */
    printf("counter=%d\n", counter);   /* always 1, no matter how many run */
    return 0;
}
```

```bash
./demo & ./demo & ./demo &   # one program file, three processes
ps -o pid,ppid,cmd -C demo   # three distinct PIDs, one command
```

**Key takeaways**

- A program is a passive file on disk; a process is an active execution with state.
- One program can back many concurrent processes, each with private data, stack, and registers.
- One process can execute several programs over its lifetime while keeping its identity and open files.
- Resource usage, scheduling, and faults are properties of processes, never of program files.

> 🧪 Practice
>
> 1. Start three copies of the same long-running program and use `ps -o pid,ppid,rss,cmd` to show that they are distinct processes. Which columns differ, and which do not?
> 2. Explain why two processes running `/bin/bash` can have different current directories despite identical program images.
> 3. Interview-style: "If ten processes run the same 4 MB program, how much physical memory does the code occupy?" *Hint: distinguish read-only text pages from writable data pages, and think about page sharing.*

#### Process Memory Layout

**Theory**

Every process gets its own virtual address space — a private, apparently contiguous range of addresses. That space is not undifferentiated; it is divided into regions with different contents, permissions, and growth behaviour, and knowing the layout explains a large fraction of real-world bugs.

From low addresses upward:

| Region | Contents | Permissions | Size behaviour |
|---|---|---|---|
| **Text (code)** | Machine instructions | Read + execute, not writable | Fixed at load time |
| **Data** | Initialised globals and statics | Read + write | Fixed |
| **BSS** | Uninitialised globals (zero-filled) | Read + write | Fixed; occupies no space in the file |
| **Heap** | Dynamic allocations (`malloc`, `new`) | Read + write | Grows upward on demand |
| **Memory maps** | Shared libraries, mapped files, large allocations | Varies | Placed between heap and stack |
| **Stack** | Call frames: locals, return addresses, saved registers | Read + write | Grows downward automatically |

Three design decisions in this layout are worth understanding:

- **Heap and stack grow toward each other** from opposite ends of the free space. This lets a program be heap-heavy or stack-heavy without the OS having to guess the split in advance.
- **Text is read-only and executable; stack and heap are writable and (on modern systems) non-executable.** The W^X ("write xor execute") rule is what stops classic code injection: an attacker who writes shellcode onto the stack finds that page is not executable.
- **BSS exists to keep executables small.** A 100 MB zeroed array costs zero bytes in the file — the loader just maps zero-filled pages.

The classic failures map directly onto the layout: a **stack overflow** is deep recursion growing the stack into a guard page; a **memory leak** is a heap that grows without bound; a **segmentation fault** is touching an address in no mapped region; and writing through a pointer to a string literal faults because literals live in read-only memory.

**Example**

```text
   Virtual address space of one process (typical x86-64 Linux)

   0x7fff_ffff_ffff  +------------------------+  high addresses
                     |  kernel space (not     |  mapped but inaccessible
                     |  reachable in ring 3)  |  from user mode
   0x7fff_ffff_0000  +------------------------+
                     |  environment, argv     |
                     +------------------------+
                     |  STACK                 |  locals, return addresses
                     |          |             |  grows DOWNWARD
                     |          v             |
                     +------------------------+
                     |  (guard page)          |  faults on overflow
                     |                        |
                     |  ~~~ free space ~~~    |
                     |                        |
                     +------------------------+
                     |  memory maps           |  libc.so, mmap'd files,
                     |  (shared libraries)    |  big malloc allocations
                     +------------------------+
                     |          ^             |
                     |          |             |  grows UPWARD
                     |  HEAP                  |  malloc / new
                     +------------------------+  <- program break (brk)
                     |  BSS (zero-filled)     |  uninitialised globals
                     +------------------------+
                     |  DATA                  |  initialised globals
                     +------------------------+
                     |  TEXT (code)           |  read + execute only
   0x0000_0000_4000  +------------------------+
   0x0000_0000_0000  |  unmapped              |  null-pointer traps land here
                     +------------------------+
```

```c
#include <stdio.h>
#include <stdlib.h>

int   initialised   = 42;      /* DATA: value stored in the executable file  */
int   uninitialised;           /* BSS:  no file space, zeroed at load time   */
const char *literal = "hi";    /* the STRING lives in read-only text/rodata  */

void recurse(int depth) {
    char frame[1024];          /* 1 KB of STACK per call: recursion is finite */
    frame[0] = (char)depth;
    if (depth < 100000) recurse(depth + 1);   /* eventually: stack overflow   */
}

int main(void) {
    int local = 1;                     /* STACK */
    int *dynamic = malloc(sizeof(int)); /* pointer on the stack, data on HEAP */

    printf("text     ~ %p\n", (void *)main);
    printf("data     ~ %p\n", (void *)&initialised);
    printf("bss      ~ %p\n", (void *)&uninitialised);
    printf("heap     ~ %p\n", (void *)dynamic);
    printf("stack    ~ %p\n", (void *)&local);
    /* Addresses print in increasing order: text < data < bss < heap < stack */

    /* literal[0] = 'H';  <- would segfault: rodata is not writable */
    free(dynamic);
    return 0;
}
```

```bash
cat /proc/self/maps      # the kernel's own view of a process's regions
                         # columns: range, perms (r-xp, rw-p), offset, path
```

**Key takeaways**

- A process's address space is divided into text, data, BSS, heap, memory maps, and stack.
- Heap grows upward and stack downward, letting either dominate the free space between them.
- Text is read-execute and stack/heap are write-no-execute, which blocks classic code injection.
- Most memory bugs are layout violations: stack overflow, leaks, null dereference, writing to read-only literals.

> 🧪 Practice
>
> 1. Run the program above and confirm the address ordering. Then run it twice — do the addresses match? Explain (consider ASLR).
> 2. Inspect `cat /proc/self/maps`. Identify the text, heap, stack, and at least one shared library, using the permission column as evidence.
> 3. Interview-style: "Why does declaring `int big[10000000];` as a global produce a small executable, but as a local variable it crashes?" *Hint: compare where each lives and which region has a hard size limit.*

#### Process States

**Theory**

A process is not always running — in fact, on a busy system it is running a small fraction of the time. The kernel tracks what each process is doing with a **state**, and the set of legal states and transitions is the skeleton of the scheduler.

The classic five-state model:

| State | Meaning | What it is waiting for |
|---|---|---|
| **New** | Being created; PCB allocated, not yet admitted | Admission by the kernel |
| **Ready** | Runnable, waiting only for a CPU | A free core (scheduler's decision) |
| **Running** | Executing instructions on a CPU right now | Nothing — it has the CPU |
| **Blocked (Waiting)** | Cannot proceed until an event occurs | I/O completion, a lock, a signal, a child |
| **Terminated (Zombie)** | Finished executing; exit status not yet collected | Its parent to call `wait` |

The transitions matter more than the names:

- **Ready → Running** — *dispatch*: the scheduler chose this process.
- **Running → Ready** — *preemption*: the time slice expired or a higher-priority process became ready. The process is still perfectly able to run.
- **Running → Blocked** — the process requested something unavailable (a disk read, an empty pipe). It is *voluntarily* giving up the CPU because it cannot use it.
- **Blocked → Ready** — the event occurred. Note it goes to Ready, *not* Running: being unblocked does not mean being scheduled.
- **Running → Terminated** — `exit()` or fatal signal.

The critical insight for reasoning about performance: **Ready and Blocked are completely different problems**. A process stuck in Ready is starved of CPU — the machine is overloaded, and adding cores or reducing load helps. A process stuck in Blocked is waiting for a device or a lock — more CPU would change nothing. Confusing them leads to the wrong fix.

Real kernels refine the model. Linux distinguishes interruptible sleep (`S`, wakeable by signals) from uninterruptible sleep (`D`, usually mid-I/O, and the cause of processes that cannot be killed), plus stopped (`T`) and zombie (`Z`).

**Example**

```text
   Classic five-state model

              admit                dispatch
   [NEW] ------------> [READY] ---------------> [RUNNING] ----> [TERMINATED]
                          ^                        |    exit
                          |     preemption         |
                          +------------------------+
                          |                        |
                          |                        | request I/O / wait
                          |    event occurs        v
                          +------------------ [BLOCKED]

   Note: BLOCKED never goes directly to RUNNING.
   Being woken up only makes you eligible; the scheduler still decides.

   Linux state letters, as shown by ps:
     R  running or runnable (running + ready share this letter)
     S  interruptible sleep   (waiting, can be woken by a signal)
     D  uninterruptible sleep (usually mid-I/O; kill -9 will not work)
     T  stopped (SIGSTOP, or under a debugger)
     Z  zombie (exited, awaiting its parent's wait())
```

```python
# A simulation making the transitions explicit.
class Process:
    def __init__(self, pid):
        self.pid, self.state = pid, "NEW"

    def admit(self):        self._to("READY",   from_={"NEW"})
    def dispatch(self):     self._to("RUNNING", from_={"READY"})
    def preempt(self):      self._to("READY",   from_={"RUNNING"})   # still able to run
    def block(self, why):   self._to("BLOCKED", from_={"RUNNING"})   # cannot proceed
    def wake(self):         self._to("READY",   from_={"BLOCKED"})   # NOT to RUNNING
    def exit(self):         self._to("TERMINATED", from_={"RUNNING"})

    def _to(self, new, from_):
        if self.state not in from_:                  # illegal transitions are bugs
            raise RuntimeError(f"{self.state} -> {new} is not permitted")
        self.state = new

p = Process(1)
p.admit(); p.dispatch(); p.block("disk read"); p.wake(); p.dispatch(); p.exit()
```

```bash
ps -eo pid,stat,wchan:20,cmd | head   # STAT column plus what a sleeper waits on
```

**Key takeaways**

- The five classic states are New, Ready, Running, Blocked, and Terminated.
- Preemption moves Running to Ready; blocking moves Running to Blocked — the causes are entirely different.
- A woken process re-enters Ready, never Running directly; the scheduler retains control.
- Ready-starvation means too little CPU; Blocked-starvation means slow I/O or lock contention. The fixes are unrelated.

> 🧪 Practice
>
> 1. Run `ps -eo pid,stat,cmd` and count processes in each state. Explain why `S` dominates on an idle desktop.
> 2. Write a program that sleeps, one that spins, and one that reads a large file. Observe each in `ps` and match the state letter to the cause.
> 3. Interview-style: "Why can't `kill -9` terminate a process in state `D`?" *Hint: ask where the process is executing at that moment and what would happen to an in-flight DMA transfer.*

#### Process Control Block

**Theory**

If a process is to be stopped and later resumed as if nothing happened, the kernel must store everything needed to reconstruct it. That store is the **Process Control Block** (PCB) — in Linux, `struct task_struct`. It is the process, as far as the kernel is concerned: the process's memory and registers may be swapped, saved, or scattered, but the PCB is the authoritative record tying them together.

A PCB holds roughly five families of information:

| Category | Contents | Used by |
|---|---|---|
| **Identity** | PID, PPID, user/group IDs, process group, session | Security, signals, job control |
| **CPU state** | Saved registers, program counter, stack pointer, flags | Context switching |
| **Scheduling** | State, priority, time slice remaining, CPU time used, queue links | The scheduler |
| **Memory** | Page table base, region descriptors, limits | The MMU and memory manager |
| **Resources** | Open file table, working directory, signal handlers, IPC objects | File and IPC subsystems |

Three properties follow from this:

- **The PCB lives in kernel memory**, never in the process's own address space. A process cannot read or corrupt its own PCB — otherwise it could grant itself privileges or priority.
- **PCBs are linked into many structures at once.** The same PCB sits in the run queue (or a wait queue), in the parent's child list, in a global process table, and in a hash by PID. Kernel data structures overlap heavily.
- **PCB size bounds the process count.** Linux's `task_struct` is several kilobytes; with kernel stacks, each process costs on the order of 8-16 KB before any user memory. This is the concrete reason processes are "heavier" than threads.

Analogy: a hospital patient chart. The patient (the running program) may be in surgery, in a ward, or in the waiting room; the chart records identity, current status, medications, and who is responsible. Staff coordinate entirely through charts, and the chart is kept by the hospital, not carried by the patient.

**Example**

```text
   Process Control Block

   +--------------------------------------+
   | pid = 4412        ppid = 4400        |  identity
   | uid = 1000        gid = 1000         |
   +--------------------------------------+
   | state = BLOCKED   priority = 20      |  scheduling
   | time_slice = 3ms  cpu_time = 1.42s   |
   | *next_in_queue ------------------->  |
   +--------------------------------------+
   | saved registers:                     |  CPU state
   |   PC  = 0x4011a8   SP = 0x7ffd2a10   |  (valid only when NOT running)
   |   rax = 0x0  rbx = 0x5  ...          |
   +--------------------------------------+
   | page table base = 0x1a2b3000         |  memory
   | text/data/heap/stack region limits   |
   +--------------------------------------+
   | open files: [0]->tty [1]->pipe ...   |  resources
   | cwd = /home/alice                    |
   | signal handlers, pending signals     |
   +--------------------------------------+

   One PCB, many lists at once:

   run queue:   PCB_7 -> PCB_3 -> PCB_9
   disk wait:   PCB_4412 -> PCB_88
   child list of 4400: PCB_4412 -> PCB_4413
```

```c
/* A teaching-sized PCB: every field answers "what must survive a switch?" */
struct pcb {
    /* identity */
    pid_t  pid, ppid;
    uid_t  uid;

    /* CPU state: meaningful only while the process is NOT on a CPU */
    struct context { uint64_t rip, rsp, rbp, rax, rbx, rflags; } ctx;

    /* scheduling */
    enum { NEW, READY, RUNNING, BLOCKED, ZOMBIE } state;
    int    priority, time_slice_left;
    uint64_t cpu_time_used;

    /* memory */
    void  *page_table_base;          /* loaded into CR3 on switch */
    struct mm_region *regions;

    /* resources */
    struct file *open_files[MAX_FD]; /* index = file descriptor number */
    char   cwd[PATH_MAX];
    sighandler_t handlers[NSIG];

    /* linkage: one PCB belongs to several lists simultaneously */
    struct pcb *next_in_queue;       /* run queue OR a wait queue */
    struct pcb *parent, *children, *next_sibling;
};
```

```bash
ls /proc/self/            # the kernel exporting PCB contents as files
cat /proc/self/status     # state, PIDs, UIDs, memory, signal masks
ls -l /proc/self/fd/      # the open file table from the PCB
```

**Key takeaways**

- The PCB is the kernel's complete record of a process and the reason a process can be suspended and resumed.
- It holds identity, saved CPU state, scheduling data, memory descriptors, and resource tables.
- It resides in kernel memory, unreachable by the process itself, which is what makes protection enforceable.
- Its size is a real cost: a few kilobytes per process before any user memory, which is why threads are cheaper.

> 🧪 Practice
>
> 1. Read `/proc/self/status` and match ten fields to the PCB categories in the table above.
> 2. Explain what would go wrong if the saved register set were stored in the process's own stack rather than in kernel memory.
> 3. Interview-style: "Why is the saved program counter meaningless while a process is in the Running state?" *Hint: ask where the authoritative copy of the PC lives at that moment.*

#### Context Switching

**Theory**

A **context switch** is the act of saving one process's CPU state and restoring another's, so that a single core can be shared. It is the mechanism that makes multiprogramming and time-sharing possible, and it is pure overhead — no user work happens during it.

The sequence, triggered by a timer interrupt, a blocking system call, or a higher-priority wakeup:

1. **Trap into the kernel** — hardware saves a minimal frame (PC, flags) and switches to kernel mode.
2. **Save the outgoing context** — the remaining general-purpose registers, stack pointer, and (lazily, if used) floating-point and vector state are written into the outgoing PCB.
3. **Update state and queues** — mark the process Ready or Blocked and place its PCB on the appropriate queue.
4. **Choose a successor** — the scheduler picks the next process (Chapter 4 covers how).
5. **Switch address space** — load the new page-table base register. On x86 this writes CR3.
6. **Restore the incoming context** — load registers from the incoming PCB.
7. **Return from trap** — resume in user mode at the new process's saved PC.

The cost has two components, and the second is larger and less visible:

- **Direct cost:** the register save/restore and scheduling logic, roughly 1-5 microseconds.
- **Indirect cost:** cache and TLB pollution. The new process finds caches full of the old process's data and must refill them from memory. The TLB may be flushed entirely on address-space change (mitigated by tagged TLBs / PCIDs). This "cache-warming" penalty often exceeds the direct cost by an order of magnitude.

This is precisely why threads of the same process are cheaper to switch between: step 5 is skipped, and the caches and TLB stay largely valid.

Analogy: switching a workbench between two craftsmen. Putting away one set of tools and laying out the other is the direct cost. The larger cost is that the incoming craftsman's materials, references, and half-finished parts are all in storage and must be fetched again.

**Example**

```text
   Context switch on a timer interrupt

   Process A (user)      | Kernel                        | Process B (user)
   ----------------------+-------------------------------+------------------
   executing ...         |                               |
       TIMER INTERRUPT --> hardware: save PC/flags,       |
                         | switch to kernel mode+stack    |
                         | save A's registers into PCB_A  |
                         | PCB_A.state = READY            |
                         | enqueue(run_queue, PCB_A)      |
                         | next = schedule()  -> PCB_B    |
                         | load CR3 = PCB_B.page_table    | <- address space change
                         |   (TLB flush / PCID switch)    |
                         | restore registers from PCB_B   |
                         | PCB_B.state = RUNNING          |
                         | IRET ------------------------->| resumes exactly
                         |                                | where it left off
   (frozen; caches now   |                                |
    hold B's data)       |                                |

   Cost profile:
     direct   : ~1-5 us   (register save/restore, scheduler)
     indirect : ~10-100 us of degraded performance while caches/TLB refill
```

```c
/* The core of a context switch, in shape if not in detail. */
void context_switch(struct pcb *out, struct pcb *in) {
    save_registers(&out->ctx);          /* freeze the outgoing process       */

    if (out->page_table_base != in->page_table_base)
        load_page_table(in->page_table_base);  /* skipped for threads of the
                                                  SAME process -- this is why
                                                  thread switches are cheap  */
    in->state = RUNNING;
    out->state = (out->state == RUNNING) ? READY : out->state;

    restore_registers(&in->ctx);        /* execution continues as `in` on the
                                          next instruction after ITS save    */
}
```

```bash
vmstat 1        # the "cs" column: context switches per second
pidstat -w 1    # voluntary (blocked) vs involuntary (preempted) switches per process
perf stat -e context-switches,cache-misses ./program
```

**Key takeaways**

- A context switch saves the outgoing PCB's CPU state, switches address space, and restores the incoming one.
- It performs no useful work: it is overhead paid for the ability to share a CPU.
- Indirect cost from cache and TLB pollution usually dominates the direct register-save cost.
- Thread switches within a process skip the address-space change and preserve cache state, making them far cheaper.

> 🧪 Practice
>
> 1. Use `vmstat 1` while idle and while running several CPU-bound loops. Explain the change in the `cs` column.
> 2. Use `pidstat -w` to distinguish voluntary from involuntary switches for an I/O-bound and a CPU-bound program. Which is which, and why?
> 3. Interview-style: "A server handling 100,000 requests per second spends 30% of CPU in context switches. What would you change?" *Hint: consider thread pools, event loops, batching, and CPU affinity rather than faster switching.*

<a id="22-process-lifecycle"></a>
### 2.2 Process Lifecycle

Processes are created by other processes, run, and end — this section follows that arc, including the failure modes that arise when a parent neglects its responsibilities.

#### Process Creation

**Theory**

Processes do not appear spontaneously. Every process except the first is created by another process, which makes the set of all processes a **tree**. At the root is the process the kernel starts by hand at boot (PID 1: `init`, `systemd`, or `launchd`); everything else descends from it.

Creating a process requires answering four questions, and different operating systems answer them differently:

1. **What is the new process's address space?** Either a copy of the parent's, or a fresh one loaded from a program file.
2. **What resources does it get?** All of the parent's open files, some subset, or none.
3. **Do parent and child run concurrently?** Usually yes; some systems make the parent wait.
4. **What is the parent's continuing relationship?** It typically retains the ability to wait for the child and receives notification when it exits.

Two design philosophies dominate:

| | **UNIX: `fork` + `exec`** | **Windows: `CreateProcess`** |
|---|---|---|
| Model | Split: duplicate, then optionally replace image | Combined: create and load in one call |
| Parameters | Almost none — the child inherits everything | Large structure specifying every detail |
| Customisation | Arbitrary code runs in the child before `exec` | Only what the parameter block expresses |
| Cost | Duplication (mitigated by copy-on-write) | No duplication |
| Composability | Very high — pipes, redirection, privilege dropping | Lower; requires explicit flags and handle lists |

The UNIX split looks wasteful and is in fact its greatest strength: the interval between `fork` and `exec` is a window in which the child is an ordinary process that can be configured arbitrarily — redirect file descriptors, change directory, set resource limits, drop privileges — using the same system calls available anywhere else. No special "process creation options" API is needed because ordinary code does the job.

Modern kernels make the copy cheap with **copy-on-write**: parent and child initially share all physical pages marked read-only, and a page is duplicated only when one of them writes to it. A `fork` followed immediately by `exec` therefore copies almost nothing.

**Example**

```text
   The process tree

   systemd (PID 1)
     |-- sshd (900)
     |     |-- sshd: alice (4400)
     |           |-- bash (4401)
     |                 |-- vim (4412)
     |                 |-- make (4420)
     |                       |-- cc1 (4421)
     |                       |-- as  (4422)
     |-- cron (905)
     +-- nginx (910)
           |-- nginx worker (911)
           +-- nginx worker (912)

   fork() with copy-on-write

   before fork:            after fork (no copying yet):
   parent -> [page A rw]   parent -> [page A ro] <- child     shared, read-only
                           on first write by either:
                           parent -> [page A' rw]
                           child  -> [page A  rw]             now duplicated
```

```c
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
    printf("parent starts, pid=%d\n", getpid());

    pid_t pid = fork();          /* ONE call, TWO returns: the defining oddity */

    if (pid < 0) {
        perror("fork");          /* out of PIDs or memory */
        return 1;
    }
    if (pid == 0) {
        /* CHILD: fork returned 0 here. Separate address space (copy-on-write),
           same open files, same cwd, new PID. */
        printf("child:  pid=%d parent=%d\n", getpid(), getppid());
        _exit(0);
    }
    /* PARENT: fork returned the child's PID here. */
    printf("parent: created child %d\n", pid);
    wait(NULL);                  /* collect the child, avoiding a zombie */
    return 0;
}
```

```bash
pstree -p          # the live process tree, with PIDs
ps -eo pid,ppid,cmd --forest | head -30
```

**Key takeaways**

- Every process is created by another, forming a tree rooted at PID 1.
- UNIX splits creation (`fork`) from program loading (`exec`); Windows combines them in `CreateProcess`.
- The gap between `fork` and `exec` is where redirection, privilege dropping, and resource limits are applied.
- Copy-on-write makes `fork` cheap by sharing pages read-only until one side writes.

> 🧪 Practice
>
> 1. Draw the process tree produced by a shell running `ls | wc -l`. How many `fork` calls occur, and who is the parent of each process?
> 2. Write a program that forks twice unconditionally (no `exec`, no `exit` between them). How many processes exist at the end? Draw the tree and explain.
> 3. Interview-style: "Why does `fork()` return twice, and how does each process know which one it is?" *Hint: focus on the single differing value and why the kernel chose that convention rather than a flag.*

#### fork and exec

**Theory**

These two calls deserve close attention because their interaction confuses nearly everyone at first, and because almost every process on a UNIX system is created by their combination.

**`fork()`** duplicates the calling process. The child receives a copy of the address space (copy-on-write), copies of the file descriptor table, the same current directory, the same signal handler dispositions, and the same register values — including the program counter, which is why it resumes at exactly the same instruction. What differs: the PID, the parent PID, the return value of `fork` itself, pending signals (cleared), and resource usage counters (reset).

**`execve()`** does not create anything. It *replaces* the calling process's program image: the text, data, heap, and stack are discarded and rebuilt from the named executable, and execution begins at the new program's entry point. Everything that identifies the process survives: PID, PPID, open file descriptors, current directory, and (importantly) file descriptor redirections set up beforehand.

The consequences of that survival rule are the whole point:

- Open file descriptors persist across `exec` unless marked close-on-exec (`FD_CLOEXEC`). This is how a shell redirects a child's output *before* deciding what program to run.
- `execve` **does not return** on success — there is no code left to return to. Any statement after it executes only if the call failed.
- Because signal *handlers* are function pointers into a program image that no longer exists, they reset to default across `exec`, while signal *masks* are inherited.

Three inheritance rules are worth memorising:

| Property | Across `fork` | Across `exec` |
|---|---|---|
| PID | New | Unchanged |
| Address space | Copied (COW) | Replaced entirely |
| Open file descriptors | Copied (shared offsets) | Preserved unless `FD_CLOEXEC` |
| Signal handlers | Inherited | Reset to default |
| Current directory, umask | Inherited | Preserved |

**Example**

```text
   fork + exec: what changes, what survives

   parent (pid 100)
     text: shell   fds: 0=tty 1=tty 2=tty
        |
        | fork()
        v
   child  (pid 101)                        <- new PID, everything else copied
     text: shell   fds: 0=tty 1=tty 2=tty
        |
        | open("out.txt") -> fd 3
        | dup2(3, 1)                       <- configure BEFORE exec
        | close(3)
        v
   child  (pid 101)
     text: shell   fds: 0=tty 1=out.txt 2=tty
        |
        | execve("/bin/ls", ...)
        v
   child  (pid 101)                        <- SAME pid, NEW program
     text: ls      fds: 0=tty 1=out.txt 2=tty   <- redirection survived
```

```c
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>

int main(void) {
    pid_t pid = fork();

    if (pid == 0) {
        /* --- the customisation window: ordinary code, ordinary syscalls --- */
        int fd = open("out.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
        dup2(fd, STDOUT_FILENO);   /* make fd 1 refer to out.txt */
        close(fd);                 /* the duplicate is no longer needed */
        chdir("/tmp");             /* run the child somewhere else */
        /* ------------------------------------------------------------------ */

        execlp("ls", "ls", "-l", (char *)NULL);
        /* Reached ONLY if exec failed: the image was never replaced. */
        perror("execlp");
        _exit(127);
    }

    waitpid(pid, NULL, 0);
    printf("child finished; its output is in /tmp/out.txt\n");
    return 0;
}
```

```python
# Higher-level languages wrap the same pair. subprocess does fork+exec for you,
# and exposes the customisation window as keyword arguments.
import subprocess
with open("out.txt", "w") as f:
    subprocess.run(["ls", "-l"], stdout=f, cwd="/tmp")  # dup2 + chdir, hidden
```

**Key takeaways**

- `fork` duplicates a process; `exec` replaces a process's program image without creating anything.
- After a successful `exec` there is no return — following code runs only on failure.
- File descriptors survive both calls (unless `FD_CLOEXEC`), which is what makes redirection possible.
- The window between the two is where all child customisation happens, using ordinary system calls.

> 🧪 Practice
>
> 1. Write a program that `exec`s `/bin/echo` and prints a message afterwards. Explain why the message never appears.
> 2. Modify the redirection example to send stderr to the same file as stdout. Which order of `dup2` calls works, and why does the other fail?
> 3. Interview-style: "What is `FD_CLOEXEC` for, and what leaks without it?" *Hint: imagine a server with a private socket or key file that spawns an untrusted helper.*

#### Process Termination

**Theory**

A process ends in one of two ways: it decides to, or something decides for it.

**Voluntary termination** happens when the process calls `exit()` (or returns from `main`, which calls `exit` implicitly). The process supplies an **exit status** — a small integer, conventionally 0 for success and non-zero for failure — which is its final message to its parent.

**Involuntary termination** happens when the process receives a fatal signal: `SIGSEGV` from an invalid memory access, `SIGKILL` from an administrator, `SIGTERM` from a shutdown sequence, or `SIGABRT` from a failed assertion. The kernel records *which signal* killed it, which the parent can distinguish from a normal exit.

On termination, the kernel performs a cleanup that is worth knowing precisely because it is more thorough than people expect:

- All open file descriptors are closed (which may flush and release locks, and signal EOF to pipe readers).
- The address space is torn down and its physical pages freed.
- Memory-mapped regions are unmapped; shared memory attachments are detached.
- Children are **re-parented** to `init`/`systemd`, never killed.
- Most of the PCB is freed — but not all: a minimal record survives so the exit status can be delivered. This is the zombie state.

Two points that surprise people:

- **Killing a parent does not kill its children.** They are orphaned and adopted, not terminated. Killing a whole job requires signalling the process *group* (`kill -TERM -PGID`) or using a container/cgroup.
- **`SIGKILL` cannot be caught, blocked, or ignored** — it is handled entirely by the kernel — which is exactly why it works when `SIGTERM` does not, and why a process in uninterruptible sleep can still resist it until the I/O completes.

The `exit` family also distinguishes `exit()` (runs `atexit` handlers, flushes stdio buffers) from `_exit()` (immediate, no cleanup). After a `fork`, a child that will not `exec` should generally use `_exit()` to avoid flushing the parent's buffered data a second time.

**Example**

```text
   Termination paths and what the parent learns

   exit(3)          -----> WIFEXITED(status)   true,  WEXITSTATUS = 3
   return 3 from main ---> identical to exit(3)
   SIGSEGV          -----> WIFSIGNALED(status) true,  WTERMSIG = 11
   kill -9          -----> WIFSIGNALED(status) true,  WTERMSIG = 9
   SIGSTOP          -----> WIFSTOPPED(status)  true (not terminated)

   Cleanup at exit

   +-- close all file descriptors  (pipe readers see EOF; locks released)
   +-- unmap address space, free physical pages
   +-- detach shared memory, release semaphores held
   +-- re-parent any children to PID 1
   +-- keep: pid + exit status  ---> ZOMBIE until the parent waits
```

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
    pid_t pid = fork();
    if (pid == 0) {
        exit(42);                     /* voluntary, with a status */
        /* try replacing with: abort();  -> terminated by SIGABRT (6) */
    }

    int status;
    waitpid(pid, &status, 0);

    if (WIFEXITED(status))            /* normal exit? */
        printf("exited normally, status %d\n", WEXITSTATUS(status));
    else if (WIFSIGNALED(status))     /* killed by a signal? */
        printf("killed by signal %d\n", WTERMSIG(status));
    return 0;
}
```

```bash
./demo; echo "shell sees: $?"    # the shell reads the same exit status
# a signal death is reported by the shell as 128 + signal number:
sh -c 'kill -9 $$'; echo $?      # prints 137  (128 + 9)
```

**Key takeaways**

- Processes end voluntarily via `exit` with a status, or involuntarily via a fatal signal.
- The kernel closes descriptors, frees memory, and re-parents children — it does not kill them.
- A minimal record survives until the parent collects the status; that is the zombie state.
- `SIGKILL` cannot be caught or ignored, which is why it succeeds where `SIGTERM` is swallowed.

> 🧪 Practice
>
> 1. Write a program returning various statuses and confirm each with `echo $?`. What happens with `exit(256)`, and why?
> 2. Start a background process, kill its parent, and observe the child's new PPID with `ps`. Explain what happened.
> 3. Interview-style: "Why should a `SIGTERM` handler exist in a server, when `SIGKILL` will work anyway?" *Hint: think about in-flight requests, buffered data, and lock files.*

#### Orphan and Zombie Processes

**Theory**

These two are frequently confused and are in fact opposites: an orphan has lost its parent, a zombie has lost nothing but is waiting for its parent to act.

**Zombie (defunct).** When a process terminates, the kernel cannot discard it completely, because the exit status is data the parent may still want. So it frees the address space, the file descriptors, and nearly everything else, but retains the PCB entry holding the PID and exit status. The process is dead — it holds no memory and consumes no CPU — but its slot in the process table remains. The parent clears it by calling `wait`/`waitpid`, an act called **reaping**.

A zombie is harmless individually and dangerous in bulk. A long-running server that forks children and never waits accumulates entries until the process table or PID space is exhausted, at which point *no process on the system can be created*. This is a classic production outage.

**Orphan.** When a parent terminates before its child, the child is not killed — it is **re-parented to PID 1**. `init`/`systemd` exists partly to be a reliable adoptive parent: it calls `wait` in a loop forever, so any orphan that later exits is reaped immediately and never becomes a lasting zombie.

This yields the neat rule: **orphans cannot become permanent zombies; only processes with a living, negligent parent can.**

Three ways to avoid zombies:

1. Call `wait`/`waitpid` — blocking, or in a `SIGCHLD` handler, or with `WNOHANG` in an event loop.
2. Set `SIGCHLD` to `SIG_IGN` (or use `SA_NOCLDWAIT`), which tells the kernel to reap automatically. You lose the exit status.
3. **Double-fork**: fork a child that immediately forks a grandchild and exits. The grandchild is orphaned instantly and adopted by init, which reaps it. This is the traditional daemonisation trick.

Analogy: a zombie is a completed hospital discharge form sitting in a tray waiting for a signature — the patient has gone home, but the paperwork occupies a slot in the filing cabinet. An orphan is a patient whose assigned doctor left; the hospital reassigns them automatically.

**Example**

```text
   ZOMBIE                                ORPHAN

   parent (alive, not waiting)           parent EXITS
      |                                     |
   child EXITS                           child still RUNNING
      |                                     |
   PCB retained: pid + status            re-parented to PID 1
   state = Z (defunct)                   state = R/S (normal)
   consumes: a process table slot        consumes: nothing unusual
   fixed by: parent calls wait()         handled by: init reaps it later

   ps output:
     PID  PPID STAT CMD
    4413  4412 Z    [demo] <defunct>     <- zombie: parent 4412 is negligent
    4499     1 S    ./worker             <- orphan: PPID became 1
```

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

/* Reap children asynchronously: the correct pattern for a forking server. */
void reap(int sig) {
    (void)sig;
    /* Loop: several children may have exited while we were not looking,
       and signals do not queue. WNOHANG makes waitpid non-blocking. */
    while (waitpid(-1, NULL, WNOHANG) > 0)
        ;
}

int main(void) {
    struct sigaction sa = { .sa_handler = reap, .sa_flags = SA_RESTART };
    sigemptyset(&sa.sa_mask);
    sigaction(SIGCHLD, &sa, NULL);   /* without this, children pile up as Z */

    for (int i = 0; i < 5; i++) {
        if (fork() == 0) {
            sleep(1);
            _exit(i);                /* _exit: skip stdio flush in the child */
        }
    }
    sleep(3);
    printf("no zombies: check with ps during the run\n");
    return 0;
}
```

```bash
ps -eo pid,ppid,stat,cmd | awk '$3 ~ /^Z/'   # list zombies, if any
cat /proc/sys/kernel/pid_max                 # the table a zombie leak exhausts
```

**Key takeaways**

- A zombie is a terminated process whose exit status has not yet been collected; it holds a process table slot only.
- An orphan is a live process whose parent died; it is re-parented to PID 1 and is not a problem.
- Zombies accumulate only under a living, negligent parent, and can exhaust the PID space.
- Avoid them by calling `wait`/`waitpid` (often via a `SIGCHLD` handler), ignoring `SIGCHLD`, or double-forking.

> 🧪 Practice
>
> 1. Write a program that forks a child which exits immediately while the parent sleeps 30 seconds without waiting. Find the zombie in `ps` and explain each column.
> 2. Reverse it: make the parent exit first and the child sleep. Show the child's PPID becoming 1.
> 3. Interview-style: "A production server slowly stops being able to fork. `ps` shows thousands of `<defunct>` entries. Diagnose and fix." *Hint: which resource is exhausted, and which single missing call causes it?*

#### Process Hierarchies

**Theory**

The parent-child relationship is not just bookkeeping — the kernel builds several grouping mechanisms on top of it, and they are what make job control, terminal handling, and modern container isolation work.

The hierarchy has four levels, each nesting inside the last:

| Level | Identifier | Purpose |
|---|---|---|
| **Process** | PID | The unit of execution and protection |
| **Process group** | PGID | A set of related processes signalled together — one shell "job" |
| **Session** | SID | A set of process groups attached to one controlling terminal — one login |
| **Container/cgroup** | cgroup path, namespaces | A resource- and visibility-isolated subtree |

**Process groups** exist so that signals can address a whole pipeline. When you type Ctrl-C, the terminal driver sends `SIGINT` to the *foreground process group*, not to one process — which is why `ps aux | grep x | sort` all die together. A shell places every pipeline in its own group precisely to make this work.

**Sessions** exist to associate process groups with a controlling terminal, and to define what happens when that terminal disappears. When an SSH connection drops, the kernel sends `SIGHUP` to the session leader, which is why long jobs die on logout — and why `nohup`, `setsid`, `screen`, and `tmux` exist: they detach the process from the session so the hangup never reaches it.

**Daemonisation** is the classic recipe built from all of this: fork (so the parent can exit and the shell moves on), `setsid()` (become a session leader with no controlling terminal), fork again (so the daemon can never *acquire* a terminal, since only a session leader can), then `chdir("/")`, reset `umask`, and redirect the standard descriptors to `/dev/null`.

Modern systems add **namespaces and cgroups** as a stronger hierarchy: a PID namespace gives a subtree its own PID numbering (its `init` is PID 1 inside, though it has a different PID outside), and a cgroup imposes collective CPU and memory limits on a subtree. Containers are exactly this — a process subtree with restricted visibility and bounded resources — and `systemd` uses the same mechanism to reliably kill an entire service, which signalling by PGID alone cannot guarantee.

**Example**

```text
   Session, groups, and processes for one login

   session 4400 (controlling terminal /dev/pts/2)
     |
     +-- process group 4401  (the shell itself, session leader's group)
     |     +-- bash (4401)
     |
     +-- process group 4450  FOREGROUND  <- receives Ctrl-C (SIGINT)
     |     +-- ps   (4450)   |
     |     +-- grep (4451)   | one pipeline = one group = one "job"
     |     +-- sort (4452)   |
     |
     +-- process group 4460  background (job %2)
           +-- make (4460)

   Terminal closes -> SIGHUP to the session -> jobs die
   unless detached with nohup / setsid / tmux.

   Container view (PID namespace)

   host:      systemd(1) --- containerd(800) --- app(9021)
   inside:                                       app(1)   <- same process,
                                                             different PID
```

```c
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>

/* Classic daemonisation: detach from terminal and session entirely. */
void daemonise(void) {
    if (fork() > 0) exit(0);      /* 1. parent exits: shell regains its prompt
                                        and the child is not a group leader   */
    setsid();                     /* 2. new session + group, no controlling
                                        terminal; SIGHUP can no longer arrive */
    if (fork() > 0) exit(0);      /* 3. second fork: we are no longer a session
                                        leader, so we can NEVER acquire a tty */
    chdir("/");                   /* 4. do not pin a filesystem we do not own */
    umask(0);                     /* 5. predictable permissions               */

    int null = open("/dev/null", O_RDWR);
    dup2(null, 0); dup2(null, 1); dup2(null, 2);  /* 6. detach std streams    */
    if (null > 2) close(null);
}
```

```bash
ps -eo pid,ppid,pgid,sid,tty,cmd | head    # the four identifiers side by side
kill -TERM -4450                           # signal the whole GROUP (note the -)
systemd-cgls                               # the cgroup hierarchy systemd manages
```

**Key takeaways**

- Processes nest into process groups (jobs), sessions (logins), and cgroups/namespaces (containers).
- Terminal signals such as Ctrl-C go to the foreground process *group*, which is why pipelines die together.
- Losing a terminal sends `SIGHUP` to the session; `nohup`, `setsid`, and `tmux` exist to escape it.
- Containers are a process subtree with its own PID namespace and resource limits, giving reliable group control.

> 🧪 Practice
>
> 1. Run `sleep 100 | cat &` and inspect PID, PGID, and SID with `ps -o pid,pgid,sid,cmd`. Explain the grouping.
> 2. Demonstrate the difference between `kill 1234` and `kill -- -1234` on a pipeline. Which terminates everything?
> 3. Interview-style: "Why does the daemonisation recipe fork *twice*?" *Hint: only a session leader can acquire a controlling terminal — so make sure you are not one.*

<a id="23-interprocess-communication"></a>
### 2.3 Interprocess Communication

Processes are deliberately isolated, so cooperating processes need explicit, kernel-mediated channels; this section covers the two fundamental models and the four mechanisms built on them.

#### Shared Memory Model

**Theory**

Isolation is the point of a process — and it is also an obstacle whenever two processes must cooperate. **Shared memory** is the most direct way around it: the kernel maps the same physical pages into two or more address spaces, and from then on the processes communicate simply by reading and writing ordinary variables.

The performance argument is decisive for bulk data. Once the mapping is established, communication involves **no system calls at all** — a write by one process is immediately visible to the other, at memory speed. Every other IPC mechanism copies data through the kernel, typically twice (user → kernel → user). For a video frame or a large data set, that difference is enormous.

The cost is that the kernel, having set up the mapping, steps out of the way entirely — and with it goes all synchronisation. Shared memory provides **no** notification that data has arrived, **no** mutual exclusion, and **no** ordering guarantees. Two processes incrementing a shared counter will lose updates exactly as two threads would. Shared memory is therefore never used alone: it is paired with semaphores, mutexes in shared memory, or atomic operations (Chapter 5).

There are two common ways to obtain it on UNIX: POSIX shared memory (`shm_open` + `mmap`, file-descriptor based, the modern choice) and System V shared memory (`shmget` + `shmat`, key-based, older). `mmap` with `MAP_SHARED` on a regular file gives the same effect with persistence.

Analogy: shared memory is a whiteboard in a shared room. Anyone can read or write instantly, with no messenger involved — which is why it is fast, and why two people writing at once produce nonsense unless they agree on turn-taking.

**Example**

```text
   Two processes, one physical region

   Process A virtual space        physical memory        Process B virtual space
   +--------------------+                                +--------------------+
   | ...                |         +-------------+        | ...                |
   | 0x7f00_0000  ------+-------> |  shared     | <------+---- 0x7f88_0000    |
   | ...                |         |  pages      |        | ...                |
   +--------------------+         +-------------+        +--------------------+

   Different virtual addresses, SAME physical frames.
   A write by A is visible to B with no system call and no copy.

   Cost comparison for 1 MB of data:
     pipe / socket : user -> kernel buffer -> user   (2 copies + syscalls)
     shared memory : write it once, in place         (0 copies, 0 syscalls)
```

```c
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <semaphore.h>

struct shared {
    sem_t  lock;          /* the synchronisation shared memory does NOT provide */
    int    counter;
    char   message[256];
};

int main(void) {
    int fd = shm_open("/demo", O_CREAT | O_RDWR, 0600);  /* a name, not a file */
    ftruncate(fd, sizeof(struct shared));                /* size the region    */

    struct shared *s = mmap(NULL, sizeof *s, PROT_READ | PROT_WRITE,
                            MAP_SHARED,      /* MAP_SHARED: visible to others;
                                                MAP_PRIVATE would be copy-on-write
                                                and therefore useless here     */
                            fd, 0);
    close(fd);                                /* the mapping outlives the fd   */

    sem_init(&s->lock, 1 /* pshared: usable across processes */, 1);

    if (fork() == 0) {
        sem_wait(&s->lock);                   /* without this, updates are lost */
        s->counter++;
        snprintf(s->message, sizeof s->message, "child wrote %d", s->counter);
        sem_post(&s->lock);
        _exit(0);
    }
    wait(NULL);

    sem_wait(&s->lock);
    printf("parent reads: %s (counter=%d)\n", s->message, s->counter);
    sem_post(&s->lock);

    munmap(s, sizeof *s);
    shm_unlink("/demo");                      /* the name persists until removed */
    return 0;
}
```

```bash
ls /dev/shm/          # POSIX shared memory objects appear here
ipcs -m               # System V shared memory segments, with attach counts
```

**Key takeaways**

- Shared memory maps the same physical pages into several address spaces, giving zero-copy communication.
- After setup it requires no system calls, making it the fastest IPC for bulk data.
- It provides no synchronisation or notification whatsoever; it must be paired with semaphores or atomics.
- Use `MAP_SHARED` (not `MAP_PRIVATE`) and remember that the name persists until explicitly unlinked.

> 🧪 Practice
>
> 1. Remove the semaphore calls from the example, have two children increment the counter one million times each, and observe lost updates. Explain the mechanism.
> 2. Benchmark transferring 100 MB between processes via a pipe versus shared memory. Explain the ratio in terms of copies and system calls.
> 3. Interview-style: "Two processes map the same region and one stores a pointer in it for the other to follow. What goes wrong?" *Hint: compare the two virtual addresses in the diagram above.*

#### Message Passing Model

**Theory**

The alternative to sharing memory is to exchange **messages**: discrete units of data copied from one process to another by the kernel, through `send` and `receive` operations. The processes never share an address space; the kernel is in the middle of every exchange.

This trades performance for safety and generality:

- **Synchronisation comes free.** A message arriving *is* the notification. There is no race over "is the data ready" because the message is not deliverable until it is complete.
- **It works across machines.** Since the model already assumes copying through an intermediary, replacing that intermediary with a network changes the cost but not the semantics — which is why sockets and RPC are message passing.
- **It is safer.** No shared writable state means no data races over the transferred data; ownership transfers with the message.
- **It is slower for bulk data**, because every byte is copied at least twice and every exchange costs system calls.

Three design axes define any message-passing system:

| Axis | Options | Implication |
|---|---|---|
| **Naming** | Direct (name the process) vs indirect (name a mailbox/port/queue) | Indirect allows many-to-many and decoupled lifetimes |
| **Synchronisation** | Blocking (synchronous) vs non-blocking (asynchronous) | Blocking send is a rendezvous; non-blocking needs buffering |
| **Buffering** | Zero capacity, bounded, or unbounded | Zero forces rendezvous; bounded means send can block; unbounded can exhaust memory |

The blocking choice deserves care. A **blocking send** with zero buffering is a rendezvous: sender and receiver meet, which gives strong ordering but couples their speeds. A **non-blocking send** into a bounded queue is what most real systems use, and it forces you to decide what happens when the queue is full — block, drop, or fail — a decision that reappears in every message broker and network stack.

Analogy: shared memory is a whiteboard; message passing is the postal system. Slower, involves an intermediary, and requires copying — but the recipient knows exactly when something arrived, and it works just as well to the next building as to the next desk.

**Example**

```text
   Message passing

   Process A                 kernel                    Process B
   ---------                 ------                    ---------
   send(B, msg) ---------> [ copy in ]
                           [ queue:  ]
                           [ [m1][m2]] ------------> receive(&msg)
                                                     [ copy out ]

   Two copies, two system calls -- and no shared state at all.

   Naming options

   DIRECT                              INDIRECT (mailbox / port / queue)
   send(P2, m)                         send(mbox_A, m)
   receive(P1, &m)                     receive(mbox_A, &m)
   both must know each other           senders and receivers decoupled;
   one-to-one                          many-to-many possible

   Buffering and blocking

   capacity 0   : send blocks until receive happens      (rendezvous)
   capacity N   : send blocks only when full             (usual case)
   unbounded    : send never blocks -- until memory runs out
```

```python
# Message passing between processes, with an explicit bounded queue.
from multiprocessing import Process, Queue

def producer(q):
    for i in range(5):
        q.put({"seq": i, "payload": f"item {i}"})   # serialised + copied
    q.put(None)                                     # sentinel: end of stream

def consumer(q):
    while True:
        msg = q.get()          # BLOCKS until a message exists -- the arrival
        if msg is None:        # of the message IS the synchronisation
            break
        print("received", msg["seq"], msg["payload"])

q = Queue(maxsize=10)          # bounded: put() blocks when full -> backpressure
p1 = Process(target=producer, args=(q,))
p2 = Process(target=consumer, args=(q,))
p1.start(); p2.start(); p1.join(); p2.join()
```

**Key takeaways**

- Message passing copies discrete messages through the kernel; processes share no memory.
- Delivery is itself the synchronisation, eliminating the races inherent in shared memory.
- The model extends unchanged across machines, which is why sockets and RPC use it.
- Naming (direct vs mailbox), blocking behaviour, and buffer capacity are the three defining design choices.

> 🧪 Practice
>
> 1. Set `maxsize=1` in the example and add a slow consumer. Describe the producer's behaviour and name the effect.
> 2. Compare shared memory and message passing across five criteria: speed, synchronisation, safety, network transparency, and complexity. Present it as a table.
> 3. Interview-style: "When a bounded queue fills, should send block, drop, or fail?" *Hint: argue from the consequences for a logging system, a video stream, and a payments pipeline separately.*

#### Pipes and Named Pipes

**Theory**

A **pipe** is the simplest concrete message-passing channel in UNIX: a kernel-managed byte buffer with a write end and a read end. It is a one-directional stream with no message boundaries — write 100 bytes then 50, and the reader may receive 150 in one read, or 3 bytes at a time.

An **anonymous pipe** (`pipe()`) has no name in the file system. It is created by one process and passed to another the only way it can be: by inheritance across `fork`. That restriction is why anonymous pipes connect *related* processes — parent to child, or siblings created by the same shell.

A **named pipe** or **FIFO** (`mkfifo`) has a path in the file system, so unrelated processes can open it by name. Despite appearing as a file, it stores nothing; the path is a rendezvous point, and data still lives only in the kernel buffer.

Two behaviours make pipes work as well as they do:

- **Flow control is automatic.** The buffer is finite (64 KB by default on Linux). A writer that outruns the reader blocks when the buffer is full; a reader that outruns the writer blocks when it is empty. Producers and consumers are throttled to each other's speed with no code.
- **EOF is meaningful.** When all write ends are closed, the reader's `read` returns 0, signalling end of stream. Conversely, writing to a pipe with no readers raises `SIGPIPE`, which by default kills the writer — this is why `head` can terminate a long pipeline early.

The most common bug is failing to close unused ends. If a parent keeps the write end open after handing it to a child, the reader never sees EOF and hangs forever — because *some* process still holds a write end.

Analogy: a pipe is a length of hose between two people. Water flows one way; if the receiver stops drinking, the hose fills and the pourer must wait; if the pourer walks away, the receiver knows there is no more water coming.

**Example**

```text
   Anonymous pipe created before fork

   parent: pipe(fd) -> fd[0] read end, fd[1] write end
       |
       | fork()  -- the child inherits BOTH descriptors
       v
   parent               kernel buffer (64 KB)               child
   close(fd[0])  --->  [ ...bytes... ]  --->  close(fd[1])
   write(fd[1])                               read(fd[0])

   Each side MUST close the end it does not use, or:
     - reader never sees EOF (a write end is still open somewhere)
     - the pipeline hangs

   How the shell builds `ls | wc -l`

   pipe(p)
   fork -> child1: dup2(p[1], 1); close both; exec ls    (stdout -> pipe)
   fork -> child2: dup2(p[0], 0); close both; exec wc    (stdin  <- pipe)
   parent: close(p[0]); close(p[1]); wait for both       (critical!)
```

```c
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(void) {
    int fd[2];
    pipe(fd);                        /* fd[0] = read end, fd[1] = write end */

    if (fork() == 0) {               /* ---- child: the reader ---- */
        close(fd[1]);                /* MUST close the write end, or no EOF */
        char buf[128];
        ssize_t n;
        while ((n = read(fd[0], buf, sizeof buf)) > 0)   /* 0 = EOF */
            fwrite(buf, 1, n, stdout);
        close(fd[0]);
        _exit(0);
    }

    close(fd[0]);                    /* ---- parent: the writer ---- */
    const char *msg = "streamed through the kernel\n";
    write(fd[1], msg, strlen(msg));
    close(fd[1]);                    /* closing the last write end sends EOF */
    wait(NULL);
    return 0;
}
```

```bash
mkfifo /tmp/chan                  # a named pipe: a rendezvous point, not storage
cat /tmp/chan &                   # reader blocks until a writer opens it
echo "hello unrelated process" > /tmp/chan
ls -l /tmp/chan                   # note the leading 'p' in the mode column
```

**Key takeaways**

- A pipe is a unidirectional kernel byte buffer with no message boundaries.
- Anonymous pipes are inherited across `fork`, so they connect related processes; FIFOs have a path and connect any processes.
- Blocking on a full or empty buffer provides automatic flow control between producer and consumer.
- Closing unused ends is mandatory: EOF depends on *all* write ends being closed, and writing with no reader raises `SIGPIPE`.

> 🧪 Practice
>
> 1. Remove `close(fd[1])` from the parent in the example. Explain precisely why the program hangs.
> 2. Implement `ls | wc -l` in C using `pipe`, `fork`, `dup2`, and `execlp`, closing every unused descriptor.
> 3. Interview-style: "Why does `yes | head -1` terminate instead of running forever?" *Hint: what does `yes` receive when it writes to a pipe whose reader has gone?*

#### Signals

**Theory**

A **signal** is not a data channel — it is an asynchronous *notification*, a software interrupt delivered to a process. Signals carry no payload beyond their number (except the rarely used `sigqueue` variant); the meaning is entirely in which signal was sent.

Signals arise from three sources: the kernel reporting a fault (`SIGSEGV`, `SIGFPE`), a user or program requesting something (`SIGINT` from Ctrl-C, `SIGTERM` from `kill`), or an event the process asked to hear about (`SIGCHLD` on child exit, `SIGALRM` on timer expiry).

A process may respond in three ways: run a **handler**, **ignore** the signal, or accept the **default action** (usually terminate, sometimes stop or ignore). `SIGKILL` and `SIGSTOP` are exceptions to all of this — they cannot be caught, blocked, or ignored, precisely so an administrator always retains control.

The subtlety that dominates practice is that a handler runs **asynchronously, interrupting the process at an arbitrary instruction**. That leads to strict rules:

- **Only async-signal-safe functions may be called from a handler.** `printf` and `malloc` are not: if the signal arrives while the process is already inside `malloc`, calling it again corrupts the heap. `write` is safe.
- **Shared state must be `volatile sig_atomic_t`**, since the compiler cannot see that a handler modifies it.
- **Signals do not queue.** Standard signals are a single pending bit — ten `SIGCHLD`s while blocked deliver one. This is why `SIGCHLD` handlers must loop with `waitpid(..., WNOHANG)`.
- **Slow system calls may be interrupted**, returning `EINTR`, unless restarted with `SA_RESTART`.

The modern preference is to keep handlers trivial: set a flag, or write a byte to a self-pipe / `signalfd` so the main event loop handles the event synchronously where normal code is safe.

Analogy: a signal is a fire alarm, not a phone call. It tells you *that* something happened, not what or why, it can interrupt you mid-sentence, and two alarms ringing at once sound like one.

**Example**

```text
   Common signals

   Signal    Default action        Typical source
   -------   -------------------   -----------------------------------------
   SIGINT    terminate             Ctrl-C, to the foreground process group
   SIGTERM   terminate             kill (polite request; catchable)
   SIGKILL   terminate (forced)    kill -9  -- CANNOT be caught or ignored
   SIGSEGV   terminate + core      invalid memory access
   SIGCHLD   ignore                a child exited or stopped
   SIGHUP    terminate             controlling terminal closed
   SIGSTOP   stop                  Ctrl-Z / job control -- also uncatchable
   SIGPIPE   terminate             wrote to a pipe with no reader

   Asynchronous delivery

   main flow:  ... a = b + c;  [SIGNAL ARRIVES] ...
                                     |
                                     v  handler runs on the same thread
                               handler() { flag = 1; }   <- keep it trivial
                                     |
               ... resumes here <-----+
```

```c
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <string.h>

/* volatile sig_atomic_t: the compiler must not cache it, and reads/writes
   must be indivisible -- the handler can fire between any two instructions. */
static volatile sig_atomic_t shutdown_requested = 0;

void on_term(int sig) {
    shutdown_requested = 1;                 /* safe: just set a flag */
    const char m[] = "signal received\n";
    write(STDERR_FILENO, m, sizeof m - 1);  /* write() is async-signal-safe;
                                               printf() is NOT */
}

int main(void) {
    struct sigaction sa;
    memset(&sa, 0, sizeof sa);
    sa.sa_handler = on_term;
    sa.sa_flags   = SA_RESTART;             /* restart interrupted syscalls
                                               instead of failing with EINTR */
    sigemptyset(&sa.sa_mask);
    sigaction(SIGTERM, &sa, NULL);          /* prefer sigaction over signal() */
    sigaction(SIGINT,  &sa, NULL);

    printf("pid %d: try  kill -TERM %d  or Ctrl-C\n", getpid(), getpid());
    while (!shutdown_requested)             /* handle it HERE, synchronously,
                                               where normal code is safe      */
        pause();                            /* sleep until any signal arrives */

    printf("clean shutdown: flushing, closing, releasing locks\n");
    return 0;
}
```

```bash
kill -l                 # every signal name and number
kill -TERM 4412         # polite: the process may clean up
kill -KILL 4412         # forced: the kernel does it, no handler runs
trap 'echo caught' INT  # shells catch signals too
```

**Key takeaways**

- Signals are asynchronous notifications carrying only an identity, not data.
- A process can catch, ignore, or take the default action — except for `SIGKILL` and `SIGSTOP`.
- Handlers interrupt arbitrary code, so only async-signal-safe functions and `volatile sig_atomic_t` state are permissible.
- Standard signals do not queue; handlers should set a flag or use a self-pipe and let the main loop do the work.

> 🧪 Practice
>
> 1. Write a program that catches `SIGINT`, prints a message on the third one, and exits. Explain why a counter must be `volatile sig_atomic_t`.
> 2. Deliberately call `printf` inside a handler and send signals rapidly during heavy `printf` use in the main loop. Describe what can go wrong and why.
> 3. Interview-style: "Why must a `SIGCHLD` handler call `waitpid` in a loop?" *Hint: signals of the same type do not queue while one is pending.*

#### Sockets

**Theory**

Sockets generalise IPC to the case where the two processes may be on different machines. A **socket** is an endpoint for communication, identified locally by a file descriptor and (for network sockets) globally by an IP address and port number.

The abstraction's great virtue is that the *same* API serves both cases. A **UNIX domain socket** (`AF_UNIX`) connects processes on one machine through a file-system path, bypassing the network stack entirely and running roughly as fast as a pipe — while adding bidirectionality, message boundaries if desired, and the ability to pass file descriptors and verify peer credentials. An **internet socket** (`AF_INET`) uses the same calls to reach another machine.

The second choice is the transport type:

| | **Stream (`SOCK_STREAM`, TCP)** | **Datagram (`SOCK_DGRAM`, UDP)** |
|---|---|---|
| Connection | Established before use | Connectionless |
| Reliability | Ordered, retransmitted, no duplicates | Best effort: may drop, reorder, duplicate |
| Boundaries | None — a byte stream | Preserved — one send is one receive |
| Cost | Handshake, state, acknowledgements | Minimal |
| Use for | HTTP, SSH, databases | DNS, video, telemetry, games |

The server-side sequence is worth memorising because it is identical everywhere: `socket()` to create the endpoint, `bind()` to claim an address, `listen()` to mark it passive with a backlog queue, and `accept()` to remove one completed connection from that queue — returning a *new* descriptor for that client while the original keeps listening. Clients need only `socket()` and `connect()`.

Two practical points: because streams have no message boundaries, application protocols must supply their own framing (length prefixes, delimiters, or fixed sizes) — assuming one `send` equals one `recv` is the most common networking bug. And `SO_REUSEADDR` exists because a closed listening address stays in `TIME_WAIT`, which otherwise prevents an immediate restart.

**Example**

```text
   Socket lifecycle

   SERVER                                CLIENT
   socket()   create endpoint            socket()
   bind()     claim address:port
   listen()   mark passive, backlog N
   accept()   <=== blocks ==========     connect()   (TCP handshake)
     returns a NEW fd for this client
   read()/write() on the new fd  <---->  read()/write()
   close(client_fd)                      close()
   (listening fd stays open for more)

   Address families, one API

   AF_UNIX  : /tmp/app.sock     same machine, no network stack, fastest,
                                can pass file descriptors and peer credentials
   AF_INET  : 93.184.216.34:80  any machine, routed over IP
```

```python
import socket

# --- Server: the four-call sequence ---
srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)     # TCP endpoint
srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)   # allow fast restart
srv.bind(("127.0.0.1", 9000))                               # claim the address
srv.listen(16)                                              # backlog of 16

conn, addr = srv.accept()      # blocks; returns a NEW socket for this client
with conn:
    # A stream has NO message boundaries: recv may return a partial message.
    # Real protocols frame explicitly -- here, a 4-byte length prefix.
    header = conn.recv(4)
    length = int.from_bytes(header, "big")
    body = b""
    while len(body) < length:                 # loop until the full message
        chunk = conn.recv(length - len(body)) # arrives; one recv is NOT enough
        if not chunk:
            raise ConnectionError("peer closed early")
        body += chunk
    conn.sendall(b"ok")
```

```python
# --- Same API, local-only transport: a UNIX domain socket ---
import socket, os
path = "/tmp/app.sock"
if os.path.exists(path):
    os.unlink(path)                                   # stale socket files persist
s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) # only the family changed
s.bind(path)
s.listen(1)
```

**Key takeaways**

- A socket is a communication endpoint; the same API serves local (`AF_UNIX`) and networked (`AF_INET`) processes.
- Stream sockets are reliable, ordered, and boundary-free; datagram sockets are best-effort with preserved boundaries.
- The server sequence is always `socket`, `bind`, `listen`, `accept`, and `accept` returns a new per-client descriptor.
- Streams require application-level framing; assuming one `send` maps to one `recv` is a persistent source of bugs.

> 🧪 Practice
>
> 1. Write an echo server and client over TCP, then convert both to `AF_UNIX` by changing only the family and address. Benchmark both.
> 2. Send two 10-byte messages back to back over TCP and show that the receiver may read 20 bytes at once. Fix it with length-prefix framing.
> 3. Interview-style: "Why does `accept()` return a new socket instead of reusing the listening one?" *Hint: consider a server with 10,000 simultaneous clients and one listening address.*

#### Remote Procedure Calls

**Theory**

Message passing works, but writing distributed code as explicit `send`/`receive` pairs is tedious and error-prone: every call needs manual serialisation, correlation of replies with requests, and error handling. **Remote Procedure Call** hides that behind the most familiar abstraction in programming — the function call. You write `result = service.get_user(42)`; the runtime turns it into a message, sends it, waits, and returns the reply as a normal return value.

The machinery is a matched pair of generated **stubs**:

1. The **client stub** implements the function locally. It **marshals** the arguments into a serialised message, sends it, and blocks awaiting the reply.
2. The **server skeleton** receives the message, **unmarshals** the arguments, calls the real function, marshals the return value, and sends it back.
3. The client stub unmarshals the result and returns it, so the caller sees an ordinary function return.

Marshalling must handle representation differences across machines — byte order, word size, floating-point format, and pointer meaninglessness — which is why RPC systems define an interface in a neutral **IDL** (Protocol Buffers, Thrift, OpenAPI) and generate both stubs from it.

The essential caution — and the standard interview topic — is that **RPC is not a local call**, however much it looks like one. The differences are semantic, not cosmetic:

| | Local call | Remote call |
|---|---|---|
| Latency | ~1 ns | 0.1-100+ ms |
| Failure modes | The function throws | Timeout, partial failure, lost reply, slow peer |
| Argument passing | By reference possible | By value only; pointers are meaningless |
| Partial failure | Impossible | The call may have executed even though you saw an error |

That last row is the crux. If a reply is lost, the client cannot distinguish "not executed" from "executed, reply lost". This forces an explicit choice of delivery semantics: **at-most-once** (never retry; safe but may not happen), **at-least-once** (retry; requires idempotent operations), or **exactly-once** (only achievable with deduplication and sequence numbers, and never for free). Modern systems (gRPC, Thrift) therefore expose timeouts, retries, and deadlines as first-class concerns rather than hiding them.

**Example**

```text
   Anatomy of an RPC

   CLIENT                                          SERVER
   ------                                          ------
   result = get_user(42)
        |
   client stub:
     marshal {method:"get_user", args:[42], id:7}
     send ------------------------------------->  receive
                                                  server skeleton:
                                                    unmarshal
                                                    call real get_user(42)
                                                    marshal {id:7, result:{...}}
     receive <--------------------------------- send
     unmarshal, match id 7 to the waiting call
        |
   returns User(...)   <- looks exactly like a local return

   What can go wrong between the two arrows:
     request lost      -> server never ran it
     reply lost        -> server RAN it; client sees a timeout
     server slow       -> client times out; server still executing
   The client cannot tell these apart. Hence idempotency and request IDs.
```

```protobuf
// The IDL: one neutral definition, both stubs generated from it.
syntax = "proto3";

service UserService {
  rpc GetUser (GetUserRequest) returns (User);
}

message GetUserRequest { int32 id = 1; }
message User {
  int32  id    = 1;
  string name  = 2;
  string email = 3;
}
```

```python
import grpc, user_pb2, user_pb2_grpc

channel = grpc.insecure_channel("localhost:50051")
stub = user_pb2_grpc.UserServiceStub(channel)

try:
    # Looks like a method call; is a network round trip.
    user = stub.GetUser(user_pb2.GetUserRequest(id=42), timeout=2.0)
    #                                                   ^^^^^^^^^^^ never omit:
    # without a deadline a dead peer blocks this caller indefinitely.
    print(user.name)
except grpc.RpcError as e:
    # Failure modes with no local equivalent -- and note that DEADLINE_EXCEEDED
    # does NOT mean the server did nothing.
    if e.code() == grpc.StatusCode.DEADLINE_EXCEEDED:
        print("timed out; the call may or may not have executed")
    elif e.code() == grpc.StatusCode.UNAVAILABLE:
        print("peer unreachable; safe to retry only if idempotent")
```

**Key takeaways**

- RPC makes a remote request look like a function call by generating client stubs and server skeletons from an IDL.
- Marshalling handles serialisation and machine representation differences; pointers cannot be passed.
- RPC is not a local call: latency is millions of times higher and partial failure is possible.
- A lost reply is indistinguishable from a lost request, so choose at-most-once or at-least-once semantics deliberately and make retried operations idempotent.

> 🧪 Practice
>
> 1. Define a two-method service in an IDL of your choice, generate the stubs, and implement both sides locally.
> 2. Add an artificial 5-second delay in the server and a 1-second client deadline. Show that the server still completes the work after the client gives up, and explain the implication.
> 3. Interview-style: "How would you make a `transfer_money` RPC safe to retry?" *Hint: think about a client-supplied identifier and what the server must remember.*

---

<a id="3-threads-and-concurrency"></a>
## 3. Threads and Concurrency

A process bundles two things that need not travel together: a protected resource container and a stream of execution. This chapter separates them, introducing the thread as an independently schedulable execution stream inside a shared address space, examining where threads are implemented and what that costs, and surveying the programming models — pools, implicit threading, fork-join — that make concurrency tractable in practice. Threads are how a single program exploits multiple cores and stays responsive during blocking work, which makes this material the bridge between the process model of Chapter 2 and the scheduling and synchronisation problems of Chapters 4 and 5.

<a id="31-thread-fundamentals"></a>
### 3.1 Thread Fundamentals

This section establishes why threads exist at all, what precisely distinguishes them from processes, what the kernel must remember about each one, and the distinction between running concurrently and running in parallel.

#### Motivation for Threads

**Theory**

Chapter 2 presented the process as a single unit. Look closely and it is two independent things fused together:

1. A **resource container**: an address space, open file descriptors, a working directory, an identity.
2. An **execution stream**: a program counter, a register set, a stack, a scheduling state.

Nothing requires these to be one-to-one. A **thread** is what you get by keeping one resource container and putting several execution streams inside it. All threads of a process share its memory, its file descriptors, and its identity; each has its own program counter, registers, and stack.

Four concrete pressures made this worth doing:

- **Responsiveness.** A word processor that spell-checks on the same execution stream as the UI freezes while it works. Move the spell-check to another thread and the interface keeps responding. Any long or blocking operation in a single-threaded interactive program stalls everything.
- **Parallelism.** A single execution stream uses exactly one core. On a 16-core machine, a single-threaded program leaves 94% of the hardware idle. Only multiple execution streams can occupy multiple cores.
- **Economy.** Creating a thread is roughly 10-100 times cheaper than creating a process, because there is no address space to build, no page tables to construct, and no file descriptor table to copy. Switching between threads of one process is cheaper too, since the address space does not change.
- **Sharing without ceremony.** Threads share memory by default. Two processes wanting shared data must set up shared memory or copy through the kernel; two threads simply use the same variable.

The cost, paid throughout Chapter 5, is that sharing by default means racing by default. Anything one thread can see, another can modify at an arbitrary moment. Threads trade the process's automatic isolation for speed and sharing, and the programmer must supply the discipline that isolation used to provide for free.

Analogy: a process is an office with one worker; threading it is hiring several workers into the *same* office. They share the filing cabinets and the whiteboard, which makes collaboration instant — and means two of them writing on the whiteboard at once produces nonsense unless they agree on rules.

**Example**

```text
   SINGLE-THREADED PROCESS            MULTITHREADED PROCESS

   +----------------------+           +--------------------------------+
   | code | data | files  |           | code | data | files            |  shared
   +----------------------+           +--------------------------------+
   | registers | stack    |           | regs  | regs  | regs  |         |
   +----------------------+           | stack | stack | stack |         |  private
   |     one thread       |           | T1    | T2    | T3    |         |
   +----------------------+           +--------------------------------+

   Effect on a 4-core machine, one CPU-bound job:

   single-threaded:  core0 [########]  core1 ....  core2 ....  core3 ....
                     25% of the machine, elapsed time T

   four threads:     core0 [##]  core1 [##]  core2 [##]  core3 [##]
                     100% of the machine, elapsed time ~T/4

   Effect on responsiveness (one blocking operation):

   single-threaded:  [UI][=== 3s file load, UI frozen ===][UI]
   two threads:      UI  [UI][UI][UI][UI][UI][UI][UI][UI]
                     wkr      [=== 3s file load ===]
```

```python
import threading, time, urllib.request

URLS = ["https://example.com"] * 8

def fetch(url):
    with urllib.request.urlopen(url, timeout=5) as r:
        return len(r.read())

# Sequential: total time is the SUM of the waits. The CPU is idle throughout.
start = time.perf_counter()
for u in URLS:
    fetch(u)
print(f"sequential: {time.perf_counter() - start:.2f}s")

# Threaded: the waits OVERLAP, so total time approaches the slowest single wait.
start = time.perf_counter()
threads = [threading.Thread(target=fetch, args=(u,)) for u in URLS]
for t in threads: t.start()      # each thread blocks in the kernel independently
for t in threads: t.join()       # wait for all of them to finish
print(f"threaded:   {time.perf_counter() - start:.2f}s")
```

**Key takeaways**

- A process fuses a resource container with an execution stream; a thread separates them, allowing many streams per container.
- Threads share code, data, and open files; each keeps its own program counter, registers, and stack.
- They exist for responsiveness, parallelism across cores, cheap creation and switching, and effortless sharing.
- Sharing by default means racing by default — the isolation processes gave for free must now be programmed explicitly.

> 🧪 Practice
>
> 1. Run the example above and explain why the threaded version is faster even in Python, whose GIL prevents parallel bytecode execution.
> 2. Identify three operations in a text editor that belong on a background thread, and say what would freeze without them.
> 3. Interview-style: "Would threading speed up a program that computes primes for ten minutes with no I/O, in a language with a global interpreter lock?" *Hint: separate waiting-bound work from CPU-bound work, and ask what the lock actually protects.*

#### Thread vs Process

**Theory**

The differences follow mechanically from one fact: **threads of a process share an address space; processes do not.** Everything else is a consequence.

| Property | Process | Thread |
|---|---|---|
| Address space | Private | Shared with sibling threads |
| Open file descriptors | Private copy | Shared |
| Global variables | Private | Shared |
| Stack | One per process | One per thread |
| Registers, program counter | One set | One set per thread |
| Creation cost | High (page tables, descriptor table) | Low (a stack and a control block) |
| Context switch cost | High (address space change, TLB flush) | Low (no address space change) |
| Communication | Kernel-mediated IPC | Direct memory access |
| Fault isolation | Strong — a crash kills one process | None — a crash kills every thread |
| Security boundary | Yes | No |

Three consequences are worth stating explicitly, because they drive real design decisions:

- **A segmentation fault in any thread terminates the whole process.** There is no partial failure. This is why browsers put tabs in separate *processes* rather than threads: one page's crash must not take down the browser. The same reasoning applies to plugin hosts and to any component you do not fully trust.
- **Threads are not a security boundary.** A thread can read every byte the process can, including keys held by another thread. Privilege separation requires processes.
- **Cheapness is not free.** Each thread needs a stack — typically 8 MB of *reserved* virtual address space on Linux, committed lazily. Ten thousand threads is 80 GB of virtual space and a great deal of kernel bookkeeping, which is why high-concurrency servers use event loops or pools rather than a thread per connection.

The choice between them is therefore mostly a question of trust and coupling: use threads for cooperating parts of one program that must share data quickly; use processes when components must be isolated, may crash independently, or run at different privilege levels.

**Example**

```text
   THREE PROCESSES                        ONE PROCESS, THREE THREADS

   +--------+ +--------+ +--------+       +---------------------------+
   | space1 | | space2 | | space3 |       |     one address space     |
   | stack  | | stack  | | stack  |       | stack1 | stack2 | stack3  |
   | heap   | | heap   | | heap   |       |       shared heap         |
   | fds    | | fds    | | fds    |       |       shared fds          |
   +--------+ +--------+ +--------+       +---------------------------+
     P1 crash does not affect P2/P3         any crash kills all three

   Sharing a counter:

   processes: shm_open + mmap + semaphore ... then counter++
   threads:   counter++                     (it is simply in scope)

   Switching:

   process -> process : save regs, LOAD NEW PAGE TABLE, flush TLB, refill caches
   thread  -> thread  : save regs                              (same page table)
                        ~5-10x cheaper
```

```c
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/wait.h>

int shared = 0;               /* one variable; the two models see it differently */

void *thread_fn(void *arg) {
    shared = 100;             /* writes the SAME variable the main thread reads */
    return NULL;
}

int main(void) {
    /* --- threads: shared memory by default --- */
    pthread_t t;
    pthread_create(&t, NULL, thread_fn, NULL);
    pthread_join(t, NULL);
    printf("after thread: shared = %d\n", shared);      /* prints 100 */

    shared = 0;

    /* --- processes: copy-on-write, so the write is private --- */
    if (fork() == 0) {
        shared = 200;         /* writes this process's OWN copy of the page */
        _exit(0);
    }
    wait(NULL);
    printf("after fork:   shared = %d\n", shared);      /* prints 0, not 200 */
    return 0;
}
```

**Key takeaways**

- The single defining difference is the shared address space; every other difference follows from it.
- Threads are cheaper to create, switch, and communicate between; processes provide fault and security isolation.
- A fatal fault in one thread destroys the entire process — there is no partial failure among threads.
- Choose processes when components must be isolated or mutually distrusted; choose threads for tightly cooperating work.

> 🧪 Practice
>
> 1. Run the example and explain the two different results in terms of copy-on-write and shared address space.
> 2. Write a program where one thread dereferences a null pointer, and confirm that all threads die. Repeat with processes and contrast.
> 3. Interview-style: "Chrome uses a process per tab despite the memory cost. Justify the trade-off." *Hint: weigh memory overhead against fault isolation and the security boundary for untrusted code.*

#### Thread Control Block

**Theory**

Just as a process needs a PCB, each thread needs a record of everything required to suspend and resume it: the **Thread Control Block** (TCB). The interesting part is not what it contains but what it *does not* — because the difference from the PCB is exactly the measure of what threads share.

A TCB holds the **per-thread** state:

| Field | Purpose |
|---|---|
| Thread ID | Identity within the process (and, in Linux, a kernel-wide TID) |
| Saved registers, PC, stack pointer | Restored on a context switch |
| Stack base and size | Each thread has its own call stack |
| Scheduling state and priority | The thread, not the process, is the schedulable unit |
| Signal mask | Signals can be blocked per thread |
| Thread-local storage pointer | Per-thread variables (see 3.3) |
| `errno` | Per-thread, or concurrent calls would corrupt each other's error codes |
| Pointer to the owning PCB | Where the shared state lives |

Everything else — page tables, open file table, working directory, user ID, signal *handlers*, heap — lives once in the PCB and is shared by all threads.

Two implications follow:

- **The thread is the unit of scheduling; the process is the unit of resource ownership.** Modern schedulers (Chapter 4) queue threads, not processes. Linux blurs this deliberately: it schedules `task_struct` entities, and a thread is simply a task that shares memory and file tables with others via `clone()` flags.
- **`errno` must be per-thread**, or two threads making concurrent system calls would overwrite each other's error status. This is why `errno` is a macro expanding to a thread-local lookup rather than a global variable, and it is the historical reason many old library functions (`strtok`, `gmtime`) have `_r` reentrant variants.

Analogy: the PCB is the office lease, the filing cabinets, and the company name; the TCB is each worker's own desk, notepad, and current task. Hiring another worker means one more desk, not another office.

**Example**

```text
   One PCB, three TCBs

   +-------------------------------------------------------+
   |  PCB (process 4412)                                   |
   |    page table base | open files | cwd | uid           |  SHARED
   |    signal handlers | heap | code | globals            |
   +---------+----------------+----------------+-----------+
             |                |                |
      +------+-----+   +------+-----+   +------+-----+
      | TCB tid=1  |   | TCB tid=2  |   | TCB tid=3  |     PRIVATE
      | regs, PC   |   | regs, PC   |   | regs, PC   |
      | stack ptr  |   | stack ptr  |   | stack ptr  |
      | state      |   | state      |   | state      |
      | errno      |   | errno      |   | errno      |
      | sig mask   |   | sig mask   |   | sig mask   |
      | TLS ptr    |   | TLS ptr    |   | TLS ptr    |
      +------------+   +------------+   +------------+

   Address space with three stacks:

   high | stack T1 (8 MB reserved) |
        | guard page               |
        | stack T2                 |
        | guard page               |
        | stack T3                 |
        | ...                      |
        | shared heap              |   <- all threads allocate from here
   low  | shared code and globals  |
```

```c
/* A teaching-sized TCB: note how short it is compared with a PCB. */
struct tcb {
    tid_t  tid;
    struct context { uint64_t rip, rsp, rbp, rax, rflags; } ctx;  /* private */

    void  *stack_base;
    size_t stack_size;                    /* its own stack, always */

    enum { READY, RUNNING, BLOCKED, TERMINATED } state;
    int    priority;

    sigset_t signal_mask;                 /* per-thread blocking mask ...      */
    int      thread_errno;                /* ... and per-thread error status   */
    void    *tls;                         /* thread-local storage block        */

    struct pcb *process;                  /* EVERYTHING shared lives here:
                                             page tables, fds, cwd, handlers  */
    struct tcb *next_in_queue;
};
```

```bash
ps -eLf | head              # -L shows threads: note LWP column vs PID
cat /proc/self/status | grep Threads
ls /proc/self/task/         # one directory per thread, each with its own stat
```

**Key takeaways**

- The TCB stores only per-thread state: registers, stack, scheduling data, signal mask, TLS, and `errno`.
- All shared state — page tables, file descriptors, working directory, signal handlers, heap — stays in the PCB.
- The thread is the unit of scheduling; the process remains the unit of resource ownership and protection.
- `errno` and functions like `strtok` need per-thread storage or reentrant variants precisely because of this split.

> 🧪 Practice
>
> 1. Inspect `/proc/self/task/` in a multithreaded program. Which per-thread files exist, and which fields differ between threads?
> 2. Explain why signal *handlers* are per-process while signal *masks* are per-thread. What would break if handlers were per-thread?
> 3. Interview-style: "Why does `strtok` have a `strtok_r` variant?" *Hint: ask where `strtok` keeps its position between calls, and what happens when two threads call it.*

#### Concurrency vs Parallelism

**Theory**

These words are used interchangeably in casual speech and mean genuinely different things, and the distinction determines whether adding threads will help.

**Concurrency** is a property of *program structure*: the program is composed of multiple independently progressing tasks whose execution may interleave. Concurrency exists on a single core — the tasks take turns — and is about *dealing with* many things at once.

**Parallelism** is a property of *execution*: multiple tasks literally execute at the same instant on different hardware. Parallelism requires multiple cores and is about *doing* many things at once.

Concurrency without parallelism is a single-core time-sharing system, or an event loop. Parallelism without concurrency is a vectorised numeric kernel, where one instruction stream operates on many data elements. Most real systems use both.

The practical consequence is that **the two solve different problems**:

| | Concurrency | Parallelism |
|---|---|---|
| Solves | Latency hiding, responsiveness, structuring I/O-bound work | Throughput on CPU-bound work |
| Needs | One core is enough | Multiple cores |
| Helps when | Tasks spend time waiting | Tasks spend time computing |
| Typical tool | Event loop, async/await, blocking threads | Thread pool sized to cores, SIMD, GPU |

Adding threads to a CPU-bound problem on one core gains nothing and costs switching overhead. Adding threads to an I/O-bound problem helps enormously even on one core, because the waits overlap.

**Amdahl's law** bounds what parallelism can achieve: if a fraction *S* of a program is inherently serial, the maximum speed-up with *N* processors is `1 / (S + (1 - S) / N)`. With 5% serial work, the ceiling is 20x no matter how many cores you add. This is why reducing the serial fraction — often lock contention — matters more than adding hardware.

Analogy: a single barista serving a queue while drinks brew is *concurrent* — one worker, several drinks progressing. Two baristas working simultaneously is *parallel*. If the shop has one espresso machine, adding baristas stops helping: that machine is the serial fraction.

**Example**

```text
   CONCURRENT, NOT PARALLEL (one core)

   core0: [A][B][C][A][B][C][A]      tasks interleave; only one runs at a time
   wall clock ------------------->

   PARALLEL (three cores)

   core0: [AAAAAAAA]
   core1: [BBBBBBBB]                 genuinely simultaneous
   core2: [CCCCCCCC]

   CONCURRENT AND PARALLEL (typical: 8 tasks, 3 cores)

   core0: [A][D][G]
   core1: [B][E][H]
   core2: [C][F]

   Amdahl's law: maximum speed-up with a serial fraction S

     S = 0.50 -> ceiling  2x     (even with infinite cores)
     S = 0.10 -> ceiling 10x
     S = 0.05 -> ceiling 20x
     S = 0.01 -> ceiling 100x

   cores:      1     2     4     8    16    64   inf
   S=0.05:   1.0x  1.9x  3.5x  5.9x  9.1x 15.4x  20x   <- flattens hard
```

```python
import time
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor

def cpu_bound(n):                 # pure computation: needs PARALLELISM
    return sum(i * i for i in range(n))

def io_bound(seconds):            # pure waiting: needs CONCURRENCY only
    time.sleep(seconds)

# I/O-bound work: threads win, even with a GIL, because the waits overlap.
start = time.perf_counter()
with ThreadPoolExecutor(max_workers=8) as ex:
    list(ex.map(io_bound, [1] * 8))
print(f"8 x 1s sleep with threads: {time.perf_counter() - start:.2f}s")  # ~1s

# CPU-bound work: threads do NOT help under a GIL; processes give real parallelism.
N = 3_000_000
start = time.perf_counter()
with ThreadPoolExecutor(max_workers=4) as ex:
    list(ex.map(cpu_bound, [N] * 4))
print(f"cpu-bound, threads:   {time.perf_counter() - start:.2f}s")   # no speed-up

start = time.perf_counter()
with ProcessPoolExecutor(max_workers=4) as ex:
    list(ex.map(cpu_bound, [N] * 4))
print(f"cpu-bound, processes: {time.perf_counter() - start:.2f}s")   # ~4x faster
```

**Key takeaways**

- Concurrency is a structural property (tasks interleave); parallelism is an execution property (tasks run simultaneously).
- Concurrency needs only one core and addresses waiting; parallelism needs many cores and addresses computation.
- Adding threads to CPU-bound work on one core costs overhead and gains nothing.
- Amdahl's law caps speed-up by the serial fraction, so reducing contention beats adding cores.

> 🧪 Practice
>
> 1. Run the example on a multi-core machine and explain each of the three timings.
> 2. A program is 90% parallelisable. Compute the speed-up at 4, 16, and 1024 cores, and state the practical lesson.
> 3. Interview-style: "Is an event loop like Node.js concurrent, parallel, or both?" *Hint: count the execution streams running JavaScript, then ask where the I/O actually happens.*

<a id="32-threading-models"></a>
### 3.2 Threading Models

Threads can be implemented in a user-space library, in the kernel, or both — and the choice determines scheduling, blocking behaviour, and whether threads can use multiple cores.

#### User-Level Threads

**Theory**

A thread needs a stack, a saved register set, and something to decide which thread runs next. None of that strictly requires the kernel. **User-level threads** are implemented entirely inside a library linked into the process: the library allocates stacks from the heap, saves and restores registers itself, and runs its own scheduler. The kernel knows nothing about them — it sees one ordinary single-threaded process.

The advantages come from staying out of the kernel:

- **Switching is extremely fast.** A switch is a function that saves a few registers and swaps stack pointers: tens of nanoseconds, with no mode transition, no TLB effect, no scheduler involvement. Kernel thread switches cost roughly a hundred times more.
- **Creation is cheap** — allocate a stack and a small control block. Millions of threads are feasible; kernel threads at that scale are not.
- **The scheduling policy is the application's.** A library can schedule cooperatively, by priority, or by work-stealing, tuned to the workload rather than to a general-purpose kernel policy.
- **It is portable**, requiring no kernel support at all.

The two defects are fundamental and both stem from the kernel's ignorance:

- **A blocking system call blocks every thread.** The kernel sees one process; when that process blocks on `read()`, all user-level threads stop, even runnable ones. The classic workaround is to make all I/O non-blocking underneath and have the library switch threads on would-block, which is exactly what modern runtimes do.
- **No parallelism.** One process with one kernel-schedulable entity gets one core, regardless of how many user threads exist.

Historically this made pure user-level threading a dead end. Modern runtimes revived it by pairing it with the kernel: Go's goroutines, Java's virtual threads (Project Loom), Erlang processes, and Rust's async tasks are all user-level threads multiplexed onto a pool of kernel threads, with the runtime intercepting blocking operations. The result keeps the cheapness and adds the parallelism.

Analogy: a manager who subdivides their own work into tasks and switches between them freely. Very efficient, invisible to the company — but the company only ever allocated one desk, so no matter how many tasks exist, one at a time proceeds, and if the manager is stuck waiting on a phone call, everything stops.

**Example**

```text
   USER-LEVEL THREADS

   user space  | process                                  |
               |  +----+ +----+ +----+ +----+             |
               |  | T1 | | T2 | | T3 | | T4 |  library-   |
               |  +----+ +----+ +----+ +----+  managed    |
               |        thread library + scheduler        |
   ------------+------------------------------------------+
   kernel      |  ONE kernel thread / one schedulable     |
               |  entity -- the kernel sees a plain       |
               |  single-threaded process                 |
   ------------+------------------------------------------+
                          ONE core, always

   The blocking problem:

   T2 calls read() ---> kernel blocks THE PROCESS
   T1, T3, T4 are runnable but cannot run: the library never regains control
```

```c
/* A minimal cooperative user-level thread library. No kernel involvement. */
#include <ucontext.h>
#define MAX 8

static ucontext_t ctx[MAX];       /* saved register+stack context per thread */
static char stacks[MAX][64 * 1024];
static int  current = 0, count = 0;

void spawn(void (*fn)(void)) {
    getcontext(&ctx[count]);
    ctx[count].uc_stack.ss_sp   = stacks[count];    /* its own stack, from the
                                                       process heap -- no kernel
                                                       allocation involved     */
    ctx[count].uc_stack.ss_size = sizeof stacks[count];
    ctx[count].uc_link          = &ctx[0];
    makecontext(&ctx[count], fn, 0);
    count++;
}

void yield_to_next(void) {
    int prev = current;
    current = (current + 1) % count;   /* the library's own scheduler --
                                          cooperative: threads must call this */
    swapcontext(&ctx[prev], &ctx[current]);   /* ~20 ns, no mode switch */
}
```

```go
// The modern revival: goroutines are user-level threads that the runtime
// multiplexes onto kernel threads, so blocking and parallelism both work.
func main() {
    for i := 0; i < 100000; i++ {   // 100k goroutines: a few KB each.
        go worker(i)                // 100k OS threads would exhaust the machine.
    }
    // When a goroutine makes a blocking syscall, the Go runtime detaches its
    // kernel thread and schedules other goroutines on another one --
    // exactly the fix pure user-level threading lacked.
}
```

**Key takeaways**

- User-level threads live entirely in a library; the kernel sees a single-threaded process.
- Switching and creation are extremely cheap, and the scheduling policy is application-controlled.
- One blocking system call stops every thread, and the process can never use more than one core.
- Modern runtimes (goroutines, virtual threads, async tasks) keep the cheapness by mapping user threads onto kernel threads.

> 🧪 Practice
>
> 1. Extend the `ucontext` example to three threads that yield in a loop, and measure the switch cost. Compare with `pthread` switch cost.
> 2. Explain precisely why a `read()` from one user-level thread stalls the others, and describe two ways a runtime avoids it.
> 3. Interview-style: "Why can Go run a million goroutines when a million OS threads would fail?" *Hint: compare stack allocation strategy and who does the scheduling.*

#### Kernel-Level Threads

**Theory**

**Kernel-level threads** are threads the kernel knows about individually: each has its own kernel-visible entity (in Linux, a `task_struct` with a TID), sits in the scheduler's run queue on its own, and can be dispatched to any core.

This inverts every property of user-level threads:

- **True parallelism.** Threads are independently schedulable, so a process with eight threads can occupy eight cores.
- **Blocking is contained.** When one thread blocks on I/O, the kernel marks *that thread* blocked and schedules a sibling. The process continues.
- **Scheduling is fair across the system**, and the kernel can apply priorities, affinity, and real-time policies to individual threads.
- But **every operation costs a system call.** Creation, destruction, and synchronisation that requires blocking all cross into the kernel.
- And **each thread consumes kernel memory** — a kernel stack plus a task structure, on the order of 8-16 KB — bounding how many can exist.
- **Switching is more expensive** than user-level switching, though still cheaper than a process switch since the address space does not change.

Linux implements this with unusual clarity: there is no separate "thread" object. `clone()` creates a task, and flags decide what it shares with its creator — `CLONE_VM` shares the address space, `CLONE_FILES` the descriptor table, `CLONE_SIGHAND` the signal handlers. `fork()` is `clone()` with nothing shared; `pthread_create()` is `clone()` with nearly everything shared. Processes and threads are two points on a continuum of sharing.

The practical limit matters: at roughly 8 KB of kernel stack per thread plus scheduler bookkeeping, ten thousand threads is feasible but wasteful, and the scheduler's run queue and cache behaviour degrade. This is why "thread per connection" servers stopped scaling and were replaced by pools and event loops.

**Example**

```text
   KERNEL-LEVEL THREADS (one-to-one)

   user space  | process                                  |
               |  +----+ +----+ +----+ +----+             |
               |  | T1 | | T2 | | T3 | | T4 |             |
   ------------+----|------|------|------|----------------+
   kernel      |  +-v--+ +-v--+ +-v--+ +-v--+             |
               |  |KT1 | |KT2 | |KT3 | |KT4 |  each in    |
               |  +----+ +----+ +----+ +----+  the run    |
               |     scheduler run queue        queue     |
   ------------+------------------------------------------+
                  core0  core1  core2  core3
                  genuinely parallel; a blocked thread does not stop the others

   Linux: one mechanism, different sharing

   clone(flags):
     fork()            -> no CLONE_VM, no CLONE_FILES     ... a process
     pthread_create()  -> CLONE_VM | CLONE_FILES |
                          CLONE_SIGHAND | CLONE_THREAD    ... a thread
     vfork()           -> CLONE_VM | CLONE_VFORK          ... something between
```

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <sched.h>
#include <unistd.h>
#include <sys/syscall.h>

int shared_value = 0;
static char child_stack[64 * 1024];

int child_fn(void *arg) {
    /* CLONE_VM was set, so this writes the SAME memory the parent sees. */
    shared_value = 42;
    printf("child  tid=%ld sees shared_value=%d\n",
           syscall(SYS_gettid), shared_value);
    return 0;
}

int main(void) {
    /* Build a thread by choosing what to share -- there is no separate API. */
    clone(child_fn,
          child_stack + sizeof child_stack,   /* stacks grow down: pass the top */
          CLONE_VM |        /* share the address space  -> thread-like */
          CLONE_FILES |     /* share open file descriptors             */
          CLONE_SIGHAND |   /* share signal handlers                   */
          SIGCHLD,
          NULL);
    sleep(1);
    printf("parent tid=%ld sees shared_value=%d\n",
           syscall(SYS_gettid), shared_value);   /* prints 42 */
    return 0;
}
```

```bash
cat /proc/sys/kernel/threads-max     # system-wide ceiling
ulimit -u                            # per-user process/thread limit
ps -eLf | wc -l                      # threads currently alive
```

**Key takeaways**

- Kernel-level threads are individually schedulable entities, giving true multi-core parallelism.
- A blocking call suspends only the calling thread; siblings continue running.
- Every thread costs a system call to create and several kilobytes of kernel memory to exist.
- Linux unifies processes and threads under `clone()`, where flags select what is shared.

> 🧪 Practice
>
> 1. Modify the `clone` example to omit `CLONE_VM` and explain the change in observed behaviour.
> 2. Write a program that creates threads in a loop until failure. How many succeed, and which limit stopped you?
> 3. Interview-style: "Why did thread-per-connection servers stop scaling around 10,000 connections?" *Hint: multiply per-thread kernel memory and stack reservation, then think about scheduler run-queue behaviour.*

#### Many-to-One Model

**Theory**

The **many-to-one** model maps many user-level threads onto a single kernel thread. It is pure user-level threading as described above, stated as a mapping.

Thread management happens entirely in user space, so it is fast and portable, and it works on systems with no kernel thread support at all — which is why early Java (the "green threads" of JDK 1.1) and Solaris's original library used it.

Its two flaws are decisive and both follow from the single kernel thread:

- **One blocking system call blocks the whole process**, because the kernel has exactly one schedulable entity to block.
- **No parallelism ever**, since one kernel thread occupies one core.

The model therefore only makes sense when either the workload does no blocking I/O, or the runtime converts every blocking operation into a non-blocking one internally. That second option is what modern async runtimes do, which is why the model is worth understanding despite being obsolete in its naive form: a single-threaded event loop (Node.js, Python `asyncio` on one thread) is many-to-one with the blocking problem engineered away.

**Example**

```text
   MANY-TO-ONE

        T1   T2   T3   T4        user threads
          \   |   |   /
           \  |   |  /
            +-------+
            |  K1   |            ONE kernel thread
            +-------+
                |
             core0                ONE core, always

   Failure mode:

   T1 blocks on read()  ->  K1 blocks  ->  T2, T3, T4 stall
                                            even though they are runnable
```

```python
# asyncio: many-to-one done correctly. One kernel thread, many tasks,
# and every blocking operation replaced by an awaitable non-blocking one.
import asyncio

async def worker(n):
    await asyncio.sleep(1)      # yields to the event loop; does NOT block
                                # the kernel thread -- this is the fix that
                                # makes many-to-one viable
    return n * 2

async def main():
    results = await asyncio.gather(*(worker(i) for i in range(1000)))
    print(len(results), "tasks completed in about one second")

asyncio.run(main())

# The trap: one genuinely blocking call ruins it.
async def broken():
    import time
    time.sleep(1)               # BLOCKS the single kernel thread; every other
                                # task stalls -- the many-to-one flaw, live.
```

**Key takeaways**

- Many-to-one maps all user threads onto one kernel thread; management is entirely in user space.
- It is fast, portable, and requires no kernel support.
- Any blocking system call stalls every thread, and the process can never exceed one core.
- Modern async runtimes are many-to-one with all blocking operations replaced by non-blocking equivalents.

> 🧪 Practice
>
> 1. Replace `asyncio.sleep(1)` with `time.sleep(1)` in the example and measure the total time. Explain the difference.
> 2. Give two workloads well suited to many-to-one and two that are badly suited, with reasons.
> 3. Interview-style: "Why is calling a slow synchronous database driver inside an async handler a bug?" *Hint: count the kernel threads available to serve the other pending requests.*

#### One-to-One Model

**Theory**

The **one-to-one** model maps each user thread to its own kernel thread. It is the model used by Linux (NPTL), Windows, and macOS, and is what `pthread_create`, `std::thread`, and `java.lang.Thread` give you.

Its virtues are the mirror image of many-to-one's flaws: **real parallelism** across cores, and **independent blocking**, so a thread waiting on I/O does not impede its siblings. The kernel scheduler handles everything, applying system-wide fairness, priorities, and affinity.

The cost is that threads are now kernel objects:

- Creation requires a system call and kernel memory (a kernel stack plus task structure, ~8-16 KB), plus a user stack whose *reserved* virtual size defaults to 8 MB on Linux.
- Context switches are kernel operations, roughly 1-5 microseconds plus cache effects.
- The number of threads is bounded by memory and by scheduler efficiency, historically leading systems to cap thread counts.

This makes the model excellent up to hundreds or a few thousand threads and unsuitable for hundreds of thousands. The standard responses are covered in 3.3: use a **thread pool** sized to the core count for CPU-bound work, and an event loop or a runtime with user-level tasks for very high I/O concurrency.

The tuning knob worth knowing is stack size. Ten thousand threads at the default 8 MB reservation is 80 GB of virtual address space — usually survivable because it is reserved rather than committed, but it can hit limits. Setting a smaller stack via `pthread_attr_setstacksize` is the standard fix for thread-heavy programs.

**Example**

```text
   ONE-TO-ONE

        T1   T2   T3   T4        user threads
         |    |    |    |
        K1   K2   K3   K4        one kernel thread each
         |    |    |    |
       core0 core1 core2 core3   true parallelism

   T2 blocks on read():
        T1, T3, T4 keep running -- only K2 is marked BLOCKED

   Cost of one thread:

     kernel stack + task_struct   ~8-16 KB   (committed kernel memory)
     user stack reservation       8 MB       (virtual; committed on use)
     creation                     ~10-30 us  (a system call)
     switch                       ~1-5 us    (plus cache/TLB effects)
```

```c
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

void *worker(void *arg) {
    long id = (long)arg;
    /* This blocks only THIS thread; the others continue on other cores. */
    sleep(1);
    printf("thread %ld done\n", id);
    return NULL;
}

int main(void) {
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, 256 * 1024);   /* 256 KB instead of the
                                                       8 MB default: the fix
                                                       for thread-heavy code  */
    pthread_t t[4];
    for (long i = 0; i < 4; i++)
        pthread_create(&t[i], &attr, worker, (void *)i);   /* a syscall each */

    for (int i = 0; i < 4; i++)
        pthread_join(t[i], NULL);       /* wait; without this, main may exit
                                           and terminate the whole process   */
    pthread_attr_destroy(&attr);
    return 0;
}
```

```bash
ulimit -s                       # default stack size (KB) for the main thread
ps -eLf | grep myprogram        # one row per kernel thread -- the mapping, visible
```

**Key takeaways**

- One-to-one gives each user thread its own kernel thread and is the model on Linux, Windows, and macOS.
- It delivers real parallelism and independent blocking, at the cost of a system call and kernel memory per thread.
- Practical limits are hundreds to a few thousand threads, driven by memory and scheduler efficiency.
- Reducing the per-thread stack reservation is the standard remedy for programs that need many threads.

> 🧪 Practice
>
> 1. Create 1,000 threads with the default stack size and again with 64 KB. Compare virtual memory usage via `/proc/self/status`.
> 2. Demonstrate independent blocking: one thread sleeps 5 seconds while three others print continuously.
> 3. Interview-style: "How many threads should a CPU-bound thread pool have on a 16-core machine, and why not more?" *Hint: think about what an extra runnable thread adds beyond the core count.*

#### Many-to-Many Model

**Theory**

The **many-to-many** model multiplexes *M* user threads onto *N* kernel threads, where N is typically close to the core count and M can be far larger. It is an attempt to take the cheapness of user threads and the parallelism of kernel threads simultaneously.

The properties it aims for:

- **Cheap, plentiful user threads** — create as many as the problem naturally has, not as many as the kernel can afford.
- **Real parallelism**, since there are several kernel threads to occupy several cores.
- **Blocking is survivable**: when a user thread blocks, the runtime can move the remaining user threads to another kernel thread, or create one.
- **Two-level scheduling**: the kernel schedules kernel threads; the runtime schedules user threads onto them.

The **two-level model** is a common variant that additionally allows a specific user thread to be bound permanently to its own kernel thread, for latency-critical work that must not wait behind the runtime's scheduler.

The difficulty is that two schedulers that cannot see each other make bad decisions together: the runtime may put two runnable user threads on one kernel thread while another sits idle, or the kernel may preempt precisely the kernel thread holding a user-level lock. Solaris and IRIX implemented true many-to-many and later abandoned it — Solaris moved to one-to-one in version 9 — because the complexity was not repaid. **Scheduler activations** were the research answer: the kernel *upcalls* the runtime whenever a thread blocks or a core becomes available, so the user scheduler is informed rather than guessing.

The model is now dominant again, in language runtimes rather than operating systems. Go's scheduler (the G-M-P model), Java's virtual threads, Erlang's BEAM, and Rust's Tokio all multiplex enormous numbers of lightweight tasks onto a small pool of kernel threads, with the runtime handling blocking by detaching and replacing kernel threads. The lesson is that many-to-many works well when a single runtime controls both the tasks and the I/O, and poorly when it must guess what the kernel is doing.

**Example**

```text
   MANY-TO-MANY (M user threads on N kernel threads, M >> N)

     T1  T2  T3  T4  T5  T6  T7  T8      many cheap user threads
       \  |  /      \  |  /   |
        \ | /        \ | /    |
        +----+      +----+  +----+
        | K1 |      | K2 |  | K3 |       N kernel threads, N ~ cores
        +----+      +----+  +----+
          |            |       |
        core0        core1   core2

   When T3 blocks on a syscall:
     K1 is blocked, but the runtime moves T1, T2 to K2/K3
     (or spins up a replacement kernel thread) -- work continues.

   Go's G-M-P scheduler, the same idea named differently:

     G = goroutine (user thread)   M = OS thread   P = logical processor
     each P holds a run queue of Gs and must be attached to an M to run them
     GOMAXPROCS sets the number of Ps -- i.e. the parallelism ceiling
     blocked syscall: M detaches from P; another M picks P up and keeps going
```

```go
package main

import (
    "fmt"
    "runtime"
    "sync"
)

func main() {
    runtime.GOMAXPROCS(4)     // N: kernel-level parallelism ceiling

    var wg sync.WaitGroup
    for i := 0; i < 100000; i++ {   // M: 100,000 user-level goroutines,
        wg.Add(1)                   // ~2 KB of growable stack each
        go func(n int) {
            defer wg.Done()
            _ = n * n
        }(i)
    }
    wg.Wait()
    // 100k goroutines multiplexed onto ~4 OS threads: neither pure model
    // could do this. One-to-one would need 100k kernel threads;
    // many-to-one would use one core.
    fmt.Println("OS threads in use:", runtime.GOMAXPROCS(0))
}
```

**Key takeaways**

- Many-to-many multiplexes M user threads over N kernel threads, aiming for cheap threads plus real parallelism.
- It needs two cooperating schedulers, and their mutual blindness is the source of its difficulty.
- Operating systems largely abandoned it (Solaris moved to one-to-one); scheduler activations were the research fix.
- Language runtimes revived it successfully — goroutines, virtual threads, BEAM, Tokio — because one runtime controls both scheduling and I/O.

> 🧪 Practice
>
> 1. Run the Go example with `GOMAXPROCS` set to 1 and to your core count, timing both. Explain the difference.
> 2. Describe a scenario where the kernel preempts a kernel thread holding a user-level lock, and the consequence for the other user threads.
> 3. Interview-style: "Compare the three models on parallelism, blocking behaviour, and cost, and say when each is appropriate." *Hint: build the table yourself; the deciding axis is who knows about the thread.*

<a id="33-thread-programming"></a>
### 3.3 Thread Programming

Knowing what a thread is does not make concurrent programs correct; this section covers the concrete APIs and the patterns that keep thread use manageable at scale.

#### POSIX Threads

**Theory**

**Pthreads** is the POSIX specification for thread creation and synchronisation — an API standard, not an implementation. Linux implements it as NPTL over `clone()`; other UNIX systems implement it differently. Learning it is worthwhile because nearly every higher-level threading API in C-family languages is a thin layer over it, and its vocabulary is universal.

The core lifecycle has four operations:

- **`pthread_create(&tid, attr, fn, arg)`** starts a new thread running `fn(arg)`. It returns immediately; the new thread runs concurrently. The `attr` parameter sets stack size, detach state, and scheduling policy.
- **`pthread_join(tid, &ret)`** blocks until the named thread finishes and collects its return value. This is the thread analogue of `waitpid`, and it serves the same purpose: without it, the thread's resources are not reclaimed.
- **`pthread_detach(tid)`** declares that nobody will join this thread, so its resources are released automatically on exit. A thread that is neither joined nor detached leaks — the thread equivalent of a zombie.
- **`pthread_exit(ret)`** terminates the calling thread with a return value; returning from the thread function does the same.

Three rules cause most beginner bugs:

1. **The argument is a `void *`, passed by pointer.** Passing the address of a loop variable gives every thread a pointer to the *same* changing variable — the single most common pthreads mistake.
2. **If `main` returns, the process exits and all threads die**, however much work remains. `main` must join its threads or call `pthread_exit` itself.
3. **Return values must outlive the thread.** Returning a pointer to a local variable returns a pointer into a destroyed stack.

Errors do not use `errno`: pthreads functions return the error number directly, so checking the return value is mandatory.

**Example**

```text
   Thread lifecycle

   main thread                       worker thread
   -----------                       -------------
   pthread_create() -------------->  starts running fn(arg)
   ... runs concurrently ...         ... runs concurrently ...
   pthread_join()   <== blocks ===   pthread_exit(result) / return result
   receives result, resources freed

   Joinable vs detached

   joinable (default): resources kept until someone joins  -> must join
   detached:           resources freed on exit             -> must not join

   Neither joined nor detached = a leak (the "zombie thread")
```

```c
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

struct task { int id; long result; };     /* one struct PER THREAD: see below */

void *worker(void *arg) {
    struct task *t = arg;                 /* the void* is cast back here */
    t->result = 0;
    for (int i = 1; i <= 1000; i++)
        t->result += (long)i * t->id;
    return t;                             /* must outlive this thread:
                                             heap or caller-owned, never a local */
}

int main(void) {
    enum { N = 4 };
    pthread_t   tid[N];
    struct task tasks[N];                 /* lives in main's frame, which
                                             outlives the workers because we join */

    for (int i = 0; i < N; i++) {
        tasks[i].id = i + 1;
        /* Pass a pointer to a DISTINCT object per thread.
           Passing &i here would be the classic bug: every thread would see
           the same variable, changing under them. */
        int rc = pthread_create(&tid[i], NULL, worker, &tasks[i]);
        if (rc != 0) {                    /* pthreads returns the error, and
                                             does NOT set errno */
            fprintf(stderr, "pthread_create: %d\n", rc);
            exit(1);
        }
    }

    for (int i = 0; i < N; i++) {
        void *ret;
        pthread_join(tid[i], &ret);       /* blocks; also reclaims resources */
        printf("thread %d returned %ld\n",
               ((struct task *)ret)->id, ((struct task *)ret)->result);
    }
    return 0;                             /* safe: all threads already joined */
}
```

```bash
gcc -pthread prog.c -o prog     # -pthread, not just -lpthread: it sets defines too
```

**Key takeaways**

- Pthreads is a specification; `create`, `join`, `detach`, and `exit` form the lifecycle.
- Every thread must be joined or detached, or its resources leak.
- Pass a distinct object to each thread; sharing a pointer to a loop variable is the classic bug.
- Returning from `main` terminates the whole process, killing threads that are still running.

> 🧪 Practice
>
> 1. Deliberately pass `&i` (the loop counter) to each thread and observe the IDs printed. Explain the result precisely.
> 2. Write a program whose `main` returns without joining. Show that worker output is truncated, then fix it two different ways.
> 3. Interview-style: "What is the thread equivalent of a zombie process, and how do you prevent it?" *Hint: consider what happens to a joinable thread that nobody ever joins.*

#### Thread Pools

**Theory**

Creating a thread per unit of work is the obvious design and the wrong one at scale. Each creation costs a system call and kernel memory, the count is unbounded (a traffic spike creates a thread spike), and beyond the core count more threads only add switching overhead and memory pressure without adding throughput.

A **thread pool** fixes all three by inverting the relationship: create a fixed set of worker threads once at startup, and feed them work through a shared queue. Workers loop forever — take a task, run it, take the next.

The benefits are direct consequences:

- **Creation cost is amortised** to zero: threads are made once and reused for the program's lifetime.
- **Concurrency is bounded**, which bounds memory and switching overhead. Under overload the queue grows rather than the thread count — degradation instead of collapse.
- **The queue provides natural backpressure** if it is bounded, letting the system push back on producers rather than accepting unbounded work.
- **Tuning is centralised**: one number controls how much of the machine the workload can use.

Sizing follows from the workload type, and getting this wrong is the usual performance bug:

| Workload | Recommended size | Reasoning |
|---|---|---|
| CPU-bound | Number of cores (or cores + 1) | Extra threads only add switching; no core is idle |
| I/O-bound | Much larger; approximately `cores x (1 + wait/compute)` | Threads spend most time blocked, so many are needed to keep cores busy |
| Mixed | Separate pools per class | One pool sized for both is wrong for each |

Two failure modes are worth knowing. **Pool starvation/deadlock** occurs when a pooled task blocks waiting for another task submitted to the *same* pool: with all workers blocked, nothing can run the task they wait for. The remedy is to never block on same-pool work, or to use separate pools. And an **unbounded queue** converts an overload into memory exhaustion — a bounded queue with an explicit rejection policy fails faster and more honestly.

Analogy: a restaurant with four cooks and an order queue, rather than hiring a new cook for every order. On a busy night the queue lengthens; the kitchen does not fill with cooks who cannot reach the stove.

**Example**

```text
   THREAD POOL

   producers            bounded task queue           fixed workers
   ---------            ------------------           -------------
   submit() --> [T][T][T][T][T][T] --> take() --> [W1] busy
                        ^                          [W2] busy
                        |                          [W3] idle, blocked on take()
                 full -> reject / block            [W4] busy

   Threads are created ONCE. Load shows up as queue depth, not thread count.

   Sizing

   CPU-bound, 8 cores : 8 threads    (more only adds context switches)
   I/O-bound, 8 cores,
     10 ms wait per 1 ms compute     : 8 x (1 + 10/1) = ~88 threads
```

```python
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor, as_completed
import os

def io_task(n):
    import time; time.sleep(0.1); return n

def cpu_task(n):
    return sum(i * i for i in range(n))

cores = os.cpu_count()

# I/O-bound: many more threads than cores, because they are mostly blocked.
with ThreadPoolExecutor(max_workers=cores * 8) as pool:
    futures = [pool.submit(io_task, i) for i in range(200)]
    for f in as_completed(futures):       # results arrive as they complete,
        _ = f.result()                    # not in submission order

# CPU-bound: processes, sized to cores. More workers than cores gains nothing.
with ProcessPoolExecutor(max_workers=cores) as pool:
    results = list(pool.map(cpu_task, [500_000] * cores))
```

```java
import java.util.concurrent.*;

// Bounded queue + explicit rejection policy: fail fast instead of running
// out of memory when producers outpace consumers.
ThreadPoolExecutor pool = new ThreadPoolExecutor(
    8, 8,                                    // fixed core and max pool size
    60L, TimeUnit.SECONDS,
    new ArrayBlockingQueue<>(1000),          // BOUNDED: backpressure, not OOM
    new ThreadPoolExecutor.CallerRunsPolicy()// on overflow the submitter runs
);                                           // the task, throttling producers
```

**Key takeaways**

- A pool creates a fixed set of reusable workers fed by a shared queue, amortising creation cost.
- Bounded concurrency turns overload into queue growth rather than thread explosion.
- Size CPU-bound pools to the core count and I/O-bound pools much larger, based on the wait-to-compute ratio.
- Use bounded queues with a rejection policy, and never block a pooled task on work submitted to the same pool.

> 🧪 Practice
>
> 1. Benchmark 10,000 short tasks with a thread per task versus a pool of 8. Explain the difference in time and peak memory.
> 2. Construct a pool deadlock: submit a task that waits on the result of another task in the same single-threaded pool. Then fix it.
> 3. Interview-style: "Your service has an 8-core box and a 200-thread pool at 100% CPU with poor latency. What do you change?" *Hint: ask whether the work is CPU- or I/O-bound, then reason about switching overhead.*

#### Implicit Threading

**Theory**

Explicit thread management is error-prone: programmers must decide how many threads to create, partition the work, coordinate completion, and get the synchronisation right. **Implicit threading** moves those decisions from the application to a compiler, runtime, or library. The programmer expresses *what may run concurrently*; the system decides how many threads to use and when.

The main approaches:

| Approach | Programmer writes | System decides |
|---|---|---|
| **Thread pools** | Tasks to submit | Thread count, assignment, reuse |
| **OpenMP** | Compiler directives on loops and regions | Team size, loop partitioning, joining |
| **Grand Central Dispatch** | Blocks submitted to queues | Threads, cores, priorities |
| **Fork-join frameworks** | Recursive task decomposition | Work-stealing across a pool |
| **Parallel collections/streams** | A declarative pipeline (`.parallelStream()`) | Splitting, scheduling, merging |
| **async/await** | Suspension points in ordinary-looking code | Event loop, continuations, thread mapping |

The gain is not only convenience but correctness: the runtime's implementation of task distribution and joining is written once, tested heavily, and reused, rather than reimplemented per project. It also adapts at run time — the same binary uses 4 threads on a laptop and 64 on a server.

The costs are real. Performance becomes less predictable and harder to reason about, since the mapping to threads is hidden. Debugging is harder — a stack trace may show runtime internals rather than your call path. And the abstraction assumes tasks are independent; hidden shared state still races, and implicit threading does nothing to prevent it. The rule of thumb: implicit threading manages *parallelism*, not *synchronisation*. You still own every shared variable.

Analogy: hiring a contractor rather than directing each worker. You specify the outcome and constraints; they allocate labour. It goes well when the work is genuinely separable and badly when hidden dependencies exist that only you knew about.

**Example**

```text
   EXPLICIT                          IMPLICIT

   decide thread count               annotate what is parallelisable
   split the data manually           runtime splits it
   create threads                    runtime manages the pool
   join threads                      runtime joins
   handle partial failures           runtime propagates errors

   for (t = 0; t < 8; t++)           #pragma omp parallel for
     pthread_create(...chunk t...)     for (i = 0; i < n; i++)
   for (t = 0; t < 8; t++)               work(i);
     pthread_join(...)
```

```c
#include <omp.h>
#include <stdio.h>

int main(void) {
    double data[1000000], total = 0.0;
    for (int i = 0; i < 1000000; i++) data[i] = i * 0.5;

    /* One directive replaces thread creation, partitioning, and joining.
       `reduction(+:total)` gives each thread a private accumulator and
       combines them safely at the end -- the runtime handles the race. */
    #pragma omp parallel for reduction(+:total)
    for (int i = 0; i < 1000000; i++)
        total += data[i] * data[i];

    printf("total=%f using up to %d threads\n", total, omp_get_max_threads());
    return 0;
}
/* compile: gcc -fopenmp prog.c   -- thread count from OMP_NUM_THREADS or cores */
```

```java
// Parallel streams: declarative, with the same caveat about shared state.
long count = orders.parallelStream()          // runtime splits and schedules
                   .filter(o -> o.total() > 100)
                   .map(Order::customerId)
                   .distinct()
                   .count();

// The trap implicit threading does NOT solve:
List<String> unsafe = new ArrayList<>();
orders.parallelStream()
      .forEach(o -> unsafe.add(o.id()));      // DATA RACE: ArrayList is not
                                              // thread-safe. Parallelism was
                                              // handled; synchronisation was not.
```

**Key takeaways**

- Implicit threading lets the programmer express parallelisable work and leaves thread management to the runtime.
- OpenMP, GCD, fork-join frameworks, parallel streams, and async/await are the common realisations.
- It adapts to the machine at run time and removes a large class of thread-management bugs.
- It manages parallelism but not synchronisation: shared mutable state still races and remains the programmer's responsibility.

> 🧪 Practice
>
> 1. Write a serial loop summing a large array, then parallelise it with OpenMP. Measure speed-up against core count.
> 2. Remove `reduction(+:total)` from the example and explain the wrong results you get.
> 3. Interview-style: "When is `parallelStream()` slower than `stream()`?" *Hint: consider small collections, splitting cost, and whether the operation is genuinely independent.*

#### Fork-Join Parallelism

**Theory**

**Fork-join** is a structured pattern for parallelising problems that decompose recursively. A task examines its input: if it is small enough, it computes the answer directly; otherwise it splits the input, **forks** subtasks to handle the pieces, and **joins** them to combine the results. Divide and conquer, with the divisions running in parallel.

The structure has a valuable property: **parallelism follows the natural recursion of the algorithm**, so merge sort, quicksort, tree traversal, matrix multiplication, and prefix sums parallelise almost mechanically. Forks and joins nest properly, so the parallel structure mirrors the call structure and is easy to reason about.

The implementation technique that makes it efficient is **work stealing**. Each worker keeps a double-ended queue of tasks. It pushes and pops its own tasks from one end (giving good locality — the most recently created task is likely cache-hot), and when it runs out, it *steals* from the opposite end of a random victim's queue (taking the oldest, largest task, which minimises stealing frequency). The result is automatic load balancing with very little contention, which is why Java's `ForkJoinPool`, `.NET`'s TPL, Cilk, and Intel TBB all use it.

The one parameter that decides performance is the **sequential threshold**: the size below which a task computes directly instead of splitting. Too high and there are too few tasks to balance across cores; too low and task-management overhead swamps the actual work. A rule of thumb is to aim for tasks in the range of 10,000 instructions and to produce perhaps 10-100 tasks per core.

Two idioms matter for correctness and speed: **fork one side and compute the other in the current thread** (avoids creating a task just to wait on it), and **join in reverse order of forking** (the most recently forked task is likely still on the local queue and cheapest to complete).

**Example**

```text
   Fork-join on sum(array[0..8])

                        sum[0..8]
                       /         \
              fork    /           \    fork
                sum[0..4]      sum[4..8]
                 /     \         /     \
           sum[0..2] sum[2..4] sum[4..6] sum[6..8]
              |         |         |         |
           (below threshold: compute directly, sequentially)
              \         /         \         /
               join    /           join    /
                sum[0..4]      sum[4..8]
                       \         /
                        join
                        sum[0..8]

   Work stealing

   worker A deque: [t1][t2][t3][t4]      A pops from the BOTTOM (cache-hot)
                    ^                    thieves steal from the TOP (oldest,
                    |                    biggest task -> fewer steals needed)
   worker B (idle) --+ steal
```

```java
import java.util.concurrent.RecursiveTask;
import java.util.concurrent.ForkJoinPool;

class SumTask extends RecursiveTask<Long> {
    private static final int THRESHOLD = 10_000;   // the tuning knob
    private final long[] data;
    private final int lo, hi;

    SumTask(long[] data, int lo, int hi) { this.data = data; this.lo = lo; this.hi = hi; }

    @Override protected Long compute() {
        if (hi - lo <= THRESHOLD) {                // small enough: do it here
            long sum = 0;
            for (int i = lo; i < hi; i++) sum += data[i];
            return sum;
        }
        int mid = lo + (hi - lo) / 2;
        SumTask left = new SumTask(data, lo, mid);
        left.fork();                               // hand the LEFT half to the pool
        long right = new SumTask(data, mid, hi).compute();  // do the RIGHT half here
                                                   // (never fork both and wait --
                                                   // this thread would idle)
        return right + left.join();                // join the forked one last
    }
}

long[] data = new long[100_000_000];
ForkJoinPool pool = ForkJoinPool.commonPool();     // sized to cores by default
long total = pool.invoke(new SumTask(data, 0, data.length));
```

**Key takeaways**

- Fork-join splits a problem recursively, runs the pieces in parallel, and combines the results.
- It suits any divide-and-conquer algorithm, and its parallel structure mirrors the recursion.
- Work-stealing deques give automatic load balancing with low contention and good locality.
- The sequential threshold governs performance: too small drowns in overhead, too large starves cores.

> 🧪 Practice
>
> 1. Implement parallel merge sort with fork-join and compare it with the sequential version on 10 million elements.
> 2. Vary `THRESHOLD` across 100, 10,000, and 1,000,000 and plot the runtime. Explain both ends of the curve.
> 3. Interview-style: "Why compute one half in the current thread instead of forking both?" *Hint: count the threads doing useful work in each version while the subtasks run.*

#### Thread Cancellation

**Theory**

Sometimes a running thread's work becomes unnecessary — a user cancels a search, one of several parallel queries returns first, or the process is shutting down. **Thread cancellation** is terminating a thread before it finishes on its own, and it is one of the hardest things to do correctly in concurrent programming.

The difficulty is that a thread stopped at an arbitrary point may hold a lock, own a half-updated data structure, or be responsible for freeing a buffer. Killing it there leaves the process permanently broken. Two approaches exist:

- **Asynchronous cancellation** terminates the target immediately. It is fast and almost always wrong: locks stay held, memory leaks, invariants break. Java deprecated `Thread.stop()` for precisely this reason.
- **Deferred cancellation** marks the thread as cancellation-requested; the thread checks periodically at **cancellation points** and exits cleanly at a safe place, releasing what it holds. This is the default in pthreads and the only responsible option.

In pthreads, cancellation points are functions where the thread may be cancelled — most blocking calls (`read`, `write`, `sleep`, `pthread_cond_wait`), plus an explicit `pthread_testcancel()` for compute loops with no blocking calls. Cleanup handlers pushed with `pthread_cleanup_push` run on cancellation, giving a chance to unlock mutexes and free resources.

Most higher-level environments avoid the mechanism entirely and use **cooperative cancellation**: a shared flag or token that the worker checks. Java uses interruption (`Thread.interrupt()` sets a flag and wakes blocking calls with `InterruptedException`); Go uses `context.Context` cancellation checked via a channel; .NET uses `CancellationToken`. All are the same idea: request, do not command.

The universal rules are worth stating plainly: **never kill a thread that holds a lock**; **always give the thread a chance to clean up**; and **check for cancellation often enough to be responsive but not so often that it costs measurable time**.

Analogy: cancellation is asking a surgeon to stop, not switching off the lights in the operating theatre. They must close what they have opened before leaving.

**Example**

```text
   ASYNCHRONOUS                      DEFERRED / COOPERATIVE

   kill the thread now               set "please stop"
        |                                 |
   thread dies mid-operation          thread notices at a safe point
        |                                 |
   mutex still LOCKED                 releases the mutex
   buffer leaked                      frees the buffer
   invariant broken                   leaves data consistent
   -> process is now broken           -> clean exit

   Where a cooperative check belongs:

   while (!cancelled) {          <- check between units of work,
       process_one_item();          not in the middle of one
   }
```

```c
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

void cleanup(void *arg) {
    printf("cleanup: releasing resources held by this thread\n");
    pthread_mutex_unlock((pthread_mutex_t *)arg);   /* the lock MUST be released */
}

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *worker(void *arg) {
    pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);  /* the safe default */

    pthread_mutex_lock(&lock);
    pthread_cleanup_push(cleanup, &lock);   /* runs if cancelled below */

    for (int i = 0; i < 1000000; i++) {
        do_one_unit_of_work(i);
        pthread_testcancel();               /* an explicit cancellation point:
                                               a pure compute loop has none  */
    }

    pthread_cleanup_pop(1);                 /* 1 = also run it on normal exit */
    return NULL;
}
```

```go
// The modern idiom: cancellation as a value the callee checks.
func worker(ctx context.Context, items []Item) error {
    for _, item := range items {
        select {
        case <-ctx.Done():          // cancellation requested
            return ctx.Err()        // return cleanly; defers still run
        default:
        }
        if err := process(item); err != nil {   // one whole unit of work,
            return err                          // never interrupted midway
        }
    }
    return nil
}

ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
defer cancel()                      // always release the context
```

**Key takeaways**

- Asynchronous cancellation stops a thread immediately and typically leaves locks held and invariants broken.
- Deferred cancellation sets a request that the thread honours at safe cancellation points.
- Cleanup handlers (or `defer`/`finally`) must release locks and resources on the cancellation path.
- Modern APIs use cooperative tokens — interruption, `context.Context`, `CancellationToken` — which are requests, not commands.

> 🧪 Practice
>
> 1. Write a thread that acquires a mutex and is cancelled asynchronously without a cleanup handler. Show that another thread then deadlocks.
> 2. Convert a long compute loop to support cooperative cancellation, and measure the cost of checking every iteration versus every 1,000.
> 3. Interview-style: "Why was `Thread.stop()` deprecated in Java?" *Hint: think about a monitor held during an update to a shared collection.*

#### Thread-Local Storage

**Theory**

Threads share everything by default, which is usually what you want and occasionally exactly what you do not. Some state is conceptually *per-thread*: a request ID for logging, a database connection, a random number generator's seed, a scratch buffer, a transaction context. Passing it explicitly through every function signature pollutes the code; making it global creates a race.

**Thread-local storage** (TLS) solves this: one declared variable, but each thread gets its own independent instance. Syntactically it looks like a global; semantically it behaves like a per-thread variable that persists across function calls within a thread.

The mechanism is straightforward — the TCB holds a pointer to a per-thread block, and accessing a TLS variable indexes off that pointer — which is why access is nearly as fast as a normal global (typically one extra register-relative indirection).

The canonical uses:

- **Context propagation without plumbing**: a request or trace ID available to every logging call in the call stack.
- **Per-thread caches and buffers**: a scratch buffer reused across calls, avoiding both allocation and contention.
- **Making non-reentrant APIs safe**: `errno` is thread-local for exactly this reason; so is `strtok_r`'s explicit state, and the reason `strtok` itself is not thread-safe.
- **Per-thread connections**: one database connection per worker thread, avoiding a shared pool lock.

The hazards are real and worth respecting. TLS is **hidden state**: functions depend on values not visible in their signatures, which makes reasoning and testing harder. It **interacts badly with thread pools**, because a pooled thread outlives the task that set the value — failing to clear TLS at task boundaries leaks one request's context into the next, a genuine correctness and security bug. And it is **incompatible with task-based runtimes** where a task may migrate between threads mid-execution: a coroutine that suspends and resumes on a different thread sees different TLS. This is why Java added `ScopedValue` and why Go deliberately has no goroutine-local storage, recommending explicit `context.Context` instead.

**Example**

```text
   ONE DECLARATION, N INSTANCES

   __thread int counter;          declared once

   thread 1 TLS block: counter = 5
   thread 2 TLS block: counter = 99      independent storage
   thread 3 TLS block: counter = 0

   Access path:

   TCB -> tls_pointer -> [ counter | request_id | buffer ... ]
                            ^
                            one indirection: nearly as fast as a global

   The thread-pool hazard:

   task A runs on worker 3, sets request_id = "abc"
   task A finishes; worker 3 is REUSED
   task B runs on worker 3, logs before setting anything
        -> logs "abc"    <- another request's identity. Clear TLS at boundaries.
```

```c
#include <stdio.h>
#include <pthread.h>

/* C11 / GCC thread-local: one declaration, one instance per thread. */
static __thread int  call_count = 0;
static __thread char scratch[256];      /* a per-thread buffer: no contention,
                                           no allocation per call */

void do_work(void) {
    call_count++;                       /* no lock needed: nobody else can see it */
    snprintf(scratch, sizeof scratch, "thread work #%d", call_count);
}

void *worker(void *arg) {
    for (int i = 0; i < 3; i++) do_work();
    printf("thread %ld: call_count=%d (%s)\n", (long)arg, call_count, scratch);
    return NULL;                        /* each thread prints 3, never 6 or 9 */
}

int main(void) {
    pthread_t t[3];
    for (long i = 0; i < 3; i++) pthread_create(&t[i], NULL, worker, (void *)i);
    for (int i = 0; i < 3; i++) pthread_join(t[i], NULL);
    return 0;
}
```

```java
// The pooled-thread trap, and the fix.
public class RequestContext {
    private static final ThreadLocal<String> REQUEST_ID = new ThreadLocal<>();

    public static void handle(Request req) {
        REQUEST_ID.set(req.id());
        try {
            process(req);          // every logging call downstream can read it
                                   // without it appearing in any signature
        } finally {
            REQUEST_ID.remove();   // MANDATORY in a pool: the thread is reused,
                                   // and a stale value leaks into the next task
        }
    }
}
```

**Key takeaways**

- Thread-local storage gives each thread its own instance of a variable that is declared once.
- It is used for context propagation, per-thread caches and connections, and making non-reentrant APIs safe.
- Access costs roughly one extra indirection through the thread's TLS block.
- In thread pools, always clear thread-locals at task boundaries; in task-based runtimes that migrate work between threads, prefer explicit context objects.

> 🧪 Practice
>
> 1. Run the C example and explain why each thread prints 3. Remove `__thread` and explain the new output.
> 2. Demonstrate the pool leak: set a `ThreadLocal` in one pooled task, omit `remove()`, and read it from a later task on the same worker.
> 3. Interview-style: "Why does Go provide no goroutine-local storage?" *Hint: consider how many goroutines exist, and what happens when work migrates between OS threads.*

---

<a id="4-cpu-scheduling"></a>
## 4. CPU Scheduling

Whenever more threads are runnable than there are cores, something must decide who runs next — and that decision, made thousands of times a second, determines whether a machine feels responsive, completes batch work quickly, or meets a hard deadline. This chapter builds the vocabulary for judging schedulers, works through the classical algorithms and their trade-offs, extends them to multiprocessors and real-time systems, and ends with how the decisions are evaluated and what production kernels actually do. Scheduling is where the abstractions of Chapters 2 and 3 meet the finite reality of the hardware.

<a id="41-scheduling-foundations"></a>
### 4.1 Scheduling Foundations

Before comparing algorithms, we need to know what workloads look like, when scheduling decisions may be taken, what performs the switch, and which metrics distinguish a good decision from a bad one.

#### CPU-I/O Burst Cycle

**Theory**

Scheduling would be uninteresting if programs simply computed from start to finish. They do not. Process execution consists of an alternating **cycle**: a stretch of computation (a **CPU burst**), then a request for I/O that blocks the process (an **I/O burst**), then more computation, and so on until a final CPU burst ends with termination.

This structure is what makes scheduling both necessary and possible. Necessary, because when a process blocks, the CPU must be given to someone else or it idles. Possible, because bursts are short and frequent enough that the scheduler gets regular opportunities to intervene.

The empirically observed distribution of CPU burst lengths is the single most important fact in this chapter: it is **exponential or hyperexponential** — a very large number of very short bursts, and a small number of long ones. Most bursts are under 8 milliseconds. This shape justifies several algorithm choices later: it is why favouring short jobs works so well, why round-robin quanta are set in the low tens of milliseconds, and why a process's recent behaviour predicts its next burst.

Processes are classified by which burst dominates:

| | **I/O-bound** | **CPU-bound** |
|---|---|---|
| Bursts | Many short CPU bursts | Few long CPU bursts |
| Time spent | Mostly blocked waiting | Mostly computing |
| Examples | Shells, editors, web servers, databases | Compilers, video encoding, simulation |
| Wants | Low latency — to be run promptly when ready | Throughput — long uninterrupted stretches |
| Effect if delayed | Device sits idle; user perceives lag | Finishes later, nobody notices immediately |

A good scheduler needs a **balanced mix** in the ready queue. If every process is CPU-bound, devices idle; if every process is I/O-bound, the CPU idles. And the classes want opposite things, which is the central tension every algorithm in 4.2 tries to resolve.

Analogy: a CPU burst is a stretch of focused desk work; an I/O burst is waiting for a colleague to reply to an email. Most desk stretches are short, and a manager assigning work must know that some people mostly wait while others mostly type.

**Example**

```text
   Execution as alternating bursts

   process: [CPU 6ms][--- I/O 40ms ---][CPU 2ms][-- I/O 25ms --][CPU 4ms] exit
             ^                          ^                        ^
             scheduler gets control at every one of these boundaries

   Burst length distribution (measured, and remarkably stable across systems)

   frequency
     |*
     |**
     |***
     |*****
     |*******
     |**********
     |***************
     |**********************
     +--------------------------------------> burst length (ms)
      0   2   4   6   8  10  12  14  16 ...

   Most bursts are SHORT. This one fact drives most scheduler design.

   Two process shapes

   I/O-bound:  [CPU][-----I/O-----][CPU][-----I/O-----][CPU][---I/O---]
   CPU-bound:  [========== CPU ==========][I/O][========== CPU =======]
```

```python
# Why a mixed workload keeps both the CPU and the devices busy.
def simulate(processes, total_ms=1000):
    """processes: list of (cpu_burst_ms, io_burst_ms)"""
    cpu_busy = io_busy = 0
    for cpu, io in processes:
        cycle = cpu + io                      # one full CPU+I/O cycle
        cycles = total_ms / cycle
        cpu_busy += cycles * cpu              # demand this process places on the CPU
        io_busy  += cycles * io               # demand it places on devices
    return cpu_busy / total_ms, io_busy / total_ms

# All I/O-bound: devices saturated, CPU nearly idle.
print(simulate([(2, 40)] * 8))     # cpu ~0.38, io ~7.6 (devices oversubscribed)

# All CPU-bound: CPU saturated, devices idle.
print(simulate([(100, 5)] * 4))    # cpu ~3.8, io ~0.19

# Mixed: both resources meaningfully used.
print(simulate([(2, 40)] * 4 + [(100, 5)] * 2))
```

**Key takeaways**

- Execution alternates between CPU bursts and I/O bursts; every transition is a scheduling opportunity.
- CPU burst lengths follow an exponential distribution: very many short bursts, few long ones.
- I/O-bound processes want low latency; CPU-bound processes want long uninterrupted runs.
- A healthy system needs a mix of both so that neither the CPU nor the devices sit idle.

> 🧪 Practice
>
> 1. Classify these as CPU- or I/O-bound and justify each: `grep` over a large directory, video transcoding, an SSH session, a nightly report generator.
> 2. Instrument a program to print timestamps around each `read()` and each compute section. Plot the burst distribution and compare with the shape above.
> 3. Interview-style: "Why does knowing bursts are mostly short make favouring short jobs a good policy?" *Hint: think about how much a long job delays a short one versus the reverse.*

#### Preemptive vs Non-Preemptive Scheduling

**Theory**

A scheduling decision is required whenever the CPU becomes available. There are exactly four circumstances in which that happens:

1. A running process **blocks** (requests I/O, waits on a child).
2. A running process **terminates**.
3. A running process is **interrupted** and becomes ready again (typically a timer expiry).
4. A **blocked process becomes ready** (an I/O completed), possibly outranking the running one.

Cases 1 and 2 are unavoidable — the running process has given up the CPU by itself. A scheduler that acts *only* on those is **non-preemptive** (or cooperative): once a process has the CPU, it keeps it until it blocks or exits.

A scheduler that also acts on cases 3 and 4 is **preemptive**: it can take the CPU away from a process that is willing and able to continue.

The differences are consequential:

| | **Non-preemptive** | **Preemptive** |
|---|---|---|
| CPU taken away | Never; only voluntary release | Yes, at timer ticks or on higher-priority wakeup |
| Response time | Unbounded — one long job blocks everyone | Bounded by the quantum |
| Implementation | Simple; no timer needed | Needs a timer interrupt and careful locking |
| Kernel data races | Few — a process runs to a safe point | Many — must protect shared structures |
| A buggy infinite loop | Hangs the system | Is merely a CPU hog |
| Used by | Early Windows/Mac, some embedded and RTOS designs, coroutines | Every general-purpose OS today |

Preemption is what makes time-sharing possible (Chapter 1), and it is not free: the kernel itself becomes concurrent. If a process is preempted while executing a system call that is halfway through modifying a kernel data structure, the structure must not be observed in that state. Early UNIX solved this by simply not preempting kernel code — a system call ran to completion or to a voluntary sleep. Modern kernels are **preemptible** (Linux's `CONFIG_PREEMPT`), using explicit locking to protect critical sections, which lowers latency at the cost of considerable complexity.

Analogy: non-preemptive scheduling is a meeting where each speaker talks until finished; preemptive scheduling is a meeting with a chairperson and a timer. The second is fairer and more responsive, and requires someone with authority to interrupt.

**Example**

```text
   The four decision points

   1. RUNNING -> BLOCKED     (I/O request)        non-preemptive too
   2. RUNNING -> TERMINATED  (exit)               non-preemptive too
   3. RUNNING -> READY       (timer preemption)   PREEMPTIVE ONLY
   4. BLOCKED -> READY       (I/O completion)     PREEMPTIVE ONLY (may preempt)

   Same workload, both disciplines
   P1 arrives t=0, burst 20ms   P2 arrives t=2, burst 3ms (interactive)

   NON-PREEMPTIVE
   |============== P1 (20ms) ==============|== P2 ==|
   0                                       20       23
   P2 response time: 18ms   -- it waited for a job it should have jumped

   PREEMPTIVE (quantum 5ms)
   |= P1 =|= P2 =|===== P1 ==================|
   0      5      8                           23
   P2 response time: 3ms    -- bounded by the quantum, not by P1's length
```

```python
# The distinction expressed as one branch in the scheduler.
class Scheduler:
    def __init__(self, preemptive):
        self.preemptive = preemptive
        self.running = None
        self.ready = []

    def on_wakeup(self, proc):
        """A blocked process became ready (decision point 4)."""
        self.ready.append(proc)
        if self.preemptive and self.running and proc.priority > self.running.priority:
            self.preempt()        # take the CPU away from a willing runner
        # non-preemptive: the woken process simply waits its turn

    def on_timer_tick(self):
        """Decision point 3 -- exists only under preemption."""
        if not self.preemptive:
            return                # a non-preemptive scheduler ignores the timer
        self.running.ticks += 1
        if self.running.ticks >= QUANTUM:
            self.preempt()

    def on_block_or_exit(self):
        """Decision points 1 and 2 -- both disciplines must handle these."""
        self.dispatch(self.pick_next())
```

**Key takeaways**

- Scheduling decisions arise at four points; non-preemptive schedulers act only on blocking and termination.
- Preemption bounds response time and is required for time-sharing and for enforcing priorities.
- Preemption makes the kernel concurrent, requiring locks around shared kernel data structures.
- Under non-preemptive scheduling one long or looping process can monopolise or hang the system.

> 🧪 Practice
>
> 1. Give two systems where non-preemptive scheduling is a defensible choice, with reasons.
> 2. Work out both Gantt charts for: P1 (t=0, 10ms), P2 (t=1, 2ms), P3 (t=2, 2ms), preemptive vs non-preemptive with a 4ms quantum. Compare average response times.
> 3. Interview-style: "Why does preemption force the kernel to use locks it did not previously need?" *Hint: consider a system call interrupted halfway through updating the ready queue.*

#### Dispatcher and Dispatch Latency

**Theory**

It is worth separating two components that are often conflated. The **scheduler** decides *which* process runs next — it is policy. The **dispatcher** actually *makes it run* — it is mechanism. The separation matters because they are tuned independently: the scheduler is chosen for fairness or throughput, while the dispatcher is optimised purely for speed.

The dispatcher performs three steps:

1. **Context switch** — save the outgoing process's registers into its PCB and load the incoming one's (Chapter 2).
2. **Switch to user mode** — the incoming process must not resume with kernel privilege.
3. **Jump to the resume point** — restore the saved program counter so execution continues exactly where it stopped.

**Dispatch latency** is the time from the decision to stop one process until the next one is actually executing. Since it happens on every switch — thousands of times a second — it must be measured in microseconds, and it is pure overhead: no user work occurs during it.

For real-time systems a more demanding quantity matters: the total delay from an event (an interrupt signalling that a high-priority task should run) until that task executes. It has two parts:

- **Conflict phase** — preempting whatever is running, and releasing any resources the high-priority task needs. If the kernel is executing a non-preemptible section, this waits.
- **Dispatch phase** — the actual switch.

The conflict phase is the problematic one, because a long non-preemptible kernel path can delay an urgent task for milliseconds. This is the entire reason real-time kernels invest in **preemption points** or fully preemptible designs, and why `PREEMPT_RT` exists for Linux: not to make throughput better, but to bound the worst-case conflict phase.

Analogy: the scheduler is the manager deciding who works next; the dispatcher is the act of physically clearing the desk and seating the next person. Dispatch latency is how long the desk stands empty — and if the previous occupant is in the middle of something they cannot abandon, the wait is longer still.

**Example**

```text
   Scheduler vs dispatcher

   [ SCHEDULER ]  policy: which one?          -> returns a PCB pointer
        |
        v
   [ DISPATCHER ] mechanism: make it run      -> context switch, user mode, jump

   Dispatch latency, decomposed

   event (interrupt: high-priority task is ready)
     |
     |<---------------- response time ----------------->|
     |                                                   |
     |<--- conflict phase --->|<-- dispatch -->|
     |                        |                |
     | preempt the running    | context switch | high-priority task
     | process; release       | + mode switch  | starts executing
     | resources it holds     |                |
     |                        |                |
     | THE PROBLEM: if the kernel is in a non-preemptible
     | section, this phase can stretch to milliseconds

   Typical magnitudes
     dispatch (switch)      : 1-5 us
     conflict, normal kernel: 0-100+ us  (unbounded in the worst case)
     conflict, PREEMPT_RT   : bounded, tens of us
```

```c
/* Policy and mechanism, deliberately separated. */

/* SCHEDULER: pure policy. Swappable without touching the dispatcher. */
struct pcb *schedule(void) {
    return pick_highest_priority(&ready_queue);   /* or CFS, or round robin */
}

/* DISPATCHER: pure mechanism. Identical whatever the policy is. */
void dispatch(struct pcb *next) {
    struct pcb *prev = current;

    save_context(&prev->ctx);            /* 1. freeze the outgoing process   */
    if (prev->page_table != next->page_table)
        load_page_table(next->page_table);

    current = next;
    next->state = RUNNING;

    restore_context(&next->ctx);         /* 2. load the incoming registers   */
    return_to_user_mode(next->ctx.rip);  /* 3. drop privilege and jump       */
}
```

```bash
# Measure the real thing on Linux.
cyclictest -t1 -p 99 -i 1000 -l 10000   # worst-case wake-up latency (rt-tests)
perf sched latency --sort max            # per-task scheduling delay
grep PREEMPT /boot/config-$(uname -r)    # which preemption model is compiled in
```

**Key takeaways**

- The scheduler chooses (policy); the dispatcher performs the switch (mechanism).
- Dispatch latency is pure overhead incurred on every switch and must stay in the microsecond range.
- Real-time response time splits into a conflict phase and a dispatch phase.
- The conflict phase dominates the worst case, which is why real-time kernels make kernel code preemptible.

> 🧪 Practice
>
> 1. Explain why separating scheduler from dispatcher makes it possible to change scheduling policy without touching the context-switch code.
> 2. Run `cyclictest` on an idle machine and again under heavy disk load. Explain the difference in maximum latency.
> 3. Interview-style: "A real-time task must react within 100 microseconds. Which phase would you attack first, and how?" *Hint: measure both phases separately before optimising either.*

#### Scheduling Criteria

**Theory**

"Better scheduler" is meaningless without saying better at what. There are five standard metrics, and the essential insight is that **they conflict** — improving one usually degrades another, so a scheduler is a choice of which to favour.

| Metric | Definition | Direction | Who cares |
|---|---|---|---|
| **CPU utilisation** | Fraction of time the CPU does useful work | Maximise | System owners |
| **Throughput** | Processes completed per unit time | Maximise | Batch and server operators |
| **Turnaround time** | Submission to completion (total elapsed) | Minimise | Batch users |
| **Waiting time** | Total time spent in the ready queue | Minimise | The scheduler's true lever |
| **Response time** | Submission to *first* output/execution | Minimise | Interactive users |

Two distinctions repay attention:

- **Waiting time is the metric a scheduler actually controls.** Turnaround time includes the process's own CPU and I/O time, which no scheduling policy can shorten. Scheduling only changes how long a process sits in the ready queue.
- **Response time is not turnaround time.** An editor that shows your keystroke in 10 ms and finishes saving in 3 seconds has excellent response time and mediocre turnaround. For interactive work, response time is the metric users perceive.

Beyond averages, two further criteria matter in practice and are routinely underweighted in textbooks:

- **Variance/predictability.** A system with 100 ms average response time and 2-second outliers feels worse than one with a steady 150 ms. Users notice the tail, not the mean, which is why production systems track p95 and p99 rather than averages.
- **Fairness and starvation-freedom.** A policy that optimises average waiting time may indefinitely postpone some process. Any usable scheduler must guarantee eventual progress.

The conflicts are direct. Maximising throughput favours short jobs, which starves long ones. Minimising response time means short quanta, which raises switching overhead and lowers throughput. Guaranteeing fairness prevents the reordering that would lower average waiting time. There is no optimum, only a chosen trade-off.

**Example**

```text
   The five metrics on one timeline

   P submitted     P first runs         P completes
        |               |                     |
        |<-- response ->|                     |
        |                                     |
        |<----------- turnaround ------------>|
        |                                     |
        waiting = turnaround - (CPU time + I/O time)
                = total time spent sitting in the ready queue

   Worked example: P arrives t=0, needs 5ms CPU, first runs at t=3, ends at t=12
     response   = 3 - 0  = 3ms
     turnaround = 12 - 0 = 12ms
     waiting    = 12 - 5 = 7ms   (if it did no I/O)

   Why averages mislead

   Scheduler A: 100, 100, 100, 100, 100         avg 100, p99 100
   Scheduler B:  10,  10,  10,  10, 460         avg 100, p99 460
   Identical averages. B is the one users complain about.
```

```python
def metrics(procs):
    """procs: list of dicts with arrival, burst, start, finish."""
    rows = []
    for p in procs:
        turnaround = p["finish"] - p["arrival"]
        waiting    = turnaround - p["burst"]     # what scheduling controls
        response   = p["start"]  - p["arrival"]  # what users perceive
        rows.append((p["name"], turnaround, waiting, response))

    n = len(rows)
    print(f"{'proc':6}{'turn':>7}{'wait':>7}{'resp':>7}")
    for name, t, w, r in rows:
        print(f"{name:6}{t:7}{w:7}{r:7}")
    print(f"{'avg':6}{sum(r[1] for r in rows)/n:7.1f}"
          f"{sum(r[2] for r in rows)/n:7.1f}{sum(r[3] for r in rows)/n:7.1f}")

    # Always look at the tail, not only the mean.
    waits = sorted(r[2] for r in rows)
    print("p95 waiting:", waits[int(0.95 * (n - 1))])

metrics([
    {"name": "P1", "arrival": 0, "burst": 24, "start": 0,  "finish": 24},
    {"name": "P2", "arrival": 0, "burst": 3,  "start": 24, "finish": 27},
    {"name": "P3", "arrival": 0, "burst": 3,  "start": 27, "finish": 30},
])
```

**Key takeaways**

- The five standard criteria are utilisation, throughput, turnaround, waiting, and response time.
- Waiting time is what a scheduler actually controls; turnaround includes work no policy can shorten.
- Response time — time to first execution — is what interactive users perceive.
- The criteria conflict, and variance plus starvation-freedom matter as much as averages in real systems.

> 🧪 Practice
>
> 1. For P1 (arrives 0, burst 8, starts 0, ends 8) and P2 (arrives 1, burst 4, starts 8, ends 12), compute all three per-process metrics by hand.
> 2. Construct two schedules of the same three jobs where one wins on average waiting time and the other on maximum waiting time. State which you would ship.
> 3. Interview-style: "Which metric would you optimise for a video game, a payroll batch run, and a web API?" *Hint: ask who is waiting and whether they are watching.*

<a id="42-scheduling-algorithms"></a>
### 4.2 Scheduling Algorithms

Each algorithm below is an answer to "who runs next", and each is best understood by the specific failure of its predecessor that it was designed to fix.

#### First-Come First-Served

**Theory**

**FCFS** is the simplest possible policy: processes run in arrival order, and each runs to completion (or until it blocks). It is a plain FIFO queue — a new process joins the tail, the dispatcher takes from the head.

Its virtues are simplicity, obvious fairness in the queueing sense, and freedom from starvation: every process eventually reaches the head. It is trivially implementable and has essentially zero scheduling overhead.

Its defect is severe and has a name: the **convoy effect**. When one long CPU-bound process holds the CPU, every short process queues behind it. Worse, the I/O-bound processes that were waiting behind it now rush to the devices simultaneously, then all finish and queue up behind the long job again — so both the CPU and the devices are alternately idle while a convoy of short jobs trails one slow one. Average waiting time becomes both high and extremely sensitive to arrival order.

The order-sensitivity is the memorable part: the *same* three processes can have an average waiting time of 17 or of 3, depending purely on which arrives first. No other classical algorithm is this fragile.

FCFS is non-preemptive by nature, which makes it unusable as a general-purpose policy — a single infinite loop hangs the system. It survives as a component inside other schedulers (as the tie-break within one priority level) and in batch systems where turnaround matters more than response.

Analogy: a single supermarket checkout with no express lane. Someone with a full trolley arrives first and everyone behind them waits, however small their basket.

**Example**

```text
   Same processes, arrival order P1, P2, P3
   P1 burst 24, P2 burst 3, P3 burst 3 (all arrive at t=0)

   |============ P1 (24) ============|= P2 =|= P3 =|
   0                                 24     27     30

   waiting:  P1 = 0    P2 = 24    P3 = 27      average = 17.0

   Reverse the arrival order: P2, P3, P1

   |= P2 =|= P3 =|============ P1 (24) ============|
   0      3      6                                 30

   waiting:  P2 = 0    P3 = 3    P1 = 6            average = 3.0

   Identical work. Average waiting time differs by 5.7x.

   The convoy effect

   CPU:    [========== long job ==========][s][s][s][s]
   disk:   idle .......................... then a burst of contention
           devices starve, then are slammed, then starve again
```

```python
def fcfs(processes):
    """processes: list of (name, arrival, burst), scheduled in arrival order."""
    procs = sorted(processes, key=lambda p: p[1])   # ties broken by input order
    clock, results = 0, []

    for name, arrival, burst in procs:
        start = max(clock, arrival)      # the CPU may be idle waiting for arrival
        finish = start + burst           # run to completion: no preemption
        results.append({
            "name": name,
            "waiting": start - arrival,          # time sitting in the queue
            "turnaround": finish - arrival,
        })
        clock = finish

    avg = sum(r["waiting"] for r in results) / len(results)
    return results, avg

print(fcfs([("P1", 0, 24), ("P2", 0, 3), ("P3", 0, 3)])[1])   # 17.0
print(fcfs([("P2", 0, 3), ("P3", 0, 3), ("P1", 0, 24)])[1])   # 3.0
```

**Key takeaways**

- FCFS runs processes in arrival order to completion — a plain FIFO queue with no overhead.
- It is starvation-free and trivially simple, but non-preemptive and therefore unusable alone.
- The convoy effect makes one long job delay every short job behind it and idles the devices.
- Average waiting time depends heavily on arrival order, which no other classical algorithm suffers as badly.

> 🧪 Practice
>
> 1. Compute the average waiting and turnaround times for P1 (0, 10), P2 (2, 5), P3 (4, 2) under FCFS.
> 2. Construct an arrival order for those three that minimises average waiting time, and one that maximises it.
> 3. Interview-style: "Where is FCFS still the right choice inside a modern scheduler?" *Hint: think about what happens between two threads of identical priority.*

#### Shortest Job First

**Theory**

FCFS's problem is that a long job can precede short ones. **Shortest Job First** fixes it directly: when the CPU is free, run the process with the smallest *next CPU burst*.

SJF is **provably optimal** for average waiting time. The proof is an exchange argument: given any schedule where a longer job precedes a shorter one, swapping them reduces total waiting time, because the swap delays the long job by the short job's (small) burst while advancing the short job by the long job's (large) burst. Repeating until no such pair exists yields SJF. No algorithm can do better on this metric.

Two problems keep it from being directly usable:

- **Burst lengths are not known in advance.** Except in batch systems where users supply an estimate, the scheduler cannot know how long the next burst will be. It must be **predicted**, and the standard method is an exponential moving average over previous bursts: `tau(n+1) = alpha * t(n) + (1 - alpha) * tau(n)`, where `t(n)` is the most recent actual burst. With `alpha = 0.5`, recent history and accumulated history are weighted equally; `alpha = 0` ignores recent behaviour entirely and `alpha = 1` uses only the last burst. This works because bursts are strongly autocorrelated — a process that has been interactive tends to stay interactive.
- **Starvation.** A steady stream of short jobs can postpone a long job indefinitely. The standard remedy is **aging**: gradually improving the effective priority of a job as it waits.

SJF is non-preemptive in its basic form: a newly arrived short job waits for the running one to finish. The preemptive variant is the subject of the next topic.

Analogy: a supermarket express lane taken to its logical extreme — always serve whoever has the fewest items. Total waiting across all customers is minimised, and the person with the full trolley may never be served.

**Example**

```text
   P1 burst 6, P2 burst 8, P3 burst 7, P4 burst 3 (all arrive t=0)

   SJF order: P4(3), P1(6), P3(7), P2(8)

   |= P4 =|=== P1 ===|==== P3 ====|===== P2 =====|
   0      3          9            16             24

   waiting:  P4 = 0   P1 = 3   P3 = 9   P2 = 16    average = 7.0
   (FCFS on the same set in the order P1..P4 gives 10.25 -- SJF is optimal)

   Burst prediction by exponential averaging (alpha = 0.5)

   actual  t(n):   6    4    6    4    13   13   13
   predict tau:   10    8    6    6     5    9   11   12
                   ^                          ^
                   initial guess              adapts upward as behaviour changes
```

```python
def predict_next_burst(history, alpha=0.5, initial=10.0):
    """Exponential moving average: tau(n+1) = alpha*t(n) + (1-alpha)*tau(n)."""
    tau = initial
    predictions = [tau]
    for actual in history:
        tau = alpha * actual + (1 - alpha) * tau   # blend the newest observation
        predictions.append(tau)                    # with everything before it
    return predictions

print([round(p, 2) for p in predict_next_burst([6, 4, 6, 4, 13, 13, 13])])
# alpha=0   -> never adapts (always the initial guess)
# alpha=1   -> only the last burst matters (jumpy, over-reacts to one outlier)
# alpha=0.5 -> the usual compromise


def sjf(processes):
    """Non-preemptive SJF: pick the shortest burst among those that have arrived."""
    remaining, clock, results = list(processes), 0, []
    while remaining:
        available = [p for p in remaining if p[1] <= clock]
        if not available:                       # CPU idle until the next arrival
            clock = min(p[1] for p in remaining)
            continue
        chosen = min(available, key=lambda p: p[2])   # smallest burst wins
        name, arrival, burst = chosen
        results.append({"name": name, "waiting": clock - arrival})
        clock += burst                          # runs to completion
        remaining.remove(chosen)
    return results, sum(r["waiting"] for r in results) / len(results)
```

**Key takeaways**

- SJF selects the process with the shortest next CPU burst and is provably optimal for average waiting time.
- The next burst is unknown and must be predicted, usually by an exponential moving average over past bursts.
- Prediction works because burst lengths are autocorrelated — recent behaviour predicts near-future behaviour.
- SJF starves long jobs under a stream of short ones, which aging is introduced to fix.

> 🧪 Practice
>
> 1. Compute average waiting time for bursts 7, 4, 1, 4 (all arriving at t=0) under FCFS and under SJF.
> 2. With `alpha = 0.5` and `tau(0) = 10`, compute the next four predictions for actual bursts 8, 7, 4, 16. Then repeat with `alpha = 0.2` and comment.
> 3. Interview-style: "SJF is optimal — why does no general-purpose OS use it?" *Hint: name two things the scheduler would need to know or guarantee that it cannot.*

#### Shortest Remaining Time First

**Theory**

**SRTF** is preemptive SJF. The decision point is extended: whenever a new process arrives, compare its burst with the *remaining* time of the running process, and preempt if the newcomer is shorter.

This closes SJF's remaining gap. Under non-preemptive SJF, a 1 ms job arriving one instant after a 20 ms job starts must wait 20 ms. Under SRTF it preempts immediately and finishes in 1 ms. The result is optimal average waiting time even for dynamic arrivals — SRTF is optimal among all algorithms, preemptive or not, when burst lengths are known.

The costs are the ones preemption always brings, plus one specific to this policy:

- **More context switches**, each with its direct and cache-pollution cost. A stream of short arrivals can preempt a long job repeatedly.
- **Worse starvation than SJF.** A long job can be preempted again and again by newcomers and may never accumulate enough CPU to finish. Its remaining time shrinks only while it runs, so it never becomes competitive on its own.
- **Prediction is still required**, with the same uncertainty, now applied more aggressively.

SRTF is the theoretical benchmark against which practical schedulers are measured rather than a deployed policy. Its spirit survives in **multilevel feedback queues** (below), which approximate "favour jobs that appear short" without needing to know burst lengths, by demoting processes that consume full quanta.

**Example**

```text
   P1 arrives 0 burst 8   P2 arrives 1 burst 4
   P3 arrives 2 burst 9   P4 arrives 3 burst 5

   t=0  only P1        -> run P1
   t=1  P2 (4) vs P1 remaining (7)  -> PREEMPT, run P2
   t=2  P3 (9) vs P2 remaining (3)  -> keep P2
   t=3  P4 (5) vs P2 remaining (2)  -> keep P2
   t=5  P2 done. remaining: P1=7, P3=9, P4=5 -> run P4
   t=10 P4 done. remaining: P1=7, P3=9       -> run P1
   t=17 P1 done                              -> run P3

   |P1|== P2 ==|=== P4 ===|====== P1 ======|======== P3 ========|
   0  1        5          10               17                   26

   waiting = turnaround - burst
     P1: (17-0) - 8 = 9      P2: (5-1)  - 4 = 0
     P3: (26-2) - 9 = 15     P4: (10-3) - 5 = 2
   average = 26/4 = 6.5

   Non-preemptive SJF on the same set gives 7.75 -- preemption pays.
   Note P3, the longest job, waits the most: starvation risk is visible here.
```

```python
def srtf(processes):
    """Preemptive SJF, simulated one time unit at a time."""
    remaining = {p[0]: p[2] for p in processes}          # name -> time left
    arrival   = {p[0]: p[1] for p in processes}
    burst     = {p[0]: p[2] for p in processes}
    finish, clock, timeline = {}, 0, []

    while remaining:
        ready = [n for n in remaining if arrival[n] <= clock]
        if not ready:
            clock += 1                                   # CPU idle
            continue
        current = min(ready, key=lambda n: remaining[n])  # shortest REMAINING
        timeline.append(current)
        remaining[current] -= 1                           # run one unit, then
        clock += 1                                        # re-decide: this is
                                                          # where preemption
        if remaining[current] == 0:                       # happens implicitly
            finish[current] = clock
            del remaining[current]

    waits = {n: finish[n] - arrival[n] - burst[n] for n in finish}
    return waits, sum(waits.values()) / len(waits)

print(srtf([("P1",0,8), ("P2",1,4), ("P3",2,9), ("P4",3,5)])[1])   # 6.5
```

**Key takeaways**

- SRTF is preemptive SJF: a newly arrived shorter job takes the CPU from the running one.
- It is optimal for average waiting time among all algorithms when burst lengths are known.
- It costs many more context switches and worsens starvation for long jobs.
- It serves as a theoretical benchmark; multilevel feedback queues approximate its behaviour without prediction.

> 🧪 Practice
>
> 1. Build the Gantt chart and average waiting time for P1 (0, 7), P2 (2, 4), P3 (4, 1), P4 (5, 4) under SRTF.
> 2. Compare SJF and SRTF on the same set and count the context switches each requires.
> 3. Interview-style: "Under SRTF, can a job be starved forever? Construct the arrival pattern." *Hint: consider a long job and a short job arriving slightly faster than they complete.*

#### Priority Scheduling

**Theory**

**Priority scheduling** generalises the previous algorithms: each process carries a priority number, and the CPU goes to the highest-priority ready process. SJF is precisely priority scheduling where the priority is the inverse of the predicted burst length, and FCFS is priority scheduling where the priority is the inverse of arrival time.

Priorities come from two sources. **Internal** priorities are computed by the system from measurable quantities — memory use, I/O-to-CPU ratio, time limits. **External** priorities come from outside: who paid, which department, how important the work is deemed to be. Real systems use both.

The scheme may be preemptive (a higher-priority arrival takes the CPU immediately) or non-preemptive (it merely goes to the head of the queue).

The defining problem is **indefinite blocking**, or **starvation**: a low-priority process may never run while higher-priority work keeps arriving. The often-repeated anecdote is MIT's IBM 7094, shut down in 1973 with a low-priority job still queued from 1967 — apocryphal or not, it captures the failure exactly.

The standard remedy is **aging**: increase a process's priority the longer it waits. A job at priority 127 that gains one priority level every 15 minutes will reach priority 0 within about 32 hours, guaranteeing eventual execution. Aging converts a policy that can starve into one that merely delays.

A second problem, **priority inversion**, appears once priorities meet locks: a high-priority task waits on a lock held by a low-priority task, which is itself preempted by medium-priority tasks — so effectively the medium tasks outrank the high one. This nearly lost the Mars Pathfinder mission in 1997, and its solutions (priority inheritance and priority ceiling) are covered in Chapter 5.

**Example**

```text
   P1 burst 10 pri 3   P2 burst 1 pri 1   P3 burst 2 pri 4
   P4 burst 1 pri 5    P5 burst 5 pri 2      (lower number = higher priority)

   order: P2(1), P5(2), P1(3), P3(4), P4(5)

   |P2|== P5 ==|====== P1 ======|= P3 =|P4|
   0  1        6                16     18 19

   waiting: P2=0  P5=1  P1=6  P3=16  P4=18      average = 8.2

   Starvation and its fix

   without aging:                    with aging (+1 level per 5 time units):
   pri 10 job waits ...              t=0   pri 10
   high-priority work keeps          t=5   pri 9
   arriving ...                      t=10  pri 8
   job never runs                    ...
                                     t=50  pri 0  -> guaranteed to run

   Priority inversion (previewing Chapter 5)

   LOW  task takes lock L
   HIGH task blocks waiting for L
   MED  task preempts LOW (it outranks LOW and needs no lock)
        -> HIGH is now effectively waiting behind MED. Inverted.
```

```python
import heapq

def priority_schedule(processes, aging_interval=None):
    """processes: list of (name, arrival, burst, priority). Lower value = higher."""
    clock, done, pending = 0, [], list(processes)
    ready = []                                   # min-heap on effective priority

    while pending or ready:
        for p in [p for p in pending if p[1] <= clock]:
            heapq.heappush(ready, (p[3], p[1], p))   # (priority, arrival, proc)
            pending.remove(p)
        if not ready:
            clock = min(p[1] for p in pending)
            continue

        if aging_interval:                       # AGING: rebuild the heap with
            aged = []                            # improved priorities for those
            for pri, arr, p in ready:            # that have waited a long time
                waited = clock - arr
                effective = max(0, p[3] - waited // aging_interval)
                aged.append((effective, arr, p))
            heapq.heapify(aged)
            ready = aged

        _, _, chosen = heapq.heappop(ready)
        done.append({"name": chosen[0], "waiting": clock - chosen[1]})
        clock += chosen[2]                       # non-preemptive: run to the end
    return done, sum(d["waiting"] for d in done) / len(done)
```

**Key takeaways**

- Priority scheduling runs the highest-priority ready process; FCFS and SJF are special cases of it.
- Priorities may be internal (computed from behaviour) or external (assigned by policy or payment).
- Its characteristic failure is starvation of low-priority work, fixed by aging priorities upward over time.
- Priority inversion — a high-priority task blocked behind a lock held by a low-priority one — is a separate hazard requiring inheritance protocols.

> 🧪 Practice
>
> 1. Compute the average waiting time for P1 (burst 4, pri 3), P2 (burst 2, pri 1), P3 (burst 6, pri 2), all arriving at t=0.
> 2. Implement aging in the example and demonstrate that a priority-20 job eventually runs despite a stream of priority-1 arrivals.
> 3. Interview-style: "Describe priority inversion and how you would prevent it." *Hint: the fix temporarily changes the priority of the lock holder, not the waiter.*

#### Round Robin

**Theory**

**Round robin** is FCFS with preemption: processes are kept in a FIFO queue, and each runs for at most one **time quantum** before being preempted and moved to the tail. If a process blocks or finishes before its quantum expires, the next one starts immediately.

It is designed specifically for **response time**, and it delivers a hard guarantee: with *n* processes and quantum *q*, no process waits more than `(n - 1) x q` before running. Every process gets `1/n` of the CPU in fair shares. There is no starvation and no need to predict burst lengths — a considerable practical advantage over SJF.

The price is average waiting time, which is usually worse than SJF's because short jobs no longer jump the queue.

Everything else about round robin depends on the **quantum**, and the trade-off is worth internalising:

| Quantum | Effect |
|---|---|
| Very large | Degenerates into FCFS — the convoy effect returns |
| Very small | Excellent response, but context-switch overhead dominates and throughput collapses |
| Rule of thumb | 10-100 ms, chosen so 80% of CPU bursts complete within one quantum |

The "80% rule" ties back to 4.1: since most bursts are short, a quantum that covers most of them means most processes give up the CPU voluntarily and are never preempted at all — preemption then applies only to the genuinely long-running minority. That is exactly the behaviour you want.

A subtlety worth knowing: turnaround time is **not** monotonic in the quantum. Making the quantum larger can improve turnaround (fewer switches) or worsen it (more convoying), so it must be measured rather than reasoned about abstractly.

Analogy: a teacher giving each raised hand exactly two minutes before moving on. Nobody waits forever, everyone gets attention quickly, and the student with a genuinely long question needs many turns to finish.

**Example**

```text
   P1 burst 24, P2 burst 3, P3 burst 3, quantum = 4

   |= P1 =|= P2 =|= P3 =|= P1 =|= P1 =|= P1 =|= P1 =|= P1 =|
   0      4      7      10     14     18     22     26     30

   waiting = finish - arrival - burst
     P1 = 30 - 0 - 24 = 6      P2 = 7 - 0 - 3 = 4      P3 = 10 - 0 - 3 = 7
   average waiting = 5.67   (FCFS on the same set: 17.0)
   response time: P2 waits only 4, not 24 -- the point of the algorithm

   Quantum sensitivity, one job of 10 units, switch cost 1 unit

   q = 12 : |========== 10 =========|                overhead 0%,  = FCFS
   q = 6  : |== 6 ==|s|== 4 ==|                       overhead ~9%
   q = 1  : |1|s|1|s|1|s|1|s|1|s|1|s|1|s|1|s|1|s|1|   overhead 50%

   The 80% rule: pick q so that ~80% of CPU bursts finish inside one quantum,
   so most processes are never preempted at all.
```

```python
from collections import deque

def round_robin(processes, quantum):
    """processes: list of (name, arrival, burst)."""
    remaining = {p[0]: p[2] for p in processes}
    arrival   = {p[0]: p[1] for p in processes}
    burst     = {p[0]: p[2] for p in processes}
    pending   = sorted(processes, key=lambda p: p[1])
    queue, clock, finish, switches = deque(), 0, {}, 0

    while pending or queue:
        while pending and pending[0][1] <= clock:        # admit new arrivals
            queue.append(pending.pop(0)[0])              # to the TAIL
        if not queue:
            clock = pending[0][1]
            continue

        name = queue.popleft()                           # take from the HEAD
        slice_ = min(quantum, remaining[name])           # run at most one quantum
        clock += slice_
        remaining[name] -= slice_
        switches += 1

        while pending and pending[0][1] <= clock:        # arrivals during the
            queue.append(pending.pop(0)[0])              # slice queue BEFORE the
                                                         # preempted process
        if remaining[name] > 0:
            queue.append(name)                           # preempted: back to tail
        else:
            finish[name] = clock

    waits = {n: finish[n] - arrival[n] - burst[n] for n in finish}
    return waits, sum(waits.values()) / len(waits), switches

for q in (1, 4, 12, 100):
    w, avg, sw = round_robin([("P1",0,24), ("P2",0,3), ("P3",0,3)], q)
    print(f"quantum {q:3}: avg wait {avg:5.2f}, switches {sw}")
```

**Key takeaways**

- Round robin gives each process one quantum in FIFO order, preempting and requeueing at the tail.
- It guarantees a response time bound of `(n - 1) x q` and cannot starve any process.
- The quantum is the whole design: too large degenerates to FCFS, too small drowns in switching overhead.
- Choose a quantum that covers roughly 80% of CPU bursts so most processes are never preempted.

> 🧪 Practice
>
> 1. Build the Gantt chart for P1 (0, 5), P2 (1, 3), P3 (2, 8) with quantum 2, and compute all three metrics.
> 2. Run the simulation across quanta 1 through 25 and plot average waiting time. Explain why the curve is not monotonic.
> 3. Interview-style: "A system has a 100 ms quantum and users complain of lag. Would you shorten it? What else would you check?" *Hint: consider the burst distribution and the switch cost before touching the knob.*

#### Multilevel Queue

**Theory**

The previous algorithms assume a single ready queue and one policy for everyone. But different classes of process want genuinely different things — interactive jobs want response time, batch jobs want throughput, system tasks want priority — and no single policy serves them all.

A **multilevel queue** scheduler partitions the ready queue into several separate queues, assigns each process permanently to one based on its class, and gives each queue **its own scheduling algorithm**:

| Queue (highest first) | Typical algorithm | Rationale |
|---|---|---|
| Real-time processes | Priority or FIFO | Deadlines must be met |
| System processes | Round robin, short quantum | Kernel work should be prompt |
| Interactive processes | Round robin, medium quantum | Response time matters |
| Batch processes | FCFS | Throughput matters; nobody is watching |

A second policy is then needed to schedule *between* queues, and there are two choices:

- **Fixed-priority preemption**: no process in a lower queue runs while any higher queue is non-empty. Simple and predictable — and it starves the lower queues under sustained load.
- **Time slicing between queues**: each queue receives a fixed share of CPU (say 80% interactive, 20% batch) to distribute among its own members. This bounds starvation at the cost of some responsiveness for the top queue.

The defining limitation is **inflexibility**: assignment is permanent. A process that starts as batch stays batch even if it becomes interactive, and vice versa. Since scheduling overhead is low (the queue is chosen by class, not computed), this design is cheap — but it cannot adapt, which is exactly what the next topic fixes.

Analogy: an airport with separate first-class, priority, and economy lines, each run differently. Efficient and predictable, but you cannot move between lines no matter how your situation changes.

**Example**

```text
   MULTILEVEL QUEUE (fixed assignment, fixed priority between queues)

   highest  +---------------------------------------------+
            | real-time      : priority, preemptive       |
            +---------------------------------------------+
            | system         : round robin, q = 8ms       |
            +---------------------------------------------+
            | interactive    : round robin, q = 20ms      |
            +---------------------------------------------+
   lowest   | batch          : FCFS                       |
            +---------------------------------------------+

   Rule: nothing in a lower queue runs while a higher queue has work.
   Consequence: sustained interactive load starves batch entirely.

   Alternative: time slicing between queues

   real-time  : 20% of CPU
   system     : 20%
   interactive: 40%
   batch      : 20%     <- guaranteed a share; cannot be starved
```

```python
from collections import deque

class MultilevelQueue:
    """Queues are ordered highest priority first; assignment is PERMANENT."""

    def __init__(self):
        self.queues = [
            {"name": "realtime",    "q": deque(), "algo": "priority", "quantum": None},
            {"name": "system",      "q": deque(), "algo": "rr",       "quantum": 8},
            {"name": "interactive", "q": deque(), "algo": "rr",       "quantum": 20},
            {"name": "batch",       "q": deque(), "algo": "fcfs",     "quantum": None},
        ]

    def admit(self, proc, level):
        self.queues[level]["q"].append(proc)   # class decides the level, once

    def pick_next(self):
        for level in self.queues:              # strict priority: scan top down
            if level["q"]:
                proc = level["q"].popleft()
                return proc, level["quantum"]  # each queue runs its own policy
        return None, None                      # nothing runnable
        # NOTE: a process never moves between levels -- that is the limitation
        #       multilevel FEEDBACK queues remove.
```

**Key takeaways**

- Multilevel queues partition processes into classes, each with its own queue and scheduling algorithm.
- A second policy schedules between queues: strict priority, or a guaranteed time share per queue.
- Strict priority between queues starves the lower ones; time slicing bounds that at some cost to responsiveness.
- Assignment is permanent, so the scheduler cannot adapt when a process's behaviour changes.

> 🧪 Practice
>
> 1. Design a three-queue scheme for a desktop OS. Name each queue, its algorithm, and its quantum, with justification.
> 2. Show a workload under which strict priority starves the batch queue indefinitely, then fix it with time slicing.
> 3. Interview-style: "Why is permanent queue assignment a problem in practice?" *Hint: think about a compiler that spends its first second reading files and the next minute computing.*

#### Multilevel Feedback Queue

**Theory**

The **multilevel feedback queue** (MLFQ) is the most important algorithm in this chapter, because it approximates SJF *without knowing burst lengths* and adapts to changing behaviour. It is the design behind the traditional UNIX, Solaris, Windows, and macOS schedulers.

The structure is a multilevel queue, but processes **move between levels** based on observed behaviour. The governing rules:

1. **New processes enter the highest-priority queue.** Optimism: assume it is interactive until proven otherwise.
2. **A process that uses its entire quantum is demoted** one level. Using a full quantum is evidence of CPU-bound behaviour.
3. **A process that blocks before its quantum expires stays** at its level (or is promoted). Blocking early is evidence of interactive behaviour.
4. **Lower queues get longer quanta.** A CPU-bound job runs less often but for longer when it does, which reduces switching overhead.
5. **Periodically, all processes are moved back to the top queue (aging).** This prevents starvation and lets a job that has changed character be re-evaluated.

The elegance is that priority is **inferred from behaviour rather than declared**. A process need not announce that it is interactive; it demonstrates it by blocking quickly. Short jobs finish while still in the high-priority queues, so they behave as if SJF had scheduled them, with no prediction required.

Two failure modes drove rules 5 and a refinement:

- **Starvation**: without periodic promotion, a long job demoted to the bottom may never run under sustained interactive load.
- **Gaming**: a process that issues a trivial I/O just before its quantum expires keeps its high priority forever. The fix is **accounting for total CPU time consumed at a level** rather than per-quantum behaviour, so the trick no longer works.

An MLFQ is defined by its parameters: the number of queues, each queue's algorithm and quantum, the demotion rule, the promotion/aging rule, and the entry queue. It is the most configurable classical scheduler, which is both its strength and its tuning burden.

**Example**

```text
   MULTILEVEL FEEDBACK QUEUE

   Q0  quantum 8ms   ---> uses full quantum? demote --+
        ^                                             |
        | periodic promotion (aging)                  v
        |                                     Q1  quantum 16ms  ---> demote --+
        |                                              ^                      |
        |                                              |                      v
        +----------------------------------------------+-------------  Q2  FCFS

   Rule: blocks early -> stays high (interactive)
         uses it all  -> sinks (CPU-bound)

   Trace: an interactive job I (3ms bursts) and a CPU-bound job C

   t=0    I enters Q0, runs 3ms, BLOCKS      -> stays in Q0
   t=3    C enters Q0, runs 8ms, quantum out -> demoted to Q1
   t=11   I ready again in Q0                -> preempts / runs first
   t=14   I blocks again                     -> stays in Q0
   t=14   C runs 16ms in Q1, quantum out     -> demoted to Q2
   ...
   Result: I keeps top priority forever without ever declaring itself
           interactive; C sinks and runs in long, efficient stretches.
```

```python
from collections import deque

class MLFQ:
    def __init__(self, quanta=(8, 16, 32), boost_interval=100):
        self.queues = [deque() for _ in quanta]
        self.quanta = quanta
        self.boost_interval = boost_interval     # rule 5: anti-starvation
        self.clock = 0
        self.last_boost = 0

    def admit(self, proc):
        proc.level = 0
        self.queues[0].append(proc)              # rule 1: enter at the top

    def run_next(self):
        if self.clock - self.last_boost >= self.boost_interval:
            self.boost_all()                     # rule 5

        for level, q in enumerate(self.queues):
            if not q:
                continue
            proc = q.popleft()
            quantum = self.quanta[level]
            used = proc.run(quantum)             # returns time actually consumed

            self.clock += used
            if proc.finished:
                return proc
            if used >= quantum:                  # rule 2: consumed it all
                proc.level = min(level + 1, len(self.queues) - 1)   # DEMOTE
            # rule 3: blocked early -> level unchanged (stays interactive)
            self.queues[proc.level].append(proc)
            return proc

    def boost_all(self):
        """Move everything back to Q0: prevents starvation and re-evaluates
           processes whose behaviour has changed."""
        for level in range(1, len(self.queues)):
            while self.queues[level]:
                proc = self.queues[level].popleft()
                proc.level = 0
                self.queues[0].append(proc)
        self.last_boost = self.clock
```

**Key takeaways**

- MLFQ moves processes between priority levels based on observed behaviour rather than declared class.
- Using a full quantum demotes a process; blocking early keeps it high, so interactivity is inferred, not announced.
- Lower queues have longer quanta, so CPU-bound work runs less often but in more efficient stretches.
- Periodic promotion prevents starvation and re-evaluates processes whose behaviour has changed; per-level CPU accounting prevents gaming.

> 🧪 Practice
>
> 1. Trace a three-queue MLFQ (quanta 4, 8, 16) with an interactive job (2ms bursts) and a 30ms CPU-bound job. Show the level of each over time.
> 2. Design the "I/O just before the quantum expires" attack against rules 1-4, then explain how per-level CPU accounting defeats it.
> 3. Interview-style: "How does MLFQ approximate SJF without knowing burst lengths?" *Hint: ask where a short job finishes, and what a long job's demotion reveals about its length.*

<a id="43-advanced-scheduling"></a>
### 4.3 Advanced Scheduling

Real machines have many cores, hardware threads that share execution units, and sometimes deadlines that must not be missed — each of which breaks an assumption the classical algorithms made.

#### Multiprocessor Scheduling

**Theory**

Every algorithm so far assumed one CPU and answered one question: *which* process runs next. With multiple cores there is a second question — *where* it runs — and the two interact.

The first design decision is who does the scheduling:

- **Asymmetric multiprocessing (AMP)**: one designated processor runs all kernel and scheduling code; the others run user code only. This eliminates concurrent access to scheduler data structures entirely, at the cost of making the master a bottleneck. It is now rare outside specialised embedded systems.
- **Symmetric multiprocessing (SMP)**: every processor schedules itself, running the scheduler on its own core. This is universal today, and it forces the scheduler's own data structures to be concurrent.

That leads to the second decision — the queue organisation — which is the real trade-off:

| | **Single shared ready queue** | **Per-CPU ready queues** |
|---|---|---|
| Load balance | Perfect and automatic | Requires explicit balancing |
| Lock contention | Severe: every scheduling decision contends | None on the common path |
| Cache behaviour | Poor: tasks bounce between cores | Good: tasks stay put |
| Scalability | Degrades badly past ~8 cores | Scales to hundreds of cores |
| Used by | Early SMP kernels | Linux, Windows, macOS today |

Per-CPU queues won decisively. A shared queue means every core takes the same lock on every scheduling decision — at thousands of decisions per second per core, that lock becomes the machine's bottleneck. Per-CPU queues make the common case lock-free at the cost of needing explicit load balancing (next topic).

Modern hardware adds two complications that a naive scheduler gets wrong:

- **NUMA**: memory is attached to specific sockets, and accessing a remote node's memory can cost twice as much. A scheduler should place a thread on a core near the memory it uses, and the memory allocator should cooperate.
- **Heterogeneous cores** (ARM big.LITTLE, Intel P-cores/E-cores): cores differ in speed and efficiency. The scheduler must decide not just *a* core but *which kind*, based on the task's demands and the power budget — Linux's Energy Aware Scheduling exists for exactly this.

**Example**

```text
   SINGLE SHARED QUEUE            PER-CPU QUEUES

     +---------------+              +------+ +------+ +------+ +------+
     | ready queue   |              | rq0  | | rq1  | | rq2  | | rq3  |
     +---+---+---+---+              +--+---+ +--+---+ +--+---+ +--+---+
         |   |   |                     |        |        |        |
      core0 core1 core2              core0    core1    core2    core3

   every decision takes ONE lock     no lock on the common path
   perfect balance, terrible         needs periodic balancing,
   scalability                       excellent scalability

   NUMA topology (2 sockets)

   +----------- node 0 -----------+   +----------- node 1 -----------+
   | core0 core1 core2 core3      |   | core4 core5 core6 core7      |
   | +--------------------------+ |   | +--------------------------+ |
   | |   local RAM  (~80 ns)    | |   | |   local RAM  (~80 ns)    | |
   | +--------------------------+ |   | +--------------------------+ |
   +--------------+---------------+   +--------------+---------------+
                  |    interconnect: remote access   |
                  +----------- ~140 ns --------------+

   Running a thread on node 1 while its memory lives on node 0
   costs roughly 1.7x on every memory access.
```

```bash
lscpu                        # sockets, cores, threads, NUMA nodes, cache sizes
numactl --hardware           # node distances: the cost matrix above, measured
cat /proc/schedstat          # per-CPU scheduler statistics, including balancing
lscpu -e                     # per-CPU max frequency: reveals P-cores vs E-cores

# Pin a workload to one NUMA node, memory included:
numactl --cpunodebind=0 --membind=0 ./benchmark
```

**Key takeaways**

- SMP is universal: every core runs the scheduler itself, so scheduler data must be concurrency-safe.
- Per-CPU ready queues replaced a single shared queue because the shared lock does not scale.
- Per-CPU queues require explicit load balancing, which a shared queue got for free.
- NUMA and heterogeneous cores mean placement matters as much as ordering: where a thread runs affects its speed.

> 🧪 Practice
>
> 1. Run `lscpu` and `numactl --hardware` on a machine you have. Describe its topology and where a scheduler should be careful.
> 2. Explain why a shared ready queue becomes a bottleneck at high core counts, with rough numbers for lock acquisitions per second.
> 3. Interview-style: "Why might the same benchmark be 40% slower when run without `numactl` pinning?" *Hint: consider where the memory was allocated versus where the thread ended up.*

#### Load Balancing and Processor Affinity

**Theory**

Per-CPU queues create the problem they solved contention for: queues drift out of balance, so one core is overloaded while another idles. **Load balancing** redistributes work; **processor affinity** resists moving it. They pull in opposite directions, and every SMP scheduler must reconcile them.

Balancing works in two directions:

- **Push migration**: a periodic task checks for imbalance and pushes threads from overloaded to idle queues.
- **Pull migration** (work stealing): an idle core pulls a waiting thread from a busy core's queue. This is cheaper — it costs nothing when the system is balanced, and the core doing the work is the one that was idle anyway.

Most kernels use both: pull for immediate idleness, push for periodic correction.

**Affinity** is the counter-pressure. When a thread runs on a core, it populates that core's L1 and L2 caches and its TLB with its working set. Migrating it discards all of that — the thread must refill caches from memory on the new core, which can cost far more than the queueing delay that motivated the move. This is the same "cache warmth" argument as context-switch cost in Chapter 2, and it is why gratuitous migration hurts.

Two forms exist:

- **Soft affinity**: the scheduler *prefers* to keep a thread on its previous core but may move it. This is the default everywhere.
- **Hard affinity**: the application *pins* a thread to a specified core set and the scheduler must comply (`sched_setaffinity`, `taskset`). Used for latency-critical work, NUMA locality, and benchmarking reproducibility.

The decision to migrate is therefore a cost comparison: migrating pays off only when the queueing delay avoided exceeds the cache-refill cost incurred. Linux formalises this with **scheduling domains** — a hierarchy mirroring the hardware (SMT siblings, cores sharing L2, sockets, NUMA nodes) where balancing is frequent and cheap within a domain and rare and expensive across domains. Migrating between hyperthreads of one core is nearly free; migrating across sockets abandons the caches entirely and possibly the memory locality too.

Analogy: moving a worker to a less busy desk means they must carry their reference books and re-open everything. Worth it if the new desk is much freer; not worth it for a slight difference.

**Example**

```text
   Imbalance and the two remedies

   before:   rq0 [A][B][C][D]     rq1 []           rq2 [E]     rq3 []
   push:     a balancer moves D and C from rq0 outward
   pull:     idle rq1 and rq3 steal from rq0 themselves (cheaper: only the
             idle cores do work, and only when there is imbalance)
   after:    rq0 [A][B]           rq1 [C]          rq2 [E]     rq3 [D]

   Linux scheduling domains: balance often where it is cheap

   +---------------------- NUMA domain (rare, expensive) -----------------+
   |  +------- socket 0 --------+        +------- socket 1 --------+      |
   |  | +--- core0 ---+  +core1+|        | +--- core4 ---+  +core5+|      |
   |  | | HT0    HT1  |  |     ||        | | HT0    HT1  |  |     ||      |
   |  | +-------------+  +-----+|        | +-------------+  +-----+|      |
   |  |   SMT domain: balance    |        |                        |      |
   |  |   constantly (free)      |        |                        |      |
   |  +--------------------------+        +-------------------------+      |
   +----------------------------------------------------------------------+

   cost of migration:
     between SMT siblings : ~free (shared L1/L2)
     between cores, 1 die : cheap (shared L3)
     between sockets      : expensive (cold caches + possibly remote memory)
```

```c
#define _GNU_SOURCE
#include <sched.h>
#include <stdio.h>

int main(void) {
    cpu_set_t set;
    CPU_ZERO(&set);
    CPU_SET(2, &set);          /* restrict this thread to CPU 2 only */
    CPU_SET(3, &set);          /* ...and CPU 3: a two-core affinity mask */

    /* HARD affinity: the scheduler must now honour this. Used for
       latency-critical threads, NUMA locality, and reproducible benchmarks. */
    if (sched_setaffinity(0, sizeof set, &set) != 0)
        perror("sched_setaffinity");

    printf("running on CPU %d\n", sched_getcpu());
    return 0;
}
```

```bash
taskset -c 0-3 ./benchmark          # pin to cores 0-3 without changing the code
taskset -pc 1234                    # show an existing process's affinity mask
watch -n1 'grep -c . /proc/schedstat'   # observe balancing activity
perf stat -e migrations,cache-misses ./workload   # migrations vs cache cost
```

**Key takeaways**

- Per-CPU queues drift out of balance; push migration and pull migration (work stealing) correct it.
- Affinity resists migration because moving a thread abandons its warm caches and TLB entries.
- Soft affinity is a preference the scheduler may override; hard affinity pins a thread to a core set.
- Scheduling domains make balancing frequent within cheap hardware boundaries and rare across expensive ones.

> 🧪 Practice
>
> 1. Run a CPU-bound benchmark with and without `taskset` pinning, and count migrations with `perf stat -e migrations`.
> 2. Explain when migrating a thread is a net loss, using rough numbers for cache refill versus queueing delay.
> 3. Interview-style: "You pin all worker threads to specific cores and throughput drops. What happened?" *Hint: consider what the scheduler can no longer do when load is uneven or another workload appears.*

#### Symmetric Multithreading

**Theory**

**Symmetric multithreading** (SMT, marketed as Hyper-Threading) is a hardware technique in which one physical core presents itself as two (or more) **logical processors**. Each logical CPU has its own architectural state — registers, program counter, interrupt state — but the two share the core's *execution resources*: ALUs, floating-point units, caches, and the TLB.

The motivation is that a single instruction stream cannot keep a modern core's execution units busy. Cache misses, branch mispredictions, and dependency stalls leave functional units idle for large fractions of every cycle. With two streams available, the core issues instructions from whichever has work ready, filling those gaps.

The essential consequence for scheduling is that **two logical CPUs on one core are not two real CPUs.** Typical gains are 15-30% total throughput, not 100%. So the scheduler must know the topology and act on it:

- **Spread before stacking.** With two runnable threads and two physical cores each with two SMT siblings, put the threads on *different physical cores*. Placing both on one core's siblings leaves an entire core idle while the two threads fight over one core's execution units.
- **Sibling contention is real.** Two cache-heavy threads on one core evict each other's data from a shared L1/L2. Two threads with complementary demands (one memory-bound, one compute-bound) share well.
- **Latency-critical work should not share.** A real-time or latency-sensitive thread on a core whose sibling is running a compute hog sees unpredictable slowdowns.

SMT also creates a security problem: siblings share caches and execution ports, which enables cross-thread side-channel attacks. This is why some cloud providers and hardened systems disable SMT entirely, accepting the throughput loss.

Analogy: two cooks sharing one kitchen. Output rises, because one can chop while the other waits for water to boil — but it is not double, and if both need the single oven at once, they interfere.

**Example**

```text
   SMT: one physical core, two logical CPUs

   +------------------- physical core 0 --------------------+
   |  logical CPU 0            logical CPU 1                |
   |  +-------------+          +-------------+              |
   |  | registers   |          | registers   |   PRIVATE    |
   |  | PC, flags   |          | PC, flags   |              |
   |  +------+------+          +------+------+              |
   |         |                        |                     |
   |         +------------+-----------+                     |
   |                      v                                 |
   |     ALUs | FPU | L1 cache | L2 cache | TLB    SHARED    |
   +--------------------------------------------------------+

   Why it helps: filling stall cycles

   one thread :  [exec][STALL: cache miss][exec][STALL][exec]
   two threads:  [ T0 ][      T1        ][ T0 ][  T1 ][ T0 ]
                 the core issues from whichever stream is ready

   PLACEMENT MATTERS: 2 threads, 2 cores x 2 SMT siblings

   BAD:   core0 [T0][T1]   core1 [  idle  ]   -> ~1.2x throughput
   GOOD:  core0 [T0][ - ]  core1 [T1][ -  ]   -> ~2.0x throughput

   Linux numbering trap: CPUs 0-3 are often core0-HT0, core1-HT0,
   core0-HT1, core1-HT1 -- so "cores 0 and 1" may or may not be siblings.
   Always check with lscpu -e before pinning.
```

```bash
lscpu -e=CPU,CORE,SOCKET      # which logical CPUs share a physical core
cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list   # e.g. "0,4"

# Measure the difference yourself: same two threads, two placements.
taskset -c 0,4 ./two_thread_bench    # both on ONE core's siblings (bad)
taskset -c 0,1 ./two_thread_bench    # on two distinct physical cores (good)

# Disable SMT entirely (throughput cost, but removes sibling side channels):
echo off | sudo tee /sys/devices/system/cpu/smt/control
```

```python
# Reading the topology so a program can place its own threads correctly.
from pathlib import Path

def physical_cores():
    """Map physical core id -> list of logical CPUs (its SMT siblings)."""
    cores = {}
    for cpu in Path("/sys/devices/system/cpu").glob("cpu[0-9]*"):
        topo = cpu / "topology" / "core_id"
        if topo.exists():
            core_id = int(topo.read_text())
            cores.setdefault(core_id, []).append(int(cpu.name[3:]))
    return cores

# Spread first: take one logical CPU per physical core before using siblings.
layout = physical_cores()
spread = [siblings[0] for siblings in layout.values()]     # use these first
stacked = [c for sibs in layout.values() for c in sibs[1:]]  # only if needed
print("prefer:", sorted(spread), "then:", sorted(stacked))
```

**Key takeaways**

- SMT gives one physical core several logical CPUs that share execution units, caches, and TLB.
- It fills stall cycles, typically yielding 15-30% extra throughput — not double.
- The scheduler must spread threads across physical cores before stacking them onto SMT siblings.
- Siblings contend for cache and execution ports, hurting latency-critical work and enabling side-channel attacks.

> 🧪 Practice
>
> 1. Determine your machine's sibling pairs with `lscpu -e`, then run a two-thread benchmark stacked and spread. Report the ratio.
> 2. Explain why two memory-bound threads share a core worse than one memory-bound plus one compute-bound thread.
> 3. Interview-style: "Would you enable SMT on a latency-sensitive trading server?" *Hint: weigh average throughput against worst-case jitter and the side-channel exposure.*

#### Real-Time Scheduling

**Theory**

Everything so far optimised averages. **Real-time systems** invert the priority: correctness depends on *when* a result is produced, not merely that it is produced. A late answer is a wrong answer.

Two categories, with very different engineering consequences:

| | **Hard real-time** | **Soft real-time** |
|---|---|---|
| Missing a deadline | System failure; may be catastrophic | Quality degrades; system continues |
| Guarantee needed | Provable, worst-case | Statistical, best-effort priority |
| Examples | Airbag deployment, flight control, pacemakers, industrial robots | Video playback, VoIP, gaming, live streaming |
| Requires | Bounded worst-case latency everywhere | High priority and low average latency |

A hard real-time system needs guarantees from every layer, not just the scheduler: bounded interrupt latency, bounded dispatch latency (4.1), no unbounded priority inversion, no page faults (memory is locked resident), and no unpredictable caches or garbage collection. This is why general-purpose kernels are unsuitable out of the box and why dedicated RTOS designs (VxWorks, QNX, FreeRTOS, Zephyr) exist.

The scheduling model uses **periodic tasks**, each characterised by three numbers: period *p* (how often it becomes ready), processing time *t* (worst-case execution time), and deadline *d* (by when it must complete, usually `d = p`). The **CPU utilisation** of a task is `t / p`, and the system's total utilisation is the sum. This model is what makes analysis possible: with these parameters known, schedulability can be *proved* before deployment rather than tested for.

A crucial requirement is **admission control**: the system must refuse a task set it cannot guarantee. Accepting work that cannot be scheduled and then missing deadlines is worse than rejecting it up front.

Linux offers `SCHED_FIFO` and `SCHED_RR` (POSIX real-time classes, fixed priorities 1-99, always preempting normal tasks) and `SCHED_DEADLINE` (an EDF implementation with admission control). These give *soft* real-time behaviour on a standard kernel; hard guarantees need `PREEMPT_RT` or a dedicated RTOS.

**Example**

```text
   Periodic task model

   task T: period p = 50ms, execution t = 20ms, deadline d = p

   |<---------- p = 50 --------->|<---------- p = 50 --------->|
   [== t = 20 ==]                [== t = 20 ==]
   ^            ^                ^
   release      must finish      next release
                by d = 50

   utilisation U = t/p = 20/50 = 0.4  (40% of the CPU reserved for T)

   Latency budget for a hard real-time response

   event -> interrupt latency -> handler -> conflict phase -> dispatch -> task
            |<---- every one of these must be BOUNDED ---->|

            If any link is unbounded (a non-preemptible kernel path,
            a page fault, a GC pause), the guarantee is void.
```

```c
#define _GNU_SOURCE
#include <sched.h>
#include <sys/mman.h>
#include <stdio.h>

int main(void) {
    /* 1. Lock all memory resident: a page fault would be an unbounded delay. */
    if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0)
        perror("mlockall");

    /* 2. Ask for a real-time class. SCHED_FIFO runs until it blocks or is
          preempted by something of HIGHER priority -- it is not time-sliced. */
    struct sched_param param = { .sched_priority = 80 };   /* 1..99 */
    if (sched_setscheduler(0, SCHED_FIFO, &param) != 0)
        perror("sched_setscheduler");     /* needs CAP_SYS_NICE / root */

    /* WARNING: a SCHED_FIFO task that never blocks will monopolise its core.
       Linux's rt_runtime_us throttle exists to keep such a bug from
       making the machine unrecoverable. */
    printf("policy=%d priority=%d\n", sched_getscheduler(0), param.sched_priority);
    return 0;
}
```

```bash
chrt -f 80 ./control_loop      # run with SCHED_FIFO priority 80
chrt -p $$                     # show the current shell's policy
cat /proc/sys/kernel/sched_rt_runtime_us   # 950000: RT tasks capped at 95%
uname -a | grep -i preempt     # is this a PREEMPT_RT kernel?
```

**Key takeaways**

- Real-time correctness depends on timing: hard systems fail if a deadline is missed, soft systems merely degrade.
- Hard guarantees require bounded latency in every layer — interrupts, kernel paths, memory, and locking.
- Tasks are modelled as periodic with period, worst-case execution time, and deadline, giving utilisation `t/p`.
- Admission control must reject task sets that cannot be guaranteed, rather than accepting and missing deadlines.

> 🧪 Practice
>
> 1. Classify as hard or soft, with justification: anti-lock braking, Netflix playback, a pacemaker, a multiplayer game server.
> 2. Compute total utilisation for tasks (t=10, p=30), (t=15, p=60), (t=5, p=25). Is it below 1.0? Does that guarantee schedulability?
> 3. Interview-style: "Why can't you get hard real-time guarantees from a standard Linux kernel?" *Hint: name three sources of unbounded delay that have nothing to do with the scheduling policy.*

#### Rate-Monotonic Scheduling

**Theory**

**Rate-monotonic scheduling** (RMS) assigns static priorities to periodic tasks by one rule: **the shorter the period, the higher the priority**. A task that runs every 20 ms outranks one that runs every 100 ms, permanently, regardless of urgency or importance. It is preemptive: a higher-rate task arriving preempts a lower-rate one immediately.

The rule looks arbitrary and is in fact optimal — RMS is provably the best possible *static-priority* algorithm for periodic tasks. If any fixed-priority assignment can schedule a task set, rate-monotonic can. The intuition is that a short-period task has less slack: it must finish sooner after each release, so delaying it is more dangerous.

Its practical value is the **schedulability test**, which can be checked before deployment:

```text
U = sum(t_i / p_i)  <=  n * (2^(1/n) - 1)
```

This bound is *sufficient but not necessary*: any task set below it is guaranteed schedulable; a set above it may still be schedulable and needs exact analysis. The bound decreases with the number of tasks, converging to `ln 2` ≈ 0.693. So in the worst case, roughly 31% of the CPU must be left unused to guarantee deadlines under RMS — that is the price of static priorities.

The strengths are predictability and simplicity: priorities are fixed, so behaviour is easy to analyse and to certify, and overload degrades predictably (the longest-period task misses first). The weakness is the utilisation ceiling, which EDF removes.

Analogy: a nurse always attending the patient whose vitals must be checked most frequently. Simple, predictable, and it works — provided the ward is not too full.

**Example**

```text
   SCHEDULABLE: P1 (p=50, t=20), P2 (p=100, t=35)

   U = 20/50 + 35/100 = 0.40 + 0.35 = 0.75
   bound for n=2: 2 * (2^0.5 - 1) = 0.828
   0.75 <= 0.828  -> GUARANTEED schedulable

   P1 has the shorter period, so it gets the higher priority.

   0        20      50      70        100     120    150
   |=P1=====|==P2===|=P1====|===P2====|=P1====|      |
   0        20      50      70        100
     P1 runs 0-20 (deadline 50, met)
     P2 runs 20-50, preempted by P1 at 50
     P1 runs 50-70 (deadline 100, met)
     P2 resumes 70-75, completing its 35 units (deadline 100, met)

   NOT SCHEDULABLE BY RMS: P1 (p=50, t=25), P2 (p=80, t=35)

   U = 25/50 + 35/80 = 0.50 + 0.4375 = 0.9375  >  0.828 -> no guarantee

   0        25      50      75    80
   |=P1=====|==P2===|=P1====|=P2=|
   0        25      50      75   80
     P2 gets 25 units (25-50), is preempted at 50 by P1,
     resumes 75-80 for only 5 more = 30 of the 35 it needs.
     DEADLINE MISSED at t=80.

   RMS utilisation bound by task count

   n:      1      2      3      4      5     10    inf
   bound: 1.000  0.828  0.780  0.757  0.743  0.718  0.693
```

```python
def rms_schedulable(tasks):
    """tasks: list of (name, period, exec_time). Returns (utilisation, bound, ok).
       The test is SUFFICIENT, not necessary: failing it does not prove
       the set is unschedulable, only that RMS cannot guarantee it."""
    n = len(tasks)
    u = sum(t / p for _, p, t in tasks)
    bound = n * (2 ** (1 / n) - 1)               # Liu and Layland bound
    return u, bound, u <= bound

def rms_priorities(tasks):
    """Rate monotonic: shorter period -> higher priority. That is the whole rule."""
    return [name for name, p, t in sorted(tasks, key=lambda x: x[1])]

set_a = [("P1", 50, 20), ("P2", 100, 35)]
set_b = [("P1", 50, 25), ("P2", 80, 35)]

for s in (set_a, set_b):
    u, bound, ok = rms_schedulable(s)
    print(f"U={u:.4f} bound={bound:.4f} -> {'guaranteed' if ok else 'NOT guaranteed'}"
          f"  priority order: {rms_priorities(s)}")
```

**Key takeaways**

- Rate-monotonic assigns static priorities by period: shorter period means higher priority, always.
- It is optimal among static-priority algorithms — if any fixed assignment works, RMS works.
- The test `U <= n(2^(1/n) - 1)` is sufficient but not necessary, and converges to about 69%.
- Up to 31% of CPU capacity may have to go unused to guarantee deadlines; that is the cost of static priorities.

> 🧪 Practice
>
> 1. Test schedulability for P1 (p=20, t=5), P2 (p=50, t=15), P3 (p=100, t=30). Assign RMS priorities.
> 2. Draw the Gantt chart for P1 (p=30, t=10) and P2 (p=40, t=15) over 120 time units and check every deadline.
> 3. Interview-style: "A task set has U = 0.75 with three tasks and fails the RMS bound. Is it definitely unschedulable?" *Hint: recall exactly what a sufficient-but-not-necessary condition claims.*

#### Earliest Deadline First

**Theory**

**EDF** replaces static priorities with dynamic ones: at every scheduling instant, run the task whose **absolute deadline is nearest**. Priorities are not properties of tasks; they change continuously as deadlines approach and are renewed each period.

The payoff is theoretically the strongest result in real-time scheduling: EDF is **optimal for uniprocessors**, and its schedulability test is simply

```text
U = sum(t_i / p_i)  <=  1.0
```

If the total demand fits in the available CPU time, EDF meets every deadline. There is no wasted 31%. A task set that RMS cannot guarantee at U = 0.9375 is trivially schedulable under EDF.

The trade-offs explain why RMS is still widely used in safety-critical systems:

| | **Rate Monotonic** | **EDF** |
|---|---|---|
| Priorities | Static, assigned once | Dynamic, recomputed continuously |
| Utilisation bound | ~0.693 to 0.828 | 1.0 |
| Runtime cost | Very low | Higher: deadline tracking and reordering |
| Behaviour in overload | Predictable — longest period fails first | **Unpredictable — domino effect**: a missed deadline makes the next task even more urgent, cascading failures |
| Analysis and certification | Simple, well-understood | Harder to argue about |
| Typical use | Avionics, automotive, certified systems | Multimedia, `SCHED_DEADLINE`, systems with slack |

The overload behaviour is the decisive practical difference. Under RMS, if the system is overloaded, you know *which* task misses: the one with the longest period. Under EDF, one missed deadline shifts urgency to the next task, which may then miss, and the failure cascades unpredictably. For a certified avionics system, predictable degradation is worth more than the extra 20% of CPU.

Linux implements EDF as `SCHED_DEADLINE`, where each task declares a runtime, a deadline, and a period, and the kernel performs **admission control** — refusing tasks that would push utilisation above the guaranteed bound. That refusal is the mechanism that makes the guarantee real.

**Example**

```text
   The set RMS could NOT guarantee: P1 (p=50, t=25), P2 (p=80, t=35)
   U = 0.9375 <= 1.0  -> EDF guarantees it

   t=0   P1 deadline 50, P2 deadline 80  -> P1 is nearer, run P1
   t=25  P1 done. Run P2 (deadline 80).
   t=50  P1 released, deadline 100. P2's deadline 80 is NEARER -> P2 continues
         (this is exactly where RMS preempted and lost)
   t=60  P2 done (35 units: 25-60). Deadline 80 MET.
   t=60  Run P1 (deadline 100).
   t=85  P1 done. Deadline 100 MET.

   |=== P1 ===|====== P2 ======|====== P1 ======|
   0          25               60               85
                    ^
                    P1's release at t=50 does NOT preempt, because P2's
                    deadline is sooner. Static priority could not express this.

   The domino effect under overload (U > 1.0)

   RMS overload:  the longest-period task misses. Every time. Predictable.
   EDF overload:  T1 misses -> T2 is now most urgent -> T2 misses ->
                  T3 is now most urgent -> ... cascade, order unpredictable
```

```python
def edf_schedulable(tasks):
    """EDF on a uniprocessor: schedulable if and only if U <= 1.0."""
    u = sum(t / p for _, p, t in tasks)
    return u, u <= 1.0

def edf_pick(ready, now):
    """The entire policy: nearest ABSOLUTE deadline wins.
       Absolute deadline = release time of the current instance + relative deadline,
       so priorities change every period -- unlike RMS."""
    return min(ready, key=lambda task: task.absolute_deadline)

tasks = [("P1", 50, 25), ("P2", 80, 35)]
u, ok = edf_schedulable(tasks)
print(f"U={u:.4f} -> EDF: {'schedulable' if ok else 'overloaded'}")
# U=0.9375 -> schedulable   (RMS could not guarantee this same set)
```

```c
/* Linux SCHED_DEADLINE: EDF with admission control built in. */
struct sched_attr attr = {
    .size           = sizeof(struct sched_attr),
    .sched_policy   = SCHED_DEADLINE,
    .sched_runtime  = 10 * 1000 * 1000,   /* 10 ms of CPU ...        */
    .sched_deadline = 30 * 1000 * 1000,   /* ... to be done within 30 ms ... */
    .sched_period   = 30 * 1000 * 1000,   /* ... every 30 ms.        */
};
/* The kernel REFUSES this call with EBUSY if admitting the task would push
   total utilisation past what it can guarantee. The refusal is the guarantee. */
if (syscall(SYS_sched_setattr, 0, &attr, 0) != 0)
    perror("sched_setattr");
```

**Key takeaways**

- EDF dynamically prioritises by nearest absolute deadline, recomputed as deadlines approach.
- It is optimal on a uniprocessor and schedulable whenever total utilisation is at most 1.0.
- It costs more at run time and behaves unpredictably in overload, cascading missed deadlines.
- RMS remains preferred for certified systems because its overload failure is predictable; Linux offers EDF as `SCHED_DEADLINE` with admission control.

> 🧪 Practice
>
> 1. Verify EDF schedulability for P1 (p=40, t=15), P2 (p=60, t=20), P3 (p=120, t=30), and compare with the RMS bound.
> 2. Draw the EDF Gantt chart for P1 (p=30, t=10), P2 (p=45, t=15) over 90 units, marking each absolute deadline.
> 3. Interview-style: "EDF achieves 100% utilisation. Why do avionics systems still use rate monotonic?" *Hint: ask what happens on the first overload, and what a certification authority needs to be told.*

<a id="44-evaluation-and-practice"></a>
### 4.4 Evaluation and Practice

Choosing between the algorithms above requires a method for comparing them, and the schedulers that actually ship are worth studying as the compromises they are.

#### Deterministic Modeling

**Theory**

**Deterministic modeling** is the simplest evaluation method: take a specific, fully specified workload and compute exactly what each algorithm would do with it. This is what the worked Gantt charts in 4.2 are — you fix the arrival times and burst lengths, run each algorithm on paper, and compare the resulting numbers.

Its virtues are real: it is **exact** (no statistical uncertainty), **fast**, **reproducible**, and **explanatory** — you can see precisely *why* one algorithm beats another on this workload, not merely that it does. It is also the right tool for teaching, for sanity-checking an implementation, and for generating regression tests.

Its limitation is equally clear: **the answer applies only to that specific workload.** Showing that SJF beats FCFS on one five-process example proves nothing about a production system whose arrival pattern differs. Real workloads have variable and unknown burst lengths, arrivals that depend on completions (a user only issues the next command after seeing the last result), and behaviour that changes over time.

The disciplined use is therefore to model **several deliberately chosen workloads** rather than one, especially adversarial cases: all-short jobs, all-long jobs, one long job among many short ones, a burst of simultaneous arrivals. An algorithm that looks good on the average case and catastrophic on a plausible edge case is not a good algorithm.

Analogy: deterministic modeling is testing a car design against one specific road. Precise, informative, and no evidence at all about how it handles the other roads.

**Example**

```text
   One workload, four algorithms, computed exactly

   P1 arrives 0 burst 10   P2 arrives 1 burst 4
   P3 arrives 2 burst 2    P4 arrives 3 burst 6

   FCFS   |==== P1 ====|= P2 =|P3|=== P4 ===|
          0            10     14 16         22
          waiting: 0, 9, 12, 13          avg = 8.50

   SJF    |==== P1 ====|P3|= P2 =|=== P4 ===|
          0            10 12     16         22
          waiting: 0, 11, 8, 13           avg = 8.00

   SRTF   |P1|= P2 =|P3|=== P4 ===|=== P1 ===|
          0  1      5  7          13         22
          waiting: 12, 0, 3, 4            avg = 4.75   <- best here

   RR q=4 |= P1 =|= P2 =|P3|= P4 =|= P1 =|= P4 =|= P1 =|
          0      4      8  10     14     18     20     22
          waiting: 8, 3, 6, 9             avg = 6.50

   Conclusion: SRTF wins ON THIS WORKLOAD. Change the arrivals and the
   ranking can change -- which is exactly the method's limitation.
```

```python
def compare(workload):
    """Deterministic modeling: run every algorithm on one exact workload."""
    results = {
        "FCFS":   fcfs(workload)[1],
        "SJF":    sjf(workload)[1],
        "SRTF":   srtf(workload)[1],
        "RR q=4": round_robin(workload, 4)[1],
    }
    for name, avg in sorted(results.items(), key=lambda kv: kv[1]):
        print(f"{name:8} avg waiting = {avg:.2f}")
    return results

# Model several DELIBERATELY CHOSEN workloads, not just one.
compare([("P1",0,10), ("P2",1,4), ("P3",2,2), ("P4",3,6)])   # mixed
compare([("P1",0,2),  ("P2",0,2), ("P3",0,2), ("P4",0,2)])   # all short
compare([("P1",0,50), ("P2",1,1), ("P3",2,1), ("P4",3,1)])   # convoy case
```

**Key takeaways**

- Deterministic modeling computes exact results for one fully specified workload.
- It is fast, reproducible, and shows why an algorithm wins, which makes it ideal for teaching and testing.
- Its conclusions do not generalise: a different arrival pattern can reverse the ranking.
- Use several workloads, including adversarial ones, rather than a single representative case.

> 🧪 Practice
>
> 1. Compute average waiting time under FCFS, SJF, and RR (q=3) for P1 (0, 8), P2 (1, 4), P3 (2, 9), P4 (3, 5).
> 2. Construct a workload on which FCFS beats SJF for average *response* time, and explain the mechanism.
> 3. Interview-style: "Your benchmark shows algorithm A is 20% better. What would you check before deploying it?" *Hint: ask how the benchmark's arrival pattern compares with production traffic.*

#### Queueing Analysis

**Theory**

Deterministic modeling needs an exact workload. **Queueing analysis** needs only its *statistical* description, which is far easier to obtain from a running system: an arrival rate and a service rate. It then predicts average queue lengths and waiting times mathematically.

The central result is **Little's Law**, which is remarkable for how few assumptions it makes:

```text
n = lambda x W
```

where `n` is the average number of items in the system, `lambda` the average arrival rate, and `W` the average time each item spends in the system. It holds for *any* stable system regardless of arrival distribution, service distribution, or scheduling discipline — which makes it the most broadly useful formula in performance work. Given any two quantities, you get the third: a server handling 50 requests/second with an average of 5 requests in flight has an average response time of 100 ms.

For a single-server queue with Poisson arrivals and exponential service times (an **M/M/1** queue), utilisation `rho = lambda / mu` gives:

```text
average number in system   n = rho / (1 - rho)
average time in system     W = 1 / (mu - lambda)
```

The critical insight is the shape of that curve: **waiting time grows without bound as utilisation approaches 1**. At 50% utilisation the queue holds 1 item; at 90% it holds 9; at 99% it holds 99. Doubling utilisation from 45% to 90% multiplies queueing delay roughly tenfold. This is the mathematical reason capacity planning targets 60-80% utilisation rather than 95% — the last few percent of capacity cost enormous latency.

The limitations are the assumptions. Real arrivals are bursty rather than Poisson, service times are not exponential, and queueing networks with feedback are hard to solve in closed form. Queueing analysis therefore gives excellent *intuition* and approximate answers, and should not be trusted for precise predictions.

**Example**

```text
   The utilisation wall (M/M/1)

   rho (utilisation)  |  avg items in system  |  latency multiplier
   -------------------+-----------------------+--------------------
        0.10          |         0.11          |        1.1x
        0.50          |         1.00          |        2.0x
        0.70          |         2.33          |        3.3x
        0.80          |         4.00          |        5.0x
        0.90          |         9.00          |       10.0x
        0.95          |        19.00          |       20.0x
        0.99          |        99.00          |      100.0x

   latency
     |                                              *
     |                                          *
     |                                     *
     |                              *
     |                   *
     |        *
     |  *  *
     +--------------------------------------------> utilisation
     0        0.5              0.8    0.9   0.95  1.0
                                       ^
                            plan to operate here, not further right

   Little's Law in practice

   A queue holds 40 requests on average; arrivals are 200/second.
   W = n / lambda = 40 / 200 = 0.2 s  -> average latency is 200 ms.
   No assumption about the scheduler was needed to say that.
```

```python
def littles_law(n=None, arrival_rate=None, wait=None):
    """n = lambda * W. Supply any two; get the third.
       Holds for ANY stable system: no distribution assumptions required."""
    if n is None:          return arrival_rate * wait
    if arrival_rate is None: return n / wait
    return n / arrival_rate

def mm1(arrival_rate, service_rate):
    """Single server, Poisson arrivals, exponential service."""
    if arrival_rate >= service_rate:
        raise ValueError("unstable: the queue grows without bound")
    rho = arrival_rate / service_rate                  # utilisation
    n   = rho / (1 - rho)                              # avg items in system
    w   = 1 / (service_rate - arrival_rate)            # avg time in system
    return {"utilisation": rho, "avg_in_system": n, "avg_time": w}

# A server that can handle 100 req/s, at increasing load:
for lam in (50, 70, 80, 90, 95, 99):
    r = mm1(lam, 100)
    print(f"load {lam:3}/s  rho={r['utilisation']:.2f}  "
          f"queue={r['avg_in_system']:6.2f}  latency={r['avg_time']*1000:7.1f} ms")
# The jump from 90 to 99 req/s -- 10% more work -- costs 10x the latency.
```

**Key takeaways**

- Queueing analysis predicts average behaviour from arrival and service rates rather than an exact workload.
- Little's Law (`n = lambda x W`) holds for any stable system, independent of distributions and scheduling policy.
- Waiting time rises without bound as utilisation approaches 100%, which is why systems are planned for 60-80%.
- Its assumptions (Poisson arrivals, exponential service) rarely hold exactly, so treat results as intuition, not prediction.

> 🧪 Practice
>
> 1. A service receives 120 requests/second and holds 18 on average. Compute the average response time using Little's Law.
> 2. Using the M/M/1 model with a service rate of 200/s, compute latency at 100, 160, 180, and 195 requests/second. Comment on the trend.
> 3. Interview-style: "Management wants to run servers at 95% CPU to save money. What is your response?" *Hint: quantify the latency multiplier and what a small traffic spike then does.*

#### Simulation and Benchmarking

**Theory**

When mathematical models are too restrictive and paper analysis too narrow, the remaining options are to **simulate** the scheduler on synthetic or recorded workloads, or to **benchmark** a real implementation on real hardware.

**Simulation** implements the algorithm and drives it with generated events, keeping a clock and statistics. It sits between the two previous methods in fidelity and cost. The critical question is the workload source:

- **Randomly generated** from a distribution: easy, and only as valid as the distribution chosen. Exponential burst lengths (4.1) are a defensible starting point.
- **Trace-driven**: recorded from a real system, capturing actual arrival patterns, correlations, and bursts. Far more credible, and the standard when accuracy matters.

Trace-driven simulation has one subtlety worth knowing: a trace is a recording of what happened *under the scheduler that produced it*. Feeding it to a different scheduler is not fully sound, because real arrivals depend on completions — a user issues the next command only after the previous one returns. Traces are still the best available input, but the feedback loop they omit is a real source of error.

**Benchmarking** runs actual software on actual hardware and is the only method that captures cache effects, NUMA behaviour, interrupt load, and lock contention — the things that dominate real performance and that no model represents. It is also the most expensive, the least controllable, and the hardest to interpret, because so many variables move at once.

Sound practice regardless of method:

- Measure **distributions, not just means** — report p50, p95, p99, and max.
- Run **long enough to reach steady state**, and discard the warm-up period.
- **Repeat runs** and report variance; a single run of a concurrent system means little.
- **Change one variable at a time**, and keep the rest of the machine quiet.
- **Beware the observer effect**: heavy tracing changes the behaviour being measured.

**Example**

```text
   The four evaluation methods

   method            | cost   | fidelity | generality | captures hardware?
   ------------------+--------+----------+------------+-------------------
   deterministic     | lowest | exact    | very low   | no
   queueing analysis | low    | approx   | high       | no
   simulation        | medium | good     | medium     | no
   benchmarking      | high   | real     | low        | yes

   Report the distribution, not the mean

   Scheduler A: p50 = 20ms  p95 =  25ms  p99 =  30ms  max =  40ms
   Scheduler B: p50 = 12ms  p95 = 100ms  p99 = 800ms  max = 3000ms

   B has the better average. A is the one users will prefer.
```

```python
import random, statistics

def simulate_rr(quantum, n_procs=1000, mean_burst=8.0, seed=42):
    """Trace-free simulation: bursts drawn from an exponential distribution,
       which matches the shape observed in 4.1."""
    rng = random.Random(seed)
    bursts = [rng.expovariate(1 / mean_burst) for _ in range(n_procs)]
    switch_cost = 0.05                        # 50 us per context switch

    clock, waits, remaining = 0.0, [0.0] * n_procs, list(bursts)
    arrival = [0.0] * n_procs                 # all arrive at t=0 for simplicity
    finished = 0

    while finished < n_procs:
        for i in range(n_procs):
            if remaining[i] <= 0:
                continue
            slice_ = min(quantum, remaining[i])
            clock += slice_ + switch_cost      # overhead charged every slice
            remaining[i] -= slice_
            if remaining[i] <= 0:
                waits[i] = clock - arrival[i] - bursts[i]
                finished += 1

    waits.sort()
    return {
        "quantum": quantum,
        "mean": statistics.mean(waits),
        "p50": waits[len(waits) // 2],
        "p95": waits[int(0.95 * len(waits))],   # ALWAYS report the tail
        "p99": waits[int(0.99 * len(waits))],
    }

for q in (1, 2, 4, 8, 16, 64):
    r = simulate_rr(q)
    print(f"q={r['quantum']:3}  mean={r['mean']:8.1f}  "
          f"p50={r['p50']:8.1f}  p95={r['p95']:8.1f}  p99={r['p99']:8.1f}")
```

```bash
# Benchmarking the real thing.
perf sched record -- ./workload     # capture actual scheduling events
perf sched latency --sort max       # per-task max scheduling delay
hackbench -l 1000 -g 20             # scheduler stress benchmark
sysbench cpu --threads=16 run       # repeat it; report variance, not one run
```

**Key takeaways**

- Simulation implements the algorithm against generated or recorded workloads; trace-driven input is the more credible.
- A trace records behaviour under the scheduler that produced it, so replaying it elsewhere omits the arrival feedback loop.
- Benchmarking is the only method that captures cache, NUMA, interrupt, and locking effects.
- Always report distributions and tails, run to steady state, repeat runs, and change one variable at a time.

> 🧪 Practice
>
> 1. Run the simulation across quanta 1 to 64 and plot mean and p99 waiting time. Explain why they do not improve together.
> 2. Add a 10% fraction of very long jobs to the burst distribution and rerun. Which percentile moves most, and why?
> 3. Interview-style: "Why can a trace-driven simulation mislead you about an interactive workload?" *Hint: think about when the next request in the trace was actually issued, and what it depended on.*

#### Linux CFS Scheduler

**Theory**

Linux's **Completely Fair Scheduler**, introduced in 2.6.23 (2007), took a different approach from the multilevel feedback queues that preceded it. Rather than approximating fairness with priority levels and quanta, CFS models an **ideal multitasking CPU** that runs all *n* runnable tasks simultaneously at `1/n` of its speed, and then tracks how far each task has fallen behind that ideal.

The mechanism is **virtual runtime** (`vruntime`): the CPU time a task has consumed, weighted by its priority. The rule is then a single sentence — **always run the task with the lowest `vruntime`** — which is the one that has received least of its fair share. As it runs, its `vruntime` advances and it eventually stops being the minimum, at which point another task is selected.

The properties follow neatly:

- **No fixed time slices.** A task runs until it is no longer the most deprived. The effective slice is derived from the number of runnable tasks and a **target latency** (`sched_latency_ns`, default 24 ms, subject to `min_granularity` so slices never become absurdly small under heavy load).
- **Priorities are weights, not levels.** Nice values map to weights (nice 0 = 1024, each nice step is a factor of about 1.25), and `vruntime` advances *more slowly* for higher-weight tasks, so they naturally get more CPU. Each nice level is roughly a 10% change in CPU share.
- **I/O-bound tasks are favoured automatically.** A task that sleeps accumulates no `vruntime`, so on waking it is far behind and is scheduled promptly — interactivity emerges from the fairness rule rather than from a heuristic. (A sleeper's `vruntime` is floored to the minimum in the queue so it cannot hoard unbounded credit.)
- **Selection is O(log n)** using a red-black tree keyed by `vruntime`, with the leftmost node cached so picking the next task is O(1).

CFS also supports **group scheduling** via cgroups: fairness can be applied between *groups* (users, containers, services) before being applied within them, so 100 threads in one container cannot outcompete 1 thread in another. This is the basis of container CPU limits.

Worth knowing for currency: CFS was replaced as the default by **EEVDF** (Earliest Eligible Virtual Deadline First) in Linux 6.6. EEVDF keeps the virtual-time fairness accounting but adds an explicit per-task latency requirement and picks among eligible tasks by virtual deadline, improving latency for tasks that need it without special-case heuristics.

**Example**

```text
   The vruntime rule

   red-black tree keyed by vruntime; leftmost = least service received = run next

                       [vruntime 24]
                      /             \
              [18]                    [31]
             /    \                  /    \
        [12]      [20]          [27]      [40]
        /
   [ 8 ] <-- leftmost: RUN THIS ONE (cached, so selection is O(1))

   After it runs for delta, its vruntime advances by:

        delta_vruntime = delta x (NICE_0_WEIGHT / task_weight)

   nice  weight   effect on vruntime advance    relative CPU share
   ----  ------   -------------------------     ------------------
    -5    3121    advances 3x SLOWER            ~3x more CPU
     0    1024    baseline                      baseline
    +5     335    advances 3x FASTER            ~3x less CPU

   Why sleepers get scheduled promptly, with no heuristic

   CPU-bound task A: runs constantly, vruntime climbs to 5000
   Interactive B:    sleeps 200ms, vruntime stays at 4800
   B wakes -> B has the lower vruntime -> B runs immediately.
   Interactivity falls out of the fairness rule itself.

   Slice length is derived, not fixed

   target latency 24ms, 4 runnable tasks  -> ~6ms each
   target latency 24ms, 48 runnable tasks -> would be 0.5ms, so
   min_granularity (~3ms) takes over and the period stretches instead.
```

```c
/* The core of CFS, reduced to its essentials. */

/* 1. Charge the running task for the time it just used, scaled by weight. */
static void update_curr(struct cfs_rq *cfs_rq) {
    struct sched_entity *curr = cfs_rq->curr;
    u64 now = rq_clock_task(rq_of(cfs_rq));
    u64 delta_exec = now - curr->exec_start;

    curr->sum_exec_runtime += delta_exec;          /* real time consumed */
    curr->vruntime += calc_delta_fair(delta_exec, curr);
    /* calc_delta_fair scales by NICE_0_LOAD / se->load.weight:
       a heavier (lower nice) task accrues vruntime more slowly, so it
       stays "behind" longer and therefore receives more CPU.        */
    curr->exec_start = now;
}

/* 2. Pick the task with the smallest vruntime -- the leftmost tree node. */
static struct sched_entity *pick_next_entity(struct cfs_rq *cfs_rq) {
    return rb_entry(cfs_rq->rb_leftmost, struct sched_entity, run_node);
    /* Cached leftmost pointer makes selection O(1); insertion is O(log n). */
}

/* 3. Slice length is COMPUTED from the number of runnable tasks. */
static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se) {
    u64 period = __sched_period(cfs_rq->nr_running);   /* target latency,
                                                          stretched if crowded */
    return period * se->load.weight / cfs_rq->load.weight;   /* weighted share */
}
```

```bash
cat /proc/sys/kernel/sched_latency_ns          # target latency (default 24ms)
cat /proc/sys/kernel/sched_min_granularity_ns  # floor on a slice
cat /proc/<pid>/sched                          # this task's vruntime and stats
nice -n 10 ./background_job                    # lower weight: ~2.5x less CPU
systemd-run --scope -p CPUWeight=200 ./job     # cgroup group scheduling
```

**Key takeaways**

- CFS models an ideal CPU giving every task `1/n` of the machine, and always runs the task furthest behind.
- Virtual runtime is CPU time weighted by priority; nice values change the rate at which it accrues.
- Interactivity emerges from the rule itself — sleepers accumulate no vruntime and are scheduled promptly on waking.
- Selection uses a red-black tree with a cached leftmost node; group scheduling extends fairness to cgroups and containers.

> 🧪 Practice
>
> 1. Run two CPU-bound loops, one under `nice -n 0` and one under `nice -n 5`, and measure the CPU share each receives with `top`. Compare with the 1.25-per-level weight ratio.
> 2. Read `/proc/<pid>/sched` for a busy process and an idle one. Explain the difference in `vruntime`.
> 3. Interview-style: "How does CFS give an interactive process good response time without detecting that it is interactive?" *Hint: ask what happens to vruntime while a task sleeps.*

#### Windows and Solaris Scheduling

**Theory**

Comparing two other production schedulers shows how differently the same problem can be solved, and that all of them are variations on multilevel feedback with system-specific heuristics.

**Windows** uses a preemptive, priority-driven scheduler with **32 priority levels**, split into two ranges:

- **Levels 16-31: real-time.** Fixed priorities, never adjusted by the system. Round robin within each level.
- **Levels 1-15: variable (dynamic).** These are adjusted at run time. Level 0 is reserved for the zero-page thread.

A thread's base priority comes from combining its **process priority class** (Idle, Below Normal, Normal, Above Normal, High, Realtime) with its **relative thread priority** (Lowest through Highest). What makes it work interactively is the set of **priority boosts** applied by the kernel:

| Boost trigger | Effect |
|---|---|
| I/O completion | Boost by a device-specific amount (disk +1, keyboard +6, sound +8) |
| Waking from a wait on an event or semaphore | Small boost, decaying by one level per quantum |
| Foreground window's threads | Quantum tripled (not the priority) |
| Starvation detected by the balance set manager | Temporary boost to 15 with a doubled quantum, for a thread ready 300+ ticks |

The boosts decay one level per quantum until the base priority is reached — a thread never drops below its base. The anti-starvation boost is an explicit patch for the priority scheduler's known failure mode.

**Solaris** organises threads into **scheduling classes**, each with its own policy and a **dispatch table** that is data, not code:

| Class | Purpose |
|---|---|
| RT (real-time) | Highest, fixed priority |
| SYS (system) | Kernel threads, fixed priority, never time-sliced |
| TS (time sharing) | Default: MLFQ via dispatch table |
| IA (interactive) | Like TS, with a boost for the window with focus |
| FSS (fair share) | Share-based allocation between projects — the ancestor of cgroup fairness |
| FX (fixed priority) | Fixed, application-controlled |

The TS/IA dispatch table encodes the MLFQ rules as tunable data: for each of 60 priority levels it lists the quantum, the new priority if the quantum is used up (lower), and the new priority if the thread returns from sleep (higher). Changing scheduling behaviour is editing a table rather than modifying the kernel — an unusually clean expression of the policy/mechanism separation from 4.1.

The common thread across Linux, Windows, and Solaris: all three are variations on multilevel feedback, all favour I/O-bound work, all include an explicit anti-starvation mechanism, and all separate real-time from normal classes.

**Example**

```text
   WINDOWS: 32 priority levels

   31 +---------------------------+
      |  REAL-TIME (16-31)        |  fixed; never boosted or decayed
   16 +---------------------------+
   15 |  VARIABLE (1-15)          |  boosted on I/O completion and wakeup,
      |                           |  decaying one level per quantum
      |    base priority  ------  |  <- never falls below this
    1 +---------------------------+
    0 |  zero-page thread         |

   Boost and decay of an interactive thread (base 8)

   priority
     14 |        *                       disk I/O completes: +1
     13 |          *                     keyboard input: +6
     12 |            *
     ...|              *   *
      8 |------------------- * * * * *   returns to base, never below
        +--------------------------------> time (one decay per quantum)

   SOLARIS: the TS dispatch table (data, not code)

   priority | quantum | pri if quantum used up | pri after sleep
   ---------+---------+------------------------+-----------------
      0     |  200ms  |          0             |       50
      5     |  200ms  |          0             |       50
     10     |  160ms  |          0             |       51
     ...    |         |                        |
     50     |   40ms  |         40             |       58
     59     |   20ms  |         49             |       59
              ^         ^                        ^
     high priority =   using it all demotes;   sleeping promotes:
     SHORT quantum     CPU-bound sinks         interactive rises
```

```text
   The three production schedulers side by side

                   | Linux (CFS/EEVDF) | Windows           | Solaris
   ----------------+-------------------+-------------------+------------------
   Core idea       | virtual-time      | 32 priority       | classes with
                   | fairness          | levels + boosts   | dispatch tables
   Interactivity   | emerges from      | explicit boosts   | table promotes
                   | vruntime          | per device type   | on sleep
   Anti-starvation | fairness is       | balance set       | table + FSS
                   | inherent          | manager boost     |
   Real-time       | SCHED_FIFO/RR/    | levels 16-31      | RT class
                   | DEADLINE          |                   |
   Group fairness  | cgroups           | job objects       | FSS class
   Tuning          | sysctl knobs      | registry/API      | edit the table
```

```bash
# Linux
chrt -p $$ ; nice -n 5 ./job ; cat /proc/sys/kernel/sched_latency_ns

# Windows (PowerShell)
# Get-Process chrome | Select-Object Name, PriorityClass
# (Get-Process notepad).PriorityClass = "AboveNormal"

# Solaris / illumos
# priocntl -l                    # list scheduling classes and priority ranges
# dispadmin -c TS -g             # dump the time-sharing dispatch table
# priocntl -s -c FSS -p 20 -i pid
```

**Key takeaways**

- Windows uses 32 levels split into fixed real-time (16-31) and dynamically boosted variable priorities (1-15).
- Windows boosts on I/O completion and wakeup, decaying one level per quantum but never below the base priority.
- Solaris expresses its multilevel feedback policy as an editable dispatch table, cleanly separating policy from mechanism.
- All three production schedulers are multilevel-feedback variants that favour I/O-bound work, guard against starvation, and isolate real-time classes.

> 🧪 Practice
>
> 1. Build the comparison table yourself for Linux, Windows, and Solaris across: default policy, interactivity mechanism, anti-starvation, and real-time support.
> 2. Explain why Windows boosts keyboard I/O completion (+6) far more than disk I/O completion (+1).
> 3. Interview-style: "What advantage does Solaris get from putting its scheduling policy in a table rather than in code?" *Hint: recall the policy/mechanism separation, and ask who can change behaviour without a recompile.*

---

<a id="5-synchronization"></a>
## 5. Synchronization

Chapter 3 gave threads a shared address space, which makes cooperation cheap and correctness fragile: two threads touching the same data at the same time can produce results that no sequential execution could ever produce. This chapter defines that hazard precisely, works up from the hardware instructions that make any solution possible to the primitives programmers actually use, applies them to the classic problems that every synchronization mechanism is measured against, and closes with the approaches that avoid locks altogether. Getting this material right is what separates a program that works from one that works until it is busy.

<a id="51-the-critical-section-problem"></a>
### 5.1 The Critical Section Problem

This section states the problem formally: what goes wrong when threads share data, what any correct solution must guarantee, and what a purely software solution looks like.

#### Race Conditions

**Theory**

A **race condition** exists when the result of a computation depends on the relative timing of concurrent operations. The program is not merely slow or occasionally wrong — it has no single defined behaviour, and the same input can produce different output on different runs.

The reason is that operations which look atomic in source code are not atomic in hardware. Consider the most famous example, `counter++`. In C or Java it is one expression; on the machine it is three separate steps:

1. **Load** the value from memory into a register.
2. **Increment** the register.
3. **Store** the register back to memory.

A thread can be preempted between any two of these (Chapter 4), or two cores can execute them genuinely simultaneously (Chapter 3). If two threads each increment a counter of 10, the interleaving `load(10), load(10), add, add, store(11), store(11)` produces 11 instead of 12. One update is silently lost.

Three properties make race conditions uniquely nasty:

- **They are intermittent.** The bad interleaving may occur once in millions of executions, so the bug passes testing and appears in production under load.
- **They are timing-sensitive.** Adding a print statement, attaching a debugger, or running on a slower machine changes the timing and can hide the bug — the "Heisenbug" effect.
- **They corrupt silently.** A lost update produces no error, no exception, and no log entry. The data is simply wrong.

The precondition for a race is specific and worth memorising: **two or more threads access the same memory location, at least one access is a write, and the accesses are not ordered by synchronization.** Remove any of those three and there is no race — which is why immutable data and thread-confined data need no locks at all.

Analogy: two people editing the same paragraph of a shared document by loading it into their own editor, changing it, and saving. Both saw the original; the second save overwrites the first. No error is reported, and the first person's edit simply vanishes.

**Example**

```text
   counter++ is three machine operations, not one

   Thread A                    memory        Thread B
   --------                    ------        --------
   load  r1 <- counter (10)      10
                                 10          load  r2 <- counter (10)
   add   r1 <- r1 + 1  (11)      10
                                 10          add   r2 <- r2 + 1  (11)
   store counter <- r1           11
                                 11          store counter <- r2  (11)
                                 ^
                        Final value 11. Expected 12. One update LOST.

   A correct interleaving, for contrast:

   Thread A                    memory        Thread B
   load  r1 <- 10                10
   add   r1 = 11                 10
   store counter <- 11           11
                                 11          load  r2 <- 11
                                 11          add   r2 = 12
                                 12          store counter <- 12

   The hardware permits BOTH. Without synchronization you get whichever
   the scheduler and the memory system happen to produce.
```

```java
public class LostUpdate {
    private static int counter = 0;              // shared, unsynchronised

    public static void main(String[] args) throws InterruptedException {
        Runnable task = () -> {
            for (int i = 0; i < 1_000_000; i++) {
                counter++;                       // load, add, store: 3 steps,
                                                 // interruptible between any two
            }
        };

        Thread t1 = new Thread(task);
        Thread t2 = new Thread(task);
        t1.start(); t2.start();
        t1.join();  t2.join();

        // Expected 2,000,000. Actual: some smaller, unpredictable number,
        // different on each run and on each machine.
        System.out.println("counter = " + counter);
    }
}
```

```python
# The same defect, and the three conditions that create it.
import threading

balance = 1000                      # (1) shared location

def withdraw(amount):
    global balance
    if balance >= amount:           # CHECK
        # A thread can be preempted right here. Both threads passed the check
        # while the balance was still 1000.
        balance -= amount           # (2) at least one access is a WRITE
                                    # (3) no synchronization orders them
threads = [threading.Thread(target=withdraw, args=(800,)) for _ in range(2)]
for t in threads: t.start()
for t in threads: t.join()
print(balance)          # can be -600: both withdrawals passed the check.
                        # This class of bug is called check-then-act.
```

**Key takeaways**

- A race condition makes a program's result depend on timing, so it has no single defined behaviour.
- Operations that look atomic in source code (`counter++`) are multi-step at the machine level and interruptible.
- A race requires three things: shared access, at least one write, and no synchronization ordering them.
- Races are intermittent, timing-sensitive, and silent, which is why they survive testing and appear under production load.

> 🧪 Practice
>
> 1. Run the Java example several times and record the results. Explain why the value differs between runs and why it is always at most 2,000,000.
> 2. Identify the race in this pair of lines executed by two threads: `if (map.get(k) == null) map.put(k, v);`. Name the pattern.
> 3. Interview-style: "A bug disappears when you add a logging statement. What does that tell you?" *Hint: consider what logging does to timing and to the width of the vulnerable window.*

#### Mutual Exclusion Requirements

**Theory**

Since the hazard is concurrent access to shared data, the remedy is to ensure that only one thread at a time executes the code that touches it. That code is a **critical section**, and the general structure of any solution is fixed:

```text
do {
    entry section       // request permission to enter
        critical section    // access the shared data
    exit section        // release permission
        remainder section   // everything else
} while (true);
```

**Mutual exclusion** is the first and most important requirement: *if one thread is executing in its critical section, no other thread may execute in its critical section.* Everything else in this chapter is machinery for achieving that property efficiently and without introducing new failures.

Two points are commonly misunderstood and worth being precise about:

- **Mutual exclusion is a property of the data, not of the code.** Two different functions that modify the same structure are in the *same* critical section and must exclude each other. Conversely, two threads running the identical function on *different* data need no exclusion at all. This is why locks are conceptually attached to data — the lock protects an invariant, not a block of text.
- **The critical section should be as short as possible.** While one thread holds exclusive access, every other thread that needs the data is stalled. A long critical section serialises the program and destroys the parallelism Chapter 3 worked to obtain. Do expensive, blocking, or I/O-bound work *outside* it.

Any solution must also operate under realistic assumptions: threads execute at nonzero but otherwise unpredictable speeds, no assumptions may be made about the number of cores or the scheduler's choices, and a thread may be preempted anywhere — including inside the entry section itself.

Finally, the discipline is only as strong as its weakest participant. A lock protects data **only if every accessor uses it**. One function that touches the structure without taking the lock reintroduces the race for everybody — which is why access to shared state is normally encapsulated behind an interface that takes the lock internally.

Analogy: a meeting room with one key. Exclusion works only if everyone who needs the room takes the key; a single person who climbs in through the window makes the whole protocol meaningless.

**Example**

```text
   The four sections, and where the danger lies

   +-------------------+
   |  entry section    |  <- request permission; may block here
   +-------------------+
   |  CRITICAL SECTION |  <- at most ONE thread here at a time
   |  (touch shared    |     keep it SHORT: everyone else is waiting
   |   data)           |
   +-------------------+
   |  exit section     |  <- release permission; must always run
   +-------------------+
   |  remainder        |  <- unrelated work; full concurrency here
   +-------------------+

   Exclusion is per-DATA, not per-function

   deposit()   --+
                 +--> both modify `balance` -> SAME critical section
   withdraw()  --+     they must exclude each other

   process(order_A)  and  process(order_B)   -> different data,
                                                no exclusion needed

   Critical section length

   BAD                                GOOD
   lock()                             data = compute_expensive()   // outside
     data = compute_expensive()       result = fetch_from_disk()   // outside
     result = fetch_from_disk()       lock()
     shared.update(data, result)        shared.update(data, result) // short
   unlock()                           unlock()
   -> holds the lock for milliseconds -> holds it for nanoseconds
```

```python
import threading

class Account:
    """Encapsulation is what makes the discipline enforceable: callers cannot
       touch `_balance` without going through a method that takes the lock."""

    def __init__(self, initial=0):
        self._balance = initial
        self._lock = threading.Lock()      # the lock belongs to the DATA

    def deposit(self, amount):
        expensive = self._audit_record(amount)   # entry: do slow work OUTSIDE
        with self._lock:                         # entry section
            self._balance += amount              # critical section: short
        return expensive                         # exit is automatic (with)

    def withdraw(self, amount):
        with self._lock:                   # SAME lock: deposit and withdraw
            if self._balance < amount:     # are one critical section because
                return False               # they touch the same data
            self._balance -= amount
            return True

    @property
    def balance(self):
        with self._lock:                   # even READS need the lock, or they
            return self._balance           # can observe a torn/stale value
```

**Key takeaways**

- Every solution has the same shape: entry section, critical section, exit section, remainder.
- Mutual exclusion means at most one thread executes in its critical section at a time.
- Exclusion is a property of the shared data: different functions touching the same data share one critical section.
- Critical sections must be short, and the protocol only works if every accessor participates — hence encapsulation.

> 🧪 Practice
>
> 1. Identify the critical sections in a linked-list implementation with `insert`, `delete`, and `search`. Which must exclude which?
> 2. Rewrite a function that holds a lock across a network call so the lock covers only the shared-state update.
> 3. Interview-style: "Is it safe for a getter to read a shared integer without the lock?" *Hint: consider visibility across cores and multi-word values, not just torn reads.*

#### Progress and Bounded Waiting

**Theory**

Mutual exclusion alone is trivially satisfiable — a solution that lets *nobody* enter the critical section excludes perfectly and is useless. Two liveness requirements rule out such degenerate answers, and together with mutual exclusion they form the complete specification of the critical-section problem.

**Progress.** If no thread is in its critical section and some threads wish to enter, then only those threads that are *not* in their remainder section may participate in deciding who enters next, and the decision cannot be postponed indefinitely.

Two clauses matter here. First, a thread that is uninterested — off doing unrelated work in its remainder — must not be able to block an interested thread. A solution where "it is B's turn" prevents A from entering even though B is not asking is a progress violation, and it is the exact defect of the naive turn-taking algorithm. Second, the decision must actually be reached in finite time; the system may not deadlock while the critical section stands empty.

**Bounded waiting.** There must exist a bound on the number of times other threads are allowed to enter their critical sections after a thread has requested entry and before that request is granted.

This rules out **starvation**. Progress guarantees *someone* gets in; bounded waiting guarantees *everyone eventually* gets in. Without it, a thread could lose the race indefinitely while others repeatedly enter — a live system in which one participant makes no progress. Note the requirement is only that a bound *exists*, not that it be small; a fair queue gives a bound of n-1, which is the practical target.

The three properties are independent, and it is instructive to see how each can fail alone:

| Property violated | Symptom |
|---|---|
| Mutual exclusion | Data corruption; the race is not prevented |
| Progress | Deadlock, or an uninterested thread blocking an interested one |
| Bounded waiting | Starvation; one thread waits forever while others proceed |

Analogy: mutual exclusion is "one person in the room at a time". Progress is "if the room is empty and someone is waiting, the door opens" — and someone who has gone home does not get a vote. Bounded waiting is "you will not be skipped an unlimited number of times".

**Example**

```text
   The three requirements, and a violation of each

   1. MUTUAL EXCLUSION  -- at most one thread in the CS
      violated: |== A in CS ==|
                    |== B in CS ==|      overlap -> corruption

   2. PROGRESS -- an empty CS plus a waiter must lead to entry
      violated by strict alternation:

        turn = 0
        A enters, exits, goes to its remainder (long computation)
        B wants to enter -> waits for turn == 1 ... which only A can set
        CS is EMPTY, B is waiting, and A is not even interested.
        -> progress violated

   3. BOUNDED WAITING -- a limit on how often others may overtake you
      violated: A requests entry
                B enters, exits, re-enters, exits, re-enters ... forever
                A never gets in although the system is making progress.
                -> starvation

   Correct behaviour

   A requests --> at most (n-1) other entries --> A enters
```

```python
# A deliberately broken solution: mutual exclusion holds, progress does not.
turn = 0                        # whose turn it is

def thread_0():
    global turn
    while True:
        while turn != 0:        # entry section: spin until it is my turn
            pass
        critical_section()
        turn = 1                # exit: hand the turn to the other thread
        remainder_0()           # <-- if this takes an hour, thread_1 can run
                                #     exactly once more and then blocks forever

def thread_1():
    global turn
    while True:
        while turn != 1:
            pass
        critical_section()
        turn = 0
        remainder_1()

# Mutual exclusion: SATISFIED (turn has one value, so only one can proceed).
# Progress:        VIOLATED  (strict alternation forces an uninterested
#                             thread to act before an interested one can enter).
# Bounded waiting: satisfied (the bound is 1) -- correctness needs ALL THREE.
```

**Key takeaways**

- A correct solution must provide mutual exclusion, progress, and bounded waiting; the three are independent.
- Progress forbids threads in their remainder section from influencing who enters, and forbids indefinite postponement.
- Bounded waiting forbids starvation by capping how many times others may enter ahead of a waiting thread.
- Strict alternation satisfies mutual exclusion but violates progress, which is why it is not a solution.

> 🧪 Practice
>
> 1. For the strict-alternation code above, construct a concrete execution that leaves thread 1 blocked while the critical section is empty.
> 2. Design a solution that satisfies mutual exclusion and progress but violates bounded waiting, and describe the starving execution.
> 3. Interview-style: "Why is 'nobody may ever enter' not an acceptable solution?" *Hint: name which of the three requirements it satisfies and which it destroys.*

#### Peterson's Solution

**Theory**

**Peterson's solution** (1981) is the classic proof that the critical-section problem can be solved in software alone, for two threads, using only ordinary loads and stores. Its value today is pedagogical rather than practical, and both halves of that statement are worth understanding.

It combines two ideas that fail individually:

- A **flag** array: `flag[i] = true` announces "thread i wants to enter". Flags alone deadlock — both threads can set their flag and then wait for the other forever.
- A **turn** variable: strict alternation. Turn alone violates progress, as shown above.

Peterson's insight is to use the flag to express *intent* and the turn to break *ties*, with one counter-intuitive detail: on entry, a thread sets `turn` to the **other** thread's index. Each politely yields, so whichever writes `turn` last loses the tie and waits. Since `turn` holds exactly one value, exactly one thread proceeds.

The entry condition — `while (flag[other] && turn == other)` — requires both clauses. A thread waits only if the other both wants in *and* holds the turn. If the other is uninterested, `flag[other]` is false and entry is immediate, which is precisely what fixes the progress violation of strict alternation.

All three requirements hold, and each can be argued directly: mutual exclusion, because both threads can only be inside if `turn` were simultaneously 0 and 1; progress, because an uninterested thread's flag is false; and bounded waiting, because after a thread exits it sets its flag false, so the waiter enters before the exiting thread could re-enter and re-take the turn — a bound of one.

The reason it is not used in practice is the important lesson: **Peterson's solution assumes sequential consistency, and no modern processor provides it.** Both CPUs and compilers reorder memory operations. If the write to `flag[i]` becomes visible to the other core *after* the read of `flag[other]`, both threads can enter simultaneously. Making it work on real hardware requires memory barriers and atomic operations — the subject of 5.2 — at which point the hardware primitives are simpler and faster than the algorithm they were added to rescue.

**Example**

```text
   Peterson's entry protocol for two threads

   Thread i:                              Thread j:
     flag[i] = true;                        flag[j] = true;
     turn = j;          // yield to j       turn = i;        // yield to i
     while (flag[j] && turn == j)           while (flag[i] && turn == i)
         ;              // wait                 ;
     CRITICAL SECTION                       CRITICAL SECTION
     flag[i] = false;                       flag[j] = false;

   Why exactly one proceeds

   Both set their flag        -> both want in
   Both write turn            -> the LAST write wins and that thread WAITS
   turn holds ONE value       -> the other thread's condition is false
                              -> exactly one enters

   Why an uninterested thread does not block anyone

   flag[j] == false  ->  the while condition is false immediately
                     ->  thread i enters without consulting `turn` at all
                     ->  progress restored (this is what strict alternation lacked)

   Why it BREAKS on real hardware

   Thread i writes flag[i]=true   |  store buffered, not yet visible to core j
   Thread i reads flag[j]         |  reads STALE false
   Thread j writes flag[j]=true   |  store buffered
   Thread j reads flag[i]         |  reads STALE false
   -> BOTH enter the critical section. Mutual exclusion lost to reordering.
```

```c
/* Peterson's solution -- correct on paper, broken on a real CPU
   unless the marked barriers are present. */
#include <stdatomic.h>
#include <stdbool.h>

static atomic_bool flag[2] = {false, false};   /* "I want to enter"  */
static atomic_int  turn;                       /* tie-breaker        */

void enter_critical(int self) {
    int other = 1 - self;

    atomic_store(&flag[self], true);           /* 1. announce intent */
    atomic_store(&turn, other);                /* 2. politely yield the turn */

    /* Without sequentially consistent atomics (or an explicit
       atomic_thread_fence(memory_order_seq_cst) here), the CPU may reorder
       the store above past the load below, and BOTH threads enter. */
    while (atomic_load(&flag[other]) && atomic_load(&turn) == other)
        ;                                      /* 3. wait only if the other
                                                     wants in AND holds the turn */
}

void leave_critical(int self) {
    atomic_store(&flag[self], false);          /* release: bound of one */
}
```

```python
# The same algorithm, showing why it does not generalise past two threads.
# Peterson's is inherently 2-thread. The n-thread software solutions
# (Lamport's Bakery, Eisenberg-McGuire) are considerably more complex --
# another reason hardware support won.
class Peterson:
    def __init__(self):
        self.flag = [False, False]
        self.turn = 0

    def lock(self, me):
        other = 1 - me
        self.flag[me] = True          # intent
        self.turn = other             # yield: last writer waits
        while self.flag[other] and self.turn == other:
            pass                      # spin

    def unlock(self, me):
        self.flag[me] = False
```

**Key takeaways**

- Peterson's solution proves the problem is solvable in software alone, for two threads, with plain loads and stores.
- Flags express intent and the turn variable breaks ties; a thread yields the turn to the other on entry.
- It satisfies all three requirements, with a bounded waiting bound of one.
- It fails on real hardware because CPUs and compilers reorder memory operations, which is why hardware primitives are used instead.

> 🧪 Practice
>
> 1. Trace Peterson's solution with both threads calling `lock` simultaneously, and show that exactly one enters.
> 2. Explain why setting `turn = self` instead of `turn = other` breaks the algorithm. Construct the failing execution.
> 3. Interview-style: "Peterson's solution is provably correct. Why does no operating system use it?" *Hint: the proof assumes a memory model that no shipping processor implements.*

<a id="52-hardware-support"></a>
### 5.2 Hardware Support

Peterson's solution failed on real machines because the hardware does not execute memory operations in program order; this section covers the instructions processors provide to make correct synchronization possible at all.

#### Memory Barriers

**Theory**

Programmers imagine memory operations happen in the order written, and every core sees the same order. That model — **sequential consistency** — is what Peterson's solution assumed, and no modern processor provides it, because enforcing it would forfeit most of the performance of the last thirty years of CPU design.

Reordering happens at three levels, and all three must be considered:

- **The compiler** reorders and eliminates memory accesses during optimisation, hoisting loads out of loops and sinking stores.
- **The processor** executes out of order and uses store buffers: a write sits in a per-core buffer before reaching cache, so the writing core sees it immediately while other cores do not.
- **The cache system** propagates invalidations asynchronously, so different cores can observe writes in different orders.

A **memory model** specifies which reorderings are permitted. x86-64 uses **TSO** (total store order), which is relatively strong — it only allows a store to be reordered past a *later* load. ARM and POWER are far weaker and permit almost any reordering. Code that is accidentally correct on x86 frequently breaks on ARM, which is a common and expensive surprise.

A **memory barrier** (or fence) is an instruction that forbids reordering across it. The usual forms:

| Barrier | Guarantees |
|---|---|
| **Store barrier** (`sfence`) | All stores before it are visible before any store after it |
| **Load barrier** (`lfence`) | All loads before it complete before any load after it |
| **Full barrier** (`mfence`) | Both, in both directions |
| **Acquire** | No later operation moves before this one (used when taking a lock) |
| **Release** | No earlier operation moves after this one (used when releasing a lock) |

Acquire/release is the pairing that matters in practice: a lock acquisition is an *acquire* barrier and a lock release is a *release* barrier, and together they guarantee that everything a thread did inside a critical section is visible to the next thread that acquires the same lock. This is precisely why correctly locked code needs no explicit fences — **the locking primitives contain them**.

Analogy: a barrier is a checkpoint on a production line. Work items may otherwise be reordered freely for efficiency, but nothing crosses the checkpoint out of order.

**Example**

```text
   Why store buffers break intuition (the classic "store buffer" litmus test)

   initially x = 0, y = 0

   Core 0:              Core 1:
     x = 1;               y = 1;
     r1 = y;              r2 = x;

   Intuition: r1 == 0 && r2 == 0 is impossible -- one store must land first.
   Reality on x86 (TSO): BOTH stores sit in per-core store buffers while
   both loads read from cache. r1 == 0 && r2 == 0 DOES occur.

     core0 store buffer: [x=1]        core1 store buffer: [y=1]
     core0 reads y from cache -> 0    core1 reads x from cache -> 0

   Fix: a full barrier between the store and the load on both cores.

   Memory model strength

   stronger  x86-64 (TSO)     : only store->load reordering allowed
             ARM64            : almost anything, unless barriers are used
   weaker    POWER            : weakest of the mainstream architectures

   Code that "works" on x86 and fails on ARM is a standard porting bug.

   Acquire / release pairing

   Thread A                          Thread B
     data = 42;                        while (!flag.load(acquire))
     flag.store(true, release);            ;
     ^                                 read(data);   // guaranteed to see 42
     nothing above may sink below      ^
                                       nothing below may rise above
```

```c
#include <stdatomic.h>

int data = 0;
atomic_bool ready = false;

void producer(void) {
    data = 42;                                        /* ordinary write      */
    atomic_store_explicit(&ready, true,
                          memory_order_release);      /* RELEASE barrier:
                                                         the write to `data`
                                                         cannot sink below   */
}

void consumer(void) {
    while (!atomic_load_explicit(&ready, memory_order_acquire))
        ;                                             /* ACQUIRE barrier:
                                                         the read below
                                                         cannot rise above   */
    printf("%d\n", data);                             /* guaranteed to be 42 */
}

/* Without the release/acquire pair, the consumer may observe ready == true
   while `data` is still 0: the two writes can become visible out of order. */
```

```java
public class Visibility {
    // `volatile` in Java gives release semantics on write and acquire on read.
    private volatile boolean ready = false;
    private int data = 0;

    void producer() {
        data = 42;
        ready = true;      // volatile write: a release barrier
    }

    void consumer() {
        while (!ready) { } // volatile read: an acquire barrier
        assert data == 42; // guaranteed by the happens-before edge
    }
    // Remove `volatile` and the JIT may hoist the read of `ready` out of the
    // loop entirely, producing an infinite loop even on a strong CPU.
}
```

**Key takeaways**

- No modern processor provides sequential consistency; compilers, CPUs, and caches all reorder memory operations.
- Memory models differ by architecture: x86-64 (TSO) is strong, ARM and POWER are much weaker.
- Barriers forbid reordering across a point; acquire and release are the pairing used by locks.
- Correctly locked code needs no explicit barriers because lock acquire and release contain them.

> 🧪 Practice
>
> 1. Write the store-buffer litmus test with two threads in a loop and count how often `r1 == 0 && r2 == 0` occurs on your machine.
> 2. Remove `volatile` from the Java example and run it. Explain the hang in terms of compiler optimisation, not CPU reordering.
> 3. Interview-style: "Code passes all tests on an x86 CI runner and deadlocks on ARM servers. Where do you look?" *Hint: name the property x86 provides for free that ARM does not.*

#### Atomic Instructions

**Theory**

Software alone cannot solve the critical-section problem efficiently, because the problem is fundamentally that read-modify-write sequences are interruptible. The hardware answer is an instruction that performs a read, a modification, and a write **as one indivisible operation**: no other core can observe or interleave with the intermediate state.

Atomicity is enforced at the cache-coherence level. To execute an atomic instruction, a core acquires exclusive ownership of the target cache line and holds it for the duration of the operation. Other cores requesting that line are made to wait. (Historically this was implemented by locking the entire memory bus, which is why x86 uses the `lock` instruction prefix; modern implementations use cache-line locking, which is far cheaper but not free.)

The common atomic primitives:

| Instruction | Operation | Typical use |
|---|---|---|
| **Test-and-set** | Set to 1, return the old value | Simple locks |
| **Compare-and-swap** | If value == expected, set to new; return success | General-purpose, lock-free structures |
| **Fetch-and-add** | Add and return the previous value | Counters, ticket locks |
| **Exchange** | Swap a register with memory | Simple locks, ownership transfer |
| **Load-linked / store-conditional** | Load, then store only if untouched since | ARM/RISC-V/POWER equivalent of CAS |

Two properties are worth internalising:

- **Atomic instructions imply memory barriers** on most architectures (or accept an explicit ordering argument, as in C++ and Rust). This is what makes them usable as synchronization rather than merely as indivisible arithmetic.
- **They are not free.** An uncontended atomic operation costs roughly 10-50 cycles versus about 1 for a normal store. Under contention it is much worse: the cache line ping-pongs between cores, and each transfer costs a coherence round trip. A hot atomic counter shared by 16 cores can be slower than a mutex, because every increment invalidates 15 caches.

The theoretical hierarchy is worth knowing: not all atomic operations are equally powerful. Test-and-set can build a lock but cannot implement wait-free consensus for more than two threads; compare-and-swap can do so for any number. This is Herlihy's consensus hierarchy, and it is why CAS is the primitive every modern lock-free algorithm is built on.

**Example**

```text
   What "atomic" means at the cache level

   WITHOUT atomicity (three separate operations)
     core0: load 10 -----+
     core1: load 10 -----+---> both see 10, both store 11: one update lost
     core0: store 11
     core1: store 11

   WITH an atomic instruction
     core0: [ acquire exclusive ownership of the line ]
            [ load 10, add 1, store 11                ] indivisible
            [ release ]
     core1: ... waits for the line ... then load 11, add 1, store 12
     Result: 12. Correct.

   Cost of contention: cache line ping-pong

   1 thread   : ~20 cycles per atomic op
   2 threads  : ~50 cycles   (line bounces between two cores)
   16 threads : ~500+ cycles (every op invalidates 15 other caches)

   This is why "just use an atomic counter" can be SLOWER than a mutex
   at high thread counts, and why sharded/per-CPU counters exist.

   Consensus hierarchy (how many threads an operation can coordinate)

   atomic read/write .................. 1
   test-and-set, fetch-and-add ........ 2
   compare-and-swap ................... infinite   <- why CAS is universal
```

```c
#include <stdatomic.h>
#include <stdio.h>

atomic_int counter = 0;

void increment_atomic(void) {
    atomic_fetch_add(&counter, 1);       /* ONE indivisible read-modify-write.
                                            Compiles to `lock xadd` on x86.   */
}

/* The same thing, spelled out, to show what the hardware guarantees. */
void increment_by_cas(void) {
    int expected = atomic_load(&counter);
    while (!atomic_compare_exchange_weak(&counter, &expected, expected + 1)) {
        /* CAS failed: another thread changed `counter` between our load and
           our attempt. `expected` was updated with the current value by the
           call itself, so we simply retry with fresh information.
           This retry loop is the shape of EVERY lock-free algorithm. */
    }
}

int main(void) {
    /* Relaxed ordering: atomic, but with NO barrier. Fine for a statistics
       counter whose value is not used to order other memory accesses. */
    atomic_fetch_add_explicit(&counter, 1, memory_order_relaxed);
    printf("%d\n", atomic_load(&counter));
    return 0;
}
```

```text
   x86-64 assembly for the two forms

   counter++            (NOT atomic)      atomic_fetch_add(&counter, 1)
   -------------------------------        -----------------------------
   mov  eax, [counter]                    lock xadd [counter], eax
   add  eax, 1                            ^^^^
   mov  [counter], eax                    the LOCK prefix makes the whole
   ^ interruptible between any two        read-modify-write indivisible
```

**Key takeaways**

- Atomic instructions perform read-modify-write indivisibly by taking exclusive ownership of the cache line.
- On most architectures they also act as memory barriers, which is what makes them usable for synchronization.
- They cost 10-50 cycles uncontended and far more under contention, as the cache line bounces between cores.
- Compare-and-swap is universal in the consensus hierarchy, which is why lock-free algorithms are built on it.

> 🧪 Practice
>
> 1. Benchmark 10 million increments using a plain `int`, an `atomic_int`, and a mutex, at 1, 4, and 16 threads. Explain the crossover.
> 2. Explain when `memory_order_relaxed` is safe, and give one example where using it is a bug.
> 3. Interview-style: "Why can an atomic counter be slower than a mutex under heavy contention?" *Hint: think about what happens to the cache line on every single operation.*

#### Test-and-Set

**Theory**

**Test-and-set** is the simplest useful atomic instruction: it writes `true` into a memory location and returns whatever was there before, indivisibly.

Its use as a lock follows immediately. A thread repeatedly executes test-and-set on a shared boolean. If the returned value is `false`, the lock was free and this thread has just claimed it — the write already happened, atomically, so no one else can have claimed it in between. If the returned value is `true`, someone else holds it, and the thread retries. Unlocking is a plain store of `false`.

The correctness argument is short and worth appreciating: exactly one thread can receive `false` from a location that transitions from `false` to `true`, because the transition happens once and the operation is indivisible.

Its limitations are equally clear:

- **No bounded waiting.** Every waiter races on each release, and nothing prevents the same unlucky thread from losing every time. It satisfies mutual exclusion and progress but not the third requirement of 5.1. A ticket lock or a queue-based lock fixes this by imposing FIFO order.
- **Cache-line hammering.** The naive loop performs an atomic *write* on every iteration, which invalidates the line in every other core's cache. Ten spinning threads generate continuous coherence traffic that slows the lock *holder* — so contention makes the critical section itself slower.

The standard mitigation is **test-and-test-and-set** (TTAS): spin on an ordinary *read* until the lock appears free, and only then attempt the atomic operation. Reads can be served from each core's own cache without invalidating anything, so waiting threads become nearly silent, and the expensive atomic is attempted only when it has a chance of succeeding. Adding **exponential backoff** between attempts reduces the thundering herd further.

Analogy: test-and-set is grabbing a door handle and being told whether it was already turned. TTAS is watching the handle from across the room and only walking over when it looks free.

**Example**

```text
   Test-and-set semantics (all of it, indivisibly)

   bool test_and_set(bool *target) {
       bool old = *target;
       *target  = true;
       return old;          // false means "it was free and is now MINE"
   }

   Two threads racing for a free lock

   lock = false
   A: test_and_set -> returns false, lock is now true  -> A ENTERS
   B: test_and_set -> returns true,  lock stays true   -> B SPINS
   A: lock = false (release)
   B: test_and_set -> returns false                    -> B ENTERS

   TAS vs TTAS cache traffic with 8 spinning threads

   TAS  : every waiter issues an atomic WRITE every iteration
          -> the line is invalidated in 7 caches, 8 times per loop
          -> coherence storm; even the LOCK HOLDER runs slower

   TTAS : waiters issue ordinary READS from their own cache
          -> zero coherence traffic while the lock is held
          -> one burst of atomics only when the lock is released
```

```c
#include <stdatomic.h>

atomic_flag lock = ATOMIC_FLAG_INIT;

/* --- Naive test-and-set spinlock --- */
void tas_acquire(void) {
    while (atomic_flag_test_and_set(&lock))
        ;                    /* an atomic WRITE every iteration:
                                hammers the cache line for all cores */
}

void tas_release(void) {
    atomic_flag_clear(&lock);
}

/* --- Test-and-test-and-set: the version you should actually write --- */
atomic_bool lock2 = false;

void ttas_acquire(void) {
    for (;;) {
        while (atomic_load_explicit(&lock2, memory_order_relaxed))
            cpu_relax();                    /* spin on a plain READ:
                                               served from the local cache,
                                               generates no coherence traffic.
                                               cpu_relax() = PAUSE on x86,
                                               YIELD on ARM: hints to the core
                                               that this is a spin loop        */

        if (!atomic_exchange_explicit(&lock2, true, memory_order_acquire))
            return;                         /* only NOW pay for the atomic,
                                               and only when it may succeed   */
    }
}

void ttas_release(void) {
    atomic_store_explicit(&lock2, false, memory_order_release);
}
```

```python
# Why test-and-set alone cannot guarantee bounded waiting.
#
#   lock free -> threads A, B, C all attempt test_and_set
#   whichever the hardware serves first wins; the others retry
#   nothing records that A has been waiting longest
#
#   A can lose to B and C indefinitely: mutual exclusion and progress
#   hold, but A starves.
#
# The fix is to impose an order -- a ticket lock:
class TicketLock:
    def __init__(self):
        self.next_ticket = 0      # atomic fetch-and-add in real code
        self.now_serving = 0

    def acquire(self):
        my = self.next_ticket     # atomically take a number
        self.next_ticket += 1
        while self.now_serving != my:   # wait for YOUR number: strict FIFO,
            pass                        # so waiting is bounded by n-1
        return my

    def release(self):
        self.now_serving += 1
```

**Key takeaways**

- Test-and-set writes `true` and returns the previous value atomically; receiving `false` means the lock was acquired.
- It gives mutual exclusion and progress but not bounded waiting, so threads can starve.
- The naive spin loop performs an atomic write per iteration, flooding the interconnect and slowing the lock holder.
- Test-and-test-and-set spins on a plain read and attempts the atomic only when the lock looks free.

> 🧪 Practice
>
> 1. Implement both TAS and TTAS spinlocks and benchmark them with 2, 8, and 32 threads. Explain the divergence.
> 2. Show an execution in which a thread starves under a TAS lock, and explain how a ticket lock prevents it.
> 3. Interview-style: "Why does adding the `PAUSE` instruction to a spin loop improve performance?" *Hint: it tells the core about speculative memory-order violations and reduces power in the pipeline.*

#### Compare-and-Swap

**Theory**

**Compare-and-swap** (CAS) is the most powerful of the common atomic primitives and the foundation of essentially all lock-free programming. It takes three arguments — a memory location, an expected value, and a new value — and atomically writes the new value *only if* the location still holds the expected one, reporting whether it succeeded.

The conditional nature is what makes it general. Test-and-set can only claim a boolean; CAS can attempt *any* state transition and detect interference. The standard usage is the **CAS retry loop**:

1. Read the current value.
2. Compute the desired new value from it.
3. CAS: install the new value if nothing has changed.
4. If the CAS failed, someone else modified it — start again with the fresh value.

This loop is the shape of every lock-free algorithm. It is optimistic: it assumes no conflict, does the work, and validates at the moment of commit. Under low contention it is faster than locking; under high contention threads burn CPU on retries, and a lock can win.

CAS provides **lock-freedom**, not **wait-freedom**: the system as a whole always makes progress (some thread's CAS always succeeds), but an individual thread can retry indefinitely. That distinction matters for real-time systems.

The characteristic hazard is the **ABA problem**. CAS checks that the value is unchanged, not that it was *never* changed. If a value goes A → B → A between a thread's read and its CAS, the CAS succeeds although the world has moved on. In a lock-free stack this can splice freed nodes back into the list. Three standard remedies: attach a monotonically increasing **version counter** to the pointer (double-width CAS), use **hazard pointers** or epoch-based reclamation to defer memory reuse, or rely on a garbage collector that never recycles a node while it is reachable.

RISC architectures (ARM, POWER, RISC-V) provide **load-linked/store-conditional** instead: LL reads and marks the address, SC stores only if nothing has touched it since. This is strictly stronger in one respect — it detects *any* write, so it is immune to ABA — at the cost of spurious failures from unrelated cache events.

**Example**

```text
   CAS semantics, indivisibly

   bool compare_and_swap(int *addr, int expected, int new_value) {
       if (*addr == expected) { *addr = new_value; return true;  }
       else                   {                    return false; }
   }

   The universal retry loop

   do {
       old = *addr;                       // 1. read the current state
       new = f(old);                      // 2. compute the desired state
   } while (!CAS(addr, old, new));        // 3. commit only if nothing changed
                                          //    otherwise retry with fresh data

   The ABA problem

   Thread 1: reads head -> node A                    stack: A -> B -> C
   Thread 1: PREEMPTED, about to CAS(head, A, B)
   Thread 2: pops A, pops B, frees B, pushes A back  stack: A -> C
   Thread 1: resumes. CAS(head, A, B) SUCCEEDS -- head is still A!
             stack: B -> ???   B was FREED. Corruption.

   Fix: version-tagged pointers

   Thread 1: reads (head=A, version=17), CAS expects (A, 17)
   Thread 2's operations bump the version to 19
   Thread 1: CAS((A,17) -> ...) FAILS correctly, and retries.
```

```c
#include <stdatomic.h>

/* --- The retry loop, in its most common form: atomic maximum --- */
void atomic_max(atomic_int *target, int value) {
    int current = atomic_load(target);
    while (value > current &&
           !atomic_compare_exchange_weak(target, &current, value)) {
        /* compare_exchange_weak updates `current` with the actual value on
           failure, so the loop condition is re-evaluated with fresh data.
           `weak` may fail spuriously on LL/SC machines, which is fine and
           cheaper inside a loop that retries anyway. */
    }
}

/* --- A lock-free stack push: no mutex anywhere --- */
struct node { int value; struct node *next; };
_Atomic(struct node *) head = NULL;

void push(int value) {
    struct node *n = malloc(sizeof *n);
    n->value = value;
    n->next = atomic_load(&head);                    /* read current head   */
    while (!atomic_compare_exchange_weak(&head, &n->next, n)) {
        /* Failure means another thread pushed or popped first.
           `n->next` has been refreshed with the new head, so we simply
           retry -- no lock was ever taken, and no thread can block another. */
    }
}
```

```java
import java.util.concurrent.atomic.AtomicStampedReference;

// The ABA fix in the standard library: a value plus a monotonic stamp.
class SafeStack<T> {
    private final AtomicStampedReference<Node<T>> head =
        new AtomicStampedReference<>(null, 0);

    void push(T value) {
        int[] stampHolder = new int[1];
        Node<T> newNode = new Node<>(value, null);
        Node<T> current;
        int stamp;
        do {
            current = head.get(stampHolder);         // read value AND stamp
            stamp   = stampHolder[0];
            newNode.next = current;
        } while (!head.compareAndSet(current, newNode, stamp, stamp + 1));
        //                                            ^^^^^  ^^^^^^^^^
        // The stamp must ALSO match, so an A -> B -> A sequence is detected:
        // the value returned to A, but the stamp advanced.
    }
}
```

**Key takeaways**

- CAS atomically installs a new value only if the location still holds an expected one, reporting success.
- The read-compute-CAS-retry loop is the structural basis of every lock-free algorithm.
- CAS gives lock-freedom (the system progresses) but not wait-freedom (one thread may retry indefinitely).
- The ABA problem defeats naive CAS; version stamps, hazard pointers, or a garbage collector are the standard fixes.

> 🧪 Practice
>
> 1. Implement a lock-free counter with a CAS retry loop and compare it with a mutex-protected counter at 2 and 16 threads.
> 2. Construct a concrete ABA failure in a lock-free stack, then show how a version stamp prevents it.
> 3. Interview-style: "Why is a CAS loop lock-free but not wait-free?" *Hint: distinguish 'some thread always makes progress' from 'every thread makes progress'.*

#### Spinlocks

**Theory**

A **spinlock** is a lock whose waiters busy-wait — they loop, repeatedly testing the lock, rather than sleeping. Building one requires only the atomic primitives above.

The trade-off against a blocking mutex is a straightforward cost comparison. Blocking involves two context switches (out and back), each costing roughly 1-5 microseconds plus cache pollution (Chapter 2). Spinning wastes CPU for the duration of the wait but avoids those switches entirely. Therefore:

**Spin when the expected wait is shorter than the cost of two context switches; block when it is longer.**

That single rule determines where spinlocks are appropriate:

| Use a spinlock when | Use a blocking mutex when |
|---|---|
| Critical sections are very short (tens to hundreds of ns) | Critical sections are long, or perform I/O |
| Multiple cores are available | The system may be single-core |
| You cannot sleep (interrupt handlers) | Sleeping is permitted |
| Contention is low | Contention is high |

Two rules are non-negotiable in kernel code and explain most spinlock bugs:

- **Never sleep while holding a spinlock.** Waiters are burning CPU waiting for you; if you block on I/O, they spin for milliseconds. Worse, on a single core the waiter can never be descheduled in favour of the holder, so the system deadlocks outright.
- **Disable interrupts if the lock is taken in interrupt context.** If a thread holds a spinlock and an interrupt handler on the same core tries to take it, the handler spins forever waiting for a thread that cannot resume until the handler returns. Linux's `spin_lock_irqsave` exists exactly for this.

Real implementations refine the basic loop considerably: TTAS to reduce cache traffic, a `PAUSE`/`YIELD` hint to the core, exponential backoff, and queue-based designs (MCS, CLH locks) where each waiter spins on its *own* cache line, eliminating coherence storms and providing FIFO fairness. Many systems use **adaptive mutexes**, which spin briefly and then block — capturing the best of both when the holder is running on another core.

**Example**

```text
   Spin or block? Compare the wait against the switch cost

   critical section 50 ns   -> SPIN   (blocking costs ~4000 ns: 80x worse)
   critical section 10 us   -> either (roughly break-even)
   critical section 10 ms   -> BLOCK  (spinning wastes 10 ms of a core)

   The single-core deadlock

   core0: thread A holds the spinlock, is preempted
   core0: thread B tries to acquire it -> spins for its ENTIRE quantum
          A cannot run because B is running. Pure waste, and on a
          non-preemptive kernel, a permanent hang.
   -> spinlocks only make sense on multiprocessors

   The interrupt deadlock

   thread holds spinlock L on core 0
     -> interrupt fires on core 0
     -> handler tries to take L
     -> handler spins; the thread cannot resume until the handler returns
     -> HARD LOCKUP.  Fix: spin_lock_irqsave() disables local interrupts.

   Queue locks: each waiter spins on its own cache line

   simple spinlock:  all waiters spin on ONE line -> coherence storm
   MCS lock:         A -> B -> C queue, each spinning on a private flag
                     the holder sets only its successor's flag: one transfer,
                     FIFO fairness, no storm
```

```c
/* A production-shaped spinlock: TTAS + pause + release barrier. */
#include <stdatomic.h>

typedef struct { atomic_bool locked; } spinlock_t;

static inline void spin_lock(spinlock_t *l) {
    for (;;) {
        /* Fast path: try once. Uncontended acquisition is a single atomic. */
        if (!atomic_exchange_explicit(&l->locked, true, memory_order_acquire))
            return;

        /* Slow path: spin on a READ so we do not invalidate other caches. */
        while (atomic_load_explicit(&l->locked, memory_order_relaxed))
            __builtin_ia32_pause();     /* PAUSE: reduces power, avoids a
                                           memory-order violation penalty on
                                           exiting the loop */
    }
}

static inline void spin_unlock(spinlock_t *l) {
    atomic_store_explicit(&l->locked, false, memory_order_release);
    /* RELEASE: everything done in the critical section is visible to the
       next thread that acquires this lock. */
}
```

```c
/* Linux kernel idioms, and what each one guards against. */

spin_lock(&lock);                 /* plain: safe only if this lock is never
                                     taken from interrupt context           */
spin_unlock(&lock);

unsigned long flags;
spin_lock_irqsave(&lock, flags);  /* saves and disables local interrupts:
                                     required if an IRQ handler takes this
                                     same lock -- prevents the hard lockup  */
spin_unlock_irqrestore(&lock, flags);

/* FORBIDDEN while holding a spinlock: */
/*   kmalloc(size, GFP_KERNEL)   -- may sleep                                */
/*   copy_to_user(...)           -- may page-fault and sleep                 */
/*   mutex_lock(...)             -- may sleep                                */
```

**Key takeaways**

- A spinlock busy-waits instead of sleeping, trading wasted CPU for the avoided cost of two context switches.
- Spin when the expected wait is shorter than a context-switch pair; block otherwise.
- Never sleep while holding a spinlock, and disable interrupts if the lock is also taken in interrupt context.
- Production spinlocks use TTAS, pause hints, backoff, or per-waiter queue locks to avoid coherence storms.

> 🧪 Practice
>
> 1. Measure the cost of a context switch on your machine, then compute the critical-section length at which spinning stops paying.
> 2. Explain step by step why taking a spinlock without disabling interrupts can hard-lock a core.
> 3. Interview-style: "Why do MCS locks scale better than simple spinlocks?" *Hint: count how many caches are invalidated per lock handoff in each design.*

<a id="53-synchronization-primitives"></a>
### 5.3 Synchronization Primitives

The hardware instructions of 5.2 are correct but awkward; this section covers the abstractions built on top of them that programmers actually use.

#### Mutex Locks

**Theory**

A **mutex** (mutual exclusion lock) is the simplest and most widely used primitive. It has two states — locked and unlocked — and two operations: `acquire`, which blocks until the lock is free and then takes it, and `release`, which frees it.

The essential difference from the spinlock of 5.2 is what a waiter does. A mutex **blocks**: the thread is moved to a wait queue associated with the lock, marked Blocked (Chapter 2), and the scheduler runs someone else. On release, a waiter is moved back to Ready. No CPU is consumed while waiting.

Modern implementations are hybrids and worth understanding, because they explain surprising performance results. Linux's futex ("fast userspace mutex") takes the uncontended path entirely in user space with a single CAS — no system call at all — and only enters the kernel when there is actual contention and someone must be put to sleep. Since most lock acquisitions are uncontended, this makes the common case cost roughly 20 nanoseconds instead of a microsecond. Many implementations additionally spin briefly before blocking (an **adaptive mutex**), which pays off when the holder is running on another core and will release shortly.

Three properties define correct mutex use:

- **Ownership.** A mutex is owned by the thread that locked it, and only that thread may unlock it. This is what allows deadlock detection, priority inheritance (5.5), and error checking — and it is the main semantic difference from a binary semaphore.
- **Release must be guaranteed.** A lock that is not released on an early return, an exception, or a `goto` deadlocks the program permanently. Every language provides a scope-based mechanism for this: RAII (`std::lock_guard`) in C++, `with` in Python, `defer` in Go, `try`/`finally` in Java. Manual lock/unlock pairs are a defect waiting to happen.
- **Non-recursive by default.** Locking a mutex you already hold deadlocks immediately, unless it is explicitly a recursive mutex. Recursive mutexes are usually a sign that the ownership structure of the code is unclear.

Analogy: a mutex is a key to a single-occupancy room, where waiters sit in the corridor asleep rather than rattling the handle, and where only the person who took the key may return it.

**Example**

```text
   Mutex state machine and the wait queue

   UNLOCKED --acquire--> LOCKED (owner: T1)
        ^                    |
        |                    | T2 acquires: BLOCKS
        |                    v
        |              wait queue: [T2][T3]
        |                    |
        +---release----------+  one waiter is made READY

   Fast path vs slow path (futex)

   uncontended:  CAS on a user-space word            ~20 ns, NO system call
   contended:    CAS fails -> futex(FUTEX_WAIT)      ~1-2 us, kernel involved
                 release   -> futex(FUTEX_WAKE)

   This is why lock cost varies by two orders of magnitude with contention.

   Spinlock vs mutex

                  | spinlock            | mutex
   ---------------+---------------------+-------------------------
   waiter does    | burns CPU           | sleeps, CPU freed
   wait cost      | proportional to wait| ~2 context switches
   ownership      | usually none        | owned; only owner unlocks
   may sleep in CS| NO                  | yes
   use for        | very short CS       | anything longer
```

```cpp
#include <mutex>
#include <stdexcept>

class Account {
    mutable std::mutex m_;      // mutable: const methods still need to lock
    double balance_ = 0;

public:
    void transfer_out(double amount) {
        std::lock_guard<std::mutex> guard(m_);   // RAII: acquires here
        if (balance_ < amount)
            throw std::runtime_error("insufficient funds");
            // ^ The mutex is STILL released: guard's destructor runs during
            //   stack unwinding. A manual unlock() after this line would
            //   never execute, deadlocking the program permanently.
        balance_ -= amount;
    }                                            // released here, always
};
```

```python
import threading

lock = threading.Lock()

# CORRECT: the context manager releases on every exit path.
def transfer(accounts, src, dst, amount):
    with lock:
        if accounts[src] < amount:
            return False        # `with` still releases the lock
        accounts[src] -= amount
        accounts[dst] += amount
        return True

# BROKEN: an early return or exception leaks the lock forever.
def transfer_bad(accounts, src, dst, amount):
    lock.acquire()
    if accounts[src] < amount:
        return False            # LOCK NEVER RELEASED -> permanent deadlock
    accounts[src] -= amount
    lock.release()

# Deadlocks immediately: a plain Lock is not recursive.
def recursive_bad():
    with lock:
        with lock:              # blocks waiting for a lock this thread holds
            pass
# Use threading.RLock() if re-entry is genuinely required -- but prefer
# restructuring so it is not.
```

**Key takeaways**

- A mutex blocks waiters on a wait queue instead of spinning, freeing the CPU for other work.
- Implementations take the uncontended path in user space with a single atomic, entering the kernel only under contention.
- Mutexes are owned: only the locking thread may unlock, which enables error checking and priority inheritance.
- Always release with a scope-based mechanism, and treat the need for a recursive mutex as a design smell.

> 🧪 Practice
>
> 1. Write a function that returns early while holding a manually acquired mutex, demonstrate the deadlock, then fix it with RAII or `with`.
> 2. Benchmark an uncontended mutex and one contended by 8 threads. Explain the difference using the futex fast/slow paths.
> 3. Interview-style: "When would you choose a spinlock over a mutex in kernel code?" *Hint: consider the length of the critical section and whether the code may sleep.*

#### Semaphores

**Theory**

A **semaphore**, introduced by Dijkstra in 1965, generalises the mutex. It is an integer counter with two atomic operations:

- **`wait`** (P, from *proberen*): decrement the counter; if it becomes negative, block the calling thread.
- **`signal`** (V, from *verhogen*): increment the counter; if any thread is blocked, wake one.

The counter represents **available units of a resource**. This makes semaphores strictly more expressive than mutexes, and they are used in two distinct ways that are worth separating clearly:

- A **counting semaphore** initialised to N controls access to N interchangeable resources — a connection pool, a buffer of N slots, a limit of N concurrent downloads. This is the use case a mutex cannot express at all.
- A **binary semaphore** initialised to 1 behaves like a lock. It is *not* a mutex, however: it has **no ownership**, so any thread may signal it, and it lacks the error checking and priority inheritance that ownership makes possible.

That absence of ownership is not merely a limitation — it is what enables the second major use: **signalling between threads**. A semaphore initialised to 0 lets thread A block until thread B signals, establishing an ordering constraint. A mutex cannot do this, because the thread that would need to unlock is not the one that locked.

| Use | Initial value | Pattern |
|---|---|---|
| Mutual exclusion | 1 | Same thread waits and signals |
| Resource counting | N | Same thread waits and signals |
| Signalling / ordering | 0 | One thread waits, a *different* thread signals |

The danger is that semaphores are unstructured. Nothing associates a `wait` with its `signal`, so a missing signal deadlocks silently, an extra signal corrupts the count, and reversed order in two threads deadlocks. There is no compiler help and no scope-based idiom. This is precisely why monitors (below) were invented, and why modern code prefers mutexes plus condition variables for exclusion and reserves semaphores for genuine counting and signalling.

Analogy: a semaphore is a bowl of N parking tokens. Take one to park (blocking if the bowl is empty), return it on leaving. Nothing records who took which token, so anyone can return one — powerful, and easy to get wrong.

**Example**

```text
   Semaphore semantics

   wait(S):   S.count--;  if (S.count < 0) { block(this thread) }
   signal(S): S.count++;  if (S.count <= 0) { wake one blocked thread }

   A negative count tells you how many threads are waiting.

   Counting semaphore: 3 database connections, 5 threads

   count=3  T1 wait -> 2, proceeds
            T2 wait -> 1, proceeds
            T3 wait -> 0, proceeds
            T4 wait -> -1, BLOCKS      (one waiter)
            T5 wait -> -2, BLOCKS      (two waiters)
            T1 signal -> -1, wakes T4
            T2 signal ->  0, wakes T5

   Signalling: a semaphore initialised to 0 orders two threads

   Thread A                 Thread B
     wait(done)   <-blocks
                              do_work()
                              signal(done)
     use_result() <-proceeds
   A mutex CANNOT express this: B never locked anything.
```

```python
import threading, time

# --- Use 1: counting a limited resource ---
db_pool = threading.Semaphore(3)        # exactly 3 connections exist

def query(n):
    with db_pool:                        # wait(): blocks if all 3 are in use
        time.sleep(0.1)                  # hold a connection
        print(f"query {n} done")
    # signal() happens on exit; at most 3 queries run concurrently

# --- Use 2: signalling an ordering between different threads ---
data_ready = threading.Semaphore(0)      # starts at 0: waiters block immediately
result = None

def producer():
    global result
    result = expensive_computation()
    data_ready.release()                 # signal: a DIFFERENT thread than the
                                         # one that will wait

def consumer():
    data_ready.acquire()                 # blocks until the producer signals
    print(result)                        # guaranteed to be computed

# --- The unstructured hazard ---
sem = threading.Semaphore(1)
def buggy():
    sem.acquire()
    if error_condition():
        return          # MISSING RELEASE: the count is now 0 forever.
    sem.release()       # No language mechanism catches this.
```

```c
#include <semaphore.h>

sem_t slots;                 /* how many free buffer slots exist  */
sem_t items;                 /* how many filled items exist       */

sem_init(&slots, 0, 10);     /* 0 = shared between threads (1 = between
                                processes, via shared memory); 10 slots */
sem_init(&items, 0, 0);      /* nothing produced yet                    */

/* Two counting semaphores used together give bounded-buffer flow control:
   this is the producer-consumer solution developed in 5.4. */
```

**Key takeaways**

- A semaphore is a counter with atomic `wait` (decrement, block if negative) and `signal` (increment, wake one).
- A counting semaphore limits access to N interchangeable resources, which a mutex cannot express.
- Having no ownership lets one thread signal what another waits on, enabling ordering between threads.
- Semaphores are unstructured: a missing or misplaced signal causes silent deadlock with no compiler assistance.

> 🧪 Practice
>
> 1. Use a counting semaphore to limit a downloader to 4 concurrent connections, and verify the limit holds under 50 tasks.
> 2. Explain why a binary semaphore is not equivalent to a mutex. Give a specific bug that ownership would have caught.
> 3. Interview-style: "Implement a barrier for N threads using only semaphores." *Hint: you need a counter protected by one semaphore and a second one to release the group.*

#### Condition Variables

**Theory**

Mutexes solve exclusion but not **waiting for a condition**. A consumer that must wait until a queue is non-empty cannot simply hold the mutex and loop — no producer could ever acquire the lock to add an item. Releasing the lock and polling in a loop works but burns CPU and is racy.

A **condition variable** solves this precisely. It supports three operations, always used in conjunction with a mutex:

- **`wait(mutex)`** — atomically releases the mutex and blocks the thread. When it returns, the mutex has been reacquired. The atomicity of the release-and-block is the crux: without it, a signal arriving in between would be missed forever.
- **`signal`** — wakes one waiting thread.
- **`broadcast`** — wakes all waiting threads.

Three rules govern correct use, and violating any of them is a classic bug:

1. **Always wait inside a `while` loop, never an `if`.** Three separate reasons make this mandatory: **spurious wakeups** are permitted by POSIX and do occur; **stolen wakeups** happen when another thread acquires the mutex between the signal and the waiter's resumption and consumes the condition; and **broadcast** wakes everyone, though the condition may only be satisfiable for one. Re-checking the predicate on waking is the only safe discipline.
2. **Hold the mutex when calling wait.** The predicate is shared state; testing it without the lock is itself a race.
3. **Prefer `broadcast` when in doubt.** `signal` is more efficient but is only correct when any single waiter can make progress. With multiple distinct predicates on one condition variable, `signal` can wake the wrong thread and stall the system.

The pairing of a mutex with condition variables is the standard general-purpose tool, and it is more expressive than semaphores because the condition can be an arbitrary predicate over shared state rather than a single counter.

Analogy: a condition variable is a waiting room with a bell. You put down the key to the room (release the mutex) and sleep. When someone rings the bell you wake, pick up the key again, and check whether what you were waiting for is actually there — because someone else may have taken it first.

**Example**

```text
   Why wait() must release the mutex ATOMICALLY

   BROKEN (if release and block were separate):
     consumer: holds mutex, sees queue empty
     consumer: releases mutex
     ---- producer adds an item and SIGNALS here: nobody is waiting yet ----
     consumer: blocks
     -> the signal was missed; the consumer sleeps forever with data available

   CORRECT: wait() performs release-and-block indivisibly, so no signal
            can slip into the gap.

   Why `while`, not `if`

   T1 waiting on "queue not empty"
   producer adds ONE item, signals
   T1 wakes and must reacquire the mutex ...
   ... but T2 (not waiting; just called pop()) grabs the mutex first
       and takes the item.
   T1 finally gets the mutex: the queue is empty AGAIN.
   With `if`  -> T1 proceeds and dereferences an empty queue. CRASH.
   With `while` -> T1 re-checks, sees empty, and waits again. Correct.

   The canonical shape

   lock(m);
   while (!predicate)        <- ALWAYS a loop
       cond_wait(cv, m);     <- releases m, blocks, reacquires m
   /* predicate is true AND we hold the mutex */
   do_work();
   unlock(m);
```

```c
#include <pthread.h>

#define CAPACITY 10
int buffer[CAPACITY], count = 0, in = 0, out = 0;

pthread_mutex_t mutex     = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t  not_full  = PTHREAD_COND_INITIALIZER;
pthread_cond_t  not_empty = PTHREAD_COND_INITIALIZER;
/* TWO condition variables, one per predicate: signalling `not_empty` then
   wakes only consumers, never a producer that cannot proceed. */

void produce(int item) {
    pthread_mutex_lock(&mutex);
    while (count == CAPACITY)                    /* WHILE, never IF */
        pthread_cond_wait(&not_full, &mutex);    /* releases mutex, blocks,
                                                    reacquires on wake */
    buffer[in] = item;
    in = (in + 1) % CAPACITY;
    count++;
    pthread_cond_signal(&not_empty);             /* a consumer can now proceed */
    pthread_mutex_unlock(&mutex);
}

int consume(void) {
    pthread_mutex_lock(&mutex);
    while (count == 0)
        pthread_cond_wait(&not_empty, &mutex);
    int item = buffer[out];
    out = (out + 1) % CAPACITY;
    count--;
    pthread_cond_signal(&not_full);              /* a producer can now proceed */
    pthread_mutex_unlock(&mutex);
    return item;
}
```

```python
import threading, collections

class BoundedQueue:
    def __init__(self, capacity):
        self._q = collections.deque()
        self._capacity = capacity
        self._lock = threading.Lock()
        self._not_full  = threading.Condition(self._lock)   # share ONE lock
        self._not_empty = threading.Condition(self._lock)

    def put(self, item):
        with self._not_full:
            while len(self._q) >= self._capacity:   # loop, not `if`
                self._not_full.wait()               # releases the lock
            self._q.append(item)
            self._not_empty.notify()                # wake one consumer

    def get(self):
        with self._not_empty:
            while not self._q:
                self._not_empty.wait()
            item = self._q.popleft()
            self._not_full.notify()
            return item

    def close(self):
        with self._lock:
            self._closed = True
            self._not_empty.notify_all()   # BROADCAST: every waiter must
            self._not_full.notify_all()    # re-check and exit
```

**Key takeaways**

- A condition variable lets a thread wait for an arbitrary predicate while holding a mutex, atomically releasing it.
- The atomic release-and-block is essential; otherwise a signal can arrive in the gap and be lost forever.
- Always re-check the predicate in a `while` loop: spurious wakeups, stolen wakeups, and broadcasts all require it.
- Use one condition variable per distinct predicate, and prefer broadcast when several different conditions share one.

> 🧪 Practice
>
> 1. Replace the `while` with an `if` in the bounded queue and construct an execution that corrupts it or crashes.
> 2. Implement a one-shot latch: N worker threads wait until a coordinator signals that setup is complete.
> 3. Interview-style: "What is a spurious wakeup and why does the standard permit it?" *Hint: consider what implementations gain by not having to suppress them.*

#### Monitors

**Theory**

Semaphores and raw mutexes are error-prone for a structural reason: the synchronization is *separate* from the data it protects. Nothing in the language connects a lock to the variables it guards, so a programmer can forget to lock, lock the wrong mutex, or fail to unlock on an error path.

A **monitor** (Hoare and Brinch Hansen, 1974) is a language construct that fuses them. It is an abstract data type in which:

- All shared data is **private** to the monitor — unreachable from outside.
- All **procedures are automatically mutually exclusive**: at most one thread executes inside the monitor at a time, enforced by the compiler or runtime rather than by programmer discipline.
- **Condition variables** inside the monitor allow threads to wait for predicates, with the monitor's lock released while waiting.

The gain is that correctness moves from convention to construction. You cannot forget to lock, because entry *is* the lock. You cannot forget to unlock, because exit *is* the unlock. The exclusion boundary and the data boundary are the same boundary.

The design question a monitor must answer is what happens when a thread signals a condition while inside the monitor — two threads would then be runnable inside, violating exclusion. There are two classic answers:

| | **Hoare semantics (signal-and-wait)** | **Mesa semantics (signal-and-continue)** |
|---|---|---|
| On signal | Signaller yields the monitor immediately to the waiter | Signaller continues; the waiter becomes merely *eligible* |
| Waiter can assume | The predicate is true on waking (`if` suffices) | Nothing — must re-check (`while` required) |
| Cost | Two extra context switches per signal | None |
| Used by | Textbook theory | Java, C#, Python, pthreads — every real system |

Mesa semantics won on efficiency, and that choice is exactly why the `while` loop of the previous topic is mandatory everywhere in practice.

Java implements monitors directly: every object has an intrinsic lock, `synchronized` methods acquire it, and `wait`/`notify`/`notifyAll` are the condition operations. `ConcurrentHashMap`, `BlockingQueue`, and Python's `threading.Condition`-based classes are all monitors in this sense.

Analogy: a monitor is a building with a turnstile admitting one person at a time, where the valuables are only reachable inside. Compare a mutex, which is a padlock you must remember to attach to the right cabinet and to close behind you.

**Example**

```text
   Monitor structure

   +--------------------------------------------+
   |  monitor BoundedBuffer                     |
   |                                            |
   |    PRIVATE data: buffer[], count, in, out  |  <- unreachable outside
   |                                            |
   |    condition not_full, not_empty           |
   |                                            |
   |    procedure put(item)  \                  |
   |    procedure get()       > automatically   |  <- at most ONE thread
   |    procedure size()     /  mutually        |     inside at a time
   |                            exclusive       |
   +--------------------------------------------+
              ^
              | entry queue: threads waiting to get IN
           [T2][T3]

   Hoare vs Mesa, on signal

   HOARE: signaller BLOCKS, waiter runs immediately with the predicate true
          |-- signaller --|>>> waiter runs >>>|-- signaller resumes --|
          waiter may use `if`. Costs two extra switches per signal.

   MESA:  signaller CONTINUES; waiter joins the entry queue
          |------ signaller continues to end of procedure ------|
                                                    then waiter competes
          By the time the waiter runs, the predicate may be false again
          -> `while` is MANDATORY. This is what every real system does.
```

```java
// Java: `synchronized` IS a monitor. The lock is the object itself.
public class BoundedBuffer<T> {
    private final Object[] items;          // private: unreachable from outside
    private int count = 0, in = 0, out = 0;

    public BoundedBuffer(int capacity) { items = new Object[capacity]; }

    // `synchronized` = acquire this object's intrinsic lock on entry,
    // release on exit, INCLUDING on an exception. Cannot be forgotten.
    public synchronized void put(T item) throws InterruptedException {
        while (count == items.length)      // MESA semantics -> while, not if
            wait();                        // releases the monitor lock, blocks
        items[in] = item;
        in = (in + 1) % items.length;
        count++;
        notifyAll();                       // wake all: producers and consumers
    }                                      // share one condition here

    @SuppressWarnings("unchecked")
    public synchronized T get() throws InterruptedException {
        while (count == 0)
            wait();
        T item = (T) items[out];
        out = (out + 1) % items.length;
        count--;
        notifyAll();
        return item;
    }

    public synchronized int size() { return count; }   // even reads are inside
}
```

```python
import threading

class Monitor:
    """Python has no monitor keyword, so the pattern is built explicitly:
       private data + one lock + conditions, all encapsulated in the class."""

    def __init__(self, capacity):
        self.__items = []                       # name-mangled: effectively private
        self.__capacity = capacity
        self.__lock = threading.RLock()
        self.__not_full  = threading.Condition(self.__lock)
        self.__not_empty = threading.Condition(self.__lock)

    def put(self, item):
        with self.__not_full:                   # entry = acquire
            while len(self.__items) >= self.__capacity:
                self.__not_full.wait()
            self.__items.append(item)
            self.__not_empty.notify()
                                                # exit = release, guaranteed
```

**Key takeaways**

- A monitor bundles private data, an implicit lock, and condition variables into one language construct.
- Mutual exclusion is enforced by construction, so locking cannot be forgotten or misapplied.
- Hoare semantics hand the monitor to the waiter on signal; Mesa semantics let the signaller continue.
- Every real system uses Mesa semantics, which is exactly why predicates must be rechecked in a `while` loop.

> 🧪 Practice
>
> 1. Implement a bounded buffer as a Java monitor, then rewrite it with explicit `ReentrantLock` and `Condition`. Compare the failure modes.
> 2. Explain why `notifyAll` is safer than `notify` when producers and consumers share one condition, and construct the stall that `notify` can cause.
> 3. Interview-style: "Why do monitors reduce concurrency bugs compared with raw mutexes?" *Hint: think about what a programmer can no longer forget to do.*

#### Readers-Writers Locks

**Theory**

A plain mutex serialises everything, but that is stronger than many workloads require. Reading shared data does not modify it, so **any number of readers may proceed simultaneously** without any race. Only writers need exclusivity.

A **readers-writers lock** (shared/exclusive lock) exploits this with two acquisition modes:

- **Shared (read) mode**: any number of threads may hold it concurrently.
- **Exclusive (write) mode**: only one thread may hold it, and no readers may hold it at the same time.

The compatibility rule is simply: readers exclude writers, writers exclude everyone, readers do not exclude each other.

The benefit is large only for read-heavy workloads. A configuration table read thousands of times per second and written once an hour is an ideal candidate. But the lock itself is more complex than a mutex — it must track a reader count and a writer flag atomically — so acquisition costs more. **For write-heavy or balanced workloads, a plain mutex is usually faster**, and this is a common misapplication.

The design decision is the **fairness policy**, and it determines which side starves:

| Policy | Behaviour | Starves |
|---|---|---|
| **Reader-preferring** | A new reader joins even if a writer is waiting | Writers, under continuous read load |
| **Writer-preferring** | A waiting writer blocks new readers | Readers, under continuous write load |
| **Fair (FIFO)** | Requests are served in arrival order | Neither |

Reader-preferring gives maximum read throughput and is the classic textbook version, but writer starvation is a real production hazard: a configuration update that never lands because reads never stop. Most production implementations are writer-preferring or fair for this reason.

Modern alternatives often beat readers-writers locks outright. **RCU** (read-copy-update, 5.5) makes readers entirely lock-free. **Seqlocks** let readers proceed optimistically and retry if a write occurred. **Copy-on-write** replaces an immutable snapshot atomically, so readers need no synchronization at all.

Analogy: a library reading room. Any number of people may read a reference book simultaneously; the librarian who needs to update it must wait until the room is empty and then keep everyone out while writing.

**Example**

```text
   Compatibility matrix

                    | reader wants in | writer wants in
   -----------------+-----------------+----------------
   readers active   |    ALLOW        |     BLOCK
   writer active    |    BLOCK        |     BLOCK
   nothing active   |    ALLOW        |     ALLOW

   Concurrency gained on a read-heavy workload

   mutex:   R1 | R2 | R3 | R4 | W1 |        strictly serial
   rwlock:  R1 R2 R3 R4 (concurrent) | W1 | 4x the read throughput

   Writer starvation under a reader-preferring policy

   time ->
   R1 [========]
   R2     [========]
   R3          [========]
   R4               [========]      readers keep overlapping
   W1     waiting..............................  forever
          ^ a new reader is admitted every time, so the count never hits zero

   Rule of thumb

   reads >> writes  (say 100:1)   -> rwlock wins
   balanced or write-heavy        -> plain mutex is faster (less bookkeeping)
```

```c
#include <pthread.h>

pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;
struct config shared_config;

/* Many threads may execute this concurrently. */
const char *lookup(const char *key) {
    pthread_rwlock_rdlock(&lock);            /* SHARED: other readers welcome */
    const char *value = config_find(&shared_config, key);
    pthread_rwlock_unlock(&lock);
    return value;
}

/* At most one, and only when no reader holds the lock. */
void reload(const char *path) {
    struct config fresh = parse_file(path);  /* expensive work OUTSIDE the lock */

    pthread_rwlock_wrlock(&lock);            /* EXCLUSIVE: blocks everyone      */
    shared_config = fresh;                   /* keep the critical section tiny  */
    pthread_rwlock_unlock(&lock);
}
```

```python
import threading

class RWLock:
    """Writer-preferring: a waiting writer blocks NEW readers, so writers
       cannot starve under continuous read load."""

    def __init__(self):
        self._lock = threading.Condition(threading.Lock())
        self._readers = 0
        self._writers_waiting = 0
        self._writer_active = False

    def acquire_read(self):
        with self._lock:
            # Yield to waiting writers: this single clause is the entire
            # difference between writer-preferring and reader-preferring.
            while self._writer_active or self._writers_waiting > 0:
                self._lock.wait()
            self._readers += 1

    def release_read(self):
        with self._lock:
            self._readers -= 1
            if self._readers == 0:
                self._lock.notify_all()      # the last reader out wakes writers

    def acquire_write(self):
        with self._lock:
            self._writers_waiting += 1
            while self._writer_active or self._readers > 0:
                self._lock.wait()
            self._writers_waiting -= 1
            self._writer_active = True

    def release_write(self):
        with self._lock:
            self._writer_active = False
            self._lock.notify_all()
```

**Key takeaways**

- Readers-writers locks allow concurrent readers but give writers exclusive access.
- They pay off only for read-heavy workloads; for balanced or write-heavy ones a plain mutex is usually faster.
- The fairness policy determines which side starves: reader-preferring starves writers, writer-preferring starves readers.
- RCU, seqlocks, and copy-on-write often outperform readers-writers locks by removing reader synchronization entirely.

> 🧪 Practice
>
> 1. Benchmark a mutex against a readers-writers lock at read:write ratios of 1:1, 10:1, and 1000:1. Find the crossover point.
> 2. Demonstrate writer starvation with a reader-preferring lock and a continuous stream of readers.
> 3. Interview-style: "Your service uses a readers-writers lock and is slower than with a mutex. What would you check?" *Hint: measure the actual read:write ratio and the cost of the lock's own bookkeeping.*

#### Barriers

**Theory**

The primitives so far protect data. A **barrier** does something different: it synchronises *time*. It is a rendezvous point where N threads must all arrive before any is allowed to continue.

The need arises whenever a computation proceeds in **phases** and phase k+1 depends on every thread finishing phase k. Iterative simulations, matrix algorithms, parallel sorts, and graph algorithms all have this shape: each thread updates its portion of a grid, and no thread may start the next iteration until *all* updates are complete, or it would read a mix of old and new values.

The operation is a single call: `barrier.wait()` blocks until N threads have called it, then releases them all.

Three implementation concerns matter:

- **Reusability.** A barrier used once per iteration must reset correctly. The classic bug is a fast thread racing round the loop and entering the *next* barrier before slow threads have left the previous one. The standard fix is a **sense-reversing barrier**, where each generation flips a shared boolean that threads compare against a private copy — so an early arrival at generation k+1 cannot be mistaken for a straggler from generation k.
- **Cost.** A barrier is only as fast as its slowest participant: every thread pays the maximum. Load imbalance is therefore amplified — a barrier in a loop turns a 10% imbalance into a 10% slowdown for *every* thread on *every* iteration. Reducing barrier count and balancing work matters more than optimising the barrier itself.
- **Scalability.** A single shared counter becomes a contention point at high thread counts, so large systems use **tree barriers** (log n depth) or hardware-assisted barriers.

Related constructs solve nearby problems: a **latch** (Java's `CountDownLatch`) is a one-shot barrier that is not reusable; a **phaser** allows the participant count to change dynamically; and `join`ing all threads is a barrier that also terminates them.

Analogy: a group hike where everyone regroups at each junction. Nobody proceeds until the last person arrives, so the group moves at the pace of its slowest member — which is exactly the cost model.

**Example**

```text
   A barrier across three threads

   T1: [== phase 1 ==]--------wait--------|[== phase 2 ==]
   T2: [==== phase 1 ====]----wait--------|[== phase 2 ==]
   T3: [======== phase 1 ========]--------|[== phase 2 ==]
                                          ^
                                  all three released together

   Every thread pays the cost of the SLOWEST. T1 and T2 idle while T3 works.

   Why a naive reusable barrier breaks

   count = 0
   arrive: count++; if (count == N) { count = 0; release_all(); }
           else wait_for_release();

   T1 is released, loops around, and calls arrive() AGAIN
   -> count becomes 1 before T2 and T3 have even woken from generation k
   -> the barrier is corrupted across generations

   Sense reversal fixes it

   shared: sense = false
   each thread: local_sense = !local_sense       // flip my private copy
                if (last to arrive) { count = N; sense = local_sense; }
                else while (sense != local_sense) ;   // wait for THIS generation
   An early arrival at generation k+1 has already flipped, so it cannot be
   confused with a straggler from generation k.
```

```c
#include <pthread.h>

pthread_barrier_t barrier;
#define THREADS 4
double grid[N][N], next[N][N];

void *simulate(void *arg) {
    int id = *(int *)arg;
    for (int iteration = 0; iteration < 1000; iteration++) {
        compute_my_rows(id, grid, next);      /* phase: read grid, write next */

        pthread_barrier_wait(&barrier);       /* BARRIER 1: everyone has
                                                 finished writing `next`      */
        if (id == 0)
            swap_buffers(&grid, &next);       /* only one thread may swap     */

        pthread_barrier_wait(&barrier);       /* BARRIER 2: everyone sees the
                                                 swap before reading again.
                                                 Omitting this is a classic bug:
                                                 fast threads would read `grid`
                                                 mid-swap.                    */
    }
    return NULL;
}

int main(void) {
    pthread_barrier_init(&barrier, NULL, THREADS);   /* N participants */
    /* ... create THREADS threads running simulate ... */
    pthread_barrier_destroy(&barrier);
    return 0;
}
```

```java
import java.util.concurrent.CyclicBarrier;
import java.util.concurrent.CountDownLatch;

// CyclicBarrier: reusable, with an optional action run once per generation
// by the last thread to arrive -- neatly replacing the "if (id == 0)" idiom.
CyclicBarrier barrier = new CyclicBarrier(4, () -> {
    swapBuffers();                    // runs once, after all 4 arrive,
});                                   // before any is released

// CountDownLatch: ONE-SHOT. Cannot be reset; use for start/stop signals.
CountDownLatch ready = new CountDownLatch(4);
// workers: ready.countDown();  coordinator: ready.await();
```

**Key takeaways**

- A barrier blocks every participant until all N have arrived, then releases them together.
- It is used for phase-synchronous computations where the next phase depends on all of the previous one.
- Reusable barriers need sense reversal so a fast thread cannot corrupt the next generation.
- Every thread pays the cost of the slowest, so barriers amplify load imbalance; latches and phasers cover related cases.

> 🧪 Practice
>
> 1. Implement a reusable barrier with a mutex and condition variable, then demonstrate the generation bug without sense reversal.
> 2. Write a phase-synchronous heat-diffusion simulation with four threads. Remove the second barrier and describe the corruption.
> 3. Interview-style: "You add a barrier per iteration and parallel speed-up drops from 7x to 2x on 8 cores. Why?" *Hint: think about what determines the duration of every single iteration.*

<a id="54-classic-problems"></a>
### 5.4 Classic Problems

These four problems are the standard test suite for synchronization mechanisms: each isolates a distinct difficulty, and any new primitive is judged by how cleanly it expresses their solutions.

#### Producer-Consumer Problem

**Theory**

The **producer-consumer** (bounded buffer) problem is the most practically important of the four, because it is the shape of nearly every real concurrent system: a work queue, a network receive path, a logging pipeline, a video decoder feeding a renderer.

The setup: one or more producers generate items and place them in a fixed-size buffer; one or more consumers remove and process them. Three requirements must hold simultaneously:

1. **Mutual exclusion** — producers and consumers both modify the buffer's indices and count, so those updates must not interleave.
2. **A producer must block when the buffer is full**, rather than overwriting or growing without bound.
3. **A consumer must block when the buffer is empty**, rather than spinning or reading garbage.

The blocking requirements are what make it more than a mutex exercise, and the *bounded* buffer is the point: an unbounded queue converts a temporary imbalance into unbounded memory growth. A bounded buffer provides **backpressure** — a fast producer is forced to slow to the consumer's rate, which is a system-design property, not merely a synchronization detail.

The classic solution uses three semaphores, and the reasoning is worth following:

- `empty`, initialised to N: counts free slots. A producer waits on it.
- `full`, initialised to 0: counts filled slots. A consumer waits on it.
- `mutex`, initialised to 1: protects the buffer structure.

The counting semaphores handle the blocking conditions and the binary one handles exclusion. **The order of the waits is critical**: a producer must `wait(empty)` *before* `wait(mutex)`. Reversing them deadlocks — a producer would hold the mutex while blocking on a full buffer, so no consumer could ever acquire the mutex to free a slot. This is the single most instructive bug in the chapter.

Modern code uses a mutex plus two condition variables (as in 5.3) or a library queue (`BlockingQueue`, `queue.Queue`, Go channels), all of which implement exactly this.

**Example**

```text
   Bounded buffer, capacity 5

   producers ---> [ A ][ B ][ C ][   ][   ] ---> consumers
                    ^              ^
                   out            in
                  count = 3, empty = 2, full = 3

   full  -> producers block  (backpressure: the fast side is throttled)
   empty -> consumers block

   THE DEADLOCK: wrong order of waits

   Producer:  wait(mutex)       <- takes the mutex FIRST
              wait(empty)       <- buffer is full: BLOCKS while HOLDING mutex
   Consumer:  wait(full)        <- ok, an item exists
              wait(mutex)       <- BLOCKS: the producer holds it forever

   Nobody can proceed. Correct order:

   Producer:  wait(empty)       <- block on the CONDITION first, holding nothing
              wait(mutex)       <- only then take the lock
              ... insert ...
              signal(mutex)
              signal(full)

   Rule: acquire the counting semaphore BEFORE the mutex, and release in
   the reverse order.
```

```c
#include <semaphore.h>
#include <pthread.h>

#define N 10
int buffer[N], in = 0, out = 0;

sem_t empty;      /* free slots:   init N */
sem_t full;       /* filled slots: init 0 */
sem_t mutex;      /* exclusion:    init 1 */

void producer(int item) {
    sem_wait(&empty);          /* 1. block if full -- holding NOTHING */
    sem_wait(&mutex);          /* 2. only now take the lock           */

    buffer[in] = item;         /*    critical section: short          */
    in = (in + 1) % N;

    sem_post(&mutex);          /* 3. release in REVERSE order         */
    sem_post(&full);           /* 4. announce an item is available    */
}

int consumer(void) {
    sem_wait(&full);           /* block if empty                      */
    sem_wait(&mutex);

    int item = buffer[out];
    out = (out + 1) % N;

    sem_post(&mutex);
    sem_post(&empty);          /* a slot is now free: may wake a producer */
    return item;
}
```

```python
import queue, threading, time

# In practice, use the library: queue.Queue IS the bounded-buffer solution.
work = queue.Queue(maxsize=10)          # bounded -> backpressure
SENTINEL = object()

def producer():
    for i in range(100):
        work.put(i)                     # BLOCKS when full: the producer is
                                        # throttled to the consumer's rate
    work.put(SENTINEL)                  # signal end of stream

def consumer():
    while True:
        item = work.get()               # BLOCKS when empty
        if item is SENTINEL:
            work.put(SENTINEL)          # re-post so other consumers also stop
            break
        process(item)
        work.task_done()

# Setting maxsize=0 makes the queue UNBOUNDED: a fast producer then grows
# it until memory is exhausted. The bound is a feature, not a limitation.
```

**Key takeaways**

- Producer-consumer requires mutual exclusion plus blocking on both the full and empty conditions.
- The classic solution uses two counting semaphores (`empty`, `full`) and one binary semaphore for exclusion.
- Waiting on the mutex before the counting semaphore deadlocks; always block on the condition first.
- A bounded buffer provides backpressure, which is why unbounded queues are a memory-exhaustion hazard.

> 🧪 Practice
>
> 1. Implement the bounded buffer with a mutex and two condition variables instead of semaphores, and test with 3 producers and 2 consumers.
> 2. Swap the two `sem_wait` calls in the producer, run it, and explain the deadlock you observe.
> 3. Interview-style: "Why would you choose a bounded queue over an unbounded one in a service?" *Hint: consider what happens when the consumer slows down for ten minutes.*

#### Readers-Writers Problem

**Theory**

The **readers-writers problem** asks how to coordinate threads that only read shared data with those that modify it — the problem the readers-writers lock of 5.3 solves. Studying it as a problem rather than a primitive makes the fairness trade-off explicit, because there is no single correct answer: there are several formulations, and each starves someone.

**The first readers-writers problem (reader-priority).** No reader waits unless a writer already holds the lock. This maximises read concurrency and is the simplest to implement — but writers can starve indefinitely: as long as at least one reader is always active, the reader count never reaches zero and a waiting writer never proceeds.

**The second readers-writers problem (writer-priority).** Once a writer is waiting, no new reader may begin. Writers get timely access; readers can now starve under a continuous stream of writes.

**The third formulation (fair / no starvation).** Requests are served in arrival order, typically by having both readers and writers queue on a common turnstile semaphore. Neither side starves, at some cost in read throughput.

The reader-priority solution is the one worth being able to write from memory, because its structure recurs:

- A `read_count` variable, itself protected by a `mutex`.
- A `rw_mutex` held by writers exclusively, and acquired by the **first** reader and released by the **last** reader.

That last idea — the first arrival acquires on behalf of the whole group and the last departure releases — is a general pattern (a "lightswitch") that appears well beyond this problem.

The practical guidance from 5.3 still applies: prefer a library implementation, choose a writer-preferring or fair one for anything that must accept updates, and consider RCU or copy-on-write when reads dominate overwhelmingly.

**Example**

```text
   Reader-priority: the lightswitch pattern

   first reader in  -> acquires rw_mutex (locking out writers for the group)
   readers 2..n     -> just increment the count; no writer can be active anyway
   last reader out  -> releases rw_mutex

   read_count: 0 -> 1  (acquire rw_mutex)
               1 -> 2, 2 -> 3   (no lock operations at all)
               3 -> 2, 2 -> 1
               1 -> 0  (release rw_mutex)

   The three formulations and who starves

   formulation      | new reader arrives while a writer waits | starves
   -----------------+----------------------------------------+---------
   first  (readers) | admitted immediately                   | writers
   second (writers) | must wait                              | readers
   third  (fair)    | queues behind the writer               | nobody

   Writer starvation, concretely

   R1 [=====]              R3 [=====]
      R2 [=====]              R4 [=====]        read_count never hits 0
   W1 waiting ..............................    -> rw_mutex never released
```

```c
#include <semaphore.h>

sem_t rw_mutex;      /* init 1: held by a writer, or by the reader group */
sem_t mutex;         /* init 1: protects read_count                      */
int   read_count = 0;

/* --- Writer: straightforward exclusive access --- */
void writer(void) {
    sem_wait(&rw_mutex);
    write_shared_data();
    sem_post(&rw_mutex);
}

/* --- Reader: the lightswitch --- */
void reader(void) {
    sem_wait(&mutex);
    read_count++;
    if (read_count == 1)          /* FIRST reader locks out writers for
                                     the whole group                     */
        sem_wait(&rw_mutex);
    sem_post(&mutex);

    read_shared_data();           /* many readers execute here at once   */

    sem_wait(&mutex);
    read_count--;
    if (read_count == 0)          /* LAST reader lets writers back in    */
        sem_post(&rw_mutex);
    sem_post(&mutex);
}
/* This is the FIRST formulation: a new reader arriving while a writer waits
   simply increments read_count and proceeds -> writers may starve. */
```

```python
import threading

class FairRWLock:
    """Third formulation: a turnstile enforces arrival order, so neither
       readers nor writers can starve."""

    def __init__(self):
        self._turnstile = threading.Semaphore(1)   # every arrival passes here
        self._rw = threading.Semaphore(1)          # exclusive access
        self._mutex = threading.Lock()
        self._readers = 0

    def acquire_read(self):
        self._turnstile.acquire()                  # queue in ARRIVAL ORDER;
        self._turnstile.release()                  # a waiting writer holds it,
                                                   # so later readers queue behind
        with self._mutex:
            self._readers += 1
            if self._readers == 1:
                self._rw.acquire()                 # lightswitch on

    def release_read(self):
        with self._mutex:
            self._readers -= 1
            if self._readers == 0:
                self._rw.release()                 # lightswitch off

    def acquire_write(self):
        self._turnstile.acquire()                  # HOLD it: blocks new readers
        self._rw.acquire()                         # wait for current readers

    def release_write(self):
        self._rw.release()
        self._turnstile.release()                  # let the queue drain
```

**Key takeaways**

- The problem has three standard formulations, distinguished by who is allowed to overtake whom.
- Reader-priority maximises read concurrency and starves writers; writer-priority does the reverse.
- The reader solution uses a lightswitch: the first reader acquires the exclusive lock for the group, the last releases it.
- A fair solution adds a turnstile that both sides must pass, enforcing arrival order and eliminating starvation.

> 🧪 Practice
>
> 1. Implement the reader-priority solution and demonstrate writer starvation with a continuous stream of readers.
> 2. Modify it to be writer-preferring, then show that readers can now starve.
> 3. Interview-style: "Which formulation would you choose for a routing table read on every packet and updated on topology change?" *Hint: ask what the consequence is of a stale table versus a delayed packet.*

#### Dining Philosophers Problem

**Theory**

Dijkstra's **dining philosophers** (1965) is the canonical illustration of **deadlock**, and its value is that the deadlock is not a coding mistake — it arises from a symmetric, apparently reasonable protocol.

Five philosophers sit around a table, alternating between thinking and eating. Between each pair is a single chopstick, and a philosopher needs both neighbouring chopsticks to eat. The obvious algorithm is: pick up the left chopstick, then the right one, eat, put both down.

This deadlocks. If all five simultaneously pick up their left chopstick, each holds one and waits forever for a right one that will never be released. All four Coffman conditions (Chapter 6) are present: mutual exclusion on chopsticks, hold-and-wait, no preemption, and a circular wait around the table.

The classic remedies each break one condition, and comparing them is the real lesson:

| Solution | Condition broken | Cost |
|---|---|---|
| **Allow at most 4 at the table** | Circular wait | Requires a global counting semaphore |
| **Asymmetric: one philosopher picks up right first** | Circular wait | Breaks the cycle with a single exception |
| **Pick up both or neither (atomic acquisition)** | Hold-and-wait | Needs a lock over the whole table; less concurrency |
| **Global ordering: always take the lower-numbered chopstick first** | Circular wait | The general, practical answer |
| **Timeout and retry** | No preemption | Risks livelock without randomised backoff |

The **global lock ordering** solution is the one that generalises to real software, and it is the single most useful takeaway in this chapter: *if every thread acquires locks in the same global order, circular wait is impossible and deadlock cannot occur.* This is why production codebases document a lock hierarchy, and why the two-account transfer problem is solved by locking accounts in ID order.

A subtlety: solving deadlock is not the same as ensuring fairness. A solution can be deadlock-free while allowing one philosopher to starve — the two properties must be checked separately.

**Example**

```text
   The table

              P0
        C4          C0
     P4                P1
        C3          C1
              P3  C2  P2

   THE DEADLOCK (every philosopher takes left first, simultaneously)

   P0 holds C0, waits for C1
   P1 holds C1, waits for C2
   P2 holds C2, waits for C3
   P3 holds C3, waits for C4
   P4 holds C4, waits for C0        <- the cycle closes: nobody proceeds

   FIX BY ASYMMETRY (P4 takes right first)

   P4 tries C0 first. Either it gets C0 (so P0 cannot hold it and the cycle
   is broken), or it does not (so it holds nothing and blocks harmlessly).
   The cycle can never close.

   FIX BY GLOBAL ORDERING (always take the LOWER-numbered chopstick first)

   P0: C0 then C1     P1: C1 then C2     P2: C2 then C3
   P3: C3 then C4     P4: C0 then C4     <- note: NOT C4 then C0
   Acquisition order is monotonic for everyone -> no cycle is possible.
```

```c
#include <pthread.h>
#define N 5

pthread_mutex_t chopstick[N];

/* --- DEADLOCKS: symmetric left-then-right --- */
void philosopher_broken(int i) {
    while (1) {
        think();
        pthread_mutex_lock(&chopstick[i]);            /* left  */
        pthread_mutex_lock(&chopstick[(i + 1) % N]);  /* right -- may never come */
        eat();
        pthread_mutex_unlock(&chopstick[(i + 1) % N]);
        pthread_mutex_unlock(&chopstick[i]);
    }
}

/* --- CORRECT: global lock ordering. The general solution. --- */
void philosopher(int i) {
    int left = i, right = (i + 1) % N;
    int first = left < right ? left : right;    /* always the LOWER index first */
    int second = left < right ? right : left;

    while (1) {
        think();
        pthread_mutex_lock(&chopstick[first]);   /* monotonic order for every
                                                    philosopher -> no cycle    */
        pthread_mutex_lock(&chopstick[second]);
        eat();
        pthread_mutex_unlock(&chopstick[second]);
        pthread_mutex_unlock(&chopstick[first]);
    }
}
```

```python
import threading

# The same principle in real code: the classic two-account transfer.
class Account:
    def __init__(self, id_, balance):
        self.id = id_
        self.balance = balance
        self.lock = threading.Lock()

def transfer_broken(src, dst, amount):
    with src.lock:              # thread 1: A then B
        with dst.lock:          # thread 2: B then A   -> DEADLOCK
            src.balance -= amount
            dst.balance += amount

def transfer(src, dst, amount):
    # Order the locks by a stable global key -- exactly the philosophers' fix.
    first, second = (src, dst) if src.id < dst.id else (dst, src)
    with first.lock:
        with second.lock:
            if src.balance >= amount:
                src.balance -= amount
                dst.balance += amount
                return True
            return False
```

**Key takeaways**

- Dining philosophers shows that a symmetric, reasonable protocol can deadlock without any coding error.
- The deadlock arises from a circular wait, one of the four conditions covered in Chapter 6.
- Standard fixes limit concurrency, break symmetry, acquire atomically, or impose a global ordering.
- Global lock ordering is the solution that generalises: identical acquisition order everywhere makes deadlock impossible.

> 🧪 Practice
>
> 1. Implement the broken version with five threads and observe the deadlock. Confirm the state with a thread dump or `gdb`.
> 2. Implement two different fixes and compare their throughput. Which permits the most concurrent eating?
> 3. Interview-style: "Two threads transfer money between the same pair of accounts in opposite directions and the service hangs. Diagnose and fix." *Hint: this is the philosophers' cycle with N = 2.*

#### Sleeping Barber Problem

**Theory**

The **sleeping barber** problem (Dijkstra) models a service system with a finite waiting area, and it isolates a difficulty the previous problems do not: the **rendezvous** between a server that sleeps when idle and clients that must decide whether to wait or leave.

The setup: a barber shop has one barber, one barber chair, and N waiting chairs. If there are no customers, the barber sleeps. A customer who arrives wakes the barber if asleep, sits in a waiting chair if one is free, or **leaves immediately** if the waiting room is full.

Three coordination problems must be solved at once:

1. **The barber must sleep when idle** rather than busy-waiting for customers.
2. **A customer must wake a sleeping barber**, and exactly one customer must be served per wake.
3. **The waiting room is bounded**, so an arriving customer must atomically check for a free chair and either take it or leave.

That third point is where the classic race lives. Checking "is a chair free?" and then sitting down must be one atomic operation — otherwise two customers can both observe the last free chair and both sit, overflowing the room. The count must be protected by a mutex, and the decision to leave must be made *while holding it*.

The standard solution uses three semaphores:

- `customers`, initialised to 0: the barber waits on it, so it sleeps when there are none.
- `barber`, initialised to 0: a customer waits on it until the barber is ready for them.
- `mutex`, initialised to 1: protects `waiting`, the count of seated customers.

The `customers`/`barber` pair is a **rendezvous**: each side signals the other and waits, so neither proceeds until both are ready. This is the reusable idea, and it appears in every thread-pool implementation — the pool's worker threads sleep on a queue-not-empty condition, submitters wake exactly one, and a bounded queue rejects work when full. The barber is a worker thread, the waiting chairs are the queue, and a customer leaving is a rejection policy (Chapter 4's `CallerRunsPolicy` and friends).

**Example**

```text
   The shop

   +-------------------------------------------+
   |  waiting chairs: [C][C][ ][ ][ ]  (N = 5) |
   |                                           |
   |  barber chair:   [ BARBER + customer ]    |
   +-------------------------------------------+

   customers arrive -> chair free? sit and signal the barber
                    -> room full?  LEAVE (this is a rejection policy)

   The rendezvous

   CUSTOMER                          BARBER
     wait(mutex)                       wait(customers)   <- SLEEPS here when 0
     if waiting == N:                  wait(mutex)
         signal(mutex); leave          waiting--
     waiting++                         signal(barber)    <- "I am ready for you"
     signal(customers)  ------------>  signal(mutex)
     signal(mutex)                     cut_hair()
     wait(barber)       <------------
     get_haircut()

   THE RACE without the mutex

   two customers both read waiting == 4 (one chair left)
   both increment -> waiting == 6 in a 5-chair room
   The check and the increment must be ONE atomic step.

   The same structure, in production

   barber          = a worker thread in a pool
   waiting chairs  = the bounded task queue
   sleeping barber = a worker blocked on "queue not empty"
   customer leaves = the pool's rejection policy when the queue is full
```

```c
#include <semaphore.h>
#define CHAIRS 5

sem_t customers;   /* init 0: counts waiting customers; the barber sleeps here */
sem_t barber;      /* init 0: signals a customer that the barber is ready      */
sem_t mutex;       /* init 1: protects `waiting`                               */
int   waiting = 0;

void barber_thread(void) {
    while (1) {
        sem_wait(&customers);      /* SLEEP until a customer arrives */

        sem_wait(&mutex);
        waiting--;                 /* take one customer out of the waiting room */
        sem_post(&barber);         /* tell that customer to come over            */
        sem_post(&mutex);

        cut_hair();                /* outside the mutex: it takes a long time    */
    }
}

void customer_thread(void) {
    sem_wait(&mutex);              /* check-and-sit must be ATOMIC */
    if (waiting < CHAIRS) {
        waiting++;
        sem_post(&customers);      /* wake the barber if it is asleep */
        sem_post(&mutex);          /* release BEFORE blocking, or nobody
                                      else could ever enter the shop    */
        sem_wait(&barber);         /* wait my turn */
        get_haircut();
    } else {
        sem_post(&mutex);          /* room full: leave. Must release the mutex. */
        leave_without_haircut();
    }
}
```

```python
import threading, queue

# The modern equivalent: a worker pool with a bounded queue and a
# rejection policy. Same three problems, solved by the library.
class BarberShop:
    def __init__(self, chairs=5):
        self._chairs = queue.Queue(maxsize=chairs)   # the waiting room
        self._barber = threading.Thread(target=self._work, daemon=True)
        self._barber.start()

    def _work(self):
        while True:
            customer = self._chairs.get()   # SLEEPS here when empty:
                                            # exactly the sleeping barber
            self._cut_hair(customer)
            self._chairs.task_done()

    def arrive(self, customer):
        try:
            self._chairs.put_nowait(customer)   # atomic check-and-sit
            return True
        except queue.Full:
            return False                        # the customer leaves
```

**Key takeaways**

- The sleeping barber models a server that sleeps when idle and a bounded waiting area for clients.
- It requires a rendezvous: the barber signals readiness and the customer signals arrival, each waiting for the other.
- Checking for a free chair and taking it must be atomic, or the waiting room overflows.
- The structure is exactly a thread pool: sleeping workers, a bounded queue, and a rejection policy when full.

> 🧪 Practice
>
> 1. Implement the solution and verify that customers are turned away when all chairs are occupied.
> 2. Extend it to multiple barbers. What changes, and what does not?
> 3. Interview-style: "Map the sleeping barber onto a web server with a connection backlog." *Hint: identify the barber, the chairs, and what corresponds to a connection being refused.*

<a id="55-alternative-approaches"></a>
### 5.5 Alternative Approaches

Locks are not the only answer, and sometimes they are the wrong one; this section covers techniques that avoid blocking, that make composition easier, and that the kernel itself relies on.

#### Lock-Free Data Structures

**Theory**

Locks have costs beyond their execution time. A thread holding a lock and then descheduled blocks every waiter for its entire absence — **convoying**. A thread that crashes or is killed while holding a lock leaves it held forever. Locks cannot be taken in some contexts (interrupt handlers, signal handlers). And composing two lock-protected operations atomically requires holding both locks, reintroducing deadlock risk.

**Lock-free** programming avoids all of this by using atomic operations directly, with the guarantee that **at least one thread always makes progress**, regardless of what any other thread does — including being preempted mid-operation. There is a precise hierarchy:

| Property | Guarantee |
|---|---|
| **Blocking** | A stalled thread can prevent all progress |
| **Obstruction-free** | A thread makes progress if it runs alone (others may cause it to retry) |
| **Lock-free** | Some thread always makes progress; individual threads may starve |
| **Wait-free** | Every thread completes in a bounded number of steps |

Wait-freedom is the strongest and rarest, valuable for real-time systems where per-thread bounds matter.

The universal building block is the CAS retry loop of 5.2. The characteristic difficulty is **memory reclamation**: with locks, you know nobody is inside a structure when you free a node. Lock-free, another thread may hold a pointer to a node you are about to free, and there is no lock to tell you. Three standard solutions exist — **hazard pointers** (each thread publishes what it is reading; nothing published may be freed), **epoch-based reclamation** (free only when all threads have passed an epoch boundary), and **garbage collection** (why lock-free structures are notably easier in Java and Go than in C++).

The honest assessment: lock-free code is difficult to write, harder to verify, and **frequently slower than a good lock** under contention, since retries waste work that a lock would have avoided. Use existing library implementations (`ConcurrentLinkedQueue`, `crossbeam`, `folly`), and write your own only with a measured reason.

**Example**

```text
   Progress guarantees

   BLOCKING (mutex)
     T1 takes the lock, is preempted for 10 ms
     T2, T3, T4 -> all blocked for 10 ms       (convoying)

   LOCK-FREE (CAS)
     T1 is preempted mid-operation
     T2 CASes successfully and completes       system progresses
     T1 resumes, its CAS fails, it retries     T1 may retry many times

   WAIT-FREE
     every thread completes within a bounded number of steps, always

   The memory reclamation hazard

   T1: reads head -> node A, about to dereference A->next
   T2: pops A and calls free(A)
   T1: dereferences freed memory        <- use-after-free
   There is no lock to tell T2 that T1 is still inside.

   Hazard pointers

   T1 publishes: "I am reading A"  -> hazard[T1] = A
   T2 wants to free A: scans all hazard slots, sees A is published,
      defers the free to a retire list and reclaims it later.
```

```java
import java.util.concurrent.atomic.AtomicReference;

// A lock-free (Treiber) stack. No mutex anywhere; the GC handles reclamation.
public class LockFreeStack<T> {
    private static class Node<T> {
        final T value; Node<T> next;
        Node(T value) { this.value = value; }
    }

    private final AtomicReference<Node<T>> head = new AtomicReference<>();

    public void push(T value) {
        Node<T> newHead = new Node<>(value);
        Node<T> oldHead;
        do {
            oldHead = head.get();          // 1. read current state
            newHead.next = oldHead;        // 2. compute desired state
        } while (!head.compareAndSet(oldHead, newHead));
        //         ^ 3. commit only if nothing changed; otherwise retry.
        //           A preempted thread here blocks NOBODY.
    }

    public T pop() {
        Node<T> oldHead, newHead;
        do {
            oldHead = head.get();
            if (oldHead == null) return null;
            newHead = oldHead.next;
        } while (!head.compareAndSet(oldHead, newHead));
        return oldHead.value;
        // In C++ this would be an ABA and use-after-free minefield; the JVM's
        // GC will not recycle `oldHead` while any thread can still reach it.
    }
}
```

```python
# When lock-free is the WRONG choice: measure before you commit to it.
#
#   contention   | mutex        | lock-free CAS
#   -------------+--------------+---------------------------
#   none         | ~20 ns       | ~20 ns       (comparable)
#   low          | ~50 ns       | ~30 ns       (CAS wins)
#   high (16 thr)| ~500 ns      | ~2000 ns     (retries dominate: LOCK wins)
#
# Under heavy contention the CAS loop repeatedly does work and throws it
# away, while a mutex lets losers sleep instead of burning CPU.
```

**Key takeaways**

- Lock-free algorithms guarantee that some thread always progresses, avoiding convoying and lock-holder failure.
- The hierarchy runs blocking, obstruction-free, lock-free, wait-free, with wait-freedom the strongest.
- The hard part is memory reclamation: hazard pointers, epoch-based schemes, or a garbage collector are required.
- Lock-free is often slower than a good lock under high contention; prefer library implementations and measure first.

> 🧪 Practice
>
> 1. Implement a lock-free counter and a mutex counter, and benchmark both at 1, 4, and 32 threads. Identify the crossover.
> 2. Explain why the Treiber stack above is safe in Java but would need hazard pointers in C.
> 3. Interview-style: "Why is 'lock-free' not the same as 'faster'?" *Hint: consider what a losing thread does in each design and how much work it discards.*

#### Transactional Memory

**Theory**

Locks have a composability problem that no amount of care fixes. Given a thread-safe `withdraw` and a thread-safe `deposit`, there is no way to compose them into an atomic `transfer` without reaching inside both and taking their locks — which requires knowing their internals and reintroduces lock-ordering deadlock. Locks do not compose.

**Transactional memory** (TM) borrows the database solution. A block of code is marked as a **transaction**: it executes optimistically while the system tracks every memory location read and written; at commit, if no other transaction touched those locations, the changes are applied atomically. If there was a conflict, the transaction is **rolled back and retried**.

The advantages are substantial:

- **Composability.** Nested transactions compose naturally — a transaction containing two others is simply a bigger transaction.
- **No deadlock**, because no locks are taken and there is no acquisition order to get wrong.
- **Optimistic concurrency.** Operations that touch disjoint data proceed in parallel without the programmer having to prove they are disjoint, which is what fine-grained locking demands.
- **Simplicity.** The programmer marks *what* must be atomic instead of designing *how* to make it so.

Two implementations exist. **Software TM** (STM) needs no hardware but adds substantial overhead — often 2-5x — because every read and write is instrumented. **Hardware TM** (Intel TSX, IBM POWER) uses the cache-coherence protocol to detect conflicts nearly for free, but transactions are bounded by cache capacity, can abort for reasons unrelated to conflicts (interrupts, page faults, system calls), and therefore **always require a fallback path**, usually a conventional lock.

The state of the art is mixed. Intel disabled TSX on many parts after security vulnerabilities were discovered, and hardware TM never became mainstream. STM is genuinely successful in Haskell and Clojure, where the language's control over side effects makes rollback safe — and that is the deep limitation: **irreversible operations cannot be rolled back.** A transaction that performs I/O, sends a network message, or takes a lock cannot simply be retried, which is why STM works best in languages that can restrict what a transaction may do.

**Example**

```text
   The composability problem locks cannot solve

   Thread-safe pieces:
     account.withdraw(x)   -- takes account's lock
     account.deposit(x)    -- takes account's lock

   Wanted: transfer(a, b, x) that is atomic as a WHOLE.
   With locks: you must reach INSIDE both objects, take both locks in a
   globally consistent order, and hope no other code path disagrees.
   With transactions: just wrap both calls. Nesting composes automatically.

   How a transaction executes

   BEGIN
     read set  = { }        every read is recorded
     write set = { }        every write is buffered, not applied
     ... run the block optimistically ...
   COMMIT
     if nothing else wrote to my read set -> apply the write set atomically
     else                                 -> DISCARD everything and RETRY

   Two transactions on disjoint data both commit: full parallelism,
   with no lock and no programmer-supplied proof that they are disjoint.

   Why hardware TM needs a fallback

   abort causes: conflict, cache capacity exceeded, interrupt, page fault,
                 system call, unsupported instruction
   -> a transaction may NEVER succeed, so code must fall back to a lock
      after a few attempts.
```

```haskell
-- Haskell STM: the type system guarantees a transaction cannot do I/O,
-- which is exactly what makes rollback safe.
import Control.Concurrent.STM

transfer :: TVar Int -> TVar Int -> Int -> STM ()
transfer from to amount = do
    balance <- readTVar from
    if balance < amount
        then retry                    -- block until `from` CHANGES, then
                                      -- re-run: no condition variable needed
        else do
            writeTVar from (balance - amount)
            modifyTVar' to (+ amount)

main :: IO ()
main = do
    a <- atomically $ newTVar 1000
    b <- atomically $ newTVar 500
    atomically $ transfer a b 300     -- the WHOLE thing is atomic

    -- Composition, which locks cannot express safely:
    atomically $ do
        transfer a b 100              -- two atomic operations become
        transfer b a 50               -- ONE atomic operation, for free
```

```c
/* Hardware TM (Intel TSX), with the mandatory lock fallback. */
#include <immintrin.h>

void transfer(struct account *a, struct account *b, int amount) {
    for (int attempt = 0; attempt < 3; attempt++) {
        unsigned status = _xbegin();
        if (status == _XBEGIN_STARTED) {
            if (a->balance >= amount) {          /* speculative execution:  */
                a->balance -= amount;            /* tracked by the cache    */
                b->balance += amount;            /* coherence protocol      */
            }
            _xend();                             /* commit atomically       */
            return;
        }
        /* Aborted: conflict, capacity, interrupt, or page fault. Retry. */
    }
    /* FALLBACK: a transaction may never succeed, so a lock path is
       mandatory, not optional. */
    lock_both_ordered(a, b);
    if (a->balance >= amount) { a->balance -= amount; b->balance += amount; }
    unlock_both(a, b);
}
```

**Key takeaways**

- Transactional memory executes a block optimistically, tracking reads and writes, and retries on conflict.
- It solves the composability problem that locks cannot: nested transactions merge into one atomic operation.
- Software TM is portable but slow; hardware TM is fast but bounded and always needs a lock fallback.
- Transactions cannot contain irreversible operations, which is why STM succeeds mainly in languages that restrict side effects.

> 🧪 Practice
>
> 1. Explain why `transfer` cannot be composed from thread-safe `withdraw` and `deposit` without reaching inside both.
> 2. Name three reasons a hardware transaction can abort that have nothing to do with a data conflict.
> 3. Interview-style: "Why can't a transaction send a network packet?" *Hint: consider what the system must be able to do if the transaction aborts.*

#### Priority Inversion and Inheritance

**Theory**

**Priority inversion** occurs when a high-priority task is blocked by a lower-priority one, effectively inverting their priorities. It is unavoidable in principle whenever priorities coexist with locks: if a low-priority task holds a lock a high-priority task needs, the high-priority task must wait. That much is *bounded* inversion, and it is acceptable.

The failure is **unbounded priority inversion**, which requires a third participant:

1. **Low** acquires lock L.
2. **High** becomes runnable, tries to acquire L, and blocks.
3. **Medium** — which needs no lock at all — becomes runnable and preempts Low, because it has higher priority.
4. Low cannot run, so it cannot release L, so High cannot run.

High is now effectively waiting behind Medium, a task it outranks, for an unbounded time. There can be any number of medium-priority tasks, so the delay has no upper bound at all.

This is not a theoretical concern. In July 1997 the **Mars Pathfinder** lander began resetting repeatedly on the Martian surface: a high-priority bus management task blocked on a mutex held by a low-priority meteorological task, which was preempted by medium-priority communications work. A watchdog timer detected the missed deadline and reset the system. The fix — enabling priority inheritance on that mutex — was uploaded to Mars.

Two protocols solve it:

- **Priority inheritance.** When a high-priority task blocks on a lock, the holder **temporarily inherits** the waiter's priority, so it cannot be preempted by medium-priority tasks and finishes quickly. On release, it reverts. This is the common solution (`PTHREAD_PRIO_INHERIT`, and the default for `SCHED_DEADLINE` and RT mutexes in Linux).
- **Priority ceiling.** Each lock is statically assigned a **ceiling** equal to the highest priority of any task that may acquire it. A task holding the lock runs at that ceiling immediately. This bounds blocking more tightly and prevents deadlock as a side effect, but requires knowing the full set of lock users in advance.

The general lesson beyond real-time systems: **priorities and locks interact badly**, and any system that uses both needs an inheritance protocol.

**Example**

```text
   UNBOUNDED PRIORITY INVERSION

   priority
   HIGH  |            [blocked on L .................................] [runs]
   MED   |                  [============ runs freely ==============]
   LOW   |  [takes L][preempted..................................][release L]
         +--------------------------------------------------------------> time
                     ^                                          ^
                     H blocks here                    L finally resumes
         H waits for MED, which it outranks, for an UNBOUNDED time
         (add more medium tasks and the delay grows without limit)

   WITH PRIORITY INHERITANCE

   priority
   HIGH  |            [blocked][=================================][runs]
   MED   |                                                    [runs]
   LOW   |  [takes L][runs AT HIGH PRIORITY][release L]
         +--------------------------------------------------------------> time
                      ^                     ^
             L inherits HIGH, so MED        L reverts to LOW
             cannot preempt it              H proceeds immediately

   Blocking is now bounded by the LENGTH OF THE CRITICAL SECTION,
   not by the amount of medium-priority work in the system.
```

```c
#include <pthread.h>

/* Enable priority inheritance -- the Mars Pathfinder fix, in two lines. */
pthread_mutex_t lock;
pthread_mutexattr_t attr;

void init_rt_mutex(void) {
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
    /* Alternative: PTHREAD_PRIO_PROTECT with an explicit ceiling.
         pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_PROTECT);
         pthread_mutexattr_setprioceiling(&attr, 80);
       Tighter bound, but requires knowing every user of the lock. */
    pthread_mutex_init(&lock, &attr);
}

/* Without setprotocol, the default is PTHREAD_PRIO_NONE: no inheritance,
   and unbounded inversion is possible. This is the default almost
   everywhere, which is why it must be set explicitly. */
```

```python
# The general lesson, in plain terms.
#
# Any system combining PRIORITIES with LOCKS can invert. That includes:
#   - RTOS tasks and a shared mutex
#   - a thread pool with prioritised work and a shared cache lock
#   - Linux SCHED_FIFO threads sharing a futex with SCHED_OTHER threads
#
# Mitigations, in order of preference:
#   1. Enable priority inheritance on every shared mutex.
#   2. Do not share locks across priority bands at all (partition the data).
#   3. Keep critical sections extremely short, bounding the inversion.
#   4. Use lock-free structures, where there is no holder to preempt.
```

**Key takeaways**

- Priority inversion is a high-priority task blocked by a lower-priority lock holder; some inversion is unavoidable.
- Unbounded inversion needs a third, medium-priority task that preempts the holder while the high task waits.
- Priority inheritance temporarily raises the holder to the waiter's priority, bounding the delay by the critical section.
- Priority ceiling assigns each lock the highest priority of any user, bounding blocking further and preventing deadlock.

> 🧪 Practice
>
> 1. Draw a timeline of unbounded inversion with three tasks, then redraw it with priority inheritance enabled.
> 2. Explain why priority ceiling requires static knowledge of the system and what it gains in return.
> 3. Interview-style: "An RTOS task misses its deadline only when an unrelated medium-priority task is active. Diagnose it." *Hint: look for a lock shared between the high-priority task and something below the medium one.*

#### Kernel Synchronization Mechanisms

**Theory**

The kernel faces every problem in this chapter under harder constraints. It runs on all cores simultaneously, is entered from interrupt handlers that cannot sleep, must not deadlock against itself, and its synchronization cost is paid by every process on the machine. It therefore uses a wider and more specialised toolkit.

The core constraint that shapes everything: **some kernel contexts cannot sleep.** Interrupt handlers and code holding a spinlock must never block, which immediately rules out mutexes and semaphores in those paths.

| Mechanism | Sleeps? | Use |
|---|---|---|
| **Spinlock** | No | Short critical sections, any context including interrupts |
| **Mutex / semaphore** | Yes | Longer sections in process context only |
| **`spin_lock_irqsave`** | No | When the same lock is taken in interrupt context |
| **Atomic variables** | No | Counters and flags, no lock needed |
| **Per-CPU variables** | N/A | Eliminate sharing entirely — the cheapest option |
| **Seqlock** | No | Write-rare, read-frequent data (timekeeping) |
| **RCU** | Readers never block | Read-mostly structures: routing tables, module lists |

Two mechanisms deserve particular attention because they represent genuinely different ideas:

**RCU (read-copy-update)** makes readers **completely free** — no locks, no atomic operations, not even a memory barrier on strongly ordered architectures. A writer copies the data, modifies the copy, and atomically swaps the pointer. Old readers continue safely on the old version; the old copy is freed only after a **grace period**, when every CPU has passed through a context switch and therefore cannot still hold a reference. RCU trades write cost and reclamation delay for essentially zero read cost, which is exactly the right trade for the kernel's many read-mostly structures.

**Seqlocks** let writers proceed without waiting for readers. A sequence counter is incremented before and after each write (making it odd during the write). A reader samples the counter, reads the data, and samples again; if the values differ or are odd, it retries. This suits small, frequently read values such as the system clock.

**Per-CPU variables** deserve the last word: the cheapest synchronization is none. Giving each CPU its own copy of a counter and summing on demand eliminates contention entirely, and it is why kernel statistics are almost always per-CPU.

**Example**

```text
   Choosing a kernel primitive

   Can this code sleep?
     |
     +-- NO (interrupt handler, holding a spinlock)
     |     |
     |     +-- Is it also taken from an IRQ?  -> spin_lock_irqsave
     |     +-- Just a counter?                -> atomic_t
     |     +-- Read-mostly?                   -> RCU / seqlock
     |     +-- Otherwise                      -> spin_lock
     |
     +-- YES (process context)
           |
           +-- Long critical section          -> mutex
           +-- Counting a resource            -> semaphore
           +-- Read-heavy                     -> rw_semaphore or RCU

   RCU: how a reader pays nothing

   readers:  rcu_read_lock() ... use pointer ... rcu_read_unlock()
             ^ on most architectures this compiles to NOTHING but a
               compiler barrier and preemption bookkeeping

   writer:   copy = clone(old)
             modify(copy)
             rcu_assign_pointer(ptr, copy)     <- one atomic pointer swap
             synchronize_rcu()                 <- WAIT for the grace period
             kfree(old)                        <- now provably unreachable

   timeline:
     old readers ---[still using old]---|
     new readers ------------------[use new]------------>
                                        ^
                              grace period ends here; old is freed

   Seqlock: writers never wait for readers

   writer: seq++ (now ODD) ... write ... seq++ (now EVEN)
   reader: s1 = seq; if odd, retry
           read data
           s2 = seq; if s1 != s2, RETRY (a write happened mid-read)
```

```c
/* --- RCU: the kernel's read-mostly workhorse --- */
struct config __rcu *global_config;

/* READER: no lock, no atomic, no wait. Runs concurrently with the writer. */
int lookup_timeout(void) {
    struct config *cfg;
    int value;

    rcu_read_lock();                          /* marks a read-side section;
                                                 essentially free            */
    cfg = rcu_dereference(global_config);     /* safe pointer load           */
    value = cfg->timeout;
    rcu_read_unlock();
    return value;
}

/* WRITER: copy, modify, swap, then wait before freeing. */
void update_timeout(int new_timeout) {
    struct config *old, *new;

    new = kmalloc(sizeof *new, GFP_KERNEL);
    old = rcu_dereference_protected(global_config, lockdep_is_held(&cfg_lock));
    *new = *old;                              /* COPY                        */
    new->timeout = new_timeout;               /* UPDATE the copy             */

    rcu_assign_pointer(global_config, new);   /* atomic swap: new readers
                                                 see `new`, old ones are
                                                 still safely using `old`    */
    synchronize_rcu();                        /* wait until no reader can
                                                 hold `old` any more         */
    kfree(old);                               /* only NOW is it safe         */
}

/* --- Per-CPU: the cheapest synchronization is none at all --- */
DEFINE_PER_CPU(unsigned long, packets_received);

void on_packet(void) {
    this_cpu_inc(packets_received);     /* no atomic, no lock, no contention:
                                           each CPU touches only its own copy */
}

unsigned long total_packets(void) {
    unsigned long total = 0;
    int cpu;
    for_each_possible_cpu(cpu)
        total += per_cpu(packets_received, cpu);   /* sum only when asked */
    return total;
}
```

```bash
# Observing kernel synchronization on a live system.
cat /proc/lock_stat                     # lock contention statistics (CONFIG_LOCK_STAT)
dmesg | grep -i lockdep                 # lockdep: runtime lock-order validation
perf lock report                        # which locks are contended, and for how long
cat /sys/kernel/debug/rcu/rcugp         # RCU grace period progress
```

**Key takeaways**

- The kernel's defining constraint is that interrupt handlers and spinlock holders must never sleep.
- Primitive choice follows from context: spinlocks and atomics where sleeping is forbidden, mutexes where it is allowed.
- RCU gives readers essentially zero cost by copying on write and deferring reclamation until a grace period ends.
- Seqlocks let writers proceed without waiting for readers, and per-CPU variables remove contention entirely.

> 🧪 Practice
>
> 1. For each case, choose a primitive and justify it: an interrupt-handler counter, a rarely updated routing table, a long file-system operation, per-CPU statistics.
> 2. Explain what a grace period is and why RCU cannot free the old copy before it ends.
> 3. Interview-style: "Why is RCU better than a readers-writers lock for the kernel's module list?" *Hint: count the atomic operations a reader performs in each design, and how often that list is read versus written.*

---

<a id="6-deadlocks"></a>
## 6. Deadlocks

Chapter 5 solved the race condition by making threads wait for each other, and in doing so created a new failure mode: a set of threads can each hold something the others need, so every one of them waits forever. This chapter defines that state precisely — the resource model, the four conditions that must hold simultaneously, and the graph notation that makes it visible — then works through the three strategies available: forbid it structurally, avoid it dynamically with advance knowledge, or allow it and recover afterwards. Deadlock deserves its own chapter because it is the failure that produces no exception, no log entry, and no CPU usage: the system simply stops responding while looking perfectly healthy.

<a id="61-deadlock-characterization"></a>
### 6.1 Deadlock Characterization

This section builds the vocabulary: what counts as a resource, the four conditions that together create deadlock, the graph notation that turns the question into cycle detection, and how deadlock differs from the two failures it is routinely confused with.

#### System Model of Resources

**Theory**

Before we can prove anything about deadlock, we need a model of the system that is simple enough to reason about but faithful enough to be useful. The standard model is deliberately austere.

A system consists of a finite number of **resource types** `R1, R2, ..., Rm`. Each type `Ri` has `Wi` identical **instances**. A resource is anything a process must obtain exclusively before it can proceed: CPU cores, memory frames, mutexes, semaphores, open-file slots, database rows, printers, network ports, IPC channels.

The word "identical" carries the weight of the whole model. Two instances belong to the same type only if a process that asks for one is equally satisfied by either. If a program requests "printer 3 specifically, because it holds the letterhead paper", then printer 3 is its own resource type with one instance. Getting this classification wrong is the most common modelling error: it makes the analysis say a system is safe when it is not.

Every process uses a resource through the same three-phase protocol:

1. **Request.** The process asks the OS (or a library) for the resource. If it is unavailable, the process blocks until it is. This is the only phase in which a process can be delayed.
2. **Use.** The process operates on the resource. The OS is not involved.
3. **Release.** The process returns the resource so others may have it.

Two orthogonal classifications of resources matter for the rest of the chapter:

| Axis | Categories | Examples | Relevance to deadlock |
|---|---|---|---|
| Lifetime | **Reusable** — a fixed number of instances, returned after use | mutexes, memory frames, printers, disk blocks | The classic model; count is conserved |
| | **Consumable** — created by a producer, destroyed by a consumer; no fixed count | messages, signals, interrupts, buffer entries | Deadlock still possible (mutual `receive`) but no fixed inventory to reason about |
| Revocability | **Preemptable** — can be taken away and restored later without harm | CPU (save registers), physical memory (swap the page out) | Never a deadlock cause: the OS can always break the wait |
| | **Non-preemptable** — taking it away corrupts the work in progress | mutex, printer mid-page, tape drive, an uncommitted DB row | The dangerous kind; the entire chapter is about these |

With this model, deadlock has an exact definition:

> A set of processes is **deadlocked** when every process in the set is waiting for an event that can only be caused by another process in the same set.

The self-referential structure is the essence of it. This is not "slow" and not "unlucky"; no amount of waiting helps, because everyone who could produce the awaited event is themselves blocked. The set is closed, and no outside activity can open it.

Analogy: a single-lane bridge that is too narrow for cars to pass. If a car enters from each end and both refuse to reverse, they are deadlocked. Note the ingredients already: the bridge cannot be shared (mutual exclusion), each car occupies the half it entered while wanting the other half (hold and wait), no one can be lifted off (no preemption), and each waits for the other (circular wait).

**Example**

```text
   A SYSTEM STATE IN THE STANDARD MODEL

   Resource types                  Instances
   -----------------------------   ------------------------------
   R1 = mutex "accounts_lock"      W1 = 1     [#]
   R2 = printers                   W2 = 2     [#][ ]
   R3 = tape drives                W3 = 3     [#][#][ ]
   R4 = DB connections (pool)      W4 = 5     [#][#][#][ ][ ]

           [#] = allocated     [ ] = available

   Available vector = (0, 1, 1, 2)

   THE THREE-PHASE PROTOCOL, AND WHERE TIME IS SPENT

     request  --->  [ may BLOCK here, possibly forever ]
        |
        v
      use      --->  [ bounded by the process's own work ]
        |
        v
     release   --->  [ must execute on EVERY exit path,
                       including exceptions and early returns ]

   Deadlock lives entirely in phase 1. A process that never reaches
   phase 3 (leaked lock) causes the same symptom by a different route.
```

```c
/* The three-phase protocol, made explicit. Every resource obeys it,
   whether the "OS" involved is the kernel, a library, or a database. */

sem_t tape_drives;                 /* R3: 3 identical instances       */
pthread_mutex_t accounts_lock;     /* R1: 1 instance (a binary case)  */

void archive_accounts(void) {
    sem_wait(&tape_drives);              /* REQUEST: blocks while 0 free   */
    pthread_mutex_lock(&accounts_lock);  /* REQUEST: second resource type  */

    write_archive();                     /* USE: OS uninvolved             */

    pthread_mutex_unlock(&accounts_lock);/* RELEASE, reverse order          */
    sem_post(&tape_drives);              /* RELEASE: increments the count   */
}
```

```python
# A minimal simulation of the model: types, instances, and the
# available vector that every algorithm in this chapter operates on.

class ResourceSystem:
    def __init__(self, total):
        self.total = list(total)          # W vector: instances per type
        self.available = list(total)      # currently unallocated
        self.allocation = {}              # process -> vector held

    def request(self, pid, req):
        held = self.allocation.setdefault(pid, [0] * len(self.total))
        # A request is granted ONLY if every component fits. Partial
        # grants are what turn a request into "hold and wait".
        if all(r <= a for r, a in zip(req, self.available)):
            self.available = [a - r for a, r in zip(self.available, req)]
            self.allocation[pid] = [h + r for h, r in zip(held, req)]
            return True
        return False                      # caller BLOCKS -- deadlock risk

    def release(self, pid, rel):
        held = self.allocation[pid]
        self.allocation[pid] = [h - r for h, r in zip(held, rel)]
        self.available = [a + r for a, r in zip(self.available, rel)]

sys_ = ResourceSystem(total=[1, 2, 3, 5])
print(sys_.request("P1", [1, 1, 1, 3]))   # True  -> available (0,1,2,2)
print(sys_.request("P2", [1, 0, 0, 0]))   # False -> P2 blocks on R1
```

**Key takeaways**

- The model is resource *types* with identical *instances*; two things are the same type only if a requester is indifferent between them.
- Every use follows request, use, release, and only the request phase can block.
- Non-preemptable resources are the ones that cause deadlock; preemptable ones can always be reclaimed.
- Deadlock: every process in a set waits for an event only another member of that set can cause — a closed, self-sustaining cycle of waiting.

> 🧪 Practice
>
> 1. Classify each as preemptable or non-preemptable, and justify: CPU registers, a `pthread_mutex_t`, a page of physical memory, a partially written CD-R, a TCP port, an uncommitted database row.
> 2. A print server has three identical printers, but one has a colour cartridge. Model this as resource types twice: once treating all three as one type, once correctly. Give a request sequence where the first model wrongly predicts success.
> 3. Interview-style: "A thread returns early from a function while holding a lock. Is that a deadlock?" *Hint: compare the definition (a waiting set whose members can only be freed by each other) against what is actually happening to the other threads, and ask whether any process in your candidate set is itself waiting.*

#### Necessary Conditions

**Theory**

In 1971 E. G. Coffman and colleagues identified four conditions that must **all hold simultaneously** for deadlock to be possible. This is the single most useful result in the chapter, because it converts a vague worry into a checklist — and, more importantly, into a design tool: break any one condition and deadlock becomes structurally impossible.

**1. Mutual exclusion.** At least one resource is held in a non-shareable mode. If a resource can be used by any number of processes at once, no one ever waits for it, so it can never appear in a waiting cycle. Read-only files satisfy this; a mutex does not.

**2. Hold and wait.** A process holds at least one resource while requesting another. If processes acquired everything they need in one atomic step, or held nothing while requesting, a blocked process would be blocking with empty hands and could not contribute to a cycle.

**3. No preemption.** Resources cannot be forcibly taken from a process; they are released only voluntarily, by the holder, after it finishes. If the system could revoke a resource, it could always break a cycle by choice.

**4. Circular wait.** There exists a set of waiting processes `{P0, P1, ..., Pn}` such that `P0` waits for a resource held by `P1`, `P1` for one held by `P2`, ..., and `Pn` for one held by `P0`.

The logical status of these is worth being precise about, because exams and interviews probe exactly here:

- The four conditions are **necessary**: no deadlock without all four.
- They are **not individually sufficient**: circular wait alone does not imply deadlock when resource types have multiple instances (see the next topic).
- Circular wait is not independent of the others — it is closer to a consequence of the first three under contention. It is listed separately because it is the condition that is easiest to attack in real code.

Analogy: a four-way intersection with no signals and a rule that you never reverse. Each car occupies its quadrant (mutual exclusion), holds it while waiting for the next (hold and wait), cannot be lifted out (no preemption), and each waits on the car to its left (circular wait). Remove any one — make quadrants shareable, require cars to claim all four before entering, allow a tow truck, or install a "yield to the right" rule that breaks the symmetry — and the gridlock cannot form.

**Example**

```text
   ALL FOUR CONDITIONS IN ONE TRACE

   Thread A                          Thread B
   ------------------------------    ------------------------------
   lock(mutex_X)        ok           .
   .                                 lock(mutex_Y)        ok
   lock(mutex_Y)        BLOCKS       .
   .                                 lock(mutex_X)        BLOCKS
   .                                 .
   [ waits forever ]                 [ waits forever ]

   Condition check:
     1. mutual exclusion  YES  mutex_X and mutex_Y are exclusive
     2. hold and wait     YES  A holds X while requesting Y
     3. no preemption     YES  nothing can take X away from A
     4. circular wait     YES  A -> Y(held by B) -> X(held by A)

   Neither thread consumes CPU. `top` shows 0%. Nothing is logged.
   This is why deadlock is diagnosed by stack dumps, not by monitoring.
```

| Condition | Holds when... | Attack (Section 6.2) | Practical cost of the attack |
|---|---|---|---|
| Mutual exclusion | Resource is exclusive | Make it shareable: immutable data, read-only files, spooling, lock-free structures | Often impossible; some resources are exclusive by nature |
| Hold and wait | Acquire while holding | Take all resources atomically, or release everything before requesting more | Low utilisation; long waits; starvation |
| No preemption | Only the holder releases | Allow revocation: `trylock` + release-all, or transaction rollback | Needs saveable state; wasted work |
| Circular wait | Cyclic waiting chain exists | Impose a global order on resource types; acquire only in increasing order | Cheap and effective; requires discipline across the whole codebase |

```java
public class FourConditions {
    private final Object X = new Object();
    private final Object Y = new Object();

    // Deadlocks under contention: satisfies all four conditions.
    public void threadA() {
        synchronized (X) {              // 1: exclusive  3: not preemptable
            work();
            synchronized (Y) {          // 2: holds X while requesting Y
                work();                 // 4: with threadB, closes the cycle
            }
        }
    }

    public void threadB() {
        synchronized (Y) {              // opposite order -- the whole bug
            work();
            synchronized (X) {
                work();
            }
        }
    }

    // Cannot deadlock: circular wait is broken by a consistent global order
    // (X before Y, always, everywhere). The other three still hold.
    public void safeA() { synchronized (X) { synchronized (Y) { work(); } } }
    public void safeB() { synchronized (X) { synchronized (Y) { work(); } } }

    private void work() { }
}
```

**Key takeaways**

- Deadlock requires mutual exclusion, hold and wait, no preemption, and circular wait, all at once.
- The conditions are necessary, not individually sufficient; with multi-instance resources even circular wait is not sufficient.
- Every prevention technique in existence is an attack on exactly one of the four.
- In practice, breaking circular wait via a global lock ordering is the cheapest and most widely used attack.

> 🧪 Practice
>
> 1. For each scenario, name the condition that is absent: (a) a read-only configuration file read by 50 threads; (b) a thread that calls `trylock` and releases all its locks on failure; (c) a program in which every thread acquires locks in ascending address order.
> 2. Write a three-thread, three-mutex program that deadlocks only when the interleaving is exactly right, then fix it by ordering alone. Explain why the fix does not reduce concurrency.
> 3. Interview-style: "Which of the four conditions is the easiest to eliminate in a large existing codebase, and why?" *Hint: think about which attack can be applied file-by-file without changing the program's resource requirements or its utilisation.*

#### Resource Allocation Graphs

**Theory**

The four conditions are a checklist, but checking "does a circular wait exist?" by reading code does not scale. The **resource allocation graph** (RAG) turns the question into a graph problem the machine can answer.

The graph is directed and bipartite, with two kinds of vertex:

- A **process** vertex, drawn as a circle: `P1, P2, ...`
- A **resource type** vertex, drawn as a rectangle containing one dot per instance: `R1, R2, ...`

and two kinds of edge:

- A **request edge** `Pi -> Rj`: process `Pi` has asked for an instance of `Rj` and is blocked waiting.
- An **assignment edge** `Rj -> Pi`: one instance of `Rj` is currently held by `Pi`. The edge starts at a specific dot inside the rectangle.

When a blocked request is finally granted, its request edge is simply reversed into an assignment edge; when the resource is released, the edge is deleted. The graph is thus a live picture of the system's waiting structure.

The central theorem:

- If the graph contains **no cycle**, then no process is deadlocked. This holds unconditionally.
- If the graph contains a cycle:
  - and **every resource type has exactly one instance**, the processes on the cycle are deadlocked. Cycle is necessary *and* sufficient.
  - and **some type has several instances**, deadlock *may* exist. The cycle is necessary but not sufficient, because a process outside the cycle may hold the instance that eventually satisfies someone on it.

That second case is the subtlety worth internalising. A cycle means "everyone on this ring is waiting on the ring", but with several instances of a type, the ring can be broken from outside: some process not on the cycle releases an instance, one waiter is satisfied, and the cycle dissolves. With single instances there is no outside supply, so the ring is fatal.

Analogy: a cycle of people each waiting for a book. If the library owns one copy of each title, the wait is hopeless. If it owns three copies of one title, a fourth reader who is not part of the ring may return their copy and rescue everyone.

**Example**

```text
   CASE 1 -- CYCLE WITH SINGLE INSTANCES: DEADLOCK

     +----------+                          +----------+
     |   R1     |  assignment              |   R2     |
     |   [*]----+--------------> (P1)      |   [*]    |
     +----------+                 |        +----------+
          ^                       | request     |
          |  request              v             | assignment
          |                     +----+          |
          +---------------------|    |<---------+
                                 (P2)

     Edges:  R1 -> P1   (P1 holds R1)
             P1 -> R2   (P1 wants R2)
             R2 -> P2   (P2 holds R2)
             P2 -> R1   (P2 wants R1)

     Cycle: P1 -> R2 -> P2 -> R1 -> P1
     Single instance per type  =>  P1 and P2 ARE DEADLOCKED.


   CASE 2 -- CYCLE WITH MULTIPLE INSTANCES: NO DEADLOCK

     R1 has TWO instances:  R1 = [*][*]

       R1.a -> P1      (P1 holds one instance of R1)
       R1.b -> P3      (P3 holds the other)
       P1   -> R2      (P1 waits for R2)
       R2   -> P2      (P2 holds R2)
       P2   -> R1      (P2 waits for R1)

     Cycle: P1 -> R2 -> P2 -> R1 -> P1        <- a cycle EXISTS
     But P3 is NOT on the cycle. When P3 releases its R1 instance,
     P2 is satisfied, finishes, releases R2, and P1 proceeds.

     CYCLE PRESENT, DEADLOCK ABSENT.  This is why cycle detection is
     only sufficient in the single-instance case.
```

```python
# Building a resource allocation graph and testing it for a cycle.
# For single-instance resource types this IS the deadlock detector.

from collections import defaultdict

class RAG:
    def __init__(self):
        self.edges = defaultdict(set)     # node -> set of successors

    def request(self, p, r):              # Pi -> Rj (blocked request)
        self.edges[p].add(r)

    def assign(self, r, p):               # Rj -> Pi (held)
        self.edges[r].add(p)

    def grant(self, p, r):                # blocked request becomes a holding
        self.edges[p].discard(r)          # reverse the edge in place
        self.edges[r].add(p)

    def find_cycle(self):
        WHITE, GREY, BLACK = 0, 1, 2      # classic DFS colouring
        colour = defaultdict(int)
        stack = []

        def dfs(u):
            colour[u] = GREY              # GREY = on the current DFS path
            stack.append(u)
            for v in self.edges[u]:
                if colour[v] == GREY:     # back edge to the path -> cycle
                    return stack[stack.index(v):] + [v]
                if colour[v] == WHITE:
                    found = dfs(v)
                    if found:
                        return found
            colour[u] = BLACK             # fully explored, cannot start a cycle
            stack.pop()
            return None

        for node in list(self.edges):
            if colour[node] == WHITE:
                cycle = dfs(node)
                if cycle:
                    return cycle
        return None

g = RAG()
g.assign("R1", "P1")      # P1 holds R1
g.request("P1", "R2")     # P1 waits for R2
g.assign("R2", "P2")      # P2 holds R2
g.request("P2", "R1")     # P2 waits for R1
print(g.find_cycle())     # ['R1', 'P1', 'R2', 'P2', 'R1'] -> deadlocked
```

**Key takeaways**

- A RAG has process and resource vertices, request edges `P -> R`, and assignment edges `R -> P`.
- No cycle always means no deadlock; this direction needs no assumptions.
- With one instance per type, a cycle means deadlock; with several instances it only means deadlock is possible.
- Detection therefore reduces to depth-first cycle search, `O(V + E)`, on the single-instance graph.

> 🧪 Practice
>
> 1. Draw the RAG for: `P1` holds `R1`, `P2` holds `R2` and `R3`, `P1` requests `R2`, `P3` requests `R1`. Is there a cycle? Is there a deadlock?
> 2. Extend the `RAG` class with a `release(r, p)` method, then produce a trace where a cycle appears and later dissolves without any process being aborted. What must be true about instance counts?
> 3. Interview-style: "Your monitoring detects a cycle in the resource graph of a system whose semaphores have counts greater than one. Do you page the on-call engineer?" *Hint: state what a cycle proves and what it does not, and name the extra check you would run before escalating.*

#### Deadlock vs Starvation vs Livelock

**Theory**

Three distinct failures are routinely reported as "the system is hung". They have different causes, different symptoms, and completely different fixes, so distinguishing them is the first diagnostic step.

**Deadlock** is a *state*: a set of processes is permanently blocked, each waiting for the others. It is stable — once entered, no execution can leave it without outside intervention. The processes consume no CPU. Progress is zero and will remain zero.

**Starvation** (indefinite postponement) is a *scheduling outcome*: a process is runnable and would make progress if selected, but the selection policy keeps choosing others. Nothing is structurally impossible; the process is simply always second in line. A low-priority thread under strict priority scheduling, or a writer under a reader-preferring readers-writers lock, starves. The system as a whole is making progress — just not for the victim. The fix is a policy fix: ageing, FIFO fairness, ticket locks (Chapter 4 and Chapter 5).

**Livelock** is *futile activity*: processes are running, changing state, and consuming CPU, but no one advances. The classic form is a `trylock`-and-retry loop where every contender releases and retries in perfect synchrony, colliding again each round. Livelock also arises in receive-livelock, where a server spends all its time in interrupt handlers accepting packets it never has time to process.

The corridor analogy captures all three. Two people meet head-on in a narrow corridor. If both stop and refuse to move, that is deadlock. If both keep stepping to the same side, over and over, that is livelock — motion without progress. If one of them stands still while a stream of higher-priority people flows past for hours, that is starvation.

**Example**

| | Deadlock | Livelock | Starvation |
|---|---|---|---|
| Process state | Blocked | Running | Runnable, not scheduled |
| CPU usage | Zero | High (often 100%) | Zero for the victim |
| Progress | None, permanently | None, though state changes | None for the victim; system progresses |
| Recovery on its own | Never | Possible, by luck | Possible, if load drops |
| Root cause | Circular wait on resources | Symmetric retry with no tie-break | Unfair selection policy |
| Typical fix | Lock ordering, detection + abort | Randomised backoff, priority tie-break | Ageing, FIFO queueing |
| Diagnosis tool | Thread dump, `jstack`, `pstack` | CPU profiler, retry counters | Latency percentiles, wait-time histograms |

```text
   THE CORRIDOR

   DEADLOCK                LIVELOCK                 STARVATION
   ---------               --------                 ----------
   A --><-- B              A -->  <-- B             A --> ..........
   (both frozen)           A steps left             ..........<-- crowd
                           B steps left             ..........<-- crowd
   CPU: 0%                 A steps right            (A still waiting)
   Forever                 B steps right
                           ... forever, at 100% CPU CPU: 0% for A
```

```python
import threading, time, random

lock_a, lock_b = threading.Lock(), threading.Lock()

def livelock_worker(first, second, name):
    """Polite retry with NO randomness: both threads back off in lockstep,
       collide again, and repeat. Busy, and permanently unproductive."""
    while True:
        first.acquire()
        if second.acquire(blocking=False):        # try the second lock
            print(f"{name} got both")
            second.release(); first.release()
            return
        first.release()                           # be polite: give up and retry
        # time.sleep(random.uniform(0, 0.01))     # <- the missing tie-break

def fixed_worker(first, second, name):
    """Randomised backoff breaks the symmetry: the two threads' retry
       instants diverge, so one wins on some round. Same code otherwise."""
    while True:
        first.acquire()
        if second.acquire(blocking=False):
            second.release(); first.release()
            return
        first.release()
        time.sleep(random.uniform(0, 0.01))       # asymmetry, cheaply bought
```

**Key takeaways**

- Deadlock is a permanent blocked state; livelock is permanent futile motion; starvation is unfair selection.
- CPU usage separates them at a glance: deadlock 0%, livelock high, starvation 0% for one victim while the system runs.
- Deadlock never resolves itself; livelock and starvation can, given luck or a load change.
- The fixes are unrelated: ordering or detection for deadlock, randomised backoff for livelock, ageing or FIFO for starvation.

> 🧪 Practice
>
> 1. For each observation, name the failure: (a) all 200 worker threads sit in `park()` and CPU is idle; (b) CPU pinned at 100%, a retry counter climbing by millions per second, throughput zero; (c) throughput normal, but one client's p99 latency is 40 seconds.
> 2. Modify `livelock_worker` so it deadlocks instead of livelocking. Which single line changes, and which Coffman condition does that restore?
> 3. Interview-style: "Ethernet's exponential backoff is often cited as a livelock fix. What exactly does the randomness buy you?" *Hint: think about what two colliding senders have in common at the moment of collision, and what must differ for one of them to win.*

<a id="62-prevention-and-avoidance"></a>
### 6.2 Prevention and Avoidance

The two proactive strategies differ in what they know. **Prevention** knows nothing about the future and guarantees safety structurally, by making one Coffman condition impossible. **Avoidance** requires processes to declare their maximum needs in advance and uses that knowledge to refuse individual requests that could lead to trouble.

#### Breaking the Necessary Conditions

**Theory**

Deadlock prevention is the direct application of the Coffman result: if all four conditions are necessary, then denying any one of them makes deadlock impossible — not unlikely, impossible. The engineering question is which condition is cheapest to deny, because each attack has a price.

**Attacking mutual exclusion.** Make resources shareable so no one ever waits. This works only where the resource permits it: read-only data, immutable objects, spooled printers (processes write to a spool file, and only the daemon touches the device), and lock-free data structures built from compare-and-swap (Chapter 5). It fails for the resources that matter most — a mutex is exclusive by definition. Generally the least applicable attack, but where it applies it is free.

**Attacking hold and wait.** Two protocols exist:

- *All-or-nothing acquisition*: a process requests every resource it will need in a single atomic operation, before it starts. It never blocks while holding anything.
- *Release before request*: a process holding resources must release them all before it may request anything new.

Both work, and both are expensive. A job that needs a tape drive for its last two seconds must hold it for its entire hour-long run (poor utilisation), and a process that repeatedly loses the atomic acquisition race can starve.

**Attacking no preemption.** Allow resources to be taken back. The usual protocol: if a process holding resources requests one that is unavailable, it releases everything it holds, and restarts once it can obtain the whole set again. In code this appears as `trylock` with release-and-retry; in databases it appears as transaction rollback. It requires state that can be saved and restored, which is exactly why it works for CPU registers and database transactions but not for a half-printed page.

**Attacking circular wait.** Define a total order `F` over resource types, and require every process to acquire in strictly increasing order of `F`. The proof is short and worth remembering: if a cycle existed, following it around would require `F(R1) < F(R2) < ... < F(Rn) < F(R1)`, so `F(R1) < F(R1)`, a contradiction. This is the attack used in real systems — the Linux kernel documents lock ordering per subsystem, and `lockdep` verifies it at runtime — because it costs nothing at run time and does not reduce concurrency. Its price is discipline: every acquisition site in the codebase must obey the same order, including inside callbacks and library code.

Analogy for ordering: a one-way system in a city centre. Cars are not restricted in where they go, and no intersection is closed; they simply cannot traverse a loop in the wrong direction, so gridlock cycles cannot form.

**Example**

```text
   THE FOUR ATTACKS, AND WHAT EACH COSTS

   Condition denied   Mechanism                     Price
   ----------------   ---------------------------   -----------------------
   mutual exclusion   immutable data, spooling,     rarely applicable
                      lock-free structures

   hold and wait      acquire ALL up front, or      utilisation collapses;
                      release-all-before-request    starvation possible

   no preemption      trylock + release-all,        wasted work; needs
                      transaction rollback          restorable state

   circular wait      global order over lock        discipline across the
                      types; acquire ascending      whole codebase  <-- USE THIS


   WHY ORDERING WORKS (proof in one line)

     Suppose P1 -> P2 -> ... -> Pn -> P1 is a wait cycle.
     Each edge means: holder of R_i is requesting R_(i+1), so F(R_i) < F(R_(i+1)).
     Chaining around the cycle: F(R_1) < F(R_1).   Contradiction.
```

```c
/* ATTACK 4: circular wait, via a total order on lock ADDRESSES.
   Works even when the set of locks is dynamic, as with per-object locks. */

void lock_two(pthread_mutex_t *a, pthread_mutex_t *b) {
    if (a == b) {                       /* same object: lock once */
        pthread_mutex_lock(a);
        return;
    }
    /* The order is arbitrary but GLOBAL and STABLE -- that is all it needs. */
    pthread_mutex_t *first  = (a < b) ? a : b;
    pthread_mutex_t *second = (a < b) ? b : a;
    pthread_mutex_lock(first);
    pthread_mutex_lock(second);
}

/* ATTACK 3: no preemption, via trylock and full release.
   Note the randomised backoff: without it this livelocks (Section 6.1). */
int lock_two_backoff(pthread_mutex_t *a, pthread_mutex_t *b) {
    for (int attempt = 0; attempt < MAX_RETRY; attempt++) {
        pthread_mutex_lock(a);
        if (pthread_mutex_trylock(b) == 0)
            return 0;                   /* got both */
        pthread_mutex_unlock(a);        /* hold NOTHING while retrying */
        usleep(rand() % (100 << attempt));  /* exponential + random */
    }
    return -1;                          /* caller must handle failure */
}
```

```python
import threading

# ATTACK 2: hold and wait, via atomic all-or-nothing acquisition.
# The process is never blocked while holding anything.
class ResourceSet:
    def __init__(self, locks):
        self.locks = sorted(locks, key=id)   # ordering also applied, belt and braces
        self.gate = threading.Lock()         # serialises the acquisition attempt

    def acquire_all(self):
        with self.gate:                      # only one acquirer at a time
            taken = []
            for lk in self.locks:
                if not lk.acquire(blocking=False):
                    for t in taken:          # all-or-nothing: undo everything
                        t.release()
                    return False
                taken.append(lk)
            return True

    def release_all(self):
        for lk in reversed(self.locks):
            lk.release()
```

**Key takeaways**

- Prevention denies one Coffman condition by construction, making deadlock impossible rather than improbable.
- Denying mutual exclusion is usually infeasible; denying hold and wait wrecks utilisation; denying preemption needs restorable state.
- A global acquisition order is the practical attack: zero run-time cost, no loss of concurrency, enforced by convention and tools like `lockdep`.
- `trylock` plus release-and-retry must include randomised backoff, or deadlock is merely traded for livelock.

> 🧪 Practice
>
> 1. A bank transfer locks two accounts. Implement the ordering attack using account IDs, and explain what goes wrong if two accounts can share an ID.
> 2. Show why "acquire all resources up front" can starve a process that needs many resources, while one needing few never starves. Which scheduling idea from Chapter 4 fixes this?
> 3. Interview-style: "You added `trylock` with release-and-retry and now the service burns 100% CPU without completing requests. What happened?" *Hint: consider what two symmetric threads do at exactly the same instant after each releases, and what is missing between the release and the next attempt.*

#### Safe and Unsafe States

**Theory**

Prevention is blunt: it constrains every program all the time, whether or not any risk exists. **Avoidance** is the alternative — grant requests one at a time, but only when granting cannot possibly lead to deadlock. To do that, the system needs one extra piece of information that prevention does not require: each process must declare, in advance, the **maximum** number of instances of each resource type it will ever need.

With that declaration, define:

> A state is **safe** if there exists an ordering of all processes `<P1, P2, ..., Pn>` — a **safe sequence** — such that for each `Pi`, the resources `Pi` may still request can be satisfied by the currently available resources plus everything held by all `Pj` with `j < i`.

Read that operationally: the system can name at least one order in which it could run every process to completion, one after another, if it had to. `P1` can finish with what is free right now. When it finishes it returns everything it held, so `P2` can finish, and so on. Existence of that sequence is the guarantee.

The three-way relationship is the crux:

- Every **safe** state is deadlock-free. The safe sequence is an explicit escape plan.
- An **unsafe** state is not necessarily deadlocked, and might never deadlock — processes might simply not make their worst-case requests.
- But from an unsafe state, the system can no longer *guarantee* anything: some sequence of legal requests leads to deadlock, and the OS has lost the ability to prevent it.

Avoidance therefore keeps the system in safe states permanently. The cost is conservatism: it will refuse requests that would in fact have been fine, so utilisation is lower than it could be. This is a deliberate trade of throughput for a guarantee.

Analogy: a bank with 12 million in cash and three customers whose approved credit limits total 22 million. The bank is safe as long as, at every moment, it can name an order in which it could fully fund each customer in turn from cash on hand plus repayments from those funded earlier. It is not lending recklessly by exceeding total cash; it is only refusing the specific loan that would leave it unable to name such an order. Hence the name of the algorithm in the last topic.

**Example**

```text
   THE CLASSIC 12-TAPE-DRIVE EXAMPLE

   Total drives: 12

   Process   Max need   Holds now   Still may request
   -------   --------   ---------   -----------------
     P0         10          5              5
     P1          4          2              2
     P2          9          2              7

   Allocated = 9,  Available = 3

   IS THIS SAFE?  Try to build a safe sequence:
     P1 may request 2 more; 3 available  -> P1 can finish.
        On finishing, P1 returns all 4 it holds -> available = 3 + 4 = 7
     P0 may request 5 more; 7 available  -> P0 can finish.
        P0 returns all 10 it holds       -> available = 7 - 5 + 10 = 12
     P2 may request 7 more; 12 available -> P2 can finish
   SAFE SEQUENCE: <P1, P0, P2>          =>  STATE IS SAFE


   NOW: P2 REQUESTS ONE MORE DRIVE.  Available would drop to 2, P2 holds 3.

   Process   Max   Holds   May request
     P0       10     5          5
     P1        4     2          2
     P2        9     3          6
   Available = 2

     P1 may request 2; 2 available -> P1 finishes, returns 4 -> available = 4
     P0 needs 5 > 4     -> cannot guarantee
     P2 needs 6 > 4     -> cannot guarantee
   NO SAFE SEQUENCE EXISTS         =>  STATE IS UNSAFE  =>  REQUEST DENIED

   Note: the unsafe state is NOT deadlocked. If P0 and P2 happen never to
   ask for their maximum, everything completes. Avoidance refuses anyway,
   because it can no longer PROVE that it will.


   THE THREE REGIONS

   +-------------------------------------------------------+
   |  ALL STATES                                           |
   |   +-----------------------------------------------+   |
   |   |  UNSAFE (no guarantee; deadlock reachable)    |   |
   |   |      +---------------------------------+      |   |
   |   |      |  DEADLOCK (already stuck)       |      |   |
   |   |      +---------------------------------+      |   |
   |   +-----------------------------------------------+   |
   |   +-----------------------------------------------+   |
   |   |  SAFE  <- avoidance keeps the system in here   |  |
   |   +-----------------------------------------------+   |
   +-------------------------------------------------------+

   safe  =>  no deadlock          unsafe  =>  deadlock POSSIBLE, not certain
```

```python
def is_safe(available, allocation, max_need):
    """Return (safe?, safe_sequence). This is the core of avoidance:
       can we name an order in which every process could finish?"""
    n, m = len(allocation), len(available)
    need = [[max_need[i][j] - allocation[i][j] for j in range(m)]
            for i in range(n)]
    work = list(available)              # resources we could hand out
    finish = [False] * n
    sequence = []

    progress = True
    while progress:
        progress = False
        for i in range(n):
            # A process qualifies if its REMAINING need fits in `work`.
            if not finish[i] and all(need[i][j] <= work[j] for j in range(m)):
                # Assume it runs to completion and returns everything.
                work = [work[j] + allocation[i][j] for j in range(m)]
                finish[i] = True
                sequence.append(i)
                progress = True         # restart the scan: more may now qualify
    return all(finish), sequence

# The 12-drive example, one resource type.
print(is_safe([3], [[5], [2], [2]], [[10], [4], [9]]))   # (True,  [1, 0, 2])
print(is_safe([2], [[5], [2], [3]], [[10], [4], [9]]))   # (False, [1])
```

**Key takeaways**

- Avoidance requires each process to declare its maximum resource need in advance.
- A state is safe if some sequence lets every process finish using free resources plus what earlier processes return.
- Safe implies no deadlock; unsafe does not imply deadlock, only that deadlock can no longer be ruled out.
- Avoidance sacrifices utilisation for a guarantee: it denies requests that would probably have been harmless.

> 🧪 Practice
>
> 1. With 12 drives and the table above, is the state safe if `P0` holds 6, `P1` holds 2, `P2` holds 2? Show the sequence or show that none exists.
> 2. Construct a state that is unsafe but from which no deadlock ever actually occurs. Explain what assumption avoidance makes that reality did not.
> 3. Interview-style: "Why does avoidance need maximum-need declarations while prevention does not?" *Hint: compare what each strategy has to predict — one reasons about the future of a specific request, the other about the shape of the code.*

#### Resource Allocation Graph Algorithm

**Theory**

When every resource type has exactly one instance, avoidance does not need the full numeric machinery of the next topic. The resource allocation graph from Section 6.1 can be extended into a decision procedure directly.

Add a third edge type: the **claim edge** `Pi --> Rj`, drawn dashed. It means "`Pi` may request `Rj` at some point in the future". All claim edges for a process must be present in the graph *before* that process begins execution — this is exactly the advance-declaration requirement of avoidance, expressed graphically. (A process may add claim edges later only if it currently holds no resources.)

Edges then move through a small lifecycle:

```text
   claim (dashed)  --request-->  request (solid)  --grant-->  assignment (reversed)
        ^                                                             |
        +---------------------- release -----------------------------+
```

The rule is one sentence: **grant a request only if converting the request edge into an assignment edge leaves the graph free of cycles — counting claim edges as if they were request edges.** If a cycle would appear, the requester waits, even though the resource is free.

Treating claim edges as real requests is what makes this avoidance rather than detection. The algorithm reasons about what *could* happen, not merely what has happened. That conservatism is the same one seen in safe states: some denied requests would have been fine.

Cost is a cycle check per request, `O(n^2)` in the number of processes. The severe limitation is the single-instance assumption: the moment a resource type has two instances, a cycle stops implying deadlock (Section 6.1) and this algorithm becomes both wrong and unusable. That is precisely the gap the Banker's algorithm fills.

**Example**

```text
   STATE: P1 holds R1. P2 claims both R1 and R2. R2 is free.

     ---->  assignment / request  (solid)
     ....>  claim                 (dashed, future possibility)

        +------+                       +------+
        |  R1  |----------> (P1)       |  R2  |
        +------+  assignment    .      +------+
            ^                   .          ^
            .                   . claim    .
            . claim             ..........>|  (P1 may want R2 later)
            .                              .
           (P2) ..........................>+
                        claim

   P2 NOW REQUESTS R2.  R2 is FREE -- but simulate the grant:

        R1 -> P1        (assignment, actual)
        P1 ..> R2       (claim, treated as a request)
        R2 -> P2        (assignment, the grant we are testing)
        P2 ..> R1       (claim, treated as a request)

        Cycle:  P1 -> R2 -> P2 -> R1 -> P1        <- CYCLE FOUND

   DECISION: DENY. P2 waits even though R2 sits idle.
   Had we granted it and P1 then requested R2, both would be stuck.
```

```python
# Avoidance for single-instance resource types, on top of the RAG.
# Reuses find_cycle() from Section 6.1.

class AvoidanceRAG(RAG):
    def __init__(self):
        super().__init__()
        self.claims = defaultdict(set)        # p -> resources it MAY request

    def declare(self, p, resources):
        """All claims must be registered before the process starts."""
        self.claims[p] |= set(resources)

    def can_grant(self, p, r):
        # 1. Tentatively convert the request into an assignment.
        self.edges[r].add(p)
        # 2. Overlay every claim edge as if it were a real request.
        overlay = [(q, s) for q, cs in self.claims.items()
                          for s in cs if s not in self.edges.get(q, ())]
        for q, s in overlay:
            self.edges[q].add(s)

        cycle = self.find_cycle()             # 3. Test the hypothetical graph

        for q, s in overlay:                  # 4. Undo the overlay ...
            self.edges[q].discard(s)
        if cycle:
            self.edges[r].discard(p)          # ... and undo the grant if unsafe
        return cycle is None                  # True -> grant, False -> block
```

**Key takeaways**

- Claim edges (dashed) express "may request later" and must all be declared before a process runs.
- A request is granted only if the resulting graph, with claims counted as requests, stays acyclic.
- The algorithm may deny a request for a resource that is currently free — that conservatism is the point.
- It applies only when every resource type has exactly one instance; otherwise use the Banker's algorithm.

> 🧪 Practice
>
> 1. Draw the graph for three processes and three single-instance resources where a request must be denied even though two of the three resources are free.
> 2. Explain why the algorithm forbids adding claim edges while a process holds resources. What could go wrong otherwise?
> 3. Interview-style: "Why can't you just run cycle detection on the ordinary graph and grant anything that keeps it acyclic?" *Hint: an acyclic graph now says nothing about the graph after the next legal request; ask which edges the claim overlay is standing in for.*

#### Banker's Algorithm

**Theory**

The Banker's algorithm, due to Dijkstra, is avoidance generalised to resource types with multiple instances. The name comes from the analogy in the safe-states topic: a banker who has approved credit lines exceeding cash on hand, and who will only disburse a withdrawal if, afterwards, they can still name an order in which every customer could be fully funded.

Four data structures, for `n` processes and `m` resource types:

| Name | Shape | Meaning |
|---|---|---|
| `Available` | vector `[m]` | Instances of each type currently free |
| `Max` | matrix `[n][m]` | Maximum each process may ever demand (declared up front) |
| `Allocation` | matrix `[n][m]` | Instances each process currently holds |
| `Need` | matrix `[n][m]` | `Max - Allocation`: what each process may still request |

The algorithm has two parts.

**Safety algorithm** — is the current state safe? Set `Work = Available` and `Finish[i] = false` for all `i`. Repeatedly find an `i` with `Finish[i] == false` and `Need[i] <= Work`; if found, set `Work = Work + Allocation[i]`, `Finish[i] = true`, and repeat. If every `Finish[i]` ends true, the state is safe and the order in which processes were selected is a safe sequence. Complexity `O(m * n^2)`.

**Resource-request algorithm** — should request `Request[i]` from process `Pi` be granted?

1. If `Request[i] > Need[i]`, the process has exceeded its declared maximum: an error, not a scheduling decision.
2. If `Request[i] > Available`, `Pi` must wait — the resources are simply not there.
3. Otherwise, **pretend** to grant it: `Available -= Request[i]`, `Allocation[i] += Request[i]`, `Need[i] -= Request[i]`. Run the safety algorithm on this hypothetical state. If safe, make the grant real. If unsafe, roll back all three updates and block `Pi`.

Step 3 is the whole idea, and it is why the algorithm is expensive: every single request costs a full safety check.

That cost, together with three structural assumptions, is why the Banker's algorithm is taught universally and deployed almost nowhere: processes rarely know their maximum needs in advance, the number of processes and resource types is not fixed in a general-purpose OS, and processes cannot be assumed to return resources promptly. It survives in narrow settings where all three hold — some real-time and embedded systems with a static task set, and some resource managers with declared quotas.

**Example**

```text
   FIVE PROCESSES, THREE RESOURCE TYPES:  A=10, B=5, C=7

           Allocation      Max          Need = Max - Allocation
            A  B  C      A  B  C          A  B  C
     P0     0  1  0      7  5  3          7  4  3
     P1     2  0  0      3  2  2          1  2  2
     P2     3  0  2      9  0  2          6  0  0
     P3     2  1  1      2  2  2          0  1  1
     P4     0  0  2      4  3  3          4  3  1

     Allocated total = (7, 2, 5)    Available = (10,5,7) - (7,2,5) = (3, 3, 2)

   SAFETY CHECK      Work = (3,3,2)
     P0? Need (7,4,3) > Work            -- skip
     P1? Need (1,2,2) <= (3,3,2)   RUN  -> Work = (3,3,2)+(2,0,0) = (5,3,2)
     P2? Need (6,0,0) > (5,3,2)         -- skip
     P3? Need (0,1,1) <= (5,3,2)   RUN  -> Work = (5,3,2)+(2,1,1) = (7,4,3)
     P4? Need (4,3,1) <= (7,4,3)   RUN  -> Work = (7,4,3)+(0,0,2) = (7,4,5)
     P2? Need (6,0,0) <= (7,4,5)   RUN  -> Work = (7,4,5)+(3,0,2) = (10,4,7)
     P0? Need (7,4,3) <= (10,4,7)  RUN  -> Work = (10,5,7)
     All finished. SAFE SEQUENCE = <P1, P3, P4, P2, P0>


   REQUEST 1:  P1 requests (1, 0, 2)
     (1,0,2) <= Need P1 (1,2,2)      ok
     (1,0,2) <= Available (3,3,2)    ok
     Pretend: Available=(2,3,0)  Alloc P1=(3,0,2)  Need P1=(0,2,0)
     Safety:  <P1, P3, P4, P0, P2> exists  ->  SAFE  ->  GRANT


   REQUEST 2:  P4 requests (3, 3, 0)   [from the ORIGINAL state]
     (3,3,0) <= Need P4 (4,3,1)      ok
     (3,3,0) <= Available (3,3,2)    ok  -- the resources ARE there
     Pretend: Available=(0,0,2)  Alloc P4=(3,3,2)  Need P4=(1,0,1)
     Safety:  P0 (7,4,3) no; P1 (1,2,2) no; P2 (6,0,0) no;
              P3 (0,1,1) no; P4 (1,0,1) no  -> nobody can run
              UNSAFE  ->  DENY, P4 blocks despite resources being free


   REQUEST 3:  P0 requests (0, 2, 0)   [from the state after REQUEST 1]
     Available (2,3,0); pretend -> Available (2,1,0), Need P0 = (7,2,3)
     Safety:  P0 no; P1 (0,2,0) needs B=2 > 1 no; P2 no;
              P3 (0,1,1) needs C=1 > 0 no; P4 no
              UNSAFE  ->  DENY
```

```python
def banker_request(pid, request, available, allocation, need):
    """Return True and mutate state if the request is safe; else leave
       state untouched and return False (the caller blocks)."""
    m = len(available)

    # Step 1: exceeding the declared maximum is a programming error.
    if any(request[j] > need[pid][j] for j in range(m)):
        raise ValueError("request exceeds declared maximum need")

    # Step 2: not enough resources exist right now -- plain unavailability.
    if any(request[j] > available[j] for j in range(m)):
        return False

    # Step 3: PRETEND to grant, then test.
    for j in range(m):
        available[j]      -= request[j]
        allocation[pid][j] += request[j]
        need[pid][j]      -= request[j]

    max_need = [[allocation[i][j] + need[i][j] for j in range(m)]
                for i in range(len(allocation))]
    safe, sequence = is_safe(available, allocation, max_need)   # from 6.2

    if not safe:                       # roll the hypothetical grant back
        for j in range(m):
            available[j]       += request[j]
            allocation[pid][j] -= request[j]
            need[pid][j]       += request[j]
        return False

    return True

available  = [3, 3, 2]
allocation = [[0,1,0], [2,0,0], [3,0,2], [2,1,1], [0,0,2]]
need       = [[7,4,3], [1,2,2], [6,0,0], [0,1,1], [4,3,1]]

print(banker_request(1, [1, 0, 2], available, allocation, need))  # True  (safe)
print(banker_request(4, [3, 3, 0], available, allocation, need))  # False (unsafe)
```

**Key takeaways**

- The Banker's algorithm extends avoidance to multi-instance resource types using `Available`, `Max`, `Allocation`, and `Need`.
- A request is granted only if the hypothetical post-grant state is safe; otherwise the state is rolled back and the process blocks.
- Safety costs `O(m * n^2)` per request, so the algorithm is charged on every allocation, not periodically.
- It assumes declared maxima, a fixed process and resource population, and prompt release — assumptions general-purpose operating systems cannot make.

> 🧪 Practice
>
> 1. From the original table, evaluate `P0` requesting `(0, 0, 2)` — only two instances of C, and two are free. Run the safety check and give the verdict.
> 2. Modify `banker_request` to return the safe sequence it found, and explain what an operator could do with that sequence during an incident.
> 3. Interview-style: "Databases manage thousands of concurrent transactions and millions of lockable rows. Why don't they run the Banker's algorithm?" *Hint: put concrete numbers into `O(m * n^2)` per request, and ask whether a transaction can state up front which rows it will touch.*

<a id="63-detection-and-recovery"></a>
### 6.3 Detection and Recovery

The third strategy is to allow deadlock to happen, notice it, and undo it. This section covers the algorithms that notice, the graph that makes noticing cheap, and the two ways to undo: kill something, or take something back.

#### Detection Algorithms

**Theory**

Prevention constrains every program forever; avoidance charges a safety check to every request. Both pay continuously to eliminate a rare event. Detection takes the opposite bet: let deadlock occur, pay nothing in the common case, and pay the recovery cost only when it actually happens.

This is what most real systems do — and the most common variant is to do nothing at all, the so-called **ostrich algorithm**. Linux, Windows, and macOS do not detect deadlocks among ordinary user processes. If your program deadlocks, it hangs, and the user kills it. The justification is economic: deadlocks are rare in correct programs, other bugs are far more common, and the machinery would cost every program something. Databases, by contrast, run detection continuously, because in a database deadlock is *routine* — it emerges from the interleaving of independently written transactions, not from a bug — and it can be recovered from cleanly by aborting one transaction.

Two detection algorithms exist, matching the two cases from Section 6.1.

**Single instance per resource type.** Maintain a wait-for graph (next topic) and search for a cycle. Cost is `O(V + E)` per run with a depth-first search.

**Multiple instances.** Use an algorithm structurally identical to the Banker's safety check, with one crucial substitution: instead of `Need` (what a process *may* eventually request), use `Request` (what it is *actually* blocked on right now). Detection is about the present, not the worst case; that single change is the entire difference between avoidance and detection.

```text
   Work = Available;  Finish[i] = (Allocation[i] == 0)
   repeat:
       find i with Finish[i] == false and Request[i] <= Work
       if found:  Work += Allocation[i];  Finish[i] = true
   until no such i
   Any process with Finish[i] == false is DEADLOCKED.
```

Initialising `Finish[i] = true` for processes holding nothing is a small but important detail: a process with no allocation cannot be part of a deadlock cycle, because nobody is waiting on it.

The remaining question is **how often to run it**. There is a genuine trade-off:

- Run it on every blocked request: detection is immediate and you know exactly which request closed the cycle, but the cost is high on a busy system.
- Run it periodically (say every minute) or when CPU utilisation drops below a threshold (a strong hint that everyone is blocked): cheap, but deadlocks persist for up to one interval, and by the time you look, several processes may be tangled, making the victim harder to choose.

**Example**

```text
   MULTI-INSTANCE DETECTION.  A=7, B=2, C=6.  All instances allocated.

            Allocation      Request        Available = (0, 0, 0)
             A  B  C       A  B  C
      P0     0  1  0       0  0  0
      P1     2  0  0       2  0  2
      P2     3  0  3       0  0  0
      P3     2  1  1       1  0  0
      P4     0  0  2       0  0  2

   RUN 1:  Work = (0,0,0)
     P0 Request (0,0,0) <= Work   RUN -> Work = (0,0,0)+(0,1,0) = (0,1,0)
     P2 Request (0,0,0) <= Work   RUN -> Work = (0,1,0)+(3,0,3) = (3,1,3)
     P1 Request (2,0,2) <= (3,1,3) RUN -> Work = (5,1,3)
     P3 Request (1,0,0) <= (5,1,3) RUN -> Work = (7,2,4)
     P4 Request (0,0,2) <= (7,2,4) RUN -> Work = (7,2,6)
     Finish = all true  ->  NO DEADLOCK
     (Note it is not even close: the system survives on P0 and P2 releasing.)


   RUN 2:  P2 now also requests one C.   Request P2 = (0, 0, 1)
     Work = (0,0,0)
     P0 Request (0,0,0) <= Work   RUN -> Work = (0,1,0)
     P1 (2,0,2) > (0,1,0)   no
     P2 (0,0,1) > (0,1,0)   no        <- C is exhausted
     P3 (1,0,0) > (0,1,0)   no
     P4 (0,0,2) > (0,1,0)   no
     No further progress.
     DEADLOCKED SET = { P1, P2, P3, P4 }

   One extra request for a single instance of C moved the system from
   comfortably safe to a four-process deadlock. Detection tells you WHICH
   four; it does not tell you which to kill.
```

```python
def detect_deadlock(available, allocation, request):
    """Present-tense variant of the safety algorithm: uses Request
       (what processes are blocked on NOW), not Need (worst case)."""
    n, m = len(allocation), len(available)
    work = list(available)
    # A process holding nothing cannot be part of a cycle: nobody waits on it.
    finish = [all(allocation[i][j] == 0 for j in range(m)) for i in range(n)]

    progress = True
    while progress:
        progress = False
        for i in range(n):
            if not finish[i] and all(request[i][j] <= work[j] for j in range(m)):
                work = [work[j] + allocation[i][j] for j in range(m)]
                finish[i] = True
                progress = True
    return [i for i in range(n) if not finish[i]]     # the deadlocked set

alloc = [[0,1,0], [2,0,0], [3,0,3], [2,1,1], [0,0,2]]
req1  = [[0,0,0], [2,0,2], [0,0,0], [1,0,0], [0,0,2]]
req2  = [[0,0,0], [2,0,2], [0,0,1], [1,0,0], [0,0,2]]   # P2 asks for one C

print(detect_deadlock([0,0,0], alloc, req1))   # []            -> no deadlock
print(detect_deadlock([0,0,0], alloc, req2))   # [1, 2, 3, 4]  -> deadlocked
```

**Key takeaways**

- Detection pays nothing in the common case and pays recovery costs only when deadlock actually occurs.
- General-purpose operating systems mostly use the ostrich algorithm; databases detect continuously because deadlock there is routine and cheaply recoverable.
- The multi-instance detector is the Banker's safety algorithm with `Request` substituted for `Need` — present state instead of worst case.
- Detection frequency trades CPU cost against how long a deadlock persists and how many processes get tangled before you look.

> 🧪 Practice
>
> 1. Re-run `detect_deadlock` with `Available = (0, 1, 0)` and the second request matrix. Does the deadlock disappear? Explain in terms of the algorithm's first pass.
> 2. Explain precisely why `Finish[i]` is initialised to true for processes with zero allocation, and construct a state where initialising it to false would report a false deadlock.
> 3. Interview-style: "Your OS runs deadlock detection once a minute. What is the argument for running it whenever CPU utilisation falls below 40% instead?" *Hint: think about what the CPU is doing while a large set of processes is blocked, and what a fixed interval costs on a system that never deadlocks.*

#### Wait-For Graphs

**Theory**

The full resource allocation graph carries information detection does not need. If every resource type has one instance, the resource vertices can be collapsed away entirely, leaving a **wait-for graph**: vertices are processes only, and an edge `Pi -> Pj` means "`Pi` is waiting for a resource currently held by `Pj`".

The collapse rule is mechanical: whenever the RAG contains `Pi -> Rk` and `Rk -> Pj`, the wait-for graph contains `Pi -> Pj`, and `Rk` disappears. The theorem carries over unchanged — **a deadlock exists if and only if the wait-for graph contains a cycle** — but the graph is roughly half the size and cycle detection runs on process count alone.

This is the representation real systems actually build:

- **MySQL/InnoDB** maintains a wait-for graph of transactions and runs detection on every lock wait, aborting the transaction judged cheapest to roll back (error 1213, "Deadlock found when trying to get lock").
- **PostgreSQL** does not check on every wait — it waits `deadlock_timeout` (1 second by default) first, on the theory that most waits resolve on their own, and only then builds the graph.
- **The JVM** exposes `ThreadMXBean.findDeadlockedThreads()`, which does exactly this over monitor and `Lock` ownership; `jstack` prints the resulting cycle.
- **The Linux kernel's `lockdep`** goes further: rather than detecting actual cycles, it records the *order* in which lock classes are acquired and reports a potential deadlock the first time any thread acquires two locks in an order inconsistent with a previously observed one — catching the bug without needing the bad interleaving to occur.

In a **distributed** system the graph is not held anywhere, and building it is the hard part. Systems use edge-chasing: a blocked process sends a probe message along its wait-for edges, and if a probe returns to its originator, a cycle exists. Because the graph is assembled from snapshots taken at different times, distributed detectors can report **phantom deadlocks** — cycles that had already dissolved by the time the probe completed.

**Example**

```text
   COLLAPSING THE RESOURCE GRAPH

   RESOURCE ALLOCATION GRAPH          WAIT-FOR GRAPH
   (processes and resources)          (processes only)

     (P1) --> [R1] --> (P2)              (P1) -----> (P2)
       ^                 |                 ^           |
       |                 v                 |           v
     [R3] <-- (P3) <-- [R2]              (P3) <--------+
       |        ^
       +--------+                        Cycle: P1 -> P2 -> P3 -> P1
                                         =>  DEADLOCK

   Rule:  Pi -> Rk  and  Rk -> Pj    collapses to    Pi -> Pj
   Valid ONLY for single-instance resource types.


   WHAT A JVM THREAD DUMP OF THIS LOOKS LIKE

   Found one Java-level deadlock:
   =============================
   "worker-1":
     waiting to lock monitor 0x00007f8b (object 0x000000076ab, a Account),
     which is held by "worker-2"
   "worker-2":
     waiting to lock monitor 0x00007f9c (object 0x000000076cd, a Account),
     which is held by "worker-1"

   The dump IS the wait-for graph, printed one edge per stanza.
```

```java
import java.lang.management.ManagementFactory;
import java.lang.management.ThreadInfo;
import java.lang.management.ThreadMXBean;
import java.util.concurrent.TimeUnit;

/** A watchdog that runs wait-for-graph detection inside a live JVM.
 *  This is exactly the periodic-detection policy from the previous topic. */
public class DeadlockWatchdog implements Runnable {
    private final ThreadMXBean bean = ManagementFactory.getThreadMXBean();

    @Override public void run() {
        while (!Thread.currentThread().isInterrupted()) {
            // Covers both synchronized monitors and java.util.concurrent Locks.
            long[] ids = bean.findDeadlockedThreads();   // null when none
            if (ids != null) {
                // Depth 20 gives enough stack to identify the offending
                // acquisition sites, without dumping the whole JVM.
                ThreadInfo[] infos = bean.getThreadInfo(ids, 20);
                for (ThreadInfo info : infos) {
                    System.err.printf("DEADLOCK: %s is blocked on %s held by %s%n",
                            info.getThreadName(),
                            info.getLockName(),          // the resource vertex
                            info.getLockOwnerName());    // the outgoing edge
                }
                // The JVM cannot break the cycle for you: no preemption of
                // monitors exists. Recovery must be a policy decision.
            }
            try { TimeUnit.SECONDS.sleep(10); }          // detection interval
            catch (InterruptedException e) { Thread.currentThread().interrupt(); }
        }
    }
}
```

```sql
-- The database equivalent: InnoDB keeps the wait-for graph itself.
-- After a deadlock, the losing transaction receives error 1213 and
-- the engine records the cycle it found:
SHOW ENGINE INNODB STATUS;      -- see the LATEST DETECTED DEADLOCK section

-- PostgreSQL waits before looking, on the assumption most waits resolve:
SHOW deadlock_timeout;          -- '1s' by default
```

**Key takeaways**

- The wait-for graph removes resource vertices: `Pi -> Pj` means `Pi` waits for something `Pj` holds.
- A cycle in it is necessary and sufficient for deadlock, but only when each resource type has one instance.
- Real detectors are wait-for graphs: InnoDB checks on every wait, PostgreSQL after a timeout, the JVM on demand via `ThreadMXBean`.
- `lockdep` detects inconsistent lock *ordering* rather than actual cycles, so it finds latent deadlocks that never occurred.
- Distributed detection uses probe messages and can report phantom deadlocks from inconsistent snapshots.

> 🧪 Practice
>
> 1. Convert this RAG to a wait-for graph and decide whether a deadlock exists: `P1 -> R1`, `R1 -> P2`, `P2 -> R2`, `R2 -> P3`, `P3 -> R3`, `R3 -> P1`.
> 2. Reproduce a two-thread deadlock in Java and capture it with `jstack`. Identify, from the dump alone, the two acquisition sites and the ordering rule that would have prevented it.
> 3. Interview-style: "Why does PostgreSQL wait a full second before running detection, while InnoDB checks immediately?" *Hint: weigh the cost of building a graph against the probability that a given lock wait is a genuine cycle rather than ordinary contention, and consider each engine's typical transaction length.*

#### Process Termination Strategies

**Theory**

Detection identifies the deadlocked set; recovery must break it. The blunt option is to destroy a process, thereby forcing the release of everything it holds. Two policies exist.

**Abort all deadlocked processes.** Guaranteed to break the cycle, guaranteed expensive. Every process in the set loses all its work, including processes that would have finished in milliseconds. Used when the state is so tangled that reasoning about individual victims is not worth the delay, or when correctness demands a clean slate.

**Abort one process at a time.** Kill one victim, re-run detection, and repeat until the cycle is gone. Much less work is destroyed, but detection runs after every kill, and the choice of victim is now a real decision.

Victim selection weighs several factors, and no single one dominates:

| Factor | Prefer to kill the process that... | Why |
|---|---|---|
| Progress made | has run the shortest time | Least work discarded |
| Work remaining | has the longest still to go | Least sunk investment lost |
| Resources held | holds the most, or the most contended | One kill frees the most, likely ending the deadlock in one step |
| Resources still needed | needs the most more | Least likely to complete soon anyway |
| Priority | has the lowest priority | Policy from Chapter 4 carries over |
| Interactivity | is a batch job, not interactive | An aborted interactive session is a visible failure |
| Restart cost | can be restarted safely | Idempotent work costs almost nothing to redo |
| Rollback count | has been killed fewest times | Prevents starvation-by-repeated-abort |

The last row deserves emphasis. If victim selection depends only on cost, the same cheap process is chosen every time, is rolled back, retries, deadlocks again, and is killed again — it never completes. This is starvation produced by the recovery mechanism itself. The standard fix is to include the number of previous rollbacks in the cost function, so a repeatedly victimised process eventually becomes the expensive choice.

The harder problem is that termination is not always safe. Killing a process mid-update leaves whatever it was modifying in an inconsistent state: a half-written file, a partially rebalanced tree in shared memory, a device left in a mode nobody expects. Databases can terminate freely precisely because every transaction is already wrapped in a rollback mechanism — the state is restorable by construction. Ordinary processes holding a mutex over shared memory are not.

**Example**

```text
   COST-BASED VICTIM SELECTION IN THE DEADLOCKED SET {P1, P2, P3, P4}

   Process  Runtime  Locks held  Rows changed  Priority  Prior aborts  Cost
   -------  -------  ----------  ------------  --------  ------------  ----
     P1      0.2 s        2            15         low          0         18
     P2     45.0 s        1        90 000        high          0      91 000
     P3      1.1 s        4           300      normal          3      3 400
     P4      0.4 s        1            40      normal          0         46

   Cost ~ work_done + locks_held * w1 + prior_aborts * BIG_PENALTY

   Naive choice:  P1 (cheapest).
   With the rollback penalty, P3 stays protected despite being cheap-ish
   on raw work -- it has already been sacrificed three times.

   Chosen victim: P1  ->  release its 2 locks  ->  RE-RUN DETECTION
                          if a cycle remains, choose again.
```

```python
ABORT_PENALTY = 10_000        # dominates raw cost: prevents starvation

def choose_victim(deadlocked, stats):
    """Lowest cost wins. The rollback count is inside the cost function,
       not applied afterwards, so it competes fairly with the other terms."""
    def cost(pid):
        s = stats[pid]
        return (s["cpu_seconds"] * 100          # work that would be discarded
                + s["rows_modified"]            # rollback effort
                + s["locks_held"] * 5           # small bonus for freeing many
                - s["priority"] * 50            # high priority -> costlier to kill
                + s["prior_aborts"] * ABORT_PENALTY)   # anti-starvation
    return min(deadlocked, key=cost)

def recover(deadlocked_set, stats, detect):
    """Abort ONE AT A TIME, re-detecting after each kill: often the first
       victim frees enough resources to dissolve the whole cycle."""
    killed = []
    while deadlocked_set:
        victim = choose_victim(deadlocked_set, stats)
        abort(victim)                        # releases everything it holds
        stats[victim]["prior_aborts"] += 1   # remembered for NEXT time
        killed.append(victim)
        deadlocked_set = detect()            # re-run; may already be empty
    return killed
```

```python
# The application-side contract: a victim must be prepared to be killed.
import time, random
import psycopg2

def transfer_with_retry(conn, src, dst, amount, max_attempts=5):
    for attempt in range(max_attempts):
        try:
            with conn:                       # commit on success, rollback on error
                with conn.cursor() as cur:
                    cur.execute("UPDATE accounts SET bal = bal - %s WHERE id = %s",
                                (amount, src))
                    cur.execute("UPDATE accounts SET bal = bal + %s WHERE id = %s",
                                (amount, dst))
            return True
        except psycopg2.errors.DeadlockDetected:
            # We were the victim. The database already rolled us back, so the
            # state is consistent; retrying is safe. Backoff avoids re-colliding.
            time.sleep(random.uniform(0, 0.05 * (2 ** attempt)))
    raise RuntimeError("transfer failed after repeated deadlocks")
```

**Key takeaways**

- Aborting all deadlocked processes always works and always destroys the most work; aborting one at a time requires re-running detection after each kill.
- Victim selection balances work done, resources held, priority, interactivity, and restart cost.
- Prior rollback count must be part of the cost function, or recovery itself starves the cheapest process.
- Termination is only safe where state is restorable, which is why databases recover cleanly and processes holding raw mutexes do not.
- Any client of a deadlock-detecting system must treat "you were the victim" as a normal outcome and retry with backoff.

> 🧪 Practice
>
> 1. Given the table above, compute the cost for each process with and without the rollback penalty. Which victim does each choice select, and what happens on the next deadlock?
> 2. Explain why aborting one process at a time requires re-running detection, and give a state where killing one process resolves two separate cycles.
> 3. Interview-style: "A retail service gets deadlock victim errors under load. The team wants to retry automatically. What must be true of the transaction for that to be correct?" *Hint: consider what the database guarantees about the aborted transaction's effects, and what happens if the transaction also sent an email or charged a card.*

#### Resource Preemption and Rollback

**Theory**

The alternative to killing a process is to take a resource away from it and give it to someone else, leaving the victim alive but set back. This is deadlock recovery by attacking the *no preemption* condition after the fact rather than before it.

Three problems must be solved together, and none of them can be skipped.

**1. Selecting a victim.** The same cost calculus as termination, but now applied per resource rather than per process: which resource, held by whom, breaks the cycle at least cost?

**2. Rollback.** A process that loses a resource mid-use cannot simply continue — it was relying on that resource. It must be rolled back to a state where it did not hold it. Two options:

- *Total rollback*: abort and restart from the beginning. Simple, and no state needs to be recorded, but it discards everything.
- *Partial rollback*: return to a **checkpoint** taken before the resource was acquired, and resume from there. Cheaper per incident, but the system must checkpoint periodically, which costs time and storage even when no deadlock ever occurs.

**3. Starvation.** If the victim is always chosen by cost, the cheapest process is preempted repeatedly and never completes. The remedy is the one from the previous topic: include the rollback count in the cost so a process cannot be victimised indefinitely.

Databases implement exactly this, and they solve the starvation problem elegantly with **timestamp ordering**. Each transaction gets a timestamp when it starts; older timestamps mean higher priority. Two well-known schemes decide what happens when transaction `T` wants a lock held by `U`:

| Scheme | If `T` is older than `U` | If `T` is younger than `U` | Property |
|---|---|---|---|
| **Wait-die** (non-preemptive) | `T` waits | `T` dies (aborts and retries with its *original* timestamp) | Older transactions wait; younger ones abort |
| **Wound-wait** (preemptive) | `T` wounds `U` — `U` is aborted, `T` proceeds | `T` waits | Older transactions preempt; younger ones wait |

Both are deadlock-free by construction: waiting only ever flows in one direction with respect to timestamp order, so a cycle would require a transaction to be both older and younger than itself. And because an aborted transaction keeps its original timestamp on retry, it grows older relative to everyone else and eventually becomes the one that cannot be aborted. Starvation is impossible. Google Spanner and CockroachDB use wound-wait variants for precisely this reason.

Analogy: recovering a shared meeting room. Termination is telling the occupants to abandon their project entirely. Preemption with total rollback is telling them to leave and start their meeting over from scratch tomorrow. Preemption with partial rollback is telling them to leave, but their notes on the whiteboard are photographed first, so they resume from where they were. Checkpointing is the cost of keeping a camera in every room, paid whether or not anyone is ever evicted.

**Example**

```text
   PARTIAL ROLLBACK TO A CHECKPOINT

   Process P2's timeline:

   start        ckpt A        acquire R1       ckpt B       acquire R2
     |------------|---------------|--------------|--------------|-----> DEADLOCK
                  ^                              ^
                  |                              |
     Roll back to ckpt B: P2 gives up R2 only, keeps R1, resumes
        from B. Work lost = everything after ckpt B.
     Roll back to ckpt A: P2 gives up BOTH R1 and R2.
        Work lost = everything after ckpt A. Needed only if
        releasing R2 alone does not break the cycle.
     Total rollback: P2 restarts from `start`. No checkpoints required,
        maximum work lost.

   The system chooses the SHALLOWEST rollback that breaks the cycle.


   WAIT-DIE vs WOUND-WAIT   (T requests a lock held by U)

                      T older than U            T younger than U
                      ----------------------    ----------------------
      wait-die        T WAITS                   T DIES (retry, same ts)
      wound-wait      T WOUNDS U (U aborts)     T WAITS

   Why neither can cycle:
      wait-die   -- every wait edge points from an OLDER to a YOUNGER
                    transaction. A cycle would need ts(T) < ts(T).
      wound-wait -- every wait edge points from a YOUNGER to an OLDER one.
                    Same contradiction, opposite direction.

   Why neither starves:
      An aborted transaction retries with its ORIGINAL timestamp, so it
      becomes progressively older, and eventually no one may abort it.
```

```python
class Transaction:
    def __init__(self, tid, timestamp):
        self.tid = tid
        self.timestamp = timestamp     # assigned ONCE; preserved across retries
        self.checkpoints = []          # (label, restorable state)

    def checkpoint(self, label, state):
        self.checkpoints.append((label, dict(state)))

    def rollback_to(self, label):
        """Partial rollback: discard everything after `label` and resume."""
        while self.checkpoints and self.checkpoints[-1][0] != label:
            self.checkpoints.pop()
        return self.checkpoints[-1][1] if self.checkpoints else None


def wound_wait(requester, holder, lock_manager):
    """Preemptive scheme. Older transactions never wait for younger ones,
       so wait edges always point young -> old and cannot form a cycle."""
    if requester.timestamp < holder.timestamp:      # requester is OLDER
        lock_manager.abort(holder)                  # WOUND: preempt the holder
        lock_manager.grant(requester)               # holder retries later,
        return "wounded"                            # keeping its timestamp
    else:                                           # requester is YOUNGER
        lock_manager.block(requester, on=holder)    # WAIT: safe direction
        return "waiting"


def wait_die(requester, holder, lock_manager):
    """Non-preemptive counterpart: nobody is ever forcibly aborted while
       holding a lock; the younger requester aborts itself instead."""
    if requester.timestamp < holder.timestamp:      # requester is OLDER
        lock_manager.block(requester, on=holder)    # WAIT
        return "waiting"
    else:                                           # requester is YOUNGER
        lock_manager.abort(requester)               # DIE: abort and retry
        return "died"                               # with the SAME timestamp
```

**Key takeaways**

- Preemption recovers by taking a resource back rather than destroying the process, but the victim must be rolled back to a state consistent with not holding it.
- Total rollback needs no bookkeeping and discards everything; partial rollback needs checkpoints, paid for continuously, and discards less.
- The system should choose the shallowest rollback that breaks the cycle.
- Starvation must be handled explicitly: count prior rollbacks, or preserve timestamps across retries as databases do.
- Wait-die and wound-wait are deadlock-free by construction because every wait edge points consistently in timestamp order, and they are starvation-free because aborted transactions keep their original timestamp.

> 🧪 Practice
>
> 1. Three transactions with timestamps `T1=10`, `T2=20`, `T3=30` contend for the same row in the order `T2` holds it, then `T1` requests, then `T3` requests. Trace the outcome under wait-die and under wound-wait.
> 2. A system checkpoints every 500 ms and deadlocks roughly once an hour. Estimate the total checkpointing overhead per deadlock avoided, and argue for or against total rollback instead.
> 3. Interview-style: "Wound-wait aborts more transactions than wait-die under some workloads, yet Spanner chose it. What does it buy?" *Hint: compare which transaction gets aborted in each scheme — the one holding locks or the one requesting them — and think about long-running transactions that have already done a lot of work.*

---

<a id="7-memory-management"></a>
## 7. Memory Management

<a id="71-main-memory-fundamentals"></a>
### 7.1 Main Memory Fundamentals

#### Address Binding

#### Logical vs Physical Address Space

#### Memory Management Unit

#### Base and Limit Registers

#### Dynamic Loading and Linking

#### Swapping

<a id="72-contiguous-allocation"></a>
### 7.2 Contiguous Allocation

#### Fixed and Variable Partitions

#### First-Fit, Best-Fit, Worst-Fit

#### Internal Fragmentation

#### External Fragmentation

#### Compaction

<a id="73-paging"></a>
### 7.3 Paging

#### Pages and Frames

#### Page Tables

#### Translation Lookaside Buffer

#### Hierarchical Page Tables

#### Hashed and Inverted Page Tables

#### Memory Protection Bits

#### Shared Pages

<a id="74-segmentation"></a>
### 7.4 Segmentation

#### Segmentation Model

#### Segment Tables

#### Segmentation with Paging

#### Comparison of Schemes

---

<a id="8-virtual-memory"></a>
## 8. Virtual Memory

<a id="81-demand-paging"></a>
### 8.1 Demand Paging

#### Concept of Virtual Memory

#### Page Faults and Handling

#### Pure Demand Paging

#### Effective Access Time

#### Copy-on-Write

<a id="82-page-replacement"></a>
### 8.2 Page Replacement

#### FIFO Replacement

#### Optimal Replacement

#### LRU and Approximations

#### Clock Algorithm

#### Counting-Based Algorithms

#### Belady's Anomaly

#### Page Buffering

<a id="83-frame-management"></a>
### 8.3 Frame Management

#### Minimum Number of Frames

#### Global vs Local Allocation

#### Proportional Allocation

#### NUMA-Aware Allocation

<a id="84-performance-concerns"></a>
### 8.4 Performance Concerns

#### Thrashing

#### Working Set Model

#### Page-Fault Frequency Control

#### Memory-Mapped Files

#### Kernel Memory Allocation

#### Buddy System and Slab Allocation

---

<a id="9-storage-systems"></a>
## 9. Storage Systems

<a id="91-secondary-storage-structure"></a>
### 9.1 Secondary Storage Structure

#### Magnetic Disk Geometry

#### Solid-State Drives

#### NVM and Flash Translation Layer

#### Disk Attachment Methods

#### Disk Formatting and Partitioning

<a id="92-disk-scheduling"></a>
### 9.2 Disk Scheduling

#### FCFS Disk Scheduling

#### SSTF

#### SCAN and C-SCAN

#### LOOK and C-LOOK

#### NVM Scheduling Considerations

<a id="93-reliability-and-performance"></a>
### 9.3 Reliability and Performance

#### RAID Levels

#### Mirroring and Striping

#### Parity and Error Correction

#### Swap Space Management

#### Storage Tiering

---

<a id="10-file-systems"></a>
## 10. File Systems

<a id="101-file-system-interface"></a>
### 10.1 File System Interface

#### File Attributes and Operations

#### File Types and Structure

#### Access Methods

#### Directory Structures

#### Mounting

#### File Sharing and Locking

<a id="102-file-system-implementation"></a>
### 10.2 File System Implementation

#### Layered File System Design

#### File Control Block and Inodes

#### Virtual File System Layer

#### Directory Implementation

#### Partition and Volume Layout

<a id="103-allocation-and-free-space"></a>
### 10.3 Allocation and Free Space

#### Contiguous Allocation

#### Linked Allocation

#### Indexed Allocation

#### Extents

#### Bit Vectors and Free Lists

#### Block Size Trade-offs

<a id="104-consistency-and-recovery"></a>
### 10.4 Consistency and Recovery

#### Buffer Cache and Write-Back Policies

#### Journaling File Systems

#### Log-Structured File Systems

#### Copy-on-Write File Systems

#### Consistency Checking

#### Backup and Restore

<a id="105-real-world-file-systems"></a>
### 10.5 Real-World File Systems

#### ext4

#### NTFS

#### ZFS and Btrfs

#### FAT and exFAT

#### NFS

#### Distributed File Systems

---

<a id="11-inputoutput-systems"></a>
## 11. Input/Output Systems

<a id="111-io-hardware"></a>
### 11.1 I/O Hardware

#### Device Controllers and Ports

#### Buses and Interfaces

#### Polling

#### Interrupt-Driven I/O

#### DMA Transfers

<a id="112-io-software-layers"></a>
### 11.2 I/O Software Layers

#### Device Drivers

#### Block vs Character Devices

#### Blocking and Non-Blocking I/O

#### Asynchronous I/O

#### Buffering and Caching

#### Spooling

<a id="113-kernel-io-subsystem"></a>
### 11.3 Kernel I/O Subsystem

#### I/O Scheduling

#### Error Handling

#### I/O Protection

#### Device Reservation

#### STREAMS

#### I/O Performance Tuning

---

<a id="12-protection-and-security"></a>
## 12. Protection and Security

<a id="121-protection-mechanisms"></a>
### 12.1 Protection Mechanisms

#### Principle of Least Privilege

#### Protection Domains

#### Access Matrix

#### Access Control Lists

#### Capabilities

#### Role-Based Access Control

#### Mandatory Access Control

<a id="122-security-threats"></a>
### 12.2 Security Threats

#### Program Threats and Malware

#### Buffer Overflow Attacks

#### Code Injection

#### System and Network Threats

#### Privilege Escalation

#### Side-Channel Attacks

<a id="123-defensive-techniques"></a>
### 12.3 Defensive Techniques

#### User Authentication

#### Cryptography in Operating Systems

#### Address Space Layout Randomization

#### Sandboxing and Isolation

#### Auditing and Logging

#### Secure Boot and Trusted Computing

---

<a id="13-virtualization"></a>
## 13. Virtualization

<a id="131-virtualization-concepts"></a>
### 13.1 Virtualization Concepts

#### Virtual Machine Abstraction

#### Type 1 and Type 2 Hypervisors

#### Full Virtualization

#### Paravirtualization

#### Emulation and Binary Translation

<a id="132-virtualization-implementation"></a>
### 13.2 Virtualization Implementation

#### Hardware Virtualization Support

#### Shadow Page Tables and Nested Paging

#### CPU and Memory Virtualization

#### I/O Virtualization

#### Live Migration

<a id="133-containers-and-lightweight-isolation"></a>
### 13.3 Containers and Lightweight Isolation

#### Namespaces

#### Control Groups

#### Container Runtimes

#### Containers vs Virtual Machines

#### Unikernels

---

<a id="14-distributed-and-specialized-systems"></a>
## 14. Distributed and Specialized Systems

<a id="141-distributed-operating-systems"></a>
### 14.1 Distributed Operating Systems

#### Network Operating System Models

#### Distributed Coordination

#### Logical Clocks and Ordering

#### Distributed Mutual Exclusion

#### Consensus and Fault Tolerance

<a id="142-real-time-and-embedded-systems"></a>
### 14.2 Real-Time and Embedded Systems

#### Hard vs Soft Real-Time

#### Latency and Jitter Requirements

#### RTOS Architectures

#### Embedded System Constraints

<a id="143-mobile-operating-systems"></a>
### 14.3 Mobile Operating Systems

#### Mobile Power Management

#### Mobile Memory Constraints

#### Application Lifecycle Management

#### Android Architecture

#### iOS Architecture

---

<a id="15-case-studies-and-performance"></a>
## 15. Case Studies and Performance

<a id="151-system-case-studies"></a>
### 15.1 System Case Studies

#### Linux Kernel Architecture

#### Windows Kernel Architecture

#### UNIX and BSD Design

#### Research Operating Systems

<a id="152-performance-analysis"></a>
### 15.2 Performance Analysis

#### System Metrics and Profiling

#### Tracing and Instrumentation

#### Bottleneck Identification

#### Capacity Planning

#### Kernel Tuning Parameters
