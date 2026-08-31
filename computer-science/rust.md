# Rust Programming Language

## Index

- [1. Foundations and Tooling](#1-foundations-and-tooling)
  - [1.1 Language Overview](#11-language-overview)
  - [1.2 Toolchain Setup](#12-toolchain-setup)
  - [1.3 Cargo Basics](#13-cargo-basics)
  - [1.4 Program Structure](#14-program-structure)
- [2. Core Language Syntax](#2-core-language-syntax)
  - [2.1 Variables and Mutability](#21-variables-and-mutability)
  - [2.2 Primitive Types](#22-primitive-types)
  - [2.3 Control Flow](#23-control-flow)
  - [2.4 Functions](#24-functions)
- [3. Ownership and Memory Model](#3-ownership-and-memory-model)
  - [3.1 Ownership Rules](#31-ownership-rules)
  - [3.2 References and Borrowing](#32-references-and-borrowing)
  - [3.3 Lifetimes](#33-lifetimes)
  - [3.4 The Borrow Checker](#34-the-borrow-checker)
- [4. Data Modeling with Types](#4-data-modeling-with-types)
  - [4.1 Structs](#41-structs)
  - [4.2 Enums](#42-enums)
  - [4.3 Pattern Matching](#43-pattern-matching)
  - [4.4 Generics](#44-generics)
- [5. Traits and Abstraction](#5-traits-and-abstraction)
  - [5.1 Trait Fundamentals](#51-trait-fundamentals)
  - [5.2 Standard Library Traits](#52-standard-library-traits)
  - [5.3 Static and Dynamic Dispatch](#53-static-and-dynamic-dispatch)
  - [5.4 Advanced Trait Techniques](#54-advanced-trait-techniques)
- [6. Collections, Strings, and Iterators](#6-collections-strings-and-iterators)
  - [6.1 Standard Collections](#61-standard-collections)
  - [6.2 Strings and Text](#62-strings-and-text)
  - [6.3 Iterators](#63-iterators)
  - [6.4 Closures](#64-closures)
- [7. Error Handling](#7-error-handling)
  - [7.1 Recoverable Errors](#71-recoverable-errors)
  - [7.2 Unrecoverable Errors](#72-unrecoverable-errors)
  - [7.3 Custom Error Types](#73-custom-error-types)
  - [7.4 Error Design Practices](#74-error-design-practices)
- [8. Modules, Crates, and Project Organization](#8-modules-crates-and-project-organization)
  - [8.1 Module System](#81-module-system)
  - [8.2 Crates and Packages](#82-crates-and-packages)
  - [8.3 Build and Release](#83-build-and-release)
  - [8.4 Tooling Ecosystem](#84-tooling-ecosystem)
- [9. Smart Pointers and Interior Mutability](#9-smart-pointers-and-interior-mutability)
  - [9.1 Owned Pointers](#91-owned-pointers)
  - [9.2 Shared Ownership](#92-shared-ownership)
  - [9.3 Interior Mutability](#93-interior-mutability)
  - [9.4 Borrowed Data Abstractions](#94-borrowed-data-abstractions)
- [10. Concurrency and Parallelism](#10-concurrency-and-parallelism)
  - [10.1 Threads](#101-threads)
  - [10.2 Message Passing](#102-message-passing)
  - [10.3 Shared-State Concurrency](#103-shared-state-concurrency)
  - [10.4 Concurrency Safety](#104-concurrency-safety)
  - [10.5 Data Parallelism](#105-data-parallelism)
- [11. Asynchronous Rust](#11-asynchronous-rust)
  - [11.1 Async Fundamentals](#111-async-fundamentals)
  - [11.2 Runtimes](#112-runtimes)
  - [11.3 Async Composition](#113-async-composition)
  - [11.4 Async Challenges](#114-async-challenges)
- [12. Testing, Documentation, and Quality](#12-testing-documentation-and-quality)
  - [12.1 Testing Fundamentals](#121-testing-fundamentals)
  - [12.2 Advanced Testing](#122-advanced-testing)
  - [12.3 Benchmarking and Profiling](#123-benchmarking-and-profiling)
  - [12.4 Documentation](#124-documentation)
- [13. Metaprogramming](#13-metaprogramming)
  - [13.1 Declarative Macros](#131-declarative-macros)
  - [13.2 Procedural Macros](#132-procedural-macros)
  - [13.3 Compile-Time Techniques](#133-compile-time-techniques)
- [14. Unsafe Rust and Systems Interop](#14-unsafe-rust-and-systems-interop)
  - [14.1 Unsafe Fundamentals](#141-unsafe-fundamentals)
  - [14.2 Memory Layout](#142-memory-layout)
  - [14.3 Foreign Function Interface](#143-foreign-function-interface)
  - [14.4 Verification Tools](#144-verification-tools)
- [15. Performance and Low-Level Control](#15-performance-and-low-level-control)
  - [15.1 Optimization Techniques](#151-optimization-techniques)
  - [15.2 Data-Oriented Design](#152-data-oriented-design)
  - [15.3 Embedded and no_std](#153-embedded-and-no_std)
- [16. Applied Rust and Ecosystem](#16-applied-rust-and-ecosystem)
  - [16.1 Idiomatic Design Patterns](#161-idiomatic-design-patterns)
  - [16.2 Systems and CLI Development](#162-systems-and-cli-development)
  - [16.3 Serialization and Data](#163-serialization-and-data)
  - [16.4 Networking and Web](#164-networking-and-web)
  - [16.5 WebAssembly](#165-webassembly)

## 1. Foundations and Tooling

<a id="11-language-overview"></a>
### 1.1 Language Overview

- Design Goals and Philosophy
- Zero-Cost Abstractions
- Safety Without Garbage Collection
- Rust Editions
- Comparison with C, C++, and Go

<a id="12-toolchain-setup"></a>
### 1.2 Toolchain Setup

- Installing with rustup
- Toolchains and Channels
- Compiling with rustc
- Rust Playground
- IDE Support and rust-analyzer

<a id="13-cargo-basics"></a>
### 1.3 Cargo Basics

- Creating a Package
- Cargo.toml Manifest
- Building and Running
- Cargo.lock and Reproducible Builds
- Dependencies from crates.io

<a id="14-program-structure"></a>
### 1.4 Program Structure

- The main Function
- Statements vs Expressions
- Comments and Doc Comments
- Formatted Printing Macros
- Compiler Errors and Warnings

## 2. Core Language Syntax

<a id="21-variables-and-mutability"></a>
### 2.1 Variables and Mutability

- let Bindings
- Mutability with mut
- Shadowing
- Constants
- Static Variables

<a id="22-primitive-types"></a>
### 2.2 Primitive Types

- Integer Types and Overflow
- Floating-Point Types
- Booleans and Characters
- Tuples
- Arrays and Slices
- Type Inference and Annotations
- Numeric Casting with as

<a id="23-control-flow"></a>
### 2.3 Control Flow

- if and if-let Expressions
- loop and Loop Labels
- while and while-let
- for Loops and Ranges
- break with Values

<a id="24-functions"></a>
### 2.4 Functions

- Parameters and Return Types
- Implicit Return Expressions
- The Never Type
- Nested and Const Functions
- Diverging Functions and panic!

## 3. Ownership and Memory Model

<a id="31-ownership-rules"></a>
### 3.1 Ownership Rules

- Stack vs Heap Allocation
- Move Semantics
- Copy vs Clone
- Ownership Transfer in Functions
- Drop and RAII

<a id="32-references-and-borrowing"></a>
### 3.2 References and Borrowing

- Shared References
- Mutable References
- Aliasing XOR Mutability Rule
- Dangling Reference Prevention
- Slice References

<a id="33-lifetimes"></a>
### 3.3 Lifetimes

- Lifetime Annotations
- Lifetime Elision Rules
- Lifetimes in Structs and Impls
- The 'static Lifetime
- Higher-Ranked Trait Bounds
- Non-Lexical Lifetimes

<a id="34-the-borrow-checker"></a>
### 3.4 The Borrow Checker

- Borrow Scope Analysis
- Common Borrow Errors
- Reborrowing
- Splitting Borrows
- Interior Mutability Motivation

## 4. Data Modeling with Types

<a id="41-structs"></a>
### 4.1 Structs

- Named-Field Structs
- Tuple Structs
- Unit Structs
- Struct Update Syntax
- Methods and Associated Functions
- Visibility of Fields

<a id="42-enums"></a>
### 4.2 Enums

- Variants with Data
- Discriminants and C-Like Enums
- Option as a Null Replacement
- Result for Fallible Values
- Recursive Enums with Box

<a id="43-pattern-matching"></a>
### 4.3 Pattern Matching

- match Expressions and Exhaustiveness
- Destructuring Structs and Enums
- Match Guards
- Binding with @
- Or-Patterns and Ranges
- Refutable vs Irrefutable Patterns
- let-else

<a id="44-generics"></a>
### 4.4 Generics

- Generic Functions
- Generic Structs and Enums
- Trait Bounds and where Clauses
- Monomorphization
- Const Generics
- Phantom Types

## 5. Traits and Abstraction

<a id="51-trait-fundamentals"></a>
### 5.1 Trait Fundamentals

- Defining and Implementing Traits
- Default Method Implementations
- Associated Types
- Associated Constants
- Supertraits
- The Orphan Rule

<a id="52-standard-library-traits"></a>
### 5.2 Standard Library Traits

- Debug and Display
- Clone and Copy
- PartialEq, Eq, and Hash
- PartialOrd and Ord
- Default
- From, Into, and TryFrom
- Deref and DerefMut
- Drop
- Index and Operator Overloading

<a id="53-static-and-dynamic-dispatch"></a>
### 5.3 Static and Dynamic Dispatch

- impl Trait in Argument Position
- impl Trait in Return Position
- Trait Objects with dyn
- Object Safety Rules
- Vtables and Fat Pointers
- Performance Trade-offs

<a id="54-advanced-trait-techniques"></a>
### 5.4 Advanced Trait Techniques

- Generic Traits and Type Parameters
- Blanket Implementations
- Marker Traits
- Newtype Pattern
- Fully Qualified Syntax
- Sealed Traits

## 6. Collections, Strings, and Iterators

<a id="61-standard-collections"></a>
### 6.1 Standard Collections

- Vec and Capacity
- VecDeque
- HashMap and Entry API
- BTreeMap and Ordering
- HashSet and BTreeSet
- BinaryHeap
- Choosing the Right Collection

<a id="62-strings-and-text"></a>
### 6.2 Strings and Text

- String vs &str
- UTF-8 Encoding and Indexing
- Chars, Bytes, and Grapheme Clusters
- String Slicing and Concatenation
- Parsing and Formatting
- OsString and CString

<a id="63-iterators"></a>
### 6.3 Iterators

- The Iterator Trait
- iter, iter_mut, and into_iter
- Adapters: map, filter, take, skip
- Consumers: collect, fold, sum
- Lazy Evaluation
- Implementing Custom Iterators
- IntoIterator and FromIterator
- DoubleEnded and ExactSize Iterators

<a id="64-closures"></a>
### 6.4 Closures

- Closure Syntax and Inference
- Capture Modes
- Fn, FnMut, and FnOnce
- move Closures
- Returning Closures
- Function Pointers

## 7. Error Handling

<a id="71-recoverable-errors"></a>
### 7.1 Recoverable Errors

- Result Combinators
- The ? Operator
- Propagation Across Functions
- Option and Result Interop
- Early Return Patterns

<a id="72-unrecoverable-errors"></a>
### 7.2 Unrecoverable Errors

- panic! and Abort vs Unwind
- unwrap and expect
- Assertions
- Backtraces
- catch_unwind

<a id="73-custom-error-types"></a>
### 7.3 Custom Error Types

- Implementing std::error::Error
- Error Conversion with From
- Boxed Trait Object Errors
- Error Source Chains
- thiserror and anyhow

<a id="74-error-design-practices"></a>
### 7.4 Error Design Practices

- Library vs Application Errors
- Enum Errors vs Opaque Errors
- Adding Context
- Non-Exhaustive Enums
- Fallible Constructors

## 8. Modules, Crates, and Project Organization

<a id="81-module-system"></a>
### 8.1 Module System

- Modules and Submodules
- Paths and the use Keyword
- Visibility Modifiers
- Re-exports with pub use
- File and Directory Layout
- Prelude Patterns

<a id="82-crates-and-packages"></a>
### 8.2 Crates and Packages

- Binary vs Library Crates
- Multiple Binaries
- Workspaces
- Path, Git, and Registry Dependencies
- Feature Flags and Conditional Compilation

<a id="83-build-and-release"></a>
### 8.3 Build and Release

- Build Profiles and Optimization Levels
- build.rs Build Scripts
- Environment Variables and Cargo Metadata
- Publishing to crates.io
- Semantic Versioning

<a id="84-tooling-ecosystem"></a>
### 8.4 Tooling Ecosystem

- rustfmt
- Clippy Lints
- cargo doc and rustdoc
- cargo audit and deny
- Custom Cargo Subcommands

## 9. Smart Pointers and Interior Mutability

<a id="91-owned-pointers"></a>
### 9.1 Owned Pointers

- Box and Heap Allocation
- Box for Recursive Types
- Box&lt;dyn Trait&gt;
- Deref Coercion

<a id="92-shared-ownership"></a>
### 9.2 Shared Ownership

- Rc and Reference Counting
- Weak References and Cycles
- Arc for Threads
- Clone Cost and Trade-offs

<a id="93-interior-mutability"></a>
### 9.3 Interior Mutability

- Cell
- RefCell and Runtime Borrow Checking
- OnceCell and LazyCell
- UnsafeCell Foundations
- Combining Rc with RefCell

<a id="94-borrowed-data-abstractions"></a>
### 9.4 Borrowed Data Abstractions

- Cow for Clone-on-Write
- Pin and Self-Referential Types
- ManuallyDrop and MaybeUninit
- Borrow and AsRef Traits

## 10. Concurrency and Parallelism

<a id="101-threads"></a>
### 10.1 Threads

- Spawning and Joining Threads
- Moving Data into Threads
- Scoped Threads
- Thread Local Storage
- Panics Across Threads

<a id="102-message-passing"></a>
### 10.2 Message Passing

- Channels with mpsc
- Senders, Receivers, and Ownership
- Bounded vs Unbounded Channels
- Crossbeam Channels
- Producer-Consumer Patterns

<a id="103-shared-state-concurrency"></a>
### 10.3 Shared-State Concurrency

- Mutex and Lock Poisoning
- RwLock
- Atomic Types and Ordering
- Condvar and Barriers
- Deadlock Avoidance

<a id="104-concurrency-safety"></a>
### 10.4 Concurrency Safety

- The Send Trait
- The Sync Trait
- Auto Traits and Negative Impls
- Fearless Concurrency Guarantees
- Data Race Freedom

<a id="105-data-parallelism"></a>
### 10.5 Data Parallelism

- Rayon Parallel Iterators
- Work Stealing
- Parallel Sorting and Reduction
- Thread Pools
- Measuring Parallel Speedup

## 11. Asynchronous Rust

<a id="111-async-fundamentals"></a>
### 11.1 Async Fundamentals

- async/await Syntax
- The Future Trait
- Poll and Wakers
- State Machine Transformation
- Lazy Futures vs Eager Tasks

<a id="112-runtimes"></a>
### 11.2 Runtimes

- Executors and Reactors
- Tokio Runtime
- async-std and smol
- Spawning Tasks
- Blocking Code in Async Contexts

<a id="113-async-composition"></a>
### 11.3 Async Composition

- join and try_join
- select and Cancellation
- Streams and StreamExt
- Async Channels
- Timeouts and Intervals

<a id="114-async-challenges"></a>
### 11.4 Async Challenges

- Pin and Unpin in Futures
- Async Traits and Object Safety
- Send Bounds on Futures
- Cancellation Safety
- Structured Concurrency Patterns

## 12. Testing, Documentation, and Quality

<a id="121-testing-fundamentals"></a>
### 12.1 Testing Fundamentals

- Unit Tests and #[test]
- Integration Tests
- Test Organization and Modules
- should_panic and Result Tests
- Ignoring and Filtering Tests

<a id="122-advanced-testing"></a>
### 12.2 Advanced Testing

- Doc Tests
- Property-Based Testing
- Fuzzing with cargo-fuzz
- Mocking and Test Doubles
- Snapshot Testing
- Code Coverage

<a id="123-benchmarking-and-profiling"></a>
### 12.3 Benchmarking and Profiling

- Criterion Benchmarks
- Micro vs Macro Benchmarks
- Flamegraphs and perf
- Allocation Profiling
- Interpreting Benchmark Noise

<a id="124-documentation"></a>
### 12.4 Documentation

- Doc Comment Conventions
- Intra-Doc Links
- Examples Directory
- README and Crate-Level Docs
- docs.rs Configuration

## 13. Metaprogramming

<a id="131-declarative-macros"></a>
### 13.1 Declarative Macros

- macro_rules! Syntax
- Fragment Specifiers
- Repetition Patterns
- Macro Hygiene
- Exporting Macros

<a id="132-procedural-macros"></a>
### 13.2 Procedural Macros

- Derive Macros
- Attribute Macros
- Function-Like Macros
- TokenStream Manipulation
- syn and quote Crates
- Compile-Time Error Reporting

<a id="133-compile-time-techniques"></a>
### 13.3 Compile-Time Techniques

- const fn and const Evaluation
- Type-State Programming
- Builder Pattern Generation
- Static Assertions
- Code Generation in build.rs

## 14. Unsafe Rust and Systems Interop

<a id="141-unsafe-fundamentals"></a>
### 14.1 Unsafe Fundamentals

- The unsafe Keyword
- Raw Pointers
- Dereferencing and Aliasing Rules
- Unsafe Functions and Traits
- Undefined Behavior Catalog
- Safe Abstraction Boundaries

<a id="142-memory-layout"></a>
### 14.2 Memory Layout

- Size, Alignment, and Padding
- repr(C) and repr(transparent)
- Union Types
- Transmute Hazards
- Custom Allocators
- Zero-Sized Types

<a id="143-foreign-function-interface"></a>
### 14.3 Foreign Function Interface

- extern Blocks and ABI
- Calling C from Rust
- Exposing Rust to C
- Binding Generation with bindgen
- cbindgen for Headers
- Ownership Across FFI Boundaries

<a id="144-verification-tools"></a>
### 14.4 Verification Tools

- Miri Interpreter
- Sanitizers
- Stacked and Tree Borrows Models
- Auditing unsafe Code
- Documenting Safety Invariants

## 15. Performance and Low-Level Control

<a id="151-optimization-techniques"></a>
### 15.1 Optimization Techniques

- Avoiding Unnecessary Allocation
- Inlining and Attributes
- Link-Time Optimization
- Codegen Units and PGO
- Bounds Check Elimination
- SIMD and Intrinsics

<a id="152-data-oriented-design"></a>
### 15.2 Data-Oriented Design

- Cache Locality
- Struct of Arrays vs Array of Structs
- Arena and Slab Allocation
- Small Vector Optimization
- Index-Based Graph Structures

<a id="153-embedded-and-no_std"></a>
### 15.3 Embedded and no_std

- The no_std Attribute
- core vs alloc vs std
- Cross-Compilation Targets
- Panic Handlers
- Interrupt-Safe Abstractions
- Embedded HAL Ecosystem

## 16. Applied Rust and Ecosystem

<a id="161-idiomatic-design-patterns"></a>
### 16.1 Idiomatic Design Patterns

- Builder Pattern
- Typestate Pattern
- Newtype and Wrapper Types
- Interpreter and Visitor with Enums
- Composition over Inheritance
- API Design Guidelines

<a id="162-systems-and-cli-development"></a>
### 16.2 Systems and CLI Development

- File and Path APIs
- Standard I/O and Buffering
- Process and Environment Handling
- Argument Parsing with clap
- Logging and Tracing
- Configuration Management

<a id="163-serialization-and-data"></a>
### 16.3 Serialization and Data

- Serde Derive and Attributes
- JSON, TOML, and Binary Formats
- Custom Serializers
- Zero-Copy Deserialization
- Database Access with sqlx and Diesel

<a id="164-networking-and-web"></a>
### 16.4 Networking and Web

- TCP and UDP Sockets
- HTTP Clients with reqwest
- Web Frameworks: Axum and Actix
- gRPC with tonic
- WebSockets
- TLS and Security Basics

<a id="165-webassembly"></a>
### 16.5 WebAssembly

- Compiling to wasm32 Targets
- wasm-bindgen and JS Interop
- WASI Runtimes
- Size Optimization
- Browser and Edge Deployment
