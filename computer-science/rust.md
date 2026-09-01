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

Rust is a systems language that refuses the usual bargain between speed and
safety: it compiles to native code with no garbage collector, yet rejects
use-after-free, data races, and dangling pointers before the program ever runs.
This chapter covers the philosophy behind that bargain, the toolchain that makes
Rust practical day to day (rustup, rustc, Cargo, rust-analyzer), and the shape of
the smallest complete program, so that every later chapter can focus on the
language itself rather than on how to build and run it.

<a id="11-language-overview"></a>
### 1.1 Language Overview

Before writing code it pays to understand what problem Rust was built to solve,
what it guarantees, what those guarantees cost, and how the language keeps
evolving without breaking existing programs.

#### Design Goals and Philosophy

For decades systems programmers faced a forced choice. Languages like C and C++
give you direct control over memory and produce fast, small binaries, but a
single mistake — freeing a pointer twice, reading past the end of a buffer,
sharing data between threads without a lock — is *undefined behavior*: the
compiler is allowed to do anything, and the bug may surface months later as a
security advisory. Languages like Java, C#, and Go remove those mistakes by
adding a garbage collector and runtime checks, but you pay with pauses, memory
overhead, and less control over layout.

Rust's thesis is that this trade-off is not fundamental. Most memory and
concurrency errors come from *aliasing plus mutation*: two parts of a program
holding pointers to the same data while at least one of them writes. If the
compiler tracks who owns each value and who may reference it, it can reject
those programs at compile time, and then no runtime machinery is needed.

Think of it as three different workshops. In the C workshop every power tool has
its safety guard removed: fast, precise, and one slip is catastrophic. In the
Java workshop a supervisor follows you everywhere, checking each move and
occasionally stopping the line to tidy up. In the Rust workshop the tools have
interlocks that are verified before you switch them on; once the machine starts,
it runs at full speed with nothing watching.

Several design principles follow from that thesis:

- **Safety by default, unsafety by opt-in.** `unsafe` is a narrow, greppable
  block, not a compiler flag or a whole-program mode.
- **Explicit over implicit.** No implicit numeric conversions, no null, no
  exceptions, no hidden allocation, no constructor magic.
- **Errors are values.** Fallibility shows up in the type (`Result`), so it
  cannot be silently ignored.
- **Make illegal states unrepresentable.** Enums and the type system encode
  invariants so whole classes of bugs fail to compile.

```rust
fn main() {
    let name = String::from("Ada");   // heap buffer, owned by `name`
    let taken = name;                 // ownership MOVES out of `name`
    println!("{taken}");              // fine: `taken` owns the buffer now

    // println!("{name}");            // error[E0382]: borrow of moved value.
                                      // The compiler rejects this instead of
                                      // letting a stale pointer reach runtime.
}
```

> Key Takeaways
> - Rust exists to deliver C-level performance with compile-time memory and
>   thread safety, rather than trading one for the other.
> - Most memory bugs come from aliasing combined with mutation; ownership rules
>   make that combination a compile error.
> - Safety is the default and `unsafe` is a small, auditable escape hatch.
> - The language prefers explicitness: no null, no exceptions, no hidden
>   conversions.

> 🧪 Practice
> 1. Write a program that creates a `String`, moves it into a second variable,
>    and prints only the second. Then uncomment a use of the first and read the
>    compiler error carefully.
> 2. List three bugs you have hit (or read about) in another language and mark
>    which of them Rust's rules would catch at compile time.
> 3. Interview: Rust has neither a garbage collector nor a manual `free`. How is
>    heap memory released, and at exactly which point in the program? (Hint:
>    think about scopes and what the compiler can insert at the end of one.)

#### Zero-Cost Abstractions

Bjarne Stroustrup's formulation is the standard one: what you do not use, you do
not pay for; and what you do use, you could not hand-code any better. Rust
adopts it wholesale. High-level constructs — iterators, closures, generics,
`Option`, operator overloading — are designed so the optimizer can erase them,
leaving machine code equivalent to the loop you would have written by hand.

The mechanism is that abstractions are resolved at compile time rather than at
runtime. Generics are *monomorphized*: `Vec<i32>` and `Vec<String>` compile to
separate specialized code with no boxing and no type tags. Closures become
anonymous structs with an inlinable call. Iterator adapters are lazy structs
that collapse into a single loop. `Option<&T>` is optimized so the null pointer
represents `None`, making it the same size as `&T`.

The cost is not zero in every dimension. You pay in compile time and sometimes in
binary size, because monomorphization duplicates code per concrete type.

```rust
fn sum_even_squares(limit: u32) -> u32 {
    (1..=limit)
        .filter(|n| n % 2 == 0)   // closure inlined; no allocation, no dyn call
        .map(|n| n * n)           // lazy: nothing is computed yet
        .sum()                    // the consumer drives the whole chain once
}

fn sum_even_squares_manual(limit: u32) -> u32 {
    let mut total = 0;
    for n in 1..=limit {
        if n % 2 == 0 {
            total += n * n;
        }
    }
    total
}

fn main() {
    // 2*2 + 4*4 + 6*6 + 8*8 + 10*10 = 4 + 16 + 36 + 64 + 100 = 220
    assert_eq!(sum_even_squares(10), 220);
    assert_eq!(sum_even_squares(10), sum_even_squares_manual(10));
}
```

In a release build these two functions typically compile to the same
instructions. You can check that on the Rust Playground with the ASM output, or
locally with `cargo asm`.

| Abstraction              | Runtime cost                    | Paid at compile time |
| ------------------------ | ------------------------------- | -------------------- |
| Generic function/struct  | None (specialized per type)     | Code duplication     |
| Trait bound (`impl T`)   | None (static dispatch, inlined) | Code duplication     |
| Iterator adapter chain   | None (fuses into one loop)      | Some inlining work   |
| Closure (non-escaping)   | None (inlined struct + call)    | None                 |
| `Option<&T>`             | None (null-pointer niche)       | None                 |
| `dyn Trait`              | One indirect call via a vtable  | Smaller binary       |
| `Box<T>`                 | One heap allocation             | None                 |

> Key Takeaways
> - Zero-cost means the abstraction adds no runtime overhead versus equivalent
>   hand-written code, not that it is free in every sense.
> - Generics are monomorphized, so trait bounds dispatch statically by default.
> - Iterator chains are lazy and fuse into a single loop; idiomatic Rust is
>   usually also fast Rust.
> - You pay for abstraction in compile time and binary size, and for `dyn Trait`
>   in one pointer indirection.

> 🧪 Practice
> 1. Rewrite a `for` loop that sums the lengths of every string in a
>    `Vec<String>` as an iterator chain and confirm both produce the same result.
> 2. Use the Rust Playground's ASM button in release mode to compare the two
>    functions above. Count the loops in each output.
> 3. Interview: A colleague says "zero-cost abstraction means free." Where is
>    that wrong, and which Rust abstractions genuinely do carry a runtime cost?
>    (Hint: consider what monomorphization does to the build, and what `dyn` and
>    `Box` add at runtime.)

#### Safety Without Garbage Collection

Every language that uses heap memory must answer one question: when is an
allocation released? There are three families of answers.

1. **Manual** (C, C++ with raw `new`/`delete`): the programmer calls `free`.
   Fast and predictable, but forgetting it leaks, doing it twice corrupts the
   allocator, and doing it too early creates a dangling pointer.
2. **Traced garbage collection** (Java, Go, C#): a runtime periodically finds
   unreachable objects and reclaims them. Safe and convenient, but it costs
   throughput, memory headroom, and — for latency-sensitive systems — pauses.
3. **Ownership with scope-based destruction** (Rust, and C++ RAII by
   convention): every value has exactly one owner, and when the owner goes out
   of scope the value's destructor runs. Rust makes this a rule the compiler
   enforces rather than a discipline you remember to follow.

Rust adds a second half to that rule: references are checked so they can never
outlive the value they point to, and at any moment you may have either many
shared references or exactly one mutable reference, never both. Aliasing without
mutation is fine; mutation without aliasing is fine; the dangerous combination is
rejected.

```text
fn main() {
    let s = String::from("hi");

        STACK (frame of main)              HEAP
        +---------------------+            +-----------+
   s -> | ptr    ------------ | ---------> | 'h' | 'i' |
        | len = 2             |            +-----------+
        | cap = 2             |
        +---------------------+

}   // `s` leaves scope -> Drop runs -> the heap buffer is freed here.
    // No GC thread, no pause, no finalizer queue: it is a deallocation call
    // the compiler inserted at this exact line.
```

| Strategy                  | Safe? | Runtime cost                      | Determinism | Examples      |
| ------------------------- | ----- | --------------------------------- | ----------- | ------------- |
| Manual free               | No    | None                              | Full        | C             |
| Garbage collector         | Yes   | CPU, memory headroom, pauses      | Low         | Java, Go      |
| Reference counting only   | Yes   | Refcount traffic; leaks cycles    | High        | Swift, Python |
| Ownership + `Drop`        | Yes   | None                              | Full        | Rust          |

What safe Rust guarantees: no use-after-free, no double free, no dangling
references, no data races, no out-of-bounds reads (indexing panics instead), and
no reads of uninitialized memory. What it does *not* guarantee: freedom from
memory leaks, deadlocks, integer overflow surprises in release builds, or plain
logic errors. Leaking is considered safe because leaked memory cannot corrupt
another part of the program; it is a resource bug, not undefined behavior.

> Key Takeaways
> - Ownership plus an automatic `Drop` at end of scope replaces both manual
>   `free` and a garbage collector.
> - Deallocation points are visible in the source and deterministic, which
>   matters for latency-sensitive and embedded work.
> - Safe Rust rules out use-after-free, double free, dangling references, and
>   data races.
> - Leaks, deadlocks, and logic bugs remain possible; "safe" means "no undefined
>   behavior", not "no bugs".

> 🧪 Practice
> 1. Write a struct with a `Drop` implementation that prints on destruction, put
>    an instance in an inner block, and observe exactly when the message appears.
> 2. Predict, then verify, the drop order of three values declared one after
>    another in the same function.
> 3. Interview: Why is `std::mem::forget`, which leaks memory on purpose, a
>    *safe* function in Rust? (Hint: define safety in terms of undefined
>    behavior rather than correctness.)

#### Rust Editions

A language that promises stability faces a dilemma: how do you fix a design
mistake — reserve a new keyword, change how closures capture variables — without
breaking the millions of lines already published? Rust's answer is *editions*.

An edition is an opt-in bundle of surface-level breaking changes, declared per
crate in `Cargo.toml`. One compiler understands every edition at once, and crates
on different editions link together freely, because an edition changes only how
source text in *that crate* is parsed and interpreted, never the underlying data
representation or ABI. The ecosystem therefore never has to migrate in lockstep,
and there is no "Rust 2" split.

Editions ship roughly every three years. New library APIs and most language
features arrive on the ordinary six-week stable train and are available on every
edition.

| Edition | Shipped with | Notable changes                                       |
| ------- | ------------ | ----------------------------------------------------- |
| 2015    | Rust 1.0     | The original baseline                                 |
| 2018    | Rust 1.31    | New module paths, `dyn Trait`, `async`/`await` keywords |
| 2021    | Rust 1.56    | Disjoint closure captures, `IntoIterator` for arrays, consistent `panic!` |
| 2024    | Rust 1.85    | `unsafe` attributes, stricter `impl Trait` lifetime capture, `unsafe_op_in_unsafe_fn` warns, `gen` reserved |

```toml
# Cargo.toml - the edition is a property of the package, not of the compiler
[package]
name = "hello"
version = "0.1.0"
edition = "2024"        # omit this and Cargo assumes 2015, so always set it
rust-version = "1.85"   # minimum supported Rust version (MSRV)
```

```bash
# Migrating an existing crate: apply the automated fixes, then bump the edition
cargo fix --edition          # rewrites code so it compiles under the next edition
# ...then edit Cargo.toml to the new edition and re-run the test suite
cargo fix --edition-idioms   # optional: adopt the new edition's idioms
rustc --edition 2024 main.rs # editions work without Cargo too
```

> Key Takeaways
> - Editions let Rust make breaking syntactic changes without splitting the
>   ecosystem; one compiler supports them all.
> - The edition is per crate, set in `Cargo.toml`, and crates of different
>   editions interoperate without friction.
> - Omitting `edition` silently means 2015, so always declare it.
> - `cargo fix --edition` automates most of a migration.

> 🧪 Practice
> 1. Create two packages, one on edition 2015 and one on 2024, and have the
>    second depend on the first. Confirm it builds.
> 2. Read the edition guide's list of 2021 changes and explain in one sentence
>    why disjoint closure captures needed an edition boundary.
> 3. Interview: A dependency in your build graph is on edition 2015 while your
>    crate is on 2024. What breaks, and why? (Hint: think about the unit of code
>    that edition rules are applied to.)

#### Comparison with C, C++, and Go

Rust is most often weighed against C and C++, its performance peers, and against
Go, its peer for network services. The distinctions worth internalizing concern
*where* each language places its safety and abstraction costs.

| Dimension         | C                   | C++                   | Go                    | Rust                  |
| ----------------- | ------------------- | --------------------- | --------------------- | --------------------- |
| Memory management | Manual              | Manual + RAII         | Garbage collected     | Ownership + `Drop`    |
| Memory safety     | None                | Opt-in, unenforced    | Runtime-enforced      | Compile-time enforced |
| Data-race safety  | None                | None                  | None                  | Compile-time enforced |
| Runtime           | None                | None                  | GC + scheduler        | None beyond a shim    |
| Abstraction cost  | Manual and verbose  | Zero-cost, complex    | Simple, some cost     | Zero-cost             |
| Error handling    | Return codes        | Exceptions + codes    | Explicit `err` values | `Result` and `?`      |
| Generics          | Macros or `void*`   | Templates (unchecked) | Generics since 1.18   | Monomorphized, bounded |
| Build and deps    | Make, CMake, ad hoc | CMake, Conan, vcpkg   | `go build`, modules   | Cargo and crates.io   |
| Compile speed     | Very fast           | Slow                  | Very fast             | Slow to moderate      |
| Learning curve    | Moderate            | Steep                 | Gentle                | Steep (ownership)     |

The practical reading of that table:

- **Versus C**: the same class of performance and control, plus a package
  manager, a real module system, generics, and a compiler that rejects the
  memory bugs that dominate C's CVE record.
- **Versus C++**: a similar zero-cost abstraction story, but the safety rules are
  checked rather than conventional, and there is one blessed build and dependency
  system instead of several competing ones.
- **Versus Go**: Go optimizes for simplicity, fast builds, and quick onboarding,
  and its garbage collector is fine for the large majority of services. Rust wins
  where GC pauses or memory overhead are unacceptable, where latency must be
  predictable, or where there can be no runtime at all: kernels, firmware,
  WebAssembly, embedded targets.

```c
/* C: compiles cleanly, corrupts memory at runtime */
char *make_greeting(void) {
    char buf[16];
    sprintf(buf, "hello");
    return buf;          /* returns a pointer into a dead stack frame */
}
```

```rust
// Rust: the equivalent mistake does not compile
fn make_greeting() -> &str {   // error[E0106]: missing lifetime specifier
    let buf = String::from("hello");
    &buf                       // ...and E0515: cannot return a reference to
}                              // a local variable

// The fix is to return ownership instead of a borrow
fn make_greeting_fixed() -> String {
    String::from("hello")
}
```

> Key Takeaways
> - Rust matches C and C++ on performance and control while enforcing safety at
>   compile time rather than by convention.
> - Go and Rust are not rivals across the board: Go trades some performance and
>   determinism for simplicity and build speed.
> - Rust's tooling story — one compiler, one build tool, one registry — is a real
>   advantage over the C and C++ ecosystem.
> - The price is a steeper learning curve and slower compilation.

> 🧪 Practice
> 1. Take the dangling-pointer C snippet above and write down which Rust rule
>    catches each of its two problems.
> 2. Draft a one-paragraph recommendation for a team choosing between Go and
>    Rust for a high-throughput HTTP proxy, and name the deciding factor.
> 3. Interview: Name a project where you would still choose Go over Rust and
>    justify it in terms of engineering cost rather than language features.
>    (Hint: think about hiring, iteration speed, and whether GC pauses actually
>    violate the service's latency budget.)

<a id="12-toolchain-setup"></a>
### 1.2 Toolchain Setup

A Rust installation is not a single compiler but a managed set of toolchains,
components, and targets. Knowing how those pieces fit together saves hours of
confusion later, especially when a project needs a specific compiler version.

#### Installing with rustup

Rust is not installed from a system package manager in the usual workflow.
Instead you install `rustup`, the official toolchain manager, and let it install
compilers for you. The reason is that a single machine routinely needs several
compiler versions at once: the stable release for daily work, a pinned older
version to check a minimum supported version, and nightly for a crate that needs
an unstable feature.

`rustup` works the way `nvm` or `pyenv` do, but it is the officially supported
path rather than a third-party add-on. It installs two directories —
`~/.cargo` (binaries and the registry cache) and `~/.rustup` (the toolchains
themselves) — and puts *shims* on your `PATH`. A shim is a tiny executable named
`rustc` or `cargo` that decides which real toolchain to invoke based on the
current directory and your configuration, then forwards the arguments.

```text
you type:  cargo build
                |
                v
   ~/.cargo/bin/cargo   (shim, always the same file)
                |
                | which toolchain?  1. `cargo +nightly ...` override on the command line
                |                   2. rust-toolchain.toml in this directory tree
                |                   3. `rustup override` set for this directory
                |                   4. the default set by `rustup default`
                v
   ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo
```

```bash
# Unix-like systems: the official installer script
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Windows: download and run rustup-init.exe; it also needs the MSVC build tools
# (Visual Studio "Desktop development with C++") for the default msvc target.

rustc --version          # rustc 1.8x.0 (hash date)
cargo --version
rustup show              # installed toolchains, targets, and the active one

rustup update            # update every installed toolchain
rustup self update       # update rustup itself

rustup component add rustfmt clippy rust-src rust-analyzer
rustup target add wasm32-unknown-unknown       # cross-compilation target
rustup doc --book        # open the offline copy of "The Rust Programming Language"
```

Components are optional pieces of a toolchain (`clippy`, `rustfmt`, `rust-src`,
`llvm-tools`), while targets are platforms you can compile *for*. Both are added
per toolchain, so installing a new toolchain does not automatically carry your
components over.

> Key Takeaways
> - Install Rust through `rustup`, not a system package manager, so you can hold
>   multiple toolchains side by side.
> - `~/.cargo/bin` holds shims; the real compilers live in `~/.rustup/toolchains`.
> - Components (`clippy`, `rustfmt`) and targets (`wasm32-unknown-unknown`) are
>   added per toolchain.
> - `rustup update` refreshes toolchains; `rustup doc` gives you the whole
>   documentation set offline.

> 🧪 Practice
> 1. Run `rustup show` and identify your default toolchain, its host triple, and
>    every installed target.
> 2. Add the `clippy` and `rustfmt` components, then confirm `cargo clippy` and
>    `cargo fmt --version` both work.
> 3. Interview: How would you guarantee that CI compiles your project with
>    exactly the same compiler version a developer used locally? (Hint: there is
>    a file `rustup` looks for as it walks up the directory tree.)

#### Toolchains and Channels

Rust ships on a *train model* borrowed from Firefox. Every six weeks the current
state of the `master` branch becomes the new beta, and the previous beta becomes
stable. A feature therefore spends roughly twelve weeks soaking before it reaches
stable users, and the release date is fixed regardless of what is ready.

Three channels ride that train:

| Channel | Cadence            | Unstable features | Typical use                        |
| ------- | ------------------ | ----------------- | ---------------------------------- |
| stable  | Every 6 weeks      | No                | Everything you ship                |
| beta    | Every 6 weeks      | No                | CI canary to catch upcoming breakage |
| nightly | Every night        | Yes, via `#![feature(...)]` | Compiler development, unstable APIs, some tooling |

The stability promise applies to stable and beta: code that compiles today
should keep compiling. Unstable features are gated behind `#![feature(...)]`
attributes that only nightly accepts, which is how Rust avoids accidentally
committing to a half-finished design.

A toolchain is named `channel[-date][-host]`, for example `stable`,
`1.85.0`, or `nightly-2026-01-15-x86_64-unknown-linux-gnu`. Pinning a dated
nightly is common because nightly changes daily.

```bash
rustup default stable                 # machine-wide default
rustup toolchain install nightly      # add a channel
rustup toolchain install 1.85.0       # add an exact version
rustup override set nightly           # pin the current directory
cargo +nightly build                  # one-off: use nightly for this command
rustup run 1.85.0 cargo test          # equivalent, more explicit form
```

Prefer a checked-in `rust-toolchain.toml` over a machine-local override: it
travels with the repository, so every developer and every CI job resolves the
same compiler automatically.

```toml
# rust-toolchain.toml, committed at the repository root
[toolchain]
channel = "1.85.0"                    # or "stable" / "nightly-2026-01-15"
components = ["rustfmt", "clippy"]    # installed on demand when first used
targets = ["wasm32-unknown-unknown"]
profile = "minimal"                   # minimal | default | complete
```

Related but distinct is the *minimum supported Rust version* (MSRV), declared as
`rust-version` in `Cargo.toml`. It states the oldest compiler your crate promises
to build with, which matters to downstream users on conservative distributions.
Since Cargo 1.84 the resolver is MSRV-aware and will prefer dependency versions
compatible with that field rather than the newest release.

> Key Takeaways
> - Stable, beta, and nightly ride a six-week train; unstable features exist only
>   on nightly behind `#![feature(...)]`.
> - `+toolchain` syntax runs one command on another toolchain; overrides pin a
>   directory.
> - Commit `rust-toolchain.toml` so the compiler version is part of the
>   repository rather than of a developer's machine.
> - `rust-version` (MSRV) is a promise to downstream users, not a toolchain
>   selector.

> 🧪 Practice
> 1. Install nightly and print both versions with `cargo +nightly --version` and
>    `cargo --version`.
> 2. Add a `rust-toolchain.toml` pinning `stable` with the `clippy` component,
>    delete a local override, and confirm `rustup show` reports the pinned
>    toolchain as active.
> 3. Interview: Your library sets `rust-version = "1.70"`, but a dependency
>    requires 1.85. What actually breaks, for whom, and what are your options?
>    (Hint: think about who compiles your dependency tree and when.)

#### Compiling with rustc

Cargo is what you will use every day, but Cargo is a driver: it works out the
dependency graph and then invokes `rustc` once per crate with a long list of
flags. Calling `rustc` directly on a single file demystifies that layer and is
genuinely useful for minimal reproductions and quick experiments.

The unit `rustc` compiles is a *crate*, not a file. You hand it one root source
file; `mod` declarations pull in the rest of the crate's files, and the whole
crate is compiled as a single unit.

```bash
rustc main.rs                    # produces ./main (or main.exe on Windows)
                                 # defaults: opt-level 0, debug assertions on,
                                 # no debug info unless you pass -g

rustc --edition 2024 -O main.rs -o app   # optimized build, explicit output name
rustc -C opt-level=3 -C target-cpu=native main.rs
rustc --emit=llvm-ir main.rs     # also: asm, mir, metadata, obj, dep-info
rustc --test main.rs && ./main   # build the unit tests into a test runner
rustc --explain E0382            # long-form explanation of an error code
rustc --print cfg                # the cfg flags active for this target
```

The moment you need a dependency, the raw `rustc` workflow becomes painful: you
must compile each dependency yourself and thread `--extern name=path/to.rlib`
and `-L dependency=dir` flags through by hand, for the entire transitive graph.
That is precisely the job Cargo exists to do.

```bash
# What Cargo does for you, done manually for a single dependency
rustc --crate-type=lib --crate-name mylib src/lib.rs -o libmylib.rlib
rustc main.rs --extern mylib=libmylib.rlib -L .
```

> Key Takeaways
> - `rustc` compiles one crate at a time from a root source file; `mod` brings in
>   the rest.
> - Bare `rustc` is unoptimized with debug assertions on; `-O` or
>   `-C opt-level=3` opts into optimization.
> - `--emit` exposes LLVM IR, assembly, and MIR, and `--explain` expands any
>   error code.
> - Managing `--extern` and `-L` flags by hand for a dependency graph is the
>   problem Cargo solves.

> 🧪 Practice
> 1. Compile a single-file "hello world" with `rustc` and run the binary without
>    Cargo involved.
> 2. Build the same file twice, with and without `-O`, and compare the output of
>    `rustc --emit=asm` for a small arithmetic function.
> 3. Interview: If `rustc` can already compile a program, why does Cargo exist?
>    Name three responsibilities Cargo takes on. (Hint: think about transitive
>    dependencies, feature resolution, and reproducibility.)

#### Rust Playground

The Rust Playground (`play.rust-lang.org`) is an official browser sandbox that
compiles and runs snippets on the project's servers. It matters more than a
typical online REPL because it is the lingua franca of the Rust community: bug
reports, forum questions, and code review comments are routinely exchanged as
Playground permalinks, which guarantee that everyone is compiling exactly the
same code on exactly the same toolchain.

What it offers beyond running code:

- Switch between stable, beta, and nightly, and between debug and release.
- View the generated assembly, LLVM IR, MIR, or WebAssembly instead of running.
- Expand macros, and run `rustfmt`, Clippy, and Miri on the snippet.
- The roughly one hundred most-downloaded crates are preinstalled, so `serde`,
  `rand`, `regex`, and `itertools` are available without a manifest.
- "Share" produces a permanent link backed by a GitHub gist.

The constraints are equally worth knowing: no network access from the running
program, a short execution time limit, one file only, and no way to add an
arbitrary crate.

```rust
// A snippet shaped for sharing: self-contained, minimal, warnings silenced
#![allow(unused)]

use itertools::Itertools;      // preinstalled on the Playground

fn main() {
    let words = ["pear", "apple", "fig"];
    let joined = words.iter().sorted().join(", ");
    println!("{joined}");      // apple, fig, pear
}
```

> Key Takeaways
> - The Playground is the standard way to share a runnable reproduction with
>   other Rust programmers.
> - It can emit ASM, LLVM IR, MIR, and expanded macros, and can run Clippy and
>   Miri.
> - The top crates by download count are preinstalled; arbitrary crates are not.
> - No network, one file, and a time limit, so it suits snippets rather than
>   projects.

> 🧪 Practice
> 1. Run the snippet above on the Playground, switch to release mode, and view
>    the assembly output.
> 2. Write a snippet that fails to compile, then use the Playground's Clippy
>    button on a version that compiles but is unidiomatic.
> 3. Interview: You are filing a bug against a crate. Describe how you would
>    build a *minimal reproducible example* and why the maintainer will ask for
>    one. (Hint: think about what has to be eliminated before the bug is the only
>    thing left.)

#### IDE Support and rust-analyzer

`rust-analyzer` is the official Language Server Protocol implementation for
Rust, and it is what makes the language pleasant to write. Because Rust's type
inference is aggressive and many types are never spelled out, an editor that can
show inferred types and resolve trait methods is not a luxury.

It is worth understanding that `rust-analyzer` is *not* the compiler. It contains
its own incremental, error-tolerant front end so it can answer questions about
code that does not yet compile, which is the normal state of code while you are
typing. For authoritative diagnostics it shells out to `cargo check` on save.
That split explains the most common confusion: the editor can be quiet while
`cargo build` fails, usually because the two are configured with different
feature flags or targets.

What it provides: types on hover, inlay hints for inferred types and parameter
names, go-to-definition and find-references, rename across a crate, macro
expansion, run/debug buttons above tests, and code actions such as filling in
every match arm, importing a missing path, or generating a trait `impl` skeleton.

```json
// .vscode/settings.json - a solid starting configuration
{
  // Use Clippy instead of plain `cargo check` for on-save diagnostics
  "rust-analyzer.check.command": "clippy",

  // Analyze with all feature flags enabled so cfg-gated code is not invisible
  "rust-analyzer.cargo.features": "all",

  // Give rust-analyzer its own target directory so its `cargo check` does not
  // block your own `cargo run` on the build lock
  "rust-analyzer.cargo.targetDir": true,

  "editor.formatOnSave": true,
  "rust-analyzer.inlayHints.typeHints.enable": true
}
```

Alternatives exist — RustRover and the IntelliJ Rust plugin ship their own
analysis engine — but `rust-analyzer` is the reference implementation and works
in any LSP-capable editor: VS Code, Neovim, Helix, Emacs, Zed.

> Key Takeaways
> - `rust-analyzer` is the official LSP server and the default choice in every
>   editor except the JetBrains IDEs.
> - It has its own error-tolerant front end, so it answers questions about code
>   that does not compile yet, and delegates real diagnostics to `cargo check`.
> - Pointing `check.command` at `clippy` surfaces lints as you work.
> - A dedicated `targetDir` stops the editor's checks from fighting your own
>   builds for the target-directory lock.

> 🧪 Practice
> 1. Enable inlay type hints and write `let v = Vec::new();` followed by
>    `v.push(1u8);` to watch the inferred type appear.
> 2. Trigger the "fill match arms" code action on a `match` over an enum with
>    three variants.
> 3. Interview: Your editor reports no errors, but `cargo build` fails. Give two
>    plausible causes. (Hint: consider what `rust-analyzer` analyzes by default
>    versus what your build actually compiles — features, targets, and cfg.)

<a id="13-cargo-basics"></a>
### 1.3 Cargo Basics

Cargo is the build system, dependency manager, test runner, and publishing tool
in one binary. Almost every Rust project is a Cargo project, so its conventions
are effectively part of the language.

#### Creating a Package

Cargo starts from a *package*: a directory with a `Cargo.toml` manifest. It is
worth separating three words that get used loosely.

| Term    | What it is                                   | Boundary                  |
| ------- | -------------------------------------------- | ------------------------- |
| Package | A `Cargo.toml` plus its source tree          | The unit Cargo builds and publishes |
| Crate   | One compilation unit produced by `rustc`     | The unit of privacy and linkage |
| Module  | A namespace inside a crate (`mod`)           | The unit of organization  |

A package contains at most one library crate and any number of binary crates.
That is why `src/lib.rs` and `src/main.rs` have fixed meanings: they are *crate
roots*, the file `rustc` is pointed at.

```bash
cargo new hello              # binary package (src/main.rs), initializes git
cargo new mylib --lib        # library package (src/lib.rs)
cargo new tool --vcs none    # skip git initialization
cargo init                   # turn the current directory into a package
```

```text
hello/
├── Cargo.toml          manifest: name, version, edition, dependencies
├── Cargo.lock          generated: the exact resolved dependency versions
├── .gitignore          generated: ignores /target
├── src/
│   ├── main.rs         crate root of the binary  -> target/debug/hello
│   ├── lib.rs          crate root of the library (optional)
│   └── bin/
│       └── helper.rs   an extra binary          -> target/debug/helper
├── tests/              integration tests, each file its own crate
├── benches/            benchmarks
├── examples/           example programs, built by `cargo build --examples`
└── target/             all build output; never committed
```

```rust
// src/main.rs, exactly as `cargo new` generates it
fn main() {
    println!("Hello, world!");
}
```

These directory names are conventions Cargo knows about, not configuration you
must write. Dropping a file into `src/bin/` gives you a second binary with no
manifest changes at all.

> Key Takeaways
> - A package is a `Cargo.toml` and its sources; a crate is one compilation unit;
>   a module is a namespace inside a crate.
> - One package holds at most one library crate plus any number of binaries.
> - `src/main.rs` and `src/lib.rs` are crate roots by convention; `src/bin/*.rs`
>   adds more binaries for free.
> - `target/` is generated output and belongs in `.gitignore`.

> 🧪 Practice
> 1. Create a package with `cargo new`, run it, and locate the produced binary
>    inside `target/`.
> 2. Add a second binary under `src/bin/` and run it with
>    `cargo run --bin <name>`.
> 3. Interview: What is the difference between a package, a crate, and a module,
>    and which one is the unit of privacy? (Hint: think about what `pub` is
>    relative to, and what `rustc` is invoked on.)

#### Cargo.toml Manifest

`Cargo.toml` is the manifest: a TOML file describing the package's identity, its
dependencies, and how it should be built. You write it; Cargo reads it. Its
companion `Cargo.lock` is the opposite — Cargo writes it and you read it.

TOML itself is small: `key = value`, `[section]` tables, arrays in brackets, and
inline tables in braces. Cargo defines the sections.

```toml
[package]
name = "taskr"                 # crate name on crates.io; snake_case or kebab-case
version = "0.2.1"              # semantic version of this package
edition = "2024"               # language edition (see 1.1)
rust-version = "1.85"          # MSRV: oldest compiler this crate supports
description = "A tiny task runner."
license = "MIT OR Apache-2.0"  # SPDX expression; required to publish
repository = "https://github.com/example/taskr"
keywords = ["cli", "tasks"]
categories = ["command-line-utilities"]

[dependencies]                 # needed to build the library and binaries
serde = { version = "1.0", features = ["derive"] }
anyhow = "1.0"
regex = { version = "1", default-features = false, features = ["std"] }

[dev-dependencies]             # tests, examples, and benches only; not shipped
proptest = "1"

[build-dependencies]           # used by build.rs at build time only
cc = "1"

[features]                     # optional, compile-time switches
default = ["color"]
color = ["dep:owo-colors"]     # enabling `color` pulls in the optional crate

[profile.release]              # override built-in build profiles
lto = true                     # link-time optimization
codegen-units = 1              # slower build, faster binary

[[bin]]                        # explicit binary target (an array of tables)
name = "taskr"
path = "src/main.rs"
```

Two details catch newcomers. First, the `[[bin]]` double brackets denote an
array of tables, so repeat the block for each binary. Second, `dev-dependencies`
are invisible to consumers of your crate and are not compiled for a normal
`cargo build`, which makes them the right home for test-only helpers.

> Key Takeaways
> - You own `Cargo.toml`; Cargo owns `Cargo.lock`.
> - `[dependencies]`, `[dev-dependencies]`, and `[build-dependencies]` are
>   separate graphs with different lifetimes.
> - `license`, `description`, and `repository` are optional locally but required
>   or expected when publishing.
> - `[features]` are compile-time switches, and `[profile.*]` tunes optimization
>   settings per build profile.

> 🧪 Practice
> 1. Add `description`, `license`, and `repository` to a package and confirm
>    `cargo publish --dry-run` stops complaining about missing metadata.
> 2. Move a testing-only dependency from `[dependencies]` to `[dev-dependencies]`
>    and verify with `cargo tree` that it disappears from the normal build graph.
> 3. Interview: Why does Cargo separate `dev-dependencies` from `dependencies`
>    at all, given both are downloaded from the same registry? (Hint: think about
>    what a downstream consumer of your crate is forced to compile.)

#### Building and Running

Cargo exposes a small set of verbs, and the useful distinction between them is
how much work each one does.

| Command                | What it does                                      | Speed        |
| ---------------------- | ------------------------------------------------- | ------------ |
| `cargo check`          | Type-checks and borrow-checks; no code generation  | Fastest      |
| `cargo build`          | Full debug build to `target/debug/`                | Moderate     |
| `cargo build --release`| Optimized build to `target/release/`               | Slowest      |
| `cargo run`            | `build`, then execute the binary                   | Moderate     |
| `cargo test`           | Build test harnesses and run every test            | Moderate     |
| `cargo clean`          | Delete `target/` entirely                          | Instant      |

The `check`/`build` split matters in practice: code generation and linking
dominate build time, so the edit-compile-fix loop should run `cargo check` (or
let `rust-analyzer` run it for you) and only produce a binary when you actually
intend to run something.

```bash
cargo check                     # fastest feedback while writing code
cargo build                     # -> target/debug/taskr, unoptimized + debug info
cargo build --release           # -> target/release/taskr, opt-level 3
cargo run                       # build (debug) and run
cargo run --release             # build (release) and run
cargo run -- --verbose input.txt  # everything after `--` goes to YOUR program
cargo run --bin helper          # pick one binary when the package has several
cargo build --timings           # HTML report showing where build time went
RUST_BACKTRACE=1 cargo run      # print a backtrace if the program panics
```

The two profiles are genuinely different programs. Debug builds keep debug info,
skip optimization, and enable `debug_assertions`, which is what makes integer
overflow panic rather than wrap. Release builds optimize at level 3 and disable
those assertions. Never benchmark a debug build; the difference is routinely ten
to a hundred times.

| Profile   | Optimization | Debug info | `debug_assertions` | Overflow behavior |
| --------- | ------------ | ---------- | ------------------ | ----------------- |
| `dev`     | `opt-level=0`| Yes        | On                 | Panics            |
| `release` | `opt-level=3`| No         | Off                | Wraps             |

> Key Takeaways
> - `cargo check` skips code generation and is the right command for the inner
>   development loop.
> - Debug and release are different builds: assertions, overflow behavior, and
>   speed all change.
> - Arguments after `--` are passed to your program, not to Cargo.
> - Always measure performance on `--release`.

> 🧪 Practice
> 1. Time `cargo check` against `cargo build` on the same project and note the
>    ratio.
> 2. Write a program that adds 1 to `u8::MAX` and run it in both profiles. Explain
>    the different outcomes.
> 3. Interview: A teammate reports that a change "made the program 50x slower"
>    but their measurement came from `cargo run`. What is the first question you
>    ask? (Hint: look at the profile table above.)

#### Cargo.lock and Reproducible Builds

`Cargo.toml` states *requirements* ("any 1.x version of serde"), while
`Cargo.lock` records the *resolution* ("serde 1.0.219, with this checksum"). The
separation is what lets a crate accept compatible upgrades in principle while
building the exact same bytes in practice.

Version requirements use SemVer, with the caret operator implied when you write
a bare version string. Rust treats a leading zero as significant, so `0.x`
releases get stricter treatment.

| Requirement | Means                    | Matches            | Rejects  |
| ----------- | ------------------------ | ------------------ | -------- |
| `"1.2.3"`   | `^1.2.3`, the default    | `>=1.2.3, <2.0.0`  | `2.0.0`  |
| `"^0.2.3"`  | Caret on a `0.x` version | `>=0.2.3, <0.3.0`  | `0.3.0`  |
| `"~1.2.3"`  | Patch updates only       | `>=1.2.3, <1.3.0`  | `1.3.0`  |
| `"1.2.*"`   | Wildcard                 | `>=1.2.0, <1.3.0`  | `1.3.0`  |
| `"=1.2.3"`  | Exactly that version     | `1.2.3`            | Everything else |

```bash
cargo build                       # creates or updates Cargo.lock as needed
cargo update                      # re-resolve everything within the requirements
cargo update -p serde             # re-resolve one package only
cargo update -p serde --precise 1.0.200   # pin one package to an exact version

cargo build --locked              # fail if Cargo.lock would have to change
cargo build --offline             # use only already-downloaded crates
cargo vendor                      # copy all dependency sources into vendor/
```

`--locked` is the flag that turns "we have a lockfile" into an actual guarantee.
Without it, CI will happily rewrite the lockfile when the manifest and lockfile
disagree, which quietly defeats the purpose; with it, the build fails and tells
you to update the lockfile deliberately.

Commit `Cargo.lock` for binaries and applications, always: you want the shipped
artifact to be reproducible. For libraries the lockfile is ignored by anyone who
depends on you — their resolution wins — but current guidance is to commit it
anyway, because it makes *your own* CI runs deterministic and turns a broken
upstream release into a deliberate update rather than a random red build.

> Key Takeaways
> - `Cargo.toml` holds requirements; `Cargo.lock` holds the exact resolved
>   versions and checksums.
> - A bare version string means a caret requirement, and `0.x` versions treat the
>   minor number as the breaking-change position.
> - Commit `Cargo.lock` and build CI with `--locked` to get reproducible builds.
> - A library's lockfile does not affect its downstream consumers.

> 🧪 Practice
> 1. Add a dependency, inspect the `Cargo.lock` entry it produced, and note the
>    checksum field.
> 2. Loosen a requirement to `"*"`, run `cargo update`, and observe what changes
>    in the lockfile.
> 3. Interview: Your CI passed yesterday and fails today with no commits in
>    between. How could dependency resolution cause that, and which flag prevents
>    it? (Hint: think about what happens when a transitive dependency publishes a
>    new patch release.)

#### Dependencies from crates.io

`crates.io` is the community registry, and Cargo talks to it by default. Adding a
dependency is a one-line command, which is precisely why dependency hygiene
matters: every crate you add is code you ship and code you are trusting.

```bash
cargo add serde --features derive    # edits Cargo.toml and resolves the version
cargo add serde_json
cargo add --dev proptest             # into [dev-dependencies]
cargo add tokio --no-default-features --features rt,macros
cargo remove regex

cargo tree                           # print the dependency graph
cargo tree -d                        # find duplicate versions of the same crate
cargo tree -i serde                  # who pulls serde in? (inverted view)
```

Dependencies do not have to come from the registry. All three forms below are
interchangeable at the call site, which makes local development against an
unpublished fork straightforward.

```toml
[dependencies]
serde = "1.0"                                              # registry
mylib = { path = "../mylib" }                              # local path
patched = { git = "https://github.com/me/patched", branch = "fix" }
```

Two behaviors are worth knowing early. *Feature unification*: if two crates in
your graph depend on `serde` with different features, Cargo compiles one `serde`
with the union of those features. And *duplicate versions*: if one crate needs
`rand 0.8` and another `rand 0.9`, Cargo compiles both, since they are
semver-incompatible — types from the two are distinct and will not interoperate,
which produces confusing type errors that `cargo tree -d` diagnoses instantly.

```toml
[dependencies]
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
```

```rust
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]  // derive macros come from the feature
struct Config {
    name: String,
    retries: u8,
}

fn main() -> Result<(), serde_json::Error> {
    let raw = r#"{"name":"api","retries":3}"#;    // raw string: no escaping
    let cfg: Config = serde_json::from_str(raw)?; // `?` propagates parse errors
    println!("{cfg:?}");                          // Config { name: "api", retries: 3 }
    println!("{}", serde_json::to_string(&cfg)?); // {"name":"api","retries":3}
    Ok(())
}
```

Every published crate gets rendered documentation at `docs.rs/<crate>`, built
from the same source, which is the first place to look before reading a README.

> Key Takeaways
> - `cargo add` edits the manifest for you, including features and dev-only
>   dependencies.
> - Dependencies can come from the registry, a path, or a git repository, with
>   identical usage in code.
> - Features are unified across the graph; semver-incompatible versions of one
>   crate coexist as separate compiled crates.
> - `cargo tree` answers "why is this here" and "why do I have two of these".

> 🧪 Practice
> 1. Add `serde` and `serde_json`, then build and run the example above.
> 2. Run `cargo tree` on a project with three or more dependencies and find one
>    crate that no line in your `Cargo.toml` mentions.
> 3. Interview: A build fails with "expected struct `rand::rngs::ThreadRng`,
>    found struct `rand::rngs::ThreadRng`" — the same name twice. What is
>    happening, and which command confirms it? (Hint: two crates in the graph
>    asked for incompatible major versions.)

<a id="14-program-structure"></a>
### 1.4 Program Structure

With the toolchain in place, the last foundation is the anatomy of a Rust
program: where execution starts, how expressions differ from statements, how code
is documented, how output is produced, and how to read what the compiler tells
you.

#### The main Function

Every executable crate starts at `fn main`. It takes no parameters — command-line
arguments are read from `std::env::args` rather than passed in, so that any part
of the program can reach them — and its return type is not limited to `()`.

Rust models the exit status through the `Termination` trait, which a handful of
standard types implement. Returning `Result` from `main` is the idiomatic way to
write a small program that can fail: the `?` operator becomes usable at the top
level, and an `Err` is printed with its `Debug` representation before the process
exits with a failure status.

```rust
use std::error::Error;
use std::fs;

// Box<dyn Error> accepts any error type, so `?` works across different failures
fn main() -> Result<(), Box<dyn Error>> {
    let args: Vec<String> = std::env::args().collect();
    // args[0] is the program's own path; real arguments start at index 1
    let path = args.get(1).ok_or("usage: wordcount <file>")?;

    let text = fs::read_to_string(path)?;   // io::Error converts into Box<dyn Error>
    println!("{} words", text.split_whitespace().count());
    Ok(())                                   // exit status 0
}
// On Err, Rust prints `Error: <Debug of the error>` to stderr and exits with 1.
```

When you need control over the exact status code, return `ExitCode` instead:

```rust
use std::process::ExitCode;

fn main() -> ExitCode {
    match run() {
        Ok(()) => ExitCode::SUCCESS,       // 0
        Err(e) => {
            eprintln!("error: {e}");       // your own message, your own format
            ExitCode::from(2)              // any u8 you like
        }
    }
}

fn run() -> Result<(), String> {
    Err("no configuration found".to_string())
}
```

| `main` return type      | Exit status on failure | Error output                |
| ----------------------- | ---------------------- | --------------------------- |
| `()`                    | Always 0 (or panic)    | None                        |
| `Result<(), E: Debug>`  | 1                      | `Error: {e:?}` on stderr    |
| `ExitCode`              | Whatever you return    | Whatever you print          |

`std::process::exit(code)` terminates immediately from anywhere, but it skips
every pending destructor, so buffered output can be lost. Prefer returning from
`main`.

> Key Takeaways
> - `main` takes no arguments; use `std::env::args` to read them.
> - `main` may return `()`, a `Result` whose error is `Debug`, or an `ExitCode`.
> - Returning `Result` unlocks `?` at the top level and prints the error with
>   `Debug`, so error types should have a readable `Debug` output.
> - `std::process::exit` bypasses destructors; returning from `main` does not.

> 🧪 Practice
> 1. Write a program that reads a filename from the command line and prints the
>    file's line count, returning `Result<(), Box<dyn Error>>`.
> 2. Change it to return `ExitCode` and exit with status 3 when the file is
>    missing. Verify with `echo $?` (or `$LASTEXITCODE` in PowerShell).
> 3. Interview: Why does a `Result`-returning `main` print the error with `Debug`
>    rather than `Display`? (Hint: consider which trait the standard library can
>    require of every error type, and what a developer needs to see.)

#### Statements vs Expressions

Rust is an *expression-oriented* language, and internalizing that early removes a
whole category of confusion. An expression evaluates to a value; a statement does
not. Rust has only two real statement forms — item declarations (`fn`, `struct`,
`use`) and `let` bindings — and almost everything else is an expression.

That includes constructs that are statements in C-family languages. A block
`{ ... }` is an expression that evaluates to its final expression. `if`, `match`,
and `loop` are expressions too, which is why Rust has no ternary operator: `if`
already returns a value.

The semicolon is the operator that turns an expression into a statement by
discarding its value and yielding the unit type `()`. That is the single most
common early mistake: adding a semicolon after a function's final expression
turns "return this value" into "return nothing".

```rust
fn add(a: i32, b: i32) -> i32 {
    a + b        // tail expression = return value. Writing `a + b;` here gives
                 // error[E0308]: expected `i32`, found `()`
}

fn main() {
    let y = {
        let a = 3;
        a + 1        // no semicolon, so the block evaluates to 4
    };

    // `if` is an expression, so it can initialize a binding directly
    let label = if y % 2 == 0 { "even" } else { "odd" };
    println!("{y} is {label}");           // 4 is even

    // `match` is an expression as well; every arm must yield the same type
    let size = match y {
        0 => "zero",
        1..=9 => "small",
        _ => "large",
    };
    println!("{size}");                   // small

    // `loop` is an expression: `break` can carry a value out of it
    let mut n = 1;
    let doubled_past_ten = loop {
        n *= 2;
        if n > 10 {
            break n;                      // 1 -> 2 -> 4 -> 8 -> 16, so 16
        }
    };
    println!("{doubled_past_ten}");       // 16
}
```

| Construct        | Statement or expression | Value it produces               |
| ---------------- | ----------------------- | ------------------------------- |
| `let x = 5;`     | Statement               | None                            |
| `fn f() {}`      | Statement (item)        | None                            |
| `x + 1`          | Expression              | The sum                         |
| `{ ...; tail }`  | Expression              | The tail expression's value     |
| `{ ...; tail; }` | Expression              | `()` because of the semicolon   |
| `if c { a } else { b }` | Expression       | `a` or `b` (same type required) |
| `match v { ... }`| Expression              | The chosen arm's value          |
| `loop { break v }`| Expression             | The value passed to `break`     |

> Key Takeaways
> - Only `let` bindings and item declarations are statements; nearly everything
>   else is an expression.
> - A block evaluates to its tail expression, so a semicolon there changes the
>   result to `()`.
> - `if`, `match`, and `loop` produce values, which is why Rust needs no ternary
>   operator.
> - `error[E0308]: expected X, found ()` almost always means a stray semicolon.

> 🧪 Practice
> 1. Rewrite a function that uses `return` in every branch so it ends in a single
>    `match` expression instead.
> 2. Write a `let` binding whose value comes from a block that computes an
>    intermediate variable, then discards it.
> 3. Interview: Why can Rust get away without a ternary operator, and what
>    constraint does making `if` an expression impose on its branches? (Hint:
>    think about what type the whole expression must have.)

#### Comments and Doc Comments

Rust distinguishes comments meant for the reader of the source from comments
meant for the reader of the *documentation*. The second kind, doc comments, are
Markdown, are compiled into HTML by `rustdoc`, and — the part that surprises
newcomers — their code examples are compiled and executed by `cargo test`.

That last property makes documentation examples an unusual asset: they cannot rot
silently. If you rename a function, its documented examples stop compiling and
your test suite goes red.

| Syntax     | Name                | Documents                              |
| ---------- | ------------------- | -------------------------------------- |
| `//`       | Line comment        | Nothing; ignored entirely              |
| `/* */`    | Block comment       | Nothing; nests correctly in Rust       |
| `///`      | Outer doc comment   | The item that follows it               |
| `//!`      | Inner doc comment   | The enclosing item (crate or module)   |

```rust
//! Temperature conversion helpers.
//!
//! This inner doc comment documents the *containing* item, so at the top of
//! `src/lib.rs` it becomes the crate's front page.

/// Converts Celsius to Fahrenheit.
///
/// # Examples
///
/// ```
/// use tempconv::c_to_f;
/// assert_eq!(c_to_f(100.0), 212.0);   // 100 * 9/5 + 32 = 180 + 32 = 212
/// assert_eq!(c_to_f(0.0), 32.0);
/// ```
///
/// # Panics
///
/// Never panics. Section headings like `# Panics`, `# Errors`, and `# Safety`
/// are a strong convention that rustdoc renders as headings.
pub fn c_to_f(celsius: f64) -> f64 {
    celsius * 9.0 / 5.0 + 32.0
}

/* Block comments /* nest properly */, which makes commenting out a region
   containing other block comments safe. */
```

```bash
cargo doc --open        # build this crate's docs (and its dependencies') and open
cargo test              # runs unit tests, integration tests, AND doc tests
cargo test --doc        # doc tests only
```

Doc tests run only for library targets, so examples in a binary-only crate are
checked for nothing. That is one practical argument for splitting real logic into
`src/lib.rs` and leaving `src/main.rs` as a thin wrapper.

> Key Takeaways
> - `///` documents the following item; `//!` documents the enclosing one, which
>   is how crate-level docs are written.
> - Doc comments are Markdown and are rendered by `rustdoc` into HTML.
> - Code blocks inside doc comments are compiled and run by `cargo test`, so
>   examples stay correct.
> - Doc tests only run for library crates, so put testable logic in `lib.rs`.

> 🧪 Practice
> 1. Add a `///` doc comment with a working `# Examples` block to a public
>    function, then run `cargo test` and watch the doc test execute.
> 2. Break the example deliberately (change the expected value) and confirm the
>    test suite fails.
> 3. Interview: Why does Rust execute the examples in documentation, and what
>    failure mode does that prevent? (Hint: think about what happens to sample
>    code in a README after two years of refactoring.)

#### Formatted Printing Macros

Printing in Rust goes through macros rather than functions, because the format
string is parsed *at compile time*. That is why `println!("{}", x)` with a
mismatched argument count is a compile error rather than a runtime surprise, and
why the format string must be a literal and cannot be a runtime variable.

The family is small and regular:

| Macro                | Destination            | Notes                            |
| -------------------- | ---------------------- | -------------------------------- |
| `print!` / `println!`| stdout                 | Line-buffered                    |
| `eprint!`/`eprintln!`| stderr                 | Unbuffered; for logs and errors  |
| `format!`            | A new `String`         | Same syntax, returns instead of prints |
| `write!`/`writeln!`  | Any `fmt::Write`/`io::Write` | Used inside `Display` impls |
| `panic!`             | Aborts with a message  | Same format syntax               |

Placeholders select a trait: `{}` uses `Display` (a human-facing rendering that
you implement yourself) and `{:?}` uses `Debug` (a developer-facing rendering
that `#[derive(Debug)]` writes for you). Primitive types implement both; your own
structs implement neither until you say so.

```rust
#[derive(Debug)]          // gives `{:?}`; `{}` would still be a compile error
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let p = Point { x: 3, y: -7 };
    let pi = 3.14159_f64;

    println!("{p:?}");              // Point { x: 3, y: -7 }
    println!("{p:#?}");             // the same, pretty-printed over four lines

    println!("{pi:.2}");            // 3.14        - precision 2
    println!("[{:>8.2}]", pi);      // [    3.14]  - width 8, right-aligned
    println!("[{:<8.2}]", pi);      // [3.14    ]  - left-aligned
    println!("[{:^8.2}]", pi);      // [  3.14  ]  - centered
    println!("[{:08.3}]", pi);      // [0003.142]  - zero-padded to width 8

    println!("{:b} {:o} {:#x}", 10, 10, 255);  // 1010 12 0xff
    println!("{0} {1} {0}", "a", "b");         // a b a       - positional
    println!("{name} is {age}", name = "Ada", age = 36);
    println!("{{literal braces}}");            // {literal braces}

    let s = format!("{}-{}", p.x, p.y);        // builds a String: "3--7"
    println!("{s}");
    eprintln!("warning: this line goes to stderr");
}
```

Since Rust 1.58 you can name a variable directly inside the braces
(`println!("{pi:.2}")`), which is now the preferred style for simple cases;
positional and named arguments remain for expressions and repeated use.

One performance note for later: `println!` acquires a lock on stdout for every
call, so printing inside a hot loop is slow. Lock once and use `writeln!`:

```rust
use std::io::{self, Write};

fn main() -> io::Result<()> {
    let stdout = io::stdout();
    let mut out = stdout.lock();      // lock once instead of once per line
    for i in 0..5 {
        writeln!(out, "line {i}")?;   // `?` because writing can fail
    }
    Ok(())
}
```

> Key Takeaways
> - Printing macros parse their format string at compile time, so argument
>   mismatches fail to build and the string must be a literal.
> - `{}` requires `Display` (hand-written); `{:?}` requires `Debug` (usually
>   derived); `{:#?}` pretty-prints.
> - Format specs cover fill, alignment, width, precision, sign, and radix, in
>   the order `{:[fill][align][sign][#][0][width][.precision][type]}`.
> - `eprintln!` writes to stderr; lock stdout and use `writeln!` in hot loops.

> 🧪 Practice
> 1. Derive `Debug` on a struct with three fields and print it with `{:?}` and
>    `{:#?}`. Compare the output.
> 2. Print a table of three rows where a name is left-aligned in 12 columns and a
>    price is right-aligned in 8 columns with two decimals.
> 3. Interview: Why must the format string be a literal rather than a `String`
>    variable, and what does that buy you? (Hint: think about when the macro's
>    expansion happens and what it can check.)

#### Compiler Errors and Warnings

Rust's compiler is unusually chatty by design: diagnostics are treated as a
teaching interface, not as an obstacle. Learning to read them in a fixed order
turns most errors into a mechanical fix.

Every diagnostic has the same anatomy: a severity and error code, a message, a
primary span with a caret under the offending code, labels explaining each
highlighted region, and often `note:` (why the rule exists) and `help:`
(a concrete suggestion, sometimes as a ready-to-apply patch).

```text
error[E0308]: mismatched types
 --> src/main.rs:2:18
  |
2 |     let n: i32 = "42";
  |            ---   ^^^^ expected `i32`, found `&str`
  |            |
  |            expected due to this
  |
help: try parsing the string into an integer
  |
2 |     let n: i32 = "42".parse().unwrap();
  |                       +++++++++++++++++

For more information about this error, try `rustc --explain E0308`.
```

Read it as: *what* rule was broken (the message), *where* (the span), *why* the
compiler expected what it did (the labels), and *what to try* (the help). When
the help is not enough, `rustc --explain E0308` prints a page-long explanation
with worked examples, and `cargo clippy` adds several hundred lints beyond
correctness — idiom, performance, and pitfall warnings.

| Code    | Meaning                                    | Usual fix                     |
| ------- | ------------------------------------------ | ----------------------------- |
| `E0308` | Mismatched types                           | Convert, or remove a stray `;` |
| `E0382` | Use of a moved value                       | Borrow, `clone`, or restructure |
| `E0499` | Two mutable borrows at once                | Shorten one borrow's scope    |
| `E0502` | Mutable and immutable borrow overlap       | Finish reading before writing |
| `E0106` | Missing lifetime specifier                 | Return owned data or annotate |
| `E0425` | Cannot find value in this scope            | Typo, or a missing `use`      |

Warnings deserve the same attention. Unused variables, unused `mut`, dead code,
and unused `Result` values are all warned about by default, and each usually
signals a real mistake. Prefix a deliberately unused binding with `_` to silence
it honestly rather than suppressing the lint.

```rust
fn main() {
    let _unused = 5;              // `_` prefix: intentionally unused, no warning

    #[allow(dead_code)]           // scoped, documented exception
    fn helper() {}

    let mut v = vec![1, 2, 3];    // warning: variable does not need to be mutable
    println!("{}", v.len());      // ...because nothing here mutates `v`
    v.push(4);                    // adding this line removes the warning
}
```

Lint levels are `allow`, `warn`, `deny`, and `forbid` (which cannot be
re-allowed). Set them per item with attributes, or crate-wide in the manifest:

```toml
[lints.rust]
unsafe_code = "forbid"
unused_must_use = "deny"

[lints.clippy]
unwrap_used = "warn"
```

In CI, `cargo clippy --all-targets -- -D warnings` promotes every warning to an
error so nothing accumulates.

> Key Takeaways
> - Read diagnostics in order: message, span, labels, note, help — the fix is
>   usually in the help.
> - `rustc --explain E0XXX` gives the long-form explanation of any error code.
> - Warnings are real signals; silence an intentional one with a `_` prefix or a
>   scoped `#[allow]`, not by ignoring the output.
> - Configure lint levels crate-wide in `[lints]`, and run
>   `clippy -- -D warnings` in CI.

> 🧪 Practice
> 1. Write code that triggers `E0308` by adding a semicolon to a function's tail
>    expression, then read the diagnostic and fix it.
> 2. Run `rustc --explain E0382` and summarize the explanation in two sentences.
> 3. Interview: `deny` and `forbid` both turn a lint into an error. What is the
>    difference, and when would you reach for `forbid`? (Hint: think about
>    whether a module deeper in the crate can override the decision.)

---

## 2. Core Language Syntax

This chapter covers the everyday grammar of Rust: how values are bound to names,
what the primitive types are and how they behave at their edges, how control flow
composes as expressions, and how functions are declared. None of it requires
ownership yet, but every choice here — immutability by default, explicit
conversions, exhaustive control flow — exists because of the safety model the
next chapter introduces.

<a id="21-variables-and-mutability"></a>
### 2.1 Variables and Mutability

Rust inverts the default that most languages use: a binding cannot be changed
unless you say so. This section covers the four ways to name a value and the
rules that separate them.

#### let Bindings

A `let` binding attaches a name to a value. The surprise for newcomers is that
the binding is *immutable* by default: once `let x = 5;` runs, `x` cannot be
reassigned.

The reason is not moral discipline about mutation. It is that immutability makes
two hard problems easy. For the reader, a name that never changes can be
understood once and then trusted throughout the function. For the compiler,
knowing a value never changes enables aggressive optimization and, more
importantly, feeds directly into the ownership rules of Chapter 3, where the
question "can this value change while someone else is looking at it?" decides
whether a program is accepted at all.

Think of `let` as writing in pen. You can start a new line with a new pen
(shadowing, below), or you can explicitly reach for a pencil (`mut`), but you
cannot quietly erase what you wrote.

A `let` also takes a *pattern* on the left, not merely a name, so destructuring
works anywhere a binding does. And a binding may be declared without a value, as
long as the compiler can prove it is initialized on every path before first use.

```rust
fn main() {
    let x = 5;              // type inferred as i32
    // x = 6;               // error[E0384]: cannot assign twice to immutable
                            //               variable `x`

    let y: u64 = 5;         // explicit annotation when inference needs help

    let (a, b) = (1, 2);    // the left side is a pattern: destructuring
    let [first, .., last] = [10, 20, 30, 40];   // array pattern with a gap
    println!("{x} {y} {a} {b} {first} {last}"); // 5 5 1 2 10 40

    // Deferred initialization: legal because every path assigns before use
    let label;
    if x > 3 {
        label = "big";
    } else {
        label = "small";
    }
    println!("{label}");    // big

    // Idiomatic alternative: `if` is an expression, so bind the result directly
    let label2 = if x > 3 { "big" } else { "small" };
    println!("{label2}");
}
```

> Key Takeaways
> - `let` bindings are immutable by default; reassigning one is `E0384`.
> - Immutability is the input to the borrow checker, not just a style preference.
> - The left-hand side of `let` is a pattern, so destructuring works everywhere.
> - Deferred initialization is allowed when the compiler can prove every path
>   assigns before the first read.

> 🧪 Practice
> 1. Bind a tuple of three values in one `let` and print each element by its
>    destructured name.
> 2. Write a `let` with deferred initialization inside a `match`, then rewrite it
>    as a single binding using `match` as an expression.
> 3. Interview: Why would a language make immutability the default when most of
>    its competitors do the opposite? Give one benefit for the reader and one for
>    the compiler. (Hint: think about what changes when two parts of a program can
>    see the same value.)

#### Mutability with mut

When a value genuinely needs to change, `mut` opts in. The keyword is worth
looking at precisely: `mut` is part of the *binding*, not part of the type.
`let mut x: i32` and `let x: i32` have the same type, `i32`; what differs is
whether the name may be reassigned or mutated through.

That distinction matters because `mut` shows up in three places with related but
distinct meanings: on a binding, on a reference (`&mut T`, where it *is* part of
the type), and in a pattern (`|mut v|`, binding by mutable value).

Explicit mutability is a communication tool. When you read a function signature
taking `&mut self`, you know before reading the body that it can modify the
receiver. When you read `let x = ...` with no `mut`, you know that line is the
whole story for `x`.

```rust
fn main() {
    let mut count = 0;      // opt in to change
    count += 1;             // mutation through the binding
    println!("{count}");    // 1
    count = 10;             // outright reassignment
    println!("{count}");    // 10

    let mut v = vec![1, 2, 3];
    v.push(4);              // mutating a value requires a mutable binding
    println!("{v:?}");      // [1, 2, 3, 4]

    // `mut` on a binding vs `&mut` in a type
    let mut n = 5;
    let r: &mut i32 = &mut n;   // `&mut i32` IS a distinct type
    *r += 1;                    // mutate through the reference
    println!("{n}");            // 6

    let unused = 1;
    println!("{unused}");
    // let mut never_mutated = 1;   // warning: variable does not need to be
                                    // mutable — the compiler tells you when
                                    // `mut` is noise
}
```

| Form           | Where `mut` lives | Meaning                                 |
| -------------- | ----------------- | --------------------------------------- |
| `let mut x`    | The binding       | `x` may be reassigned or mutated        |
| `&mut T`       | The type          | Exclusive reference permitting mutation |
| `fn f(mut v: V)`| The parameter binding | The local copy may be mutated      |
| `|mut acc| ...`| The closure pattern | The bound value may be mutated        |

> Key Takeaways
> - `mut` on a binding is not part of the type; `&mut T` is a different type from
>   `&T`.
> - Mutation of a value and reassignment of a binding both require `mut`.
> - The `unused_mut` warning flags `mut` that no longer earns its place.
> - Explicit mutability documents intent at every call site and signature.

> 🧪 Practice
> 1. Write a loop that accumulates a sum into a `mut` variable, then rewrite it
>    with `.sum()` and no `mut` at all.
> 2. Write a function taking `&mut Vec<i32>` that pushes an element, and call it
>    from `main`.
> 3. Interview: `let mut x = 5;` and `let x = &mut y;` both contain `mut`. Explain
>    the difference in what each one makes mutable. (Hint: one is a property of a
>    name, the other of a type.)

#### Shadowing

Shadowing is declaring a *new* binding with an existing name. The old value is
not modified or destroyed; it is simply no longer reachable by that name for the
rest of the scope.

This is not a workaround for immutability. It solves a different problem: a value
that is conceptually "the same thing" passing through stages of refinement, often
changing type as it goes. Reading a string from input, trimming it, then parsing
it to a number produces three different types that all deserve the name `input`.
Inventing `input_str`, `input_trimmed`, and `input_num` is noise, and reusing one
`mut` variable is impossible because the types differ.

The mental model: shadowing puts a new sheet of paper on top of the old one. The
old sheet still exists underneath (and, importantly, still owns its data until
its scope ends), but the name now refers to the top sheet.

```rust
fn main() {
    let spaces = "   ";              // &str
    let spaces = spaces.len();       // usize — a NEW binding, type changed
    println!("{spaces}");            // 3

    // let mut spaces = "   ";
    // spaces = spaces.len();        // error[E0308]: mismatched types
                                     // `mut` cannot change a binding's type

    let x = 5;
    let x = x + 1;                   // 6, shadows the previous `x`
    {
        let x = x * 2;               // 12, shadows only inside this block
        println!("inner: {x}");      // inner: 12
    }
    println!("outer: {x}");          // outer: 6 — the inner shadow is gone

    // The idiomatic use: refine a value through stages
    let raw = "  42  ";
    let raw = raw.trim();            // &str
    let raw: i32 = raw.parse().unwrap();  // i32
    println!("{}", raw + 1);         // 43
}
```

| Aspect                | `mut`                       | Shadowing                    |
| --------------------- | --------------------------- | ---------------------------- |
| Creates a new binding | No                          | Yes                          |
| Can change the type   | No                          | Yes                          |
| Scope                 | The original binding's      | Until the end of the current scope |
| Result stays immutable| No                          | Yes, unless you write `mut` again |
| Typical use           | Accumulators, counters      | Type refinement, parsing stages |

> Key Takeaways
> - Shadowing creates a new binding that reuses a name; it does not mutate the
>   old one.
> - Unlike `mut`, shadowing may change the type.
> - A shadow introduced inside a block disappears when that block ends.
> - Prefer shadowing for staged transformations, `mut` for values that genuinely
>   change over time.

> 🧪 Practice
> 1. Read a `&str` literal `"  7 "`, shadow it twice to trim and parse it, and
>    print the number doubled.
> 2. Write a block that shadows an outer variable, prints both values, and shows
>    the outer value is unchanged afterwards.
> 3. Interview: When would shadowing be the wrong choice, and how could it hide a
>    bug? (Hint: think about a long function where a name silently means something
>    different after line 40.)

#### Constants

A `const` is a named compile-time value. It is not a variable at all: there is no
storage for it in the usual sense. The compiler substitutes the value into every
place the name appears, the way a text macro would, but with full type checking.

Three rules follow from that. The type annotation is mandatory, because there is
no initializer expression to infer from at each use site. The value must be
computable at compile time, so no heap allocation, no reading a file, no calling
an arbitrary function (only a `const fn`). And a `const` may be declared in any
scope, including inside a function or an `impl` block, with the convention that
names are `SCREAMING_SNAKE_CASE`.

```rust
const MAX_RETRIES: u32 = 3;                     // module scope
const TIMEOUT_MS: u64 = 30 * 1_000;             // arithmetic is fine
const GREETING: &str = "hello";                 // &'static str is allowed

const fn square(n: u32) -> u32 {
    n * n
}
const GRID_CELLS: u32 = square(8);              // const fn call: 64

struct Circle;
impl Circle {
    const SIDES: u32 = 0;                       // associated constant
}

fn main() {
    const LOCAL_LIMIT: usize = 16;              // constants can be function-local
    let buffer = [0u8; LOCAL_LIMIT];            // usable where a constant is
                                                // required, e.g. an array length
    println!("{MAX_RETRIES} {TIMEOUT_MS} {GREETING} {GRID_CELLS}");
    println!("{} {}", Circle::SIDES, buffer.len());   // 0 16
}
```

Because a `const` is inlined at each use, two references to the same constant are
not guaranteed to have the same address. If you need one shared location in
memory, that is what `static` is for.

> Key Takeaways
> - `const` requires an explicit type and a value computable at compile time.
> - Constants are inlined at every use site, so they have no single address.
> - They may be declared at module scope, inside functions, or as associated
>   constants in an `impl`.
> - Only `const fn` calls are permitted in a constant's initializer.

> 🧪 Practice
> 1. Define a `const` array length and use it to declare an array, then print the
>    array's length.
> 2. Write a `const fn` that computes a value and use it to initialize a `const`.
> 3. Interview: Why does `const` require a type annotation when `let` does not?
>    (Hint: think about where the value physically ends up after compilation.)

#### Static Variables

A `static` also names a compile-time value, but unlike `const` it designates a
single memory location that exists for the entire run of the program. Its
lifetime is `'static`, and a reference to it can be handed around freely.

The practical distinction is address identity. Use `const` for a value (a limit,
a string, a conversion factor); use `static` when the *location* matters — a
large lookup table you do not want duplicated at every use site, a global counter,
or something whose address is passed to C code.

Then there is `static mut`, the closest thing Rust has to a classic global
variable, and the reason it is discouraged. A mutable global is reachable from
every thread with no synchronization, which is exactly the data race the language
exists to prevent, so every access requires `unsafe`. Edition 2024 goes further
and rejects even creating a reference to one — including the implicit reference a
`println!` argument takes.

```rust
use std::sync::LazyLock;
use std::sync::atomic::{AtomicU32, Ordering};

static PROGRAM_NAME: &str = "taskr";            // one location, 'static lifetime

// A global counter, done safely: atomics need no `unsafe` and no lock
static REQUESTS: AtomicU32 = AtomicU32::new(0);

// A global that needs runtime initialization: computed once, on first access
static SQUARES: LazyLock<Vec<u32>> = LazyLock::new(|| (0..5).map(|n| n * n).collect());

// static mut COUNTER: u32 = 0;                 // legal but effectively unusable:
// unsafe { COUNTER += 1; }                     // every access needs `unsafe`, and
                                                // in edition 2024 taking a
                                                // reference to it is a hard error
                                                // (lint `static_mut_refs`)

fn main() {
    REQUESTS.fetch_add(1, Ordering::Relaxed);   // atomic increment, thread-safe
    println!("{PROGRAM_NAME}");                 // taskr
    println!("{}", REQUESTS.load(Ordering::Relaxed));  // 1
    println!("{:?}", *SQUARES);                 // [0, 1, 4, 9, 16]
}
```

| Feature          | `const`                     | `static`                          |
| ---------------- | --------------------------- | --------------------------------- |
| Storage          | Inlined at each use         | One fixed address                 |
| Lifetime         | No address to speak of      | `'static`, the whole program run  |
| Mutable form     | Never                       | `static mut`, `unsafe` only       |
| Interior mutability | Not useful               | The safe way: atomics, `Mutex`, `OnceLock` |
| Type annotation  | Required                    | Required                          |
| Typical use      | Limits, factors, small values | Tables, globals, FFI-visible data |

> Key Takeaways
> - `static` is one memory location with a `'static` lifetime; `const` is an
>   inlined value.
> - Reach for `static` when identity, size, or an address matters; otherwise use
>   `const`.
> - `static mut` requires `unsafe`, and edition 2024 rejects references to it —
>   treat it as unavailable.
> - Safe mutable globals are built from `AtomicU32`, `Mutex`, `OnceLock`, or
>   `LazyLock`.

> 🧪 Practice
> 1. Declare a `static` string and a `const` integer, then print both from a
>    function other than `main`.
> 2. Build a global counter with `AtomicUsize`, increment it from three separate
>    function calls, and print the total.
> 3. Interview: Why is `static mut` unsafe while `static REQUESTS: AtomicU32` is
>    not, even though both are mutable globals? (Hint: ask what happens when two
>    threads touch each one simultaneously.)

<a id="22-primitive-types"></a>
### 2.2 Primitive Types

Rust's primitives are the types the CPU understands directly, plus a few the
compiler builds from them. Their edge cases — overflow, NaN, truncating casts —
are where most surprises live, so this section spends its time there.

#### Integer Types and Overflow

Rust makes you choose an integer's width and signedness explicitly. There is no
generic `int` that quietly means 32 bits here and 64 bits there, because the
choice affects both the range of values and the memory layout of every struct
containing it.

| Length  | Signed  | Unsigned | Range (signed)                     |
| ------- | ------- | -------- | ---------------------------------- |
| 8-bit   | `i8`    | `u8`     | -128 to 127                        |
| 16-bit  | `i16`   | `u16`    | -32,768 to 32,767                  |
| 32-bit  | `i32`   | `u32`    | about -2.1e9 to 2.1e9              |
| 64-bit  | `i64`   | `u64`    | about -9.2e18 to 9.2e18            |
| 128-bit | `i128`  | `u128`   | about -1.7e38 to 1.7e38            |
| pointer | `isize` | `usize`  | Machine word: 64-bit on most desktops |

`i32` is the default when inference has no other information, and `usize` is the
type of every index and length, because it is guaranteed to hold any address the
machine can produce.

The genuinely interesting part is overflow. In C, signed overflow is undefined
behavior, which lets compilers make surprising deductions. Rust defines the
behavior instead, and splits it by build profile:

- **Compile time**: if the compiler can evaluate the expression, overflow is a
  hard error (`arithmetic_overflow` is deny-by-default) — the program does not
  build at all.
- **Debug build**: the operation panics with "attempt to add with overflow".
- **Release build**: the operation wraps using two's complement. Defined, but
  almost certainly not what you meant.

Relying on either runtime behavior is a mistake. When overflow is *possible*, say
what should happen using the explicit methods every integer type provides.

```rust
fn main() {
    let big = 1_000_000u32;         // underscores are ignored, purely readability
    let hex = 0xff_u8;              // 255
    let oct = 0o77;                 // 63
    let bin = 0b1010_1010u8;        // 170
    let byte = b'A';                // u8 byte literal: 65
    println!("{big} {hex} {oct} {bin} {byte}");

    let x: u8 = 250;
    let y: u8 = 10;

    // Explicit strategies — none of these depend on the build profile
    println!("{:?}", x.checked_add(y));      // None            (signals failure)
    println!("{}", x.wrapping_add(y));       // 4               (modular arithmetic)
    println!("{}", x.saturating_add(y));     // 255             (clamp at the bound)
    println!("{:?}", x.overflowing_add(y));  // (4, true)       (value + did it wrap)

    // Bounds are associated constants
    println!("{} {}", u8::MAX, i32::MIN);    // 255 -2147483648

    // Indexing uses usize
    let v = [10, 20, 30];
    let i: usize = 2;
    println!("{}", v[i]);                    // 30
}
```

```text
u8 arithmetic at the boundary: 250 + 10

  checked_add   -> None                (you decide what to do)
  wrapping_add  -> 4                   (250 + 10 = 260, 260 - 256 = 4)
  saturating_add-> 255                 (stops at u8::MAX)
  overflowing_add -> (4, true)         (wrapped value, plus a flag)
  plain `+`     -> panic in debug, wraps to 4 in release
```

> Key Takeaways
> - Integer width and signedness are always explicit; `i32` is the inference
>   default and `usize` is the index type.
> - Overflow that the compiler can see is a build error; at runtime it panics in
>   debug and wraps in release.
> - Wrapping is defined behavior in Rust, unlike C's undefined signed overflow —
>   but it is still a bug unless you asked for it.
> - Use `checked_`, `wrapping_`, `saturating_`, or `overflowing_` to state intent
>   explicitly.

> 🧪 Practice
> 1. Compute `u8::MAX + 1` using each of the four explicit methods and print the
>    results side by side.
> 2. Write a function `fn safe_sub(a: u32, b: u32) -> Option<u32>` that returns
>    `None` when the subtraction would go below zero.
> 3. Interview: A test passes locally but a release build produces a wrong number
>    for large inputs. What is the likely cause, and how would you make the
>    behavior identical in both profiles? (Hint: consider `debug_assertions`, and
>    the `overflow-checks` profile setting.)

#### Floating-Point Types

Rust has two floating-point types, `f32` and `f64`, both IEEE 754. `f64` is the
default because on modern hardware it is the same speed as `f32` for scalar work
and has far more precision.

The important thing to internalize is that floats are not real numbers; they are
a finite set of values with a binary fraction. Values like 0.1 have no exact
binary representation, in the same way 1/3 has no exact decimal one. Every
arithmetic result is rounded to the nearest representable value, so tiny errors
accumulate.

Rust surfaces the consequence in its type system: floats implement `PartialEq`
and `PartialOrd` but not `Eq` or `Ord`. The reason is `NaN` ("not a number"),
which is not equal to itself and is unordered with everything. That is why a
`Vec<f64>` cannot be sorted with `.sort()`, and why floats cannot be `HashMap`
keys.

```rust
fn main() {
    let a = 0.1_f64;
    let b = 0.2_f64;
    println!("{}", a + b);              // 0.30000000000000004
    println!("{}", a + b == 0.3);       // false

    // Compare with a tolerance instead of `==`
    let close = (a + b - 0.3).abs() < f64::EPSILON;
    println!("{close}");                // true

    let nan = f64::NAN;
    println!("{}", nan == nan);         // false — NaN equals nothing, not even NaN
    println!("{}", nan.is_nan());       // true  — this is the correct test

    // Division by zero is defined for floats (unlike integers, which panic)
    println!("{} {}", 1.0_f64 / 0.0, -1.0_f64 / 0.0);   // inf -inf
    println!("{}", (0.0_f64 / 0.0).is_nan());           // true

    // Sorting needs an explicit total order because Ord is not implemented
    let mut values = vec![3.5, f64::NAN, 1.25, 2.0];
    // values.sort();                   // error: the trait bound `f64: Ord` is
                                        //        not satisfied
    values.sort_by(|x, y| x.total_cmp(y));   // IEEE 754 total order, NaN last
    println!("{values:?}");                  // [1.25, 2.0, 3.5, NaN]
}
```

> Key Takeaways
> - `f64` is the default; both types are IEEE 754 with rounding error on most
>   decimal fractions.
> - Never compare floats with `==`; compare against a tolerance, or use
>   `total_cmp`.
> - Floats implement `PartialOrd` but not `Ord`, because `NaN` is unordered — so
>   `.sort()` and `HashMap` keys are unavailable.
> - Float division by zero yields `inf` or `NaN` rather than panicking.

> 🧪 Practice
> 1. Print `0.1 + 0.2` and explain the trailing digits in one sentence.
> 2. Write `fn approx_eq(a: f64, b: f64, tol: f64) -> bool` and test it on values
>    that differ in the last bit.
> 3. Interview: Why does Rust refuse to implement `Ord` for `f64`, and what breaks
>    if a language pretends floats are totally ordered? (Hint: think about what a
>    sort algorithm assumes about comparisons, and where `NaN` fits.)

#### Booleans and Characters

`bool` has exactly two values, `true` and `false`, and occupies one byte. Rust has
no truthiness: an `if` condition must be a `bool`, so `if x` where `x` is an
integer does not compile. That single restriction eliminates the classic
`if (x = 1)` assignment-in-condition bug outright, since assignment produces `()`
rather than a value.

`char` is more interesting. In C, `char` is a byte. In Rust, `char` is a *Unicode
scalar value*: four bytes, holding any code point from `U+0000` to `U+10FFFF`
except the surrogate range. So `'a'`, `'é'`, and `'あ'` are each one `char`.

That is not the same as "one thing the user sees on screen". A user-perceived
character (a grapheme cluster) may be several `char`s — a letter plus a combining
accent, for example. And a `char` is not one byte of a string: Rust's strings are
UTF-8, where a single `char` occupies one to four bytes. Chapter 6 develops this;
what matters here is that `char` and `u8` are different types on purpose.

```rust
fn main() {
    let yes = true;
    let n = 3;
    // if n { }                         // error[E0308]: expected `bool`, found
                                        //               integer — no truthiness
    if n > 2 && yes {
        println!("conditions must be bool");
    }
    println!("{}", true as i32);        // 1 — an explicit cast is still allowed

    let letter = 'a';                   // char, 4 bytes
    let accented = 'é';
    let japanese = 'あ';
    let escaped = '\u{03bb}';           // any scalar value by code point: lambda
    let tab = '\t';

    println!("{}", std::mem::size_of::<char>());   // 4  — always, regardless of value
    println!("{}", accented.len_utf8());           // 2  — bytes when UTF-8 encoded
    println!("{}", "é".len());                     // 2  — String length is in BYTES
    println!("{}", "é".chars().count());           // 1  — one scalar value

    println!("{escaped} {}", tab.is_whitespace());  // lambda, then true
    println!("{}", letter as u32);                 // 97
    println!("{:?}", char::from_u32(97));          // Some('a')
    println!("{}", letter.is_alphabetic());        // true
    println!("{}", letter.to_ascii_uppercase());   // A

    let byte = b'a';                    // u8 literal: a byte, NOT a char
    println!("{} {} {}", byte, byte as char, japanese as u32);  // 97 a 12354
}
```

> Key Takeaways
> - `bool` is one byte and there is no truthiness: conditions must be `bool`.
> - `char` is a 4-byte Unicode scalar value, not a byte and not a grapheme
>   cluster.
> - `"é".len()` counts bytes, `chars().count()` counts scalar values, and the two
>   often differ.
> - `b'a'` is a `u8` byte literal; only `u8` may be cast to `char`.

> 🧪 Practice
> 1. Print the byte length and the `chars().count()` of `"héllo"` and explain the
>    difference.
> 2. Write a function that returns `true` when a `char` is a vowel, handling both
>    cases.
> 3. Interview: Why is `char` four bytes when most characters need only one, and
>    what would break if Rust made it one byte? (Hint: think about what
>    `s.chars().nth(3)` must be able to return.)

#### Tuples

A tuple groups a fixed number of values of possibly different types into one
value. It is the lightest possible compound type: no name, no field names, no
declaration.

Use a tuple when the grouping is obvious from context and short-lived — returning
two values from a function, pairing a key with a value, holding coordinates. When
the grouping has meaning that outlives one expression, promote it to a struct so
the fields get names; `.0` and `.1` become unreadable fast.

The empty tuple `()` is the *unit type*. It has exactly one value, carries no
information, and is what every expression that "returns nothing" actually
returns. Rust does not have `void`; it has a type with one value, which composes
much better.

```rust
fn main() {
    let point: (i32, i32) = (3, 7);
    println!("{} {}", point.0, point.1);        // 3 7 — access by position

    let (x, y) = point;                         // destructuring
    println!("{x} {y}");                        // 3 7

    let mixed = ("width", 1920u32, 2.5f64);     // heterogeneous
    println!("{}", mixed.1);                    // 1920

    let nested = ((1, 2), (3, 4));
    println!("{}", (nested.1).0);               // 3

    let unit: () = ();                          // the unit type and its one value
    println!("{unit:?}");                       // ()

    let single = (5,);                          // trailing comma makes a 1-tuple;
    println!("{}", single.0);                   // (5) alone is just parentheses

    println!("{:?}", divide(17, 5));            // (3, 2)
    let (quotient, remainder) = divide(17, 5);  // the usual way to consume it
    println!("{quotient} r{remainder}");        // 3 r2
}

// A tuple is the natural return type for "two related values, right here"
fn divide(a: i32, b: i32) -> (i32, i32) {
    (a / b, a % b)      // integer division truncates: 17/5 = 3, 17%5 = 2
}
```

Two practical limits: tuple fields are accessed by a literal index only (`t.0`,
never `t[i]`), and the standard library implements traits such as `Debug` and
`Clone` for tuples only up to twelve elements. Both are gentle pressure toward
using a struct once a tuple grows.

> Key Takeaways
> - Tuples group a fixed number of heterogeneous values with positional access.
> - `()` is the unit type: Rust's replacement for `void`, and the value of every
>   expression that yields nothing.
> - Destructuring is the idiomatic way to consume a tuple.
> - Promote a tuple to a struct once it outlives a single expression or grows
>   past two or three fields.

> 🧪 Practice
> 1. Write a function returning the minimum and maximum of a slice as a tuple.
> 2. Destructure a nested tuple `((1, 2), 3)` into three named bindings in one
>    `let`.
> 3. Interview: Rust has no `void`; it has `()`. Name one thing that becomes
>    possible because "returns nothing" is a real type. (Hint: think about generic
>    code that must name the return type of any function.)

#### Arrays and Slices

An array `[T; N]` holds exactly `N` values of type `T`, laid out contiguously.
The crucial detail is that `N` is part of the *type*: `[i32; 3]` and `[i32; 4]`
are different types that cannot be assigned to one another. Arrays live inline —
on the stack when they are local variables — so their size must be known at
compile time.

That rigidity is inconvenient for writing functions. A function taking
`[i32; 3]` works with exactly three elements. The solution is the *slice*, `&[T]`:
a borrowed view into a contiguous run of elements. A slice is a *fat pointer* —
a pointer plus a length, sixteen bytes on a 64-bit machine — so it can describe
any span without knowing its size at compile time.

Slices are the reason a single function can accept an array, a `Vec`, or part of
either. Write functions in terms of `&[T]` and callers can hand you anything
contiguous.

```rust
fn main() {
    let a: [i32; 5] = [1, 2, 3, 4, 5];
    let zeros = [0u8; 4];               // repeat syntax: [value; count]
    println!("{} {}", a.len(), zeros.len());        // 5 4

    println!("{}", a[0]);               // 1 — indexing is bounds-checked
    // println!("{}", a[10]);           // panics: index out of bounds
    println!("{:?}", a.get(10));        // None — the non-panicking accessor

    let all = &a[..];                   // whole array as a slice
    let middle = &a[1..4];              // elements 1, 2, 3 -> [2, 3, 4]
    println!("{:?} {:?}", all, middle); // [1, 2, 3, 4, 5] [2, 3, 4]

    println!("{}", sum(&a));            // 15 — an array coerces to a slice
    println!("{}", sum(middle));        // 9  — so does part of one
    let v = vec![10, 20];
    println!("{}", sum(&v));            // 30 — and so does a Vec

    println!("{}", std::mem::size_of::<&[i32]>());  // 16: pointer + length
    println!("{}", std::mem::size_of::<&i32>());    // 8:  pointer only
}

// Take `&[T]`, not `&Vec<T>` or `[T; N]`: it accepts the most callers
fn sum(values: &[i32]) -> i32 {
    values.iter().sum()
}
```

```text
let a = [1, 2, 3, 4, 5];        let middle = &a[1..4];

  array `a` (20 bytes, contiguous)
  +----+----+----+----+----+
  |  1 |  2 |  3 |  4 |  5 |
  +----+----+----+----+----+
         ^              
         |  slice `middle` = fat pointer
         +---- ptr
               len = 3         -> sees [2, 3, 4], owns nothing
```

| Type       | Size known at compile time | Owns data | Growable | Lives    |
| ---------- | -------------------------- | --------- | -------- | -------- |
| `[T; N]`   | Yes, `N` is in the type    | Yes       | No       | Inline (stack) |
| `&[T]`     | No (fat pointer to `N` items) | No     | No       | Borrowed view |
| `Vec<T>`   | No                         | Yes       | Yes      | Heap     |

> Key Takeaways
> - An array's length is part of its type, so `[i32; 3]` and `[i32; 4]` are
>   unrelated types.
> - A slice `&[T]` is a fat pointer (address plus length) that borrows a
>   contiguous run of elements.
> - Indexing panics on out-of-bounds; `.get()` returns `Option` instead.
> - Accept `&[T]` in function signatures so arrays, `Vec`s, and sub-ranges all
>   work.

> 🧪 Practice
> 1. Write a function `fn average(xs: &[f64]) -> f64` and call it with both an
>    array and a `Vec`.
> 2. Take a slice of the middle three elements of a five-element array and print
>    its length and contents.
> 3. Interview: Why is `&[T]` sixteen bytes on a 64-bit machine while `&i32` is
>    eight? (Hint: what does the caller need to know that the type alone does not
>    say?)

#### Type Inference and Annotations

Rust is statically typed, but you rarely write types inside a function body. The
compiler runs a local inference algorithm over each function, gathering
constraints from how a value is used and solving for a single type.

"Local" is the key word. Inference operates within a function body only —
signatures always require explicit types. That boundary is deliberate: it keeps
error messages near the mistake, keeps compile times manageable, and makes a
function's contract readable without inspecting its implementation.

Inference is also *bidirectional*. A later line can determine an earlier
binding's type, which is why `let v = Vec::new();` compiles when a subsequent
`v.push(1u8)` reveals the element type. When nothing in the body pins a numeric
type down, Rust falls back to defaults: `i32` for integers, `f64` for floats.

Annotation becomes necessary when the compiler genuinely cannot decide — most
often with `collect()` and `parse()`, which are generic over their *return*
type.

```rust
fn main() {
    let a = 5;                      // i32 by default
    let b = 5.0;                    // f64 by default
    let c = 5u8;                    // suffix pins the type
    let d: u64 = 5;                 // annotation pins the type
    println!("{a} {b} {c} {d}");

    let mut v = Vec::new();         // element type unknown here...
    v.push(1u8);                    // ...decided by this line: Vec<u8>
    println!("{v:?}");

    // `collect` can build many types, so it needs a hint. Two equivalent ways:
    let squares: Vec<i32> = (1..=4).map(|n| n * n).collect();   // annotate the binding
    let cubes = (1..=4).map(|n| n * n * n).collect::<Vec<i32>>(); // turbofish
    println!("{squares:?} {cubes:?}");   // [1, 4, 9, 16] [1, 8, 27, 64]

    // `parse` is generic over its output type for the same reason
    let n: i32 = "42".parse().unwrap();
    let m = "42".parse::<f64>().unwrap();
    println!("{n} {m}");                 // 42 42

    // Mixing types is an error, not an implicit conversion
    let x: u8 = 1;
    let y: u32 = 2;
    // println!("{}", x + y);        // error[E0308]: expected `u8`, found `u32`
    println!("{}", u32::from(x) + y); // 3 — conversions are always explicit
}
```

> Key Takeaways
> - Inference is local to a function body; signatures always spell out their
>   types.
> - Inference is bidirectional, so a later use can determine an earlier binding's
>   type.
> - Unconstrained numeric literals default to `i32` and `f64`.
> - `collect()` and `parse()` are generic over their return type, so annotate the
>   binding or use the turbofish.

> 🧪 Practice
> 1. Write `let v = Vec::new();` followed by a `push` that forces the element type
>    to `String`, and confirm it compiles.
> 2. Collect the same iterator into a `Vec<i32>` and into a `HashSet<i32>` using
>    both annotation styles.
> 3. Interview: Why does Rust infer types inside function bodies but require them
>    in signatures, when it could in principle infer both? (Hint: consider error
>    messages, compile time, and what a caller should have to read.)

#### Numeric Casting with as

Rust performs no implicit numeric conversions. Adding a `u8` to a `u32` is a type
error, because implicit widening is where subtle bugs hide in C. Conversions must
be written, and `as` is the terse way to write one.

The trade-off with `as` is that it never fails and never panics — it produces
*some* value for every input, even when the value cannot be represented. The
rules per conversion:

| Conversion            | Behavior of `as`                        | Example                    |
| --------------------- | --------------------------------------- | -------------------------- |
| Larger to smaller int | Truncates the high bits (modular)       | `300i32 as u8` -> 44       |
| Signed to unsigned    | Reinterprets the two's complement bits  | `-1i32 as u8` -> 255       |
| Smaller to larger int | Lossless; sign-extends if signed        | `-1i8 as i32` -> -1        |
| Float to int          | Truncates toward zero, saturates at bounds | `300.7f64 as u8` -> 255 |
| `NaN` to int          | Yields 0                                | `f64::NAN as i32` -> 0     |
| Int to float          | May lose precision silently             | `i64::MAX as f32`          |
| `bool` to int         | `false` -> 0, `true` -> 1               | `true as i32` -> 1         |
| `u8` to `char`        | Allowed; other integer types are not    | `65u8 as char` -> 'A'      |

Because `as` silently produces a wrong-but-defined answer, prefer the trait-based
conversions when correctness matters. `From`/`Into` exist only for conversions
that cannot lose information, so `u32::from(x)` will not compile if the
conversion is lossy. `TryFrom`/`TryInto` cover the fallible direction and return
a `Result` you must handle.

```rust
use std::convert::TryFrom;

fn main() {
    // `as` always answers, correct or not
    println!("{}", 300i32 as u8);        // 44   (300 mod 256)
    println!("{}", -1i32 as u8);         // 255  (bit reinterpretation)
    println!("{}", 300.7f64 as u8);      // 255  (saturates, does not wrap)
    println!("{}", -1.5f64 as u8);       // 0    (saturates at the low bound)
    println!("{}", f64::NAN as i32);     // 0
    println!("{}", 3.99f64 as i32);      // 3    (truncates toward zero)

    // Lossless conversions: checked by the compiler, cannot silently corrupt
    let small: u8 = 200;
    let wide: u32 = u32::from(small);    // compiles: u8 always fits in u32
    // let narrow: u8 = u8::from(wide);  // does not compile: not always valid
    println!("{wide}");

    // Fallible conversions: the failure is a value you must handle
    match u8::try_from(300u32) {
        Ok(v) => println!("fits: {v}"),
        Err(e) => println!("does not fit: {e}"),   // out of range integral type
                                                   // conversion attempted
    }

    // The common legitimate use of `as`: indexing and float/int boundaries
    let items = ["a", "b", "c"];
    let idx: u32 = 1;
    println!("{}", items[idx as usize]);  // b
    let ratio = 3 as f64 / 4 as f64;      // avoid integer division: 0.75
    println!("{ratio}");
}
```

> Key Takeaways
> - Rust has no implicit numeric coercion; every conversion is written out.
> - `as` never fails: it truncates integers, saturates float-to-int conversions,
>   and turns `NaN` into 0.
> - Prefer `From`/`Into` for lossless conversions and `TryFrom`/`TryInto` when
>   the value may not fit.
> - Reserve `as` for cases where the truncation is intended or impossible, such
>   as an index cast to `usize`.

> 🧪 Practice
> 1. Print `1000i32 as u8`, `-1i32 as u8`, and `1e10f64 as i32`, and explain each
>    result.
> 2. Rewrite a lossy `as` conversion using `TryFrom` and handle the error branch.
> 3. Interview: `as` never panics and never fails to compile. Why is that a
>    hazard rather than a convenience, and when is `as` still the right tool?
>    (Hint: compare what the compiler can check for `as` versus for `TryFrom`.)

<a id="23-control-flow"></a>
### 2.3 Control Flow

Rust's control flow will look familiar, with one structural difference: almost
all of it consists of expressions that produce values, which changes how the
constructs are used.

#### if and if-let Expressions

`if` in Rust differs from C in two visible ways and one deep one. The visible
ones: the condition needs no parentheses, and the branches always need braces.
The deep one: `if` is an expression, so it evaluates to a value and can appear
anywhere a value is expected.

That has a consequence the compiler enforces. If an `if` produces a value, every
branch must produce the *same type*, and an `if` without an `else` implicitly has
an `else` branch yielding `()`. So `let x = if c { 5 };` fails: one branch gives
an integer, the other unit.

The related form `if let` handles the extremely common case of "run this code
only when a value matches one particular pattern". It is a `match` with a single
interesting arm and no obligation to be exhaustive — trading exhaustiveness
checking for brevity. Since edition 2024, conditions can be chained with `&&`,
combining pattern matches and boolean tests in one condition (a *let chain*).

```rust
fn main() {
    let n = 7;

    // No parentheses; braces are mandatory even for one statement
    if n % 2 == 0 {
        println!("even");
    } else if n % 3 == 0 {
        println!("divisible by three");
    } else {
        println!("neither");            // neither
    }

    // `if` as an expression: both branches must have the same type
    let size = if n < 10 { "small" } else { "large" };
    println!("{size}");                 // small
    // let bad = if n < 10 { "small" }; // error[E0317]: `if` may be missing an
                                        // `else` clause — types differ: &str vs ()

    // `if let`: match one pattern, ignore everything else
    let config: Option<u32> = Some(3);
    if let Some(retries) = config {
        println!("retries = {retries}");   // retries = 3
    } else {
        println!("using the default");
    }

    // Let chains (edition 2024): pattern match and test in a single condition
    let maybe: Option<i32> = Some(7);
    if let Some(v) = maybe
        && v > 3
    {
        println!("matched and above three: {v}");   // matched and above three: 7
    }

    // Without let chains this needs nesting, which is why they were added
    if let Some(v) = maybe {
        if v > 3 {
            println!("same result, one level deeper");
        }
    }
}
```

> Key Takeaways
> - Conditions take no parentheses, require braces, and must be `bool`.
> - `if` is an expression: every branch must yield the same type, and a missing
>   `else` yields `()`.
> - `if let` matches a single pattern concisely but gives up exhaustiveness
>   checking.
> - Edition 2024 allows let chains, combining `let` patterns and boolean tests
>   with `&&`.

> 🧪 Practice
> 1. Rewrite a three-branch `if`/`else if`/`else` so its value initializes a
>    single `let` binding.
> 2. Convert a `match` with one meaningful arm and a `_ => {}` arm into an
>    `if let`.
> 3. Interview: Why must all branches of an `if` expression have the same type,
>    and what does the compiler assume when the `else` is missing? (Hint: think
>    about what type the whole expression would have.)

#### loop and Loop Labels

`loop` is an unconditional infinite loop. It exists as its own keyword rather
than as `while true` because the compiler treats it differently: it knows a
`loop` without a `break` never finishes normally, so such a loop's type is the
never type `!`, and code after it is correctly flagged as unreachable. With
`while true`, the compiler must assume the condition could become false.

The natural shape for `loop` is "repeat until something happens": retrying a
fallible operation, waiting on a queue, running an event loop.

When loops nest, plain `break` and `continue` affect only the innermost one.
*Labels* — an identifier prefixed with a single quote — let you name a loop and
target it explicitly. Labels also work on plain blocks, giving a structured way
to jump forward out of a section of code without a `goto`.

```rust
fn main() {
    let mut attempts = 0;

    // "Repeat until something happens" — the canonical use of `loop`
    loop {
        attempts += 1;
        if attempts == 3 {
            break;                      // exits this loop
        }
    }
    println!("attempts = {attempts}");  // attempts = 3

    // Labels: `break` and `continue` can target an outer loop by name
    let grid = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
    let target = 5;
    let mut found_at = None;

    'rows: for (r, row) in grid.iter().enumerate() {
        for (c, value) in row.iter().enumerate() {
            if *value == target {
                found_at = Some((r, c));
                break 'rows;            // leaves BOTH loops, not just the inner
            }
        }
    }
    println!("{found_at:?}");           // Some((1, 1))

    // `continue 'label` skips to the next iteration of the labeled loop
    'outer: for a in 1..=3 {
        for b in 1..=3 {
            if a == b {
                continue 'outer;        // abandon this `a` entirely
            }
            print!("{a}{b} ");          // 21 31 32
        }
    }
    println!();
    // a=1 stops at b=1, a=2 prints 21 then stops at b=2, a=3 prints 31 and 32:
    // `continue 'outer` abandons the rest of the current `a`, not just this `b`.

    // A labeled block: structured early exit with no loop involved
    let status = 'check: {
        if grid[0][0] != 1 {
            break 'check "corrupt";
        }
        if grid.len() != 3 {
            break 'check "wrong size";
        }
        "ok"
    };
    println!("{status}");               // ok
}
```

> Key Takeaways
> - `loop` is an infinite loop the compiler understands: without a `break` its
>   type is `!`, enabling accurate unreachable-code analysis.
> - Plain `break` and `continue` apply to the innermost loop only.
> - Labels (`'name:`) let `break` and `continue` target an outer loop.
> - Labeled blocks give a structured early exit without introducing a loop.

> 🧪 Practice
> 1. Write a `loop` that doubles a number until it exceeds 1000, then prints the
>    iteration count.
> 2. Search a 2D array for a value using labeled `break` to exit both loops at
>    once.
> 3. Interview: Why does Rust provide `loop` when `while true` would do? (Hint:
>    ask what type each construct has and what the compiler can then prove about
>    the code after it.)

#### while and while-let

`while` repeats as long as a boolean condition holds. It is the right tool when
the exit condition is a genuine test evaluated before each pass, and it saves the
`if ... break` ceremony that `loop` would require.

`while let` is its pattern-matching sibling: repeat as long as an expression
keeps matching a pattern. Its natural use is draining something that reports
"nothing left" with an `Option` — `pop()` on a stack, `next()` on an iterator,
`recv()` on a channel. The loop ends the moment the pattern stops matching.

```rust
fn main() {
    // `while`: the condition is re-tested before every iteration
    let mut n = 1;
    while n < 100 {
        n *= 3;                         // 1 -> 3 -> 9 -> 27 -> 81 -> 243
    }
    println!("{n}");                    // 243

    // Countdown, the classic shape
    let mut countdown = 3;
    while countdown > 0 {
        print!("{countdown} ");         // 3 2 1
        countdown -= 1;
    }
    println!();

    // `while let`: loop as long as the pattern matches
    let mut stack = vec![1, 2, 3];
    while let Some(top) = stack.pop() {     // `pop` returns None when empty
        print!("{top} ");                   // 3 2 1 — LIFO order
    }
    println!();

    // The same loop written with `loop` and an explicit match, for comparison
    let mut stack2 = vec![1, 2, 3];
    loop {
        match stack2.pop() {
            Some(top) => print!("{top} "),
            None => break,
        }
    }
    println!();                             // 3 2 1

    // A common trap: this is an infinite loop, because `last()` never consumes
    // let items = vec![1, 2, 3];
    // while let Some(x) = items.last() { println!("{x}"); }
}
```

| Construct   | Runs while                    | Typical use                      |
| ----------- | ----------------------------- | -------------------------------- |
| `loop`      | Forever, until `break`        | Retry, event loop, value-producing loop |
| `while`     | A `bool` condition holds      | A test that changes over time    |
| `while let` | A pattern keeps matching      | Draining `Option`-yielding sources |
| `for`       | An iterator yields items      | Every fixed-size traversal       |

> Key Takeaways
> - `while` tests its condition before each iteration; `while let` tests whether a
>   pattern still matches.
> - `while let` is the idiomatic way to drain a stack, channel, or iterator.
> - The loop ends on the first non-matching value, so the operation inside must
>   actually consume something.
> - `while let` is exactly `loop` plus a `match` with a `break` arm, written
>   compactly.

> 🧪 Practice
> 1. Write a `while` loop that halves a number until it reaches 1, printing each
>    value.
> 2. Drain a `Vec<String>` with `while let Some(s) = v.pop()` and count the
>    elements as you go.
> 3. Interview: When would you choose `while let` over a `for` loop over the same
>    collection? (Hint: think about whether the collection is being consumed
>    element by element and whether other code mutates it meanwhile.)

#### for Loops and Ranges

Rust's `for` is a for-*each* loop and nothing else. There is no C-style
`for (i = 0; i < n; i++)`, because that form is a manual reimplementation of
iteration that is easy to get wrong: off-by-one bounds, forgetting the
increment, mutating the counter inside the body.

`for` accepts anything implementing `IntoIterator` and takes ownership of what it
iterates by default — which is why `for x in v` consumes `v`. Iterating by
reference (`&v`) or by mutable reference (`&mut v`) is a deliberate choice
spelled out at the loop head.

Ranges supply the counting loops. `a..b` is exclusive of `b`, `a..=b` includes
it, and both are ordinary iterators, so adapters like `.rev()` and `.step_by()`
apply.

```rust
fn main() {
    // Ranges: exclusive and inclusive
    for i in 0..3 {
        print!("{i} ");                 // 0 1 2
    }
    println!();
    for i in 1..=3 {
        print!("{i} ");                 // 1 2 3
    }
    println!();

    // Ranges are iterators, so adapters work
    let stepped: Vec<i32> = (0..10).step_by(3).collect();
    let reversed: Vec<i32> = (1..=5).rev().collect();
    println!("{stepped:?} {reversed:?}");   // [0, 3, 6, 9] [5, 4, 3, 2, 1]

    let v = vec![10, 20, 30];

    for x in &v {
        print!("{x} ");                 // 10 20 30 — borrows; `v` still usable
    }
    println!();

    let mut w = vec![1, 2, 3];
    for x in &mut w {
        *x *= 10;                       // mutable borrow: modify in place
    }
    println!("{w:?}");                  // [10, 20, 30]

    for x in v {                        // takes ownership: `v` is moved here
        print!("{x} ");                 // 10 20 30
    }
    println!();
    // println!("{v:?}");               // error[E0382]: borrow of moved value

    // Index and value together, without managing a counter
    let names = ["ada", "grace", "alan"];
    for (i, name) in names.iter().enumerate() {
        print!("{i}:{name} ");          // 0:ada 1:grace 2:alan
    }
    println!();

    // Two sequences in lockstep
    for (name, score) in names.iter().zip([90, 95, 88]) {
        print!("{name}={score} ");      // ada=90 grace=95 alan=88
    }
    println!();

    // Ranges work over chars too
    for c in 'a'..='e' {
        print!("{c}");                  // abcde
    }
    println!();
}
```

| Loop head    | Item type | Effect on the collection      |
| ------------ | --------- | ----------------------------- |
| `for x in v` | `T`       | Consumes `v`; unusable after  |
| `for x in &v`| `&T`      | Borrows; `v` still usable     |
| `for x in &mut v` | `&mut T` | Mutable borrow; modify in place |

> Key Takeaways
> - `for` iterates over anything implementing `IntoIterator`; there is no C-style
>   counting loop.
> - `a..b` excludes the end, `a..=b` includes it, and both are iterators.
> - `for x in v` moves the collection; write `&v` or `&mut v` to borrow instead.
> - `enumerate` and `zip` replace manual index arithmetic.

> 🧪 Practice
> 1. Print the even numbers from 0 to 20 using a range with `step_by`, then again
>    with `filter`.
> 2. Iterate a `Vec<String>` by reference, print each element, and confirm the
>    vector is still usable afterwards.
> 3. Interview: Why did Rust omit the C-style `for` loop, and what does
>    `for x in &v` guarantee that a manual index loop does not? (Hint: think about
>    bounds checks and about what the borrow checker can see.)

#### break with Values

Since `loop` is an expression, it can produce a value: `break expr` exits the loop
*and* supplies its result. This turns the common "loop until you compute
something, then store it" pattern into a single binding, with no mutable
placeholder variable declared before the loop.

Only `loop` supports this, along with labeled blocks. `while` and `for` cannot
break with a value, because their exit condition can be reached without a `break`
at all — the compiler would have no value to produce in that case. Attempting it
is `E0571`.

With labels, `break 'label value` can even hand a value out of an outer loop from
deep inside a nest.

```rust
fn main() {
    // The value of the whole `loop` expression comes from `break`
    let mut n = 1;
    let first_over_100 = loop {
        n *= 2;
        if n > 100 {
            break n;                    // 1,2,4,...,64,128 -> 128
        }
    };
    println!("{first_over_100}");       // 128

    // Compare: without break-with-value you need a mutable placeholder
    let mut m = 1;
    let result;             // no initial value needed: the loop's only exit assigns
    loop {
        m *= 2;
        if m > 100 {
            result = m;
            break;
        }
    }
    println!("{result}");               // 128, but with an extra `mut` binding

    // Retry loops read particularly well this way
    let mut attempt = 0;
    let outcome = loop {
        attempt += 1;
        match try_connect(attempt) {
            Ok(conn) => break conn,                 // success: yield the value
            Err(_) if attempt >= 3 => break "gave up after 3 tries".to_string(),
            Err(_) => continue,                     // otherwise try again
        }
    };
    println!("{outcome}");              // connected on attempt 3

    // A labeled break can carry a value out of nested loops
    let grid = [[1, 2], [3, 4]];
    let found = 'search: loop {
        for row in &grid {
            for &cell in row {
                if cell % 4 == 0 {
                    break 'search Some(cell);
                }
            }
        }
        break None;
    };
    println!("{found:?}");              // Some(4)

    // let x = while true { break 5; };  // error[E0571]: `break` with value from
                                         // a `while` loop is not allowed
}

fn try_connect(attempt: u32) -> Result<String, &'static str> {
    if attempt >= 3 {
        Ok(format!("connected on attempt {attempt}"))
    } else {
        Err("refused")
    }
}
```

> Key Takeaways
> - `break value` makes a `loop` an expression that produces that value.
> - Only `loop` and labeled blocks can break with a value; `while` and `for`
>   cannot (`E0571`).
> - This removes the mutable placeholder variable that the same logic needs in
>   other languages.
> - `break 'label value` carries a result out of an outer loop from inside a
>   nest.

> 🧪 Practice
> 1. Use `loop` with `break` to find the first power of 3 greater than 500 and
>    bind it directly.
> 2. Write a retry loop that returns a `Result` value via `break` after at most
>    five attempts.
> 3. Interview: Why can `loop` break with a value while `while` cannot? (Hint:
>    think about how each loop can end, and what value would exist on the path
>    that never executes a `break`.)

<a id="24-functions"></a>
### 2.4 Functions

Functions are where Rust's explicitness is strictest: every parameter and return
type is written out, because a signature is a contract that both sides of a call
must be able to read without consulting the body.

#### Parameters and Return Types

A function is declared with `fn`, a name in `snake_case`, a parenthesized
parameter list where every parameter has an explicit type, and an optional
`-> Type` return annotation. Omitting the return type means the function returns
`()`.

Type annotations are mandatory here even though the compiler could often infer
them. The reason is documentation and error locality: a caller reading
`fn parse(input: &str) -> u32` knows the contract without reading the body, and a
type error is reported at the offending call rather than propagating outward
through inference.

Order does not matter — functions can be called before they are defined in the
file, since Rust resolves items across the whole scope rather than top to bottom.

Parameters follow the ownership rules of Chapter 3, which show up here as three
different signatures with three different meanings.

```rust
fn main() {
    println!("{}", add(2, 3));              // 5 — defined below, still callable
    greet();                                // returns ()

    let s = String::from("hello");
    println!("{}", length(&s));             // 5 — borrows; `s` survives
    println!("{}", shout(s));               // HELLO — takes ownership; `s` moves
    // println!("{s}");                     // error[E0382]: value moved above

    let mut v = vec![3, 1, 2];
    sort_in_place(&mut v);                  // mutable borrow
    println!("{v:?}");                      // [1, 2, 3]

    let (min, max) = min_max(&[4, 9, 1]);   // several values via a tuple
    println!("{min} {max}");                // 1 9
}

fn add(a: i32, b: i32) -> i32 {             // every parameter type is explicit
    a + b
}

fn greet() {                                // no `->` means the return type is ()
    println!("hi");
}

fn length(s: &str) -> usize {               // borrow: caller keeps the value
    s.len()
}

fn shout(s: String) -> String {             // ownership: caller gives it up
    s.to_uppercase()
}

fn sort_in_place(v: &mut Vec<i32>) {        // exclusive borrow: caller sees changes
    v.sort();
}

fn min_max(xs: &[i32]) -> (i32, i32) {      // a tuple returns several values
    let mut min = xs[0];
    let mut max = xs[0];
    for &x in xs {
        if x < min { min = x; }
        if x > max { max = x; }
    }
    (min, max)
}
```

| Parameter form | Caller keeps the value | Callee may mutate | Use when                    |
| -------------- | ---------------------- | ----------------- | --------------------------- |
| `x: T`         | No, it is moved        | Its own copy      | The function consumes or stores it |
| `x: &T`        | Yes                    | No                | Read-only access (the default choice) |
| `x: &mut T`    | Yes                    | Yes               | The caller wants the changes back |

> Key Takeaways
> - Every parameter and non-unit return type must be annotated; inference stops
>   at the signature.
> - A missing `->` means the function returns `()`.
> - Function definition order is irrelevant; items are visible throughout their
>   scope.
> - `T`, `&T`, and `&mut T` encode ownership, read access, and exclusive
>   mutation in the signature itself.

> 🧪 Practice
> 1. Write `fn celsius_to_fahrenheit(c: f64) -> f64` and call it before its
>    definition in the file.
> 2. Write a function that takes `&mut Vec<i32>` and removes every odd number,
>    then verify the caller sees the change.
> 3. Interview: Rust could infer parameter and return types from a function body.
>    Why does it refuse to? (Hint: think about what changes for callers, for error
>    messages, and for the crate's public API when a body is edited.)

#### Implicit Return Expressions

A function body is a block, and a block evaluates to its final expression. So the
last expression in a function — written without a semicolon — is the return
value. The `return` keyword exists, but idiomatic Rust reserves it for *early*
exits.

Preferring the tail expression is more than style. It composes with `if` and
`match` being expressions, so a function that chooses among several results reads
as one expression rather than a series of assignments or scattered `return`s.

The trap is the semicolon: adding one to the tail expression turns the value into
`()` and produces `error[E0308]: mismatched types`, the most common early error
in Rust.

```rust
fn main() {
    println!("{}", square(4));              // 16
    println!("{}", classify(0));            // zero
    println!("{}", first_word("hello world")); // hello
    println!("{:?}", checked_div(7, 0));     // None
}

fn square(n: i32) -> i32 {
    n * n           // tail expression: this is the return value
                    // `n * n;` here would be E0308: expected `i32`, found `()`
}

fn classify(n: i32) -> &'static str {
    // `match` is an expression, so the whole body is a single tail expression
    match n {
        0 => "zero",
        n if n < 0 => "negative",
        _ => "positive",
    }
}

fn first_word(s: &str) -> &str {
    // `return` earns its place for early exits that skip the rest of the body
    for (i, c) in s.char_indices() {
        if c == ' ' {
            return &s[..i];     // early return
        }
    }
    s                           // tail expression: no space found
}

fn checked_div(a: i32, b: i32) -> Option<i32> {
    if b == 0 {
        return None;            // guard clause: early exit keeps nesting flat
    }
    Some(a / b)                 // tail expression
}
```

> Key Takeaways
> - The final expression of a body, written without a semicolon, is the return
>   value.
> - `return` is for early exits; the tail expression is the idiomatic normal path.
> - Because `if` and `match` are expressions, whole function bodies often reduce
>   to one expression.
> - A stray semicolon on the tail changes the return type to `()` and produces
>   `E0308`.

> 🧪 Practice
> 1. Write a function whose entire body is a single `match` expression returning
>    a `&'static str`.
> 2. Take a function that uses `return` in four branches and rewrite it with one
>    tail expression.
> 3. Interview: What exactly does adding a semicolon to a function's last
>    expression change, and why does the resulting error mention `()`? (Hint:
>    describe what the semicolon does to an expression.)

#### The Never Type

Some expressions never produce a value because control flow leaves before they
finish. `return`, `break`, `continue`, `panic!`, `std::process::exit`, and a
`loop` with no `break` all fall into this category. Rust gives them a type: `!`,
pronounced "never", the type with no values at all.

The reason a type is needed becomes obvious in a `match`. Every arm of a `match`
expression must have the same type, so what type does an arm that panics have?
If `panic!` had type `()`, then `match x { Some(v) => v, None => panic!("...") }`
would be a type error whenever `v` is not `()`. Giving it type `!` solves this
neatly: because `!` has no values, it can safely coerce to *any* type. There is
no value to convert, so the coercion is vacuous.

Think of `!` as a promise: "this code path does not come back, so whatever type
you needed here, consider it satisfied."

```rust
fn main() {
    let maybe: Option<i32> = Some(5);

    // The `None` arm has type `!`, which coerces to i32 to match the other arm
    let value: i32 = match maybe {
        Some(v) => v,
        None => panic!("expected a value"),
    };
    println!("{value}");                    // 5

    // Same coercion with `return`, `continue`, and `break`
    let mut total = 0;
    for i in 0..5 {
        let doubled: i32 = if i == 3 { continue } else { i * 2 };
        total += doubled;                   // 0 + 2 + 4 + 8 = 14 (i == 3 skipped)
    }
    println!("{total}");                    // 14

    println!("{}", parse_or_exit("12"));    // 12
}

fn parse_or_exit(s: &str) -> u32 {
    match s.parse() {
        Ok(n) => n,
        // `exit` returns `!`, so this arm type-checks against u32
        Err(_) => std::process::exit(1),
    }
}

// A function that never returns is annotated `-> !`
#[allow(dead_code)]         // never called here; shown for its signature
fn fail_forever() -> ! {
    panic!("this function never returns normally");
}
```

| Expression            | Type | Why                                      |
| --------------------- | ---- | ---------------------------------------- |
| `panic!("...")`       | `!`  | Unwinds; control never continues          |
| `return x`            | `!`  | Leaves the function                       |
| `break` / `continue`  | `!`  | Leaves or restarts the loop               |
| `std::process::exit(1)` | `!` | Terminates the process                   |
| `loop {}` (no `break`)| `!`  | Never finishes                            |

Note that `!` is stable in return position (`fn f() -> !`) while using it as a
general standalone type annotation is still unstable — you will meet it mostly
through coercion rather than by writing it.

> Key Takeaways
> - `!` is the type of expressions that never produce a value.
> - Because `!` has no values, it coerces to any type, which is what makes
>   `panic!` usable in any `match` arm.
> - `-> !` marks a function that never returns normally.
> - `return`, `break`, `continue`, `panic!`, and `process::exit` all have type
>   `!`.

> 🧪 Practice
> 1. Write a `match` where one arm returns a `u32` and the other calls `panic!`,
>    and confirm it compiles.
> 2. Write `fn shutdown(code: i32) -> !` that prints a message and calls
>    `std::process::exit`.
> 3. Interview: Why can an expression of type `!` be used where any other type is
>    expected, when no other type coerces so freely? (Hint: think about how many
>    values of type `!` exist, and what a conversion would have to do with one.)

#### Nested and Const Functions

Two variations on `fn` are worth knowing early.

A **nested function** is a function item declared inside another function's body.
Its purpose is scoping: a helper used only by one function can be hidden inside
it, keeping the module namespace clean and signalling to the reader that nothing
else calls it. The critical rule — and the reason nested functions are not
closures — is that a nested function *cannot capture* anything from the enclosing
scope. It is an ordinary item that happens to be written in an inner scope, so
every value it needs must arrive through its parameters.

A **const function** is one the compiler may evaluate at compile time. Marking a
function `const fn` does not force compile-time evaluation; it makes the function
*eligible* to be called in a const context — an array length, a `const` or
`static` initializer, a const generic argument — while remaining callable at
runtime exactly like any other function. In exchange, the body is restricted to a
subset of the language that the const evaluator supports: no heap allocation, no
arbitrary trait method calls, nothing that touches the outside world. That subset
has grown with almost every release.

```rust
const fn kib(n: usize) -> usize {
    n * 1024                        // usable at compile time AND at runtime
}

const BUFFER_SIZE: usize = kib(4);  // evaluated during compilation: 4096

fn main() {
    let buffer = [0u8; BUFFER_SIZE];     // a const context: needs a compile-time value
    println!("{}", buffer.len());        // 4096
    println!("{}", kib(2));              // 2048 — the same fn called at runtime

    let readings = [3, 9, 4, 1];
    println!("{:?}", normalize(&readings));   // [2, 8, 3, 0]

    let factor = 10;
    // fn scaled(x: i32) -> i32 { x * factor }   // error[E0434]: can't capture
                                                 // dynamic environment — items
                                                 // do not close over locals
    let scaled = |x: i32| x * factor;            // a closure can (Chapter 6)
    println!("{}", scaled(5));                   // 50
}

fn normalize(values: &[i32]) -> Vec<i32> {
    // A nested helper: visible only inside `normalize`
    fn subtract_min(v: i32, min: i32) -> i32 {
        v - min                     // everything it needs comes in as a parameter
    }

    let min = *values.iter().min().unwrap_or(&0);
    values.iter().map(|&v| subtract_min(v, min)).collect()
}
```

| Form           | Can capture locals | Runs at compile time | Typical use               |
| -------------- | ------------------ | -------------------- | ------------------------- |
| Top-level `fn` | No                 | No                   | Ordinary code             |
| Nested `fn`    | No                 | No                   | A helper used by one function only |
| `const fn`     | No                 | Yes, when a const context requires it | Sizes, table generation, constants |
| Closure        | Yes                | No                   | Callbacks, iterator adapters |

> Key Takeaways
> - A nested `fn` is scoped to its enclosing function but cannot capture its
>   locals; that is what closures are for.
> - `const fn` may be evaluated at compile time and is still an ordinary function
>   at runtime.
> - Const contexts — array lengths, `const`/`static` initializers — accept only
>   `const fn` calls.
> - The subset of Rust allowed in a `const fn` is restricted but expands with
>   most releases.

> 🧪 Practice
> 1. Write a `const fn` that computes a buffer size and use it as an array length.
> 2. Move a small helper into a nested function and confirm the outer module can
>    no longer call it.
> 3. Interview: Why can a nested function not read a variable from the function
>    that contains it, while a closure defined at the same spot can? (Hint: think
>    about what data a plain function value carries with it, and what a closure
>    carries.)

#### Diverging Functions and panic!

A *diverging* function is one that never returns to its caller: its return type
is `!`. Sometimes divergence is the whole point of the function — an error
reporter that exits the process, a supervisor loop that runs until shutdown, or a
helper whose only job is to panic with a good message.

Panicking is Rust's mechanism for unrecoverable errors: a bug so severe that the
only sensible options are to stop the current thread or the process. It is
categorically different from `Result`, which represents failures a caller can
reasonably be expected to handle. The rule of thumb: a panic means "this program
is wrong", while a `Result` means "this operation did not work". A missing file
is a `Result`; an index off the end of an array your own code just built is a
panic.

The standard library provides a small vocabulary of panicking macros, each
signalling a different intent to the reader.

| Macro                 | Meaning                                         |
| --------------------- | ----------------------------------------------- |
| `panic!("msg")`       | An unrecoverable error, with a message           |
| `unreachable!()`      | This code is logically impossible to reach       |
| `todo!()`             | Not implemented yet; a deliberate placeholder    |
| `unimplemented!()`    | Intentionally never implemented for this case    |
| `assert!(cond)`       | Panic when an invariant does not hold            |
| `assert_eq!(a, b)`    | Panic on inequality, printing both values        |
| `debug_assert!(cond)` | The same, but compiled out in release builds     |

By default a panic *unwinds*: it runs the destructor of every value on the stack
in reverse order and then terminates the thread. Setting `panic = "abort"` in a
release profile terminates the process immediately instead, which produces a
smaller binary and is common in embedded work, at the cost of skipping cleanup.

```rust
use std::process;

fn main() {
    println!("{}", checked_index(&[1, 2, 3], 1));    // 2
    println!("{}", parse_port("8080"));              // 8080
    // println!("{}", parse_port("http"));           // exits with status 2

    let grade = 'B';
    println!("{}", points(grade));                   // 3

    assert_eq!(2 + 2, 4);                            // passes silently
    // assert!(1 > 2, "invariant broken: {} <= {}", 1, 2);   // would panic
}

// A diverging helper: its `-> !` lets callers use it in any type position
fn fatal(message: &str) -> ! {
    eprintln!("fatal: {message}");
    process::exit(2);
}

fn parse_port(s: &str) -> u16 {
    match s.parse() {
        Ok(p) => p,
        Err(_) => fatal("port must be a number"),   // `!` coerces to u16
    }
}

fn checked_index(xs: &[i32], i: usize) -> i32 {
    // Panicking is correct here: an out-of-range index is a caller bug,
    // not a runtime condition the caller can recover from
    assert!(i < xs.len(), "index {i} out of range for length {}", xs.len());
    xs[i]
}

fn points(grade: char) -> u32 {
    match grade {
        'A' => 4,
        'B' => 3,
        'C' => 2,
        'D' | 'F' => 0,
        // The caller's type says only these letters are possible, so anything
        // else means the program's own logic is broken
        _ => unreachable!("invalid grade: {grade}"),
    }
}
```

> Key Takeaways
> - A diverging function returns `!` and never hands control back to its caller.
> - Panic for bugs and broken invariants; return `Result` for failures a caller
>   can handle.
> - `unreachable!`, `todo!`, and `unimplemented!` are panics that document *why*
>   they are there.
> - Panics unwind and run destructors by default; `panic = "abort"` skips that
>   for a smaller, faster binary.

> 🧪 Practice
> 1. Write a function that panics with a formatted message when given a negative
>    number, and call it inside `assert!`-guarded code.
> 2. Replace a `todo!()` placeholder in a stub function with a real
>    implementation and observe the compiler's warnings before and after.
> 3. Interview: You are designing a library function that receives a string that
>    might not be valid UTF-8. Should it panic or return `Result`, and why? (Hint:
>    ask whether the caller could plausibly have prevented the situation.)

---

## 3. Ownership and Memory Model

Ownership is the idea the whole language is built around: every value has exactly
one owner, and when that owner goes away the value is cleaned up. From that one
rule Rust derives memory safety with no garbage collector, and the borrow checker
that enforces it is the source of both the language's guarantees and its steepest
learning curve. This chapter builds the model from the stack upward, then works
through borrowing, lifetimes, and the errors the checker actually reports.

<a id="31-ownership-rules"></a>
### 3.1 Ownership Rules

Ownership is three rules: each value has one owner, there is only ever one owner
at a time, and when the owner goes out of scope the value is dropped. This
section works out what each one means in practice.

#### Stack vs Heap Allocation

Every running program has two places to put data, and the difference between them
is why ownership exists at all.

The **stack** is a contiguous region that grows and shrinks with function calls.
Each call pushes a frame holding that function's local variables; returning pops
it. Because everything is added and removed at one end, allocation is a single
pointer adjustment — essentially free. The cost is rigidity: the size of every
value in a frame must be known at compile time, and the data dies when the
function returns.

The **heap** is a large pool where you can request a block of any size at
runtime. The allocator finds a suitable region, marks it used, and returns its
address. That flexibility buys you dynamically sized and long-lived data, and
costs a bookkeeping step on allocation, a step on release, and a pointer
indirection on every access.

Think of the stack as a stack of trays in a cafeteria: you take from the top and
return to the top, which is why it is fast and why you cannot pull one out of the
middle. The heap is the coat check: you hand over an item of any shape, get a
ticket (a pointer), and must return the ticket to get the space back. Losing a
ticket is a memory leak; using a ticket after collecting the coat is a
use-after-free.

A `String` shows both at once. The variable itself is a three-word value on the
stack — pointer, length, capacity — while the text lives in a heap buffer it
points to.

```rust
fn main() {
    let n = 42;                          // i32: 4 bytes, entirely on the stack
    let arr = [1u8, 2, 3];               // fixed size known at compile time: stack
    let s = String::from("hello");       // handle on the stack, text on the heap
    let boxed = Box::new(99);            // an i32 pushed onto the heap deliberately

    println!("{n} {arr:?} {s} {boxed}");
    println!("{}", std::mem::size_of_val(&s));   // 24 on 64-bit: ptr + len + cap
    println!("{}", s.len());                     // 5: bytes in the heap buffer
    println!("{}", s.capacity());                // 5: bytes the buffer can hold
}   // `s` and `boxed` go out of scope here: their heap allocations are released
```

```text
        STACK                                   HEAP
  +--------------------+
  | n    = 42          |
  | arr  = [1, 2, 3]   |
  |                    |
  | s (String)         |
  |   ptr  ------------|-------------------> +---+---+---+---+---+
  |   len  = 5         |                     | h | e | l | l | o |
  |   cap  = 5         |                     +---+---+---+---+---+
  |                    |
  | boxed (Box<i32>)   |
  |   ptr  ------------|-------------------> +----+
  +--------------------+                     | 99 |
                                             +----+
  Fast, fixed-size, freed                Flexible, sized at runtime, freed
  automatically when the                 when its owner is dropped
  frame is popped
```

| Property            | Stack                          | Heap                            |
| ------------------- | ------------------------------ | ------------------------------- |
| Allocation cost     | One pointer bump               | Allocator bookkeeping           |
| Size known when     | Compile time                   | Runtime                         |
| Access              | Direct                         | One pointer indirection         |
| Lifetime            | Ends with the function call    | Ends when the owner is dropped  |
| Typical residents   | Integers, `bool`, arrays, references, struct fields | `String`, `Vec<T>`, `Box<T>` contents |

> Key Takeaways
> - Stack allocation is a pointer bump and requires a compile-time known size;
>   heap allocation is flexible but costs bookkeeping and indirection.
> - A `String` or `Vec` is a small stack-resident handle pointing at a heap
>   buffer.
> - Stack data dies when its frame is popped; heap data dies when its owner is
>   dropped.
> - Ownership exists to answer one question: who is responsible for releasing
>   that heap block?

> 🧪 Practice
> 1. Print `size_of_val` for an `i32`, a `String`, and a `Box<i32>`, and explain
>    why the `String` is larger than the `Box`.
> 2. Create a `String`, push characters onto it in a loop, and print `len()` and
>    `capacity()` after each push to watch the buffer grow.
> 3. Interview: Why is stack allocation faster than heap allocation, and what do
>    you give up by using it? (Hint: think about what the allocator must search
>    for and what the stack never has to.)

#### Move Semantics

Consider what would have to happen if two variables could own the same heap
buffer. When the first goes out of scope, it frees the buffer. When the second
goes out of scope, it frees the same buffer again — a double free, one of the
classic memory-corruption bugs.

Languages solve this in different ways: C++ copies deeply by default (expensive)
or shares with `shared_ptr` (refcount overhead); Java and Go share freely and let
a garbage collector work out when nobody is looking. Rust picks a fourth option:
assignment *moves* ownership. The bits of the handle are copied, and the original
variable is marked invalid, so exactly one variable is responsible for the
buffer.

This is not a runtime operation — no flag is set, nothing is checked while the
program runs. The compiler tracks which variables are live and rejects any use of
a moved-from one. Move semantics are entirely a compile-time bookkeeping exercise
that happens to compile down to a memcpy of a few words.

```rust
fn main() {
    let s1 = String::from("hello");
    let s2 = s1;                    // MOVE: the handle is copied, `s1` invalidated

    println!("{s2}");               // hello
    // println!("{s1}");            // error[E0382]: borrow of moved value: `s1`
                                    // note: move occurs because `String` does not
                                    //       implement the `Copy` trait

    // Types stored entirely on the stack are copied instead of moved
    let a = 5;
    let b = a;                      // COPY: `i32` is `Copy`
    println!("{a} {b}");            // 5 5 — both remain usable

    // Moves also happen into collections, structs, and closures
    let name = String::from("Ada");
    let people = vec![name];        // `name` moved into the vector
    // println!("{name}");          // error[E0382]

    // Partial moves: one field can be moved out of a struct
    struct Person { name: String, age: u32 }
    let p = Person { name: String::from("Grace"), age: 45 };
    let who = p.name;               // moves the `name` field out of `p`
    println!("{who} {}", p.age);    // Grace 45 — `p.age` is still readable
    // println!("{:?}", p.name);    // error[E0382]: `p.name` was moved

    println!("{people:?}");         // ["Ada"]
}
```

```text
let s1 = String::from("hello");        let s2 = s1;

   s1                HEAP                s1  (invalidated)      HEAP
  +------+          +-------+           +------+               +-------+
  | ptr -|--------->|"hello"|           | ptr -|---- X         |"hello"|
  | len 5|          +-------+           | len 5|               +-------+
  | cap 5|                              | cap 5|                   ^
  +------+                              +------+                   |
                                        s2                         |
                                       +------+                    |
                                       | ptr -|--------------------+
                                       | len 5|
                                       | cap 5|   Only the handle was copied.
                                       +------+   The buffer has ONE owner.
```

> Key Takeaways
> - Assigning a non-`Copy` value moves ownership: the handle is copied and the
>   source becomes unusable.
> - Moves prevent double frees by guaranteeing exactly one owner per allocation.
> - Move checking is entirely a compile-time analysis; at runtime a move is just a
>   few bytes copied.
> - Moves happen on assignment, on passing to a function, on returning, and on
>   pushing into a collection.

> 🧪 Practice
> 1. Move a `String` into a second variable, then try to print the first and read
>    the resulting error message in full.
> 2. Move a `String` into a `Vec`, then try to use the original binding. Fix it
>    two ways: by cloning, and by restructuring the code.
> 3. Interview: Why does Rust invalidate the source of a move instead of copying
>    the heap data like C++ does by default? (Hint: consider what happens at the
>    end of scope for each variable, and what a deep copy would cost in a loop.)

#### Copy vs Clone

If every assignment moved, working with integers would be miserable. Rust
distinguishes two categories with two traits.

`Copy` is a *marker trait* saying "duplicating this value is just copying its
bits, and the duplicate needs no separate cleanup". Types that live entirely on
the stack qualify: integers, floats, `bool`, `char`, shared references, and
tuples or arrays of such types. When a type is `Copy`, assignment copies instead
of moving, and both variables remain valid. The copy is implicit precisely
because it is cheap and cannot go wrong.

`Clone` is the explicit, potentially expensive duplication. `String::clone`
allocates a new heap buffer and copies the bytes into it. Because that cost is
real, Rust makes you write `.clone()` — you should be able to see allocations in
the source.

The two traits interact by rule: `Copy` requires `Clone` (a supertrait), and a
type that implements `Drop` can never be `Copy`, since needing cleanup is exactly
what a bitwise duplicate cannot handle.

```rust
#[derive(Debug, Clone, Copy)]       // both: bitwise duplication is valid here
struct Point { x: i32, y: i32 }

#[derive(Debug, Clone)]             // Clone only: it owns a heap allocation
struct Label { text: String }

// #[derive(Clone, Copy)]
// struct Bad { text: String }      // error[E0204]: the trait `Copy` cannot be
                                    // implemented: `String` is not `Copy`

fn main() {
    let p1 = Point { x: 1, y: 2 };
    let p2 = p1;                    // COPY: 8 bytes duplicated
    println!("{p1:?} {}", p2.x + p2.y);   // Point { x: 1, y: 2 } 3 — both usable

    let l1 = Label { text: String::from("hi") };
    let l2 = l1.clone();            // explicit: allocates a second heap buffer
    println!("{} {}", l1.text, l2.text);  // hi hi — two independent buffers

    let l3 = l1;                    // MOVE: no clone, so `l1` is gone
    // println!("{l1:?}");          // error[E0382]
    println!("{l3:?}");             // Label { text: "hi" }

    // References are Copy; mutable references deliberately are not
    let value = 10;
    let r1 = &value;
    let r2 = r1;                    // copying a shared reference is fine
    println!("{r1} {r2}");          // 10 10
}
```

| Trait   | How it runs      | Cost              | Source is         | Implemented by       |
| ------- | ---------------- | ----------------- | ----------------- | -------------------- |
| `Copy`  | Implicit, on assignment | Bitwise copy | Still valid       | Stack-only types     |
| `Clone` | Explicit `.clone()` | Arbitrary, may allocate | Still valid | Anything that can duplicate itself |
| Neither | Move             | A few words copied | Invalidated      | Owning types by default |

> Key Takeaways
> - `Copy` types are duplicated implicitly on assignment and both bindings stay
>   valid.
> - `Clone` is explicit because it may allocate; `.clone()` marks the cost in the
>   source.
> - `Copy` requires `Clone`, and a type with a `Drop` implementation can never be
>   `Copy`.
> - `&T` is `Copy`; `&mut T` is not, because exclusivity is the whole point of a
>   mutable reference.

> 🧪 Practice
> 1. Derive `Clone` and `Copy` on a two-field struct of integers and confirm both
>    bindings stay usable after assignment.
> 2. Add a `String` field to that struct and observe the exact error when `Copy`
>    can no longer be derived.
> 3. Interview: Why can a type that implements `Drop` never implement `Copy`?
>    (Hint: imagine the destructor running for every bitwise duplicate.)

#### Ownership Transfer in Functions

Passing a value to a function follows exactly the same rule as assigning it to a
variable: non-`Copy` values move, `Copy` values are copied. The parameter becomes
the new owner, so when the function ends, the value is dropped there.

Returning transfers ownership back out. That gives a "give and take back" style —
pass ownership in, return it with the result — which works but is unbearable
after two parameters. The example below shows why references had to exist: the
whole point of the next section is to read a value without taking responsibility
for it.

```rust
fn main() {
    let s = String::from("hello");
    consume(s);                     // `s` is MOVED into the function
    // println!("{s}");             // error[E0382]: value borrowed after move

    let n = 5;
    copy_number(n);                 // `i32` is Copy, so `n` survives
    println!("{n}");                // 5

    // The awkward "give and take back" pattern, before references
    let s2 = String::from("hello");
    let (s2, len) = give_and_return(s2);   // ownership handed back in a tuple
    println!("{s2} has {len} bytes");      // hello has 5 bytes

    // The same job with a borrow: no ownership changes hands at all
    let s3 = String::from("hello");
    println!("{} bytes", borrow_len(&s3));  // 5 bytes
    println!("{s3} is still mine");         // hello is still mine

    // A function can also produce ownership out of nothing
    let made = make_string();
    println!("{made}");                     // built inside the function
}

fn consume(text: String) {
    println!("consumed {text}");
}   // `text` is dropped here — the caller's value is gone for good

fn copy_number(x: i32) {
    println!("copied {x}");
}   // only a copy is dropped; the caller's `n` is untouched

fn give_and_return(text: String) -> (String, usize) {
    let len = text.len();
    (text, len)                     // hand ownership back to the caller
}

fn borrow_len(text: &String) -> usize {
    text.len()                      // borrowed: nothing is dropped here
}

fn make_string() -> String {
    String::from("built inside the function")   // ownership moves to the caller
}
```

> Key Takeaways
> - Passing a non-`Copy` value to a function moves it; the function becomes the
>   owner and drops it at the end.
> - Returning a value transfers ownership to the caller.
> - The "take ownership and hand it back in a tuple" pattern works but is the
>   problem borrowing was invented to solve.
> - A function that only needs to read should take `&T`, not `T`.

> 🧪 Practice
> 1. Write a function that takes a `String` by value and prints it, then observe
>    the error when the caller tries to reuse the value.
> 2. Rewrite that function to borrow, and confirm the caller can still use the
>    string afterwards.
> 3. Interview: A function takes `Vec<String>` by value but only reads it. What
>    does that cost the caller, and what would you change? (Hint: think about what
>    the caller must do if it still needs the vector.)

#### Drop and RAII

RAII — Resource Acquisition Is Initialization — is the idea that a resource's
lifetime should be tied to a value's lifetime. Acquire the resource when you
create the value; release it when the value is destroyed. Rust applies this to
everything: heap memory, file handles, sockets, mutex guards, database
connections.

The mechanism is the `Drop` trait. Implement `drop(&mut self)` and the compiler
inserts a call at the exact point the value goes out of scope. That is what makes
"forgetting to close the file" structurally impossible: closing is not something
you remember to do, it is something that happens because the value ended.

The rules for *when* are worth memorizing:

- Local variables are dropped in **reverse** order of declaration (the last
  declared is the first dropped), mirroring how the stack unwinds.
- A struct's fields are dropped in **declaration** order, after the struct's own
  `Drop::drop` runs.
- Elements of a `Vec` are dropped front to back.
- A moved-from value is not dropped in the original scope; the new owner drops it.

You cannot call `.drop()` yourself (`error[E0040]`) because that would leave the
value in place for the automatic drop to run again. To drop early, hand the value
to `std::mem::drop`, which simply takes ownership and lets it fall out of scope.

```rust
struct Noisy(&'static str);

impl Drop for Noisy {
    // Called automatically when a `Noisy` goes out of scope
    fn drop(&mut self) {
        println!("dropping {}", self.0);
    }
}

fn main() {
    let _first = Noisy("first");
    let _second = Noisy("second");

    {
        let _inner = Noisy("inner");
        println!("inner scope ends now");
    }   // "dropping inner" prints here, at the closing brace

    let early = Noisy("early");
    drop(early);                    // std::mem::drop: takes ownership, drops it now
    // early.drop();                // error[E0040]: explicit use of destructor method

    let moved = Noisy("moved");
    take(moved);                    // dropped inside `take`, not here

    println!("main is ending");
}   // reverse declaration order: "second" drops before "first"

fn take(n: Noisy) {
    println!("took {}", n.0);
}   // "dropping moved" prints here
```

Running the program prints:

```text
inner scope ends now
dropping inner
dropping early
took moved
dropping moved
main is ending
dropping second
dropping first
```

The standard library relies on this everywhere: `File` closes its descriptor in
`Drop`, `MutexGuard` releases the lock in `Drop`, and `Box`, `String`, and `Vec`
free their allocations in `Drop`.

> Key Takeaways
> - `Drop::drop` runs automatically at end of scope, tying resource release to a
>   value's lifetime.
> - Locals drop in reverse declaration order; struct fields drop in declaration
>   order.
> - Calling `.drop()` directly is an error; use `std::mem::drop(value)` to release
>   early.
> - A moved value is dropped by its new owner, not at the original binding's
>   scope end.

> 🧪 Practice
> 1. Write a struct with a `Drop` implementation and three instances, and predict
>    the print order before running it.
> 2. Use `std::mem::drop` to release one of them early and confirm the output
>    order changes.
> 3. Interview: How does RAII make "forgetting to close a file" impossible, and
>    what does the same mechanism give you when a function panics halfway
>    through? (Hint: think about what unwinding does to every value on the stack.)

<a id="32-references-and-borrowing"></a>
### 3.2 References and Borrowing

Moving ownership for every function call is impractical, so Rust lets you lend a
value instead. A reference borrows access without taking responsibility, under
rules strict enough that the compiler can prove nothing goes wrong.

#### Shared References

A shared reference, written `&T`, is a pointer that grants read access to a value
someone else owns. Creating one is called *borrowing*: the owner keeps ownership
and its responsibility to clean up, and the borrow simply must end before the
owner does.

The library-card analogy is apt. Borrowing a book gives you the right to read it;
the library still owns it, and you must return it before the library can discard
it. Several people can read a photocopy at once — and, crucially, no one may
scribble in the book while others are reading.

Shared references are cheap: one machine word, `Copy`, and freely duplicated. You
can have as many as you like at the same time, because reading concurrently can
never produce an inconsistent result.

Two ergonomics features hide most of the pointer mechanics. *Automatic
dereferencing* means `r.len()` works on a `&String` without writing `(*r).len()`.
*Deref coercion* means a `&String` is accepted where `&str` is expected, and a
`&Vec<T>` where `&[T]` is expected — which is why idiomatic signatures use the
slice types.

```rust
fn main() {
    let s = String::from("hello");

    let r1 = &s;                    // borrow: `s` still owns the buffer
    let r2 = &s;                    // any number of shared borrows may coexist
    let r3 = r1;                    // `&T` is Copy, so this copies the reference

    println!("{r1} {r2} {r3}");     // hello hello hello
    println!("{}", r1.len());       // 5 — auto-deref: no need for (*r1).len()
    println!("{}", *r1 == s);       // true — explicit deref compares the values
    println!("{s}");                // the owner is still perfectly usable

    // Deref coercion: &String is accepted where &str is required
    println!("{}", char_count(&s));         // 5
    let v = vec![1, 2, 3];
    println!("{}", sum(&v));                // 6 — &Vec<i32> coerces to &[i32]

    // A borrow cannot outlive what it points to; here it clearly does not
    let total: i32 = { let nums = [1, 2, 3]; sum(&nums) };
    println!("{total}");                    // 6
}

fn char_count(text: &str) -> usize {        // takes &str, so both &String and
    text.chars().count()                    // &str literals work at the call site
}

fn sum(values: &[i32]) -> i32 {             // takes a slice, not &Vec<i32>
    values.iter().sum()
}
```

> Key Takeaways
> - `&T` grants read access without transferring ownership; the owner still frees
>   the value.
> - Any number of shared references may exist simultaneously.
> - `&T` is `Copy` and one word wide, so passing references is cheap.
> - Auto-deref and deref coercion let `&String` act as `&str` and `&Vec<T>` as
>   `&[T]`; prefer the slice types in signatures.

> 🧪 Practice
> 1. Create a `String`, take three shared references to it, and print all three
>    plus the original.
> 2. Write `fn longest_word(text: &str) -> &str` and call it with both a `String`
>    reference and a string literal.
> 3. Interview: Why is `&T` `Copy` when `T` might not be? (Hint: ask what
>    resources the reference itself owns.)

#### Mutable References

A mutable reference, `&mut T`, grants write access to someone else's value. It
comes with a much stronger condition than a shared reference: while it exists, it
is the *only* way to reach that value. No other reference, mutable or shared, and
not even the owner, may be used until the mutable borrow ends.

Two requirements follow. First, you can only take `&mut x` if `x` itself is a
mutable binding — you cannot acquire more permission than the owner has. Second,
`&mut T` is deliberately not `Copy`: copying it would create a second path to the
same data, which is exactly what exclusivity forbids. Passing one to a function
instead performs a *reborrow*, which suspends the original until the callee
returns.

Writing through a mutable reference uses `*` to reach the value, though method
calls and compound assignment auto-deref as usual.

```rust
fn main() {
    let mut count = 10;
    let r = &mut count;             // exclusive borrow of `count` begins
    *r += 5;                        // write through the reference
    // println!("{count}");         // error[E0502]: `count` is borrowed here
    println!("{r}");                // 15 — last use of `r`, so the borrow ends
    println!("{count}");            // 15 — the owner is usable again

    let mut v = vec![1, 2, 3];
    push_twice(&mut v);             // reborrow into the function
    println!("{v:?}");              // [1, 2, 3, 10, 20]

    // Method calls that mutate take &mut self implicitly
    v.sort();
    v.reverse();
    println!("{v:?}");              // [20, 10, 3, 2, 1]

    // The owner must itself be mutable
    let fixed = 5;
    // let bad = &mut fixed;        // error[E0596]: cannot borrow `fixed` as
                                    // mutable, as it is not declared as mutable
    println!("{fixed}");

    // Mutating through a reference held in a struct field or a slice element
    let mut scores = [1, 2, 3];
    if let Some(first) = scores.first_mut() {
        *first = 100;
    }
    println!("{scores:?}");         // [100, 2, 3]
}

fn push_twice(values: &mut Vec<i32>) {
    values.push(10);
    values.push(20);
}   // the reborrow ends here; the caller's borrow is usable again
```

| Reference | How many at once | Grants | Is `Copy` | Owner usable meanwhile |
| --------- | ---------------- | ------ | --------- | ---------------------- |
| `&T`      | Any number       | Read   | Yes       | For reading            |
| `&mut T`  | Exactly one      | Read and write | No | No                    |

> Key Takeaways
> - `&mut T` is an *exclusive* borrow: while it lives, nothing else may read or
>   write the value, including the owner.
> - Taking `&mut x` requires `x` to be a `mut` binding.
> - `&mut T` is not `Copy`; passing it to a function reborrows it for the duration
>   of the call.
> - Write through it with `*r = ...`; method calls and `+=` auto-deref.

> 🧪 Practice
> 1. Take a mutable reference to an integer, increment it through the reference,
>    and print the owner afterwards.
> 2. Write `fn scale(v: &mut Vec<i32>, factor: i32)` that multiplies every element
>    in place.
> 3. Interview: Why is `&mut T` not `Copy` when `&T` is? (Hint: what invariant
>    would a second copy of a mutable reference break?)

#### Aliasing XOR Mutability Rule

Everything in the borrow checker follows from one rule, and it is worth stating
in isolation:

> At any point in the program, for any piece of data, you may have **either** any
> number of shared references **or** exactly one mutable reference — never both.

*Aliasing* means two pointers reaching the same data. *Mutation* means changing
it. Either is safe alone; together they are the root of a startling share of all
memory bugs. Iterator invalidation, data races, and the surprises that make C
compilers conservative are all aliasing plus mutation.

The classic demonstration needs no threads at all. Take a reference to a vector's
first element, then push onto the vector. If the push exceeds capacity, the
vector allocates a bigger buffer, copies the elements over, and frees the old
one — and your reference now points into freed memory. C++ permits this and it is
undefined behavior; Rust makes it a compile error.

The rule also pays for performance. Because a `&mut T` is guaranteed unaliased,
the compiler can keep values in registers across calls and reorder reads and
writes in ways a C compiler cannot justify without `restrict`.

```rust
fn main() {
    let mut v = vec![1, 2, 3];

    // Many shared borrows: fine, nothing can change underneath them
    let a = &v[0];
    let b = &v[1];
    println!("{a} {b}");            // 1 2

    // The dangerous pattern, rejected at compile time
    let first = &v[0];              // immutable borrow starts
    // v.push(4);                   // error[E0502]: cannot borrow `v` as mutable
                                    // because it is also borrowed as immutable
    println!("{first}");            // ...borrow is still live here

    v.push(4);                      // fine now: `first` is no longer used
    println!("{v:?}");              // [1, 2, 3, 4]

    // Two mutable borrows at once
    let m1 = &mut v;
    // let m2 = &mut v;             // error[E0499]: cannot borrow `v` as mutable
                                    // more than once at a time
    m1.push(5);
    println!("{v:?}");              // [1, 2, 3, 4, 5]
}
```

```text
Why `push` while borrowed is forbidden:

  before push                        after push (capacity exceeded)
  v -> [1|2|3]  (cap 3)              v -> [1|2|3|4|_|_]  (new buffer, cap 6)
        ^                                  
        |                                  old buffer FREED
  first -+                           first -+  ...still pointing at freed memory

  In C++ this compiles and is undefined behavior.
  In Rust it is error[E0502], caught before the program ever runs.
```

| Situation                        | Allowed | Reason                          |
| -------------------------------- | ------- | ------------------------------- |
| Many `&T` at once                | Yes     | Readers cannot disagree         |
| One `&mut T` alone               | Yes     | No other path to the data       |
| `&T` and `&mut T` together       | No      | The reader could see a torn value |
| Two `&mut T` at once             | No      | Both could write simultaneously |
| Owner used while borrowed mutably| No      | The owner is another alias      |

> Key Takeaways
> - The whole borrow checker reduces to: many readers XOR one writer.
> - Aliasing and mutation are each safe alone; combining them causes iterator
>   invalidation, data races, and use-after-free.
> - The rule is enforced at compile time with zero runtime cost.
> - Guaranteed non-aliasing also unlocks optimizations that C compilers cannot
>   safely perform.

> 🧪 Practice
> 1. Hold a reference to `v[0]`, call `v.push(...)`, and read the resulting
>    `E0502` message closely.
> 2. Fix that code two ways: by narrowing the borrow's scope, and by copying the
>    value out before pushing.
> 3. Interview: Explain why "many readers or one writer" prevents data races
>    without any runtime locking. (Hint: define a data race precisely, then check
>    which of its conditions the rule removes.)

#### Dangling Reference Prevention

A dangling reference points at memory that no longer holds the value it was
created for. In C it is trivial to produce one — return the address of a local
variable and the frame is gone by the time the caller reads it. The result is not
a crash but something worse: whatever bytes happen to be there now.

Rust prevents this categorically by tracking, for every reference, the region of
code where the referent is guaranteed to be alive. If a reference could outlive
its referent, the program does not compile. There is no runtime check and no null
value to test — the situation simply cannot be expressed.

The error appears in two forms. When a function tries to return a reference to a
local, you get `E0106` (the compiler cannot work out what the returned reference
would borrow from) or `E0515` (returning a reference to a local variable). The
fix is almost always to return owned data, or to return a reference derived from
one of the *inputs*, which the caller already keeps alive.

```rust
fn main() {
    let s = String::from("hello world");
    println!("{}", first_word(&s));      // hello — borrowed from the caller's data
    println!("{}", make_greeting());     // hello — owned, moved to the caller

    // Also caught: a reference outliving the scope of what it points to
    // let dangling;
    // {
    //     let temp = String::from("short-lived");
    //     dangling = &temp;             // error[E0597]: `temp` does not live
    // }                                 //               long enough
    // println!("{dangling}");
    println!("{s}");
}

// Returning a reference derived from an INPUT is fine: the caller owns the data
fn first_word(text: &str) -> &str {
    match text.find(' ') {
        Some(i) => &text[..i],
        None => text,
    }
}

// fn dangle() -> &String {              // error[E0106]: missing lifetime specifier
//     let s = String::from("hello");    // error[E0515]: cannot return reference
//     &s                                //               to local variable `s`
// }                                     // `s` is dropped right here

// The fix: return ownership instead of a borrow
fn make_greeting() -> String {
    String::from("hello")
}
```

```text
C:                                    Rust:

char *f(void) {                       fn f() -> &String {
    char buf[16];                         let s = String::from("hi");
    return buf;   /* compiles! */         &s        // error[E0515]
}                 /* frame gone */    }             // will not compile

Caller reads freed stack memory.      No program with this bug can be built.
```

> Key Takeaways
> - Rust tracks how long each referent lives and rejects any reference that could
>   outlive it.
> - Returning a reference to a local is `E0515`; the compiler asks for a lifetime
>   with `E0106` when it cannot infer the origin.
> - Returning a reference derived from a parameter is fine, because the caller
>   keeps that data alive.
> - When in doubt, return owned data — the borrow checker is telling you the
>   ownership is unclear.

> 🧪 Practice
> 1. Write a function that tries to return a reference to a local `String` and
>    read both errors it produces.
> 2. Fix it twice: once by returning `String`, once by taking an input reference
>    and returning a slice of it.
> 3. Interview: A C function returning a pointer to a local compiles fine and
>    fails at runtime. What information does Rust's compiler have that C's does
>    not? (Hint: think about what a lifetime records about a reference's type.)

#### Slice References

A slice is a reference to a contiguous *part* of a collection: `&[T]` for arrays
and vectors, `&str` for strings. It stores a pointer and a length, owns nothing,
and keeps the borrow rules of any other reference.

The value of slices is that they make "a range inside this collection" a
first-class thing the borrow checker understands. Before slices, a function
scanning for a word would return an index — and an index is just a number, with
no connection to the collection it came from. Clear the string and the index is
silently stale. Return a slice instead, and the borrow keeps the string
immutable for as long as the slice is alive.

String slices carry one extra rule: `&s[i..j]` indexes *bytes*, and the
boundaries must fall on character boundaries in the UTF-8 encoding. Slicing
through a multi-byte character panics rather than producing invalid text.

```rust
fn main() {
    let mut s = String::from("hello world");

    let word = first_word(&s);      // an immutable borrow of `s` lives in `word`
    // s.clear();                   // error[E0502]: cannot borrow `s` as mutable
                                    // `clear` takes &mut self, and `word` is live
    println!("{word}");             // hello — after this, the borrow ends
    s.clear();                      // now allowed
    println!("{:?}", s);            // ""

    let nums = [10, 20, 30, 40, 50];
    let middle = &nums[1..4];       // [20, 30, 40]
    let all = &nums[..];            // the whole array as a slice
    println!("{middle:?} {} {}", all.len(), middle[0]);   // [20, 30, 40] 5 20

    // Slices of a Vec behave identically
    let v = vec![1, 2, 3, 4];
    println!("{:?}", &v[2..]);      // [3, 4]

    // String slices index BYTES and must land on char boundaries
    let text = String::from("héllo");         // 'é' occupies two bytes
    println!("{}", &text[0..1]);              // h
    // println!("{}", &text[0..2]);           // panics: byte index 2 is not a
                                              // char boundary
    println!("{}", &text[0..3]);              // hé
    println!("{} {}", text.len(), text.chars().count());   // 6 5
}

fn first_word(text: &str) -> &str {
    let bytes = text.as_bytes();
    for (i, &b) in bytes.iter().enumerate() {
        if b == b' ' {              // b' ' is the space character as a u8
            return &text[..i];      // a slice tied to the caller's string
        }
    }
    text
}
```

```text
let s = String::from("hello world");
let word = first_word(&s);

  s (String)            HEAP
  +-------+            +---+---+---+---+---+---+---+---+---+---+---+
  | ptr --|----------->| h | e | l | l | o |   | w | o | r | l | d |
  | len 11|            +---+---+---+---+---+---+---+---+---+---+---+
  | cap 11|              ^           
  +-------+              |
  word (&str)            |
  +-------+              |
  | ptr --|--------------+
  | len 5 |     Borrowing keeps `s` immutable while `word` is alive,
  +-------+     so the buffer cannot be cleared or reallocated underneath.
```

> Key Takeaways
> - A slice is a borrowed view of part of a collection: a pointer plus a length,
>   owning nothing.
> - Because a slice borrows, the collection cannot be mutated while the slice is
>   alive — stale indices become impossible.
> - `&str` indexes bytes and panics if a boundary falls inside a multi-byte
>   character.
> - Prefer `&str` and `&[T]` parameters so callers can pass whole collections or
>   any part of one.

> 🧪 Practice
> 1. Write `fn second_word(text: &str) -> &str` returning the second
>    space-separated word.
> 2. Take a slice of a `Vec`, then try to `push` while the slice is alive, and fix
>    the error by scoping the slice.
> 3. Interview: The book's `first_word` originally returned a `usize` index. What
>    class of bug does returning `&str` eliminate? (Hint: think about what happens
>    to an index when the string is cleared, and what the borrow checker knows
>    about a slice that it cannot know about a number.)

<a id="33-lifetimes"></a>
### 3.3 Lifetimes

Lifetimes are how the compiler expresses "this reference is valid for at least
this long". Most of the time they are inferred; this section covers the cases
where you have to write them down and what they actually mean.

#### Lifetime Annotations

Every reference has a lifetime: the region of the program over which it is
guaranteed valid. Usually the compiler works it out alone. The exception is when
a function returns a reference and there is more than one candidate source for
it — then the compiler cannot know which input the result borrows from, and it
asks you.

The critical misconception to clear up first: **a lifetime annotation does not
change how long anything lives**. Writing `'a` does not extend a value's life by
a single instruction. It *describes a relationship* the caller must satisfy, so
the compiler can check both sides. It is a type-level constraint, exactly like a
generic type parameter — which is why it is declared in the same angle brackets.

`fn longest<'a>(x: &'a str, y: &'a str) -> &'a str` reads: for any lifetime `'a`,
if both arguments are valid for `'a`, the result is valid for `'a` too. In
practice `'a` becomes the *shorter* of the two inputs' lifetimes, because that is
the largest region where the promise holds.

```rust
fn main() {
    let long = String::from("a long string");
    {
        let short = String::from("short");
        // 'a is inferred as the shorter of the two: the inner scope
        let result = longest(&long, &short);
        println!("longest: {result}");      // longest: a long string
    }   // `short` dies here, and so may anything borrowed from it

    // This does not compile, and the annotation is what catches it:
    // let outer;
    // {
    //     let temp = String::from("temporary");
    //     outer = longest(&long, &temp);   // error[E0597]: `temp` does not live
    // }                                    //               long enough
    // println!("{outer}");

    // Two lifetimes: the result is known to borrow only from the first argument
    println!("{}", first_of(&long, "ignored"));   // a long string

    // When the result cannot borrow from an input, do not annotate: return owned
    println!("{}", combine(&long, "!"));    // a long string!
}

// Both parameters and the result share one lifetime parameter
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x } else { y }
}

// A second lifetime says the result never borrows from `y`
fn first_of<'a, 'b>(x: &'a str, _y: &'b str) -> &'a str {
    x
}

fn combine(a: &str, b: &str) -> String {    // returns owned data: no lifetimes
    format!("{a}{b}")
}
```

```text
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str

  long  |===========================================|   lives longer
  short          |=======================|              lives shorter
  'a             |=======================|              the OVERLAP
  result         |=======================|              valid only here

  Using `result` after `short` dies is exactly what the annotation forbids.
```

> Key Takeaways
> - A lifetime is the region over which a reference is guaranteed valid.
> - Annotations describe relationships between input and output references; they
>   never extend how long a value lives.
> - `'a` resolves to the overlap of the annotated inputs — effectively the
>   shortest of them.
> - If the result cannot borrow from any input, return an owned value instead of
>   reaching for a lifetime.

> 🧪 Practice
> 1. Write `longest` yourself and call it with two strings from different scopes
>    so the error appears, then fix the scoping.
> 2. Write `fn prefix<'a>(text: &'a str, _sep: &str) -> &'a str` returning
>    everything before the first space, and explain why only one parameter needs
>    an annotation.
> 3. Interview: Does `'a` make a value live longer? Explain what it actually does.
>    (Hint: think about whether the annotation is an instruction to the code
>    generator or a constraint checked against the caller.)

#### Lifetime Elision Rules

If lifetimes were always written out, every signature taking a reference would be
noisy. In practice you write them rarely, because the compiler applies three
mechanical *elision rules* first and only asks for annotations when they fail to
determine an answer.

The rules, applied in order:

1. Every elided lifetime in the parameters gets its **own distinct** lifetime
   parameter.
2. If there is **exactly one** input lifetime, it is assigned to every elided
   output lifetime.
3. If one of the parameters is `&self` or `&mut self`, **`self`'s lifetime** is
   assigned to every elided output lifetime.

If output lifetimes remain undetermined after all three, compilation fails with
`E0106` and you must annotate. These are not inference — they are a fixed
shorthand expansion, which is why they are predictable.

| Written signature                          | After elision                                     | Works? |
| ------------------------------------------ | ------------------------------------------------- | ------ |
| `fn f(s: &str) -> &str`                    | `fn f<'a>(s: &'a str) -> &'a str`                 | Yes, rule 2 |
| `fn f(x: &str, y: &str) -> &str`           | Two input lifetimes, output undetermined          | No, `E0106` |
| `fn f(&self, x: &str) -> &str`             | `fn f<'a, 'b>(&'a self, x: &'b str) -> &'a str`   | Yes, rule 3 |
| `fn f(s: &str) -> usize`                   | No output reference to determine                  | Yes |

```rust
struct Parser<'a> {
    input: &'a str,
    position: usize,
}

impl<'a> Parser<'a> {
    fn new(input: &'a str) -> Self {
        Parser { input, position: 0 }
    }

    // Rule 3: the returned &str borrows from `self`, no annotation needed
    fn remaining(&self) -> &str {
        &self.input[self.position..]
    }

    // Explicit form of the same thing, for comparison
    fn remaining_explicit<'s>(&'s self) -> &'s str {
        &self.input[self.position..]
    }

    fn advance(&mut self, n: usize) {
        self.position += n;
    }
}

// Rule 2: one input lifetime, so the output borrows from it
fn trim_start(text: &str) -> &str {
    text.trim_start()
}

// Rules 1 and 2 do not settle this one: two inputs, one output reference
// fn pick(a: &str, b: &str) -> &str { a }   // error[E0106]
fn pick<'a>(a: &'a str, _b: &str) -> &'a str {
    a
}

fn main() {
    let text = String::from("hello world");
    let mut parser = Parser::new(&text);
    println!("{}", parser.remaining());          // hello world
    parser.advance(6);
    println!("{}", parser.remaining());          // world
    println!("{}", parser.remaining_explicit()); // world
    println!("{}", trim_start("   padded"));     // padded
    println!("{}", pick("first", "second"));     // first
}
```

> Key Takeaways
> - Three mechanical rules cover the vast majority of signatures, so annotations
>   are rare in practice.
> - Rule 2 (one input lifetime) and rule 3 (`&self` wins) are the two that fire
>   most often.
> - Elision is a fixed expansion, not inference — you can always work out what
>   the compiler wrote.
> - When the rules leave an output lifetime undetermined, you get `E0106` and must
>   annotate.

> 🧪 Practice
> 1. Expand `fn f(&self, other: &str) -> &str` by hand into its fully annotated
>    form.
> 2. Write a two-reference-parameter function returning a reference, watch it fail
>    with `E0106`, and fix it with the minimum annotation.
> 3. Interview: Why does rule 3 pick `self`'s lifetime rather than another
>    parameter's? (Hint: think about what a method usually returns a view into.)

#### Lifetimes in Structs and Impls

A struct may hold references instead of owned data, which is how you build
zero-copy parsers and views. The price is that the struct becomes *generic over a
lifetime*: `struct Excerpt<'a> { part: &'a str }` means "an `Excerpt` cannot
outlive the string slice it points into".

That reads as a constraint on instances, and the compiler enforces it exactly:
create an `Excerpt` borrowing from a `String`, and the `Excerpt` must be gone
before the `String` is dropped.

Implementation blocks must declare the lifetime too, because `impl<'a>
Excerpt<'a>` is an implementation for every possible `'a`, just as `impl<T>
Wrapper<T>` covers every `T`.

A limit worth knowing early: a struct cannot hold a reference to *its own* field.
Such a self-referential type cannot be expressed with lifetimes, because moving
the struct would invalidate the internal pointer. That problem is what `Pin` and
crates like `ouroboros` exist for, and it is why an owned field plus an index is
the common workaround.

```rust
// The struct borrows; it may not outlive what it borrows from
#[derive(Debug)]
struct Excerpt<'a> {
    part: &'a str,
}

impl<'a> Excerpt<'a> {              // an impl for every lifetime 'a
    fn new(part: &'a str) -> Self {
        Excerpt { part }
    }

    // Rule 3 applies: the result borrows from `self`
    fn first_char(&self) -> &str {
        &self.part[..1]
    }

    // Returning a reference tied to the BORROWED data, not to `self`
    fn into_part(self) -> &'a str {
        self.part
    }
}

fn main() {
    let novel = String::from("Call me Ishmael. Some years ago...");
    let sentence = novel.split('.').next().expect("no sentence found");
    let excerpt = Excerpt::new(sentence);

    println!("{:?}", excerpt);              // Excerpt { part: "Call me Ishmael" }
    println!("{}", excerpt.first_char());   // C
    println!("{}", excerpt.into_part());    // Call me Ishmael

    // The lifetime constraint in action:
    // let dangling;
    // {
    //     let temp = String::from("temporary text");
    //     dangling = Excerpt::new(&temp);  // error[E0597]: `temp` does not live
    // }                                    //               long enough
    // println!("{dangling:?}");
    println!("{}", novel.len());            // 34
}
```

| Struct style                     | Owns data | Can outlive the source | Typical use          |
| -------------------------------- | --------- | ---------------------- | -------------------- |
| `struct S { text: String }`      | Yes       | Yes                    | The default choice   |
| `struct S<'a> { text: &'a str }` | No        | No                     | Zero-copy views, parsers |

> Key Takeaways
> - A struct holding references is generic over a lifetime and cannot outlive the
>   data it borrows.
> - `impl<'a> Type<'a>` declares the lifetime just like a generic type parameter.
> - Borrowing structs enable zero-copy parsing but constrain where instances can
>   be stored.
> - Self-referential structs cannot be written with plain lifetimes; own the data
>   and store an index instead.

> 🧪 Practice
> 1. Define `struct Words<'a> { text: &'a str }` with a method returning the first
>    word, and construct one from a `String`.
> 2. Try to return an `Excerpt` from a function that creates the `String` locally,
>    and explain the resulting error.
> 3. Interview: When would you choose `struct Config<'a> { name: &'a str }` over
>    `struct Config { name: String }`? (Hint: weigh avoided allocations against
>    where the value needs to be stored and how long it must live.)

#### The 'static Lifetime

`'static` is the lifetime of data that lives for the entire run of the program.
It appears in two very different-looking positions, and confusing them is a
common source of frustration.

As a **reference lifetime**, `&'static T` means "this reference is valid
forever". String literals are the canonical example: their bytes are baked into
the binary, so `let s: &'static str = "hello";` is always true. Values leaked
deliberately with `Box::leak` also qualify.

As a **trait bound**, `T: 'static` means something weaker and much more common:
"this type contains no references with a lifetime shorter than `'static`". Every
owned type satisfies it — `String`, `Vec<u8>`, and `i32` are all `T: 'static`,
because they borrow nothing. The bound appears on thread spawning and on
`Box<dyn Error + 'static>` not because those values must live forever, but
because they must not depend on a borrow that could expire.

The mistake to avoid is treating `'static` as a fix for a lifetime error. If the
compiler complains that a value does not live long enough, adding `'static` to
the signature usually just moves the error to the caller. The real fix is
normally to own the data or to restructure the borrow.

```rust
use std::thread;

// A string literal is baked into the binary: its bytes outlive everything
static BANNER: &str = "welcome";
const VERSION: &'static str = "1.0";        // the annotation is redundant here

fn main() {
    let literal: &'static str = "hello";
    println!("{literal} {BANNER} {VERSION}");    // hello welcome 1.0

    // `T: 'static` as a BOUND means "owns its data", not "lives forever"
    let owned = String::from("moved into the thread");
    let handle = thread::spawn(move || {
        // The closure must be 'static: it may outlive `main`'s frame, so it
        // cannot capture any reference to a local. Owned data satisfies this.
        println!("{owned}");
    });
    handle.join().unwrap();

    println!("{}", describe(String::from("owned value")));   // owned value
    println!("{}", describe("a literal"));                   // a literal

    // Deliberately leaking to obtain a &'static str at runtime
    let built = format!("built at runtime").into_boxed_str();
    let computed: &'static str = Box::leak(built);
    println!("{computed}");                                  // built at runtime
}

// `T: 'static` accepts String, &'static str, i32 — anything free of short borrows
fn describe<T: std::fmt::Display + 'static>(value: T) -> String {
    format!("{value}")
}
```

| Form           | Means                                            | Satisfied by                |
| -------------- | ------------------------------------------------ | --------------------------- |
| `&'static T`   | This reference is valid for the whole program     | Literals, leaked values, statics |
| `T: 'static`   | This type holds no references shorter than `'static` | All owned types, and `&'static T` |

> Key Takeaways
> - `&'static T` is a reference valid for the whole program; string literals are
>   the everyday example.
> - `T: 'static` is a bound meaning "contains no short-lived borrows", which every
>   owned type satisfies.
> - `thread::spawn` requires `'static` because the thread may outlive the
>   spawning frame, not because data must live forever.
> - Adding `'static` to silence a borrow error usually relocates the error rather
>   than fixing it.

> 🧪 Practice
> 1. Bind a string literal to a `&'static str` and pass it to a function requiring
>    that type.
> 2. Try to `thread::spawn` a closure capturing a local `String` by reference,
>    read the error, and fix it with `move`.
> 3. Interview: `String` is not a reference, so why does it satisfy `T: 'static`?
>    (Hint: restate the bound as a claim about what the type contains rather than
>    about how long a value lives.)

#### Higher-Ranked Trait Bounds

Some functions take a callback that must work for references of *any* lifetime,
not for one specific lifetime chosen by the caller. Ordinary generic parameters
cannot express that: `fn apply<'a, F: Fn(&'a str) -> &'a str>` lets the caller
pick one `'a` up front, so a closure that must handle a shorter borrow created
*inside* `apply` will not fit.

A higher-ranked trait bound (HRTB) says "for all lifetimes". The syntax is
`for<'a> Fn(&'a str) -> &'a str`, read as: this closure is callable with a
reference of any lifetime whatsoever, and the returned reference matches whatever
was passed in.

You have used HRTBs already without noticing, because the same elision rules
apply to `Fn` bounds: writing `F: Fn(&str) -> &str` expands to the `for<'a>`
form automatically. Writing it explicitly matters for `dyn` trait objects,
stored callbacks, and one notorious papercut — a *closure* is not inferred as
higher-ranked on its own. The compiler picks one concrete lifetime for
`|s: &str| s.trim()` and then reports "one type is more general than the other"
at the call. A plain `fn` item has no such problem, and a closure can be forced
into the higher-ranked form by passing it through a helper carrying the bound.

```rust
// Elided form: the compiler expands this to `for<'a> Fn(&'a str) -> &'a str`
fn apply_elided<F: Fn(&str) -> &str>(f: F, text: &str) -> String {
    f(text).to_string()
}

// The same bound written out explicitly
fn apply_hrtb<F>(f: F, text: &str) -> String
where
    F: for<'a> Fn(&'a str) -> &'a str,   // "for ALL lifetimes 'a"
{
    // The bound must hold for this locally created borrow too, whose lifetime
    // is shorter than anything the caller could have named
    let local = String::from("local text");
    let inner = f(&local);
    format!("{} | {}", f(text), inner)
}

// A plain `fn` item is higher-ranked automatically
fn first_word(s: &str) -> &str {
    s.split(' ').next().unwrap_or(s)
}

// Closures are not. Passing one through a helper that carries the bound is the
// standard trick to force the higher-ranked inference.
fn as_hrtb<F: for<'a> Fn(&'a str) -> &'a str>(f: F) -> F {
    f
}

// Storing such a callback also requires the explicit form
struct Transformer {
    op: Box<dyn for<'a> Fn(&'a str) -> &'a str>,
}

fn main() {
    println!("{}", apply_elided(first_word, "hello there"));   // hello
    println!("{}", apply_hrtb(first_word, "hello there"));     // hello | local

    // let closure = |s: &str| s.trim();
    // apply_hrtb(closure, "  padded  ");   // error[E0308]: one type is more
                                            // general than the other - the
                                            // closure got ONE fixed lifetime

    let trimmer = as_hrtb(|s| s.trim());    // now inferred as for<'a>
    println!("{}", apply_hrtb(trimmer, "  padded  "));   // padded | local text

    let t = Transformer { op: Box::new(|s: &str| s.trim()) };
    println!("[{}]", (t.op)("  padded  "));              // [padded]
}
```

> Key Takeaways
> - An HRTB (`for<'a>`) means a bound holds for *every* lifetime, not for one the
>   caller chooses.
> - It is required when a callback must accept references created inside the
>   callee.
> - `Fn(&str) -> &str` already elides to a `for<'a>` bound, so most code never
>   writes it out.
> - A `fn` item is higher-ranked automatically; a closure returning a borrow of
>   its argument often is not, and "one type is more general than the other" is
>   that error.
> - Write the bound explicitly for `dyn` trait objects, stored callbacks, and to
>   force a closure into the higher-ranked form.

> 🧪 Practice
> 1. Write a function taking `F: Fn(&str) -> &str` and call it with a closure
>    returning the trimmed input.
> 2. Reproduce the "one type is more general than the other" error by passing a
>    closure directly, then fix it with a `for<'a>`-bounded helper.
> 3. Interview: Why can `fn apply<'a, F: Fn(&'a str) -> &'a str>(f: F)` not accept
>    a closure that is called on a string created inside `apply`? (Hint: ask who
>    chooses `'a` in each form, and when.)

#### Non-Lexical Lifetimes

Rust's original borrow checker was *lexical*: a borrow lasted until the end of
the enclosing block, regardless of whether it was ever used again. That rejected
obviously fine programs — take a reference, print it, then mutate the owner three
lines later, and the compiler complained that the earlier borrow was still alive.

Non-lexical lifetimes (NLL), shipped with the 2018 edition, changed the analysis
to be based on *control flow* rather than syntax. A borrow now ends at its last
actual use. The borrow checker builds the program's control-flow graph and asks
whether any path could still reach a use of the reference; if not, the borrow is
over.

Nothing about the runtime changed — this is purely about which programs are
accepted. Two related refinements arrived with it: *two-phase borrows*, which let
`v.push(v.len())` compile by reserving the mutable borrow before evaluating the
argument, and better handling of borrows that end on some branches but not
others.

```rust
fn main() {
    let mut v = vec![1, 2, 3];

    let first = &v[0];          // borrow starts
    println!("{first}");        // ...and ends HERE, at its last use
    v.push(4);                  // legal under NLL; rejected before 2018
    println!("{v:?}");          // [1, 2, 3, 4]

    // The same shape with a mutable borrow
    let r = &mut v;
    r.push(5);                  // last use of `r`
    println!("{v:?}");          // [1, 2, 3, 4, 5] — `v` is usable again

    // Two-phase borrows: the argument is evaluated before the mutable borrow
    // becomes active, so this reads and mutates in one expression
    v.push(v.len());            // pushes 5
    println!("{v:?}");          // [1, 2, 3, 4, 5, 5]

    // Control-flow sensitivity: the borrow is live only on the path that uses it
    let mut text = String::from("hello");
    let maybe: Option<&str> = if text.len() > 3 { Some(&text[..3]) } else { None };
    match maybe {
        Some(prefix) => println!("{prefix}"),   // hel
        None => text.push_str(" world"),        // mutating is fine on this path
    }
    println!("{text}");                          // hello
}
```

```text
Lexical (pre-2018)                    Non-lexical (NLL)

let first = &v[0];   borrow starts    let first = &v[0];   borrow starts
println!("{first}"); borrow alive     println!("{first}"); LAST USE -> ends
v.push(4);           ERROR            v.push(4);           OK
                     borrow alive
}                    borrow ends
```

> Key Takeaways
> - A borrow ends at its last use, not at the end of the enclosing block.
> - NLL is a compile-time analysis over the control-flow graph; runtime behavior
>   is unchanged.
> - Two-phase borrows make patterns like `v.push(v.len())` compile.
> - If the checker still complains, the reference genuinely is used later —
>   shorten its live range or restructure.

> 🧪 Practice
> 1. Write code that takes a shared borrow, uses it, and then mutates the owner,
>    and confirm it compiles.
> 2. Move the borrow's last use to *after* the mutation and read the resulting
>    `E0502` error.
> 3. Interview: How did NLL change which programs compile, and did it weaken any
>    safety guarantee? (Hint: ask what the checker measures now versus before, and
>    whether a reference that is never used again can be observed.)

<a id="34-the-borrow-checker"></a>
### 3.4 The Borrow Checker

The borrow checker is the compiler pass that enforces everything above. Knowing
roughly how it reasons turns its errors from obstacles into a readable
description of what your code actually does.

#### Borrow Scope Analysis

The borrow checker does not read your braces. After type checking, the compiler
lowers the function to MIR — a control-flow graph of simple statements — and the
checker works on that graph.

For each reference it computes a *region*: the set of program points where that
reference may still be used. A reference is live at a point if some path forward
from there reaches a use of it. The checker then verifies two things at every
point: that no two live regions conflict under the aliasing rule, and that each
region is contained within the lifetime of the value being borrowed.

This is why the checker is path-sensitive. A borrow created in one branch is not
live in the other. A borrow created inside a loop body ends at the bottom of the
iteration unless it escapes. And a borrow whose last use is line 3 imposes no
constraint on line 4, even if the enclosing block runs to line 40.

```rust
fn main() {
    let mut data = vec![1, 2, 3];

    // Two borrows in exclusive branches never conflict: only one is ever live
    let flag = data.len() > 2;
    if flag {
        let r = &data[0];           // live only on this path
        println!("{r}");            // 1
    } else {
        data.push(4);               // a mutable borrow, on the other path
    }

    // A borrow created and finished inside a loop iteration
    for _ in 0..2 {
        let last = data.last().copied();    // borrow ends at `.copied()`
        if let Some(x) = last {
            data.push(x * 10);              // mutation is fine: no live borrow
        }
    }
    println!("{data:?}");                   // [1, 2, 3, 30, 300]

    // The region of `view` ends at its final use, releasing `data`
    let view = &data[..2];
    let total: i32 = view.iter().sum();     // last use of `view`
    data.clear();                           // allowed from here on
    println!("{total} {data:?}");           // 3 []
}
```

```text
MIR-level view of the last block:

  bb0:  view    = &data[..2]        region of `view` starts
        total   = sum(view)         last use  -> region ENDS here
        data.clear()                needs &mut data: no live shared borrow, OK
        print(total, data)

  The checker asks, at every statement: "which regions are live here, and do
  they conflict?" Braces never enter into it.
```

> Key Takeaways
> - The checker runs on a control-flow graph, not on lexical block structure.
> - Each reference gets a region: the program points from which a use is still
>   reachable.
> - Borrows in mutually exclusive branches never conflict.
> - An error means a use is genuinely reachable after the conflicting operation —
>   read the "first borrow later used here" note to find it.

> 🧪 Practice
> 1. Write an `if`/`else` where one branch borrows immutably and the other mutates,
>    and confirm it compiles.
> 2. Create a borrow inside a loop body, mutate the collection later in the same
>    iteration, and observe when it does and does not compile.
> 3. Interview: Two borrows appear in the same block, yet the compiler accepts
>    them. How can you tell whether the checker considers them overlapping?
>    (Hint: find the last use of each and ask whether one region reaches the
>    other.)

#### Common Borrow Errors

Borrow-checker errors come from a small, learnable set. Each has a standard
cause and a standard family of fixes.

| Code    | Message                                        | Typical cause                         | Usual fix |
| ------- | ---------------------------------------------- | ------------------------------------- | --------- |
| `E0382` | Use of moved value                             | Using a variable after moving it      | Borrow instead, or `clone` |
| `E0499` | Cannot borrow as mutable more than once        | Two live `&mut` to the same value     | Shorten one borrow; split the borrow |
| `E0502` | Cannot borrow as mutable, also borrowed as immutable | Mutating while a reader is live | End the read first; copy the value out |
| `E0505` | Cannot move out of a borrowed value            | Moving while a reference is live      | Move after the borrow ends |
| `E0506` | Cannot assign to a borrowed value              | Assigning while borrowed              | End the borrow first |
| `E0596` | Cannot borrow as mutable                       | Owner is not a `mut` binding          | Add `mut` to the binding |
| `E0597` | Value does not live long enough                | Reference outlives its referent       | Widen the value's scope; own the data |
| `E0515` | Cannot return reference to local variable      | Returning a borrow of a local         | Return an owned value |

The single most useful habit: read the *three* spans a borrow error prints —
where the first borrow begins, where the conflicting action happens, and where
the first borrow is later used. The third span is the one that explains why the
borrow is still alive.

```rust
fn main() {
    // E0502 — and the standard fixes
    let mut v = vec![1, 2, 3];
    let first = &v[0];
    // v.push(4);                   // error[E0502]: `v` borrowed as immutable here
    println!("{first}");            // ...and used here, keeping the borrow alive

    // Fix A: copy the value out so no borrow remains
    let first_value = v[0];         // i32 is Copy: this reads and ends immediately
    v.push(4);
    println!("{first_value} {v:?}"); // 1 [1, 2, 3, 4]

    // Fix B: scope the borrow explicitly
    {
        let r = &v[1];
        println!("{r}");            // 2
    }
    v.push(5);

    // E0505 — moving out from under a live borrow
    let s = String::from("hello");
    let r = &s;
    // let moved = s;               // error[E0505]: cannot move out of `s`
    println!("{r}");                // borrow ends here
    let moved = s;                  // now the move is fine
    println!("{moved} {v:?}");      // hello [1, 2, 3, 4, 5]

    // E0596 — the owner is not mutable
    let fixed = vec![1];
    // fixed.push(2);               // error[E0596]: cannot borrow `fixed` as mutable
    println!("{fixed:?}");          // [1]
}
```

> Key Takeaways
> - The error set is small: moved values, overlapping borrows, missing `mut`, and
>   references outliving their target.
> - Always read the "first borrow later used here" span; it identifies why the
>   borrow is still live.
> - Common fixes: shorten the borrow, copy the value out, add `mut`, restructure
>   to own the data.
> - Reaching for `.clone()` works but should be a considered choice, not a reflex.

> 🧪 Practice
> 1. Deliberately produce `E0502`, then fix it three different ways.
> 2. Produce `E0505` by moving a value while a reference to it is live, and
>    resolve it by reordering.
> 3. Interview: Your colleague fixes every borrow error with `.clone()`. When is
>    that legitimate and when is it a smell? (Hint: think about what the error is
>    telling you about ownership design, and about cost in a hot loop.)

#### Reborrowing

A puzzle: `&mut T` is not `Copy`, yet you can pass the same mutable reference to
two functions in a row, and you can call methods on it repeatedly. If passing it
moved it, the second use would fail.

The resolution is *reborrowing*. When a `&mut T` is used where another `&mut T`
is expected, the compiler implicitly creates a new, shorter-lived mutable borrow
*through* the original: written out, `&mut *r`. The original is frozen for the
duration of the reborrow and becomes usable again afterwards, so exclusivity
holds at every instant — there is still only one usable path to the data at any
point.

Method calls do the same thing: `r.push(1)` on a `r: &mut Vec<i32>` reborrows
`*r` for the length of the call.

Reborrowing is also why returning a reference derived from a `&mut self` method
keeps the receiver borrowed: the returned reference is a reborrow whose region
extends as long as the caller uses it.

```rust
fn main() {
    let mut v = vec![1, 2, 3];
    let r = &mut v;                 // one mutable borrow of `v`

    push_one(r);                    // implicit reborrow: &mut *r
    push_one(r);                    // `r` still usable — it was never moved
    push_one(&mut *r);              // the same thing, written explicitly

    r.push(99);                     // method call: reborrows for the call
    println!("{r:?}");              // [1, 2, 3, 1, 1, 1, 99]

    // A reborrow keeps the ORIGINAL frozen while it is alive
    let inner = &mut *r;
    inner.push(5);
    // r.push(6);                   // error[E0499]: `*r` is borrowed by `inner`
    println!("{inner:?}");          // inner's last use: the reborrow ends
    r.push(6);                      // now `r` is usable again
    println!("{v:?}");              // [1, 2, 3, 1, 1, 1, 99, 5, 6]

    // A reborrow happens only when the target type is known to be `&mut _`.
    // A generic by-value parameter MOVES the reference instead.
    let m = &mut v;
    let m2 = identity(m);           // T = &mut Vec<i32>: `m` is moved, not reborrowed
    // m.push(0);                   // error[E0382]: use of moved value: `m`
    m2.push(42);
    println!("{v:?}");              // [1, 2, 3, 1, 1, 1, 99, 5, 6, 42]
}

fn push_one(values: &mut Vec<i32>) {
    values.push(1);
}

// A generic parameter takes its argument by value, so no reborrow is inserted
fn identity<T>(value: T) -> T {
    value
}
```

> Key Takeaways
> - Passing a `&mut T` where a `&mut T` is expected creates an implicit reborrow
>   (`&mut *r`), not a move.
> - The original reference is frozen while the reborrow is live and usable again
>   afterwards.
> - Method calls on a mutable reference reborrow for the duration of the call.
> - A reference returned from a `&mut self` method is a reborrow, which is why the
>   receiver stays borrowed while you hold the result.

> 🧪 Practice
> 1. Pass one `&mut Vec<i32>` to two functions in sequence and confirm it
>    compiles.
> 2. Create an explicit reborrow with `&mut *r`, use the original before the
>    reborrow's last use, and read the `E0499` error.
> 3. Interview: `&mut T` is not `Copy`, so how can a single mutable reference be
>    used many times? (Hint: name the operation the compiler inserts and describe
>    what happens to the original while it is live.)

#### Splitting Borrows

The borrow checker tracks borrows at the granularity of *places* — `s.a`, `s.b`,
`v[0]` — not whole variables, when it can see the paths involved. So borrowing
two different struct fields mutably at the same time is fine: they are disjoint
pieces of memory and the compiler can prove it.

The proof only works when the disjointness is visible in the code. A method
taking `&mut self` borrows the *entire* struct, because from the caller's side
all the compiler knows is the signature. That is why a method that mutates one
field while another is borrowed fails, even though the same code written inline
compiles.

For collections, the compiler cannot reason about indices at all — `v[i]` and
`v[j]` might be the same element — so the standard library provides methods that
do the split for you and encode the disjointness in their return types:
`split_at_mut`, `iter_mut`, and `split_first_mut`.

```rust
#[derive(Debug)]
struct Player {
    name: String,
    score: u32,
    history: Vec<u32>,
}

impl Player {
    // Fine: field borrows are disjoint and visible inside the method
    fn record(&mut self) {
        let score = &mut self.score;
        let history = &mut self.history;    // a DIFFERENT field: no conflict
        history.push(*score);
        *score = 0;
    }

    fn name(&self) -> &str {
        &self.name
    }
}

fn main() {
    let mut p = Player { name: "Ada".into(), score: 30, history: vec![] };

    // Two fields borrowed mutably at once: allowed, they are disjoint places
    let name = &mut p.name;
    let score = &mut p.score;
    name.push_str(" L.");
    *score += 5;
    println!("{name} {score}");              // Ada L. 35

    // But a &mut self METHOD borrows the whole struct
    // let n = p.name();                     // shared borrow of ALL of `p`
    // p.record();                           // error[E0502]: `p` borrowed here
    // println!("{n}");
    p.record();
    println!("{}", p.name());                // Ada L.
    println!("{p:?}");                       // score 0, history [35]

    // Collections: the compiler cannot prove two indices differ, so ask the
    // standard library to split for you
    let mut v = vec![1, 2, 3, 4];
    let (left, right) = v.split_at_mut(2);   // two disjoint &mut [i32]
    left[0] += 100;
    right[0] += 200;
    println!("{v:?}");                       // [101, 2, 203, 4]

    // iter_mut hands out one &mut per element, disjoint by construction
    for x in v.iter_mut() {
        *x *= 2;
    }
    println!("{v:?}");                       // [202, 4, 406, 8]
}
```

> Key Takeaways
> - Borrows are tracked per place, so distinct struct fields can be borrowed
>   mutably at the same time.
> - A `&mut self` method borrows the whole struct; disjointness invisible at the
>   signature cannot be exploited.
> - The compiler cannot prove two indices are different; use `split_at_mut`,
>   `iter_mut`, or `split_first_mut`.
> - When a method fights you, inlining the field access or taking the fields as
>   separate parameters often resolves it.

> 🧪 Practice
> 1. Borrow two fields of a struct mutably in the same scope and mutate both.
> 2. Use `split_at_mut` to swap the halves of a `Vec` in place without cloning.
> 3. Interview: Why does `self.score` and `self.history` work inside a method,
>    while calling `self.name()` and then mutating `self.score` does not? (Hint:
>    ask what the compiler can see at each point — the body, or only the
>    signature.)

#### Interior Mutability Motivation

The aliasing rule is checked at compile time, which means it must be
*conservative*: it rejects every program it cannot prove safe, including some
that are perfectly fine. Three situations run into that wall regularly.

- **Shared graph structures.** A tree where children hold a link back to their
  parent has two owners for the same node, which single ownership forbids.
- **Caching and memoization.** A `get` method wants to record a computed result,
  but its signature takes `&self`, because callers reasonably expect a read.
- **Callbacks and observers.** Several handlers hold a reference to shared state
  and each wants to update it.

*Interior mutability* is the escape hatch: types that allow mutation through a
shared reference by moving the aliasing check from compile time to runtime. The
guarantee is preserved — one writer or many readers, still — but the enforcement
happens when the program runs, and a violation panics instead of failing to
compile.

`Cell<T>` handles `Copy` values by swapping whole values in and out, with no
references handed out at all. `RefCell<T>` hands out real references and tracks
how many are live in a counter, panicking on `borrow_mut()` if the rule is
broken. Both are single-threaded; `Mutex` and `RwLock` are their thread-safe
counterparts. Chapter 9 covers all of them properly.

```rust
use std::cell::{Cell, RefCell};

struct Counter {
    hits: Cell<u32>,                    // Copy value: swap it in and out
    log: RefCell<Vec<String>>,          // non-Copy: hand out references
}

impl Counter {
    // Note `&self`, not `&mut self`: callers see a read-only method
    fn record(&self, label: &str) {
        self.hits.set(self.hits.get() + 1);          // Cell: get and set
        self.log.borrow_mut().push(label.to_string()); // RefCell: runtime check
    }
}

fn main() {
    let c = Counter { hits: Cell::new(0), log: RefCell::new(Vec::new()) };

    c.record("first");
    c.record("second");                 // mutating through a SHARED reference

    println!("{}", c.hits.get());       // 2
    println!("{:?}", c.log.borrow());   // ["first", "second"]

    // The rule still holds — it is simply checked at runtime now
    let cell = RefCell::new(5);
    {
        let a = cell.borrow();
        let b = cell.borrow();          // many shared borrows: fine
        println!("{a} {b}");            // 5 5
    }                                   // both released here
    *cell.borrow_mut() += 1;            // exclusive borrow: fine, nothing live
    println!("{}", cell.borrow());      // 6

    // let keep = cell.borrow();
    // let boom = cell.borrow_mut();    // panics: already mutably borrowed
}
```

| Mechanism        | Rule checked at | Violation results in | Thread-safe |
| ---------------- | --------------- | -------------------- | ----------- |
| `&T` / `&mut T`  | Compile time    | A compile error      | Yes         |
| `Cell<T>`        | Not needed (no references escape) | N/A    | No          |
| `RefCell<T>`     | Runtime         | A panic              | No          |
| `Mutex<T>` / `RwLock<T>` | Runtime | Blocking, or a poisoned lock | Yes |

> Key Takeaways
> - The borrow checker is conservative: some safe programs cannot be proved safe
>   at compile time.
> - Interior mutability moves the same aliasing check to runtime, allowing
>   mutation through `&T`.
> - `Cell` swaps values without handing out references; `RefCell` hands out
>   references and panics on a violation.
> - Reach for it deliberately — a runtime panic is a worse failure mode than a
>   compile error, so restructure first when you can.

> 🧪 Practice
> 1. Build a struct with a `Cell<u32>` counter and increment it from a method
>    taking `&self`.
> 2. Use a `RefCell<Vec<String>>` to append from a `&self` method, then
>    deliberately hold two `borrow_mut()` guards and observe the panic message.
> 3. Interview: `RefCell` enforces the same rule as the borrow checker. What did
>    you gain and what did you give up by choosing it? (Hint: compare when the
>    error is discovered and what form it takes in production.)

---

## 4. Data Modeling with Types

Rust's type system is not just a checker bolted onto the language — it is the
primary tool for expressing what your program means. Structs group related data,
enums say that a value is exactly one of several alternatives, pattern matching
takes those shapes apart with the compiler verifying you covered every case, and
generics let one definition serve many types with no runtime cost. Used together
they let you make illegal states unrepresentable, so whole categories of bugs
become compile errors instead of test failures.

<a id="41-structs"></a>
### 4.1 Structs

A struct bundles several values into one named type. This section covers the
three syntactic forms, how instances are built and updated, and how behavior and
visibility attach to them.

#### Named-Field Structs

A tuple can already group values, but `(f64, f64, f64)` tells a reader nothing.
Is that a position, a colour, or a width-height-depth? A struct answers that by
giving both the type and each field a name.

Naming buys three things. Documentation, since `rect.width` cannot be confused
with `rect.height` the way `rect.0` and `rect.1` can. Type safety, because a
`Rectangle` cannot be passed where a `Circle` is expected even though both are
"two numbers". And a place to hang behavior and invariants, which the following
topics build on.

A struct definition is a template, not a value. Creating an instance means
supplying every field — Rust has no partially initialized structs and no
implicit defaults. Mutability is a property of the *binding*, not of individual
fields: `let mut r` makes every field of `r` mutable, and there is no way to mark
one field mutable and another not.

```rust
#[derive(Debug)]                    // gives `{:?}`; see Chapter 5 for the traits
struct Rectangle {
    width: f64,
    height: f64,
    label: String,
}

fn main() {
    let mut rect = Rectangle {
        width: 3.0,
        height: 4.0,
        label: String::from("floor"),   // every field must be given a value
    };

    println!("{}", rect.width);         // 3 — field access with a dot
    rect.height = 5.0;                  // needs `mut` on the BINDING, not the field
    println!("{rect:?}");               // Rectangle { width: 3.0, height: 5.0,
                                        //             label: "floor" }
    println!("{} area {}", rect.label, area(&rect));   // floor area 15

    // Field init shorthand: when a variable has the field's name, write it once
    let width = 10.0;
    let height = 2.0;
    let other = Rectangle { width, height, label: "wall".into() };
    println!("{}", area(&other));       // 20

    // Structs are values: they can be nested, returned, and stored in collections
    let all = vec![rect, other];        // both are MOVED into the vector
    println!("{}", all.len());          // 2
}

fn area(r: &Rectangle) -> f64 {
    r.width * r.height
}
```

```text
struct Rectangle { width: f64, height: f64, label: String }

  one instance in memory (field order is chosen by the compiler)

  +----------------+----------------+---------------------------+
  | width: f64     | height: f64    | label: String (ptr/len/cap)|
  |      3.0       |      5.0       |     --------------------->  heap "floor"
  +----------------+----------------+---------------------------+

  The struct owns every field, so dropping it drops the String's buffer too.
```

> Key Takeaways
> - A struct names both the type and each field, making the data self-describing
>   and type-safe.
> - Every field must be initialized at construction; there are no partially built
>   structs.
> - `mut` applies to the whole binding — individual fields cannot be made
>   selectively mutable.
> - Field init shorthand (`Rectangle { width, height }`) removes the `x: x` noise.

> 🧪 Practice
> 1. Define a `Book` struct with a title, author, and page count, create one, and
>    print it with `{:?}`.
> 2. Write a function taking `&Book` that returns whether it is longer than 300
>    pages, and call it twice on the same value.
> 3. Interview: Rust has no way to mark a single field as mutable while the rest
>    stay immutable. Why is that consistent with the borrow rules? (Hint: think
>    about what `&mut book` grants access to.)

#### Tuple Structs

A tuple struct is a struct whose fields are positional rather than named:
`struct Point(f64, f64);`. It sits between a plain tuple and a full struct — the
*type* has a name, but the fields do not.

The reason to reach for one is almost always the **newtype pattern**: wrapping an
existing type to give it a distinct identity. `f64` cannot distinguish meters
from feet, so a function accepting a raw `f64` accepts any number anyone passes.
`struct Meters(f64)` and `struct Feet(f64)` are different types, and mixing them
becomes a compile error rather than a Mars Climate Orbiter.

Newtypes also unlock trait implementations that the orphan rule would otherwise
forbid (Chapter 5) and let you attach validation to a primitive. The wrapper is
free: a single-field tuple struct has exactly the layout of the value inside it.

```rust
#[derive(Debug, Clone, Copy, PartialEq)]
struct Meters(f64);                     // newtype: a distinct type, same layout

#[derive(Debug, Clone, Copy)]
struct Feet(f64);

#[derive(Debug)]
struct Rgb(u8, u8, u8);                 // a genuine positional grouping

impl Meters {
    fn to_feet(self) -> Feet {
        Feet(self.0 * 3.280_84)         // `.0` reaches the wrapped value
    }
}

fn describe_distance(d: Meters) -> String {
    format!("{} m", d.0)
}

fn main() {
    let distance = Meters(100.0);
    println!("{}", describe_distance(distance));        // 100 m
    let in_feet = distance.to_feet();
    println!("{in_feet:?} -> {} ft", in_feet.0);        // Feet(328.084) -> 328.084 ft

    // describe_distance(Feet(100.0));   // error[E0308]: expected `Meters`,
                                         // found `Feet` — the whole point
    // describe_distance(100.0);         // error[E0308]: expected `Meters`,
                                         // found floating-point number

    let color = Rgb(255, 128, 0);
    let Rgb(r, g, b) = color;            // destructuring works positionally
    println!("{r} {g} {b}");             // 255 128 0

    // A newtype costs nothing at runtime
    println!("{} {}", std::mem::size_of::<Meters>(), std::mem::size_of::<f64>());
                                         // 8 8
    println!("{}", distance == Meters(100.0));          // true
}
```

| Form                          | Field access | Use when                          |
| ----------------------------- | ------------ | --------------------------------- |
| `struct P { x: f64, y: f64 }` | `p.x`        | Fields mean different things      |
| `struct P(f64, f64);`         | `p.0`        | Position is obvious, or it is a newtype |
| `(f64, f64)`                  | `t.0`        | Ad hoc, local, no name needed     |

> Key Takeaways
> - A tuple struct names the type but not the fields, and is accessed by position.
> - The newtype pattern gives a primitive a distinct identity so the compiler can
>   catch unit and meaning mix-ups.
> - A single-field tuple struct has the same size and layout as the value it
>   wraps: the abstraction is free.
> - Reach for named fields as soon as position stops being self-explanatory.

> 🧪 Practice
> 1. Define `struct Celsius(f64)` and `struct Fahrenheit(f64)` with a conversion
>    method, and confirm you cannot pass one where the other is expected.
> 2. Write `struct UserId(u32)` and a function that only accepts it, then try
>    passing a bare `u32`.
> 3. Interview: What does the newtype pattern buy you that a type alias
>    (`type Meters = f64;`) does not? (Hint: ask whether an alias creates a new
>    type or just a new spelling of an old one.)

#### Unit Structs

A unit struct has no fields at all: `struct Marker;`. It occupies zero bytes, and
every instance is identical, so it carries no information — which sounds useless
until you notice that types themselves carry information.

The use cases are all about the *type* rather than the data. A unit struct can
implement traits, so it works as a strategy or handler object that needs no
state. It can act as a compile-time marker distinguishing otherwise identical
generic types (see phantom types in 4.4). And as a zero-sized type (ZST) it costs
nothing: a `Vec<Marker>` allocates no memory for elements, and a
`HashMap<K, ()>` is exactly how `HashSet<K>` is implemented.

```rust
use std::collections::HashMap;

// A stateless strategy: the behavior lives in the trait impl, not in fields
trait Formatter {
    fn format(&self, value: f64) -> String;
}

struct Plain;                       // unit struct: zero bytes, one value
struct Currency;

impl Formatter for Plain {
    fn format(&self, value: f64) -> String {
        format!("{value}")
    }
}

impl Formatter for Currency {
    fn format(&self, value: f64) -> String {
        format!("${value:.2}")
    }
}

fn main() {
    let formatters: Vec<Box<dyn Formatter>> = vec![Box::new(Plain), Box::new(Currency)];
    for f in &formatters {
        println!("{}", f.format(12.5));         // 12.5   then   $12.50
    }

    // Zero-sized: the type carries the information, the value carries none
    println!("{}", std::mem::size_of::<Plain>());       // 0
    println!("{}", std::mem::size_of::<()>());          // 0

    // A set is a map whose values are the unit type: no space per entry
    let mut seen: HashMap<&str, ()> = HashMap::new();
    seen.insert("a", ());
    println!("{}", seen.contains_key("a"));             // true
}
```

> Key Takeaways
> - A unit struct has no fields, occupies zero bytes, and has exactly one value.
> - It is used to attach behavior (trait impls) or meaning (markers) to a type
>   that needs no data.
> - Zero-sized types are optimized away entirely: collections of them allocate
>   nothing per element.
> - `HashSet<K>` is literally `HashMap<K, ()>` for this reason.

> 🧪 Practice
> 1. Define two unit structs implementing the same trait with different behavior
>    and call each through a `Box<dyn Trait>`.
> 2. Print `size_of` for a unit struct, `()`, and a struct with one `u8` field,
>    and explain the results.
> 3. Interview: What can a unit struct do that a plain constant cannot? (Hint:
>    think about what you can implement for a type but not for a value.)

#### Struct Update Syntax

Building a new value that differs from an existing one in a field or two is
common — configuration overrides, state transitions, test fixtures. Writing out
every unchanged field is noise, so Rust provides `..base`, which fills in every
field you did not specify from another instance of the same type.

The rule that catches people is that `..base` follows ordinary ownership rules
per field. `Copy` fields are copied and `base` stays fully usable. Non-`Copy`
fields are **moved**, which partially moves out of `base` — after that, `base`
cannot be used as a whole, though its remaining fields are still readable.

Note the syntax details: `..base` must come last, there is no trailing comma
after it, and it is not the same as a spread from a *different* type — the base
must be the same struct type.

```rust
#[derive(Debug, Clone)]
struct Config {
    host: String,
    port: u16,
    retries: u8,
    verbose: bool,
}

fn main() {
    let base = Config {
        host: String::from("localhost"),
        port: 8080,
        retries: 3,
        verbose: false,
    };

    // Take everything from `base` except `port`
    let staging = Config { port: 9090, ..base.clone() };   // clone: keep `base` whole
    println!("{staging:?}");
    // Config { host: "localhost", port: 9090, retries: 3, verbose: false }

    // Without the clone, the String field is MOVED out of `base`
    let prod = Config { verbose: true, ..base };
    println!("{}", prod.host);          // localhost
    // println!("{base:?}");            // error[E0382]: `base` partially moved
    println!("{}", base.port);          // 8080 — Copy fields are still readable
    println!("{} {}", prod.retries, prod.verbose);      // 3 true

    // A struct of only Copy fields leaves the base entirely usable
    #[derive(Debug, Clone, Copy)]
    struct Window { width: u32, height: u32 }
    let small = Window { width: 100, height: 50 };
    let tall = Window { height: 200, ..small };
    println!("{small:?} {tall:?}");
    // Window { width: 100, height: 50 } Window { width: 100, height: 200 }
    println!("{} {}", tall.width, tall.height);         // 100 200
}
```

> Key Takeaways
> - `..base` fills every unspecified field from another instance of the same
>   struct type.
> - It must be the final element of the initializer and takes no trailing comma.
> - Non-`Copy` fields are moved out of the base, partially moving it; `Copy`
>   fields are copied.
> - Use `..base.clone()` when the original must stay usable.

> 🧪 Practice
> 1. Build a `Config` struct and derive two variants from it with update syntax,
>    changing one field each.
> 2. Trigger the partial-move error by using the base after moving a `String`
>    field out, then fix it two ways.
> 3. Interview: `let b = A { x: 1, ..a };` compiles, but using `a` afterwards
>    sometimes fails and sometimes does not. What decides? (Hint: look at the
>    types of the fields that `..a` actually supplied.)

#### Methods and Associated Functions

Data and the operations on it belong together. In Rust that pairing happens in an
`impl` block, which is separate from the struct definition — the shape is
declared once, and any number of `impl` blocks may add behavior to it.

Two kinds of function live there:

- **Methods** take a form of `self` as the first parameter and are called with dot
  syntax: `rect.area()`. The receiver form encodes the ownership contract exactly
  as a function parameter does — `&self` to read, `&mut self` to modify, `self` to
  consume.
- **Associated functions** have no `self` and are called on the type:
  `Rectangle::new(3.0, 4.0)`. Rust has no constructors, so `new` is a convention,
  not a keyword, and a type may have as many differently named constructors as it
  needs.

`Self` (capital S) is an alias for the implementing type, which keeps `impl`
blocks robust when a type is renamed.

One ergonomic detail worth knowing: method calls perform *automatic
referencing*. Writing `rect.area()` inserts the `&` for you, and `p.translate()`
inserts `&mut` when that is what the method takes, which is why Rust needs no
`->` operator.

```rust
#[derive(Debug)]
struct Rectangle {
    width: f64,
    height: f64,
}

impl Rectangle {
    // Associated function: no `self`, called as Rectangle::new(...)
    fn new(width: f64, height: f64) -> Self {       // `Self` == `Rectangle`
        Self { width, height }
    }

    fn square(side: f64) -> Self {                  // a second "constructor"
        Self::new(side, side)
    }

    // &self: read-only borrow of the receiver
    fn area(&self) -> f64 {
        self.width * self.height
    }

    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }

    // &mut self: modifies the receiver in place
    fn scale(&mut self, factor: f64) {
        self.width *= factor;
        self.height *= factor;
    }

    // self: consumes the receiver, so the old value cannot be reused
    fn into_square(self) -> Rectangle {
        let side = self.width.max(self.height);
        Rectangle::new(side, side)
    }
}

// A second impl block for the same type is perfectly legal
impl Rectangle {
    fn perimeter(&self) -> f64 {
        2.0 * (self.width + self.height)
    }
}

fn main() {
    let mut r = Rectangle::new(3.0, 4.0);
    println!("{}", r.area());               // 12 — auto-ref inserts &r
    println!("{}", r.perimeter());          // 14

    r.scale(2.0);                           // auto-ref inserts &mut r
    println!("{r:?}");                      // Rectangle { width: 6.0, height: 8.0 }

    let small = Rectangle::square(2.0);
    println!("{}", r.can_hold(&small));     // true

    let sq = r.into_square();               // `r` is MOVED into the method
    // println!("{r:?}");                   // error[E0382]: value moved
    println!("{}", sq.area());              // 64
}
```

| Receiver    | Borrow taken | Caller keeps value | Use for                    |
| ----------- | ------------ | ------------------ | -------------------------- |
| `&self`     | Shared       | Yes                | Reading, computing         |
| `&mut self` | Exclusive    | Yes                | Mutating in place          |
| `self`      | Ownership    | No                 | Conversions, builders, consuming |
| (none)      | N/A          | N/A                | Constructors, factory functions |

> Key Takeaways
> - Methods take `self`, `&self`, or `&mut self`; associated functions take none
>   and are called on the type.
> - `new` is a convention, not a language feature — name constructors whatever
>   describes them.
> - `Self` aliases the implementing type; multiple `impl` blocks per type are
>   allowed.
> - Method calls auto-reference the receiver, so Rust needs no `->` operator.

> 🧪 Practice
> 1. Add a `Circle` struct with `new`, `area`, and `scale`, mirroring the example.
> 2. Write a method taking `self` by value that converts the struct into another
>    type, and confirm the original becomes unusable.
> 3. Interview: When would you write a method taking `self` by value rather than
>    `&self`? (Hint: think about builders and about conversions named `into_*`.)

#### Visibility of Fields

Everything in Rust is private to its module by default — structs, fields,
methods, and functions alike. `pub` opts an item into being visible outside.

The important consequence is that `pub struct` and `pub` *fields* are separate
decisions. Making the type public while keeping fields private means callers can
hold and pass the value but can only touch it through the methods you expose.
That is what makes invariants enforceable: if `Temperature`'s field is private
and the only constructor validates its range, no code anywhere can produce an
out-of-range `Temperature`.

Rust offers finer-grained visibility than public/private:

| Modifier          | Visible to                                     |
| ----------------- | ---------------------------------------------- |
| (none)            | The defining module and its descendants        |
| `pub`             | Everywhere the item's path can be reached      |
| `pub(crate)`      | Anywhere in the current crate                  |
| `pub(super)`      | The parent module                              |
| `pub(in path)`    | The named ancestor module and its descendants  |

A practical note: a struct with any private field cannot be constructed with
literal syntax from outside its module, which is precisely why a public
constructor is required — and why adding a private field to a public struct is a
breaking change only if callers were building it literally.

```rust
mod temperature {
    #[derive(Debug)]
    pub struct Celsius {
        degrees: f64,               // PRIVATE: unreachable outside this module
        pub label: String,          // public: freely readable and writable
    }

    impl Celsius {
        // The only way in — so the invariant is guaranteed for every instance
        pub fn new(degrees: f64, label: &str) -> Option<Self> {
            if degrees < -273.15 {
                None                // below absolute zero: refuse to build it
            } else {
                Some(Self { degrees, label: label.to_string() })
            }
        }

        pub fn degrees(&self) -> f64 {      // a getter exposes read access only
            self.degrees
        }

        pub(crate) fn raw(&self) -> f64 {   // visible crate-wide, not to users
            self.degrees
        }
    }
}

use temperature::Celsius;

fn main() {
    let mut t = Celsius::new(21.5, "room").expect("valid temperature");

    println!("{}", t.degrees());        // 21.5 — through the getter
    println!("{}", t.raw());            // 21.5 — pub(crate), same crate
    t.label.push_str(" sensor");        // the public field is directly writable
    println!("{:?}", t);                // Celsius { degrees: 21.5,
                                        //           label: "room sensor" }

    // t.degrees = -500.0;              // error[E0616]: field `degrees` is private
    // let bad = Celsius { degrees: -500.0, label: String::new() };
                                        // error[E0451]: field `degrees` is private
    println!("{:?}", Celsius::new(-300.0, "impossible").is_none());   // true
}
```

> Key Takeaways
> - Items are private to their module by default; `pub` opts into visibility.
> - A public struct with private fields can only be built and modified through
>   its own methods, which is how invariants are enforced.
> - `pub(crate)` and `pub(super)` express "internal API" without exposing it to
>   downstream users.
> - Private fields make literal construction impossible from outside, so provide
>   a constructor.

> 🧪 Practice
> 1. Put a struct in a module with one private and one public field, and try to
>    build it literally from `main`.
> 2. Add a validating constructor returning `Option<Self>` and a getter, then
>    prove the invariant cannot be violated.
> 3. Interview: Why does making a field private make an invariant *guaranteed*
>    rather than merely conventional? (Hint: enumerate every way a value of that
>    type could come into existence.)

<a id="42-enums"></a>
### 4.2 Enums

Where a struct says "all of these at once", an enum says "exactly one of these".
That single idea replaces null, exceptions, and a great deal of defensive
programming.

#### Variants with Data

An enum in C is a list of named integers. In Rust it is a *sum type*: a value is
one of several variants, and each variant may carry its own data of its own
shape. That is a categorical upgrade, and it is the feature most responsible for
Rust code needing fewer runtime checks than its equivalents elsewhere.

The contrast is worth stating precisely. A struct is a *product* type: a
`Rectangle` holds a width *and* a height, so the number of possible values is
width-count times height-count. An enum is a *sum* type: a `Shape` is a circle
*or* a rectangle, so the possible values are the circle count plus the rectangle
count. Modelling with sums is how you make illegal states unrepresentable — a
`Connection` that is either `Disconnected` or `Connected { socket }` cannot
possibly be "disconnected but holding a socket", whereas a struct with a `bool`
and an `Option<Socket>` can.

In memory, an enum is a *tag* saying which variant is active plus enough space
for the largest variant's payload. Reading the wrong variant's data is impossible
because the only way in is a pattern match, which checks the tag first.

Variants come in the same three shapes as structs: unit, tuple, and named-field.
Enums can have `impl` blocks just like structs.

```rust
#[derive(Debug)]
enum Shape {
    Circle(f64),                            // tuple variant: radius
    Rectangle { width: f64, height: f64 },  // struct variant: named fields
    Point,                                  // unit variant: no data
}

impl Shape {
    fn area(&self) -> f64 {
        // The match reads the tag, then the payload of that variant only
        match self {
            Shape::Circle(r) => std::f64::consts::PI * r * r,
            Shape::Rectangle { width, height } => width * height,
            Shape::Point => 0.0,
        }
    }
}

fn main() {
    let shapes = vec![
        Shape::Circle(1.0),
        Shape::Rectangle { width: 3.0, height: 4.0 },
        Shape::Point,
    ];

    for s in &shapes {
        println!("{s:?} -> {:.2}", s.area());
    }
    // Circle(1.0) -> 3.14
    // Rectangle { width: 3.0, height: 4.0 } -> 12.00
    // Point -> 0.00

    // One type, three shapes of data: a Vec can hold them all
    println!("{}", shapes.len());               // 3

    // Size = tag + the largest payload, rounded for alignment
    println!("{}", std::mem::size_of::<Shape>());   // 24
}
```

```text
enum Shape { Circle(f64), Rectangle { width: f64, height: f64 }, Point }

  +-----+--------------------------------+
  | tag |        payload space           |   size = 24 bytes
  +-----+--------------------------------+

  Circle(1.0)          tag=0 | 1.0        |  (8 of 16 payload bytes used)
  Rectangle{3.0,4.0}   tag=1 | 3.0 | 4.0  |  (the largest variant sets the size)
  Point                tag=2 |  unused    |

  A match checks the tag before touching the payload, so misreading is impossible.
```

> Key Takeaways
> - An enum is a sum type: a value is exactly one variant, each with its own
>   payload shape.
> - Structs model "and", enums model "or"; combining them makes illegal states
>   unrepresentable.
> - Layout is a tag plus space for the largest variant, so one huge variant
>   inflates every value.
> - Enums take `impl` blocks and methods exactly like structs.

> 🧪 Practice
> 1. Define an `Event` enum with a unit variant, a tuple variant, and a
>    struct variant, and print each with `{:?}`.
> 2. Add a method that returns a `&'static str` description for each variant.
> 3. Interview: Model a network connection that is either disconnected or
>    connected with a session id. Why is an enum better than a struct holding a
>    `bool` and an `Option<u32>`? (Hint: count the states each version can
>    represent, and how many of them are meaningful.)

#### Discriminants and C-Like Enums

When every variant is a unit variant, an enum is just a set of named constants —
the C-style enum. Rust assigns each variant an integer *discriminant*, starting
at 0 and incrementing, and you can set the values explicitly when they must match
an external protocol, a database column, or a C header.

Two rules matter. A fieldless enum can be cast to an integer with `as`; an enum
with any data-carrying variant cannot. And the reverse direction is not a cast at
all: an arbitrary integer may not correspond to any variant, so converting back
must be fallible. Implementing `TryFrom` is the idiomatic way, and it is exactly
the kind of boilerplate that derive macros in the ecosystem generate for you.

`#[repr(u8)]` and friends pin the underlying representation, which matters for
FFI and for wire formats where the exact byte layout is part of the contract.

```rust
#[derive(Debug, Clone, Copy, PartialEq)]
#[repr(u8)]                             // guarantees the layout for FFI/protocols
enum Status {
    Ok = 200,                           // explicit discriminants
    NotFound = 44,
    Error,                              // implicit: previous + 1 = 45
}

#[derive(Debug, Clone, Copy)]
enum Direction {                        // implicit discriminants: 0, 1, 2, 3
    North,
    East,
    South,
    West,
}

impl TryFrom<u8> for Status {
    type Error = String;                // the conversion's error type

    fn try_from(value: u8) -> Result<Self, String> {
        match value {
            200 => Ok(Status::Ok),
            44 => Ok(Status::NotFound),
            45 => Ok(Status::Error),
            other => Err(format!("no Status for {other}")),
        }
    }
}

fn main() {
    println!("{}", Status::Ok as u8);            // 200 — fieldless enums cast
    println!("{}", Status::Error as u8);         // 45
    println!("{}", Direction::South as i32);     // 2

    // Integer -> enum is fallible, because not every integer is a valid variant
    println!("{:?}", Status::try_from(44u8));    // Ok(NotFound)
    println!("{:?}", Status::try_from(7u8));     // Err("no Status for 7")

    println!("{}", std::mem::size_of::<Status>());       // 1, thanks to repr(u8)
    println!("{}", std::mem::size_of::<Direction>());    // 1
    for d in [Direction::North, Direction::East, Direction::South, Direction::West] {
        print!("{d:?}={} ", d as i32);
    }
    println!();                     // North=0 East=1 South=2 West=3
}
```

> Key Takeaways
> - Fieldless enums have integer discriminants, implicit from 0 or set
>   explicitly.
> - `Enum as i32` works only when no variant carries data.
> - Converting an integer back into an enum is fallible; implement `TryFrom`
>   rather than transmuting.
> - `#[repr(u8)]` fixes the representation for FFI and wire protocols.

> 🧪 Practice
> 1. Define an enum of HTTP methods with explicit discriminants and print each as
>    an integer.
> 2. Implement `TryFrom<u8>` for it and handle both the valid and invalid cases.
> 3. Interview: Why is `enum_value as u8` safe while the reverse needs `TryFrom`?
>    (Hint: compare the number of valid enum values with the number of possible
>    `u8` values.)

#### Option as a Null Replacement

Tony Hoare called null references his "billion-dollar mistake". The problem is
not the concept of absence — it is that in most languages *every* reference type
can secretly be null, so the compiler cannot tell you which values need a check.
Every dereference is a potential crash, and the only defense is discipline.

Rust has no null. Absence is modelled with an ordinary enum from the standard
library:

```rust
pub enum Option<T> {
    None,
    Some(T),
}
```

Because `Option<T>` and `T` are different types, the compiler enforces the check.
You cannot accidentally use an `Option<i32>` as an `i32`; you must match on it,
or call a method that handles the `None` case. Absence becomes visible in the
signature: `fn find(&self, k: &str) -> Option<&Value>` tells you it may not find
anything, while `fn get(&self) -> &Value` promises it always will.

The cost is nothing. Rust applies *niche optimization*: when the inner type has
an invalid bit pattern to spare — as a reference or `Box` does, since neither can
be null — `None` is represented by that pattern, so `Option<Box<T>>` is the same
size as `Box<T>`.

`Option` is in the prelude, so `Some` and `None` need no import. Chapter 7 covers
the combinator methods in depth; the essentials are below.

```rust
fn main() {
    let numbers = vec![1, 5, 12, 7];

    let found: Option<&i32> = numbers.iter().find(|&&n| n > 10);
    let missing: Option<&i32> = numbers.iter().find(|&&n| n > 100);

    println!("{found:?} {missing:?}");           // Some(12) None

    // Handling both cases explicitly
    match found {
        Some(n) => println!("found {n}"),        // found 12
        None => println!("nothing matched"),
    }

    // Common combinators instead of a full match
    println!("{}", missing.copied().unwrap_or(0));           // 0
    println!("{}", missing.map_or(-1, |n| *n));              // -1
    println!("{}", found.is_some());                         // true
    println!("{:?}", found.map(|n| n * 2));                  // Some(24)

    // if let / let else for the one-case shapes
    if let Some(n) = found {
        println!("still {n}");                               // still 12
    }

    // Absence is visible in the type, so this cannot compile:
    // let sum = found + 1;      // error[E0369]: cannot add `{integer}` to
                                 //               `Option<&i32>`

    // Niche optimization: None costs no extra space for non-nullable types
    println!("{} {}", size_of::<Box<i32>>(), size_of::<Option<Box<i32>>>());  // 8 8
    println!("{} {}", size_of::<&i32>(), size_of::<Option<&i32>>());          // 8 8
    println!("{} {}", size_of::<i32>(), size_of::<Option<i32>>());            // 4 8
}

use std::mem::size_of;
```

> Key Takeaways
> - Rust has no null; `Option<T>` makes absence a distinct type the compiler
>   forces you to handle.
> - A signature returning `Option<T>` documents fallibility that a nullable
>   pointer hides.
> - Niche optimization makes `Option<&T>` and `Option<Box<T>>` the same size as
>   the bare pointer.
> - Prefer combinators (`unwrap_or`, `map`, `and_then`) over a full `match` for
>   simple cases.

> 🧪 Practice
> 1. Write a function returning `Option<&str>` for the first word longer than
>    five characters, and handle both outcomes at the call site.
> 2. Convert three `match` statements over `Option` into `unwrap_or`, `map`, and
>    `if let` respectively.
> 3. Interview: How does `Option<T>` prevent null-pointer dereferences at compile
>    time, and what does it cost at runtime? (Hint: name the type the compiler
>    sees before the check and after it, then recall niche optimization.)

#### Result for Fallible Values

`Option` says a value may be absent. `Result` says an operation may fail, and
carries the reason why:

```rust
pub enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

The design point is that errors are ordinary *values*, returned through the
normal path, not a parallel control-flow mechanism. With exceptions, any function
can throw and the signature never says so; you learn what can fail from
documentation, or from production. With `Result`, fallibility is in the type, the
compiler warns when you ignore one (`Result` is `#[must_use]`), and error
handling stays where the call is.

The obvious objection — that checking every call is tedious — is what the `?`
operator answers. `?` unwraps an `Ok` or returns the `Err` from the enclosing
function, converting the error type if needed. Chapter 7 covers the mechanics;
what matters here is the shape of the type.

```rust
use std::num::ParseIntError;

#[derive(Debug)]
enum ConfigError {
    Missing(String),
    BadNumber(ParseIntError),
}

// The signature states exactly what can go wrong
fn parse_port(raw: Option<&str>) -> Result<u16, ConfigError> {
    let text = raw.ok_or_else(|| ConfigError::Missing("port".to_string()))?;
    let port: u16 = text.parse().map_err(ConfigError::BadNumber)?;
    Ok(port)
}

fn main() {
    println!("{:?}", parse_port(Some("8080")));     // Ok(8080)
    println!("{:?}", parse_port(None));             // Err(Missing("port"))
    println!("{:?}", parse_port(Some("http")));     // Err(BadNumber(ParseIntError
                                                    //     { kind: InvalidDigit }))

    // Handling a Result explicitly
    match parse_port(Some("443")) {
        Ok(port) => println!("listening on {port}"),    // listening on 443
        Err(ConfigError::Missing(field)) => println!("missing field: {field}"),
        Err(ConfigError::BadNumber(e)) => println!("bad number: {e}"),
    }

    // Ignoring one is a warning, not a silent mistake
    // parse_port(None);        // warning: unused `Result` that must be used

    // Result and Option convert both ways
    let opt: Option<u16> = parse_port(Some("22")).ok();
    println!("{opt:?}");                                // Some(22)
}
```

| Type              | Says                                | Carries on failure |
| ----------------- | ----------------------------------- | ------------------ |
| `Option<T>`       | The value may be absent             | Nothing            |
| `Result<T, E>`    | The operation may fail              | An error value `E` |
| Exceptions (other languages) | Anything may fail, invisibly | A thrown object |

> Key Takeaways
> - `Result<T, E>` makes failure an ordinary return value with the reason
>   attached.
> - Fallibility appears in the signature, so callers cannot be surprised by it.
> - `Result` is `#[must_use]`: discarding one produces a warning.
> - Use `Option` when absence needs no explanation, `Result` when the caller
>   needs to know why.

> 🧪 Practice
> 1. Write `fn half(n: i32) -> Result<i32, String>` that fails on odd input, and
>    handle both outcomes.
> 2. Convert a function returning `Option<T>` into one returning
>    `Result<T, String>` using `ok_or`.
> 3. Interview: What does `Result` give you that exceptions do not, and what do
>    exceptions give you that `Result` does not? (Hint: think about what the
>    signature tells a caller, and about how much code sits between a failure and
>    the place that handles it.)

#### Recursive Enums with Box

Try to define a linked list directly and the compiler stops you:

```text
enum List {
    Cons(i32, List),        // error[E0072]: recursive type has infinite size
    Nil,
}

size_of(List) = tag + size_of(i32) + size_of(List)
              = tag + 4 + (tag + 4 + (tag + 4 + ...))     never terminates
```

The problem is that Rust lays out enums inline, and computing the size of `List`
requires knowing the size of `List`. The fix is *indirection*: store a pointer to
the next element instead of the element itself. A pointer has a fixed size
regardless of what it points at, so the recursion in the type stops even though
the data structure remains recursive.

`Box<T>` is the tool — a smart pointer that owns a heap allocation (Chapter 9).
`Box<List>` is eight bytes whatever `List` turns out to be, so the size
calculation terminates.

This pattern is everywhere in real code: expression trees for interpreters and
compilers, JSON-like nested data, and tree structures of every kind. The compiler
even tells you the fix in the error message.

```rust
#[derive(Debug)]
enum Expr {
    Number(f64),
    Add(Box<Expr>, Box<Expr>),      // Box breaks the infinite-size recursion
    Multiply(Box<Expr>, Box<Expr>),
    Negate(Box<Expr>),
}

impl Expr {
    fn eval(&self) -> f64 {
        match self {
            Expr::Number(n) => *n,
            // Recursion in the DATA is fine; only the TYPE needed indirection
            Expr::Add(a, b) => a.eval() + b.eval(),
            Expr::Multiply(a, b) => a.eval() * b.eval(),
            Expr::Negate(e) => -e.eval(),
        }
    }
}

fn main() {
    // (2 + 3) * -4
    let expr = Expr::Multiply(
        Box::new(Expr::Add(
            Box::new(Expr::Number(2.0)),
            Box::new(Expr::Number(3.0)),
        )),
        Box::new(Expr::Negate(Box::new(Expr::Number(4.0)))),
    );

    println!("{}", expr.eval());                    // -20
    println!("{}", std::mem::size_of::<Expr>());    // 24: tag + two pointers

    // The classic cons list, same idea
    #[derive(Debug)]
    enum List {
        Cons(i32, Box<List>),
        Nil,
    }
    let list = List::Cons(1, Box::new(List::Cons(2, Box::new(List::Nil))));
    println!("{list:?}");
    // Cons(1, Cons(2, Nil))
    if let List::Cons(head, tail) = &list {
        println!("head {head}, tail {tail:?}");     // head 1, tail Cons(2, Nil)
    }
}
```

```text
Expr::Add(Box<Expr>, Box<Expr>) on the stack and heap

  expr (24 bytes on the stack)
  +-----+---------+---------+
  | tag |  ptr    |  ptr    |
  +-----+----|----+----|----+
             |         |
             v         v
        [Add node]  [Negate node]      each a heap allocation of fixed size
             |            |
             v            v
      [Number 2][Number 3]  [Number 4]

  The type is finite because a pointer's size never depends on its target.
```

> Key Takeaways
> - A directly recursive enum has infinite size (`E0072`) because enums are laid
>   out inline.
> - `Box<T>` introduces indirection with a fixed pointer size, terminating the
>   size computation.
> - The data structure stays recursive; only the *type* needed the pointer.
> - This is the standard shape for expression trees, linked lists, and nested
>   documents.

> 🧪 Practice
> 1. Write the `List` enum without `Box`, read the `E0072` error, and apply the
>    compiler's suggestion.
> 2. Extend the `Expr` enum with a `Subtract` variant and update `eval`.
> 3. Interview: Why does `Box<Expr>` make the type finite when `Expr` itself is
>    still recursive? (Hint: ask what the compiler needs to know to lay out a
>    value on the stack, and whether a pointer's size depends on its target.)

<a id="43-pattern-matching"></a>
### 4.3 Pattern Matching

Patterns are how data gets taken apart in Rust. They appear in `match`, `let`,
function parameters, `if let`, `while let`, and `for` — the same small grammar
everywhere, checked for completeness by the compiler.

#### match Expressions and Exhaustiveness

`match` compares a value against a series of patterns and runs the first arm that
fits. That much resembles `switch` in other languages. Two differences make it a
different tool entirely.

First, `match` is *exhaustive*. The compiler proves that the arms cover every
possible value, and refuses to compile if any case is missing. That turns "we
forgot to handle the new variant" from a production incident into a build
failure: add a variant to an enum, and every `match` on it that is now incomplete
lights up immediately.

Second, `match` is an expression, so it produces a value and every arm must
therefore have the same type.

The wildcard `_` matches anything and is the usual way to close a match over a
large domain such as integers. Use it deliberately, though: a `_` arm on an enum
silences exactly the exhaustiveness check you wanted, so listing variants
explicitly is often the better default.

```rust
#[derive(Debug)]
enum Command {
    Move { x: i32, y: i32 },
    Write(String),
    Quit,
}

fn run(cmd: &Command) -> String {
    // Every arm yields a String; the match itself is the return value
    match cmd {
        Command::Move { x, y } => format!("move to {x},{y}"),
        Command::Write(text) => format!("write {text}"),
        Command::Quit => String::from("quit"),
        // Adding a variant to `Command` breaks this match at compile time,
        // which is exactly what you want. A `_ => ...` arm would hide that.
    }
}

fn main() {
    let commands = vec![
        Command::Move { x: 3, y: -1 },
        Command::Write("hello".to_string()),
        Command::Quit,
    ];
    for c in &commands {
        println!("{}", run(c));
    }
    // move to 3,-1
    // write hello
    // quit

    // Over an unbounded domain, `_` closes the match
    let n = 7;
    let label = match n {
        0 => "zero",
        1 => "one",
        _ => "many",                    // required: i32 has billions of values
    };
    println!("{label}");                // many

    // Matching a reference binds by reference automatically ("match ergonomics")
    let maybe = Some(String::from("owned"));
    match &maybe {
        Some(s) => println!("{}", s.len()),     // `s` is &String, nothing moved
        None => println!("empty"),
    }
    println!("{maybe:?}");              // Some("owned") — still usable
}
```

> Key Takeaways
> - `match` is exhaustive: missing a case is a compile error, so new enum
>   variants surface every place that must handle them.
> - It is an expression, so all arms must produce the same type.
> - `_` matches anything; on enums it also disables the exhaustiveness benefit.
> - Matching on `&value` binds the contents by reference, so nothing is moved out.

> 🧪 Practice
> 1. Write a `match` over a three-variant enum that returns a `&'static str`, then
>    add a fourth variant and observe the error.
> 2. Rewrite an `if`/`else if` chain over an integer as a `match` with a `_` arm.
> 3. Interview: When is adding `_ => {}` to a match over an enum a mistake?
>    (Hint: think about what happens six months later when someone adds a
>    variant.)

#### Destructuring Structs and Enums

A pattern mirrors the shape of the data it matches. Where an expression *builds*
a value from parts, a pattern *takes it apart* into bindings, using the same
syntax read in reverse.

Structs destructure by field name, with a shorthand when the binding takes the
field's own name. `..` ignores the remaining fields, which keeps a pattern
readable and stable when fields are added later. Enums destructure per variant,
and patterns nest arbitrarily, so one pattern can reach several levels into a
data structure and pull out exactly what it needs.

Destructuring works in every pattern position, not only `match`: `let`
statements, function parameters, and `for` loop heads all take patterns.

```rust
#[derive(Debug)]
struct Point { x: i32, y: i32 }

#[derive(Debug)]
struct Line { start: Point, end: Point, width: f64 }

enum Message {
    Ping,
    Coords(Point),
    Resize { width: u32, height: u32 },
}

fn main() {
    // In a `let`: field shorthand binds `x` and `y`
    let p = Point { x: 3, y: 7 };
    let Point { x, y } = p;
    println!("{x} {y}");                    // 3 7

    // Rename while destructuring, and ignore the rest with `..`
    let line = Line {
        start: Point { x: 0, y: 0 },
        end: Point { x: 4, y: 3 },
        width: 2.0,
    };
    let Line { start: Point { x: sx, y: sy }, end, .. } = &line;   // nested + rest
    println!("{sx},{sy} -> {},{} @{}", end.x, end.y, line.width);  // 0,0 -> 4,3 @2

    // In a `match`, per variant
    for msg in [Message::Ping, Message::Coords(Point { x: 1, y: 2 }),
                Message::Resize { width: 800, height: 600 }] {
        let text = match msg {
            Message::Ping => "ping".to_string(),
            Message::Coords(Point { x, y }) => format!("at {x},{y}"),   // nested
            Message::Resize { width, .. } => format!("width {width}"),  // partial
        };
        println!("{text}");
    }
    // ping
    // at 1,2
    // width 800

    // `if let` destructures the same way, reading both fields this time
    let resize = Message::Resize { width: 1024, height: 768 };
    if let Message::Resize { width, height } = resize {
        println!("{width}x{height}");        // 1024x768
    }

    // In a function parameter
    print_point(&Point { x: 9, y: 9 });      // 9,9

    // In a `for` head: each item is a tuple, destructured on the spot
    let pairs = vec![("a", 1), ("b", 2)];
    for (name, value) in &pairs {
        print!("{name}={value} ");           // a=1 b=2
    }
    println!();

    // `_` ignores a single value, `..` ignores several
    let (first, _, third) = (1, 2, 3);
    println!("{first} {third}");             // 1 3
}

// The parameter itself is a pattern
fn print_point(&Point { x, y }: &Point) {
    println!("{x},{y}");
}
```

> Key Takeaways
> - Patterns mirror construction syntax: what builds a value can take it apart.
> - `..` ignores remaining fields and keeps patterns stable as structs grow.
> - Patterns nest, so one `match` arm can reach several levels into a structure.
> - `let`, function parameters, and `for` heads all accept patterns, not just
>   names.

> 🧪 Practice
> 1. Destructure a nested struct in a single `let` and print two inner fields.
> 2. Write a function whose parameter is a destructuring pattern over a tuple
>    struct.
> 3. Interview: Why does `..` in a struct pattern make code more resilient than
>    listing every field? (Hint: consider what happens to each style when a field
>    is added.)

#### Match Guards

Sometimes the pattern is right but a condition on the bound values decides the
outcome: "a `Some` whose value is negative", "a point on the diagonal". Patterns
alone cannot express arithmetic or comparisons, so `match` allows an `if`
condition after the pattern — a *match guard*.

The guard runs only if the pattern matched, and it sees every binding the pattern
created. Arms are tried top to bottom, so a guarded arm that fails falls through
to the next arm rather than failing the whole match.

The one thing to know: **guards are invisible to the exhaustiveness checker**.
The compiler cannot evaluate arbitrary conditions, so it assumes a guarded arm
might not match. A match whose only `Some` arm is guarded still needs another arm
to cover `Some`.

Guards also solve the classic shadowing puzzle. In a pattern, a bare identifier
*binds*, it does not compare — so `Some(n)` matches any `Some` and binds it,
shadowing any outer `n`. To compare against an outer variable, use a guard.

```rust
fn main() {
    let values = [Some(-5), Some(0), Some(42), None];

    for v in values {
        let description = match v {
            Some(n) if n < 0 => format!("negative: {n}"),
            Some(0) => "zero".to_string(),
            Some(n) if n % 2 == 0 => format!("positive even: {n}"),
            Some(n) => format!("positive odd: {n}"),    // still needed: guards do
                                                        // not prove exhaustiveness
            None => "nothing".to_string(),
        };
        println!("{description}");
    }
    // negative: -5
    // zero
    // positive even: 42
    // nothing

    // Comparing against an outer variable REQUIRES a guard
    let expected = 5;
    let got = Some(5);
    match got {
        Some(n) if n == expected => println!("matched the expected {n}"),
        Some(n) => println!("got {n}, wanted {expected}"),
        None => println!("got nothing"),
    }
    // matched the expected 5

    // Without the guard, `Some(expected)` would BIND a new `expected`,
    // shadowing the outer one and matching every `Some`.

    // A guard applies to the whole or-pattern before it
    let pair = (2, -2);
    match pair {
        (x, y) if x + y == 0 => println!("they cancel out"),    // this arm
        (x, _) if x > 0 => println!("positive first"),
        _ => println!("something else"),
    }
}
```

> Key Takeaways
> - A match guard is an `if` condition after a pattern, with access to its
>   bindings.
> - Guards let you express conditions patterns cannot, such as comparisons and
>   arithmetic.
> - The exhaustiveness checker ignores guards, so a guarded arm never counts as
>   covering a case.
> - Use a guard to compare against an outer variable; a bare name in a pattern
>   binds rather than compares.

> 🧪 Practice
> 1. Match an `Option<i32>` with separate arms for negative, zero, and positive
>    values.
> 2. Write a match on a `(i32, i32)` tuple with a guard that detects points on the
>    line `y = x`.
> 3. Interview: Why does the compiler still demand an unguarded arm after
>    `Some(n) if n > 0`? (Hint: ask what the compiler would have to do to know
>    whether the guard can ever be false.)

#### Binding with @

Occasionally you need both things at once: to *test* that a value falls in some
shape, and to *keep* the whole value that matched. A range pattern like `1..=5`
tests but binds nothing; a binding like `n` keeps the value but tests nothing.
The `@` operator does both: `n @ 1..=5` matches the range and binds the matched
value to `n`.

Read `@` as "as", the way you would in English: "an id in one to five, as `n`".

It composes with any pattern, including struct and enum patterns, so you can
capture a whole substructure while still constraining its interior.

```rust
#[derive(Debug)]
enum Event {
    Key { code: u8 },
    Click { x: i32, y: i32 },
}

fn main() {
    for code in [3u8, 7, 200] {
        let msg = match code {
            // Test the range AND keep the value
            n @ 1..=5 => format!("low code {n}"),
            n @ 6..=99 => format!("mid code {n}"),
            n => format!("high code {n}"),
        };
        println!("{msg}");
    }
    // low code 3
    // mid code 7
    // high code 200

    // Binding a whole struct variant while constraining a field
    let events = [Event::Key { code: 4 }, Event::Click { x: 10, y: 20 }];
    for e in &events {
        match e {
            // `key` binds the whole variant payload; the inner pattern still tests
            key @ Event::Key { code: 1..=5 } => println!("special {key:?}"),
            Event::Key { code } => println!("other key {code}"),
            Event::Click { x, y } => println!("click {x},{y}"),
        }
    }
    // special Key { code: 4 }
    // click 10,20

    // @ works with or-patterns too
    let n = 9;
    match n {
        small @ (1 | 2 | 3) => println!("small {small}"),
        other @ (4..=10) => println!("medium {other}"),      // medium 9
        _ => println!("large"),
    }
}
```

> Key Takeaways
> - `name @ pattern` matches the pattern and binds the matched value to `name`.
> - It solves the "test it and keep it" case that ranges and bare bindings cannot
>   each do alone.
> - It composes with struct, enum, range, and or-patterns.
> - Read it as "as": `n @ 1..=5` is "a value in 1 to 5, as n".

> 🧪 Practice
> 1. Match an integer with `@` bindings for the ranges 0-9, 10-99, and everything
>    else, printing the captured value.
> 2. Bind a whole enum variant with `@` while constraining one of its fields.
> 3. Interview: What does `n @ 1..=5` do that neither `1..=5` nor `n` alone can?
>    (Hint: separate the testing job from the capturing job.)

#### Or-Patterns and Ranges

Two pattern forms remove most of the repetition from a `match`.

An **or-pattern** joins alternatives with `|`: `1 | 3 | 5` matches any of them
with one arm. Since Rust 1.53 the `|` can be *nested* inside a pattern rather
than only at the top level, so `Some(1 | 2)` is valid and much clearer than
`Some(1) | Some(2)`. Every alternative in an or-pattern must bind the same
variables with the same types, since the arm body has to work whichever branch
matched.

A **range pattern** matches a contiguous span: `1..=5` is inclusive on both ends,
and `1..5` (stable since 1.80) excludes the upper bound. Ranges work on integers
and on `char`, which makes classification code read almost like the specification
it implements.

```rust
fn classify(c: char) -> &'static str {
    match c {
        'a' | 'e' | 'i' | 'o' | 'u' => "vowel",         // or-pattern
        'a'..='z' => "consonant",                        // inclusive range
        'A'..='Z' => "uppercase",
        '0'..='9' => "digit",
        ' ' | '\t' | '\n' => "whitespace",
        _ => "other",
    }
}

fn http_family(status: u16) -> &'static str {
    match status {
        100..200 => "informational",     // exclusive upper bound
        200..300 => "success",
        300..400 => "redirect",
        400..500 => "client error",
        500..600 => "server error",
        _ => "unknown",
    }
}

fn main() {
    for c in ['e', 'z', 'Q', '7', ' ', '!'] {
        print!("{} ", classify(c));
    }
    println!();
    // vowel consonant uppercase digit whitespace other

    for s in [204u16, 301, 404, 503, 42] {
        print!("{} / ", http_family(s));
    }
    println!();
    // success / redirect / client error / server error / unknown /

    // Nested or-patterns inside an enum pattern
    let inputs = [Some(1), Some(2), Some(9), None];
    for i in inputs {
        let text = match i {
            Some(1 | 2) => "one or two",             // nested `|`
            Some(n @ 3..=10) => {
                // every alternative must bind the same names, so this arm is
                // separate rather than merged with the one above
                if n == 9 { "nine" } else { "three to ten" }
            }
            Some(_) => "something else",
            None => "none",
        };
        print!("{text} / ");
    }
    println!();
    // one or two / one or two / nine / none /
}
```

| Pattern      | Matches                  | Note                              |
| ------------ | ------------------------ | --------------------------------- |
| `1 \| 2 \| 3`| Any listed alternative   | All branches must bind the same names |
| `Some(1 \| 2)`| Nested alternatives     | Stable since Rust 1.53            |
| `1..=5`      | 1 through 5 inclusive    | Works on integers and `char`      |
| `1..5`       | 1 through 4              | Stable since Rust 1.80            |
| `..=5`       | Everything up to 5       | Open-ended ranges are allowed too |

> Key Takeaways
> - `|` joins alternatives in one arm and can nest inside patterns.
> - Every alternative in an or-pattern must bind the same variables with the same
>   types.
> - `a..=b` is inclusive, `a..b` excludes the upper bound, and both work on
>   integers and `char`.
> - Ranges make classification code read like the rules it implements.

> 🧪 Practice
> 1. Write a function classifying a `char` as vowel, consonant, digit, or other
>    using or-patterns and ranges.
> 2. Rewrite `Some(1) | Some(2) | Some(3)` as a single nested or-pattern.
> 3. Interview: Why must every alternative of an or-pattern bind the same
>    variables? (Hint: think about what the arm's body would refer to if one
>    branch bound `n` and another did not.)

#### Refutable vs Irrefutable Patterns

Every pattern is one of two kinds, and knowing which explains a family of
otherwise puzzling errors.

An **irrefutable** pattern matches every possible value of its type. `let x = 5;`
and `let (a, b) = pair;` cannot fail — there is no `(i32, i32)` that fails to be
a pair.

A **refutable** pattern may fail for some values. `Some(n)` is refutable because
the value might be `None`; `1..=5` is refutable because the number might be 7.

Each pattern position accepts one kind. `let` statements and function parameters
require irrefutable patterns, because there is nowhere to go if the match fails.
`if let` and `while let` require refutable ones, since their whole purpose is to
handle the possibility of not matching — passing an irrefutable pattern there is
a warning, as the else branch would be dead code. `match` arms accept both, and
the final arm is typically irrefutable so the match is exhaustive.

```rust
fn main() {
    // Irrefutable: cannot fail, so `let` accepts it
    let point = (3, 7);
    let (x, y) = point;
    println!("{x} {y}");                // 3 7

    let opt: Option<i32> = Some(5);

    // Refutable in a `let` is an error:
    // let Some(n) = opt;               // error[E0005]: refutable pattern in
                                        // local binding — `None` not covered

    // The three ways to use a refutable pattern
    if let Some(n) = opt {              // 1. handle the matching case
        println!("if let: {n}");        // if let: 5
    }

    match opt {                         // 2. handle every case
        Some(n) => println!("match: {n}"),      // match: 5
        None => println!("match: none"),
    }

    let Some(n) = opt else {            // 3. bind, or diverge (next topic)
        panic!("expected a value");
    };
    println!("let else: {n}");          // let else: 5

    // `while let` also wants a refutable pattern: it stops when it stops matching
    let mut stack = vec![1, 2, 3];
    while let Some(top) = stack.pop() {
        print!("{top} ");               // 3 2 1
    }
    println!();

    // An irrefutable pattern in `if let` is a warning: the else can never run
    // if let x = 5 { println!("{x}"); }
    // warning: irrefutable `if let` pattern
}
```

| Position             | Pattern kind required | Why                              |
| -------------------- | --------------------- | -------------------------------- |
| `let` statement      | Irrefutable           | No branch exists for a failure   |
| Function parameter   | Irrefutable           | Same reason                      |
| `for` loop head      | Irrefutable           | Every item must bind             |
| `if let` / `while let` | Refutable (warns otherwise) | The non-matching branch is the point |
| `match` arm          | Either                | Arms may fail; the set must be exhaustive |
| `let ... else`       | Refutable             | The `else` handles the failure   |

> Key Takeaways
> - Irrefutable patterns always match; refutable ones may fail.
> - `let`, function parameters, and `for` heads require irrefutable patterns
>   (`E0005` otherwise).
> - `if let`, `while let`, and `let-else` exist to handle refutable patterns.
> - An irrefutable pattern in `if let` warns, because the else branch is
>   unreachable.

> 🧪 Practice
> 1. Try `let Some(n) = some_option;` and read `E0005`, then fix it three
>    different ways.
> 2. Classify these as refutable or irrefutable: `(a, b)`, `Some(x)`, `_`,
>    `Point { x, y }`, `1..=5`.
> 3. Interview: Why does `if let x = 5` produce a warning while
>    `if let Some(x) = opt` does not? (Hint: ask whether the else branch is
>    reachable in each case.)

#### let-else

A very common shape: extract a value from an `Option` or `Result`, and if it is
not there, bail out — return, `continue`, or panic. Written with `if let`, the
happy path ends up indented inside the conditional, and deep chains of extraction
produce a staircase drifting rightward.

`let ... else` (stable since Rust 1.65) inverts it. The binding lands in the
*enclosing* scope, and the `else` block handles the failure. The one requirement
is that the `else` block must diverge — it has to `return`, `break`, `continue`,
or panic, because execution cannot fall through to code that expects the binding.

The result is the guard-clause style that keeps the happy path at the left
margin, which is why `let-else` is the preferred form for validation and parsing
sequences.

```rust
#[derive(Debug)]
struct User { name: String, age: u32 }

// With let-else: each failure exits early, the happy path stays unindented
fn parse_user(line: &str) -> Option<User> {
    let mut parts = line.split(',');

    let Some(name) = parts.next() else {
        return None;                    // the else block MUST diverge
    };
    let Some(age_text) = parts.next() else {
        return None;
    };
    let Ok(age) = age_text.trim().parse::<u32>() else {
        return None;                    // works on Result as well as Option
    };
    if name.is_empty() {
        return None;
    }

    Some(User { name: name.to_string(), age })   // `name` and `age` are in scope
}

// The same logic with if let: correct, but the staircase grows with each step
fn parse_user_nested(line: &str) -> Option<User> {
    let mut parts = line.split(',');
    if let Some(name) = parts.next() {
        if let Some(age_text) = parts.next() {
            if let Ok(age) = age_text.trim().parse::<u32>() {
                return Some(User { name: name.to_string(), age });
            }
        }
    }
    None
}

fn main() {
    println!("{:?}", parse_user("Ada, 36"));
    // Some(User { name: "Ada", age: 36 })
    println!("{:?}", parse_user("Grace"));      // None — no age field
    println!("{:?}", parse_user("Alan, old"));  // None — unparsable age
    println!("{:?}", parse_user_nested("Ada, 36"));
    // Some(User { name: "Ada", age: 36 })

    if let Some(u) = parse_user("Grace, 45") {
        println!("{} is {}", u.name, u.age);        // Grace is 45
    }

    // In a loop, the else block can `continue` instead of returning
    let mut total = 0;
    for raw in ["1", "two", "3"] {
        let Ok(n) = raw.parse::<i32>() else {
            continue;                   // skip this item, keep looping
        };
        total += n;
    }
    println!("{total}");                // 4
}
```

> Key Takeaways
> - `let PATTERN = expr else { ... };` binds in the enclosing scope and handles
>   failure in the `else`.
> - The `else` block must diverge: `return`, `break`, `continue`, or panic.
> - It replaces `if let` staircases with flat guard clauses.
> - It works with any refutable pattern, including `Ok(...)` on a `Result`.

> 🧪 Practice
> 1. Rewrite a two-level `if let` chain as two `let-else` statements.
> 2. Write a loop that parses strings to numbers, skipping unparsable entries with
>    `let-else` and `continue`.
> 3. Interview: Why must the `else` block of a `let-else` diverge? (Hint: ask what
>    the value of the binding would be on the next line if the else block simply
>    finished.)

<a id="44-generics"></a>
### 4.4 Generics

Generics let one definition work for many types without giving up type checking
or paying at runtime. This section covers writing them, constraining them, and
what the compiler actually produces.

#### Generic Functions

Write a function that finds the largest `i32` in a slice, then one for `f64`, and
then one for `char`, and you have three identical bodies differing only in a
type. The alternatives in other languages are unappealing: duplicate the code,
give up type safety with `void*` or `Object`, or accept boxing and dynamic
dispatch.

A generic function introduces a *type parameter* — a placeholder filled in at
each call site. `fn largest<T>(list: &[T]) -> &T` reads "for any type `T`". The
angle brackets after the name declare the parameter, exactly as they do for
lifetimes.

There is an immediate consequence. Inside the body you may only use operations
the compiler knows `T` supports, and by default that is almost nothing. Comparing
two `T` values requires stating that `T` can be compared: `T: PartialOrd`. That
is a *trait bound* (next topic but one), and it is what makes generics
type-checked at the definition rather than at every instantiation the way C++
templates are.

Type parameters are usually inferred from the arguments. When they cannot be —
because the type appears only in the return position — the turbofish `::<T>`
supplies them explicitly.

```rust
// One definition, every comparable type
fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut biggest = &list[0];
    for item in list {
        if item > biggest {         // needs PartialOrd; without the bound: E0369
            biggest = item;
        }
    }
    biggest
}

// Two independent type parameters
fn pair<A, B>(a: A, b: B) -> (A, B) {
    (a, b)
}

// A generic that appears only in the return type: the caller must say which
fn zeroed<T: Default>() -> T {
    T::default()
}

fn main() {
    println!("{}", largest(&[3, 7, 2]));                    // 7   (i32)
    println!("{}", largest(&[1.5, 0.2, 9.9]));              // 9.9 (f64)
    println!("{}", largest(&['x', 'a', 'm']));              // x   (char)
    println!("{}", largest(&["pear", "apple", "fig"]));     // pear (&str)

    println!("{:?}", pair("id", 42));                       // ("id", 42)

    let n: i32 = zeroed();                  // inferred from the annotation
    let s = zeroed::<String>();             // turbofish: stated explicitly
    println!("{n} {s:?}");                  // 0 ""

    // Without a bound, the compiler rejects operations it cannot prove exist:
    // fn broken<T>(a: T, b: T) -> bool { a > b }
    // error[E0369]: binary operation `>` cannot be applied to type `T`
}
```

> Key Takeaways
> - A type parameter declared in `<>` lets one function body serve many types.
> - Inside the body only operations guaranteed by the bounds are available, so
>   generic code is checked once at the definition.
> - Type parameters are normally inferred; the turbofish `::<T>` states them when
>   only the return type mentions them.
> - Generic code is not slower than the hand-written monomorphic version.

> 🧪 Practice
> 1. Write `fn first<T>(items: &[T]) -> Option<&T>` and call it on a slice of
>    strings and a slice of integers.
> 2. Write a generic `swap` that takes a two-element tuple and returns it
>    reversed.
> 3. Interview: Rust checks a generic function's body once, while a C++ template
>    is checked per instantiation. What does each approach buy and cost? (Hint:
>    think about where an error is reported and how readable it is.)

#### Generic Structs and Enums

Types take parameters for the same reason functions do: a `Vec<i32>` and a
`Vec<String>` should not need separate definitions. You have been using generic
types since Chapter 1 — `Option<T>`, `Result<T, E>`, `Vec<T>`, and `Box<T>` are
all ordinary generic definitions from the standard library, not compiler magic.

Declaring one is a matter of listing the parameters after the name and using them
as field types. A type may take several, and they may be filled with different
types at each use.

Implementation blocks come in two flavours, and the difference matters:

- `impl<T> Point<T>` implements methods for **every** `T`. The parameter is
  declared after `impl` because the block itself is generic.
- `impl Point<f64>` implements methods for that **one** concrete type. Those
  methods exist only on `Point<f64>` values.

That second form is how a type offers extra capability when its parameter
supports more — a pattern taken further with bounded impls in the next topic.

```rust
#[derive(Debug)]
struct Point<T> {
    x: T,
    y: T,
}

#[derive(Debug)]
struct Pair<A, B> {         // two independent parameters
    left: A,
    right: B,
}

#[derive(Debug)]
enum Tree<T> {              // enums are generic in exactly the same way
    Leaf(T),
    Node(Box<Tree<T>>, Box<Tree<T>>),
}

impl<T> Point<T> {          // methods available for EVERY T
    fn new(x: T, y: T) -> Self {
        Self { x, y }
    }

    fn x(&self) -> &T {
        &self.x
    }
}

impl Point<f64> {           // methods available ONLY on Point<f64>
    fn distance_from_origin(&self) -> f64 {
        (self.x * self.x + self.y * self.y).sqrt()
    }
}

impl<T> Tree<T> {
    // Recursion over a generic enum: reads both Leaf and Node payloads
    fn leaves(&self) -> Vec<&T> {
        match self {
            Tree::Leaf(v) => vec![v],
            Tree::Node(left, right) => {
                let mut out = left.leaves();
                out.extend(right.leaves());
                out
            }
        }
    }
}

impl<A, B> Pair<A, B> {
    fn swap(self) -> Pair<B, A> {       // the method may change the parameters
        Pair { left: self.right, right: self.left }
    }
}

fn main() {
    let integer = Point::new(1, 2);             // Point<i32>
    let float = Point::new(3.0, 4.0);           // Point<f64>
    println!("{integer:?} {float:?}");
    // Point { x: 1, y: 2 } Point { x: 3.0, y: 4.0 }
    println!("{} {}", integer.x(), float.x());  // 1 3

    println!("{}", float.distance_from_origin());   // 5
    // integer.distance_from_origin();               // error[E0599]: no method
                                                     // found for Point<i32>

    let p = Pair { left: "id", right: 7 };
    println!("{:?}", p.swap());                 // Pair { left: 7, right: "id" }

    let tree = Tree::Node(
        Box::new(Tree::Leaf(1)),
        Box::new(Tree::Leaf(2)),
    );
    println!("{tree:?}");                       // Node(Leaf(1), Leaf(2))
    println!("{:?}", tree.leaves());            // [1, 2]

    // Both fields share one parameter, so this does not compile:
    // let mixed = Point { x: 1, y: 2.0 };      // error[E0308]: mismatched types
}
```

> Key Takeaways
> - Structs and enums take type parameters just as functions do; `Option` and
>   `Vec` are ordinary generic types.
> - `impl<T> Type<T>` adds methods for every `T`; `impl Type<Concrete>` adds them
>   for one instantiation only.
> - A single parameter used for two fields forces both to be the same type — use
>   two parameters when they may differ.
> - Methods may change the parameters, as in `Pair<A, B>::swap -> Pair<B, A>`.

> 🧪 Practice
> 1. Define `struct Stack<T>` with `push`, `pop`, and `len` methods and use it
>    with two different element types.
> 2. Add a method that exists only on `Stack<String>`, such as `join`.
> 3. Interview: Why does `impl<T> Point<T>` declare `T` twice — once after `impl`
>    and once after `Point`? (Hint: ask which position introduces the parameter
>    and which one uses it.)

#### Trait Bounds and where Clauses

A bare type parameter is nearly useless: the compiler knows nothing about `T`, so
almost no operation is allowed on it. *Trait bounds* add knowledge. `T: Display`
means "whatever `T` is, it can be formatted", which unlocks `println!("{}", value)`
inside the body.

Bounds are a contract in both directions. The function body may rely on exactly
what the bounds guarantee, and the caller must supply a type that satisfies them.
That is why generic code compiles once and reports errors at the definition,
rather than exploding at the instantiation site the way C++ templates do.

Syntax comes in three equivalent forms. Inline (`<T: Display>`) is compact and
right for one or two simple bounds. `+` combines several. A `where` clause moves
the bounds below the signature, which is far more readable once there are several
parameters or long bounds, and is required for some complex forms such as bounds
on associated types.

Bounds can also be placed on `impl` blocks, which produces *conditional methods*:
the method exists only when the parameter satisfies the bound. The standard
library uses this heavily — `Vec<T>` has `sort` only when `T: Ord`.

```rust
use std::fmt::{Debug, Display};

// Inline bound: shortest form
fn show<T: Display>(value: T) {
    println!("{value}");
}

// Multiple bounds with `+`
fn show_twice<T: Display + Clone>(value: T) {
    let copy = value.clone();
    println!("{value} {copy}");
}

// A `where` clause keeps a busy signature readable
fn summarize<T, U>(items: &[T], tag: U) -> String
where
    T: Debug,
    U: Display + Clone,
{
    format!("{tag}: {items:?}")
}

#[derive(Debug)]
struct Wrapper<T> {
    value: T,
}

impl<T> Wrapper<T> {                    // available for every T
    fn new(value: T) -> Self {
        Self { value }
    }
}

impl<T: Display + PartialOrd> Wrapper<T> {   // CONDITIONAL: only for these T
    fn print_if_bigger(&self, other: &T) {
        if self.value > *other {
            println!("{} is bigger than {other}", self.value);
        }
    }
}

struct Opaque;                          // implements neither Display nor PartialOrd

fn main() {
    show(42);                           // 42
    show("text");                       // text
    show_twice(1.5);                    // 1.5 1.5
    println!("{}", summarize(&[1, 2, 3], "nums"));      // nums: [1, 2, 3]

    let w = Wrapper::new(10);
    w.print_if_bigger(&3);              // 10 is bigger than 3

    let o = Wrapper::new(Opaque);       // `new` still works: no bound on it
    // o.print_if_bigger(&Opaque);      // error[E0599]: the method exists but
                                        // its bounds are not satisfied
    println!("{}", std::mem::size_of_val(&o.value));    // 0
}
```

| Form                                     | Best for                        |
| ---------------------------------------- | ------------------------------- |
| `fn f<T: Display>(x: T)`                 | One or two short bounds         |
| `fn f<T: Display + Clone + Debug>(x: T)` | A few bounds on one parameter   |
| `fn f<T, U>(..) where T: .., U: ..`      | Several parameters, long bounds |
| `impl<T: Bound> Type<T>`                 | Methods that exist conditionally |

> Key Takeaways
> - A trait bound tells the compiler what operations a type parameter supports;
>   without one, almost nothing is allowed.
> - Bounds are checked once at the definition, so errors point at the generic code
>   rather than at each instantiation.
> - `where` clauses are equivalent to inline bounds but far more readable with
>   several parameters.
> - Bounds on `impl` blocks create conditional methods that exist only for
>   qualifying types.

> 🧪 Practice
> 1. Write `fn print_all<T: Debug>(items: &[T])` and call it with two different
>    element types.
> 2. Convert a function with three inline bounds into `where`-clause form.
> 3. Interview: `Vec<T>` has a `sort` method, but `vec_of_structs.sort()` fails to
>    compile. What is happening, and what does the error tell you to add? (Hint:
>    think about which `impl` block `sort` lives in.)

#### Monomorphization

Generics could be implemented at runtime, by boxing values and dispatching
through a table of function pointers — that is roughly what Java's erasure and
Rust's own `dyn Trait` do. Rust's default is the opposite: *monomorphization*, a
compile-time process that generates a separate specialized copy of the code for
each concrete type actually used.

Call `largest` with a slice of `i32` and a slice of `char`, and the compiler emits
two functions, each working on its concrete type with no indirection, no boxing,
and full inlining available. The generic version exists only in the source; the
binary contains ordinary monomorphic functions.

This is what "zero-cost abstraction" means for generics: the machine code is what
you would have written by hand. The costs move to compile time — more work for
the compiler and more code in the binary, an effect known as *code bloat* when a
large generic function is instantiated for dozens of types. The standard remedy
is to keep the generic wrapper thin and put the bulk of the work in a
non-generic inner function.

```rust
use std::fmt::Display;

fn show<T: Display>(value: T) {
    println!("{value}");
}

// The bloat-avoidance pattern: a thin generic shell over a concrete worker
fn log_message<S: AsRef<str>>(msg: S) {     // instantiated per argument type
    log_inner(msg.as_ref());                // one shared, non-generic body
}

fn log_inner(msg: &str) {                   // compiled exactly once
    println!("[log] {msg}");
}

fn main() {
    show(5);            // the compiler emits show::<i32>
    show("text");       // ...and a separate show::<&str>
    show(2.5);          // ...and show::<f64>

    log_message("a literal");               // [log] a literal
    log_message(String::from("a String"));  // [log] a String
}

// Conceptually, the compiler produced:
//
//   fn show_i32(value: i32)   { println!("{value}"); }
//   fn show_str(value: &str)  { println!("{value}"); }
//   fn show_f64(value: f64)   { println!("{value}"); }
//
// Each call site jumps straight to its specialized version.
```

| Approach                       | Dispatch     | Runtime cost        | Binary size |
| ------------------------------ | ------------ | ------------------- | ----------- |
| Monomorphization (Rust generics)| Static      | None                | Larger      |
| Trait objects (`dyn Trait`)    | Dynamic      | One indirect call   | Smaller     |
| Type erasure (Java)            | Dynamic      | Boxing + indirection| Smaller     |
| Templates (C++)                | Static       | None                | Larger      |

> Key Takeaways
> - Rust compiles a separate specialized copy of generic code for each concrete
>   type used.
> - The result is static dispatch with no runtime overhead — the generic
>   disappears entirely.
> - The costs are compile time and binary size, not speed.
> - Keep generic shells thin and delegate to a non-generic function when code
>   bloat matters.

> 🧪 Practice
> 1. Write a generic function, call it with three different types, and describe
>    what the compiler emits for each.
> 2. Refactor a large generic function into a thin generic wrapper plus a
>    non-generic worker taking `&str`.
> 3. Interview: When would you deliberately choose `dyn Trait` over generics?
>    (Hint: think about binary size, compile time, and whether the set of types is
>    known at compile time at all.)

#### Const Generics

Type parameters abstract over types. *Const generics* abstract over **values**
known at compile time — in practice, almost always array lengths.

The motivating problem is that `[T; 3]` and `[T; 4]` are different types, so a
function taking `[f64; 3]` cannot accept `[f64; 4]`. Before const generics you
either wrote one function per length, accepted a slice and lost the compile-time
length, or used macros. Now the length itself becomes a parameter:
`fn sum<const N: usize>(values: [f64; N]) -> f64`.

The payoff is that sizes are checked at compile time. A matrix type
`Matrix<const R: usize, const C: usize>` makes a dimension mismatch a build error
rather than a runtime panic, and the compiler still knows every size exactly, so
loops can be unrolled and bounds checks removed.

The parameter must be an integral, `bool`, or `char` type, and it is inferred
from the argument at each call.

```rust
#[derive(Debug)]
struct Matrix<const ROWS: usize, const COLS: usize> {
    data: [[f64; COLS]; ROWS],
}

impl<const ROWS: usize, const COLS: usize> Matrix<ROWS, COLS> {
    fn zeros() -> Self {
        Self { data: [[0.0; COLS]; ROWS] }
    }

    fn dimensions(&self) -> (usize, usize) {
        (ROWS, COLS)                    // the parameters are usable as values
    }

    // Multiplication is only defined when the inner dimensions agree, and the
    // compiler enforces that from the signature alone
    fn multiply<const OTHER: usize>(
        &self,
        rhs: &Matrix<COLS, OTHER>,
    ) -> Matrix<ROWS, OTHER> {
        let mut out = Matrix::<ROWS, OTHER>::zeros();
        for r in 0..ROWS {
            for c in 0..OTHER {
                for k in 0..COLS {
                    out.data[r][c] += self.data[r][k] * rhs.data[k][c];
                }
            }
        }
        out
    }
}

// One function for arrays of any length; N is inferred at the call
fn sum<const N: usize>(values: [f64; N]) -> f64 {
    values.iter().sum()
}

fn main() {
    println!("{}", sum([1.0, 2.0, 3.0]));           // 6  — N inferred as 3
    println!("{}", sum([1.0; 5]));                  // 5  — N inferred as 5

    let a: Matrix<2, 3> = Matrix::zeros();
    let b: Matrix<3, 4> = Matrix::zeros();
    let product = a.multiply(&b);                   // Matrix<2, 4>
    println!("{:?} {:?}", a.dimensions(), product.dimensions());   // (2, 3) (2, 4)

    // let bad = b.multiply(&b);        // error[E0308]: expected Matrix<4, _>,
                                        // found Matrix<3, 4> — dimensions
                                        // checked at COMPILE time
}
```

> Key Takeaways
> - Const generics parameterize a type or function over a compile-time value,
>   usually an array length.
> - They let one definition serve every array size while keeping the length in
>   the type.
> - Dimension and size errors become compile errors instead of runtime panics.
> - The parameter is limited to integral, `bool`, and `char` types.

> 🧪 Practice
> 1. Write `fn first_and_last<const N: usize>(a: [i32; N]) -> (i32, i32)` and call
>    it with arrays of two different lengths.
> 2. Add a `transpose` method to `Matrix<ROWS, COLS>` returning
>    `Matrix<COLS, ROWS>`.
> 3. Interview: What does `Matrix<2, 3>` catch that a runtime `rows`/`cols` field
>    does not? (Hint: ask when a dimension mismatch is discovered in each design.)

#### Phantom Types

Occasionally you want a type parameter that appears nowhere in the data — used
purely to distinguish types at compile time. Rust will not allow an unused
parameter (`E0392`), because it affects variance and drop checking, so you need a
field that mentions it without occupying space. That field is
`PhantomData<T>`: a zero-sized marker that says "this type behaves as though it
contained a `T`".

Two patterns dominate.

**Unit and identity tagging.** `Length<Meters>` and `Length<Feet>` both store one
`f64`, but they are different types, so adding them is a compile error. Same for
`Id<User>` versus `Id<Order>` — both wrap a `u64`, and mixing them up is exactly
the kind of bug that survives code review.

**Typestate.** Encode an object's state in its type: `Door<Open>` and
`Door<Closed>` are distinct, and `fn open(self) -> Door<Open>` can be defined only
on `Door<Closed>`. Calling `open` twice then fails to compile rather than
panicking at runtime.

All of it is erased before code generation: the marker occupies no space and the
checks cost nothing.

```rust
use std::marker::PhantomData;

// --- Unit tagging -----------------------------------------------------------
struct Meters;
struct Feet;

#[derive(Debug)]
struct Length<Unit> {
    value: f64,
    _unit: PhantomData<Unit>,       // no data; exists so `Unit` is used
}

impl<Unit> Length<Unit> {
    fn new(value: f64) -> Self {
        Self { value, _unit: PhantomData }
    }

    // Only lengths of the SAME unit can be added
    fn add(self, other: Self) -> Self {
        Self::new(self.value + other.value)
    }
}

// --- Typestate --------------------------------------------------------------
struct Open;
struct Closed;

struct Door<State> {
    _state: PhantomData<State>,
}

impl Door<Closed> {
    fn new() -> Self {
        Door { _state: PhantomData }
    }
    fn open(self) -> Door<Open> {       // only a closed door can be opened
        println!("opening");
        Door { _state: PhantomData }
    }
}

impl Door<Open> {
    fn close(self) -> Door<Closed> {    // only an open door can be closed
        println!("closing");
        Door { _state: PhantomData }
    }
}

fn main() {
    let a: Length<Meters> = Length::new(3.0);
    let b: Length<Meters> = Length::new(4.0);
    println!("{}", a.add(b).value);         // 7

    let c: Length<Feet> = Length::new(10.0);
    // let bad = Length::<Meters>::new(1.0).add(c);   // error[E0308]: expected
                                                      // Length<Meters>, found
                                                      // Length<Feet>
    println!("{}", c.value);                // 10

    // The marker is free
    println!("{}", std::mem::size_of::<Length<Meters>>());   // 8, same as f64
    println!("{}", std::mem::size_of::<Door<Open>>());       // 0

    let door = Door::<Closed>::new();
    let door = door.open();                 // opening
    let door = door.close();                // closing
    // door.close();                        // error[E0599]: no method `close`
                                            // on Door<Closed>
    let _ = door;
}
```

> Key Takeaways
> - `PhantomData<T>` lets a type carry a parameter it does not store, satisfying
>   the "unused parameter" rule (`E0392`).
> - Phantom types distinguish otherwise identical representations: units,
>   identifiers, states.
> - The typestate pattern encodes a state machine in the type system, so invalid
>   transitions do not compile.
> - Everything is erased at compile time: markers are zero-sized and checks are
>   free.

> 🧪 Practice
> 1. Build `Id<User>` and `Id<Order>` newtypes over `u64` with `PhantomData` and
>    confirm they cannot be interchanged.
> 2. Add a `Locked` state to the `Door` example so that only an open door can be
>    locked.
> 3. Interview: Why does Rust reject a struct with an unused type parameter
>    instead of just ignoring it? (Hint: the parameter still affects how the
>    compiler reasons about variance and dropping.)

---

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
