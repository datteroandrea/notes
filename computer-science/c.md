# C Programming Language

## Index

- [1. Foundations and Toolchain](#1-foundations-and-toolchain)
  - [1.1 Origins and Standards](#11-origins-and-standards)
  - [1.2 Program Structure](#12-program-structure)
  - [1.3 Build Pipeline](#13-build-pipeline)
  - [1.4 Development Environment](#14-development-environment)
- [2. Types, Values, and Expressions](#2-types-values-and-expressions)
  - [2.1 Fundamental Types](#21-fundamental-types)
  - [2.2 Variables and Literals](#22-variables-and-literals)
  - [2.3 Operators](#23-operators)
  - [2.4 Conversions and Numeric Behavior](#24-conversions-and-numeric-behavior)
- [3. Control Flow](#3-control-flow)
  - [3.1 Selection](#31-selection)
  - [3.2 Iteration](#32-iteration)
  - [3.3 Jumps](#33-jumps)
- [4. Functions and Program Organization](#4-functions-and-program-organization)
  - [4.1 Function Basics](#41-function-basics)
  - [4.2 Scope and Lifetime](#42-scope-and-lifetime)
  - [4.3 Multi-File Programs](#43-multi-file-programs)
  - [4.4 Variadic Functions](#44-variadic-functions)
- [5. Arrays, Strings, and Pointers](#5-arrays-strings-and-pointers)
  - [5.1 Arrays](#51-arrays)
  - [5.2 Pointer Fundamentals](#52-pointer-fundamentals)
  - [5.3 Advanced Pointer Use](#53-advanced-pointer-use)
  - [5.4 Strings](#54-strings)
- [6. Composite and User-Defined Types](#6-composite-and-user-defined-types)
  - [6.1 Structures](#61-structures)
  - [6.2 Unions and Enumerations](#62-unions-and-enumerations)
  - [6.3 Typedefs and Layout](#63-typedefs-and-layout)
- [7. Memory Management](#7-memory-management)
  - [7.1 Memory Model](#71-memory-model)
  - [7.2 Dynamic Allocation](#72-dynamic-allocation)
  - [7.3 Memory Errors](#73-memory-errors)
  - [7.4 Allocation Strategies](#74-allocation-strategies)
- [8. The Preprocessor](#8-the-preprocessor)
  - [8.1 Directives](#81-directives)
  - [8.2 Conditional Compilation](#82-conditional-compilation)
  - [8.3 Macro Techniques and Hazards](#83-macro-techniques-and-hazards)
- [9. Standard Library](#9-standard-library)
  - [9.1 Formatted and Stream I/O](#91-formatted-and-stream-io)
  - [9.2 Core Utility Headers](#92-core-utility-headers)
  - [9.3 Error Handling](#93-error-handling)
- [10. Data Structures and Algorithms in C](#10-data-structures-and-algorithms-in-c)
  - [10.1 Linear Structures](#101-linear-structures)
  - [10.2 Associative and Hierarchical Structures](#102-associative-and-hierarchical-structures)
  - [10.3 Generic and Reusable Code](#103-generic-and-reusable-code)
- [11. Systems Programming](#11-systems-programming)
  - [11.1 Processes and the OS Interface](#111-processes-and-the-os-interface)
  - [11.2 Files and I/O at the System Level](#112-files-and-io-at-the-system-level)
  - [11.3 Networking](#113-networking)
  - [11.4 Concurrency](#114-concurrency)
- [12. Low-Level and Advanced Topics](#12-low-level-and-advanced-topics)
  - [12.1 Bit Manipulation](#121-bit-manipulation)
  - [12.2 Undefined and Unspecified Behavior](#122-undefined-and-unspecified-behavior)
  - [12.3 Interfacing and Portability](#123-interfacing-and-portability)
  - [12.4 Embedded and Freestanding C](#124-embedded-and-freestanding-c)
- [13. Quality, Debugging, and Security](#13-quality-debugging-and-security)
  - [13.1 Debugging](#131-debugging)
  - [13.2 Analysis and Testing](#132-analysis-and-testing)
  - [13.3 Secure and Maintainable C](#133-secure-and-maintainable-c)

---

## 1. Foundations and Toolchain

<a id="11-origins-and-standards"></a>
### 1.1 Origins and Standards

#### History of C

#### K&R C vs ANSI C

#### C89/C99/C11/C17/C23

#### Freestanding vs Hosted Implementations

#### Where C Is Used Today

<a id="12-program-structure"></a>
### 1.2 Program Structure

#### Anatomy of a C Program

#### The main Function and Return Codes

#### Statements and Blocks

#### Comments

#### Source Files and Translation Units

<a id="13-build-pipeline"></a>
### 1.3 Build Pipeline

#### Preprocessing, Compiling, Assembling, Linking

#### Object Files and Executables

#### Invoking GCC and Clang

#### Common Compiler Flags

#### Warnings as Errors

#### Optimization Levels

<a id="14-development-environment"></a>
### 1.4 Development Environment

#### Editors and IDEs

#### Reading Compiler Diagnostics

#### Manual Pages and Reference Docs

#### Compiler Explorer and Disassembly

---

## 2. Types, Values, and Expressions

<a id="21-fundamental-types"></a>
### 2.1 Fundamental Types

#### char, short, int, long, long long

#### Signed vs Unsigned

#### float, double, long double

#### _Bool and stdbool.h

#### void

#### Fixed-Width Types in stdint.h

#### sizeof and Type Sizes

<a id="22-variables-and-literals"></a>
### 2.2 Variables and Literals

#### Declaration vs Definition

#### Identifiers and Keywords

#### Integer, Floating, Character, and String Literals

#### Escape Sequences

#### const Qualifier

#### volatile Qualifier

#### restrict Qualifier

<a id="23-operators"></a>
### 2.3 Operators

#### Arithmetic Operators

#### Relational and Equality Operators

#### Logical Operators and Short-Circuiting

#### Bitwise Operators and Shifts

#### Assignment and Compound Assignment

#### Increment and Decrement

#### Ternary Conditional Operator

#### Comma Operator

#### Precedence and Associativity

<a id="24-conversions-and-numeric-behavior"></a>
### 2.4 Conversions and Numeric Behavior

#### Implicit Conversions and Integer Promotion

#### Usual Arithmetic Conversions

#### Explicit Casts

#### Integer Overflow and Wraparound

#### Floating-Point Representation (IEEE 754)

#### Precision Loss and Comparison Pitfalls

---

## 3. Control Flow

<a id="31-selection"></a>
### 3.1 Selection

#### if and else

#### Nested and Chained Conditions

#### switch, case, and default

#### Fallthrough Behavior

<a id="32-iteration"></a>
### 3.2 Iteration

#### while Loop

#### do-while Loop

#### for Loop

#### Nested Loops

#### Infinite Loops and Termination Conditions

<a id="33-jumps"></a>
### 3.3 Jumps

#### break and continue

#### goto and Labels

#### return

#### Structured vs Unstructured Control Flow

---

## 4. Functions and Program Organization

<a id="41-function-basics"></a>
### 4.1 Function Basics

#### Definitions and Prototypes

#### Parameters and Arguments

#### Return Values

#### Pass by Value Semantics

#### Recursion

#### Function Design and Cohesion

<a id="42-scope-and-lifetime"></a>
### 4.2 Scope and Lifetime

#### Block, File, and Function Scope

#### Automatic Storage Duration

#### static Variables

#### extern Declarations

#### register and inline

#### Name Shadowing

<a id="43-multi-file-programs"></a>
### 4.3 Multi-File Programs

#### Header Files and Include Guards

#### Separating Interface from Implementation

#### Internal vs External Linkage

#### Circular Dependencies

#### Build Systems and Makefiles

<a id="44-variadic-functions"></a>
### 4.4 Variadic Functions

#### Ellipsis Parameters

#### va_list, va_start, va_arg, va_end

#### Writing printf-Style Wrappers

#### Type-Safety Limitations

---

## 5. Arrays, Strings, and Pointers

<a id="51-arrays"></a>
### 5.1 Arrays

#### Declaration and Initialization

#### Indexing and Bounds

#### Multidimensional Arrays

#### Array Decay to Pointers

#### Passing Arrays to Functions

#### Variable-Length Arrays

<a id="52-pointer-fundamentals"></a>
### 5.2 Pointer Fundamentals

#### Address-of and Dereference Operators

#### Pointer Declaration and Types

#### NULL Pointers

#### Pointer Arithmetic

#### Pointers and Arrays Relationship

#### const with Pointers

#### void Pointers

<a id="53-advanced-pointer-use"></a>
### 5.3 Advanced Pointer Use

#### Pointers to Pointers

#### Arrays of Pointers

#### Pointers to Functions

#### Callbacks and Dispatch Tables

#### Reading Complex Declarations

<a id="54-strings"></a>
### 5.4 Strings

#### Null-Terminated Character Arrays

#### String Literals and Immutability

#### strlen, strcpy, strcmp, strcat

#### strncpy and Bounded Variants

#### Tokenizing with strtok

#### Searching with strchr and strstr

#### Common String Bugs

---

## 6. Composite and User-Defined Types

<a id="61-structures"></a>
### 6.1 Structures

#### Defining and Initializing structs

#### Member Access and Arrow Operator

#### Nested Structures

#### Arrays of Structures

#### Passing and Returning Structures

#### Designated Initializers

<a id="62-unions-and-enumerations"></a>
### 6.2 Unions and Enumerations

#### union Declaration and Semantics

#### Tagged Unions

#### Type Punning Caveats

#### enum Constants and Underlying Type

#### Bit Fields

<a id="63-typedefs-and-layout"></a>
### 6.3 Typedefs and Layout

#### typedef for Readability

#### Opaque Types

#### Struct Padding and Alignment

#### offsetof

#### _Alignas and _Alignof

#### Packing Trade-offs

---

## 7. Memory Management

<a id="71-memory-model"></a>
### 7.1 Memory Model

#### Process Memory Layout

#### Stack vs Heap

#### Static and Global Storage

#### Text and Read-Only Data

#### Object Lifetime and Validity

<a id="72-dynamic-allocation"></a>
### 7.2 Dynamic Allocation

#### malloc and calloc

#### realloc Semantics

#### free and Ownership

#### Checking Allocation Failure

#### Allocating Structs and Arrays

#### Growable Buffers

<a id="73-memory-errors"></a>
### 7.3 Memory Errors

#### Memory Leaks

#### Dangling Pointers and Use-After-Free

#### Double Free

#### Buffer Overflows

#### Uninitialized Reads

#### Alignment and Aliasing Violations

<a id="74-allocation-strategies"></a>
### 7.4 Allocation Strategies

#### Arena and Pool Allocators

#### Stack Allocation with alloca

#### Custom Allocator Interfaces

#### Reference Counting Patterns

#### Fragmentation

---

## 8. The Preprocessor

<a id="81-directives"></a>
### 8.1 Directives

#### #include and Search Paths

#### #define Object-Like Macros

#### Function-Like Macros

#### #undef

#### Predefined Macros

<a id="82-conditional-compilation"></a>
### 8.2 Conditional Compilation

#### #if, #ifdef, #ifndef, #else, #elif

#### Feature Test Macros

#### Platform-Specific Code

#### Debug and Release Builds

#### #error and #pragma

<a id="83-macro-techniques-and-hazards"></a>
### 8.3 Macro Techniques and Hazards

#### Stringification and Token Pasting

#### Multiple Evaluation Pitfalls

#### do-while(0) Idiom

#### X-Macros

#### Generic Programming with _Generic

#### Macros vs inline Functions

---

## 9. Standard Library

<a id="91-formatted-and-stream-io"></a>
### 9.1 Formatted and Stream I/O

#### printf and Format Specifiers

#### scanf and Input Pitfalls

#### fopen, fclose, and Modes

#### fread, fwrite, fgets, fputs

#### fseek, ftell, and Positioning

#### Buffering and fflush

#### stdin, stdout, stderr

<a id="92-core-utility-headers"></a>
### 9.2 Core Utility Headers

#### string.h and Memory Functions

#### stdlib.h Conversions and Random Numbers

#### qsort and bsearch

#### math.h Essentials

#### ctype.h Character Classification

#### time.h Dates and Timing

#### limits.h and float.h

<a id="93-error-handling"></a>
### 9.3 Error Handling

#### Return Codes as Convention

#### errno and perror

#### assert and NDEBUG

#### setjmp and longjmp

#### exit, atexit, and abort

#### Designing Error Propagation

---

## 10. Data Structures and Algorithms in C

<a id="101-linear-structures"></a>
### 10.1 Linear Structures

#### Dynamic Arrays

#### Singly and Doubly Linked Lists

#### Stacks

#### Queues and Circular Buffers

#### String Builders

<a id="102-associative-and-hierarchical-structures"></a>
### 10.2 Associative and Hierarchical Structures

#### Hash Tables and Collision Handling

#### Binary Search Trees

#### Heaps and Priority Queues

#### Tries

#### Graph Representations

<a id="103-generic-and-reusable-code"></a>
### 10.3 Generic and Reusable Code

#### void Pointer Based Containers

#### Comparator and Destructor Callbacks

#### Macro-Generated Containers

#### Intrusive Data Structures

#### API Design for Libraries

---

## 11. Systems Programming

<a id="111-processes-and-the-os-interface"></a>
### 11.1 Processes and the OS Interface

#### Command-Line Arguments and Environment

#### System Calls vs Library Calls

#### fork, exec, and wait

#### Exit Status and Signals

#### signal and sigaction Basics

<a id="112-files-and-io-at-the-system-level"></a>
### 11.2 Files and I/O at the System Level

#### File Descriptors

#### open, read, write, close

#### Blocking vs Non-Blocking I/O

#### I/O Multiplexing with select and poll

#### Memory-Mapped Files with mmap

<a id="113-networking"></a>
### 11.3 Networking

#### Sockets API Overview

#### TCP Client and Server

#### UDP Datagrams

#### Byte Order Conversion

#### Handling Partial Reads and Writes

<a id="114-concurrency"></a>
### 11.4 Concurrency

#### POSIX Threads Creation and Joining

#### Mutexes and Condition Variables

#### Race Conditions and Deadlock

#### C11 Threads and Atomics

#### Memory Ordering Basics

#### Thread-Local Storage

---

## 12. Low-Level and Advanced Topics

<a id="121-bit-manipulation"></a>
### 12.1 Bit Manipulation

#### Masking, Setting, and Clearing Bits

#### Bit Counting and Scanning Idioms

#### Flags and Bit Sets

#### Endianness

#### Packing and Unpacking Binary Data

<a id="122-undefined-and-unspecified-behavior"></a>
### 12.2 Undefined and Unspecified Behavior

#### Categories of Non-Portable Behavior

#### Common Sources of UB

#### Strict Aliasing Rule

#### Sequence Points and Evaluation Order

#### How Optimizers Exploit UB

<a id="123-interfacing-and-portability"></a>
### 12.3 Interfacing and Portability

#### Calling Conventions and the ABI

#### Inline Assembly

#### Linking Against C from Other Languages

#### Static vs Shared Libraries

#### Dynamic Loading with dlopen

#### Cross-Platform Portability Concerns

<a id="124-embedded-and-freestanding-c"></a>
### 12.4 Embedded and Freestanding C

#### Memory-Mapped Registers

#### volatile in Hardware Contexts

#### Interrupt Service Routines

#### Avoiding Dynamic Allocation

#### Linker Scripts and Sections

---

## 13. Quality, Debugging, and Security

<a id="131-debugging"></a>
### 13.1 Debugging

#### GDB and LLDB Fundamentals

#### Breakpoints, Watchpoints, and Backtraces

#### Inspecting Memory and Registers

#### Core Dumps

#### Debug Logging Strategies

<a id="132-analysis-and-testing"></a>
### 13.2 Analysis and Testing

#### Valgrind Memcheck

#### AddressSanitizer and UndefinedBehaviorSanitizer

#### Static Analyzers and Linters

#### Unit Testing Frameworks

#### Fuzzing

#### Profiling and Benchmarking

<a id="133-secure-and-maintainable-c"></a>
### 13.3 Secure and Maintainable C

#### Input Validation and Bounds Checking

#### Avoiding Format String Vulnerabilities

#### Integer Overflow Defenses

#### Safe String and Memory Practices

#### Coding Standards (MISRA, CERT C)

#### Code Review Checklist for C
