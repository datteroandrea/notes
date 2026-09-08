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

This chapter establishes the ground you stand on before writing serious C: where the language came from, which standard you are actually compiling against, what a C program is made of, and how source text becomes a running executable. Understanding the toolchain is not optional trivia in C — the compiler, preprocessor, assembler, and linker are separate tools with separate failure modes, and most beginner confusion comes from not knowing which one is complaining. By the end you should be able to read a standard revision's feature list, invoke GCC or Clang deliberately rather than by ritual, and decode any diagnostic it produces.

<a id="11-origins-and-standards"></a>
### 1.1 Origins and Standards

C is not one language but a family of closely related dialects, each pinned by an ISO standard. This section explains how C came to be, why the standards matter in daily practice, and which flavor you should target.

#### History of C

**Theory**

C exists because someone needed to write an operating system without writing assembly. In the late 1960s, systems software was written in assembly language, which meant that porting an OS to new hardware meant rewriting it entirely. Martin Richards' BCPL (1967) offered a portable, typeless systems language; Ken Thompson trimmed it into **B** (1969) for early Unix on the PDP-7. B had one data type — the machine word — which was fine on a word-addressed machine and terrible on the byte-addressed PDP-11.

Dennis Ritchie evolved B into **C** at Bell Labs between 1971 and 1973, adding a type system (`char`, `int`, `float`, `double`), structures, and pointer arithmetic tied to the size of the pointed-to type. The decisive moment came in 1973, when Unix was rewritten in C. An operating system had become *portable software*, and C rode Unix onto every architecture Unix reached.

The design philosophy that resulted still governs the language:

- **Trust the programmer.** No bounds checks, no garbage collector, no hidden costs.
- **Keep the language small.** Anything that can live in a library does.
- **Map cleanly to hardware.** Every construct should have an obvious machine-code translation.
- **Make it portable, but not at any price.** Where hardware genuinely differs (integer width, byte order), C exposes the difference rather than papering over it.

Think of C as a **portable assembler with types**. It is the thinnest reasonable abstraction over "a machine with a flat byte-addressable memory and a stack," which is why it survived while richer contemporaries did not.

```text
BCPL (1967, Richards)
   |  typeless, word-oriented
   v
B (1969, Thompson)          -- Unix on PDP-7
   |  + byte addressing needed
   v
C (1972-73, Ritchie)        -- Unix rewritten in C (1973)
   |
   +--> K&R C (1978, "The C Programming Language")
   |
   +--> ANSI C / C89 (1989) --> ISO C90 (1990)
            |
            +--> C95 -> C99 -> C11 -> C17 -> C23
```

**Examples**

The oldest C program still compiles, more or less unchanged — a rare property in programming languages:

```c
/* The 1978 K&R "hello, world", modernized only enough to be legal C today. */
#include <stdio.h>   /* K&R original had no #include and no return type */

int main(void)
{
    printf("hello, world\n");
    return 0;
}
```

**Key Takeaways**

- C was created (1972–73, Dennis Ritchie, Bell Labs) to make Unix portable; its ancestry is BCPL → B → C.
- Adding a type system to B's word-oriented model is what made C usable on byte-addressed hardware.
- Core philosophy: small language, large library, trust the programmer, map predictably to machine code.
- C spread because Unix spread; the two are historically inseparable.

> 🧪 Practice
>
> 1. Compile the "hello, world" program above with `cc hello.c -o hello` and run it. Then delete the `#include <stdio.h>` line and recompile — record the exact diagnostic your compiler gives, and explain why the program may still link and run.
> 2. Research one language feature C deliberately *omits* (for example: nested functions, string type, exceptions, modules pre-C23). Write a short paragraph on what C requires you to do instead and what that costs.
> 3. Interview-style: *"Why is C still used for operating system kernels when safer languages exist?"* Hint: think about what a kernel cannot rely on — a runtime, a heap that already exists, or a garbage collector that can pause execution.

#### K&R C vs ANSI C

**Theory**

Before 1989 there was no C standard — there was a *book*. Kernighan and Ritchie's *The C Programming Language* (1978) was the de facto specification, and the dialect it described is called **K&R C**. Compilers each interpreted it slightly differently, and the language had genuine holes that the book simply did not address.

The most consequential difference is **function prototypes**. In K&R C, a function declaration told the compiler the return type but *not* the parameter types, so the compiler could not check your arguments or convert them:

```c
/* K&R style: the declaration promises nothing about parameters. */
double sqrt();              /* "sqrt returns double" -- that's all */

/* K&R style definition: names first, types in a separate list. */
double scale(x, factor)
double x;
double factor;
{
    return x * factor;
}
```

Call `scale(2, 3)` with integer arguments and the compiler had no idea it needed to convert them to `double`; it passed raw ints and the function reinterpreted the bits as floating point. Garbage in, garbage out, silently.

ANSI committee X3J11 standardized C in 1989, importing prototypes from C++ along with `void`, `const`, `volatile`, `signed`, enumerations, standard library declarations in headers, and a defined preprocessor.

| Aspect | K&R C (1978) | ANSI C / C89 (1989) |
| --- | --- | --- |
| Function declarations | No parameter types | Full prototypes, arguments checked |
| Function definitions | Identifier list + separate declarations | Types inline in the parameter list |
| `void` | Absent | Return type and "no parameters" marker |
| `const` / `volatile` | Absent | Present |
| Standard library | Convention only | Specified with headers |
| Preprocessor | Varied by compiler | Specified (`#`, `##`, standard directives) |
| Implicit `int` | Pervasive | Allowed but discouraged |

A crucial trap survived into modern C: `int f()` does **not** mean "takes no arguments" in C89–C17 — it means "takes an unspecified number of arguments." Only `int f(void)` means no arguments. C23 finally changed `()` to mean `(void)`, aligning with C++.

**Examples**

```c
#include <stdio.h>

/* ANSI/modern: prototype fully specifies parameters. */
double scale(double x, double factor);

/* Empty parens: NOT "no arguments" before C23 -- unchecked call! */
void legacy();

int main(void)
{
    printf("%f\n", scale(2, 3));  /* 2 and 3 converted to double: prints 6.000000 */
    legacy(1, "oops", 3.5);       /* Compiles under C17: no prototype, no check */
    return 0;
}

double scale(double x, double factor)
{
    return x * factor;
}

void legacy(void) { }
```

Compile with `-Wstrict-prototypes` and the compiler will flag `void legacy();` as a declaration without a prototype.

**Key Takeaways**

- K&R C was defined by a book, not a standard; ANSI C89 was the first formal specification.
- Prototypes are the headline change: they enable argument type checking and implicit conversion at call sites.
- Always write `f(void)`, never `f()`, in C17 and earlier; C23 makes `()` equivalent to `(void)`.
- K&R-style function definitions were removed entirely in C23 — modern code should never use them.

> 🧪 Practice
>
> 1. Write a K&R-style function definition and compile it with `gcc -std=c17` and then `gcc -std=c23` (or `-std=c2x` on older GCC). Compare the diagnostics.
> 2. Declare `int add();` and define it as `int add(int a, int b) { return a + b; }`. Call `add(1)` and `add(1, 2, 3)` under `-std=c17 -Wall -Wextra`. Which calls are diagnosed? What does the program actually print?
> 3. Add `-Wstrict-prototypes -Wmissing-prototypes` to a small project of yours and fix every warning. Note which ones represented real risk.

#### C89/C99/C11/C17/C23

**Theory**

Each standard revision adds features while preserving backward compatibility almost perfectly. Practically, the standard you pick determines which syntax the compiler accepts and which library functions it declares. Choosing one is a portability decision: older standards run on more compilers (embedded vendors lag badly), newer ones give you better tools.

| Standard | Year | Headline additions |
| --- | --- | --- |
| **C89/C90** | 1989/1990 | Prototypes, `void`, `const`, `volatile`, enums, standard library. Declarations only at block start. |
| **C95** (amendment) | 1995 | Wide characters (`wchar.h`, `wctype.h`), digraphs, `iso646.h`. |
| **C99** | 1999 | `//` comments, declarations anywhere, `long long`, `_Bool`/`stdbool.h`, `stdint.h`, `inline`, `restrict`, VLAs, designated initializers, compound literals, flexible array members, `snprintf`, variadic macros. |
| **C11** | 2011 | `_Generic`, `_Static_assert`, `_Alignas`/`_Alignof`, anonymous structs/unions, `threads.h`, `stdatomic.h`, `aligned_alloc`, `_Noreturn`; VLAs made optional; `gets` removed. |
| **C17/C18** | 2018 | No new features — defect reports and clarifications only. The safe modern default. |
| **C23** | 2024 | `nullptr`, `bool`/`true`/`false` as keywords, `constexpr`, `typeof`, `[[attributes]]`, binary literals `0b1010`, digit separators `1'000'000`, `#embed`, enums with fixed underlying type, `()` means `(void)`, K&R definitions removed, `unreachable()`, `memset_explicit`. |

Select the dialect with `-std=`:

```bash
gcc -std=c89 file.c     # strict old-school; also -std=c90
gcc -std=c99 file.c
gcc -std=c11 file.c
gcc -std=c17 file.c     # sensible default today
gcc -std=c23 file.c     # newer GCC/Clang; older ones spell it -std=c2x
```

Add `-pedantic` to make the compiler actually enforce the standard and reject GNU extensions. Without `-std=`, GCC defaults to a *GNU* dialect (`gnu17` or `gnu23` depending on version), which quietly enables non-standard extensions.

You can detect the standard in code via the `__STDC_VERSION__` macro:

| Standard | `__STDC_VERSION__` |
| --- | --- |
| C89/C90 | undefined |
| C95 | `199409L` |
| C99 | `199901L` |
| C11 | `201112L` |
| C17 | `201710L` |
| C23 | `202311L` |

**Examples**

```c
#include <stdio.h>

int main(void)
{
#if !defined(__STDC_VERSION__)
    puts("C89/C90");
#elif __STDC_VERSION__ >= 202311L
    puts("C23 or later");
#elif __STDC_VERSION__ >= 201710L
    puts("C17");
#elif __STDC_VERSION__ >= 201112L
    puts("C11");
#elif __STDC_VERSION__ >= 199901L
    puts("C99");
#else
    puts("C95");
#endif
    return 0;
}
```

A snippet that is legal C99 but rejected by strict C89:

```c
#include <stdio.h>

int main(void)
{
    int n = 3;                 /* C89: fine */
    printf("%d\n", n);
    int m = n * 2;             /* C89 error: declaration after statement */
    for (int i = 0; i < m; i++)/* C89 error: declaration inside for-init */
        printf("%d ", i);      // C89 error: // comment
    putchar('\n');
    return 0;
}
```

Try `gcc -std=c89 -pedantic-errors` versus `gcc -std=c99` on it.

**Key Takeaways**

- Default to `-std=c17` for portability plus modern features; move to `-std=c23` only when your toolchain and target support it.
- C99 is the watershed release: `//` comments, mid-block declarations, `stdint.h`, `stdbool.h`, designated initializers.
- C11 added the concurrency and generic-selection machinery; C17 added nothing but fixes.
- Without an explicit `-std=`, GCC and Clang enable GNU extensions — your "portable" code may not be.
- Use `__STDC_VERSION__` for conditional compilation across standards.

> 🧪 Practice
>
> 1. Compile the version-detection program with `-std=c89`, `-std=c99`, `-std=c11`, and `-std=c17` and confirm the output matches each time.
> 2. Take the C99 snippet above and rewrite it to compile cleanly under `gcc -std=c89 -pedantic-errors`.
> 3. Run `gcc -dM -E -x c /dev/null | sort | head -40` to dump predefined macros. Then diff the output between `-std=c17` and `-std=gnu17`. What extra macros does the GNU dialect define?
> 4. Interview-style: *"What does `-pedantic` do, and why might a large codebase avoid it?"* Hint: consider how many real projects rely on GNU extensions like statement expressions or `__attribute__`.

#### Freestanding vs Hosted Implementations

**Theory**

The C standard recognizes that C runs in two very different worlds. A **hosted implementation** assumes an operating system underneath: there is a file system, a heap, a `main` that gets called, and the complete standard library. A **freestanding implementation** assumes almost nothing — it is C for kernels, bootloaders, and microcontrollers where there is no OS to provide services.

The difference is contractual, not stylistic:

| | Hosted | Freestanding |
| --- | --- | --- |
| Entry point | `main` with defined signatures | Implementation-defined (e.g. `_start`, `Reset_Handler`) |
| Standard library | Complete | Minimal required set only |
| `malloc`, `printf`, `fopen` | Available | Not guaranteed |
| Startup code | Provided by the C runtime (crt0) | You write it |
| Typical target | Linux/Windows/macOS application | Kernel, bootloader, bare-metal firmware |

Freestanding implementations must supply only the headers that declare *types and macros* rather than functions requiring OS support:

```text
Freestanding-required headers
  <float.h>      <iso646.h>     <limits.h>     <stdalign.h>   (C11)
  <stdarg.h>     <stdbool.h>    <stddef.h>     <stdint.h>
  <stdnoreturn.h> (C11)         + C23 adds <stdbit.h>, <stckdint.h>, etc.

Notably ABSENT: <stdio.h>  <stdlib.h>  <string.h>  <math.h>  <time.h>
```

The macro `__STDC_HOSTED__` is `1` for hosted, `0` for freestanding.

An important gotcha: even in freestanding mode, compilers may emit calls to `memcpy`, `memset`, `memmove`, and `memcmp` when they optimize struct assignments or array initializations. Bare-metal projects must supply these four functions themselves.

**Examples**

```c
/* Detect the environment at compile time. */
#include <stdio.h>

int main(void)
{
#if __STDC_HOSTED__
    puts("hosted: OS services available");
#else
    /* No puts() here -- we would have to write to a UART directly. */
#endif
    return 0;
}
```

A minimal freestanding program for an embedded target:

```c
/* Compiled with: arm-none-eabi-gcc -ffreestanding -nostdlib -nostartfiles ... */

/* No stdio, no malloc, no main() call from a runtime. */
volatile unsigned int *const GPIO_OUT = (unsigned int *)0x40020014;

void Reset_Handler(void)   /* Named in the vector table, not "main" */
{
    for (;;) {
        *GPIO_OUT ^= (1u << 5);   /* Toggle an LED; volatile prevents removal */
    }
}

/* The compiler may still emit calls to these -- we must provide them. */
void *memset(void *dst, int c, unsigned long n)
{
    unsigned char *p = dst;
    while (n--) *p++ = (unsigned char)c;
    return dst;
}
```

Relevant flags:

```bash
gcc -ffreestanding    # do not assume standard library semantics
gcc -nostdlib         # do not link libc or startup files
gcc -nostartfiles     # link libc but not crt0
gcc -fno-builtin      # do not transform code into implicit libc calls
```

**Key Takeaways**

- Hosted C assumes an OS and the full standard library; freestanding C assumes almost nothing.
- Freestanding guarantees only type/macro headers (`stddef.h`, `stdint.h`, `limits.h`, `stdarg.h`, …), never `stdio.h` or `stdlib.h`.
- In freestanding mode the entry point is implementation-defined — usually a reset vector, not `main`.
- Check `__STDC_HOSTED__` to write code that adapts to both.
- Even freestanding builds often need hand-written `memcpy`/`memset`; the compiler generates calls to them.

> 🧪 Practice
>
> 1. Write a program that prints whether `__STDC_HOSTED__` is 1 or 0, then compile it with and without `-ffreestanding` and observe whether the macro changes on your toolchain.
> 2. Try `gcc -nostdlib hello.c -o hello` on a normal "hello world". Read the linker errors carefully and explain each one.
> 3. Interview-style: *"You are writing a kernel and cannot use `malloc`. What allocation strategies remain available?"* Hint: think about static arrays, arena/bump allocators, and fixed-size object pools.

#### Where C Is Used Today

**Theory**

C is no longer the default language for new applications, and it does not need to be. Its territory is the layer beneath everything else — the software that other software runs on top of, where the cost of an abstraction is unacceptable or where no runtime exists to provide one.

Where C dominates:

- **Operating system kernels** — Linux, the BSDs, Windows kernel components, and most RTOSes (FreeRTOS, Zephyr).
- **Embedded and firmware** — microcontrollers with kilobytes of RAM, automotive ECUs, medical devices, industrial control.
- **Language runtimes and interpreters** — CPython, Ruby MRI, PHP, Lua, and the reference implementations of most scripting languages.
- **Databases and infrastructure** — SQLite, PostgreSQL, Redis, nginx, Git, curl.
- **Numerical and media libraries** — BLAS/LAPACK kernels, FFmpeg, zlib, OpenSSL.
- **The universal FFI** — the C ABI is the lingua franca. Python, Rust, Go, Java, and JavaScript all bind to native code by pretending to be C.

That last point is the most underrated reason to learn C: **C is the interoperability standard**. When Rust exposes a library to Python, the interface is `extern "C"`. C's calling convention and memory layout are the neutral ground every language agrees on.

Where C is losing ground, honestly: new application code, new systems projects that can adopt Rust or Zig, and any domain where memory-safety vulnerabilities carry high cost. Roughly 70% of severe CVEs in large C/C++ codebases have historically been memory-safety issues. Knowing C today means knowing both its power and this specific liability.

```text
        Application layer   (Python, JS, Java, Go, Swift)
                |  FFI / bindings -- expressed in C
        ----------------------------------------------
        Runtimes & libraries (CPython, V8 parts, SQLite, OpenSSL)  <- C
        ----------------------------------------------
        OS kernel & drivers  (Linux, BSD, RTOS)                    <- C
        ----------------------------------------------
        Firmware / bootloader / bare metal                         <- C
        ----------------------------------------------
        Hardware
```

**Examples**

Exposing a C function to Python via `ctypes` — the FFI pattern in miniature:

```c
/* fastmath.c -- build: gcc -shared -fPIC fastmath.c -o libfastmath.so */
int sum_range(int lo, int hi)
{
    int total = 0;
    for (int i = lo; i < hi; i++)
        total += i;
    return total;
}
```

```python
# driver.py
import ctypes
lib = ctypes.CDLL("./libfastmath.so")
lib.sum_range.argtypes = [ctypes.c_int, ctypes.c_int]  # declare the C prototype
lib.sum_range.restype = ctypes.c_int
print(lib.sum_range(1, 1000))                          # 499500
```

**Key Takeaways**

- C's niche is the foundation layer: kernels, firmware, runtimes, and performance-critical libraries.
- The C ABI is the universal interoperability layer between all other languages.
- C is chosen for predictable performance, minimal runtime requirements, and ubiquitous compiler support.
- Its dominant weakness is memory safety; modern C practice is largely about mitigating that with tooling and discipline.

> 🧪 Practice
>
> 1. Pick a tool you use daily (`git`, `curl`, `sqlite3`, `redis-server`) and find its source repository. Identify the file containing `main()` and skim the first 50 lines.
> 2. Build the `sum_range` shared library above and call it from Python via `ctypes`. Then deliberately declare `restype` as `c_double` and explain the garbage you get back.
> 3. Interview-style: *"When would you choose C over Rust for a new project in 2026?"* Hint: consider toolchain availability on exotic targets, certification requirements (MISRA/DO-178C), and existing codebase integration.

<a id="12-program-structure"></a>
### 1.2 Program Structure

Before writing logic, you need to know what shape a C program takes and what each piece is for. This section dissects a minimal program and defines the vocabulary — statements, blocks, translation units — that the rest of the language builds on.

#### Anatomy of a C Program

**Theory**

A C source file is a sequence of **top-level declarations and definitions**. There is no class, no module wrapper, no implicit entry point — just things declared at file scope, in the order you wrote them. The compiler reads top to bottom and must have *seen* a name before you use it, which is why headers and prototypes appear near the top.

A conventional file has this shape:

```text
+-----------------------------------------------+
| 1. Preprocessor directives  (#include, #define)|  -- textual, run first
+-----------------------------------------------+
| 2. Type declarations        (struct, enum,     |
|    typedef)                                    |
+-----------------------------------------------+
| 3. Function prototypes                         |  -- promises to the compiler
+-----------------------------------------------+
| 4. File-scope variables     (globals, statics) |
+-----------------------------------------------+
| 5. Function definitions     (the actual code)  |
+-----------------------------------------------+
```

Every C program needs exactly one `main` (in a hosted implementation), and execution starts there — but note that file-scope variables are initialized *before* `main` runs.

**Examples**

```c
/* ---- 1. Preprocessor directives ---------------------------------- */
#include <stdio.h>      /* brings in printf's prototype */
#include <stdlib.h>     /* EXIT_SUCCESS, EXIT_FAILURE */

#define MAX_ITEMS 8     /* object-like macro: pure text substitution */

/* ---- 2. Type declarations ---------------------------------------- */
typedef struct {
    const char *name;
    double      price;
} Item;

/* ---- 3. Function prototypes -------------------------------------- */
static double total_price(const Item *items, size_t count);
static void   print_item(const Item *item);

/* ---- 4. File-scope data ------------------------------------------ */
static const Item catalog[] = {   /* 'static' = private to this file */
    { "bolt",   0.25 },
    { "nut",    0.10 },
    { "washer", 0.05 },
};

/* ---- 5. Function definitions -------------------------------------- */
int main(void)
{
    size_t n = sizeof catalog / sizeof catalog[0];  /* idiomatic array length */

    for (size_t i = 0; i < n; i++)
        print_item(&catalog[i]);

    printf("Total: %.2f\n", total_price(catalog, n));
    return EXIT_SUCCESS;
}

static void print_item(const Item *item)
{
    printf("%-8s %5.2f\n", item->name, item->price);  /* %-8s = left-pad to 8 */
}

static double total_price(const Item *items, size_t count)
{
    double sum = 0.0;
    for (size_t i = 0; i < count; i++)
        sum += items[i].price;
    return sum;
}
```

**Key Takeaways**

- A C file is a flat list of declarations; order matters because the compiler is a single forward pass.
- Conventional layout: includes → types → prototypes → file-scope data → definitions.
- `static` at file scope means "internal linkage" — the name is private to this translation unit.
- File-scope objects with initializers are set up before `main` begins executing.
- `sizeof arr / sizeof arr[0]` gives element count, but only where `arr` is a real array, not a decayed pointer.

> 🧪 Practice
>
> 1. Reorder the file above so `print_item` is defined *after* `main` but delete its prototype. Record the compiler's diagnostic and explain it.
> 2. Add a file-scope `int counter = 0;` and a function that increments it. Print it from `main` before and after calling the function.
> 3. Add a second `.c` file that also declares `static const Item catalog[]`. Compile and link both. Does it collide? Now remove `static` from both and try again.

#### The main Function and Return Codes

**Theory**

`main` is the entry point of a hosted C program, and the standard permits exactly two portable signatures:

```c
int main(void);
int main(int argc, char *argv[]);
```

Anything else (`void main()`, `int main(int, char**, char**)`) is either non-standard or implementation-defined. `void main` is simply wrong in standard C, even though some embedded compilers accept it.

The return value of `main` is the program's **exit status**, communicated to whatever launched it. By convention:

- `0` (or `EXIT_SUCCESS`) means success.
- Any nonzero value means failure; `EXIT_FAILURE` is the portable "something went wrong."

Only `0`, `EXIT_SUCCESS`, and `EXIT_FAILURE` are portable. On POSIX systems the status is truncated to its low 8 bits, so `return 256;` is observed as `0` by the shell — a genuine bug source.

Since C99, falling off the end of `main` without a `return` is equivalent to `return 0;`. This is special-cased for `main` only; every other non-`void` function that runs off the end and whose value is used is undefined behavior.

`argc` is the argument count and `argv` is an array of `argc + 1` pointers, where `argv[0]` is conventionally the program name and `argv[argc]` is guaranteed to be `NULL`.

```text
Shell command:  ./tool -v input.txt

argc = 3
argv ---> [0] --> "./tool"
          [1] --> "-v"
          [2] --> "input.txt"
          [3] --> NULL        <-- always present, guaranteed by the standard
```

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    if (argc < 2) {
        /* Usage errors go to stderr, not stdout. */
        fprintf(stderr, "usage: %s <filename>\n", argv[0]);
        return EXIT_FAILURE;          /* nonzero: the caller can detect failure */
    }

    for (int i = 0; i < argc; i++)
        printf("argv[%d] = \"%s\"\n", i, argv[i]);

    /* argv is NULL-terminated, so this loop is equivalent: */
    for (char **p = argv; *p != NULL; p++)
        printf("  -> %s\n", *p);

    return EXIT_SUCCESS;              /* 0 */
}
```

Inspecting the exit status from a shell:

```bash
$ ./tool
usage: ./tool <filename>
$ echo $?
1
$ ./tool notes.txt
argv[0] = "./tool"
argv[1] = "notes.txt"
$ echo $?
0
```

**Key Takeaways**

- Use `int main(void)` or `int main(int argc, char *argv[])`; never `void main`.
- Return `0`/`EXIT_SUCCESS` on success and `EXIT_FAILURE` (or a small documented nonzero) on failure.
- Exit status is truncated to 8 bits on POSIX — keep return values in `0..255`.
- Since C99, reaching the end of `main` implies `return 0;`; no other function gets that courtesy.
- `argv[0]` is the program name and `argv[argc]` is `NULL`; error messages belong on `stderr`.

> 🧪 Practice
>
> 1. Write a program that returns the number of command-line arguments it received (excluding the program name) and verify with `echo $?`.
> 2. Make a program `return 300;` and observe the shell's `$?`. Explain the value you see.
> 3. Write an `echo` clone that prints all arguments separated by spaces followed by a newline, iterating with the `NULL`-terminated pointer walk rather than `argc`.
> 4. Interview-style: *"What is the difference between `return 1;` from `main` and calling `exit(1)` from a nested function?"* Hint: consider what happens to local variables and to functions registered with `atexit`.

#### Statements and Blocks

**Theory**

A **statement** is a unit of execution terminated by a semicolon. A **block** (compound statement) is a `{ ... }`-delimited sequence of declarations and statements that acts as a single statement anywhere one is expected, and — critically — introduces a new **scope**.

Statement categories:

| Category | Examples |
| --- | --- |
| Expression statement | `x = 5;`, `foo();`, `i++;` |
| Compound statement (block) | `{ int t = a; a = b; b = t; }` |
| Selection | `if`, `switch` |
| Iteration | `while`, `do`, `for` |
| Jump | `break`, `continue`, `goto`, `return` |
| Labeled | `label:`, `case 3:`, `default:` |
| Null statement | `;` alone |

The mental model to internalize: **control structures take exactly one statement.** A block is how you give them more than one. This is why omitting braces is dangerous — the infamous "goto fail" bug in Apple's TLS stack came from exactly this.

```c
if (condition)
    do_one();          /* only this line is guarded */
    do_two();          /* ALWAYS runs -- indentation lies */
```

The null statement `;` is legal and occasionally intentional, but a stray semicolon after a loop header is a classic bug:

```c
for (int i = 0; i < 10; i++);   /* body is the empty statement! */
    printf("%d\n", i);          /* runs once, and i is out of scope anyway */
```

**Examples**

```c
#include <stdio.h>

int main(void)
{
    int x = 10;

    {                       /* Block: introduces a nested scope */
        int x = 20;         /* Shadows the outer x -- legal, but confusing */
        printf("inner x = %d\n", x);   /* 20 */
    }                       /* inner x's lifetime ends here */

    printf("outer x = %d\n", x);       /* 10 */

    /* Braces make multi-statement bodies unambiguous. */
    if (x > 5) {
        printf("big\n");
        x -= 5;
    } else {
        printf("small\n");
    }

    /* An intentional empty body, written explicitly for the reader. */
    int n = 0;
    while (n++ < 3)
        ;                   /* deliberate no-op, on its own line */

    printf("n = %d\n", n);  /* 4 */
    return 0;
}
```

**Key Takeaways**

- A block `{ }` is one statement and one scope; variables declared inside it die at the closing brace.
- Control structures bind to a single statement — always use braces, even for one-liners.
- A stray `;` after `if (...)`, `for (...)`, or `while (...)` silently creates an empty body.
- Inner declarations shadow outer ones; `-Wshadow` will warn you about it.
- Since C99, declarations may appear anywhere in a block, not just at the top.

> 🧪 Practice
>
> 1. Write a program containing the `if` without braces bug above and confirm both lines execute. Then fix it with braces.
> 2. Nest three blocks, each declaring an `int v` with a different value, and print `v` at every level to trace shadowing. Recompile with `-Wshadow`.
> 3. Explain what `for (i = 0; i < n; i++);` does versus `for (i = 0; i < n; i++) { }` — and whether there is any difference at all.

#### Comments

**Theory**

C has two comment forms, and their differences matter more than they first appear.

**Block comments** `/* ... */` come from the original language and **do not nest**. The comment ends at the *first* `*/`, which makes commenting out a region that already contains block comments a reliable way to break your build:

```c
/* disable this section
   int a = compute();   /* get the value */   <-- comment ENDS here
   use(a);
*/                                            <-- stray, syntax error
```

**Line comments** `// ...` were added in C99 (borrowed from C++/BCPL) and run to end of line. They nest harmlessly inside block comments, which is why the standard idiom for disabling code is `#if 0` rather than comments at all:

```c
#if 0
    int a = compute();   /* block comments inside are fine */
    use(a);
#endif
```

Comments are removed during translation phase 3 and each is replaced by **one space**, not nothing. That matters in rare token-pasting cases: `a/**/b` is two tokens `a` and `b`, not `ab`.

Style guidance: comments should explain *why*, not *what*. The code already says what it does.

```c
i++;                      /* Bad: increment i */
i++;                      /* Good: skip the delimiter byte */
```

**Examples**

```c
#include <stdio.h>

/*
 * Multi-line block comment, traditional style.
 * Good for file headers and function documentation.
 */

/**
 * Doxygen-style documentation comment.
 * @param n  Number of retries; must be positive.
 * @return   0 on success, -1 on failure.
 */
int retry(int n);

int main(void)
{
    int flags = 0;      // C99 line comment: trailing note
    flags |= 1 << 3;    // set bit 3: enables verbose output

    /* Commenting out with #if 0 survives nested comments: */
#if 0
    printf("debug: flags = %d\n", flags);   /* still fine */
#endif

    /* Watch out: a line comment ending with a backslash continues! */
    // this comment continues to the next line \
    printf("this line is INSIDE the comment\n");

    printf("flags = %d\n", flags);
    return 0;
}
```

**Key Takeaways**

- `/* */` does not nest; `//` is C99 and later.
- Use `#if 0 ... #endif` to disable blocks of code, never block comments.
- Each comment is replaced by a single space during preprocessing.
- A `//` comment ending in a backslash swallows the following line — a genuine source of bugs.
- Comment the reasoning, the invariant, or the non-obvious constraint; not the syntax.

> 🧪 Practice
>
> 1. Write a file containing a nested block comment and record the exact error. Then fix it with `#if 0`.
> 2. Reproduce the backslash-continuation trap and confirm the following line does not execute.
> 3. Take a 20-line function you wrote recently and rewrite its comments so none of them describe *what* a line does — only why.

#### Source Files and Translation Units

**Theory**

The standard's unit of compilation is the **translation unit (TU)**: one source file *after* the preprocessor has run, meaning the `.c` file with every `#include` textually expanded and every macro substituted. The compiler sees TUs, not files.

This is the single most important structural fact about C: **each `.c` file is compiled in complete isolation.** It knows nothing about any other `.c` file except what you tell it through declarations, which is why headers exist.

```text
  main.c        util.c          util.h
    |             |               |
    | #include "util.h"  <--------+ (textually pasted into BOTH)
    v             v
+--------+   +--------+
|  TU 1  |   |  TU 2  |   <- preprocessed source; compiler sees these
+--------+   +--------+
    |             |
  compile      compile
    v             v
  main.o       util.o     <- object files with unresolved symbols
    \             /
     \           /
       link (ld)          <- resolves util's symbols across objects
          |
          v
       ./program
```

The header contains **declarations** (promises: "a function named `util_add` exists with this signature"), and exactly one `.c` file contains the **definition** (the actual code). The compiler needs the declaration to type-check the call; the linker needs the definition to produce the final binary. Get this wrong and you get two distinct error classes:

- Missing declaration → *compiler* error: `implicit declaration of function 'util_add'`.
- Missing definition → *linker* error: `undefined reference to 'util_add'`.

Learning to tell these apart is a large part of becoming productive in C.

**Examples**

```c
/* ---------- util.h : the interface (declarations only) ---------- */
#ifndef UTIL_H          /* include guard: prevents double inclusion */
#define UTIL_H

int util_add(int a, int b);   /* declaration -- no body */

#endif /* UTIL_H */
```

```c
/* ---------- util.c : the implementation ---------- */
#include "util.h"       /* ensures the definition matches the declaration */

int util_add(int a, int b)   /* definition -- has a body */
{
    return a + b;
}
```

```c
/* ---------- main.c : a consumer ---------- */
#include <stdio.h>
#include "util.h"       /* we only need the promise, not the code */

int main(void)
{
    printf("%d\n", util_add(2, 3));
    return 0;
}
```

Building it, step visible:

```bash
gcc -c main.c -o main.o    # TU 1 -> object file (util_add unresolved)
gcc -c util.c -o util.o    # TU 2 -> object file (util_add defined)
gcc main.o util.o -o app   # link: linker matches the symbol
```

Inspect the unresolved symbol yourself:

```bash
$ nm main.o | grep util_add
                 U util_add       # 'U' = undefined, needs another object
$ nm util.o | grep util_add
0000000000000000 T util_add       # 'T' = defined in .text section
```

**Key Takeaways**

- A translation unit is one `.c` file after preprocessing; each is compiled independently.
- Headers carry declarations; exactly one `.c` file carries each definition (the One Definition Rule in practice).
- Missing declaration is a *compiler* error; missing definition is a *linker* error — the messages are distinguishable.
- Include guards (`#ifndef`/`#define`/`#endif`) or `#pragma once` prevent duplicate inclusion.
- `nm` shows which symbols an object file defines (`T`, `D`, `B`) and which it needs (`U`).

> 🧪 Practice
>
> 1. Build the three-file example above with separate `-c` steps. Then delete `util.c` from the link line and read the resulting error.
> 2. Remove `#include "util.h"` from `main.c` but keep the call to `util_add`. Compile with `-std=c17 -Wall` and then with `-std=c23`. Compare the diagnostics.
> 3. Remove the include guard from `util.h` and `#include "util.h"` twice in `main.c`. Add a `struct` definition to the header first, so the double inclusion actually breaks something.
> 4. Interview-style: *"You get `undefined reference to 'sqrt'` even though you included `math.h`. What is wrong?"* Hint: the header gave you the declaration — what did the linker not get?

<a id="13-build-pipeline"></a>
### 1.3 Build Pipeline

`gcc hello.c` looks like one action but is actually four programs running in sequence. Knowing which stage produces which artifact — and which stage is failing — is the difference between debugging effectively and guessing.

#### Preprocessing, Compiling, Assembling, Linking

**Theory**

The C toolchain is a pipeline of four distinct tools, each consuming the previous stage's output:

```text
 hello.c        source file
    |
    | 1. PREPROCESSOR  (cpp)     gcc -E
    |    - expands #include (textual paste)
    |    - substitutes macros (#define)
    |    - resolves #if / #ifdef
    |    - strips comments
    v
 hello.i        preprocessed source = the TRANSLATION UNIT
    |
    | 2. COMPILER  (cc1)         gcc -S
    |    - lexes, parses, type-checks
    |    - optimizes
    |    - emits target assembly
    v
 hello.s        assembly text
    |
    | 3. ASSEMBLER  (as)         gcc -c
    |    - assembly mnemonics -> machine code
    |    - builds symbol table + relocations
    v
 hello.o        object file (ELF/Mach-O/COFF), NOT runnable
    |
    | 4. LINKER  (ld, via gcc)   gcc (no flag)
    |    - combines .o files + libraries
    |    - resolves symbol addresses
    |    - applies relocations
    |    - adds startup code (crt1.o)
    v
 ./hello        executable
```

Two properties are worth memorizing:

1. **The preprocessor understands no C.** It is a text-manipulation engine that happens to be aware of C tokens. It cannot evaluate `sizeof`, does not know types, and will happily produce nonsense.
2. **The linker understands no types.** It matches *names* (symbols). This is why a mismatched declaration between two files links fine and then corrupts memory at runtime — nobody checked.

**Examples**

Run each stage by hand:

```bash
gcc -E hello.c -o hello.i   # 1. preprocess only
gcc -S hello.i -o hello.s   # 2. compile to assembly
as     hello.s -o hello.o   # 3. assemble  (or: gcc -c hello.s -o hello.o)
gcc    hello.o -o hello     # 4. link      (gcc drives ld with the right flags)
```

Watch the preprocessor at work:

```c
/* demo.c */
#include <stdio.h>
#define SQUARE(x) ((x) * (x))
#define VERSION 3

int main(void)
{
    printf("v%d: %d\n", VERSION, SQUARE(4));
    return 0;
}
```

```bash
$ gcc -E demo.c | tail -6
int main(void)
{
    printf("v%d: %d\n", 3, ((4) * (4)));   /* macros gone, text substituted */
    return 0;
}
```

The full preprocessed output is thousands of lines because `stdio.h` pulls in a large dependency tree:

```bash
$ wc -l demo.c
9 demo.c
$ gcc -E demo.c | wc -l
1247                                # this is what the compiler actually reads
```

**Key Takeaways**

- Four stages: preprocess (`-E`), compile (`-S`), assemble (`-c`), link (no flag).
- The translation unit is the preprocessor's output — that is what the compiler parses.
- The preprocessor is pure text substitution with no knowledge of C semantics.
- The linker matches symbol names only; it performs no type checking across translation units.
- `gcc file.c -o prog` runs all four stages silently; use `-v` to see the actual sub-commands.

> 🧪 Practice
>
> 1. Take any program you have written and run all four stages manually, keeping each intermediate file. Open `hello.i` and find where your code begins after the header expansion.
> 2. Run `gcc -v hello.c -o hello 2>&1 | head -40` and identify the invocations of `cc1`, `as`, and `collect2`/`ld`.
> 3. Write a macro `#define N 10` and use it as an array size. Preprocess with `-E` and confirm the array declaration shows the literal `10`.
> 4. Interview-style: *"At which stage does `#include <stdio.h>` get resolved, and at which stage does the actual `printf` code get attached?"* Hint: one is textual, one is at link time against libc.

#### Object Files and Executables

**Theory**

An object file is compiled machine code that is **not yet runnable**, because addresses are not final. It contains:

- **Sections** holding code and data.
- A **symbol table** listing names defined here and names needed from elsewhere.
- **Relocations**: "at byte offset 0x1a there is an address I could not compute; patch it when you know where `printf` lives."

Standard sections in ELF (Linux) and their approximate equivalents elsewhere:

| Section | Contents | Occupies file space? |
| --- | --- | --- |
| `.text` | Executable machine code | Yes |
| `.rodata` | Read-only data: string literals, `const` tables | Yes |
| `.data` | Initialized globals/statics with nonzero values | Yes |
| `.bss` | Zero-initialized globals/statics | No — just a size |
| `.symtab` | Symbol table | Yes (strippable) |
| `.rela.text` | Relocation entries for `.text` | Yes (consumed by linker) |

`.bss` ("block started by symbol") is why a program with a 10 MB zeroed global array can be a 20 KB file: the file records only the *size*, and the loader zeroes that memory at startup.

Symbol types from `nm`:

| Letter | Meaning |
| --- | --- |
| `T` / `t` | Defined in `.text` (uppercase = global, lowercase = local/static) |
| `D` / `d` | Defined in `.data` |
| `B` / `b` | Defined in `.bss` |
| `R` / `r` | Defined in `.rodata` |
| `U` | **Undefined** — must be supplied by another object or library |
| `W` | Weak symbol |

**Examples**

```c
/* obj.c */
#include <stdio.h>

int   initialized  = 42;      /* -> .data  */
int   zeroed;                 /* -> .bss   */
static int private_counter;   /* -> .bss, local symbol (lowercase 'b') */
const char *msg = "hello";    /* pointer in .data, "hello" in .rodata */

void helper(void) { private_counter++; }   /* -> .text */

int main(void) { helper(); printf("%d\n", initialized); return 0; }
```

```bash
$ gcc -c obj.c -o obj.o

$ nm obj.o
0000000000000000 T helper
0000000000000000 D initialized
0000000000000014 T main
0000000000000008 d msg
                 U printf          # <-- undefined: comes from libc at link time
0000000000000000 b private_counter
0000000000000004 B zeroed

$ size obj.o
   text    data     bss     dec     hex filename
     72      16       8      96      60 obj.o

$ readelf -S obj.o | grep -E '\.text|\.data|\.bss|\.rodata'
  [ 1] .text     PROGBITS  ...
  [ 3] .data     PROGBITS  ...
  [ 4] .bss      NOBITS    ...   # NOBITS = takes no file space
  [ 5] .rodata   PROGBITS  ...
```

After linking, the `U printf` is resolved and the executable gains startup code:

```bash
$ gcc obj.o -o obj
$ file obj
obj: ELF 64-bit LSB pie executable, dynamically linked, ...
$ ldd obj
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6    # resolved at load time
```

**Key Takeaways**

- Object files hold machine code with unresolved addresses plus a symbol table and relocations.
- `.text` = code, `.rodata` = constants, `.data` = initialized globals, `.bss` = zeroed globals (no file space).
- `U` in `nm` output means the symbol must come from somewhere else — the root cause of most link errors.
- Useful inspection tools: `nm` (symbols), `size` (section sizes), `objdump -d` (disassembly), `readelf -S` (sections), `ldd` (shared library dependencies).
- Linking adds startup files (`crt1.o`, `crti.o`) that set up the environment and call `main`.

> 🧪 Practice
>
> 1. Declare a `static int big[1000000];` at file scope, compile to an object file, and compare `ls -l` size against the same array initialized to `{1}`. Explain the difference using `.bss` versus `.data`.
> 2. Run `nm` on an object file of yours and classify every symbol by letter. Which are `U`, and where will each come from?
> 3. Use `objdump -d --section=.text obj.o | head -30` to view the disassembly of one function. Identify the prologue and epilogue.
> 4. Interview-style: *"Why does adding a large zero-initialized global barely change the executable size, but a large initialized one does?"* Hint: `NOBITS`.

#### Invoking GCC and Clang

**Theory**

GCC and Clang are separate compilers with a deliberately compatible command-line interface. In most projects they are drop-in substitutes, which is valuable: compiling with both catches more bugs, because each warns about things the other misses.

| | GCC | Clang |
| --- | --- | --- |
| Origin | GNU Project, 1987 | LLVM Project, 2007 |
| Diagnostics | Good, improving | Excellent — ranges, fix-it hints |
| Compile speed | Slower | Generally faster |
| Sanitizers | Supported | First-class, originated here |
| Target coverage | Very broad (obscure embedded targets) | Broad, fewer exotic targets |
| Default dialect | `gnu17`/`gnu23` (version dependent) | `gnu17`/`gnu23` |

The compiler driver (`gcc`/`clang`) is not the compiler — it is a program that decides which stages to run based on your file extensions and flags:

| Input | Driver behavior |
| --- | --- |
| `.c` | preprocess, compile, assemble, (link) |
| `.i` | compile, assemble, (link) — already preprocessed |
| `.s` | assemble, (link) |
| `.o` | link only |
| `.a` / `.so` | link against |

Argument order matters for libraries: `-l` flags must come **after** the object files that need them, because the traditional linker processes inputs left to right and only pulls in what is currently unresolved.

**Examples**

```bash
# Simplest: one command, all stages
gcc hello.c -o hello
clang hello.c -o hello

# Multiple translation units
gcc main.c util.c -o app

# Separate compilation (what build systems do -- only rebuild what changed)
gcc -c main.c -o main.o
gcc -c util.c -o util.o
gcc main.o util.o -o app

# Linking math library: -lm goes AFTER the sources that use it
gcc calc.c -o calc -lm            # correct
gcc -lm calc.c -o calc            # may fail: "undefined reference to sqrt"

# Include and library search paths
gcc -Iinclude -Llib main.c -o app -lmylib
#   -Iinclude : where to look for "..." and <...> headers
#   -Llib     : where to look for libmylib.a / libmylib.so
#   -lmylib   : link against libmylib

# Define a macro from the command line (equivalent to #define DEBUG 1)
gcc -DDEBUG=1 -DVERSION='"1.2.3"' main.c -o app

# Generate header dependency files for Make
gcc -MMD -MP -c main.c -o main.o   # writes main.d listing headers used
```

A minimal but realistic invocation for daily development:

```bash
clang -std=c17 -Wall -Wextra -Wpedantic -g -O0 \
      -fsanitize=address,undefined \
      main.c util.c -o app
```

**Key Takeaways**

- `gcc` and `clang` share a flag vocabulary; compiling with both is a cheap way to find more bugs.
- The driver picks stages from the file extension; `.i`, `.s`, and `.o` inputs skip earlier stages.
- Place `-l` library flags after the files that reference them.
- `-I` adds header search paths, `-L` adds library search paths, `-l` names a library, `-D` defines a macro.
- `-MMD -MP` generates dependency files so Make rebuilds when headers change.

> 🧪 Practice
>
> 1. Write a program calling `sqrt()` and compile it as `gcc calc.c -o calc` (no `-lm`). Then fix it, and also try putting `-lm` before the source file. Record all three outcomes.
> 2. Compile the same buggy program (for example, one with an unused variable and a sign-comparison mismatch) with both `gcc -Wall -Wextra` and `clang -Wall -Wextra`. List the differences in what each reports.
> 3. Use `-DMAX=100` from the command line instead of a `#define` in the source, and verify with `gcc -E` that the substitution happens.
> 4. Compile a two-file project with `-MMD -MP`, then open the generated `.d` file and describe its format.

#### Common Compiler Flags

**Theory**

Flags fall into functional groups. Learning them by group beats memorizing a magic incantation.

| Group | Flags | Purpose |
| --- | --- | --- |
| **Language** | `-std=c17`, `-pedantic` | Select the dialect and enforce it |
| **Warnings** | `-Wall -Wextra -Wpedantic`, `-Wshadow`, `-Wconversion` | Find bugs at compile time |
| **Debug** | `-g`, `-g3`, `-fno-omit-frame-pointer` | Emit debug info for GDB/LLDB |
| **Optimization** | `-O0`…`-O3`, `-Os`, `-Og` | Trade compile time/size for speed |
| **Sanitizers** | `-fsanitize=address,undefined,leak` | Runtime bug detection |
| **Paths** | `-I`, `-L`, `-l`, `-D`, `-U` | Includes, libraries, macros |
| **Output** | `-o`, `-c`, `-S`, `-E` | Control which stage and where output goes |
| **Hardening** | `-D_FORTIFY_SOURCE=2`, `-fstack-protector-strong`, `-Wl,-z,relro,-z,now` | Runtime defenses |

The most valuable warnings beyond `-Wall -Wextra`:

- `-Wshadow` — a local variable hides an outer one.
- `-Wconversion` — implicit conversions that may lose value (noisy but revealing).
- `-Wstrict-prototypes` — declarations without full prototypes.
- `-Wvla` — variable-length arrays (often unwanted; they can blow the stack).
- `-Wformat=2` — aggressive `printf` format-string checking, including non-literal formats.
- `-Wnull-dereference`, `-Wdouble-promotion`, `-Wcast-align`.

Note that `-Wall` is a historical misnomer: it does not enable all warnings, and neither does `-Wall -Wextra`. Clang offers `-Weverything`, which is useful for exploration but far too noisy for a build.

A critical interaction: some warnings (notably `-Wmaybe-uninitialized` and `-Warray-bounds`) only fire when optimization is on, because they depend on dataflow analysis performed by the optimizer. Building with `-O0` hides them.

**Examples**

Two useful presets:

```bash
# Development build: maximum feedback, easy debugging
gcc -std=c17 -Wall -Wextra -Wpedantic -Wshadow -Wconversion \
    -Og -g3 -fsanitize=address,undefined \
    main.c -o app-dev

# Release build: optimized, hardened, no sanitizers
gcc -std=c17 -Wall -Wextra -O2 -DNDEBUG \
    -D_FORTIFY_SOURCE=2 -fstack-protector-strong \
    -Wl,-z,relro,-z,now \
    main.c -o app
```

A program that demonstrates why the extra warnings pay off:

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    int count = 5;
    size_t len = strlen("hello");

    if (len > count)                /* -Wsign-compare (in -Wextra): signed vs unsigned */
        puts("longer");

    {
        int count = 99;             /* -Wshadow: hides the outer 'count' */
        printf("%d\n", count);
    }

    char c = 300;                   /* -Wconversion / -Woverflow: value truncated */
    printf("%d\n", c);

    int uninit;
    printf("%d\n", uninit);         /* -Wuninitialized (needs -O1 or higher) */

    return 0;
}
```

Compile it with `gcc -Wall -Wextra -Wshadow -Wconversion -O1` and read every message.

**Key Takeaways**

- Baseline for every project: `-std=c17 -Wall -Wextra -Wpedantic`.
- `-Wall` does not enable all warnings; add `-Wshadow`, `-Wconversion`, `-Wformat=2`, `-Wstrict-prototypes`.
- `-Og` gives good debuggability with some optimization; `-g3` includes macro definitions for GDB.
- Some warnings require optimization to fire — never assume `-O0` shows you everything.
- Release builds should add `-DNDEBUG`, `-D_FORTIFY_SOURCE=2`, and `-fstack-protector-strong`.

> 🧪 Practice
>
> 1. Compile the warning demo above at `-O0` and at `-O2`. Which warnings appear only at `-O2`? Explain why.
> 2. Build one of your programs with `clang -Weverything` and skim the output. Pick three warnings you think are worth keeping and three that are noise, and justify each.
> 3. Add `-fsanitize=address` to a program that reads one element past the end of a stack array. Compare the sanitizer output to the program's behavior without it.
> 4. Interview-style: *"Why might a bug appear only in the release build?"* Hint: think about undefined behavior, uninitialized memory, and what the optimizer is permitted to assume.

#### Warnings as Errors

**Theory**

In C, a warning is very often a bug. Because the language permits so much (implicit conversions, missing prototypes, unchecked pointer casts), the compiler frequently *knows* something is wrong but is only allowed to complain. A codebase that accumulates warnings loses that signal entirely: once there are 400 warnings, nobody reads number 401.

`-Werror` converts every warning into a hard error, forcing the count to stay at zero. The trade-offs are real:

**Arguments for `-Werror`:**
- Warnings never accumulate; the signal stays useful.
- Bugs are caught at the earliest, cheapest moment.
- Code review is not spent on "you forgot to check that."

**Arguments against `-Werror` in released source:**
- A newer compiler adds a new warning and your previously-fine tarball no longer builds for users.
- Third-party headers you do not control can trip warnings.
- Sanitizer or platform-specific warnings can block emergency fixes.

The standard resolution: **`-Werror` in CI and development builds, never in the default build of released source.** Users compiling from a distribution tarball should never be blocked by a compiler upgrade.

For fine-grained control:

```bash
-Werror                   # all warnings become errors
-Werror=implicit-function-declaration    # only this one
-Wno-error=unused-variable               # this one stays a warning
-Wno-unused-parameter                    # disable this warning entirely
```

`-Werror=implicit-function-declaration` deserves special mention: calling an undeclared function was legal in C89 and is a frequent source of severe bugs (the compiler assumes it returns `int`, corrupting the result of a function that actually returns a pointer on 64-bit systems). It is an error by default in C99+ mode on Clang 16+ and GCC 14+, but promoting it explicitly is worthwhile on older toolchains.

**Examples**

```c
/* werror_demo.c */
#include <stdio.h>

int main(void)
{
    int unused_var = 5;              /* -Wunused-variable */
    printf("%d\n", "not an int");    /* -Wformat: %d with char* */
    return 0;
}
```

```bash
$ gcc -Wall -Wextra werror_demo.c -o demo
werror_demo.c:6:20: warning: format '%d' expects argument of type 'int',
                    but argument 2 has type 'char *' [-Wformat=]
werror_demo.c:5:9:  warning: unused variable 'unused_var' [-Wunused-variable]
# ... and it still produces a binary that will misbehave

$ gcc -Wall -Wextra -Werror werror_demo.c -o demo
werror_demo.c:6:20: error: format '%d' expects argument of type 'int', ...
cc1: all warnings being treated as errors
# no binary produced -- exactly what you want
```

Suppressing a warning locally when you genuinely mean it, using pragmas:

```c
/* Intentionally unused parameter in a callback with a fixed signature. */
void on_timer(int signal_number)
{
    (void)signal_number;    /* portable idiom: cast to void silences -Wunused */
    do_work();
}

/* Or, compiler-specific, scoped precisely: */
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    legacy_api_call();      /* we know; migration is tracked in issue #431 */
#pragma GCC diagnostic pop
```

**Key Takeaways**

- Warnings in C usually indicate real defects; treat zero warnings as the only acceptable state.
- Use `-Werror` in CI and local development, not in the default build of source you ship to users.
- Promote specific critical warnings with `-Werror=implicit-function-declaration` even where blanket `-Werror` is impractical.
- Silence an intentional unused parameter with `(void)param;` — portable and self-documenting.
- Use `#pragma GCC diagnostic push/ignored/pop` to suppress narrowly, with a comment explaining why.

> 🧪 Practice
>
> 1. Add `-Werror` to a small project of yours and fix every resulting error. Note which ones were genuine bugs.
> 2. Write a function with an unused parameter and silence the warning using the `(void)param;` idiom. Confirm the warning disappears without disabling it globally.
> 3. Use `#pragma GCC diagnostic` to suppress exactly one warning on exactly one line, and verify that the same warning still fires elsewhere in the file.
> 4. Interview-style: *"Your project uses `-Werror` and a compiler upgrade breaks the build with a new warning. What do you do?"* Hint: consider the difference between fixing, `-Wno-error=`, and pinning the toolchain — and which is appropriate for a hotfix versus a sprint.

#### Optimization Levels

**Theory**

Optimization levels are named presets that toggle dozens of individual passes. Higher is not automatically better: `-O3` can be slower than `-O2` (aggressive inlining hurts instruction cache locality), and `-Ofast` is not even standard-conforming.

| Level | Behavior | Typical use |
| --- | --- | --- |
| `-O0` | No optimization. Fastest compile, most debuggable, slowest code. Default. | Debugging where you need every variable inspectable |
| `-O1` | Basic optimizations that do not cost much compile time | Rarely chosen deliberately |
| `-O2` | The standard production level. Nearly all safe optimizations. | **Default choice for release** |
| `-O3` | `-O2` plus aggressive inlining and vectorization. Larger binaries. | Measure before adopting |
| `-Os` | Optimize for size (`-O2` minus size-increasing passes) | Embedded, constrained memory |
| `-Oz` | Optimize for size even harder (Clang, GCC 12+) | Very tight flash budgets |
| `-Og` | Optimize for the debugging experience | **Default for development** |
| `-Ofast` | `-O3` + `-ffast-math`; **breaks IEEE 754 conformance** | Only with informed consent |

Two facts every C programmer must internalize:

**1. Optimizers assume your program has no undefined behavior.** If your code has UB, the optimizer may delete the check that would have caught it. This is why bugs "appear at `-O2`" — they were always there, but `-O0`'s naive code generation happened to hide them.

```c
int check(int *p) {
    int v = *p;            /* dereference implies p != NULL */
    if (p == NULL)         /* optimizer: "p can't be NULL, I already deref'd it" */
        return -1;         /* -> this branch may be deleted entirely at -O2 */
    return v;
}
```

**2. Debugging optimized code is harder.** Variables get held in registers with no memory location (`<optimized out>` in GDB), functions get inlined so backtraces are misleading, and statements get reordered so single-stepping jumps around. `-Og` exists precisely to give you most of the speed with a coherent debugging experience.

**Examples**

Observe the optimizer removing work:

```c
/* opt.c */
int sum_to(int n)
{
    int total = 0;
    for (int i = 1; i <= n; i++)
        total += i;
    return total;
}
```

```bash
$ gcc -O0 -S opt.c -o - | grep -c '\b\(add\|cmp\|jmp\|jle\)\b'
# many instructions: an actual loop

$ gcc -O2 -S opt.c -o - | head -20
# the loop is gone -- GCC recognizes the closed form n*(n+1)/2
# and emits a handful of arithmetic instructions with no branch
```

Measuring rather than guessing:

```bash
for lvl in O0 O1 O2 O3 Os; do
    gcc -$lvl bench.c -o bench-$lvl
    printf "%-4s " "$lvl"
    /usr/bin/time -f "%e s" ./bench-$lvl 2>&1 | tail -1
    printf "     size: %s bytes\n" "$(stat -c%s bench-$lvl)"
done
```

A UB-triggered behavior change:

```c
#include <stdio.h>
#include <limits.h>

int main(void)
{
    int x = INT_MAX;
    /* Signed overflow is UNDEFINED BEHAVIOR, not wraparound. */
    if (x + 1 < x)                    /* optimizer: "cannot happen" -> deleted */
        puts("overflow detected");    /* may never print at -O2 */
    else
        puts("no overflow");
    return 0;
}
```

Compile at `-O0` and `-O2` and compare. Then compile with `-fsanitize=undefined` to see the real diagnosis.

**Key Takeaways**

- `-Og -g` for development, `-O2` for release, `-Os`/`-Oz` for size-constrained targets.
- `-O3` is not automatically faster than `-O2`; benchmark before choosing it.
- `-Ofast` enables `-ffast-math` and abandons IEEE 754 conformance — use only deliberately.
- Optimizers assume the absence of undefined behavior; UB bugs commonly surface only at higher levels.
- `-DNDEBUG` in release builds disables `assert`, which is a separate decision from the `-O` level.

> 🧪 Practice
>
> 1. Write a compute-heavy loop (for example, summing a million floats) and benchmark it at `-O0`, `-O2`, and `-O3`. Record both runtime and binary size.
> 2. Compile the signed-overflow example at `-O0` and `-O2`. Explain the difference, then run it under `-fsanitize=undefined`.
> 3. Compile a function at `-O2 -g`, load it in GDB, and try to print a local variable. Observe `<optimized out>`. Recompile at `-Og` and compare.
> 4. Interview-style: *"A test passes at `-O0` and fails at `-O2`. Where do you look first?"* Hint: the optimizer is rarely the bug — what does it assume about your code?

<a id="14-development-environment"></a>
### 1.4 Development Environment

Tooling is not incidental in C; a good environment gives you the safety net the language does not. This section covers choosing an editor, reading what the compiler actually tells you, finding authoritative documentation, and looking at the generated machine code.

#### Editors and IDEs

**Theory**

The productivity differences between C editors come down to one question: **is there a language server?** Modern C tooling is built on `clangd`, which parses your code with a real Clang frontend and provides go-to-definition, completion, inline diagnostics, and refactoring. Without it, an editor is doing regex guesswork.

`clangd` needs to know how each file is compiled — the include paths, the `-D` macros, the `-std=`. It reads this from `compile_commands.json`, a **compilation database** that most build systems can generate:

```bash
# CMake generates it directly
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build

# For Make-based projects, use Bear to intercept the build
bear -- make

# Result: compile_commands.json in the project root
```

Without this file, `clangd` guesses and you get spurious "file not found" errors on your own headers.

| Option | Strengths | Considerations |
| --- | --- | --- |
| **VS Code + clangd** | Free, excellent LSP support, good debugger UI | Disable the Microsoft C/C++ IntelliSense engine to avoid conflicts |
| **Neovim/Vim + clangd** | Fast, keyboard-driven, works over SSH | Requires configuration investment |
| **CLion** | Deepest static analysis, integrated refactoring | Commercial license |
| **Emacs + lsp-mode/eglot** | Highly extensible | Configuration effort |
| **Visual Studio** | Best Windows/MSVC debugging | Windows-centric |

Essential companions regardless of editor:

- **`clang-format`** — automatic formatting from a `.clang-format` file, ending all style debate.
- **`clang-tidy`** — a linter that catches bug patterns the compiler does not.
- **GDB / LLDB** — the debugger; non-negotiable in C.
- **Valgrind / AddressSanitizer** — memory error detection.

**Examples**

A minimal `.clang-format` at the project root:

```yaml
BasedOnStyle: LLVM
IndentWidth: 4
ColumnLimit: 100
PointerAlignment: Right      # int *p, not int* p -- matches C convention
AllowShortFunctionsOnASingleLine: None
SortIncludes: true
```

```bash
clang-format -i src/*.c src/*.h        # format in place
clang-format --dry-run --Werror src/*.c   # CI check: fail if unformatted
```

A `.clang-tidy` configuration enabling useful checks:

```yaml
Checks: >
  bugprone-*,
  clang-analyzer-*,
  cert-*,
  readability-*,
  -readability-magic-numbers
WarningsAsErrors: 'bugprone-*,clang-analyzer-*'
```

```bash
clang-tidy src/main.c -- -std=c17 -Iinclude
```

**Key Takeaways**

- `clangd` is the foundation of modern C editing; it needs `compile_commands.json` to work correctly.
- Generate the compilation database with `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON` or `bear -- make`.
- `clang-format` removes style arguments; enforce it in CI with `--dry-run --Werror`.
- `clang-tidy` catches bug patterns beyond compiler warnings — enable at minimum `bugprone-*` and `clang-analyzer-*`.
- The editor matters less than the tooling behind it; any editor with LSP support is viable.

> 🧪 Practice
>
> 1. Generate `compile_commands.json` for a multi-file project of yours and confirm your editor's go-to-definition works across files.
> 2. Write a `.clang-format` file, run `clang-format -i` over a project, and inspect the diff. Adjust `PointerAlignment` and re-run to see the effect.
> 3. Run `clang-tidy` with `bugprone-*` on an existing file. Investigate each finding and decide whether it is a real issue.

#### Reading Compiler Diagnostics

**Theory**

Compiler messages are structured data, not prose. Every GCC/Clang diagnostic follows the same grammar:

```text
path/to/file.c:LINE:COLUMN: SEVERITY: MESSAGE [-Wflag-name]
    source line reproduced here
         ^~~~~~~~~
         caret points at the exact token
```

The four fields to read, in order:

1. **Severity** — `error` (compilation stops), `warning` (compilation continues), `note` (context for a preceding message; never appears alone).
2. **Location** — file, line, column. The column is often the real clue.
3. **The `[-Wflag]` suffix** — names the warning so you can search for it, suppress it, or promote it with `-Werror=`.
4. **`note:` lines** — these tell you *where the other half of the problem is*: the conflicting declaration, the macro expansion site, the candidate function.

Three rules for efficient diagnosis:

**Rule 1: Fix the first error only, then recompile.** C parsers cascade badly. One missing semicolon can produce fifty errors, forty-nine of which are noise.

**Rule 2: If the error makes no sense, look at the previous line.** A missing `;` or unbalanced brace is reported where the parser *noticed*, not where the mistake is.

**Rule 3: Distinguish compiler errors from linker errors.** They come from different tools and have different fixes:

| Symptom | Tool | Meaning | Fix |
| --- | --- | --- | --- |
| `error: 'foo' undeclared` | Compiler | No declaration in scope | Add `#include` or declaration |
| `implicit declaration of function 'foo'` | Compiler | Called without a prototype | Add the header |
| `undefined reference to 'foo'` | Linker | No definition anywhere | Add the `.c` file or `-lfoo` |
| `multiple definition of 'foo'` | Linker | Defined in two TUs | Move definition to one `.c`; use `extern` in the header |
| `ld: cannot find -lfoo` | Linker | Library not on the search path | Add `-L`, or install the `-dev` package |

**Examples**

A missing semicolon, and where the error lands:

```c
#include <stdio.h>

int main(void)
{
    int x = 5      /* <-- missing semicolon HERE */
    int y = 10;
    printf("%d\n", x + y);
    return 0;
}
```

```text
demo.c:6:5: error: expected ';' before 'int'
    6 |     int y = 10;
      |     ^~~
    5 |     int x = 5
      |              ^     <-- Clang's fix-it hint points at the real location
```

The error is reported on line 6, but the bug is on line 5. Clang's fix-it makes this explicit; GCC's message is subtler.

A `note:` carrying the crucial second half:

```c
/* a.c */
int compute(int x, int y) { return x + y; }
```
```c
/* main.c */
int compute(double x);        /* wrong declaration */
int main(void) { return compute(1.5); }
```

```text
main.c:1:5: error: conflicting types for 'compute'
    1 | int compute(double x);
      |     ^~~~~~~
a.c:1:5: note: previous definition of 'compute' was here
    1 | int compute(int x, int y) { return x + y; }
      |     ^~~~~~~
```

The `note` is what tells you where to look — never ignore it.

A linker error, which has no line number at all:

```text
/usr/bin/ld: main.o: in function `main':
main.c:(.text+0x1a): undefined reference to `util_add'
collect2: error: ld returned 1 exit status
```

Note `/usr/bin/ld` and `collect2` — those names identify this as a *link* failure. The fix is on the command line, not in the source.

Useful flags for reading diagnostics:

```bash
gcc -fdiagnostics-color=always      # colorize
gcc -fmax-errors=1                  # stop after the first error
clang -fcaret-diagnostics           # show source with carets (default)
gcc -fdiagnostics-show-template-tree  # structured type mismatch output
```

**Key Takeaways**

- Diagnostic format is `file:line:column: severity: message [-Wflag]`; read all four parts.
- Always fix the first error and recompile — later errors are usually cascading noise.
- `note:` lines tell you where the *other* relevant code is; they are the most useful part of a multi-part diagnostic.
- Compiler errors mention a line in your file; linker errors mention `ld`/`collect2` and a symbol name.
- `undefined reference` means a missing definition or library, never a missing `#include`.

> 🧪 Practice
>
> 1. Deliberately introduce a missing semicolon, an unbalanced brace, and a misspelled variable name, one at a time. For each, note the reported line and how far it is from the actual mistake.
> 2. Create a project where `main.c` calls a function defined in `util.c`, then link without `util.o`. Record the full error text and identify which tool produced it.
> 3. Trigger a `conflicting types` error and use the `note:` line to find the other declaration.
> 4. Interview-style: *"You see `error: dereferencing pointer to incomplete type 'struct Foo'`. What is missing?"* Hint: the compiler knows the type's *name* but not its *layout* — where would the layout be declared?

#### Manual Pages and Reference Docs

**Theory**

C's documentation is unusually good if you know where to look, and the crucial skill is knowing **which source is authoritative for what**.

Unix manual pages are divided into numbered sections, and the section determines what you get:

| Section | Contents | Example |
| --- | --- | --- |
| 1 | User commands | `man 1 gcc` |
| 2 | **System calls** (kernel interface) | `man 2 write`, `man 2 open` |
| 3 | **Library functions** (libc) | `man 3 printf`, `man 3 malloc` |
| 5 | File formats | `man 5 elf` |
| 7 | Overviews and conventions | `man 7 signal`, `man 7 socket` |

The section number matters because names collide. `man printf` gives you the *shell command*, not the C function — you need `man 3 printf`. Likewise `man 2 write` (the syscall) differs from `man 1 write` (send a message to a user).

Every man page has a fixed structure worth reading in a specific order:

```text
NAME          -- one-line summary
SYNOPSIS      -- the #include you need + the exact prototype   <- read FIRST
DESCRIPTION   -- what it does
RETURN VALUE  -- success and failure values                     <- read SECOND
ERRORS        -- errno values and their meanings
CONFORMING TO -- which standard (C99? POSIX.1-2008?)            <- portability
NOTES         -- caveats, glibc-specific behavior
SEE ALSO      -- related functions                              <- how you discover APIs
```

Read SYNOPSIS to get the header and signature, RETURN VALUE to learn how failure is signaled, then CONFORMING TO if portability matters.

The documentation hierarchy, most to least authoritative:

1. **The ISO standard** (or its free public draft — N1256 for C99, N1570 for C11, N2310 for C17, N3220 for C23). The final word on language semantics.
2. **POSIX (IEEE 1003.1)** — the authority for system interfaces (`open`, `fork`, `pthread_*`).
3. **cppreference.com/w/c** — accurate, well-organized, shows which standard introduced each feature. The best day-to-day reference.
4. **man pages** — authoritative for your *specific system's* behavior, including glibc extensions.
5. Everything else.

**Examples**

```bash
man 3 printf          # the C library function
man 2 open            # the system call
man 3 strtol          # note the errno-based error checking protocol
man 7 signal          # conceptual overview of signals

man -k socket         # search page names/descriptions (same as: apropos socket)
man -f printf         # which sections contain 'printf'  (same as: whatis printf)
```

Reading a page critically — `strtol` is the classic example of why RETURN VALUE matters:

```c
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>

/* The man page for strtol explains this exact protocol. */
int parse_int(const char *s, long *out)
{
    char *end;
    errno = 0;                          /* MUST reset: strtol only sets it */
    long v = strtol(s, &end, 10);

    if (end == s)          return -1;   /* no digits consumed at all */
    if (*end != '\0')      return -1;   /* trailing garbage after the number */
    if (errno == ERANGE)   return -1;   /* value out of long's range */
    if (v > INT_MAX || v < INT_MIN) return -1;

    *out = v;
    return 0;
}

int main(int argc, char *argv[])
{
    long n;
    if (argc != 2 || parse_int(argv[1], &n) != 0) {
        fprintf(stderr, "usage: %s <integer>\n", argv[0]);
        return 1;
    }
    printf("parsed: %ld\n", n);
    return 0;
}
```

None of that error handling is guessable — it comes straight from `man 3 strtol`. This is why reading documentation is a core C skill rather than an optional one.

**Key Takeaways**

- Always specify the man section for C functions: `man 3 printf`, `man 2 read`.
- Section 2 = system calls, section 3 = library functions; the distinction reflects a real boundary.
- Read SYNOPSIS (header + prototype), then RETURN VALUE (how failure is signaled), then CONFORMING TO.
- `man -k` / `apropos` searches by keyword when you do not know the function name.
- cppreference.com/w/c is the best everyday reference; the ISO drafts (N1570, N3220) are the final authority.

> 🧪 Practice
>
> 1. Run `man 3 malloc` and answer from the page alone: what does it return on failure, and is the returned memory initialized?
> 2. Use `man -k directory` to find functions for reading directories. Then read `man 3 opendir` and write a program that lists a directory's entries.
> 3. Compare `man 2 write` and `man 3 fwrite`. Identify at least three behavioral differences (buffering, partial writes, error reporting).
> 4. Interview-style: *"How do you know whether a function you are calling is portable?"* Hint: there is a section of the man page that answers exactly this.

#### Compiler Explorer and Disassembly

**Theory**

C's promise is that you can reason about the machine code your source produces. Actually looking at that machine code turns a vague mental model into a precise one — and it is the only way to answer questions like "does the compiler vectorize this loop?" or "is this abstraction free?"

**Compiler Explorer** (godbolt.org) is the standard tool: it compiles a snippet with dozens of compiler/version/flag combinations side by side, color-coding source lines to their generated assembly. Use it to:

- Verify an optimization actually happened.
- Compare GCC versus Clang code generation.
- See the cost of a language construct.
- Confirm that undefined behavior is being exploited.

Locally, the equivalents are:

```bash
gcc -S -O2 file.c -o -                  # assembly to stdout (AT&T syntax)
gcc -S -O2 -masm=intel file.c -o -      # Intel syntax (often easier to read)
gcc -S -O2 -fverbose-asm file.c -o -    # annotate with variable names
objdump -d --demangle binary            # disassemble a compiled binary
objdump -S -d binary                    # interleave source (needs -g)
gdb -batch -ex 'disassemble main' ./a.out
```

A minimal x86-64 reading guide so the output is not opaque:

| Element | Meaning |
| --- | --- |
| `%rdi %rsi %rdx %rcx %r8 %r9` | Integer argument registers 1–6 (System V ABI) |
| `%rax` | Return value; also scratch |
| `%rsp` / `%rbp` | Stack pointer / frame pointer |
| `mov a, b` | AT&T: move a **into** b (source first) |
| `lea` | Compute an address; often used for cheap arithmetic |
| `cmp` + `jle`/`jne` | Compare then conditional jump |
| `call` / `ret` | Function call and return |

Note the syntax trap: AT&T order is `mov src, dst`; Intel order is `mov dst, src`. They are reversed.

**Examples**

Proving that an abstraction is free:

```c
/* Does wrapping the addition in a function cost anything at -O2? */
static int add(int a, int b) { return a + b; }

int compute(int x)
{
    return add(x, 10);
}
```

```bash
$ gcc -O2 -S -masm=intel abstraction.c -o -
compute:
        lea     eax, [rdi+10]   # entire function: one instruction
        ret                     # 'add' was inlined completely -- zero cost
```

Seeing the optimizer collapse a loop:

```c
int sum_to(int n)
{
    int total = 0;
    for (int i = 1; i <= n; i++)
        total += i;
    return total;
}
```

At `-O0` this compiles to a real loop with a compare and a backward jump. At `-O2`, GCC recognizes the arithmetic series and emits branch-free code computing `n*(n+1)/2`. Comparing the two outputs makes the power of the optimizer concrete in a way no description does.

Seeing undefined behavior exploited:

```c
#include <stddef.h>

int deref_then_check(int *p)
{
    int v = *p;              /* implies p is valid, hence non-NULL */
    if (p == NULL)           /* optimizer concludes: unreachable */
        return -1;
    return v;
}
```

Compile at `-O2` and look at the assembly: the `NULL` check and its branch are gone entirely. This is the single most instructive exercise for understanding why UB is dangerous — you can *see* the safety check disappear.

**Key Takeaways**

- godbolt.org compares compilers, versions, and flags side by side with source-to-assembly highlighting.
- Locally: `gcc -S -O2 -masm=intel` for source-level assembly, `objdump -d` for a compiled binary.
- AT&T syntax is `mov src, dst`; Intel syntax is `mov dst, src` — always check which you are reading.
- Reading assembly answers questions that reasoning cannot: was it inlined, was it vectorized, was the check removed.
- Watching the optimizer delete a redundant `NULL` check after a dereference is the clearest possible demonstration of UB exploitation.

> 🧪 Practice
>
> 1. Compile a simple function with `-O0` and `-O2` using `gcc -S -masm=intel` and diff the assembly. Count the instructions in each.
> 2. Paste the `deref_then_check` function into godbolt.org with GCC at `-O2` and confirm the `NULL` check is absent from the output. Then add `-fno-delete-null-pointer-checks` and observe the difference.
> 3. Write two versions of the same loop — one using an index, one using a pointer — and compare their `-O2` assembly. Are they identical?
> 4. Interview-style: *"How would you verify that the compiler vectorized your loop?"* Hint: look for SIMD register names (`xmm`, `ymm`, `zmm`) in the assembly, or use `-fopt-info-vec`.

---

## 2. Types, Values, and Expressions

This chapter covers C's type system — what a value *is* at the bit level, how you write one down, what the operators do to it, and the conversion rules the compiler silently applies between them. C's types map almost directly onto hardware registers, which makes them fast and predictable, but also means the language will happily let a value overflow, truncate, or change sign without saying a word. Most subtle C bugs live in exactly this territory, so learning the conversion and promotion rules precisely is the highest-leverage investment you can make in the language.

<a id="21-fundamental-types"></a>
### 2.1 Fundamental Types

C's built-in types are a thin veneer over machine storage: integers of various widths, floating-point numbers, and a deliberate absence of a type. This section covers what each one guarantees — and, more importantly, what it does not.

#### char, short, int, long, long long

**Theory**

C does not specify how big an `int` is. This surprises everyone at first, but it follows directly from C's design goal: run efficiently on wildly different hardware. On a 16-bit microcontroller, forcing `int` to be 32 bits would make ordinary arithmetic slow. So the standard specifies only **minimum ranges**, and each implementation picks sizes that suit its target.

What the standard actually guarantees:

| Type | Minimum bits | Guaranteed minimum range |
| --- | --- | --- |
| `char` | 8 (`CHAR_BIT`) | `-127..127` or `0..255` |
| `short` | 16 | `-32767..32767` |
| `int` | 16 | `-32767..32767` |
| `long` | 32 | `-2147483647..2147483647` |
| `long long` (C99) | 64 | `-9223372036854775807..+same` |

Plus one ordering rule you can always rely on:

```text
sizeof(char) == 1  <=  sizeof(short)  <=  sizeof(int)  <=  sizeof(long)  <=  sizeof(long long)
```

Note the ranges are symmetric around zero (`-32767`, not `-32768`). The standard historically permitted sign-magnitude and ones' complement representations, so it could not promise the extra negative value. C23 finally mandates two's complement, making `INT_MIN == -32768` (for 16-bit int) guaranteed — but portable code written for older standards still uses the symmetric minimums.

In practice, real systems cluster into a few **data models**:

| Model | `int` | `long` | pointer | Where |
| --- | --- | --- | --- | --- |
| ILP32 | 32 | 32 | 32 | 32-bit Linux, 32-bit Windows |
| LP64 | 32 | **64** | 64 | 64-bit Linux, macOS, BSD |
| LLP64 | 32 | **32** | 64 | 64-bit Windows |

The trap is immediate: `long` is 64 bits on Linux and 32 bits on Windows, both 64-bit systems. Code that stores a pointer in a `long` works on one and corrupts on the other. `int` is 32 bits essentially everywhere on desktop/server hardware, which is why it remains the default for loop counters and small values.

Think of these types as **"at least this big, chosen to be fast on this machine."** When you need an exact width, use `stdint.h` (covered later in this subchapter).

**Examples**

```c
#include <stdio.h>
#include <limits.h>   /* CHAR_BIT, INT_MAX, LONG_MIN, ... */

int main(void)
{
    printf("CHAR_BIT  = %d bits per byte\n", CHAR_BIT);

    /* %zu is the correct specifier for size_t, which sizeof yields. */
    printf("char      %zu bytes\n", sizeof(char));
    printf("short     %zu bytes\n", sizeof(short));
    printf("int       %zu bytes\n", sizeof(int));
    printf("long      %zu bytes\n", sizeof(long));
    printf("long long %zu bytes\n", sizeof(long long));

    printf("\nINT_MIN  = %d\n",   INT_MIN);
    printf("INT_MAX  = %d\n",     INT_MAX);
    printf("LONG_MAX = %ld\n",    LONG_MAX);     /* %ld for long */
    printf("LLONG_MAX = %lld\n",  LLONG_MAX);    /* %lld for long long */
    return 0;
}
```

Typical LP64 output:

```text
CHAR_BIT  = 8 bits per byte
char      1 bytes
short     2 bytes
int       4 bytes
long      8 bytes
long long 8 bytes
```

Bit layout of a 32-bit `int` holding the value 5:

```text
 bit 31                                              bit 0
   |                                                    |
   v                                                    v
   0000 0000 0000 0000 0000 0000 0000 0101   =  5
   ^
   sign bit (0 = non-negative)

   1111 1111 1111 1111 1111 1111 1111 1011   = -5  (two's complement)
   ^
   sign bit (1 = negative)
```

**Key Takeaways**

- C specifies minimum ranges, not exact sizes; `int` is 16 bits minimum but 32 bits in practice on modern hardware.
- The guaranteed ordering is `char <= short <= int <= long <= long long`, with `sizeof(char) == 1` by definition.
- `long` is 64-bit on Linux/macOS (LP64) but 32-bit on Windows (LLP64) — never assume it holds a pointer.
- `limits.h` gives you the actual bounds (`INT_MAX`, `LONG_MIN`, `CHAR_BIT`) for the current implementation.
- Use `%zu` for `size_t`, `%ld` for `long`, `%lld` for `long long`; mismatched specifiers are undefined behavior.

> 🧪 Practice
>
> 1. Write a program that prints the size and the `_MIN`/`_MAX` values of every integer type on your machine. Identify which data model you are on.
> 2. Compute `INT_MAX + 1` and print it. Then compute `UINT_MAX + 1u` and print it. Explain why only one of these is well-defined.
> 3. Write a function `int fits_in_short(long v)` that returns 1 if `v` is representable in a `short`, using `SHRT_MIN`/`SHRT_MAX` rather than hardcoded numbers.
> 4. Interview-style: *"You need a variable that can hold any pointer as an integer. Which type do you use?"* Hint: neither `int` nor `long` is portable — look in `stdint.h`.

#### Signed vs Unsigned

**Theory**

Every integer type has a signed and an unsigned flavor. The distinction is not just "can it be negative" — it changes the *arithmetic rules*, and mixing the two is one of the most productive sources of C bugs.

An N-bit unsigned type stores values `0 .. 2^N - 1`. All bits are magnitude. A signed type spends its top bit on sign, giving `-2^(N-1) .. 2^(N-1) - 1` in two's complement.

```text
8-bit patterns, two ways of reading the same bits:

  bits        unsigned char    signed char
  0000 0000        0                0
  0111 1111      127              127
  1000 0000      128             -128    <-- same bits, different value
  1111 1111      255               -1    <-- same bits, different value
```

The critical behavioral difference:

| | Signed | Unsigned |
| --- | --- | --- |
| Overflow | **Undefined behavior** | Wraps modulo `2^N` (well-defined) |
| `x < 0` possible | Yes | Never — the comparison is always false |
| Right shift of negative | Implementation-defined | N/A |
| Division truncation | Toward zero | Toward zero (no negatives) |

Unsigned wraparound being *defined* is genuinely useful (hashing, checksums, ring buffers). Signed overflow being *undefined* is what lets the optimizer assume `x + 1 > x`, which enables loop optimizations — and which silently deletes your overflow checks.

The classic failure mode is a comparison between signed and unsigned. The usual arithmetic conversions (covered in 2.4) convert the signed operand to unsigned, so a negative number becomes enormous:

```c
int   i = -1;
unsigned u = 1;
if (i < u)              /* i converts to UINT_MAX = 4294967295 */
    puts("less");       /* NEVER PRINTS */
else
    puts("not less");   /* this runs */
```

A special case worth memorizing: **plain `char` is a distinct third type.** `char`, `signed char`, and `unsigned char` are three different types, and whether plain `char` is signed is implementation-defined (signed on x86 Linux, unsigned on ARM Linux). This is why `getchar()` returns `int`, not `char` — it must distinguish 256 byte values from `EOF` (`-1`).

**Examples**

```c
#include <stdio.h>
#include <limits.h>
#include <string.h>

int main(void)
{
    /* 1. Unsigned wraparound is defined and predictable. */
    unsigned char u = 255;
    u++;                                   /* wraps to 0, modulo 256 */
    printf("255 + 1 (unsigned char) = %u\n", u);   /* 0 */

    /* 2. The signed/unsigned comparison trap. */
    int  i = -1;
    unsigned int ui = 1;
    printf("(-1 < 1u) = %d\n", i < ui);    /* 0 -- not what you expect */

    /* 3. The classic loop that never terminates. */
    for (unsigned k = 3; k >= 0; k--) {    /* k >= 0 is ALWAYS true */
        if (k > 100) break;                /* escape hatch so we can run this */
        printf("k = %u\n", k);             /* 3 2 1 0 then wraps to 4294967295 */
    }

    /* 4. Plain char signedness is implementation-defined. */
    char c = 200;                          /* may be -56 or 200 */
    printf("char 200 -> %d\n", c);

    /* 5. Why getchar returns int: EOF must be distinguishable. */
    printf("EOF = %d\n", EOF);             /* -1, not representable in unsigned char */
    return 0;
}
```

Safe patterns:

```c
/* Compare sizes without mixing signedness: make both unsigned. */
size_t len = strlen(s);
if (len > (size_t)max_allowed) { /* ... */ }

/* Or compare in the signed domain, after checking the range fits. */
if (len <= (size_t)INT_MAX && (int)len > max_allowed) { /* ... */ }

/* For byte manipulation, always use unsigned char -- no sign extension. */
unsigned char *bytes = (unsigned char *)data;
```

**Key Takeaways**

- Unsigned overflow wraps modulo `2^N` and is fully defined; signed overflow is undefined behavior.
- In a mixed signed/unsigned comparison, the signed value is converted to unsigned — negative values become huge.
- `unsigned x >= 0` is always true; a countdown loop with an unsigned counter never terminates.
- `char`, `signed char`, and `unsigned char` are three distinct types; plain `char`'s signedness is implementation-defined.
- Use `unsigned char` for raw bytes, `size_t` for sizes and indices, and enable `-Wsign-compare` (in `-Wextra`).

> 🧪 Practice
>
> 1. Write the infinite unsigned countdown loop and confirm it wraps. Fix it two different ways (a signed counter, and a `while (k-- > 0)` form).
> 2. Print the result of `(unsigned char)-1`, `(char)-1`, and `(int)(char)200` on your machine. Explain each value.
> 3. Write a function that safely compares a `size_t` against an `int` without any implicit conversion warnings under `-Wextra -Wconversion`.
> 4. Interview-style: *"Why does `getchar()` return `int` instead of `char`?"* Hint: count how many distinct values it must be able to return.

#### float, double, long double

**Theory**

Integers count; floating-point numbers *approximate*. A `float` does not store a real number — it stores a sign, an exponent, and a fixed number of significant bits, giving you scientific notation in binary. The consequence is that most decimal fractions cannot be represented exactly, in the same way `1/3` cannot be written exactly in decimal.

C provides three floating types, which on nearly all modern systems map to IEEE 754 formats:

| Type | Typical size | Format | Significant decimal digits | Approx. range |
| --- | --- | --- | --- | --- |
| `float` | 4 bytes | IEEE 754 binary32 | ~7 | ±1.2e-38 .. ±3.4e38 |
| `double` | 8 bytes | IEEE 754 binary64 | ~15–17 | ±2.2e-308 .. ±1.8e308 |
| `long double` | 8, 12, or 16 bytes | x87 80-bit, binary128, or same as `double` | 18–33 | platform-dependent |

`long double` is the least portable type in C. On x86 Linux/macOS with GCC it is the 80-bit x87 extended format (stored in 12 or 16 bytes for alignment); on MSVC it is identical to `double`; on some ARM and POWER systems it is true 128-bit quad precision. Do not rely on it for portable code.

**`double` is the default.** An unsuffixed literal like `3.14` is a `double`, math functions like `sin` take and return `double`, and older C rules promoted `float` arguments to `double` in variadic calls. Use `float` only when you have a specific reason: large arrays where memory bandwidth dominates, GPU/SIMD work, or embedded targets with only single-precision hardware.

The mental model: floating point trades **exactness for range**. You get to represent 1e300 and 1e-300, but you give up the guarantee that `0.1 + 0.2 == 0.3`.

**Examples**

```c
#include <stdio.h>
#include <float.h>    /* FLT_DIG, DBL_EPSILON, DBL_MAX, ... */
#include <math.h>     /* fabs, sqrt, INFINITY, NAN */

int main(void)
{
    printf("float       %zu bytes, %d significant digits\n",
           sizeof(float), FLT_DIG);
    printf("double      %zu bytes, %d significant digits\n",
           sizeof(double), DBL_DIG);
    printf("long double %zu bytes, %d significant digits\n",
           sizeof(long double), LDBL_DIG);

    /* The canonical demonstration: 0.1 is not exactly 0.1 in binary. */
    printf("\n0.1 + 0.2 = %.20f\n", 0.1 + 0.2);   /* 0.30000000000000004441 */
    printf("(0.1 + 0.2 == 0.3) is %d\n", 0.1 + 0.2 == 0.3);  /* 0 -- false! */

    /* Precision difference between float and double. */
    float  f = 0.1f;
    double d = 0.1;
    printf("\nfloat  0.1 = %.20f\n", (double)f);   /* 0.10000000149011611938 */
    printf("double 0.1 = %.20f\n", d);            /* 0.10000000000000000555 */

    /* Special values are part of IEEE 754. */
    double inf  = 1.0 / 0.0;      /* +infinity (with IEEE semantics) */
    double nan  = 0.0 / 0.0;      /* NaN */
    printf("\ninf = %f, isinf = %d\n", inf, isinf(inf));
    printf("nan = %f, isnan = %d\n", nan, isnan(nan));
    printf("(nan == nan) = %d\n", nan == nan);    /* 0 -- NaN != itself */
    return 0;
}
```

Choosing a type:

```c
/* Default: use double. */
double average(const double *v, size_t n)
{
    double sum = 0.0;
    for (size_t i = 0; i < n; i++) sum += v[i];
    return sum / (double)n;   /* cast avoids int/double surprises */
}

/* Use float deliberately: 100 million samples, memory-bandwidth bound. */
float *audio_samples;   /* 400 MB as float vs 800 MB as double */
```

**Key Takeaways**

- `float` ≈ 7 significant decimal digits, `double` ≈ 15–17; `long double` is platform-dependent and non-portable.
- `double` is the language default: unsuffixed literals and `math.h` functions are `double`.
- Most decimal fractions (including 0.1) have no exact binary representation — never test floats with `==`.
- IEEE 754 defines `+inf`, `-inf`, and `NaN`; `NaN` compares unequal to everything, including itself.
- `float.h` provides `FLT_DIG`, `DBL_EPSILON`, `DBL_MAX`, and friends for the current implementation.

> 🧪 Practice
>
> 1. Print `0.1 + 0.2` with `%.20f` and explain the trailing digits. Then find the smallest `n` where `1.0 + 1.0/n == 1.0` in `double`.
> 2. Sum the value `0.1` one million times in both `float` and `double`, and compare each result against `100000.0`. Quantify the drift.
> 3. Write a `bool nearly_equal(double a, double b, double eps)` helper and use it to compare `0.1 + 0.2` with `0.3`.
> 4. Interview-style: *"Why should you never use a `float` to store a monetary amount?"* Hint: think about what 0.10 looks like in binary and what happens after ten thousand additions.

#### _Bool and stdbool.h

**Theory**

C89 had no boolean type. Truth was just "an integer": `0` is false, anything else is true. That works, but it means a function returning "yes" could return 1, 42, or -7, and there was no type-level documentation of intent.

C99 added **`_Bool`**, a real type with exactly two values. Its defining property is the conversion rule: **assigning any scalar to a `_Bool` yields 0 if the value is zero (or a null pointer), and 1 otherwise.** This normalization is what makes it different from a small `int`.

```c
_Bool b = 42;    /* stores 1, not 42 */
_Bool c = 0.5;   /* stores 1 */
_Bool d = 0.0;   /* stores 0 */
```

The ugly `_Bool` spelling exists for backward compatibility: adding a keyword named `bool` in 1999 would have broken every codebase that had already defined its own. `<stdbool.h>` provides the friendly names as macros:

```c
#define bool  _Bool
#define true  1
#define false 0
#define __bool_true_false_are_defined 1
```

In **C23**, `bool`, `true`, and `false` became real keywords, and `<stdbool.h>` became unnecessary (it still exists, empty, for compatibility). Note that in C23, `true` and `false` have type `bool`, whereas in C99–C17 they were `int` constants `1` and `0`.

Relational and logical operators (`<`, `==`, `&&`, `!`) yield `int` values 0 or 1 in C, not `bool` — another difference from C++ that occasionally matters.

**Examples**

```c
#include <stdio.h>
#include <stdbool.h>   /* not needed in C23, harmless to include */

/* Self-documenting signature: the return type says what it means. */
bool is_even(int n)
{
    return n % 2 == 0;    /* comparison yields int 0/1, converted to bool */
}

int main(void)
{
    bool flag = true;
    printf("sizeof(bool) = %zu\n", sizeof(bool));   /* usually 1 */

    /* The normalizing conversion is the whole point. */
    bool a = 42;
    bool b = -1;
    bool c = 0.0001;
    printf("bool from 42     = %d\n", a);   /* 1 */
    printf("bool from -1     = %d\n", b);   /* 1 */
    printf("bool from 0.0001 = %d\n", c);   /* 1 */

    /* Contrast with int, which stores the value as-is. */
    int i = 42;
    printf("int  from 42     = %d\n", i);   /* 42 */

    /* Idiomatic conditionals: test the value, do not compare to true. */
    if (flag) puts("set");            /* good */
    if (flag == true) puts("set");    /* redundant; and fragile with int flags */

    printf("is_even(7) = %s\n", is_even(7) ? "true" : "false");
    return 0;
}
```

A common pre-C99 pattern you will still encounter, and why it is fragile:

```c
/* Legacy style -- works, but nothing normalizes the value. */
#define TRUE  1
#define FALSE 0
typedef int BOOL;

BOOL result = some_flags & MASK;   /* might be 8, not 1 */
if (result == TRUE) { }            /* FAILS when result is 8 */
if (result) { }                    /* correct */
```

**Key Takeaways**

- `_Bool` (C99) holds exactly 0 or 1; assigning any nonzero scalar normalizes it to 1.
- Include `<stdbool.h>` for `bool`, `true`, `false` in C99–C17; in C23 they are keywords.
- Relational and logical operators return `int` (0 or 1) in C, not `bool`.
- Never write `if (x == true)` — test the value directly, since non-`bool` flags may hold any nonzero value.
- Using `bool` as a return type documents intent in a way `int` cannot.

> 🧪 Practice
>
> 1. Assign several nonzero values (including a float and a pointer) to a `bool` and print each result. Confirm they all normalize to 1.
> 2. Write the fragile `result == TRUE` example with a value of 8 and demonstrate the bug; then fix it.
> 3. Print `sizeof(bool)` and `sizeof(_Bool)` and confirm they match. Compile with `-std=c23` without including `<stdbool.h>` and verify it still works.

#### void

**Theory**

`void` is C's way of saying "no type here." It is an **incomplete type that can never be completed**, which means you can never create an object of type `void` — `void x;` is an error. Its usefulness comes entirely from the three places the language gives it special meaning.

**1. No return value.** `void f(void)` returns nothing; using its result is an error.

**2. No parameters.** `int f(void)` means "takes exactly zero arguments." As covered in Chapter 1, `int f()` in C17 and earlier means "unspecified parameters" and disables argument checking. Always write `(void)`.

**3. `void *` — the generic pointer.** This is the important one. A `void *` can point to an object of any type. It has no notion of what it points at, so you cannot dereference it or do pointer arithmetic on it (GCC permits `void *` arithmetic as an extension, treating the size as 1, but it is not standard C).

Crucially, in C, conversion between `void *` and any object pointer type is **implicit and safe in both directions**. This is why `malloc` returns `void *` and you do not need a cast:

```c
int *p = malloc(n * sizeof *p);   /* void* -> int* implicitly; no cast needed */
```

Casting the result of `malloc` is a C++ habit; in C it is unnecessary and can hide a missing `#include <stdlib.h>`.

The `void *` type is the foundation of generic programming in C — `qsort`, `memcpy`, and every generic container use it as the erased type.

A fourth idiom worth knowing: casting an expression to `void` explicitly discards it, which documents intent and silences warnings.

```c
(void)unused_parameter;    /* "I know, and I mean it" */
(void)printf("...");       /* deliberately ignoring the return value */
```

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* 1. void return: the function is called for its effect. */
void log_message(const char *msg)
{
    fprintf(stderr, "[log] %s\n", msg);
    /* 'return;' with no value is legal here; falling off the end is fine. */
}

/* 2. void parameters: takes exactly nothing. */
int get_answer(void) { return 42; }

/* 3. void*: a generic swap that works for any type. */
void generic_swap(void *a, void *b, size_t size)
{
    unsigned char tmp[64];
    if (size > sizeof tmp) return;       /* keep the example simple */
    memcpy(tmp, a,   size);              /* memcpy takes void* -- any type */
    memcpy(a,   b,   size);
    memcpy(b,   tmp, size);
}

int main(void)
{
    int x = 1, y = 2;
    generic_swap(&x, &y, sizeof x);      /* int* converts to void* implicitly */
    printf("x=%d y=%d\n", x, y);         /* x=2 y=1 */

    double d1 = 1.5, d2 = 2.5;
    generic_swap(&d1, &d2, sizeof d1);   /* same function, different type */
    printf("d1=%g d2=%g\n", d1, d2);

    /* void* round-trip is guaranteed to preserve the value. */
    int  n  = 99;
    void *v = &n;                        /* int*  -> void*  (implicit) */
    int  *p = v;                         /* void* -> int*   (implicit in C) */
    printf("*p = %d\n", *p);

    /* Illegal operations on void*, shown as comments: */
    /* printf("%d", *v);  ERROR: cannot dereference void*          */
    /* v = v + 1;         Not standard C (GCC extension)           */
    /* void nothing;      ERROR: cannot declare an object of type void */

    (void)get_answer();                  /* deliberately discard the result */
    log_message("done");
    return 0;
}
```

**Key Takeaways**

- `void` is an incomplete type; you cannot declare an object of type `void`.
- `f(void)` means zero parameters — always prefer it to `f()` in C17 and earlier.
- `void *` is the generic object pointer; conversions to and from it are implicit in C (unlike C++).
- You cannot dereference a `void *` or do standard pointer arithmetic on it — you must cast to a concrete type first.
- Do not cast the return value of `malloc` in C; the implicit conversion is correct and the cast can mask a missing header.

> 🧪 Practice
>
> 1. Write a `void print_array(const void *base, size_t count, size_t elem_size, void (*print)(const void *))` that prints any array using a callback.
> 2. Try to compile `void x;`, `*(void *)p`, and `v + 1` where `v` is `void *`. Record each diagnostic.
> 3. Write a generic `void *find_max(const void *base, size_t n, size_t size, int (*cmp)(const void *, const void *))` in the style of `qsort`'s comparator.
> 4. Interview-style: *"Why does `malloc` return `void *` rather than `char *`?"* Hint: think about what conversions the caller would otherwise have to write, and about alignment guarantees.

#### Fixed-Width Types in stdint.h

**Theory**

Because `int` and `long` have implementation-defined sizes, any code that touches a **binary format** — a network packet, a file header, a hardware register, a serialized struct — cannot use them safely. C99 introduced `<stdint.h>` to solve exactly this.

The header defines three families, and picking the right family is the actual skill:

| Family | Meaning | Example | Guaranteed to exist? |
| --- | --- | --- | --- |
| `intN_t` | **Exactly** N bits, two's complement, no padding | `int32_t` | Only if the platform has such a type |
| `int_leastN_t` | Smallest type with **at least** N bits | `int_least16_t` | Yes, for N = 8, 16, 32, 64 |
| `int_fastN_t` | **Fastest** type with at least N bits | `int_fast32_t` | Yes, for N = 8, 16, 32, 64 |

Each has an `uintN_t` unsigned counterpart. Plus special-purpose types:

- `intptr_t` / `uintptr_t` — an integer large enough to hold a `void *` (optional, but present everywhere real).
- `intmax_t` / `uintmax_t` — the largest integer type available.
- `size_t` (from `stddef.h`) — unsigned, holds any object size; the type of `sizeof`.
- `ptrdiff_t` (from `stddef.h`) — signed, the result of subtracting two pointers.

Choosing between them:

- **Binary layout matters** (file/network/hardware): `int32_t`, `uint8_t`. Exact width or nothing.
- **You just need a range guarantee**: `int_least32_t`. Portable to exotic platforms without exact-width types.
- **Hot loop counter**: `int_fast32_t`. May be 64 bits if that is faster on the target.
- **Sizes and array indices**: `size_t`.

Printing these types requires the format macros in `<inttypes.h>`, because `%d` is wrong if `int32_t` is a `long` on some platform:

```c
printf("%" PRId32 "\n", value);   /* PRId32 expands to "d" or "ld" as needed */
```

That string-concatenation syntax is ugly but it is the only portable way.

**Examples**

```c
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>   /* PRId32, PRIu64, SCNd32, ... */

/* A binary file/network header: every field must have an exact, known width. */
typedef struct {
    uint32_t magic;        /* exactly 4 bytes, always */
    uint16_t version;      /* exactly 2 bytes */
    uint16_t flags;
    uint64_t payload_size; /* exactly 8 bytes */
} FileHeader;

int main(void)
{
    /* Exact-width: use when the bit pattern is part of a contract. */
    uint8_t  byte  = 255;
    int32_t  count = -100000;
    uint64_t big   = 18446744073709551615ULL;   /* UINT64_MAX */

    printf("byte  = %" PRIu8  "\n", byte);
    printf("count = %" PRId32 "\n", count);
    printf("big   = %" PRIu64 "\n", big);

    /* Range-guaranteed, portable everywhere. */
    int_least16_t small = 30000;
    /* Fastest type holding at least 32 bits -- may actually be 64. */
    int_fast32_t  fast  = 1000000;
    printf("int_fast32_t is %zu bytes\n", sizeof fast);

    /* Pointer-sized integer. */
    int v = 5;
    uintptr_t addr = (uintptr_t)&v;
    printf("address as integer: %" PRIuPTR "\n", addr);

    /* Limits come from the same header. */
    printf("INT32_MAX  = %" PRId32 "\n", INT32_MAX);
    printf("UINT8_MAX  = %" PRIu8  "\n", UINT8_MAX);

    printf("sizeof(FileHeader) = %zu\n", sizeof(FileHeader));  /* 16, if no padding */
    return 0;
}
```

Guidance in table form:

| Use case | Type |
| --- | --- |
| Byte buffer / raw data | `uint8_t` (or `unsigned char`) |
| File or wire protocol field | `int32_t`, `uint16_t`, … |
| Hardware register | `volatile uint32_t` |
| Array index, size, `sizeof` result | `size_t` |
| Pointer difference | `ptrdiff_t` |
| Storing a pointer as an integer | `uintptr_t` |
| Loop counter, no layout constraint | `int` or `int_fast32_t` |

**Key Takeaways**

- `intN_t` is exact-width and only exists where the platform supports it; `int_leastN_t` and `int_fastN_t` always exist.
- Use exact-width types whenever the bit layout is part of an external contract (files, networks, hardware).
- `size_t` for sizes and indices, `ptrdiff_t` for pointer differences, `uintptr_t` to hold a pointer as an integer.
- Print fixed-width types with `<inttypes.h>` macros (`PRId32`, `PRIu64`); `%d` is not portable for them.
- Fixed-width types do not fix struct padding — layout still depends on alignment (see Chapter 6).

> 🧪 Practice
>
> 1. Rewrite a struct that uses `int` and `short` fields to use exact-width types, then print `sizeof` for both versions and explain any difference.
> 2. Write a function that serializes a `uint32_t` into a 4-byte big-endian buffer, and a matching deserializer. Test the round trip.
> 3. Print `sizeof(int_fast8_t)` and `sizeof(int_least8_t)` on your machine. Explain why they may differ.
> 4. Interview-style: *"When would you choose `int_fast32_t` over `int32_t`?"* Hint: think about which one has a layout obligation and which one is purely about arithmetic speed.

#### sizeof and Type Sizes

**Theory**

`sizeof` answers one question: **how many bytes does this object or type occupy?** It is an operator, not a function, and it is evaluated at compile time (with one exception). Its result has type `size_t`, an unsigned type, which is why the correct `printf` specifier is `%zu`.

Three properties define its behavior:

**1. `sizeof(char) == 1` by definition.** A "byte" in C is whatever `char` is — on virtually all systems 8 bits, but the standard only requires `CHAR_BIT >= 8`. All other sizes are expressed in these units.

**2. The operand is not evaluated.** `sizeof` only needs the *type* of the expression, so side effects never happen:

```c
int i = 0;
size_t n = sizeof(i++);   /* i is still 0 -- i++ is never executed */
```

The single exception is a variable-length array, whose size genuinely depends on runtime values.

**3. Parentheses are required for types, optional for expressions.**

```c
sizeof(int)      /* type: parentheses REQUIRED */
sizeof x         /* expression: parentheses optional */
sizeof(x)        /* also fine */
```

The most valuable idiom in C uses form two:

```c
int *p = malloc(n * sizeof *p);   /* size of what p points to */
```

Written this way, changing `p`'s type does not require editing the `malloc` call — the size follows automatically. Compare with `malloc(n * sizeof(int))`, which silently becomes wrong if `p` becomes a `long *`.

The other essential idiom is array length:

```c
size_t count = sizeof arr / sizeof arr[0];
```

This works **only where `arr` is a real array**. Pass an array to a function and it decays to a pointer, at which point `sizeof arr` gives the pointer size and the idiom silently produces garbage. This is one of the most common bugs in beginner C.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

/* The array has DECAYED to a pointer here -- sizeof is wrong inside. */
void broken_count(int arr[])
{
    /* sizeof arr is sizeof(int*) = 8, sizeof arr[0] = 4  ->  2 */
    printf("  inside function: %zu (WRONG)\n", sizeof arr / sizeof arr[0]);
}

/* Correct: pass the length explicitly. */
void correct_count(const int *arr, size_t n)
{
    (void)arr;
    printf("  inside function: %zu (correct)\n", n);
}

int main(void)
{
    int arr[10];
    size_t n = sizeof arr / sizeof arr[0];
    printf("in main: %zu\n", n);              /* 10 -- correct */
    broken_count(arr);
    correct_count(arr, n);

    /* sizeof does not evaluate its operand. */
    int i = 0;
    size_t s = sizeof(i++);
    printf("\nsizeof(i++) = %zu, i is still %d\n", s, i);   /* i == 0 */

    /* The self-maintaining malloc idiom. */
    double *d = malloc(20 * sizeof *d);       /* == 20 * sizeof(double) */
    if (d == NULL) return 1;
    printf("allocated %zu bytes\n", 20 * sizeof *d);
    free(d);

    /* Structs include padding -- sizeof is not the sum of member sizes. */
    struct S { char c; int i; };              /* 1 + 4 = 5 bytes of data ... */
    printf("sizeof(struct S) = %zu\n", sizeof(struct S));   /* ... but 8 */

    /* Common sizes on a typical LP64 machine. */
    printf("\nsizeof(char)   = %zu\n", sizeof(char));    /* 1, always */
    printf("sizeof(int)    = %zu\n", sizeof(int));       /* 4 */
    printf("sizeof(void*)  = %zu\n", sizeof(void *));    /* 8 */
    printf("sizeof(size_t) = %zu\n", sizeof(size_t));    /* 8 */
    return 0;
}
```

Why the struct is 8 bytes, not 5:

```text
struct S { char c; int i; };

 offset:  0     1  2  3     4  5  6  7
        +----+---------+ +--------------+
        | c  | padding | |      i       |
        +----+---------+ +--------------+
          1B     3B            4B          total = 8

The 3 padding bytes align 'i' to a 4-byte boundary, because most
hardware loads a 4-byte int fastest from an address divisible by 4.
```

**Key Takeaways**

- `sizeof` yields `size_t` (print with `%zu`) and measures in units where `sizeof(char) == 1`.
- The operand is not evaluated — side effects inside `sizeof` never happen (except with VLAs).
- Prefer `malloc(n * sizeof *p)` over `malloc(n * sizeof(int))`: it stays correct when the type changes.
- `sizeof arr / sizeof arr[0]` gives the element count only where `arr` is a true array, never after decay to a pointer.
- `sizeof(struct)` includes padding, so it is usually larger than the sum of its members.

> 🧪 Practice
>
> 1. Reproduce the `broken_count` bug and print both values. Then rewrite the function to take an explicit length.
> 2. Define three structs with the same members in different orders and print `sizeof` for each. Explain the differences.
> 3. Write a macro `#define ARRAY_LEN(a) (sizeof (a) / sizeof (a)[0])` and describe a situation where it silently gives the wrong answer.
> 4. Interview-style: *"What does `sizeof(sizeof(int))` evaluate to, and why?"* Hint: what is the type of the inner expression's result?

<a id="22-variables-and-literals"></a>
### 2.2 Variables and Literals

Having types is one thing; naming values and writing them down is another. This section covers how names come into existence, how constants are spelled, and the three qualifiers that change what the compiler may assume about an object.

#### Declaration vs Definition

**Theory**

C separates *introducing a name* from *creating the thing*. This distinction is invisible in single-file programs and essential in multi-file ones.

- A **declaration** tells the compiler that a name exists and what its type is. It is a promise.
- A **definition** additionally allocates storage (for objects) or provides a body (for functions). It is the thing itself.

Every definition is also a declaration; not every declaration is a definition.

```c
extern int counter;       /* declaration: "an int named counter exists somewhere" */
int counter;              /* definition:  allocates storage */

int add(int, int);        /* declaration: prototype only */
int add(int a, int b)     /* definition:  has a body */
{ return a + b; }
```

The rule that governs multi-file programs: **a name may be declared many times but defined exactly once** across the whole program. This is why headers contain declarations and `.c` files contain definitions. Put a definition in a header, include it from two files, and the linker reports `multiple definition of 'counter'`.

`extern` is the keyword that makes a declaration explicitly *not* a definition for objects. For functions it is redundant (a prototype without a body is already just a declaration), which is why most style guides omit it there.

A subtlety at file scope: `int counter;` with no initializer is a **tentative definition**. If no other definition appears in the translation unit, it becomes a definition initialized to zero. This is why forgetting `extern` in a header sometimes appears to work (the linker may merge tentative definitions as a common-symbol extension) and sometimes fails loudly — GCC 10+ defaults to `-fno-common`, making it an error.

**Examples**

```c
/* ---------- config.h : declarations only ---------- */
#ifndef CONFIG_H
#define CONFIG_H

extern int   verbosity;        /* DECLARATION: no storage allocated here */
extern const char *app_name;   /* DECLARATION */

int  config_load(const char *path);   /* declaration (prototype) */
void config_reset(void);              /* declaration */

#endif
```

```c
/* ---------- config.c : exactly one definition of each ---------- */
#include "config.h"

int   verbosity = 0;                 /* DEFINITION: storage allocated here */
const char *app_name = "myapp";      /* DEFINITION */

int config_load(const char *path)    /* DEFINITION: has a body */
{
    (void)path;
    verbosity = 1;
    return 0;
}

void config_reset(void) { verbosity = 0; }
```

```c
/* ---------- main.c : uses the declarations ---------- */
#include <stdio.h>
#include "config.h"

int main(void)
{
    config_load("app.conf");
    printf("%s verbosity=%d\n", app_name, verbosity);
    return 0;
}
```

What goes wrong if you drop `extern`:

```c
/* BAD header: this is a DEFINITION, not a declaration. */
int verbosity;      /* included by main.c AND config.c */
```

```text
$ gcc main.o config.o -o app
/usr/bin/ld: config.o:(.bss+0x0): multiple definition of `verbosity';
             main.o:(.bss+0x0): first defined here
```

Local variables follow the same logic but with an important addition:

```c
void f(void)
{
    int x;          /* definition; automatic storage; UNINITIALIZED (garbage) */
    int y = 0;      /* definition with initializer */
    static int z;   /* definition; static storage; ZERO-initialized */
    /* extern int g; is a declaration referring to a file-scope object */
}
```

Objects with static storage duration (globals and `static` locals) are zero-initialized automatically. Automatic (stack) variables are not — reading one before assignment is undefined behavior.

**Key Takeaways**

- A declaration introduces a name and type; a definition also allocates storage or supplies a body.
- A name may be declared repeatedly but defined exactly once program-wide.
- Headers hold `extern` declarations; the matching definition lives in exactly one `.c` file.
- Omitting `extern` in a header creates a definition per including file, causing `multiple definition` at link time.
- Static-storage objects are zero-initialized; automatic variables contain garbage until assigned.

> 🧪 Practice
>
> 1. Build the three-file example above, then remove `extern` from the header and record the exact linker error.
> 2. Declare `extern int missing;` in a file, use it, and compile without ever defining it. Which tool reports the error, and what does it say?
> 3. Print an uninitialized automatic `int` and an uninitialized `static int` in the same function. Explain the difference.
> 4. Interview-style: *"Can you have two definitions of the same function in one program?"* Hint: consider `static` and what internal linkage does to the name.

#### Identifiers and Keywords

**Theory**

An **identifier** is a name you give to a variable, function, type, macro, or label. The syntactic rules are simple; the *reservation* rules are where people get into trouble.

Syntax:
- Made of letters, digits, and underscore (`_`).
- Cannot start with a digit.
- Case sensitive (`count` and `Count` are different).
- Cannot be a keyword.
- C99 also permits universal character names (Unicode) in identifiers, though few codebases use them.

Guaranteed-distinct lengths: C99 requires at least 63 significant characters for internal identifiers and 31 for external (linker-visible) ones. Modern toolchains impose no practical limit.

**Reserved identifiers** are the part that bites. The standard reserves entire *patterns* for the implementation, and using them is undefined behavior even though it usually compiles:

| Pattern | Reserved for | Example of a name to avoid |
| --- | --- | --- |
| `_` + uppercase letter | Always, any scope | `_Buffer`, `_MAX` |
| `__` (double underscore) anywhere | Always, any scope | `my__var`, `__helper` |
| `_` + lowercase, at file scope | File-scope identifiers | `_count` as a global |
| `str`, `mem`, `wcs` + lowercase | Future `<string.h>` additions | `strjoin`, `memclear` |
| `is`, `to` + lowercase | Future `<ctype.h>` additions | `islower_ascii` |
| `E` + digit or uppercase | `<errno.h>` | `E2BIG_CUSTOM` |
| `LC_` + uppercase | `<locale.h>` | `LC_MYTHING` |
| `SIG` / `SIG_` + uppercase | `<signal.h>` | `SIGMYEVENT` |
| `int`/`uint` … `_t` | `<stdint.h>` | `uint24_t` |

The practical rule: **prefix your project's public names with a short project tag** (`http_parse`, `img_load`) rather than a leading underscore. This avoids reserved patterns and gives you a namespace at the same time.

C's keyword list has grown across standards:

| Standard | Added keywords |
| --- | --- |
| C89 | `auto break case char const continue default do double else enum extern float for goto if int long register return short signed sizeof static struct switch typedef union unsigned void volatile while` |
| C99 | `inline restrict _Bool _Complex _Imaginary` |
| C11 | `_Alignas _Alignof _Atomic _Generic _Noreturn _Static_assert _Thread_local` |
| C23 | `alignas alignof bool constexpr false nullptr static_assert thread_local true typeof typeof_unqual` (and more) |

Note the C11 keywords all begin with `_` + uppercase precisely because that pattern was reserved — the committee left itself room to add keywords without breaking existing code.

**Examples**

```c
#include <stdio.h>

/* Valid identifiers */
int   count;
int   _internal_ok_at_block_scope;   /* risky at file scope -- reserved there */
int   MAX_SIZE;
int   camelCase;
int   snake_case;
int   x2;
int   _;                              /* legal, though unhelpful */

/* Invalid -- each of these is a compile error */
/* int 2fast;        starts with a digit          */
/* int my-var;       hyphen is not an identifier char */
/* int int;          keyword                      */
/* int my var;       space                        */

/* Reserved patterns: legal to the compiler, UNDEFINED BEHAVIOR per the standard */
/* int __helper;     double underscore anywhere   */
/* int _Buffer;      underscore + uppercase       */
/* void strjoin();   str + lowercase              */

/* Good practice: namespace with a project prefix. */
typedef struct http_request http_request;
int  http_parse(const char *raw, http_request *out);
void http_free(http_request *req);

int main(void)
{
    /* Case sensitivity is real and a common source of typos. */
    int value = 1, Value = 2, VALUE = 3;
    printf("%d %d %d\n", value, Value, VALUE);   /* 1 2 3 */
    return 0;
}
```

**Key Takeaways**

- Identifiers use letters, digits, and `_`; they cannot begin with a digit and are case sensitive.
- Names beginning with `_` + uppercase, or containing `__` anywhere, are reserved to the implementation in every scope.
- A leading `_` at file scope is also reserved; use a project prefix (`http_`, `img_`) instead.
- `str`, `mem`, `is`, `to`, `E`, `SIG`, `LC_` prefixes are reserved for future standard-library growth.
- Keywords differ by standard; C11's `_Alignas`-style spellings exist to avoid breaking pre-existing code.

> 🧪 Practice
>
> 1. Write a list of ten identifiers, half valid and half invalid or reserved, and check each against a compiler with `-Wall -pedantic`. Note which reserved names compile without complaint.
> 2. Rename a small module's public functions to use a consistent project prefix and observe how it changes readability at call sites.
> 3. Interview-style: *"Why do C11 keywords look like `_Static_assert` instead of `static_assert`?"* Hint: what would happen to a 2005 codebase that had already defined its own `static_assert` macro?

#### Integer, Floating, Character, and String Literals

**Theory**

A **literal** (the standard says "constant") is a value written directly in source code. What surprises most newcomers is that every literal has a *type*, determined by rules you can control with prefixes and suffixes — and getting that type wrong causes real bugs.

**Integer literals.** The base comes from the prefix:

| Form | Base | Example | Value |
| --- | --- | --- | --- |
| No prefix | Decimal | `42` | 42 |
| `0` prefix | **Octal** | `042` | 34 |
| `0x` / `0X` | Hexadecimal | `0x2A` | 42 |
| `0b` / `0B` (C23) | Binary | `0b101010` | 42 |

The octal rule is a genuine trap: `0755` is 493, and a zero-padded "decimal" like `010` is 8. This bites when formatting data or writing lookup tables.

Suffixes control the type:

| Suffix | Meaning | Example |
| --- | --- | --- |
| none | `int`, then `long`, then `long long` (first that fits) | `42` |
| `u` / `U` | unsigned | `42u` |
| `l` / `L` | long | `42L` |
| `ll` / `LL` | long long | `42LL` |
| combined | `ul`, `ull`, … | `42ULL` |

Without a suffix, a decimal literal gets the first *signed* type that can hold it. This matters: `1 << 31` overflows a 32-bit `int` (undefined behavior), while `1u << 31` is fine.

**Floating literals.** An unsuffixed literal is a **`double`**, not a `float`:

| Suffix | Type | Example |
| --- | --- | --- |
| none | `double` | `3.14` |
| `f` / `F` | `float` | `3.14f` |
| `l` / `L` | `long double` | `3.14L` |

Scientific notation (`1.5e-10`) and C99 hex float notation (`0x1.8p3` = 12.0) are also available. Writing `float x = 3.14;` computes a `double` and then narrows it — usually harmless but wasteful, and compilers warn under `-Wdouble-promotion`.

**Character literals.** Here is C's most surprising rule: **`'a'` has type `int`, not `char`**, so `sizeof('a')` is 4 on a typical machine (in C++ it is 1). The value is the character's encoding in the execution character set — usually ASCII, so `'A'` is 65.

Prefixes: `L'x'` (`wchar_t`), `u'x'` (`char16_t`), `U'x'` (`char32_t`), and C23's `u8'x'` (`char8_t`).

**String literals.** A string literal `"hello"` has type `char[6]` — five characters plus the automatic terminating `'\0'`. Key properties:

- It has **static storage duration**: it exists for the whole program.
- Attempting to **modify it is undefined behavior**, even though its type is not `const char[]` in C (a historical wart). In practice it lives in read-only memory and writing segfaults.
- Adjacent literals are **concatenated at compile time**: `"foo" "bar"` is `"foobar"`. This is how the `PRId32` macros work.

The critical distinction:

```c
char *p  = "hello";   /* pointer to a read-only literal -- do NOT modify */
char a[] = "hello";   /* a modifiable 6-byte array, COPIED from the literal */
```

**Examples**

```c
#include <stdio.h>

int main(void)
{
    /* --- Integer literals: base matters --- */
    printf("42    = %d\n", 42);          /* 42  decimal */
    printf("042   = %d\n", 042);         /* 34  OCTAL -- the leading zero */
    printf("0x2A  = %d\n", 0x2A);        /* 42  hex */
    printf("0b101010 = %d\n", 0b101010); /* 42  binary (C23; GCC extension earlier) */

    /* Suffix controls the type, which controls the arithmetic. */
    printf("\n1 << 31  is UB on 32-bit int; 1u << 31 = %u\n", 1u << 31);
    printf("sizeof 42   = %zu\n", sizeof 42);      /* 4  (int) */
    printf("sizeof 42L  = %zu\n", sizeof 42L);     /* 8  (long, LP64) */
    printf("sizeof 42LL = %zu\n", sizeof 42LL);    /* 8  (long long) */

    /* --- Floating literals default to double --- */
    printf("\nsizeof 3.14  = %zu\n", sizeof 3.14);   /* 8  (double) */
    printf("sizeof 3.14f = %zu\n", sizeof 3.14f);    /* 4  (float)  */
    printf("1.5e-10 = %g, 0x1.8p3 = %g\n", 1.5e-10, 0x1.8p3);  /* ..., 12 */

    /* --- Character literals are int in C --- */
    printf("\n'A' = %d, sizeof 'A' = %zu\n", 'A', sizeof 'A');  /* 65, 4 */
    printf("'0' = %d\n", '0');                                   /* 48 */
    printf("digit value of '7' = %d\n", '7' - '0');              /* 7 -- common idiom */

    /* --- String literals --- */
    printf("\nsizeof \"hello\" = %zu\n", sizeof "hello");   /* 6: 5 chars + '\0' */

    char *p  = "hello";      /* points into read-only storage */
    char  a[] = "hello";     /* a private, modifiable copy */
    a[0] = 'H';              /* fine */
    /* p[0] = 'H'; */        /* UNDEFINED BEHAVIOR -- usually a segfault */
    printf("a = %s, p = %s\n", a, p);

    /* Adjacent literals concatenate at compile time. */
    const char *msg = "This is one "
                      "long string "
                      "split across lines.";
    puts(msg);
    return 0;
}
```

Memory picture of the two string forms:

```text
char *p = "hello";               char a[] = "hello";

  p (8 bytes, on stack)            a (6 bytes, on stack)
  +----------+                     +---+---+---+---+---+----+
  | 0x400604 |---+                 | h | e | l | l | o | \0 |
  +----------+   |                 +---+---+---+---+---+----+
                 |                   ^ modifiable: it is YOUR copy
                 v
  .rodata (read-only section)
  +---+---+---+---+---+----+
  | h | e | l | l | o | \0 |      <- writing here is undefined behavior
  +---+---+---+---+---+----+
```

**Key Takeaways**

- A leading `0` means octal: `042` is 34, not 42. Never zero-pad decimal literals.
- Unsuffixed integer literals are `int` (then `long`, `long long`); use `u`/`L`/`LL` to control the type in shifts and comparisons.
- Unsuffixed floating literals are `double`; write `3.14f` when you want a `float`.
- `'a'` has type `int` in C, so `sizeof 'a'` is 4; `'7' - '0'` is the standard digit-conversion idiom.
- `"hello"` is a `char[6]` with static storage; modifying a string literal is undefined behavior — use `char a[] = "..."` for a mutable copy.

> 🧪 Practice
>
> 1. Print `010`, `10`, and `0x10` and explain the three different values. Then find a real-world case (file permissions, escape codes) where octal is the natural notation.
> 2. Write `char *p = "test"; p[0] = 'T';` and run it. Record what happens, then fix it two different ways.
> 3. Demonstrate that `sizeof('a') != sizeof(char)` in C, and explain why this differs from C++.
> 4. Interview-style: *"What is the difference between `char *s = "abc"` and `char s[] = "abc"` in terms of storage and mutability?"* Hint: draw where the bytes live for each.

#### Escape Sequences

**Theory**

Some characters cannot be typed literally inside a string: a newline would end the line, a double quote would end the string, and control characters have no printable form. **Escape sequences** are the backslash-introduced spellings that stand in for them.

The complete standard set:

| Escape | Name | ASCII value |
| --- | --- | --- |
| `\n` | Newline (line feed) | 10 |
| `\t` | Horizontal tab | 9 |
| `\r` | Carriage return | 13 |
| `\\` | Backslash | 92 |
| `\'` | Single quote | 39 |
| `\"` | Double quote | 34 |
| `\?` | Question mark (avoids trigraphs) | 63 |
| `\0` | Null character | 0 |
| `\a` | Alert (bell) | 7 |
| `\b` | Backspace | 8 |
| `\f` | Form feed | 12 |
| `\v` | Vertical tab | 11 |
| `\ooo` | Octal, 1–3 digits | varies |
| `\xhh…` | Hexadecimal, 1+ digits | varies |
| `\uXXXX`, `\UXXXXXXXX` | Universal character name (C99) | varies |

Two traps deserve attention.

**The hex escape is greedy.** `\x` consumes *as many* hex digits as follow it, with no two-digit limit. So `"\x41BC"` is not `'A'` followed by `"BC"` — it is a single escape `\x41BC`, which overflows a `char` and is a compile error or implementation-defined. The fix is string concatenation: `"\x41" "BC"`.

**`\0` is just an octal escape.** `\0` is octal zero, and `\012` is octal 12 = decimal 10 = newline. So `"\0"` and `"\00"` are the null character, but `"\08"` is `\0` followed by the character `8` (since 8 is not an octal digit).

Note also that `\n` is a *single* character (value 10). On Windows text-mode streams the C runtime translates it to CR+LF on output, but in memory it is always one byte. That translation is why you open binary files with `"rb"`/`"wb"`.

**Examples**

```c
#include <stdio.h>

int main(void)
{
    /* Common escapes in action */
    printf("Line one\nLine two\n");              /* newline */
    printf("Col1\tCol2\tCol3\n");                /* tab-separated */
    printf("She said \"hello\" to me.\n");       /* embedded quotes */
    printf("Path: C:\\Users\\dev\\file.txt\n");  /* literal backslashes */
    printf("A bell: \a\n");                      /* audible alert */

    /* Numeric escapes: three ways to write 'A' (65 = 0101 octal = 0x41) */
    printf("%c %c %c\n", 'A', '\101', '\x41');   /* A A A */

    /* The greedy hex trap */
    /* printf("\x41BC\n"); */                    /* ERROR: hex escape out of range */
    printf("%s\n", "\x41" "BC");                 /* correct: "ABC" */

    /* \0 is octal zero; it terminates C strings */
    const char embedded[] = "abc\0def";          /* 8 bytes, but strlen is 3 */
    printf("sizeof = %zu, prints as: %s\n", sizeof embedded, embedded);

    /* A progress-bar idiom using carriage return (no newline) */
    for (int i = 0; i <= 100; i += 25) {
        printf("\rProgress: %3d%%", i);          /* \r returns to column 0 */
        fflush(stdout);                          /* force output without a newline */
    }
    printf("\n");

    /* ANSI terminal colors use the ESC character, \033 or \x1b */
    printf("\033[31mred text\033[0m and normal\n");
    return 0;
}
```

Byte-level view of an escape-heavy string:

```text
"a\tb\n"

  'a'   '\t'  'b'   '\n'  '\0'
  0x61  0x09  0x62  0x0A  0x00     <- 5 bytes total, sizeof == 5
  ^^^^  ^^^^^^^^^^  ^^^^
  one   one char    one char
  char  (not two)   (not two)
```

**Key Takeaways**

- Escape sequences let you embed newlines, quotes, backslashes, and control characters in literals.
- `\n` is one character (value 10), not the two characters `\` and `n`.
- `\xhh` is greedy — it consumes every following hex digit; break the string to stop it (`"\x41" "BC"`).
- `\0` is octal zero and terminates C strings; a string with an embedded `\0` has `sizeof` larger than `strlen`.
- Windows paths in literals need doubled backslashes (`"C:\\dir"`), or use forward slashes, which the Windows API accepts.

> 🧪 Practice
>
> 1. Print a small table using `\t` alignment, then the same table using `printf` width specifiers. Compare robustness when the values vary in length.
> 2. Create `char s[] = "ab\0cd";` and print both `sizeof s` and `strlen(s)`. Explain the difference.
> 3. Write the string `"\x41BC"` and record the compiler error, then fix it with concatenation.
> 4. Interview-style: *"How many bytes does `"a\\b"` occupy?"* Hint: count the characters after the compiler processes the escape, then add the terminator.

#### const Qualifier

**Theory**

`const` means **"this object will not be modified through this name."** That framing matters: it is a promise about access, not a guarantee that the underlying memory is immutable.

What it buys you:

1. **Compiler-enforced intent.** Attempting to assign through a `const` name is a compile error, catching bugs early.
2. **Self-documenting interfaces.** `void print(const char *s)` tells every caller the string is safe.
3. **Optimization opportunities.** The compiler may place `const` objects with static storage in read-only memory.

A critical difference from C++: **in C, a `const` object is not a compile-time constant expression.** You cannot use it as an array size in C89, in a `case` label, or in a bit-field width. That is what `#define` and `enum` are for.

```c
const int SIZE = 10;
int arr1[SIZE];        /* C89: error. C99: a VLA, not a fixed array. */

#define SIZE2 10
int arr2[SIZE2];       /* fine: 10 is a literal after preprocessing */

enum { SIZE3 = 10 };
int arr3[SIZE3];       /* fine: enum constants ARE constant expressions */
```

With pointers, `const` can qualify two different things, and reading the declaration right-to-left resolves it:

```c
const int *p;        /* p is a pointer to a const int   -- can't do *p = x  */
int const *p;        /* identical to the above          */
int *const p;        /* p is a const pointer to int     -- can't do p = &y  */
const int *const p;  /* both are const                  */
```

The mnemonic: **`const` applies to what is on its left, unless there is nothing on its left, in which case it applies to what is on its right.**

Finally, casting away `const` and then writing is **undefined behavior** if the object was actually defined as `const`. The cast compiles; the write may segfault.

**Examples**

```c
#include <stdio.h>
#include <string.h>

/* const in an interface: "I will read your buffer, never write it." */
size_t count_char(const char *s, char target)
{
    size_t n = 0;
    while (*s) {                 /* reading through a const pointer: fine */
        if (*s == target) n++;
        s++;                     /* moving the pointer itself: also fine --
                                    s is a non-const pointer to const char */
    }
    /* *s = 'x';  ERROR: assignment of read-only location */
    return n;
}

int main(void)
{
    const int limit = 100;
    /* limit = 200; */           /* ERROR: assignment of read-only variable */
    printf("limit = %d\n", limit);

    int x = 1, y = 2;

    /* 1. Pointer to const int: the VALUE is protected. */
    const int *p1 = &x;
    /* *p1 = 5; */               /* ERROR */
    p1 = &y;                     /* OK: repointing is allowed */

    /* 2. Const pointer to int: the POINTER is protected. */
    int *const p2 = &x;
    *p2 = 5;                     /* OK: the value can change */
    /* p2 = &y; */               /* ERROR: p2 itself is const */

    /* 3. Both const. */
    const int *const p3 = &x;
    /* *p3 = 5;  ERROR */
    /* p3 = &y;  ERROR */
    printf("x=%d *p3=%d\n", x, *p3);

    /* const arrays of strings: a very common idiom */
    static const char *const days[] = {
        "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
    };
    printf("%s\n", days[2]);

    printf("count = %zu\n", count_char("hello world", 'l'));
    return 0;
}
```

Reading complex declarations right-to-left:

```text
const char * const * p;
                     ^ p
                   ^   is a pointer
           ^^^^^         to a const pointer
      ^^^^                  to a const char

Read: "p is a pointer to a const pointer to a const char."
```

**Key Takeaways**

- `const` promises that an object will not be modified *through that particular name*.
- In C (unlike C++) a `const` object is not a constant expression — use `#define` or `enum` for array sizes and `case` labels.
- `const int *p` protects the pointed-to value; `int *const p` protects the pointer; read right-to-left.
- Marking pointer parameters `const` documents that a function only reads its input, and enables better diagnostics.
- Casting away `const` and writing to a genuinely `const` object is undefined behavior, typically a segfault.

> 🧪 Practice
>
> 1. Write all four pointer/`const` combinations, then attempt both `*p = ...` and `p = ...` on each. Record which compile.
> 2. Add `const` to every read-only pointer parameter in a small program of yours. Note any places the compiler then rejects — those were real modifications you may not have intended.
> 3. Try `const int n = 5; int a[n];` under `-std=c89 -pedantic` and `-std=c99`. Explain both outcomes.
> 4. Interview-style: *"What does `char * const * const p` mean?"* Hint: apply the right-to-left rule one qualifier at a time.

#### volatile Qualifier

**Theory**

Compilers optimize on an assumption: **the only thing that changes memory is your program.** Given that, a loop that reads the same variable repeatedly without writing it can safely read once and cache the value in a register.

That assumption is false in three situations, and `volatile` is how you tell the compiler so:

1. **Memory-mapped hardware registers.** A status register at a fixed address changes because a peripheral changed it.
2. **Variables modified by a signal handler.** The handler can run between any two instructions.
3. **Variables shared with another thread** — though for threads, `volatile` is *not* sufficient; you need atomics or a mutex, because `volatile` provides no ordering or atomicity guarantees.

`volatile` means: **every read must actually read memory, every write must actually write memory, and the compiler may not reorder these accesses relative to each other.** It disables caching in registers and elimination of "redundant" accesses.

Without it, this hardware polling loop can compile into an infinite loop:

```c
uint32_t *status = (uint32_t *)0x40001000;
while (*status == 0) { }        /* compiler reads ONCE, loops on the register */
```

With `volatile`, each iteration re-reads the address:

```c
volatile uint32_t *status = (volatile uint32_t *)0x40001000;
while (*status == 0) { }        /* correct: reads memory every iteration */
```

The essential caveat: **`volatile` is not a threading primitive.** It guarantees the access happens; it does not make it atomic and does not prevent the *CPU* from reordering. For inter-thread communication use `_Atomic` (C11), `stdatomic.h`, or mutexes. For signal handlers use `volatile sig_atomic_t`, which the standard specifically blesses.

**Examples**

```c
#include <stdio.h>
#include <signal.h>
#include <stdint.h>

/* The standard's own type for signal-handler communication. */
static volatile sig_atomic_t stop_requested = 0;

static void handle_sigint(int sig)
{
    (void)sig;
    stop_requested = 1;      /* set asynchronously, outside normal flow */
}

int main(void)
{
    signal(SIGINT, handle_sigint);

    /* Without 'volatile', the compiler may hoist the read out of the loop
       and never observe the handler's write -- an infinite loop. */
    unsigned long spins = 0;
    while (!stop_requested) {
        if (++spins > 100000000UL) break;   /* bounded, so the demo terminates */
    }
    printf("\nstopped after %lu spins (stop_requested = %d)\n",
           spins, (int)stop_requested);
    return 0;
}
```

Hardware register access, the canonical embedded pattern:

```c
#include <stdint.h>

/* Each read/write must reach the peripheral, in program order. */
#define UART_STATUS  (*(volatile uint32_t *)0x40011000)
#define UART_DATA    (*(volatile uint32_t *)0x40011004)
#define UART_TX_READY (1u << 7)

void uart_putc(char c)
{
    /* Poll until the transmitter is ready. Requires a fresh read each time. */
    while ((UART_STATUS & UART_TX_READY) == 0) {
        /* spin */
    }
    UART_DATA = (uint32_t)(unsigned char)c;   /* the write must not be elided */
}
```

What the qualifier changes, conceptually:

```text
   int flag;                          volatile int flag;

   while (!flag) { }                  while (!flag) { }
        |                                  |
        v  compiler may generate:          v  compiler must generate:
   load flag -> r1                    loop: load flag -> r1
   loop: test r1                            test r1
         jump loop                          jump loop
   (infinite: r1 never reloaded)      (correct: memory read each pass)
```

Note the pointer syntax mirrors `const`:

```c
volatile int *p;        /* pointer to volatile int (the usual MMIO case) */
int *volatile p;        /* volatile pointer to ordinary int (rare) */
volatile int *volatile p;  /* both */
```

**Key Takeaways**

- `volatile` tells the compiler that an object may change outside the program's control, forcing a real memory access on every read and write.
- Its three legitimate uses are memory-mapped I/O, `sig_atomic_t` flags set by signal handlers, and `setjmp`/`longjmp` locals.
- It is **not** a synchronization primitive: it provides no atomicity and no CPU-level ordering. Use `_Atomic` or mutexes for threads.
- Without `volatile`, a polling loop on a hardware register can be optimized into an infinite loop.
- `volatile int *p` (pointer to volatile) is the MMIO form; the qualifier follows the same right-to-left reading rules as `const`.

> 🧪 Practice
>
> 1. Write a loop that spins on a non-`volatile` global, compile at `-O0` and `-O2`, and inspect the assembly with `gcc -S`. Then add `volatile` and compare.
> 2. Implement a `SIGINT` handler that sets a `volatile sig_atomic_t` flag, and a main loop that exits cleanly when it is set.
> 3. Write both `volatile int *p` and `int *volatile p`, then attempt to modify `*p` and `p` for each. Record which compile.
> 4. Interview-style: *"Is `volatile` enough to share a counter between two threads?"* Hint: distinguish "the access happens" from "the access is atomic and ordered."

#### restrict Qualifier

**Theory**

`restrict` (C99) is a **promise you make to the compiler** about pointers. Applied to a pointer parameter, it asserts: *for the lifetime of this pointer, the object it points to will be accessed only through this pointer (or pointers derived from it).* In other words, no aliasing.

Why does that matter? Consider:

```c
void add_arrays(int *a, int *b, int *sum, int n)
{
    for (int i = 0; i < n; i++)
        sum[i] = a[i] + b[i];
}
```

The compiler cannot know whether `sum` overlaps `a` or `b`. If `sum == a + 1`, then writing `sum[0]` changes `a[1]`, so the compiler must reload `a[i]` and `b[i]` on every iteration and cannot vectorize the loop. Adding `restrict` removes that doubt:

```c
void add_arrays(int *restrict a, int *restrict b, int *restrict sum, int n)
```

Now the compiler can load, compute, and store in wide SIMD chunks.

The catch is that `restrict` is **unchecked**. If you lie — pass overlapping pointers to a `restrict` function — the behavior is undefined, and the bug will be silent and data-dependent. The compiler will not warn you.

The most famous example in the standard library is the `memcpy`/`memmove` pair:

```c
void *memcpy(void *restrict dest, const void *restrict src, size_t n);
void *memmove(void *dest, const void *src, size_t n);   /* no restrict */
```

`memcpy` may be fast precisely because it assumes no overlap. `memmove` handles overlap correctly and is slightly slower. Using `memcpy` on overlapping buffers is undefined behavior, and it does misbehave in practice on optimized implementations.

Note that `restrict` applies only to pointers, and it is meaningful mainly on function parameters and on local pointers within a block.

**Examples**

```c
#include <stdio.h>
#include <string.h>

/* Promise: dst does not overlap src. The compiler may vectorize freely. */
void scale_copy(double *restrict dst, const double *restrict src,
                size_t n, double factor)
{
    for (size_t i = 0; i < n; i++)
        dst[i] = src[i] * factor;   /* no reload of src needed: no aliasing */
}

/* No promise: the compiler must assume dst and src may overlap. */
void scale_copy_safe(double *dst, const double *src, size_t n, double factor)
{
    for (size_t i = 0; i < n; i++)
        dst[i] = src[i] * factor;   /* conservative codegen */
}

int main(void)
{
    double a[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    double b[8];

    scale_copy(b, a, 8, 2.0);        /* correct: b and a are distinct */
    for (int i = 0; i < 8; i++) printf("%g ", b[i]);
    printf("\n");

    /* scale_copy(a + 1, a, 7, 2.0);   UNDEFINED BEHAVIOR: they overlap. */
    scale_copy_safe(a + 1, a, 7, 2.0);  /* defined, though still order-sensitive */

    /* memcpy vs memmove on overlapping memory */
    char buf[] = "abcdefgh";
    /* memcpy(buf + 2, buf, 5); */      /* UB: regions overlap */
    memmove(buf + 2, buf, 5);           /* correct: handles overlap */
    printf("%s\n", buf);                /* ababcdeh */
    return 0;
}
```

Why the compiler is stuck without `restrict`:

```text
Without restrict, the compiler must consider this possibility:

  src:  [ s0 ][ s1 ][ s2 ][ s3 ]
  dst:        [ d0 ][ d1 ][ d2 ][ d3 ]
                ^
                dst[0] and src[1] are the SAME memory

  So after writing dst[0], the value of src[1] may have changed
  -> must reload src[i] every iteration
  -> cannot process four elements at once with SIMD

With restrict, you guarantee the regions are disjoint, so:
  -> load 4 src values, multiply, store 4 dst values, per iteration
```

**Key Takeaways**

- `restrict` promises that the pointed-to object is accessed only through that pointer, enabling vectorization and reduced reloads.
- The promise is unchecked: violating it is undefined behavior with no diagnostic.
- `memcpy` declares `restrict` on both arguments; use `memmove` whenever the regions may overlap.
- It applies only to pointers and matters most on function parameters in numeric or buffer-processing code.
- Add it only where you can genuinely guarantee non-overlap, and document the requirement at the call sites.

> 🧪 Practice
>
> 1. Write a vector-addition function with and without `restrict`, compile both at `-O3`, and diff the assembly (look for `xmm`/`ymm` SIMD registers).
> 2. Call `memcpy` with overlapping regions and observe the result; then use `memmove` on the same data and compare.
> 3. Add `restrict` to a function and then deliberately pass overlapping pointers. Does the compiler warn? Does the output change between `-O0` and `-O2`?
> 4. Interview-style: *"Why does `strcpy` not declare its parameters `restrict` in every implementation, while `memcpy` does?"* Hint: check the actual C standard signatures for both — and think about what the caller can reasonably guarantee.

<a id="23-operators"></a>
### 2.3 Operators

Operators are where types meet computation. C has a large operator set with precise rules about precedence, evaluation order, and the types of results — and several operators behave differently than newcomers expect.

#### Arithmetic Operators

**Theory**

C provides five arithmetic operators: `+`, `-`, `*`, `/`, `%`. Four behave as expected. The two that require care are **integer division** and **the modulus operator**.

**Integer division truncates.** If both operands are integers, the result is an integer with the fractional part discarded — not rounded:

```c
7 / 2    == 3      /* not 3.5, not 4 */
-7 / 2   == -3     /* truncation is TOWARD ZERO (C99+) */
```

Before C99, the direction of truncation for negative operands was implementation-defined. C99 standardized it: division truncates toward zero, and `%` takes the sign of the dividend (the left operand). The invariant the standard guarantees is:

```text
(a / b) * b + (a % b) == a
```

Working through `-7 / 2` and `-7 % 2`: `-7 / 2` is `-3`, so `-3 * 2 + r == -7`, giving `r == -1`. Hence `-7 % 2 == -1`, not `1`. This differs from Python, where `-7 % 2 == 1` — a frequent source of confusion for people arriving from other languages.

**Division or modulus by zero is undefined behavior**, not an exception. On most hardware integer division by zero raises SIGFPE and crashes; floating-point division by zero produces infinity (under IEEE 754). Always check the divisor.

**`%` requires integer operands.** For floating-point remainder use `fmod()` from `math.h`.

Unary `-` on the most-negative integer (`-INT_MIN`) overflows and is undefined behavior, because `INT_MAX` is one less than `|INT_MIN|` in two's complement.

**Examples**

```c
#include <stdio.h>
#include <math.h>     /* fmod */

int main(void)
{
    /* Integer division truncates toward zero. */
    printf(" 7 / 2  = %d\n",  7 / 2);    /*  3 */
    printf("-7 / 2  = %d\n", -7 / 2);    /* -3 (toward zero, not -4) */
    printf(" 7 %% 2  = %d\n",  7 % 2);   /*  1 */
    printf("-7 %% 2  = %d\n", -7 % 2);   /* -1 (sign follows the dividend) */
    printf(" 7 %% -2 = %d\n",  7 % -2);  /*  1 */

    /* Verify the standard's invariant. */
    int a = -7, b = 2;
    printf("(a/b)*b + a%%b = %d  (should be %d)\n", (a/b)*b + a%b, a);

    /* To get a floating result, at least one operand must be floating. */
    printf("\n7 / 2   = %d   (integer division)\n", 7 / 2);
    printf("7.0 / 2 = %g (one double operand promotes the other)\n", 7.0 / 2);
    printf("(double)7 / 2 = %g\n", (double)7 / 2);
    printf("7 / (double)2 = %g\n", 7 / (double)2);

    /* A classic bug: the division happens BEFORE the conversion. */
    int total = 7, count = 2;
    double wrong = total / count;            /* 3.0 -- integer division first */
    double right = (double)total / count;    /* 3.5 */
    printf("\nwrong = %g, right = %g\n", wrong, right);

    /* Floating-point remainder needs fmod. */
    printf("fmod(7.5, 2.0) = %g\n", fmod(7.5, 2.0));   /* 1.5 */

    /* Always guard the divisor. */
    int divisor = 0;
    if (divisor != 0) printf("%d\n", 10 / divisor);
    else              printf("division by zero avoided\n");

    /* A safe way to round up an integer division. */
    int items = 17, per_page = 5;
    int pages = (items + per_page - 1) / per_page;   /* ceiling division */
    printf("pages = %d\n", pages);                   /* 4 */
    return 0;
}
```

Truncation directions compared:

```text
   value    C (trunc toward 0)   floor()    Python's //
   ------   ------------------   -------    -----------
    7 / 2          3                3            3
   -7 / 2         -3               -4           -4
    7 % 2          1                1            1
   -7 % 2         -1                1            1
```

**Key Takeaways**

- Integer division truncates toward zero; `7/2 == 3` and `-7/2 == -3`.
- `%` takes the sign of the left operand (dividend): `-7 % 2 == -1`, unlike Python.
- The invariant `(a/b)*b + (a%b) == a` always holds for well-defined operands.
- Division or modulus by zero is undefined behavior for integers; for floating point it yields infinity or NaN.
- To get a floating result, cast one operand *before* the division: `(double)total / count`, not `(double)(total / count)`.

> 🧪 Practice
>
> 1. Write a program printing `a / b` and `a % b` for all sign combinations of `7` and `2`. Verify the standard's invariant for each.
> 2. Implement `int floor_div(int a, int b)` and `int floor_mod(int a, int b)` that behave like Python's `//` and `%` for negative operands.
> 3. Write a function that computes a percentage as a `double` from two `int` counts, correct when the numerator is smaller than the denominator.
> 4. Interview-style: *"How do you compute the ceiling of an integer division without floating point?"* Hint: `(a + b - 1) / b` — and consider when that expression can overflow.

#### Relational and Equality Operators

**Theory**

The relational operators (`<`, `>`, `<=`, `>=`) and equality operators (`==`, `!=`) compare two values and yield an **`int`**: `1` for true, `0` for false. Not a `bool` — an `int`. This is why `printf("%d", 3 > 2)` prints `1`.

Three behaviors deserve attention.

**1. `==` versus `=`.** The single most common C typo is writing assignment where comparison was meant. Because assignment is an expression whose value is the assigned value, `if (x = 5)` compiles, assigns 5 to `x`, and is always true. Compilers warn under `-Wall`, and the defensive "Yoda condition" (`if (5 == x)`) makes the mistake a compile error, though modern warnings make it largely unnecessary.

**2. Comparing floating-point with `==` is almost always wrong.** Because `0.1 + 0.2 != 0.3` in binary, exact comparison fails for computed values. Compare with a tolerance instead (see 2.4).

**3. Mixed signed/unsigned comparison converts the signed operand to unsigned**, as covered in 2.1. `-1 < 1u` is false.

Two pointer-specific rules:
- Comparing pointers with `==`/`!=` is always well-defined.
- Comparing with `<`/`>` is only defined for pointers into the **same array object** (or one past its end). Ordering pointers to unrelated objects is undefined behavior, even though it appears to work.

Finally, chained comparisons do not mean what they do in mathematics. `a < b < c` parses as `(a < b) < c`, comparing `0` or `1` against `c`.

**Examples**

```c
#include <stdio.h>
#include <string.h>
#include <math.h>

int main(void)
{
    /* Results are int 0 or 1, not bool. */
    printf("(3 > 2)  = %d\n", 3 > 2);      /* 1 */
    printf("(3 == 2) = %d\n", 3 == 2);     /* 0 */
    printf("sizeof (3 > 2) = %zu\n", sizeof (3 > 2));   /* 4 -- it's an int */

    /* Assignment vs comparison */
    int x = 0;
    if (x = 5)                             /* WARNING: assignment, always true */
        printf("x was assigned %d\n", x);
    x = 0;
    if (x == 5) printf("never\n");
    else        printf("x == 5 is false\n");

    /* Chained comparison does not mean what it looks like. */
    int a = 1, b = 5, c = 3;
    printf("\n(a < b < c) = %d\n", a < b < c);   /* (1<5)=1, then 1<3 = 1 */
    printf("correct form  = %d\n", a < b && b < c);   /* 0 -- 5 < 3 is false */

    /* Floating-point equality */
    double f = 0.1 + 0.2;
    printf("\n(0.1+0.2 == 0.3) = %d\n", f == 0.3);              /* 0 */
    printf("with tolerance    = %d\n", fabs(f - 0.3) < 1e-9);   /* 1 */

    /* Strings compare by ADDRESS with ==, not content. */
    char s1[] = "hello", s2[] = "hello";
    printf("\n(s1 == s2)          = %d  (compares pointers)\n", s1 == s2);
    printf("strcmp(s1,s2) == 0  = %d  (compares content)\n", strcmp(s1, s2) == 0);

    /* Signed/unsigned comparison */
    int i = -1; unsigned u = 1;
    printf("\n(-1 < 1u) = %d  (signed converted to unsigned)\n", i < u);

    /* Pointer comparison within one array is well-defined. */
    int arr[5];
    int *p = &arr[1], *q = &arr[3];
    printf("(p < q) = %d\n", p < q);   /* 1 -- same array, defined */
    return 0;
}
```

**Key Takeaways**

- Relational and equality operators yield `int` `0` or `1` in C, not `bool`.
- `=` is assignment and `==` is comparison; `if (x = 5)` is legal, always true, and warned about under `-Wall`.
- Never compare floating-point values with `==`; use a tolerance appropriate to the magnitudes involved.
- `s1 == s2` on strings compares addresses; use `strcmp(s1, s2) == 0` to compare content.
- `a < b < c` parses as `(a < b) < c`; write `a < b && b < c`.

> 🧪 Practice
>
> 1. Write `if (x = 5)` and compile with and without `-Wall`. Then fix it and confirm the warning disappears.
> 2. Demonstrate that `a < b < c` gives a surprising result for `a=1, b=5, c=3`, and explain the two-step evaluation.
> 3. Compare two identical string literals with `==` and with `strcmp`. Then try the same with two `char[]` arrays and explain any difference in the `==` result.
> 4. Interview-style: *"Is `p < q` well-defined for two arbitrary pointers?"* Hint: consider what guarantee the standard makes about pointers into different objects.

#### Logical Operators and Short-Circuiting

**Theory**

The logical operators are `&&` (and), `||` (or), and `!` (not). They treat any nonzero scalar as true and zero as false, and they produce `int` `0` or `1`.

Their defining feature is **short-circuit evaluation**:

- `a && b` evaluates `b` **only if** `a` is true. If `a` is false, the result is 0 and `b` is never touched.
- `a || b` evaluates `b` **only if** `a` is false.

This is not merely an optimization — it is guaranteed by the standard, and there is a **sequence point** between the two operands, meaning the left side is fully evaluated (side effects included) before the right side begins. That guarantee makes this the standard idiom for guarded access:

```c
if (p != NULL && p->value > 0)   /* p->value is only evaluated if p is non-NULL */
if (i < n && arr[i] == target)   /* bounds check before indexing */
```

Reverse the operands and you get a crash. Order is part of the semantics.

The corresponding pattern for defaults and early exits:

```c
if (config == NULL || config->disabled)   /* stops before dereferencing NULL */
```

Two frequent errors:

**Confusing `&&` with `&`.** The bitwise operators (`&`, `|`) evaluate both operands and operate bit by bit. `2 && 1` is `1` (both truthy); `2 & 1` is `0` (no common bits). Using `&` where `&&` was meant silently changes both the value and the evaluation behavior.

**Assuming C has boolean-returning `||` like Python.** In C, `a || b` yields `1`, not `a` or `b`. The idiom `x = a || b;` gives `x` the value 1, not the first truthy operand.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

int side_effect(const char *label, int value)
{
    printf("  [evaluated %s]\n", label);
    return value;
}

typedef struct { int value; } Node;

int main(void)
{
    /* Short-circuit: the right operand is never evaluated. */
    puts("0 && side_effect():");
    int r1 = 0 && side_effect("right", 1);      /* right side skipped */
    printf("  result = %d\n\n", r1);

    puts("1 || side_effect():");
    int r2 = 1 || side_effect("right", 1);      /* right side skipped */
    printf("  result = %d\n\n", r2);

    puts("1 && side_effect():");
    int r3 = 1 && side_effect("right", 1);      /* right side IS evaluated */
    printf("  result = %d\n\n", r3);

    /* The guard idiom: order is load-bearing. */
    Node *p = NULL;
    if (p != NULL && p->value > 0)              /* safe: never dereferences NULL */
        puts("positive");
    else
        puts("null or non-positive");

    /* if (p->value > 0 && p != NULL)  <- CRASHES: dereference happens first */

    /* Bounds check before indexing */
    int arr[5] = {1, 2, 3, 4, 5};
    int i = 10;
    if (i < 5 && arr[i] == 3) puts("found");    /* arr[10] never accessed */
    else                      puts("out of range");

    /* && vs & are genuinely different operators. */
    printf("\n2 && 1 = %d  (logical: both truthy)\n", 2 && 1);   /* 1 */
    printf("2 &  1 = %d  (bitwise: 010 & 001 = 000)\n", 2 & 1);  /* 0 */

    /* Logical operators yield 1, not the operand value. */
    int a = 5, b = 7;
    printf("\n(a || b) = %d  (not 5)\n", a || b);
    printf("!0 = %d, !5 = %d, !!5 = %d\n", !0, !5, !!5);  /* 1, 0, 1 */
    return 0;
}
```

Evaluation flow:

```text
   expr:   f() && g()

           +--------+   false (0)
           |  f()   |----------------> result = 0    (g() NOT called)
           +--------+
                | true (nonzero)
                v
           +--------+
           |  g()   |----------------> result = (g() != 0)
           +--------+

   Sequence point between the operands: every side effect of f()
   is complete before g() begins.
```

**Key Takeaways**

- `&&` and `||` short-circuit: the right operand is evaluated only when the result is not already determined.
- There is a sequence point between the operands, so left-side side effects complete first — this makes NULL and bounds guards safe.
- Both operators yield `int` `1` or `0`, never the operand's own value.
- `&&`/`||` are not `&`/`|`: the bitwise versions evaluate both sides and combine bits.
- `!!x` is the idiomatic way to normalize any scalar to `0` or `1`.

> 🧪 Practice
>
> 1. Write a function with a `printf` side effect and use it on both sides of `&&` and `||` with each combination of truthy/falsy left operands. Record which calls actually happen.
> 2. Write a linked-list search that uses `p != NULL && p->key == target` in the loop condition, then reverse the operands and observe the crash.
> 3. Replace `&&` with `&` in a NULL-guard expression and explain precisely why it becomes unsafe.
> 4. Interview-style: *"How would you write a safe division that returns 0 when the divisor is zero, in a single expression?"* Hint: `b != 0 && ...` does not return the quotient — think about the ternary operator instead.

#### Bitwise Operators and Shifts

**Theory**

Bitwise operators work on the individual bits of integer values. They exist because C is a systems language: flags, masks, hardware registers, and compact encodings all require bit-level control.

| Operator | Name | Effect |
| --- | --- | --- |
| `&` | AND | 1 where both bits are 1 |
| `\|` | OR | 1 where either bit is 1 |
| `^` | XOR | 1 where the bits differ |
| `~` | NOT | Flips every bit (unary) |
| `<<` | Left shift | Moves bits left, filling with 0 |
| `>>` | Right shift | Moves bits right |

```text
   a = 0b1100 (12)      a & b  = 0b1000 (8)
   b = 0b1010 (10)      a | b  = 0b1110 (14)
                        a ^ b  = 0b0110 (6)
                        ~a     = ...11110011  (depends on width)
                        a << 1 = 0b11000 (24)
                        a >> 1 = 0b0110  (6)
```

Left shift by *n* multiplies by `2^n`; right shift divides by `2^n` (for non-negative values).

The rules that cause undefined behavior are worth memorizing, because they are easy to trip:

| Situation | Status |
| --- | --- |
| Shift count `>=` width of the promoted type | **Undefined behavior** |
| Shift count negative | **Undefined behavior** |
| Left-shifting a negative value | **Undefined behavior** (C99+) |
| Left shift where the result overflows a signed type | **Undefined behavior** |
| Right-shifting a negative value | **Implementation-defined** (arithmetic shift in practice) |
| Any shift on unsigned types within range | Well-defined |

`1 << 31` on a 32-bit `int` overflows into the sign bit — undefined. Write `1u << 31`. This one line prevents a whole class of bugs.

Also note that **integer promotion applies before the operation**: operands narrower than `int` are promoted to `int` first. So `~(unsigned char)0` is not 255 but `-1` (as an `int`), and shifting an `unsigned char` by 20 is legal because it was promoted to a 32-bit `int`.

**Examples**

```c
#include <stdio.h>
#include <stdint.h>

/* Print the low 8 bits of a value, most significant first. */
static void print_bits8(const char *label, unsigned v)
{
    printf("%-10s ", label);
    for (int i = 7; i >= 0; i--) putchar((v >> i) & 1u ? '1' : '0');
    printf("  (%u)\n", v & 0xFFu);
}

/* Flag definitions: each is a distinct single bit. */
#define FLAG_READ    (1u << 0)   /* 0000 0001 */
#define FLAG_WRITE   (1u << 1)   /* 0000 0010 */
#define FLAG_EXEC    (1u << 2)   /* 0000 0100 */
#define FLAG_HIDDEN  (1u << 3)   /* 0000 1000 */

int main(void)
{
    unsigned a = 12, b = 10;
    print_bits8("a = 12", a);
    print_bits8("b = 10", b);
    print_bits8("a & b", a & b);
    print_bits8("a | b", a | b);
    print_bits8("a ^ b", a ^ b);
    print_bits8("a << 1", a << 1);
    print_bits8("a >> 1", a >> 1);

    /* --- The four canonical bit operations --- */
    unsigned flags = 0;
    flags |=  FLAG_READ | FLAG_WRITE;     /* SET bits */
    flags &= ~FLAG_WRITE;                 /* CLEAR a bit (AND with inverse) */
    flags ^=  FLAG_EXEC;                  /* TOGGLE a bit */
    if (flags & FLAG_READ)                /* TEST a bit */
        puts("\nREAD is set");
    print_bits8("flags", flags);

    /* --- Undefined behavior to avoid --- */
    /* int x = 1 << 31;      UB: overflows signed int    */
    uint32_t ok = 1u << 31;  /* fine: unsigned            */
    printf("1u << 31 = %u\n", ok);
    /* int y = 1 << 32;      UB: shift count >= width     */
    /* int z = -8 >> 1;      implementation-defined       */

    /* Promotion surprise: operands smaller than int are promoted. */
    unsigned char c = 0;
    printf("~c as int = %d (not 255)\n", ~c);              /* -1 */
    printf("(unsigned char)~c = %u\n", (unsigned char)~c); /* 255 */

    /* Useful idioms */
    unsigned n = 40;
    printf("\nn is %s\n", (n & 1u) ? "odd" : "even");      /* low bit test */
    printf("n is %s a power of 2\n",
           (n && !(n & (n - 1))) ? "" : "not");            /* power-of-two test */
    printf("n / 8  via shift = %u\n", n >> 3);
    printf("n * 4  via shift = %u\n", n << 2);
    return 0;
}
```

Clearing a bit, step by step:

```text
   flags        0000 1011
   FLAG_WRITE   0000 0010
   ~FLAG_WRITE  1111 1101       <- invert the mask
   -----------------------  AND
   result       0000 1001       <- bit 1 cleared, everything else preserved
```

**Key Takeaways**

- `&` masks, `|` sets, `^` toggles, `~` inverts; `<<` and `>>` multiply and divide by powers of two.
- Set with `x |= MASK`, clear with `x &= ~MASK`, toggle with `x ^= MASK`, test with `if (x & MASK)`.
- Shifting by a count `>=` the type's width, or by a negative count, is undefined behavior.
- Left-shifting into or past the sign bit of a signed type is undefined; use unsigned types for bit manipulation.
- Integer promotion applies first, so `~` and `<<` on `char`/`short` operate on a promoted `int`.

> 🧪 Practice
>
> 1. Write `set_bit`, `clear_bit`, `toggle_bit`, and `test_bit` functions taking a `uint32_t` and a bit index. Test each.
> 2. Implement a function that counts the set bits in a `uint32_t` using `n &= n - 1` in a loop, and explain why that clears the lowest set bit.
> 3. Write a function that swaps the two 16-bit halves of a `uint32_t` using shifts and masks.
> 4. Interview-style: *"How do you check whether an unsigned integer is a power of two in one expression?"* Hint: think about what `n - 1` does to the bit pattern of a power of two.

#### Assignment and Compound Assignment

**Theory**

In C, **assignment is an expression, not a statement.** `x = 5` has a value (5) and a type (that of `x`), which is why `if (x = 5)` compiles and why chained assignment works:

```c
a = b = c = 0;      /* right-associative: a = (b = (c = 0)) */
```

The result of an assignment is the value *after* conversion to the left operand's type. So `int i; double d = (i = 3.7);` gives `d == 3.0`, not 3.7 — the truncation happens first.

**Compound assignment** operators (`+=`, `-=`, `*=`, `/=`, `%=`, `&=`, `|=`, `^=`, `<<=`, `>>=`) combine an operation with assignment. The standard defines `a op= b` as equivalent to `a = a op b` **except that `a` is evaluated only once.** That exception is the entire point:

```c
arr[compute_index()] += 5;    /* compute_index() called ONCE */
arr[compute_index()] = arr[compute_index()] + 5;   /* called TWICE -- possibly
                                                      different indices! */
```

For any expression with side effects or nontrivial cost on the left, the compound form is both faster and more correct.

One subtlety: compound assignment performs an implicit conversion back to the left type, which can silently truncate:

```c
char c = 100;
c += 100;        /* computed as int 200, then truncated to char -- may be -56 */
```

`-Wconversion` flags these.

**Examples**

```c
#include <stdio.h>

static int call_count = 0;

int index_of(void)
{
    call_count++;
    printf("  [index_of called, count=%d]\n", call_count);
    return 2;
}

int main(void)
{
    /* Assignment is an expression with a value. */
    int x, y, z;
    x = y = z = 10;                       /* right-associative chain */
    printf("x=%d y=%d z=%d\n", x, y, z);

    int n;
    printf("value of (n = 42) is %d\n", (n = 42));

    /* The assignment's value is AFTER conversion. */
    int i;
    double d = (i = 3.7);                 /* i becomes 3; d becomes 3.0 */
    printf("i=%d d=%g\n", i, d);

    /* Compound assignment evaluates the left operand once. */
    int arr[5] = {0, 0, 0, 0, 0};
    puts("\nCompound form:");
    arr[index_of()] += 5;                 /* one call */
    puts("Expanded form:");
    call_count = 0;
    arr[index_of()] = arr[index_of()] + 5;/* two calls */

    /* All compound operators */
    int v = 20;
    v += 5;  printf("\nv += 5  -> %d\n", v);   /* 25 */
    v -= 3;  printf("v -= 3  -> %d\n", v);     /* 22 */
    v *= 2;  printf("v *= 2  -> %d\n", v);     /* 44 */
    v /= 4;  printf("v /= 4  -> %d\n", v);     /* 11 */
    v %= 3;  printf("v %%= 3  -> %d\n", v);    /* 2  */
    v <<= 4; printf("v <<= 4 -> %d\n", v);     /* 32 */
    v >>= 2; printf("v >>= 2 -> %d\n", v);     /* 8  */
    v |= 1;  printf("v |= 1  -> %d\n", v);     /* 9  */
    v &= 12; printf("v &= 12 -> %d\n", v);     /* 8  */
    v ^= 15; printf("v ^= 15 -> %d\n", v);     /* 7  */

    /* Silent truncation on the implicit conversion back. */
    char c = 100;
    c += 100;                             /* int 200 -> char, may overflow */
    printf("\nchar 100 += 100 -> %d\n", c);
    return 0;
}
```

**Key Takeaways**

- Assignment is an expression whose value is the assigned value after conversion to the left operand's type.
- Assignment is right-associative, making `a = b = c = 0` valid.
- `a op= b` evaluates `a` exactly once, unlike `a = a op b` — essential when the left side has side effects.
- Compound assignment implicitly converts back to the left type, which can truncate silently.
- Enable `-Wconversion` to catch narrowing introduced by compound assignment.

> 🧪 Practice
>
> 1. Write a function with a side effect that returns an array index, and use it in both `arr[f()] += 1` and `arr[f()] = arr[f()] + 1`. Count the calls.
> 2. Demonstrate silent truncation with `char c = 100; c += 100;` and then with `unsigned char`. Explain the difference.
> 3. Rewrite a chain of `x = x * 2 + 1` style updates using compound operators and confirm identical results.
> 4. Interview-style: *"What is the value and type of the expression `(char)(i = 300)` when `i` is an `int`?"* Hint: two conversions happen, in a specific order.

#### Increment and Decrement

**Theory**

`++` and `--` add or subtract one. Each has two forms, and the difference is **what the expression evaluates to**, not what happens to the variable:

| Form | Name | Expression value | Variable after |
| --- | --- | --- | --- |
| `++x` | Prefix | The **new** value | incremented |
| `x++` | Postfix | The **old** value | incremented |

Mnemonic: read the operator position literally. In `++x` the increment comes first, so you get the new value. In `x++` the increment comes after, so you get the old value.

```c
int x = 5;
int a = ++x;   /* x becomes 6, a == 6 */

int y = 5;
int b = y++;   /* b == 5, then y becomes 6 */
```

As a standalone statement, `i++;` and `++i;` are identical — the discarded value is the only difference. (The old advice that `++i` is faster applies to C++ iterators with overloaded operators, not to C scalars, where compilers generate identical code.)

The genuinely important rule: **modifying an object more than once between sequence points, or reading it for a purpose other than computing its new value, is undefined behavior.** These expressions have no defined meaning:

```c
i = i++;             /* UB */
i = ++i + i++;       /* UB */
arr[i] = i++;        /* UB */
printf("%d %d", i++, i++);   /* UB */
```

Different compilers produce different results, and the same compiler may differ between optimization levels. There is no "right answer" to memorize — the correct response is to never write such code. C11 restated these rules in terms of *sequencing* rather than sequence points, but the practical guidance is unchanged.

The classic legitimate idiom is combining traversal with access:

```c
*dst++ = *src++;    /* copy, then advance both pointers */
```

Here each object is modified once, and the reads compute the pointers' own new values, so it is well-defined.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    /* Prefix vs postfix: same effect on the variable, different value. */
    int x = 5;
    printf("x=5;  ++x yields %d, x is now %d\n", ++x, x);   /* 6, 6 */
    int y = 5;
    printf("y=5;  y++ yields %d, y is now %d\n", y++, y);   /* 5, 6 */

    /* As statements, they are equivalent. */
    int i = 0, j = 0;
    i++; ++j;
    printf("\nafter i++ and ++j: i=%d j=%d\n", i, j);       /* 1 1 */

    /* The classic pointer-copy idiom (well-defined). */
    const char *src = "hello";
    char dst[16], *d = dst;
    while ((*d++ = *src++) != '\0')       /* copy char, advance both, test */
        ;
    printf("copied: %s\n", dst);

    /* Correct array fill: one modification per expression. */
    int arr[5];
    for (int k = 0; k < 5; k++) arr[k] = k * 10;
    for (int k = 0; k < 5; k++) printf("%d ", arr[k]);
    printf("\n");

    /* UNDEFINED BEHAVIOR -- never write these: */
    /* int v = 5; v = v++;                       */
    /* int w = 1; w = ++w + w++;                 */
    /* printf("%d %d\n", i++, i++);              */
    /* while (n < 5) arr[n] = n++ * 10;          */
    return 0;
}
```

Evaluation trace:

```text
   int x = 5;
   int a = ++x;

     step 1: x = x + 1     -> x is 6
     step 2: value of expr -> 6
     step 3: a = 6

   int y = 5;
   int b = y++;

     step 1: value of expr -> 5   (the OLD value is captured)
     step 2: y = y + 1     -> y is 6
     step 3: b = 5
```

**Key Takeaways**

- `++x` yields the new value; `x++` yields the old value. Both increment the variable.
- As standalone statements they are equivalent; in C there is no performance difference for scalars.
- Modifying an object twice in one expression (`i = i++`) is undefined behavior with no meaningful "answer."
- Reading a variable in the same expression where it is modified, for an unrelated purpose (`arr[i] = i++`), is also undefined.
- `*dst++ = *src++` is a well-defined and idiomatic copy loop, because each object is modified once.

> 🧪 Practice
>
> 1. For `int x = 3;` print the value and the resulting `x` for each of `x++`, `++x`, `x--`, `--x`, resetting between each.
> 2. Write `i = i++;` and compile it with GCC and Clang at `-O0` and `-O2`. Compare results and note that all four may differ.
> 3. Implement `strcpy` yourself using the `*d++ = *s++` idiom, then rewrite it with explicit indices and compare readability.
> 4. Interview-style: *"What does `a[i] = i++;` evaluate to?"* Hint: the correct answer is not a number — name the language rule it violates.

#### Ternary Conditional Operator

**Theory**

The conditional operator `? :` is C's only ternary operator (it takes three operands) and its only **expression-level** conditional. Where `if` is a statement that performs actions, `? :` is an expression that produces a value:

```c
result = condition ? value_if_true : value_if_false;
```

Two properties make it more than syntactic sugar:

**1. Only one branch is evaluated.** There is a sequence point after the condition, so the untaken branch's side effects never happen. This makes guarded expressions safe:

```c
int len = (s != NULL) ? strlen(s) : 0;   /* strlen never called on NULL */
```

**2. It works where statements cannot** — in initializers, in `const` initialization, inside macro bodies, and in function arguments:

```c
const int limit = is_debug ? 10 : 1000;   /* an if-statement cannot do this */
printf("%d item%s\n", n, n == 1 ? "" : "s");
```

The result type follows the usual arithmetic conversions applied to the two branches, which can surprise you: `flag ? 1 : 2.0` has type `double`, so the result is `1.0` even when the condition is true.

Style caution: the operator is right-associative, so nesting works (`a ? b : c ? d : e` parses as `a ? b : (c ? d : e)`), but deeply nested ternaries become unreadable fast. Two levels is a reasonable ceiling; beyond that use `if`/`else` or a lookup table.

Note also that its precedence is very low — lower than arithmetic and comparison but higher than assignment — so parenthesize when embedding it in a larger expression.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    int a = 10, b = 20;

    /* Basic use: an expression, so it can initialize. */
    int max = (a > b) ? a : b;
    printf("max = %d\n", max);

    /* Works where a statement cannot: const initialization. */
    const int retries = (a > 5) ? 3 : 10;
    printf("retries = %d\n", retries);

    /* Inline pluralization -- a very common idiom. */
    for (int n = 0; n <= 2; n++)
        printf("%d file%s\n", n, n == 1 ? "" : "s");

    /* Safe guarded evaluation: strlen is skipped when s is NULL. */
    const char *s = NULL;
    size_t len = (s != NULL) ? strlen(s) : 0;
    printf("len = %zu\n", len);

    /* Result type follows the usual arithmetic conversions. */
    printf("\n1 : 2.0  -> %g (double, even though the condition is true)\n",
           1 ? 1 : 2.0);
    printf("sizeof (1 ? 'a' : 0) = %zu\n", sizeof (1 ? 'a' : 0));  /* int */

    /* Nesting: readable at two levels, not beyond. */
    int score = 85;
    const char *grade = score >= 90 ? "A"
                      : score >= 80 ? "B"
                      : score >= 70 ? "C"
                      : "F";
    printf("\ngrade = %s\n", grade);

    /* Precedence trap: ?: binds looser than +, so parenthesize. */
    int x = 5;
    printf("1 + (x > 3 ? 10 : 20) = %d\n", 1 + (x > 3 ? 10 : 20));  /* 11 */

    /* Also usable as an lvalue selector via pointers. */
    int p = 1, q = 2;
    *((a > b) ? &p : &q) = 99;      /* assigns to q, since a < b */
    printf("p=%d q=%d\n", p, q);
    return 0;
}
```

Comparison with `if`:

| | `if` / `else` | `? :` |
| --- | --- | --- |
| Kind | Statement | Expression |
| Produces a value | No | Yes |
| Usable in an initializer | No | Yes |
| Can contain multiple statements | Yes | No |
| Best for | Control flow with actions | Choosing between two values |

**Key Takeaways**

- `? :` is an expression that yields a value, so it works in initializers, arguments, and macro bodies where `if` cannot.
- Only the selected branch is evaluated; a sequence point after the condition makes NULL guards safe.
- The result type comes from the usual arithmetic conversions of both branches — `1 ? 1 : 2.0` is `1.0`.
- It is right-associative, so chained ternaries work, but keep nesting shallow for readability.
- Its low precedence means you should parenthesize it inside larger expressions.

> 🧪 Practice
>
> 1. Rewrite three small `if`/`else` assignments as ternary expressions, and one ternary chain back into `if`/`else`. Judge which reads better in each case.
> 2. Write `printf("%d item%s\n", n, ...)` handling singular/plural, then extend it to handle 0 as "no items" with nested ternaries.
> 3. Print `sizeof (1 ? 'a' : 0)` and `sizeof (1 ? 'a' : 0.0)` and explain both results.
> 4. Interview-style: *"Can the conditional operator be used on the left-hand side of an assignment?"* Hint: not directly in C — but consider what happens if the branches yield pointers.

#### Comma Operator

**Theory**

The comma operator evaluates its left operand, **discards the result**, then evaluates its right operand and yields that value. There is a sequence point between the two, so the left side's side effects are complete before the right side begins.

```c
x = (a, b);     /* evaluates a (discarding it), then assigns b to x */
```

The left operand is therefore useful only for its side effects. Its main legitimate use is in `for` loops, where the syntax allows only one expression in the init and increment slots:

```c
for (i = 0, j = n - 1; i < j; i++, j--)   /* two counters, one loop */
```

The essential confusion to clear up: **most commas in C are not the comma operator.** They are separators, and they have different meanings:

| Context | Is it the operator? |
| --- | --- |
| `f(a, b)` — function arguments | No, separator |
| `int a, b;` — declarations | No, separator |
| `{1, 2, 3}` — initializer lists | No, separator |
| `enum { A, B }` — enumerators | No, separator |
| `for (a, b; c; d, e)` | **Yes**, operator |
| `x = (a, b);` | **Yes**, operator |

Because of this, `f(a, b)` passes two arguments while `f((a, b))` passes one — the value of `b`. The extra parentheses change the meaning entirely.

The comma operator has the **lowest precedence of any C operator**, lower even than assignment, which is why `x = a, b;` parses as `(x = a), b;`.

Outside `for` loops and a few macro idioms, the comma operator is rarely worth using: it hides side effects and makes code harder to read.

**Examples**

```c
#include <stdio.h>

int main(void)
{
    /* The value of a comma expression is the RIGHT operand. */
    int x = (1, 2, 3);
    printf("x = %d\n", x);                  /* 3 */

    /* Precedence: comma is lower than assignment. */
    int y;
    y = 1, 2;                               /* parses as (y = 1), 2 */
    printf("y = %d\n", y);                  /* 1 */
    int z = (1, 2);                         /* parentheses needed to get 2 */
    printf("z = %d\n", z);                  /* 2 */

    /* The legitimate use: multiple init/increment expressions in a for loop. */
    puts("\nReversing an array with two counters:");
    int arr[] = {1, 2, 3, 4, 5, 6};
    int n = (int)(sizeof arr / sizeof arr[0]);
    for (int i = 0, j = n - 1; i < j; i++, j--) {
        int t = arr[i]; arr[i] = arr[j]; arr[j] = t;
    }
    for (int i = 0; i < n; i++) printf("%d ", arr[i]);
    printf("\n");

    /* Separator vs operator: these are different calls. */
    printf("\ntwo args: ");
    printf("%d %d\n", 1, 2);                /* comma = separator */
    printf("one arg:  ");
    printf("%d\n", (1, 2));                 /* comma = operator; prints 2 */

    /* Sequence point: left side completes before right side. */
    int i = 0;
    int v = (i++, i * 10);                  /* i becomes 1, then v = 10 */
    printf("\ni=%d v=%d\n", i, v);
    return 0;
}
```

A macro idiom where the comma operator earns its place:

```c
/* Log the access and return the element, as a single expression. */
#define TRACED_GET(arr, i) \
    (fprintf(stderr, "get[%d]\n", (i)), (arr)[(i)])

int value = TRACED_GET(data, 3);   /* logs, then yields data[3] */
```

**Key Takeaways**

- The comma operator evaluates left, discards it, evaluates right, and yields the right value.
- There is a sequence point between the operands, so left-side side effects complete first.
- It has the lowest precedence in C — lower than assignment — so `x = a, b` means `(x = a), b`.
- Commas in function calls, declarations, and initializer lists are separators, not the operator.
- Its main legitimate use is multiple expressions in a `for` loop's init and increment clauses.

> 🧪 Practice
>
> 1. Print the values of `(1, 2, 3)`, and of `y` after `y = 1, 2;` versus `y = (1, 2);`. Explain each.
> 2. Write a `for` loop that walks two indices toward each other using the comma operator, and rewrite it without the comma operator. Compare clarity.
> 3. Call `printf("%d\n", (1, 2))` and `printf("%d %d\n", 1, 2)` and explain why the first prints one value.
> 4. Interview-style: *"How many arguments does `f((a, b), c)` pass?"* Hint: count the separators at the top level of the argument list.

#### Precedence and Associativity

**Theory**

When an expression contains several operators, two rules decide the grouping:

- **Precedence** determines which operator binds more tightly. `a + b * c` is `a + (b * c)` because `*` outranks `+`.
- **Associativity** breaks ties among equal precedence. `a - b - c` is `(a - b) - c` because `-` is left-associative.

Neither rule says anything about **evaluation order**. `f() + g()` groups as one addition, but the compiler may call `g()` first. Precedence is about parsing; order of evaluation is (mostly) unspecified.

The full table, highest precedence first:

| Level | Operators | Associativity |
| --- | --- | --- |
| 1 | `()` `[]` `.` `->` postfix `++` `--` compound literals | Left to right |
| 2 | prefix `++` `--` `+` `-` `!` `~` `*` `&` `sizeof` casts `_Alignof` | **Right to left** |
| 3 | `*` `/` `%` | Left to right |
| 4 | `+` `-` | Left to right |
| 5 | `<<` `>>` | Left to right |
| 6 | `<` `<=` `>` `>=` | Left to right |
| 7 | `==` `!=` | Left to right |
| 8 | `&` | Left to right |
| 9 | `^` | Left to right |
| 10 | `\|` | Left to right |
| 11 | `&&` | Left to right |
| 12 | `\|\|` | Left to right |
| 13 | `?:` | **Right to left** |
| 14 | `=` `+=` `-=` `*=` … | **Right to left** |
| 15 | `,` | Left to right |

Rather than memorizing all fifteen levels, internalize the handful that actually cause bugs:

**1. Bitwise operators bind looser than comparison.** This is C's most notorious precedence wart:

```c
if (flags & MASK == 0)      /* parses as flags & (MASK == 0) -- WRONG */
if ((flags & MASK) == 0)    /* what you meant */
```

**2. Shift binds looser than arithmetic.**

```c
x << 1 + 2      /* is x << 3, not (x << 1) + 2 */
```

**3. `*` and `++` on pointers.** Both are level 2, right-to-left, but postfix `++` is level 1:

```c
*p++     /* is *(p++)  -- dereference the old p, then advance */
(*p)++   /* increment the pointed-to value */
++*p     /* same as ++(*p) */
```

**4. `.` and `->` bind tighter than almost everything**, so `*p.f` is `*(p.f)`, not `(*p).f`. That is exactly why `->` exists.

**5. Assignment is right-associative and very low**, so `a = b = c` works and `x = y > 0` assigns the comparison result.

The practical rule used by every serious C style guide: **rely on precedence for arithmetic, parenthesize everything else.** Compilers agree — `-Wparentheses` (part of `-Wall`) warns about the most dangerous cases.

**Examples**

```c
#include <stdio.h>

#define FLAG_ACTIVE (1u << 2)

int main(void)
{
    /* Arithmetic: precedence works as in mathematics. */
    printf("2 + 3 * 4     = %d  (= 2 + 12)\n", 2 + 3 * 4);        /* 14 */
    printf("(2 + 3) * 4   = %d\n", (2 + 3) * 4);                  /* 20 */

    /* Associativity for equal precedence. */
    printf("\n10 - 4 - 3    = %d  (left-assoc: (10-4)-3)\n", 10 - 4 - 3);  /* 3 */
    int a, b, c;
    a = b = c = 7;                       /* right-assoc: a = (b = (c = 7)) */
    printf("a=%d b=%d c=%d\n", a, b, c);

    /* TRAP 1: bitwise & binds looser than == */
    unsigned flags = FLAG_ACTIVE;
    printf("\nflags & FLAG_ACTIVE == 0  -> %d  (WRONG: & (== 0))\n",
           flags & FLAG_ACTIVE == 0);
    printf("(flags & FLAG_ACTIVE) == 0 -> %d  (correct)\n",
           (flags & FLAG_ACTIVE) == 0);

    /* TRAP 2: shift binds looser than + */
    int x = 1;
    printf("\nx << 1 + 2    = %d  (= x << 3)\n", x << 1 + 2);     /* 8 */
    printf("(x << 1) + 2  = %d\n", (x << 1) + 2);                 /* 4 */

    /* TRAP 3: pointer dereference and increment */
    int arr[] = {10, 20, 30};
    int *p = arr;
    printf("\n*p++   = %d, p now points at %d\n", *p++, *p);      /* 10, 20 */
    p = arr;
    printf("(*p)++ = %d, arr[0] is now %d\n", (*p)++, arr[0]);    /* 10, 11 */

    /* TRAP 4: logical && binds tighter than || */
    printf("\n1 || 0 && 0 = %d  (= 1 || (0 && 0))\n", 1 || 0 && 0);  /* 1 */

    /* Evaluation ORDER is not precedence: this is unspecified. */
    /* printf("%d %d\n", f(), g());   which runs first? unspecified */
    return 0;
}
```

Parse tree for the classic trap:

```text
   flags & MASK == 0

   == has HIGHER precedence than &, so it groups as:

            &
           / \
      flags   ==
             /  \
          MASK    0        <- MASK == 0 is evaluated first (usually 0),
                              then flags & 0, which is always 0.
```

**Key Takeaways**

- Precedence decides grouping; associativity breaks ties; neither determines evaluation order.
- Bitwise `&`, `^`, `|` bind *looser* than `==` and `!=` — always parenthesize `(x & MASK) == 0`.
- Shifts bind looser than `+` and `-`: `x << 1 + 2` is `x << 3`.
- `*p++` dereferences then advances; use `(*p)++` to increment the pointed-to value.
- Rely on precedence for ordinary arithmetic and parenthesize everything else; `-Wparentheses` catches the worst cases.

> 🧪 Practice
>
> 1. Predict the value of `2 + 3 * 4 - 6 / 3`, `1 << 2 + 3`, and `5 & 3 == 3` before running them, then verify.
> 2. Write `if (flags & MASK == 0)` and compile with `-Wall`. Read the warning and fix it.
> 3. For `int arr[] = {1,2,3}; int *p = arr;` predict and verify `*p++`, `*++p`, `++*p`, and `(*p)++`, resetting `p` each time.
> 4. Interview-style: *"In `f() + g() * h()`, which function is called first?"* Hint: distinguish the shape of the expression tree from the order the compiler chooses to evaluate leaves.

<a id="24-conversions-and-numeric-behavior"></a>
### 2.4 Conversions and Numeric Behavior

C converts between types constantly and silently. These rules are mechanical and knowable, and they explain a large fraction of otherwise baffling bugs.

#### Implicit Conversions and Integer Promotion

**Theory**

Whenever an expression mixes types, C converts operands to a common type before computing. Some of these conversions are lossless; others silently discard information. Nothing warns you by default.

The first rule to learn is **integer promotion**, which applies to *every* small integer type in *every* arithmetic context:

> Any object of a type whose rank is lower than `int` — that is, `char`, `signed char`, `unsigned char`, `short`, `unsigned short`, `_Bool`, and bit-fields — is converted to `int` if `int` can represent all its values; otherwise to `unsigned int`.

This happens before any arithmetic, before shifts, before `~`. On a typical 32-bit-`int` machine, `unsigned char` and `unsigned short` both promote to *signed* `int`, because a 32-bit `int` can represent every 8-bit and 16-bit unsigned value. That has visible consequences:

```c
unsigned char a = 200, b = 100;
unsigned char c = a + b;      /* computed as int 300, then truncated to 44 */
printf("%d\n", a + b);        /* prints 300, not 44 -- the expression is int */
```

Promotion is why `sizeof(char) == 1` but `sizeof('a')` and `sizeof(c + 0)` are 4.

The other implicit conversions:

| Conversion | Behavior |
| --- | --- |
| Narrower integer → wider integer | Value preserved (sign-extended if signed) |
| Wider → narrower integer | Truncates to the low bits; for signed, implementation-defined before C23, wraps in C23 |
| Signed → unsigned | Adds `2^N` if negative; well-defined modular result |
| Integer → floating | May lose precision for large integers |
| Floating → integer | **Truncates toward zero**; UB if out of range |
| `double` → `float` | Rounds; may become infinity |
| Anything → `_Bool` | 0 stays 0, everything else becomes 1 |

The float-to-integer rule is the one people forget: `(int)3.99` is `3`, not `4`. There is no rounding — use `round()`, `floor()`, or `ceil()` if you want it.

**Examples**

```c
#include <stdio.h>
#include <limits.h>

int main(void)
{
    /* --- Integer promotion in action --- */
    unsigned char a = 200, b = 100;
    printf("a + b as expression  = %d\n", a + b);          /* 300 -- it's an int */
    unsigned char sum = a + b;
    printf("stored in u.char     = %d\n", sum);            /* 44  -- truncated */
    printf("sizeof(a)     = %zu\n", sizeof a);             /* 1 */
    printf("sizeof(a + 0) = %zu\n", sizeof(a + 0));        /* 4 -- promoted */

    /* char arithmetic is int arithmetic */
    char c1 = 'A';
    printf("\n'A' + 1 = %d, as char = %c\n", c1 + 1, (char)(c1 + 1));

    /* --- Narrowing truncates --- */
    int big = 300;
    char small = (char)big;                 /* keeps low 8 bits: 300 & 0xFF = 44 */
    printf("\n(char)300 = %d\n", small);

    long l = 4294967296L;                   /* 2^32 */
    int  i = (int)l;                        /* low 32 bits are all zero */
    printf("(int)4294967296 = %d\n", i);    /* 0 */

    /* --- Signed to unsigned is modular, not a reinterpretation error --- */
    int neg = -1;
    unsigned u = neg;                       /* -1 + 2^32 = 4294967295 */
    printf("\n(unsigned)-1 = %u\n", u);

    /* --- Float to int TRUNCATES --- */
    printf("\n(int)3.99  = %d\n", (int)3.99);    /* 3, not 4 */
    printf("(int)-3.99 = %d\n", (int)-3.99);     /* -3, not -4 */
    printf("(int)(3.99 + 0.5) = %d  (manual rounding)\n", (int)(3.99 + 0.5));

    /* --- Integer to float can lose precision --- */
    int precise = 16777217;                 /* 2^24 + 1 */
    float f = precise;                      /* float has only 24 significand bits */
    printf("\nint 16777217 -> float -> int = %d\n", (int)f);   /* 16777216 */

    /* --- Anything to _Bool normalizes --- */
    _Bool t = 42;
    printf("\n(_Bool)42 = %d\n", t);        /* 1 */
    return 0;
}
```

Promotion diagram:

```text
   unsigned char a = 200;     bits: 1100 1000        (1 byte)
   unsigned char b = 100;     bits: 0110 0100        (1 byte)

   a + b:
     step 1  promote a to int:  0000 0000 ... 1100 1000  = 200
     step 2  promote b to int:  0000 0000 ... 0110 0100  = 100
     step 3  add as int:        0000 0001 ... 0010 1100  = 300
     step 4  IF stored back into unsigned char: keep low 8 bits
                                          0010 1100      = 44
```

**Key Takeaways**

- Integer promotion converts every type narrower than `int` to `int` before arithmetic, shifts, or `~`.
- `unsigned char + unsigned char` is computed as `int`; truncation happens only on assignment back to a narrow type.
- Narrowing keeps the low-order bits; signed-to-unsigned conversion adds `2^N` and is well-defined.
- Float-to-integer conversion truncates toward zero and is undefined if the value does not fit.
- A 32-bit `float` cannot represent every `int` past `2^24`; use `double` when converting large integers.

> 🧪 Practice
>
> 1. Print `sizeof(char)`, `sizeof(c)`, and `sizeof(c + 0)` for a `char c`, and explain the three results.
> 2. Add two `unsigned char` values that sum past 255, printing both the expression result and the value stored back into an `unsigned char`.
> 3. Find the smallest positive integer that cannot be represented exactly as a `float`, by converting and converting back in a loop.
> 4. Interview-style: *"Why does `(int)(x + 0.5)` fail as a rounding function for negative `x`?"* Hint: work through `x = -2.7` step by step.

#### Usual Arithmetic Conversions

**Theory**

When a binary operator has operands of different types, C applies the **usual arithmetic conversions** to find a common type. The algorithm is mechanical, and knowing it turns "mysterious" results into predictable ones.

The order of checks:

```text
1. If either operand is long double  -> convert the other to long double
2. Else if either is double          -> convert the other to double
3. Else if either is float           -> convert the other to float
4. Otherwise (both are integers):
   a. Apply INTEGER PROMOTION to both operands
   b. If both now have the same type -> done
   c. If both are signed, or both unsigned -> convert to the higher rank
   d. If the UNSIGNED type has rank >= the signed type's rank
                                        -> convert the signed to unsigned
   e. Else if the SIGNED type can represent all values of the unsigned type
                                        -> convert the unsigned to signed
   f. Else -> convert BOTH to the unsigned version of the signed type
```

Integer rank order: `_Bool` < `char` < `short` < `int` < `long` < `long long`.

Step 4d is where the classic bug lives. `int` vs `unsigned int` on a typical platform: same rank, unsigned wins, so the `int` becomes unsigned, and a negative value becomes enormous.

Note also that the result of step 4d–4f depends on the platform's type sizes. On LP64, `int` vs `unsigned int` converts to `unsigned int` (rule d), but `int` vs `unsigned short` promotes the `unsigned short` to `int` first (rule a), so both end up `int` — no surprise. Change to a 16-bit-`int` platform and that second case behaves differently.

**Examples**

```c
#include <stdio.h>
#include <limits.h>

int main(void)
{
    /* Rule 2: one double makes both double. */
    int    i = 7;
    double d = 2.0;
    printf("7 / 2.0 = %g  (int converted to double)\n", i / d);   /* 3.5 */
    printf("7 / 2   = %d  (both int)\n", 7 / 2);                  /* 3 */

    /* Rule 4d: unsigned wins at equal rank -- the classic trap. */
    int      s = -1;
    unsigned u = 1;
    printf("\n(-1 < 1u)          = %d\n", s < u);                 /* 0 */
    printf("(-1 converted)     = %u\n", (unsigned)s);             /* 4294967295 */

    /* Rule 4e: a wider signed type can represent the unsigned one. */
    long          ls = -1;
    unsigned int  ui = 1;
    printf("\n(-1L < 1u) on LP64 = %d  (unsigned int fits in long)\n", ls < ui);

    /* Rule 4a: promotion first can eliminate the mismatch entirely. */
    int            si = -1;
    unsigned short us = 1;
    printf("(-1 < (unsigned short)1) = %d  (us promoted to int)\n", si < us);  /* 1 */

    /* A realistic bug: comparing a signed count against strlen. */
    int count = -1;
    size_t len = 5;                          /* size_t is unsigned */
    if (count < (int)len) puts("\ncorrect: cast to signed");
    if (count < len)      puts("this does NOT print: count became huge");

    /* Mixed-width integer arithmetic */
    printf("\nsizeof(int + long)       = %zu\n", sizeof(1 + 1L));
    printf("sizeof(int + long long)  = %zu\n", sizeof(1 + 1LL));
    printf("sizeof(char + char)      = %zu  (both promoted to int)\n",
           sizeof((char)1 + (char)1));
    printf("sizeof(float + double)   = %zu\n", sizeof(1.0f + 1.0));
    return 0;
}
```

Decision flowchart:

```text
   a OP b  with different types
        |
        v
   any long double? --yes--> both long double
        | no
        v
   any double? -------yes--> both double
        | no
        v
   any float? --------yes--> both float
        | no
        v
   promote both to at least int
        |
        v
   same type now? ----yes--> done
        | no
        v
   same signedness? --yes--> convert to the higher rank
        | no
        v
   unsigned rank >= signed rank? --yes--> convert signed -> UNSIGNED  (the trap)
        | no
        v
   signed type covers all unsigned values? --yes--> convert unsigned -> signed
        | no
        v
   both -> unsigned version of the signed type
```

**Key Takeaways**

- Floating types win over integers; `long double` > `double` > `float`.
- For integers, promotion to `int` happens first, then the higher-rank type wins.
- At equal rank, unsigned beats signed — this converts negative values to huge positives.
- A wider signed type can absorb a narrower unsigned type, avoiding the trap (`long` vs `unsigned int` on LP64).
- Enable `-Wsign-compare` and `-Wconversion`, and cast explicitly whenever operand types differ in signedness.

> 🧪 Practice
>
> 1. For each pair — `int`/`unsigned`, `long`/`unsigned int`, `int`/`unsigned short`, `char`/`char` — print `sizeof` of the sum and predict the common type first.
> 2. Write a loop comparing a signed index against `strlen(s)` that fails, then fix it three ways (cast, use `size_t`, restructure the condition).
> 3. Demonstrate a case where `a < b` and `b < c` are both true but `a < c` is false, using mixed signedness.
> 4. Interview-style: *"Why is `-1 < sizeof(int)` false?"* Hint: name the specific step of the usual arithmetic conversions that applies.

#### Explicit Casts

**Theory**

A cast `(type)expression` performs an explicit conversion. Its purpose is to say "I know these types differ, and I mean this." Used well, it documents intent; used carelessly, it silences the compiler while the bug survives.

The legitimate uses:

**1. Forcing floating-point arithmetic.**
```c
double avg = (double)total / count;   /* without the cast: integer division */
```

**2. Documenting an intentional narrowing.**
```c
uint8_t low = (uint8_t)(value & 0xFF);   /* deliberate truncation */
```

**3. Converting `void *` to a concrete type** where required (in C, mainly for function-pointer or `qsort` comparator use, since object-pointer conversions are implicit).

**4. Discarding a value explicitly.**
```c
(void)unused_parameter;
```

The dangerous uses:

**Casting away `const` or `volatile`.** The cast compiles; writing to a genuinely `const` object is undefined behavior.

**Casting between unrelated pointer types.** This can violate alignment requirements and the strict aliasing rule, both of which are undefined behavior that optimizers actively exploit:

```c
float f = 1.5f;
int *p = (int *)&f;      /* strict aliasing violation */
printf("%d\n", *p);      /* UB -- may print anything, may be optimized away */
```

The correct way to reinterpret bits is `memcpy` (which compilers optimize into a single move) or a union.

**Casting a pointer to a smaller integer type.** Use `uintptr_t`, never `int`.

A useful discipline: **every cast should have a reason you can state in one sentence.** If the reason is "it made the warning go away," the cast is probably hiding a real problem.

Note that C has only this one cast syntax — there is no `static_cast`/`reinterpret_cast` distinction as in C++, so the reader cannot tell intent from syntax. Comments matter more.

**Examples**

```c
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>

int main(void)
{
    /* 1. Forcing floating-point division -- cast BEFORE dividing. */
    int total = 7, count = 2;
    printf("no cast:      %g\n", (double)(total / count));   /* 3   -- too late */
    printf("correct cast: %g\n", (double)total / count);     /* 3.5 */

    /* 2. Documented, intentional narrowing. */
    uint32_t value = 0xDEADBEEF;
    uint8_t  low   = (uint8_t)(value & 0xFFu);   /* explicitly want one byte */
    printf("\nlow byte = 0x%02X\n", low);

    /* 3. Reinterpreting bits: memcpy, not a pointer cast. */
    float f = 1.5f;
    uint32_t bits;
    memcpy(&bits, &f, sizeof bits);              /* well-defined, and optimized
                                                    to a single register move */
    printf("float 1.5 bit pattern = 0x%08X\n", bits);
    /* uint32_t *bad = (uint32_t *)&f;   strict aliasing violation -- UB */

    /* 4. Pointer-to-integer requires uintptr_t. */
    int v = 5;
    uintptr_t addr = (uintptr_t)&v;              /* correct */
    /* int addr_bad = (int)&v;                      truncates on 64-bit */
    printf("address = 0x%" PRIxPTR "\n", addr);

    /* 5. Explicitly discarding a value. */
    (void)printf("discarded return value\n");

    /* 6. Casting away const is legal syntax and dangerous semantics. */
    const int locked = 10;
    int *sneaky = (int *)&locked;                /* compiles fine */
    /* *sneaky = 20; */                          /* UNDEFINED BEHAVIOR */
    (void)sneaky;

    /* 7. In C you do NOT cast malloc's result. */
    int *arr = malloc(10 * sizeof *arr);         /* void* converts implicitly */
    if (arr) { arr[0] = 1; free(arr); }
    return 0;
}
```

Cast checklist:

| Cast | Verdict |
| --- | --- |
| `(double)a / b` | Good — forces float division |
| `(uint8_t)(x & 0xFF)` | Good — documents intended truncation |
| `(void)unused` | Good — documents deliberate discard |
| `(int *)malloc(...)` | Unnecessary in C; can hide a missing header |
| `(char *)&some_int` | Legal (`char *` may alias anything) but check intent |
| `(float *)&some_int` | Bad — strict aliasing violation |
| `(int *)const_ptr` then write | Bad — undefined behavior |
| `(int)pointer` | Bad — use `uintptr_t` |

**Key Takeaways**

- A cast documents an intentional conversion; it never makes an invalid operation valid.
- Cast *before* the operation for float division: `(double)a / b`, not `(double)(a / b)`.
- Reinterpret bit patterns with `memcpy` or a union, never by casting between unrelated pointer types.
- Casting away `const` compiles but writing through the result is undefined behavior.
- Do not cast `malloc`'s return in C; use `uintptr_t` when a pointer must become an integer.

> 🧪 Practice
>
> 1. Compute an average of two `int` values as a `double` in three ways — no cast, cast after the division, cast before — and explain all three results.
> 2. Extract the sign, exponent, and mantissa bits of a `float` using `memcpy` into a `uint32_t`. Verify against a known value.
> 3. Cast away `const` on a `const` global and attempt a write. Compile at `-O0` and `-O2`; describe what happens in each case.
> 4. Interview-style: *"Why is `(float *)&my_int` undefined behavior when `(char *)&my_int` is not?"* Hint: look up which types are allowed to alias any object.

#### Integer Overflow and Wraparound

**Theory**

An integer type holds a finite range. Exceeding it is **overflow**, and C treats the two signedness classes completely differently:

| | Signed overflow | Unsigned overflow |
| --- | --- | --- |
| Standard says | **Undefined behavior** | Wraps modulo `2^N` |
| Practical result | Anything — including deleted code | Predictable wraparound |
| Can you check afterward? | No, the check itself is UB | Yes |

Unsigned wraparound is a defined, useful feature: hash functions, checksums, and circular buffers rely on it.

Signed overflow being undefined is not an oversight — it lets the optimizer assume `x + 1 > x` and that loop counters do not wrap, which enables real optimizations. The cost is that overflow-check code written the obvious way gets deleted:

```c
int check(int a, int b) {
    int sum = a + b;         /* if this overflows, the program has NO meaning */
    if (sum < a) return -1;  /* optimizer: "cannot happen" -> may delete this */
    return sum;
}
```

The correct approach is to check **before** overflowing:

```c
if (a > INT_MAX - b) return -1;   /* no overflow occurs in this test */
int sum = a + b;
```

Or use the compiler builtins, which are the practical modern answer:

```c
int sum;
if (__builtin_add_overflow(a, b, &sum)) { /* handle overflow */ }
```

GCC and Clang both provide `__builtin_add_overflow`, `__builtin_sub_overflow`, and `__builtin_mul_overflow`. C23 adds standard equivalents in `<stdckdint.h>` (`ckd_add`, `ckd_sub`, `ckd_mul`).

Three specific traps worth memorizing:

- `INT_MIN / -1` and `INT_MIN % -1` overflow (the magnitude exceeds `INT_MAX`) — undefined, and typically SIGFPE.
- `-INT_MIN` overflows for the same reason.
- `abs(INT_MIN)` is undefined.

Detect overflow at runtime during development with `-fsanitize=signed-integer-overflow` (part of `-fsanitize=undefined`).

**Examples**

```c
#include <stdio.h>
#include <limits.h>
#include <stdbool.h>

/* WRONG: the overflow happens before the check, so the check is meaningless. */
bool bad_would_overflow(int a, int b)
{
    int sum = a + b;      /* UB right here if it overflows */
    return sum < a;       /* optimizer may assume this is false */
}

/* RIGHT: test the operands without ever overflowing. */
bool safe_add(int a, int b, int *out)
{
    if (b > 0 && a > INT_MAX - b) return false;   /* would overflow high */
    if (b < 0 && a < INT_MIN - b) return false;   /* would overflow low  */
    *out = a + b;
    return true;
}

bool safe_mul(int a, int b, int *out)
{
    if (a > 0 && b > 0 && a > INT_MAX / b) return false;
    if (a > 0 && b < 0 && b < INT_MIN / a) return false;
    if (a < 0 && b > 0 && a < INT_MIN / b) return false;
    if (a < 0 && b < 0 && a < INT_MAX / b) return false;
    *out = a * b;
    return true;
}

int main(void)
{
    /* Unsigned wraparound is DEFINED and predictable. */
    unsigned int u = UINT_MAX;
    printf("UINT_MAX + 1 = %u  (defined: wraps to 0)\n", u + 1);
    unsigned char b = 250;
    b += 10;
    printf("250 + 10 as unsigned char = %u  (wraps to 4)\n", b);

    /* Signed overflow is UNDEFINED -- do not rely on the output below. */
    printf("\nINT_MAX = %d\n", INT_MAX);
    /* int overflowed = INT_MAX + 1;   UB: may print INT_MIN, may not */

    /* Safe arithmetic */
    int result;
    printf("\nsafe_add(INT_MAX, 1)  = %s\n",
           safe_add(INT_MAX, 1, &result) ? "ok" : "OVERFLOW detected");
    printf("safe_add(100, 200)    = %s (%d)\n",
           safe_add(100, 200, &result) ? "ok" : "overflow", result);
    printf("safe_mul(100000, 100000) = %s\n",
           safe_mul(100000, 100000, &result) ? "ok" : "OVERFLOW detected");

    /* Compiler builtins: the practical modern approach. */
#if defined(__GNUC__) || defined(__clang__)
    int sum;
    if (__builtin_add_overflow(INT_MAX, 1, &sum))
        printf("\nbuiltin: overflow detected\n");
#endif

    /* The INT_MIN traps */
    printf("\nINT_MIN = %d\n", INT_MIN);
    /* printf("%d\n", INT_MIN / -1);   UB: magnitude exceeds INT_MAX */
    /* printf("%d\n", -INT_MIN);       UB: same reason */
    (void)bad_would_overflow(1, 1);
    return 0;
}
```

Wraparound visualized:

```text
   8-bit unsigned:               8-bit signed:

        255 -> 0                     127 -> -128
     +----------+                  +------------+
     |          |                  |            |
   254        1                  126          -127
     |          |                  |            |
     +---- 0 ---+                  +---- 0 -----+

   DEFINED: modulo 256           UNDEFINED BEHAVIOR
   (the arrow really happens)    (the arrow is what hardware
                                  does; the language says nothing)
```

**Key Takeaways**

- Unsigned overflow wraps modulo `2^N` and is fully defined; signed overflow is undefined behavior.
- Post-hoc overflow checks on signed arithmetic are themselves undefined and may be optimized away.
- Check before the operation (`a > INT_MAX - b`) or use `__builtin_*_overflow` / C23 `<stdckdint.h>`.
- `INT_MIN / -1`, `-INT_MIN`, and `abs(INT_MIN)` all overflow and are undefined.
- Build with `-fsanitize=undefined` during development to catch signed overflow at runtime.

> 🧪 Practice
>
> 1. Write a program that wraps an `unsigned char` past 255 and an `unsigned int` past `UINT_MAX`. Confirm both behave modulo `2^N`.
> 2. Implement `safe_sub` and `safe_div` in the style of `safe_add`, remembering the `INT_MIN / -1` case.
> 3. Compile a signed-overflow program at `-O0`, `-O2`, and with `-fsanitize=undefined`. Compare all three outputs.
> 4. Interview-style: *"Why can't you detect signed overflow by checking whether the result is smaller than the operand?"* Hint: the check runs after the program has already lost all defined meaning.

#### Floating-Point Representation (IEEE 754)

**Theory**

A floating-point number is stored as three fields — sign, exponent, and significand (mantissa) — encoding the value:

```text
value = (-1)^sign  x  1.mantissa  x  2^(exponent - bias)
```

This is binary scientific notation. The leading `1.` is implicit for normal numbers (you get one bit free), and the exponent is stored biased so it can represent negatives without a sign of its own.

The two formats you will use:

```text
binary32 (float), 32 bits:
 +-+--------+-----------------------+
 |S| Exp(8) |   Mantissa (23)       |     bias = 127
 +-+--------+-----------------------+
 31 30    23 22                    0
 -> 24 bits of precision (23 stored + 1 implicit) ~ 7 decimal digits

binary64 (double), 64 bits:
 +-+-----------+-------------------------------------------+
 |S| Exp (11)  |          Mantissa (52)                    |  bias = 1023
 +-+-----------+-------------------------------------------+
 63 62       52 51                                        0
 -> 53 bits of precision ~ 15-17 decimal digits
```

Worked example, the value 1.5 as a `float`:

```text
   1.5 decimal = 1.1 binary = 1.1 x 2^0
   sign     = 0
   exponent = 0 + 127 = 127 = 0111 1111
   mantissa = 1000...0  (the fraction after the implicit "1.")

   0 01111111 10000000000000000000000  = 0x3FC00000
```

Special exponent values encode the cases IEEE 754 defines:

| Exponent | Mantissa | Meaning |
| --- | --- | --- |
| All zeros | Zero | ±0 (yes, there are two zeros) |
| All zeros | Nonzero | Subnormal (gradual underflow) |
| All ones | Zero | ±Infinity |
| All ones | Nonzero | NaN (Not a Number) |

The consequence that drives every floating-point bug: **only fractions whose denominator is a power of two are exact.** `0.5`, `0.25`, `0.125` are exact. `0.1`, `0.2`, `0.3` are not — they are repeating fractions in binary, just as `1/3` repeats in decimal. `0.1` stored as a `double` is actually `0.1000000000000000055511151231257827…`.

NaN has two properties worth memorizing: it propagates through every arithmetic operation, and it compares **unequal to everything, including itself**. `x != x` is a valid (if obscure) NaN test; prefer `isnan(x)`.

**Examples**

```c
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <math.h>
#include <float.h>

/* Show the raw bit fields of a float. */
static void dump_float(const char *label, float f)
{
    uint32_t b;
    memcpy(&b, &f, sizeof b);              /* well-defined bit reinterpretation */
    uint32_t sign = b >> 31;
    uint32_t exp  = (b >> 23) & 0xFFu;
    uint32_t mant = b & 0x7FFFFFu;
    printf("%-10s %-12g  0x%08X  S=%u E=%3u (2^%d) M=0x%06X\n",
           label, (double)f, b, sign, exp, (int)exp - 127, mant);
}

int main(void)
{
    puts("label      value         bits        fields");
    dump_float("1.0f",  1.0f);
    dump_float("1.5f",  1.5f);
    dump_float("2.0f",  2.0f);
    dump_float("-1.5f", -1.5f);
    dump_float("0.1f",  0.1f);            /* not exact */
    dump_float("0.0f",  0.0f);
    dump_float("-0.0f", -0.0f);           /* distinct bit pattern from +0.0 */
    dump_float("inf",   INFINITY);
    dump_float("nan",   NAN);

    /* Exact vs inexact fractions */
    printf("\n0.5   = %.20f\n", 0.5);      /* exact: 2^-1 */
    printf("0.25  = %.20f\n", 0.25);       /* exact: 2^-2 */
    printf("0.1   = %.20f\n", 0.1);        /* NOT exact */
    printf("0.3   = %.20f\n", 0.3);        /* NOT exact */

    /* Zeros compare equal but have different bits. */
    printf("\n(0.0 == -0.0) = %d\n", 0.0 == -0.0);          /* 1 */
    printf("1.0/0.0  = %g\n", 1.0 / 0.0);                   /* inf  */
    printf("1.0/-0.0 = %g\n", 1.0 / -0.0);                  /* -inf */

    /* NaN behavior */
    double nan_v = NAN;
    printf("\nnan == nan = %d  (always false)\n", nan_v == nan_v);
    printf("nan != nan = %d  (always true)\n", nan_v != nan_v);
    printf("isnan(nan) = %d\n", isnan(nan_v));
    printf("nan + 1    = %g  (propagates)\n", nan_v + 1);

    /* Machine epsilon: the gap between 1.0 and the next representable value. */
    printf("\nDBL_EPSILON = %g\n", DBL_EPSILON);
    printf("1.0 + DBL_EPSILON/2 == 1.0 ? %d\n", 1.0 + DBL_EPSILON/2 == 1.0);
    return 0;
}
```

**Key Takeaways**

- IEEE 754 stores sign, biased exponent, and mantissa; `float` gives ~7 decimal digits, `double` ~15–17.
- Only fractions with power-of-two denominators are exact; 0.1, 0.2, and 0.3 are all approximations.
- Special encodings give ±0, ±infinity, subnormals, and NaN.
- NaN compares unequal to everything including itself; test with `isnan`, not `==`.
- `DBL_EPSILON` is the gap between 1.0 and the next `double` — the basis for relative-tolerance comparisons.

> 🧪 Practice
>
> 1. Use the `dump_float` function to print the bit fields of 3.0, 0.75, and 100.0, and hand-verify one of them against the formula.
> 2. Find the largest integer `n` such that every integer up to `n` is exactly representable as a `float`. Verify by round-tripping.
> 3. Show that `0.1f + 0.2f != 0.3f` and that `0.5f + 0.25f == 0.75f`. Explain why one holds and the other does not.
> 4. Interview-style: *"How many distinct values can a 32-bit `float` represent between 1.0 and 2.0?"* Hint: the exponent is fixed across that interval — count what the mantissa can do.

#### Precision Loss and Comparison Pitfalls

**Theory**

Every floating-point operation rounds its result to the nearest representable value. Individually the error is tiny (at most half an ULP, "unit in the last place"), but errors **accumulate**, and in specific situations they explode.

**Failure mode 1: Equality comparison.** Because computed values carry rounding error, `==` on floating-point results is essentially always wrong:

```c
if (0.1 + 0.2 == 0.3)         /* false */
```

The fix is a tolerance — but the choice of tolerance matters:

- **Absolute epsilon** (`fabs(a-b) < 1e-9`) works only when the magnitudes are near 1. For values around 1e9, 1e-9 is smaller than the gap between adjacent doubles, so it degenerates into `==`.
- **Relative epsilon** (`fabs(a-b) <= eps * fmax(fabs(a), fabs(b))`) scales with magnitude and is correct across ranges — except near zero, where relative comparison breaks down.
- **Combined**: use absolute near zero and relative elsewhere. This is what production code does.

**Failure mode 2: Accumulation.** Summing many small values in a loop lets rounding error compound. Summing 0.1 ten million times drifts visibly from 1,000,000. Fixes include summing in sorted order (small to large), pairwise summation, or **Kahan summation**, which tracks the lost low-order bits in a compensation variable.

**Failure mode 3: Catastrophic cancellation.** Subtracting two nearly equal numbers destroys significant digits. If `a` and `b` agree to 15 digits, `a - b` retains almost no correct digits — the error that was in the last place is now the whole value. The standard example is the quadratic formula when `b^2` is much larger than `4ac`; the fix is algebraic rearrangement, not more precision.

**Failure mode 4: Loop counters.** `for (double x = 0.0; x != 1.0; x += 0.1)` never terminates, because the accumulated `x` never exactly equals 1.0. Always use an integer loop counter and compute the float from it.

**Examples**

```c
#include <stdio.h>
#include <math.h>
#include <float.h>
#include <stdbool.h>
#include <stddef.h>

/* Combined absolute/relative comparison -- the practical general solution. */
bool nearly_equal(double a, double b, double rel_eps, double abs_eps)
{
    if (a == b) return true;                       /* handles infinities */
    double diff = fabs(a - b);
    if (diff <= abs_eps) return true;              /* near zero: absolute */
    return diff <= rel_eps * fmax(fabs(a), fabs(b));  /* elsewhere: relative */
}

/* Kahan summation: track and reinject the rounding error. */
double kahan_sum(const double *v, size_t n)
{
    double sum = 0.0, comp = 0.0;                  /* comp = running lost bits */
    for (size_t i = 0; i < n; i++) {
        double y = v[i] - comp;                    /* add back what was lost */
        double t = sum + y;                        /* this rounds ... */
        comp = (t - sum) - y;                      /* ... and this captures it */
        sum = t;
    }
    return sum;
}

int main(void)
{
    /* PITFALL 1: equality */
    printf("0.1 + 0.2 == 0.3        : %d\n", 0.1 + 0.2 == 0.3);
    printf("nearly_equal(...)       : %d\n",
           nearly_equal(0.1 + 0.2, 0.3, 1e-9, 1e-12));

    /* Absolute epsilon fails at large magnitudes. */
    double big1 = 1e9, big2 = 1e9 + 1.0;
    printf("\nabsolute 1e-9 on 1e9    : %d (too strict)\n",
           fabs(big1 - big2) < 1e-9);
    printf("relative 1e-9 on 1e9    : %d\n",
           nearly_equal(big1, big2, 1e-9, 1e-12));

    /* PITFALL 2: accumulation */
    static double vals[1000000];
    double naive = 0.0;
    for (int i = 0; i < 1000000; i++) vals[i] = 0.1;
    for (int i = 0; i < 1000000; i++) naive += 0.1;
    printf("\nnaive sum of 1e6 x 0.1  : %.10f\n", naive);
    printf("kahan sum               : %.10f\n", kahan_sum(vals, 1000000));
    printf("exact                   : 100000.0000000000\n");

    /* PITFALL 3: catastrophic cancellation */
    double a = 1.0000000000000002, b = 1.0000000000000000;
    printf("\na - b = %.20g  (only ~1 significant digit survives)\n", a - b);

    /* PITFALL 4: float loop counters */
    puts("\nBAD:  for (double x = 0.0; x != 1.0; x += 0.1) would never end.");
    int steps = 0;
    for (double x = 0.0; x < 1.0 && steps < 100; x += 0.1) steps++;
    printf("x < 1.0 with += 0.1 ran %d times (expected 10)\n", steps);

    puts("GOOD: drive the loop with an integer.");
    for (int i = 0; i < 10; i++) {
        double x = i * 0.1;                        /* recomputed, not accumulated */
        (void)x;
    }
    printf("integer-driven loop ran exactly 10 times\n");
    return 0;
}
```

Choosing a comparison strategy:

| Situation | Approach |
| --- | --- |
| Values near 1 | Absolute epsilon (`1e-9`) is acceptable |
| Values spanning many magnitudes | Relative epsilon |
| Values possibly near zero | Absolute epsilon, or the combined form |
| Comparing to exact zero | `fabs(x) < abs_eps` |
| Money | Do not use floating point — use integer cents |
| Loop counters | Use an integer and compute the float |

**Key Takeaways**

- Never compare computed floating-point values with `==`; use a tolerance suited to the magnitudes involved.
- Absolute epsilon works only near 1; use relative epsilon for large values and a combined test in general code.
- Rounding errors accumulate over long summations — use Kahan summation or sort before summing when accuracy matters.
- Subtracting nearly equal values destroys precision (catastrophic cancellation); fix it algebraically, not with more bits.
- Drive loops with integer counters and compute floating values from them, never by repeated accumulation.

> 🧪 Practice
>
> 1. Sum `0.1` one million times naively and with Kahan summation; report both errors against the exact value.
> 2. Write `nearly_equal` and test it on pairs at magnitudes 1e-10, 1, and 1e10. Show where a fixed absolute epsilon fails.
> 3. Write the loop `for (double x = 0.0; x != 1.0; x += 0.1)` with an iteration cap, and print `x` each step to see why it never hits 1.0 exactly.
> 4. Interview-style: *"Why do financial systems store amounts as integer cents rather than as `double` dollars?"* Hint: think about what `0.10` is in binary, and what happens after a million transactions.

---

## 3. Control Flow

Control flow is how a program decides what to do next: which statements run, how many times, and in what order. C offers a compact set of constructs — two selection forms, three loop forms, and four jumps — that map almost directly onto the conditional branches and jumps a CPU actually executes. This chapter covers each one precisely, including the traps (dangling `else`, `switch` fallthrough, `continue` in a `while` loop) that turn small syntactic slips into silent logic bugs.

<a id="31-selection"></a>
### 3.1 Selection

Selection means choosing between alternative paths based on a value. C gives you two constructs — `if` for arbitrary conditions and `switch` for dispatching on a single integer — and knowing when each is the right tool matters more than the syntax.

#### if and else

**Theory**

Every program needs to make decisions, and `if` is the primitive that expresses one. Its form is:

```c
if (expression)
    statement;
else
    statement;
```

The crucial thing to understand is what "true" means here. C has no requirement that the condition be a boolean. **The expression is evaluated, and the branch is taken if the result compares unequal to zero.** That is the entire rule. The condition may be an `int`, a `double`, a pointer, or a character — anything with a scalar type.

```c
if (5)          /* true: 5 != 0 */
if (0)          /* false */
if (-1)         /* true: -1 != 0 */
if (0.0)        /* false */
if (ptr)        /* true if ptr is not a null pointer */
if ('a')        /* true: 'a' is 97 */
```

This flexibility is why the idiomatic C null check is `if (p)` rather than `if (p != NULL)`, and why `if (n)` reads as "if n is nonzero."

Three structural rules follow from the grammar, and each is a bug source:

**1. `if` takes exactly one statement.** To run several, you need a block. Without braces only the first statement is conditional, and indentation lies to you:

```c
if (x > 0)
    printf("positive\n");
    printf("and nonzero\n");   /* ALWAYS runs -- not part of the if */
```

**2. The `else` binds to the nearest unmatched `if`.** This is the "dangling else" problem:

```c
if (a)
    if (b)
        f();
else            /* binds to 'if (b)', NOT 'if (a)', despite the indentation */
    g();
```

**3. A stray semicolon creates an empty body.**

```c
if (x > 0);              /* the null statement IS the body */
    printf("positive\n"); /* runs unconditionally */
```

All three disappear if you always use braces. That is why essentially every C style guide mandates them.

One more trap deserves separate mention: because assignment is an expression (Chapter 2.3), `if (x = 5)` is legal — it assigns 5 and tests the result, which is always true. Compilers warn under `-Wall`; some codebases still write `if (5 == x)` ("Yoda conditions") to make the mistake a syntax error.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int n = 7;

    /* Braces make the body unambiguous, even for one statement. */
    if (n > 0) {
        printf("%d is positive\n", n);
    } else {
        printf("%d is zero or negative\n", n);
    }

    /* Idiomatic truthiness: any nonzero scalar is true. */
    int *p = malloc(sizeof *p);
    if (p) {                       /* same as: if (p != NULL) */
        *p = 42;
        printf("allocated, *p = %d\n", *p);
        free(p);
    } else {
        fprintf(stderr, "allocation failed\n");
        return EXIT_FAILURE;
    }

    /* The dangling-else trap, written unambiguously. */
    int a = 1, b = 0;
    if (a) {
        if (b) {
            puts("a and b");
        } else {
            puts("a but not b");   /* clearly attached to 'if (b)' */
        }
    }

    /* Assignment vs comparison. */
    int x = 0;
    if (x = 5) {                   /* WARNING under -Wall: always true */
        printf("x is now %d\n", x);
    }
    x = 0;
    if (x == 5) puts("never");
    else        puts("x is not 5");

    /* if without else: the common guard-clause shape. */
    if (n % 2 != 0) {
        printf("%d is odd\n", n);
    }
    return 0;
}
```

Control-flow shape:

```text
            +-----------------+
            |  evaluate cond  |
            +-----------------+
               |           |
        != 0   |           |  == 0
               v           v
        +-----------+   +-----------+
        | then-body |   | else-body |   (else is optional)
        +-----------+   +-----------+
               |           |
               +-----+-----+
                     v
              continue after
```

**Key Takeaways**

- The condition is any scalar expression; the branch is taken when it compares unequal to zero.
- `if` governs exactly one statement — use braces to attach more, and use them always.
- `else` binds to the nearest unmatched `if`, regardless of indentation.
- A stray `;` after `if (...)` silently makes the body empty.
- `if (x = 5)` assigns rather than compares; `-Wall` warns, and extra parentheses `if ((x = f()))` mark a deliberate assignment.

> 🧪 Practice
>
> 1. Write the brace-less `if` bug above, confirm both lines execute, then fix it. Repeat with the stray-semicolon version.
> 2. Write a function `const char *sign(int n)` returning `"negative"`, `"zero"`, or `"positive"` using `if`/`else`.
> 3. Construct a dangling-`else` example where the indentation suggests one binding and the compiler chooses the other. Verify with a test value, then disambiguate with braces.
> 4. Interview-style: *"Is `if (0.1 + 0.2 - 0.3)` true or false?"* Hint: the condition is not a comparison — ask what value the expression actually has (see Chapter 2.4).

#### Nested and Chained Conditions

**Theory**

Real decisions rarely have two outcomes. C gives you two ways to express more, and they mean different things.

**Chaining** (`else if`) selects **one** branch from several mutually exclusive alternatives. It is not a separate construct — it is an `if` statement appearing as the `else` body, which the grammar allows because an `if` is itself a statement:

```c
if (a)      { ... }
else if (b) { ... }     /* really: else { if (b) { ... } else { ... } } */
else        { ... }
```

Conditions are tested top to bottom, and evaluation stops at the first match. Two consequences follow: **order matters**, and later conditions may assume earlier ones were false. A classic bug is writing overlapping ranges in the wrong order:

```c
if (score >= 60) return 'D';        /* catches 95 too -- everything below is dead */
else if (score >= 90) return 'A';   /* unreachable */
```

**Nesting** expresses conjunction — conditions that must *all* hold, often where the inner test is only meaningful when the outer one passed:

```c
if (file != NULL) {
    if (file->size > 0) { ... }     /* only valid once file is known non-NULL */
}
```

When the inner condition has no such dependency, `&&` is usually clearer than nesting, and short-circuit evaluation (Chapter 2.3) makes the dependent case safe too:

```c
if (file != NULL && file->size > 0) { ... }   /* equivalent and flatter */
```

Deep nesting is the main readability hazard. The standard remedy is the **guard clause**: handle the failure cases first and return early, so the successful path stays at one indentation level.

```c
/* Nested "arrow" shape                Guard-clause shape          */
if (a) {                               if (!a) return ERR_A;
    if (b) {                           if (!b) return ERR_B;
        if (c) {                       if (!c) return ERR_C;
            do_work();                 do_work();
        }
    }
}
```

Finally, when many branches test *the same variable* against constants, an `else if` ladder is the wrong tool — that is what `switch` is for.

**Examples**

```c
#include <stdio.h>

/* Chained conditions: ordered so each range is reachable. */
char grade(int score)
{
    if      (score >= 90) return 'A';
    else if (score >= 80) return 'B';   /* implies score < 90 */
    else if (score >= 70) return 'C';
    else if (score >= 60) return 'D';
    else                  return 'F';
}

typedef struct { const char *name; long size; } File;

/* Guard clauses: failures exit early, the happy path stays flat. */
int process(const File *f, int max_size)
{
    if (f == NULL)        return -1;    /* handle each failure and leave */
    if (f->name == NULL)  return -2;
    if (f->size <= 0)     return -3;
    if (f->size > max_size) return -4;

    printf("processing %s (%ld bytes)\n", f->name, f->size);
    return 0;                            /* only one indentation level */
}

int main(void)
{
    int scores[] = {95, 85, 72, 65, 30};
    for (int i = 0; i < 5; i++)
        printf("%3d -> %c\n", scores[i], grade(scores[i]));

    File good = { "data.bin", 1024 };
    File empty = { "empty.bin", 0 };
    printf("\nprocess(good)  = %d\n", process(&good, 4096));
    printf("process(empty) = %d\n", process(&empty, 4096));
    printf("process(NULL)  = %d\n", process(NULL, 4096));

    /* Nesting vs && -- both safe, thanks to short-circuit evaluation. */
    const File *f = NULL;
    if (f != NULL && f->size > 0)        /* f->size never evaluated when f is NULL */
        puts("non-empty");
    else
        puts("null or empty");
    return 0;
}
```

Choosing between the forms:

| Situation | Use |
| --- | --- |
| Several mutually exclusive outcomes | `else if` chain |
| Conditions that must all hold, independent | `&&` in one `if` |
| Inner test only valid if outer passed | `&&` (short-circuits) or nesting |
| Many failure cases before real work | Guard clauses with early `return` |
| One variable compared to many constants | `switch` |

**Key Takeaways**

- `else if` is an `if` inside an `else`; branches are tested in order and the first match wins.
- Order overlapping range tests from most to least restrictive, or later branches become unreachable.
- `&&` with short-circuit evaluation replaces most two-level nesting and reads flatter.
- Guard clauses (validate and return early) keep the main logic at one indentation level.
- An `else if` ladder testing one variable against constants is better written as a `switch`.

> 🧪 Practice
>
> 1. Rewrite `grade` with the comparisons in ascending order and demonstrate the resulting bug with a score of 95.
> 2. Take a three-level nested `if` from your own code and convert it to guard clauses. Count the indentation levels before and after.
> 3. Write a function classifying a character as digit, uppercase, lowercase, whitespace, or other, using a chain. Then compare with the `ctype.h` functions.
> 4. Interview-style: *"When would you deliberately nest instead of using `&&`?"* Hint: think about needing a distinct `else` action for the outer condition alone.

#### switch, case, and default

**Theory**

When you compare one integer against many constants, an `else if` ladder does N comparisons in sequence. `switch` expresses the same intent but tells the compiler that all branches test the *same* value against *distinct constants*, which lets it generate a jump table — a single indexed jump — instead of a chain of comparisons.

```c
switch (expression) {
    case constant1:
        statements
        break;
    case constant2:
        statements
        break;
    default:
        statements
}
```

The restrictions are strict, and all follow from the jump-table model:

| Requirement | Detail |
| --- | --- |
| Controlling expression | Must have **integer type** (including `char` and `enum`) — never `float`, `double`, a string, or a struct |
| `case` labels | Must be **integer constant expressions**, known at compile time — no variables, no function calls |
| Duplicate labels | A compile error |
| Ranges | Not standard C (`case 1 ... 5:` is a GCC extension) |
| `default` | Optional; may appear anywhere, though convention puts it last |

Because you cannot switch on a string, comparing strings requires `strcmp` in an `if` chain, or mapping the string to an enum first.

Two subtleties are worth knowing.

**`case` labels are labels, not blocks.** A `switch` body is one statement (usually a compound statement) into which the labels are jump targets. That is why a `case` that declares a variable can be a problem: the declaration's scope is the whole `switch` body, but jumping to a later `case` skips its initialization.

```c
switch (n) {
    case 1:
        int x = 5;        /* C23 allows this; earlier standards need a label
                             followed by a statement, not a declaration */
        break;
    case 2:
        printf("%d", x);  /* x is in scope but UNINITIALIZED -- init was skipped */
}
```

The fix is to wrap the case body in its own braces, which is good practice whenever a case declares anything:

```c
case 1: {
    int x = 5;
    break;
}
```

**`default` catches everything unmatched**, and including it is usually right. The exception: when switching over an `enum` and handling every enumerator, omitting `default` lets `-Wswitch` warn you if a new enumerator is added later — a genuinely useful safety net.

**Examples**

```c
#include <stdio.h>
#include <string.h>

typedef enum { OP_ADD, OP_SUB, OP_MUL, OP_DIV } Op;

double apply(Op op, double a, double b)
{
    switch (op) {
        case OP_ADD: return a + b;      /* 'return' also leaves the switch */
        case OP_SUB: return a - b;
        case OP_MUL: return a * b;
        case OP_DIV: return b != 0 ? a / b : 0.0;
    }
    /* No default: -Wswitch warns if a new Op is added and not handled. */
    return 0.0;
}

const char *day_type(int day)
{
    switch (day) {
        case 0:
        case 6:
            return "weekend";           /* two labels, one body */
        case 1: case 2: case 3: case 4: case 5:
            return "weekday";
        default:
            return "invalid";           /* catches everything else */
    }
}

int main(void)
{
    printf("3 + 4 = %g\n", apply(OP_ADD, 3, 4));
    printf("3 * 4 = %g\n", apply(OP_MUL, 3, 4));

    for (int d = -1; d <= 7; d += 3)
        printf("day %d: %s\n", d, day_type(d));

    /* A case that declares a variable needs its own block. */
    int code = 2;
    switch (code) {
        case 1: {
            int retries = 3;            /* scoped to this block only */
            printf("retrying %d times\n", retries);
            break;
        }
        case 2: {
            char buf[16];
            snprintf(buf, sizeof buf, "code-%d", code);
            printf("%s\n", buf);
            break;
        }
        default:
            puts("unknown code");
    }

    /* You CANNOT switch on a string; use strcmp or map to an enum. */
    const char *cmd = "stop";
    if      (strcmp(cmd, "start") == 0) puts("starting");
    else if (strcmp(cmd, "stop")  == 0) puts("stopping");
    else                                puts("unknown command");
    return 0;
}
```

How the two forms compile, conceptually:

```text
  else-if ladder                  switch with dense labels

  cmp n, 1                        cmp n, 5
  je  case1                       ja  default          (bounds check)
  cmp n, 2                        jmp [table + n*8]    (one indexed jump)
  je  case2
  cmp n, 3                        table:
  je  case3                         .quad case0
  ...                               .quad case1
  (O(N) comparisons)                .quad case2  ...   (O(1) dispatch)
```

The compiler chooses: dense label sets become jump tables, sparse ones become comparison chains or binary searches. You do not control this, but the `switch` form is what makes the optimization possible.

**Key Takeaways**

- `switch` requires an integer controlling expression and compile-time integer constant `case` labels.
- Duplicate labels are an error; ranges are a GNU extension, not standard C; strings cannot be switched on.
- Multiple labels may share one body — the idiomatic way to group cases.
- Wrap a `case` body in braces whenever it declares a variable; otherwise a jump can skip the initialization.
- Omitting `default` in an exhaustive `enum` switch enables `-Wswitch` to warn when a new enumerator appears.

> 🧪 Practice
>
> 1. Write a `switch` that maps a single-character operator (`+ - * /`) to an operation, with a `default` for unknown input.
> 2. Try `switch` on a `double` and on a `char *`, and record the compiler errors for each.
> 3. Declare a variable directly after a `case` label without braces, then jump to a later case that uses it. Compile with `-Wall -Wextra` and explain the diagnostic.
> 4. Interview-style: *"When is a `switch` measurably faster than an `if`/`else` chain, and when is it not?"* Hint: think about how densely packed the case values are.

#### Fallthrough Behavior

**Theory**

A `case` label marks a jump target, not a self-contained branch. Once control jumps there, execution continues straight through subsequent labels until it hits a `break`, a `return`, a `goto`, or the closing brace. This is **fallthrough**, and it is C's most notorious default.

```c
switch (2) {
    case 1: puts("one");
    case 2: puts("two");     /* execution enters here ... */
    case 3: puts("three");   /* ... and keeps going */
    case 4: puts("four");
}
/* prints: two three four */
```

It is inherited from the language's origins: `switch` was designed as computed-goto machinery, and adding an implicit `break` would have made shared case bodies impossible. The cost is that a forgotten `break` produces a silent, plausible-looking bug.

There are two legitimate uses:

**1. Grouping labels with an empty body.** Stacked labels are not really fallthrough in the risky sense, and every reader recognizes the idiom:

```c
case 'a': case 'e': case 'i': case 'o': case 'u':
    vowels++;
    break;
```

**2. Deliberate cumulative processing**, where each case genuinely should do its own work and then everything below it. This is rare and must be commented.

Modern C gives you tools for the accidental case:

- `-Wimplicit-fallthrough` (in `-Wextra` on GCC) warns on any fallthrough with a non-empty case body.
- The warning is silenced by a recognized comment (`/* fallthrough */`), by GCC/Clang's `__attribute__((fallthrough))`, or — in **C23** — by the standard attribute `[[fallthrough]];`.

The rule to adopt: **every non-empty case ends with `break`, `return`, or an explicit fallthrough marker.** No exceptions, so a missing terminator is always a bug.

Note that `break` inside a `switch` exits the *switch*, not an enclosing loop. To leave a loop from inside a `switch` you need `goto`, a flag, or a `return`.

**Examples**

```c
#include <stdio.h>

/* Accidental fallthrough: the classic bug. */
void buggy(int n)
{
    switch (n) {
        case 1:
            puts("one");
            /* missing break -- falls into case 2 */
        case 2:
            puts("two");
            break;
        default:
            puts("other");
    }
}

/* Intentional, marked fallthrough. */
void permissions(int level)
{
    switch (level) {
        case 3:
            puts("+ admin");
            /* fallthrough */          /* recognized by -Wimplicit-fallthrough */
        case 2:
            puts("+ write");
            /* fallthrough */
        case 1:
            puts("+ read");
            break;
        default:
            puts("no access");
    }
}

/* Grouped labels: empty bodies, no warning, universally understood. */
int count_vowels(const char *s)
{
    int n = 0;
    for (; *s; s++) {
        switch (*s) {
            case 'a': case 'e': case 'i': case 'o': case 'u':
            case 'A': case 'E': case 'I': case 'O': case 'U':
                n++;
                break;
            default:
                break;                  /* explicit, even when empty */
        }
    }
    return n;
}

int main(void)
{
    puts("buggy(1):");       buggy(1);     /* prints "one" AND "two" */
    puts("\npermissions(3):"); permissions(3);
    puts("\npermissions(1):"); permissions(1);
    printf("\nvowels in \"Hello World\" = %d\n", count_vowels("Hello World"));
    return 0;
}
```

Execution trace for `buggy(1)`:

```text
   switch (n)  with n == 1
        |
        v
   case 1:  puts("one");     <- entry point
        |   (no break)
        v
   case 2:  puts("two");     <- FALLS THROUGH into this body
        |
      break                  <- finally exits
        |
        v
   after the switch
```

**Key Takeaways**

- Control falls through from one `case` into the next unless stopped by `break`, `return`, or `goto`.
- Stacked labels with empty bodies are the safe, idiomatic way to share one body among several values.
- Deliberate fallthrough must be marked: `/* fallthrough */`, `__attribute__((fallthrough))`, or C23's `[[fallthrough]];`.
- Enable `-Wimplicit-fallthrough` (in `-Wextra`) so an accidental omission becomes a diagnostic.
- `break` inside a `switch` exits only the `switch`; it does not break out of an enclosing loop.

> 🧪 Practice
>
> 1. Run `buggy(1)` and confirm it prints two lines. Add the missing `break` and re-run.
> 2. Compile a switch with an unmarked non-empty fallthrough using `-Wextra`, then silence it correctly with a `/* fallthrough */` comment and with `[[fallthrough]];` under `-std=c23`.
> 3. Write a `switch` inside a `while` loop where `break` is intended to exit the loop. Observe that it does not, then fix it with a flag and with `goto`.
> 4. Interview-style: *"Give a case where fallthrough is the clearest way to express the logic."* Hint: think about cumulative permission or privilege levels.

<a id="32-iteration"></a>
### 3.2 Iteration

Loops repeat work. C has three forms that are formally interchangeable, so the real skill is choosing the one whose shape matches the problem — and writing a termination condition that is provably correct.

#### while Loop

**Theory**

`while` is the simplest loop: test a condition, and if it is true, run the body and test again.

```c
while (expression)
    statement;
```

It is **entry-controlled**: the test happens *before* each iteration, including the first. If the condition is false initially, the body never runs at all. That property is what makes `while` the right choice when the number of iterations is unknown and possibly zero — reading until end of file, walking a linked list, waiting for a flag.

Compare the mental models:

- **`while`** — "keep going as long as this holds." Condition-driven.
- **`for`** — "do this a known number of times." Counter-driven.
- **`do-while`** — "do it, then decide whether to repeat." At-least-once.

Every `while` loop needs three things, and omitting the third is the classic beginner bug:

1. An initialization *before* the loop.
2. A condition that can eventually become false.
3. **Something inside the body that changes the condition.**

```c
int i = 0;
while (i < 10) {
    printf("%d\n", i);
    /* forgetting i++ here loops forever */
}
```

Two idioms are worth memorizing because you will read them constantly.

**Assignment inside the condition.** Because assignment is an expression, you can read and test in one step. The extra parentheses are required for correct precedence and also signal to the compiler (and reader) that the assignment is deliberate:

```c
int c;
while ((c = getchar()) != EOF) { ... }   /* read, assign, then compare */
```

Without the inner parentheses, `c = getchar() != EOF` would assign the comparison's 0-or-1 result to `c`.

**Pointer walking.**

```c
while (*s != '\0') s++;    /* or simply: while (*s) s++; */
```

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct Node { int value; struct Node *next; } Node;

int main(void)
{
    /* 1. Counting: works, but a for loop expresses this better. */
    int i = 0;
    while (i < 5) {
        printf("%d ", i);
        i++;                          /* MUST change the condition */
    }
    printf("\n");

    /* 2. Zero iterations: the condition is false on entry. */
    int n = 10;
    while (n < 5) {
        puts("never printed");
    }

    /* 3. Unknown count: walk a linked list until NULL. */
    Node c = {3, NULL}, b = {2, &c}, a = {1, &b};
    Node *p = &a;
    while (p != NULL) {               /* idiomatically: while (p) */
        printf("%d -> ", p->value);
        p = p->next;                  /* advance, or loop forever */
    }
    puts("NULL");

    /* 4. Assign-and-test: the canonical input idiom. */
    printf("\ncounting digits in \"a1b22c333\": ");
    const char *s = "a1b22c333";
    int digits = 0;
    char ch;
    while ((ch = *s++) != '\0') {     /* parentheses are required */
        if (ch >= '0' && ch <= '9') digits++;
    }
    printf("%d\n", digits);

    /* 5. Digit extraction: a loop whose count depends on the value. */
    int num = 9375, sum = 0;
    while (num > 0) {
        sum += num % 10;              /* take the last digit */
        num /= 10;                    /* drop it -- guarantees termination */
    }
    printf("digit sum of 9375 = %d\n", sum);
    return 0;
}
```

Execution order:

```text
      +--> evaluate condition
      |        |
      |    true|          false
      |        v            \
      |    +--------+        \
      |    |  body  |         +--> exit loop
      |    +--------+
      |        |
      +--------+

   Note: the condition is checked BEFORE the first iteration,
   so a body of zero executions is possible.
```

**Key Takeaways**

- `while` tests the condition before every iteration, so the body may run zero times.
- Prefer it when the iteration count is unknown or data-driven; prefer `for` when counting.
- The body must change something the condition depends on, or the loop never terminates.
- `while ((c = getchar()) != EOF)` needs the inner parentheses — assignment has lower precedence than `!=`.
- `while (p)` and `while (*s)` are idiomatic tests for non-null pointers and non-terminator characters.

> 🧪 Practice
>
> 1. Write a `while` loop that reverses the digits of an integer (1234 becomes 4321). Explain why it terminates.
> 2. Implement `size_t my_strlen(const char *s)` using a `while` loop and pointer walking, without indexing.
> 3. Write `while (c = getchar() != EOF)` (missing parentheses) and explain what `c` actually holds on each iteration.
> 4. Interview-style: *"Write a loop that counts the set bits in an unsigned integer."* Hint: `n &= n - 1` clears the lowest set bit — how many iterations does that take?

#### do-while Loop

**Theory**

`do-while` is the mirror image of `while`: the body runs first, and the condition is tested afterward.

```c
do
    statement;
while (expression);      /* note the mandatory semicolon */
```

It is **exit-controlled**, which gives it one defining property: **the body always executes at least once.** That is the entire reason it exists, and it makes the construct the right choice whenever the test depends on work the body must do first.

The canonical shapes:

- **Menus** — display options, read a choice, repeat if invalid. You must show the menu before you can validate anything.
- **Input validation** — prompt, read, re-prompt while the value is out of range.
- **Retry loops** — attempt an operation, retry while it failed and attempts remain.
- **Number processing** — printing the digits of `0` requires one pass even though `0 > 0` is false.

That last case is a good illustration of the difference:

```c
int n = 0;
while (n > 0)  { putchar('0' + n % 10); n /= 10; }   /* prints NOTHING */
do             { putchar('0' + n % 10); n /= 10; } while (n > 0);  /* prints "0" */
```

Two practical notes. The semicolon after the closing `while (...)` is **required** — the statement is not complete without it, and omitting it produces a confusing error at the next line. And `do-while` is the least-used of the three loops; when you find yourself reaching for it, check whether the at-least-once property is genuinely what you want, because reviewers will read `while` faster.

One more use has nothing to do with looping at all: `do { ... } while (0)` is the standard idiom for wrapping a multi-statement macro into a single statement. It is covered in Chapter 8.3, but the reason it works is here — the construct is one statement that runs its body exactly once and swallows a trailing semicolon cleanly.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    /* 1. The at-least-once property, demonstrated. */
    int n = 0;
    printf("while with n=0: ");
    while (n > 0) { printf("ran "); n--; }        /* body never runs */
    printf("(nothing)\n");

    n = 0;
    printf("do-while with n=0: ");
    do { printf("ran "); n--; } while (n > 0);    /* runs once */
    printf("\n");

    /* 2. Printing digits: 0 must still produce one character. */
    int value = 0;
    char buf[16];
    int  len = 0;
    do {
        buf[len++] = (char)('0' + value % 10);
        value /= 10;
    } while (value > 0);
    printf("\ndigits of 0: ");
    while (len > 0) putchar(buf[--len]);          /* reverse the buffer */
    putchar('\n');

    /* 3. Retry with a bounded attempt count. */
    int attempt = 0, success = 0;
    do {
        attempt++;
        success = (attempt == 3);                 /* pretend it works on try 3 */
        printf("attempt %d: %s\n", attempt, success ? "ok" : "failed");
    } while (!success && attempt < 5);

    /* 4. Input validation shape (input simulated so the example runs). */
    int inputs[] = {-1, 99, 7};                   /* stand-in for scanf */
    int idx = 0, choice;
    do {
        choice = inputs[idx++];
        printf("read %d\n", choice);
    } while ((choice < 1 || choice > 10) && idx < 3);
    printf("accepted: %d\n", choice);
    return 0;
}
```

Comparison of the two condition-tested loops:

```text
   while                          do-while

   +--> test                      +--> body
   |     | true                   |     |
   |     v                        |     v
   |   body                       |    test
   |     |                        |     | true
   +-----+                        +-----+
         | false                        | false
         v                              v
       exit                            exit

   0 or more iterations           1 or more iterations
```

| | `while` | `do-while` |
| --- | --- | --- |
| Test position | Before body | After body |
| Minimum iterations | 0 | 1 |
| Trailing semicolon | No | **Yes, required** |
| Typical use | Data-driven, may be empty | Menus, validation, retries |

**Key Takeaways**

- `do-while` runs the body before testing, guaranteeing at least one iteration.
- Use it when the condition depends on something the body must compute or read first.
- The closing `while (expression);` requires a semicolon.
- Prefer `while` unless the at-least-once property is genuinely needed — it is the more familiar shape.
- `do { ... } while (0)` is the standard multi-statement macro wrapper (see Chapter 8.3).

> 🧪 Practice
>
> 1. Write a number-guessing loop with a hard-coded sequence of guesses that keeps looping until the guess is correct, using `do-while`.
> 2. Convert an integer to a string manually with `do-while`, and confirm the input `0` produces `"0"`.
> 3. Omit the semicolon after `while (cond)` in a `do-while` and record the compiler error. Note that it points at the wrong line.
> 4. Interview-style: *"Rewrite any `do-while` as a `while` loop."* Hint: you will need to duplicate the body or introduce a flag — explain the trade-off.

#### for Loop

**Theory**

`for` packs the three parts of a counted loop — setup, test, and advance — into one header, so everything governing the iteration is visible in a single line.

```c
for (initialization; condition; increment)
    statement;
```

It is exactly equivalent to:

```c
initialization;
while (condition) {
    statement;
    increment;          /* with one exception, noted below */
}
```

The order of evaluation is:

```text
   1. initialization        (once, before anything else)
   2. condition   --false-->  exit
      |true
   3. body
   4. increment
      then back to step 2
```

**All three clauses are optional.** Omitting the condition means "always true," so `for (;;)` is the idiomatic infinite loop.

Since C99 you can **declare the loop variable in the initialization clause**, and its scope is the loop itself:

```c
for (int i = 0; i < n; i++) { ... }
/* i does not exist here */
```

This is strictly better than declaring `i` outside: it cannot collide with anything, it cannot be accidentally used after the loop, and the compiler has more freedom. Use it unless you need the final value afterward.

The comma operator (Chapter 2.3) lets a single clause do several things — this is its main legitimate use:

```c
for (int i = 0, j = n - 1; i < j; i++, j--) { ... }   /* walk from both ends */
```

Two points of care:

**The `while` equivalence breaks with `continue`.** In a `for` loop, `continue` jumps to the increment clause; in the hand-written `while` version, it jumps to the condition and skips the increment — producing an infinite loop. This is covered in 3.3.

**Do not modify the loop variable inside the body** unless that is the whole point of the loop. A `for` header is a contract with the reader about how the variable advances; breaking it inside the body is how off-by-one and skipped-element bugs appear.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    /* 1. The standard counted loop, with C99 scoped declaration. */
    for (int i = 0; i < 5; i++)
        printf("%d ", i);
    printf("\n");
    /* printf("%d", i);  ERROR: i is out of scope here */

    /* 2. Counting down. */
    for (int i = 5; i > 0; i--)
        printf("%d ", i);
    printf("\n");

    /* 3. Any step size. */
    for (int i = 0; i <= 20; i += 5)
        printf("%d ", i);
    printf("\n");

    /* 4. Two variables via the comma operator: reverse in place. */
    char s[] = "control flow";
    for (size_t i = 0, j = strlen(s) - 1; i < j; i++, j--) {
        char t = s[i]; s[i] = s[j]; s[j] = t;
    }
    printf("reversed: %s\n", s);

    /* 5. Iterating a pointer instead of an index. */
    int data[] = {10, 20, 30, 40};
    for (int *p = data; p < data + 4; p++)
        printf("%d ", *p);
    printf("\n");

    /* 6. Clauses are optional. */
    int k = 0;
    for (; k < 3; )        /* no init, no increment -- legal but unusual */
        k++;
    printf("k = %d\n", k);

    /* 7. Empty body: the work happens in the header. */
    const char *str = "measure me";
    size_t len;
    for (len = 0; str[len] != '\0'; len++)
        ;                  /* deliberate empty body, on its own line */
    printf("length = %zu\n", len);

    /* 8. Idiomatic array traversal with size_t. */
    size_t count = sizeof data / sizeof data[0];
    for (size_t i = 0; i < count; i++)
        printf("data[%zu]=%d ", i, data[i]);
    printf("\n");
    return 0;
}
```

When to choose which loop:

| Pattern | Best form |
| --- | --- |
| Known iteration count | `for` |
| Array or range traversal | `for` |
| Two indices moving together | `for` with comma operator |
| Condition-driven, may run zero times | `while` |
| Must run at least once | `do-while` |
| Intentionally infinite | `for (;;)` |

**Key Takeaways**

- `for` groups initialization, condition, and increment in one header; all three clauses are optional.
- Evaluation order is init once, then condition → body → increment, repeating.
- Declare the loop variable in the init clause (C99) to scope it to the loop.
- The comma operator allows multiple init and increment expressions — its principal legitimate use.
- `for` and `while` are equivalent *except* under `continue`, which still runs a `for` loop's increment clause.

> 🧪 Practice
>
> 1. Print a multiplication table for 1–5 using a `for` loop, then rewrite it as an equivalent `while` loop.
> 2. Write a loop that visits every second element of an array from the end toward the start.
> 3. Convert `for (int i = 0; i < n; i++) { if (i % 2) continue; work(i); }` into a `while` loop that behaves identically. Explain what you had to be careful about.
> 4. Interview-style: *"What is the scope and lifetime of `i` in `for (int i = 0; ...)`?"* Hint: consider whether an outer `i` with the same name is visible inside the body.

#### Nested Loops

**Theory**

A loop inside a loop is how you traverse two-dimensional structure: rows and columns of a matrix, every pair drawn from a set, or a search that scans a window at each position.

The mechanics are simple — for every single iteration of the outer loop, the inner loop runs to completion:

```text
outer i=0:  inner j=0,1,2
outer i=1:  inner j=0,1,2
outer i=2:  inner j=0,1,2
            total: 3 x 3 = 9 iterations
```

The cost multiplies. Two nested loops over *n* elements is O(n²); three is O(n³). At n = 1,000 that is a million and a billion operations respectively — the difference between instant and unusable. Whenever you write a triple nest, it is worth asking whether the algorithm is right.

Two practical concerns matter beyond the mechanics.

**Memory layout.** C arrays are stored **row-major**: `m[0][0]`, `m[0][1]`, `m[0][2]`, then `m[1][0]`, and so on. Iterating with the row index outermost walks memory sequentially and uses the cache well; swapping the loops strides across memory and can be several times slower on large matrices, even though both produce identical results.

```c
for (i...) for (j...) sum += m[i][j];   /* fast: sequential access */
for (j...) for (i...) sum += m[i][j];   /* slow: strided access */
```

**Exiting from the inside.** `break` leaves only the innermost loop. Escaping several levels at once requires one of three techniques:

| Technique | Notes |
| --- | --- |
| Flag variable | Portable, but adds a test to every level |
| `goto` past the loops | The clearest option in C; widely accepted for exactly this |
| Extract into a function and `return` | Usually the best refactor |

Finally, keep inner and outer loop variables distinct (`i`, `j`, `k` or meaningful names). Reusing the same name shadows the outer one and produces baffling behavior; `-Wshadow` catches it.

**Examples**

```c
#include <stdio.h>
#include <stdbool.h>

#define ROWS 3
#define COLS 4

/* Extracting the search into a function makes 'return' the exit mechanism. */
static bool find_value(int m[ROWS][COLS], int target, int *out_r, int *out_c)
{
    for (int r = 0; r < ROWS; r++)
        for (int c = 0; c < COLS; c++)
            if (m[r][c] == target) {
                *out_r = r; *out_c = c;
                return true;              /* leaves BOTH loops at once */
            }
    return false;
}

int main(void)
{
    int m[ROWS][COLS] = {
        { 1,  2,  3,  4},
        { 5,  6,  7,  8},
        { 9, 10, 11, 12}
    };

    /* 1. Row-major traversal: outer = row, inner = column. */
    for (int r = 0; r < ROWS; r++) {
        for (int c = 0; c < COLS; c++)
            printf("%3d", m[r][c]);
        putchar('\n');                    /* between rows, not columns */
    }

    /* 2. A triangular nest: inner bound depends on the outer variable. */
    puts("\nmultiplication triangle:");
    for (int i = 1; i <= 4; i++) {
        for (int j = 1; j <= i; j++)      /* j <= i, not a fixed bound */
            printf("%2d ", i * j);
        putchar('\n');
    }

    /* 3. Escaping nested loops with goto. */
    int target = 7;
    for (int r = 0; r < ROWS; r++) {
        for (int c = 0; c < COLS; c++) {
            if (m[r][c] == target) {
                printf("\nfound %d at (%d,%d)\n", target, r, c);
                goto done;                /* breaks out of both loops */
            }
        }
    }
    puts("\nnot found");
done:

    /* 4. The same search with a flag -- more code, more state. */
    bool found = false;
    int fr = -1, fc = -1;
    for (int r = 0; r < ROWS && !found; r++) {      /* extra test here ... */
        for (int c = 0; c < COLS; c++) {
            if (m[r][c] == 11) { found = true; fr = r; fc = c; break; }
        }
    }
    if (found) printf("flag search: 11 at (%d,%d)\n", fr, fc);

    /* 5. The cleanest version: a function that returns. */
    int r2, c2;
    if (find_value(m, 12, &r2, &c2))
        printf("function search: 12 at (%d,%d)\n", r2, c2);
    return 0;
}
```

Row-major memory layout:

```text
   int m[3][4] in memory (one contiguous block of 12 ints):

   +----+----+----+----+----+----+----+----+----+----+----+----+
   |m00 |m01 |m02 |m03 |m10 |m11 |m12 |m13 |m20 |m21 |m22 |m23 |
   +----+----+----+----+----+----+----+----+----+----+----+----+
     ^--------- row 0 -------^--------- row 1 -------^-- row 2 --^

   for r { for c { m[r][c] } }   walks left to right   -> cache-friendly
   for c { for r { m[r][c] } }   jumps by 4 ints each  -> cache-hostile
```

**Key Takeaways**

- The inner loop completes fully for each single iteration of the outer loop; total iterations multiply.
- Two nested loops over n items is O(n²) — check the algorithm before nesting three deep.
- C arrays are row-major; put the row index in the outer loop for sequential memory access.
- `break` exits only the innermost loop; use `goto`, a flag, or extraction into a function to leave several.
- Give each level a distinct loop variable and compile with `-Wshadow`.

> 🧪 Practice
>
> 1. Print a right-triangle pattern of asterisks with 5 rows, then invert it.
> 2. Write a function that transposes a square matrix in place. Determine which index range the inner loop needs to avoid swapping twice.
> 3. Time a 2000x2000 matrix sum with the loops in both orders and report the difference.
> 4. Interview-style: *"How do you break out of three nested loops?"* Hint: name three approaches and say which one you would defend in code review.

#### Infinite Loops and Termination Conditions

**Theory**

An infinite loop is one whose condition never becomes false. Sometimes that is exactly what you want; more often it is a bug. Telling the two apart, and reasoning about why a loop *must* stop, is a core skill.

**Deliberate infinite loops** are the normal structure for programs that run until told to stop:

- Server accept loops and GUI event loops.
- Embedded `main` functions — a microcontroller has no OS to return to.
- Interpreter read-eval-print loops.

Two spellings exist. `for (;;)` is the traditional C idiom: the condition clause is empty, which the standard defines as true, and it produces no warning. `while (1)` is equally common and clearer to some readers; older compilers occasionally warned about the constant condition, which is why `for (;;)` persists.

Such loops always contain an internal exit — a `break`, `return`, `exit()`, or `goto`.

**Accidental infinite loops** come from a handful of recurring mistakes:

| Cause | Example | Fix |
| --- | --- | --- |
| Missing update | `while (i < 10) printf(...);` | Increment inside the body |
| Wrong comparison | `for (i = 0; i != 10; i += 3)` — skips 10 | Use `<` rather than `!=` |
| Unsigned counting down | `for (unsigned i = n; i >= 0; i--)` | `i >= 0` is always true — use a signed type or `while (i-- > 0)` |
| Float accumulation | `for (double x = 0; x != 1.0; x += 0.1)` | Never hits 1.0 exactly — drive with an integer |
| Modifying the counter in the body | Body resets or decrements `i` | Keep the update in the header |
| Overflow | `for (int i = 1; i > 0; i *= 2)` | Signed overflow is UB; the "wrap" is not guaranteed |
| Stray semicolon | `while (cond);` | The body is the null statement |

The systematic defense is to state a **loop variant**: a quantity that strictly decreases (or increases) toward a bound on every iteration. In `while (n > 0) n /= 10;` the variant is `n`, which shrinks every pass, so termination is guaranteed. If you cannot name such a quantity, you cannot claim the loop terminates.

For loops whose termination depends on external conditions (network reads, retries, hardware polling), add a **bounded fallback** — a maximum iteration count or a timeout — so a stuck peer cannot hang the program.

**Examples**

```c
#include <stdio.h>
#include <limits.h>

int main(void)
{
    /* 1. Deliberate infinite loop with an internal exit. */
    int count = 0;
    for (;;) {                       /* idiomatic "loop forever" */
        count++;
        if (count >= 3) break;       /* the exit lives inside */
    }
    printf("for(;;) ran %d times\n", count);

    /* 2. while (1) is equivalent. */
    count = 0;
    while (1) {
        if (++count >= 3) break;
    }
    printf("while(1) ran %d times\n", count);

    /* 3. BUG: unsigned counter can never go below zero. */
    printf("\nunsigned countdown (bounded so it terminates):\n");
    unsigned u = 3;
    int guard = 0;
    while (u >= 0) {                 /* ALWAYS true -- u wraps to UINT_MAX */
        printf("  u = %u\n", u);
        u--;
        if (++guard > 5) { puts("  ...would run forever"); break; }
    }
    /* Correct forms: */
    printf("correct: ");
    for (unsigned k = 3; k-- > 0; )  /* test then decrement */
        printf("%u ", k);
    printf("\n");

    /* 4. BUG: != with a step that skips the target. */
    printf("\nfor (i = 0; i != 10; i += 3) would skip 10: ");
    for (int i = 0; i < 12; i += 3) printf("%d ", i);   /* use < instead */
    printf("\n");

    /* 5. Termination argument via a loop variant. */
    int n = 987654;
    int steps = 0;
    while (n > 0) {
        n /= 10;                     /* VARIANT: n strictly decreases */
        steps++;                     /* so the loop must end */
    }
    printf("\ndigits: %d\n", steps);

    /* 6. External condition with a bounded fallback. */
    int attempts = 0, connected = 0;
    while (!connected && attempts < 5) {      /* bound prevents hanging */
        attempts++;
        connected = (attempts == 4);          /* simulated */
    }
    printf("connected=%d after %d attempts\n", connected, attempts);
    return 0;
}
```

Checklist for any loop you write:

```text
   1. What is initialized before the loop?
   2. What must be true for the body to run?
   3. What changes each iteration?           <- the variant
   4. Does that change move toward the exit? <- termination argument
   5. Is there a bound if the data is hostile or the peer never responds?
```

**Key Takeaways**

- `for (;;)` and `while (1)` are the idiomatic deliberate infinite loops; both need an internal `break`, `return`, or `exit`.
- The most common accidental causes are a missing update, `!=` with a stepping counter, unsigned countdowns, and float accumulation.
- `unsigned i >= 0` is always true — a countdown with an unsigned counter never ends.
- Justify termination by naming a variant: a quantity that strictly moves toward the exit condition every iteration.
- Loops depending on external state should carry a maximum attempt count or timeout.

> 🧪 Practice
>
> 1. Write four loops that fail to terminate for four different reasons from the table, then fix each one.
> 2. Write a countdown from `n` to 0 using an `unsigned` counter, correctly. Give two working forms.
> 3. For a binary-search loop, state the variant that proves it terminates and give the maximum iteration count for n elements.
> 4. Interview-style: *"How would you make a retry loop robust against a server that never responds?"* Hint: consider an attempt cap and how the delay between attempts should change.

<a id="33-jumps"></a>
### 3.3 Jumps

Jump statements transfer control unconditionally. Three of them refine loops and functions in everyday code; the fourth, `goto`, carries a reputation that deserves a precise, unsentimental treatment.

#### break and continue

**Theory**

`break` and `continue` are loop refinements: they let you exit early or skip ahead without contorting the loop condition.

**`break` terminates the innermost enclosing loop or `switch` immediately.** Control resumes at the statement after it. This is what makes search loops natural — stop as soon as you find what you were looking for, instead of scanning the whole array and testing a flag afterward.

**`continue` skips the rest of the current iteration** and moves to the next one. It is the "filter" statement: reject uninteresting items at the top of the body so the real work is not buried inside an `if`.

The single most important detail is **where `continue` jumps to**, and it differs by loop type:

| Loop | `continue` jumps to |
| --- | --- |
| `for` | The **increment** clause, then the condition |
| `while` | The **condition** directly |
| `do-while` | The **condition** at the bottom |

That difference is a real bug generator. In a `for` loop the counter still advances; in a hand-written `while` equivalent it does not:

```c
int i = 0;
while (i < 10) {
    if (i % 2 == 0) continue;   /* i never increments -- INFINITE LOOP */
    printf("%d ", i);
    i++;
}
```

The `for` version of the same logic is safe, because the increment is in the header:

```c
for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) continue;   /* i++ still runs */
    printf("%d ", i);
}
```

Two further points. `break` inside a `switch` that sits inside a loop exits **the switch only** — a frequent surprise, covered in 3.1. And neither statement escapes more than one level; nested loops need `goto`, a flag, or a function boundary.

Used with restraint, both improve clarity. Overused — a loop body with five `continue`s and three `break`s — they scatter the exit logic and make the loop hard to reason about.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    int data[] = {4, 8, 15, 16, 23, 42};
    size_t n = sizeof data / sizeof data[0];

    /* 1. break: stop as soon as the target is found. */
    int target = 16, found_at = -1;
    for (size_t i = 0; i < n; i++) {
        if (data[i] == target) {
            found_at = (int)i;
            break;                       /* no reason to keep scanning */
        }
    }
    printf("found %d at index %d\n", target, found_at);

    /* 2. continue: filter, keeping the real work unindented. */
    printf("odd values: ");
    for (size_t i = 0; i < n; i++) {
        if (data[i] % 2 == 0) continue;  /* reject and move on */
        printf("%d ", data[i]);
    }
    printf("\n");

    /* 3. The while/continue trap, made safe with a guard. */
    printf("while + continue (bounded): ");
    int i = 0, guard = 0;
    while (i < 10) {
        if (i % 2 == 0) {
            i++;                          /* MUST advance before continuing */
            continue;
        }
        printf("%d ", i);
        i++;
        if (++guard > 20) break;
    }
    printf("\n");

    /* 4. break in a switch exits the switch, not the loop. */
    printf("switch inside loop: ");
    for (size_t k = 0; k < n; k++) {
        switch (data[k] % 3) {
            case 0:
                printf("[%d div3] ", data[k]);
                break;                    /* leaves the switch only */
            default:
                break;
        }
        /* loop continues here */
    }
    printf("\n");

    /* 5. Skipping empty tokens while parsing. */
    const char *fields[] = {"alpha", "", "beta", "", "gamma"};
    printf("non-empty fields: ");
    for (size_t f = 0; f < 5; f++) {
        if (fields[f][0] == '\0') continue;
        printf("%s ", fields[f]);
    }
    printf("\n");
    return 0;
}
```

Where each statement sends control:

```text
   for (init; COND; INCR) {
       ...
       continue;  ------> jumps to INCR, then COND
       ...
       break;     ------> jumps out, past the whole loop
       ...
   }
   <-- break lands here

   while (COND) {
       ...
       continue;  ------> jumps to COND  (INCR does not exist!)
       ...
   }
```

**Key Takeaways**

- `break` exits the innermost enclosing loop or `switch`; `continue` skips to the next iteration.
- In a `for` loop `continue` still runs the increment clause; in a `while` loop it does not — a classic infinite-loop cause.
- `break` inside a `switch` nested in a loop exits only the `switch`.
- Neither statement escapes more than one level of nesting.
- Use `continue` as an early filter to keep the main work at low indentation; avoid scattering many exits through one body.

> 🧪 Practice
>
> 1. Write a loop that sums an array but stops at the first negative value, using `break`. Then rewrite it with a flag and compare.
> 2. Write the `while` + `continue` infinite loop deliberately, confirm it hangs (with a guard or Ctrl-C), then fix it two different ways.
> 3. Write a loop over a string that counts letters, skipping digits and punctuation with `continue`.
> 4. Interview-style: *"What is the difference between `break` and `continue` inside a `switch` that is inside a `for` loop?"* Hint: one of them is not valid for the switch at all — which, and what does it act on?

#### goto and Labels

**Theory**

`goto` transfers control unconditionally to a labeled statement in the same function.

```c
    goto label;
    /* ... */
label:
    statement;
```

Labels have **function scope**: a label is visible throughout the function that contains it, so `goto` can jump into or out of blocks within that function — but never into another function. (Crossing function boundaries requires `setjmp`/`longjmp`, covered in Chapter 9.3.)

`goto` has a reputation, and the history is worth knowing: Dijkstra's 1968 letter "Go To Statement Considered Harmful" argued that unrestricted jumps make it impossible to reason about a program's state, because you cannot tell how control arrived at any given point. That argument is correct, and it is why the structured constructs exist.

But the blanket prohibition it inspired is too strong for C, because C lacks the alternatives that other languages provide. There are two situations where `goto` is the clearest available tool, and both are standard practice in professional C — the Linux kernel uses the first extensively.

**1. Cleanup on error paths.** A function that acquires several resources must release exactly the ones it acquired, in reverse order, from any failure point. Without `goto` you get either deep nesting or duplicated cleanup code:

```c
    if (!(a = acquire_a())) goto fail;
    if (!(b = acquire_b())) goto fail_a;
    if (!(c = acquire_c())) goto fail_b;
    /* success path */
    return 0;

fail_b: release_b(b);
fail_a: release_a(a);
fail:   return -1;
```

Each label releases what was acquired up to that point. Adding a fourth resource means adding one line and one label — the structure scales.

**2. Breaking out of nested loops**, as covered in 3.2, where `break` reaches only one level.

The discipline that makes `goto` safe:

- **Jump forward, never backward.** Backward jumps create loops that the loop constructs express better.
- **Stay within one function** and keep the jump distance short enough to see on one screen.
- **Use descriptive labels** (`cleanup`, `fail_unlock`, `done`), not `L1`.
- **Never jump into a block**, past a declaration with an initializer, or into the scope of a variable-length array — the last is a constraint violation, and the others leave objects uninitialized.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

/* The canonical error-cleanup ladder. */
int load_records(const char *path, int **out, size_t *count)
{
    FILE *f = NULL;
    int  *buf = NULL;
    int   rc = -1;                      /* pessimistic default */

    f = fopen(path, "r");
    if (f == NULL) goto fail;           /* nothing acquired yet */

    buf = malloc(128 * sizeof *buf);
    if (buf == NULL) goto fail_close;   /* the file IS open -- close it */

    for (size_t i = 0; i < 128; i++) {
        if (fscanf(f, "%d", &buf[i]) != 1) {
            if (i == 0) goto fail_free; /* both resources held */
            *count = i;
            break;
        }
        *count = i + 1;
    }

    *out = buf;                          /* success: ownership transfers out */
    fclose(f);
    return 0;

fail_free:                               /* release in REVERSE order */
    free(buf);
fail_close:
    fclose(f);
fail:
    return rc;
}

int main(void)
{
    /* Escaping nested loops -- goto is the clearest option in C. */
    int grid[4][4] = {
        {1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}
    };
    int want = 11;

    for (int r = 0; r < 4; r++) {
        for (int c = 0; c < 4; c++) {
            if (grid[r][c] == want) {
                printf("found %d at (%d,%d)\n", want, r, c);
                goto search_done;        /* leaves both loops */
            }
        }
    }
    printf("%d not found\n", want);
search_done:

    /* What NOT to do: a backward goto reimplementing a loop. */
    int i = 0;
loop_start:                              /* write 'while (i < 3)' instead */
    if (i < 3) {
        printf("i=%d ", i);
        i++;
        goto loop_start;
    }
    printf("\n");

    int *records = NULL;
    size_t n = 0;
    if (load_records("missing.txt", &records, &n) != 0)
        puts("load failed cleanly (no leak)");
    else
        free(records);
    return 0;
}
```

Why the ladder beats the alternatives:

```text
   Nested-if version              goto ladder

   if (a = acq_a()) {             if (!(a = acq_a())) goto fail;
     if (b = acq_b()) {           if (!(b = acq_b())) goto fail_a;
       if (c = acq_c()) {         if (!(c = acq_c())) goto fail_b;
         work();                  work();
         rel_c();                 rel_c(); rel_b(); rel_a();
       }                          return 0;
       rel_b();
     }                            fail_b: rel_b();
     rel_a();                     fail_a: rel_a();
   }                              fail:   return -1;

   depth grows with resources     flat; one line per resource
   cleanup duplicated per path    cleanup written exactly once
```

**Key Takeaways**

- `goto` jumps to a label within the same function; labels have function scope.
- Its two defensible uses in C are error-cleanup ladders and escaping nested loops.
- Always jump forward, keep the jump short and visible, and name labels for what they do.
- Release resources in reverse acquisition order, with one label per acquired resource.
- Never jump into a block, over an initialization, or into the scope of a variable-length array.

> 🧪 Practice
>
> 1. Write a function that opens two files and allocates a buffer, with a `goto` cleanup ladder handling failure at each of the three steps.
> 2. Rewrite that same function using nested `if` statements instead, and compare the line count and maximum indentation.
> 3. Attempt a `goto` that jumps forward past an initialized declaration and compile with `-Wall -Wextra`. Record the result.
> 4. Interview-style: *"Your team's style guide bans `goto` entirely. What do you propose for multi-resource cleanup?"* Hint: consider a single-exit function with a status variable, or splitting acquisition into a helper.

#### return

**Theory**

`return` ends the current function immediately and hands control back to the caller, optionally carrying a value.

```c
return;              /* only in a void function */
return expression;   /* value converted to the function's return type */
```

Two rules matter for correctness:

**The value is converted to the declared return type.** `return 3.7;` from a function declared `int` returns `3` — the truncation happens silently, exactly as in an assignment.

**Reaching the end of a non-`void` function without returning a value is undefined behavior** *if the caller uses the result*. The one exception is `main`, where falling off the end has meant `return 0;` since C99. Compile with `-Wreturn-type` (included in `-Wall`) to catch missing returns.

There is a long-running style debate between **single exit** (one `return` at the bottom, control reaching it via flags) and **multiple exits** (return as soon as the answer is known). Single exit came from languages without automatic cleanup, where one exit point meant one place to release resources. In modern C the multiple-exit style — guard clauses that validate and return early — usually produces flatter, more readable code. The exception is exactly the case `goto` addresses: when resources must be released, funnel failures to one cleanup block instead of duplicating `free`/`fclose` at every exit.

Two errors are worth calling out explicitly.

**Returning a pointer to a local variable.** The object's lifetime ends when the function returns, so the caller receives a dangling pointer:

```c
int *bad(void) {
    int x = 42;
    return &x;        /* x is gone the moment we return -- UB */
}
```

Valid alternatives: return by value, return a pointer to `malloc`'d memory (documenting who frees it), take a caller-provided output buffer, or return a pointer to a `static` object (with the thread-safety caveat that all callers share it).

**Returning a struct by value is fine.** Unlike arrays, structs are copied on return, so `return (Point){x, y};` is correct and idiomatic.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct { double x, y; } Point;

/* Multiple exits: answer as soon as it is known. */
int classify(int n)
{
    if (n < 0)  return -1;
    if (n == 0) return  0;
    return 1;
}

/* Guard clauses: validate, then do the work at one indentation level. */
int safe_divide(int a, int b, int *out)
{
    if (out == NULL) return -1;
    if (b == 0)      return -2;
    *out = a / b;
    return 0;
}

/* Returning a struct BY VALUE is correct -- it is copied. */
Point midpoint(Point p, Point q)
{
    return (Point){ (p.x + q.x) / 2, (p.y + q.y) / 2 };
}

/* BUG: the local dies when the function returns. */
/* int *dangling(void) { int x = 42; return &x; } */

/* Correct alternative 1: heap allocation, caller frees. */
int *make_array(size_t n)
{
    int *a = malloc(n * sizeof *a);      /* caller must free() this */
    if (a == NULL) return NULL;
    for (size_t i = 0; i < n; i++) a[i] = (int)i;
    return a;
}

/* Correct alternative 2: caller supplies the buffer. */
int fill_array(int *dst, size_t n)
{
    if (dst == NULL) return -1;
    for (size_t i = 0; i < n; i++) dst[i] = (int)(i * i);
    return 0;
}

/* void function: bare 'return' is an early exit. */
void report(const char *msg)
{
    if (msg == NULL) return;             /* no value after 'return' */
    printf("[report] %s\n", msg);
}

int main(void)
{
    printf("classify(-5)=%d classify(0)=%d classify(9)=%d\n",
           classify(-5), classify(0), classify(9));

    int q;
    printf("safe_divide(10,2) -> rc=%d q=%d\n", safe_divide(10, 2, &q), q);
    printf("safe_divide(10,0) -> rc=%d\n",      safe_divide(10, 0, &q));

    Point m = midpoint((Point){0,0}, (Point){4,6});
    printf("midpoint = (%g, %g)\n", m.x, m.y);

    int *heap = make_array(5);
    if (heap) {
        for (int i = 0; i < 5; i++) printf("%d ", heap[i]);
        printf("\n");
        free(heap);                      /* ownership was transferred to us */
    }

    int local[5];
    fill_array(local, 5);
    for (int i = 0; i < 5; i++) printf("%d ", local[i]);
    printf("\n");

    report(NULL);
    report("done");

    /* Implicit conversion on return. */
    printf("classify returns int; 3.7 would become %d\n", (int)3.7);
    return 0;                            /* main: 0 means success */
}
```

Ways to get data out of a function:

| Technique | Ownership / lifetime |
| --- | --- |
| Return by value (scalar or struct) | Copied — always safe |
| Return `malloc`'d pointer | Caller must `free`; document it |
| Caller-supplied output buffer | Caller owns the storage; pass its size too |
| Return pointer to `static` | Valid but shared by all callers; not thread-safe |
| Return pointer to a local | **Undefined behavior** — never do this |

**Key Takeaways**

- `return` exits the function immediately; the value is converted to the declared return type.
- Falling off the end of a non-`void` function is undefined behavior if the caller uses the result; `main` is the exception.
- Early returns (guard clauses) generally read better than a single exit reached through flags.
- When a function holds resources, funnel failures to one cleanup block rather than duplicating releases at each `return`.
- Never return the address of a local; return by value, allocate, use an output parameter, or use `static`.

> 🧪 Practice
>
> 1. Write a function with four validation checks in guard-clause style, then rewrite it with a single exit and a status variable. Compare readability.
> 2. Write `int *dangling(void)` returning the address of a local, call it, and print through the pointer. Then run it under `-fsanitize=address` and read the report.
> 3. Write the same "return an array" operation three ways: heap allocation, caller-supplied buffer, and a `static` array. State the ownership rule for each.
> 4. Interview-style: *"Is it safe to return a struct by value from a C function?"* Hint: contrast what happens with a struct against what happens with an array.

#### Structured vs Unstructured Control Flow

**Theory**

**Structured programming** is the discipline of building all control flow from three composable patterns:

1. **Sequence** — statements executed in order.
2. **Selection** — `if`, `switch`.
3. **Iteration** — `while`, `do-while`, `for`.

The Böhm–Jacopini theorem (1966) proved that these three suffice: any computable function can be expressed with them alone, without arbitrary jumps. The practical payoff is **single-entry, single-exit blocks**. When every construct is entered at the top and left at the bottom, you can reason about a block in isolation — you know what was true on entry, so you can determine what is true on exit. Unrestricted `goto` destroys that property, because control can arrive at a statement from anywhere.

**Unstructured** control flow means jumps that break this discipline: backward `goto`s forming ad-hoc loops, jumps into the middle of blocks, and multiple entry points.

C is a structured language with escape hatches. It provides all three structured constructs, plus `break`, `continue`, `return`, and `goto`, which are *disciplined* deviations — each has a well-defined target and does not permit arbitrary entry:

| Construct | Structured? | Assessment |
| --- | --- | --- |
| `if`, `switch`, loops | Yes | Always fine |
| `return` (early) | Mostly | Single-exit purists object; generally clearer |
| `break`, `continue` | Mostly | Fine in moderation; many per loop hurts |
| Forward `goto` (cleanup) | Deviation | Accepted C idiom for resource release |
| Backward `goto` | No | Almost always a loop written badly |
| `setjmp`/`longjmp` | No | Non-local jump; use sparingly, see Chapter 9.3 |

A useful measure is **cyclomatic complexity**: the number of linearly independent paths through a function, which equals the number of decision points plus one. Each `if`, `case`, loop, `&&`, and `||` adds one. Values above roughly 10–15 signal a function that is hard to test (you need at least that many test cases for path coverage) and usually one that should be split.

When control flow genuinely is complex — a protocol parser, a lexer — the answer is not more nesting but a different representation: an explicit **state machine** with a `switch` over states inside a loop. Each state's transitions are then local and readable, and adding a state does not deepen any nesting.

**Examples**

```c
#include <stdio.h>
#include <ctype.h>

/* Unstructured: control arrives at labels from several places.
   Hard to say what is true at any point. */
int messy_classify(const char *s)
{
    int i = 0, digits = 0, letters = 0;
top:
    if (s[i] == '\0') goto done;
    if (isdigit((unsigned char)s[i])) { digits++;  i++; goto top; }
    if (isalpha((unsigned char)s[i])) { letters++; i++; goto top; }
    i++;
    goto top;
done:
    return digits * 100 + letters;
}

/* Structured: the same logic as sequence + iteration + selection. */
int clean_classify(const char *s)
{
    int digits = 0, letters = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if      (isdigit((unsigned char)s[i])) digits++;
        else if (isalpha((unsigned char)s[i])) letters++;
    }
    return digits * 100 + letters;
}

/* Genuinely complex flow, expressed as an explicit state machine.
   Each state is local and self-contained; adding one adds no nesting. */
typedef enum { S_START, S_WORD, S_NUMBER, S_DONE } State;

void tokenize(const char *s)
{
    State st = S_START;
    int i = 0;

    while (st != S_DONE) {
        char c = s[i];
        switch (st) {
            case S_START:
                if      (c == '\0')                       st = S_DONE;
                else if (isalpha((unsigned char)c)) { printf("WORD("); st = S_WORD; }
                else if (isdigit((unsigned char)c)) { printf("NUM(");  st = S_NUMBER; }
                else                                 i++;   /* skip separator */
                break;

            case S_WORD:
                if (isalpha((unsigned char)c)) { putchar(c); i++; }
                else                           { printf(") "); st = S_START; }
                break;

            case S_NUMBER:
                if (isdigit((unsigned char)c)) { putchar(c); i++; }
                else                           { printf(") "); st = S_START; }
                break;

            case S_DONE:
                break;
        }
    }
    putchar('\n');
}

int main(void)
{
    const char *s = "abc123 x9";
    printf("messy = %d, clean = %d\n", messy_classify(s), clean_classify(s));
    tokenize("hello 42 world7");
    return 0;
}
```

State-machine shape:

```text
              +---------+  alpha   +--------+
      +-----> |  START  |--------> |  WORD  |--+
      |       +---------+          +--------+  | non-alpha
      |         |     | digit          ^       |
      |  other  |     +---------+      +-------+
      +---------+               |
                                v
                          +----------+
                          |  NUMBER  |--+
                          +----------+  | non-digit
                                ^       |
                                +-------+

   Every transition is one line in one 'case'. No nesting grows.
```

**Key Takeaways**

- Structured programming builds all control flow from sequence, selection, and iteration; Böhm–Jacopini proved these suffice.
- Single-entry, single-exit blocks are what make local reasoning about state possible.
- C's `break`, `continue`, `return`, and forward `goto` are disciplined deviations with well-defined targets — not arbitrary jumps.
- Backward `goto` is almost always a loop written badly; rewrite it with a loop construct.
- Cyclomatic complexity above ~10–15 signals a function to split; genuinely complex flow belongs in an explicit state machine.

> 🧪 Practice
>
> 1. Rewrite `messy_classify` yourself before reading `clean_classify`, then compare your version.
> 2. Count the cyclomatic complexity of a function in your own code (decision points + 1). Split it if the count exceeds 12.
> 3. Extend the `tokenize` state machine with a `S_STRING` state that captures text between double quotes.
> 4. Interview-style: *"Give a concrete case where `goto` produces more maintainable code than the structured alternative."* Hint: the answer involves resources acquired in sequence, and what happens when a fifth one is added later.

---

## 4. Functions and Program Organization

A function is the unit of abstraction in C: a named block of code with a declared interface, its own local storage, and a single way in and (logically) a single way out. This chapter covers how functions are declared, called, and returned from; how the compiler and linker decide which names are visible where and how long each variable lives; and how those rules scale up to programs split across many `.c` files with headers, build systems, and linkage rules. It closes with variadic functions — the mechanism behind `printf` — and the type-safety price they charge.

<a id="41-function-basics"></a>
### 4.1 Function Basics

A function packages a computation behind a name and a type signature. This section covers what the compiler needs to know at each call site, how arguments travel from caller to callee, how results travel back, and how to decide where one function should end and the next begin.

#### Definitions and Prototypes

**Theory**

To generate code for a call, the compiler needs two things at the point of the call: how many arguments to pass and what type each one is, and what type comes back. It does *not* need the function's body — that can live in another file, or in a library shipped as machine code. C therefore separates two ideas:

- A **definition** provides the body. It says what the function *does*. Each function must be defined exactly once in the whole program.
- A **declaration** provides only the interface — return type, name, parameter types. It says what the function *looks like*. It may appear many times, in many files.

A declaration that includes parameter types is called a **prototype**. Think of the prototype as the label on a shipping container and the definition as the contents: the loading dock only reads the label.

```c
double area(double r);          /* declaration (prototype) -- note the ';' */

double area(double r)           /* definition -- note the '{' */
{
    return 3.14159265358979 * r * r;
}
```

Why does this matter so much in C? Because the compiler processes a translation unit **top to bottom in one pass**. When it reaches a call, it uses whatever it knows about that name *at that moment*. If it has never seen the name, older C (C89) let it guess: the function was assumed to return `int` and its arguments were passed with default promotions, unchecked. That "implicit declaration" rule silently produced garbage whenever the guess was wrong — the classic case being `sqrt(2)`, where the compiler assumes an `int` return and reads the wrong register.

The rule tightened over time, and knowing which revision you compile under matters:

| Form | Meaning in C89 | Meaning in C99/C11/C17 | Meaning in C23 |
| --- | --- | --- | --- |
| No declaration before use | Implicit `int` function, arguments unchecked | Constraint violation (diagnostic required); many compilers still only warn | Removed entirely; error |
| `int f();` | Old-style: takes *unspecified* arguments, no checking | Same — unspecified arguments | Same as `int f(void);` — takes no arguments |
| `int f(void);` | Prototype: takes no arguments | Same | Same |
| `int f(int, char *);` | Prototype: checked | Same | Same |

Two practical consequences follow. First, **always write `(void)`, not `()`,** for a function that takes no parameters — up to C23, `()` disables argument checking rather than forbidding arguments. Second, **compile with `-Wall -Wextra -Werror`** (Chapter 1.3) so a missing prototype stops the build instead of producing a program that "mostly" works.

Where do prototypes live? For a function used only inside one `.c` file, declare it `static` near the top of that file (Chapter 4.3). For a function other files call, put the prototype in a header and include that header **in the defining file too** — that way the compiler compares the declaration against the definition and catches a mismatch immediately, rather than letting the linker join two incompatible views of the same name.

C99 also removed **implicit `int`** for return types: `main() { }` and `static x;` are no longer valid; write `int main(void)` and `static int x;`.

**Examples**

```c
#include <stdio.h>

/* --- Declarations (prototypes). No bodies; the compiler now knows the shapes. --- */
double        area(double r);
int           max3(int a, int b, int c);
static void   banner(const char *title);   /* static: visible only in this file */
void          no_args(void);               /* '(void)' -- takes NOTHING */

int main(void)
{
    banner("geometry");
    /* Legal only because 'area' was declared above: the compiler knows the
       argument is a double and the result is a double, so it converts the
       int literal 2 to 2.0 and reads the result from the FP register. */
    printf("area(2)   = %.4f\n", area(2));
    printf("max3      = %d\n", max3(3, 9, 4));
    no_args();
    return 0;
}

/* --- Definitions. Order among themselves does not matter now. --- */
double area(double r)
{
    return 3.14159265358979 * r * r;
}

int max3(int a, int b, int c)
{
    int m = (a > b) ? a : b;
    return (m > c) ? m : c;
}

static void banner(const char *title)
{
    printf("== %s ==\n", title);
}

void no_args(void)
{
    puts("called with no arguments");
}
```

What goes wrong without a prototype:

```c
/* BAD: no #include <math.h>, so sqrt is undeclared. */
int main(void)
{
    double x = sqrt(2.0);   /* C89: assumed 'int sqrt()' -> reads the wrong
                               register, gets garbage. C99+: diagnostic.
                               C23: hard error. */
    printf("%f\n", x);
    return 0;
}
```

```text
   Prototype visible at the call site?
   ----------------------------------
        NO                              YES
         |                               |
         v                               v
   compiler guesses (C89) /        arguments converted to the
   errors out (C23)                declared parameter types,
         |                         return value read correctly
         v                               |
   wrong registers, wrong sizes,         v
   silent nonsense at run time      correct call, mismatches
                                    diagnosed at compile time
```

**Key Takeaways**

- A declaration (prototype) gives the interface and ends in `;`; a definition gives the body. One definition per program, many declarations allowed.
- The compiler is single-pass: a function must be declared *before* the first call in the file, or defined above it.
- Write `f(void)`, never `f()`, for zero-parameter functions — before C23, `()` means "unspecified arguments, unchecked".
- Include the header that declares a function inside the file that defines it, so declaration/definition mismatches are caught at compile time.
- Implicit function declarations and implicit `int` are gone in modern C; enable `-Wall -Wextra -Werror` so the compiler enforces this for you.

> 🧪 Practice
>
> 1. Write a program that calls `sqrt` without including `<math.h>`. Compile it with `-std=c89`, then `-std=c17 -Wall`, then `-std=c23`, and record how each diagnoses it.
> 2. Declare `void f();` in one file and define it as `void f(int a) { ... }` in another; call `f()` with no arguments. Observe that it compiles and links, and explain why.
> 3. Split `area` and `max3` into `geom.c` with prototypes in `geom.h`, include `geom.h` from `geom.c`, then deliberately change one parameter type in the header and see which tool complains.
> 4. Interview-style: *"Why does C need forward declarations at all, when Java and Python do not?"* Hint: think about how many passes each language's compiler makes over a source file, and what a linker is given to work with.

#### Parameters and Arguments

**Theory**

The two words name two sides of the same handshake, and keeping them apart makes every later rule easier:

- A **parameter** is the variable named in the function's definition. It exists inside the function.
- An **argument** is the expression written at the call site. Its *value* is what gets sent.

Calling a function is, formally, an assignment: each argument is converted to the corresponding parameter's type exactly as if by assignment, and the parameter starts life holding that value. `f(3)` where `f` takes a `double` passes `3.0`; `f(3.7)` where `f` takes an `int` passes `3` (truncated, not rounded).

Parameters are ordinary local variables. They live in the function's own frame, they can be modified freely, and modifying them has no effect on the caller. That is the whole of C's argument model, and Chapter 4.1's "Pass by Value Semantics" topic develops the consequences.

Several rules deserve attention:

**Argument count and type are checked against the prototype.** Too few, too many, or an incompatible type is a compile error — this is precisely what prototypes buy you.

**Evaluation order of arguments is unspecified.** In `f(g(), h())`, the compiler may call `h` first. Worse, if two arguments modify the same object — `f(i++, i++)` — the behavior is undefined (Chapter 12.2). Never let one argument depend on a side effect in another.

**Arrays decay.** A parameter declared `int a[]` or `int a[10]` is silently adjusted to `int *a`. The array itself is never copied, `sizeof a` inside the function gives the size of a *pointer*, and the `10` is documentation only. Because of this, any function taking an array needs a separate length parameter. C99 lets you write `void f(int n, int a[static n])` to document a minimum length and let the compiler warn.

**Function parameters decay too.** A parameter declared as a function type becomes a pointer to function (Chapter 5.3).

**`const` on a parameter is a promise.** `void print(const char *s)` promises not to write through `s`. This documents intent, lets callers pass string literals safely, and enables optimizations. Note that top-level `const` on a by-value parameter (`void f(const int n)`) only prevents the function from reassigning its own copy — it means nothing to the caller and is usually omitted from the prototype.

**C has no default arguments and no overloading.** Two functions cannot share a name; a name means exactly one function. Variadic functions (Chapter 4.4) and `_Generic` (Chapter 10.3) are the workarounds.

**Examples**

```c
#include <stdio.h>
#include <string.h>

/* 'n' is a parameter; the caller's expression is the argument. */
long sum_ints(const int *a, size_t n)   /* const: we promise not to write through a */
{
    long total = 0;
    for (size_t i = 0; i < n; i++)
        total += a[i];
    return total;
}

/* Array parameter: 'int a[10]' is a lie -- it is really 'int *a'. */
void show_size(int a[10])
{
    printf("sizeof inside callee = %zu\n", sizeof a);  /* 8 on a 64-bit machine */
}

/* Implicit conversion happens as if by assignment. */
void takes_double(double d) { printf("got %.2f\n", d); }
void takes_int(int i)       { printf("got %d\n", i);   }

int main(void)
{
    int data[10] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

    printf("sizeof in caller     = %zu\n", sizeof data);  /* 40: real array */
    show_size(data);                                      /* decays to int * */

    /* The length must be passed explicitly -- the callee cannot recover it. */
    printf("sum = %ld\n", sum_ints(data, sizeof data / sizeof data[0]));

    takes_double(3);      /* int 3 converted to 3.00 */
    takes_int(3.7);       /* double truncated to 3, not rounded */

    /* Unspecified evaluation order: do not write code that depends on it. */
    int i = 0;
    /* printf("%d %d\n", i++, i++);  <-- UNDEFINED BEHAVIOR. Never do this. */
    printf("%d\n", i);
    return 0;
}
```

```text
   Call:  sum_ints(data, 10)
                |      |
     argument --+      +-- argument
                |      |
          (assignment-like conversion)
                v      v
   Definition: sum_ints(const int *a, size_t n)
                          parameter    parameter
                        (a copy of the pointer, and a copy of 10,
                         both living in the callee's own frame)
```

**Key Takeaways**

- Parameter = the callee's variable; argument = the caller's expression. Passing is an implicit assignment, including conversions.
- Prototypes make argument count and types checkable; without one, nothing is checked.
- Array parameters decay to pointers — `sizeof` inside the callee measures the pointer, so always pass a length alongside.
- Argument evaluation order is unspecified; two side effects on the same object in one call is undefined behavior.
- Use `const` on pointer parameters you do not write through; C has no overloading and no default arguments.

> 🧪 Practice
>
> 1. Write `double average(const double *a, size_t n)` and call it with an array; print `sizeof` for the array in `main` and for the parameter inside the function, and explain the difference.
> 2. Define `void f(int x)` and call it as `f(2.99)`, `f('A')`, and `f(70000L)`. Predict each printed result before running, then check.
> 3. Write a function `void swap_wrong(int a, int b)` that tries to swap its parameters, call it, and show that the caller's variables are unchanged.
> 4. Interview-style: *"What does `void f(int a[static 5])` mean, and what can the compiler do with it?"* Hint: it is a promise from the caller, not a constraint on the callee's type.

#### Return Values

**Theory**

A function sends a result back with `return expression;`. As with arguments, the value is converted to the declared return type as if by assignment, and a *copy* is what the caller receives.

The mechanics matter for one reason above all: **the callee's local storage disappears when it returns.** Its frame is popped, and any pointer into it becomes dangling. So `return &local;` is a bug — one that often "works" in testing because the memory has not yet been overwritten, and then fails catastrophically later. Returning a *value* is always safe; returning a *pointer* is safe only when the pointee outlives the call (it is `static`, heap-allocated, or owned by the caller).

`void` means "no value". A `void` function may use bare `return;` to exit early, but `return expr;` is an error. Conversely, in a non-`void` function, falling off the closing brace without returning is legal syntax, but *using* the resulting value is undefined behavior. Compilers catch this with `-Wreturn-type`, which should always be on.

`main` is the special case: reaching the end of `main` behaves as `return 0;`. Return `EXIT_SUCCESS` or `EXIT_FAILURE` from `<stdlib.h>` for portability; only the low 8 bits reach the shell on POSIX systems, so never encode meaningful data in an exit status.

C can only return one value, which shapes idiomatic C error handling. Four patterns cover almost everything:

| Pattern | Shape | When to use |
| --- | --- | --- |
| Value only | `int add(int, int)` | Cannot fail |
| Sentinel | `char *strchr(...)` returns `NULL` | One obviously invalid value exists |
| Status + out-parameter | `int parse(const char *s, long *out)` | Every value is valid; failure must be distinguishable |
| Struct return | `struct result f(void)` | Two or more related values; copies are cheap |

The status + out-parameter shape is the workhorse of robust C: the return value says whether it worked, and the caller supplies storage for the answer. Returning a struct is fully legal (the whole struct is copied, and the ABI may use registers or a hidden pointer), and modern compilers handle it efficiently — but note that a struct containing a pointer to a local is still a dangling pointer.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>

/* 1. Plain value. */
int add(int a, int b) { return a + b; }

/* 2. Sentinel: NULL means "not found". */
const char *find_char(const char *s, char c)
{
    for (; *s; s++)
        if (*s == c) return s;
    return NULL;                    /* the sentinel */
}

/* 3. Status + out-parameter: every long is a valid result, so the
      success/failure signal must travel separately. */
int parse_long(const char *s, long *out)     /* returns 0 on success, -1 on failure */
{
    char *end;
    errno = 0;
    long v = strtol(s, &end, 10);
    if (end == s || *end != '\0') return -1;             /* not a number */
    if (errno == ERANGE)          return -1;             /* out of range  */
    *out = v;                                            /* write through the out-param */
    return 0;
}

/* 4. Struct return: two values that belong together. */
struct divmod { int quot, rem; };

struct divmod divide(int a, int b)
{
    struct divmod r = { a / b, a % b };
    return r;                        /* the whole struct is copied out */
}

/* DANGER: returning the address of a local. */
int *broken(void)
{
    int local = 42;
    return &local;      /* the frame dies here; the pointer is dangling */
}

int main(void)
{
    printf("add        : %d\n", add(2, 3));

    const char *p = find_char("hello", 'l');
    printf("find_char  : %s\n", p ? p : "(not found)");

    long v;
    if (parse_long("12345", &v) == 0) printf("parse_long : %ld\n", v);
    else                              puts("parse_long : failed");

    struct divmod d = divide(17, 5);
    printf("divide     : %d rem %d\n", d.quot, d.rem);

    /* int *bad = broken(); printf("%d", *bad);  <-- undefined behavior */
    return EXIT_SUCCESS;
}
```

```text
   Caller frame                Callee frame (alive only during the call)
   +-------------+             +-----------------------+
   | int r;      | <--copy---- | return a + b;         |
   +-------------+             | int local = 42;       |
   | int *bad;   | <--addr---- | return &local;  <-- points HERE
   +-------------+             +-----------------------+
                                        ^
                                  frame popped on return:
                                  the pointer now aims at reusable memory
```

**Key Takeaways**

- `return` copies a value out and converts it to the declared return type; the callee's locals are destroyed immediately after.
- Never return the address of an automatic local — return by value, or return memory that outlives the call.
- Falling off the end of a non-`void` function and using the result is undefined behavior; keep `-Wreturn-type` enabled.
- `main` implicitly returns 0; use `EXIT_SUCCESS`/`EXIT_FAILURE` and remember only the low 8 bits are visible to the shell.
- Only one value comes back: use a sentinel when one exists, a status code plus out-parameter when every value is valid, and a struct for related values.

> 🧪 Practice
>
> 1. Write `int safe_div(int a, int b, int *out)` returning `-1` when `b == 0` and `0` otherwise. Call it with both cases.
> 2. Write the `broken()` function above, compile with `-Wall`, and note the warning. Then run it and observe that the wrong value only sometimes appears — explain why the bug is nondeterministic.
> 3. Rewrite `divide` to use two out-parameters instead of a struct. Compare the call sites for readability.
> 4. Interview-style: *"Your function must return a string. What are your options in C, and what does each imply about ownership?"* Hint: enumerate who calls `free`, and what happens with `static` buffers when two threads call at once.

#### Pass by Value Semantics

**Theory**

C has exactly one argument-passing mechanism: **pass by value**. Every argument is copied into the parameter, and the callee works on the copy. There is no pass-by-reference in the language — no `&` in a parameter list like C++, no implicit aliasing.

This is why the beginner's `swap` fails:

```c
void swap(int a, int b) { int t = a; a = b; b = t; }   /* swaps two copies */
```

The fix is not a different calling convention; it is passing a different *value* — the address:

```c
void swap(int *a, int *b) { int t = *a; *a = *b; *b = t; }
swap(&x, &y);
```

Note what actually happened: the pointer itself is still passed by value (the callee gets its own copy of the address). But a copy of an address still points at the original object, so writing through it reaches the caller's variable. "Pass by reference" in C is simply "pass a pointer by value" — the idiom people call *pass by address*.

Three consequences follow.

**Arrays are the apparent exception, and are not.** Because an array expression decays to a pointer to its first element, `f(arr)` passes an address, so the callee can modify the caller's elements. No array was copied; a pointer was.

**Big structs cost a copy.** Passing a 4 KB struct by value copies 4 KB on every call. Pass `const struct big *` instead when the struct is large, and pass small structs (a point, a complex number) by value for clarity and speed.

**Copies are shallow.** Copying a struct that contains a pointer copies the pointer, not the pointee. Both copies then alias the same buffer — fine if you intend sharing, a double-free waiting to happen if you do not.

| Want | Pass | Callee sees | Can modify caller's object? |
| --- | --- | --- | --- |
| Read a scalar | `int n` | copy of the value | No |
| Modify a scalar | `int *n` | copy of the address | Yes, via `*n` |
| Read a large struct | `const struct S *s` | copy of the address, read-only | No (compiler enforced) |
| Modify a large struct | `struct S *s` | copy of the address | Yes |
| Read an array | `const int *a, size_t n` | copy of the address | No |

**Examples**

```c
#include <stdio.h>
#include <string.h>

struct big { char data[4096]; int id; };

void by_value(struct big b)         { b.id = 99; }        /* modifies a 4 KB copy */
void by_pointer(struct big *b)      { b->id = 99; }       /* modifies the original */
void read_only(const struct big *b) { printf("id=%d\n", b->id); /* b->id = 1; would not compile */ }

void bad_swap(int a, int b)   { int t = a; a = b; b = t; }
void good_swap(int *a, int *b){ int t = *a; *a = *b; *b = t; }

void fill(int a[], size_t n)  { for (size_t i = 0; i < n; i++) a[i] = (int)i; }  /* really int * */

int main(void)
{
    int x = 1, y = 2;
    bad_swap(x, y);   printf("bad_swap : x=%d y=%d\n", x, y);   /* 1 2 -- unchanged */
    good_swap(&x, &y);printf("good_swap: x=%d y=%d\n", x, y);   /* 2 1 -- swapped  */

    struct big s;
    memset(&s, 0, sizeof s);
    s.id = 7;
    by_value(s);                   /* copies the whole 4 KB struct onto the stack */
    printf("after by_value  : id=%d\n", s.id);   /* still 7 */
    by_pointer(&s);
    printf("after by_pointer: id=%d\n", s.id);   /* now 99 */
    read_only(&s);

    int arr[5] = { 0 };
    fill(arr, 5);                                 /* array decayed to a pointer */
    printf("arr[3] = %d\n", arr[3]);              /* 3 -- caller's array was modified */
    return 0;
}
```

```text
   good_swap(&x, &y)

   caller frame              callee frame
   +----------+              +----------+
   | x  =  1  |<-------------| a (copy of &x)
   +----------+              +----------+
   | y  =  2  |<-------------| b (copy of &y)
   +----------+              +----------+

   The POINTERS are copies. What they point AT is shared.
```

**Key Takeaways**

- C passes everything by value; the callee always works on a copy of the argument's value.
- To modify a caller's object, pass its address — the pointer is copied, but the pointee is shared.
- Arrays are not an exception: the array expression decays to a pointer, so the address is what gets copied.
- Struct arguments are copied in full; pass large structs as `const struct S *` to avoid the cost and document read-only intent.
- Struct copies are shallow — a copied pointer member aliases the same memory.

> 🧪 Practice
>
> 1. Implement `bad_swap` and `good_swap`, print addresses of the caller's variables and of the parameters inside each, and confirm they differ.
> 2. Write a function that takes a 1 MB struct by value in a loop of a million calls, time it, then change to `const struct *` and time it again.
> 3. Write `void zero(int *a, size_t n)` and call it with a stack array and with a `malloc`ed buffer; verify both are modified.
> 4. Interview-style: *"C is pass-by-value only — so how does `scanf` change my variables?"* Hint: look at what `&x` actually evaluates to, and what `scanf` does with the copy it receives.

#### Recursion

**Theory**

A function may call itself. That sounds circular, but it works because each call gets its own frame: its own parameters, its own locals, its own return address. Ten nested calls means ten independent copies of the locals stacked on top of each other.

Recursion is the natural shape for problems that are **self-similar** — where the answer for size *n* is built from the answer for a smaller input. Every correct recursive function has two parts:

1. A **base case** that returns without recursing. Without it, the recursion never stops.
2. A **recursive case** that calls itself on strictly smaller input, guaranteeing the base case is eventually reached.

The cost is the stack. Each frame consumes memory (typically tens of bytes, more with big locals), and the stack is a fixed, modest size — commonly 8 MB on Linux, 1 MB on Windows. Exceed it and the program dies with a stack overflow (segmentation fault), with no exception to catch. Depth proportional to `n` is fine for `n` in the thousands; depth proportional to `n` for a million-element list is not.

Two shapes are worth naming:

- **Tail recursion**: the recursive call is the *last* thing the function does, with nothing left to compute afterwards. A compiler at `-O2` can turn this into a jump, reusing the frame — the recursion becomes a loop and the stack stops growing. This is an optimization, not a language guarantee; never rely on it for correctness.
- **Tree recursion**: the function calls itself more than once (naive Fibonacci). Beware exponential blow-up — naive `fib(50)` makes about 2.7 billion calls.

When should you use recursion in C? When the *data* is recursive: trees, directory hierarchies, nested expressions, divide-and-conquer sorts. For simple linear iteration, a loop is clearer, faster, and cannot overflow the stack. Any recursion can be rewritten iteratively (with an explicit stack if necessary), and for depth-unbounded input you should.

**Examples**

```c
#include <stdio.h>

/* Classic: factorial. Base case n <= 1, recursive case n * fact(n-1). */
unsigned long long fact(unsigned n)
{
    if (n <= 1) return 1;              /* base case -- stops the recursion */
    return n * fact(n - 1);            /* NOT tail recursive: the multiply
                                          happens after the call returns */
}

/* Tail-recursive version: nothing to do after the call, so -O2 turns it
   into a loop and the stack stops growing. */
unsigned long long fact_tail(unsigned n, unsigned long long acc)
{
    if (n <= 1) return acc;
    return fact_tail(n - 1, acc * n);  /* tail call */
}

/* Tree recursion: two calls per level -> exponential time. */
unsigned long long fib_slow(unsigned n)
{
    if (n < 2) return n;
    return fib_slow(n - 1) + fib_slow(n - 2);
}

/* The iterative equivalent: O(n) time, O(1) space. */
unsigned long long fib_fast(unsigned n)
{
    unsigned long long a = 0, b = 1;
    for (unsigned i = 0; i < n; i++) { unsigned long long t = a + b; a = b; b = t; }
    return a;
}

/* Recursion where it genuinely fits: a self-similar structure. */
struct node { int value; struct node *left, *right; };

int tree_sum(const struct node *n)
{
    if (n == NULL) return 0;                                  /* base case */
    return n->value + tree_sum(n->left) + tree_sum(n->right); /* self-similar */
}

int main(void)
{
    printf("fact(10)      = %llu\n", fact(10));
    printf("fact_tail(10) = %llu\n", fact_tail(10, 1));
    printf("fib_slow(30)  = %llu\n", fib_slow(30));   /* noticeably slow */
    printf("fib_fast(90)  = %llu\n", fib_fast(90));   /* instant */

    struct node l = { 1, NULL, NULL }, r = { 3, NULL, NULL }, root = { 2, &l, &r };
    printf("tree_sum      = %d\n", tree_sum(&root));
    return 0;
}
```

Frame growth for `fact(4)`:

```text
   call            stack (grows downward)
   fact(4)  -->  [ n=4 ]
   fact(3)  -->  [ n=4 ][ n=3 ]
   fact(2)  -->  [ n=4 ][ n=3 ][ n=2 ]
   fact(1)  -->  [ n=4 ][ n=3 ][ n=2 ][ n=1 ]   <- base case, returns 1
                        unwinding:
                  1*2 = 2 -> 2*3 = 6 -> 6*4 = 24
```

**Key Takeaways**

- Every recursive function needs a base case and a recursive case that strictly shrinks the input.
- Each call allocates a new frame; depth is bounded by the stack (about 8 MB on Linux) and overflow is a hard crash.
- Tail recursion *can* be optimized into a loop at `-O2`, but C does not guarantee it — never depend on it for correctness.
- Tree recursion without memoization can be exponential; naive `fib` is the standard cautionary example.
- Prefer recursion for recursive data (trees, nested structures) and loops for linear traversal.

> 🧪 Practice
>
> 1. Write a recursive `size_t str_len(const char *s)` and a recursive `void reverse_print(const char *s)`. Test both on a short string.
> 2. Write a recursive function with no base case, run it, and observe the crash. Then use `ulimit -s` to check your stack size and estimate the depth reached.
> 3. Time `fib_slow(35)` versus `fib_fast(35)`. Then add memoization (a `static` array of cached results) to `fib_slow` and time it again.
> 4. Interview-style: *"Rewrite a recursive binary-tree traversal iteratively."* Hint: whatever the call stack was storing for you, you must now store yourself.

#### Function Design and Cohesion

**Theory**

The compiler accepts any function you can type. What separates maintainable C from a swamp is a set of design habits, and the central one is **cohesion**: a function should do one conceptual thing, and its name should say what that thing is.

A useful test: describe the function in one sentence without using "and" or "then". If you cannot, it is doing too much.

Practical guidelines, roughly in order of impact:

**One job per function.** `read_config_and_connect_and_log()` has three reasons to change and cannot be tested or reused piecemeal. Splitting it makes each part independently testable.

**Short enough to see at once.** There is no magic number, but a function that does not fit on a screen is usually hiding two functions. Chapter 3.3 covered cyclomatic complexity: above roughly 10-15 decision points, split it.

**Few parameters.** Beyond four or five, callers start passing things in the wrong order — especially with same-typed parameters where the compiler cannot help. Group related parameters into a struct.

**Minimize hidden state.** A function that reads only its parameters and writes only its outputs (a *pure* function) is trivially testable and thread-safe. Global state and `static` locals make behavior depend on history. Push state to the edges of your program.

**Consistent error signaling.** Pick one convention per module — `0`/`-1`, `NULL`, or an `enum` status — and apply it everywhere. Mixed conventions are a permanent source of unchecked failures.

**Const-correctness in the signature.** `size_t count(const char *s, char c)` tells the reader and the compiler that the string is not modified. Signatures are documentation the compiler checks.

**Name for the caller's viewpoint.** Verb phrases for actions (`parse_line`, `flush_buffer`), noun or predicate phrases for queries (`buffer_size`, `is_valid`). A function named `process` says nothing.

**Guard clauses over deep nesting.** Handling invalid input first and returning early keeps the main path at one indentation level.

**Examples**

```c
#include <stdio.h>
#include <string.h>
#include <ctype.h>

/* ---------- BEFORE: one function doing four jobs ---------- */
int handle(char *line)          /* modifies input, parses, validates, prints */
{
    if (line != NULL) {
        if (strlen(line) > 0) {
            for (char *p = line; *p; p++)
                *p = (char)toupper((unsigned char)*p);
            if (strncmp(line, "SET ", 4) == 0) {
                char *value = line + 4;
                if (strlen(value) > 0) {
                    printf("setting to %s\n", value);
                    return 0;
                } else return -1;
            } else return -2;
        } else return -3;
    }
    return -4;
}

/* ---------- AFTER: four cohesive functions ---------- */

/* One job: uppercase in place. Pure with respect to everything but its argument. */
static void upcase(char *s)
{
    for (; *s; s++) *s = (char)toupper((unsigned char)*s);
}

/* One job: recognize the command and hand back the argument. No I/O, no mutation. */
static const char *parse_set(const char *line)
{
    if (strncmp(line, "SET ", 4) != 0) return NULL;   /* guard clause */
    const char *value = line + 4;
    return (*value != '\0') ? value : NULL;
}

/* One job: apply the effect. */
static void apply_set(const char *value)
{
    printf("setting to %s\n", value);
}

/* Thin coordinator: reads top to bottom, guard clauses first, one level deep. */
int handle_line(char *line)
{
    if (line == NULL || *line == '\0') return -1;     /* guard */
    upcase(line);
    const char *value = parse_set(line);
    if (value == NULL) return -2;                     /* guard */
    apply_set(value);
    return 0;
}

int main(void)
{
    char a[] = "set brightness";
    char b[] = "get brightness";
    printf("a -> %d\n", handle_line(a));
    printf("b -> %d\n", handle_line(b));
    return 0;
}
```

Where each design axis pushes:

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| Name contains "and" | Low cohesion | Split into two functions |
| 7 parameters, several `int` | Ungrouped data | Pass a struct |
| Nesting 5 levels deep | Missing guard clauses | Return early on invalid input |
| Test needs elaborate setup | Hidden global state | Pass state in as a parameter |
| Same value recomputed everywhere | Missing helper | Extract a named function |

**Key Takeaways**

- A function should do one thing; if its one-sentence description needs "and", split it.
- Keep parameter lists short and group related arguments into structs; same-typed parameters invite ordering bugs.
- Prefer pure functions — inputs in, value out — and push global and `static` state to the program's edges.
- Use guard clauses to handle errors first and keep the success path shallow.
- Choose one error-signaling convention per module and use `const` in signatures to document and enforce read-only access.

> 🧪 Practice
>
> 1. Take the `handle` function above and refactor it yourself before reading the "AFTER" version; compare the two decompositions.
> 2. Find a function in your own code with more than five parameters and refactor it to take a configuration struct.
> 3. Rewrite a deeply nested validation function using guard clauses and count the indentation levels before and after.
> 4. Interview-style: *"How do you decide whether a block of code deserves to be its own function?"* Hint: think about naming, reuse, and what you would need to mock to test it.

<a id="42-scope-and-lifetime"></a>
### 4.2 Scope and Lifetime

Two independent questions govern every variable in C: *where in the source is this name visible* (scope), and *when during execution does this object exist* (storage duration). Confusing them is the source of most puzzling behavior around `static`, `extern`, and dangling pointers, so this section separates them carefully.

#### Block, File, and Function Scope

**Theory**

**Scope** is a purely compile-time, textual property: the region of source code in which an identifier refers to a particular declaration. It says nothing about memory. C defines four scopes:

| Scope | Where it starts | Where it ends | Typical declaration |
| --- | --- | --- | --- |
| **Block** | At the declarator, inside `{ }` | At the closing `}` | Locals, parameters |
| **File** | At the declarator, outside any block | End of the translation unit | Globals, `static` globals |
| **Function** | Anywhere in the function | End of the function | Labels only (`goto` targets) |
| **Function prototype** | Inside the parameter list | End of the prototype | `void f(int n, int a[n]);` |

Two details in that table repay attention.

**Scope begins at the declarator, not at the enclosing brace.** So this is legal and surprising:

```c
int x = 10;
void f(void) {
    int x = x;      /* the inner x is already in scope: it initializes itself
                       with its own indeterminate value, not with 10 */
}
```

**Function scope applies only to labels.** A label written anywhere in a function is visible everywhere in it, which is why `goto` can jump forward over declarations to a cleanup label at the bottom (Chapter 3.3).

Blocks nest, and each `{ }` opens a new block scope — including the bodies of `if`, `for`, and `while`, and even bare braces you write for the purpose. A `for` loop's initializer is itself in a scope that encloses the loop body:

```c
for (int i = 0; i < n; i++) { /* i is visible here */ }
/* i is NOT visible here (C99 and later) */
```

Declaring variables in the smallest possible scope is the single cheapest reliability habit in C: it shortens the distance a reader must track, prevents accidental reuse, and lets the compiler reuse the storage.

Note that parameters are in the *block* scope of the function body, which is why a parameter and a top-level local cannot share a name.

**Examples**

```c
#include <stdio.h>

int g = 100;                    /* file scope: visible from here to end of file */

void demo(int p)                /* p: block scope of the function body */
{
    int a = 1;                  /* block scope: the whole function body */

    {                           /* a nested block -- a new scope */
        int a = 2;              /* shadows the outer a (see "Name Shadowing") */
        int b = 3;              /* exists only inside these braces */
        printf("inner: a=%d b=%d p=%d g=%d\n", a, b, p, g);
    }
    /* printf("%d", b); */      /* ERROR: b is out of scope here */

    printf("outer: a=%d\n", a); /* 1 -- the inner a was a different object */

    for (int i = 0; i < 2; i++) /* i: scope is the for statement */
        printf("loop i=%d\n", i);
    /* printf("%d", i); */      /* ERROR: i is out of scope */

    goto done;                  /* labels have FUNCTION scope: visible everywhere */
done:
    puts("done");
}

int main(void) { demo(7); return 0; }
```

```text
   file scope
   +-----------------------------------------------+
   | int g;                                        |
   |                                               |
   |  demo() body -- block scope                   |
   |  +------------------------------------------+ |
   |  | int p (parameter), int a                 | |
   |  |                                          | |
   |  |  nested block                            | |
   |  |  +------------------------+              | |
   |  |  | int a (shadows), int b |              | |
   |  |  +------------------------+              | |
   |  |                                          | |
   |  |  label 'done': visible in ALL of demo    | |
   |  +------------------------------------------+ |
   +-----------------------------------------------+
```

**Key Takeaways**

- Scope is textual visibility, decided at compile time; it is independent of lifetime.
- C has block, file, function (labels only), and function-prototype scope.
- A name's scope starts at its declarator, not at the opening brace — `int x = x;` sees the inner `x`.
- Every `{ }` opens a new scope, including loop and `if` bodies; C99 `for (int i = ...)` confines `i` to the loop.
- Declare variables in the narrowest scope that works; it reduces bugs and helps the optimizer.

> 🧪 Practice
>
> 1. Write a function with three nested blocks, each declaring `int v` with a different value, and print `v` at each level.
> 2. Try to use a `for`-loop variable after the loop under `-std=c99` and under `-std=c89`. Explain the different results.
> 3. Write `int x = 10;` at file scope and `int x = x + 1;` inside a function; compile with `-Wall -Winit-self` and explain the warning.
> 4. Interview-style: *"What is the scope of a label, and why is it different from everything else?"* Hint: consider what `goto` must be able to do inside a function with many nested blocks.

#### Automatic Storage Duration

**Theory**

**Storage duration** answers the other question: how long does the object live? The default for anything declared inside a block is **automatic** storage duration — hence the (essentially never-written) keyword `auto`.

An automatic object is created when execution enters its block and destroyed when execution leaves that block, by any route: falling off the end, `break`, `continue`, `return`, or `goto`. In practice the compiler allocates all of a function's automatic objects in one **stack frame** on function entry, and pops the whole frame on return — which is why creating them costs essentially nothing (adjusting a stack pointer) and why there is no cleanup to run.

Three properties matter:

**Uninitialized automatics hold indeterminate values.** Unlike static objects, they are *not* zeroed. Reading one before writing it is undefined behavior — and often looks like it "works" because the stack happened to contain zeros. Always initialize at the point of declaration.

**Their addresses are only valid during their lifetime.** Once the block exits, any pointer to them dangles. This is the mechanism behind the `return &local;` bug from Chapter 4.1.

**Each call gets a fresh copy**, which is exactly what makes recursion and multithreading work: two simultaneous calls do not share locals. Automatic objects are inherently thread-safe.

The stack is finite (often 8 MB). A large automatic array — `char buf[10 * 1024 * 1024];` — can overflow it with no diagnostic at compile time and no recoverable error at run time. Big buffers belong on the heap (Chapter 7.2).

C99's **variable-length arrays (VLAs)** are automatic objects whose size is computed at run time. They are convenient but risky: a size derived from untrusted input is a stack-overflow vulnerability, and VLAs are optional in C11 and later (`__STDC_NO_VLA__`).

**Examples**

```c
#include <stdio.h>

void counter_broken(void)
{
    int count = 0;      /* created fresh on EVERY call */
    count++;
    printf("count = %d\n", count);   /* always 1 */
}

void indeterminate(void)
{
    int uninitialized;               /* NOT zeroed -- holds whatever was there */
    int initialized = 0;             /* always do this instead */
    printf("initialized = %d\n", initialized);
    /* printf("%d", uninitialized);  <-- undefined behavior */
    (void)uninitialized;
}

void scoped_lifetime(void)
{
    for (int i = 0; i < 3; i++) {
        int inner = i * 10;          /* created and destroyed on every iteration */
        printf("i=%d inner=%d (addr %p)\n", i, inner, (void *)&inner);
        /* The address is typically identical each iteration: the same stack
           slot is reused. Same storage, but a new object each time. */
    }
}

int *dangling(void)
{
    int local = 5;
    return &local;      /* lifetime ends at the closing brace */
}

int main(void)
{
    counter_broken();
    counter_broken();   /* still prints 1: the local was recreated */
    indeterminate();
    scoped_lifetime();
    (void)dangling();   /* using the result would be undefined behavior */
    return 0;
}
```

```text
   Stack during main() -> scoped_lifetime()

   high addresses
   +---------------------+
   | main's frame        |   lives until main returns
   +---------------------+
   | scoped_lifetime's   |   created on entry, popped on return
   |   frame: i, inner   |
   +---------------------+
   low addresses  <-- stack pointer moves down on call, up on return
```

**Key Takeaways**

- Block-scope variables have automatic storage duration by default: created on block entry, destroyed on block exit.
- Automatic objects are *not* zero-initialized; reading an uninitialized one is undefined behavior.
- Pointers to automatic objects dangle once the block is left — never return them or store them beyond the block.
- Each call and each recursion level gets its own copy, which makes locals inherently thread-safe.
- The stack is small; put large buffers on the heap and treat run-time-sized VLAs as a security risk.

> 🧪 Practice
>
> 1. Write a function with an uninitialized `int` and print it, compiled with `-O0` and then `-O2 -Wall`. Compare the values and the warnings.
> 2. Print the address of a local inside a loop for several iterations, then inside a recursive function for several depths. Explain why one repeats and the other does not.
> 3. Declare `char buf[64 * 1024 * 1024]` as a local and run the program; then move it to `malloc` and run again.
> 4. Interview-style: *"Why is a local variable thread-safe but a `static` local is not?"* Hint: count how many copies of each exist when two threads call the same function.

#### static Variables

**Theory**

`static` is the most overloaded keyword in C. It does two entirely different jobs depending on where it appears, and the only reliable way to keep them apart is to ask: *is this inside a block or outside one?*

**1. `static` on a block-scope variable changes its storage duration.** The variable keeps block scope (still only visible inside that function), but it now has **static storage duration**: it is created once, before `main` runs, and lives until the program exits. It retains its value between calls. Static objects are also **zero-initialized by default**, and their initializer must be a constant expression evaluated at compile time (C99 relaxes this only for VLAs, which cannot be static at all).

**2. `static` on a file-scope declaration changes its linkage.** The variable or function still has static storage duration (globals always do), but it becomes **internal linkage**: invisible to other translation units. That is a Chapter 4.3 topic, and it is the C equivalent of "private to this file".

| Declaration | Scope | Storage duration | Linkage |
| --- | --- | --- | --- |
| `int x;` inside a function | block | automatic | none |
| `static int x;` inside a function | block | static | none |
| `int x;` at file scope | file | static | external |
| `static int x;` at file scope | file | static | internal |

Static locals are useful for a call counter, a lazily initialized table, or a cached result. They come with a real cost: the function is no longer pure, its behavior depends on call history, and it is **not thread-safe** — every thread shares the one object. The classic example is `strtok`, whose static state is exactly why it cannot be used from two threads.

The initializer of a static local runs **once**, not on every call — a point that surprises people coming from languages with different semantics:

```c
void f(void) { static int n = 5; n++; }   /* n is set to 5 once, before main */
```

**Examples**

```c
#include <stdio.h>

/* 1. Static local: one object, shared by all calls, remembers its value. */
int next_id(void)
{
    static int id = 0;      /* initialized ONCE, before main runs */
    return ++id;
}

/* 2. Lazy initialization: build an expensive table on first use. */
const int *squares(void)
{
    static int table[10];
    static int built = 0;   /* zero-initialized by default */
    if (!built) {
        for (int i = 0; i < 10; i++) table[i] = i * i;
        built = 1;
        puts("(table built)");
    }
    return table;           /* SAFE to return: static storage outlives the call */
}

/* 3. Contrast with automatic. */
void automatic_counter(void)
{
    int count = 0;          /* recreated every call */
    printf("automatic: %d\n", ++count);
}

int main(void)
{
    printf("ids: %d %d %d\n", next_id(), next_id(), next_id());  /* order of
        evaluation is unspecified, but all three differ -- state persists */

    const int *t = squares();
    const int *u = squares();       /* no rebuild message the second time */
    printf("squares[7] = %d, same pointer: %s\n", t[7], t == u ? "yes" : "no");

    automatic_counter();
    automatic_counter();            /* prints 1 both times */
    return 0;
}
```

```text
   Memory regions

   +----------------+  .data / .bss : static storage duration
   | static int id  |  created before main, destroyed at exit
   | static table[] |  ONE copy, shared by every call and every thread
   +----------------+
   | heap           |  malloc/free
   +----------------+
   | stack          |  automatic locals: one copy PER CALL
   +----------------+
```

**Key Takeaways**

- Inside a block, `static` changes storage duration: one object, created before `main`, retaining its value across calls.
- At file scope, `static` changes linkage instead: the name becomes private to the translation unit.
- Static objects are zero-initialized and their initializers must be compile-time constants, evaluated once.
- Returning a pointer to a static local is safe (unlike an automatic), but every caller shares one buffer.
- Static state destroys purity and thread safety — `strtok` is the standard cautionary example.

> 🧪 Practice
>
> 1. Write `int call_count(void)` using a static local and call it in a loop; then remove `static` and explain the change.
> 2. Write a function returning a pointer to a static `char` buffer that formats a number as a string. Call it twice in a single `printf` and explain the surprising output.
> 3. Print the address of a static local and of an automatic local in the same function across several calls; compare stability.
> 4. Interview-style: *"When is a static local the right tool, and when is it a landmine?"* Hint: consider two threads, and consider what a unit test needs to reset between cases.

#### extern Declarations

**Theory**

By default, a variable declared at file scope has **external linkage**: the name is exported and any translation unit in the program can refer to the same object. `extern` is how another file says "this name exists somewhere else — trust me, the linker will find it."

The crucial distinction is **definition versus declaration**, exactly as with functions:

```c
int counter = 0;        /* DEFINITION: allocates storage, in exactly one .c file */
extern int counter;     /* DECLARATION: no storage; refers to the definition */
```

The rule that follows is the standard C project layout, and it is worth memorizing:

- Put `extern int counter;` in the **header**.
- Put `int counter = 0;` in **exactly one `.c` file**.
- Every file that uses `counter` includes the header.

If you put the definition in the header instead, every file that includes it defines the variable, and the linker reports a duplicate symbol. (Historically some linkers merged tentative definitions — the "common symbol" behavior — which is why the mistake sometimes went unnoticed. GCC 10 and later default to `-fno-common`, so it is now an error.)

Functions are simpler: a function declaration is `extern` by default, so `extern` on a prototype is redundant and normally omitted.

A subtlety worth knowing: at file scope, `int counter;` with no initializer is a **tentative definition**. If the translation unit never provides a real definition, it becomes a definition initialized to zero. This is why `int x;` in two headers used to link "by accident."

Globals themselves deserve a warning independent of the mechanics. They create invisible coupling between modules, make functions non-reentrant, and complicate testing. Prefer passing state explicitly; when a global is genuinely justified (a program-wide configuration, a logging handle), expose it through accessor functions rather than raw `extern`, so you can add validation or locking later. Mark read-only globals `const` and, if shared across threads, use `_Atomic` or a mutex — `volatile` is *not* a threading tool (Chapter 11.4).

**Examples**

```c
/* ---------- config.h ---------- */
#ifndef CONFIG_H
#define CONFIG_H

extern int   verbosity;         /* DECLARATION -- no storage allocated */
extern const char *program_name;

void set_verbosity(int level);  /* 'extern' is implicit on functions */

#endif
```

```c
/* ---------- config.c ---------- */
#include "config.h"             /* include your own header: catches mismatches */

int   verbosity    = 0;         /* THE definition -- exactly one in the program */
const char *program_name = "demo";

void set_verbosity(int level)
{
    verbosity = (level < 0) ? 0 : level;
}
```

```c
/* ---------- main.c ---------- */
#include <stdio.h>
#include "config.h"             /* brings in the extern declarations */

int main(void)
{
    printf("%s: verbosity = %d\n", program_name, verbosity);
    set_verbosity(3);
    printf("%s: verbosity = %d\n", program_name, verbosity);  /* same object */
    return 0;
}
```

```text
   config.h   : extern int verbosity;   <- promise, no storage
        |  included by
        +---------------------+
        v                     v
   config.c                 main.c
   int verbosity = 0;       (uses verbosity)
        |                     |
        |  compiled           |  compiled
        v                     v
   config.o                 main.o
   [defines verbosity]      [undefined ref: verbosity]
        \                     /
         +----- linker ------+
                   |
                   v
             one object, one address
```

**Key Takeaways**

- `extern` declares; a file-scope definition allocates. Declare in the header, define in exactly one `.c` file.
- Defining a variable in a header causes duplicate-symbol errors in every file that includes it (and GCC 10+ no longer merges them).
- `extern` on function prototypes is redundant — functions have external linkage by default.
- `int x;` at file scope is a tentative definition that becomes a zero-initialized definition if nothing else defines it.
- Globals couple modules and break reentrancy; prefer explicit parameters or accessor functions, and mark read-only globals `const`.

> 🧪 Practice
>
> 1. Build the three-file example above. Then move `int verbosity = 0;` into `config.h` and read the linker error carefully.
> 2. Declare `extern int missing;` and use it without defining it anywhere. Compare the error message to the previous one and identify which tool produced each.
> 3. Add a second `.c` file that also modifies `verbosity`, and confirm all files see the same object by printing `&verbosity` from each.
> 4. Interview-style: *"How would you expose a global counter to other modules while keeping the ability to add a mutex later?"* Hint: what does an accessor function let you change that an `extern` variable does not?

#### register and inline

**Theory**

These two keywords are both hints about performance, and both are widely misunderstood — one is obsolete, the other is subtle.

**`register`** asked the compiler to keep a variable in a CPU register instead of memory. In 1972, with primitive compilers, this genuinely helped. Today every optimizing compiler does register allocation far better than a human can annotate, and the hint is ignored. One real effect remains: **you cannot take the address of a `register` variable** — `&x` is a compile error. That is occasionally used to enforce "this must never escape", but the keyword is otherwise dead code. C++17 removed it; C23 keeps it only for compatibility. Do not write it in new code.

**`inline`** (C99) is the interesting one. Function calls have overhead — arguments set up, a jump, a frame, a return — and for a tiny function that overhead can dominate. Inlining substitutes the body at the call site, eliminating the call and, more importantly, exposing the body to optimization in the caller's context.

The critical point: **`inline` is not a command, and it is primarily a linkage rule, not an optimization directive.** Compilers inline aggressively at `-O2` without any keyword, and they refuse to inline when they judge it unprofitable (large bodies, recursion, address-taken functions) even when you write it. What `inline` actually changes is what the linker sees, and C's rule here is genuinely tricky:

- `inline void f(void) { ... }` in a header provides an **inline definition**, which does *not* create an external symbol. If the compiler decides not to inline a call, the linker needs a real function somewhere — and finds none. The result is the classic "undefined reference to `f`" at `-O0`.
- Exactly one translation unit must provide an **external definition**, written either as `extern inline void f(void);` (a declaration with `extern` in a `.c` file, which emits the symbol) or by defining it without `inline`.
- `static inline` in a header sidesteps all of this: each translation unit gets its own private copy, no external symbol is needed, and there is no linker puzzle. **This is what nearly all real C code uses.**

C++ has different rules here; do not carry the intuition across.

**Examples**

```c
/* ---------- vec.h : the idiomatic pattern ---------- */
#ifndef VEC_H
#define VEC_H

/* static inline: safe in a header, no linker rules to remember,
   each translation unit gets its own copy that the compiler may inline. */
static inline int imax(int a, int b)
{
    return a > b ? a : b;
}

static inline int clamp(int v, int lo, int hi)
{
    return imax(lo, v < hi ? v : hi);
}

#endif
```

```c
/* ---------- The C99 'inline' rule, demonstrated ---------- */
/* fast.h */
inline int square(int x) { return x * x; }   /* inline definition: no symbol emitted */

/* fast.c */
#include "fast.h"
extern int square(int x);   /* THIS line emits the external definition.
                               Without it, a non-inlined call fails at link time. */

/* main.c */
#include <stdio.h>
#include "fast.h"
int main(void) { printf("%d\n", square(7)); return 0; }
```

```c
/* ---------- register: what it still does ---------- */
#include <stdio.h>

int main(void)
{
    register int fast = 42;   /* the hint is ignored by modern compilers */
    printf("%d\n", fast);
    /* int *p = &fast; */     /* ERROR: cannot take the address of a register variable */
    return 0;
}
```

| Form | Where to write it | Emits a symbol? | Use it? |
| --- | --- | --- | --- |
| `static inline f() {...}` | Header | Per-TU, internal | Yes — the default choice |
| `inline f() {...}` | Header | No | Only with a matching `extern` declaration |
| `extern inline f();` | Exactly one `.c` | Yes | Pair with the above |
| `register int x;` | Anywhere | n/a | No — obsolete |

**Key Takeaways**

- `register` is obsolete; its only surviving effect is forbidding `&x`. Modern compilers allocate registers better than annotations can.
- `inline` is a hint the compiler may ignore, and at `-O2` it inlines plenty without the keyword.
- C99 `inline` is chiefly a linkage rule: a bare `inline` definition emits no symbol, causing link errors when a call is not inlined.
- `static inline` in a header is the practical idiom — no external symbol, no linker subtleties.
- Do not apply C++ `inline` intuition to C; the rules genuinely differ.

> 🧪 Practice
>
> 1. Write `inline int square(int x) { return x * x; }` in a header, call it from two `.c` files, and build at `-O0`. Read the link error, then fix it with `extern inline` in one file.
> 2. Change the same function to `static inline`, rebuild at `-O0` and `-O2`, and compare object-file symbols with `nm`.
> 3. Try to take the address of a `register` variable and record the exact error message from your compiler.
> 4. Interview-style: *"Does marking a function `inline` make it faster?"* Hint: separate what the keyword promises the linker from what the optimizer decides, and consider instruction-cache pressure.

#### Name Shadowing

**Theory**

When an inner scope declares a name that already exists in an enclosing scope, the inner declaration **shadows** the outer one: within the inner scope, the name refers to the new object, and the outer one is temporarily unreachable. It is not an error; C is designed this way so that an inner block never needs to know what names its surroundings use.

Shadowing is what makes locals safe. Without it, adding a global named `count` to a program could break every function that happened to use `count` as a local. With it, the innermost declaration always wins.

The danger is not the rule but the confusion it enables. Three patterns cause real bugs:

**Accidental shadowing during refactoring.** You add a local `n` to a function that already reads a global `n`, and the rest of the function silently switches meaning.

**Shadowing a parameter in a nested block.** The inner assignment appears to modify the argument but modifies a different object.

**Shadowing standard library names.** A local named `index`, `time`, `read`, `link`, or `remove` compiles (POSIX declares these functions), and then a call to the real function fails obscurely.

`-Wshadow` reports all of it. Many projects enable it; a few find it noisy because inner loops legitimately reuse `i`. A good compromise is to enable it and rename rather than suppress.

Related, and distinct: **redeclaration in the same scope** is an error, not shadowing (`int x; int x;` inside one block). And a shadowed variable is only hidden, not destroyed — the outer object still exists and keeps its value.

**Examples**

```c
#include <stdio.h>

int value = 100;                /* file scope */

void shadow_demo(int value)     /* parameter shadows the global */
{
    printf("parameter shadows global: %d\n", value);   /* the parameter */

    {
        int value = 20;         /* shadows the parameter */
        printf("block shadows parameter: %d\n", value);
        value = 30;             /* modifies the innermost object ONLY */
    }

    printf("parameter unchanged: %d\n", value);        /* still the argument */
}

/* A realistic bug: the inner 'total' looks like an accumulator but is not. */
int sum_broken(const int *a, size_t n)
{
    int total = 0;
    for (size_t i = 0; i < n; i++) {
        int total = a[i];       /* SHADOWS -- reported by -Wshadow */
        (void)total;            /* the outer total never changes */
    }
    return total;               /* always 0 */
}

int sum_fixed(const int *a, size_t n)
{
    int total = 0;
    for (size_t i = 0; i < n; i++)
        total += a[i];          /* one 'total', the outer one */
    return total;
}

int main(void)
{
    shadow_demo(7);
    printf("global still: %d\n", value);   /* 100 -- never touched */

    int data[] = { 1, 2, 3, 4 };
    printf("broken=%d fixed=%d\n",
           sum_broken(data, 4), sum_fixed(data, 4));   /* 0 and 10 */
    return 0;
}
```

```text
   Name lookup for 'value' proceeds outward until a match is found:

   innermost block  --> int value = 20;      <-- found, stop
        |
   function body    --> int value (parameter)
        |
   file scope       --> int value = 100;
        |
   (not found)      --> compile error
```

**Key Takeaways**

- An inner declaration hides an outer one of the same name; lookup always resolves to the innermost declaration in scope.
- Shadowing is legal and useful — it decouples inner blocks from the names used around them.
- Accidental shadowing silently changes meaning, especially when refactoring or when the shadowed name is a global or a library function.
- Compile with `-Wshadow` and fix by renaming rather than suppressing.
- Redeclaring a name in the *same* scope is an error; shadowing requires a nested scope.

> 🧪 Practice
>
> 1. Reproduce `sum_broken`, compile with `-Wall -Wextra` (note it may not warn) and then with `-Wshadow`, and compare.
> 2. Declare a local variable named `index` or `time`, then call the standard function of that name in the same scope, and read the resulting error.
> 3. Write a function where a parameter is shadowed inside an `if` block; print addresses to prove there are two distinct objects.
> 4. Interview-style: *"Is shadowing a language flaw or a feature?"* Hint: imagine adding one new global to a million-line codebase without it.

<a id="43-multi-file-programs"></a>
### 4.3 Multi-File Programs

Beyond a few hundred lines, a C program lives in many files. This section covers the machinery that makes that work: headers and the guards that keep them safe, the interface/implementation split, the linkage rules that decide which names cross file boundaries, how to untangle circular dependencies, and how a build system turns a directory of sources into a binary.

#### Header Files and Include Guards

**Theory**

The preprocessor's `#include` is textual: it replaces the directive with the entire contents of the named file, before the compiler sees anything (Chapter 1.3, Chapter 8.1). Nothing more sophisticated happens — no module system, no import resolution, no deduplication.

That simplicity creates one immediate hazard. If `a.h` includes `common.h` and `b.h` includes `common.h`, then a file including both gets `common.h` twice. Duplicated `struct` definitions, `typedef`s, and `enum`s are errors; the translation unit will not compile.

The fix is the **include guard**: a preprocessor conditional that makes the second and later inclusions expand to nothing.

```c
#ifndef PROJECT_MODULE_H       /* first time: not defined, so we proceed */
#define PROJECT_MODULE_H       /* now it is defined */
... contents ...
#endif
```

The macro name must be unique across the whole program — including every library you link against. Use a project prefix and mirror the path: `MYLIB_NET_SOCKET_H` for `mylib/net/socket.h`. A bare `UTIL_H` collides sooner than you expect, and the symptom is bizarre: a header silently vanishes.

`#pragma once` does the same job in one line and is supported by GCC, Clang, and MSVC, but it is not in the C standard and can misbehave when the same file is reachable by two paths (symlinks, hard links, bind mounts) — implementations compare files, not names, but the heuristics differ. Guards are the portable choice; many projects use both.

What belongs in a header, and what does not:

| Put in the header (`.h`) | Keep in the source (`.c`) |
| --- | --- |
| Function prototypes | Function definitions |
| `extern` variable declarations | Variable definitions |
| `struct`/`union`/`enum` definitions the caller needs | Types private to the module |
| `typedef`s | Static helper functions |
| Macros that are part of the interface | Implementation-only macros |
| `static inline` small functions | Everything else |

Two further rules keep headers healthy. **Headers should be self-contained**: including a header first in an otherwise empty file must compile, meaning it includes what it needs. And **include what you use**: do not rely on a header transitively pulling in `<stddef.h>` for you.

Finally, note the two include forms. `#include "local.h"` searches the current directory first, then the system paths; `#include <system.h>` searches only the configured include paths (`-I` adds to them). Use quotes for your project's headers and angle brackets for the standard library and installed dependencies.

**Examples**

```c
/* ---------- stack.h : a complete, well-formed header ---------- */
#ifndef MYPROJ_STACK_H          /* unique, path-mirroring guard name */
#define MYPROJ_STACK_H

#include <stddef.h>             /* self-contained: we use size_t below */

typedef struct {                /* the caller needs the layout to declare one */
    int    *data;
    size_t  len;
    size_t  cap;
} Stack;

int  stack_init(Stack *s, size_t capacity);   /* prototypes only */
void stack_free(Stack *s);
int  stack_push(Stack *s, int value);
int  stack_pop(Stack *s, int *out);

/* Small enough to inline; 'static inline' avoids all linker subtleties. */
static inline size_t stack_len(const Stack *s) { return s->len; }

#endif /* MYPROJ_STACK_H */
```

```c
/* ---------- Why the guard matters ---------- */
/* a.h */
#ifndef A_H
#define A_H
#include "stack.h"
#endif

/* b.h */
#ifndef B_H
#define B_H
#include "stack.h"          /* second inclusion of stack.h ... */
#endif

/* main.c */
#include "a.h"
#include "b.h"              /* ... but the guard makes it expand to nothing */
int main(void) { Stack s; (void)s; return 0; }
/* Without the guard in stack.h: "error: redefinition of 'Stack'" */
```

```text
   Preprocessing main.c

   #include "a.h"  --> #include "stack.h"
                          MYPROJ_STACK_H not defined -> define it, emit contents
   #include "b.h"  --> #include "stack.h"
                          MYPROJ_STACK_H IS defined  -> emit nothing
                                                        ^
                                        the guard turned an error into a no-op
```

**Key Takeaways**

- `#include` is plain text substitution; without protection, a header included twice defines its types twice.
- Wrap every header in `#ifndef`/`#define`/`#endif` with a project-unique, path-mirroring macro name.
- `#pragma once` is shorter and widely supported but non-standard; guards are the portable baseline.
- Headers hold declarations, type definitions, and `static inline` helpers — never definitions of functions or variables.
- Make every header self-contained and include what you use rather than relying on transitive includes.

> 🧪 Practice
>
> 1. Create a header defining a `struct` without a guard, include it twice from one `.c`, and read the error. Add the guard and rebuild.
> 2. Give two different headers the same guard macro (`UTIL_H`) and include both. Explain why the second header's contents disappear.
> 3. Write a header that uses `size_t` without including `<stddef.h>`; compile it first in an empty `.c` and observe. Then make it self-contained.
> 4. Interview-style: *"What are the trade-offs between `#pragma once` and include guards?"* Hint: think about symlinks, build-system copies, and what the standard actually specifies.

#### Separating Interface from Implementation

**Theory**

A header is a **contract**. It states what a module offers; the `.c` file states how. Callers compile against the contract and never see the implementation, so the implementation can change freely as long as the contract holds. This is C's version of encapsulation, enforced by convention and by linkage rather than by an `private` keyword.

Getting the boundary right buys three things: **faster builds** (changing a `.c` file recompiles one object; changing a header recompiles every file that includes it), **safer refactoring** (nothing outside can depend on what it cannot see), and **readable modules** (the header is the documentation).

The strongest tool for hiding implementation is the **opaque pointer** (also called a handle, or the "pimpl" idiom in C++). The header declares a struct tag *without* defining it:

```c
typedef struct Database Database;    /* incomplete type: size unknown */
Database *db_open(const char *path);
```

Callers can hold a `Database *` but cannot dereference it, cannot declare a `Database` by value, and cannot depend on its fields — because they do not know them. The full `struct Database { ... };` lives in `database.c`. The cost is that every instance must be heap-allocated (the caller cannot know the size), and every access goes through a function call. In exchange, you can add, remove, or reorder fields without recompiling — or even relinking — anything else.

When the type must be transparent (a small `Point`, a `Vec3` you want on the stack and inlined), define it in the header and accept the coupling. The choice is a real trade-off:

| Approach | Caller can | Changing the struct requires | Use when |
| --- | --- | --- | --- |
| Full struct in header | Stack-allocate, access fields, inline | Recompiling all users | Small, stable value types |
| Opaque pointer | Only pass the pointer to your functions | Recompiling only the module | Resource handles, evolving types |

Conventions that keep interfaces coherent: prefix every exported name with the module name (`stack_push`, not `push`), so the global namespace stays navigable; mark everything not in the header `static`; document ownership in the header (who frees what); and keep the header free of implementation-only includes so it does not leak dependencies to every caller.

**Examples**

```c
/* ---------- counter.h : the entire public contract ---------- */
#ifndef MYPROJ_COUNTER_H
#define MYPROJ_COUNTER_H

/* Opaque type: callers get a handle, not a layout. */
typedef struct Counter Counter;

Counter *counter_create(const char *name);   /* returns NULL on failure;
                                                caller owns the result */
void     counter_destroy(Counter *c);        /* safe on NULL */
void     counter_increment(Counter *c);
long     counter_value(const Counter *c);

#endif
```

```c
/* ---------- counter.c : everything private lives here ---------- */
#include <stdlib.h>
#include <string.h>
#include "counter.h"        /* include our own header: the compiler now checks
                               that our definitions match our declarations */

struct Counter {            /* the real layout -- invisible to callers */
    char *name;
    long  value;
    long  overflow_count;   /* added later; NO caller needs recompiling */
};

static char *dup_string(const char *s)   /* static: private helper, no symbol */
{
    size_t n = strlen(s) + 1;
    char *p = malloc(n);
    return p ? memcpy(p, s, n) : NULL;
}

Counter *counter_create(const char *name)
{
    Counter *c = malloc(sizeof *c);
    if (!c) return NULL;
    c->name = dup_string(name);
    if (!c->name) { free(c); return NULL; }
    c->value = c->overflow_count = 0;
    return c;
}

void counter_destroy(Counter *c)
{
    if (!c) return;                 /* free(NULL)-style tolerance */
    free(c->name);
    free(c);
}

void counter_increment(Counter *c) { c->value++; }
long counter_value(const Counter *c) { return c->value; }
```

```c
/* ---------- main.c : sees the contract only ---------- */
#include <stdio.h>
#include "counter.h"

int main(void)
{
    Counter *c = counter_create("hits");
    if (!c) return 1;
    /* Counter local;      <-- ERROR: incomplete type, size unknown */
    /* c->value = 99;      <-- ERROR: dereferencing an incomplete type */
    counter_increment(c);
    counter_increment(c);
    printf("value = %ld\n", counter_value(c));
    counter_destroy(c);
    return 0;
}
```

```text
   main.c knows:                 counter.c knows:
   +---------------------+       +--------------------------+
   | typedef struct      |       | struct Counter {         |
   |   Counter Counter;  |       |   char *name;            |
   | counter_create()    |       |   long value;            |
   | counter_increment() |       |   long overflow_count;   |
   | counter_value()     |       | };                       |
   | counter_destroy()   |       | static char *dup_string()|
   +---------------------+       +--------------------------+
        the contract                 the implementation
        (stable)                     (free to change)
```

**Key Takeaways**

- The header is a contract; the `.c` file is an implementation detail that callers must not be able to depend on.
- Opaque pointers (`typedef struct T T;` with the definition in the `.c`) give real encapsulation at the cost of heap allocation and function-call access.
- Expose full struct definitions only for small, stable value types you want stack-allocated and inlined.
- Always include a module's own header in its `.c` so declaration/definition mismatches fail at compile time.
- Prefix exported names by module, mark everything else `static`, and document ownership in the header.

> 🧪 Practice
>
> 1. Build the `Counter` module above, then add a field to `struct Counter` and confirm that only `counter.c` needs recompiling.
> 2. Try to declare `Counter c;` on the stack in `main.c` and explain the "incomplete type" error precisely.
> 3. Convert a transparent struct module you have written into an opaque-pointer module; list what capabilities the caller lost.
> 4. Interview-style: *"How do you achieve information hiding in C, which has no `private`?"* Hint: two mechanisms — one for types, one for names — and both are compile/link-time, not run-time.

#### Internal vs External Linkage

**Theory**

**Linkage** determines whether declarations of the same name in different scopes or different translation units refer to the same entity. It is the third property of every identifier, alongside scope and storage duration, and it is the one the *linker* cares about.

C defines three kinds:

| Linkage | Meaning | How to get it |
| --- | --- | --- |
| **External** | One entity shared across the whole program | File-scope functions and variables, by default |
| **Internal** | One entity per translation unit, private to it | `static` at file scope |
| **None** | The entity is unique to its declaration | Block-scope variables, parameters, type names |

The practical model: after compiling, each `.o` file carries a symbol table listing names it **defines** and names it **needs**. External-linkage names appear there and are matched up by the linker. Internal-linkage names do not — they are local details, invisible outside the object file.

This gives you C's access control:

- **Public**: declared in the header, defined non-`static` in the `.c`.
- **Private**: declared and defined `static` in the `.c`, never in the header.

Making helpers `static` is not merely tidiness. It prevents name collisions across the program (two modules can each have a `static int helper(void)`), it lets the compiler inline and optimize more aggressively because it knows every call site, it lets the linker discard unused code, and it shrinks the exported symbol table.

Two rules govern definitions:

**One Definition Rule (linker view)**: each external-linkage entity must be defined exactly once in the whole program. Zero definitions gives "undefined reference"; two gives "multiple definition".

**Consistency**: all declarations of the same external name must have compatible types. The compiler cannot check across files — it only sees one at a time — so a mismatch produces silent, undefined behavior. This is exactly why the shared header exists: it forces every file, including the defining one, to see the same declaration. Link-time optimization (`-flto`) can detect some of these mismatches.

A confusing corner: `static` on a *block-scope* variable does not affect linkage at all (block-scope variables have no linkage) — it changes storage duration, as covered in Chapter 4.2. Same keyword, unrelated meaning.

**Examples**

```c
/* ---------- module.c ---------- */
#include <stdio.h>
#include "module.h"

int shared_total = 0;               /* EXTERNAL linkage: other files can see it */
static int call_count = 0;          /* INTERNAL: private to module.c            */

static void log_call(const char *who)   /* INTERNAL: no symbol exported */
{
    call_count++;
    printf("[%d] %s\n", call_count, who);
}

void module_add(int n)              /* EXTERNAL: part of the public interface */
{
    log_call("module_add");
    shared_total += n;
}
```

```c
/* ---------- other.c : a second module with its OWN log_call ---------- */
#include <stdio.h>

static void log_call(const char *who)   /* No conflict: internal linkage means
                                           this is a different function entirely */
{
    printf("other: %s\n", who);
}

void other_work(void) { log_call("other_work"); }
```

```bash
# Inspect the symbol tables to see linkage made concrete.
gcc -c module.c other.c
nm module.o
# 0000000000000000 T module_add        <- 'T': external, defined here
#                  U printf            <- 'U': external, needed from elsewhere
# 0000000000000000 B shared_total      <- 'B': external, uninitialized data
# 0000000000000004 b call_count        <- lowercase 'b': INTERNAL (static)
# 0000000000000000 t log_call          <- lowercase 't': INTERNAL (static)
#
# Lowercase = local to this object file. Uppercase = visible to the linker.
```

```text
   module.o                          other.o
   +--------------------+            +--------------------+
   | T module_add       |            | T other_work       |
   | B shared_total     |            | t log_call  (own)  |
   | t log_call (own)   |            +--------------------+
   | U printf           |
   +--------------------+
            \                       /
             +------ linker -------+
                      |
        matches U (needed) against T/B (defined).
        The two 't log_call' entries never meet: internal linkage.
```

**Key Takeaways**

- Linkage decides whether two declarations of a name refer to the same entity; external crosses files, internal does not, block-scope has none.
- File-scope functions and variables are external by default; `static` at file scope makes them internal.
- Mark every helper not in the header `static`: it prevents collisions, enables optimization, and keeps the symbol table small.
- Each external entity needs exactly one definition program-wide — zero gives "undefined reference", two gives "multiple definition".
- Cross-file type mismatches are undefined behavior the compiler cannot catch; a shared header included everywhere is the defense.

> 🧪 Practice
>
> 1. Define a non-`static` function with the same name in two `.c` files and link them; read the error. Add `static` to both and confirm it links.
> 2. Run `nm` on an object file from your own project and classify five symbols as external or internal by their letter case.
> 3. Declare `extern int x;` in one file and define `long x = 5;` in another, then print `x` from the first. Explain the garbage, and see whether `-flto` catches it.
> 4. Interview-style: *"What does `static` mean in C?"* Hint: the correct answer is a question back — at file scope or at block scope? — and two different explanations.

#### Circular Dependencies

**Theory**

A circular dependency exists when module A needs something from B and B needs something from A. The textual `#include` model handles this badly: with guards in place, the second inclusion is empty, so one of the two files sees an incomplete picture and the compile fails with errors like "unknown type name" that point at a perfectly reasonable line.

Trace it: `a.h` includes `b.h`, which includes `a.h`. The guard for `a.h` is already defined, so the inner include yields nothing, and `b.h` continues without `a.h`'s types. Whether it compiles then depends on which file was included first — a genuinely order-dependent build.

Three techniques resolve it, in order of preference.

**1. Forward-declare instead of including.** If a header only needs a *pointer* to a type, it does not need the type's definition — an incomplete type suffices:

```c
struct Employee;                    /* forward declaration: no #include needed */
struct Department { struct Employee **staff; size_t n; };
```

Pointers to incomplete types are legal because their size is known. The full definition is only required where the pointer is dereferenced or the struct declared by value — which is in the `.c`, not the header. This eliminates most cycles and speeds up builds by removing header edges.

**2. Extract the shared part into a third header.** If A and B both need common types, move them to `common.h` and have both include it. The cycle A -> B -> A becomes A -> C, B -> C: a tree.

**3. Reconsider the design.** A genuine cycle often means the two modules are really one, or that the dependency should be inverted with a callback. If `logger` needs `config` and `config` needs `logger`, pass a log function pointer into `config` instead of having it reach back.

Note that circular dependencies *between `.c` files* are perfectly fine — `a.c` may call functions in `b.c` and vice versa, because the linker resolves all symbols simultaneously. The problem is specifically about *headers*, which are processed sequentially.

**Examples**

```c
/* ---------- BROKEN: a real cycle ---------- */
/* employee.h */
#ifndef EMPLOYEE_H
#define EMPLOYEE_H
#include "department.h"            /* needs Department */
struct Employee { char name[64]; struct Department *dept; };
#endif

/* department.h */
#ifndef DEPARTMENT_H
#define DEPARTMENT_H
#include "employee.h"              /* needs Employee -> CYCLE */
struct Department { char name[64]; struct Employee *head; };
#endif
/* Compiling a file that includes employee.h first:
   employee.h -> department.h -> employee.h (guard already set: EMPTY)
   -> department.h continues, 'struct Employee' unknown -> error */
```

```c
/* ---------- FIXED: forward declarations break the cycle ---------- */
/* employee.h */
#ifndef EMPLOYEE_H
#define EMPLOYEE_H

struct Department;                 /* incomplete type; a pointer to it is fine */

struct Employee {
    char name[64];
    struct Department *dept;       /* pointer: size known without the definition */
};

void employee_print(const struct Employee *e);
#endif
```

```c
/* department.h */
#ifndef DEPARTMENT_H
#define DEPARTMENT_H

struct Employee;                   /* the mirror image; still no #include */

struct Department {
    char name[64];
    struct Employee *head;
};

void department_print(const struct Department *d);
#endif
```

```c
/* department.c : the ONLY place that needs both full definitions */
#include <stdio.h>
#include "department.h"
#include "employee.h"              /* now the complete type is available */

void department_print(const struct Department *d)
{
    printf("%s, head: %s\n", d->name, d->head ? d->head->name : "(vacant)");
    /* d->head->name requires the COMPLETE struct Employee -- hence the include */
}
```

```text
   Before                    After
   a.h <---> b.h             a.h      b.h
     (cycle: neither          |        |
      can be first)           +---> a.c/b.c include both
                             (headers depend on nothing)

   Rule of thumb:
     need only 'struct T *'  -> forward declare
     need sizeof, members,
       or a by-value T       -> #include
```

**Key Takeaways**

- Header cycles break because include guards make the second inclusion empty, leaving one file with missing types.
- Forward-declare (`struct T;`) whenever a header needs only a pointer — this removes most cycles and speeds up builds.
- A complete definition is needed only for by-value use, member access, or `sizeof`, and that belongs in the `.c`.
- If both headers need shared types, factor them into a third header both include.
- Cycles between `.c` files are fine; the linker resolves all symbols at once. Only header cycles are a problem.

> 🧪 Practice
>
> 1. Build the broken employee/department pair, read the error, then fix it with forward declarations.
> 2. Take a header in your project and replace every `#include` used only for pointer types with a forward declaration; measure the change in build time.
> 3. Construct a case where forward declaration is *not* enough (a struct containing another struct by value) and explain why.
> 4. Interview-style: *"Two modules genuinely need each other. What do you do?"* Hint: forward declarations first; if that fails, ask whether the dependency can be inverted with a callback or whether it is really one module.

#### Build Systems and Makefiles

**Theory**

Once a project has more than a handful of files, rebuilding everything on every change wastes minutes and typing `gcc` by hand invites mistakes. A build system solves two problems: **correctness** (rebuild exactly what the change affected — no more, no less) and **automation** (one command produces the artifact).

`make` is the classic answer, and understanding it makes every other build tool legible. Its model is a dependency graph of **rules**:

```make
target: prerequisites
	recipe        # MUST be indented with a TAB, not spaces
```

`make` compares timestamps: if any prerequisite is newer than the target, it runs the recipe. Applied recursively, this rebuilds only what is stale. `foo.o` depends on `foo.c`; the program depends on all the `.o` files. Change one `.c` and exactly one `.o` is rebuilt, then the link runs.

There is a trap here that bites every C project. `foo.o` also depends on every header `foo.c` includes — but `make` cannot know that unless you tell it. Edit a header, and `make` sees no change to `foo.c` and skips the rebuild, leaving object files compiled against different versions of a struct. The result is memory corruption at run time, and the classic fix is `make clean` (which admits defeat).

The real fix is **automatic dependency generation**. GCC and Clang's `-MMD -MP` flags emit a `.d` file per object listing its header dependencies in `make` syntax; `-include $(DEPS)` pulls them in. This is the single most important thing to get right in a hand-written Makefile.

Useful mechanics, compactly:

| Feature | Meaning |
| --- | --- |
| `$@` | The target |
| `$<` | The first prerequisite |
| `$^` | All prerequisites, deduplicated |
| `%.o: %.c` | Pattern rule: how to make any `.o` from its `.c` |
| `:=` vs `=` | Immediate vs lazily-expanded assignment (prefer `:=`) |
| `.PHONY` | Targets that are commands, not files (`clean`, `all`) |
| `make -j8` | Run 8 recipes in parallel |
| `CC`, `CFLAGS`, `LDFLAGS` | Conventional variables users expect to override |

Beyond `make`: **CMake** generates build files for many platforms and toolchains and is the de-facto standard for portable C/C++ projects; **Ninja** is a fast low-level executor that CMake usually targets; **Meson** is a modern, more opinionated front end. All of them solve the same dependency-graph problem — `make` just makes the graph visible.

**Examples**

```make
# ---------- A small but correct Makefile ----------
CC      := gcc
CFLAGS  := -std=c17 -Wall -Wextra -Wpedantic -Wshadow -g -MMD -MP
LDFLAGS :=
LDLIBS  := -lm

TARGET  := app
SRCS    := $(wildcard src/*.c)          # every .c under src/
OBJS    := $(SRCS:.c=.o)                # same names with .o
DEPS    := $(OBJS:.o=.d)                # the generated dependency files

.PHONY: all clean run

all: $(TARGET)

# Link: $@ is 'app', $^ is every object file.
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

# Pattern rule -- compile any .c into the matching .o.
# $< is the .c file; -MMD -MP (in CFLAGS) also writes src/foo.d
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Pull in the generated header dependencies. The leading '-' means
# "do not fail on the first build, when no .d files exist yet".
-include $(DEPS)

clean:
	rm -f $(TARGET) $(OBJS) $(DEPS)

run: $(TARGET)
	./$(TARGET)
```

```text
   What -MMD generates (src/main.d), in make's own syntax:

   src/main.o: src/main.c src/stack.h src/config.h
   src/stack.h:            <- the -MP part: empty rules so a DELETED header
   src/config.h:              does not break the build with "no rule to make"

   Result: touching src/stack.h now correctly rebuilds src/main.o.
```

```bash
# Typical usage
make            # build only what changed
make -j$(nproc) # parallel build
make clean all  # from scratch
make CC=clang CFLAGS="-O2 -DNDEBUG"   # override conventional variables
```

The equivalent in CMake, for comparison:

```cmake
cmake_minimum_required(VERSION 3.16)
project(app C)
set(CMAKE_C_STANDARD 17)
add_executable(app src/main.c src/stack.c)   # dependencies tracked automatically
target_compile_options(app PRIVATE -Wall -Wextra)
target_link_libraries(app PRIVATE m)
```

**Key Takeaways**

- A build system exists to rebuild exactly what a change affected and to make the build one reproducible command.
- `make` rules are `target: prerequisites` plus a TAB-indented recipe, and rebuilds are driven by file timestamps.
- Object files depend on headers too; without generated dependencies, editing a header silently produces a stale, corrupt build.
- Always compile with `-MMD -MP` and `-include` the resulting `.d` files — this is the fix, not `make clean`.
- Use `$@`, `$<`, `$^`, pattern rules, and `.PHONY`; respect `CC`/`CFLAGS`/`LDFLAGS` so users can override them.
- For portable or larger projects, CMake (usually generating Ninja) is the practical standard.

> 🧪 Practice
>
> 1. Write the Makefile above for a three-file project. Touch one `.c` and confirm only one `.o` rebuilds.
> 2. Remove `-MMD -MP` and the `-include` line, edit a header that changes a struct's size, rebuild, and observe the stale-object bug. Restore them and confirm it is fixed.
> 3. Add a `debug` target using `-fsanitize=address,undefined -g` and a `release` target using `-O2 -DNDEBUG`, and compare binary sizes.
> 4. Interview-style: *"Why does `make` need a dependency graph at all, instead of just recompiling everything?"* Hint: think about a project with 10,000 files and a one-line change, and then about what makes the graph hard to get right.

<a id="44-variadic-functions"></a>
### 4.4 Variadic Functions

`printf` accepts any number of arguments of any type — something no ordinary C prototype can express. This section covers the mechanism that makes it possible, how to write your own variadic functions correctly, and the type-safety hole the mechanism leaves open.

#### Ellipsis Parameters

**Theory**

Every function so far has had a fixed parameter list. A **variadic** function does not: it takes some fixed parameters followed by an unknown number of additional arguments, written as `...` (the ellipsis).

```c
int printf(const char *format, ...);
```

The rules are narrow and non-negotiable:

**At least one named parameter is required before the ellipsis** (in C17 and earlier; C23 relaxes this, but portable code should not rely on it). This is not arbitrary: the standard mechanism for walking the extra arguments starts from the last *named* one, so there must be one.

**The ellipsis comes last**, and there is exactly one.

**The callee cannot discover how many arguments were passed, or their types.** The language provides no count, no type tags, nothing. Every variadic function must derive this from the fixed parameters. There are only two workable conventions:

1. **A count parameter**: `int sum(int n, ...)` — the caller says how many follow.
2. **A sentinel**: `void print_all(const char *first, ...)` terminated by `NULL`, as `execl` does.
3. **A format string**: `printf`'s approach — the format describes both count and types.

**Arguments after the ellipsis undergo default argument promotions**, because there is no prototype to convert them against:

| Passed type | Actually received as |
| --- | --- |
| `char`, `signed char`, `unsigned char`, `short`, `_Bool` | `int` |
| `float` | `double` |
| everything else (`int`, `long`, `double`, pointers, structs) | unchanged |

This is why `va_arg(ap, char)` is always wrong — you must ask for `int`. And it is why `%f` in `printf` works for both `float` and `double` arguments: by the time `printf` sees it, a `float` has already become a `double`.

One more consequence: because there is no prototype for the variable part, **no conversion happens at the call site**. `printf("%ld\n", 5)` passes an `int` where `printf` will read a `long` — undefined behavior, not a silent conversion. Getting the types exactly right at the call site is the caller's job.

**Examples**

```c
#include <stdio.h>
#include <stdarg.h>

/* Convention 1: an explicit count in a fixed parameter. */
int sum(int count, ...)                 /* 'count' is named; '...' is the rest */
{
    va_list ap;
    va_start(ap, count);                /* start after the LAST NAMED parameter */
    int total = 0;
    for (int i = 0; i < count; i++)
        total += va_arg(ap, int);       /* 'int', because of default promotions */
    va_end(ap);
    return total;
}

/* Convention 2: a NULL sentinel terminates the list. */
void print_words(const char *first, ...)
{
    va_list ap;
    va_start(ap, first);
    for (const char *s = first; s != NULL; s = va_arg(ap, const char *))
        printf("%s ", s);
    va_end(ap);
    putchar('\n');
}

/* Demonstrating default argument promotions. */
void show_promotions(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    /* A char argument arrives as int; a float arrives as double. */
    int  c = va_arg(ap, int);           /* NOT va_arg(ap, char) -- that is UB */
    double f = va_arg(ap, double);      /* NOT float */
    va_end(ap);
    printf("char-as-int = %d ('%c'), float-as-double = %.2f\n", c, c, f);
}

int main(void)
{
    printf("sum        = %d\n", sum(4, 10, 20, 30, 40));
    print_words("variadic", "functions", "in", "C", NULL);   /* sentinel required */
    show_promotions(2, 'A', 3.5f);      /* 'A' promotes to int, 3.5f to double */
    return 0;
}
```

```text
   Call:  sum(4, 10, 20, 30, 40)

   +-------+   +----+----+----+----+
   | count |   | 10 | 20 | 30 | 40 |   <- no type or count information
   +-------+   +----+----+----+----+      travels with these
      named           the "..." part
        |
        +--> the ONLY thing telling the callee there are four ints.
             Lie about it and you read past the arguments -> UB.
```

**Key Takeaways**

- `...` declares a variadic function; it must come last and (before C23) must follow at least one named parameter.
- The callee gets no count and no type information — it must be conveyed by a count parameter, a sentinel, or a format string.
- Arguments in the variable part undergo default promotions: `char`/`short`/`_Bool` become `int`, `float` becomes `double`.
- No conversion happens at the call site for variadic arguments, so the caller must pass exactly the type the callee will read.
- Never retrieve a promoted type with its original name (`va_arg(ap, char)` and `va_arg(ap, float)` are always wrong).

> 🧪 Practice
>
> 1. Write `double average(int count, ...)` and call it with three and then five `double` arguments. Then pass integer literals and explain the wrong result.
> 2. Write a sentinel-terminated `int max_of(int first, ...)` ending at a negative value, and document the convention in a comment.
> 3. Call `print_words` without the terminating `NULL` and observe the crash or garbage. Explain what the loop read.
> 4. Interview-style: *"Why must a variadic function have at least one named parameter?"* Hint: consider what `va_start` needs as its second argument, and how the traditional implementation located the next argument.

#### va_list, va_start, va_arg, va_end

**Theory**

`<stdarg.h>` provides the portable interface for walking the anonymous arguments. It is four pieces (five in C99), and the discipline is rigid.

**`va_list`** is an opaque cursor object holding the state of the walk. On some ABIs it is a pointer; on x86-64 System V it is a small struct tracking register-save areas and an overflow pointer. Never assume a representation, never copy it with `=`, never inspect it.

**`va_start(ap, last_named)`** initializes the cursor. The second argument must be the name of the last *named* parameter — this is exactly why one is required. (C23 allows `va_start(ap)` with the parameter omitted.)

**`va_arg(ap, type)`** returns the next argument, interpreted as `type`, and advances the cursor. This is the dangerous operation: it does not verify anything. If the actual argument was a `double` and you ask for `int`, you get garbage and the cursor advances by the wrong amount, corrupting every subsequent read. Remember the promotions: ask for `int`, not `char`; `double`, not `float`.

**`va_end(ap)`** performs any cleanup the implementation needs. It is a no-op on many platforms and mandatory on all of them — omitting it is undefined behavior, and it must be called on every path out of the function, including early `return`s and error paths.

**`va_copy(dst, src)`** (C99) duplicates a cursor mid-walk. You need it whenever the list must be traversed twice — the classic case being a formatting function that first measures the required buffer size and then formats into it, because the first pass consumes the list. The copy must itself be released with `va_end`.

Two more rules that catch people:

- **A `va_list` cannot be re-walked.** After `va_end`, or after reaching the end, you must `va_start` again (or have made a `va_copy` first).
- **You cannot pass a `va_list` to another variadic function**, only to a function that takes a `va_list` — which is why the standard library pairs every `printf` with a `vprintf`. This is the whole reason the `v`-prefixed family exists.

```text
   Every walk follows exactly this shape:

   va_list ap;
   va_start(ap, last_named);      <- initialize
       va_arg(ap, T);  ...        <- consume, in order, with the right types
   va_end(ap);                    <- release, on EVERY exit path
```

**Examples**

```c
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

/* Basic walk with a count. */
int sum(int count, ...)
{
    va_list ap;
    va_start(ap, count);
    int total = 0;
    for (int i = 0; i < count; i++)
        total += va_arg(ap, int);
    va_end(ap);                     /* mandatory */
    return total;
}

/* Early exit: va_end must still run on every path. */
int sum_capped(int count, int cap, ...)
{
    va_list ap;
    va_start(ap, cap);
    int total = 0;
    for (int i = 0; i < count; i++) {
        total += va_arg(ap, int);
        if (total > cap) {
            va_end(ap);             /* do NOT return without this */
            return cap;
        }
    }
    va_end(ap);
    return total;
}

/* va_copy: the list must be walked twice -- once to measure, once to build. */
char *join(const char *sep, int count, ...)
{
    va_list ap, ap2;
    va_start(ap, count);
    va_copy(ap2, ap);               /* snapshot BEFORE consuming ap */

    size_t need = 1;                             /* the terminating '\0' */
    for (int i = 0; i < count; i++) {
        need += strlen(va_arg(ap, const char *));
        if (i + 1 < count) need += strlen(sep);
    }
    va_end(ap);                                  /* first walk is finished */

    char *out = malloc(need);
    if (!out) { va_end(ap2); return NULL; }      /* release the copy too */

    out[0] = '\0';
    for (int i = 0; i < count; i++) {            /* second walk uses the copy */
        strcat(out, va_arg(ap2, const char *));
        if (i + 1 < count) strcat(out, sep);
    }
    va_end(ap2);
    return out;
}

int main(void)
{
    printf("sum        = %d\n", sum(3, 1, 2, 3));
    printf("sum_capped = %d\n", sum_capped(5, 10, 4, 4, 4, 4, 4));

    char *s = join(", ", 3, "alpha", "beta", "gamma");
    if (s) { printf("join       = %s\n", s); free(s); }
    return 0;
}
```

```text
   x86-64 System V: what va_list is actually tracking

   +----------------------+
   | gp_offset            |  next integer register slot
   | fp_offset            |  next floating-point register slot
   | overflow_arg_area  --+--> arguments that did not fit in registers (stack)
   | reg_save_area      --+--> where the prologue spilled the registers
   +----------------------+

   This is why va_list is opaque and why 'va_list b = a;' is not a copy:
   on some ABIs it is an array type, and on all of them the state is shared.
   Use va_copy.
```

**Key Takeaways**

- The sequence is fixed: `va_start`, zero or more `va_arg`, then `va_end` — on every exit path, including errors.
- `va_arg` performs no checking; the wrong type both returns garbage and misaligns every later read.
- Ask for promoted types: `int` for `char`/`short`/`_Bool`, `double` for `float`.
- A `va_list` is consumed by walking it; use `va_copy` (paired with its own `va_end`) when you need a second pass.
- You cannot forward a `va_list` to a variadic function — that is why `vprintf`, `vsnprintf`, and friends exist.

> 🧪 Practice
>
> 1. Write `int count_positive(int n, ...)` that walks `n` integers and counts the positive ones. Add an early `return` and make sure `va_end` runs on that path.
> 2. Deliberately call `va_arg(ap, double)` on an argument that was an `int`, print the result, and then print the *next* argument to see the cursor damage.
> 3. Implement `join` above without `va_copy` by calling `va_start` a second time; explain when each approach is valid.
> 4. Interview-style: *"Why does the standard library provide both `printf` and `vprintf`?"* Hint: try to write a logging wrapper that adds a prefix and then forwards its arguments to `printf`.

#### Writing printf-Style Wrappers

**Theory**

The most common real use of variadics is not inventing a new calling convention — it is wrapping an existing one. You want `log_error("disk %s full at %d%%", name, pct)` to add a timestamp, a severity tag, and a newline, then hand everything to `fprintf`.

The obstacle is the rule from the previous topic: **a `va_list` cannot be passed to a variadic function.** `fprintf(stderr, fmt, ap)` does not forward the arguments; it passes the `va_list` object itself as the first conversion's argument, producing garbage.

The solution is the `v`-family. For nearly every variadic function in the standard library there is a counterpart taking a `va_list` instead of `...`:

| Variadic | `va_list` counterpart | Purpose |
| --- | --- | --- |
| `printf` | `vprintf` | Format to `stdout` |
| `fprintf` | `vfprintf` | Format to a stream |
| `sprintf` | `vsprintf` | Format to a buffer (unbounded — avoid) |
| `snprintf` | `vsnprintf` | Format to a bounded buffer (use this) |

So the wrapper pattern is always the same shape: take `...`, start a `va_list`, call the `v`-version, end the list.

Two refinements make the wrapper production-quality.

**Compiler-checked format strings.** GCC and Clang support `__attribute__((format(printf, m, n)))`, where `m` is the 1-based index of the format string parameter and `n` is the index of the first variadic argument. With it, the compiler applies full `-Wformat` checking to *your* function — catching `%d` with a `char *` at compile time. This single annotation recovers most of the type safety variadics give up, and it is the reason your wrapper should exist rather than a macro. Wrap it in a macro so it degrades to nothing on compilers that lack it.

**Correct sizing with `vsnprintf`.** `vsnprintf` returns the number of characters it *would* have written, excluding the terminator, regardless of the buffer size. That makes the two-pass idiom possible: call it with a size of 0 to measure, `malloc` that many bytes plus one, then call it again to format. The second call needs a `va_copy`, because the first consumed the list.

Never use `sprintf` or `vsprintf` in a wrapper. They have no bound and are a buffer overflow waiting for a long argument.

**Examples**

```c
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <time.h>

/* Portable attribute wrapper: real checking on GCC/Clang, nothing elsewhere. */
#if defined(__GNUC__) || defined(__clang__)
#  define PRINTF_LIKE(fmt_idx, first_arg) \
       __attribute__((format(printf, fmt_idx, first_arg)))
#else
#  define PRINTF_LIKE(fmt_idx, first_arg)
#endif

/* 1: 'fmt' is parameter 2, the variadic part starts at parameter 3. */
void log_msg(const char *level, const char *fmt, ...) PRINTF_LIKE(2, 3);

void log_msg(const char *level, const char *fmt, ...)
{
    time_t now = time(NULL);
    char stamp[32];
    strftime(stamp, sizeof stamp, "%H:%M:%S", localtime(&now));

    fprintf(stderr, "[%s] %s: ", stamp, level);

    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);   /* the v-version accepts a va_list */
    va_end(ap);

    fputc('\n', stderr);
}

/* 2: allocate exactly the right buffer, using vsnprintf's return value. */
char *format_alloc(const char *fmt, ...) PRINTF_LIKE(1, 2);

char *format_alloc(const char *fmt, ...)
{
    va_list ap, ap2;
    va_start(ap, fmt);
    va_copy(ap2, ap);                        /* the measuring pass consumes ap */

    int n = vsnprintf(NULL, 0, fmt, ap);     /* size 0: writes nothing, returns
                                                the length it WOULD have needed */
    va_end(ap);
    if (n < 0) { va_end(ap2); return NULL; }

    char *buf = malloc((size_t)n + 1);       /* +1 for the terminator */
    if (!buf) { va_end(ap2); return NULL; }

    vsnprintf(buf, (size_t)n + 1, fmt, ap2); /* the real pass, bounded */
    va_end(ap2);
    return buf;
}

int main(void)
{
    log_msg("INFO",  "starting, pid placeholder %d", 1234);
    log_msg("ERROR", "disk %s is %d%% full", "/dev/sda1", 97);
    /* log_msg("ERROR", "%d", "not an int");   <- caught at COMPILE time
                                                  thanks to PRINTF_LIKE */

    char *s = format_alloc("%s scored %.1f in %d rounds", "player", 9.25, 3);
    if (s) { puts(s); free(s); }
    return 0;
}
```

```text
   Why forwarding needs the v-family

   log_msg("INFO", "x=%d", 42)
        |
        va_start(ap, fmt)      ap now points at { 42 }
        |
        +--> fprintf(stderr, fmt, ap)    WRONG: passes the va_list OBJECT,
        |                                 %d reads its first machine word
        |
        +--> vfprintf(stderr, fmt, ap)   RIGHT: vfprintf knows ap is a cursor
```

**Key Takeaways**

- A `va_list` cannot be forwarded to a variadic function; call the `v`-prefixed counterpart (`vfprintf`, `vsnprintf`) instead.
- The wrapper shape is always `va_start` -> `v...` call -> `va_end`.
- Annotate wrappers with `__attribute__((format(printf, m, n)))` to get full `-Wformat` checking on your own function.
- `vsnprintf` returns the length it *would* have written, enabling measure-then-allocate; use `va_copy` for the second pass.
- Never use `sprintf`/`vsprintf` in a wrapper — they are unbounded.

> 🧪 Practice
>
> 1. Write `void debug_log(const char *fmt, ...)` that prefixes `"[debug] "` and appends a newline, using `vfprintf`.
> 2. Add the `format` attribute to it, then call it with a mismatched specifier and confirm the compiler catches it. Remove the attribute and see that the error becomes silent.
> 3. Implement `char *str_format(const char *fmt, ...)` with the two-pass `vsnprintf` idiom; test it with a string long enough to need a large buffer.
> 4. Interview-style: *"Your logging wrapper crashes only when a caller passes a `%s`. What is the most likely cause?"* Hint: think about what the wrapper forwards, and what happens when a `va_list` is walked twice or passed to the wrong function.

#### Type-Safety Limitations

**Theory**

Variadic functions punch a hole in C's type system. For the fixed parameters, the prototype lets the compiler check and convert; for everything after the `...`, there is nothing to check against. The callee's claims about the types are simply believed.

Four concrete failure modes follow, and all of them are undefined behavior rather than diagnosable errors:

**1. Format/argument mismatch.** `printf("%d", 3.14)` reads an integer from where a `double` was passed. On x86-64 the two even travel in different register files, so the value printed is unrelated garbage. Worse, `printf("%s", 42)` treats 42 as an address and dereferences it — a crash at best.

**2. Wrong count.** `printf("%d %d\n", 1)` reads a second argument that was never passed, taking whatever happens to be in the next register or stack slot. This is an information leak, not merely a wrong number: the classic format-string vulnerability uses `%x` repeatedly (and `%n`, which *writes*) to read and corrupt the stack. Never pass user-controlled data as a format string — use `printf("%s", user_input)`, never `printf(user_input)`.

**3. Missing promotions.** `va_arg(ap, char)` or `va_arg(ap, float)` requests a type that can never have been passed.

**4. Size mismatches on integer types.** `printf("%d", some_long)` or `printf("%zu", some_int)` misreads the argument size. Use the `<inttypes.h>` macros (`PRId64`, `PRIu32`) for fixed-width types, `%zu` for `size_t`, `%td` for `ptrdiff_t`, and cast to `void *` for `%p`.

The defenses, in order of strength:

| Defense | What it catches | Cost |
| --- | --- | --- |
| `-Wformat -Wformat-security` (in `-Wall`) | Mismatches in calls to known format functions | None; enable always |
| `__attribute__((format(...)))` | The same, for your own wrappers | One annotation |
| `_Generic` (C11) | Type dispatch with full checking | More code, no varargs at all |
| Fixed-arity or struct-array APIs | Everything | A different interface design |
| Compound literals with an array | Variable count, one checked type | Slightly unusual call syntax |

The design lesson is that variadics should be a last resort. If the arguments are all the same type, take an array (a compound literal makes the call site pleasant). If you are dispatching on type, `_Generic` gives compile-time selection with real checking (Chapter 10.3). Reserve `...` for genuine formatting interfaces, and annotate them.

**Examples**

```c
#include <stdio.h>
#include <stdarg.h>
#include <inttypes.h>
#include <stddef.h>

int main(void)
{
    /* --- The four failure modes (all undefined behavior) --- */
    /* printf("%d\n", 3.14);          type mismatch: reads an int from an FP register */
    /* printf("%s\n", 42);            42 treated as an address -> segfault */
    /* printf("%d %d\n", 1);          reads an argument that was never passed */
    /* printf("%d\n", (long)1);       size mismatch on LP64 */

    /* --- Doing it correctly --- */
    size_t   n  = 42;
    long     l  = 1234567890L;
    int64_t  i8 = 9007199254740993;
    void    *p  = &n;
    ptrdiff_t d = 16;

    printf("size_t   : %zu\n",       n);
    printf("long     : %ld\n",       l);
    printf("int64_t  : %" PRId64 "\n", i8);   /* portable fixed-width */
    printf("pointer  : %p\n",        (void *)p);   /* cast is required */
    printf("ptrdiff  : %td\n",       d);

    /* --- NEVER do this: format-string vulnerability --- */
    const char *user_input = "%x %x %x %n";
    /* printf(user_input);          reads the stack; %n WRITES to memory */
    printf("%s\n", user_input);     /* correct: the data is an argument */

    return 0;
}
```

```c
/* --- A type-safe alternative when the arguments share a type --- */
#include <stdio.h>
#include <stddef.h>

static int sum_array(const int *a, size_t n)
{
    int total = 0;
    for (size_t i = 0; i < n; i++) total += a[i];
    return total;
}

/* A compound literal (C99) gives a variadic-looking call site with FULL checking:
   the wrong type here is a compile error, not run-time garbage. */
#define SUM(...) sum_array((int[]){ __VA_ARGS__ }, \
                           sizeof((int[]){ __VA_ARGS__ }) / sizeof(int))

int main(void)
{
    printf("%d\n", SUM(1, 2, 3, 4, 5));    /* 15, fully type-checked */
    /* printf("%d\n", SUM(1, "two"));         compile ERROR -- exactly what we want */
    return 0;
}
```

```text
   Where the checking happens

   fixed parameters        |  variadic arguments
   ------------------------+--------------------------
   prototype known         |  no prototype
   converted as if by      |  default promotions only
     assignment            |
   count checked           |  count unknown to the callee
   type checked            |  type asserted by va_arg, never verified
                           |
                           +--> every guarantee is the programmer's,
                                except what -Wformat can infer from
                                a literal format string
```

**Key Takeaways**

- Variadic arguments are unchecked: the callee's `va_arg` type and the format string are assertions the compiler cannot verify.
- Mismatched type, wrong count, missing promotion, and wrong integer size are all undefined behavior, often silent.
- Never pass user-controlled data as a format string; `%n` makes it a memory-write primitive.
- Use `%zu`, `%td`, `PRId64`, and `(void *)` casts for `%p` to keep formats and argument sizes aligned.
- Keep `-Wformat` on, annotate your wrappers with the `format` attribute, and prefer arrays, structs, or `_Generic` when the interface does not truly need formatting.

> 🧪 Practice
>
> 1. Write `printf("%d\n", 3.14)` and `printf("%s\n", 42)`, compile with `-Wall`, and record both the warning and the runtime behavior.
> 2. Write a program that prints a `size_t` with `%d` on a 64-bit system and explain when the output happens to look correct and when it does not.
> 3. Implement the `SUM` macro above, then try `SUM(1, 2.5)` and explain the diagnostic.
> 4. Interview-style: *"Explain the format-string vulnerability and how to prevent it."* Hint: describe what `%x` reads and what `%n` writes, then give the one-line fix at the call site.

---

## 5. Arrays, Strings, and Pointers

This chapter is the heart of C. Arrays give you contiguous storage, pointers give you the addresses of that storage, and strings are what happens when you combine the two with a terminating zero byte — a design that makes C fast and flexible while placing every bounds check squarely on you. Understanding how arrays decay into pointers, what pointer arithmetic actually computes, and why a missing `'\0'` is a security bug rather than a typo is what separates C that works from C that only appears to.

<a id="51-arrays"></a>
### 5.1 Arrays

An array is a fixed-size, contiguous block of elements of one type, accessed by index. This section covers how to declare and initialize one, what happens at the boundaries, how multiple dimensions are laid out in memory, and the decay rule that quietly turns almost every array into a pointer.

#### Declaration and Initialization

**Theory**

When you need one integer you declare `int x;`. When you need a thousand, you do not want a thousand names — you want one name and a number to pick between them. That is an array: **a fixed number of elements of the same type, laid out back to back in memory, with no gaps and no header.**

That last part matters. An array in C is not an object with a length field, a capacity, or bounds information. It is *just the elements*. `int a[5]` occupies exactly `5 * sizeof(int)` bytes and nothing else. This is why arrays are as fast as manually managed memory, and why the language cannot check anything for you at run time — there is nothing to check against.

The declaration reads outward from the name: `int a[5];` means "`a` is an array of 5 `int`". The size must be a constant expression known at compile time (except for VLAs, covered later in this section).

Initialization has several forms, and the rules reward knowing them precisely:

```c
int a[5] = {1, 2, 3, 4, 5};   /* all five given                      */
int b[5] = {1, 2};            /* b[2..4] are ZERO -- not garbage     */
int c[5] = {0};               /* the classic "zero the whole array"  */
int d[]  = {1, 2, 3};         /* size deduced: 3                     */
int e[5] = {};                /* C23: empty braces, all zero         */
```

The key rule: **if you provide any initializer, every element you did not mention is zero-initialized** (as if by `= 0` for scalars). That is why `= {0}` works — you initialize the first element explicitly and the rest by the rule. If you provide *no* initializer at all, storage duration decides: automatic arrays hold indeterminate values, static and global arrays are zeroed (Chapter 4.2).

C99 added **designated initializers**, which let you set specific elements by index and let the rest fall to zero. They make sparse tables readable and order-independent:

```c
int lookup[10] = { [3] = 42, [7] = 99 };   /* everything else is 0 */
```

Giving more initializers than the declared size is an error. Character arrays get a special form covered in Chapter 5.4: `char s[] = "hi";` creates a 3-byte array (`'h'`, `'i'`, `'\0'`).

To get the element count, never hard-code a number that can drift out of sync with the declaration. Use the `sizeof` idiom:

```c
size_t n = sizeof a / sizeof a[0];   /* total bytes / bytes per element */
```

This works **only where `a` is a real array**. Inside a function that received the array as a parameter, `a` is a pointer and the idiom silently computes nonsense — the single most important caveat in this chapter, developed under "Array Decay to Pointers".

**Examples**

```c
#include <stdio.h>

int global_arr[4];              /* static storage: zero-initialized */

int main(void)
{
    int uninit[4];              /* automatic: INDETERMINATE, not zero */
    int full[5]    = {10, 20, 30, 40, 50};
    int partial[5] = {10, 20};              /* -> {10, 20, 0, 0, 0} */
    int zeroed[5]  = {0};                   /* -> all zero          */
    int deduced[]  = {1, 2, 3, 4};          /* size is 4            */
    int sparse[8]  = { [2] = 7, [5] = 9 };  /* C99 designated init  */

    /* The count idiom: recomputed by the compiler, never drifts. */
    size_t n = sizeof deduced / sizeof deduced[0];
    printf("deduced has %zu elements, %zu bytes\n", n, sizeof deduced);

    printf("partial : ");
    for (size_t i = 0; i < 5; i++) printf("%d ", partial[i]);
    printf("\nsparse  : ");
    for (size_t i = 0; i < 8; i++) printf("%d ", sparse[i]);
    printf("\nglobal  : %d %d (zeroed by the standard)\n",
           global_arr[0], global_arr[3]);

    (void)uninit;   /* reading it would be undefined behavior */
    (void)full; (void)zeroed;
    return 0;
}
```

```text
   int full[5] = {10, 20, 30, 40, 50};   on a machine with 4-byte int

   address:  0x100   0x104   0x108   0x10c   0x110
            +-------+-------+-------+-------+-------+
            |  10   |  20   |  30   |  40   |  50   |
            +-------+-------+-------+-------+-------+
   index:      [0]     [1]     [2]     [3]     [4]

   sizeof full = 20 bytes. No length field, no bounds, no header --
   the array IS the 20 bytes.
```

**Key Takeaways**

- An array is a contiguous block of same-typed elements with no stored length — `sizeof a` is the only record of its size, and only where the declaration is visible.
- The size in `int a[N]` must be a compile-time constant (VLAs excepted).
- Any initializer zero-fills the elements you omit; `= {0}` is the idiom for zeroing an array.
- No initializer means indeterminate values for automatic arrays and zeros for static/global ones.
- Use designated initializers (`[3] = 42`) for sparse tables, and `sizeof a / sizeof a[0]` for the element count — never a hard-coded number.

> 🧪 Practice
>
> 1. Declare an `int` array of 6 elements initialized with only the first two values, print all six, and explain the last four.
> 2. Write a program that prints `sizeof` and the element count for arrays of `char`, `int`, and `double` with the same number of elements.
> 3. Build a `const char *day_name[7]` table using designated initializers so the days appear out of order in the source but print in order.
> 4. Interview-style: *"What is the difference between `int a[5] = {0};` and `int a[5];` at file scope versus inside a function?"* Hint: two independent rules are in play — the initializer rule and the storage-duration rule.

#### Indexing and Bounds

**Theory**

Indexing looks like a language feature but is really arithmetic. The standard defines it exactly:

```
a[i]  is  *(a + i)
```

The subscript operator is *defined* as pointer addition followed by a dereference. `a` decays to a pointer to its first element, `a + i` advances by `i` elements (not `i` bytes — see "Pointer Arithmetic"), and `*` reads what is there.

Two consequences follow immediately. First, **indexing is zero-based** not by convention but by construction: `a[0]` is `*(a + 0)`, the element at the start. The valid indices for `int a[5]` are 0 through 4, and `a[5]` is one past the end.

Second, because addition commutes, `a[i]` and `i[a]` are the same expression. `3["hello"]` is legal C and evaluates to `'l'`. This is a curiosity rather than a technique, but it proves the point: there is no special "array indexing" machinery, only pointer arithmetic.

Now the part that defines C's reputation. **There is no bounds checking. None.** Writing `a[7]` on a five-element array is undefined behavior, and the compiler generates the same instruction it would for a valid index: compute the address, access it. What happens next depends on what lives there:

- Nothing visible — the memory belongs to your process and you corrupted an unrelated variable.
- A crash — the address is unmapped.
- A security hole — you overwrote a return address or a function pointer.

Undefined behavior also means the compiler may assume it never happens, and optimize accordingly. This is why out-of-bounds bugs can change behavior between `-O0` and `-O2` and vanish when you add a `printf` to investigate.

The permanent defenses are three:

**Always derive the bound from the array.** `for (size_t i = 0; i < sizeof a / sizeof a[0]; i++)`, or a named constant used in both the declaration and the loop.

**Watch the off-by-one.** `<=` in a loop condition, or looping to `n` when indices stop at `n-1`, is the most common single bug in C. Half-open ranges (`i < n`) exist precisely to avoid it.

**Use the tools.** `-fsanitize=address` catches out-of-bounds accesses at run time with a precise report; `-fsanitize=undefined` catches more; `-Warray-bounds` catches some at compile time. There is no reason to debug memory corruption by hand in 2026.

One legal edge case worth knowing: computing (but not dereferencing) the address **one past the end** is defined, which is what makes `for (int *p = a; p != a + n; p++)` valid. One before the beginning is not.

**Examples**

```c
#include <stdio.h>

int main(void)
{
    int a[5] = {10, 20, 30, 40, 50};
    size_t n = sizeof a / sizeof a[0];

    /* a[i] is literally *(a + i) -- all four forms are identical. */
    printf("%d %d %d %d\n", a[2], *(a + 2), *(2 + a), 2[a]);

    /* Correct traversal: half-open range, bound derived from the array. */
    for (size_t i = 0; i < n; i++)
        printf("a[%zu] = %d\n", i, a[i]);

    /* Pointer traversal: 'a + n' is a legal address to COMPUTE,
       though *(a + n) would be undefined to read. */
    for (int *p = a; p != a + n; p++)
        printf("%d ", *p);
    putchar('\n');

    /* --- The classic bugs, all undefined behavior --- */
    /* for (size_t i = 0; i <= n; i++) sum += a[i];   off-by-one: reads a[5] */
    /* a[5] = 99;                                     one past the end       */
    /* a[-1] = 99;                                    before the beginning   */
    /* int i = 10; printf("%d", a[i]);                far out of bounds      */

    return 0;
}
```

```text
   int a[5];      valid indices 0..4

        a[0]   a[1]   a[2]   a[3]   a[4]  | a[5]
       +------+------+------+------+------+· · · · ·
       |  10  |  20  |  30  |  40  |  50  |  ???
       +------+------+------+------+------+· · · · ·
       ^                                  ^
       a                                  a + 5
                                          address is LEGAL to compute
                                          (loop sentinel), ILLEGAL to read

   What a[5] = 99 might hit:  another local, a saved register,
                              the return address, or nothing at all.
                              The compiler emits the write either way.
```

```bash
# Let the sanitizer find it instead of guessing:
gcc -g -fsanitize=address,undefined -o prog prog.c && ./prog
# ==12345==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x...
#   WRITE of size 4 at 0x... thread T0
#     #0 0x... in main prog.c:14
```

**Key Takeaways**

- `a[i]` is defined as `*(a + i)`; indexing is pointer arithmetic, which is why indices start at 0 and why `i[a]` compiles.
- C performs no bounds checking; an out-of-range access is undefined behavior that may corrupt memory silently.
- Valid indices for `T a[N]` are `0` to `N-1`; the address `a + N` may be computed but never dereferenced.
- Derive loop bounds from the array itself and prefer half-open ranges (`i < n`) to avoid off-by-one errors.
- Develop with `-fsanitize=address,undefined`; it turns silent corruption into a precise diagnostic.

> 🧪 Practice
>
> 1. Write a loop that deliberately reads `a[n]` on a 5-element array. Run it at `-O0`, then at `-O2`, then under `-fsanitize=address`, and compare the three outcomes.
> 2. Print `a[2]`, `*(a + 2)`, and `2[a]` for the same array and explain why they agree.
> 3. Write `sum_array(const int *a, size_t n)` with an intentional `<=` bug, observe the wrong total, then fix it and explain what the extra iteration read.
> 4. Interview-style: *"Why does C not bounds-check arrays, and what would it cost if it did?"* Hint: think about what an array actually is in memory, and what extra data every access would need to consult.

#### Multidimensional Arrays

**Theory**

C has no true two-dimensional array. What it has is **arrays of arrays**, and the distinction explains everything that follows.

`int grid[3][4];` declares an array of 3 elements, each of which is an array of 4 `int`. Read the declaration left to right for dimensions and inside out for meaning: `grid` is an array[3] of array[4] of int. Therefore `grid[1]` is not a scalar — it is an entire `int[4]` — and `grid[1][2]` indexes into that inner array.

The memory layout is **row-major**: all of row 0, then all of row 1, then all of row 2, in one contiguous block of 12 integers. There are no pointers involved, no row table, no indirection. The address of `grid[i][j]` is:

```
base + (i * columns + j) * sizeof(int)
```

which the compiler computes for you — and which is exactly why the *column* count must be part of the type. Given only "a pointer to some ints", nothing can compute `i * columns`.

Row-major layout has a real performance consequence. CPUs load memory in cache lines (typically 64 bytes) and prefetch forward. Iterating rows in the outer loop and columns in the inner loop walks memory sequentially and hits cache; swapping the loops strides across memory and can be several times slower for a large matrix, purely from cache misses.

Initialization can be nested or flat. Nested braces are clearer and let each row zero-fill independently:

```c
int g[3][4] = {
    {1, 2, 3, 4},
    {5, 6},              /* -> {5, 6, 0, 0} */
    {0}                  /* -> {0, 0, 0, 0} */
};
int flat[2][3] = {1, 2, 3, 4, 5, 6};   /* legal: fills in row-major order */
```

Only the **first** dimension may be omitted when there is an initializer, since the compiler can count the rows but must be told the row width.

The same reasoning extends to three dimensions and beyond: `int cube[2][3][4]` is an array of 2 arrays of 3 arrays of 4 ints, laid out with the rightmost index varying fastest.

Do not confuse `int grid[3][4]` with `int *rows[3]` (an array of 3 pointers, each to a separately allocated row). Both support `x[i][j]` syntax, but the first is one contiguous block with computed offsets, and the second is a table of pointers with a real indirection per access. That comparison belongs to "Arrays of Pointers" in Chapter 5.3.

**Examples**

```c
#include <stdio.h>

int main(void)
{
    int grid[3][4] = {
        { 1,  2,  3,  4},
        { 5,  6,  7,  8},
        { 9, 10, 11, 12}
    };

    /* grid[i] is an int[4], not an int. */
    printf("sizeof grid       = %zu\n", sizeof grid);        /* 48 = 3*4*4 */
    printf("sizeof grid[0]    = %zu\n", sizeof grid[0]);     /* 16 = 4*4   */
    printf("sizeof grid[0][0] = %zu\n", sizeof grid[0][0]);  /* 4          */

    size_t rows = sizeof grid / sizeof grid[0];        /* 3 */
    size_t cols = sizeof grid[0] / sizeof grid[0][0];  /* 4 */

    for (size_t i = 0; i < rows; i++) {
        for (size_t j = 0; j < cols; j++)
            printf("%3d ", grid[i][j]);
        putchar('\n');
    }

    /* Proof of contiguity: read the whole thing as one flat block. */
    int *flat = &grid[0][0];
    printf("flat: ");
    for (size_t k = 0; k < rows * cols; k++) printf("%d ", flat[k]);
    putchar('\n');

    /* The compiler's address formula, made explicit. */
    printf("grid[2][1] = %d, flat[2*4 + 1] = %d\n", grid[2][1], flat[2 * 4 + 1]);
    return 0;
}
```

```text
   int grid[3][4]  -- row-major, ONE contiguous block of 12 ints

   grid[0]            grid[1]             grid[2]
   +---+---+---+---+  +---+---+---+---+  +---+---+---+---+
   | 1 | 2 | 3 | 4 |  | 5 | 6 | 7 | 8 |  | 9 |10 |11 |12 |
   +---+---+---+---+  +---+---+---+---+  +---+---+---+---+
     0   1   2   3      4   5   6   7      8   9  10  11    <- flat offset

   address of grid[i][j] = base + (i*4 + j) * sizeof(int)
                                      ^
                              the column count MUST be in the type
```

Cache behavior of the two loop orders:

```c
/* FAST: sequential memory access, one cache line serves several elements. */
for (size_t i = 0; i < ROWS; i++)
    for (size_t j = 0; j < COLS; j++)
        sum += m[i][j];

/* SLOW: each step jumps COLS*sizeof(int) bytes -- a cache miss per access. */
for (size_t j = 0; j < COLS; j++)
    for (size_t i = 0; i < ROWS; i++)
        sum += m[i][j];
```

**Key Takeaways**

- `int a[R][C]` is an array of `R` arrays of `C` ints, stored contiguously in row-major order — there is no row-pointer table.
- `a[i]` has type `int[C]`, so `sizeof a[0]` gives the row size and `sizeof a / sizeof a[0]` gives the row count.
- The address formula is `base + (i*C + j)*sizeof(T)`, which is why the column count is part of the type and cannot be omitted.
- Only the leftmost dimension may be left empty when an initializer is present.
- Iterate with the last index in the innermost loop; the reverse order strides across cache lines and is measurably slower.

> 🧪 Practice
>
> 1. Declare `int m[2][3]`, fill it with nested braces, and print `sizeof` for `m`, `m[0]`, and `m[0][0]`. Explain each number.
> 2. Access a 2D array through a flat `int *` pointer and verify that `flat[i*cols + j] == m[i][j]` for every element.
> 3. Time summing a 2000x2000 `int` matrix row-major versus column-major, and report the ratio.
> 4. Interview-style: *"Why can you omit the first dimension of a 2D array parameter but not the second?"* Hint: write out the address formula and see which numbers it needs.

#### Array Decay to Pointers

**Theory**

This is the single most important rule in C, and the one that causes the most confusion, so it is worth stating exactly:

> In most expressions, an array is implicitly converted ("decays") to a pointer to its first element.

`a` of type `int[5]` becomes an `int *` pointing at `a[0]`. The conversion is automatic, invisible, and happens before almost anything else. It is why you can write `p = a;`, why `a[i]` works as pointer arithmetic, and why passing an array to a function passes an address.

Why does the language do this? Because copying arrays implicitly would be expensive and usually unwanted. C's designers made arrays "second-class" values: you cannot assign one array to another, pass one by value, or return one. What you manipulate instead is a pointer to the first element — cheap, uniform, and explicit about the fact that no copy occurred.

There are exactly **three exceptions**, and memorizing them is worth the effort because everything surprising about arrays traces back to one of them:

| Context | Result | Why it matters |
| --- | --- | --- |
| `sizeof a` | Size of the whole array in bytes | The one place the real size survives |
| `&a` | Pointer to the *array*: type `int (*)[5]` | Different type from `&a[0]`, though the same address |
| String literal initializing a `char` array | Copies the characters | `char s[] = "hi"` creates an array, not a pointer |

(C11 adds `_Alignof`, which behaves like `sizeof` here.)

The `&a` exception deserves a picture. For `int a[5]`:

- `a` decays to `int *` — pointing at the first element. `a + 1` moves 4 bytes.
- `&a[0]` is `int *` — the same address, the same arithmetic.
- `&a` is `int (*)[5]` — the same address, but `+1` moves **20 bytes**, past the whole array.

All three print identically with `%p`. Only the types differ, and the type is what determines the arithmetic.

The decay rule is also why the `sizeof` count idiom breaks across function boundaries. Inside `void f(int a[5])`, the parameter's type is adjusted to `int *`; the `5` is documentation the compiler ignores. `sizeof a` yields the pointer size, and any element count derived from it is wrong. GCC and Clang warn with `-Wsizeof-array-argument` — heed it.

Finally, note that decay applies to the *outer* dimension only. A 2D array `int g[3][4]` decays to `int (*)[4]` — a pointer to an array of 4 ints — not to `int **`. Those two types are not interchangeable, and confusing them is a common source of type errors.

**Examples**

```c
#include <stdio.h>

void takes_pointer(int a[5])       /* the '5' is ignored: really int *a */
{
    printf("inside : sizeof a = %zu (a POINTER)\n", sizeof a);
}

int main(void)
{
    int a[5] = {1, 2, 3, 4, 5};

    /* --- Exception 1: sizeof sees the real array --- */
    printf("caller : sizeof a = %zu (the whole ARRAY)\n", sizeof a);
    takes_pointer(a);              /* decays here */

    /* --- Decay in ordinary expressions --- */
    int *p = a;                    /* implicit: p = &a[0] */
    printf("a[2]=%d p[2]=%d *(a+2)=%d\n", a[2], p[2], *(a + 2));

    /* --- Exception 2: &a has a different TYPE, same address --- */
    printf("a     = %p\n", (void *)a);
    printf("&a[0] = %p\n", (void *)&a[0]);
    printf("&a    = %p   (same address, type int (*)[5])\n", (void *)&a);

    printf("a + 1  = %p  (+4 bytes: one int)\n",  (void *)(a + 1));
    printf("&a + 1 = %p  (+20 bytes: one whole array)\n", (void *)(&a + 1));

    /* --- Exception 3: string literal initializing a char array --- */
    char s[] = "hi";               /* COPIES 3 bytes into a modifiable array */
    const char *q = "hi";          /* points at a read-only literal          */
    printf("sizeof s = %zu, sizeof q = %zu\n", sizeof s, sizeof q);  /* 3, 8 */

    /* --- 2D decay: to int (*)[4], NOT int ** --- */
    int g[3][4] = {{0}};
    int (*row)[4] = g;             /* correct type for a decayed 2D array */
    /* int **wrong = g;               would not compile -- incompatible   */
    printf("row+1 advances %zu bytes\n",
           (size_t)((char *)(row + 1) - (char *)row));   /* 16 */
    return 0;
}
```

```text
   int a[5];

   a        -> decays to int *      : points at a[0], +1 moves 4 bytes
   &a[0]    -> int *                : identical to the above
   &a       -> int (*)[5]           : SAME address, +1 moves 20 bytes
   sizeof a -> 20                   : no decay here

        +----+----+----+----+----+
        | a0 | a1 | a2 | a3 | a4 |
        +----+----+----+----+----+
        ^                        ^
        |                        &a + 1  (past the whole array)
        a, &a[0], &a  (one address, three types)
        |
        a + 1 --> points here (a[1])
```

**Key Takeaways**

- In nearly every expression an array converts to a pointer to its first element; this is why arrays cannot be assigned, copied, or passed by value.
- The three exceptions are `sizeof` (and `_Alignof`), `&array`, and a string literal initializing a `char` array.
- `a`, `&a[0]`, and `&a` share an address but not a type — `&a` is `T (*)[N]`, so its arithmetic steps over the entire array.
- Inside a function, an array parameter is a pointer: `sizeof` on it gives the pointer size, so always pass the length separately.
- A 2D array decays to `T (*)[C]`, never to `T **`.

> 🧪 Practice
>
> 1. Print `sizeof` for an array in `main` and inside a function that takes it as `int a[10]`. Explain both values and note the compiler warning.
> 2. Print `a`, `&a[0]`, `&a`, `a + 1`, and `&a + 1` for `int a[5]` and calculate the byte differences.
> 3. Try to assign `int **p = g;` for a 2D array `g`, read the error, then write the correct declaration.
> 4. Interview-style: *"Are arrays and pointers the same thing in C?"* Hint: the answer is no, and the useful reply names the three contexts where the difference is visible.

#### Passing Arrays to Functions

**Theory**

Following directly from decay: **you cannot pass an array to a function in C.** You pass a pointer to its first element, and the callee receives an address, not a copy. This is efficient — no matter how large the array, the call costs one pointer — but it has two consequences the caller must handle.

**The callee does not know the length.** It must be told. Every array-taking function in C therefore has a companion length parameter, and getting that convention right is your responsibility. The standard library's `memcpy(dst, src, n)` and `fgets(buf, size, stream)` are the model.

**The callee can modify the caller's data.** There is no copy to protect the original, so mark the parameter `const` when you do not intend to write through it. `const int *a` is enforced by the compiler and documents the contract in the signature.

The three parameter spellings are equivalent — pick one and be consistent:

```c
void f(int *a,  size_t n);   /* honest: it really is a pointer   */
void f(int a[], size_t n);   /* conventional: signals "array"    */
void f(int a[5], size_t n);  /* the 5 is documentation only      */
```

C99 adds a fourth, genuinely different form: `void f(int a[static 5])` is a *promise from the caller* that `a` points to at least 5 elements and is not null. Compilers use it for warnings and optimization; it does not change the parameter's type.

Multidimensional arrays need more care, because the address formula needs the column count:

```c
void f(int g[3][4]);      /* adjusted to: int (*g)[4]  */
void f(int g[][4]);       /* same thing                */
void f(int (*g)[4]);      /* the actual type           */
void f(size_t r, size_t c, int g[r][c]);   /* C99 VLA parameter: fully general */
```

Note the parentheses in `int (*g)[4]` — "pointer to array of 4 int". Without them, `int *g[4]` means "array of 4 pointers to int", a completely different type (Chapter 5.3).

If you genuinely want a copy — pass-by-value semantics for a block of data — wrap the array in a struct. Structs *are* copied on assignment and on passing, which is one practical reason to prefer them for small fixed buffers:

```c
struct vec3 { double v[3]; };
void f(struct vec3 v);      /* the whole struct, array included, is copied */
```

Returning arrays has the same restriction: you cannot return an array type. Return a pointer to storage that outlives the call (heap or static), fill a caller-supplied buffer (the usual and safest choice), or return a struct.

**Examples**

```c
#include <stdio.h>
#include <string.h>

/* Read-only: 'const' documents and enforces that we do not write. */
long sum(const int *a, size_t n)
{
    long total = 0;
    for (size_t i = 0; i < n; i++) total += a[i];
    return total;
}

/* Mutating: no const, because we intend to modify the caller's array. */
void scale(int *a, size_t n, int factor)
{
    for (size_t i = 0; i < n; i++) a[i] *= factor;
}

/* C99: 'static 5' promises at least 5 elements and a non-null pointer. */
int first_five_sum(const int a[static 5])
{
    return a[0] + a[1] + a[2] + a[3] + a[4];
}

/* 2D: the column count must be in the type. */
void print_grid(size_t rows, const int g[][4])
{
    for (size_t i = 0; i < rows; i++) {
        for (size_t j = 0; j < 4; j++) printf("%3d ", g[i][j]);
        putchar('\n');
    }
}

/* Fully general 2D via C99 VLA parameters: dimensions come first. */
long sum_2d(size_t rows, size_t cols, const int g[rows][cols])
{
    long total = 0;
    for (size_t i = 0; i < rows; i++)
        for (size_t j = 0; j < cols; j++)
            total += g[i][j];
    return total;
}

/* Copy semantics, achieved by wrapping the array in a struct. */
struct vec3 { double v[3]; };
struct vec3 doubled(struct vec3 in)      /* 'in' is a genuine copy */
{
    for (int i = 0; i < 3; i++) in.v[i] *= 2;
    return in;                            /* the caller's original is untouched */
}

/* Caller-supplied output buffer: the safest way to "return" an array. */
int make_range(int *out, size_t cap, int start, int count)
{
    if ((size_t)count > cap) return -1;   /* never write past the caller's buffer */
    for (int i = 0; i < count; i++) out[i] = start + i;
    return 0;
}

int main(void)
{
    int a[5] = {1, 2, 3, 4, 5};
    size_t n = sizeof a / sizeof a[0];

    printf("sum          = %ld\n", sum(a, n));
    scale(a, n, 10);
    printf("after scale  = %ld (caller's array WAS modified)\n", sum(a, n));
    printf("first_five   = %d\n", first_five_sum(a));

    int g[2][4] = {{1, 2, 3, 4}, {5, 6, 7, 8}};
    print_grid(2, g);
    printf("sum_2d       = %ld\n", sum_2d(2, 4, g));

    struct vec3 v = {{1.0, 2.0, 3.0}};
    struct vec3 d = doubled(v);
    printf("struct copy  : v.v[0]=%.1f d.v[0]=%.1f\n", v.v[0], d.v[0]);

    int buf[8];
    if (make_range(buf, 8, 100, 4) == 0)
        printf("range        : %d %d %d %d\n", buf[0], buf[1], buf[2], buf[3]);
    return 0;
}
```

```text
   Caller                          Callee: sum(const int *a, size_t n)
   +--------------------+
   | a[0] a[1] ... a[4] |<---------  a  (a COPY of the address)
   +--------------------+            n  (a copy of the length)
        ^
        one array, no copy made. The callee reads and writes
        the caller's memory directly -- 'const' is the only guard.
```

**Key Takeaways**

- Arrays are never passed by value; the callee receives a pointer, so always pass an explicit length alongside it.
- `int *a`, `int a[]`, and `int a[5]` are the same parameter type; `int a[static 5]` adds a caller promise of at least 5 elements.
- Use `const T *` for read-only parameters — it is compiler-enforced documentation.
- 2D parameters need the column count: `int (*g)[4]`, or C99 `int g[rows][cols]` with the dimensions passed first.
- To get copy semantics, wrap the array in a struct; to "return" an array, fill a caller-supplied buffer and take its capacity as a parameter.

> 🧪 Practice
>
> 1. Write `void reverse(int *a, size_t n)` that reverses an array in place, and verify from the caller that the original was modified.
> 2. Write a function that takes `const int *` and try to assign to an element; read the compiler error and explain what `const` protected.
> 3. Write `long sum_2d(size_t rows, size_t cols, const int g[rows][cols])` and call it with two differently shaped arrays.
> 4. Interview-style: *"How would you write a function that returns a new array of results?"* Hint: there are three viable designs; compare who allocates and who frees in each.

#### Variable-Length Arrays

**Theory**

Until C99, array sizes had to be compile-time constants. If the size was only known at run time, you either allocated on the heap with `malloc` or over-allocated a fixed maximum and hoped. C99 introduced **variable-length arrays**: automatic arrays whose size is an ordinary run-time expression.

```c
void f(size_t n)
{
    int buf[n];       /* a VLA: size determined when control reaches here */
}
```

The size is evaluated once, on entry to the block, and the array lives on the stack like any other automatic object (Chapter 4.2), disappearing at the end of its block. This makes VLAs cheap — a stack-pointer adjustment rather than an allocator call — and automatically cleaned up.

Their most useful form is as **function parameters**, where they finally allow a genuinely generic 2D array function:

```c
void print(size_t rows, size_t cols, int g[rows][cols]);
```

The dimensions must be declared before use, which is why they come first in the parameter list. This is a real gain over `int (*g)[4]`, which hard-codes the width.

The restrictions follow from being run-time-sized:

- **No initializer.** `int a[n] = {0};` is invalid — write a loop or `memset`.
- **No `static` or file scope.** VLAs are strictly automatic.
- **Not a struct member.** (Flexible array members solve a different problem; Chapter 6.1.)
- **`sizeof` is evaluated at run time** for a VLA and yields the actual byte count — the one case where `sizeof` is not a compile-time constant.
- **`goto` may not jump into a VLA's scope**, since that would skip the allocation.

Now the serious caveat. **A VLA whose size comes from untrusted input is a stack-overflow vulnerability.** The stack is small (about 8 MB on Linux, 1 MB on Windows) and there is no way to detect failure — no null return, no error code. `int buf[n]` with a large `n` simply moves the stack pointer past the guard page, and the program crashes or, worse, the allocation skips the guard page entirely and corrupts other memory. Always validate the size against a fixed cap before declaring a VLA, or use `malloc`, which reports failure by returning `NULL`.

Support is also uneven: C11 made VLAs **optional** (a conforming implementation may define `__STDC_NO_VLA__`), and MSVC has never supported them. The Linux kernel removed VLAs entirely for the security reasons above. C23 requires VLA *parameter* types while keeping VLA *objects* optional.

The practical rule: use VLA parameter types freely for multidimensional functions; use VLA objects only for small, bounded, internally computed sizes; use `malloc` for anything large or externally influenced.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* The best use of VLAs: a genuinely generic 2D parameter.
   Note the dimensions must be declared BEFORE the array that uses them. */
long sum_matrix(size_t rows, size_t cols, const int m[rows][cols])
{
    long total = 0;
    for (size_t i = 0; i < rows; i++)
        for (size_t j = 0; j < cols; j++)
            total += m[i][j];
    return total;
}

/* A VLA object, with the size safely bounded. */
void process(size_t n)
{
    if (n == 0 || n > 1024) {            /* MANDATORY: bound the size */
        fprintf(stderr, "n out of range\n");
        return;
    }
    int buf[n];                          /* no initializer allowed */
    memset(buf, 0, sizeof buf);          /* sizeof is a RUN-TIME value here */
    for (size_t i = 0; i < n; i++) buf[i] = (int)(i * i);
    printf("n=%zu sizeof buf=%zu last=%d\n", n, sizeof buf, buf[n - 1]);
}

/* The safe alternative when the size is large or untrusted. */
int process_heap(size_t n)
{
    int *buf = malloc(n * sizeof *buf);
    if (!buf) return -1;                 /* failure is REPORTABLE, unlike a VLA */
    for (size_t i = 0; i < n; i++) buf[i] = (int)i;
    printf("heap: last = %d\n", buf[n - 1]);
    free(buf);
    return 0;
}

int main(void)
{
#if defined(__STDC_NO_VLA__)
    puts("This implementation does not support VLAs.");
#else
    process(10);
    process(2000);                       /* rejected by the bound check */

    int m[3][4] = {{1,2,3,4},{5,6,7,8},{9,10,11,12}};
    printf("sum_matrix = %ld\n", sum_matrix(3, 4, m));

    int wide[2][6] = {{1,1,1,1,1,1},{2,2,2,2,2,2}};
    printf("sum_matrix = %ld  (different shape, same function)\n",
           sum_matrix(2, 6, wide));
#endif
    process_heap(1000000);               /* far too big for the stack */
    return 0;
}
```

| Aspect | VLA `int a[n]` | `malloc(n * sizeof(int))` |
| --- | --- | --- |
| Where | Stack | Heap |
| Cost | Pointer adjustment | Allocator call |
| Failure reported? | No — crash | Yes — returns `NULL` |
| Cleanup | Automatic at block exit | Manual `free` |
| Max practical size | Kilobytes | Gigabytes |
| Lifetime | Until block ends | Until you free it |
| Portability | Optional since C11; no MSVC | Universal |

```text
   Stack with a VLA

   +------------------+ <- stack base
   | main's frame     |
   +------------------+
   | process's frame  |
   |  n, i            |
   |  buf[n]  <-- size chosen at RUN TIME; the stack pointer just moves
   +------------------+
   | ...              |
   +------------------+
   | GUARD PAGE       | <- a huge n jumps straight past this:
   +------------------+    no diagnostic, no NULL, just corruption
```

**Key Takeaways**

- A VLA is an automatic array whose size is a run-time expression, allocated on the stack and freed at block exit.
- VLAs take no initializer, cannot be `static` or at file scope, and cannot be struct members; `sizeof` on one is evaluated at run time.
- VLA *parameters* (`void f(size_t r, size_t c, int g[r][c])`) are the feature's best use — genuinely generic multidimensional functions.
- A VLA sized from untrusted input is a stack-overflow vulnerability with no way to detect failure; always bound the size or use `malloc`.
- VLA objects are optional since C11 (`__STDC_NO_VLA__`) and unsupported by MSVC; prefer heap allocation for anything large or portable.

> 🧪 Practice
>
> 1. Write a function taking `size_t n` that declares `int buf[n]`, fills it, and prints `sizeof buf`. Confirm the size changes with `n`.
> 2. Call it with `n = 100000000` and observe the crash. Then add a bound check and a `malloc` fallback.
> 3. Write `void transpose(size_t r, size_t c, const int in[r][c], int out[c][r])` and test it on a non-square matrix.
> 4. Interview-style: *"Why did the Linux kernel remove all VLAs from its codebase?"* Hint: think about kernel stack sizes, attacker-controlled lengths, and what failure looks like when there is no return value to check.

<a id="52-pointer-fundamentals"></a>
### 5.2 Pointer Fundamentals

A pointer holds the address of an object. That one idea gives C its ability to modify a caller's data, walk arrays efficiently, build linked structures, and manage memory directly. This section builds pointers from the ground up: the two operators, what the type means, the null pointer, the arithmetic, and the qualifiers that keep it all honest.

#### Address-of and Dereference Operators

**Theory**

Every object in a running program lives somewhere in memory, and every location has a numeric **address**. Think of memory as a very long street of numbered houses, each holding one byte. A pointer is a slip of paper with a house number written on it.

Two operators connect values and addresses, and they are exact inverses:

- **`&x`** — the *address-of* operator. Yields the address where `x` lives. "Where is it?"
- **`*p`** — the *dereference* (or indirection) operator. Yields the object at the address `p` holds. "What is there?"

So `*&x` is `x`, always. Reading the declaration syntax the same way helps: `int *p;` can be read as "`*p` is an `int`", which is why the `*` is conventionally attached to the name rather than the type.

Why is this worth having? Three reasons dominate:

1. **Modifying a caller's variable.** C passes everything by value (Chapter 4.1), so a function that must change something takes its address.
2. **Avoiding copies.** Passing a 4 KB struct copies 4 KB; passing its address copies 8 bytes.
3. **Building structures whose shape is not known in advance** — linked lists, trees, dynamically sized buffers.

Two constraints keep the operators safe. `&` requires an **lvalue**: something with a location. `&42` and `&(x + 1)` are errors because literals and temporaries have no address. And `*` requires a pointer that actually points at a valid, live object — dereferencing a null, uninitialized, or dangling pointer is undefined behavior.

Note the syntactic overload: `*` means multiplication between two operands, dereference before one; `&` means bitwise AND between two operands, address-of before one. Context disambiguates them.

Finally, `%p` is the correct `printf` specifier for a pointer, and the argument must be cast to `void *` — it is a variadic function with no conversion (Chapter 4.4).

**Examples**

```c
#include <stdio.h>

void increment(int *p)      /* takes an ADDRESS, so it can modify the original */
{
    (*p)++;                 /* parentheses matter: *p++ would increment the POINTER */
}

int main(void)
{
    int x = 42;
    int *p = &x;            /* p holds the address of x */

    printf("x        = %d\n", x);
    printf("&x       = %p\n", (void *)&x);     /* where x lives */
    printf("p        = %p\n", (void *)p);      /* the same address */
    printf("*p       = %d\n", *p);             /* what is there: 42 */
    printf("&p       = %p\n", (void *)&p);     /* p itself has an address too */

    *p = 100;               /* write THROUGH the pointer */
    printf("after *p = 100, x = %d\n", x);     /* 100 -- same object */

    increment(&x);
    printf("after increment(&x), x = %d\n", x); /* 101 */

    /* The operators are inverses: *&x is just x. */
    printf("x = %d, *&x = %d  (the * undoes the &)\n", x, *&x);

    /* int *bad;  *bad = 5;      undefined: uninitialized pointer */
    /* int *q = &42;             error: literals have no address  */
    return 0;
}
```

```text
   Memory (addresses simplified)

   address    contents        name
   --------   -------------   ------
   0x7ffc10   |    42     |   x
   0x7ffc18   | 0x7ffc10  |   p     <- p HOLDS the address of x

     &x  ->  0x7ffc10        "where is x?"
     p   ->  0x7ffc10        same value
     *p  ->  42              "what is at 0x7ffc10?"
     &p  ->  0x7ffc18        p is an object too, with its own address

              p
        +-----------+          +-------+
        | 0x7ffc10  | -------> |  42   |  x
        +-----------+          +-------+
```

**Key Takeaways**

- `&x` gives the address of an object; `*p` gives the object at an address. They are inverses: `*&x` is `x`.
- Read `int *p;` as "`*p` is an `int`" — the `*` belongs with the name.
- Pointers exist to let functions modify a caller's data, to avoid copying large objects, and to build dynamic structures.
- `&` needs an lvalue: literals and arithmetic results have no address.
- Dereferencing an uninitialized, null, or dangling pointer is undefined behavior; print pointers with `%p` and a `(void *)` cast.

> 🧪 Practice
>
> 1. Declare an `int`, take its address, print the value through the pointer, then modify it through the pointer and print the original variable.
> 2. Write `void swap(int *a, int *b)` and prove from `main` that both variables changed.
> 3. Print `&x`, `p`, and `&p` for `int x; int *p = &x;` and explain in one sentence what each address refers to.
> 4. Interview-style: *"What does `*p++` do, and how does it differ from `(*p)++`?"* Hint: consult the precedence of postfix `++` versus unary `*`, and say which object each version modifies.

#### Pointer Declaration and Types

**Theory**

A pointer is not just "an address". It is an address **plus a type**, and the type is what makes the pointer useful.

Consider the address `0x1000`. On its own it says nothing: is there an `int` there? A `char`? The first byte of a struct? The pointer's type answers three questions the hardware cannot:

1. **How many bytes to read or write** when you dereference. `*(char *)p` touches 1 byte; `*(double *)p` touches 8.
2. **How to interpret those bytes** — as a two's complement integer, an IEEE 754 float, a pointer, and so on.
3. **How far `p + 1` moves** — by `sizeof(*p)` bytes, not by one byte. This is the whole basis of pointer arithmetic.

All object pointers are the same *size* on a given platform (8 bytes on typical 64-bit systems), because they all hold an address. But they are not the same *type*, and C will not implicitly convert between them — `int *p = &some_double;` is a constraint violation, not a warning to ignore.

Declaration syntax has one classic trap:

```c
int *a, b;      /* a is int *, b is plain int -- the * binds to the NAME */
int *a, *b;     /* both are pointers                                     */
int* a, b;      /* SAME as the first line: the spacing is a lie          */
```

The `*` is part of the declarator, not the type specifier. This is why `int *p;` (star with the name) is the dominant C style, while `int* p;` (star with the type) reads as if it distributes across the declaration when it does not. The safest habit is one declaration per line.

Pointers must be initialized before use. An uninitialized pointer holds whatever was on the stack — dereferencing it is undefined behavior and may corrupt anything. Initialize to `NULL` if you have no target yet.

Some types worth naming:

| Declaration | Meaning |
| --- | --- |
| `int *p` | pointer to `int` |
| `const int *p` | pointer to constant `int` (cannot write `*p`) |
| `int *const p` | constant pointer to `int` (cannot reassign `p`) |
| `void *p` | pointer to unknown type (no arithmetic, no dereference) |
| `int **p` | pointer to pointer to `int` |
| `int (*p)[5]` | pointer to array of 5 `int` |
| `int (*p)(void)` | pointer to function returning `int` |
| `struct node *p` | pointer to a struct — may point to an *incomplete* type |

That last row is worth noting: you can declare a pointer to a type whose definition you have not seen. This is what makes opaque pointers (Chapter 4.3) and self-referential structs possible.

**Examples**

```c
#include <stdio.h>

int main(void)
{
    int    i = 65;
    double d = 3.14;
    char   c = 'A';

    int    *pi = &i;
    double *pd = &d;
    char   *pc = &c;

    /* Every pointer is the same SIZE ... */
    printf("sizeof(int*)=%zu sizeof(double*)=%zu sizeof(char*)=%zu\n",
           sizeof pi, sizeof pd, sizeof pc);

    /* ... but the type decides how much is read and how far +1 moves. */
    printf("sizeof(*pi)=%zu sizeof(*pd)=%zu sizeof(*pc)=%zu\n",
           sizeof *pi, sizeof *pd, sizeof *pc);

    printf("pi+1 advances %zu bytes\n", (size_t)((char *)(pi + 1) - (char *)pi));
    printf("pd+1 advances %zu bytes\n", (size_t)((char *)(pd + 1) - (char *)pd));
    printf("pc+1 advances %zu bytes\n", (size_t)((char *)(pc + 1) - (char *)pc));

    /* Same address, different interpretation. */
    unsigned char *bytes = (unsigned char *)&i;   /* legal: char* may alias anything */
    printf("i = %d, first byte = 0x%02x\n", i, bytes[0]);

    /* The declaration trap. */
    int *a, b;          /* a is a pointer; b is a plain int */
    a = &i; b = 5;
    printf("a points to %d, b = %d\n", *a, b);

    /* double *wrong = &i;   ERROR: incompatible pointer types */
    return 0;
}
```

```text
   One address, three interpretations

   memory:  ... 41 00 00 00 1f 85 eb 51 b8 1e 09 40 ...
                ^
                0x1000

   (char   *)0x1000  ->  reads 1 byte  -> 0x41 = 'A'
   (int    *)0x1000  ->  reads 4 bytes -> 65 (little-endian)
   (double *)0x1000  ->  reads 8 bytes -> some float value

   The bytes never changed. The TYPE decided what they mean.
```

**Key Takeaways**

- A pointer's type determines how many bytes a dereference touches, how they are interpreted, and how far `p + 1` moves.
- All object pointers are typically the same size, but they are distinct types and do not implicitly convert.
- The `*` binds to the declarator: `int *a, b;` declares one pointer and one `int` — declare one variable per line.
- Always initialize pointers; use `NULL` when there is no target yet.
- A pointer to an incomplete type is legal, which is what enables opaque handles and self-referential structs.

> 🧪 Practice
>
> 1. Declare pointers to `char`, `int`, and `double`, and print both `sizeof(pointer)` and `sizeof(*pointer)` for each.
> 2. Write `int *a, b;`, assign to both, and print their types' behavior; then fix the declaration so both are pointers.
> 3. Take the address of an `int`, cast it to `unsigned char *`, and print all four bytes in hex. Explain the order you see.
> 4. Interview-style: *"If all pointers are 8 bytes, why does C need pointer types at all?"* Hint: give three things the compiler cannot do without the type, one of which involves `+ 1`.

#### NULL Pointers

**Theory**

Sometimes a pointer needs to mean "nothing here": a search found no match, a list has no next node, an allocation failed. C reserves one value for that — the **null pointer** — guaranteed to compare unequal to any valid object address.

`NULL` is a macro from `<stddef.h>` (and `<stdio.h>`, `<stdlib.h>`, and others), defined as an implementation-defined null pointer constant, usually `((void *)0)` or plain `0`. Any pointer assigned the constant `0` becomes null, which is why `if (p == 0)` and `if (p == NULL)` are equivalent. C23 adds `nullptr`, a properly typed null pointer constant that avoids the ambiguities of `0` in variadic and generic contexts.

Do not confuse three different "nothings":

| Thing | What it is | Where used |
| --- | --- | --- |
| `NULL` | Null pointer constant | Pointers |
| `'\0'` | The character with value 0 | String terminator |
| `0` | The integer zero | Arithmetic |

They may share a bit pattern, but conflating them in code obscures intent.

**Dereferencing a null pointer is undefined behavior.** In practice, on hosted systems, the page at address 0 is deliberately left unmapped so the hardware traps the access — that is what a segmentation fault usually is. That is a courtesy of the operating system, not a guarantee of the language: on some embedded systems address 0 is real memory, and the write silently corrupts it.

Idiomatically, the null test is written by truthiness, because any nonzero scalar is true (Chapter 3.1):

```c
if (p)  { /* p is not null */ }
if (!p) { /* p is null     */ }
```

Three habits make null handling reliable:

**Check what can fail.** `malloc`, `fopen`, `strchr`, `getenv`, and most search functions return `NULL` on failure. Checking is not optional.

**Initialize to `NULL`.** An uninitialized pointer is worse than a null one: it holds garbage that may point at valid memory, so the bug does not trap — it corrupts.

**Null out after freeing.** `free(p); p = NULL;` converts a dangling pointer (undefined behavior, unpredictable) into a null pointer (an immediate, reproducible crash). And since `free(NULL)` is explicitly a no-op, a double free becomes harmless.

That last guarantee is worth remembering as a design pattern: several standard functions accept `NULL` and do nothing, which lets cleanup code stay branch-free. Writing your own destructors the same way (`if (!p) return;`) is good practice.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Sentinel convention: NULL means "not found". */
const char *find(const char *hay, char needle)
{
    for (; *hay; hay++)
        if (*hay == needle) return hay;
    return NULL;
}

/* Destructor style: tolerate NULL so callers need no guard. */
void destroy(char *p)
{
    if (!p) return;      /* the same courtesy free() extends to us */
    free(p);
}

int main(void)
{
    int *p = NULL;                    /* initialize: no target yet */
    printf("p is %s\n", p ? "not null" : "null");
    /* *p = 5;   undefined behavior -- typically a segmentation fault */

    /* Every allocation can fail. */
    int *buf = malloc(10 * sizeof *buf);
    if (buf == NULL) {                /* mandatory check */
        fprintf(stderr, "allocation failed\n");
        return EXIT_FAILURE;
    }
    buf[0] = 1;

    free(buf);
    buf = NULL;      /* dangling -> null: turns silent UB into a clean crash */
    free(buf);       /* explicitly safe: free(NULL) does nothing */

    /* Sentinel returns must be tested before use. */
    const char *hit = find("hello", 'z');
    printf("find 'z': %s\n", hit ? hit : "(not found)");

    /* fopen is the classic forgotten check. */
    FILE *f = fopen("/definitely/not/here", "r");
    if (!f) { perror("fopen"); }
    else    { fclose(f); }

    destroy(NULL);   /* harmless by design */
    return 0;
}
```

```text
   Three states a pointer can be in

   valid      p ---> [ live object ]      dereference: fine
   null       p ---> (address 0)          dereference: traps immediately
   dangling   p ---> [ freed / dead ]     dereference: UNDEFINED, may
                                          appear to work, may corrupt

   free(p); p = NULL;   moves a pointer from the worst state to the
                        second-best one: failures become loud and
                        reproducible instead of silent and random.
```

**Key Takeaways**

- `NULL` is the "points to nothing" value, guaranteed distinct from any valid object address; C23 adds the typed `nullptr`.
- Keep `NULL`, `'\0'`, and `0` distinct in your code even where they share a representation.
- Dereferencing null is undefined behavior; the segmentation fault you usually get is the OS being helpful, not a language guarantee.
- Always check functions that signal failure with `NULL` — `malloc`, `fopen`, `strchr`, `getenv`.
- Initialize pointers to `NULL` and set them to `NULL` after `free`; `free(NULL)` is a guaranteed no-op, so write your own destructors to tolerate it too.

> 🧪 Practice
>
> 1. Write a program that dereferences a `NULL` pointer, run it, and note the exact signal and message. Then run it under `-fsanitize=undefined`.
> 2. Write a `find_index` function returning a pointer to a matching element or `NULL`, and handle both cases at the call site.
> 3. Write a cleanup function that takes a pointer, frees it, and demonstrate that calling it twice is safe when you null the caller's copy — then explain why passing `char **` would be needed to null it inside the function.
> 4. Interview-style: *"Why is setting a pointer to NULL after `free` recommended, and when does it not help?"* Hint: consider a second pointer to the same block, and what a struct field copy does.

#### Pointer Arithmetic

**Theory**

Pointer arithmetic is what makes C's array traversal fast and its buffer bugs possible. The rule is simple and easy to misremember:

> Adding an integer `n` to a pointer advances it by `n * sizeof(*p)` **bytes**, not by `n` bytes.

The pointer type supplies the scale. For `int *p` on a 32-bit-int machine, `p + 1` moves 4 bytes; for `double *q`, `q + 1` moves 8; for `char *c`, `c + 1` moves 1. The compiler multiplies for you, which is precisely why `a[i]` can be defined as `*(a + i)` and still land on element `i` rather than byte `i`.

Four operations are defined on pointers:

| Operation | Result | Notes |
| --- | --- | --- |
| `p + n`, `p - n` | Pointer | Scaled by the element size |
| `p++`, `p--` | Pointer | Move one element |
| `p - q` | `ptrdiff_t` | Number of *elements* between them, not bytes |
| `p == q`, `p < q` | `int` | Comparison; ordering is only meaningful within one array |

Pointer subtraction is the one people misuse. `q - p` gives the element count, so `&a[5] - &a[2]` is 3, not 12. Its type is `ptrdiff_t` from `<stddef.h>`, printed with `%td`.

The boundaries are strict, and violating them is undefined behavior even if you never dereference:

- You may point anywhere from the first element to **one past the last**.
- `a + n` (one past the end) is valid to compute and compare, and that is what makes `for (p = a; p != a + n; p++)` correct.
- Dereferencing `a + n` is undefined. So is computing `a - 1`.
- Arithmetic and comparison between pointers into **different** objects is undefined — the compiler is entitled to assume it does not happen, so it is not merely "unportable".

There is no arithmetic on `void *` (its element size is unknown) or on function pointers, though GCC permits `void *` arithmetic as an extension treating it as `char *`.

The idiom this all enables is the pointer walk:

```c
for (const int *p = a; p != a + n; p++)
    total += *p;
```

Is it faster than indexing? On modern compilers, essentially never — they generate the same code. Choose whichever is clearer; indexing usually is, except when walking a null-terminated string, where the pointer form is natural.

Finally, mind precedence: `*p++` parses as `*(p++)` — dereference the old value, then advance the pointer. To increment the pointee, write `(*p)++`. This distinction appears in real code constantly, most famously in `while (*dst++ = *src++);`.

**Examples**

```c
#include <stdio.h>
#include <stddef.h>

int main(void)
{
    int a[6] = {10, 20, 30, 40, 50, 60};
    int *p = a;                 /* decay: p points at a[0] */

    /* Arithmetic is scaled by the element size. */
    printf("p   -> %d\n", *p);
    printf("p+1 -> %d  (advanced %zu bytes)\n", *(p + 1),
           (size_t)((char *)(p + 1) - (char *)p));
    printf("p+3 -> %d\n", *(p + 3));

    /* Subtraction yields ELEMENTS, not bytes. */
    int *q = &a[5];
    ptrdiff_t gap = q - p;
    printf("q - p = %td elements (%zu bytes apart)\n",
           gap, (size_t)((char *)q - (char *)p));

    /* The canonical walk: 'a + n' is a legal sentinel. */
    long total = 0;
    for (const int *it = a; it != a + 6; it++) total += *it;
    printf("total = %ld\n", total);

    /* Comparison orders pointers within one array. */
    printf("p < q : %s\n", (p < q) ? "yes" : "no");

    /* Precedence: *p++ vs (*p)++ */
    p = a;
    int v = *p++;               /* read a[0], THEN advance p */
    printf("v = %d, now *p = %d\n", v, *p);      /* 10, then 20 */
    p = a;
    (*p)++;                     /* increment a[0] itself */
    printf("a[0] is now %d\n", a[0]);            /* 11 */

    /* --- Undefined, even without dereferencing --- */
    /* int *before = a - 1;              before the first element */
    /* int x = *(a + 6);                 one past the end, dereferenced */
    /* int b[3]; if (a < b) { }          different objects */
    return 0;
}
```

```text
   int a[6];  int *p = a;

        a[0]  a[1]  a[2]  a[3]  a[4]  a[5]   (one past end)
       +-----+-----+-----+-----+-----+-----+· · ·
       | 10  | 20  | 30  | 40  | 50  | 60  |
       +-----+-----+-----+-----+-----+-----+· · ·
       ^     ^                       ^     ^
       p    p+1                     p+5   p+6
       |<--- 4 bytes --->|                 |
                                           legal to compute and compare,
                                           undefined to dereference

   q - p  counts ELEMENTS:  &a[5] - &a[0] = 5   (not 20)
```

**Key Takeaways**

- `p + n` advances by `n * sizeof(*p)` bytes; the pointer's type supplies the scale.
- `p - q` yields a `ptrdiff_t` element count, not a byte count; print it with `%td`.
- The valid range is the first element through one-past-the-end; computing `a - 1` or dereferencing `a + n` is undefined behavior.
- Arithmetic or ordering comparison between pointers into different objects is undefined, not merely unportable.
- `*p++` dereferences then advances the pointer; `(*p)++` increments the pointed-to value.

> 🧪 Practice
>
> 1. Print `p`, `p+1`, and `p+2` for `int *`, `char *`, and `double *` pointers into their own arrays, and report the byte differences.
> 2. Compute `&a[7] - &a[2]` for an `int a[10]` and explain why the answer is 5 rather than 20.
> 3. Rewrite an indexed array-sum loop as a pointer walk using `!=` against `a + n`, and confirm identical results.
> 4. Interview-style: *"Why is `a + n` legal but `a - 1` undefined for an array `a[n]`?"* Hint: think about what a loop needs as a termination sentinel, and about arrays placed at the very start of a memory segment.

#### Pointers and Arrays Relationship

**Theory**

Beginners are often told "arrays and pointers are the same in C". They are not, and the confusion causes real bugs. The accurate statement is narrower:

> An array *expression* decays to a pointer to its first element in most contexts, and an array parameter *is* a pointer. Otherwise, arrays and pointers are different types with different behavior.

Here is the full comparison:

| Property | `int a[5]` | `int *p` |
| --- | --- | --- |
| What it is | 5 contiguous ints | One variable holding an address |
| `sizeof` | 20 (whole array) | 8 (the pointer) |
| Can be reassigned | No — `a = ...` is an error | Yes — `p = ...` |
| Storage for elements | Yes, it is the storage | No, points elsewhere |
| `&x` type | `int (*)[5]` | `int **` |
| Increment `x++` | Illegal | Legal |
| Where allocated | Where declared | Wherever it points |

The decisive difference: **an array name is not a modifiable lvalue.** `a = p;` does not compile. `a` designates storage; it is not a variable holding a value that could be changed. A pointer, by contrast, is an ordinary variable whose value happens to be an address.

The syntactic overlap comes from decay plus the definition `a[i] == *(a + i)`. Because both an array and a pointer can appear where a pointer is expected, both support `[]`, `*`, and arithmetic. That is convenience, not identity.

The most damaging place this bites is across translation units. If one file has:

```c
char buf[100];            /* an ARRAY: buf IS 100 bytes */
```

and another declares:

```c
extern char *buf;         /* a POINTER: WRONG */
```

then the second file reads the first 8 bytes of the character data and treats them as an address. It compiles, it links, and it crashes or corrupts memory at run time — the compiler never sees both declarations at once (Chapter 4.3). The header must say `extern char buf[];`.

Two more places where the difference is visible and useful:

**String initialization.** `char s[] = "hi";` copies 3 bytes into a writable array. `char *p = "hi";` stores the address of a read-only literal. Writing through `p` is undefined behavior. This is Chapter 5.4's central point.

**Function parameters.** Here the array really does become a pointer: `void f(int a[5])` has parameter type `int *`. This adjustment happens only in parameter declarations, and only to the outermost dimension.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    int  a[5] = {1, 2, 3, 4, 5};
    int *p    = a;                  /* legal: array decays */

    /* Both support the same syntax ... */
    printf("a[2]=%d p[2]=%d *(a+2)=%d *(p+2)=%d\n",
           a[2], p[2], *(a + 2), *(p + 2));

    /* ... but they are NOT the same type. */
    printf("sizeof a = %zu  (the array)\n",   sizeof a);   /* 20 */
    printf("sizeof p = %zu  (the pointer)\n", sizeof p);   /*  8 */

    p++;                            /* fine: p is a variable */
    printf("after p++, *p = %d\n", *p);
    /* a++;      ERROR: a is not a modifiable lvalue */
    /* a = p;    ERROR: cannot assign to an array     */

    /* &a and &p have different types. */
    int (*pa)[5] = &a;              /* pointer to array of 5 int */
    int **pp     = &p;              /* pointer to pointer to int */
    printf("(*pa)[0] = %d, **pp = %d\n", (*pa)[0], **pp);

    /* What a wrong 'extern char *buf;' does: the CHARACTERS get read
       as if they were an address. */
    char buf[8] = "ABCDEFG";
    unsigned long long as_address;
    memcpy(&as_address, buf, sizeof as_address);   /* reinterpret the bytes */
    printf("buf's bytes read as an address: 0x%llx\n", as_address);
    return 0;
}
```

```text
   char buf[8] = "ABCDEFG";        (the ARRAY: the bytes themselves)

   0x2000: 41 42 43 44 45 46 47 00
           A  B  C  D  E  F  G  \0

   Correct view (extern char buf[]):
       buf --> 0x2000, and the data starts right there.

   Wrong view (extern char *buf):
       "buf" is read as a POINTER stored at 0x2000,
       so its value is 0x0047464544434241  <- the letters, as an address
       Dereferencing that lands somewhere meaningless.
```

**Key Takeaways**

- Arrays and pointers are distinct types; the overlap comes from decay and from `a[i] == *(a + i)`.
- An array name is not a modifiable lvalue: it cannot be assigned, incremented, or copied wholesale.
- `sizeof` and `&` reveal the difference — `sizeof a` is the whole array, and `&a` has type `T (*)[N]`.
- Declaring an array as `extern T *` in another file is a serious bug that compiles and links but misinterprets data as an address.
- A parameter written as an array is adjusted to a pointer; that is the one place they truly coincide.

> 🧪 Practice
>
> 1. Write a program that prints `sizeof` for an array and for a pointer to its first element, then try `a++` and record the error.
> 2. Define `char buf[16] = "hello";` in one file, declare `extern char *buf;` in another, and observe the run-time failure. Fix it with `extern char buf[];`.
> 3. Declare `int (*pa)[5]` and `int **pp` for the same array and pointer, and print what each dereference chain yields.
> 4. Interview-style: *"When is an array not a pointer?"* Hint: name the contexts where decay does not happen, and the assignment rule that has no pointer equivalent.

#### const with Pointers

**Theory**

`const` means "this cannot be modified through this name". With pointers there are two things that could be constant — the pointer and the pointee — so there are four combinations, and reading them correctly is a small skill worth acquiring.

The reliable technique is to **read the declaration right to left from the name**:

```c
int *p;              /* p is a pointer to int                          */
const int *p;        /* p is a pointer to int-that-is-const            */
int const *p;        /* identical to the line above                    */
int *const p;        /* p is a const pointer to int                    */
const int *const p;  /* p is a const pointer to int-that-is-const      */
```

The rule that resolves the ambiguity: `const` applies to whatever is immediately to its **left**, unless there is nothing there, in which case it applies to the right. That is why `const int *` and `int const *` mean the same thing, while `int *const` is different — the `const` is right of the `*`, so it qualifies the pointer.

| Declaration | Can change `*p`? | Can change `p`? |
| --- | --- | --- |
| `int *p` | Yes | Yes |
| `const int *p` | No | Yes |
| `int *const p` | Yes | No |
| `const int *const p` | No | No |

The overwhelmingly common one is `const int *` (also written `const char *` for strings): a read-only view of data you do not own. Use it on every parameter you do not intend to write through. It costs nothing at run time and buys three things: the compiler catches accidental writes, callers can pass `const` data and string literals, and the signature documents the contract.

Two subtleties matter.

**Conversions are one-way.** `int *` converts implicitly to `const int *` — adding a restriction is always safe. The reverse requires an explicit cast, and *modifying* an object that was originally defined `const` is undefined behavior even if you cast the qualifier away. `const` is a promise about the object, not just a view.

**`const` is shallow.** `const struct S *p` prevents you from writing `p->field`, but if `field` is itself a pointer, `*(p->field)` is still writable. Likewise, a `const` pointer to non-const data protects only the pointer.

For two-level pointers there is a genuine wart: `char **` does *not* convert to `const char **`, even though it looks like it should. The reason is that allowing it would let you smuggle a `const` object's address into a non-const pointer. The workaround is `const char *const *`.

**Examples**

```c
#include <stdio.h>

/* The workhorse: a read-only view. Callers may pass literals and const data. */
size_t count_char(const char *s, char c)
{
    size_t n = 0;
    for (; *s; s++)          /* modifying s (the pointer) is fine */
        if (*s == c) n++;
    /* *s = 'x';                ERROR: s points to const char */
    return n;
}

int main(void)
{
    int x = 10, y = 20;

    /* 1. Everything modifiable. */
    int *p1 = &x;
    *p1 = 11; p1 = &y;

    /* 2. Pointer to const: the DATA is protected. */
    const int *p2 = &x;
    /* *p2 = 12;      ERROR: read-only data */
    p2 = &y;          /* fine: the pointer itself is not const */

    /* 3. Const pointer: the POINTER is fixed. */
    int *const p3 = &x;
    *p3 = 13;         /* fine: the data is writable */
    /* p3 = &y;       ERROR: cannot reassign a const pointer */

    /* 4. Both. */
    const int *const p4 = &x;
    /* *p4 = 14;      ERROR */
    /* p4  = &y;      ERROR */

    printf("x=%d y=%d *p2=%d *p4=%d\n", x, y, *p2, *p4);

    /* Adding const is implicit; removing it needs a cast (and is dangerous). */
    int  *mutable_p = &x;
    const int *view = mutable_p;             /* fine: adds a restriction */
    /* int *back = view;                     ERROR without a cast        */
    int *back = (int *)view;                 /* legal here only because x
                                                was not defined const     */
    *back = 99;
    printf("x = %d\n", x);

    /* const applies to the ORIGINAL object, not just the view: */
    const int frozen = 5;
    int *cheat = (int *)&frozen;
    /* *cheat = 6;    UNDEFINED BEHAVIOR: frozen was defined const */
    (void)cheat;

    printf("count_char = %zu\n", count_char("hello world", 'l'));
    return 0;
}
```

```text
   Read right to left from the name:

   const int *p          p -> pointer -> to int -> that is const
   |________|  |         "pointer to const int": data locked, pointer free
                |
   int *const p          p -> const -> pointer -> to int
        |____| |         "const pointer to int": pointer locked, data free

           const int *p              int *const p
        p  [ can move ]           p  [ FIXED ]
             |                          |
             v                          v
          [ locked data ]           [ writable data ]
```

**Key Takeaways**

- Read declarations right to left from the name; `const` qualifies what is immediately to its left, or to its right if nothing is there.
- `const T *p` protects the data; `T *const p` protects the pointer; both can be combined.
- Use `const T *` on every parameter you do not write through — it is free, compiler-enforced documentation.
- `T *` converts implicitly to `const T *`, but casting the other way and then writing to an originally-`const` object is undefined behavior.
- `const` is shallow, and `char **` does not implicitly convert to `const char **`; use `const char *const *`.

> 🧪 Practice
>
> 1. Declare all four `const` combinations for a pointer to `int`, then attempt both a pointer reassignment and a write through each, recording which four attempts fail.
> 2. Write `void print_all(const char *const *strings, size_t n)` and call it with an array of string literals.
> 3. Add `const` to the parameters of a function you wrote earlier and confirm it still compiles at every call site.
> 4. Interview-style: *"What does `const char * const * p` mean, and why can't I pass a `char **` to it?"* Hint: peel one level at a time, and consider what a single-level `const` conversion would let a caller smuggle through.

#### void Pointers

**Theory**

Sometimes a function must handle memory without knowing its type. `memcpy` copies bytes; `qsort` sorts anything; `malloc` returns storage that could become anything. C's tool for this is `void *` — a pointer to an unspecified type, C's closest thing to a generic pointer.

Its defining property: **any object pointer converts to `void *` and back implicitly, without a cast and without losing information.** That round trip is guaranteed, which is what makes generic APIs possible.

The price is that a `void *` carries no type, so two operations are forbidden:

- **You cannot dereference it.** `*vp` is meaningless — how many bytes would it read?
- **You cannot do arithmetic on it.** `vp + 1` has no defined step size. (GCC and Clang allow it as an extension, treating it as `char *`; `-Wpedantic` flags it.)

To use the data you must convert to a concrete pointer type first. In C that conversion is implicit — `int *p = malloc(n);` needs no cast. In fact, **casting the result of `malloc` is discouraged in C**: it is redundant, and before C99 it could mask a missing `<stdlib.h>` include, hiding the implicit-declaration bug (Chapter 4.1). (C++ requires the cast, which is the source of the disagreement you will see in older code.)

The generic-function pattern combines `void *` with an explicit element size, and often a callback:

```c
void qsort(void *base, size_t n, size_t size,
           int (*cmp)(const void *, const void *));
```

`qsort` never knows what it is sorting. It moves `size` bytes at a time and asks your comparison function to order any two elements. The comparator receives `const void *` and casts back to the real type — the safety C gives up in exchange for genericity. If you cast to the wrong type there, nothing catches it.

Two related points:

**`void *` is for object pointers only.** Converting a *function* pointer to `void *` is not guaranteed by the standard (POSIX requires it to work so `dlsym` can function). Use a function pointer type instead.

**`char *` and `unsigned char *` are the byte-level view.** When you need to inspect or copy raw bytes, cast to `unsigned char *`: those types are explicitly allowed to alias any object, and arithmetic on them steps one byte at a time.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* A generic swap: works for any type, given the element size. */
void generic_swap(void *a, void *b, size_t size)
{
    unsigned char *pa = a, *pb = b;      /* byte view: arithmetic is per-byte */
    for (size_t i = 0; i < size; i++) {
        unsigned char t = pa[i];
        pa[i] = pb[i];
        pb[i] = t;
    }
}

/* A qsort comparator: the caller's type knowledge is restored by casting. */
int cmp_int(const void *a, const void *b)
{
    int x = *(const int *)a;             /* cast back to the REAL type */
    int y = *(const int *)b;
    return (x > y) - (x < y);            /* avoids overflow of x - y */
}

/* A generic printer driven by an explicit tag -- void* carries no type. */
typedef enum { T_INT, T_DOUBLE, T_STRING } Type;

void print_any(const void *value, Type t)
{
    switch (t) {
    case T_INT:    printf("int: %d\n",    *(const int *)value);    break;
    case T_DOUBLE: printf("double: %g\n", *(const double *)value); break;
    case T_STRING: printf("string: %s\n",  (const char *)value);   break;
    }
}

int main(void)
{
    int    i = 42;
    double d = 3.14;
    char   s[] = "hello";

    print_any(&i, T_INT);
    print_any(&d, T_DOUBLE);
    print_any(s,  T_STRING);

    int x = 1, y = 2;
    generic_swap(&x, &y, sizeof x);
    printf("swapped ints: x=%d y=%d\n", x, y);

    double p = 1.5, q = 2.5;
    generic_swap(&p, &q, sizeof p);      /* the same function, another type */
    printf("swapped doubles: p=%g q=%g\n", p, q);

    int arr[] = {5, 2, 9, 1, 7};
    size_t n = sizeof arr / sizeof arr[0];
    qsort(arr, n, sizeof arr[0], cmp_int);
    printf("sorted: ");
    for (size_t k = 0; k < n; k++) printf("%d ", arr[k]);
    putchar('\n');

    /* malloc returns void*: the conversion is implicit, no cast needed. */
    int *buf = malloc(n * sizeof *buf);  /* NOT (int *)malloc(...) in C */
    if (!buf) return EXIT_FAILURE;
    memcpy(buf, arr, n * sizeof *buf);
    printf("copied first = %d\n", buf[0]);
    free(buf);

    /* void *vp = &i; *vp;      ERROR: cannot dereference void*   */
    /* vp + 1;                  not portable: no element size     */
    return 0;
}
```

```text
   void * : an address with the type erased

   int i = 42;
   void *vp = &i;          <- implicit, no cast, no information lost

   *vp            ERROR  (how many bytes? interpreted how?)
   vp + 1         ERROR  (step by what?)
   *(int *)vp     42     <- restore the type, then dereference

   Genericity in C = void* (the bytes)
                   + size_t (how many)
                   + a callback or tag (what they mean)
```

**Key Takeaways**

- `void *` is a typeless object pointer; conversions to and from any object pointer type are implicit and lossless.
- It cannot be dereferenced or used in arithmetic — convert to a concrete type first.
- Do not cast `malloc`'s return value in C; the conversion is automatic and the cast can hide a missing header.
- Generic APIs pair `void *` with an explicit element size and usually a callback (`qsort`, `bsearch`, `memcpy`).
- Type safety is your responsibility across a `void *` boundary; use `unsigned char *` for byte-level work and function pointer types for functions.

> 🧪 Practice
>
> 1. Write `void print_bytes(const void *p, size_t n)` that prints `n` bytes in hex, and call it on an `int` and a `double`.
> 2. Write a `qsort` comparator for an array of `double` and one for an array of `struct { char name[16]; int score; }` ordered by score.
> 3. Implement `generic_swap` and use it on two `struct` values, verifying the contents actually exchanged.
> 4. Interview-style: *"Why can't you dereference or do arithmetic on a `void *`?"* Hint: both operations need one number that the type would normally supply.

<a id="53-advanced-pointer-use"></a>
### 5.3 Advanced Pointer Use

With the fundamentals in place, pointers compose: pointers to pointers, arrays of pointers, and pointers to functions. These are the building blocks of dynamic data structures, argument vectors, and the callback-driven designs that give C its polymorphism. This section closes with the technique for reading any declaration, however tangled.

#### Pointers to Pointers

**Theory**

A pointer is an object with an address, so you can take a pointer to it. `int **pp` holds the address of an `int *`, which holds the address of an `int`. This is not cleverness for its own sake — two levels of indirection solve two specific problems that one level cannot.

**Problem 1: modifying a caller's pointer.** C passes by value (Chapter 4.1), so a function receiving `int *p` gets a *copy* of the address. Assigning to `p` inside the function changes only the copy. If the function must make the caller's pointer point somewhere else — allocate a buffer, advance a cursor, unlink a list node — it needs the address of the pointer: `int **`.

This is the difference between "modify what the pointer points at" (one level) and "modify the pointer itself" (two levels). The same reasoning that turned `swap(int, int)` into `swap(int *, int *)` turns `alloc(int *)` into `alloc(int **)`.

**Problem 2: dynamic tables of pointers.** A `char **` can point at the first element of an array of `char *`, which is how `argv`, environment vectors, and dynamically allocated 2D arrays are represented. Each element is itself a pointer to a separately allocated block.

The classic application is the linked-list deletion loop, where `struct node **` lets you treat "the head pointer" and "some node's `next` field" uniformly, eliminating the special case for removing the first element. That trick — hold a pointer to the pointer you might need to change — is one of the more elegant idioms in C.

Reading multi-level dereferences is mechanical: each `*` peels one level.

```c
int    x  = 5;
int   *p  = &x;      /*  *p  is x           */
int  **pp = &p;      /*  *pp is p, **pp is x */
int ***ppp = &pp;    /* ***ppp is x          */
```

Beyond three levels, readability collapses; a struct or a typedef is almost always the better design.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

/* Fails: modifies a COPY of the caller's pointer. */
void alloc_broken(int *p, size_t n)
{
    p = malloc(n * sizeof *p);   /* the caller never sees this */
    if (p) p[0] = 1;
}

/* Works: receives the ADDRESS of the caller's pointer. */
int alloc_ok(int **p, size_t n)
{
    *p = malloc(n * sizeof **p); /* writes THROUGH to the caller's variable */
    if (!*p) return -1;
    (*p)[0] = 1;
    return 0;
}

/* The idiom: a pointer-to-pointer removes the head special case entirely. */
struct node { int value; struct node *next; };

void remove_value(struct node **head, int target)
{
    struct node **link = head;               /* points at the head pointer   */
    while (*link) {
        if ((*link)->value == target) {
            struct node *dead = *link;
            *link = dead->next;              /* rewrite whichever pointer
                                                led here -- head or ->next  */
            free(dead);
            return;
        }
        link = &(*link)->next;               /* advance to the next LINK */
    }
}

int main(void)
{
    int x = 5;
    int *p = &x;
    int **pp = &p;

    printf("x=%d  *p=%d  **pp=%d\n", x, *p, **pp);
    **pp = 50;                               /* reaches all the way to x */
    printf("after **pp = 50, x = %d\n", x);

    int *buf = NULL;
    alloc_broken(buf, 10);
    printf("after alloc_broken, buf is %s\n", buf ? "set" : "still NULL");

    if (alloc_ok(&buf, 10) == 0) {
        printf("after alloc_ok, buf[0] = %d\n", buf[0]);
        free(buf);
    }

    /* Linked list: build 1 -> 2 -> 3 on the heap. */
    struct node *head = NULL;
    for (int v = 3; v >= 1; v--) {           /* prepend, so it ends up 1,2,3 */
        struct node *n = malloc(sizeof *n);
        if (!n) return EXIT_FAILURE;
        n->value = v;
        n->next  = head;
        head = n;
    }

    remove_value(&head, 1);                  /* removes the HEAD, no special case */
    remove_value(&head, 3);                  /* removes the tail, same code */
    for (struct node *n = head; n; n = n->next)
        printf("list node: %d\n", n->value); /* only 2 remains */

    while (head) { struct node *dead = head; head = head->next; free(dead); }
    return 0;
}
```

```text
   int x = 5;  int *p = &x;  int **pp = &p;

     pp            p             x
   +--------+    +--------+    +------+
   | &p     |--->| &x     |--->|  5   |
   +--------+    +--------+    +------+
    0x30          0x20          0x10

   *pp   -> p   (the pointer)
   **pp  -> 5   (the value)


   Why the list idiom works:

   head ---> [1] ---> [2] ---> [3] ---> NULL
    ^         ^
    |         |
   link points AT head           link points AT node[1].next
   (so *link = ... rewrites head, with identical code)
```

**Key Takeaways**

- `T **` holds the address of a `T *`; each `*` peels one level of indirection.
- To let a function change the caller's *pointer* (not just the pointee), pass the pointer's address.
- Arrays of pointers (`argv`, string tables, ragged 2D arrays) are naturally reached through a `T **`.
- Holding a pointer-to-pointer to the current link makes linked-list insertion and deletion uniform, with no head special case.
- More than two or three levels is a design smell; introduce a struct or typedef instead.

> 🧪 Practice
>
> 1. Write `void set_to_null(int **p)` that sets the caller's pointer to `NULL`, and prove from `main` that it worked.
> 2. Write both `alloc_broken` and `alloc_ok` above and explain, in terms of copies, why only one succeeds.
> 3. Implement `remove_value` and use it to delete the first, a middle, and the last element of a list.
> 4. Interview-style: *"Why does a function that frees a list need `struct node **` rather than `struct node *`?"* Hint: after the last free, what should the caller's head pointer contain, and who can set it?

#### Arrays of Pointers

**Theory**

An array of pointers is a table of addresses. Each element points somewhere else — typically to strings or to separately allocated blocks of differing sizes.

The declaration needs care, because `[]` binds tighter than `*`:

```c
char *names[3];    /* array of 3 pointers to char        */
char (*p)[3];      /* pointer to an array of 3 char      */
```

The parentheses are the whole difference. Read `char *names[3]` as: `names` is an array (of 3) of pointer to char.

The primary use case is **ragged data** — rows of different lengths. A 2D array `char words[3][20]` reserves 20 bytes for every word, wasting space and imposing a maximum. `char *words[3] = {"hi", "elephant", "a"};` stores three pointers to literals of exactly the sizes needed.

The trade-off against a true 2D array is worth stating explicitly:

| | `char grid[3][20]` | `char *table[3]` |
| --- | --- | --- |
| Memory layout | One contiguous 60-byte block | 3 pointers + 3 separate blocks |
| Row lengths | All identical | Independent |
| Access cost | Computed offset | One pointer dereference |
| Cache behavior | Excellent | Depends on where rows landed |
| Rows swappable | Copy the bytes | Swap two pointers |
| Total size known by | `sizeof grid` | Neither — must track it |

Sorting is the classic illustration: sorting `char *table[]` swaps 8-byte pointers, while sorting `char grid[][20]` copies 20 bytes per swap.

The most familiar array of pointers in all of C is `argv`. `int main(int argc, char *argv[])` receives a table of `argc` string pointers, with `argv[argc]` guaranteed to be `NULL`. Because a parameter's outermost array dimension decays, `char *argv[]` and `char **argv` are the same declaration.

Building a *dynamic* 2D array as an array of pointers means two allocation levels — one for the row table, one per row — and freeing must mirror that in reverse. It is more code than a single flat `malloc(rows * cols * sizeof(T))` with manual indexing, and worse for cache locality, but it permits ragged rows and row swapping. Choose deliberately.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare_strings(const void *a, const void *b)
{
    /* a and b point AT the array elements, which are themselves char*. */
    const char *const *pa = a, *const *pb = b;
    return strcmp(*pa, *pb);
}

int main(int argc, char *argv[])     /* identical to char **argv */
{
    /* Ragged strings: each pointer targets a literal of its own length. */
    const char *words[] = {"pear", "fig", "banana", "kiwi"};
    size_t n = sizeof words / sizeof words[0];

    printf("sizeof words = %zu (%zu pointers)\n", sizeof words, n);
    for (size_t i = 0; i < n; i++)
        printf("  words[%zu] = %-8s (%zu chars)\n", i, words[i], strlen(words[i]));

    /* Sorting moves POINTERS, not characters. */
    char *sortable[] = {"pear", "fig", "banana", "kiwi"};
    qsort(sortable, 4, sizeof sortable[0], compare_strings);
    printf("sorted:");
    for (size_t i = 0; i < 4; i++) printf(" %s", sortable[i]);
    putchar('\n');

    /* argv is an array of pointers, NULL-terminated by the standard. */
    printf("argc = %d\n", argc);
    for (int i = 0; argv[i] != NULL; i++)
        printf("  argv[%d] = %s\n", i, argv[i]);

    /* A dynamic ragged 2D array: two levels of allocation. */
    size_t rows = 3;
    size_t lens[] = {2, 5, 9};
    int **table = malloc(rows * sizeof *table);      /* the row table */
    if (!table) return EXIT_FAILURE;
    for (size_t i = 0; i < rows; i++) {
        table[i] = malloc(lens[i] * sizeof **table); /* each row, own length */
        if (!table[i]) {                             /* unwind on failure */
            while (i--) free(table[i]);
            free(table);
            return EXIT_FAILURE;
        }
        for (size_t j = 0; j < lens[i]; j++) table[i][j] = (int)(i * 10 + j);
    }
    printf("ragged: table[2][8] = %d\n", table[2][8]);

    for (size_t i = 0; i < rows; i++) free(table[i]);   /* rows first ... */
    free(table);                                       /* ... then the table */
    return 0;
}
```

```text
   char *words[4] = {"pear", "fig", "banana", "kiwi"};

   words (a contiguous array of 4 pointers)
   +---------+---------+---------+---------+
   |  ptr    |  ptr    |  ptr    |  ptr    |
   +----|----+----|----+----|----+----|----+
        |         |         |         |
        v         v         v         v
     "pear\0"  "fig\0"  "banana\0"  "kiwi\0"     <- separate, sized to fit


   Contrast with char grid[4][8]:  ONE 32-byte block, every row padded to 8

   +--------+--------+--------+--------+
   |pear\0  |fig\0   |banana\0|kiwi\0  |
   +--------+--------+--------+--------+
   contiguous and cache-friendly, but a 9-char word does not fit
```

**Key Takeaways**

- `T *a[N]` is an array of pointers; `T (*a)[N]` is a pointer to an array — the parentheses decide.
- Arrays of pointers hold ragged data efficiently and make swapping or sorting rows a pointer-sized operation.
- A true 2D array is one contiguous block with better cache behavior but uniform row sizes.
- `argv` is an array of `argc` string pointers with a guaranteed `NULL` at `argv[argc]`.
- A dynamic ragged array needs one allocation for the table plus one per row, freed in reverse order.

> 🧪 Practice
>
> 1. Build a `const char *months[12]` table and print each entry with its length.
> 2. Sort an array of `char *` with `qsort` and `strcmp`, then explain what physically moved during the sort.
> 3. Allocate a ragged `int **` with rows of lengths 1..5, fill each row with its index, print it, and free it correctly.
> 4. Interview-style: *"When would you choose `int **` over a flat `int *` for a matrix?"* Hint: weigh cache locality and allocation count against the need for ragged rows and O(1) row swaps.

#### Pointers to Functions

**Theory**

Functions live in memory too, and a function's name — like an array's — decays to a pointer to it in most expressions. A **function pointer** stores that address, letting you store, pass, and call functions as data. This is how C achieves polymorphism without inheritance: the caller decides at run time which code executes.

The declaration mirrors the function's signature, with the name wrapped in parentheses:

```c
int  add(int, int);          /* a function                        */
int (*fp)(int, int);         /* a POINTER to such a function      */
int *gp(int, int);           /* WRONG: a function returning int * */
```

Without the parentheses, `*` binds to the return type, and you have declared a function, not a pointer. This is the same precedence rule as `char *a[3]` versus `char (*a)[3]`.

The type includes the parameter types and the return type, and they must match exactly — a function pointer is strongly typed. Calling through an incompatible function pointer is undefined behavior, not a reinterpretation.

The syntax is forgiving in one respect: assignment and calls work with or without the extra operators.

```c
fp = add;    fp = &add;      /* identical: the name decays          */
fp(2, 3);    (*fp)(2, 3);    /* identical: calling dereferences it  */
```

The older `(*fp)(2, 3)` style makes the indirection visible; `fp(2, 3)` is what modern code writes. Pick one.

A `typedef` makes function pointers readable, and is close to mandatory once they appear in parameter lists or structs:

```c
typedef int (*BinaryOp)(int, int);   /* BinaryOp is now a usable type name */
BinaryOp op = add;
```

Two constraints to remember: function pointers may **not** be converted to `void *` portably (POSIX guarantees it so `dlsym` works, the C standard does not), and you cannot do arithmetic on them. Also note that a null function pointer is possible and must be checked before calling, just like a data pointer.

The uses follow in the next topic, but the shape is already visible: any time you want to parameterize *behavior* rather than data — a comparison, an event handler, a state transition — a function pointer is C's answer.

**Examples**

```c
#include <stdio.h>

int add(int a, int b)      { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }

/* A typedef turns an unreadable type into a usable name. */
typedef int (*BinaryOp)(int, int);

/* Taking behavior as a parameter: the caller chooses the operation. */
int apply(BinaryOp op, int a, int b)
{
    if (!op) return 0;      /* function pointers can be NULL too */
    return op(a, b);
}

/* Returning a function pointer -- readable thanks to the typedef. */
BinaryOp select_op(char symbol)
{
    switch (symbol) {
    case '+': return add;
    case '-': return subtract;
    case '*': return multiply;
    default:  return NULL;
    }
}

int main(void)
{
    int (*fp)(int, int) = add;      /* the raw declaration */

    printf("fp(7, 3)     = %d\n", fp(7, 3));      /* modern call syntax  */
    printf("(*fp)(7, 3)  = %d\n", (*fp)(7, 3));   /* classic, identical  */

    fp = &subtract;                 /* '&' is optional and equivalent */
    printf("after fp = &subtract: %d\n", fp(7, 3));

    printf("apply(multiply, 7, 3) = %d\n", apply(multiply, 7, 3));

    /* Choosing behavior at run time. */
    const char *symbols = "+-*/";
    for (const char *s = symbols; *s; s++) {
        BinaryOp op = select_op(*s);
        if (op) printf("7 %c 3 = %d\n", *s, op(7, 3));
        else    printf("7 %c 3 = (unsupported)\n", *s);
    }

    /* The type must match exactly. */
    /* double (*wrong)(int, int) = add;   ERROR: incompatible types */
    return 0;
}
```

```text
   Declaration anatomy

   int (*fp)(int, int);
       ^^^^   ^^^^^^^^   ^
       |      |          +-- returns int
       |      +------------- takes (int, int)
       +-------------------- fp is a pointer

   Without the parentheses:
   int *gp(int, int);     -> gp is a FUNCTION returning int*


   What is stored

     fp                   text segment (code)
   +--------+           +------------------------+
   | 0x4005 |---------> | add:  push rbp ...     |
   +--------+           |       ret              |
                        +------------------------+

   Assigning fp = subtract just changes the stored address.
```

**Key Takeaways**

- A function name decays to a pointer to the function; `f`, `&f`, `fp(...)`, and `(*fp)(...)` are all equivalent forms.
- Declare with the name in parentheses: `int (*fp)(int, int)`. Without them you declare a function returning a pointer.
- Function pointer types must match the signature exactly; calling through an incompatible type is undefined behavior.
- Use a `typedef` as soon as a function pointer appears in a parameter, return type, or struct member.
- Function pointers do not portably convert to `void *` and support no arithmetic; check for `NULL` before calling.

> 🧪 Practice
>
> 1. Declare a function pointer for `int f(int)`, assign three different functions to it in turn, and call each.
> 2. Write `int apply(int (*op)(int, int), int a, int b)` and pass it three different operations.
> 3. Write `select_op` returning a function pointer, first without a typedef and then with one; compare readability.
> 4. Interview-style: *"What is the difference between `int (*f)(void)` and `int *f(void)`?"* Hint: apply the precedence of `()` versus `*` and describe what each name denotes.

#### Callbacks and Dispatch Tables

**Theory**

Function pointers become powerful when they are used as **callbacks** — you hand a function to another function so it can call you back — and as **dispatch tables**, arrays or structs of function pointers that replace long `switch` chains.

**Callbacks invert control.** `qsort` knows how to sort but not how to compare; you know how to compare but not how to sort. You pass a comparator, and `qsort` calls it whenever it needs an ordering decision. The standard library uses this shape in `qsort`, `bsearch`, and `atexit`; POSIX uses it for signal handlers and thread entry points; every GUI and event loop is built on it.

A well-designed callback API includes a **context parameter** — an opaque `void *` passed straight back to the callback. Without one, the callback can only reach global state, which breaks reentrancy and thread safety. C's own `qsort` famously lacks this (hence the non-portable `qsort_r`), so when you design a callback interface, include the context from the start.

**Dispatch tables replace branching with indexing.** Instead of

```c
switch (opcode) {
case OP_ADD: return do_add(a, b);
case OP_SUB: return do_sub(a, b);
...
}
```

you build an array indexed by opcode:

```c
static int (*const ops[])(int, int) = { [OP_ADD] = do_add, [OP_SUB] = do_sub };
return ops[opcode](a, b);
```

The gain is not primarily speed — compilers turn dense `switch`es into jump tables anyway — but structure. Adding a case means adding one table entry rather than editing control flow, the table can be data-driven, and the set of handlers becomes inspectable at run time. The cost is that you must bounds-check the index yourself and handle null entries, since neither is automatic.

**Structs of function pointers are C's vtables.** Group related operations into a struct, and you have an interface that different implementations can satisfy:

```c
struct writer {
    int (*write)(void *ctx, const char *data, size_t n);
    void (*close)(void *ctx);
    void *ctx;
};
```

A file writer, a socket writer, and an in-memory buffer writer all provide the same struct with different function pointers. Callers use them identically. This is precisely how the Linux kernel's `file_operations` and countless C libraries achieve polymorphism.

Always initialize function pointer tables fully (designated initializers make gaps explicit as `NULL`) and check before calling — a null entry called is an immediate crash.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ---------- 1. A callback with a context parameter ---------- */
/* The context is what makes the callback reusable and thread-safe. */
void for_each(const int *a, size_t n, void (*fn)(int, void *), void *ctx)
{
    for (size_t i = 0; i < n; i++) fn(a[i], ctx);
}

static void accumulate(int value, void *ctx)
{
    long *total = ctx;          /* the caller's state, not a global */
    *total += value;
}

static void print_item(int value, void *ctx)
{
    const char *label = ctx;
    printf("%s%d ", label, value);
}

/* ---------- 2. A dispatch table ---------- */
typedef enum { OP_ADD, OP_SUB, OP_MUL, OP_COUNT } OpCode;

static int op_add(int a, int b) { return a + b; }
static int op_sub(int a, int b) { return a - b; }
static int op_mul(int a, int b) { return a * b; }

/* 'const' table of function pointers, indexed by opcode. */
static int (*const dispatch[OP_COUNT])(int, int) = {
    [OP_ADD] = op_add,
    [OP_SUB] = op_sub,
    [OP_MUL] = op_mul,
};

int execute(OpCode op, int a, int b)
{
    if (op < 0 || op >= OP_COUNT || dispatch[op] == NULL)
        return 0;                       /* YOU must bounds-check, not the compiler */
    return dispatch[op](a, b);
}

/* ---------- 3. A struct of function pointers: C's vtable ---------- */
struct writer {
    int  (*write)(void *ctx, const char *s);
    void (*close)(void *ctx);
    void *ctx;
};

static int stdout_write(void *ctx, const char *s) { (void)ctx; return fputs(s, stdout); }
static void stdout_close(void *ctx)               { (void)ctx; }

static int buffer_write(void *ctx, const char *s)
{
    char *buf = ctx;
    strcat(buf, s);                     /* demo only: assumes capacity */
    return 0;
}
static void buffer_close(void *ctx) { printf("[buffer holds: %s]\n", (char *)ctx); }

/* One caller, many implementations -- the polymorphism C actually has. */
void emit_report(struct writer *w)
{
    w->write(w->ctx, "report line 1\n");
    w->write(w->ctx, "report line 2\n");
    w->close(w->ctx);
}

int main(void)
{
    int data[] = {1, 2, 3, 4, 5};
    size_t n = sizeof data / sizeof data[0];

    long total = 0;
    for_each(data, n, accumulate, &total);      /* context carries the result */
    printf("total = %ld\n", total);

    for_each(data, n, print_item, "#");
    putchar('\n');

    printf("dispatch: %d %d %d\n",
           execute(OP_ADD, 7, 3), execute(OP_SUB, 7, 3), execute(OP_MUL, 7, 3));

    struct writer to_stdout = { stdout_write, stdout_close, NULL };
    emit_report(&to_stdout);

    char buf[128] = "";
    struct writer to_buffer = { buffer_write, buffer_close, buf };
    emit_report(&to_buffer);                    /* same function, different behavior */
    return 0;
}
```

```text
   Dispatch table: an array indexed by opcode

   dispatch[]        code
   +---------+     +-----------+
   | OP_ADD  |---->| op_add    |
   +---------+     +-----------+
   | OP_SUB  |---->| op_sub    |
   +---------+     +-----------+
   | OP_MUL  |---->| op_mul    |
   +---------+     +-----------+

   execute(op, a, b)  ->  dispatch[op](a, b)
                          ^
                          one indexed call replaces the whole switch


   Struct of function pointers = one interface, many implementations

   emit_report(w) ---> w->write ---> stdout_write   (writes to the terminal)
                                or   buffer_write   (appends to memory)
                                or   socket_write   (sends over a network)
```

**Key Takeaways**

- Callbacks invert control: the library calls your function when it needs a decision it cannot make itself.
- Always include a `void *` context parameter in callback APIs; without it, callbacks depend on globals and lose reentrancy.
- Dispatch tables replace `switch` chains with an indexed array of function pointers, making the handler set data-driven and extensible.
- You must bounds-check the index and null-check the entry yourself — the language checks neither.
- A struct of function pointers plus a context is C's vtable, and the standard way to write polymorphic interfaces.

> 🧪 Practice
>
> 1. Write `void map(int *a, size_t n, int (*fn)(int))` that applies a transformation in place, and call it with a squaring and a negating function.
> 2. Build a four-entry calculator dispatch table indexed by an enum, including a division handler that reports divide-by-zero.
> 3. Extend `for_each` with a callback that finds the maximum, using the context pointer to carry the running maximum out.
> 4. Interview-style: *"How would you implement virtual functions in C?"* Hint: describe what a struct of function pointers stored inside (or beside) each object gives you, and where the `this` pointer comes from.

#### Reading Complex Declarations

**Theory**

C declarations are notoriously hard to read, and the reason is structural: **a declaration mimics the syntax of the expression that uses the variable.** `int *p` means "the expression `*p` has type `int`". Once you internalize that, even `char *(*(*x[3])(int))[5]` becomes decodable — it just takes discipline.

The systematic method is the **spiral rule**, or more reliably the "right-left" procedure:

1. Find the **identifier**.
2. Look **right**. If you see `[`, say "array of"; if `(`, say "function returning". Consume all of them at this nesting level.
3. Look **left**. If you see `*`, say "pointer to".
4. When you hit a closing parenthesis, move out one level and repeat from step 2.
5. Finish with the base type.

Two precedence facts drive everything: `[]` and `()` bind **tighter** than `*`. That is why parentheses appear so often — they exist purely to defeat that precedence.

Work through the four cases that matter in practice:

| Declaration | Reading | Meaning |
| --- | --- | --- |
| `int *a[5]` | a, array of 5, pointer to, int | Array of 5 pointers |
| `int (*a)[5]` | a, pointer to, array of 5, int | Pointer to an array of 5 |
| `int *f(void)` | f, function returning, pointer to, int | Function returning a pointer |
| `int (*f)(void)` | f, pointer to, function returning, int | Pointer to a function |

The difference in each pair is one set of parentheses, and it changes the type completely.

Two tools help. `cdecl` (a command-line program, also at cdecl.org) translates in both directions. And the compiler itself will tell you: declare the variable, then deliberately assign an `int` to it and read the error message, which names the exact type.

The best practice, though, is not to need the skill. **`typedef` breaks any complex declaration into readable pieces:**

```c
typedef int (*Handler)(int, char *);   /* one clear name             */
typedef Handler HandlerTable[10];      /* an array of them           */
Handler *get_handlers(void);           /* trivially readable now     */
```

Nested function pointers in particular should always be typedef'd. If a declaration takes more than a few seconds to parse, that is a defect in the code, not a challenge to rise to.

**Examples**

```c
#include <stdio.h>

int  value = 42;
int  square(int x) { return x * x; }
int  arr5[5] = {1, 2, 3, 4, 5};

/* Function returning a pointer to int. */
int *get_value(void) { return &value; }

/* Function returning a pointer to an array of 5 int -- typedef'd for sanity. */
typedef int Row5[5];
Row5 *get_row(void) { return &arr5; }

int main(void)
{
    /* 1. array of 5 pointers to int */
    int *a[5];
    a[0] = &value;
    printf("1. *a[0]      = %d\n", *a[0]);

    /* 2. pointer to an array of 5 int */
    int (*b)[5] = &arr5;
    printf("2. (*b)[2]    = %d, sizeof *b = %zu\n", (*b)[2], sizeof *b);

    /* 3. function returning pointer to int */
    int *(*fn_ret_ptr)(void) = get_value;
    printf("3. *fn()      = %d\n", *fn_ret_ptr());

    /* 4. pointer to function returning int */
    int (*fn_ptr)(int) = square;
    printf("4. fn_ptr(6)  = %d\n", fn_ptr(6));

    /* 5. array of 3 pointers to functions returning int */
    int (*table[3])(int) = { square, square, square };
    printf("5. table[1](5)= %d\n", table[1](5));

    /* The same thing, made readable with typedefs. */
    typedef int (*IntFn)(int);
    IntFn clean_table[3] = { square, square, square };
    printf("6. clean[2](4)= %d\n", clean_table[2](4));

    printf("7. (*get_row())[4] = %d\n", (*get_row())[4]);
    return 0;
}
```

```text
   Decoding  int (*table[3])(int)

   step 1: find the identifier           table
   step 2: look right -> [3]             table is an array of 3
   step 3: look left  -> *               ... of pointers to
   step 4: out one level, right -> (int) ... functions taking (int)
   step 5: base type                     ... returning int

   Reading:  "table is an array of 3 pointers to functions
              taking an int and returning an int"


   The precedence that causes all the confusion:

     []  and  ()   bind tighter than   *

     int *a[5]     ->  *(a[5])     -> array of pointers
     int (*a)[5]   ->  (*a)[5]     -> pointer to array
```

```bash
# Let a tool do it when in doubt:
cdecl> explain int (*table[3])(int)
declare table as array 3 of pointer to function (int) returning int
```

**Key Takeaways**

- A declaration mirrors the expression that uses the identifier: `int *p` says `*p` is an `int`.
- Read outward from the identifier — right first for `[]` and `()`, then left for `*` — obeying parentheses.
- `[]` and `()` bind tighter than `*`; parentheses exist to override that, and their presence flips the meaning entirely.
- `int *a[5]` is an array of pointers, `int (*a)[5]` a pointer to an array; `int *f()` returns a pointer, `int (*f)()` is a pointer to a function.
- Prefer `typedef` for anything beyond one level of indirection — needing the spiral rule is a sign the declaration should be split.

> 🧪 Practice
>
> 1. Write out, in English, the meanings of `char **argv`, `int (*daytab)[13]`, `void (*signal(int, void (*)(int)))(int)`.
> 2. Declare "an array of 5 pointers to functions taking `double` and returning `char *`", then rewrite it with two typedefs.
> 3. Take one complex declaration from your own code or a system header and decode it step by step, then verify with `cdecl`.
> 4. Interview-style: *"What does `void (*signal(int, void (*)(int)))(int);` declare?"* Hint: start at `signal`, note it is a function first, and identify what its second parameter and its return type have in common.

<a id="54-strings"></a>
### 5.4 Strings

C has no string type. It has a convention: a sequence of characters ending in a zero byte, manipulated through pointers. This section covers that convention, the standard functions built on it, and the specific ways it goes wrong — because more C security vulnerabilities come from string handling than from anything else.

#### Null-Terminated Character Arrays

**Theory**

Other languages store a string as a length plus the bytes. C stores only the bytes, and marks the end with a **null terminator** — a byte with value zero, written `'\0'`.

That single design decision explains nearly everything about C strings:

- A "string" is just a `char` array whose contents happen to end with `'\0'`. There is no string type, no length field, no capacity.
- Any function that processes a string must **scan** to find the end. `strlen` is O(n), not O(1).
- A `char *` can point into the middle of a string and the result is still a valid string — the tail from that point on. This is why `strchr` can return a pointer and callers can use it directly.
- **If the terminator is missing, every string function runs off the end** of the array, reading whatever follows until it finds a zero byte somewhere in unrelated memory. This is the root of the buffer overflow.

The storage must always be one byte larger than the visible text. `char s[6] = "hello"` holds `'h' 'e' 'l' 'l' 'o' '\0'` — five characters, six bytes. Getting this off by one is the most common single mistake in C.

Declaration forms:

```c
char a[] = "hi";        /* array of 3: 'h','i','\0' -- size deduced      */
char b[10] = "hi";      /* 10 bytes: "hi\0" then 7 more zeros            */
char c[3] = {'h','i','\0'};  /* explicit, identical to a                 */
char d[2] = "hi";       /* LEGAL but NOT a string: no room for '\0'      */
```

That last case is a genuine C quirk: initializing a `char` array with a string literal that exactly fills it drops the terminator silently, producing a character array that is not a string. Any `strlen` or `printf("%s")` on it runs off the end.

Distinguish two lengths for any buffer:

| Measure | For `char buf[10] = "hi"` | How to get it |
| --- | --- | --- |
| Buffer size (capacity) | 10 | `sizeof buf` — only where the array is visible |
| String length (content) | 2 | `strlen(buf)` — scans to `'\0'` |

`sizeof` counts the box; `strlen` counts what is in it. Confusing them, especially after an array decays to a pointer in a function, is a reliable source of overflow.

Also note that `'a'` (a `char` literal, an `int` in C) and `"a"` (a string literal, a 2-byte array) are entirely different things.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    char a[] = "hello";              /* 6 bytes: 5 chars + '\0' */
    char b[10] = "hi";               /* 10 bytes, rest zero-filled */
    char c[6] = {'h','e','l','l','o','\0'};   /* identical to a */

    printf("a: sizeof=%zu strlen=%zu\n", sizeof a, strlen(a));  /* 6, 5 */
    printf("b: sizeof=%zu strlen=%zu\n", sizeof b, strlen(b));  /* 10, 2 */
    printf("c: \"%s\"\n", c);

    /* The bytes, made visible. */
    printf("a bytes:");
    for (size_t i = 0; i < sizeof a; i++)
        printf(" %02x(%c)", (unsigned char)a[i], a[i] ? a[i] : '.');
    putchar('\n');

    /* A pointer into the middle is still a valid string. */
    const char *tail = a + 2;
    printf("tail = \"%s\"\n", tail);       /* "llo" */

    /* Manual traversal: the terminator IS the loop condition. */
    size_t n = 0;
    for (const char *p = a; *p != '\0'; p++) n++;
    printf("manual strlen = %zu\n", n);

    /* Truncating by writing a terminator -- no data is moved. */
    char word[] = "hello world";
    word[5] = '\0';
    printf("truncated = \"%s\" (but sizeof is still %zu)\n", word, sizeof word);

    /* THE TRAP: exactly-sized initializer drops the terminator. */
    char bad[2] = "hi";                    /* legal C; NOT a string */
    printf("bad[0]=%c bad[1]=%c -- no '\\0' anywhere\n", bad[0], bad[1]);
    /* printf("%s", bad);   would read past the array until a random 0 */
    return 0;
}
```

```text
   char a[] = "hello";

   index:    0    1    2    3    4    5
           +----+----+----+----+----+----+
           | h  | e  | l  | l  | o  | \0 |
           +----+----+----+----+----+----+
           0x68 0x65 0x6c 0x6c 0x6f 0x00

   sizeof a  = 6   <- the box
   strlen(a) = 5   <- scans until it hits 0x00

   a + 2 ---------------^  "llo" is a valid string too


   Missing terminator: char bad[2] = "hi";

           +----+----+  ?    ?    ?    ?
           | h  | i  | ?? | ?? | ?? | 00 |
           +----+----+----+----+----+----+
                       ^^^^^^^^^^^^^^^^^^
                       strlen keeps reading into memory
                       that is not yours
```

**Key Takeaways**

- A C string is a `char` array terminated by `'\0'`; there is no length field, so every operation scans.
- Always allocate `strlen + 1` bytes; forgetting the terminator's byte is the classic off-by-one.
- `sizeof` gives the buffer capacity (only where the array is in scope); `strlen` gives the content length by scanning.
- A pointer into the middle of a string is itself a valid string; writing `'\0'` truncates in place without moving data.
- `char s[N] = "..."` with an exactly-fitting literal silently omits the terminator, producing a non-string.

> 🧪 Practice
>
> 1. Declare `char s[20] = "test"` and print both `sizeof s` and `strlen(s)`, explaining the gap.
> 2. Write your own `size_t my_strlen(const char *s)` with a pointer walk, and verify it against `strlen`.
> 3. Build a `char` array by hand without a terminator, pass it to `printf("%s")`, and observe the garbage. Add the terminator and rerun.
> 4. Interview-style: *"What is the cost of `strlen` and why does it matter in a loop?"* Hint: consider `for (i = 0; i < strlen(s); i++)` on a long string and count total character reads.

#### String Literals and Immutability

**Theory**

A string literal — anything in double quotes — is not just syntax for characters. It is an **array object with static storage duration** that exists for the entire run of the program. Where that array lives, and whether you may write to it, is the source of one of C's nastiest crashes.

The critical distinction:

```c
char  arr[] = "hello";     /* COPIES 6 bytes into a writable array   */
char *ptr   = "hello";     /* points at the literal itself: READ-ONLY */
```

`arr` is an array initialized from the literal — you own those bytes and may modify them. `ptr` is a pointer holding the literal's address. **Modifying a string literal is undefined behavior**, and on every mainstream platform it is an immediate segmentation fault, because the compiler places literals in a read-only section (`.rodata`) that the loader maps without write permission.

The literal's type is `char[N]`, not `const char[N]` — a historical wart kept for compatibility with pre-standard code. That is why `char *p = "hello";` compiles at all despite being a loaded gun. Modern compilers warn about it (`-Wwrite-strings` makes literals `const`), and C23 finally changed the rules so that assigning a literal to a plain `char *` is deprecated.

The fix is a habit, not a flag: **always declare pointers to literals as `const char *`.** Then the compiler stops the write at compile time instead of the CPU stopping it at run time.

Two more properties are worth knowing.

**Identical literals may be shared.** Compilers commonly merge duplicate literals, so `"hello" == "hello"` may be true — or may not. Never compare strings with `==`; that compares addresses. Use `strcmp`.

**Adjacent literals concatenate at compile time.** `"hello" " " "world"` is one literal, which is how long strings are split across source lines cleanly.

Finally, the lifetime rules differ in a way that matters for returning strings. A literal has static storage duration, so returning `const char *` to one from a function is perfectly safe. Returning a pointer to a local `char` array is the dangling-pointer bug from Chapter 4.1.

**Examples**

```c
#include <stdio.h>
#include <string.h>

/* Safe: the literal outlives the function -- static storage duration. */
const char *status_name(int code)
{
    switch (code) {
    case 0:  return "ok";
    case 1:  return "warning";
    default: return "error";
    }
}

/* UNSAFE: returns a pointer to an automatic array that dies here. */
/* const char *broken(void) { char buf[] = "temp"; return buf; } */

int main(void)
{
    char  arr[] = "hello";       /* a writable COPY in this frame     */
    const char *ptr = "hello";   /* points at read-only storage       */

    arr[0] = 'H';                /* fine: we own these bytes */
    printf("arr = %s\n", arr);

    /* ptr[0] = 'H';                UNDEFINED: usually a segfault.
       Declaring ptr as 'const char *' turns this into a COMPILE error. */

    printf("sizeof arr = %zu (the array)\n",   sizeof arr);   /* 6 */
    printf("sizeof ptr = %zu (the pointer)\n", sizeof ptr);   /* 8 */

    /* Literals may be merged by the compiler -- never rely on it,
       and never compare strings with ==. */
    const char *x = "shared";
    const char *y = "shared";
    printf("x == y   : %s (implementation-defined!)\n", (x == y) ? "true" : "false");
    printf("strcmp   : %d (0 means equal -- THIS is the correct test)\n",
           strcmp(x, y));

    /* Adjacent literals concatenate at compile time. */
    const char *long_line = "This is one literal "
                            "split across two source lines.";
    printf("%s\n", long_line);

    printf("status   : %s / %s\n", status_name(0), status_name(9));
    return 0;
}
```

```text
   Process memory

   +------------------------+
   | .rodata (READ-ONLY)    |
   |   "hello\0"  <---------+---- const char *ptr
   +------------------------+
   | .data / .bss           |
   +------------------------+
   | heap                   |
   +------------------------+
   | stack                  |
   |   arr: h e l l o \0    |  <- char arr[] = "hello": a COPY, writable
   +------------------------+

   arr[0] = 'H';   ->  fine
   ptr[0] = 'H';   ->  writes into a read-only page -> SIGSEGV
```

| | `char arr[] = "hi"` | `char *ptr = "hi"` |
| --- | --- | --- |
| What it is | An array holding a copy | A pointer to the literal |
| Writable | Yes | No (undefined behavior) |
| `sizeof` | 3 | 8 (the pointer) |
| Lifetime | Its enclosing block | Whole program |
| Safe to return | No (if automatic) | Yes |

**Key Takeaways**

- A string literal is a static-lifetime array, normally placed in read-only memory; modifying one is undefined behavior.
- `char a[] = "x"` copies into a writable array; `char *p = "x"` merely points at the literal.
- Always write `const char *` for pointers to literals so the compiler catches writes at compile time.
- Never compare strings with `==` — that compares addresses, and identical literals may or may not be merged.
- Returning a literal from a function is safe; returning a local `char` array is not.

> 🧪 Practice
>
> 1. Write `char *p = "hello"; p[0] = 'H';`, run it, and record the crash. Change the declaration to `const char *` and note that the failure moves to compile time.
> 2. Compare two identical literals with `==` and with `strcmp`, and explain which result is trustworthy.
> 3. Write a function returning `const char *` for an enum-to-name lookup, and explain why no allocation is needed.
> 4. Interview-style: *"Why does `char *s = "hi"; s[0] = 'H';` compile but crash?"* Hint: separate what the type system permits from where the loader put the bytes.

#### strlen, strcpy, strcmp, strcat

**Theory**

`<string.h>` provides the classic four. All of them share one assumption — **their inputs are properly null-terminated** — and three of them share one danger: they write to a destination whose size they do not know.

**`size_t strlen(const char *s)`** scans until `'\0'` and returns the count, excluding the terminator. It is O(n). Calling it in a loop condition turns an O(n) loop into O(n squared) — hoist it into a variable.

**`char *strcpy(char *dst, const char *src)`** copies `src` including its terminator into `dst` and returns `dst`. It has **no idea how big `dst` is.** If `src` is longer, it writes past the end. This is the canonical buffer overflow, and the reason `strcpy` appears in essentially every security-critical CVE list.

**`int strcmp(const char *a, const char *b)`** compares byte by byte and returns a negative, zero, or positive value — *not* necessarily -1/0/1. The correct test for equality is `strcmp(a, b) == 0`. The ordering is by `unsigned char` value, so it is ASCII/byte order, not locale-aware alphabetical order (`strcoll` handles that).

**`char *strcat(char *dst, const char *src)`** appends `src` to the end of `dst`. It must first `strlen(dst)` to find the end, then copy — so repeated `strcat` in a loop is quadratic. It also has no size knowledge, so it overflows just as readily as `strcpy`.

The pattern is clear: **the destination's capacity is never a parameter**, so the caller must guarantee it. The required space for `strcpy` is `strlen(src) + 1`; for `strcat` it is `strlen(dst) + strlen(src) + 1`.

Two other traps:

**Overlapping buffers are undefined** for all of these. Use `memmove` when regions may overlap.

**`strcmp` on a non-terminated array** runs off the end. Every one of these functions assumes a valid string.

Return values are chosen for chaining (`strcpy` returns `dst`), which is occasionally handy but often just hides the destination. Modern code should reach for the bounded variants in the next topic, and use `snprintf` for anything involving concatenation.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    /* --- strlen: O(n), hoist it out of loops --- */
    const char *s = "hello";
    size_t len = strlen(s);                       /* 5, terminator excluded */
    printf("strlen = %zu\n", len);
    /* BAD:  for (size_t i = 0; i < strlen(s); i++)   rescans every iteration */
    for (size_t i = 0; i < len; i++) putchar(s[i]);
    putchar('\n');

    /* --- strcpy: caller must guarantee capacity --- */
    char dst[16];
    strcpy(dst, "hello");                         /* needs strlen(src)+1 = 6 */
    printf("dst = %s\n", dst);

    /* Do the arithmetic BEFORE copying. */
    const char *src = "a longer string";
    if (strlen(src) + 1 <= sizeof dst) strcpy(dst, src);
    else printf("refused: %zu bytes needed, %zu available\n",
                strlen(src) + 1, sizeof dst);

    /* char small[4]; strcpy(small, "overflow");     BUFFER OVERFLOW */

    /* --- strcmp: sign, not magnitude --- */
    printf("strcmp(\"apple\",\"banana\") = %d (negative: apple sorts first)\n",
           strcmp("apple", "banana"));
    printf("strcmp(\"abc\",\"abc\")      = %d (zero: equal)\n",
           strcmp("abc", "abc"));
    printf("strcmp(\"b\",\"a\")          = %d (positive)\n", strcmp("b", "a"));

    /* The ONLY correct equality test: */
    const char *a = "abc", *b = "abc";
    if (strcmp(a, b) == 0) puts("equal");
    /* if (a == b)   compares ADDRESSES, not contents */

    /* Byte order, not alphabetical order: */
    printf("strcmp(\"Zebra\",\"apple\")  = %d ('Z'=90 < 'a'=97)\n",
           strcmp("Zebra", "apple"));

    /* --- strcat: appends, needs room for BOTH --- */
    char buf[32] = "Hello";
    if (strlen(buf) + strlen(", world") + 1 <= sizeof buf)
        strcat(buf, ", world");
    printf("strcat -> %s\n", buf);

    /* Repeated strcat is quadratic: each call rescans from the start. */
    char acc[64] = "";
    for (int i = 0; i < 5; i++) strcat(acc, "ab");   /* fine here, bad at scale */
    printf("acc = %s\n", acc);

    /* The modern replacement for building strings: */
    char out[32];
    int written = snprintf(out, sizeof out, "%s has %zu chars", s, len);
    printf("snprintf -> %s (would need %d bytes)\n", out, written);
    return 0;
}
```

| Function | Reads | Writes | Knows destination size? | Safe alternative |
| --- | --- | --- | --- | --- |
| `strlen` | src | — | n/a | `strnlen` (POSIX) for untrusted input |
| `strcpy` | src | dst | **No** | `snprintf`, `strlcpy`, checked `memcpy` |
| `strcmp` | both | — | n/a | `strncmp` for a bounded prefix |
| `strcat` | both | dst | **No** | `snprintf` with an offset |

```text
   strcat(dst, src) does this:

   1. scan dst for '\0'          <- O(strlen(dst)) EVERY call
   2. copy src there, with '\0'

   dst: [H][e][l][l][o][\0][ ][ ][ ][ ]
                        ^ found here
   src: [!][\0]
   dst: [H][e][l][l][o][!][\0][ ][ ][ ]

   Nobody checked that dst had room. That check is YOUR job.
```

**Key Takeaways**

- All four functions require null-terminated inputs and undefined behavior follows if that fails.
- `strlen` is O(n) — hoist it out of loop conditions.
- `strcpy` and `strcat` do not know the destination size; the caller must ensure `strlen(src) + 1` and `strlen(dst) + strlen(src) + 1` bytes respectively.
- `strcmp` returns a sign, not -1/0/1; test `== 0` for equality, and remember it orders by byte value, not locale.
- Overlapping source and destination are undefined; use `memmove`. For building strings, prefer `snprintf`.

> 🧪 Practice
>
> 1. Implement `my_strlen`, `my_strcpy`, and `my_strcmp` from scratch and test them against the library versions.
> 2. Write a program that overflows a small buffer with `strcpy`, run it under `-fsanitize=address`, and read the report.
> 3. Measure the difference between `for (i = 0; i < strlen(s); i++)` and a hoisted length on a one-megabyte string.
> 4. Interview-style: *"Why is `strcmp` returning a negative number rather than `false`?"* Hint: think about what a sorting routine needs from a comparison, and what `qsort`'s comparator contract requires.

#### strncpy and Bounded Variants

**Theory**

The `n`-suffixed functions take a size limit, which sounds like the fix for the overflow problem. It partly is — but **`strncpy` is not the safe `strcpy`**, and believing it is has caused a great many bugs.

`char *strncpy(char *dst, const char *src, size_t n)` has two surprising behaviors:

1. **If `src` is longer than `n`, no terminator is written.** You get exactly `n` characters and an unterminated buffer — a non-string that the next `strlen` will run off.
2. **If `src` is shorter than `n`, the remainder is padded with zeros** — all the way to `n` bytes. Copying a 3-character string into a 4096-byte buffer writes 4096 bytes.

Neither is a bug. `strncpy` was designed in the 1970s for fixed-width fields in file records, not for safe string copying. Using it as a safe `strcpy` requires manually terminating every time:

```c
strncpy(dst, src, sizeof dst - 1);
dst[sizeof dst - 1] = '\0';        /* MANDATORY */
```

The related bounded functions behave more sensibly:

- **`strncat(dst, src, n)`** appends at most `n` characters *and always adds a terminator* — so it needs `n + 1` free bytes, and its `n` means "from src", not "total size". The correct call is `strncat(dst, src, sizeof dst - strlen(dst) - 1)`, which is error-prone enough that `snprintf` is usually better.
- **`strncmp(a, b, n)`** compares at most `n` characters; genuinely useful for prefix tests.
- **`memcpy(dst, src, n)`** copies exactly `n` bytes with no terminator logic; when you already know the length, it is the fastest and clearest choice.

The practical recommendation for new code is **`snprintf`**: it always terminates (given a nonzero size), it handles concatenation and formatting in one call, and it returns the length it *would* have written, so truncation is detectable:

```c
int n = snprintf(buf, sizeof buf, "%s/%s", dir, file);
if (n < 0 || (size_t)n >= sizeof buf) { /* truncated */ }
```

Platform-specific options exist. BSD's `strlcpy`/`strlcat` always terminate and return the length they tried to create, which makes truncation detectable; they are available on macOS and BSD, and glibc added them in version 2.38. C11 Annex K adds `strcpy_s` and friends, but the annex is optional, rarely implemented outside MSVC, and widely criticized — do not build portable code on it.

The unifying principle: **truncation is not the same as safety.** A silently truncated path, command, or hostname can itself be a vulnerability. Always detect truncation and decide deliberately what to do about it.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    /* --- Trap 1: no terminator when src is too long --- */
    char dst[6];
    memset(dst, 'X', sizeof dst);         /* poison, to make the effect visible */
    strncpy(dst, "hello world", 5);       /* copies 5 chars, NO '\0' */
    printf("bytes:");
    for (size_t i = 0; i < sizeof dst; i++) printf(" %c", dst[i]);
    printf("   <- last byte is still 'X', not '\\0'\n");
    /* printf("%s", dst);   would read past the array */

    /* The mandatory fix-up: */
    char safe[6];
    strncpy(safe, "hello world", sizeof safe - 1);
    safe[sizeof safe - 1] = '\0';         /* ALWAYS do this with strncpy */
    printf("safe = \"%s\" (truncated deliberately)\n", safe);

    /* --- Trap 2: zero-padding to the full n --- */
    char padded[16];
    strncpy(padded, "hi", sizeof padded); /* writes 2 chars + 14 zero bytes */
    printf("padded = \"%s\", strlen=%zu, but 16 bytes were written\n",
           padded, strlen(padded));

    /* --- strncat: n counts SOURCE chars and always terminates --- */
    char buf[16] = "Hello";
    strncat(buf, ", world!!!", sizeof buf - strlen(buf) - 1);  /* room for '\0' */
    printf("strncat -> \"%s\"\n", buf);

    /* --- strncmp: prefix comparison --- */
    const char *path = "/usr/local/bin";
    if (strncmp(path, "/usr", 4) == 0) puts("path starts with /usr");

    /* --- The recommended tool: snprintf, with truncation DETECTED --- */
    char out[16];
    const char *dir = "/very/long/directory", *file = "name.txt";
    int need = snprintf(out, sizeof out, "%s/%s", dir, file);
    if (need < 0) {
        puts("snprintf: encoding error");
    } else if ((size_t)need >= sizeof out) {
        printf("snprintf: TRUNCATED -- needed %d bytes, had %zu\n",
               need + 1, sizeof out);
    }
    printf("out = \"%s\" (always terminated)\n", out);

    /* --- memcpy when the length is already known --- */
    char exact[6];
    const char *src = "hello";
    size_t n = strlen(src);
    if (n + 1 <= sizeof exact) {
        memcpy(exact, src, n + 1);        /* copy the terminator explicitly */
        printf("memcpy -> \"%s\"\n", exact);
    }
    return 0;
}
```

| Function | Always terminates? | Pads? | Truncation detectable? | Verdict |
| --- | --- | --- | --- | --- |
| `strcpy` | Yes | No | n/a (overflows) | Avoid |
| `strncpy` | **No** | Yes, to `n` | No | Only for fixed-width fields |
| `strncat` | Yes | No | No | Awkward `n` semantics |
| `strlcpy` (BSD) | Yes | No | Yes (return value) | Good, not universal |
| `snprintf` | Yes | No | Yes (return value) | **Recommended default** |
| `memcpy` | n/a | No | n/a | Best when length is known |

**Key Takeaways**

- `strncpy` is not a safe `strcpy`: it omits the terminator when the source is too long and zero-pads to `n` when it is short.
- If you use `strncpy`, pass `sizeof dst - 1` and write `dst[sizeof dst - 1] = '\0'` yourself, every time.
- `strncat`'s `n` counts source characters, not total buffer size, and it always appends a terminator.
- Prefer `snprintf` for copying and building strings: it always terminates and its return value detects truncation.
- Truncation is not automatically safe — detect it and handle it, because a shortened path or command can be its own vulnerability.

> 🧪 Practice
>
> 1. Copy an 11-character string into a 6-byte buffer with `strncpy`, print the raw bytes, and show that no terminator was written.
> 2. Use `strncpy` on a short string into a large buffer and demonstrate that the whole buffer was written.
> 3. Write `int safe_copy(char *dst, size_t cap, const char *src)` using `snprintf` that returns -1 on truncation, and test both paths.
> 4. Interview-style: *"Is `strncpy` safe?"* Hint: the useful answer distinguishes "does not overflow the destination" from "produces a valid string", and names what the caller must still do.

#### Tokenizing with strtok

**Theory**

Splitting a string on delimiters — a CSV line, a path, a command — is common enough that C provides `strtok`. It works, but its interface makes it one of the most dangerous convenience functions in the standard library, and understanding why teaches a lot about C API design.

```c
char *strtok(char *str, const char *delim);
```

The usage is a two-phase loop: pass the string on the first call, then `NULL` on every subsequent call to continue from where it left off.

```c
for (char *tok = strtok(buf, ",;"); tok != NULL; tok = strtok(NULL, ",;"))
    puts(tok);
```

Three properties determine everything about how it can be used:

**1. It modifies the input.** `strtok` finds each delimiter and overwrites it with `'\0'`, then returns a pointer into your buffer. No copies are made — which is fast, but means you cannot pass a string literal (undefined behavior, Chapter 5.4) or a buffer you still need intact. Copy first if you need the original.

**2. It keeps hidden static state.** That is how it remembers its position between calls. Consequences: you cannot tokenize two strings at once, you cannot call it from a function that is itself called from within a tokenizing loop, and it is **not thread-safe** — two threads calling `strtok` corrupt each other's state.

**3. It treats runs of delimiters as one.** `"a,,b"` with delimiter `","` yields two tokens (`"a"`, `"b"`), not three. Empty fields disappear, which makes `strtok` wrong for CSV parsing where an empty column is meaningful.

The reentrant alternatives fix the state problem: POSIX `strtok_r(str, delim, &saveptr)` and Windows/C11 Annex K `strtok_s` take an explicit context pointer, so nesting and threading work. Use them whenever available.

When empty fields matter, or the input must be preserved, write the split yourself with `strchr` or `strcspn` — it is a dozen lines and avoids every one of the above problems.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    /* strtok MODIFIES its input, so copy from a literal into an array. */
    char line[] = "root:x:0:0:System Administrator:/root:/bin/bash";

    printf("tokens:\n");
    for (char *tok = strtok(line, ":"); tok; tok = strtok(NULL, ":"))
        printf("  [%s]\n", tok);

    /* The original is destroyed: delimiters became '\0'. */
    printf("after: \"%s\" (only the first field survives as a string)\n", line);

    /* Consecutive delimiters collapse -- empty fields VANISH. */
    char csv[] = "a,,b,,,c";
    printf("collapsed:");
    for (char *t = strtok(csv, ","); t; t = strtok(NULL, ",")) printf(" [%s]", t);
    printf("   <- 3 tokens, not 6\n");

    /* Reentrant version: explicit state, so nesting and threads work. */
    char data[] = "k1=v1;k2=v2;k3=v3";
    char *outer_save = NULL, *inner_save = NULL;

    for (char *pair = strtok_r(data, ";", &outer_save); pair;
         pair = strtok_r(NULL, ";", &outer_save)) {
        /* A NESTED tokenization -- impossible with plain strtok. */
        char *key = strtok_r(pair, "=", &inner_save);
        char *val = strtok_r(NULL, "=", &inner_save);
        printf("  key=%s value=%s\n", key ? key : "?", val ? val : "?");
    }

    /* Hand-rolled split that PRESERVES empty fields and the input. */
    const char *rec = "x,,y";
    printf("manual split (empty fields kept):");
    const char *start = rec;
    for (;;) {
        const char *comma = strchr(start, ',');
        int len = comma ? (int)(comma - start) : (int)strlen(start);
        printf(" [%.*s]", len, start);     /* %.*s prints a bounded slice */
        if (!comma) break;
        start = comma + 1;
    }
    putchar('\n');
    return 0;
}
```

```text
   strtok destroys as it goes

   before:  r o o t : x : 0 : 0 \0
                    ^   ^   ^
   after :  r o o t \0 x \0 0 \0 0 \0
            |------|  |-|  |-|  |-|
            returned pointers point INTO your buffer

   Hidden static state:

   call 1: strtok(line, ":")  -> saves position after "root"
   call 2: strtok(NULL, ":")  -> resumes from the saved position
                                 ^^^^^^^^^^^
                                 one global cursor: no nesting,
                                 no concurrency, no second string
```

| | `strtok` | `strtok_r` | Manual `strchr` loop |
| --- | --- | --- | --- |
| Modifies input | Yes | Yes | No |
| Thread-safe | No | Yes | Yes |
| Nestable | No | Yes | Yes |
| Empty fields | Collapsed | Collapsed | Preserved |
| Portability | Standard C | POSIX (`strtok_s` on Windows) | Universal |

**Key Takeaways**

- `strtok` splits in place by overwriting delimiters with `'\0'` and returning pointers into your buffer — never pass it a string literal.
- It stores its position in hidden static state, so it cannot be nested, cannot tokenize two strings at once, and is not thread-safe.
- Runs of delimiters collapse, so empty fields disappear — making it unsuitable for CSV where empties are meaningful.
- Use `strtok_r` (POSIX) or `strtok_s` (C11 Annex K/Windows) with an explicit save pointer whenever available.
- Write a `strchr`-based split when you must preserve the input or keep empty fields.

> 🧪 Practice
>
> 1. Tokenize `"one two three"` on spaces with `strtok` and print each token; then print the original buffer and explain what changed.
> 2. Pass a string literal to `strtok` and observe the crash. Fix it by copying into a `char` array first.
> 3. Use `strtok_r` to parse `"a=1;b=2;c=3"` into key/value pairs with a nested inner tokenizer.
> 4. Interview-style: *"Why can't you use `strtok` in a multithreaded program?"* Hint: ask where the position between calls is stored, and how many copies of it exist.

#### Searching with strchr and strstr

**Theory**

The search functions all follow one convention: **they return a pointer to the match, or `NULL` if there is none.** Returning a pointer rather than an index is deliberate — the result is itself a valid C string (the tail from the match onward), so you can print it, search it again, or copy from it directly.

The family:

| Function | Finds | Returns |
| --- | --- | --- |
| `strchr(s, c)` | First occurrence of character `c` | Pointer to it, or `NULL` |
| `strrchr(s, c)` | Last occurrence of `c` | Pointer to it, or `NULL` |
| `strstr(h, n)` | First occurrence of substring `n` | Pointer to it, or `NULL` |
| `strpbrk(s, set)` | First character from a set | Pointer to it, or `NULL` |
| `strspn(s, set)` | Length of initial run **of** set chars | A length, not a pointer |
| `strcspn(s, set)` | Length of initial run **not in** set | A length, not a pointer |
| `memchr(p, c, n)` | Byte in a bounded region | Pointer, or `NULL` |

Three details repay attention.

**`strchr`'s second parameter is an `int`, converted to `char`.** This means `strchr(s, '\0')` is well defined and returns a pointer to the terminator — a neat way to find the end of a string. It also means passing a value outside `char` range is converted, not rejected.

**To get an index, subtract.** `size_t pos = found - s;` yields a `ptrdiff_t` offset. This only makes sense when `found` is non-null, so check first.

**`memchr` is the bounded cousin.** When you have a buffer with a known length that might not be terminated — data from `read()`, a network packet — `memchr` is correct and `strchr` is a buffer overrun waiting to happen.

The `strspn`/`strcspn` pair is underused and genuinely handy: `strspn(s, " \t")` gives the length of leading whitespace (skip it by adding), and `strcspn(s, ",")` gives the distance to the next comma or to the end — which is exactly the "split preserving empty fields" primitive from the previous topic.

One performance note: `strstr` in glibc uses a two-way algorithm with linear worst-case behavior, so it is fine for general use. A naive hand-rolled substring search is O(n*m); do not write your own unless you have measured a need.

**Examples**

```c
#include <stdio.h>
#include <string.h>

int main(void)
{
    const char *path = "/usr/local/share/doc/readme.txt";

    /* strchr: first occurrence; the result is itself a valid string. */
    const char *first_slash = strchr(path, '/');
    printf("first '/' at index %td -> \"%s\"\n", first_slash - path, first_slash);

    /* strrchr: last occurrence -- the classic "basename" and "extension" idiom. */
    const char *base = strrchr(path, '/');
    base = base ? base + 1 : path;                /* skip the slash if found */
    const char *ext = strrchr(base, '.');
    printf("basename  = %s\n", base);
    printf("extension = %s\n", ext ? ext + 1 : "(none)");

    /* Always check for NULL before using the result. */
    const char *missing = strchr(path, 'Z');
    printf("'Z' found : %s\n", missing ? "yes" : "no");

    /* strstr: substring search. */
    const char *hit = strstr(path, "share");
    if (hit) printf("\"share\" at index %td\n", hit - path);

    /* Counting occurrences by advancing past each match. */
    int slashes = 0;
    for (const char *p = path; (p = strchr(p, '/')) != NULL; p++) slashes++;
    printf("slash count = %d\n", slashes);

    /* strspn / strcspn: run lengths, useful for trimming and splitting. */
    const char *line = "   \t hello, world";
    size_t ws = strspn(line, " \t");              /* leading whitespace length */
    printf("trimmed = \"%s\"\n", line + ws);

    const char *field = "name,value";
    size_t upto = strcspn(field, ",");            /* distance to the comma */
    printf("first field = \"%.*s\"\n", (int)upto, field);

    /* strpbrk: first character from a set. */
    const char *ops = strpbrk("a+b*c", "+-*/");
    printf("first operator = %c\n", ops ? *ops : '?');

    /* memchr: bounded search in data that may NOT be terminated. */
    char raw[8] = {'a','b','c','\n','d','e','f','g'};   /* no '\0' anywhere */
    char *nl = memchr(raw, '\n', sizeof raw);
    printf("newline at offset %td (strchr here would run off the end)\n",
           nl - raw);
    return 0;
}
```

```text
   const char *p = "/usr/local/bin";
                    0    5     11

   strchr(p, '/')   -> p+0   "/usr/local/bin"
   strrchr(p, '/')  -> p+10  "/bin"
   strstr(p,"local")-> p+5   "local/bin"
   strchr(p, 'Z')   -> NULL

   The return is a POINTER, so:
     index      = result - p
     tail       = result           (already a valid string)
     next match = strchr(result + 1, c)
```

**Key Takeaways**

- Search functions return a pointer to the match or `NULL`; always test before dereferencing.
- The returned pointer is a valid string for the remainder of the input, which makes chaining and printing tails trivial.
- Convert a match to an index by subtracting the base pointer (`found - s`), printed with `%td`.
- `strrchr` gives the basename/extension idiom; `strspn`/`strcspn` give trimming and field-splitting without modifying the input.
- Use `memchr` for buffers with a known length that may not be null-terminated.

> 🧪 Practice
>
> 1. Write a function that returns the file extension of a path, or `NULL`, using `strrchr`, and handle a path with no dot.
> 2. Count all occurrences of a substring in a string using `strstr` in a loop, advancing correctly past each match.
> 3. Write `char *trim_leading(char *s)` using `strspn`, and a splitter using `strcspn` that preserves empty fields.
> 4. Interview-style: *"When must you use `memchr` instead of `strchr`?"* Hint: think about data read from a socket or a file, and what `strchr` assumes about where the data ends.

#### Common String Bugs

**Theory**

String handling is where most C security vulnerabilities live. The bugs are not exotic — the same handful recur for decades — so knowing them by name is most of the defense.

**1. Off-by-one on the terminator.** Allocating `strlen(s)` bytes instead of `strlen(s) + 1`, or looping `i <= len`. The write of the final `'\0'` lands one byte past the buffer — a classic heap or stack corruption.

**2. Unbounded copy.** `strcpy`, `strcat`, `sprintf`, and `gets` write as much as the source demands. `gets` is so unfixable it was removed from the standard in C11; use `fgets`.

**3. Missing terminator.** From `strncpy` truncation, from a manually built array, or from data read with `read()`/`recv()`, which do not terminate anything. Every subsequent string operation then runs off the end.

**4. Comparing with `==`.** Compares addresses. It sometimes appears to work because identical literals may be merged, which makes the bug intermittent — the worst kind.

**5. Writing to a string literal.** `char *p = "x"; p[0] = 'y';` — undefined behavior, usually a segfault (Chapter 5.4).

**6. Returning a pointer to a local buffer.** The frame dies at `return`; the pointer dangles (Chapter 4.1).

**7. `sizeof` on a decayed pointer.** Inside a function, `sizeof buf` is the pointer size, so `strncpy(buf, src, sizeof buf)` copies 8 bytes. Pass the capacity explicitly.

**8. Off-by-one in `strncat`.** Its `n` is source characters, not total capacity, and it appends a terminator beyond them — so it needs `n + 1` free bytes.

**9. Overlapping copies.** `strcpy(s, s + 1)` is undefined; use `memmove`.

**10. Signed `char` with `<ctype.h>`.** `toupper(c)` where `c` is a plain `char` holding a byte above 127 passes a negative value, which is undefined. Cast: `toupper((unsigned char)c)`.

The defenses are systematic rather than clever:

| Defense | Catches |
| --- | --- |
| `-Wall -Wextra -Wformat-security` | Format bugs, obvious misuse |
| `-fsanitize=address,undefined` | Overflows, use-after-free, off-by-ones, at run time |
| `-D_FORTIFY_SOURCE=2 -O2` | Some overflows in libc calls, cheaply |
| Valgrind | Invalid reads/writes, leaks |
| `snprintf` everywhere | Unbounded writes and missing terminators |
| Static analyzers (`clang --analyze`, cppcheck) | Cross-function reasoning |

The habit that prevents most of this: **carry the capacity alongside every buffer**, treat every external input as unterminated until you terminate it yourself, and use `snprintf` as the default tool for building strings.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* BUG 1: off-by-one -- no room for the terminator. */
char *dup_broken(const char *s)
{
    char *p = malloc(strlen(s));        /* MISSING the +1 */
    if (p) strcpy(p, s);                /* writes one byte past the block */
    return p;
}

char *dup_fixed(const char *s)
{
    size_t n = strlen(s) + 1;           /* +1 for '\0' */
    char *p = malloc(n);
    if (p) memcpy(p, s, n);             /* length known: memcpy is clearest */
    return p;
}

/* BUG 7: sizeof on a parameter measures the POINTER. */
void copy_broken(char *dst, const char *src)
{
    strncpy(dst, src, sizeof dst);      /* 8 bytes, whatever dst really is */
    /* -Wsizeof-pointer-memaccess warns about exactly this */
}

void copy_fixed(char *dst, size_t cap, const char *src)
{
    if (cap == 0) return;
    snprintf(dst, cap, "%s", src);      /* always terminates, never overflows */
}

/* BUG 6: returning a pointer into a dead frame. */
/* const char *greet_broken(void) { char b[16]; strcpy(b, "hi"); return b; } */

/* BUG 10: plain char passed to ctype functions. */
void upcase_fixed(char *s)
{
    for (; *s; s++)
        *s = (char)toupper((unsigned char)*s);   /* the cast is REQUIRED */
}

int main(void)
{
    /* BUG 4: == compares addresses, not contents. */
    char a[] = "hello";
    const char *b = "hello";
    printf("a == b  : %s  (comparing ADDRESSES -- always wrong)\n",
           (a == b) ? "true" : "false");
    printf("strcmp  : %s  (comparing CONTENTS -- correct)\n",
           strcmp(a, b) == 0 ? "equal" : "different");

    /* BUG 3: data from a bounded read is NOT terminated for you. */
    char buf[8];
    memset(buf, 'A', sizeof buf);       /* simulate a full read() */
    /* printf("%s", buf);   would run off the end */
    buf[sizeof buf - 1] = '\0';         /* terminate it yourself */
    printf("terminated: %s\n", buf);

    /* BUG 9: overlapping regions need memmove. */
    char ov[] = "abcdef";
    memmove(ov, ov + 1, strlen(ov));    /* shift left, terminator included */
    printf("shifted : %s\n", ov);

    char *ok = dup_fixed("safe copy");
    if (ok) { printf("dup     : %s\n", ok); free(ok); }

    char out[6];
    copy_fixed(out, sizeof out, "truncate me");
    printf("bounded : \"%s\"\n", out);

    char word[] = "mixed Case";
    upcase_fixed(word);
    printf("upcased : %s\n", word);
    return 0;
}
```

```text
   The off-by-one, drawn

   malloc(strlen("hi")) = 2 bytes
   +---+---+
   | h | i |  \0  <- written HERE: one byte past the allocation
   +---+---+  ^^
              heap metadata or the next block: corrupted

   malloc(strlen("hi") + 1) = 3 bytes
   +---+---+----+
   | h | i | \0 |   correct
   +---+---+----+
```

```bash
# The single highest-value habit for string code:
gcc -g -Wall -Wextra -fsanitize=address,undefined -o prog prog.c
./prog
# ==1234==ERROR: AddressSanitizer: heap-buffer-overflow
#   WRITE of size 1 at 0x602000000012 thread T0
#     #0 strcpy
#     #1 dup_broken prog.c:11
```

**Key Takeaways**

- Allocate `strlen(s) + 1`; the terminator's byte is the most commonly forgotten one in C.
- Never use `gets`, and treat `strcpy`/`strcat`/`sprintf` as unsafe unless you have already proven the capacity.
- Data from `read`, `recv`, and `strncpy` may be unterminated — terminate it yourself before any string function touches it.
- Compare with `strcmp`, not `==`; `sizeof` on a parameter gives the pointer size, so pass capacities explicitly.
- Cast to `unsigned char` before calling `<ctype.h>` functions, use `memmove` for overlapping regions, and build strings with `snprintf`.
- Compile with `-Wall -Wextra -fsanitize=address,undefined` during development; it finds these bugs mechanically.

> 🧪 Practice
>
> 1. Write `dup_broken` above, run it under AddressSanitizer, and read the exact report. Then fix it and confirm the report disappears.
> 2. Write a function that takes `char *dst` and uses `sizeof dst` for its bound; compile with `-Wall` and explain the warning.
> 3. Read a line with `fgets`, strip the trailing newline correctly (handling the case where none is present), and print the result.
> 4. Interview-style: *"You are reviewing C code and see `strcpy(dest, src)`. What do you need to verify before approving it?"* Hint: name the two quantities that must be compared, and where each one comes from.

---

## 6. Composite and User-Defined Types

Scalars and arrays only take you so far: real programs model things — a point, a packet, a customer record — that consist of several values of different types travelling together. This chapter covers the constructs C gives you for that: `struct` for grouping, `union` for overlapping, `enum` for named constants, and `typedef` for naming the result. It closes with memory layout, because in C the difference between a 12-byte struct and a 24-byte one is often just the order you wrote the members in.

<a id="61-structures"></a>
### 6.1 Structures

A structure groups several values into one named object. This section covers how to declare and initialize one, how to reach its members through values and pointers, how structures nest and form arrays, and what happens when you pass one to a function.

#### Defining and Initializing structs

**Theory**

Suppose you are tracking employees. With scalars alone you get parallel arrays: `names[i]`, `ages[i]`, `salaries[i]`. Nothing ties index `i` in one array to index `i` in another; sort one and the rest are silently wrong. What you want is a single object holding all three fields, so they move together.

That is a `struct`: **a type whose objects contain several named members, laid out in memory in declaration order.** Unlike an array, the members may have different types, and you access them by name rather than by index.

The declaration introduces a new type:

```c
struct point {      /* 'point' is the struct TAG */
    int x;          /* members, in declaration order */
    int y;
};                  /* the semicolon is mandatory */
```

Note that `struct point` — both words — is the type name. C keeps struct tags in a separate namespace from ordinary identifiers, which is why you may have a variable named `point` and a `struct point` in the same scope, and why the `struct` keyword must appear at every use. Most code eliminates the repetition with a `typedef` (Chapter 6.3).

Several declaration forms exist:

```c
struct point { int x, y; };            /* type only                    */
struct point p1, p2;                   /* variables of that type       */
struct { int x, y; } anon;             /* anonymous: no tag, one use   */
struct point3 { int x, y, z; } origin; /* type and a variable at once  */
```

Initialization mirrors arrays. Positional initializers fill members in order, and **any member you omit is zero-initialized**:

```c
struct point a = {10, 20};    /* x=10, y=20      */
struct point b = {10};        /* x=10, y=0       */
struct point c = {0};         /* both zero       */
struct point d;               /* INDETERMINATE if automatic */
```

C99's designated initializers (covered in detail later in this section) let you name members, which is both clearer and immune to member reordering.

Three properties distinguish structs from arrays, and all three matter:

**Structs are copied on assignment.** `p2 = p1;` copies every member — a genuine value copy, unlike arrays, which cannot be assigned at all. The copy is *shallow*: a pointer member is duplicated, not what it points to.

**Structs can be passed and returned by value.** Again unlike arrays.

**Structs cannot be compared with `==`.** There is no member-wise comparison operator, and `memcmp` is not a valid substitute because padding bytes (Chapter 6.3) hold indeterminate values. Write a comparison function.

Finally, a struct may be declared without a definition — `struct node;` — creating an **incomplete type**. You can form pointers to it but not objects, which is what makes self-referential structures and opaque handles possible.

**Examples**

```c
#include <stdio.h>
#include <string.h>

struct point { int x, y; };

struct employee {
    char   name[32];
    int    age;
    double salary;
};

/* Structs cannot be compared with ==; write the comparison yourself. */
int point_equal(struct point a, struct point b)
{
    return a.x == b.x && a.y == b.y;
}

int main(void)
{
    struct point a = {10, 20};      /* positional  */
    struct point b = {10};          /* y is ZERO, not garbage */
    struct point c = {0};           /* both zero   */

    printf("a = (%d, %d)\n", a.x, a.y);
    printf("b = (%d, %d)   <- omitted member is zero\n", b.x, b.y);
    printf("c = (%d, %d)\n", c.x, c.y);

    /* Assignment copies EVERY member -- arrays cannot do this. */
    struct point copy = a;
    copy.x = 99;
    printf("a.x=%d copy.x=%d  (independent objects)\n", a.x, copy.x);

    /* if (a == copy) ...   ERROR: no == for structs */
    printf("point_equal(a, c) = %d\n", point_equal(a, c));

    /* A struct containing an array: the array IS copied along with it. */
    struct employee e1 = {"Ada Lovelace", 36, 95000.0};
    struct employee e2 = e1;                  /* the whole 48+ bytes */
    strcpy(e2.name, "Grace Hopper");
    printf("e1: %-14s age %d  $%.0f\n", e1.name, e1.age, e1.salary);
    printf("e2: %-14s age %d  $%.0f\n", e2.name, e2.age, e2.salary);

    /* Incomplete type: pointers are fine, objects are not. */
    struct node;                     /* declared, not defined */
    struct node *maybe = NULL;       /* legal */
    /* struct node actual;              ERROR: incomplete type */
    (void)maybe;
    return 0;
}
```

```text
   struct employee { char name[32]; int age; double salary; };

   offset  0                        32      36        40        48
           +------------------------+-------+---------+---------+
           | name[32]               | age   | padding | salary  |
           +------------------------+-------+---------+---------+
                                             ^^^^^^^
                                     4 bytes inserted so 'salary'
                                     lands on an 8-byte boundary
                                     (see Chapter 6.3)

   Members are laid out in DECLARATION ORDER, with padding as needed.
   The struct's own size is a multiple of its strictest member alignment.
```

**Key Takeaways**

- A `struct` groups differently typed members under one name, laid out in declaration order.
- `struct tag` is the full type name; tags live in their own namespace, which is why the keyword repeats until you add a `typedef`.
- Any member left out of an initializer is zero-initialized; an uninitialized automatic struct holds indeterminate values.
- Structs are copied on assignment and can be passed and returned by value — arrays can do none of that.
- Structs cannot be compared with `==`, and `memcmp` is unreliable because of padding; write an explicit comparison.
- A declared-but-undefined struct is an incomplete type: pointers to it are legal, objects are not.

> 🧪 Practice
>
> 1. Define `struct book { char title[64]; int year; double price; };`, create one with a partial initializer, and print every member.
> 2. Assign one struct to another, modify the copy, and prove the original is unchanged. Then add a `char *` member and show that the copy shares the pointee.
> 3. Try `if (s1 == s2)` on two structs, read the error, then write `int book_equal(const struct book *a, const struct book *b)`.
> 4. Interview-style: *"Why can't you compare two structs with `==` when you can assign them?"* Hint: assignment copies bytes you chose; comparison would have to interpret bytes nobody wrote.

#### Member Access and Arrow Operator

**Theory**

Two operators reach a struct's members, and which one you use depends on whether you hold the struct or its address:

- **`.`** (the dot, or member operator) applies to a **struct value**: `p.x`.
- **`->`** (the arrow) applies to a **pointer to a struct**: `ptr->x`.

The arrow is pure convenience. `ptr->x` is defined as exactly `(*ptr).x` — dereference the pointer, then select the member. The parentheses in that expansion are not optional: `.` binds tighter than unary `*`, so `*ptr.x` parses as `*(ptr.x)`, which tries to select a member from a *pointer* and fails to compile. The arrow exists so that nobody has to write `(*ptr).x` thousands of times.

Because pointers to structs are everywhere in C — linked structures, function parameters that avoid copying, opaque handles — `->` is one of the most-typed operators in the language.

Both operators sit in the highest precedence group along with `[]` and function calls, and they associate left to right, so chains read naturally:

```c
a.b.c          /* nested struct values           */
p->next->next  /* two pointer hops               */
arr[i].field   /* index first, then select       */
p->arr[3].x    /* dereference, index, select     */
```

Two precedence interactions are worth memorizing because they cause real bugs:

```c
++p->count     /* ++(p->count)  -- increments the MEMBER   */
(++p)->count   /* increments the POINTER, then selects     */
*p->name       /* *(p->name)    -- dereferences the member */
```

Since `->` binds tighter than `*` and than prefix `++`, the member selection happens first in the unparenthesized forms.

One more rule: the member name is not an expression. You cannot write `s.(compute_name())` or index into members by number. Selecting a member is resolved entirely at compile time, which is why C has no reflection and why generic access to fields requires `offsetof` (Chapter 6.3) or macros.

**Examples**

```c
#include <stdio.h>
#include <string.h>

struct address { char city[32]; int zip; };

struct person {
    char name[32];
    int  age;
    struct address addr;      /* a nested struct VALUE */
    struct person *next;      /* a pointer to the same type */
};

/* Taking a pointer avoids copying and is the usual C convention. */
void print_person(const struct person *p)
{
    printf("%s (%d) of %s %d\n",
           p->name, p->age,          /* arrow: p is a pointer      */
           p->addr.city,             /* arrow then dot: chained    */
           p->addr.zip);
}

int main(void)
{
    struct person alice = {"Alice", 30, {"Berlin", 10115}, NULL};
    struct person bob   = {"Bob",   25, {"Munich", 80331}, &alice};

    /* Dot on a value, arrow on a pointer. */
    printf("value  : %s, %s\n", alice.name, alice.addr.city);

    struct person *p = &bob;
    printf("pointer: %s, %s\n", p->name, p->addr.city);

    /* The arrow is exactly this: */
    printf("equivalent: %s == %s\n", p->name, (*p).name);
    /* printf("%s", *p.name);    ERROR: parses as *(p.name) */

    /* Chained hops through pointers. */
    print_person(p);
    print_person(p->next);              /* bob -> alice */
    printf("chain: %s\n", bob.next->addr.city);

    /* Precedence: what gets incremented? */
    struct person *cursor = &bob;
    printf("cursor->age before : %d\n", cursor->age);
    ++cursor->age;                      /* ++(cursor->age): the MEMBER */
    printf("cursor->age after  : %d\n", cursor->age);

    struct person list[2] = {alice, bob};
    struct person *it = list;
    printf("(++it)->name = %s   <- the POINTER moved\n", (++it)->name);

    /* Array of structs: [] binds before . */
    printf("list[0].name = %s\n", list[0].name);
    return 0;
}
```

```text
   struct person bob;   struct person *p = &bob;

        bob                                p
   +-------------+                    +---------+
   | name  "Bob" |  <---------------- | &bob    |
   | age    25   |                    +---------+
   | addr .city  |
   |      .zip   |         bob.name     -> dot: bob is a VALUE
   | next  ------+---> alice
   +-------------+         p->name      -> arrow: p is a POINTER
                           (*p).name    -> identical, spelled out
                           p->next->age -> chained hops

   Precedence:  ->  .  []  ()   bind tighter than   *  ++  --

     ++p->count   ==   ++(p->count)
     *p->name     ==   *(p->name)
```

**Key Takeaways**

- Use `.` on a struct value and `->` on a pointer to a struct; `p->x` is defined as `(*p).x`.
- The parentheses in `(*p).x` are required because `.` binds tighter than unary `*`.
- `.`, `->`, `[]`, and `()` share the highest precedence and associate left to right, so `p->a.b[i].c` reads left to right.
- `++p->count` increments the member, not the pointer; write `(++p)->count` if you meant the pointer.
- Member names are resolved at compile time — there is no runtime field lookup in C.

> 🧪 Practice
>
> 1. Create a struct value and a pointer to it, then print the same member three ways: `s.m`, `p->m`, and `(*p).m`.
> 2. Write `*p.name` and record the compiler error, then explain the parse that caused it.
> 3. Build a three-node linked list of structs on the stack and print a member reached through `a.next->next->field`.
> 4. Interview-style: *"What is the difference between `++p->x`, `(++p)->x`, and `p++->x`?"* Hint: apply the precedence table first, then say which object each expression modifies and what value it yields.

#### Nested Structures

**Theory**

A struct member may itself be a struct. This is **composition**: building complex types out of simpler ones, the same way you build functions out of functions. A `struct rectangle` contains two `struct point`s; a `struct employee` contains a `struct address`; a `struct packet` contains a `struct header`.

The nested struct is stored **inline**, as part of the outer struct's own storage — not as a pointer to it. `sizeof(struct rectangle)` includes both points in full. This gives you one contiguous object with no indirection, which is good for locality and means a single assignment copies the whole tree of values.

Access chains with `.` and `->` as far as the nesting goes:

```c
rect.top_left.x           /* value, value            */
prect->top_left.x         /* pointer, then value     */
p->addr.city              /* pointer, then value     */
```

Initialization nests with braces that mirror the structure:

```c
struct rectangle r = { {0, 0}, {10, 5} };
```

The inner braces are optional (C allows flattening, `{0, 0, 10, 5}`) but omitting them is a false economy — compilers warn under `-Wmissing-braces`, and the flattened form breaks silently if a member is added.

C11 added **anonymous structs and unions**: a nested struct or union with no member name, whose members are accessed as if they belonged to the outer struct. This is genuinely useful for grouping without adding a level of naming:

```c
struct value {
    int type;
    union {                 /* anonymous: no member name */
        int    i;
        double d;
    };                      /* accessed as v.i and v.d, not v.u.i */
};
```

The alternative to nesting by value is nesting by pointer — `struct address *addr`. That is the right choice when the inner object is large, optional, shared, or of a type whose definition you would rather not expose (Chapter 6.3's opaque types). The cost is an allocation, an indirection, and a lifetime to manage.

Note the one thing a struct cannot contain: **itself, by value.** `struct node { struct node next; };` is infinitely large and rejected. A *pointer* to the same type is fine, because a pointer has a known size even when the type is still incomplete. That is exactly how linked lists and trees are built.

**Examples**

```c
#include <stdio.h>

struct point { int x, y; };

struct rectangle {
    struct point top_left;      /* stored INLINE, not as a pointer */
    struct point bottom_right;
};

/* C11 anonymous union: members are reached directly through the outer struct. */
struct value {
    enum { V_INT, V_DOUBLE } type;
    union {                     /* no member name */
        int    i;
        double d;
    };
};

/* Self-reference must go through a POINTER. */
struct node {
    int value;
    struct node *next;          /* legal: pointer to an incomplete type */
    /* struct node  bad;           ERROR: infinitely sized */
};

int area(const struct rectangle *r)
{
    int w = r->bottom_right.x - r->top_left.x;   /* arrow, then dot */
    int h = r->bottom_right.y - r->top_left.y;
    return w * h;
}

int main(void)
{
    /* Nested braces mirror the nesting. */
    struct rectangle r = { {0, 0}, {10, 5} };

    printf("top_left    = (%d, %d)\n", r.top_left.x, r.top_left.y);
    printf("area        = %d\n", area(&r));
    printf("sizeof rect = %zu (both points stored inline)\n", sizeof r);

    /* One assignment copies the whole nested tree. */
    struct rectangle copy = r;
    copy.top_left.x = 99;
    printf("r.top_left.x=%d copy.top_left.x=%d\n", r.top_left.x, copy.top_left.x);

    /* Anonymous union: v.i, not v.u.i */
    struct value v = { .type = V_DOUBLE };
    v.d = 3.5;
    printf("anonymous   : type=%d d=%.1f\n", v.type, v.d);

    /* Self-referential struct: the basis of every linked structure. */
    struct node c = {3, NULL}, b = {2, &c}, a = {1, &b};
    for (struct node *n = &a; n; n = n->next) printf("%d ", n->value);
    putchar('\n');
    return 0;
}
```

```text
   Nesting by VALUE (inline):

   struct rectangle
   +-----------------------------+
   | top_left      | bottom_right|
   | +-----+-----+ | +-----+-----+
   | |  x  |  y  | | |  x  |  y  |
   | +-----+-----+ | +-----+-----+
   +-----------------------------+
   one contiguous object, sizeof = 16, no indirection


   Nesting by POINTER:

   struct person              struct address
   +----------+              +------------+
   | name     |              | city       |
   | addr ----+------------> | zip        |
   +----------+              +------------+
   separate allocation, separate lifetime, one dereference per access
```

**Key Takeaways**

- A struct member may be a struct; it is stored inline, so the outer object contains the inner one in full.
- Access chains with `.` and `->` according to whether each step holds a value or a pointer.
- Use nested braces in initializers to mirror the structure; flattening compiles but breaks silently when members change.
- C11 anonymous structs and unions expose their members directly in the enclosing struct, avoiding an extra name.
- A struct cannot contain itself by value, but a pointer to its own type is legal and is how linked structures are built.

> 🧪 Practice
>
> 1. Define `struct date` and embed it in `struct event`; initialize with nested braces and print each field through the chain.
> 2. Write a function taking `const struct rectangle *` that returns the perimeter, using both `->` and `.` in the same expression.
> 3. Convert an inline nested member into a pointer member and list every change required at the call sites, including allocation and freeing.
> 4. Interview-style: *"Why can a struct contain a pointer to its own type but not an instance of it?"* Hint: ask what the compiler must know to compute `sizeof` in each case.

#### Arrays of Structures

**Theory**

Combining the previous two chapters' primitives gives you the workhorse of C data handling: an array of structs. Each element is a complete record, stored contiguously, and indexing gives you one record at a time.

```c
struct employee staff[100];
staff[3].salary = 50000;
```

The layout is exactly what you would expect: `sizeof(struct employee)` bytes per element, back to back, with each element internally padded as its type requires. Because the element size is a compile-time constant, `staff[i]` is one multiply-add, just like any array.

This organization is called **array of structs (AoS)**, and the alternative is **struct of arrays (SoA)**, where each field gets its own array:

```c
struct staff_soa {
    char   names[100][32];
    int    ages[100];
    double salaries[100];
};
```

The two have identical information content and very different performance profiles. When you process whole records — read employee 42, print all fields — AoS wins, because the record is in one or two cache lines. When you process one field across many records — sum every salary — SoA wins, because the salaries are packed contiguously with no other fields wasting cache space. Numerical and graphics code often uses SoA for exactly this reason (it also vectorizes better); ordinary application code uses AoS because it is simpler and matches how you think about records.

| | Array of structs | Struct of arrays |
| --- | --- | --- |
| Layout | `[rec0][rec1][rec2]` | `[f0 f0 f0][f1 f1 f1]` |
| Whole-record access | One cache line | One miss per field |
| Single-field scans | Wastes cache on other fields | Fully sequential |
| SIMD friendliness | Poor | Good |
| Code clarity | High | Lower |
| Adding a record | One element | Parallel updates |

Two practical notes for AoS.

**Initialization** uses nested braces, one inner brace per element, and designated initializers work at both levels.

**Sorting** with `qsort` works directly: pass `sizeof(struct employee)` as the element size, and the comparator casts `const void *` back to `const struct employee *` (Chapter 5.2). Note that `qsort` moves whole records — for large structs, sorting an array of *pointers* to them is cheaper, since only pointers move.

Finally, remember that an array of structs decays to a pointer to its first element like any array (Chapter 5.1), and `sizeof arr / sizeof arr[0]` remains the way to count elements where the array is in scope.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct employee {
    char   name[16];
    int    age;
    double salary;
};

/* qsort comparator: cast back to the real element type. */
static int by_salary_desc(const void *a, const void *b)
{
    const struct employee *x = a, *y = b;
    if (x->salary < y->salary) return  1;    /* descending */
    if (x->salary > y->salary) return -1;
    return 0;
}

static int by_name(const void *a, const void *b)
{
    const struct employee *x = a, *y = b;
    return strcmp(x->name, y->name);
}

int main(void)
{
    /* Nested braces: one inner brace per element. */
    struct employee staff[] = {
        {"Alice",   30, 95000.0},
        {"Bob",     25, 72000.0},
        {"Charlie", 41, 88000.0},
    };
    size_t n = sizeof staff / sizeof staff[0];

    printf("element size = %zu, %zu elements, %zu bytes total\n",
           sizeof staff[0], n, sizeof staff);

    /* Indexing selects a whole record; [] binds before . */
    for (size_t i = 0; i < n; i++)
        printf("  %-8s %3d  $%.0f\n", staff[i].name, staff[i].age, staff[i].salary);

    /* Pointer walk over records: p++ advances by sizeof(struct employee). */
    puts("via pointer walk:");
    for (const struct employee *p = staff; p != staff + n; p++)
        printf("  %-8s at offset %td\n", p->name, (p - staff));

    /* qsort moves WHOLE records (48 bytes each here). */
    qsort(staff, n, sizeof staff[0], by_salary_desc);
    printf("by salary : %s, %s, %s\n", staff[0].name, staff[1].name, staff[2].name);

    qsort(staff, n, sizeof staff[0], by_name);
    printf("by name   : %s, %s, %s\n", staff[0].name, staff[1].name, staff[2].name);

    /* Cheaper for large records: sort an array of POINTERS instead. */
    struct employee *refs[3];
    for (size_t i = 0; i < n; i++) refs[i] = &staff[i];
    /* Only 8-byte pointers move; the records stay put. */
    printf("refs[0] -> %s\n", refs[0]->name);
    return 0;
}
```

```text
   Array of structs (AoS): records are contiguous

   staff[0]            staff[1]            staff[2]
   +----------------+  +----------------+  +----------------+
   |name|age|salary |  |name|age|salary |  |name|age|salary |
   +----------------+  +----------------+  +----------------+
   |<-- 32 bytes -->|

   "print employee 1"  -> one cache line, everything present
   "sum all salaries"  -> loads name and age too, wasting cache


   Struct of arrays (SoA): fields are contiguous

   names[]  : [n0][n1][n2]...
   ages[]   : [a0][a1][a2]...
   salaries : [s0][s1][s2]...   <- summing walks this array alone
```

**Key Takeaways**

- An array of structs stores whole records contiguously; `arr[i]` costs the same indexed arithmetic as any array.
- Initialize with one inner brace per element; designated initializers work at the element and member level.
- AoS suits whole-record access; SoA suits scanning one field across many records and vectorizes better.
- `qsort` sorts an array of structs directly with `sizeof(struct T)` as the element size, moving entire records.
- For large records, sort an array of pointers instead — only pointer-sized values move.

> 🧪 Practice
>
> 1. Build an array of five `struct point`, fill it in a loop, and print each element with its index.
> 2. Sort an array of structs by two different fields using two `qsort` comparators.
> 3. Rewrite a three-field AoS as SoA, then time summing one field over a million elements in both layouts.
> 4. Interview-style: *"When would you choose struct-of-arrays over array-of-structs?"* Hint: describe the access pattern first, then say what the cache loads in each case.

#### Passing and Returning Structures

**Theory**

Unlike arrays, structs are first-class values: you can pass one to a function and return one from a function, and in both directions the whole struct is **copied**. This is a genuine convenience — no aliasing, no lifetime questions — but it has a cost proportional to the struct's size.

What actually happens at the machine level depends on the ABI. On x86-64 System V, small structs (up to 16 bytes) travel in registers, making them as cheap as passing two scalars. Larger ones are copied to the stack, and a returned struct is written through a hidden pointer the caller supplies. So a 16-byte `struct point3` costs nothing extra, while a 4 KB struct costs a 4 KB memcpy per call.

The practical guidance:

| Struct size | Pass as | Reason |
| --- | --- | --- |
| Small (a few words) | Value | Register-passed, no aliasing, clearer |
| Large | `const struct T *` | Avoids the copy |
| Must be modified | `struct T *` | Copies do not propagate back |

Passing by value is not just a performance decision — it is a semantic one. A by-value parameter is the callee's own copy, so the caller's object cannot be modified. That is often exactly what you want, and it makes the function easier to reason about. Passing `const struct T *` gets you the same read-only guarantee without the copy, at the price of an indirection.

Two hazards deserve emphasis.

**The copy is shallow.** If the struct contains a pointer, both copies point to the same memory. Freeing through one leaves the other dangling; this is the classic double-free in C data structures. If a struct owns heap memory, either pass pointers to it or write an explicit deep-copy function.

**Returning a struct is safe; returning a pointer to a local struct is not.** `return s;` copies the value out. `return &s;` returns the address of a dead frame (Chapter 4.1).

Returning a struct is the cleanest way for a function to produce multiple values, and C99's **compound literals** make constructing one at the call site pleasant:

```c
return (struct point){ .x = 3, .y = 4 };     /* an unnamed struct value */
```

A compound literal is a real object with a type; inside a function it has automatic storage duration, so do not return a pointer to one.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct point { int x, y; };                 /* small: pass by value */

struct big { char data[4096]; int id; };    /* large: pass by pointer */

struct owner { char *name; };               /* contains a POINTER: copies alias */

/* By value: the callee gets its own copy; the caller is untouched. */
struct point moved(struct point p, int dx, int dy)
{
    p.x += dx; p.y += dy;      /* modifying the copy */
    return p;                  /* the whole struct is copied out */
}

/* By pointer with const: no copy, no modification. */
long checksum(const struct big *b)
{
    long sum = b->id;
    for (size_t i = 0; i < sizeof b->data; i++) sum += b->data[i];
    return sum;
}

/* By pointer without const: the caller's object IS modified. */
void bump_id(struct big *b) { b->id++; }

/* Compound literal: build a struct value inline (C99). */
struct point origin(void) { return (struct point){ .x = 0, .y = 0 }; }

/* Deep copy, needed because the shallow copy would alias 'name'. */
int owner_copy(struct owner *dst, const struct owner *src)
{
    size_t n = strlen(src->name) + 1;
    dst->name = malloc(n);
    if (!dst->name) return -1;
    memcpy(dst->name, src->name, n);
    return 0;
}

int main(void)
{
    struct point p = {1, 2};
    struct point q = moved(p, 10, 10);
    printf("p = (%d,%d) unchanged; q = (%d,%d)\n", p.x, p.y, q.x, q.y);
    printf("origin = (%d,%d)\n", origin().x, origin().y);

    /* Compound literals also work as arguments. */
    struct point r = moved((struct point){5, 5}, 1, 1);
    printf("r = (%d,%d)\n", r.x, r.y);

    struct big *b = malloc(sizeof *b);
    if (!b) return EXIT_FAILURE;
    memset(b, 0, sizeof *b);
    b->id = 7;
    printf("checksum = %ld\n", checksum(b));    /* no 4 KB copy */
    bump_id(b);
    printf("id after bump = %d\n", b->id);      /* 8: modified in place */
    free(b);

    /* Shallow copy hazard. */
    struct owner a = { malloc(8) };
    if (!a.name) return EXIT_FAILURE;
    strcpy(a.name, "shared");
    struct owner shallow = a;                   /* both point at the SAME buffer */
    printf("aliased: %s / %s (same address: %s)\n",
           a.name, shallow.name, a.name == shallow.name ? "yes" : "no");

    struct owner deep;
    if (owner_copy(&deep, &a) == 0) {
        printf("deep copy independent: %s\n", deep.name);
        free(deep.name);
    }
    free(a.name);                               /* freeing once is correct;
                                                   shallow.name now dangles */
    return 0;
}
```

```text
   Pass by value (small struct)          Pass by pointer (large struct)

   caller        callee                  caller            callee
   +-------+     +-------+               +-----------+     +--------+
   | p.x=1 | --> | p.x=1 |  (copy)       | 4 KB data | <-- | b (ptr)|
   | p.y=2 | --> | p.y=2 |               +-----------+     +--------+
   +-------+     +-------+               one address copied, no data moved
   caller's p cannot change              caller's object CAN change
                                         unless the parameter is const


   Shallow copy of a struct holding a pointer:

   a.name ------+
                +---> [ "shared" ]      ONE buffer, TWO owners
   shallow.name-+                       free() through either leaves the
                                        other dangling
```

**Key Takeaways**

- Structs are passed and returned by value, copying every member; small structs travel in registers, large ones are memcpy'd.
- Pass small structs by value for clarity and safety; pass large ones as `const struct T *` to avoid the copy.
- To let a function modify the caller's struct, pass a non-const pointer — a by-value copy never propagates back.
- Struct copies are shallow: pointer members alias the same memory, so owning structs need an explicit deep copy.
- Returning a struct by value is safe; returning a pointer to a local struct or compound literal is not.

> 🧪 Practice
>
> 1. Write a function taking `struct point` by value that modifies it, and confirm the caller's copy is unchanged. Then change the parameter to a pointer.
> 2. Time one million calls passing a 4 KB struct by value versus by `const` pointer.
> 3. Write a struct containing a `char *`, copy it by assignment, free through one copy, and observe what happens under AddressSanitizer when using the other.
> 4. Interview-style: *"Is it ever wrong to pass a struct by value?"* Hint: consider size, whether the struct owns resources, and what the ABI does with the return value.

#### Designated Initializers

**Theory**

Positional initializers work, but they scale badly. Given

```c
struct config c = {1, 0, 8080, 30, 0, 1};
```

nobody can tell what those values mean, and inserting a member at the front silently shifts every value to the wrong field. C99's **designated initializers** fix both problems by naming the member:

```c
struct config c = { .port = 8080, .timeout = 30, .verbose = 1 };
```

The rules are simple and generous:

- **Any member you do not name is zero-initialized.** This is the same rule as positional initializers, and it means you can specify only what differs from zero.
- **Order does not matter.** `{ .y = 2, .x = 1 }` is fine.
- **You may mix designated and positional forms.** After a designator, initialization continues from that member, which is legal but confusing — prefer one style.
- **A later initializer for the same member wins**, which is occasionally useful for "defaults, then overrides" patterns within one initializer.
- **They work for arrays too**, with `[index] = value`, and they nest arbitrarily.

The benefits are substantial for real code. Configuration structs become self-documenting. Adding or reordering members does not silently corrupt existing initializers. Sparse tables — dispatch tables indexed by opcode, lookup tables indexed by character — become readable and gap-tolerant, with unlisted entries reliably `NULL` or `0`.

One caveat about the zero-fill guarantee: it applies to *members*, not to padding bytes. Any struct with padding may have indeterminate bytes between members even after `= {0}`, which is why `memcmp` on structs is unreliable (Chapter 6.3). If you need every byte zeroed — for hashing, for writing to disk, for a security-sensitive wipe — use `memset`.

Two related C99/C23 conveniences travel with this feature. **Compound literals** use the same syntax to build an unnamed object anywhere an expression is allowed: `(struct point){ .x = 1 }`. And **C23's `= {}`** finally provides an official "zero everything" initializer without naming a first member.

Note that C++ supports only a restricted form of designated initializers (C++20, requiring declaration order and no gaps), so shared headers should not rely on C's more permissive rules.

**Examples**

```c
#include <stdio.h>
#include <string.h>

struct config {
    int  verbose;
    int  daemonize;
    int  port;
    int  timeout;
    int  max_clients;
    const char *logfile;
};

/* A settings struct is far clearer with designators. */
static const struct config defaults = {
    .port        = 8080,
    .timeout     = 30,
    .max_clients = 64,
    .logfile     = "/var/log/app.log",
    /* verbose and daemonize are ZERO by the omission rule */
};

/* Sparse dispatch table: unlisted entries are guaranteed NULL. */
typedef void (*handler)(void);
static void on_get(void)  { puts("GET");  }
static void on_post(void) { puts("POST"); }

enum { M_GET, M_POST, M_PUT, M_DELETE, M_COUNT };

static handler handlers[M_COUNT] = {
    [M_GET]  = on_get,
    [M_POST] = on_post,
    /* M_PUT and M_DELETE are NULL -- explicit and safe to test */
};

/* Designators nest, in arrays and structs alike. */
struct point { int x, y; };
static struct point corners[4] = {
    [0] = { .x = 0,  .y = 0  },
    [2] = { .x = 10, .y = 10 },
    /* [1] and [3] are {0, 0} */
};

int main(void)
{
    /* Order is irrelevant; omitted members are zero. */
    struct config c = { .timeout = 5, .verbose = 1 };
    printf("verbose=%d daemonize=%d port=%d timeout=%d logfile=%s\n",
           c.verbose, c.daemonize, c.port, c.timeout,
           c.logfile ? c.logfile : "(null)");

    /* Defaults, then override -- copy the struct, then set fields. */
    struct config custom = defaults;
    custom.port = 9090;
    printf("custom : port=%d timeout=%d max=%d\n",
           custom.port, custom.timeout, custom.max_clients);

    /* A later designator for the same member wins. */
    struct point p = { .x = 1, .y = 2, .x = 99 };
    printf("p = (%d, %d)  <- the last .x wins\n", p.x, p.y);

    /* Sparse table: test the gaps before calling. */
    for (int m = 0; m < M_COUNT; m++) {
        if (handlers[m]) handlers[m]();
        else             printf("method %d: unimplemented\n", m);
    }

    for (int i = 0; i < 4; i++)
        printf("corner %d = (%d, %d)\n", i, corners[i].x, corners[i].y);

    /* Zeroing MEMBERS is not the same as zeroing BYTES. */
    struct config z = {0};      /* every member zero; padding indeterminate */
    struct config m;
    memset(&m, 0, sizeof m);    /* every BYTE zero -- use this for hashing/IO */
    printf("z.port=%d m.port=%d\n", z.port, m.port);
    return 0;
}
```

| Style | Example | Survives member reordering? | Readable? |
| --- | --- | --- | --- |
| Positional | `{1, 0, 8080}` | No | No |
| Designated | `{ .port = 8080 }` | Yes | Yes |
| Mixed | `{ 1, .port = 8080 }` | Partly | No |
| `= {0}` / C23 `= {}` | zero everything | Yes | Yes |

**Key Takeaways**

- Designated initializers name the member (`.field = value`), making initialization order-independent and self-documenting.
- Unnamed members are zero-initialized, so you only specify what differs from zero.
- They work for array elements (`[3] = ...`) and nest, which makes sparse tables safe — gaps are reliably `NULL`/`0`.
- Adding or reordering struct members cannot silently corrupt a designated initializer, unlike a positional one.
- Zero-initialization applies to members, not padding; use `memset` when every byte must be zero.

> 🧪 Practice
>
> 1. Define a six-member config struct and initialize only two members with designators; print all six and confirm the rest are zero.
> 2. Build a dispatch table indexed by an enum with two of five entries filled, and write a loop that safely handles the gaps.
> 3. Take a positional initializer, add a new member at the *front* of the struct, and observe how the values shift. Then convert it to designators and repeat.
> 4. Interview-style: *"Does `struct s x = {0};` guarantee every byte of `x` is zero?"* Hint: distinguish members from the bytes between them, and say when the difference is observable.

<a id="62-unions-and-enumerations"></a>
### 6.2 Unions and Enumerations

Structures put members side by side; unions stack them on top of each other, and enumerations give names to integer constants. This section covers both, the tagged-union discipline that makes unions safe, and the bit fields that let a struct describe individual bits.

#### union Declaration and Semantics

**Theory**

A `struct` allocates space for **all** its members. A `union` allocates space for the **largest** one, and every member starts at the same address. The members overlap; writing one overwrites the others.

The syntax is identical to a struct, only the keyword changes:

```c
union number {
    int    i;      /* 4 bytes */
    float  f;      /* 4 bytes */
    double d;      /* 8 bytes */
};                 /* sizeof(union number) is 8 (plus alignment) */
```

Think of it as a room that can be furnished as an office *or* a bedroom, but not both at once — the floor space is shared. A struct, by contrast, is a house with a separate room for each purpose.

The defining rule: **only one member is "active" at a time — the one most recently written.** Reading a member other than the active one is a separate topic (type punning, next but one) with real caveats. The language does not track which member is active; that bookkeeping is entirely yours, which is why unions almost always appear inside a struct alongside a tag (the next topic).

Why would you want overlapping storage? Three legitimate reasons:

**Memory efficiency for mutually exclusive data.** A token in a parser is either an integer, a float, or an identifier — never more than one. A struct with all three wastes space in every token; a union does not.

**Variant records.** A value in a dynamic language interpreter, a message in a protocol, a node in an AST — anything with "one of N shapes".

**Low-level reinterpretation.** Examining the bytes of a float, or splitting a 32-bit word into fields. This works in practice and is explicitly blessed by C99's footnote on type punning, but it comes with caveats worth understanding.

Mechanics to know:

- `sizeof(union)` is at least the size of the largest member, rounded up to satisfy the union's alignment (the strictest of its members').
- Initialization with `= { value }` initializes the **first** member. Designated initializers let you pick: `union number n = { .f = 1.5f };`.
- Unions can be assigned, passed, and returned by value like structs, copying the whole storage.
- A union can contain structs, arrays, and other unions; C11 anonymous unions inside a struct expose their members directly.

**Examples**

```c
#include <stdio.h>
#include <string.h>

union number {
    int    i;
    float  f;
    double d;
    char   bytes[8];
};

/* A union of structs: two views of the same 4 bytes. */
union rgba {
    unsigned int packed;
    struct { unsigned char r, g, b, a; } channel;
};

int main(void)
{
    union number n;

    printf("sizeof(union number) = %zu (the LARGEST member, not the sum)\n",
           sizeof n);
    printf("sizeof(int)=%zu float=%zu double=%zu\n",
           sizeof n.i, sizeof n.f, sizeof n.d);

    /* Every member shares one address. */
    printf("&n.i = %p\n&n.f = %p\n&n.d = %p   <- all identical\n",
           (void *)&n.i, (void *)&n.f, (void *)&n.d);

    /* Writing one member overwrites the others. */
    n.i = 42;
    printf("after n.i = 42     : n.i = %d\n", n.i);
    n.d = 3.14;                    /* i and f are now meaningless */
    printf("after n.d = 3.14   : n.d = %g, n.i = %d (garbage: not active)\n",
           n.d, n.i);

    /* Initialization: first member by default, or pick one with a designator. */
    union number a = {7};              /* initializes .i */
    union number b = { .f = 1.5f };    /* initializes .f */
    printf("a.i = %d, b.f = %.1f\n", a.i, b.f);

    /* Unions copy by value, like structs. */
    union number copy = b;
    printf("copy.f = %.1f\n", copy.f);

    /* Two views of the same four bytes. */
    union rgba color;
    color.channel.r = 0x12;
    color.channel.g = 0x34;
    color.channel.b = 0x56;
    color.channel.a = 0x78;
    printf("packed = 0x%08x (byte order depends on endianness)\n", color.packed);
    printf("sizeof(union rgba) = %zu\n", sizeof color);
    return 0;
}
```

```text
   struct three { int i; float f; double d; };   -- side by side

   offset 0      4      8            16
          +------+------+------------+
          |  i   |  f   |     d      |     sizeof = 16
          +------+------+------------+


   union number { int i; float f; double d; };   -- stacked

   offset 0                          8
          +--------------------------+
          |            d             |     sizeof = 8
          +------+-------------------+
          |  i   |
          +------+
          |  f   |
          +------+
          ^
          all three members START HERE

   Writing n.d overwrites whatever n.i and n.f held.
```

**Key Takeaways**

- A union's members all start at the same address and share storage; its size is that of the largest member, rounded to its alignment.
- Only the most recently written member is active; the language does not track which one, so you must.
- Unions save space for mutually exclusive data and express variant records; they also enable low-level byte reinterpretation.
- `= {value}` initializes the first member; use a designated initializer to choose another.
- Unions assign, pass, and return by value like structs, copying the whole shared storage.

> 🧪 Practice
>
> 1. Declare a union of `char`, `int`, and `double`, print its `sizeof`, and print the address of each member to confirm they coincide.
> 2. Write one member, then read another, and explain why the result is not meaningful without further rules.
> 3. Define a union with a 4-byte integer and a 4-element `unsigned char` array, set the integer to `0x01020304`, and print the bytes. Explain the order.
> 4. Interview-style: *"What is the difference between a struct and a union, and when would you pick a union?"* Hint: contrast total size and simultaneity, then give a case where the data is genuinely one-of-N.

#### Tagged Unions

**Theory**

A bare union has a fatal flaw: it does not know which member is valid. Read the wrong one and you get nonsense with no diagnostic. The fix is a discipline, not a language feature — **pair the union with a tag that records which member is active**, and wrap both in a struct:

```c
struct value {
    enum { V_INT, V_FLOAT, V_STRING } type;   /* the tag */
    union {
        int    i;
        double f;
        char  *s;
    } as;                                     /* the payload */
};
```

This is called a **tagged union**, a discriminated union, or a variant record. It is one of the most important patterns in C, and it is how interpreters represent values, how compilers represent AST nodes, how protocol parsers represent messages, and how any "this is one of several shapes" problem gets solved.

The rules that make it work:

**Every write to the union updates the tag.** Do this in one place — a constructor function per variant — so the invariant cannot drift.

**Every read switches on the tag.** Never access a member without checking. A `switch` over an enum with no `default` lets `-Wswitch` tell you when a new variant is added and a case is missing, which turns a class of bugs into compile errors.

**Ownership travels with the variant.** If one arm holds a `char *` that was allocated, the destructor must check the tag before freeing. This is where tagged unions most often leak.

The space saving is real: with three members of 4, 8, and 8 bytes, a struct-of-all is 24 bytes while the tagged union is 16. More importantly, the tag makes the intent explicit and checkable.

Compare the alternatives you might reach for:

| Approach | Space | Type safety | Extensibility |
| --- | --- | --- | --- |
| Struct with all fields | Largest (wastes) | None (any field readable) | Easy, but grows |
| Bare union | Smallest | None | Unsafe |
| Tagged union | Small | Good, with `switch` warnings | Add an enum value and a case |
| `void *` plus type code | Smallest struct | Worst (casts everywhere) | Requires allocation |

C11's anonymous unions remove the `as.` prefix if you prefer `v.i` over `v.as.i` — a matter of taste, though the explicit name documents that the members are alternatives.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum { V_INT, V_DOUBLE, V_STRING } ValueType;

typedef struct {
    ValueType type;              /* the TAG: which member is live */
    union {
        long   i;
        double d;
        char  *s;                /* OWNED: must be freed */
    } as;
} Value;

/* Constructors: the only places that set the tag, so it cannot drift. */
static Value make_int(long v)    { return (Value){ .type = V_INT,    .as.i = v }; }
static Value make_double(double v){ return (Value){ .type = V_DOUBLE, .as.d = v }; }

static Value make_string(const char *v)
{
    Value out = { .type = V_STRING, .as.s = NULL };
    size_t n = strlen(v) + 1;
    out.as.s = malloc(n);
    if (out.as.s) memcpy(out.as.s, v, n);
    return out;
}

/* Every read switches on the tag. No default: -Wswitch flags a missing case
   when a new variant is added to ValueType. */
static void value_print(const Value *v)
{
    switch (v->type) {
    case V_INT:    printf("int    %ld\n", v->as.i); break;
    case V_DOUBLE: printf("double %g\n",  v->as.d); break;
    case V_STRING: printf("string \"%s\"\n", v->as.s ? v->as.s : ""); break;
    }
}

/* Ownership follows the tag: only the string variant owns memory. */
static void value_free(Value *v)
{
    if (v->type == V_STRING) {
        free(v->as.s);
        v->as.s = NULL;
    }
    v->type = V_INT;             /* leave it in a valid state */
    v->as.i = 0;
}

static double value_as_number(const Value *v)
{
    switch (v->type) {
    case V_INT:    return (double)v->as.i;
    case V_DOUBLE: return v->as.d;
    case V_STRING: return v->as.s ? atof(v->as.s) : 0.0;
    }
    return 0.0;
}

int main(void)
{
    Value values[] = { make_int(42), make_double(3.5), make_string("2.75") };
    size_t n = sizeof values / sizeof values[0];

    printf("sizeof(Value) = %zu  (tag + largest member + padding)\n", sizeof(Value));

    for (size_t i = 0; i < n; i++) {
        value_print(&values[i]);
        printf("  as number: %g\n", value_as_number(&values[i]));
    }

    for (size_t i = 0; i < n; i++) value_free(&values[i]);
    return 0;
}
```

```text
   Tagged union layout

   +--------+---------------------------+
   |  type  |  union { i | d | s }      |
   +--------+---------------------------+
    4 bytes   8 bytes (largest member)
             (+4 padding before the union, for 8-byte alignment)

   type = V_DOUBLE  ->  read .d      (reading .s here would be a bug)
   type = V_STRING  ->  read .s, and free it in the destructor


   The discipline, in three rules:

   write ---> always set the tag in the same statement (a constructor)
   read  ---> always switch on the tag, no default, let -Wswitch help
   free  ---> check the tag; only some variants own memory
```

**Key Takeaways**

- A tagged union pairs an enum tag with a union payload inside a struct, recording which member is active.
- Set the tag in constructor functions so the union and tag can never disagree.
- Read only through a `switch` on the tag, and omit `default` so `-Wswitch` reports missing cases when a variant is added.
- Ownership is per-variant: the destructor must check the tag before freeing pointer members.
- This is the standard C pattern for interpreter values, AST nodes, and protocol messages.

> 🧪 Practice
>
> 1. Build a `Shape` tagged union with circle, rectangle, and triangle variants, and write an `area` function that switches on the tag.
> 2. Add a fourth variant to the enum without adding a `case`, compile with `-Wall`, and read the warning.
> 3. Extend the `Value` example with a `V_ARRAY` variant that owns a heap array, and update the destructor correctly.
> 4. Interview-style: *"How would you implement a dynamically typed value in C?"* Hint: describe the two fields, then say what enforces the correspondence between them.

#### Type Punning Caveats

**Theory**

**Type punning** means accessing the same bytes as two different types — reading a `float`'s bits as an `int`, or a byte buffer as a struct. It is unavoidable in serialization, hashing, graphics, and driver code, and it is one of the easiest places in C to write something that works today and breaks under `-O2` next year.

The trouble comes from **strict aliasing**. The standard says an object may only be accessed through an lvalue of its own type (or a compatible one, or a character type). This is not pedantry — it lets the optimizer assume that an `int *` and a `float *` never refer to the same memory, so it can keep values in registers across stores. Violate the rule and the compiler is free to reorder or elide your accesses; the result is code that works at `-O0` and fails at `-O2`.

There are three approaches, and only two are reliable.

**1. Cast pointers (the bad way).**

```c
float f = 1.5f;
int i = *(int *)&f;      /* strict-aliasing violation: undefined behavior */
```

GCC warns with `-Wstrict-aliasing`. Some code disables the optimization with `-fno-strict-aliasing` (the Linux kernel does), but you cannot rely on that in portable code.

**2. Use a union (the pragmatic way).** C99 added a footnote, promoted to normative text in C11, explicitly allowing you to read a union member other than the last one written; the bytes are reinterpreted in the new member's type. GCC and Clang document and support this. It is the idiomatic C solution:

```c
union { float f; uint32_t u; } pun = { .f = 1.5f };
uint32_t bits = pun.u;      /* well defined in C (not in C++) */
```

**3. Use `memcpy` (the portable way).** Copying bytes into a properly typed object is always well defined, in both C and C++, and modern compilers optimize a fixed-size `memcpy` into a single register move — there is no runtime cost:

```c
uint32_t bits;
memcpy(&bits, &f, sizeof bits);   /* always correct, always fast */
```

C23 adds `memcpy`-based helpers and `<stdbit.h>`; when in doubt, `memcpy` is the answer.

Three further hazards apply to all approaches:

**Endianness.** The byte order of a multi-byte value is platform-specific. Punning to a byte array on x86 (little-endian) gives you the reverse order of a network protocol's big-endian layout. Use `htonl`/`ntohl` or explicit shifts for anything crossing a machine boundary.

**Padding.** Reinterpreting a struct as bytes exposes padding, whose values are indeterminate. Never hash, compare, or transmit a struct's raw bytes without `memset`ing it first — and preferably serialize field by field.

**Trap representations and alignment.** Not every bit pattern is valid for every type, and reading through a misaligned pointer is undefined behavior (and a crash on strict-alignment hardware such as some ARM configurations).

The rule of thumb: **use `memcpy` for punning, a union when it reads better, and never a bare pointer cast.**

**Examples**

```c
#include <stdio.h>
#include <string.h>
#include <stdint.h>

/* The union approach: well defined in C, and the idiomatic form. */
static uint32_t float_bits_union(float f)
{
    union { float f; uint32_t u; } pun;
    pun.f = f;
    return pun.u;              /* reading the other member is allowed in C */
}

/* The memcpy approach: portable to C++ too, and optimized to a register move. */
static uint32_t float_bits_memcpy(float f)
{
    uint32_t u;
    memcpy(&u, &f, sizeof u);  /* always well defined */
    return u;
}

/* The pointer cast: DO NOT DO THIS -- strict aliasing violation. */
/* static uint32_t float_bits_bad(float f) { return *(uint32_t *)&f; } */

int main(void)
{
    float f = 1.5f;
    printf("union  : 0x%08x\n", float_bits_union(f));
    printf("memcpy : 0x%08x   <- identical, and portable\n", float_bits_memcpy(f));

    /* IEEE 754 single precision: sign | exponent(8) | mantissa(23) */
    uint32_t bits = float_bits_memcpy(f);
    printf("sign=%u exponent=%u mantissa=0x%06x\n",
           bits >> 31, (bits >> 23) & 0xFF, bits & 0x7FFFFF);

    /* Endianness: the same value, different byte order per platform. */
    uint32_t value = 0x01020304;
    unsigned char bytes[4];
    memcpy(bytes, &value, sizeof bytes);
    printf("0x01020304 in memory: %02x %02x %02x %02x  (%s-endian)\n",
           bytes[0], bytes[1], bytes[2], bytes[3],
           bytes[0] == 0x04 ? "little" : "big");

    /* Portable byte extraction: shifts do NOT depend on endianness. */
    printf("portable bytes      : %02x %02x %02x %02x\n",
           (value >> 24) & 0xFF, (value >> 16) & 0xFF,
           (value >>  8) & 0xFF,  value        & 0xFF);

    /* Padding hazard: raw struct bytes include indeterminate padding. */
    struct padded { char c; int i; };     /* 3 bytes of padding after c */
    struct padded a, b;
    memset(&a, 0, sizeof a);              /* zero EVERY byte, padding included */
    memset(&b, 0, sizeof b);
    a.c = b.c = 'x';
    a.i = b.i = 42;
    printf("memcmp after memset : %d (0 = equal, reliable ONLY because\n"
           "                         both were memset first)\n",
           memcmp(&a, &b, sizeof a));
    return 0;
}
```

| Technique | Well defined in C? | In C++? | Optimized well? | Verdict |
| --- | --- | --- | --- | --- |
| `*(int *)&f` | No (strict aliasing) | No | n/a | Never |
| Union member read | Yes (C99 footnote, C11 text) | No (UB) | Yes | Fine in C |
| `memcpy` | Yes | Yes | Yes (single move) | **Preferred** |
| `unsigned char *` view | Yes | Yes | Yes | For byte inspection |

```text
   Why strict aliasing exists

   void f(int *a, float *b) {
       *a = 1;
       *b = 2.0f;      compiler assumes these CANNOT overlap,
       return *a;      so it may return 1 without reloading
   }

   If you pass the same address as both, the assumption is wrong and
   the result is whatever the optimizer decided. -O0 hides it; -O2 does not.
```

**Key Takeaways**

- Type punning through a bare pointer cast violates strict aliasing and is undefined behavior that typically breaks only under optimization.
- Reading a union member other than the one last written is explicitly allowed in C (but not in C++).
- `memcpy` into a correctly typed object is always well defined and compiles to the same instructions — make it your default.
- Byte order is platform-specific; use shifts or `htonl`/`ntohl` for anything crossing machines.
- Raw struct bytes include indeterminate padding; `memset` the whole object before hashing, comparing, or transmitting it, and prefer field-by-field serialization.

> 🧪 Practice
>
> 1. Extract the sign, exponent, and mantissa of a `float` using both a union and `memcpy`, and confirm both give the same bits.
> 2. Detect your machine's endianness by writing `0x01020304` and inspecting the bytes; then write an endianness-independent byte extractor with shifts.
> 3. Compare two structs with `memcmp` without `memset`ing them first, fill them identically, and see whether the result is reliably zero. Explain.
> 4. Interview-style: *"Why might `*(int*)&my_float` work at `-O0` and fail at `-O2`?"* Hint: name the assumption the optimizer is allowed to make about two differently typed pointers.

#### enum Constants and Underlying Type

**Theory**

Magic numbers make code unreadable and bugs invisible. `if (state == 3)` tells you nothing; `if (state == STATE_CLOSED)` tells you everything. C offers two ways to name a constant — `#define` and `enum` — and for related sets of integers the enum is almost always better.

```c
enum color { RED, GREEN, BLUE };     /* RED=0, GREEN=1, BLUE=2 */
```

The rules:

- **Values start at 0 and increment** unless you assign one explicitly.
- **You may assign any constant expression**, and subsequent members continue from there: `enum { A = 5, B, C }` gives 5, 6, 7.
- **Values need not be unique.** `enum { OK = 0, SUCCESS = 0 }` is legal.
- **The constants are ordinary identifiers**, visible in the enclosing scope — not namespaced under the enum tag. That is why C code prefixes them (`COLOR_RED`, `STATE_CLOSED`) to avoid collisions.
- **The constants have type `int`** in C17 and earlier, regardless of the enum's own type.

The enumerated *type* is a different matter. Up to C17, its underlying type is **implementation-defined** — the compiler picks a type that can hold all the values, which may be `int`, `unsigned int`, or something smaller. So `sizeof(enum color)` is not portable, and you should not rely on an enum's size in a struct that maps to a binary format. C23 fixes this: enums now have a fixed underlying type by default (`int`, or a larger type if needed), and you may specify one explicitly with `enum flags : unsigned char { ... }`.

Why prefer enums over `#define`?

| | `#define` | `enum` |
| --- | --- | --- |
| Visible to the debugger | No (preprocessor removes it) | Yes, as a symbol |
| Type checking | None (plain text) | It is a type |
| Scoped | No (whole file onward) | Follows normal scope rules |
| Auto-numbering | Manual | Automatic |
| `switch` exhaustiveness warnings | No | Yes (`-Wswitch`) |
| Works for non-integers | Yes (strings, expressions) | No (integers only) |

That `-Wswitch` row is the strongest practical argument. Switching on an enum without a `default` makes the compiler list any missing enumerator — so adding a state to a state machine produces a compile-time list of every place that must handle it. Adding a `default: break;` throws that away, which is why exhaustive enum switches deliberately omit it.

Two idioms worth knowing. A trailing `COUNT` member sizes arrays automatically:

```c
enum { M_GET, M_POST, M_PUT, M_COUNT };   /* M_COUNT == 3 */
handler table[M_COUNT];
```

And enums are not restricted to sequential values — powers of two make combinable flags, though the combination itself is an `int`, not a member of the enum.

Finally, note that C enums are **not type-safe** in the way C++ or Rust enums are: any integer can be assigned to an enum variable, and arithmetic on enum values silently yields `int`. The enum documents intent and enables warnings; it does not enforce a closed set.

**Examples**

```c
#include <stdio.h>

/* Auto-numbered from 0; the trailing COUNT sizes tables automatically. */
enum weekday { MON, TUE, WED, THU, FRI, SAT, SUN, DAY_COUNT };

/* Explicit values, then continuing from the last one. */
enum status { ST_OK = 0, ST_WARN = 10, ST_ERROR, ST_FATAL };  /* 0, 10, 11, 12 */

/* Powers of two: combinable flags. */
enum perm { P_READ = 1 << 0, P_WRITE = 1 << 1, P_EXEC = 1 << 2 };

static const char *day_name[DAY_COUNT] = {
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
};

/* No default: -Wswitch reports any enumerator this fails to handle. */
static const char *describe(enum status s)
{
    switch (s) {
    case ST_OK:    return "ok";
    case ST_WARN:  return "warning";
    case ST_ERROR: return "error";
    case ST_FATAL: return "fatal";
    }
    return "unknown";        /* reached only for out-of-range integers */
}

int main(void)
{
    printf("MON=%d SUN=%d DAY_COUNT=%d\n", MON, SUN, DAY_COUNT);
    printf("ST_WARN=%d ST_ERROR=%d ST_FATAL=%d  <- continue from 10\n",
           ST_WARN, ST_ERROR, ST_FATAL);

    for (enum weekday d = MON; d < DAY_COUNT; d++)
        printf("  %d = %s\n", d, day_name[d]);

    printf("status: %s / %s\n", describe(ST_OK), describe(ST_FATAL));

    /* Flags: the OR of two enumerators is an int, not an enum member. */
    int mode = P_READ | P_WRITE;
    printf("mode=%d readable=%s writable=%s executable=%s\n", mode,
           (mode & P_READ)  ? "yes" : "no",
           (mode & P_WRITE) ? "yes" : "no",
           (mode & P_EXEC)  ? "yes" : "no");

    /* The underlying type is implementation-defined before C23. */
    printf("sizeof(enum weekday) = %zu (do not rely on this in binary formats)\n",
           sizeof(enum weekday));

    /* C enums are not a closed set: any int may be assigned. */
    enum status bogus = (enum status)99;
    printf("bogus = %d -> %s\n", bogus, describe(bogus));
    return 0;
}
```

```text
   enum weekday { MON, TUE, WED, THU, FRI, SAT, SUN, DAY_COUNT };
                   0    1    2    3    4    5    6      7
                                                        ^
                                          not a real day: it is the COUNT,
                                          and it resizes itself when you
                                          add a day above it


   Why omitting 'default' is a feature:

   switch (s) {          add ST_TIMEOUT to the enum
   case ST_OK:    ...    ---------------------------> warning: enumeration
   case ST_WARN:  ...                                 value 'ST_TIMEOUT' not
   case ST_ERROR: ...                                 handled in switch
   case ST_FATAL: ...
   }                     With 'default:' present, the compiler stays silent
                         and the new state falls into the wrong branch.
```

**Key Takeaways**

- Enumerators start at 0 and increment; explicit values are allowed and later members continue from them.
- Enum constants have type `int` (pre-C23) and live in the ordinary identifier scope, so prefix them to avoid collisions.
- The enum type's underlying type is implementation-defined before C23; do not rely on `sizeof` in binary layouts.
- Prefer enums to `#define` for related integers: they are debuggable, scoped, auto-numbered, and enable `-Wswitch` exhaustiveness checks.
- Omit `default` in enum switches so new enumerators produce compile-time warnings; add a trailing `COUNT` member to size tables.
- C enums are not a closed set — any integer can be stored in one, so validate values from outside the program.

> 🧪 Practice
>
> 1. Define an enum for the months with explicit values 1-12 and print each with its number.
> 2. Write a `switch` over a four-value enum with no `default`, add a fifth enumerator, and read the compiler warning.
> 3. Build a flags enum with four powers of two, combine three of them, and write a function that prints which are set.
> 4. Interview-style: *"When would you use `#define` instead of an `enum`?"* Hint: think about non-integer constants, and about values that must be usable in `#if` preprocessor conditions.

#### Bit Fields

**Theory**

Sometimes an `int` is a hundred times more space than a value needs. A boolean flag needs one bit; a 3-bit priority field needs three. **Bit fields** let a struct declare members measured in bits rather than bytes:

```c
struct flags {
    unsigned int is_active  : 1;    /* 1 bit  */
    unsigned int priority   : 3;    /* 3 bits, values 0-7 */
    unsigned int error_code : 4;    /* 4 bits, values 0-15 */
};                                  /* fits in one byte of an int */
```

The syntax is a member declaration followed by `:` and a width in bits. The compiler packs consecutive bit fields into an underlying storage unit and generates the shifting and masking for you, so you read and write them like ordinary members.

Two legitimate uses: **saving memory** when you have millions of records with small fields, and **describing hardware or protocol layouts** where the specification is written in bits.

That second use is where people get burned, because **bit field layout is largely implementation-defined**:

- Whether fields are allocated from the low end or high end of the storage unit is up to the compiler (in practice it follows endianness).
- Whether a field may straddle a storage-unit boundary is implementation-defined.
- The alignment and size of the underlying unit is implementation-defined.
- A plain `int` bit field may be signed or unsigned — so a 1-bit `int` field can hold only 0 and -1. **Always write `unsigned int` (or `signed int` when you mean it).**

The consequence: a struct of bit fields is *not* a portable description of a hardware register or a network packet. It will work on the compiler you tested and may silently reorder elsewhere. For portable bit manipulation, use explicit masks and shifts on a fixed-width integer (Chapter 12.1) — more verbose, but exactly specified.

Further restrictions:

- **You cannot take the address of a bit field** (`&f.priority` is an error), since it may not start on a byte boundary. They also cannot be used with `sizeof` individually.
- **Only integer types are allowed**: `int`, `unsigned int`, `_Bool`, and (implementation-defined) other integer types.
- **A width of 0** with no name forces the next field to start at the next storage unit — an alignment tool.
- **An unnamed field** of nonzero width inserts padding bits.

Finally, bit fields are not always a win. Reading one costs a load, a shift, and a mask; writing costs a read-modify-write. In a hot loop, three `unsigned char` members may be faster than three bit fields, and in multithreaded code, adjacent bit fields in the same unit are a data race unless separately synchronized (C11 defines the memory model here — distinct bit fields in the same unit are not independently updatable without a race).

**Examples**

```c
#include <stdio.h>
#include <stdint.h>

/* Space saving: 8 bits of information in 4 bytes instead of 12. */
struct packed_flags {
    unsigned int is_active  : 1;    /* ALWAYS write 'unsigned' explicitly */
    unsigned int priority   : 3;    /* 0-7   */
    unsigned int error_code : 4;    /* 0-15  */
};

struct unpacked_flags {
    unsigned int is_active;
    unsigned int priority;
    unsigned int error_code;
};

/* Using width 0 to force the next field into a new storage unit. */
struct aligned_fields {
    unsigned int a : 4;
    unsigned int   : 0;             /* pad to the next unit boundary */
    unsigned int b : 4;
};

/* The signedness trap. */
struct trap {
    int  flag : 1;                  /* may be SIGNED: holds 0 and -1 */
    unsigned int ok : 1;            /* holds 0 and 1 */
};

int main(void)
{
    printf("sizeof packed   = %zu\n", sizeof(struct packed_flags));
    printf("sizeof unpacked = %zu\n", sizeof(struct unpacked_flags));
    printf("sizeof aligned  = %zu\n", sizeof(struct aligned_fields));

    struct packed_flags f = { .is_active = 1, .priority = 5, .error_code = 12 };
    printf("active=%u priority=%u error=%u\n", f.is_active, f.priority, f.error_code);

    /* Overflow wraps silently: 3 bits cannot hold 9. */
    f.priority = 9;                 /* 9 = 0b1001, truncated to 0b001 */
    printf("priority after assigning 9 = %u  (truncated to 3 bits)\n", f.priority);

    /* The signedness trap in action. */
    struct trap t = {0};
    t.flag = 1;
    t.ok   = 1;
    printf("int flag:1 holds %d, unsigned ok:1 holds %u\n", t.flag, t.ok);

    /* &f.priority;      ERROR: cannot take the address of a bit field */

    /* The PORTABLE alternative: explicit masks and shifts. */
    uint16_t reg = 0;
    reg |= (uint16_t)(1u   << 0);          /* bit 0: active   */
    reg |= (uint16_t)((5u  & 0x7u) << 1);  /* bits 1-3: priority */
    reg |= (uint16_t)((12u & 0xFu) << 4);  /* bits 4-7: error code */
    printf("register = 0x%04x -> active=%u priority=%u error=%u\n", reg,
           (unsigned)( reg        & 1u),
           (unsigned)((reg >> 1)  & 0x7u),
           (unsigned)((reg >> 4)  & 0xFu));
    return 0;
}
```

```text
   struct packed_flags -- one plausible layout (NOT guaranteed)

   bit:  31                        8 7    4 3  1 0
        +---------------------------+------+----+-+
        |         unused            |error |pri |a|
        +---------------------------+------+----+-+
                                     4 bits 3    1

   Another compiler may allocate from the other end:

   bit:  0 1  3 4    7 8                        31
        +-+----+------+---------------------------+
        |a| pri|error |          unused           |
        +-+----+------+---------------------------+

   Both are conforming. This is why bit fields do NOT portably
   describe hardware registers or wire formats.
```

**Key Takeaways**

- Bit fields declare members in bits (`unsigned int flag : 1`), letting one storage unit hold several small values.
- Always write `unsigned int` — a plain `int` bit field may be signed, so a 1-bit field would hold 0 and -1.
- Bit ordering, straddling, and unit size are implementation-defined, so bit fields are not portable descriptions of registers or wire formats.
- You cannot take the address of a bit field; a zero-width unnamed field forces alignment to the next unit.
- Assigning a value too large for the width truncates silently.
- For portable bit manipulation, use explicit masks and shifts on fixed-width integers, and remember bit fields cost read-modify-write and are not independently thread-safe.

> 🧪 Practice
>
> 1. Define a struct with 1-, 3-, and 4-bit fields, print its `sizeof`, and compare against the same fields as full `unsigned int`s.
> 2. Assign a value larger than a field's width and observe the truncation; compute the expected result by hand first.
> 3. Rewrite a three-field bit-field struct as a single `uint16_t` with mask/shift accessor functions, and verify both produce the same values.
> 4. Interview-style: *"Would you use bit fields to describe a network packet header?"* Hint: list what the standard leaves to the implementation, and what that means when the sender and receiver use different compilers.

<a id="63-typedefs-and-layout"></a>
### 6.3 Typedefs and Layout

Naming a type and knowing how it sits in memory are the two remaining pieces. This section covers `typedef` and the opaque handles it enables, then the alignment rules that decide a struct's real size — and the tools for measuring, controlling, and occasionally overriding them.

#### typedef for Readability

**Theory**

`typedef` creates an **alias** for an existing type. It does not create a new type: after `typedef int Metres;`, a `Metres` *is* an `int`, assignable to and from any other `int` with no warning. C has no way to declare a distinct integer type — the alias is documentation with autocomplete, not type safety.

Its real value is eliminating noise and taming complex declarations. Three patterns dominate:

**Struct aliases.** Without a typedef, every use repeats the keyword: `struct point p;`. With one, `Point p;`. The idiomatic form combines the definition and the typedef, keeping the tag so the type can still be used self-referentially and forward-declared:

```c
typedef struct node {
    int value;
    struct node *next;      /* the TAG is needed here: 'Node' does not
                               exist yet at this point */
} Node;
```

**Function pointers.** This is where typedef stops being cosmetic. `void (*handler)(int, char *)` in a parameter list is hard to read; `Handler h` is not (Chapter 5.3).

**Platform abstraction.** `typedef uint64_t Timestamp;` lets you change the underlying type in one place. The standard library does this everywhere — `size_t`, `time_t`, `FILE`, `ptrdiff_t` are all typedefs whose real types vary by platform.

The syntax follows declaration syntax exactly: write the declaration you would use for a variable, put `typedef` in front, and the name being declared becomes the type name. `typedef int (*Fn)(void);` declares `Fn` where the variable `Fn` would have been.

Three cautions:

**Hiding pointers is usually a mistake.** `typedef struct node *NodePtr;` means readers cannot see that `NodePtr p` is a pointer, so they miss that it can be null, must be freed, and aliases. The convention in most C codebases is to hide struct-ness but not pointer-ness. The exception is genuinely opaque handles (next topic), where hiding is the point.

**Names ending in `_t` are reserved.** POSIX reserves the `_t` suffix for its own types, so `mytype_t` risks a collision with a future standard type. Use `CamelCase` or a project prefix instead.

**A typedef does not create a new type for overload or warning purposes.** Assigning `Metres` to `Seconds` compiles silently. If you need distinct types, wrap the value in a one-member struct — the compiler will then reject cross-assignment.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

/* 1. Struct alias, keeping the tag for self-reference. */
typedef struct node {
    int value;
    struct node *next;        /* 'Node' is not defined yet -- use the tag */
} Node;

/* 2. Function pointer alias: the strongest case for typedef. */
typedef int (*BinaryOp)(int, int);

static int add(int a, int b) { return a + b; }
static int mul(int a, int b) { return a * b; }

/* Compare the two signatures: */
static int apply_raw(int (*op)(int, int), int a, int b) { return op(a, b); }
static int apply(BinaryOp op, int a, int b)             { return op(a, b); }

/* 3. Platform abstraction: change the underlying type in one place. */
typedef unsigned long Timestamp;

/* 4. Distinct types via a wrapper struct -- the compiler CAN check these. */
typedef struct { double v; } Metres;
typedef struct { double v; } Seconds;

/* A plain alias gives no protection: */
typedef double RawMetres;
typedef double RawSeconds;

int main(void)
{
    /* Struct alias in use: no 'struct' keyword needed. */
    Node c = {3, NULL}, b = {2, &c}, a = {1, &b};
    for (Node *n = &a; n; n = n->next) printf("%d ", n->value);
    putchar('\n');

    BinaryOp op = add;
    printf("apply(add, 3, 4) = %d\n", apply(op, 3, 4));
    printf("apply_raw(mul, 3, 4) = %d\n", apply_raw(mul, 3, 4));

    Timestamp t = 1725792000UL;
    printf("timestamp = %lu\n", t);

    /* A typedef alias is NOT a new type: this compiles with no warning. */
    RawMetres m = 5.0;
    RawSeconds s = m;             /* silently accepted: both are double */
    printf("raw alias allows nonsense: %.1f seconds from %.1f metres\n", s, m);

    /* The struct wrapper makes the same mistake a compile error. */
    Metres  distance = { 5.0 };
    Seconds duration = { 2.0 };
    /* duration = distance;          ERROR: incompatible struct types */
    printf("checked: %.1f m over %.1f s = %.1f m/s\n",
           distance.v, duration.v, distance.v / duration.v);
    return 0;
}
```

| Use | Without typedef | With typedef |
| --- | --- | --- |
| Struct variable | `struct node n;` | `Node n;` |
| Function pointer parameter | `int (*op)(int, int)` | `BinaryOp op` |
| Array of function pointers | `int (*t[4])(int, int)` | `BinaryOp t[4]` |
| Pointer to array | `int (*p)[10]` | `typedef int Row[10]; Row *p;` |

```text
   typedef follows declaration syntax exactly:

       int      x;        ->   typedef int      Metres;
       int   (*f)(void);  ->   typedef int   (*Fn)(void);
       char    *s[10];    ->   typedef char    *StringTable[10];
              ^                                ^
       the variable name                the new TYPE name
       goes exactly where               goes in the same place
```

**Key Takeaways**

- `typedef` creates an alias, not a new type; the compiler will not catch mixing two aliases of the same underlying type.
- Use it to drop the `struct` keyword, to name function pointer types, and to abstract platform-dependent types.
- Keep the struct tag when defining a self-referential type, since the alias does not exist yet inside its own definition.
- Avoid hiding pointers behind typedefs except for genuinely opaque handles — readers need to know what can be null and what must be freed.
- Do not name your types with a `_t` suffix; that namespace is reserved by POSIX.
- For real type distinction, wrap the value in a single-member struct.

> 🧪 Practice
>
> 1. Define a struct with and without a typedef and compare the declarations at ten use sites.
> 2. Write a function taking a function pointer parameter, first spelled out and then via a typedef, and compare readability.
> 3. Create two typedefs of `double` and assign one to the other; then convert them to wrapper structs and observe the error.
> 4. Interview-style: *"Is `typedef struct { ... } Foo;` ever a problem?"* Hint: consider what happens when the struct needs a member pointing to its own type.

#### Opaque Types

**Theory**

An **opaque type** is one whose definition callers cannot see. They receive a pointer, pass it back to your functions, and never look inside. This is C's strongest form of encapsulation, and it is built from one language feature: the **incomplete type**.

```c
/* counter.h -- the public header */
typedef struct Counter Counter;      /* declared, never defined here */

Counter *counter_create(void);
void     counter_destroy(Counter *c);
void     counter_increment(Counter *c);
long     counter_value(const Counter *c);
```

Because `struct Counter` is never defined in the header, callers can hold a `Counter *` but cannot declare a `Counter`, cannot access a member, and cannot compute `sizeof`. The full definition lives in `counter.c`, where the implementation can change freely.

What that buys you, concretely:

**True information hiding.** No caller can depend on a field, because none can see one. Compare this with a struct in a header, where nothing stops someone reaching in.

**ABI stability.** Adding, removing, or reordering members changes the struct's size and layout. If callers know the size — because they declared one on the stack or allocated one — every caller must be recompiled. With an opaque handle, only your `.c` file knows the size, so you can change the layout and ship a new shared library without breaking existing binaries. This is why virtually every C library exposes handles: `FILE *`, `sqlite3 *`, `pthread_mutex_t` (partially), `SSL_CTX *`.

**Enforced invariants.** All construction goes through your `create` function, so an object cannot exist in a half-initialized state.

The costs are real and worth stating:

- **Every object must be heap-allocated**, because callers cannot know the size to reserve stack space. That is one allocation per object and a `destroy` call to match.
- **Every access is a function call**, not a direct field read. Compilers cannot inline across translation units without LTO.
- **More code**: a getter and setter for anything callers legitimately need.

Design conventions that make opaque APIs pleasant: name every function with the module prefix; return `NULL` from the constructor on failure; make the destructor tolerate `NULL`; take `const Handle *` for read-only operations; and document ownership in the header, since the type gives no hints.

A middle ground exists when callers must stack-allocate for performance: expose a struct whose members are documented as private (often with an underscore prefix or a `char opaque[N]` blob sized generously). This trades encapsulation for allocation control, and it is how `pthread_mutex_t` works.

**Examples**

```c
/* ===================== stack.h : the entire public contract ============ */
#ifndef MYPROJ_STACK_H
#define MYPROJ_STACK_H

#include <stddef.h>

typedef struct Stack Stack;        /* opaque: no definition here */

Stack *stack_create(size_t capacity);   /* NULL on failure; caller owns it */
void   stack_destroy(Stack *s);         /* safe on NULL */
int    stack_push(Stack *s, int value); /* 0 on success, -1 if full */
int    stack_pop(Stack *s, int *out);   /* 0 on success, -1 if empty */
size_t stack_size(const Stack *s);      /* const: read-only operation */

#endif
```

```c
/* ===================== stack.c : everything private ==================== */
#include <stdlib.h>
#include "stack.h"

struct Stack {              /* the real layout, invisible to callers */
    int    *data;
    size_t  len;
    size_t  cap;
    size_t  push_count;     /* added later: NO caller needs recompiling */
};

Stack *stack_create(size_t capacity)
{
    if (capacity == 0) return NULL;
    Stack *s = malloc(sizeof *s);           /* only THIS file knows the size */
    if (!s) return NULL;
    s->data = malloc(capacity * sizeof *s->data);
    if (!s->data) { free(s); return NULL; }
    s->len = s->push_count = 0;
    s->cap = capacity;
    return s;
}

void stack_destroy(Stack *s)
{
    if (!s) return;                         /* tolerate NULL, like free() */
    free(s->data);
    free(s);
}

int stack_push(Stack *s, int value)
{
    if (s->len == s->cap) return -1;
    s->data[s->len++] = value;
    s->push_count++;
    return 0;
}

int stack_pop(Stack *s, int *out)
{
    if (s->len == 0) return -1;
    *out = s->data[--s->len];
    return 0;
}

size_t stack_size(const Stack *s) { return s->len; }
```

```c
/* ===================== main.c : sees only the contract ================= */
#include <stdio.h>
#include "stack.h"

int main(void)
{
    Stack *s = stack_create(4);
    if (!s) return 1;

    /* Stack local;        ERROR: incomplete type -- size unknown  */
    /* s->len = 99;        ERROR: dereferencing an incomplete type */
    /* sizeof(Stack);      ERROR: same reason                      */

    for (int i = 1; i <= 5; i++)
        printf("push %d -> %s\n", i, stack_push(s, i) == 0 ? "ok" : "full");

    printf("size = %zu\n", stack_size(s));

    int v;
    while (stack_pop(s, &v) == 0) printf("pop %d\n", v);

    stack_destroy(s);
    stack_destroy(NULL);        /* explicitly safe */
    return 0;
}
```

```text
   What each translation unit knows

   main.c                      stack.c
   +----------------------+    +--------------------------+
   | typedef struct Stack |    | struct Stack {           |
   |         Stack;       |    |   int *data;             |
   |                      |    |   size_t len, cap;       |
   | Stack *s;   (8 bytes)|    |   size_t push_count;     |
   | -- cannot deref      |    | };                       |
   | -- cannot sizeof     |    | -- free to change layout |
   +----------------------+    +--------------------------+

   Adding push_count changed sizeof(struct Stack).
   main.o did not need recompiling, because it never knew the size.
```

| | Transparent struct in header | Opaque handle |
| --- | --- | --- |
| Caller can stack-allocate | Yes | No (heap only) |
| Caller can read fields | Yes | Only via functions |
| Changing layout requires | Recompiling all callers | Rebuilding one `.c` |
| Access cost | Direct, inlinable | Function call |
| Best for | Small value types (`Point`) | Resources, evolving types |

**Key Takeaways**

- An opaque type is an incomplete type in the header (`typedef struct T T;`) with its definition confined to one `.c` file.
- Callers can hold and pass the pointer but cannot dereference it, declare an object, or take its `sizeof`.
- This gives real encapsulation and ABI stability: layout changes need no caller recompilation.
- The costs are mandatory heap allocation, a function call per access, and accessor boilerplate.
- Return `NULL` on constructor failure, make the destructor `NULL`-tolerant, use `const Handle *` for reads, and document ownership.

> 🧪 Practice
>
> 1. Build the three-file `Stack` example, then add a field to `struct Stack` and confirm only `stack.c` recompiles.
> 2. Try to declare `Stack s;` in `main.c` and explain the "incomplete type" error in your own words.
> 3. Convert a transparent struct module you have written into an opaque one, listing every capability callers lose.
> 4. Interview-style: *"Why does `FILE` exist as an opaque type rather than a struct you can inspect?"* Hint: consider what would happen to every compiled program if a libc update added a field.

#### Struct Padding and Alignment

**Theory**

You might expect `struct { char c; int i; }` to occupy 5 bytes. It almost always occupies 8. The reason is **alignment**, and understanding it turns struct layout from a mystery into something you can compute.

CPUs do not read memory one byte at a time; they read aligned words. A 4-byte `int` at an address divisible by 4 is fetched in one memory access. At a misaligned address it may take two accesses plus recombination — or, on strict-alignment architectures (some ARM configurations, SPARC), it faults. So each type has an **alignment requirement**, normally equal to its size for scalars: `char` 1, `short` 2, `int` 4, `double` 8, pointers 8 on 64-bit.

C guarantees that every member of a struct is properly aligned. To keep that promise while laying members out in declaration order, the compiler inserts **padding bytes**:

```c
struct bad {
    char  c;      /* offset 0            */
                  /* offsets 1-3: PADDING so i lands on a multiple of 4 */
    int   i;      /* offset 4            */
    char  d;      /* offset 8            */
                  /* offsets 9-11: TRAILING padding */
};                /* sizeof = 12, not 6  */
```

Two rules produce that result:

1. **Each member starts at an offset that is a multiple of its own alignment.**
2. **The struct's total size is a multiple of its strictest member's alignment**, so that arrays of the struct keep every element aligned. That is where trailing padding comes from.

The practical consequence is that **member order changes struct size.** Sorting members from largest to smallest alignment usually minimizes padding:

```c
struct good {
    int   i;      /* offset 0 */
    char  c;      /* offset 4 */
    char  d;      /* offset 5 */
                  /* 2 bytes trailing padding */
};                /* sizeof = 8, one third smaller */
```

For an array of a million records, that is 4 MB saved and noticeably better cache behavior — one of the few "free" optimizations in C.

Two hazards follow from padding:

**Padding bytes hold indeterminate values.** They are not zeroed by `= {0}` (which zeroes members). This is why `memcmp` on two structs is unreliable, why hashing raw struct bytes is a bug, and why writing a struct to a file or socket can leak stack contents — a real class of kernel security issue. `memset` the whole object first, or serialize field by field.

**Padding is not portable.** Sizes and alignments differ between 32-bit and 64-bit, and between ABIs. Never assume a struct's layout matches a file format or wire protocol.

To inspect layout, use `offsetof` (next topic), `_Alignof`, or your compiler: `gcc -Wpadded` warns wherever padding is inserted, and `pahole` visualizes struct holes.

**Examples**

```c
#include <stdio.h>
#include <stddef.h>
#include <string.h>

struct bad  { char c; int i; char d; };      /* poor order  */
struct good { int i; char c; char d; };      /* good order  */

struct mixed {
    char    a;      /* 1 byte  */
    double  b;      /* 8 bytes, needs 8-byte alignment */
    short   c;      /* 2 bytes */
    int     d;      /* 4 bytes */
};

int main(void)
{
    printf("alignments: char=%zu short=%zu int=%zu double=%zu ptr=%zu\n",
           _Alignof(char), _Alignof(short), _Alignof(int),
           _Alignof(double), _Alignof(void *));

    printf("\nstruct bad  : sizeof=%zu\n", sizeof(struct bad));
    printf("  c at %zu, i at %zu, d at %zu\n",
           offsetof(struct bad, c), offsetof(struct bad, i),
           offsetof(struct bad, d));

    printf("struct good : sizeof=%zu  <- same members, 33%% smaller\n",
           sizeof(struct good));
    printf("  i at %zu, c at %zu, d at %zu\n",
           offsetof(struct good, i), offsetof(struct good, c),
           offsetof(struct good, d));

    printf("\nstruct mixed: sizeof=%zu\n", sizeof(struct mixed));
    printf("  a at %zu, b at %zu, c at %zu, d at %zu\n",
           offsetof(struct mixed, a), offsetof(struct mixed, b),
           offsetof(struct mixed, c), offsetof(struct mixed, d));

    /* Padding bytes are INDETERMINATE -- memcmp is unreliable. */
    struct bad x, y;
    memset(&x, 0xAA, sizeof x);      /* simulate whatever was on the stack */
    memset(&y, 0x55, sizeof y);
    x.c = y.c = 'a'; x.i = y.i = 1; x.d = y.d = 'b';
    printf("\nmembers equal, memcmp = %d  <- nonzero: the PADDING differs\n",
           memcmp(&x, &y, sizeof x));

    memset(&x, 0, sizeof x); memset(&y, 0, sizeof y);   /* zero every byte */
    x.c = y.c = 'a'; x.i = y.i = 1; x.d = y.d = 'b';
    printf("after memset, memcmp = %d  <- now reliable\n", memcmp(&x, &y, sizeof x));
    return 0;
}
```

```text
   struct bad { char c; int i; char d; };      sizeof = 12

   offset:  0    1    2    3    4    5    6    7    8    9   10   11
          +----+----+----+----+-------------------+----+----+----+----+
          | c  | ## | ## | ## |        i          | d  | ## | ## | ## |
          +----+----+----+----+-------------------+----+----+----+----+
                 padding (3)                            trailing padding (3)


   struct good { int i; char c; char d; };     sizeof = 8

   offset:  0    1    2    3    4    5    6    7
          +-------------------+----+----+----+----+
          |         i         | c  | d  | ## | ## |
          +-------------------+----+----+----+----+
                                        trailing (2)

   Rule 1: every member at a multiple of its own alignment
   Rule 2: total size a multiple of the strictest alignment
           (so arr[1] starts aligned too)
```

**Key Takeaways**

- Each type has an alignment requirement; the compiler inserts padding so every member lands on a valid offset.
- A struct's size is rounded up to a multiple of its strictest member alignment, which produces trailing padding.
- Declaration order determines size — ordering members from largest to smallest alignment usually minimizes padding.
- Padding bytes are indeterminate: `= {0}` zeroes members, not padding, so `memcmp`, hashing, and raw I/O on structs are unsafe without `memset`.
- Layout is platform- and ABI-specific; never assume a struct matches a file or wire format.
- Inspect layout with `offsetof`, `_Alignof`, `gcc -Wpadded`, or `pahole`.

> 🧪 Practice
>
> 1. Declare `struct { char a; double b; char c; }`, print its `sizeof` and every member offset, then reorder to shrink it and report the saving.
> 2. Write two structs with identical members, fill them identically without `memset`, and compare with `memcmp`. Explain any nonzero result.
> 3. Compile a struct-heavy file with `-Wpadded` and interpret three of the warnings.
> 4. Interview-style: *"How would you reduce the memory footprint of an array of ten million records?"* Hint: start with member ordering, then consider field widths and whether every field belongs in the hot record.

#### offsetof

**Theory**

`offsetof(type, member)`, from `<stddef.h>`, gives the byte offset of a member from the start of its struct, as a `size_t`. It is a compile-time constant, so it can size arrays and appear in static initializers.

```c
size_t off = offsetof(struct employee, salary);   /* e.g. 40 */
```

Why would you need it? Three recurring situations:

**Inspecting layout.** Printing offsets is the fastest way to understand where padding went (previous topic).

**Generic, data-driven access.** A serializer, a config parser, or an ORM-like table can describe a struct as a list of `{name, offset, type}` records, then read or write fields by computing `(char *)object + offset`. This is how C code achieves reflection-like behavior without reflection.

**The `container_of` idiom.** Given a pointer to a member, recover a pointer to the struct that contains it. This is what makes intrusive data structures work — where the list node is embedded *inside* the object rather than pointing to it:

```c
#define container_of(ptr, type, member) \
    ((type *)((char *)(ptr) - offsetof(type, member)))
```

The Linux kernel is built on this. A `struct list_head` is embedded in every object that wants to be listed; the generic list code manipulates only `list_head`s, and `container_of` recovers the enclosing object. The benefit over a `void *`-based list is that no separate node allocation is needed and the type is recovered exactly.

Implementation notes worth knowing: `offsetof` is a macro, traditionally defined as `((size_t)&((type *)0)->member)` — forming a pointer to a member of a null pointer, which is technically undefined behavior. Modern compilers implement it with a builtin (`__builtin_offsetof`), so use the macro from `<stddef.h>` rather than rolling your own.

Restrictions: `offsetof` requires a complete struct or union type and a non-bit-field member, since bit fields may not start on a byte boundary.

For the arithmetic itself, always cast to `char *` before adding an offset — pointer arithmetic is scaled by the pointee type (Chapter 5.2), and `char` is the only type whose scale is one byte.

**Examples**

```c
#include <stdio.h>
#include <stddef.h>
#include <string.h>

struct employee {
    char   name[16];
    int    age;
    double salary;
    int    id;
};

/* Recover the containing struct from a pointer to one of its members. */
#define container_of(ptr, type, member) \
    ((type *)((char *)(ptr) - offsetof(type, member)))

/* A data-driven field table: generic access without reflection. */
typedef enum { F_INT, F_DOUBLE, F_STRING } FieldType;

struct field {
    const char *name;
    size_t      offset;
    FieldType   type;
};

static const struct field employee_fields[] = {
    { "name",   offsetof(struct employee, name),   F_STRING },
    { "age",    offsetof(struct employee, age),    F_INT    },
    { "salary", offsetof(struct employee, salary), F_DOUBLE },
    { "id",     offsetof(struct employee, id),     F_INT    },
};

/* Print any employee field by name, driven entirely by the table. */
static void print_field(const struct employee *e, const char *name)
{
    for (size_t i = 0; i < sizeof employee_fields / sizeof employee_fields[0]; i++) {
        const struct field *f = &employee_fields[i];
        if (strcmp(f->name, name) != 0) continue;

        /* Cast to char* so the arithmetic is in BYTES. */
        const void *p = (const char *)e + f->offset;
        switch (f->type) {
        case F_INT:    printf("%s = %d\n",  name, *(const int *)p);    break;
        case F_DOUBLE: printf("%s = %.2f\n", name, *(const double *)p); break;
        case F_STRING: printf("%s = %s\n",  name,  (const char *)p);   break;
        }
        return;
    }
    printf("%s: no such field\n", name);
}

/* Intrusive list: the node lives INSIDE the object. */
struct list_head { struct list_head *next; };

struct task {
    int id;
    struct list_head link;      /* embedded, not a pointer */
    char label[8];
};

int main(void)
{
    printf("layout of struct employee (sizeof=%zu):\n", sizeof(struct employee));
    printf("  name   at %2zu\n", offsetof(struct employee, name));
    printf("  age    at %2zu\n", offsetof(struct employee, age));
    printf("  salary at %2zu\n", offsetof(struct employee, salary));
    printf("  id     at %2zu\n", offsetof(struct employee, id));

    struct employee e = { "Ada", 36, 95000.0, 7 };
    puts("\ngeneric access by field name:");
    print_field(&e, "name");
    print_field(&e, "salary");
    print_field(&e, "id");
    print_field(&e, "bonus");

    /* container_of: from an embedded member back to the whole object. */
    struct task t = { .id = 42, .label = "build" };
    struct list_head *node = &t.link;            /* generic code sees only this */
    struct task *recovered = container_of(node, struct task, link);
    printf("\ncontainer_of: id=%d label=%s (same object: %s)\n",
           recovered->id, recovered->label,
           recovered == &t ? "yes" : "no");
    return 0;
}
```

```text
   container_of arithmetic

   struct task
   +------+----------------+---------+
   |  id  |     link       |  label  |
   +------+----------------+---------+
   ^      ^
   |      node  (what the generic list code holds)
   |
   node - offsetof(struct task, link)  =  the task itself

   offsetof(struct task, link) = 8
   node = 0x1008  ->  (char*)node - 8  =  0x1000  ->  (struct task *)


   Why intrusive lists matter:

   pointer-based list:  node -> [ptr] -> object     2 allocations, 2 hops
   intrusive list:      node IS inside object       1 allocation, 1 subtraction
```

**Key Takeaways**

- `offsetof(type, member)` from `<stddef.h>` yields a compile-time `size_t` byte offset within a struct.
- It requires a complete type and does not work on bit fields.
- Use it to inspect layout, to build data-driven field tables that read and write members generically, and for `container_of`.
- `container_of` recovers the enclosing struct from a pointer to an embedded member — the foundation of intrusive lists in the Linux kernel.
- Always cast to `char *` before adding a byte offset, since pointer arithmetic is otherwise scaled by the pointee type.

> 🧪 Practice
>
> 1. Print `offsetof` for every member of a four-member struct and reconcile the numbers with its `sizeof`.
> 2. Implement the `container_of` macro and use it to recover a struct from a pointer to its second member.
> 3. Build a field table for a struct and write a function that sets any field by name given a `void *` value.
> 4. Interview-style: *"How does the Linux kernel's linked list work without knowing the element type?"* Hint: the node is embedded in the object, and one macro does the arithmetic that recovers it.

#### _Alignas and _Alignof

**Theory**

Before C11, alignment was something the compiler did to you. C11 made it controllable with two operators, declared in `<stdalign.h>`:

- **`_Alignof(type)`** yields the alignment requirement of a type, as a compile-time `size_t`. It answers "what address multiple must this start on?"
- **`_Alignas(x)`** on a declaration raises an object's alignment to at least `x`, which may be a constant or a type.

`<stdalign.h>` provides `alignof` and `alignas` as macros for the underscore-free spelling; in C23 both are keywords and the header is unnecessary.

Why would you ever need more alignment than the compiler gives?

**SIMD instructions.** SSE requires 16-byte alignment, AVX 32-byte, AVX-512 64-byte. A misaligned load either faults or takes the slow path.

**Cache-line alignment.** On a 64-byte cache-line machine, two variables written by two threads that share a cache line cause **false sharing**: each write invalidates the other core's copy, and throughput collapses even though the variables are logically independent. Aligning each to 64 bytes and padding to a full line fixes it — a standard technique in concurrent data structures.

**Hardware buffers.** DMA controllers and memory-mapped devices frequently require specific alignment.

The rules:

- `_Alignas` may only **increase** alignment, never decrease it. `_Alignas(1) int x;` is an error.
- The argument must be a valid alignment (a power of two) that the implementation supports.
- It applies to objects and struct members, but **not** to function parameters, bit fields, or `register` variables.
- Applying it to a struct member increases the struct's own alignment and size accordingly.

For heap allocations, `malloc` returns memory aligned for any *fundamental* type (typically 16 bytes), which is not enough for AVX-512 or cache-line alignment. C11 added **`aligned_alloc(alignment, size)`**, where the size must be a multiple of the alignment; POSIX offers `posix_memalign`. Memory from either is freed with plain `free`.

`max_align_t` (in `<stddef.h>`) names the strictest fundamental alignment, which is what `malloc` guarantees.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <stdalign.h>      /* alignas / alignof macros */
#include <stddef.h>
#include <stdint.h>        /* uintptr_t, for the modulo checks below */

/* Cache-line alignment to prevent false sharing between threads. */
#define CACHE_LINE 64

struct counters {
    alignas(CACHE_LINE) long a;    /* each counter gets its own cache line */
    alignas(CACHE_LINE) long b;
};

/* Over-aligned type for SIMD. */
typedef struct {
    alignas(16) float v[4];        /* SSE wants 16-byte alignment */
} vec4;

int main(void)
{
    printf("alignof: char=%zu short=%zu int=%zu double=%zu\n",
           alignof(char), alignof(short), alignof(int), alignof(double));
    printf("alignof(void*)=%zu  alignof(max_align_t)=%zu (what malloc guarantees)\n",
           alignof(void *), alignof(max_align_t));

    /* Raising alignment on a single object. */
    alignas(64) int aligned_var = 5;
    int normal_var = 5;
    printf("\naligned_var at %p (%% 64 = %zu)\n",
           (void *)&aligned_var, (size_t)((uintptr_t)&aligned_var % 64));
    printf("normal_var  at %p (%% 64 = %zu)\n",
           (void *)&normal_var, (size_t)((uintptr_t)&normal_var % 64));

    /* Alignment on members inflates the struct. */
    printf("\nsizeof(struct counters) = %zu (two 64-byte lines)\n",
           sizeof(struct counters));
    printf("alignof(struct counters) = %zu\n", alignof(struct counters));
    printf("offsetof b = %zu\n", offsetof(struct counters, b));

    printf("\nsizeof(vec4)=%zu alignof(vec4)=%zu\n", sizeof(vec4), alignof(vec4));

    /* Heap: malloc guarantees only max_align_t; use aligned_alloc for more. */
    void *plain = malloc(256);
    void *over  = aligned_alloc(64, 256);   /* size MUST be a multiple of 64 */
    if (!plain || !over) { free(plain); free(over); return EXIT_FAILURE; }

    printf("\nmalloc         -> %p (%% 64 = %zu)\n",
           plain, (size_t)((uintptr_t)plain % 64));
    printf("aligned_alloc  -> %p (%% 64 = %zu)\n",
           over, (size_t)((uintptr_t)over % 64));

    free(plain);
    free(over);                              /* plain free() is correct */

    /* alignas(1) int x;      ERROR: alignment can only be RAISED */
    return 0;
}
```

```text
   False sharing, and what alignas fixes

   Without alignment: two counters in ONE cache line

   cache line (64 bytes)
   +--------+--------+---------------------------------+
   |   a    |   b    |            unused               |
   +--------+--------+---------------------------------+
   thread 1 writes a  ->  invalidates the whole line on core 2
   thread 2 writes b  ->  invalidates the whole line on core 1
   result: constant cache-coherency traffic, throughput collapses


   With alignas(64): separate lines

   line 0                        line 1
   +--------+--------------+     +--------+--------------+
   |   a    |   padding    |     |   b    |   padding    |
   +--------+--------------+     +--------+--------------+
   independent writes, no coherency traffic
```

**Key Takeaways**

- `_Alignof`/`alignof` queries a type's alignment; `_Alignas`/`alignas` raises an object's or member's alignment.
- Alignment can only be increased, and only to a supported power of two; it does not apply to parameters or bit fields.
- Over-alignment matters for SIMD loads, DMA buffers, and avoiding false sharing between threads on separate cache lines.
- `malloc` guarantees only `max_align_t` alignment; use `aligned_alloc` (size must be a multiple of the alignment) or `posix_memalign` for more, and free both with `free`.
- `alignas` on a member raises the whole struct's alignment and size.

> 🧪 Practice
>
> 1. Print `alignof` for six built-in types and for a struct containing them, and explain the struct's value.
> 2. Declare a variable with `alignas(64)` and verify its address is a multiple of 64; then try `alignas(1)` and read the error.
> 3. Allocate a buffer with `aligned_alloc(64, 640)` and confirm the alignment; then measure a memory-bandwidth loop against a plain `malloc` buffer.
> 4. Interview-style: *"What is false sharing and how would you prevent it?"* Hint: two threads, two variables, one cache line — and what the coherency protocol does on each write.

#### Packing Trade-offs

**Theory**

Padding wastes space, and sometimes you want it gone: a struct that must match a file header byte for byte, or an array of ten million records where 30 percent padding is real memory. Compilers offer **packing** to remove padding entirely.

There is no standard syntax; the two common spellings are:

```c
#pragma pack(push, 1)        /* MSVC and GCC/Clang */
struct header { char c; int i; };
#pragma pack(pop)

struct __attribute__((packed)) header { char c; int i; };   /* GCC/Clang */
```

Both produce a struct with no padding: `sizeof` becomes 5 instead of 8, and `i` starts at offset 1.

Now the costs, which are larger than they look.

**Misaligned access is slow, and sometimes fatal.** On x86 the CPU handles unaligned loads with a performance penalty (often small for scalars, significant when it straddles a cache line). On strict-alignment architectures — some ARM configurations, MIPS, SPARC — an unaligned load raises a fault. The compiler knows the field is misaligned and emits byte-by-byte assembly to compensate, which is correct but slower still.

**Taking the address of a packed member is undefined behavior.** `&packed.i` has type `int *` but does not satisfy `int`'s alignment, so dereferencing it — or passing it to a function expecting an aligned `int *` — is UB. GCC warns with `-Waddress-of-packed-member`, and this is the most common real bug packing introduces.

**Packing does not make layout portable.** It removes padding but does nothing about endianness, type sizes (`long` is 4 bytes on Windows and 8 on Linux), bit field ordering, or signedness of `char`. A packed struct still fails to describe a wire format portably.

The recommended alternative for serialization is **explicit marshalling**: read and write field by field with fixed-width types and `memcpy`, converting byte order as needed. It is more code, but it is correct everywhere, it is greppable, and it makes the format explicit rather than implicit in a struct declaration.

| Goal | Packing | Better approach |
| --- | --- | --- |
| Match a file/wire format | Not portable | Explicit `memcpy` marshalling with fixed-width types and byte-order conversion |
| Save memory in a large array | Works, costs speed | Reorder members first; shrink field widths; consider SoA |
| Match a hardware register | Fragile | `volatile` fixed-width integers with masks and shifts |
| Interop with a specific compiled ABI | Legitimate use | Packing, with static assertions on size and offsets |

When you do pack, defend it: add `static_assert(sizeof(struct h) == 5, "layout changed")` and `static_assert(offsetof(...) == n, ...)` so a compiler or platform change fails the build instead of corrupting data.

**Examples**

```c
#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>

struct normal { char c; int i; short s; };

/* GCC/Clang attribute form. */
struct __attribute__((packed)) packed_attr { char c; int i; short s; };

/* Pragma form (also MSVC). */
#pragma pack(push, 1)
struct packed_pragma { char c; int i; short s; };
#pragma pack(pop)

/* Guard the assumption so a platform change breaks the BUILD, not the data. */
static_assert(sizeof(struct packed_attr) == 7, "unexpected packed layout");
static_assert(offsetof(struct packed_attr, i) == 1, "unexpected offset");

/* The portable alternative: explicit marshalling, no layout assumptions. */
struct message { uint8_t type; uint32_t length; uint16_t flags; };

static size_t message_encode(const struct message *m, uint8_t *out)
{
    size_t k = 0;
    out[k++] = m->type;
    /* Big-endian on the wire, regardless of host byte order. */
    out[k++] = (uint8_t)(m->length >> 24);
    out[k++] = (uint8_t)(m->length >> 16);
    out[k++] = (uint8_t)(m->length >>  8);
    out[k++] = (uint8_t)(m->length      );
    out[k++] = (uint8_t)(m->flags  >>  8);
    out[k++] = (uint8_t)(m->flags       );
    return k;                                  /* exactly 7 bytes, everywhere */
}

static void message_decode(const uint8_t *in, struct message *m)
{
    m->type   = in[0];
    m->length = ((uint32_t)in[1] << 24) | ((uint32_t)in[2] << 16) |
                ((uint32_t)in[3] <<  8) |  (uint32_t)in[4];
    m->flags  = (uint16_t)(((uint16_t)in[5] << 8) | in[6]);
}

int main(void)
{
    printf("normal        : sizeof=%zu  c@%zu i@%zu s@%zu\n",
           sizeof(struct normal), offsetof(struct normal, c),
           offsetof(struct normal, i), offsetof(struct normal, s));
    printf("packed_attr   : sizeof=%zu  c@%zu i@%zu s@%zu\n",
           sizeof(struct packed_attr), offsetof(struct packed_attr, c),
           offsetof(struct packed_attr, i), offsetof(struct packed_attr, s));
    printf("packed_pragma : sizeof=%zu\n", sizeof(struct packed_pragma));

    struct packed_attr p = { 'A', 0x11223344, 0x5566 };
    printf("packed value  : c=%c i=0x%08x s=0x%04x\n", p.c, p.i, p.s);

    /* int *bad = &p.i;    UNDEFINED: the address is not int-aligned.
       GCC reports it with -Waddress-of-packed-member.
       The safe way to get the value out: */
    int copy;
    memcpy(&copy, &p.i, sizeof copy);
    printf("via memcpy    : 0x%08x\n", copy);

    /* Explicit marshalling: identical bytes on every platform. */
    struct message m = { .type = 3, .length = 0x0000ABCD, .flags = 0x0102 };
    uint8_t wire[7];
    size_t n = message_encode(&m, wire);
    printf("wire (%zu bytes):", n);
    for (size_t i = 0; i < n; i++) printf(" %02x", wire[i]);
    putchar('\n');

    struct message back;
    message_decode(wire, &back);
    printf("decoded       : type=%u length=0x%08x flags=0x%04x\n",
           back.type, back.length, back.flags);
    return 0;
}
```

```text
   struct normal { char c; int i; short s; };     sizeof = 12

   0    1    2    3    4    5    6    7    8    9   10   11
   +----+----+----+----+-------------------+---------+----+----+
   | c  | ## | ## | ## |         i         |    s    | ## | ## |
   +----+----+----+----+-------------------+---------+----+----+
   every member aligned; loads are single instructions


   packed:                                        sizeof = 7

   0    1    2    3    4    5    6
   +----+-------------------+---------+
   | c  |         i         |    s    |
   +----+-------------------+---------+
        ^
        i starts at offset 1: NOT 4-byte aligned
        -> slower loads on x86, a FAULT on strict-alignment CPUs
        -> &p.i is an unaligned int* : undefined behavior
```

**Key Takeaways**

- `#pragma pack(1)` and `__attribute__((packed))` remove padding, shrinking the struct at the cost of misaligned members.
- Misaligned access is slower on x86 and can fault on ARM, MIPS, and SPARC; the compiler compensates with slower code.
- Taking the address of a packed member is undefined behavior — use `memcpy` to extract the value, and heed `-Waddress-of-packed-member`.
- Packing does not make layout portable: endianness, type sizes, and bit field ordering still vary.
- Prefer explicit field-by-field marshalling with fixed-width types for wire and file formats.
- If you must pack, guard `sizeof` and `offsetof` with `static_assert` so a platform change fails the build.

> 🧪 Practice
>
> 1. Declare the same three members as a normal and a packed struct, print both sizes and all offsets, and compute the saving.
> 2. Take the address of a packed member, compile with `-Wall -Wextra`, and read the warning. Then rewrite the access with `memcpy`.
> 3. Write `encode`/`decode` functions for a four-field message using fixed-width types and big-endian byte order, and round-trip a value.
> 4. Interview-style: *"A colleague proposes `#pragma pack(1)` on a struct that is written directly to a network socket. What do you say?"* Hint: name what packing fixes and the three things it leaves broken across platforms.

---

## 7. Memory Management

Every C program is a story about memory: where objects live, how long they last, and who is responsible for reclaiming them. C gives you direct control over all three, which is why C programs can be fast and small — and why the majority of security vulnerabilities in C code are memory bugs. This chapter maps the regions of a running process, teaches the dynamic allocation API precisely, catalogues the classic memory errors with the tools that catch them, and finishes with the allocation strategies experienced C programmers reach for when `malloc` per object is not good enough.

<a id="71-memory-model"></a>
### 7.1 Memory Model

Before allocating anything you need a mental picture of where memory comes from. This section walks through the address space of a running process, the fundamental stack/heap distinction, the storage that exists for the whole program run, the read-only regions, and the rule that ties it all together: object lifetime.

#### Process Memory Layout

**Theory**

When you run a program, the operating system does not hand your code a flat undifferentiated pile of bytes. It builds an **address space**: a range of virtual addresses divided into regions, each with different contents, different permissions, and a different growth behaviour. Knowing which region an address belongs to tells you almost everything you need to know about it — whether you may write to it, how long it will remain valid, and who is going to clean it up.

The classic layout, from low addresses to high, looks like this on a typical Unix-like system:

- **Text (code) segment** — the machine instructions of your program, plus (usually) string literals and other constants. Read-only and executable. Writing here traps.
- **Initialized data (`.data`)** — global and `static` variables with a non-zero initializer. Read/write, and their initial values are stored in the executable file itself.
- **Uninitialized data (`.bss`)** — global and `static` variables that are zero or have no initializer. Read/write, and *not* stored in the file: the loader simply maps a zeroed region, which is why a program with a 100 MB global array can have a tiny executable. ("bss" is a historical assembler mnemonic; treat it as a name.)
- **Heap** — the region `malloc` carves allocations out of. It grows *upward*, toward higher addresses, as the allocator asks the kernel for more space.
- **Memory-mapped region** — shared libraries, large `malloc` blocks, and anything you map with `mmap`. Sits between the heap and the stack.
- **Stack** — one region per thread, holding function call frames. It grows *downward*, toward lower addresses, as calls nest.

Two properties are essential. First, these are **virtual** addresses: the address you print is a per-process fiction that the MMU translates to physical memory. Two processes can both hold address `0x601040` and be looking at entirely different physical bytes. Second, the regions have **permissions** enforced by hardware. A write to the text segment or a jump into a non-executable stack raises a fault, which the kernel usually turns into `SIGSEGV`.

A useful analogy: the address space is a warehouse. The text segment is the sealed blueprint cabinet — readable, never modified. Static storage is the permanent shelving, allocated when the warehouse opens and cleared when it closes. The stack is a stack of pallets by the door: last on, first off, and everything on it disappears when the shift ends. The heap is the open floor where you can claim any patch of any size, keep it as long as you like, and must remember to release it.

Modern systems also randomize the base addresses of these regions on every run (ASLR), so exact addresses are never reproducible and must never be hard-coded or compared for anything but equality with pointers from the same region.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

int initialized_global = 42;      /* .data : value stored in the binary   */
int uninitialized_global;         /* .bss  : zero-filled by the loader    */
const char *literal = "hello";    /* pointer in .data, chars in .rodata   */

void f(void) { }                  /* code lives in .text                  */

int main(void)
{
    int local = 1;                        /* stack */
    static int function_static = 7;       /* .data, despite being in a function */
    void *heap = malloc(64);              /* heap  */

    /* %p expects void*; the cast is required for correctness, not style. */
    printf("text   (function f)   : %p\n", (void *)(size_t)f);
    printf("rodata (string lit)   : %p\n", (void *)literal);
    printf("data   (init global)  : %p\n", (void *)&initialized_global);
    printf("data   (func static)  : %p\n", (void *)&function_static);
    printf("bss    (uninit global): %p\n", (void *)&uninitialized_global);
    printf("heap   (malloc)       : %p\n", heap);
    printf("stack  (local)        : %p\n", (void *)&local);

    free(heap);
    return 0;
}
```

Typical output on x86-64 Linux (addresses vary every run because of ASLR):

```text
text   (function f)   : 0x5591b4a0d169
rodata (string lit)   : 0x5591b4a0e004
data   (init global)  : 0x5591b4a10010
data   (func static)  : 0x5591b4a10014
bss    (uninit global): 0x5591b4a1001c
heap   (malloc)       : 0x5591b5c2f2a0     <- above the data segment
stack  (local)        : 0x7ffd3a4f1abc     <- far higher, separate region
```

```text
        HIGH ADDRESSES
        +-------------------------------+
        | environment / argv strings    |
        +-------------------------------+
        | STACK                         |  one per thread
        |   main's frame                |
        |   caller's frame              |
        |   callee's frame              |
        |            |                  |
        |            v  grows DOWN      |
        +-------------------------------+
        |                               |
        |        (unmapped gap)         |  touching this = SIGSEGV
        |                               |
        +-------------------------------+
        |            ^  grows UP        |
        |            |                  |
        | HEAP  (malloc / free)         |
        +-------------------------------+
        | .bss   uninitialized globals  |  zero-filled, not in the file
        +-------------------------------+
        | .data  initialized globals    |  values come from the file
        +-------------------------------+
        | .rodata string literals, const|  READ-ONLY
        +-------------------------------+
        | .text  machine code           |  READ-ONLY + EXECUTABLE
        +-------------------------------+
        LOW ADDRESSES  (page 0 unmapped, which is why *NULL traps)
```

You can see the segments in a real binary without running it:

```bash
$ size ./a.out
   text    data     bss     dec     hex filename
   1867     620       8    2495     9bf a.out
```

**Key Takeaways**

- A process address space is divided into regions with distinct contents, permissions, and lifetimes: text, rodata, data, bss, heap, mapped files, and stack.
- Globals with non-zero initializers occupy `.data` and are stored in the executable; zero/uninitialized globals occupy `.bss` and cost no file space.
- The heap grows upward and is managed by you; each thread's stack grows downward and is managed automatically.
- Addresses are virtual and randomized per run — never hard-code them, and only compare pointers within the same object.
- Page zero is deliberately unmapped, which is why dereferencing `NULL` reliably faults instead of silently corrupting memory.

> 🧪 Practice
>
> 1. Write a program that prints the address of a global, a `static` local, a stack local, and a `malloc` result, and order them from lowest to highest.
> 2. Add a 10 MB uninitialized global array to a program, rebuild, and compare the on-disk size with the same array initialized to `{1}`. Explain the difference using `size`.
> 3. Recurse a function that prints the address of its own local variable, and determine the direction and per-frame size of stack growth.
> 4. Interview-style: *"Two runs of the same program print different addresses for the same global. Is that a bug?"* Hint: think about what layer maps virtual addresses, and what security feature deliberately perturbs the mapping.

#### Stack vs Heap

**Theory**

The two regions you actively allocate from are the stack and the heap, and choosing between them is one of the most consequential decisions in a C program. They differ in almost every dimension.

The **stack** is a contiguous region managed by a single register (the stack pointer). Entering a function subtracts from it to make a frame holding parameters, locals, saved registers, and the return address; returning adds it back. That is the entire allocation algorithm: one arithmetic instruction. It is therefore extremely fast, perfectly cache-friendly (the top of the stack is nearly always in L1), and impossible to leak — the frame is reclaimed by the `return` whether you planned it or not.

Its cost is rigidity. The lifetime of a stack object is exactly the enclosing block, no longer. The size is fixed at compile time (unless you use a VLA), and the total space is small and bounded — commonly 8 MB for the main thread on Linux and often just 512 KB to 1 MB for other threads. Overflow it and you get a fault, not an error code.

The **heap** is a general-purpose pool managed by library code (`malloc` and friends), which in turn asks the kernel for large chunks via `brk` or `mmap`. Allocation means searching bookkeeping structures for a suitable free block, splitting it, and updating metadata — dramatically more work than adjusting a register, and each block carries hidden overhead (typically 8–16 bytes of header plus rounding to a 16-byte boundary). In exchange you get what the stack cannot give: **lifetime you control**, sizes determined at run time, and capacity limited by system memory rather than by a fixed frame budget.

The decision rule that covers most real code:

| Question | Stack | Heap |
|---|---|---|
| Size known at compile time? | required (or a small VLA) | not required |
| Size large (say > 100 KB)? | avoid — overflow risk | yes |
| Must outlive the creating function? | impossible | yes |
| Allocation cost | ~1 instruction | tens to hundreds of instructions |
| Reclamation | automatic on return | manual `free`, or it leaks |
| Failure mode | crash on overflow | `NULL` return you can handle |
| Fragmentation | none | possible over long runs |

The single most common beginner error in C follows directly from the stack's lifetime rule: returning a pointer to a local. The address stays numerically valid and the bytes may even look right for a while, but the frame is gone, and the next call reuses it.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* WRONG: 'buf' dies when make_greeting_broken returns.
   The returned pointer refers to a frame that no longer exists. */
char *make_greeting_broken(const char *name)
{
    char buf[64];
    snprintf(buf, sizeof buf, "Hello, %s!", name);
    return buf;                    /* dangling: undefined behaviour */
}

/* RIGHT (option A): allocate on the heap; the CALLER frees. */
char *make_greeting_heap(const char *name)
{
    size_t n = strlen(name) + 9;   /* "Hello, " + name + "!" + NUL */
    char *s = malloc(n);
    if (!s) return NULL;
    snprintf(s, n, "Hello, %s!", name);
    return s;                      /* valid until the caller frees it */
}

/* RIGHT (option B): the caller supplies the buffer -- no allocation at all.
   This is the classic C idiom: it works with stack, heap or static memory. */
int make_greeting_into(char *dst, size_t cap, const char *name)
{
    int n = snprintf(dst, cap, "Hello, %s!", name);
    return (n >= 0 && (size_t)n < cap) ? 0 : -1;   /* -1 means truncated */
}

int main(void)
{
    char stack_buf[64];
    if (make_greeting_into(stack_buf, sizeof stack_buf, "Ada") == 0)
        puts(stack_buf);

    char *heap_str = make_greeting_heap("Grace");
    if (heap_str) {
        puts(heap_str);
        free(heap_str);            /* caller owns it, caller frees it */
    }
    return 0;
}
```

```text
   A CALL IN PROGRESS
                                   HEAP
   STACK (grows down)              +--------------------------+
   +---------------------+         | header | "Hello, Grace!" |
   | main frame          |         +--------------------------+
   |   stack_buf[64] ....|              ^
   |   heap_str  --------+--------------+
   +---------------------+
   | make_greeting frame |   <- exists only while the call is active
   |   name, n, s        |      pop on return; reused by the NEXT call
   +---------------------+
   |         v           |
   |   (unallocated)     |

   Returning &stack_buf from a callee hands out an address in a frame
   that the next call will overwrite. Returning a heap pointer is fine:
   the block outlives every frame until someone calls free().
```

**Key Takeaways**

- Stack allocation is a register adjustment: fastest possible, automatically reclaimed, but lifetime-bound to the enclosing block and limited to a few megabytes.
- Heap allocation costs real work and per-block overhead, but gives run-time sizes, caller-controlled lifetime, and a recoverable `NULL` on failure.
- Prefer the stack for small, short-lived, fixed-size objects; use the heap when the object must outlive its creator, is large, or has a run-time size.
- Never return a pointer to a local object — the frame is reclaimed on return regardless of what the bytes still contain.
- The "caller supplies the buffer" idiom sidesteps the choice entirely and is the most reusable interface shape in C.

> 🧪 Practice
>
> 1. Write `char *bad(void)` returning a pointer to a local array; call it, then call an unrelated function, and print the buffer. Compile with `-Wall` and read the warning.
> 2. Benchmark one million 64-byte stack allocations against one million `malloc`/`free` pairs and report the ratio.
> 3. Write a recursive function with a 1 MB local array and find how many frames deep it gets before crashing. Compare with `ulimit -s`.
> 4. Interview-style: *"When would you deliberately choose heap allocation for an object that easily fits on the stack?"* Hint: think about lifetime, ownership transfer, and the size of the object relative to the thread's stack limit.

#### Static and Global Storage

**Theory**

Between the stack (too short-lived) and the heap (manually managed) sits a third storage duration: **static**. An object with static storage duration is created before `main` runs and destroyed after it returns — it exists for the entire execution of the program, at a fixed address, in `.data` or `.bss`.

Three declarations produce static storage:

1. A variable declared at file scope (a "global"), with or without `static`.
2. A variable inside a function declared `static`.
3. A variable declared `static` at file scope — same storage, but with internal linkage.

Note the keyword `static` does two unrelated jobs in C, which is a genuine wart worth stating plainly:

- **Inside a function**, `static` changes *storage duration*: the variable persists across calls instead of being recreated.
- **At file scope**, `static` changes *linkage*: the name becomes invisible to other translation units. The storage duration was already static.

Three rules make static storage predictable:

**Zero initialization is guaranteed.** Unlike automatic variables, a static object with no initializer is zero-initialized — every scalar to `0`, every pointer to `NULL`, recursively through arrays and structs. This is free, done by the loader mapping a zeroed page.

**Initializers must be constant expressions.** `static int x = 5;` is fine; `static int x = get_value();` is not, because the value has to be known at link time. (C++ allows dynamic initialization here; C does not.)

**The address is fixed and stable** for the whole run, which makes static objects safe to return pointers to — the one storage class where returning `&local` is legal.

Static locals are excellent for things like one-time initialization flags, call counters, and caches. They come with two serious caveats. They are **not thread-safe**: every thread shares the one object, so any mutation needs synchronization or `_Thread_local` (C11), which gives each thread its own copy. And they make functions **non-reentrant**, which is exactly why `strtok` cannot be used from two places at once and why `strtok_r` exists.

Also remember that static objects consume memory for the entire run. A 64 MB static buffer costs 64 MB from process start to exit, whether used or not.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

int    g_initialized = 10;    /* .data, external linkage  */
int    g_zero;                /* .bss,  external linkage, guaranteed 0 */
static int g_private = 3;     /* .data, INTERNAL linkage: file-local */

/* A static local: one object shared by every call. */
int next_id(void)
{
    static int counter = 0;   /* initialized ONCE, before main() */
    return ++counter;         /* the value survives between calls */
}

/* Contrast: an automatic local is recreated (and here, re-initialized)
   on every call, so it can never accumulate anything. */
int broken_next_id(void)
{
    int counter = 0;
    return ++counter;         /* always 1 */
}

/* Legal to return: the array's lifetime is the whole program.
   NOT thread-safe and NOT reentrant -- a second call clobbers the first
   result while the caller may still be holding it. */
const char *month_name(int m)
{
    static const char *names[] = {
        "Jan","Feb","Mar","Apr","May","Jun",
        "Jul","Aug","Sep","Oct","Nov","Dec"
    };
    return (m >= 1 && m <= 12) ? names[m - 1] : "???";
}

/* One-time initialization guarded by a static flag (single-threaded only). */
static int *lookup_table(void)
{
    static int table[256];
    static int ready = 0;              /* zero-initialized for free */
    if (!ready) {
        for (int i = 0; i < 256; i++)
            table[i] = i * i;
        ready = 1;
    }
    return table;                      /* fixed address, always valid */
}

int main(void)
{
    printf("%d %d %d\n", next_id(), next_id(), next_id());   /* order unspecified! */
    printf("static local again: %d\n", next_id());
    printf("broken: %d %d\n", broken_next_id(), broken_next_id());
    printf("g_zero = %d (guaranteed zero)\n", g_zero);
    printf("month 3 = %s\n", month_name(3));
    printf("table[16] = %d\n", lookup_table()[16]);
    (void)g_private;
    return 0;
}
```

Note the deliberate trap in the first `printf`: the evaluation order of function arguments is unspecified, so three calls to a counter inside one call is exactly the kind of code that prints `3 2 1` on one compiler and `1 2 3` on another.

| Declaration | Storage duration | Linkage | Initial value if omitted |
|---|---|---|---|
| `int x;` at file scope | static | external | zero |
| `static int x;` at file scope | static | internal | zero |
| `int x;` inside a function | automatic | none | indeterminate |
| `static int x;` inside a function | static | none | zero |
| `_Thread_local static int x;` | thread | none | zero, per thread |

**Key Takeaways**

- Static storage duration means the object lives from before `main` to after it returns, at a fixed address.
- Static objects are zero-initialized by default and can only be initialized with constant expressions.
- `static` inside a function controls lifetime; `static` at file scope controls linkage — same keyword, different jobs.
- Returning a pointer to a static object is legal, but the object is shared, so the function is neither reentrant nor thread-safe.
- Use `_Thread_local` (C11) when each thread needs its own persistent copy.

> 🧪 Practice
>
> 1. Write a `counter()` function using a static local and call it five times; then remove `static` and explain the change in output.
> 2. Write `const char *to_string(int n)` that formats into a static buffer, then call it twice inside one `printf` and explain the result.
> 3. Declare a file-scope `static` variable in two `.c` files with the same name, link them, and confirm they are distinct objects. Then remove `static` and read the linker error.
> 4. Interview-style: *"Why is `strtok` considered dangerous in modern code?"* Hint: ask what it must remember between calls, and where that state can possibly live.

#### Text and Read-Only Data

**Theory**

Not all of your program's memory is writable, and the parts that are not exist for good reasons. Two regions are mapped read-only by the loader:

- **`.text`** — the compiled machine instructions. Read and execute, no write. Making code read-only prevents accidental self-modification and, combined with W^X ("write xor execute") policies, blocks a large class of attacks that inject code into a data buffer and jump to it.
- **`.rodata`** — read-only data: string literals, `const` objects the compiler can prove are never modified, jump tables generated for `switch`, and floating-point constants.

The single most consequential practical consequence is the nature of **string literals**. A literal like `"hello"` is an array object of type `char[6]` with static storage duration, typically placed in `.rodata`. Two things follow:

**Modifying a string literal is undefined behaviour.** On hosted systems with a read-only `.rodata` mapping it is a segmentation fault; on some embedded targets it silently succeeds and corrupts a shared constant. There is no diagnostic required.

**Identical literals may be shared.** The compiler is permitted (and usually configured) to store one copy of `"hello"` and point every occurrence at it, so pointer comparisons between literals have unspecified results.

This creates C's most infamous type trap:

```c
char *p = "hello";        /* pointer to READ-ONLY memory; p[0]='H' is UB */
char  a[] = "hello";      /* a MUTABLE COPY on the stack; a[0]='H' is fine */
```

Both lines contain the same literal, but the second uses it as an *initializer* for a local array, which copies the six bytes into writable storage. In C the literal's type is `char[]` rather than `const char[]` for historical compatibility, so `char *p = "hello";` compiles without complaint — this is why `-Wwrite-strings` exists and why disciplined code always writes `const char *p = "hello";`.

`const` itself deserves a precise statement: it is a *promise you make to the compiler*, not a hardware guarantee. A `const` local on the stack lives in writable memory and can be modified through a cast (undefined behaviour, but it will physically work). A `const` object with static storage duration and a constant initializer is typically placed in `.rodata`, where the hardware does enforce it. The distinction matters when reasoning about what will crash versus what will silently corrupt.

**Examples**

```c
#include <stdio.h>
#include <string.h>

const int  g_const = 100;        /* likely .rodata: hardware-enforced   */
const char g_msg[] = "constant"; /* .rodata                             */

int main(void)
{
    char *mutable_ptr  = "literal";        /* points INTO .rodata      */
    const char *good   = "literal";        /* same bytes, honest type  */
    char  copy[]       = "literal";        /* a WRITABLE stack copy    */

    printf("literal via ptr : %s  at %p\n", mutable_ptr, (void *)mutable_ptr);
    printf("stack copy      : %s  at %p\n", copy, (void *)copy);

    copy[0] = 'L';                 /* fine: 'copy' is a stack array */
    printf("after write     : %s\n", copy);

    /* mutable_ptr[0] = 'L';          <- CRASH: writing to .rodata      */
    /* strcpy(mutable_ptr, "boom");   <- same crash, less obvious       */

    /* sizeof reveals the difference between the array and the pointer. */
    printf("sizeof(copy)=%zu  sizeof(mutable_ptr)=%zu\n",
           sizeof copy,            /* 8: the array, including the NUL   */
           sizeof mutable_ptr);    /* 8 on x86-64: just a pointer       */

    /* Identical literals MAY be merged into one object -- unspecified. */
    const char *a = "shared";
    const char *b = "shared";
    printf("a==b ? %s (unspecified either way)\n", a == b ? "yes" : "no");

    printf("%d %s\n", g_const, g_msg);
    (void)good;
    return 0;
}
```

```text
   char *p    = "hello";                char a[] = "hello";

   STACK                                STACK
   +---------+                          +---------------------+
   | p  o----+---+                      | a: h e l l o \0     |  writable
   +---------+   |                      +---------------------+
                 |
   .rodata       v                      .rodata
   +---------------------+              +---------------------+
   | h e l l o \0        |  READ-ONLY   | h e l l o \0        | (template
   +---------------------+              +---------------------+  copied in
                                                                 at startup)
   p[0] = 'H';  -> SIGSEGV              a[0] = 'H';  -> fine
```

Two compiler flags turn this class of bug into a build error:

```bash
# Give string literals the type 'const char[]' so assigning to char* warns.
gcc -Wwrite-strings -Wall -Wextra prog.c
# prog.c: warning: initialization discards 'const' qualifier

# Belt and braces: make every warning fatal in CI.
gcc -Wwrite-strings -Werror prog.c
```

**Key Takeaways**

- `.text` (code) and `.rodata` (literals and constants) are mapped read-only; writing to them faults on hosted systems.
- A string literal is a static array in read-only memory — modifying it is undefined behaviour, and identical literals may be merged.
- `char *p = "x";` points at read-only bytes; `char a[] = "x";` copies them into writable storage. The difference is the entire bug.
- Always declare pointers to literals as `const char *`, and build with `-Wwrite-strings` to enforce it.
- `const` is a compile-time promise; only static-storage `const` objects are typically protected by the hardware.

> 🧪 Practice
>
> 1. Write `char *p = "hello"; p[0] = 'H';` and run it. Then change to `char p[] = "hello";` and confirm it works. Explain both.
> 2. Print `sizeof` for a string literal, a `char[]` initialized from one, and a `char *` pointing at one. Account for every number.
> 3. Compile a file that assigns a literal to a `char *` with `-Wwrite-strings` and fix every diagnostic it produces.
> 4. Interview-style: *"Two `const char *` variables in the same file are both initialized from the literal `"x"`. Must they compare equal?"* Hint: ask what the standard requires versus what the compiler is allowed to merge.

#### Object Lifetime and Validity

**Theory**

Everything in this chapter reduces to one concept: **lifetime**. An object's lifetime is the portion of program execution during which storage is guaranteed to be reserved for it. Inside its lifetime the object has a stable address and a determinate value (once you write one). Outside it, *any* use of a pointer to it — reading, writing, comparing, even just copying the pointer value in some readings of the standard — is undefined behaviour.

C defines four storage durations, and lifetime follows directly from which one an object has:

| Storage duration | Lifetime begins | Lifetime ends | Example |
|---|---|---|---|
| **static** | before `main` | after `main` returns | globals, `static` locals |
| **thread** | thread creation | thread exit | `_Thread_local` objects |
| **automatic** | entering the block | leaving the block | ordinary locals, parameters |
| **allocated** | successful `malloc` | matching `free` | heap blocks |

The critical insight for beginners is that **a pointer does not extend a lifetime**. In a garbage-collected language, holding a reference keeps the object alive. In C, the pointer is nothing but a number; the object's lifetime is decided entirely by its storage duration, and the pointer becomes "indeterminate" the instant the lifetime ends. A pointer in that state is called **dangling**, and the language does not detect it for you.

Three subtleties trip up even experienced programmers:

**Block scope is finer than function scope.** An automatic object declared inside `{ ... }` or a `for` body dies at the closing brace, not at the function's `return`. A pointer stashed outside that block dangles immediately.

**Compound literals follow the scope they appear in.** `(struct point){1, 2}` at block scope has automatic storage duration and dies at the end of that block; at file scope it has static duration. Returning a pointer to a block-scope compound literal is the same bug as returning `&local`.

**`realloc` ends the old object's lifetime.** If it moves the block, every pointer into the old block dangles — including pointers you stored inside other structures.

The discipline that makes this manageable is to think about lifetime and *ownership* together, and to write it down. Every function that returns a pointer should document, in one line, who is responsible for the object and until when. "Returns a pointer into an internal buffer, valid until the next call" and "returns a malloc'd block the caller must free" are radically different contracts, and most memory bugs in real codebases come from a caller guessing wrong.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

struct point { int x, y; };

/* Lifetime demonstration: the inner block's object dies at its closing brace. */
void block_scope_trap(void)
{
    int *p;
    {
        int inner = 42;
        p = &inner;               /* legal here */
        printf("inside block : %d\n", *p);
    }                             /* 'inner' lifetime ENDS here */
    /* printf("%d", *p);             <- UB: p dangles, even though we are
                                         still inside the same function */
    (void)p;
}

/* Compound literals: storage duration follows the enclosing scope. */
struct point *bad_literal(void)
{
    return &(struct point){1, 2};   /* automatic: dies on return -- UB */
}

static struct point *ok_literal(void)
{
    static struct point sp = {1, 2};  /* static: valid forever */
    return &sp;
}

/* Documented contracts make lifetime a caller-visible part of the API. */

/* Returns a pointer to an internal buffer.
   VALID UNTIL: the next call to this function. Do not free. */
const char *shared_format(int n)
{
    static char buf[32];
    snprintf(buf, sizeof buf, "<%d>", n);
    return buf;
}

/* Returns a newly allocated string, or NULL on failure.
   OWNERSHIP: transferred to the caller, who must free() it. */
char *owned_format(int n)
{
    char *s = malloc(32);
    if (!s) return NULL;
    snprintf(s, 32, "<%d>", n);
    return s;
}

int main(void)
{
    block_scope_trap();

    /* The shared-buffer contract in action: the second call invalidates
       the first result, so this prints the SAME string twice. */
    const char *a = shared_format(1);
    const char *b = shared_format(2);
    printf("shared: a=%s b=%s   <- a was clobbered\n", a, b);

    char *o1 = owned_format(1);
    char *o2 = owned_format(2);
    if (o1 && o2) printf("owned : o1=%s o2=%s  <- independent\n", o1, o2);
    free(o1);
    free(o2);

    printf("ok_literal: (%d,%d)\n", ok_literal()->x, ok_literal()->y);
    return 0;
}
```

```text
   LIFETIME TIMELINE for one call to f()

   program start ----------------------------------------------> exit
   |                                                              |
   |== static objects (globals, static locals) ===================|
   |                                                              |
              |== f's frame: locals, parameters ==|
                    |== inner block object ==|
              |
              |==== malloc'd block ============================>  |
                                              |
                                            free()  <- YOU decide

   A pointer captured at any point remains a valid *pointer* only while
   the bar underneath it is still drawn. Past its end, the pointer value
   itself is indeterminate -- not merely "pointing at old data".
```

**Key Takeaways**

- Lifetime, not scope and not pointer count, decides when an object's storage is guaranteed to exist.
- The four storage durations — static, thread, automatic, allocated — each fix a lifetime you cannot negotiate with, except for allocated storage, which you control via `free`.
- Holding a pointer never extends a lifetime; when the lifetime ends, the pointer is dangling and any use is undefined behaviour.
- Automatic lifetime ends at the enclosing *block*, not the function, and block-scope compound literals follow the same rule.
- Document ownership and validity in one line above every pointer-returning function; most memory bugs are contract misunderstandings.

> 🧪 Practice
>
> 1. Write a function that saves the address of a variable declared in an inner block into an outer pointer, then reads it after the block. Run it under AddressSanitizer with `-fsanitize=address` and read the report.
> 2. Write two functions returning `const char *`: one using a static buffer, one using `malloc`. Document each contract in a comment, then write a caller that misuses both and explain the symptom.
> 3. Take a struct holding a `char *`, copy it, free through one copy, and use the other. Name the exact lifetime rule that was broken.
> 4. Interview-style: *"A function returns `&(struct point){1,2}`. Is that valid?"* Hint: compound literals have a storage duration too — ask which scope it was written in.

<a id="72-dynamic-allocation"></a>
### 7.2 Dynamic Allocation

The heap is reached through four functions declared in `<stdlib.h>`: `malloc`, `calloc`, `realloc`, and `free`. This section covers each precisely, the failure handling they demand, and the two patterns — allocating structures and growing buffers — that account for most heap code you will ever write.

#### malloc and calloc

**Theory**

`malloc(size)` asks the allocator for a block of at least `size` contiguous bytes and returns a pointer to it, or `NULL` if it cannot. That is the whole contract, but four details in it matter enormously.

**The contents are indeterminate.** `malloc` does not clear the block. Whatever bytes the allocator last had there — often data from a previously freed allocation — are what you get. Reading them before writing is undefined behaviour, not merely "getting garbage", because the compiler is entitled to assume it never happens.

**The block is suitably aligned for any object type.** The returned pointer is guaranteed to satisfy the strictest fundamental alignment on the platform (16 bytes on x86-64), so you may store any type in it. For over-aligned types — SIMD vectors, cache-line-aligned structures — use C11's `aligned_alloc(alignment, size)` or POSIX `posix_memalign`.

**The return type is `void *`, and you should not cast it.** `void *` converts implicitly to any object pointer type in C. Adding a cast is not merely redundant; before C99 it could hide a missing `<stdlib.h>` include, causing the return value to be treated as `int` and truncated. (In C++ the cast is required, which is where the habit comes from.)

**`malloc(0)` is implementation-defined**: it may return `NULL` or a unique pointer you must still `free`. Do not rely on either — treat a zero-size request as a bug in your own logic.

`calloc(count, size)` differs in two ways, and both are reasons to prefer it in specific situations:

- It **zero-initializes** the whole block. Every byte is `0`, which for integers means zero, and on every mainstream platform means `NULL` for pointers and `0.0` for IEEE floats — though the standard technically guarantees only the byte pattern.
- It **checks the multiplication for overflow**. `malloc(n * sizeof(T))` can wrap around on a large `n`, producing a small allocation followed by an enormous overflow — a well-known exploit primitive. `calloc(n, sizeof(T))` is required to detect the overflow and return `NULL`.

The zeroing is not always free: for large blocks the allocator typically gets fresh pages from the kernel that are already zeroed, making `calloc` effectively free; for small blocks it must `memset`. The overflow check, however, is always worth having.

The canonical safe allocation idiom uses `sizeof *ptr` rather than repeating the type name, so the size can never drift out of sync with the declaration:

```c
T *p = malloc(n * sizeof *p);   /* not sizeof(T) -- immune to type changes */
```

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>   /* SIZE_MAX */

int main(void)
{
    /* --- malloc: uninitialized --------------------------------------- */
    int *a = malloc(5 * sizeof *a);      /* sizeof *a, not sizeof(int) */
    if (!a) { perror("malloc"); return EXIT_FAILURE; }

    /* Reading a[i] here would be UB. Write first. */
    for (int i = 0; i < 5; i++) a[i] = i * i;

    /* --- calloc: zeroed, with an overflow-checked size ---------------- */
    int *b = calloc(5, sizeof *b);       /* all five elements are 0 */
    if (!b) { perror("calloc"); free(a); return EXIT_FAILURE; }

    printf("malloc: ");
    for (int i = 0; i < 5; i++) printf("%d ", a[i]);
    printf("\ncalloc: ");
    for (int i = 0; i < 5; i++) printf("%d ", b[i]);   /* 0 0 0 0 0 */
    putchar('\n');

    /* --- why calloc's overflow check matters -------------------------- */
    size_t huge = SIZE_MAX / sizeof(int) + 2;
    int *danger = malloc(huge * sizeof(int));  /* the product WRAPS: tiny block */
    int *safe   = calloc(huge, sizeof(int));   /* detects overflow -> NULL     */
    printf("malloc(wrapped) = %p   calloc(checked) = %p\n",
           (void *)danger, (void *)safe);
    free(danger);

    /* --- over-aligned allocation (C11) -------------------------------- */
    /* size must be a multiple of the alignment. */
    void *aligned = aligned_alloc(64, 64 * 4);
    if (aligned) {
        printf("aligned_alloc(64,...) -> %p (%% 64 == %zu)\n",
               aligned, (size_t)aligned % 64);
        free(aligned);                    /* freed with plain free() */
    }

    free(a);
    free(b);
    return 0;
}
```

| | `malloc(n)` | `calloc(c, n)` |
|---|---|---|
| Contents | indeterminate | all bytes zero |
| Overflow-checked size | no | yes |
| Cost for large blocks | cheap | usually as cheap (kernel pages arrive zeroed) |
| Cost for small blocks | cheap | extra `memset` |
| Use when | you overwrite the whole block immediately | you need zeros, or the size is a product |

```text
   WHAT malloc(24) ACTUALLY RESERVES

   returned pointer
        |
        v
   +----------+------------------------------+----------+
   | header   | your 24 usable bytes         | padding  |
   | (size,   |                              | to the   |
   |  flags)  |                              | next 16B |
   +----------+------------------------------+----------+
   ^                                                    ^
   |------------- the allocator's real chunk ----------- |

   The header sits BEHIND your pointer. Writing before p[0] or past
   p[23] corrupts allocator metadata, which is why heap overflows
   often crash later, inside free(), far from the real bug.
```

**Key Takeaways**

- `malloc` returns uninitialized memory suitably aligned for any type, or `NULL` on failure; reading before writing is undefined behaviour.
- `calloc` zero-fills and checks `count * size` for overflow — prefer it whenever the size is a product or zeros are wanted.
- Write `malloc(n * sizeof *p)`, never `sizeof(T)`, so the size follows the declaration automatically.
- Do not cast the result of `malloc` in C; the implicit `void *` conversion is correct and the cast can mask a missing header.
- Use `aligned_alloc` (C11) when you need alignment stricter than the fundamental one, and free it with ordinary `free`.

> 🧪 Practice
>
> 1. Allocate a 10-element `int` array with `malloc` and print it before writing; then do the same with `calloc` and compare. Run both under `valgrind`.
> 2. Rewrite `int *p = (int *)malloc(10 * sizeof(int));` in the safest idiomatic form and list every improvement.
> 3. Write a function `void *xmalloc_array(size_t count, size_t size)` that detects multiplication overflow itself and returns `NULL`, then verify it against `calloc`.
> 4. Interview-style: *"When is `calloc(n, size)` strictly better than `malloc(n * size)` plus `memset`?"* Hint: think about arithmetic that can wrap, and about pages the kernel has already zeroed.

#### realloc Semantics

**Theory**

`realloc(ptr, new_size)` resizes an existing allocation. It is the most useful and the most misused function in the allocation API, because its behaviour depends on circumstances you cannot observe.

The contract: `realloc` returns a pointer to a block of `new_size` bytes whose contents are the same as the old block up to the smaller of the two sizes. To do that it may either **grow the block in place** (if free space happens to follow it) or **allocate a new block, copy the data, and free the old one**. You do not get to know which happened, and you must write code that is correct either way. That single rule generates all the others:

- **The old pointer must be treated as invalid after a successful call.** If the block moved, the old pointer dangles. Any other pointer *into* the old block — an interior pointer, a cached element address, a pointer stored in another structure — also dangles.
- **On failure it returns `NULL` and leaves the original block untouched and still allocated.** This is why the classic mistake

  ```c
  p = realloc(p, n);   /* if this returns NULL, the old block is LEAKED */
  ```

  is a leak: you have overwritten the only pointer to a block that was not freed. Always assign to a temporary first.
- **New bytes when growing are uninitialized**, exactly like `malloc`.
- Two special cases fold the rest of the API into `realloc`: `realloc(NULL, n)` behaves as `malloc(n)`, and `realloc(p, 0)` is, since C23, undefined behaviour — historically it freed the block and returned `NULL` or a unique pointer, so never use it as a way to free. Call `free` instead.

Performance deserves a warning. Growing a buffer by a constant amount — `realloc(p, n + 1)` in a loop — is quadratic, because most calls copy the entire buffer. Growth must be **geometric**: multiply the capacity (typically by 1.5 or 2) so that the amortized cost per element is constant. This is exactly what `std::vector`, Python lists, and Go slices do internally, and it is covered in detail under *Growable Buffers*.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    size_t cap = 4;
    int *a = malloc(cap * sizeof *a);
    if (!a) return EXIT_FAILURE;
    for (size_t i = 0; i < cap; i++) a[i] = (int)i;

    printf("before: ptr=%p cap=%zu\n", (void *)a, cap);

    /* CORRECT resize: assign to a temporary so a failure does not lose 'a'. */
    size_t new_cap = cap * 2;
    int *tmp = realloc(a, new_cap * sizeof *a);
    if (!tmp) {
        free(a);                 /* 'a' is still valid: clean up properly */
        return EXIT_FAILURE;
    }
    a = tmp;                     /* commit only after success */
    cap = new_cap;

    /* The new bytes are UNINITIALIZED -- fill them before reading. */
    for (size_t i = 4; i < cap; i++) a[i] = (int)i;

    printf("after : ptr=%p cap=%zu  (same address or not -- you cannot know)\n",
           (void *)a, cap);
    for (size_t i = 0; i < cap; i++) printf("%d ", a[i]);
    putchar('\n');

    /* THE INTERIOR-POINTER TRAP -------------------------------------- */
    int *third = &a[2];                    /* cached pointer into the block */
    tmp = realloc(a, cap * 4 * sizeof *a); /* may MOVE the block */
    if (tmp) {
        a = tmp;
        /* printf("%d", *third);   <- UB if the block moved: 'third'
                                      points into the freed old block. */
        third = &a[2];                     /* recompute AFTER every realloc */
        printf("recomputed third = %d\n", *third);
    }

    /* realloc(NULL, n) == malloc(n): lets one code path handle first use. */
    int *fresh = realloc(NULL, 8 * sizeof *fresh);
    free(fresh);

    free(a);
    return 0;
}
```

```text
   CASE 1: grown IN PLACE (free space followed the block)

   before:  [ 0 1 2 3 ][ free space  ]
                 ^ a
   after:   [ 0 1 2 3 | ? ? ? ? ]
                 ^ a   (same address; old pointer still happens to work)

   CASE 2: MOVED (no room to grow)

   before:  [ 0 1 2 3 ][ other allocation ]
                 ^ a
   after:   [  freed  ][ other allocation ] ...... [ 0 1 2 3 | ? ? ? ? ]
                 ^ a (DANGLING)                         ^ returned pointer

   Your code cannot tell the two cases apart, so it must be written for
   CASE 2 always: reassign the pointer, and recompute every pointer that
   aimed into the old block.
```

**Key Takeaways**

- `realloc` may grow in place or move the block; correct code assumes it moved and uses only the returned pointer.
- Never write `p = realloc(p, n)` — a `NULL` return leaks the still-valid original. Use a temporary and commit on success.
- Every pointer into the old block, including interior and stored pointers, is invalidated by a successful `realloc`.
- Bytes added when growing are uninitialized; `realloc(NULL, n)` is `malloc(n)`; `realloc(p, 0)` is not a way to free.
- Grow geometrically, not by a constant, or the total cost of building a buffer becomes quadratic.

> 🧪 Practice
>
> 1. Build an array by `realloc`-ing one element at a time to 100,000 elements, printing the pointer whenever it changes. Count the moves.
> 2. Time the previous loop against a doubling strategy for one million elements and report the ratio.
> 3. Write a resize helper `int grow(int **buf, size_t *cap)` that returns `0`/`-1` and never leaks on failure; use it in a loop.
> 4. Interview-style: *"What is wrong with `p = realloc(p, size);`?"* Hint: describe the state of the heap and of `p` in the failure branch.

#### free and Ownership

**Theory**

`free(ptr)` returns a block to the allocator. Its contract is short and unforgiving:

- The pointer must be **exactly** what a previous `malloc`, `calloc`, `realloc`, or `aligned_alloc` returned — not an interior pointer, not an adjusted one.
- Each block must be freed **at most once**. A second `free` is undefined behaviour and, on modern allocators, a classic exploitation primitive.
- `free(NULL)` is **guaranteed to do nothing**. This is a genuine convenience: cleanup paths never need `if (p)` guards.
- After `free`, the pointer's value is indeterminate. Using it is undefined behaviour; so, formally, is even reading it.

Notice what `free` does *not* do: it does not modify your pointer variable (it cannot, it receives a copy), it does not zero the memory, and it usually does not return anything to the operating system — the allocator keeps the block on a free list for reuse, which is why a process's resident size rarely shrinks after freeing.

The hard part of `free` is not the call, it is deciding **who calls it**. C has no destructors and no garbage collector, so ownership is a convention your code must express and your documentation must state. Three conventions cover nearly everything:

1. **The allocator frees.** The function that allocates also frees, and callers only borrow. Simple and safe, but limits the object's lifetime.
2. **Ownership transfers to the caller.** A "constructor" returns a pointer that the caller must eventually `free` — or, better, pass to a matching destructor.
3. **A container owns its elements.** The container's destroy function frees each element. Callers must not free elements they merely obtained a pointer to.

The practical discipline that makes this work is **paired create/destroy functions**. Instead of exposing `malloc` and `free` at the API boundary, expose `thing_create` and `thing_destroy`. The destroy function knows the internal structure, frees members in the right order, and can be extended later (adding a new heap member requires no change at any call site). Setting the pointer to `NULL` after freeing — often via a small macro or a destroy function taking `Thing **` — turns a would-be use-after-free into a clean `NULL` dereference that crashes immediately at the real location.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char   *name;     /* owned: allocated separately */
    int    *scores;   /* owned */
    size_t  n;
} Student;

/* Constructor: returns ownership to the caller, or NULL on failure.
   Cleans up partial allocations so a failure never leaks. */
Student *student_create(const char *name, size_t n)
{
    Student *s = calloc(1, sizeof *s);      /* zeroed: members start NULL */
    if (!s) return NULL;

    s->name = malloc(strlen(name) + 1);
    if (!s->name) goto fail;                /* single cleanup path */
    strcpy(s->name, name);

    s->scores = calloc(n, sizeof *s->scores);
    if (!s->scores) goto fail;
    s->n = n;
    return s;

fail:
    free(s->name);                          /* free(NULL) is safe */
    free(s);
    return NULL;
}

/* Destructor: frees members first, then the struct. Takes Student**
   so it can NULL the caller's pointer -- no dangling pointer survives. */
void student_destroy(Student **sp)
{
    if (!sp || !*sp) return;
    free((*sp)->name);
    free((*sp)->scores);
    free(*sp);
    *sp = NULL;              /* the caller's variable is now safely NULL */
}

int main(void)
{
    Student *s = student_create("Ada", 3);
    if (!s) return EXIT_FAILURE;

    s->scores[0] = 95;
    printf("%s scored %d\n", s->name, s->scores[0]);

    student_destroy(&s);
    printf("after destroy, s = %p\n", (void *)s);   /* (nil) */

    student_destroy(&s);   /* idempotent: safe because s is NULL */

    /* free(NULL) is always a no-op -- cleanup code needs no guards. */
    char *never_allocated = NULL;
    free(never_allocated);
    return 0;
}
```

```text
   OWNERSHIP OF A Student

   Student *s ---> +----------------+
                   | name   o-------+---> "Ada\0"       (owned block 2)
                   | scores o-------+---> [95][0][0]    (owned block 3)
                   | n = 3          |
                   +----------------+   (owned block 1)

   student_destroy must free 2 and 3 BEFORE 1 -- once block 1 is freed,
   the pointers to 2 and 3 are unreachable and the memory is leaked.
   Freeing "outside-in" is one of the most common leak patterns.
```

**Key Takeaways**

- `free` requires the exact pointer returned by the allocator, exactly once; `free(NULL)` is always a safe no-op.
- Freeing does not change your pointer variable, does not clear the memory, and usually does not return pages to the OS.
- Ownership is a convention, not a language feature — document for every pointer who frees it and when.
- Prefer paired `x_create`/`x_destroy` functions over raw `malloc`/`free` at API boundaries.
- Free inner members before the containing struct, and have destroy take a `T **` so it can null the caller's pointer.

> 🧪 Practice
>
> 1. Implement `create`/`destroy` for a struct with two heap members and verify with `valgrind --leak-check=full` that nothing leaks.
> 2. Deliberately free the struct before its members, run under Valgrind, and interpret the "definitely lost" report.
> 3. Write a `SAFE_FREE(p)` macro that frees and nulls in one statement (use the `do { } while (0)` idiom from Chapter 8.3) and explain what it cannot protect against.
> 4. Interview-style: *"After `free(p)`, why is setting `p = NULL` recommended but not sufficient?"* Hint: consider every other variable that may hold the same address.

#### Checking Allocation Failure

**Theory**

`malloc` can return `NULL`. The question is what your program should do about it, and the answer is genuinely different depending on the kind of program you are writing — which is why this deserves its own topic rather than a line of boilerplate.

First, when does allocation actually fail? Less often than you might think on Linux, which by default **overcommits**: the kernel grants address space optimistically and only allocates physical pages on first touch, so `malloc` succeeds and the process may later be killed by the OOM killer instead. But failure is entirely real when the request is huge or corrupted by an integer overflow, when a 32-bit process exhausts its 4 GB address space, when `RLIMIT_AS` or a container memory limit is in force, or on embedded systems with no virtual memory at all. Attacker-controlled sizes are the common thread in the security-relevant cases.

Second, what should happen on failure? Three strategies, each appropriate somewhere:

| Strategy | Shape | Fits |
|---|---|---|
| **Abort** | check, print, `exit(EXIT_FAILURE)` | command-line tools, batch jobs |
| **Propagate** | return `NULL`/`-1` up the call chain | libraries, reusable modules |
| **Recover** | free caches, retry, degrade | long-running servers, databases, embedded |

Whichever you choose, the checking itself is non-negotiable, because an unchecked `NULL` does not stay a local problem: `strcpy(NULL, s)` or `p->field = 1` on a null pointer is a crash at best and, when the offset is large enough to land on a mapped page, memory corruption at worst.

The pattern that keeps abort-style code readable is a small wrapper, conventionally named `xmalloc`, that never returns `NULL`. It removes the check from every call site while keeping the behaviour explicit in one place. For libraries the opposite discipline applies: never call `exit` from library code — return an error and let the application decide.

The genuinely difficult part is **cleaning up correctly when a failure happens halfway through a multi-step construction**. C's answer is the `goto` cleanup ladder: a single set of labels in reverse allocation order, each falling through to the next. It is one of the few places where `goto` is unambiguously the clearest tool, and it is standard practice throughout the Linux kernel.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

/* Strategy 1: abort. Never returns NULL, so call sites stay clean.
   Appropriate for applications, NEVER for library code. */
void *xmalloc(size_t n)
{
    void *p = malloc(n);
    if (!p) {
        fprintf(stderr, "fatal: out of memory allocating %zu bytes\n", n);
        exit(EXIT_FAILURE);
    }
    return p;
}

/* Strategy 2: propagate, with a goto cleanup ladder.
   Labels appear in REVERSE allocation order and fall through. */
struct resource {
    char *buf_a;
    char *buf_b;
    FILE *fp;
};

int resource_init(struct resource *r, const char *path, size_t n)
{
    r->buf_a = NULL; r->buf_b = NULL; r->fp = NULL;

    r->buf_a = malloc(n);
    if (!r->buf_a) goto err;                 /* nothing acquired yet */

    r->buf_b = malloc(n);
    if (!r->buf_b) goto err_free_a;

    r->fp = fopen(path, "r");
    if (!r->fp) goto err_free_b;

    return 0;                                 /* success: keep everything */

err_free_b:
    free(r->buf_b);
    r->buf_b = NULL;
err_free_a:
    free(r->buf_a);
    r->buf_a = NULL;
err:
    return -1;                                /* caller decides what to do */
}

/* Strategy 3: recover -- shed a cache and retry once. */
static char *cache = NULL;

void *malloc_or_shrink(size_t n)
{
    void *p = malloc(n);
    if (!p && cache) {
        free(cache);                          /* release reclaimable memory */
        cache = NULL;
        p = malloc(n);                        /* one retry */
    }
    return p;                                 /* still may be NULL */
}

int main(void)
{
    char *s = xmalloc(32);
    strcpy(s, "checked at one place");
    puts(s);
    free(s);

    struct resource r;
    if (resource_init(&r, "/nonexistent", 128) != 0)
        fprintf(stderr, "init failed cleanly, nothing leaked\n");

    /* A request large enough to fail even with overcommit. */
    void *huge = malloc((size_t)-1 / 2);
    printf("huge malloc -> %s\n", huge ? "succeeded" : "NULL (as expected)");
    free(huge);
    return 0;
}
```

```text
   THE goto CLEANUP LADDER

   acquire A ---> acquire B ---> acquire C ---> return 0 (success)
       |              |              |
       | fail         | fail         | fail
       v              v              v
      err        err_free_a     err_free_b
                      ^              |
                      +--------------+   (falls through, releasing
                      |                   resources newest-first)
                      v
                   return -1

   One exit path per acquisition point, each releasing exactly what was
   already acquired. Adding a fourth resource means adding one label,
   not editing four error branches.
```

**Key Takeaways**

- Always check the result of every allocation; an unchecked `NULL` becomes a crash or a corruption far from the real cause.
- Choose a strategy deliberately: abort in applications, propagate errors in libraries, recover in long-running or embedded systems.
- Library code must never call `exit` — return an error code and let the application decide.
- An `xmalloc`-style wrapper concentrates abort-on-failure logic in one place and keeps call sites readable.
- Use a `goto` cleanup ladder for multi-step initialization so partial failures release exactly what was acquired, in reverse order.

> 🧪 Practice
>
> 1. Write `xmalloc` and `xcalloc`, use them in a small program, and force failure with `ulimit -v 10000` to see the message.
> 2. Write a function that allocates three buffers and opens a file, using a `goto` ladder, then verify with Valgrind that each failure point leaks nothing.
> 3. Wrap `malloc` with a version that fails randomly one time in ten, run your program repeatedly, and fix every crash it exposes.
> 4. Interview-style: *"Why does `malloc` almost never return `NULL` on Linux even when memory is exhausted?"* Hint: name the kernel policy involved and the process that cleans up afterwards.

#### Allocating Structs and Arrays

**Theory**

Two shapes account for most heap use: a single structure, and an array of elements. Both are straightforward once a few idioms are internalized.

**A single struct.** `T *p = malloc(sizeof *p);` allocates exactly one. Using `sizeof *p` rather than `sizeof(T)` means changing the declared type requires no edit here — a small habit that prevents a serious class of bug. If the struct has pointer members, `calloc(1, sizeof *p)` is often better, because it starts every member `NULL`, which makes a cleanup path safe even after a partial failure.

**An array.** `T *a = malloc(n * sizeof *a);` gives `n` contiguous elements you index normally: `a[i]`. This is exactly the layout of a real array, so pointer arithmetic, `memcpy`, and functions taking `T *` all work unchanged. Guard the multiplication: use `calloc(n, sizeof *a)` or check `n <= SIZE_MAX / sizeof *a` first.

**Arrays of structs versus arrays of pointers.** This is a genuine design decision:

| | `T *arr` (array of structs) | `T **arr` (array of pointers) |
|---|---|---|
| Allocations | 1 | 1 + n |
| Memory locality | excellent — one contiguous run | poor — each element elsewhere |
| Element size | must be uniform and known | may vary (polymorphism) |
| Moving/growing | copies whole elements | copies pointers only |
| Cleanup | one `free` | loop, then free the array |

For plain data, the contiguous array wins decisively on performance. Arrays of pointers earn their keep when elements are large, must not move, or are of varying concrete types.

**2D arrays** have three usual encodings. The flat one — a single block of `rows * cols` with manual index arithmetic `a[r * cols + c]` — is one allocation, cache-friendly, and the one to reach for by default. The array-of-row-pointers gives `a[r][c]` syntax at the cost of `rows + 1` allocations and an extra indirection per access. C99's pointer-to-VLA (`int (*a)[cols] = malloc(rows * sizeof *a);`) gives you both: one allocation *and* `a[r][c]` syntax, when the column count is a run-time value.

Finally, the **flexible array member** (C99) lets a struct end with an unsized array so that a header and its payload live in one allocation — one `malloc`, one `free`, and perfect locality. It is the idiomatic way to represent a variable-length record in modern C.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct { int x, y; } Point;

/* Flexible array member: header and payload in ONE allocation. */
typedef struct {
    size_t len;
    char   data[];       /* C99 FAM: must be last, has no size of its own */
} Buffer;

Buffer *buffer_create(size_t len)
{
    Buffer *b = malloc(sizeof *b + len);     /* header + payload together */
    if (!b) return NULL;
    b->len = len;
    memset(b->data, 0, len);
    return b;                                 /* one block -> one free() */
}

int main(void)
{
    /* --- one struct ---------------------------------------------------- */
    Point *p = malloc(sizeof *p);            /* sizeof *p, not sizeof(Point) */
    if (!p) return EXIT_FAILURE;
    *p = (Point){3, 4};
    printf("point (%d,%d)\n", p->x, p->y);
    free(p);

    /* --- contiguous array of structs (preferred for plain data) -------- */
    size_t n = 4;
    Point *arr = calloc(n, sizeof *arr);     /* overflow-checked product */
    if (!arr) return EXIT_FAILURE;
    for (size_t i = 0; i < n; i++) arr[i] = (Point){(int)i, (int)i * 2};
    printf("arr[2] = (%d,%d)  stride = %zu bytes\n",
           arr[2].x, arr[2].y, sizeof *arr);
    free(arr);                                /* ONE free for all elements */

    /* --- array of pointers: n+1 allocations, n+1 frees ---------------- */
    Point **parr = calloc(n, sizeof *parr);
    if (!parr) return EXIT_FAILURE;
    for (size_t i = 0; i < n; i++) {
        parr[i] = malloc(sizeof **parr);
        if (!parr[i]) break;
        *parr[i] = (Point){(int)i, 0};
    }
    for (size_t i = 0; i < n; i++) free(parr[i]);   /* elements first */
    free(parr);                                     /* then the array  */

    /* --- 2D, flat: one allocation, manual indexing -------------------- */
    size_t rows = 3, cols = 4;
    int *grid = calloc(rows * cols, sizeof *grid);
    if (!grid) return EXIT_FAILURE;
    grid[1 * cols + 2] = 99;                  /* row 1, column 2 */
    printf("grid[1][2] = %d\n", grid[1 * cols + 2]);
    free(grid);

    /* --- 2D via pointer-to-VLA (C99): one allocation AND a[r][c] ------ */
    int (*vla)[cols] = malloc(rows * sizeof *vla);
    if (vla) {
        vla[1][2] = 77;
        printf("vla[1][2]  = %d\n", vla[1][2]);
        free(vla);
    }

    /* --- flexible array member ---------------------------------------- */
    Buffer *b = buffer_create(16);
    if (b) {
        strcpy(b->data, "one allocation");
        printf("%s (len=%zu)\n", b->data, b->len);
        free(b);                              /* frees header and payload */
    }
    return 0;
}
```

```text
   ARRAY OF STRUCTS                 ARRAY OF POINTERS

   arr -> [x y][x y][x y][x y]      parr -> [p0][p1][p2][p3]
          one contiguous block                |   |   |   |
          1 malloc, 1 free                    v   v   v   v
          sequential scan = 1 cache        [x y][x y] ... scattered
          line per few elements            5 mallocs, 5 frees
                                           a pointer chase per element

   FLEXIBLE ARRAY MEMBER

   Buffer *b -> +--------+---------------------------+
                | len    | data[len]                 |   ONE block
                +--------+---------------------------+
                sizeof *b        len bytes
```

**Key Takeaways**

- Use `malloc(sizeof *p)` for one object and `calloc(n, sizeof *a)` for `n` — both track the declaration and the latter checks the product.
- A contiguous array of structs beats an array of pointers for plain data: fewer allocations, one free, far better locality.
- Flat 2D arrays with `a[r * cols + c]` are the safe default; pointer-to-VLA gives `a[r][c]` syntax with a single allocation.
- With arrays of pointers, free the elements before the array itself, or the element blocks become unreachable.
- A flexible array member packs a header and a variable-length payload into one allocation with one matching `free`.

> 🧪 Practice
>
> 1. Allocate an array of 1000 `Point` structs and an array of 1000 `Point *`, fill both, and compare the total number of `malloc` calls and the time to sum all `x` values.
> 2. Implement a 2D matrix three ways (flat, row pointers, pointer-to-VLA) with matching create/destroy functions, and verify all three with Valgrind.
> 3. Write a `Packet` struct with a flexible array member holding a payload, plus create/destroy functions, and confirm one allocation per packet.
> 4. Interview-style: *"You need one million small records that are scanned repeatedly. Array of structs or array of pointers?"* Hint: count allocations, then count cache lines touched per pass.

#### Growable Buffers

**Theory**

The dynamic array — a buffer that grows as you append — is the most useful data structure in C and the one every C programmer eventually writes. Getting it right teaches the whole allocation API at once.

The structure holds three things: a pointer to the elements, the number of elements in use (`len`), and the number of elements the block can hold (`cap`). The invariant `len <= cap` is what makes appending cheap: most appends just write at `data[len++]`, and only when `len == cap` does the buffer grow.

**Why growth must be geometric.** Suppose you grow by one element each time. Appending *n* elements performs *n* reallocations, and each one may copy the entire buffer, giving `1 + 2 + ... + n = O(n^2)` element copies. Now suppose you double: growth happens only at capacities 1, 2, 4, 8, ..., and the total copying is `1 + 2 + 4 + ... + n < 2n` — linear overall, so **amortized O(1) per append**. The difference for a million appends is roughly a trillion operations versus two million.

The growth factor is a real trade-off. Doubling wastes up to 50% of the allocated space in the worst case but reallocates rarely. A factor of 1.5 wastes less and has a theoretical advantage: the sum of previous blocks can eventually exceed the next request, letting the allocator reuse freed space, which doubling never allows. Most C code uses 2 for simplicity; `cap = cap + cap / 2` is the 1.5 version.

Three details separate a toy implementation from a correct one:

- **Overflow.** `cap * 2 * sizeof(T)` can wrap on 32-bit systems or with an attacker-controlled length. Check before multiplying.
- **Failure safety.** A failed `realloc` must leave the vector exactly as it was — same pointer, same length, same capacity — so the caller can handle the error and keep using it.
- **Pointer invalidation.** Every append can move the buffer, so any pointer or index-derived pointer obtained before an append may dangle afterwards. Indices survive reallocation; pointers do not. This is the same rule that makes C++ iterator invalidation famous, and it is why storing indices is often the better design.

When you know the final size in advance, calling a `reserve` function once eliminates all intermediate reallocation and copying — the single cheapest optimization available for this structure.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>   /* SIZE_MAX */

typedef struct {
    int    *data;
    size_t  len;      /* elements in use          */
    size_t  cap;      /* elements the block holds */
} Vec;

/* Ensure room for at least 'want' elements. Returns 0 on success, -1 on
   failure WITHOUT disturbing the existing contents. */
static int vec_reserve(Vec *v, size_t want)
{
    if (want <= v->cap) return 0;

    size_t new_cap = v->cap ? v->cap : 4;
    while (new_cap < want) {
        /* Overflow guards BEFORE the arithmetic that could wrap. */
        if (new_cap > SIZE_MAX / 2) return -1;
        new_cap *= 2;                                  /* geometric growth */
    }
    if (new_cap > SIZE_MAX / sizeof *v->data) return -1;

    int *tmp = realloc(v->data, new_cap * sizeof *v->data);
    if (!tmp) return -1;          /* v is untouched: still perfectly usable */

    v->data = tmp;                /* commit only after success */
    v->cap  = new_cap;
    return 0;
}

static int vec_push(Vec *v, int value)
{
    if (vec_reserve(v, v->len + 1) != 0) return -1;
    v->data[v->len++] = value;
    return 0;
}

static void vec_free(Vec *v)
{
    free(v->data);
    v->data = NULL;               /* leave the struct in a reusable state */
    v->len = v->cap = 0;
}

int main(void)
{
    Vec v = {0};                  /* NULL, 0, 0 -- realloc(NULL,n) == malloc */
    size_t last_cap = 0;

    for (int i = 0; i < 20; i++) {
        if (vec_push(&v, i * i) != 0) { vec_free(&v); return EXIT_FAILURE; }
        if (v.cap != last_cap) {                 /* observe the growth curve */
            printf("len=%2zu grew to cap=%2zu at %p\n", v.len, v.cap, (void *)v.data);
            last_cap = v.cap;
        }
    }

    printf("contents:");
    for (size_t i = 0; i < v.len; i++) printf(" %d", v.data[i]);
    putchar('\n');

    /* THE INVALIDATION RULE: indices survive growth, pointers do not. */
    int *third_ptr = &v.data[2];
    size_t third_idx = 2;
    vec_push(&v, 999);                   /* may move the whole block */
    /* printf("%d", *third_ptr);            <- UB if the block moved */
    printf("by index (always safe): %d\n", v.data[third_idx]);
    (void)third_ptr;

    /* Knowing the size up front removes every intermediate copy. */
    Vec big = {0};
    if (vec_reserve(&big, 1000000) == 0) {
        for (int i = 0; i < 1000000; i++) big.data[big.len++] = i;
        printf("filled %zu elements with ONE allocation\n", big.len);
    }
    vec_free(&big);
    vec_free(&v);
    return 0;
}
```

```text
   DOUBLING: total copies stay linear

   cap:  4        8            16                  32
        [....]  [........]   [................]  [...............]
   copy:  -       4            8                  16          = 28 copies
                                                                for 32 pushes

   GROWING BY ONE: total copies are quadratic

   cap:  1  2  3  4  5 ... 32
   copy: 0 +1 +2 +3 +4 ... +31                                = 496 copies
                                                                for 32 pushes

   At 1,000,000 pushes the gap is ~2 million versus ~500 billion copies.
```

**Key Takeaways**

- A growable buffer is `data` + `len` + `cap` with the invariant `len <= cap`; only a full buffer triggers a reallocation.
- Growth must be geometric (typically 1.5x or 2x) for amortized O(1) appends; growing by a constant is quadratic.
- Check capacity arithmetic for overflow before multiplying, especially when the length is attacker-influenced.
- On `realloc` failure, leave the structure untouched so the caller can recover; commit the new pointer only after success.
- Any append may move the buffer: store indices rather than pointers, and call `reserve` up front when the size is known.

> 🧪 Practice
>
> 1. Implement `Vec` with `push`, `pop`, `get`, and `free`, printing the capacity every time it changes for 100 pushes.
> 2. Add a growth-factor parameter and measure total time and peak memory for 1.5x versus 2x over ten million appends.
> 3. Make `vec_push` fail on the tenth call (via a fake allocator) and prove with assertions that `len`, `cap`, and the contents are unchanged.
> 4. Interview-style: *"Why do dynamic arrays double instead of growing by a fixed amount?"* Hint: total the copies for both strategies over n appends and compare the growth rates.

<a id="73-memory-errors"></a>
### 7.3 Memory Errors

Memory bugs are C's defining hazard: they are easy to write, often symptom-free for a long time, and responsible for the majority of serious security vulnerabilities in C code. This section catalogues the six classic errors, shows what each looks like, and pairs every one with the tool that finds it automatically.

#### Memory Leaks

**Theory**

A memory leak is allocated memory that is no longer reachable but has not been freed. The block stays reserved for the process's whole lifetime because nothing holds its address any more, so nothing can ever free it.

Leaks are the mildest memory bug in the sense that they do not corrupt anything — a leaking program produces correct output. That mildness is also why they are dangerous: a short-lived program's leaks are invisible (the OS reclaims everything at exit), so leaky habits go unnoticed until the same code runs inside a server that serves requests for weeks. There the leak becomes memory exhaustion, then swapping, then an OOM kill.

The recurring causes are worth memorizing, because they are recognizable patterns rather than random mistakes:

- **Overwriting the only pointer.** `p = malloc(...)` twice without an intervening `free`.
- **`p = realloc(p, n)` on failure**, discussed earlier: the original block is still allocated and its address is gone.
- **Early returns.** A function with one `malloc` and four `return` statements typically frees on only one of them. This is the leak the `goto` cleanup ladder exists to eliminate.
- **Losing a container's contents.** Freeing an array of pointers without freeing the elements; freeing a struct before its heap members; forgetting to walk a linked list.
- **Error paths nobody tests.** The success path is exercised constantly and the failure path almost never, so that is where leaks accumulate.

A related and more insidious problem is the **logical leak**: memory that is still reachable but will never be used again — an unbounded cache, a list of completed jobs nobody removes, an event log that only grows. Leak detectors report nothing because the pointers are live. Only monitoring resident memory over time reveals it.

Detection is fully automated and you should never hunt for a leak by reading code first. Valgrind's Memcheck reports leaks with the allocating stack trace, and LeakSanitizer (bundled with AddressSanitizer) does the same much faster.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* LEAK 1: the only pointer to the first block is overwritten. */
void leak_overwrite(void)
{
    char *p = malloc(100);
    p = malloc(200);          /* the 100-byte block is now unreachable */
    free(p);                  /* frees only the second */
}

/* LEAK 2: an early return skips the cleanup. */
int leak_early_return(int n)
{
    int *buf = malloc(n * sizeof *buf);
    if (!buf) return -1;
    if (n > 100) return -2;   /* LEAK: 'buf' is never freed on this path */
    free(buf);
    return 0;
}

/* FIXED: one exit path, cleanup guaranteed. */
int no_leak(int n)
{
    int rc = 0;
    int *buf = malloc(n * sizeof *buf);
    if (!buf) return -1;
    if (n > 100) { rc = -2; goto out; }
    /* ... work ... */
out:
    free(buf);
    return rc;
}

/* LEAK 3: freeing the container but not its contents. */
void leak_container(void)
{
    char **rows = malloc(3 * sizeof *rows);
    for (int i = 0; i < 3; i++) {
        rows[i] = malloc(32);
        snprintf(rows[i], 32, "row %d", i);
    }
    free(rows);               /* the three 32-byte blocks are lost */
}

/* FIXED: elements first, container second. */
void no_leak_container(void)
{
    char **rows = malloc(3 * sizeof *rows);
    if (!rows) return;
    for (int i = 0; i < 3; i++) rows[i] = malloc(32);
    for (int i = 0; i < 3; i++) free(rows[i]);   /* inside-out */
    free(rows);
}

int main(void)
{
    leak_overwrite();
    leak_early_return(200);
    leak_container();
    no_leak(200);
    no_leak_container();
    return 0;
}
```

Finding them takes one command:

```bash
$ gcc -g -O0 leaks.c -o leaks
$ valgrind --leak-check=full --show-leak-kinds=all ./leaks
==12345== HEAP SUMMARY:
==12345==     in use at exit: 996 bytes in 5 blocks
==12345== 100 bytes in 1 blocks are definitely lost in loss record 1 of 3
==12345==    at 0x4C2FB0F: malloc (vg_replace_malloc.c:299)
==12345==    by 0x40064B: leak_overwrite (leaks.c:7)      <- exact line
==12345==    by 0x4006F2: main (leaks.c:56)

# Faster alternative, built into the compiler:
$ gcc -g -fsanitize=address leaks.c -o leaks && ./leaks
# ==12345==ERROR: LeakSanitizer: detected memory leaks
```

| Valgrind category | Meaning |
|---|---|
| **definitely lost** | no pointer to the block exists — a real leak, fix it |
| **indirectly lost** | reachable only from a definitely-lost block (e.g. list nodes) |
| **possibly lost** | only an interior pointer remains — usually a real leak |
| **still reachable** | a pointer exists at exit; not a leak, but often untidy |

**Key Takeaways**

- A leak is unreachable allocated memory; it never corrupts data, which is exactly why it survives testing and kills long-running processes.
- The usual causes are overwritten pointers, untested early-return paths, and containers freed without their contents.
- Free inside-out: elements before the container, members before the struct.
- Logical leaks (reachable but never reused, such as unbounded caches) are invisible to leak detectors — watch resident memory over time.
- Run `valgrind --leak-check=full` or build with `-fsanitize=address` routinely; never hunt leaks by reading code first.

> 🧪 Practice
>
> 1. Write a program with three distinct leaks and find all of them with Valgrind, mapping each report to its source line.
> 2. Refactor a function with four `return` statements and two allocations into a single-exit `goto` ladder, and prove with Valgrind that no path leaks.
> 3. Build a linked list of 1000 nodes, free only the head, and explain the "indirectly lost" figure in the report.
> 4. Interview-style: *"A server's memory grows steadily but the leak checker reports nothing. What is happening?"* Hint: distinguish unreachable memory from memory that is reachable but never used again.

#### Dangling Pointers and Use-After-Free

**Theory**

A **dangling pointer** holds the address of an object whose lifetime has ended. Dereferencing one is a **use-after-free** (or use-after-scope for stack objects), and it is among the most severe bugs in C — severe because of how it behaves, not just because it is wrong.

The behaviour is what makes it dangerous. Freed memory is not erased and not unmapped; the allocator keeps it on a free list for reuse. So a use-after-free typically:

1. **Works perfectly at first.** The bytes are still there. Tests pass.
2. **Starts returning wrong data** once that block is handed out to a different allocation and overwritten.
3. **Corrupts unrelated state** if you *write* through the dangling pointer, damaging whatever now owns those bytes — including allocator metadata.

The symptom therefore appears far away in space and time from the cause, which is why these bugs consume days of debugging. In security terms, an attacker who can control which allocation reuses the freed block ("heap grooming") can turn a use-after-free into arbitrary code execution; this class is behind a large share of browser and kernel exploits.

Dangling pointers arise in five recognizable ways:

- Using a pointer after `free`.
- Keeping a second copy of a pointer and freeing through the first (aliasing).
- Returning or storing the address of a local variable.
- Using an interior pointer after `realloc` moved the block.
- Holding a pointer to an element of a container that was resized or destroyed.

The defences are layered. **Null after free** — ideally through a destroy function taking `T **` — converts a silent use-after-free into an immediate, obvious `NULL` dereference at the correct location. It does not help with aliases, which is why the second defence is **single, documented ownership**: one owner per object, and borrowers that never outlive the owner. The third is tooling: AddressSanitizer quarantines freed blocks and poisons them so any access reports instantly, with both the allocation and the free stack traces.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    /* --- classic use-after-free --------------------------------------- */
    char *p = malloc(32);
    strcpy(p, "still here");
    free(p);
    /* printf("%s\n", p);      <- UB. Often prints correctly, which is the
                                  worst possible outcome: it hides the bug. */

    /* The block gets reused, and the "old" data silently changes. */
    char *q = malloc(32);           /* very likely the SAME address as p */
    strcpy(q, "different data");
    printf("p == q ? %s\n", (void *)p == (void *)q ? "yes -- reused" : "no");

    /* --- the aliasing trap: nulling one copy does not help ------------ */
    char *owner = malloc(16);
    char *alias = owner;            /* second pointer to the same block   */
    free(owner);
    owner = NULL;                   /* only THIS variable is now safe     */
    /* alias[0] = 'x';                 <- still dangling: UB              */
    (void)alias;

    /* --- use-after-scope ---------------------------------------------- */
    int *dangler;
    {
        int local = 5;
        dangler = &local;
    }                               /* 'local' lifetime ends here */
    /* printf("%d\n", *dangler);      <- UB; the slot is reused by the
                                         next call made from this frame */
    (void)dangler;

    free(q);
    return 0;
}
```

A destroy function that nulls the caller's pointer removes the most common case entirely:

```c
void thing_destroy(Thing **t)
{
    if (!t || !*t) return;
    free((*t)->buf);
    free(*t);
    *t = NULL;              /* the caller's variable cannot dangle */
}
```

```bash
$ gcc -g -fsanitize=address uaf.c -o uaf && ./uaf
==4242==ERROR: AddressSanitizer: heap-use-after-free on address 0x602000000010
READ of size 1 at 0x602000000010 thread T0
    #0 0x4f2a1b in main uaf.c:12                <- where you used it
0x602000000010 is located 0 bytes inside of 32-byte region
freed by thread T0 here:
    #1 0x4f29c4 in main uaf.c:11                <- where you freed it
previously allocated by thread T0 here:
    #2 0x4f2986 in main uaf.c:9                 <- where you allocated it
```

Three stack traces in one report — use, free, and allocation — is why AddressSanitizer turns a multi-day hunt into a two-minute fix.

```text
   TIMELINE OF A USE-AFTER-FREE

   malloc -> [ "still here" ]      p valid
                  ^ p
   free   -> [ "still here" ]      p DANGLING (bytes unchanged: the trap)
                  ^ p                          allocator owns the block
   malloc -> [ "different data" ]  p aliases someone else's object
                  ^ p ^ q
   *p = 'X' -> corrupts q's object, and the crash appears in q's code,
               possibly minutes later, with no trace of the real culprit.
```

**Key Takeaways**

- A dangling pointer refers to an object whose lifetime has ended; using it is undefined behaviour with delayed, misleading symptoms.
- Freed memory keeps its contents until reused, so a use-after-free often appears to work — the most dangerous failure mode there is.
- Writing through a dangling pointer corrupts whatever now owns the block, including allocator metadata, and is a prime exploitation target.
- Null the pointer after freeing, preferably inside a destroy function taking `T **`; note this does not protect aliases.
- AddressSanitizer reports use, free, and allocation stack traces together — make it your default debug build.

> 🧪 Practice
>
> 1. Free a buffer, allocate another the same size, and show that the first pointer now aliases the second allocation.
> 2. Write a `destroy(T **)` function that nulls the caller's pointer, then demonstrate an alias it still cannot protect.
> 3. Build the same program with and without `-fsanitize=address` and compare what each run reports.
> 4. Interview-style: *"Why is use-after-free considered more dangerous than a memory leak?"* Hint: compare what each one does to data owned by other parts of the program.

#### Double Free

**Theory**

A double free calls `free` twice on the same block. It is undefined behaviour, and unlike a leak it attacks the allocator itself.

Understanding why requires knowing a little about how allocators work. When you free a block, the allocator writes bookkeeping into the block's own memory — typically linking it into a free list by storing pointers in the first bytes of the now-unused space. Freeing a second time links an already-linked block again, producing a corrupted or cyclic free list. The consequences range from an immediate abort (glibc detects many cases and prints `double free or corruption`), to a later crash inside an innocent `malloc`, to the allocator handing out the same block to two different callers — which is a use-after-free by construction, and a classic route to arbitrary code execution.

The causes are almost always structural rather than careless:

- **Two owners.** Two data structures each believe they own the same object, and both clean up.
- **Aliased pointers.** `free(a); free(b);` where `a == b`.
- **Error paths that free, followed by a caller that also frees.** A function that frees on failure and returns an error, whose caller then frees its copy too.
- **Retry loops** that call cleanup twice.
- **Shallow struct copies** where both copies' destructors free the same inner pointer.

The defences follow directly:

**Null after free**, again via a destroy function that takes `T **`. `free(NULL)` is a guaranteed no-op, so a second call becomes harmless. This handles the "same variable freed twice" case completely.

**Define ownership precisely.** For every heap object, exactly one owner is responsible for freeing it, and that fact belongs in a comment on the type. Aliases are borrows and must never free.

**Make error-path ownership explicit.** State in the documentation whether a function frees its argument on failure. "On error, this function takes ownership and frees the buffer" is a legitimate contract, and so is "on error, the caller retains ownership" — but the caller has to know which.

For structs whose members are heap pointers, remember that assignment copies shallowly: after `b = a;`, two structs point at the same buffers, and destroying both is a double free. Either write a deep-copy function or make the type non-copyable by convention.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct { char *name; } Item;

/* Safe destroy: idempotent because free(NULL) is a no-op. */
static void item_destroy(Item **ip)
{
    if (!ip || !*ip) return;
    free((*ip)->name);
    (*ip)->name = NULL;
    free(*ip);
    *ip = NULL;
}

static Item *item_create(const char *name)
{
    Item *i = calloc(1, sizeof *i);
    if (!i) return NULL;
    i->name = malloc(strlen(name) + 1);
    if (!i->name) { free(i); return NULL; }
    strcpy(i->name, name);
    return i;
}

int main(void)
{
    /* --- the direct form --------------------------------------------- */
    char *p = malloc(16);
    free(p);
    /* free(p);            <- DOUBLE FREE: glibc aborts, ASan reports */
    p = NULL;
    free(p);               /* harmless: free(NULL) does nothing */

    /* --- the aliasing form: harder to see ---------------------------- */
    char *a = malloc(16);
    char *b = a;           /* an alias, not a copy of the data */
    free(a);
    /* free(b);            <- SAME BLOCK: double free */
    a = b = NULL;

    /* --- the shallow-copy form: hardest to see ----------------------- */
    Item *x = item_create("shared");
    if (x) {
        Item y = *x;              /* shallow copy: y.name aliases x->name */
        /* free(y.name);             <- would double-free with item_destroy */
        (void)y;
        item_destroy(&x);         /* frees name and struct exactly once */
        item_destroy(&x);         /* idempotent: x is NULL, nothing happens */
    }
    return 0;
}
```

```text
   WHAT THE ALLOCATOR SEES

   free(p) once:      free list: HEAD -> [p] -> [older] -> NULL
   free(p) again:     free list: HEAD -> [p] -> [p] -> ...  (cycle!)

   Later:  q1 = malloc(16);   -> returns p
           q2 = malloc(16);   -> returns p AGAIN
           Two "independent" objects now share one block; writing q1
           silently rewrites q2. This is the primitive attackers use.
```

Detection is immediate with either tool:

```bash
$ ./prog
free(): double free detected in tcache 2       # glibc's own check
Aborted (core dumped)

$ gcc -g -fsanitize=address prog.c -o prog && ./prog
==777==ERROR: AddressSanitizer: attempting double-free on 0x602000000010
    #0 free
    #1 main prog.c:14              <- the second free
freed by thread T0 here:
    #1 main prog.c:12              <- the first free
```

**Key Takeaways**

- Freeing the same block twice corrupts allocator metadata and can cause the same block to be handed to two callers.
- The realistic causes are ambiguous ownership, aliased pointers, error paths that free, and shallow struct copies.
- Null the pointer after freeing so a repeat call becomes a no-op — `free(NULL)` is always safe.
- Assign exactly one owner per heap object and document whether a function takes ownership on failure.
- glibc detects many double frees at run time; AddressSanitizer reports both free sites precisely.

> 🧪 Practice
>
> 1. Trigger a double free deliberately and compare the plain glibc message with the AddressSanitizer report.
> 2. Write a struct with a heap member, copy it by assignment, and destroy both copies. Explain the failure and then implement a deep copy.
> 3. Design an API where a function takes ownership of its argument on failure; document the contract and write a caller that respects it.
> 4. Interview-style: *"Why can a double free lead to code execution, while a leak cannot?"* Hint: think about what the allocator stores inside freed blocks and what it does with that data later.

#### Buffer Overflows

**Theory**

A buffer overflow writes (or reads) outside the bounds of an object. C performs no bounds checking — `a[i]` compiles to "add `i * sizeof(T)` to the base address and access it", with no validation whatsoever — so the language will happily let you scribble over whatever follows your array.

What gets damaged depends on where the buffer lives:

- **Stack overflow** — the frame contains locals, the saved frame pointer, and the **return address**. Overwriting the return address redirects execution when the function returns, which is the original "smashing the stack" attack. Compilers now insert stack canaries (`-fstack-protector-strong`), which detect the corruption at return time and abort.
- **Heap overflow** — the bytes after your block are another allocation or the allocator's chunk header. Corrupting a header typically produces a crash inside a later, unrelated `malloc` or `free`, hiding the real cause.
- **Global overflow** — damages neighbouring globals, usually producing baffling action-at-a-distance bugs.

The recurring sources are a short list, and nearly all of them are string functions:

| Dangerous | Why | Safer choice |
|---|---|---|
| `gets(buf)` | no length parameter at all | `fgets(buf, sizeof buf, stdin)` |
| `strcpy(d, s)` | copies until NUL, whatever the size | `snprintf`, or a bounded copy |
| `strcat(d, s)` | appends without checking room | `snprintf` with an explicit length |
| `sprintf(buf, ...)` | output length is unbounded | `snprintf(buf, sizeof buf, ...)` |
| `scanf("%s", buf)` | unbounded field | `scanf("%31s", buf)` or `fgets` |

`gets` was removed from the language in C11 — that is how bad it is.

Off-by-one errors deserve special mention because they are so easy to make: `for (i = 0; i <= n; i++)` writes one element past the end, and forgetting the NUL terminator's byte makes `char buf[N]` hold only `N - 1` characters. A one-byte overflow is not a minor overflow; on the stack it can overwrite the least significant byte of a saved pointer, and on the heap it can flip an allocator flag bit.

Two habits prevent most of this. First, **always compute the size from the object**: `sizeof buf` for arrays (never for pointers, where it gives the pointer size), and carry an explicit length alongside every pointer parameter. Second, **prefer `snprintf` for all string building** — it bounds the output, always NUL-terminates (given a non-zero size), and returns the length it *would* have written, which lets you detect truncation.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* UNSAFE: no bound at all. The caller's input decides how far we write. */
void unsafe_copy(const char *input)
{
    char buf[16];
    strcpy(buf, input);            /* overflows for input longer than 15 */
    printf("%s\n", buf);
}

/* SAFE: bounded, always terminated, and truncation is detectable. */
int safe_copy(const char *input)
{
    char buf[16];
    int n = snprintf(buf, sizeof buf, "%s", input);
    if (n < 0 || (size_t)n >= sizeof buf) {
        fprintf(stderr, "input truncated (%d chars needed)\n", n);
        return -1;
    }
    printf("%s\n", buf);
    return 0;
}

/* The classic off-by-one: <= instead of <. */
void off_by_one(void)
{
    int a[5];
    for (int i = 0; i <= 5; i++)   /* writes a[5]: one past the end */
        a[i] = i;
}

/* sizeof does NOT work through a pointer -- a very common overflow cause. */
void sizeof_trap(char *heap_buf)
{
    printf("sizeof(pointer) = %zu  <- the POINTER, not the buffer\n",
           sizeof heap_buf);       /* 8 on x86-64, regardless of the size */
    /* memset(heap_buf, 0, sizeof heap_buf);  would clear only 8 bytes */
}

/* Correct heap-buffer handling: carry the length with the pointer. */
typedef struct { char *data; size_t cap; } Buf;

int buf_append(Buf *b, size_t used, const char *s)
{
    size_t need = strlen(s);
    if (used + need + 1 > b->cap) return -1;   /* explicit bounds check */
    memcpy(b->data + used, s, need + 1);
    return 0;
}

int main(void)
{
    safe_copy("short");
    safe_copy("a string that is definitely longer than fifteen characters");

    /* unsafe_copy("a string that is definitely longer than fifteen chars"); */
    (void)unsafe_copy;

    char *h = malloc(64);
    if (h) { sizeof_trap(h); free(h); }
    off_by_one();
    return 0;
}
```

```text
   STACK FRAME BEING OVERFLOWED BY strcpy(buf, long_input)

   low addresses
   +-----------------+
   | buf[0..15]      | <- the write starts here
   +-----------------+
   | other locals    | <- clobbered next
   +-----------------+
   | saved rbp       | <- clobbered
   +-----------------+
   | canary (with    | <- -fstack-protector-strong puts a random value
   |  -fstack-prot.) |    here; a mismatch at return aborts the program
   +-----------------+
   | RETURN ADDRESS  | <- clobbering this hijacks control flow
   +-----------------+
   high addresses     (writes proceed toward higher addresses)
```

```bash
# Catch overflows at run time, on the stack, heap and globals:
$ gcc -g -fsanitize=address -fno-omit-frame-pointer prog.c -o prog && ./prog
# ==999==ERROR: AddressSanitizer: stack-buffer-overflow ... WRITE of size 1

# Cheap production hardening (no ASan required):
$ gcc -O2 -D_FORTIFY_SOURCE=3 -fstack-protector-strong -Wall -Wextra prog.c
# _FORTIFY_SOURCE turns many str*/mem* calls into length-checked variants
```

**Key Takeaways**

- C never checks bounds; an out-of-range index simply computes an address and accesses it.
- Stack overflows can overwrite the return address; heap overflows corrupt allocator metadata and crash elsewhere later.
- Replace `gets`, `strcpy`, `strcat`, and `sprintf` with `fgets` and `snprintf`, and always check `snprintf`'s return value for truncation.
- `sizeof` gives the object size only for arrays — through a pointer it gives the pointer's size, which is a classic overflow cause.
- Build debug with `-fsanitize=address` and release with `-D_FORTIFY_SOURCE=3 -fstack-protector-strong`.

> 🧪 Practice
>
> 1. Write a 16-byte stack buffer, `strcpy` a 40-character string into it, and run it under AddressSanitizer. Then rewrite with `snprintf`.
> 2. Write a loop with `<=` over a 5-element array and find it with both `-fsanitize=address` and `valgrind`.
> 3. Write a function taking `char *buf` that uses `sizeof buf` for its bound; show the bug, then fix the signature to take an explicit length.
> 4. Interview-style: *"What does a stack canary protect against, and what does it not?"* Hint: consider the order of writes and which corruptions happen before the function returns.

#### Uninitialized Reads

**Theory**

An automatic (stack) variable with no initializer holds an **indeterminate value**: whatever bytes were left in that memory by earlier code. Likewise, `malloc` returns uninitialized bytes. Reading either before writing is undefined behaviour.

It is worth being precise about why this is worse than "you get a random number". The standard says such values are indeterminate, which — for objects that could be trap representations, and for anything the compiler can prove is uninitialized — allows the compiler to assume the read never happens. Real optimizers act on this: they may propagate contradictory assumptions, delete a branch that depends on the uninitialized value, or produce different values for two reads of the same variable. Treating it as "just garbage that varies" underestimates the risk.

Practically, the symptoms are what make it maddening. Uninitialized stack memory often contains the leftovers of the *previous* call, so a variable can be reliably `0` in a debug build (fresh stack pages arrive zeroed from the kernel) and reliably wrong in a release build, or work until you add an unrelated function call before it. This is the archetypal "works in debug, fails in release" bug.

Uninitialized memory is also a **security problem** independent of correctness: if a struct with padding or an unfilled buffer is written to a file, socket, or log, previously freed data — passwords, keys, other users' data — leaks out. The Heartbleed vulnerability was, in essence, a large uninitialized-and-overread buffer being sent to a remote peer.

Prevention is easy and cheap:

- **Initialize at declaration.** `int count = 0;`, `char *p = NULL;`, `struct config c = {0};`. Declaring variables at first use (C99) makes this natural, because you usually know the value by then.
- **Use `calloc`** when a heap block should start zeroed, or `memset` immediately after `malloc`.
- **Do not forget struct padding.** `struct s x = {0};` zeroes every *member*, but padding bytes remain indeterminate. Use `memset(&x, 0, sizeof x)` before serializing a struct byte-for-byte.
- **Turn on the warnings**: `-Wall -Wextra` enables `-Wmaybe-uninitialized`, which catches many cases at compile time (though not all — the analysis is necessarily incomplete).
- **Use MemorySanitizer** (`-fsanitize=memory`, Clang) or Valgrind, which track initialization at the bit level and report the exact read.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* UB: 'sum' starts with whatever was in that stack slot. */
int broken_sum(const int *a, size_t n)
{
    int sum;                       /* indeterminate */
    for (size_t i = 0; i < n; i++)
        sum += a[i];               /* reads an indeterminate value */
    return sum;
}

int fixed_sum(const int *a, size_t n)
{
    int sum = 0;                   /* one character fixes it */
    for (size_t i = 0; i < n; i++)
        sum += a[i];
    return sum;
}

/* A function that leaves stack garbage for the NEXT call to inherit. */
static void dirty_the_stack(void)
{
    volatile int junk[32];
    for (int i = 0; i < 32; i++) junk[i] = 0xDEADBEEF;
}

static void observe_garbage(void)
{
    int uninitialized[4];          /* same stack region as junk[] above */
    printf("leftover values: %d %d\n", uninitialized[0], uninitialized[1]);
}

/* Padding is NOT covered by {0} -- relevant whenever bytes leave the process. */
struct record {
    char  tag;      /* 1 byte  */
    /* 3 padding bytes here */
    int   value;    /* 4 bytes */
};

int main(void)
{
    int data[] = {1, 2, 3, 4};
    printf("fixed_sum  = %d\n", fixed_sum(data, 4));
    printf("broken_sum = %d (indeterminate; may differ per build)\n",
           broken_sum(data, 4));

    dirty_the_stack();
    observe_garbage();             /* often prints 0xDEADBEEF as -559038737 */

    /* malloc gives indeterminate bytes; calloc gives zeros. */
    int *m = malloc(4 * sizeof *m);
    int *c = calloc(4, sizeof *c);
    if (m && c) printf("malloc[0]=%d (garbage)  calloc[0]=%d\n", m[0], c[0]);
    free(m); free(c);

    /* Member-wise zeroing leaves padding indeterminate. */
    struct record r1 = {0};                 /* members zeroed, padding not */
    struct record r2;
    memset(&r2, 0, sizeof r2);              /* every BYTE zeroed */
    r1.tag = r2.tag = 'A';
    printf("use memset before writing a struct to a file or socket\n");
    return 0;
}
```

```bash
$ valgrind ./prog
==7777== Conditional jump or move depends on uninitialised value(s)
==7777==    at 0x40067A: broken_sum (prog.c:8)
==7777==  Uninitialised value was created by a stack allocation
==7777==    at 0x400666: broken_sum (prog.c:6)     <- the declaration

$ clang -g -fsanitize=memory prog.c -o prog && ./prog
# ==8888==WARNING: MemorySanitizer: use-of-uninitialized-value
```

**Key Takeaways**

- Automatic variables and `malloc`'d memory start indeterminate; reading before writing is undefined behaviour, not merely unpredictable.
- Optimizers exploit the undefinedness, so symptoms differ between debug and release builds — the classic "works with -O0" bug.
- Initialize at declaration, use `calloc` for zeroed heap memory, and declare variables at first use.
- `struct s x = {0};` zeroes members but not padding — `memset` before serializing a struct to a file or the network.
- Enable `-Wall -Wextra` for compile-time detection, and use Valgrind or MemorySanitizer for the cases static analysis cannot see.

> 🧪 Practice
>
> 1. Write `broken_sum` and run it under `-O0` and `-O2`; report both results and explain why they may differ.
> 2. Write a function that fills a large local array, return, then call another function with an uninitialized local array of the same size and print it.
> 3. Serialize a struct with padding using `fwrite` twice — once after `{0}` and once after `memset` — and compare the bytes with `xxd`.
> 4. Interview-style: *"Why can reading an uninitialized variable be worse than reading a random value?"* Hint: consider what the optimizer is permitted to assume about code paths that would be undefined.

#### Alignment and Aliasing Violations

**Theory**

Two rules constrain how you may reinterpret memory in C. Both are invisible in ordinary code and both bite hard in low-level code that casts pointers.

**Alignment.** Every type has an alignment requirement: an `int` typically must sit at an address divisible by 4, a `double` by 8. `malloc` always returns memory suitably aligned for any fundamental type, so ordinary heap use is safe. Trouble comes from *reinterpreting* a pointer: taking a `char *` at an arbitrary offset into a buffer and casting it to `int *`. On x86 the unaligned access usually works (a little slower); on ARMv7, SPARC, and many microcontrollers it raises a bus error; and even on x86 the *cast itself* is undefined behaviour, so the compiler may transform the code in ways that break it — for example by using an SSE instruction that does require alignment. The portable fix is `memcpy`, which has no alignment requirement and which every modern compiler turns into a single unaligned load when the target permits.

**Strict aliasing.** The compiler is allowed to assume that two pointers of *incompatible* types never refer to the same object. That assumption is what lets it keep a value in a register across a store through an unrelated pointer — a significant optimization. Violating it (writing through a `float *` and reading through an `int *`, say) makes the compiler's assumption false, and the generated code can silently ignore your write. The exceptions the standard grants are worth memorizing:

- A **character type** (`char`, `unsigned char`, `signed char`) may alias anything. This is why `memcpy` and byte-level inspection are always legal.
- Types that differ only in signedness or qualifiers may alias.
- A **union** member access is the sanctioned way to reinterpret bytes: writing one member and reading another is well-defined in C (unlike C++), though the result depends on representation.

The practical rules that follow are short: **use `memcpy` to reinterpret bytes**, use a union when you want an explicit, named reinterpretation, and reserve `-fno-strict-aliasing` for legacy code you cannot fix. C11's `_Alignof` and `alignas` let you query and request alignment explicitly, and `aligned_alloc` gives over-aligned heap blocks when SIMD or cache-line separation demands them.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdalign.h>    /* alignas, alignof (C11) */

/* WRONG: violates strict aliasing AND may be misaligned.
   Compiled with -O2, the read may not observe the write at all. */
float bad_bit_cast(uint32_t bits)
{
    return *(float *)&bits;         /* type-punning through a cast */
}

/* RIGHT: memcpy has no alignment or aliasing constraints, and every
   modern compiler optimizes this to a single register move. */
float good_bit_cast(uint32_t bits)
{
    float f;
    memcpy(&f, &bits, sizeof f);
    return f;
}

/* Also right, and self-documenting: a union member access. */
float union_bit_cast(uint32_t bits)
{
    union { uint32_t u; float f; } conv;   /* both members, one storage */
    conv.u = bits;
    return conv.f;                          /* well-defined in C */
}

/* Parsing a byte stream: NEVER cast the cursor to a wider pointer type. */
int parse_be32(const unsigned char *p, size_t len, uint32_t *out)
{
    if (len < 4) return -1;
    /* Portable, alignment-free, endian-explicit. */
    *out = (uint32_t)p[0] << 24 | (uint32_t)p[1] << 16
         | (uint32_t)p[2] <<  8 | (uint32_t)p[3];
    return 0;
}

int main(void)
{
    printf("alignof(char)=%zu int=%zu double=%zu\n",
           alignof(char), alignof(int), alignof(double));

    printf("good  = %f\n", good_bit_cast(0x40490FDBu));   /* ~3.14159 */
    printf("union = %f\n", union_bit_cast(0x40490FDBu));
    (void)bad_bit_cast;

    /* Unaligned access via a cast: undefined, and a bus error on ARM. */
    unsigned char raw[16] = {0};
    /* int *bad = (int *)(raw + 1);  *bad = 42;   <- UB */
    int value = 42;
    memcpy(raw + 1, &value, sizeof value);        /* always correct */
    int back;
    memcpy(&back, raw + 1, sizeof back);
    printf("round-tripped through an unaligned offset: %d\n", back);

    uint32_t n;
    unsigned char stream[] = {0x00, 0x00, 0x01, 0x00};
    if (parse_be32(stream, sizeof stream, &n) == 0)
        printf("parsed big-endian value = %u\n", n);

    /* Over-aligned allocation for SIMD or cache-line isolation. */
    alignas(64) static int cache_line_isolated[16];
    void *simd = aligned_alloc(32, 32 * 8);
    printf("static alignas(64) at %% 64 == %zu\n",
           (size_t)(void *)cache_line_isolated % 64);
    free(simd);
    return 0;
}
```

```text
   ALIGNMENT

   ok:   addr 0x1000  [ int ][ int ][ int ]      0x1000 % 4 == 0
   bad:  addr 0x1001  [  i n t  ] spans two 4-byte units
                       ^ cast to int* is UB; bus error on strict CPUs

   STRICT ALIASING: what the optimizer is allowed to do

     void f(int *i, float *g) {
         *i = 1;            // compiler: 'g' cannot alias 'i' (different types)
         *g = 2.0f;         // so it may keep *i == 1 in a register
         return *i;         // and return 1 WITHOUT reloading from memory
     }

   If you actually passed the same address for both, the returned 1 is
   "wrong" -- but your program was already undefined.
```

**Key Takeaways**

- Casting a pointer to a stricter-aligned type is undefined behaviour, works by luck on x86, and faults on many other architectures.
- Strict aliasing lets the compiler assume incompatible pointer types never overlap; violating it can make stores vanish under optimization.
- Character types may alias anything, which is why `memcpy` and byte-wise inspection are always legal.
- Use `memcpy` for type punning (compilers optimize it away) or a union member access; avoid `*(T *)&x` casts entirely.
- Use `alignof`/`alignas` and `aligned_alloc` when you need explicit or over-strict alignment, and parse byte streams byte by byte.

> 🧪 Practice
>
> 1. Print `alignof` for `char`, `short`, `int`, `double`, and a struct containing all of them, and explain each value.
> 2. Write both `bad_bit_cast` and `good_bit_cast`, compile at `-O2` with `-Wstrict-aliasing=2`, and compare the generated assembly with `-S`.
> 3. Parse a 4-byte big-endian integer out of an unaligned offset in a byte array using shifts, and again using `memcpy`, and verify both give the same result.
> 4. Interview-style: *"Why is `*(float *)&some_int` unsafe even when the sizes match?"* Hint: name the two separate rules it can break, and describe what the optimizer is permitted to assume about each.

<a id="74-allocation-strategies"></a>
### 7.4 Allocation Strategies

Calling `malloc` for every object is correct but rarely optimal. This section covers the strategies experienced C programmers use instead: arenas and pools that make deallocation trivial, stack allocation of run-time sizes, pluggable allocator interfaces, reference counting for shared ownership, and the fragmentation problem that motivates most of it.

#### Arena and Pool Allocators

**Theory**

General-purpose `malloc` solves a hard problem: arbitrary sizes, arbitrary lifetimes, arbitrary order of release. That generality costs bookkeeping on every call. Most programs do not need it, because their allocations fall into patterns — and two custom allocators exploit those patterns to be both dramatically faster and far harder to leak.

**Arena (region, bump) allocator.** The insight is that many allocations share a lifetime: everything created while parsing one request, compiling one function, or rendering one frame dies together. So allocate one large block up front and satisfy each request by advancing an offset — a single addition and a bounds check. There is no per-allocation header, no free list, and no `free` at all: you release the entire arena in one operation when the phase ends.

The consequences are striking. Allocation is a handful of instructions. Allocations are contiguous, so traversing them is cache-perfect. Individual objects cannot be leaked, because nothing is individually owned. And the whole class of double-free and use-after-free-of-one-object bugs disappears — replaced, honestly, by a new one: using a pointer after the arena is reset.

**Pool (free-list, slab) allocator.** The other common pattern is many objects of *one* size with *individual* lifetimes — list nodes, particles, connection records. Carve a block into fixed-size slots and thread the free ones onto a singly linked list, storing each `next` pointer inside the free slot itself (it is unused space, so the list costs zero extra memory). Allocation pops the head; freeing pushes it back. Both are O(1) with a couple of instructions, there is no size arithmetic, no fragmentation is possible (every slot is interchangeable), and objects can be freed in any order.

| | `malloc`/`free` | Arena | Pool |
|---|---|---|---|
| Sizes | any | any | one fixed size |
| Free granularity | per object | whole arena at once | per object |
| Alloc cost | tens of instructions | ~3 instructions | ~3 instructions |
| Per-object overhead | 8–16 bytes | 0 (plus padding) | 0 |
| Fragmentation | possible | none | none |
| Typical use | general code | request/frame/parse phases | many same-size nodes |

Both need care with **alignment**: a bump allocator must round the offset up to the required alignment, or it will hand out addresses that break `double` or SIMD accesses. Rounding to `alignof(max_align_t)` is the simple, always-correct choice.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stddef.h>     /* max_align_t */
#include <stdalign.h>   /* alignof (C11) */

/* ---------------- Arena: bump-pointer allocation ------------------- */
typedef struct {
    unsigned char *base;
    size_t         cap;
    size_t         used;
} Arena;

static int arena_init(Arena *a, size_t cap)
{
    a->base = malloc(cap);
    if (!a->base) return -1;
    a->cap = cap;
    a->used = 0;
    return 0;
}

/* Round 'n' up to the next multiple of 'align' (a power of two). */
static size_t align_up(size_t n, size_t align)
{
    return (n + align - 1) & ~(align - 1);
}

static void *arena_alloc(Arena *a, size_t size)
{
    size_t offset = align_up(a->used, alignof(max_align_t));  /* never skip */
    if (offset > a->cap || size > a->cap - offset) return NULL;  /* overflow-safe */
    void *p = a->base + offset;
    a->used = offset + size;          /* the entire allocation algorithm */
    return p;
}

static void arena_reset(Arena *a) { a->used = 0; }   /* frees EVERYTHING */
static void arena_free(Arena *a)  { free(a->base); a->base = NULL; a->cap = a->used = 0; }

/* ---------------- Pool: fixed-size free list ------------------------ */
typedef struct PoolNode { struct PoolNode *next; } PoolNode;

typedef struct {
    unsigned char *block;
    PoolNode      *free_list;
    size_t         slot;      /* bytes per slot */
} Pool;

static int pool_init(Pool *p, size_t slot_size, size_t count)
{
    /* Each slot must be able to hold a 'next' pointer while free. */
    p->slot = align_up(slot_size < sizeof(PoolNode) ? sizeof(PoolNode) : slot_size,
                       alignof(max_align_t));
    p->block = malloc(p->slot * count);
    if (!p->block) return -1;

    p->free_list = NULL;
    for (size_t i = count; i-- > 0; ) {          /* thread every slot on */
        PoolNode *n = (PoolNode *)(p->block + i * p->slot);
        n->next = p->free_list;
        p->free_list = n;
    }
    return 0;
}

static void *pool_alloc(Pool *p)
{
    PoolNode *n = p->free_list;
    if (!n) return NULL;                 /* pool exhausted */
    p->free_list = n->next;              /* pop the head: O(1) */
    return n;
}

static void pool_free(Pool *p, void *ptr)
{
    PoolNode *n = ptr;
    n->next = p->free_list;              /* push onto the head: O(1) */
    p->free_list = n;
}

static void pool_destroy(Pool *p) { free(p->block); p->block = NULL; p->free_list = NULL; }

/* ---------------- Using them --------------------------------------- */
typedef struct { int id; double score; } Record;

int main(void)
{
    /* Arena: everything created for one "request" dies together. */
    Arena a;
    if (arena_init(&a, 64 * 1024) != 0) return EXIT_FAILURE;

    for (int request = 0; request < 3; request++) {
        char   *name = arena_alloc(&a, 32);
        Record *r    = arena_alloc(&a, sizeof *r);
        if (!name || !r) break;
        snprintf(name, 32, "request-%d", request);
        *r = (Record){request, request * 1.5};
        printf("%s -> id=%d score=%.1f  (arena used %zu bytes)\n",
               name, r->id, r->score, a.used);
        arena_reset(&a);          /* one instruction frees BOTH allocations */
    }
    arena_free(&a);

    /* Pool: many same-size objects with individual lifetimes. */
    Pool pool;
    if (pool_init(&pool, sizeof(Record), 100) != 0) return EXIT_FAILURE;

    Record *rs[5];
    for (int i = 0; i < 5; i++) {
        rs[i] = pool_alloc(&pool);
        *rs[i] = (Record){i, i * 0.5};
    }
    pool_free(&pool, rs[2]);                 /* out-of-order free is fine */
    Record *reused = pool_alloc(&pool);      /* gets slot 2 straight back */
    printf("pool reused the freed slot: %s\n", reused == rs[2] ? "yes" : "no");
    pool_destroy(&pool);
    return 0;
}
```

```text
   ARENA                              POOL

   base                               block
   |                                  |
   [name][rec][name][rec][ free  ]    [ A ][ B ][ C ][ D ][ E ]
                    ^ used             free_list -> C -> E -> NULL
   alloc: used += size                          (next pointers live
   reset: used  = 0   (frees all)                INSIDE the free slots)

   No per-object header, no free list.  alloc: pop head.  free: push head.
   Cannot free one object.             Any order, no fragmentation.
```

**Key Takeaways**

- An arena allocates by bumping an offset and frees everything at once — ideal when many objects share one lifetime (a request, a frame, a parse).
- A pool serves fixed-size slots from a free list threaded through the free slots themselves: O(1) allocate and free, zero overhead, no fragmentation.
- Both eliminate per-object headers and dramatically outperform `malloc` for their patterns, while removing whole classes of leak and double-free bugs.
- The new failure mode is lifetime confusion: a pointer used after `arena_reset` is a use-after-free with no allocator to detect it.
- Always align the bump offset (to `alignof(max_align_t)` if in doubt) and size pool slots to hold at least a `next` pointer.

> 🧪 Practice
>
> 1. Implement the arena above and benchmark 100,000 small allocations against 100,000 `malloc` calls; report the ratio and the peak memory.
> 2. Extend the arena with a "checkpoint/rollback" API (`size_t arena_mark(Arena*)`, `void arena_release(Arena*, size_t)`) and use it for nested scopes.
> 3. Add an assertion to `pool_free` that the pointer lies within the pool block and on a slot boundary, then test it with a deliberately bad pointer.
> 4. Interview-style: *"When would you choose an arena over `malloc`, and what do you give up?"* Hint: describe the lifetime pattern that makes it a win, and the bug class it introduces.

#### Stack Allocation with alloca

**Theory**

`alloca(size)` allocates memory on the *stack* — in the current function's frame — and it is automatically released when the function returns. It is not standard C (it comes from `<alloca.h>` on glibc, `<malloc.h>` on Windows), but it appears often enough in real code to need understanding.

The appeal is genuine: allocation is a single stack-pointer adjustment, there is no `free` to forget, and no leak is possible even on an early return or a `longjmp`. For a run-time-sized scratch buffer in a hot function, it is the fastest thing available.

The problems are equally genuine, and they are why most style guides ban it:

- **There is no failure indication.** If the size exceeds the remaining stack, you do not get `NULL`; you get stack overflow — a crash, or worse, a silently corrupted frame. Since the available stack depends on call depth, the same `alloca` may work in one caller and crash in another.
- **A size derived from input is a vulnerability.** `alloca(user_supplied_length)` lets an attacker move the stack pointer arbitrarily.
- **The lifetime is the whole function, not the block.** `alloca` inside a loop accumulates until the function returns — a loop of `alloca` calls is effectively a stack leak.
- **It does not compose.** `alloca` in a function argument list has unspecified behaviour on some compilers, and it interacts badly with inlining and with `setjmp`/`longjmp`.

C99's **variable-length arrays (VLAs)** provide the same capability with better semantics: `int buf[n];` has block scope (so a loop reclaims each iteration), respects normal array typing, and works with `sizeof`. They inherit the fatal flaw — no failure mode when `n` is large — which is why VLAs became optional in C11 and why the Linux kernel removed them entirely. The `__STDC_NO_VLA__` macro tells you whether an implementation supports them.

The sound rule: use a **fixed-size stack buffer for the common small case and fall back to `malloc` above a threshold**. This gives you the speed of the stack for typical inputs and the safety of the heap for outliers, with a bounded, auditable worst case.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef _WIN32
#  include <alloca.h>
#endif

/* DANGEROUS: no failure path. A large 'n' overflows the stack and crashes,
   and 'n' derived from untrusted input is a security hole. */
void risky(size_t n)
{
    char *buf = alloca(n);        /* no NULL check is possible */
    memset(buf, 0, n);
    /* released automatically when the function returns */
}

/* VLA: same speed, better scoping -- but the same missing failure mode. */
void vla_version(size_t n)
{
#ifndef __STDC_NO_VLA__
    char buf[n];                  /* block scope: reclaimed at the brace */
    memset(buf, 0, n);
    printf("VLA of %zu bytes, sizeof works: %zu\n", n, sizeof buf);
#else
    (void)n;
#endif
}

/* THE RECOMMENDED PATTERN: small-size optimization with a heap fallback.
   Fast and allocation-free for the common case, safe for any size. */
#define STACK_THRESHOLD 256

int process(const char *input, size_t len)
{
    char  stack_buf[STACK_THRESHOLD];
    char *buf   = stack_buf;
    char *owned = NULL;                       /* non-NULL only if we malloc'd */

    if (len + 1 > sizeof stack_buf) {
        owned = malloc(len + 1);
        if (!owned) return -1;                /* a real, checkable failure */
        buf = owned;
    }

    memcpy(buf, input, len);
    buf[len] = '\0';
    printf("processed %zu bytes using the %s\n",
           len, owned ? "heap" : "stack");

    free(owned);                              /* free(NULL) is a no-op */
    return 0;
}

int main(void)
{
    risky(64);
    vla_version(10);

    char small[100], big[1000];
    memset(small, 'a', sizeof small);
    memset(big,   'b', sizeof big);
    process(small, sizeof small);   /* stack path */
    process(big,   sizeof big);     /* heap path  */
    return 0;
}
```

| | `alloca` | VLA | fixed buffer + heap fallback |
|---|---|---|---|
| Standard | no | C99, optional since C11 | yes |
| Failure detectable | no | no | yes (`NULL`) |
| Lifetime | whole function | enclosing block | explicit |
| `sizeof` works | no | yes | yes |
| Safe with untrusted sizes | no | no | yes |

**Key Takeaways**

- `alloca` allocates in the current stack frame and is freed on return: extremely fast, but non-standard and with no way to detect failure.
- Its lifetime is the whole function, so `alloca` in a loop accumulates until return.
- VLAs give the same capability with proper block scope and typing, but share the fatal lack of a failure path and are optional since C11.
- Never size either from untrusted input — it is a direct route to stack overflow.
- Prefer a fixed-size stack buffer for the common case with a `malloc` fallback above a threshold: fast, safe, and standard.

> 🧪 Practice
>
> 1. Write a function using `alloca` in a loop and print the stack pointer each iteration to show the accumulation.
> 2. Implement the threshold pattern with a 128-byte buffer and verify with Valgrind that the heap path never leaks, including on the error return.
> 3. Compile a VLA-using program with `-Wvla` and with `-std=c11 -Wall`, and explain each diagnostic.
> 4. Interview-style: *"Why do the Linux kernel and many style guides ban VLAs and `alloca`?"* Hint: consider what happens when the size is large and what the code can do about it.

#### Custom Allocator Interfaces

**Theory**

Once you have more than one allocation strategy, the next step is to stop hard-coding which one your data structures use. A **custom allocator interface** lets a module allocate through a caller-supplied policy: the heap in production, an arena in a request handler, a pool in an embedded system, and an instrumented allocator in tests.

The idiomatic C shape is a struct of function pointers plus an opaque context:

```c
typedef struct {
    void *(*alloc)(void *ctx, size_t size);
    void *(*realloc)(void *ctx, void *ptr, size_t size);
    void  (*free)(void *ctx, void *ptr);
    void  *ctx;                 /* the arena, pool, or NULL for malloc */
} Allocator;
```

The `ctx` pointer is what makes this work: it carries the allocator's state, so the same function-pointer signature serves a stateless `malloc` wrapper and a stateful arena. This is the same pattern as `qsort`'s comparison function, SQLite's `sqlite3_mem_methods`, and Zig's `std.mem.Allocator` — and it is the standard way to express polymorphism in C.

Three design points are worth getting right the first time:

**Take the allocator by parameter, not by global.** A global "current allocator" seems convenient but breaks under threading and nesting. Structures that allocate should store the allocator they were created with, so their destroy function releases through the same one.

**Decide the failure convention once.** Either every `alloc` may return `NULL` and every caller checks, or the interface guarantees non-`NULL` and aborts. Mixing the two is where bugs live.

**Keep it minimal.** Three functions cover essentially everything. Adding `calloc`, alignment parameters, or size-passing `free` (which lets pool allocators skip a lookup) is a real design choice, not an automatic improvement.

The immediate payoff beyond flexibility is **testability**. A wrapper allocator that counts live allocations turns "does this function leak?" into an assertion. One that fails on the *n*th call lets you exercise every error path deterministically — the single most effective technique for making error handling actually correct, since those paths are otherwise never executed.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    void *(*alloc)(void *ctx, size_t size);
    void  (*free)(void *ctx, void *ptr);
    void  *ctx;
} Allocator;

/* --- Backend 1: plain malloc (stateless: ctx is unused) -------------- */
static void *sys_alloc(void *ctx, size_t size) { (void)ctx; return malloc(size); }
static void  sys_free (void *ctx, void *ptr)   { (void)ctx; free(ptr); }

static const Allocator SYSTEM_ALLOCATOR = { sys_alloc, sys_free, NULL };

/* --- Backend 2: a counting wrapper, for tests ----------------------- */
typedef struct {
    const Allocator *inner;
    size_t live;          /* outstanding allocations */
    size_t total;         /* allocations ever made   */
    size_t fail_after;    /* fail once this many succeed (SIZE_MAX = never) */
} CountingCtx;

static void *counting_alloc(void *ctx, size_t size)
{
    CountingCtx *c = ctx;
    if (c->total >= c->fail_after) return NULL;     /* deterministic failure */
    void *p = c->inner->alloc(c->inner->ctx, size);
    if (p) { c->live++; c->total++; }
    return p;
}

static void counting_free(void *ctx, void *ptr)
{
    CountingCtx *c = ctx;
    if (ptr) c->live--;
    c->inner->free(c->inner->ctx, ptr);
}

/* --- A data structure parameterized by its allocator ---------------- */
typedef struct {
    const Allocator *a;      /* remembered so destroy uses the SAME one */
    char            *data;
    size_t           len;
} String;

static String *string_create(const Allocator *a, const char *s)
{
    size_t n = strlen(s) + 1;
    String *str = a->alloc(a->ctx, sizeof *str);
    if (!str) return NULL;

    str->data = a->alloc(a->ctx, n);
    if (!str->data) { a->free(a->ctx, str); return NULL; }   /* no leak */

    memcpy(str->data, s, n);
    str->len = n - 1;
    str->a = a;
    return str;
}

static void string_destroy(String *s)
{
    if (!s) return;
    const Allocator *a = s->a;     /* release through the creating allocator */
    a->free(a->ctx, s->data);
    a->free(a->ctx, s);
}

int main(void)
{
    /* Production path: the system allocator. */
    String *s = string_create(&SYSTEM_ALLOCATOR, "hello");
    if (s) { printf("%s (len %zu)\n", s->data, s->len); string_destroy(s); }

    /* Test path 1: assert that create/destroy is leak-free. */
    CountingCtx ctx = { &SYSTEM_ALLOCATOR, 0, 0, (size_t)-1 };
    Allocator counting = { counting_alloc, counting_free, &ctx };

    String *t = string_create(&counting, "counted");
    printf("live during use : %zu\n", ctx.live);      /* 2 */
    string_destroy(t);
    printf("live after free : %zu (0 means no leak)\n", ctx.live);

    /* Test path 2: force the SECOND allocation to fail and prove the
       error path releases the first one. */
    ctx.live = ctx.total = 0;
    ctx.fail_after = 1;
    String *u = string_create(&counting, "will fail");
    printf("create under injected failure -> %s, live = %zu\n",
           u ? "unexpected success" : "NULL as expected", ctx.live);
    return 0;
}
```

```text
   ONE INTERFACE, MANY BACKENDS

                    +---------------------------+
   your module ---> | Allocator { alloc, free,  |
   (String, Vec,    |             ctx }         |
    parser, ...)    +------------+--------------+
                                 |
              +------------------+-----------------+---------------+
              v                  v                 v               v
         malloc/free          Arena              Pool         Counting /
         (ctx = NULL)      (ctx = &arena)   (ctx = &pool)   fault-injecting
                                                             (ctx = &stats)

   The module's code never changes; the policy is chosen at the call site.
```

**Key Takeaways**

- An allocator interface is a struct of function pointers plus an opaque `ctx`, the standard way to express policy polymorphism in C.
- Pass the allocator explicitly and store it in objects that own memory, so destruction uses the allocator that created them.
- Fix the failure convention (returns `NULL` versus never fails) once for the whole interface.
- A counting wrapper turns leak checks into assertions; a fault-injecting wrapper makes every error path testable and deterministic.
- Keep the interface minimal — `alloc`, `realloc`, `free` covers nearly all real use.

> 🧪 Practice
>
> 1. Implement the `Allocator` interface with two backends (system and arena) and run the same `String` code through both.
> 2. Add a `realloc` slot to the interface and implement it for the arena (hint: it can only grow the most recent allocation in place).
> 3. Use the fault-injecting allocator to fail the *n*th allocation for every *n* in a function that makes five allocations, and verify no path leaks.
> 4. Interview-style: *"Why does the allocator interface need a `void *ctx` when `malloc` needs no state?"* Hint: think about what an arena or pool must remember between calls, and about testability.

#### Reference Counting Patterns

**Theory**

Single ownership — one owner frees the object — covers most C code. But sometimes an object is genuinely shared: a texture used by several sprites, a configuration read by several subsystems, a buffer passed to a queue while the producer still holds it. Nobody knows who will finish last, so nobody can be the sole owner.

**Reference counting** answers this: the object carries a counter of how many owners it has. `retain` increments it, `release` decrements it, and the object is destroyed when the count reaches zero. The last owner out turns off the lights, and no single piece of code needs to know the global picture.

The rules are simple and must be followed exactly:

- Creation returns the object with a count of **1** — the creator is an owner.
- Anyone who **stores** a pointer for later use calls `retain`.
- Anyone who is **finished** with their pointer calls `release`, and must treat the pointer as invalid afterwards.
- Every `retain` is matched by exactly one `release`. One missing `release` leaks the object forever; one extra destroys it while others are still using it.

Two limitations are fundamental rather than implementation defects. **Cycles leak**: if A holds a reference to B and B to A, both counts stay at 1 even when nothing else refers to either, and neither is ever freed. The standard remedy is a *weak reference* — a raw pointer that does not participate in counting — for the "back" direction (parent pointers, observer links), with a rule for handling the case where the target is gone.

**Thread safety needs atomics.** A plain `count++` is a read-modify-write; two threads can interleave and lose an increment, causing a premature free. Use C11 `<stdatomic.h>`: `atomic_fetch_add(&count, 1)` for retain, and `atomic_fetch_sub(&count, 1) == 1` to detect the last release. Note the atomics protect only the *count*, not the object's contents — sharing mutable data still needs a lock.

Reference counting also has a real cost: an increment and decrement on every ownership change, cache-line contention when many threads touch the same counter, and destruction happening at an unpredictable point in the program. Use it where sharing is genuine, not as a default.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdatomic.h>

typedef struct {
    atomic_int refcount;      /* atomic: safe to share across threads */
    char      *data;
    size_t     len;
} SharedBuf;

/* Creation returns the object with refcount == 1: the caller is an owner. */
SharedBuf *sb_create(const char *s)
{
    SharedBuf *b = malloc(sizeof *b);
    if (!b) return NULL;
    b->len  = strlen(s);
    b->data = malloc(b->len + 1);
    if (!b->data) { free(b); return NULL; }
    memcpy(b->data, s, b->len + 1);
    atomic_init(&b->refcount, 1);
    return b;
}

/* Claim shared ownership. Returns the same pointer for convenient chaining. */
SharedBuf *sb_retain(SharedBuf *b)
{
    if (b) atomic_fetch_add(&b->refcount, 1);
    return b;
}

/* Give up ownership. Destroys the object when the LAST owner releases.
   fetch_sub returns the value BEFORE the subtraction, so 1 means "was the
   last reference". */
void sb_release(SharedBuf *b)
{
    if (!b) return;
    if (atomic_fetch_sub(&b->refcount, 1) == 1) {
        free(b->data);
        free(b);                     /* nobody else can reach it now */
    }
}

/* A consumer that stores the pointer must retain it. */
typedef struct { SharedBuf *buf; } Consumer;

void consumer_attach(Consumer *c, SharedBuf *b) { c->buf = sb_retain(b); }
void consumer_detach(Consumer *c) { sb_release(c->buf); c->buf = NULL; }

int main(void)
{
    SharedBuf *b = sb_create("shared payload");     /* count = 1 */
    if (!b) return EXIT_FAILURE;

    Consumer c1, c2;
    consumer_attach(&c1, b);                        /* count = 2 */
    consumer_attach(&c2, b);                        /* count = 3 */
    printf("count = %d, data = %s\n",
           atomic_load(&b->refcount), b->data);

    sb_release(b);                                  /* count = 2 */
    b = NULL;                    /* the creator's pointer is now invalid */

    printf("creator released; consumers still work: %s\n", c1.buf->data);

    consumer_detach(&c1);                           /* count = 1 */
    consumer_detach(&c2);                           /* count = 0 -> destroyed */
    printf("all owners released; object destroyed exactly once\n");
    return 0;
}
```

```text
   REFERENCE COUNT OVER TIME

   sb_create   -> [count=1]  creator
   attach c1   -> [count=2]  creator, c1
   attach c2   -> [count=3]  creator, c1, c2
   release     -> [count=2]  c1, c2          (creator's pointer now invalid)
   detach c1   -> [count=1]  c2
   detach c2   -> [count=0]  -> free(data); free(object)

   A REFERENCE CYCLE (the failure mode counting cannot solve)

        +-------+  strong   +-------+
        |   A   |---------->|   B   |     external references: none
        |count=1|<----------|count=1|     both counts stay 1 forever
        +-------+  strong   +-------+     -> leaked

   Fix: make one direction WEAK (a raw pointer, no retain), typically the
   child->parent or observer->subject link.
```

**Key Takeaways**

- Reference counting suits genuinely shared objects whose last user is not known in advance.
- Creation yields count 1; store means `retain`, finish means `release`; every retain needs exactly one matching release.
- One missing release leaks the object; one extra causes a use-after-free for every remaining owner.
- Cycles are never collected — break them with weak (non-counting) references in the back direction.
- Use `<stdatomic.h>` counters when the object crosses threads; atomics protect the count, not the contents.

> 🧪 Practice
>
> 1. Implement `sb_create`/`sb_retain`/`sb_release` and print the count after every operation for three owners.
> 2. Build a deliberate two-object cycle, confirm with Valgrind that both objects leak, then break it with a weak pointer.
> 3. Share one counted object across four threads that each retain, sleep, and release; run with `-fsanitize=thread` using a plain `int` count and then an `atomic_int`.
> 4. Interview-style: *"What can reference counting never reclaim, and how do real systems cope?"* Hint: draw two objects pointing at each other and total the counts.

#### Fragmentation

**Theory**

A long-running program can fail to allocate 1 MB while holding 500 MB of free memory. That is **fragmentation**: free memory exists, but not in the shape you need.

Two kinds, with different causes and different remedies:

**External fragmentation** — free memory is split into many small non-contiguous holes. A request larger than any single hole fails even though the total free space is ample. This is the classic problem, caused by allocating and freeing blocks of varied sizes in varied orders over a long period.

**Internal fragmentation** — memory wasted *inside* allocated blocks. Allocators round sizes up to size classes and add headers, so a 100-byte request may consume 128 bytes. Requesting many small blocks (`malloc(1)` a million times) can waste more memory than it uses.

```text
   EXTERNAL: total free = 300 bytes, but a 200-byte request FAILS

   [ used 100 ][ free 100 ][ used 50 ][ free 100 ][ used 80 ][ free 100 ]
                    ^^^                    ^^^                    ^^^
                    no single hole is large enough

   INTERNAL: you asked for 100, the allocator reserved 128

   [ hdr 16 | your 100 bytes | 12 wasted ]
```

Modern allocators (glibc's ptmalloc, jemalloc, tcmalloc, mimalloc) fight this hard: size classes group similar requests so freed blocks are reusable by like-sized ones, adjacent free chunks are coalesced, per-thread caches avoid contention, and large requests are served by `mmap` and returned directly to the kernel on `free`. As a result, catastrophic fragmentation is rare in ordinary desktop and server programs — but it remains a genuine risk in long-running processes with irregular allocation patterns, and in embedded systems with no virtual memory, where it is often the reason dynamic allocation is banned outright.

The strategies that actually help, roughly in order of effectiveness:

1. **Use pools for fixed-size objects.** Interchangeable slots make external fragmentation structurally impossible.
2. **Use arenas for phase-scoped work.** Freeing everything at once returns one large contiguous region, not a spray of holes.
3. **Allocate long-lived objects early**, before the heap becomes irregular, so they do not sit in the middle of otherwise-free space.
4. **Batch small allocations.** One block of 1000 records fragments far less than 1000 blocks, and saves 1000 headers.
5. **Reserve capacity up front** for growable buffers, avoiding the trail of abandoned intermediate blocks that doubling leaves behind.
6. **Reuse rather than reallocate.** Keep a free list of objects instead of returning them to the allocator.

A measurement caveat that saves a lot of confusion: RSS not falling after you free is usually *not* a leak and *not* fragmentation. `free` returns memory to the allocator, which keeps it for reuse; only large `mmap`-backed blocks go straight back to the kernel. Compare *allocator* statistics (`malloc_info`, `mallinfo2`, or jemalloc's stats) across time, not process RSS, before concluding anything.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Pattern 1: a fragmenting workload -- alternate sizes, free every other. */
static void fragmenting_pattern(void)
{
    enum { N = 1000 };
    void *blocks[N];

    for (int i = 0; i < N; i++)
        blocks[i] = malloc(i % 2 ? 64 : 1024);      /* alternating sizes */

    for (int i = 0; i < N; i += 2)
        free(blocks[i]);                            /* holes everywhere */

    /* The heap now looks like: [free][used][free][used]... */
    void *big = malloc(512 * 1024);
    printf("large request after fragmenting: %s\n", big ? "ok" : "FAILED");
    free(big);

    for (int i = 1; i < N; i += 2) free(blocks[i]);
}

/* Pattern 2: batching -- one allocation instead of N. */
typedef struct { int id; char name[28]; } Record;

static void batched(size_t n)
{
    Record *all = malloc(n * sizeof *all);   /* ONE block, ONE header */
    if (!all) return;
    for (size_t i = 0; i < n; i++) {
        all[i].id = (int)i;
        snprintf(all[i].name, sizeof all[i].name, "rec%zu", i);
    }
    printf("batched  : 1 allocation, %zu bytes, contiguous\n",
           n * sizeof *all);
    free(all);                                /* ONE free */
}

static void unbatched(size_t n)
{
    Record **all = malloc(n * sizeof *all);
    if (!all) return;
    for (size_t i = 0; i < n; i++) all[i] = malloc(sizeof **all);
    /* n+1 allocations, n headers (~16 bytes each), scattered addresses */
    printf("unbatched: %zu allocations, ~%zu bytes of headers alone\n",
           n + 1, n * 16);
    for (size_t i = 0; i < n; i++) free(all[i]);
    free(all);
}

/* Pattern 3: reuse instead of churn -- a tiny free list. */
typedef struct FreeNode { struct FreeNode *next; } FreeNode;
static FreeNode *recycled = NULL;

static Record *record_get(void)
{
    if (recycled) {                    /* reuse: no allocator involvement */
        FreeNode *n = recycled;
        recycled = n->next;
        return (Record *)n;
    }
    return malloc(sizeof(Record));
}

static void record_put(Record *r)
{
    FreeNode *n = (FreeNode *)r;       /* the slot is free: store 'next' in it */
    n->next = recycled;
    recycled = n;
}

int main(void)
{
    fragmenting_pattern();
    batched(1000);
    unbatched(1000);

    Record *a = record_get();
    record_put(a);
    Record *b = record_get();          /* the same block, no malloc call */
    printf("recycled the same block: %s\n", a == b ? "yes" : "no");
    record_put(b);
    while (recycled) { FreeNode *n = recycled; recycled = n->next; free(n); }
    return 0;
}
```

```bash
# Inspect what the allocator is actually holding (glibc):
$ MALLOC_STATS=1 ./prog      # or call malloc_stats() / mallinfo2() in code

# Try a different allocator without changing your program:
$ LD_PRELOAD=/usr/lib/libjemalloc.so ./prog
```

**Key Takeaways**

- External fragmentation is free memory split into unusable holes; internal fragmentation is space wasted inside allocated blocks by headers and rounding.
- Modern allocators mitigate both with size classes, coalescing, and thread caches, so severe fragmentation is mostly a long-running or embedded concern.
- Pools and arenas eliminate fragmentation structurally for their patterns — the strongest fix available.
- Batch small allocations, reserve capacity up front, allocate long-lived objects early, and recycle objects rather than churning the heap.
- Process RSS not shrinking after `free` is normal allocator behaviour, not proof of a leak — measure with allocator statistics instead.

> 🧪 Practice
>
> 1. Allocate 10,000 alternating 64-byte and 1 MB blocks, free every other one, then attempt a large allocation and report the result and the process RSS.
> 2. Compare total memory used by 100,000 individual `malloc(32)` calls against one `malloc(100000 * 32)`, and account for the difference.
> 3. Run a fragmenting workload under the default allocator and again under jemalloc via `LD_PRELOAD`, comparing peak RSS.
> 4. Interview-style: *"A server's memory usage plateaus at 3 GB and never drops despite freeing everything. Is that a leak?"* Hint: distinguish what `free` returns to the allocator from what the allocator returns to the kernel.

---

## 8. The Preprocessor

Before the compiler ever sees your code, a separate program rewrites it: the preprocessor pastes in headers, expands macros, and deletes the branches you told it to skip. It is a pure text transformer with no knowledge of C's types, scopes, or syntax, which makes it both remarkably powerful and uniquely dangerous. This chapter covers the directives you use daily, the conditional compilation that makes portable code possible, and the macro techniques — and traps — that separate robust codebases from ones nobody can debug.

<a id="81-directives"></a>
### 8.1 Directives

Preprocessor directives are lines beginning with `#` that instruct the preprocessor rather than the compiler. This section covers the four you will use constantly — `#include`, `#define` for constants and for macros, and `#undef` — plus the macros the implementation defines for you.

#### #include and Search Paths

**Theory**

C has no module system. There is no `import` that understands packages, no compiled interface file the compiler consults. Instead there is `#include`, and what it does is almost comically simple: **it replaces the directive line with the entire contents of the named file**, then continues preprocessing that text as though you had typed it.

That literal substitution explains everything about how C headers behave. A header is not "imported" — it is *pasted*. If two files include the same header, both get a full copy of its text. If a header includes another header, you get both, expanded in place. The compiler never learns that a file called `stdio.h` exists; it just sees several thousand lines of declarations at the top of your translation unit.

There are two spellings, and the difference is about *where the preprocessor looks*:

- `#include <stdio.h>` — angle brackets. Search the **system include directories**: the compiler's built-in paths (`/usr/include`, `/usr/local/include`, the toolchain's own directory) plus anything added with `-I`. Use this for the standard library and third-party libraries installed on the system.
- `#include "myheader.h"` — quotes. Search **the directory of the file doing the including first**, then fall back to the entire angle-bracket search path. Use this for headers belonging to your own project.

The rule of thumb is ownership: quotes for your code, angle brackets for everyone else's.

Because a header gets pasted wherever it is named, including one twice in a single translation unit duplicates every declaration in it — harmless for function prototypes, but a hard error for struct and enum definitions, which may not be repeated. Since headers include other headers, this happens constantly and by accident. The fix is an **include guard**: wrap the whole header in a conditional keyed on a unique macro, so the second and subsequent inclusions expand to nothing.

```c
#ifndef PROJECT_MODULE_H     /* first time: not defined, so continue */
#define PROJECT_MODULE_H     /* mark it, so next time we skip        */
/* ... contents ... */
#endif
```

Every header you write needs one. The near-universal alternative, `#pragma once`, is a single line supported by every mainstream compiler, but it is not in the C standard and it can misbehave when the same file is reachable through two paths (symlinks, bind mounts, hard links) since it identifies files by inode or path rather than by name. Include guards are the portable choice; many projects use both.

Two further disciplines pay off in real codebases. **Headers should be self-contained**: a header must include whatever it needs so that including it first, alone, compiles. And **include what you use**: do not rely on a header transitively dragging in `<stddef.h>` for you, because the day it stops doing so your build breaks for no visible reason.

**Examples**

```c
/* ---------- geometry.h : a well-formed header ---------- */
#ifndef GEOMETRY_H            /* include guard: unique name, often PATH_BASED */
#define GEOMETRY_H

#include <stddef.h>           /* self-contained: we use size_t below */

typedef struct { double x, y; } Point;      /* CANNOT be repeated: needs the guard */

double point_distance(Point a, Point b);    /* declarations may repeat harmlessly */
size_t point_hash(Point p);

#endif /* GEOMETRY_H */
```

```c
/* ---------- main.c ---------- */
#include <stdio.h>            /* angle: system/library headers */
#include <math.h>
#include "geometry.h"         /* quotes: this project's headers */
#include "geometry.h"         /* included AGAIN -- the guard makes it a no-op */

int main(void)
{
    Point a = {0.0, 0.0}, b = {3.0, 4.0};
    printf("distance = %.1f\n", point_distance(a, b));
    return 0;
}
```

Watching the substitution happen makes the mental model concrete:

```bash
# -E stops after preprocessing: no compilation, just the expanded text.
$ gcc -E main.c | wc -l
1247                          # our 12-line file became 1247 lines

# See exactly which files were pulled in, and how deeply nested:
$ gcc -H -fsyntax-only main.c
. /usr/include/stdio.h
.. /usr/include/x86_64-linux-gnu/bits/types.h
... /usr/include/x86_64-linux-gnu/bits/wordsize.h
. /usr/include/math.h
. geometry.h                   # one dot per nesting level

# Add a search directory for both forms:
$ gcc -Iinclude -Ivendor/lib/include main.c
```

```text
   WHY GUARDS ARE NOT OPTIONAL

   main.c
     |
     +-- #include "window.h" ---> #include "types.h"  --> typedef ... Point;
     |
     +-- #include "canvas.h" ---> #include "types.h"  --> typedef ... Point;
                                       ^
                                       |
                        Second expansion redefines Point.
                        Without a guard: "error: redefinition of 'Point'"
                        With a guard:    the second expansion is empty.
```

| | `#include <file.h>` | `#include "file.h"` |
|---|---|---|
| Searches first | system directories and `-I` paths | the including file's own directory |
| Falls back to | nothing further | the full system/`-I` search path |
| Intended for | standard library, installed third-party | headers inside your project |

**Key Takeaways**

- `#include` performs literal text substitution — the header's full contents replace the directive line, with no notion of modules or importing.
- Angle brackets search system and `-I` directories; quotes search the including file's directory first, then everything else.
- Every header needs an include guard (`#ifndef`/`#define`/`#endif`); repeated type definitions are an error, and nested includes make repetition inevitable.
- `#pragma once` is shorter and universally supported in practice, but non-standard and confusable by symlinks and duplicate paths.
- Make headers self-contained and include what you use, so a change in someone else's header cannot break your build.

> 🧪 Practice
>
> 1. Write a header defining a struct without a guard, include it twice from one `.c` file, and read the error. Then add the guard and confirm it compiles.
> 2. Run `gcc -E` on a file containing only `#include <stdio.h>` and `int main(void){return 0;}` and count the resulting lines. Then run `gcc -H` and identify the three most deeply nested headers.
> 3. Create `include/util.h` and compile a file that includes it as `"util.h"` with and without `-Iinclude`. Explain both outcomes.
> 4. Interview-style: *"What is the practical difference between `#include <x.h>` and `#include "x.h"`?"* Hint: describe the search order, and say what happens when the quoted form fails to find the file locally.

#### #define Object-Like Macros

**Theory**

An **object-like macro** gives a name to a piece of replacement text. Wherever the name appears as a separate token afterwards, the preprocessor substitutes the text.

```c
#define MAX_USERS 100
```

From that line onward, every `MAX_USERS` token becomes `100` before the compiler sees anything. The compiler never hears the name; error messages will talk about `100`.

The historical motivation was that C had no other way to write a compile-time constant usable in contexts that demand one — array sizes at file scope, `case` labels, bit-field widths. A `const int` variable in C is *not* a constant expression (unlike in C++), so `int buf[MAX];` with `const int MAX = 100;` is a VLA at best and an error at file scope. Macros filled that gap.

Three properties define how they behave, and each one is a source of surprise:

**The replacement is textual, not evaluated.** `#define AREA 3 + 4` makes `AREA * 2` expand to `3 + 4 * 2`, which is 11, not 14. The macro does not compute anything; it pastes tokens, and the surrounding operators then bind however C's precedence dictates. **Always parenthesize a replacement that is an expression**: `#define AREA (3 + 4)`.

**There is no type and no scope.** A macro is not a variable. It ignores blocks and functions entirely, is invisible to the debugger, and lives from its `#define` to the end of the file (or a `#undef`). This is why macro names are conventionally `SHOUTING_CASE` — the convention is the only warning a reader gets, and it also avoids colliding with ordinary identifiers.

**The definition ends at the newline.** Continue a long macro with a backslash at end of line. And note there is no semicolon: `#define N 100;` puts the semicolon into the expansion, so `int a[N];` becomes `int a[100;];`.

Since C99 and C11, macros have real competition for this job. **`enum` constants** are genuine integer constant expressions, are typed, are scoped, and are visible to the debugger — better than a macro for related integers. **`const`** objects work wherever a constant expression is not required, and carry a type the compiler can check. **`static const`** at file scope is the idiomatic choice for a floating-point constant. The remaining unambiguous macro territory is: integer constants needed in constant-expression contexts, string literals you want concatenated at compile time, and configuration values you want overridable from the build system with `-D`.

**Examples**

```c
#include <stdio.h>

/* --- good object-like macros ---------------------------------------- */
#define MAX_USERS      100
#define PI             3.14159265358979323846
#define GREETING       "Hello, "
#define APP_NAME       "demo"
#define BANNER         GREETING APP_NAME    /* literals concatenate */

/* Parenthesize any replacement that is an expression. */
#define BAD_SUM        3 + 4                /* dangerous */
#define GOOD_SUM      (3 + 4)               /* safe      */

/* A long definition continued with backslashes (no trailing backslash
   on the final line, and nothing after any backslash -- not even a space). */
#define VERSION_STRING "v" "1" "." "4" "." \
                       "2"

/* Overridable from the build: -DBUFFER_SIZE=8192 wins over this default. */
#ifndef BUFFER_SIZE
#  define BUFFER_SIZE 1024
#endif

int global_buffer[MAX_USERS];      /* a macro works where a const int cannot */

int main(void)
{
    printf("%s %s\n", BANNER, VERSION_STRING);
    printf("buffer size: %d\n", BUFFER_SIZE);

    /* The textual-substitution trap, demonstrated. */
    printf("BAD_SUM  * 2 = %d   (expands to 3 + 4 * 2)\n", BAD_SUM * 2);
    printf("GOOD_SUM * 2 = %d   (expands to (3 + 4) * 2)\n", GOOD_SUM * 2);

    /* Macros have no scope: this one is live from here to end of file. */
    #define LOCAL_LOOKING 5
    {
        int x = LOCAL_LOOKING;    /* the braces mean nothing to it */
        printf("x = %d\n", x);
    }
    printf("still visible: %d\n", LOCAL_LOOKING);

    double area = PI * 2.0 * 2.0;
    printf("area = %.4f\n", area);
    printf("array capacity = %zu\n", sizeof global_buffer / sizeof *global_buffer);
    return 0;
}
```

```text
   WHAT THE COMPILER ACTUALLY RECEIVES

   you write:                 preprocessor emits:
   ------------------------   ------------------------------
   BAD_SUM * 2                3 + 4 * 2          -> 11  (surprise)
   GOOD_SUM * 2               (3 + 4) * 2        -> 14  (intended)
   int a[MAX_USERS];          int a[100];
   BANNER                     "Hello, " "demo"   -> one literal
```

| Mechanism | Constant expression? | Typed | Scoped | Debugger sees it |
|---|---|---|---|---|
| `#define N 100` | yes | no | no | no |
| `enum { N = 100 };` | yes | `int` | yes | yes |
| `const int N = 100;` | **no** (in C) | yes | yes | yes |
| `static const double X = 1.5;` | no | yes | yes | yes |

**Key Takeaways**

- An object-like macro substitutes text; it does not evaluate, has no type, and obeys no scope or block structure.
- Parenthesize any replacement that is an expression, or surrounding operators will bind in ways you did not intend.
- Never end a macro definition with a semicolon, and continue long definitions with a trailing backslash.
- Prefer `enum` for related integer constants and `const` where a constant expression is not required — both are typed, scoped, and debuggable.
- Reserve macros for constant-expression contexts, string-literal building, and values the build system overrides with `-D`.

> 🧪 Practice
>
> 1. Define `#define SQUARE_SIDE 2 + 3` and print `SQUARE_SIDE * SQUARE_SIDE`. Predict the value first, then fix it with parentheses.
> 2. Define a constant three ways (`#define`, `enum`, `const int`) and try to use each as an array size at file scope. Explain which fail and why.
> 3. Add `#ifndef`-guarded defaults for two configuration macros, then override one with `-D` on the command line and verify with `gcc -E`.
> 4. Interview-style: *"Why is `const int N = 10;` not usable as an array size at file scope in C?"* Hint: consider the exact definition of "integer constant expression" and how C differs from C++ here.

#### Function-Like Macros

**Theory**

A macro can take parameters:

```c
#define SQUARE(x) ((x) * (x))
```

`SQUARE(5)` expands to `((5) * (5))`. This looks like a function call and is often described as one, but the resemblance is superficial and the differences cause most macro bugs.

A function-like macro is still pure text substitution. The arguments are **token sequences**, not values. They are not evaluated before substitution, they are not converted to a parameter type, and each one is pasted in wherever the parameter name appears — possibly several times, possibly zero times. There is no call, no stack frame, and no return value; the expansion simply becomes part of the surrounding expression.

Three rules follow directly, and skipping any of them produces a macro that works in testing and fails in production:

**Parenthesize every parameter, every time it appears.** Without it, an argument that is an expression gets torn apart by the surrounding operators. `#define SQUARE(x) x * x` turns `SQUARE(a + b)` into `a + b * a + b`.

**Parenthesize the entire replacement.** Without it, the macro's own result gets torn apart by operators around the call site. `#define DOUBLE(x) (x) + (x)` makes `DOUBLE(3) * 2` expand to `(3) + (3) * 2`, which is 9.

**Never use a parameter more than once if you can avoid it.** Because arguments are pasted, `MAX(i++, j)` may increment `i` twice. This is the multiple-evaluation problem, serious enough that it gets its own topic in 8.3.

Two syntactic gotchas are worth naming. There must be **no space between the macro name and the opening parenthesis** in the *definition*: `#define F (x) ...` defines an object-like macro whose replacement text starts with `(x)`. And a macro argument containing a top-level comma is split into two arguments, so `ASSERT_EQ(f(a, b), c)` is fine (the comma is inside parentheses) but `DECLARE(struct { int a, b; }, name)` is not — braces do not protect commas, only parentheses do.

Since C99, macros may be **variadic**: `...` in the parameter list collects the remaining arguments, and `__VA_ARGS__` expands to them. The classic problem — a trailing comma when zero variadic arguments are supplied — is solved by GNU's `, ##__VA_ARGS__` extension or, portably since C23, by `__VA_OPT__(,)`.

Given all this, when is a function-like macro the right tool? When you need something a function cannot do: operate on types rather than values, capture `__FILE__`/`__LINE__` from the call site, produce a compile-time constant, or generate code (see X-Macros in 8.3). For anything that is genuinely a computation, a `static inline` function is better in every respect — it is type-checked, evaluates each argument once, and modern compilers inline it just as effectively.

**Examples**

```c
#include <stdio.h>

/* --- correct: every parameter and the whole body parenthesized -------- */
#define SQUARE(x)     ((x) * (x))
#define MAX(a, b)     ((a) > (b) ? (a) : (b))
#define IS_EVEN(n)    (((n) % 2) == 0)

/* --- broken versions, for contrast ---------------------------------- */
#define BAD_SQUARE(x)  x * x           /* no parameter parens */
#define BAD_DOUBLE(x) (x) + (x)        /* no outer parens     */

/* --- variadic macro (C99) ------------------------------------------- */
#define LOG(fmt, ...) \
    fprintf(stderr, "[%s:%d] " fmt "\n", __FILE__, __LINE__, __VA_ARGS__)

/* GNU extension handles the zero-argument case by eating the comma. */
#define LOG_ANY(fmt, ...) \
    fprintf(stderr, "[%s:%d] " fmt "\n", __FILE__, __LINE__, ##__VA_ARGS__)

/* --- what a macro can do that a function cannot --------------------- */
#define ARRAY_LEN(a)  (sizeof (a) / sizeof (a)[0])   /* operates on a TYPE  */
#define STRINGIFY(x)  #x                             /* sees the TOKENS     */

/* --- what a function does better ------------------------------------ */
static inline int square_fn(int x) { return x * x; }  /* type-checked, one eval */

int main(void)
{
    printf("SQUARE(5)         = %d\n", SQUARE(5));
    printf("SQUARE(2 + 3)     = %d\n", SQUARE(2 + 3));       /* 25 */
    printf("BAD_SQUARE(2 + 3) = %d  <- expands to 2 + 3 * 2 + 3\n",
           BAD_SQUARE(2 + 3));                               /* 11 */

    printf("SQUARE(3) * 2     = %d\n", SQUARE(3) * 2);       /* 18 */
    printf("BAD_DOUBLE(3) * 2 = %d  <- expands to (3) + (3) * 2\n",
           BAD_DOUBLE(3) * 2);                               /* 9  */

    printf("MAX(10, 20) = %d\n", MAX(10, 20));

    int nums[] = {1, 2, 3, 4, 5};
    printf("ARRAY_LEN(nums) = %zu   (a function cannot do this)\n",
           ARRAY_LEN(nums));
    printf("STRINGIFY(a + b) = \"%s\"\n", STRINGIFY(a + b));

    LOG("started with %d items", 5);
    LOG_ANY("no arguments at all");
    printf("square_fn(7) = %d\n", square_fn(7));
    return 0;
}
```

```text
   EXPANSION, STEP BY STEP

   source:      SQUARE(2 + 3) * 2
   substitute:  ((2 + 3) * (2 + 3)) * 2
   compiler:    25 * 2 = 50                          correct

   source:      BAD_SQUARE(2 + 3) * 2       #define BAD_SQUARE(x) x * x
   substitute:  2 + 3 * 2 + 3 * 2
   compiler:    2 + 6 + 6 = 14                       silently wrong

   The macro never "computes" anything. It hands the compiler a token
   sequence, and C's precedence rules decide the meaning.
```

| | Function-like macro | `static inline` function |
|---|---|---|
| Argument type checking | none | full |
| Argument evaluation | once per textual use | exactly once |
| Can take a type as an argument | yes | no |
| Sees `__FILE__` / `__LINE__` of the caller | yes | no |
| Debugger steps into it | no | yes |
| Result usable as a constant expression | yes | no |

**Key Takeaways**

- A function-like macro substitutes token sequences; there is no call, no type checking, and no evaluation before substitution.
- Parenthesize every parameter use and the entire replacement body — omitting either lets surrounding operators corrupt the meaning.
- No space is allowed between the macro name and `(` in the definition, and top-level commas split arguments regardless of braces.
- Variadic macros use `...` and `__VA_ARGS__`; handle the empty case with `##__VA_ARGS__` (GNU) or `__VA_OPT__(,)` (C23).
- Use macros only for what functions cannot do — type operations, call-site metadata, constant expressions, code generation — and prefer `static inline` otherwise.

> 🧪 Practice
>
> 1. Write `#define CUBE(x) x * x * x`, evaluate `CUBE(1 + 1)`, explain the result, then fix it and verify with `gcc -E`.
> 2. Write `MIN(a, b)` correctly, then call it as `MIN(x++, y)` and describe exactly what the expansion does to `x`.
> 3. Write a variadic `LOG` macro that prints file and line, and make it work with zero variadic arguments both the GNU way and the C23 way.
> 4. Interview-style: *"Give a case where a function-like macro is strictly better than an inline function."* Hint: think about what information disappears once the compiler has parsed a call, and about `sizeof`.

#### #undef

**Theory**

`#undef NAME` removes a macro definition. From that line onward, `NAME` is an ordinary identifier again, and the preprocessor will not substitute anything for it.

Because macros ignore scope and persist to the end of the translation unit, `#undef` is the only way to bound one. That makes it the tool for a small set of specific jobs:

**Limiting a helper macro's blast radius.** A macro defined to generate a table or simplify a repetitive block should be undefined immediately after the block that needs it. Otherwise it leaks into every subsequent line of the file — and into every file that includes this one, if it lives in a header. A header that defines a macro named `MIN` and never undefines it will fight with everything else in the program.

**Redefining a macro.** Redefining a macro with different replacement text is a constraint violation (the compiler must diagnose it) unless the new definition is *identical*, token for token. `#undef` first, then define again, and it is legal.

**Neutralizing an implementation's macro.** Standard library functions are permitted to be implemented as macros as well as functions — `getchar`, `putc`, `isdigit`, and `assert` commonly are. Occasionally you need the real function: to take its address, or to defeat a macro that expands its argument twice. `#undef getchar` exposes the underlying function, since the standard guarantees one exists.

**Disabling `assert`.** `<assert.h>` is designed to be included repeatedly with `NDEBUG` toggled in between; it undefines and redefines `assert` each time.

`#undef` on a name that is not defined is explicitly legal and does nothing, so defensive `#undef` before `#define` is safe. One caution: you may not `#undef` names the standard reserves — `defined`, and, in strict terms, standard library macro names in headers you have included, though implementations tolerate most of it.

The overall guidance is simple: if a macro is a local implementation detail, undefine it as soon as you are done. If it is part of your module's public interface, name it with a project prefix so it cannot collide, and leave it defined.

**Examples**

```c
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    /* --- bounding a helper macro's lifetime -------------------------- */
    #define ROW(label, value)  printf("%-10s %d\n", (label), (value));

    ROW("alpha", 1)
    ROW("beta",  2)
    ROW("gamma", 3)

    #undef ROW              /* the helper cannot leak past this point   */
    /* ROW("delta", 4);        would now be an "undeclared" error       */

    /* --- redefinition requires an intervening #undef ----------------- */
    #define LIMIT 100
    printf("LIMIT = %d\n", LIMIT);
    /* #define LIMIT 200      <- ERROR: incompatible redefinition       */
    #undef LIMIT
    #define LIMIT 200         /* legal now                              */
    printf("LIMIT = %d\n", LIMIT);

    /* --- getting the real function behind a library macro ------------ */
    printf("isdigit('7') via macro = %d\n", isdigit('7'));
    #undef isdigit            /* the standard guarantees a real function too */
    printf("isdigit('7') via func  = %d\n", isdigit('7'));

    /* A function pointer requires the function, not the macro. */
    int (*classify)(int) = isdigit;
    printf("through a pointer      = %d\n", classify('7'));

    /* --- #undef of an undefined name is legal and does nothing ------- */
    #undef NEVER_DEFINED_ANYWHERE
    return 0;
}
```

A header that defines a helper for its own declarations must clean up after itself:

```c
/* ---------- events.h ---------- */
#ifndef EVENTS_H
#define EVENTS_H

/* A local generator macro -- an implementation detail of this header. */
#define DECLARE_EVENT(name) void on_##name(int code);

DECLARE_EVENT(open)      /* void on_open(int code);   */
DECLARE_EVENT(close)     /* void on_close(int code);  */
DECLARE_EVENT(error)     /* void on_error(int code);  */

#undef DECLARE_EVENT     /* ESSENTIAL: do not export it to every includer */

#endif /* EVENTS_H */
```

```text
   MACRO LIFETIME IN A TRANSLATION UNIT

   line 1   ................................  ROW undefined
   line 12  #define ROW(...)   ------+
   line 14  ROW(alpha, 1)            | ROW is live here
   line 16  ROW(gamma, 3)            |
   line 18  #undef ROW         ------+
   line 20  ................................  ROW undefined again
   EOF

   Without the #undef, the bar extends to EOF -- and, from a header,
   into every file that includes it.
```

**Key Takeaways**

- `#undef NAME` ends a macro's definition; it is the only way to bound a macro, which otherwise lives to the end of the translation unit.
- Redefining a macro with different text is an error unless you `#undef` it first; an identical redefinition is permitted.
- Always `#undef` helper macros defined inside a header, or they leak into every file that includes it.
- Standard library facilities may be macros; `#undef` exposes the guaranteed real function, which you need to take its address.
- `#undef` on an undefined name is legal and harmless, so a defensive `#undef` before `#define` costs nothing.

> 🧪 Practice
>
> 1. Define a macro, use it, `#undef` it, then use it again and read the error message. Explain what the compiler now thinks the name is.
> 2. Try to redefine a macro with different replacement text without `#undef`, then with it, and compare the diagnostics.
> 3. Write a header that uses a generator macro to declare five functions and undefines it at the end; verify with `gcc -E` that the macro is gone from the output.
> 4. Interview-style: *"Why might you `#undef` a standard library name like `getchar`?"* Hint: consider what the standard permits an implementation to do, and what you cannot do with a macro.

#### Predefined Macros

**Theory**

The preprocessor defines a set of macros for you. They are the only way your source code can learn about *itself* — where a line came from, when it was built, which standard and compiler are in use — and they are the raw material of assertions, logging, and portable code.

The standard mandates a small, reliable set:

| Macro | Expands to |
|---|---|
| `__FILE__` | the current source file name, as a string literal |
| `__LINE__` | the current line number, as an integer constant |
| `__DATE__` | compilation date, `"Mmm dd yyyy"` |
| `__TIME__` | compilation time, `"hh:mm:ss"` |
| `__STDC__` | `1` in a conforming implementation |
| `__STDC_VERSION__` | the standard revision, e.g. `201112L` for C11 |
| `__STDC_HOSTED__` | `1` for a hosted implementation, `0` for freestanding |

C99 added `__func__`, which is worth a special note: it is **not a macro**. It is a predefined identifier — a `static const char[]` holding the enclosing function's name, declared implicitly at the top of every function body. The practical consequence is that it does not concatenate with adjacent string literals the way `__FILE__` does, so `"in " __func__` fails to compile while `"in " __FILE__` works.

Compilers and platforms add many more, and this is what makes conditional compilation possible: `__GNUC__`, `__clang__`, `_MSC_VER` identify the compiler; `__linux__`, `_WIN32`, `__APPLE__` identify the OS; `__x86_64__`, `__aarch64__` identify the architecture. These are not standardized, so relying on them is inherently a portability decision — covered properly in 8.2.

`__LINE__` and `__FILE__` are the reason certain facilities must be macros. `assert(x)` reports the file and line of the *failing assertion*, not of the assert implementation, because the macro captures them at the expansion site. A function receiving `x` could never know where it was called from. The same trick underlies every serious logging macro.

Two practical warnings. `__DATE__` and `__TIME__` embed the build timestamp, which destroys **reproducible builds** — the same source produces different binaries — so many projects ban them or override them with a fixed value. And you can query everything a compiler defines, which is far more useful than memorizing lists:

```bash
$ gcc -dM -E - < /dev/null | sort | head
```

**Examples**

```c
#include <stdio.h>

/* __FILE__ and __LINE__ are captured where the macro is EXPANDED,
   which is exactly why this cannot be a function. */
#define LOG(msg) \
    printf("%s:%d in %s(): %s\n", __FILE__, __LINE__, __func__, (msg))

#define TRACE_HERE() \
    printf("reached %s:%d\n", __FILE__, __LINE__)

static void worker(void)
{
    LOG("inside worker");          /* reports worker's line, not LOG's */
}

int main(void)
{
    printf("file      : %s\n", __FILE__);
    printf("line      : %d\n", __LINE__);
    printf("function  : %s\n", __func__);      /* an identifier, not a macro */
    printf("built     : %s %s\n", __DATE__, __TIME__);

    /* __FILE__ is a string literal, so it concatenates: */
    puts("compiled from " __FILE__);
    /* puts("inside " __func__);   <- ERROR: __func__ is not a literal */

#ifdef __STDC_VERSION__
    printf("standard  : %ldL\n", __STDC_VERSION__);
#else
    printf("standard  : C89/C90\n");
#endif

#if defined(__clang__)
    printf("compiler  : clang %d.%d\n", __clang_major__, __clang_minor__);
#elif defined(__GNUC__)
    printf("compiler  : gcc %d.%d\n", __GNUC__, __GNUC_MINOR__);
#elif defined(_MSC_VER)
    printf("compiler  : MSVC %d\n", _MSC_VER);
#else
    printf("compiler  : unknown\n");
#endif

    TRACE_HERE();
    worker();
    return 0;
}
```

Typical output:

```text
file      : macros.c
line      : 20
function  : main
built     : Sep  8 2026 14:02:11
compiled from macros.c
standard  : 201710L
compiler  : gcc 13.3
reached macros.c:41
macros.c:14 in worker(): inside worker
```

| Standard version | `__STDC_VERSION__` |
|---|---|
| C89 / C90 | not defined |
| C95 (amendment 1) | `199409L` |
| C99 | `199901L` |
| C11 | `201112L` |
| C17 / C18 | `201710L` |
| C23 | `202311L` |

```bash
# List every macro your compiler predefines (hundreds of them):
$ gcc -dM -E - < /dev/null | wc -l
396
$ gcc -dM -E - < /dev/null | grep -E '__(linux|x86_64|GNUC)__'
#define __linux__ 1
#define __x86_64__ 1
#define __GNUC__ 13

# Override the build timestamp for reproducible builds:
$ SOURCE_DATE_EPOCH=1700000000 gcc prog.c -o prog
```

**Key Takeaways**

- `__FILE__`, `__LINE__`, `__DATE__`, `__TIME__`, `__STDC__`, and `__STDC_VERSION__` are standard and always available in a conforming implementation.
- `__func__` is a predefined *identifier*, not a macro, so it cannot be concatenated with string literals.
- Capturing `__FILE__` and `__LINE__` at the expansion site is precisely why `assert` and logging facilities must be macros.
- Compiler, OS, and architecture macros (`__GNUC__`, `__linux__`, `_WIN32`, `__x86_64__`) are implementation-defined but essential for portable code.
- `__DATE__` and `__TIME__` break reproducible builds; use `gcc -dM -E - < /dev/null` to discover what a toolchain actually defines.

> 🧪 Practice
>
> 1. Write a `LOG` macro using `__FILE__`, `__LINE__`, and `__func__`, call it from three different functions, and confirm each reports its own location.
> 2. Try to write `puts("in " __func__);` and `puts("in " __FILE__);`. Explain why exactly one compiles.
> 3. Run `gcc -dM -E - < /dev/null` and find the macros identifying your OS, architecture, compiler version, and pointer size.
> 4. Interview-style: *"Why must `assert` be a macro rather than a function?"* Hint: think about what the failure message must contain and where that information exists.

<a id="82-conditional-compilation"></a>
### 8.2 Conditional Compilation

Conditional directives let the preprocessor delete regions of code before the compiler sees them, which is how one source tree builds for several platforms, standards, and configurations. This section covers the conditional directives themselves, the feature test macros that gate library functionality, platform detection, debug versus release builds, and the diagnostic directives.

#### #if, #ifdef, #ifndef, #else, #elif

**Theory**

Conditional compilation answers a question `if` cannot: **should this code exist at all?** A run-time `if` requires every branch to compile — every function it calls must be declared, every type must be defined, every symbol must link. That is impossible when one branch calls a Windows API and the other calls a POSIX one, or when a branch uses a C11 feature on a C89 compiler.

Conditional directives operate a step earlier. The preprocessor evaluates the condition and passes only the surviving branch to the compiler. The other branch is deleted as text: it may reference undeclared functions, use unsupported syntax, or be complete nonsense for the current target, and nothing will complain. It is not compiled, so it does not have to be compilable.

The family:

- **`#ifdef NAME`** — true if `NAME` is defined as a macro, regardless of its value.
- **`#ifndef NAME`** — true if it is not. The basis of include guards.
- **`#if expr`** — true if the constant integer expression `expr` is non-zero.
- **`#elif expr`**, **`#else`**, **`#endif`** — chain and terminate.
- **`defined(NAME)`** — an operator usable inside `#if`, so you can combine tests: `#if defined(A) && !defined(B)`.

The `#if` expression evaluator has its own rules, and they are a common source of confusion:

- It handles **integer arithmetic only** — no floating point, no `sizeof`, no casts, no enum constants (those are compiler-level, and the preprocessor runs first), no string comparison.
- **Any identifier that is not a defined macro becomes `0`.** This is silent and is the single biggest hazard: a typo in `#if VERSON > 2` evaluates as `0 > 2` and quietly takes the wrong branch with no diagnostic. Use `#if defined(X) && X > 2` when the distinction matters, and turn on `-Wundef` so the compiler warns about undefined identifiers in `#if`.
- Arithmetic uses the widest integer type available, and `#if 1/0` is an error, not undefined behaviour.

Choosing between the forms: use `#ifdef`/`#ifndef` when only existence matters (include guards, feature presence). Use `#if` when a *value* matters, or when you need boolean combinations — `#ifdef` cannot express `&&`. Note also that `#if 0 ... #endif` is the correct way to comment out a block of code that itself contains comments, since C comments do not nest. The skipped text still has to be *tokenizable* — an unterminated quote or comment inside it is an error — but it need not be valid C.

Finally, keep in mind that conditionals multiply. Three independent two-way conditionals produce eight possible builds, of which your CI probably compiles one. Code inside an unusual branch rots silently. The practical mitigation is to isolate platform differences behind a small internal interface implemented once per platform, rather than sprinkling `#ifdef` through the logic.

**Examples**

```c
#include <stdio.h>

#define FEATURE_LOGGING 1
#define MAX_CONNECTIONS 50
/* VERBOSE is deliberately left undefined */

int main(void)
{
    /* --- #ifdef: existence only -------------------------------------- */
#ifdef FEATURE_LOGGING
    printf("logging is compiled in\n");
#else
    /* This branch is DELETED. It could contain anything. */
    printf("logging disabled\n");
#endif

    /* --- #if: the value matters -------------------------------------- */
#if MAX_CONNECTIONS > 100
    printf("high-capacity build\n");
#elif MAX_CONNECTIONS > 10
    printf("standard build (%d connections)\n", MAX_CONNECTIONS);
#else
    printf("minimal build\n");
#endif

    /* --- combining tests, which #ifdef cannot express ---------------- */
#if defined(FEATURE_LOGGING) && !defined(QUIET_MODE)
    printf("verbose logging active\n");
#endif

    /* --- THE HAZARD: an undefined identifier silently becomes 0 ------ */
#if VERBOSE                       /* VERBOSE is not defined -> 0 -> false */
    printf("this never prints, and nothing warns you\n");
#endif

#if defined(VERBOSE) && VERBOSE   /* explicit and safe */
    printf("also never prints, but the intent is clear\n");
#endif

    /* --- #if 0 to disable a block containing comments ---------------- */
#if 0
    printf("dead code\n");        /* a comment in here is harmless */
    this does not have to be valid C, only tokenizable;
#endif

    return 0;
}
```

```bash
# -Wundef turns the silent-zero hazard into a diagnostic:
$ gcc -Wundef prog.c
prog.c:31:5: warning: "VERBOSE" is not defined, evaluates to 0 [-Wundef]

# See which branch survived -- the definitive way to debug a conditional:
$ gcc -E prog.c | grep -n printf
```

```text
   WHAT THE COMPILER RECEIVES

   source                          after preprocessing
   ------------------------------  ---------------------------------
   #ifdef FEATURE_LOGGING
       printf("logging in\n");     ->  printf("logging in\n");
   #else
       printf("disabled\n");       ->  (deleted entirely -- never parsed,
   #endif                               never type-checked, never linked)

   This is why the dead branch may call functions that do not exist on
   this platform: the compiler never sees it.
```

| Form | Tests | Use for |
|---|---|---|
| `#ifdef NAME` | is `NAME` defined | feature/platform presence, include guards |
| `#ifndef NAME` | is `NAME` not defined | include guards, default definitions |
| `#if expr` | integer value of `expr` | version numbers, sizes, boolean combinations |
| `#if defined(A) \|\| defined(B)` | either defined | multi-platform grouping |

**Key Takeaways**

- Conditional directives delete code before compilation, so the discarded branch need not be valid for the current platform — something run-time `if` can never do.
- Use `#ifdef`/`#ifndef` when only existence matters, `#if` when a value matters or you need `&&`/`||`.
- The `#if` evaluator handles integers only: no `sizeof`, no floats, no enum constants, no string comparison.
- Undefined identifiers silently evaluate to `0` in `#if` — build with `-Wundef` and prefer `#if defined(X) && X`.
- Conditionals multiply build configurations exponentially; isolate platform differences behind a small interface instead of scattering `#ifdef`.

> 🧪 Practice
>
> 1. Write a file with three mutually exclusive `#if`/`#elif`/`#else` branches keyed on a `LEVEL` macro, and use `gcc -E` to confirm exactly one survives at each `-DLEVEL=` value.
> 2. Misspell a macro name inside an `#if` and observe that the code compiles and takes the wrong branch. Then add `-Wundef` and fix it.
> 3. Put deliberately invalid C inside `#if 0` and confirm it compiles; then change it to `#if 1` and read the errors.
> 4. Interview-style: *"Why can't you replace `#ifdef _WIN32` with a normal `if` statement?"* Hint: consider what has to be true of both branches for the file to compile at all.

#### Feature Test Macros

**Theory**

Standard C is a small language, and its headers are required to declare *only* what the standard specifies. But `<stdio.h>` on Linux also has `popen`, `<string.h>` has `strdup`, and `<unistd.h>` exists at all — none of which are standard C. How does one header serve both a strict-conformance build and a POSIX build?

The answer is **feature test macros**: macros you define *before* including any header, which the implementation's headers examine to decide what to declare. They are a request, made at the top of your file or on the command line, for a particular set of extensions.

The mechanism matters more than the list. Inside glibc's headers, roughly:

```c
#ifdef _POSIX_C_SOURCE
extern int fileno(FILE *);      /* declared only if POSIX was requested */
#endif
```

So if you forget the macro, the declaration simply does not exist. In C89 that produced an implicit declaration and a link that often worked by accident; in C99 and later it is an error, which is a considerable improvement.

The macros you will actually meet:

| Macro | Requests |
|---|---|
| `_POSIX_C_SOURCE 200809L` | POSIX.1-2008 (`fileno`, `strdup`, `getline`, `nanosleep`) |
| `_XOPEN_SOURCE 700` | X/Open 7 — POSIX plus XSI extensions (`strptime`, `crypt`) |
| `_GNU_SOURCE` | everything glibc offers, including GNU-only functions |
| `_DEFAULT_SOURCE` | glibc's default set (BSD and SVID additions) |
| `__STDC_WANT_LIB_EXT1__ 1` | C11 Annex K bounds-checked functions (`memcpy_s`) |

Two rules make them work, and violating either produces baffling results:

**Define before any `#include`.** The headers test the macro as they are processed; defining it afterwards has no effect on headers already expanded. Because a header you include might itself include `<features.h>`, the safe place is the very first line of the file — or, better, the compiler command line (`-D_POSIX_C_SOURCE=200809L`), which guarantees it for every file in the build.

**Define it consistently across the whole project.** Different translation units seeing different declarations of the same structure is a recipe for silent ABI mismatches.

There is also a converse relationship worth understanding: `-std=c11` selects strict conformance and *disables* the default extensions, whereas `-std=gnu11` enables them. So a file that compiles with `gcc prog.c` may fail with `gcc -std=c11 prog.c` — the classic "it worked yesterday" symptom, fixed by adding the appropriate feature test macro rather than by abandoning `-std=c11`.

Note the naming convention: the leading underscore plus capital letter marks these as reserved identifiers, which is precisely why the implementation may use them and why you must never invent your own names in that space.

**Examples**

```c
/* The feature test macro MUST come before every #include. */
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>          /* POSIX: only usable because of the macro above */

int main(void)
{
    /* strdup is POSIX, not standard C: without the macro, this fails to
       compile under -std=c11 with "implicit declaration of function". */
    char *copy = strdup("duplicated with a POSIX function");
    if (!copy) return EXIT_FAILURE;
    puts(copy);
    free(copy);

    /* fileno is POSIX too. */
    printf("stdout file descriptor = %d\n", fileno(stdout));

    /* getline is POSIX.1-2008: reads an arbitrarily long line, allocating. */
    printf("enter a line: ");
    char  *line = NULL;
    size_t cap  = 0;
    ssize_t len = getline(&line, &cap, stdin);
    if (len > 0) printf("read %zd bytes: %s", len, line);
    free(line);

    /* Report which feature sets the headers were compiled with. */
#ifdef _POSIX_C_SOURCE
    printf("_POSIX_C_SOURCE = %ldL\n", (long)_POSIX_C_SOURCE);
#endif
#ifdef _GNU_SOURCE
    printf("_GNU_SOURCE is defined\n");
#endif
    return 0;
}
```

```bash
# Strict C11: POSIX functions are hidden, so this FAILS without the macro.
$ gcc -std=c11 -Wall prog.c
prog.c: warning: implicit declaration of function 'strdup'

# Two equivalent fixes -- the second is preferred for whole projects:
$ gcc -std=c11 -D_POSIX_C_SOURCE=200809L prog.c     # request POSIX
$ gcc -std=gnu11 prog.c                             # GNU dialect, extensions on

# Prove the mechanism: ask whether the declaration is even present.
$ echo '#include <string.h>' | gcc -std=c11 -E - | grep -c strdup
0
$ echo '#include <string.h>' | gcc -std=c11 -D_POSIX_C_SOURCE=200809L -E - | grep -c strdup
1
```

```text
   HOW A HEADER DECIDES WHAT TO DECLARE

   your file                  glibc <string.h>
   ---------------------      -----------------------------------
   #define _POSIX_C_SOURCE    #if defined(_POSIX_C_SOURCE) && \
             200809L               _POSIX_C_SOURCE >= 200809L
   #include <string.h>  --->  extern char *strdup(const char *);
                              #endif
                              extern void *memcpy(...);   /* always */

   Define the macro AFTER the include and the #if has already been
   evaluated -- the declaration never appears, and nothing warns you.
```

**Key Takeaways**

- Feature test macros tell implementation headers which non-standard declarations to expose; without them, the declarations do not exist.
- They must be defined before any `#include` — the first line of the file, or better, on the compiler command line for the whole project.
- `_POSIX_C_SOURCE`, `_XOPEN_SOURCE`, and `_GNU_SOURCE` request progressively larger sets; define one consistently across all translation units.
- `-std=c11` disables extensions while `-std=gnu11` enables them, which is why the same code can compile under one and not the other.
- The leading-underscore-capital naming marks these as reserved to the implementation; never invent identifiers in that space.

> 🧪 Practice
>
> 1. Compile a program calling `strdup` with `-std=c11` alone, then with `-D_POSIX_C_SOURCE=200809L`, and explain both results.
> 2. Move the `#define _POSIX_C_SOURCE` line to *after* `#include <string.h>` and explain why it stops working.
> 3. Use `gcc -E` to prove that `getline`'s declaration appears only when the feature test macro is set.
> 4. Interview-style: *"A colleague's file compiles with `gcc file.c` but fails with `gcc -std=c11 file.c`. What is happening?"* Hint: think about what the default dialect enables that strict conformance does not.

#### Platform-Specific Code

**Theory**

Portable C does not mean code that avoids platform differences — it means code that *isolates* them. Every non-trivial program eventually needs something the standard does not provide: sleeping, listing a directory, querying the terminal size. Conditional compilation is how you supply each platform's version while keeping one source tree.

Detection relies on macros the compiler predefines. They are not standardized, but they are stable and well-documented in practice:

| Category | Macro | Meaning |
|---|---|---|
| OS | `_WIN32` | Windows (32- **and** 64-bit; `_WIN64` adds 64-bit) |
| | `__linux__` | Linux |
| | `__APPLE__` | macOS / iOS (with `TargetConditionals.h` to distinguish) |
| | `__unix__` | Unix-like generally |
| | `__FreeBSD__`, `__ANDROID__` | as named |
| Compiler | `__GNUC__` | GCC — **also defined by Clang and ICC** |
| | `__clang__` | Clang specifically; test it *before* `__GNUC__` |
| | `_MSC_VER` | MSVC, with the version as the value |
| Architecture | `__x86_64__`, `__i386__`, `__aarch64__`, `__arm__` | as named |
| Word size | `__SIZEOF_POINTER__`, `UINTPTR_MAX` | pointer width |

Two detection traps recur constantly. `_WIN32` is defined on 64-bit Windows too, so `#ifdef _WIN32` is the correct test for "Windows" and `_WIN64` narrows it. And Clang defines `__GNUC__` for compatibility, so an `#elif defined(__GNUC__)` chain must test `__clang__` first or Clang will silently take the GCC branch.

The design question is *where* the conditionals go, and this matters far more than the detection details. Scattering `#ifdef` through business logic produces code that nobody can read and that only ever compiles on the maintainer's machine. The disciplined pattern is a **thin platform layer**: define a small portable interface, and implement it once per platform, with the conditionals confined to that one file. The rest of the program calls `platform_sleep_ms` and never mentions an operating system.

Where a conditional chain must appear inline, always end it with an `#else` that produces a compile error via `#error` (see below). Silently compiling nothing on an unrecognized platform turns a five-second build failure into a mysterious run-time bug.

A useful check on your own design: if a header contains `#ifdef _WIN32` around a *struct definition*, different platforms see different layouts of the same type — which is exactly what you want in a platform layer and exactly what causes chaos when it leaks into a public interface.

**Examples**

```c
/* ---------- platform.h : the portable interface, no #ifdef ---------- */
#ifndef PLATFORM_H
#define PLATFORM_H

#include <stddef.h>

void   platform_sleep_ms(unsigned ms);
size_t platform_page_size(void);
const char *platform_name(void);

#endif
```

```c
/* ---------- platform.c : every conditional lives HERE ---------------- */
#include "platform.h"

#if defined(_WIN32)
#  include <windows.h>
#elif defined(__unix__) || defined(__APPLE__)
#  include <unistd.h>
#  include <time.h>
#else
#  error "Unsupported platform: add an implementation in platform.c"
#endif

void platform_sleep_ms(unsigned ms)
{
#if defined(_WIN32)
    Sleep(ms);                                   /* milliseconds */
#else
    struct timespec ts = { ms / 1000u, (long)(ms % 1000u) * 1000000L };
    nanosleep(&ts, NULL);                        /* seconds + nanoseconds */
#endif
}

size_t platform_page_size(void)
{
#if defined(_WIN32)
    SYSTEM_INFO si;
    GetSystemInfo(&si);
    return (size_t)si.dwPageSize;
#else
    return (size_t)sysconf(_SC_PAGESIZE);
#endif
}

const char *platform_name(void)
{
    /* Order matters: test the MOST specific macro first. */
#if defined(_WIN64)
    return "Windows (64-bit)";
#elif defined(_WIN32)
    return "Windows (32-bit)";
#elif defined(__APPLE__)
    return "macOS";
#elif defined(__ANDROID__)          /* before __linux__: Android defines both */
    return "Android";
#elif defined(__linux__)
    return "Linux";
#else
    return "unknown";
#endif
}
```

```c
/* ---------- main.c : completely platform-agnostic -------------------- */
#include <stdio.h>
#include "platform.h"

int main(void)
{
    printf("platform  : %s\n", platform_name());
    printf("page size : %zu bytes\n", platform_page_size());

    /* Compiler identification: __clang__ MUST be tested before __GNUC__,
       because Clang also defines __GNUC__ for compatibility. */
#if defined(__clang__)
    printf("compiler  : clang\n");
#elif defined(__GNUC__)
    printf("compiler  : gcc\n");
#elif defined(_MSC_VER)
    printf("compiler  : msvc\n");
#endif

    printf("sleeping 100 ms...\n");
    platform_sleep_ms(100);
    puts("done");
    return 0;
}
```

```text
   TWO WAYS TO ORGANIZE THE SAME DIFFERENCES

   SCATTERED (avoid)              ISOLATED (prefer)

   business.c                     business.c
     #ifdef _WIN32 ...              platform_sleep_ms(100);
     logic                          logic
     #ifdef _WIN32 ...              platform_page_size();
     more logic                     more logic
     #ifdef __linux__ ...                 |
                                          v
   Every reader must mentally      platform.c  <- ALL #ifdef here
   run three builds at once.       platform.h  <- one clean interface
```

**Key Takeaways**

- Platform detection uses compiler-predefined macros; `_WIN32` covers 64-bit Windows too, and Clang also defines `__GNUC__`.
- Order conditional chains from most specific to least specific: `__clang__` before `__GNUC__`, `__ANDROID__` before `__linux__`, `_WIN64` before `_WIN32`.
- Confine conditionals to a thin platform layer with a portable interface, rather than scattering them through application logic.
- Always terminate a platform chain with `#else #error`, so an unsupported target fails at build time rather than at run time.
- Code inside a branch you never build will rot — compile every supported configuration in CI.

> 🧪 Practice
>
> 1. Write `platform_name()` covering Windows, macOS, and Linux, and verify with `gcc -E` which branch survives on your machine.
> 2. Write a chain testing `__GNUC__` before `__clang__`, compile with Clang, and explain the result. Then fix the order.
> 3. Implement a two-function platform layer (sleep and page size) with a header containing no conditionals at all, and confirm `main.c` has no platform macros.
> 4. Interview-style: *"How would you structure a codebase supporting three operating systems?"* Hint: think about where the conditionals live and how many files a reader must open to understand one function.

#### Debug and Release Builds

**Theory**

The same source should produce two rather different programs: a debug build that checks assumptions aggressively and explains itself, and a release build that is fast and quiet. Conditional compilation is what makes both come from one source tree, with the difference driven entirely by macros the build system defines.

The one standardized mechanism is **`NDEBUG` and `assert`**. `<assert.h>` defines `assert(expr)` to evaluate `expr` and abort with a message naming the file, line, and expression if it is false — unless `NDEBUG` is defined, in which case `assert` expands to a do-nothing expression. So a release build adds `-DNDEBUG` and every assertion vanishes, costing nothing.

That design has one consequence you must internalize: **never put a side effect inside `assert`.**

```c
assert(pop_item() != NULL);   /* the item is never popped in release builds */
```

The assertion is the *entire* statement, so when it disappears, so does the call. Assertions must be pure checks.

The complementary rule is about *what* to assert. Assertions document **programmer errors** — conditions that must hold if the code is correct: a non-null internal pointer, an index within bounds, an invariant after a rebalance. They are not error handling. A failed file open, a malformed input line, or a failed allocation are **run-time conditions** that occur in correct programs and must be handled with real code that survives into release.

Beyond `assert`, projects define their own build-mode macros — conventionally `DEBUG`, or a project-prefixed name — to gate logging, extra validation, expensive invariant checks, and diagnostic output. The pattern that keeps this maintainable is a debug macro that **compiles away to nothing in release but still parses in both modes**, so the disabled code cannot rot. `do { } while (0)` (see 8.3) is the standard shape, and passing arguments to a `(void)` expression keeps unused-variable warnings quiet.

A typical flag pairing:

| | Debug | Release |
|---|---|---|
| Optimization | `-O0` (or `-Og`) | `-O2` / `-O3` |
| Debug info | `-g3` | `-g` (kept, then stripped or shipped separately) |
| Assertions | on (no `NDEBUG`) | off (`-DNDEBUG`) |
| Sanitizers | `-fsanitize=address,undefined` | none |
| Hardening | — | `-D_FORTIFY_SOURCE=3 -fstack-protector-strong` |

Two cautions. First, keep `-Wall -Wextra` on in *both* modes: some warnings only appear with optimization enabled, because they depend on data-flow analysis. Second, remember that debug and release are genuinely different programs — a bug that appears only in release usually means undefined behaviour whose symptoms changed, not a compiler bug.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

/* A debug-only logging macro. In release it becomes a (void)0 expression
   that still TYPE-CHECKS its arguments, so disabled code cannot rot. */
#ifdef DEBUG
#  define DBG(fmt, ...) \
       fprintf(stderr, "[debug %s:%d] " fmt "\n", __FILE__, __LINE__, ##__VA_ARGS__)
#  define DBG_ONLY(stmt) stmt
#else
#  define DBG(fmt, ...) ((void)0)
#  define DBG_ONLY(stmt) ((void)0)
#endif

/* An expensive invariant check that only exists in debug builds. */
static int is_sorted(const int *a, size_t n)
{
    for (size_t i = 1; i < n; i++)
        if (a[i - 1] > a[i]) return 0;
    return 1;
}

static int binary_search(const int *a, size_t n, int key)
{
    /* Programmer errors: these must hold if the caller is correct. */
    assert(a != NULL);
    assert(is_sorted(a, n));          /* O(n) check, debug builds only */

    size_t lo = 0, hi = n;
    while (lo < hi) {
        size_t mid = lo + (hi - lo) / 2;
        DBG("probing index %zu (value %d)", mid, a[mid]);
        if (a[mid] == key) return (int)mid;
        if (a[mid] < key) lo = mid + 1;
        else              hi = mid;
    }
    return -1;
}

int main(int argc, char **argv)
{
    int data[] = {1, 3, 5, 7, 9, 11};

    /* A RUN-TIME condition: handled properly, survives into release. */
    if (argc > 2) {
        fprintf(stderr, "usage: %s [key]\n", argv[0]);
        return EXIT_FAILURE;
    }

    int key = (argc == 2) ? atoi(argv[1]) : 7;
    DBG_ONLY(printf("searching for %d in %zu elements\n",
                    key, sizeof data / sizeof *data));

    printf("index of %d = %d\n", key, binary_search(data, 6, key));

    /* WRONG -- the side effect disappears under -DNDEBUG:
       assert(binary_search(data, 6, 3) >= 0);   */

    /* RIGHT -- compute first, then assert on the pure value. */
    int found = binary_search(data, 6, 3);
    assert(found >= 0);
    printf("found 3 at index %d\n", found);

#ifdef NDEBUG
    puts("release build: assertions compiled out");
#else
    puts("debug build: assertions active");
#endif
    return 0;
}
```

```bash
# Debug build: assertions on, no optimization, sanitizers, full debug info.
$ gcc -std=c11 -Wall -Wextra -g3 -O0 -DDEBUG \
      -fsanitize=address,undefined prog.c -o prog-debug

# Release build: optimized, assertions off, hardened.
$ gcc -std=c11 -Wall -Wextra -O2 -DNDEBUG \
      -D_FORTIFY_SOURCE=3 -fstack-protector-strong prog.c -o prog-release

$ ./prog-debug 7
[debug prog.c:32] probing index 3 (value 7)
index of 7 = 3
debug build: assertions active

$ ./prog-release 7
index of 7 = 3
release build: assertions compiled out
```

```text
   WHAT assert(x) BECOMES

   without NDEBUG:   ((x) ? (void)0
                          : __assert_fail("x", __FILE__, __LINE__, __func__))
   with NDEBUG:      ((void)0)

   Everything inside the parentheses -- including any function call --
   is gone. That is the whole reason side effects are forbidden.
```

**Key Takeaways**

- `assert` is compiled out by `-DNDEBUG`, so assertions must be pure checks with no side effects the program depends on.
- Assert programmer errors (invariants, contracts); handle run-time conditions such as I/O and allocation failure with real code.
- Write debug macros that expand to `((void)0)` in release so the disabled code still type-checks and cannot rot.
- Debug builds pair `-O0 -g3` with sanitizers; release builds pair `-O2 -DNDEBUG` with hardening flags.
- Keep `-Wall -Wextra` on in both modes — some warnings require optimization to be detected at all.

> 🧪 Practice
>
> 1. Write a program with an assertion, build it with and without `-DNDEBUG`, and confirm the assertion disappears using `gcc -E`.
> 2. Put a function call with a side effect inside an `assert`, build both ways, and show that the behaviour differs.
> 3. Write a `DBG` macro that vanishes in release builds but still triggers a `-Wformat` warning in both modes when given a wrong specifier.
> 4. Interview-style: *"When should you use `assert` instead of returning an error code?"* Hint: distinguish conditions caused by a bug from conditions that occur in a correct program.

#### #error and #pragma

**Theory**

Two directives step outside the substitute-and-delete model: one deliberately stops the build, and one talks to the compiler.

**`#error message`** makes the preprocessor emit a diagnostic and fail. It exists so that an impossible configuration is caught at build time rather than producing a subtly broken binary. Its natural home is the final `#else` of any conditional chain that must be exhaustive:

```c
#else
#  error "Unsupported platform"
#endif
```

It is equally valuable for enforcing prerequisites: a minimum standard version, a required feature test macro, a compiler that supports an extension you rely on, an assumption about type sizes. The message is free text (no quotes required, though they are conventional) and macros in it are *not* expanded, so print values with a separate `#if` chain rather than expecting interpolation. C23 adds `#warning` for non-fatal notices; GCC and Clang have supported it as an extension for decades.

**`#pragma`** is the standard escape hatch for compiler-specific instructions. The standard defines the syntax and almost nothing about the meaning: an unrecognized pragma must be **ignored**, which is what makes pragmas relatively safe to use — a compiler that does not understand yours simply skips it (though GCC will tell you with `-Wunknown-pragmas`).

The pragmas that matter in practice:

| Pragma | Effect |
|---|---|
| `#pragma once` | include-guard replacement (universal but non-standard) |
| `#pragma pack(push, 1)` / `pop` | control struct padding (see Chapter 6.3) |
| `#pragma GCC diagnostic push/ignored/pop` | suppress a warning for a bounded region |
| `#pragma omp parallel for` | OpenMP parallelization |
| `#pragma STDC FP_CONTRACT OFF` | one of three *standard* pragmas (also `FENV_ACCESS`, `CX_LIMITED_RANGE`) |

The diagnostic-control pragmas deserve emphasis because they are the disciplined way to handle a warning you genuinely must accept. Rather than disabling `-Wunused-parameter` for the whole project, push the diagnostic state, ignore exactly one warning for exactly the lines that need it, and pop. The suppression is then visible, local, and documented at the point of the exception.

`_Pragma("...")` is the operator form, introduced in C99. Because it takes a string literal, it can be produced by a macro — which `#pragma` cannot, since directives are not generated by macro expansion. That is the only way to wrap pragmas in a portable macro.

**Examples**

```c
#include <stdio.h>
#include <limits.h>

/* --- #error as a build-time contract ------------------------------- */
#if !defined(__STDC_VERSION__) || __STDC_VERSION__ < 201112L
#  error "This project requires a C11 compiler (use -std=c11 or later)"
#endif

#if CHAR_BIT != 8
#  error "This code assumes 8-bit bytes"
#endif

/* Exhaustive chain: an unknown platform fails at build time, loudly. */
#if defined(_WIN32)
#  define PLATFORM "windows"
#elif defined(__linux__)
#  define PLATFORM "linux"
#elif defined(__APPLE__)
#  define PLATFORM "macos"
#else
#  error "Unsupported platform -- add a case above"
#endif

/* C23 has #warning; GCC and Clang have supported it for decades. */
#if defined(LEGACY_API)
#  warning "LEGACY_API is deprecated and will be removed in v3.0"
#endif

/* --- #pragma for a bounded, documented warning suppression --------- */
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
/* This signature is fixed by a callback API we do not control. */
static int callback(int used, void *ignored_by_design)
{
    return used * 2;
}
#pragma GCC diagnostic pop        /* the suppression ends HERE */

/* --- _Pragma: the operator form, usable inside a macro -------------
   #pragma cannot be produced by macro expansion; _Pragma takes a string
   literal, so it can. */
#define ALLOW_FLOAT_EQ_BEGIN \
    _Pragma("GCC diagnostic push") \
    _Pragma("GCC diagnostic ignored \"-Wfloat-equal\"")
#define ALLOW_FLOAT_EQ_END \
    _Pragma("GCC diagnostic pop")

int main(void)
{
    printf("platform: %s\n", PLATFORM);
    printf("callback(21, NULL) = %d\n", callback(21, NULL));

    double a = 0.5, b = 0.5;

    ALLOW_FLOAT_EQ_BEGIN
    int exact = (a == b);             /* no -Wfloat-equal inside the region */
    ALLOW_FLOAT_EQ_END

    /* Outside the region the warning is active again -- compile with
       -Wfloat-equal and only the line below is reported. */
    int also = (a == b);

    printf("exact=%d also=%d, CHAR_BIT=%d\n", exact, also, CHAR_BIT);
    return 0;
}
```

```bash
# The #error fires before anything is compiled:
$ gcc -std=c99 prog.c
prog.c:6:4: error: #error "This project requires a C11 compiler (use -std=c11 or later)"

$ gcc -std=c11 prog.c -o prog        # succeeds

# Find pragmas your compiler does not recognize:
$ gcc -Wunknown-pragmas -std=c11 prog.c

# Confirm the suppression is bounded: only the line AFTER the pop warns.
$ gcc -std=c11 -Wfloat-equal prog.c
prog.c:57:19: warning: comparing floating-point with '==' or '!=' is unsafe
```

```text
   WHY #error BEATS A SILENT DEFAULT

   without #error:                  with #error:

   unknown platform                 unknown platform
        |                                |
   no branch taken                  build stops immediately
        |                                |
   PLATFORM undefined               "Unsupported platform --
        |                            add a case above"
   confusing error 40 lines
   later, or a broken binary        Five seconds to diagnose.
```

**Key Takeaways**

- `#error` fails the build with a message; use it in the final `#else` of every exhaustive conditional chain and to enforce prerequisites.
- Macros are not expanded inside an `#error` message — select among several messages with `#if` instead.
- `#warning` is a long-standing extension standardized in C23 for non-fatal notices such as deprecations.
- Unrecognized pragmas must be ignored, which makes them portable to use; `-Wunknown-pragmas` reveals which ones your compiler skipped.
- `#pragma GCC diagnostic push/ignored/pop` scopes a warning suppression to a few lines; `_Pragma("...")` is the form usable inside macros.

> 🧪 Practice
>
> 1. Add an `#error` requiring C11 and build with `-std=c99` and `-std=c11`. Compare the diagnostics.
> 2. Write a platform chain whose `#else` is an `#error`, then compile with `-U__linux__ -U_WIN32 -U__APPLE__` to trigger it.
> 3. Use `#pragma GCC diagnostic push/ignored/pop` to silence one warning for exactly one function, and confirm the warning returns immediately after the `pop`.
> 4. Interview-style: *"Why does the standard require unknown pragmas to be ignored rather than rejected?"* Hint: think about compiling code written for a different compiler, and what the alternative would cost.

<a id="83-macro-techniques-and-hazards"></a>
### 8.3 Macro Techniques and Hazards

This section covers what macros can do that nothing else in C can — turn tokens into strings, build identifiers, and generate code — alongside the traps that make them notorious, and the modern features that let you retire many of them.

#### Stringification and Token Pasting

**Theory**

Two operators exist only inside function-like macros, and they are what make macros a code-generation tool rather than merely a substitution one.

**`#` — stringification.** Applied to a macro parameter, `#param` produces a string literal containing the argument's *source text*. `STR(x + y)` yields `"x + y"`. The preprocessor normalizes whitespace to single spaces and escapes embedded quotes and backslashes correctly. This is how `assert` prints the failing expression, and how a test framework reports which comparison failed.

**`##` — token pasting.** `a ## b` glues two tokens into one. `CONCAT(my, var)` yields the single identifier `myvar`. This is how you generate names: `make_##type##_list` becomes `make_int_list`. The result must be a *valid single token*; pasting `1` and `+` is undefined behaviour.

Both operators come with one rule that surprises everyone the first time: **a parameter operated on by `#` or `##` is not macro-expanded first.** So:

```c
#define VERSION 3
#define STR(x)  #x
STR(VERSION)      /* "VERSION", not "3" */
```

The fix is the **two-level idiom**: an outer macro whose only job is to expand its argument, and an inner macro that does the stringification.

```c
#define STR_IMPL(x) #x
#define STR(x)      STR_IMPL(x)     /* x expands, THEN gets stringified */
STR(VERSION)        /* "3" */
```

The same two-level pattern applies to `##`. The rule to remember: **if the argument might itself be a macro, add an indirection layer.** Naming the inner one with an `_IMPL` or `_` suffix is the near-universal convention.

Where these earn their keep:

- **Diagnostics** — printing the expression that failed, which no function can do.
- **Identifier generation** — declaring or defining families of similarly named functions, types, or variables from one line.
- **Unique names** — `__LINE__` pasted into an identifier gives a per-line unique symbol, the trick behind static assertions and scoped-cleanup macros in C.
- **Turning a build-system value into a string** — `-DVERSION=1.2.3` becomes `"1.2.3"` via the two-level idiom.

**Examples**

```c
#include <stdio.h>
#include <string.h>

/* --- stringification --------------------------------------------- */
#define STR_IMPL(x)  #x
#define STR(x)       STR_IMPL(x)      /* expands x before stringifying */

/* --- token pasting ------------------------------------------------ */
#define CAT_IMPL(a, b) a ## b
#define CAT(a, b)      CAT_IMPL(a, b) /* expands both before pasting  */

#define VERSION_MAJOR 3
#define VERSION_MINOR 14

/* Generating a family of functions from one line -- the payoff. */
#define DEFINE_MAX(type)                                  \
    static type max_##type(type a, type b)                \
    {                                                     \
        return a > b ? a : b;                             \
    }

DEFINE_MAX(int)        /* defines max_int    */
DEFINE_MAX(long)       /* defines max_long   */
DEFINE_MAX(double)     /* defines max_double */

/* A check macro that reports the source text of what failed. */
#define CHECK(expr)                                             \
    do {                                                        \
        if (!(expr))                                            \
            printf("FAILED: %s   (%s:%d)\n", #expr,             \
                   __FILE__, __LINE__);                         \
        else                                                    \
            printf("passed: %s\n", #expr);                      \
    } while (0)

/* __LINE__ pasted into a name gives a unique identifier per line. */
#define UNIQUE_NAME(prefix) CAT(prefix, __LINE__)

int main(void)
{
    /* The one-level trap and the two-level fix, side by side. */
    printf("STR_IMPL(VERSION_MAJOR) = %s   <- not expanded\n",
           STR_IMPL(VERSION_MAJOR));                    /* "VERSION_MAJOR" */
    printf("STR(VERSION_MAJOR)      = %s   <- expanded first\n",
           STR(VERSION_MAJOR));                         /* "3"             */

    /* Building a version string entirely at compile time. */
    printf("version = %s\n",
           STR(VERSION_MAJOR) "." STR(VERSION_MINOR));  /* "3" "." "14"    */

    /* Whitespace is normalized; quotes and backslashes are escaped. */
    printf("STR(a   +    b) = \"%s\"\n", STR(a   +    b));
    printf("STR(\"quoted\") = %s\n", STR("quoted"));

    /* Generated functions, called normally. */
    printf("max_int(3, 7)        = %d\n", max_int(3, 7));
    printf("max_long(10L, 4L)    = %ld\n", max_long(10L, 4L));
    printf("max_double(2.5, 1.5) = %.1f\n", max_double(2.5, 1.5));

    CHECK(1 + 1 == 2);
    CHECK(strlen("abc") == 5);

    /* Both halves must sit on the SAME source line to paste the same
       number -- that is exactly what makes the name unique per line. */
    int UNIQUE_NAME(tmp_) = 1; (void)UNIQUE_NAME(tmp_);   /* tmp_71, say */
    return 0;
}
```

```text
   EXPANSION OF THE TWO-LEVEL IDIOM

   STR(VERSION_MAJOR)
     -> STR_IMPL(VERSION_MAJOR)    outer macro: argument IS expanded
                                   because # is not applied here
     -> STR_IMPL(3)                VERSION_MAJOR expanded to 3
     -> #3
     -> "3"                                                   correct

   STR_IMPL(VERSION_MAJOR)         called directly:
     -> #VERSION_MAJOR             # suppresses expansion
     -> "VERSION_MAJOR"                                       surprising
```

| Operator | Input | Output | Common use |
|---|---|---|---|
| `#x` | `x` = `a + b` | `"a + b"` | assertion and test messages |
| `##` | `foo` `##` `bar` | `foobar` | generating function and type names |
| two-level `#` | macro-valued argument | expanded, then quoted | `-DVER=1.2` to `"1.2"` |
| `##` with `__LINE__` | `tmp` `##` `71` | `tmp71` | unique per-line identifiers |

**Key Takeaways**

- `#param` stringifies a parameter's source text; `##` pastes two tokens into one, which must be a valid single token.
- A parameter used with `#` or `##` is *not* macro-expanded first — this is the rule behind nearly every stringification surprise.
- Use the two-level `_IMPL` idiom whenever the argument might itself be a macro.
- Token pasting generates families of identifiers, which is the foundation of X-Macros and of generic containers in C.
- Pasting `__LINE__` into a name yields per-line unique identifiers, the basis of static assertion and cleanup macros.

> 🧪 Practice
>
> 1. Write `STR(x)` in one level and two, apply both to a macro-valued argument, and explain the difference in output.
> 2. Write `DEFINE_SWAP(type)` that generates `swap_int`, `swap_double`, and `swap_char`, and call all three.
> 3. Use `-DBUILD_ID=abc123` and print it as a string with the two-level idiom. Verify with `gcc -E` that the expansion is what you expect.
> 4. Interview-style: *"Why does `#define STR(x) #x` print `VERSION` instead of `3` for `STR(VERSION)`?"* Hint: name the rule about parameters adjacent to `#` and `##`.

#### Multiple Evaluation Pitfalls

**Theory**

This is the single most notorious macro bug, and it follows inevitably from text substitution.

A macro parameter is pasted wherever it appears in the replacement text. If it appears twice, the argument's *expression* appears twice — and if that expression has a side effect, the side effect happens twice.

```c
#define MAX(a, b) ((a) > (b) ? (a) : (b))

int i = 5, j = 3;
int m = MAX(i++, j);
/* expands to: ((i++) > (j) ? (i++) : (j))
   i is incremented TWICE, and m gets 6, not 5 */
```

The parentheses are all correct. The macro is textbook-quality. It is still wrong, because the *caller* passed an expression with a side effect, and nothing in the macro's appearance warns them.

Side effects hide in more places than `++`:

- assignment and compound assignment (`x = f()`, `n += 1`)
- any function call that is not pure — `getchar()`, `rand()`, `pop()`, `malloc()`
- volatile reads, where each access is a distinct hardware operation
- expensive-but-pure calls, where double evaluation is a correctness non-issue but a performance one: `MAX(expensive(x), expensive(y))` runs three calls instead of two

The consequences split into three severities: wrong results (the `i++` case), performance loss (repeated expensive calls), and hardware misbehaviour (a `volatile` register read consumed twice).

The defences, in order of preference:

1. **Use a `static inline` function.** Arguments are evaluated exactly once, by the language's own rules. This solves the problem completely and is the right answer whenever the operation is a computation on values.
2. **Assign arguments to temporaries inside the macro.** This requires a statement-expression, since a plain macro cannot declare variables and still be an expression. GCC and Clang provide `({ ... })`; it is not standard C.
3. **Use `_Generic` (C11)** to dispatch to type-specific inline functions, getting one evaluation *and* polymorphism.
4. **Name the macro so callers are warned.** If a macro genuinely must evaluate twice, the convention is a name that shouts — some codebases require such macros to be prefixed or documented at the definition.

A related hazard is worth flagging: a macro that evaluates a parameter *zero* times. `#define DEBUG_ONLY(x)` (expanding to nothing) will silently delete `DEBUG_ONLY(must_happen())` in release builds — the same class of bug as `assert` with side effects.

**Examples**

```c
#include <stdio.h>

#define MAX_MACRO(a, b) ((a) > (b) ? (a) : (b))

/* The correct answer whenever the operation is a computation. */
static inline int max_int(int a, int b) { return a > b ? a : b; }

/* GNU statement expression: one evaluation, still type-generic.
   NOT standard C -- gcc/clang only. */
#if defined(__GNUC__)
#  define MAX_SAFE(a, b)              \
      ({ __auto_type _a = (a);        \
         __auto_type _b = (b);        \
         _a > _b ? _a : _b; })
#endif

static int call_count = 0;
static int expensive(int x) { call_count++; return x * 2; }

int main(void)
{
    /* --- side effect evaluated twice ------------------------------ */
    int i = 5, j = 3;
    int m = MAX_MACRO(i++, j);          /* ((i++) > (j) ? (i++) : (j)) */
    printf("MAX_MACRO(i++, j): m=%d i=%d   <- i incremented twice\n", m, i);

    i = 5;
    int n = max_int(i++, j);            /* i++ evaluated exactly once */
    printf("max_int(i++, j) : n=%d i=%d   <- correct\n", n, i);

    /* --- performance: three calls where two were intended --------- */
    call_count = 0;
    int r1 = MAX_MACRO(expensive(3), expensive(4));
    printf("MAX_MACRO: result=%d, expensive() called %d times\n",
           r1, call_count);

    call_count = 0;
    int r2 = max_int(expensive(3), expensive(4));
    printf("max_int  : result=%d, expensive() called %d times\n",
           r2, call_count);

#if defined(__GNUC__)
    call_count = 0;
    int r3 = MAX_SAFE(expensive(3), expensive(4));
    printf("MAX_SAFE : result=%d, expensive() called %d times\n",
           r3, call_count);

    i = 5;
    printf("MAX_SAFE(i++, j) = %d, i = %d\n", MAX_SAFE(i++, j), i);
#endif
    return 0;
}
```

Output:

```text
MAX_MACRO(i++, j): m=6 i=7   <- i incremented twice
max_int(i++, j) : n=5 i=6   <- correct
MAX_MACRO: result=8, expensive() called 3 times
max_int  : result=8, expensive() called 2 times
MAX_SAFE : result=8, expensive() called 2 times
MAX_SAFE(i++, j) = 5, i = 6
```

```text
   WHY THE COUNT IS THREE

   MAX_MACRO(expensive(3), expensive(4))
     -> ((expensive(3)) > (expensive(4)) ? (expensive(3)) : (expensive(4)))
          ^ call 1        ^ call 2         ^ call 3 (the winning branch)

   The comparison evaluates both; the selected branch evaluates one again.
   The ternary's short-circuit means only ONE of the last two runs -- so
   three calls total, not four.
```

| Approach | Single evaluation | Type-generic | Standard C | Constant expression |
|---|---|---|---|---|
| Plain macro | no | yes | yes | yes |
| `static inline` function | yes | no | yes | no |
| GNU statement expression | yes | yes | no | no |
| `_Generic` + inline functions | yes | yes | yes (C11) | no |

**Key Takeaways**

- A macro parameter used twice evaluates its argument twice — the classic source of wrong results, wasted work, and volatile-access bugs.
- Side effects hide in `++`, assignments, impure function calls, and volatile reads, not just obvious increments.
- Prefer a `static inline` function whenever the macro is really a computation on values; the language then guarantees one evaluation.
- GNU statement expressions with temporaries fix the problem generically but are non-standard; `_Generic` plus inline functions is the portable equivalent.
- A macro that evaluates a parameter zero times is equally dangerous — it silently deletes the caller's side effect.

> 🧪 Practice
>
> 1. Write `MAX(a, b)` as a macro, call it with `MAX(i++, j)` for `i = 5, j = 3`, and predict `m` and `i` before running.
> 2. Instrument a function with a call counter and show that `MAX(f(1), f(2))` calls it three times while an inline version calls it twice.
> 3. Rewrite `MAX` as a GNU statement expression with temporaries, and confirm side effects occur once.
> 4. Interview-style: *"Why does `MAX(x++, y++)` behave unpredictably?"* Hint: write out the full expansion, then count each variable's occurrences and consider the ternary's short-circuit.

#### do-while(0) Idiom

**Theory**

A multi-statement macro has a syntax problem that has nothing to do with what it computes.

Consider a macro meant to be used like a statement:

```c
#define SWAP(a, b) int t = a; a = b; b = t;
```

Two things break immediately. First, in `if (x) SWAP(p, q); else ...`, only the first statement belongs to the `if`; the rest execute unconditionally and the `else` becomes an orphan — a syntax error at best, and silently wrong control flow at worst. Second, the macro declares `t` in the surrounding scope, colliding with any existing `t`.

The obvious fix — wrapping in braces — solves the scope problem and half the control-flow one:

```c
#define SWAP(a, b) { int t = a; a = b; b = t; }
```

but now `if (x) SWAP(p, q); else ...` expands to `if (x) { ... } ; else ...`, and that stray semicolon between the block and `else` is a syntax error. The macro works without a trailing semicolon and breaks with one, which means it does not look or behave like a statement.

The idiom that solves both:

```c
#define SWAP(a, b) do { int t = (a); (a) = (b); (b) = t; } while (0)
```

`do { ... } while (0)` executes its body exactly once, and — this is the point — it is a statement that **requires** a terminating semicolon. So `SWAP(p, q);` is exactly one grammatical statement, works unbraced in `if`/`else`, and gives the macro its own scope for temporaries. Any decent optimizer removes the loop entirely; there is no run-time cost.

Two refinements complete the pattern. A trailing semicolon is now *mandatory*, which is what you want: forgetting it is a compile error rather than a subtle bug. And `break` or `continue` inside the body will bind to the `do`-loop rather than to an enclosing loop, so a macro body must not use them for the caller's control flow — one of the reasons a "return the value" macro is better written as a statement expression or a function.

You will see the same shape in the Linux kernel, in glibc, and in essentially every C project of size. When you need a macro that acts like a statement, this is the shape.

**Examples**

```c
#include <stdio.h>

/* --- three versions, only one of which is safe -------------------- */
#define SWAP_BAD(a, b)     int t = a; a = b; b = t;
#define SWAP_BRACES(a, b)  { int t = (a); (a) = (b); (b) = t; }
#define SWAP(a, b)         do { int t = (a); (a) = (b); (b) = t; } while (0)

/* The idiom shines for multi-statement macros with a condition. */
#define LOG_IF(cond, msg)                          \
    do {                                           \
        if (cond) {                                \
            printf("[log] %s\n", (msg));           \
            fflush(stdout);                        \
        }                                          \
    } while (0)

/* A cleanup macro: several statements, used like one. */
#define FREE_AND_NULL(p) \
    do { free(p); (p) = NULL; } while (0)

int main(void)
{
    int x = 1, y = 2;

    /* SWAP_BAD in an if/else does NOT compile:
           if (x < y) SWAP_BAD(x, y); else puts("no");
       expands to:
           if (x < y) int t = x; x = y; y = t; ; else puts("no");
                                                      ^ orphan else      */

    /* SWAP_BRACES breaks with the semicolon a reader will always write:
           if (x < y) SWAP_BRACES(x, y); else puts("no");
       expands to:
           if (x < y) { ... } ; else puts("no");
                              ^ stray semicolon before else              */

    /* SWAP works exactly like a statement, braces or not. */
    if (x < y)
        SWAP(x, y);              /* one statement, semicolon required */
    else
        puts("already ordered");
    printf("x=%d y=%d\n", x, y);

    /* It also composes inside loops and other conditionals. */
    for (int i = 0; i < 3; i++)
        LOG_IF(i % 2 == 0, "even iteration");

    /* The temporary 't' is scoped to the macro: no collision. */
    int t = 99;                  /* would clash with SWAP_BAD's 't' */
    SWAP(x, y);
    printf("outer t is untouched: %d, x=%d y=%d\n", t, x, y);
    return 0;
}
```

```text
   EXPANSION IN AN if/else, SIDE BY SIDE

   source:   if (c) SWAP(x, y); else f();

   BAD:      if (c) int t = x; x = y; y = t; ; else f();
                    ^ only this belongs to the if      ^ orphan else

   BRACES:   if (c) { int t = x; x = y; y = t; } ; else f();
                                                 ^ stray ; -> error

   do/while: if (c) do { ... } while (0); else f();
                    ^------- one complete statement -------^   correct
```

| Wrapper | Works in unbraced `if`/`else` | Needs trailing `;` | Own scope |
|---|---|---|---|
| bare statements | no | inconsistent | no |
| `{ ... }` | no (stray semicolon) | must be omitted | yes |
| `do { ... } while (0)` | yes | yes, required | yes |

**Key Takeaways**

- A multi-statement macro must expand to exactly one statement, or it breaks unbraced `if`/`else` and silently changes control flow.
- Plain braces fix scoping but leave a stray semicolon before `else`; `do { } while (0)` fixes both.
- The idiom makes the trailing semicolon mandatory, so the macro reads and behaves like a normal statement call.
- It gives the macro body its own scope for temporaries, avoiding collisions with caller variables.
- Optimizers remove the loop entirely, so there is no run-time cost; avoid `break`/`continue` in the body, which would bind to the `do`.

> 🧪 Practice
>
> 1. Write `SWAP` without any wrapper, use it in an unbraced `if`/`else`, and read the compiler error. Then fix it with `do { } while (0)`.
> 2. Write a version wrapped in plain braces and show that it compiles only when the caller omits the semicolon.
> 3. Write a `CHECK_AND_RETURN(cond, code)` macro using the idiom, and explain why `break` inside its body would be a bug.
> 4. Interview-style: *"Why `do { } while (0)` rather than just braces?"* Hint: write out both expansions in an `if`/`else` and look at the semicolon.

#### X-Macros

**Theory**

Programs constantly need the *same* list of items expressed in several forms: an enum of error codes, an array of their names, a `switch` mapping each to a message, a parser recognizing each by string. Maintaining four parallel lists is a guaranteed bug — someone adds an entry to three of them.

**X-Macros** solve this by writing the list exactly once and generating every form from it. The technique has two parts:

1. A **list macro** that invokes an undefined macro `X` once per item, passing the item's fields as arguments.
2. For each output form, define `X` to produce that form, expand the list, then `#undef X`.

```c
#define COLOR_LIST      \
    X(RED,   "red",   0xFF0000)  \
    X(GREEN, "green", 0x00FF00)  \
    X(BLUE,  "blue",  0x0000FF)

/* Form 1: an enum */
#define X(name, str, hex) COLOR_##name,
enum color { COLOR_LIST COLOR_COUNT };
#undef X

/* Form 2: a name table */
#define X(name, str, hex) str,
static const char *color_names[] = { COLOR_LIST };
#undef X
```

Add a fourth colour to `COLOR_LIST` and the enum, the table, and every other generated form update together. It is impossible for them to drift out of sync, because there is only one list.

The pattern is decades old (the `X` name comes from early Unix source) and is used in the Linux kernel, in interpreters for opcode tables, in embedded register maps, and in protocol implementations. It is the closest thing C has to compile-time reflection.

Two practical rules keep it manageable. **Always `#undef X` after each use**, or the next expansion inherits the wrong definition. And **keep the field list stable**: every consumer must accept the same arity, so adding a field means touching every `#define X` — which is exactly the moment to consider whether the list has outgrown the technique.

The honest trade-off: X-Macros produce code no debugger will show you and no `grep` will find. Searching for `COLOR_RED` finds only the list entry, not the enum constant it generates. That opacity is the price for the guarantee that the forms cannot disagree, and it is why the technique belongs in the small, stable, list-shaped corners of a program rather than everywhere.

**Examples**

```c
#include <stdio.h>
#include <string.h>

/* ================= THE SINGLE SOURCE OF TRUTH ==================== */
/*        enum name    string        HTTP code   retryable          */
#define ERROR_LIST                                        \
    X(OK,          "ok",             200,        0)       \
    X(NOT_FOUND,   "not found",      404,        0)       \
    X(TIMEOUT,     "timeout",        408,        1)       \
    X(RATE_LIMIT,  "rate limited",   429,        1)       \
    X(SERVER,      "server error",   500,        1)

/* ---- Form 1: the enum ------------------------------------------- */
#define X(name, str, code, retry) ERR_##name,
typedef enum { ERROR_LIST ERR_COUNT } ErrorCode;
#undef X

/* ---- Form 2: a name lookup table -------------------------------- */
#define X(name, str, code, retry) str,
static const char *error_names[] = { ERROR_LIST };
#undef X

/* ---- Form 3: a numeric lookup table ----------------------------- */
#define X(name, str, code, retry) code,
static const int error_http[] = { ERROR_LIST };
#undef X

/* ---- Form 4: a switch-based predicate --------------------------- */
static int error_is_retryable(ErrorCode e)
{
    switch (e) {
#define X(name, str, code, retry) case ERR_##name: return retry;
        ERROR_LIST
#undef X
        default: return 0;
    }
}

/* ---- Form 5: a reverse parser ----------------------------------- */
static ErrorCode error_from_string(const char *s)
{
#define X(name, str, code, retry) if (strcmp(s, str) == 0) return ERR_##name;
    ERROR_LIST
#undef X
    return ERR_COUNT;                      /* not found */
}

/* ---- Form 6: generated declarations ------------------------------ */
#define X(name, str, code, retry) void handle_##name(void);
ERROR_LIST                                  /* void handle_OK(void); etc. */
#undef X

int main(void)
{
    printf("%-14s %-16s %-6s %s\n", "ENUM", "NAME", "HTTP", "RETRY");
    for (int e = 0; e < ERR_COUNT; e++)
        printf("%-14d %-16s %-6d %s\n",
               e, error_names[e], error_http[e],
               error_is_retryable((ErrorCode)e) ? "yes" : "no");

    printf("\nlookup \"timeout\" -> enum %d (%s)\n",
           error_from_string("timeout"),
           error_names[error_from_string("timeout")]);

    /* Adding one line to ERROR_LIST updates ALL six forms at once. */
    printf("total error codes: %d\n", ERR_COUNT);
    return 0;
}
```

Output:

```text
ENUM           NAME             HTTP   RETRY
0              ok               200    no
1              not found        404    no
2              timeout          408    yes
3              rate limited     429    yes
4              server error     500    yes

lookup "timeout" -> enum 2 (timeout)
total error codes: 5
```

```text
   ONE LIST, MANY FORMS

                     ERROR_LIST
                         |
        +--------+-------+-------+--------+---------+
        v        v       v       v        v         v
      enum    names[]  http[]  switch  parser  declarations

   Add X(CONFLICT, "conflict", 409, 0) to the list and every branch
   above regenerates. Nothing can fall out of sync, because nothing
   else states the list.
```

**Key Takeaways**

- X-Macros declare a list once and generate every derived form from it, making parallel tables impossible to desynchronize.
- The pattern is: a list macro invoking `X(...)` per item, then `#define X`, expand the list, `#undef X` for each output form.
- Always `#undef X` after each use, or later expansions inherit the wrong definition.
- They are C's nearest equivalent to compile-time reflection, used for opcode tables, error codes, register maps, and protocol fields.
- The cost is discoverability: generated identifiers are invisible to `grep` and to the debugger, so keep the technique to small, stable lists.

> 🧪 Practice
>
> 1. Build an X-Macro list of five HTTP status codes and generate an enum plus a name table; add a sixth entry and confirm both update.
> 2. Add a `switch`-based `is_error()` predicate over the same list without touching the list itself.
> 3. Use `gcc -E` to see the generated enum and table, and explain each line of the expansion.
> 4. Interview-style: *"How would you keep an enum and its string names from drifting apart?"* Hint: think about how many places the list of items is written down.

#### Generic Programming with _Generic

**Theory**

Before C11, writing one operation that worked for several types meant one of three unhappy options: a macro with no type checking, a family of hand-written `_int`/`_double` functions the caller had to choose between, or `void *` plus a size and a comparison callback (the `qsort` approach), which loses type safety entirely.

C11 added **`_Generic`**, a *type-based selection expression*. It examines the type of a controlling expression at compile time and evaluates to whichever association matches:

```c
_Generic(expression,
         int:    handler_int,
         double: handler_double,
         default: handler_other)
```

Three properties are essential:

- **Selection happens at compile time.** The result is a single expression with a single type; the unselected branches are discarded. There is no run-time dispatch and no cost.
- **The controlling expression is not evaluated.** Only its type is used, so `_Generic(i++, ...)` does not increment `i`. This makes it side-effect safe in a way that macros generally are not.
- **The type must match exactly after the usual conversions.** Array and function types decay to pointers, and top-level qualifiers are dropped from the controlling expression, but `int` will not match a `long` association. Every type you want to support must be listed, or you need a `default`.

The dominant use is as the dispatch mechanism inside a macro, giving a type-generic *interface* backed by ordinary type-safe *functions*. That combination solves the multiple-evaluation problem too: the macro's argument is passed to a real function, so it is evaluated exactly once.

The standard library uses this directly: `<tgmath.h>` builds type-generic `sqrt`, `sin`, and friends over the `float`/`double`/`long double` variants, and it is how a C11 implementation provides them portably.

Practical limitations to know going in. There is no way to write a *generic* association such as "any pointer type" — every type is listed explicitly, so a `_Generic` over many types gets verbose. Every listed branch must compile even though only one is selected, so you cannot use it to guard code that would be invalid for other types. And it dispatches on *type*, not on value or on number of arguments.

**Examples**

```c
#include <stdio.h>
#include <math.h>
#include <string.h>

/* --- type-safe implementations, one per type ---------------------- */
static int    max_i(int a, int b)             { return a > b ? a : b; }
static long   max_l(long a, long b)           { return a > b ? a : b; }
static double max_d(double a, double b)       { return a > b ? a : b; }

/* --- one generic interface over them ------------------------------
   Arguments go to a real function, so each is evaluated exactly once. */
#define MAX(a, b) _Generic((a),      \
        int:    max_i,               \
        long:   max_l,               \
        double: max_d                \
    )((a), (b))

/* --- a type-name utility: selection with no function call --------- */
#define TYPE_NAME(x) _Generic((x),          \
        char:            "char",            \
        signed char:     "signed char",     \
        unsigned char:   "unsigned char",   \
        short:           "short",           \
        int:             "int",             \
        long:            "long",            \
        long long:       "long long",       \
        float:           "float",           \
        double:          "double",          \
        char *:          "char *",          \
        const char *:    "const char *",    \
        void *:          "void *",          \
        default:         "unknown")

/* --- a generic print ---------------------------------------------
   Dispatch on the FORMAT STRING, not on a whole printf call. Every
   association is type-checked even though only one is selected, so
   _Generic((x), int: printf("%d\n", (x)), long: printf("%ld\n", (x)), ...)
   emits -Wformat warnings for the branches that were not chosen. */
#define FMT(x) _Generic((x),                \
        int:    "%d\n",                     \
        long:   "%ld\n",                    \
        double: "%f\n",                     \
        char *: "%s\n")
#define PRINT(x) printf(FMT(x), (x))

static int side_effect_count = 0;
static int bump(void) { side_effect_count++; return 7; }

int main(void)
{
    printf("MAX(3, 7)         = %d\n",   MAX(3, 7));
    printf("MAX(2.5, 1.5)     = %.1f\n", MAX(2.5, 1.5));
    printf("MAX(10L, 20L)     = %ld\n",  MAX(10L, 20L));

    printf("\ntype of 42     : %s\n", TYPE_NAME(42));
    printf("type of 42L    : %s\n", TYPE_NAME(42L));
    printf("type of 3.14   : %s\n", TYPE_NAME(3.14));
    printf("type of 3.14f  : %s\n", TYPE_NAME(3.14f));
    printf("type of \"text\" : %s\n", TYPE_NAME("text"));   /* char * */

    /* The controlling expression is NOT evaluated -- only its type. */
    side_effect_count = 0;
    const char *t = TYPE_NAME(bump());
    printf("\nTYPE_NAME(bump()) = %s, bump() called %d times\n",
           t, side_effect_count);                            /* 0 times */

    /* And because MAX forwards to a function, each argument runs once. */
    side_effect_count = 0;
    int mv = MAX(bump(), 3);      /* compute first: argument order is unspecified */
    printf("MAX(bump(), 3) = %d, bump() called %d time\n",
           mv, side_effect_count);                           /* 1 time  */

    PRINT(42);
    PRINT(2.718);
    PRINT("generic printing");
    return 0;
}
```

```text
   COMPILE-TIME SELECTION

   MAX(2.5, 1.5)
     -> _Generic((2.5), int: max_i, long: max_l, double: max_d)((2.5), (1.5))
                  ^^^ type is double
     -> max_d((2.5), (1.5))          the other branches are DISCARDED

   The generated code contains one direct call to max_d. There is no
   dispatch table, no branch, and no run-time cost whatsoever.
```

| Approach | Type-safe | One evaluation | Zero run-time cost | Standard |
|---|---|---|---|---|
| Plain macro | no | no | yes | yes |
| `void *` + callback | no | yes | no (indirect call) | yes |
| Per-type functions | yes | yes | yes | yes (verbose to call) |
| `_Generic` + functions | yes | yes | yes | C11 |

**Key Takeaways**

- `_Generic` selects an expression based on the compile-time type of its controlling expression, with no run-time cost.
- The controlling expression is never evaluated — only its type is inspected — so it is free of side effects.
- Types must match exactly after array/function decay and qualifier removal; list every type you support or provide a `default`.
- Every association is type-checked even though only one is selected, so dispatch on a value (a format string, a function name) rather than wrapping whole calls.
- The idiomatic use is a macro that dispatches to per-type `static inline` functions: type-generic interface, type-safe implementation, single evaluation.
- `<tgmath.h>` is built on exactly this mechanism; the limitation is verbosity, since there is no way to match a category of types.

> 🧪 Practice
>
> 1. Write `TYPE_NAME(x)` covering six types and test it with literals of each, explaining the result for `"text"` and for `'a'`.
> 2. Build a generic `ABS(x)` dispatching to `abs`, `labs`, and `fabs`, and confirm the correct one is chosen for each type.
> 3. Prove that `_Generic` does not evaluate its controlling expression by passing a function with a side-effect counter.
> 4. Interview-style: *"How does `_Generic` differ from C++ templates?"* Hint: consider what each one generates, when the selection happens, and whether new code is produced per type.

#### Macros vs inline Functions

**Theory**

Historically, macros were the only way to avoid function call overhead in C. That reason is gone: `inline` arrived in C99, and modern compilers inline aggressively across a translation unit and — with link-time optimization — across the whole program, often better than a human would choose. Performance is no longer an argument for macros.

What remains is a genuine capability difference. A macro operates on **tokens before compilation**; a function operates on **values after it**. Each can do things the other cannot, and the boundary is sharp:

**Only a macro can:**
- take a *type* as an argument (`sizeof (T)`, casts, declarations)
- see the caller's `__FILE__`, `__LINE__`, and source text (`#expr`)
- generate declarations, definitions, or identifiers (X-Macros, `##`)
- produce an integer constant expression usable as an array size or `case` label
- work in a pre-C99 codebase where `inline` does not exist

**Only a function can:**
- type-check its arguments and its return value
- guarantee each argument is evaluated exactly once
- be stepped into by a debugger, appear in a stack trace, and be profiled by name
- have its address taken and be passed as a callback
- obey scope, so a local name cannot silently capture a caller's identifier

A few notes on `inline` itself, since its C semantics are unusual. `inline` is a *hint about linkage and duplication*, not a command to inline — the compiler decides regardless, and `-O0` typically inlines nothing. A bare `inline` function in C provides only an "inline definition", which is not an external definition, so calling it from another translation unit gives a link error; **`static inline` in a header is the form you want**, and it is what real projects use almost exclusively.

The practical decision procedure is short. Ask: *does this need tokens, types, or the call site?* If yes, write a macro, name it in `SHOUTING_CASE`, parenthesize everything, and use `do { } while (0)` if it is statement-shaped. If no, write a `static inline` function. If you want a generic interface with type safety, combine both: a macro that uses `_Generic` to dispatch to inline functions.

**Examples**

```c
#include <stdio.h>
#include <stdlib.h>

/* ============ CASES WHERE ONLY A MACRO WORKS ==================== */

/* 1. Operates on a TYPE, and yields a constant expression. */
#define ARRAY_LEN(a)      (sizeof (a) / sizeof (a)[0])
#define ALLOC_ARRAY(T, n) ((T *)malloc((n) * sizeof (T)))

/* 2. Captures the call site. A function could never know these. */
#define TRACE(msg) \
    printf("%s:%d in %s(): %s\n", __FILE__, __LINE__, __func__, (msg))

/* 3. Reports the source text of an expression. */
#define REQUIRE(expr)                                        \
    do {                                                     \
        if (!(expr)) {                                       \
            fprintf(stderr, "requirement failed: %s at %s:%d\n", \
                    #expr, __FILE__, __LINE__);              \
            abort();                                         \
        }                                                    \
    } while (0)

/* 4. A compile-time constant usable where only constants are allowed. */
#define CACHE_LINE 64
static char aligned_buffer[CACHE_LINE * 8];     /* array size: needs a macro */

/* ============ CASES WHERE A FUNCTION IS BETTER ================== */

/* Type-checked, single evaluation, debuggable, address-takeable. */
static inline int   clamp_i(int v, int lo, int hi)
{
    return v < lo ? lo : (v > hi ? hi : v);
}
static inline double clamp_d(double v, double lo, double hi)
{
    return v < lo ? lo : (v > hi ? hi : v);
}

/* ============ THE BEST OF BOTH: _Generic over inline functions === */
#define CLAMP(v, lo, hi) _Generic((v),      \
        int:    clamp_i,                    \
        double: clamp_d                     \
    )((v), (lo), (hi))

int main(void)
{
    int nums[] = {1, 2, 3, 4, 5, 6};
    printf("ARRAY_LEN(nums) = %zu  (a function receives a pointer)\n",
           ARRAY_LEN(nums));

    int *heap = ALLOC_ARRAY(int, 10);        /* a type as an argument */
    if (heap) { heap[0] = 1; free(heap); }

    TRACE("only a macro sees this location");

    printf("CLAMP(15, 0, 10)     = %d\n",   CLAMP(15, 0, 10));
    printf("CLAMP(0.5, 1.0, 2.0) = %.1f\n", CLAMP(0.5, 1.0, 2.0));

    /* A function has an address; a macro does not exist at run time. */
    int (*fn)(int, int, int) = clamp_i;
    printf("through a function pointer: %d\n", fn(99, 0, 10));

    REQUIRE(ARRAY_LEN(nums) == 6);
    printf("buffer size = %zu\n", sizeof aligned_buffer);
    return 0;
}
```

```text
   THE DECISION

   Does it need TOKENS, TYPES, or the CALL SITE?
        |
        +-- yes --> MACRO
        |            - SHOUTING_CASE name
        |            - parenthesize every parameter and the whole body
        |            - do { } while (0) if it is statement-shaped
        |            - #undef it if it is a local helper
        |
        +-- no ---> static inline FUNCTION
                     - type-checked, one evaluation, debuggable
                     - put it in the header; the compiler inlines it

   Need a generic INTERFACE with type safety?
        --> a macro using _Generic that dispatches to inline functions
```

| Property | Macro | `static inline` function |
|---|---|---|
| Argument type checking | none | full |
| Evaluations per argument | one per textual use | exactly one |
| Accepts a type argument | yes | no |
| Sees `__FILE__` / `__LINE__` / `#expr` | yes | no |
| Yields a constant expression | yes | no |
| Debugger and profiler support | none | full |
| Address can be taken | no | yes |
| Respects scope | no | yes |
| Run-time cost when optimized | none | none |

**Key Takeaways**

- Performance is no longer a reason to choose macros — compilers inline `static inline` functions as well as or better than hand-written macros.
- Use a macro only when you need tokens, types, the call site, or a constant expression; otherwise use a function.
- `static inline` in a header is the correct form in C; a bare `inline` definition is not an external definition and will not link.
- Functions give type checking, single evaluation, scoping, addressability, and debugger support — everything a macro gives up.
- A macro dispatching through `_Generic` to inline functions combines a generic interface with full type safety and one evaluation.

> 🧪 Practice
>
> 1. Write `SQUARE` as both a macro and a `static inline` function, compile at `-O2`, and compare the generated assembly with `gcc -S`.
> 2. Write `ARRAY_LEN` as a function and explain why it cannot work. Then explain why the macro is also wrong when handed a pointer.
> 3. Take the address of an inline function and pass it as a callback; then try the same with a macro and describe the error.
> 4. Interview-style: *"Given modern compilers inline aggressively, why do macros still exist in new C code?"* Hint: list the things that disappear once the compiler has parsed the call and turned arguments into values.

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
