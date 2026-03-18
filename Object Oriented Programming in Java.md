# Object Oriented Programming in Java
Useful links:
https://www.geeksforgeeks.org/java/java/
https://www.geeksforgeeks.org/advance-java/advanced-java/
https://www.geeksforgeeks.org/advance-java/spring-boot/

## Index
1. [1. Core Java Fundamentals (CHECK)](#1-core-java-fundamentals)
    - [JVM, JRE, JDK](#jvm-jre-jdk)
    - [Compilation vs Execution](#compilation-vs-execution)
2. [2. Object Oriented Programming (CHECK)](#2-object-oriented-programming)
    - [Encapsulation](#encapsulation)
    - [Inheritance](#inheritance)
    - [Polymorphism (REWRITE)](#polymorphism)
        - [Compile-time Polymorphism](#compile-time-polymorphism)
        - [Runtime Polymorphism (IMPROVE)](#runtime-polymorphism)
    - [Abstraction](#abstraction)
        - [Interfaces](#interfaces)
        - [Abstract Classes](#abstract-classes)
3. [3. Collections Framework (IMPROVE)](#3-collections-framework)
    - [List](#list)
        - [ArrayList](#arraylist)
        - [LinkedList](#linkedlist)
    - [Set](#set)
        - [HashSet](#hashset)
        - [LinkedHashSet (TODO)](#linkedhashset)
    - [Map (TODO)](#map)
        - [HashMap](#hashmap)
        - [TreeMap](#treemap)
        - [LinkedHashMap (TODO)](#linkedhashmap)
    - [Queue (TODO)](#queue)
        - [PriorityQueue (TODO)](#priorityqueue)
    - [Iterator (TODO)](#iterator)
    - [Comparator (TODO)](#comparator)
    - [HashMap vs TreeMap (TODO)](#hashmap-vs-treemap)
4. [4. Exception Handling (IMPROVE)](#4-exception-handling)
    - [Checked vs Unchecked Exceptions](#checked-vs-unchecked-exceptions)
    - [try-catch-finally](#try-catch-finally)
    - [throw vs throws](#throw-vs-throws)
    - [Custom Exceptions](#custom-exceptions)
5. [5. Java 8+ features (IMPROVE)](#5-java-8-features)
    - [Functional Interfaces](#functional-interfaces)
    - [Lambda Expressions](#lambda-expressions)
    - [Method References (TODO)](#method-references)
    - [Streams (IMPROVE)](#streams)
    - [Optional](#optional)
6. [6. Concurrency & Parallelism (IMPROVE)](#6-concurrency-and-parallelism)
    - [Concurrency vs Parallelism (TODO)](#concurrency-vs-parallelism)
    - [Thread vs Runnable](#thread-vs-runnable)
    - [Callable vs Runnable](#callable-vs-runnable)
    - [Java Memory Model](#java-memory-model)
    - [Volatile (IMPROVE)](#volatile)
    - [Synchronization (IMPROVE)](#synchronization)
    - [Race Condition (TODO)](#race-conditions)
    - [Deadlocks (TODO)](#deadlocks)
    - [Locks (TODO)](#locks)
    - [Thread Pools (TODO)](#thread-pools)
    - [Atomics (TODO)](#atomics)
7. [7. Java Memory Management (IMPROVE)](#7-java-memory-management)
    - [Stack](#stack)
    - [Heap](#heap)
    - [Garbage Collection (EXPAND)](#garbage-collection)
        - [Generational Garbage Collection (TODO)](#generational-garbage-collection)
        - [Memory Leaks (IMPROVE)](#memory-leaks)
8. [8. Immutability (IMPROVE)](#8-immutability)
    - [Immutable Variables (IMPROVE)](#immutable-variables)
    - [Immutable Methods (TODO)](#immutable-methods)
    - [Immutable Classes (IMPROVE)](#immutable-classes)
        - [String Immutability](#string-immutability)
        - [Benefits and Pitfalls](#benefits-and-pitfalls)
9. [9. Equals & Hashcode Contract (CHECK)](#9-equals-and-hashcode-contract)
10. [10. SOLID (EXPAND)](#10-solid)
11. [11. Design Patterns](#11-design-patterns)
    - [Creational Patterns](#creational-patterns)
        - [Singleton](#singleton)
        - [Factory](#factory)
        - [Builder](#builder)
    - [Structural Patterns](#structural-patterns)
        - [Decorator](#decorator)
        - [Facade](#facade)
        - [Composite](#composite)
        - [Proxy](#proxy)
    - [Behavioral Patterns](#behavioral-patterns)
        - [Strategy](#strategy)
        - [Observer](#observer)
        - [Command](#command)
        - [State](#state)
12. [12. Serialization](#12-serialization)
    - [Serializable](#serializable)
    - [serialVersionUUID](#serialVersionUUID)
    - [transient](#transient)
    - [Custom Serialization](#custom-serialization)
    - [Externalizable](#externalizable)
    - [Object Graphs](#object-graphs)
    - [Security](#security)
    - [Common Pitfalls (EXPAND)](#common-pitfalls)
13. [13. I/O & NIO (CHECK)](#13-io-and-nio)
    - [IO](#io)
    - [NIO](#nio)
14. [14. Networking (TODO)](#14-networking)
    - [](#)
    - [](#)
    - [](#)
    - [](#)
15. [15. Spring Framework (TODO)](#15-spring-framework)
    - [Dependency Injection](#dependency-injection)
    - [Inversion of Control](#inversion-of-control)
    - [Aspect-Oriented Programming](#aspect-oriented-programming)
    - [Maven](#maven)
    - [Bean lifecycle (TODO)](#bean-lifecycle)
    - [Annotations (TODO)](#annotations)
16. [16. Spring Boot (TODO)](#16-spring-boot)
    - [](#)
    - [](#)
    - [](#)
    - [](#)
    - [](#)
17. [17. JDBC (TODO)](#17-jdbc)
    - [Connections (TODO)](#connections)
    - [Prepared Statements (TODO)](#prepared-statements)
    - [SQL Injection Prevention (TODO)](#sql-injection-prevention)
    - [Transactions (TODO)](#transactions)
18. [18. Testing & Best Practices (TODO)](#18-testing-and-best-practices)
    - [Unit Testing Basics (TODO)](#unit-testing-basics)
    - [Clean Code Principles (TODO)](#clean-code-principles)
    - [Common Java Pitfalls (TODO)](#common-java-pitfalls)
19. [19. Interview Questions & Anwers (TODO)](#19-interview-questions-and-answers)
    - [](#)
    - [](#)
    - [](#)
    - [](#)

## 1. Core Java Fundamentals
### JVM, JRE, JDK
The JVM is the runtime engine that executes Java bytecode.
Java source code (.java) is compiled into bytecode (.class)
The JVM interprets or JIT-compiles that bytecode into machine code
This is what makes Java platform-independent ("write once, run anywhere")

The JRE is what you need to run Java applications.
It includes:
- The JVM
- Core Java class libraries (java.lang, java.util, etc.)
- Supporting runtime files

The JDK is what you need to develop Java applications.
It includes:
- The JRE
- Development tools:
    - javac (compiler)
    - java (launcher)
    - javadoc
    - jar
    - Debuggers and profilers

### Compilation vs Execution
Compilation is the process of converting human-readable source code into a lower-level form that a computer or runtime can understand. The Java compiler (javac) converts .java files into bytecode (.class files).

What happens during compilation:
- Syntax checking (missing semicolons, invalid keywords)
- Type checking (incompatible types, missing methods)
- Method and variable resolution
- Generation of bytecode (platform-independent)

If compilation fails, the program does not run, errors are caught before execution.

Execution is the process of running the compiled program so that it performs its intended behavior.

In Java:
1. The JVM (Java Virtual Machine) loads the .class files
2. Bytecode is either interpreted or compiled into native machine code via Just-In-Time (JIT).
3. The program instructions are executed on the CPU


## 2. Object-Oriented Programming

Note: in Java methods, objects are passed by reference, which means that modifying the object passed as a parameter will affect the original object.

### Encapsulation

Encapsulation is about bundling data and behavior together and restricting direct access to internal state.
It means that fields are usually private, access happens through public methods and the class controls how its data is read or modified.

```Java
public class BankAccount {
    private double balance;

    public double getBalance() {
        return balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Invalid amount");
        }
        balance += amount;
    }
}
```

Encapsulation hides internal state and exposes only controlled operations, improving safety and maintainability.

In Java, visibility (access control) defines where a class member (field, method, constructor, or class) can be accessed from. Java provides four visibility levels, controlled using access modifiers:
- public: Accessible from any class across packages and modules.
- protected: Accessible within the same package and accessible in subclasses, even in different packages.
- default: Accessible only within the same package, no keyword used.
- private: Accessible only within the same class, not visible to subclasses or other classes.

### Inheritance

Inheritance allows a class or interface to reuse and extend behavior from another class or interface.
It implements an IS-A relationship between parent and children classes. The child class inherits fields and methods of the parent. In Java inheritance is established via the extends keyword.

It allows for code reuse, creates a logical hierarchy and enables polymorphism.
```Java
public class Vehicle {
    public void move() {
        System.out.println("Vehicle is moving");
    }
}

public class Car extends Vehicle {
    public void openTrunk() {
        System.out.println("Trunk opened");
    }
}
```

Examples of inheritance are:
- a class extending another class
- an interface extending another interface

Note: A class implementing an interface is not an example of inheritance.

### Polymorphism

Polymorphism is the ability of different types to respond to the same operation in different ways, this is achieved in different ways:
- Coercion is an operation that serves multiple types through implicit-type conversion. For example, you divide an integer by another integer or a floating-point value by another floating-point value. If one operand is an integer and the other operand is a floating-point value, the compiler coerces (implicitly converts) the integer to a floating-point value to prevent a type error. Another example is passing a subclass object reference to a method's superclass parameter. The compiler coerces the subclass type to the superclass type to restrict operations to those of the superclass.
- Overloading refers to using the same operator symbol or method name in different contexts. For example, you might use + to perform integer addition, floating-point addition, or string concatenation, depending on the types of its operands. Also, multiple methods having the same name can appear in a class (through declaration and/or inheritance).
- Parametric polymorphism stipulates that within a class declaration, a field name can associate with different types and a method name can associate with different parameter and return types. The field and method can then take on different types in each class instance (object). For example, a field might be of type `Double` (a member of Java's standard class library that wraps a double value) and a method might return a `Double` in one object, and the same field might be of type `String` and the same method might return a `String` in another object.
- Subtype means that a type can serve as another type's subtype. When a subtype instance appears in a supertype context, executing a supertype operation on the subtype instance results in the subtype's version of that operation executing. For example, consider a fragment of code that draws arbitrary shapes. You can express this drawing code more concisely by introducing a Shape class with a `draw()` method; by introducing `Circle`, `Rectangle`, and other subclasses that override `draw()`; by introducing an array of type Shape whose elements store references to Shape subclass instances; and by calling Shape's `draw()` method on each instance. When you call `draw()`, it's the `Circle`'s, `Rectangle`'s or other `Shape` instances `draw()` method that gets called. We say that there are many forms of `Shape`'s `draw()` method.

Subtype polymorphism relies on upcasting and late binding. Upcasting is a form of casting where you cast up the inheritance hierarchy from a subtype to a supertype. No cast operator is involved because the subtype is a specialization of the supertype. For example, `Shape s = new Circle()`; upcasts from `Circle` to `Shape`. This makes sense because a circle is a kind of shape.

After upcasting `Circle` to `Shape`, you cannot call Circle-specific methods, such as a `getRadius()` method that returns the circle's radius, because Circle-specific methods are not part of Shape's interface. Losing access to subtype features after narrowing a subclass to its superclass seems pointless, but is necessary for achieving subtype polymorphism.

Suppose that Shape declares a `draw()` method, its Circle subclass overrides this method, `Shape s = new Circle();` has just executed, and the next line specifies `s.draw()`;. Which `draw()` method is called: `Shape`'s `draw()` method or `Circle`'s `draw()` method? The compiler doesn't know which `draw()` method to call. All it can do is verify that a method exists in the superclass, and verify that the method call's arguments list and return type match the superclass's method declaration. However, the compiler also inserts an instruction into the compiled code that, at runtime, fetches and uses whatever reference is in s to call the correct `draw()` method. This task is known as late binding.

Moving up the class hierarchy, via upcasting, entails losing access to subtype features. For example, assigning a Circle object to Shape variable s means that you cannot use s to call Circle's `getRadius()` method. However, it's possible to once again access `Circle`'s `getRadius()` method by performing an explicit cast operation like this one: `Circle c = (Circle) s;`.

This assignment is known as downcasting because you are casting down the inheritance hierarchy from a supertype to a subtype (from the `Shape` superclass to the `Circle` subclass). Although an upcast is always safe (the superclass's interface is a subset of the subclass's interface), a downcast isn't always safe.

#### Compile-Time Polymorphism

Compile-Time Polymorphism in Java is also known as static polymorphism, overloading or Ad-Hoc polymorphism. Compile-time polymorphism in Java is the umbrella term for forms of polymorphic behavior that the compiler resolves without needing dynamic dispatch at runtime.

It helps to be precise about what "resolved at compile time" means. Java compilation includes a phase where the compiler performs:
1. Overload resolution: chooses which method signature to call from a set of same-named methods.
2. Type inference: deduces generic type arguments (e.g., <T> or <K, V>).
3. Conversions: inserts/permits primitive widening, boxing/unboxing, reference widening, and (sometimes) selects an overload because one conversion is “better” than another.
4. Static binding for certain constructs (e.g., static methods, private methods, constructors), though those aren’t typically what people mean by compile-time polymorphism—they’re just statically bound.

##### Coercion
In type theory, coercion is when an expression of one type is used where another type is expected, and the language defines a conversion/interpretation. Java has several coercion-like mechanisms:
- Primitive numeric promotion / widening: int → long → float → double (with rules).
- Boxing/unboxing: int ↔ Integer.
- Reference widening: ArrayList → List → Collection → Object.
- String conversion in concatenation: "x=" + someObj uses String.valueOf(...)

In practice Coercion happens when Java automatically converts one type to another so an operation can proceed.
```Java
int a = 10;
double b = 5.5;

double result = a + b;  // int is coerced to double
```

##### Method Overloading

Method overloading is when multiple methods in the same class have the same name but different parameters. Methods can be overloaded by changes in the number of arguments or/and a change in the type of arguments.

Signature: name + number, order and types of the parameters.

Overloading is ad hoc because behavior varies based on the static types of the arguments at the call site. The compiler picks the most specific applicable signature using JLS rules:
1. Collect applicable methods (can the arguments be converted to the parameters?).
2. Prefer methods requiring less severe conversions (exact match beats boxing; boxing beats varargs; etc.).
3. Pick the most specific among applicable candidates.
4. If ambiguous, compilation fails.
```Java
public final class OverloadDemo {
    static void f(int x)     { System.out.println("int"); }
    static void f(long x)    { System.out.println("long"); }
    static void f(Integer x) { System.out.println("Integer"); }
    static void f(Object x)  { System.out.println("Object"); }

    public static void main(String[] args) {
        f(1);                 // ?
        Integer i = 1;
        f(i);                 // ?
        Object o = 1;
        f(o);                 // ?
    }
}
```

- Call 1: Compile-time decision is to bind to f(int).
- Call 2: Compile-time decision is to bind to f(Integer).
- Call 3: Compile-time decision is to bind to f(Object).

So compile-time polymorphism here is purely driven by static types at the call site and legal conversions.

Now let’s layer in inheritance (runtime polymorphism) and show the interaction. A classic trap:
```Java
class Parent {
    void g(Object x) { System.out.println("Parent.g(Object)"); }
}

class Child extends Parent {
    @Override
    void g(Object x) { System.out.println("Child.g(Object)"); }

    void g(String x) { System.out.println("Child.g(String)"); } // overload
}

public class MixDemo {
    public static void main(String[] args) {
        Parent p = new Child();
        p.g("hello");
    }
}
```

At first glance, you might think `"hello"` is a `String` so `Child.g(String)` should run. It doesn’t.

Here’s the two-step mental model:
1. Compile time (overload resolution): The compiler looks at the declared type of `p`, which is Parent. In Parent, the only visible `g` is `g(Object)`. So the call is compiled as `Parent.g(Object)`.
2. Runtime (override dispatch): The selected signature is g(Object)—and that method is overridden in Child. So at runtime, dynamic dispatch chooses `Child.g(Object)`.

Result printed: `Child.g(Object)`.

This is the cleanest illustration of the boundary:
1. Overloading is chosen at compile time based on the static type of the reference and arguments.
2. Overriding is chosen at runtime based on the runtime class of the receiver (for instance methods).

If you change the static type:
```Java
Child c = new Child();
c.g("hello"); // now overload resolution sees both g(Object) and g(String); picks g(String)
```
Now you get `Child.g(String)`.

Let's now have a look at coercion and method overloading together:
```Java
public final class CoercionDemo {
    static void h(long x)    { System.out.println("long"); }
    static void h(Integer x) { System.out.println("Integer"); }
    static void h(int... xs) { System.out.println("varargs"); }

    public static void main(String[] args) {
        h(1);    // which?
    }
}
```
h(1) chooses h(long), not h(Integer) and not varargs, because: int → long is primitive widening, int → Integer is boxing, varargs is lower priority than fixed arity. In overload resolution, Java prefers widening over boxing, and fixed arity over varargs.

Now consider:
```Java
static void k(Long x)   { System.out.println("Long"); }
static void k(Integer x){ System.out.println("Integer"); }

k(null); // ambiguous!
```

`null` is compatible with any reference type, so both are applicable and neither is more specific (they’re unrelated). The compiler rejects it. The fix is to cast: `k((Long) null)`.

Numeric literals and constant folding can change applicability:
```Java
static void m(byte x) { System.out.println("byte"); }
static void m(int x)  { System.out.println("int"); }

m(1); // prints "int"
```
Even though 1 could fit in a byte, Java does not automatically narrow int literal to byte for overload selection unless it’s a constant and the target is a byte parameter and the method is otherwise applicable—here both are applicable? Actually m(byte) is applicable only if the compiler can convert the constant 1 to byte without a cast; for constant expressions, it can. Yet m(byte) is more specific than m(int) because byte can convert to int, but not vice versa. So this can compile to m(byte) in some cases. Where it gets tricky is when you introduce more overloads and promotions; you start relying on subtle ranking rules. In practice: avoid overload sets that depend on constant narrowing.

Overload selection happens at compile time, but the chosen overload might unbox at runtime:
```Java
static void n(int x) { System.out.println("int"); }
static void n(Object x) { System.out.println("Object"); }

Integer x = null;
n(x); // chooses n(int) via unboxing? Actually Integer->int requires unboxing, so n(int) is applicable; n(Object) is also applicable via widening reference.
      // Which is chosen? n(int) can be considered more specific in some contexts; result: unboxing occurs -> NullPointerException at runtime.
```
This is a classic “compile-time polymorphism caused a runtime crash” scenario: the compiler legally selects the overload, then unboxing happens and blows up. A robust API design avoids overloads that force unboxing when an Object overload is present, or avoids nullable wrappers in such overload sets.

##### Parametric Polymorphism
Parametric Polymorphism abstracts the types that the code uses to perform operations.
Instead of writing separate implementations for String, Integer, or a custom domain type, we write the algorithm once and let the type parameter represent the unknown type, constrained as needed.
Parametrically polymorphic functions and data types are sometimes called generic functions and generic datatypes, respectively, and they form the basis of generic programming.
```Java
public class Box<T> {
    private T value;

    public Box(T value) {
        this.value = value;
    }

    public T get() {
        return value;
    }

    public void set(T value) {
        this.value = value;
    }
}
```
Here, T is a type parameter. At compile time, the compiler enforces type safety: `Box<String>` cannot accept an Integer. The important nuance is that this type information exists only at compile time. Java implements generics via type erasure, meaning that at runtime `Box<String>` and `Box<Integer>` are both just `Box`. The compiler inserts casts where necessary and ensures correctness beforehand. This design preserves backward compatibility with pre-generics bytecode but introduces limitations, such as the inability to create `new T()` or maintain runtime type distinctions between different parameterizations.

Generic methods are equally powerful and often more flexible than generic classes:
```Java
public static <T> T identity(T value) {
    return value;
}
```

The `<T>` before the return type declares a method-level type parameter. The compiler infers `T` from the call site:
```Java
String s = identity("hello");
Integer i = identity(42);
```

This demonstrates parametric polymorphism in its purest form: the same compiled method works for different types without casting at the call site.

Covariance describes a type relationship where a generic type preserves the subtype relationship of its type parameter for safe reading. In Java, this is expressed with `? extends T`. If `Integer` is a subtype of `Number`, then `List<Integer>` can be treated as `List<? extends Number>`. This allows elements to be read safely as `Number`, but disallows inserting elements (except `null`) because the exact subtype is unknown and writing could violate type safety.

Contravariance describes a type relationship where a generic type reverses the subtype relationship of its type parameter for safe writing. In Java, this is expressed with ? super T. If `Integer` is a subtype of `Number`, then `List<Number>` can be treated as `List<? super Integer>`. This allows inserting `Integer` values safely, but when reading, the only guaranteed type is `Object`, since the specific supertype used is unknown.

Bounds allow us to constrain the range of acceptable types. Suppose we need comparison logic:
```Java
public static <T extends Comparable<T>> T max(T a, T b) {
    return a.compareTo(b) >= 0 ? a : b;
}
```

Here, `T extends Comparable<T>` is an upper bound. It guarantees at compile time that `compareTo` is available. This is different from subtype polymorphism because we are not saying "T is a subclass of X to enable overriding," but rather "T must satisfy this structural contract so the algorithm compiles." Multiple bounds are also possible: `<T extends Number & Comparable<T>>`.

Wildcards address variance, which is where many developers struggle. Java generics are invariant, meaning `List<Integer>` is not a subtype of `List<Number>`. To express covariance or contravariance, we use wildcards:
```Java
public static double sum(List<? extends Number> numbers) {
    double total = 0.0;
    for (Number n : numbers) {
        total += n.doubleValue();
    }
    return total;
}
```
The `? extends Number` wildcard allows us to accept `List<Integer>`, `List<Double>`, etc. We can read safely as `Number`, but we cannot add elements because the exact subtype is unknown. Conversely:
```Java
public static void addIntegers(List<? super Integer> list) {
    list.add(1);
    list.add(2);
}
```

Here, `? super Integer` enables contravariant behavior; we can safely insert `Integer` values. The common rule is PECS: Producer Extends, Consumer Super. This is not subtype polymorphism in the classical sense; it is variance control over parameterized types enforced at compile time.

Comparing parametric polymorphism to subtype polymorphism clarifies the distinction. With subtype polymorphism:
```Java
Animal a = new Dog();
a.makeSound();
```

The behavior varies dynamically via method overriding and virtual dispatch at runtime. With parametric polymorphism, the behavior does not change based on subtype; instead, the algorithm is written generically and checked statically. The variation lies in the type argument supplied, not in overridden behavior. In other words, subtype polymorphism is runtime dispatch over a hierarchy; parametric polymorphism is compile-time abstraction over types.

However, type erasure imposes limitations. You cannot use instanceof `List<String>` because generic type arguments are erased. You cannot create arrays of parameterized types (`new List<String>[10]`). Reflection becomes more complex when retrieving generic type information. Another common pitfall involves mixing raw types with parameterized types, which disables compile-time checks and reintroduces runtime risks. Developers also frequently misunderstand variance, leading to incorrect assumptions about assignability between `List<Subclass>` and `List<Superclass>`.

#### Runtime Polymorphism

Runtime Polymorphism in Java is also known as Dynamic Method Dispatch or Method Overriding. Method Overriding occurs when a derived class has a definition for one of the member functions of the base class. That base function is said to be overridden.

Method overriding in Java means when a subclass provides a specific implementation of a method that is already defined in its superclass.
```Java
class Parent {
    void greet() {
        System.out.println("Hello from Parent");
    }
}

class Child extends Parent {
    @Override
    void greet() {
        System.out.println("Hello from Child");
    }
}
```
Note:
- Return types must be the same or covariant
- Cannot override static methods
- Overloading is based on static types, not runtime values. If you pass a subtype through a supertype reference, overload selection won’t “see” the subtype.
- Type erasure limits expressiveness. You can’t overload only by generic type parameter:
    ```Java
    void doIt(List<String> x) {}
    void doIt(List<Integer> x) {} // illegal: same erasure
    ```
    Similarly, you can’t do instanceof `List<String>`.
- If you “override” but accidentally change the parameter type, you create an overload:
    ```Java
    class Base { void process(Object o) {} }
    class Sub extends Base { void process(String s) {} } // not an override
    ```
    Now polymorphism doesn’t work as intended when referenced as Base. Always use @Override; the compiler will catch this.

### Abstraction

Abstraction focuses on hiding the complex implementation details and showing only the essential features of an object. In java abstraction is mainly achieved using either interfaces or abstract classes.

##### Interfaces
- Methods are public by default
- Fields are public static final
- Supports multiple inheritance
- Can have default and static methods (Java 8+): default methods provide an implementation
- No constructors
- No instance state

Use interfaces when you need to define what a class must do, not how:
```Java
interface PaymentService {
    void pay(double amount);
}
class CreditCardPayment implements PaymentService {
    public void pay(double amount) {
        // credit card logic
    }
}
```

##### Abstract classes
- Can have abstract and concrete methods
- Can have instance variables (state)
- Can have constructors
- Supports single inheritance only
- Methods can have any access modifier
- Can maintain protected fields

Use an abstract classes when you need to provide partial implementation while still hiding details:
```Java
abstract class Vehicle {
    abstract void move();

    void start() {
        System.out.println("Vehicle started");
    }
}

class Car extends Vehicle {
    void move() {
        System.out.println("Car drives");
    }
}
```

## 3. Collections Framework
https://www.geeksforgeeks.org/java/java/#:~:text=Memory%20Leaks-,Collections,-Java%20Collections%20provide
Java Collection Framework (JCF) is a set of classes and interfaces that provide ready-made data structures to store and manipulate groups of objects efficiently.
The java.util package contains the Collections class in Java. The Java Collections class is used with the static methods that operate on the collections or return the collection. All the methods of this class throw a NullPointerException if the collection or object passed to the methods is null.

The addAll() method of java.util.Collections class is used to add all the specified elements to the specified collection. Elements to be added may be specified individually or as an array.
```Java
List<String> l = new ArrayList<>();
Collections.addAll(l, "Fruits", "Bat", "Ball");
```

Collections.sort() is used to sort the elements present in the specified list of Collections in ascending order. Collections.reverseOrder() is used to sort in descending order.
```Java
List<String> l = new ArrayList<>();
Collections.sort(l);
Collections.sort(l, Collections.reverseOrder());
```

Collections.binarySearch() method returns the position of an object in a sorted list. To use this method, the list should be sorted in ascending order, otherwise, the result returned from the method will be wrong. If the element exists in the list, the method will return the position of the element in the sorted list, if the element does not exist in the list then this method will return a negative number that shows where the item would be inserted in the list - 1.
```Java
Collections.binarySearch(l, "Horse")
```

The copy() method of Collections class is used to copy all the elements from one list into another. After the operation, the index of each copied element in the destination list will be identical to its index in the source list. The destination list must be at least as long as the source list. If it is longer, the remaining elements in the destination list are unaffected.
```Java
Collections.copy(l1, l2);
```

Collections.disjoint() is used to check whether two specified collections have nothing in common. It returns true if the two collections do not have any element in common.
```Java
Collections.disjoint(l1, l2)
```

The Collection interface is the root of the Java Collections Framework, defined in the java.util package. It represents a group of individual objects as a single unit and provides basic operations for working with them. Collections can automatically grow or shrink in size, unlike arrays that have a fixed length. Can hold same-type or different-type elements based on implementation. Allows easy access and processing of elements using loops or iterators. Provides convenient methods such as add(), remove(), and clear() to manage elements effortlessly.
```Java
public interface Collection<E> extends Iterable<E>
```

The Collection interface is part of a hierarchy that extends Iterable, which means collections can be traversed.
### List

List is an interface in the Java Collections Framework that represents an ordered collection (also called a sequence). It maintains insertion order, allows duplicate elements and supports index-based access, supports null elements (implementation dependent) and supports bidirectional traversal using ListIterator.
public interface List<E> extends Collection<E> { }

Note: you can't remove an item from a collection you're iterating over (this throws ConcurrentModificationException in Java). You can get around this by explicitly using an Iterator and removing the item or by using Streams.
```Java
Iterator<Integer> it = list.iterator();
while (it.hasNext()) {
    if (it.next() < 0) {
        it.remove(); // safe
    }
}
```

#### ArrayList

An ArrayList in Java is a resizable (or dynamic) array from the java.util package that can grow or shrink automatically as elements are added or removed, unlike regular arrays with a fixed size.
Backed by a dynamic array
Fast random access → O(1)
Slower inserts/removals in the middle → O(n)
not thread-safe
Most commonly used
```Java
ArrayList<Integer> arr = new ArrayList<>();
ArrayList<String> arr = new ArrayList<>(collection);
ArrayList<Double> arr = new ArrayList<>(20);
List<Integer> list = new ArrayList<>();
```

#### LinkedList
It implements a doubly-linked list data structure where elements are not stored in contiguous memory. Each node contains three parts: the data, a reference to the next node, and a reference to the previous node
Backed by a doubly linked list
Fast inserts/removals at ends → O(1)
Slower access → O(n)
Also implements Deque
```Java
LinkedList<Object> list = new LinkedList<>();
LinkedList<Object> list = new LinkedList<>(collection);
List<Integer> list = new LinkedList<>();
```

### Set
Set is an interface that is part of the Java Collections Framework and represents a collection that does not allow duplicate elements.
No duplicates (based on equals() comparison)
At most one null element (except for TreeSet which does not allow null elements)
No guaranteed ordering (unless a specific implementation provides it)
Use a Set when:
You need to ensure uniqueness
Order is not important (or is handled explicitly)
Fast lookup, insertion, or removal is required
Set uses equals() to check if elements are the same while Hash-based sets (HashSet, LinkedHashSet) also rely on hashCode().
If you store custom objects in a Set, you must override both equals() and hashCode(), or duplicates may appear.

#### HashSet
It is used to store the unique elements, and it doesn't maintain any specific order of elements.
Capacity refers to the number of buckets in the hash table. The default capacity of a HashSet is 16.
The Load Factor is a measure that controls how full the HashSet can get before resizing. Default Load Factor = 0.75. If the number of elements exceeds the threshold, the capacity is doubled.
Unordered
Allows one null
Uses HashMap internally which is an implementation of hash table data structure
implements Serializable and Cloneable interfaces
not thread-safe
O(1) average time for add, remove, contains
Creates a new empty HashSet with default capacity (16) and load factor (0.75).
HashSet<String> set = new HashSet<>();

Creates an empty HashSet with the specified initial capacity and default load factor (0.75).
HashSet<Type> set = new HashSet<>(int initialCapacity);

Creates an empty HashSet with the given initial capacity and load factor.
HashSet<Type> set = new HashSet<>(int initialCapacity, float loadFactor);

Creates a new HashSet containing the elements of the specified collection (removes duplicates automatically).
HashSet<Type> set = new HashSet<>(c);

#### LinkedHashSet
https://www.geeksforgeeks.org/java/linkedhashset-in-java-with-examples/
Maintains insertion order (uses a separate linked list to keep insertion order)
More space required compared to HashSet
Allows one null
TreeSet
https://www.geeksforgeeks.org/java/treeset-in-java-with-examples/
Sorted (natural order or via Comparator)
Does not allow null
Backed by a Red-Black Tree
O(log n) operations

### Map
https://www.geeksforgeeks.org/java/map-interface-in-java/
Map is an interface part of the Java Collections Framework and represents but it is not a subtype of Collection.
A Map represents a key-value data structure, where:
Keys are unique
Each key maps to at most one value
Values can be duplicated

Map methods:
- put(K key, V value)
- get(Object key)
- remove(Object key)
- containsKey(Object key)
- containsValue(Object value)
- keySet()
- values()
- entrySet()

#### HashMap
https://www.geeksforgeeks.org/java/java-util-hashmap-in-java-with-examples/
Unordered
Average O(1) time for get and put
Allows one null key and multiple null values
Not thread-safe
Map<String, Integer> map = new HashMap<>();
map.put("A", 1);
LinkedHashMap
https://www.geeksforgeeks.org/java/linkedhashmap-class-in-java/
Insertion order preserved
More space required compared to HashMap
Useful for LRU cache
Map<String, Integer> map = new LinkedHashMap<>();
map.put("A", 1);

#### TreeMap
https://www.geeksforgeeks.org/java/treemap-in-java/
Sorted by key
Based on Red-Black Tree
O(log n) time complexity
Does not allow null keys
Map<String, Integer> map = new TreeMap<>();
map.put("A", 1);
ConcurrentHashMap
Thread-safe
Better performance than synchronized maps
Does not allow null keys or values

HashMap vs TreeMap
Aspect
HashMap
TreeMap
Data structure
Hash table
Red black tree
Ordering
no ordering
sorted by key
Time Complexity
O(1) average
O(log n)
Null Keys
One null key allowed
No null keys
Use case
Fast Operations
Ordered data / range operations

### Queue
https://www.geeksforgeeks.org/java/queue-interface-java/
Queue is an interface in Java and is part of the Collections Framework.
A Queue in Java is a linear data structure that follows the FIFO (First-In, First-Out) principle, the first element added is the first one removed.
There is also PriorityQueue which is an implementation of Queue based on a Heap and does not follow FIFO principle but orders the elements based on natural ordering or using a comparator.

#### PriorityQueue
https://www.geeksforgeeks.org/java/priority-queue-in-java/

### Iterator
https://www.geeksforgeeks.org/java/iterators-in-java/

### Comparator
https://www.geeksforgeeks.org/java/java-comparator-interface/

### HashMap vs TreeMap

## 4. Exception Handling

https://www.geeksforgeeks.org/java/java/#:~:text=Employee%20Management%20System-,Exception%20Handling,-Java%20Exception%20Handling
Exception handling is Java's mechanism for dealing with runtime errors in a controlled way, without crashing the application.
Exceptions represent abnormal conditions such as: invalid input, missing files, network failures, database errors, programming bugs.
Java enforces exception handling to separate error-handling logic from business logic, improve reliability and enable graceful failure and recovery.
Object
 └── Throwable
      ├── Error (JVM-level problems, usually not handled)
      └── Exception
           ├── Checked Exceptions
           └── RuntimeException (Unchecked Exceptions)

### Checked vs Unchecked Exceptions

Checked exceptions are checked at compile time, handle them using try-catch, or declare them using throws. Examples: IOException, SQLException, ClassNotFoundException.

Use when:
1. The caller can reasonably recover
2. The failure is expected and external

Unchecked exceptions occur at runtime and are not enforced by the compiler. Examples: NullPointerException, IllegalArgumentException, IndexOutOfBoundsException, ArithmeticException.

Use when
1. It's a programming error
2. Recovery is not meaningful at runtime

#### try-catch-finally
try: contains code that may throw an exception.
catch: handles a specific exception type.
finally: always executes regardless of exception, even if an exception is thrown or a return statement is executed. It is mainly used for resource cleanup.
```Java
try {
    int result = 10 / 0;
} catch (ArithmeticException e) {
    System.out.println("Cannot divide by zero");
}
```

Note:
1. Always catch most specific exceptions first
2. Multiple catch blocks are allowed
```Java
try {
    openConnection();
} catch (Exception e) {
    log(e);
} finally {
    closeConnection(); // always runs
}
```

#### throw vs throws

throw: is used to throw an exception.
```Java
if (age < 18) {
    throw new IllegalArgumentException("Age must be >= 18");
}
```

throws: used in a method signature to declare exceptions the method may pass up to the caller of the function to handle.
```Java
public void readFile() throws IOException {
    FileReader reader = new FileReader("file.txt");
}
```

Note: using throws you can declare multiple exceptions.

#### Custom Exceptions

Custom exceptions allow you to model domain-specific failures.

*Why Use Custom Exceptions?*
1. Improve readability
2. Provide business context
3. Enable precise error handling
4. Avoid generic Exception usage

*Example*
```Java
// Creating a custom checked exception.
public class InsufficientBalanceException extends Exception {
    public InsufficientBalanceException(String message) {
        super(message);
    }
}

// Usage:
public void withdraw(double amount) throws InsufficientBalanceException {
    if (amount > balance) {
        throw new InsufficientBalanceException("Not enough funds");
    }
}

// Creating a custom unchecked exception.
public class InvalidOrderException extends RuntimeException {
    public InvalidOrderException(String message) {
        super(message);
    }
}
```

Never:
- catch a Throwable because: it masks fatal JVM errors, prevents proper shutdown, makes the system unstable and unpredictable.
- using exceptions for normal flow control i.e.:
    ```Java
    try {
        return list.get(0);
    } catch (IndexOutOfBoundsException e) {
        return null;
    }
    ```
- put "throws Exception" on a method or creating many checked exceptions for every small condition.
    ```Java
    Ignoring finally execution rules
    try {
        return 10;
    } finally {
        return 20; // overrides try return!
    }
    ```
- overriding custom exception constructors wrongly

## 5. Java 8+ Features

### Functional interfaces
A Functional Interface in Java is an interface that contains exactly one abstract method. It represents a single unit of behavior, making it the foundation of lambda expressions and functional programming in Java (introduced in Java 8).
Example of a functional interface:
```Java
@FunctionalInterface
interface Logger {
    void log(String msg);

    default void info(String msg) {
        log("INFO: " + msg);
    }
}
```

Default or static methods don't break the functional interface.

### Lambda Expressions

https://www.geeksforgeeks.org/java/lambda-expressions-java-8/
Lambda expressions represent anonymous functions, pieces of behavior you can pass around as data.
A lambda can only be used where a functional interface is expected.

*Example*

```Java
// Before Java 8
Comparator<Integer> cmp = new Comparator<>() {
    public int compare(Integer a, Integer b) {
        return a.compareTo(b);
    }
};

// With Lambda
Comparator<Integer> cmp = (a, b) -> a.compareTo(b);
@FunctionalInterface
interface Calculator {
    int add(int a, int b);
}

Calculator calc = (a, b) -> a + b;
```

Common built-in functional interfaces:
- `Predicate<T>`:  boolean result
- `Function<T, R>`: transforms data
- `Consumer<T>`: performs action
- `Supplier<T>`: provides value

Lambdas can capture variables from the enclosing scope only if they are effectively final.
```Java
int factor = 2;

Function<Integer, Integer> f = x -> x * factor; // OK
// factor = 3; ❌ not allowed
```

### Method References
https://www.geeksforgeeks.org/java/java-method-references/

### Streams
https://www.geeksforgeeks.org/java/java-8-stream-tutorial/
The Java Streams are a high-level abstraction for processing collections of data in a functional, declarative way. It lets you express what you want to do with data rather than how to do it.
A Stream is a sequence of elements that are processed lazily, support functional style operations and can be sequential or parallel. Streams are not data structures, once consumed they are gone and it does not mutate the source collection.
Think of a stream as a pipeline of operations applied to data.
A stream pipeline has three parts: Source → Intermediate Operations → Terminal Operation.
```Java
int sum =
    numbers.stream()                  // source
           .filter(n -> n > 10)        // intermediate
           .map(n -> n * 2)            // intermediate
           .reduce(0, Integer::sum);   // terminal
```

Common Stream intermediate operations:
- filter(Predicate)
- map(Function): applies the transformation function to each element in Stream.
- flatMap(Function): for each element in stream applies the transformation function which produces multiple values and then turns them all into a single list of values.
- sorted(): 
- distinct()
- limit(n)
- peek(Consumer)

*Example*
```Java
stream.filter(x -> x > 0).map(x -> x * 2);
```

Common Stream terminal operations:
- forEach
- collect: collects all the elements into a collection i.e.: toList(), toSet(), toMap(), groupingBy(), partitioningBy().
    ```Java
    Map<String, List<User>> usersByRole = users.stream()
    .collect(Collectors.groupingBy(User::getRole));
    ```
- reduce: combines elements into a single value.
    ```Java
    int sum = numbers.stream().reduce(0, (a, b) -> a + b);
    ```
- findFirst, findAny
- anyMatch, allMatch, noneMatch
- count
List<String> result =
    names.stream()
         .filter(n -> n.startsWith("A"))
         .collect(Collectors.toList());

Streams:
- Improve readability
- Encourage functional programming
- Enable easy parallelization
- Reduce boilerplate loops
- Promote immutability and declarative style

### Optional
Optional<T> is a container object that may or may not contain a non-null value. It was introduced in Java 8 to reduce NullPointerException and make code more expressive about the absence of a value.
Before Optional, missing values were usually represented by null, which causes:
- NullPointerException
- Unclear API contracts
- Defensive null checks everywhere
Optional forces the developer to explicitly handle the "value missing" case.

Note: Optional.of(null) throws NullPointerException.
Common Methods:
- isPresent(): returns true if the value is present
- ifPresent(func): executes a function on the value if the value is present
- orElse(def): returns the value or a default value passed as parameter
- orElseGet(func): return the value if present, otherwise invoke func and return the result of that invocation.
- orElseThrow: return the contained value, if present, otherwise throw an exception to be created by the provided supplier.

```Java
opt.ifPresent(v -> System.out.println(v));

String value1 = opt.orElse("default");

String value2 = opt.orElseGet(() -> computeDefault());

String value3 = opt.orElseThrow(() -> 
    new IllegalStateException("Value missing"));

Optional<Integer> length = opt.map(String::length);
Optional<String> result = opt.filter(s -> s.startsWith("A"));
```

*How to use Optional*
```Java
Optional<User> findUserById(long id);
```

Don't:
- call get() method without first establishing if optional has a value this may throw NoSuchElementException
- Check if element is present and then use get() method (unless you have to) Optional is not meant to be treated like null values

#### Exercise
Convert this code into Optional:
```Java
if (user != null && user.getAddress() != null) {
    return user.getAddress().getCity();
}
return "Unknown";
```

##### Solution
```Java
return Optional.ofNullable(user).map(User::getAddress)
.map(Address::getCity()).orElse("Unknown")
```

## 6. Concurrency and Parallelism
- https://www.geeksforgeeks.org/java/java-multithreading-tutorial/
- https://www.geeksforgeeks.org/java/java-threads/
- https://www.geeksforgeeks.org/java/difference-between-thread-start-and-thread-run-in-java/
- https://www.geeksforgeeks.org/java/thread-sleep-method-in-java-with-examples/
- https://www.geeksforgeeks.org/java/daemon-thread-java/
- https://www.geeksforgeeks.org/java/synchronization-in-java/
- https://www.geeksforgeeks.org/java/thread-safety-and-how-to-achieve-it-in-java/
- https://www.geeksforgeeks.org/java/how-to-use-locks-in-multi-threaded-java-program/
- https://www.geeksforgeeks.org/java/difference-between-lock-and-monitor-in-java-concurrency/
- https://www.geeksforgeeks.org/java/lock-framework-vs-thread-synchronization-in-java/
- https://www.geeksforgeeks.org/java/reentrant-lock-in-java/
- https://www.geeksforgeeks.org/java/deadlock-in-java-multithreading/
- https://www.geeksforgeeks.org/java/thread-pools-java/
- https://www.geeksforgeeks.org/java/what-is-java-executor-framework/
- https://www.geeksforgeeks.org/java/java-lang-thread-class-java/
- https://www.geeksforgeeks.org/java/lifecycle-and-states-of-a-thread-in-java/
- https://www.geeksforgeeks.org/java/java-thread-priority-multithreading/
- https://www.geeksforgeeks.org/java/main-thread-java/
- https://www.geeksforgeeks.org/java/java-util-concurrent-package/
- https://www.geeksforgeeks.org/java/java-util-concurrent-executor-interface-with-examples/
- https://www.geeksforgeeks.org/java/java-util-concurrent-executorservice-interface-with-examples/
- https://www.geeksforgeeks.org/java/runnable-interface-in-java/
- https://www.geeksforgeeks.org/java/callable-future-java/
- https://www.geeksforgeeks.org/java/difference-between-callable-and-runnable-in-java/

### Concurrency vs Parallelism

### Thread vs Runnable
A thread is the smallest unit of execution within a process. It represents a single flow of control that the CPU can schedule and run independently.
- Lightweight: creating a thread is cheaper than creating a process.
- Shared Resources: threads share heap memory, files, and objects of the process. Each thread has its own stack (local variables and call frames).
Concurrent Execution: multiple threads can run at the same time (or be time-sliced on a single CPU).

Independent Execution: if one thread blocks or waits, others can continue running.

In Java, multithreading can be achieved in two main ways, by extending the Thread class or by implementing the Runnable interface.
By extending the Thread class:
- The task logic is placed in the run() method.
- Calling start() creates a new thread and calls run() internally.
- Limitation: Java supports single inheritance, so you cannot extend another class.

```Java
class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("Thread running");
    }
}

public class Main {
    public static void main(String[] args) {
        MyThread t = new MyThread();
        t.start(); // creates a new thread
    }
}
```

By implementing the Runnable interface the class can still extend another class and the same Runnable can be executed by multiple threads.
```Java
class MyTask implements Runnable {
    @Override
    public void run() {
        System.out.println("Runnable running");
    }
}

public class Main {
    public static void main(String[] args) {
        Thread t = new Thread(new MyTask());
        t.start();
    }
}
```

### Callable vs Runnable
Runnable is used to perform a task and it cannot declare checked exceptions.
```Java
@FunctionalInterface
public interface Runnable {
    void run();
}
```
Callable is used to perform a task that returns a value and can throw checked exceptions
```Java
@FunctionalInterface
public interface Callable<V> {
    V call() throws Exception;
}
```

### Java Memory Model
The Java Memory Model defines how and when threads can see and modify shared data.
In short: JMM defines correctness rules for multithreaded Java programs.

Conceptually, JMM splits memory into:
- Main Memory: Shared among all threads, contains instance fields, static fields, and array elements.
- Thread (Working) Memory: Private to each thread, holds copies of variables read from main memory, threads read/write variables here first.

Changes made by one thread are not guaranteed to be visible to others unless proper synchronization is used.

```Java
boolean running = true;

Thread t1 = new Thread(() -> {
    while (running) { }  // may never stop
});

Thread t2 = new Thread(() -> {
    running = false;
});
```

Even though t2 sets running = false, t1 may never see the update because:
t1 may cache running in its working memory
No synchronization means no guarantee of visibility

### Volatile
The volatile keyword ensures that a variable is visible (a write can be seen by all other threads) as well as order of operations (reads/writes cannot be reordered across volatile operations), however it does not guarantee mutual exclusion.

### Synchronization
With multiple threads, you can get:
Race conditions: two threads interleave operations and produce wrong results.
Visibility issues: one thread updates a value, another thread keeps seeing an old value.
Reordering issues: the compiler/JIT/CPU reorder reads/writes for performance, breaking assumptions.
Java gives you tools mainly to enforce:
Mutual exclusion (only one thread at a time touches something)
Visibility (writes by one thread become visible to others predictably)
Ordering (certain operations can't be reordered across a boundary)

synchronized is a monitor lock (a mutex) tied to an object (or the class object for static sync). It gives you:
- Mutual exclusion: only one thread can be inside a synchronized block on the same monitor at once.
- Visibility & ordering: it creates a happens-before relationship.
- Synchronized does not offer atomicity.

Entering and exiting a synchronized block establishes a happens-before relationship, therefore synchronized guarantees atomicity and visibility of shared variables and prevents race conditions.
The JVM and CPU may reorder instructions for performance, reordering is allowed unless it breaks happens-before rules.

When a thread enters a synchronized block it acquires the monitor lock (may block).
When a thread exits it releases the lock, all writes done inside the block are flushed so that another thread acquiring the same lock will see them.

Every Java object has an intrinsic (monitor) lock, a thread must acquire that lock before entering a synchronized block.
```Java
synchronized void increment() { } // method-level
synchronized(this) { } // block-level
synchronized(MyClass.class) { } // class-level
```

It is used to protect critical sections where shared mutable state is modified, it creates simple concurrency control without advanced locking needs.

*Pros*
- Simple and safe
- Automatic lock release (even on exceptions)

*Cons*
- Blocking (threads wait)
- No timeout, no fairness control
- Can hurt performance under contention

### Race Conditions

### Deadlocks

### Locks
Lock gives advanced features that synchronized doesn't:
Try lock without blocking (tryLock)
Timed acquisition (tryLock(timeout))
Interruptible acquisition (lockInterruptibly)
Multiple conditions per lock (Condition)
Fairness policies (queueing fairness)
Some locks are optimized for read-heavy workloads (ReadWriteLock)

A ReentrantLock is like synchronized but explicit:
```Java
Lock lock = new ReentrantLock();

lock.lock();
try {
  // critical section
} finally {
  lock.unlock();
}
```

Note: always unlock it in finally, this is not optional.

Use synchronized when:
- need simple mutual exclusion
- want the simplest, hardest-to-misuse solution
- don't need timed/interruptible locking

Use Lock / ReentrantLock when:
- need tryLock, timeouts, fairness, interruptible locking
- need multiple conditions
- implementing advanced concurrency primitives

Use volatile when:
- need visibility for a simple flag/state
- doing safe publication of immutable objects or references
- don't need atomic compound updates

### Thread Pools
A Thread Pool is a collection of pre-created, reusable threads that are kept ready to perform tasks. Instead of creating a new thread every time you need to run something (which is costly in terms of memory and CPU), a thread pool maintains a fixed number of threads. When a task is submitted:
1. If a thread is free, it immediately picks up the task and runs it.
2. If all threads are busy, the task waits in a queue until a thread becomes available.
3. After finishing a task, the thread does not die. It goes back to the pool and waits for the next task.

Generally speaking, ExecutorService automatically provides a pool of threads and an API for assigning tasks to it.

Executor Interface is the root interface of the framework that is used to execute submitted tasks without explicitly creating threads. Defines a single method:
```Java
Executor executor = command -> new Thread(command).start();
executor.execute(() -> System.out.println("Task executed"));
```

The ExecutorService extends the Executor interface and provides advanced methods for task management, such as submitting tasks that return results and controlling executor shutdown.
Supports both Runnable and Callable tasks.
Provides lifecycle management (shutdown, awaitTermination).
Can execute multiple tasks simultaneously.
```Java
ExecutorService service = Executors.newFixedThreadPool(2);
service.submit(() -> System.out.println("Running a task"));
service.shutdown();
```

ThreadPoolExecutor is the most commonly used implementation of ExecutorService. It manages a pool of worker threads to execute tasks efficiently, reusing threads to reduce overhead.
Controls core pool size, maximum pool size, and queue capacity.
Supports custom thread factory and rejection policies.
```Java
ExecutorService executor = Executors.newFixedThreadPool(3);
executor.execute(task);
```

### Atomics
https://medium.com/@qingedaig/java-volatile-vs-atomic-classes-7599eb70a661

## 7. Java Memory Management
https://www.geeksforgeeks.org/java/java/#:~:text=and%20Pattern%20Matching-,Memory%20Allocation,-Java%20Memory%20Allocation
When your Java program runs on the JVM, memory is divided into several logical areas.
The ones you care about most for interviews:
Heap: where objects and arrays live
Stack(s): each thread has its own stack, where method calls and local variables live
Metaspace: where class metadata lives
Native memory: used by JVM internals, direct buffers, JNI, etc.

### Stack
The stack is used as memory for method calls and threads, each method call or thread has its own stack. The stack holds frames, one per active method call. Each frame contains:
Local primitive variables and references to objects on the heap
The operand stack (for bytecode operations)
Return address
The stack is LIFO which means that frames are pushed on method call and popped on return. It's fast because it's purely pointer moves with no GC involved. The stack data lives only until the method returns and it's not shared between threads.

```Java
public void foo() {
    int x = 10;          // x is on the stack (primitive)
    Person p = new Person("Alice"); // p is on the stack, Person object is on the heap
}
```

x is on the foo stack
p reference is on the foo stack
p object is in the heap
When the foo method returns its stack frame is popped and x and p are gone. The Person object may still live on the heap if some other reference points to it, otherwise, it becomes eligible for GC.
StackOverflowError: usually caused by deep or infinite recursion; the thread/method's stack runs out of space.

### Heap
The heap is a shared area where all objects and arrays are allocated (instances of classes), it also contains the fields of those objects both primitive and reference fields.
The heap is shared by all threads and requires synchronization for shared mutable state. It is managed by the garbage collector which means that it has slower allocation and deallocation than the stack.

```Java
public class Person {
    String name;      // field, stored inside the object on the heap
    int age;
}

public void bar() {
    Person p = new Person();
    p.name = "Bob";   // modifying object on heap
    p.age = 30;
}
```

The reference of p is on the stack.
The Person object and its fields name, age are on the heap.
"Bob" (a String) is also an object on the heap (immutable).
OutOfMemoryError: Java heap space is full and GC cannot free enough memory.

Semantically, objects are on the heap; the JVM may optimize some allocations away using escape analysis and placing them on the stack.

### Garbage Collection
Java uses automatic memory management, the engineer only allocates objects with new and does not explicitly free them. The GC periodically frees objects that are no longer reachable.

#### Memory leaks
Memory leaks happen when holding references to objects you no longer actually need, preventing GC from collecting them.

*Examples*

Unbounded Collections: cache is a static field and nothing removes elements from cache which means that it will grow until OutOfMemoryError.

```Java
private static final List<byte[]> cache = new ArrayList<>();

public void leak() {
    byte[] block = new byte[1024 * 1024];
    cache.add(block);  // never removed
}
```
If a Listener registers and never unregisters, and the Publisher outlives it, the Publisher holds a reference to Listener, even if nobody else cares about Listener, it stays reachable via Publisher.listeners.

```Java
class Publisher {
    private final List<Listener> listeners = new ArrayList<>();
    void register(Listener l) { listeners.add(l); }
}
```

#### Generational Garbage Collection
https://newrelic.com/blog/apm/java-garbage-collection#:~:text=During%20the%20garbage%20collection%20process,up%20memory%20in%20the%20heap.

## 8. Immutability
An object is immutable if, after it's been constructed, its observable state can never change for any caller.
Immutable objects are naturally thread-safe because they can't change.

### Immutable Variables
Using final on a variable means "this variable can't be reassigned", it does not mean the object referenced is immutable.

### Immutable Methods

### Immutable Classes
An immutable class must have all the fields set as private, does not provide any setters or other state-modifying methods, does not allow subclasses (either because the class is final or make the constructor private and use a factory), all fields are initialized in the constructor, do not pass this to other objects that might mutate the state.

*Example*
```Java
public final class Person {
    private final String name;
    private final int age; // primitive, so fine

    public Person(String name, int age) {
        // validate here if you want (e.g. age >= 0)
        this.name = name;
        this.age = age;
    }

    // Only getters; no setters
    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    // Optionally with methods that return new instances instead of modifying state
    public Person withAge(int newAge) {
        return new Person(this.name, newAge);
    }
}
```
This is not immutable because you expose the values map which can lead to state modification:
```Java
public final class Config {
    private final Map<String, String> values;

    public Config(Map<String, String> values) {
        this.values = values; // no defensive copy
    }

    public Map<String, String> getValues() {
        return values; // exposes mutable map
    }
}
```
Instead you should return a copy of the values map.

#### String immutability
String is one of the most important immutable classes in Java.
```Java
public final class String implements Serializable, Comparable<String>, CharSequence {
    private final char[] value;
    private final int hash; // cached hash code, computed lazily
    // ...
}
```
The value is a character array, but it's private final, and never exposed, no method in String ever mutates that array; all "modifying" methods (substring, toUpperCase, replace, etc.) return new String objects.
Because strings are immutable, Java can safely reuse instances in the String pool.
```Java
String a = "hello";
String b = "hello";
System.out.println(a == b); // true -- same instance from pool
```

If strings were mutable, this would be unsafe because changing a would implicitly change b.

#### Benefits and pitfalls

*Pros*
- Once created, the object never changes, no debugging.
- No need to think about object lifecycle beyond construction.
- No partial or inconsistent state after construction.
- Immutable objects are inherently thread-safe
- You can safely cache and reuse immutable objects
- Methods equals & hashCode are stable over time
- Methods that return new immutable objects instead of mutating arguments fit functional programming style
- Easier to test; no need to reset state between tests.

*Cons*
- Performance and memory overhead: every state change requires a new instance

## 9. Equals and HashCode Contract
Identity and Equality are 2 distinct concepts:
- identity means same object reference in memory and is checked this way `a == b`
- equality means same value according to some logical definition you choose and is checked this way a.equals(b)
By default, the equals method performs an identity check (==). To define logical equality (e.g., two User objects with the same id are "equal"), you must override equals() and also hashCode().

Any implementation of the equals method must satisfy these rules:
- Reflexive: x.equals(x) is always true.
- Symmetric: if x.equals(y) is true, then y.equals(x) must also be true.
- Transitive: if x.equals(y) and y.equals(z) are true, then x.equals(z) must be true.
- Consistent: multiple calls with the same values should give the same result, as long as the objects don't change.
- Non-null: x.equals(null) must always return false.

The hashCode method is an int used to quickly group objects into buckets in hash-based collections.

Any implementation of the hashCode method must satisfy these rules:
- Consistency: during a single execution, if the object's fields used in equals method don't change, x.hashCode() must always return the same value.
- Equal objects have equal hash codes: if x.equals(y) is true, then x.hashCode() == y.hashCode() must be true.
- Unequal objects may have equal hash codes: different objects can have the same hash code (hash collisions are allowed), but fewer collisions are better for performance.
The critical rule is number 2. If you override equals but not hashCode, you almost certainly violate it.

Let's say we have a Person class where two persons are considered equal if they have the same id:
```Java
public class Person {
    private final int id;
    private final String name;

    public Person(int id, String name) {
        this.id = id;
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        // 1. Check reference equality
        if (this == o) return true;
        // 2. Check for null and type
        if (o == null || getClass() != o.getClass()) return false;
        // 3. Cast and compare fields
        Person person = (Person) o;
        return id == person.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}
```

Note:
- The equals(Object o) method must take an Object, not Person. Otherwise it doesn't override correctly.
getClass() != o.getClass() ensures symmetry when dealing with inheritance.
- Only use fields that define logical equality in this case, just id.
hashCode() uses the same fields as equals()
- If you add the name field to equals(), you must also include it in hashCode(), example:
    ```Java
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Person)) return false;
        Person person = (Person) o;
        return id == person.id &&
            Objects.equals(name, person.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }
    ```

## 10. SOLID
SOLID is a set of five core Object-Oriented Design principles that help you write maintainable, flexible, and scalable software, SOLID stands for:
- Single Responsibility: a class should only have one responsibility.
- Open/Closed: classes should be open for extension but closed for modification.
- Liskov Substitution: if class A is a subtype of class B, we should be able to replace B with A without disrupting the behavior of our program.
- Interface Segregation: larger interfaces should be split into smaller ones. By doing so, we can ensure that implementing classes only need to be concerned about the methods that are of interest to them.
- Dependency Inversion: The principle of dependency inversion refers to the decoupling of software modules. This way, instead of high-level modules depending on low-level modules, both will depend on abstractions.

## 11. Design Patterns
Design patterns are proven, reusable solutions to common software design problems.
They are not code you copy-paste, but rather general templates for solving recurring issues in object-oriented programming.

There are different types of design patterns:
- Creational patterns deal with object creation: how, when, and by whom objects should be instantiated, some examples are: Singleton, Factory Method, Abstract Factory and Builder.
Structural patterns deal with class composition: how objects fit together to form larger structures, some examples are: Adapter, Decorator, Facade, Composite and Proxy.
- Behavioral patterns handle communication and responsibility distribution between objects, some examples are: Observer, Command, Iterator, Template, State, Chain of Responsibility.

### Creational Patterns
Creational patterns deal with the mechanisms of object creation. At first glance, creating an object seems trivial — you just call new. But as systems grow, naive instantiation scatters construction logic across the codebase, tightly couples callers to concrete classes, makes testing harder, and offers no control over how many instances exist or how they're configured. Creational patterns solve these problems by abstracting and centralizing the instantiation process.
There are five classic creational patterns: Singleton, Factory Method, Abstract Factory, Builder, and Prototype. Each addresses a different dimension of the object creation problem.

#### Singleton
The Singleton pattern ensures that a class has exactly one instance and provides a global access point to it. The motivating use cases are things like configuration managers, connection pools, logging systems, or caches — resources that must be shared and where multiple instances would cause inconsistency or waste.

The naive implementation is well-known but dangerously broken in concurrent environments:
```Java
public class SingletonObject {
    private static SingletonObject instance;

    private SingletonObject() {}

    public static synchronized SingletonObject getInstance() {
        if(!instance) {
            instance = new SingletonObject();
        }
        return instance;
    }
}
```

The double-checked locking fix is commonly cited, but it requires volatile to prevent the JVM from reordering object construction steps:
```Java
public class SingletonObject {
    private static volatile SingletonObject instance;

    private SingletonObject() {}

    public static synchronized SingletonObject getInstance() {
        if(!instance) {
            synchronized(SingletonObject.class) {
                if (instance == null) {
                    instance = new SingletonObject();
                }
            }
        }
        return instance;
    }
}
```

However, the cleanest, most idiomatic Java approach is the initialization-on-demand holder idiom, which leverages the JVM's class loading guarantees to achieve thread safety without synchronization overhead:
```Java
public class ConfigManager {
    private ConfigManager() {}

    private static class Holder {
        static final ConfigManager INSTANCE = new ConfigManager();
    }

    public static ConfigManager getInstance() {
        return Holder.INSTANCE;
    }
}
```

The Holder class is not loaded until getInstance() is called for the first time, and the JVM guarantees that static initializers run exactly once. This is lazy, thread-safe, and carries no synchronization cost after initialization.
If you need serialization safety as well, the enum singleton is the most robust approach — Joshua Bloch advocates for this in Effective Java:
```Java
public enum ConfigManager {
    INSTANCE;

    private final Map<String, String> config = new HashMap<>();

    public String get(String key) { return config.get(key); }
    public void set(String key, String value) { config.put(key, value); }
}
```

The primary purpose of a Java Singleton class is to restrict the limit of the number of object creations to only one. This often ensures that there is access control to resources, for example, a socket or a database connection.

It is memory efficient as the object creation will take place only once instead of creating it each time a new request is made, which reduces the overhead and makes it memory efficient.

Enums are inherently serialization-safe and reflection-proof — two attack vectors that can break other singleton implementations.
The honest truth about Singleton is that it's the most controversial pattern in this group. Global state makes unit testing painful because you can't easily inject a mock or reset state between tests. It also introduces hidden dependencies — a class that calls `ConfigManager.getInstance()` doesn't advertise that dependency in its constructor, making the dependency graph opaque. In modern Java development, the pattern has been largely superseded by dependency injection containers like Spring, where you declare a bean as `@Singleton` scoped (the default) and the container manages the single instance while still allowing injection and testability.

#### Factory
A Factory Method is a creational design pattern in object-oriented programming (including Java) that provides a way to create objects without specifying the exact class of the object that will be created.

Instead of calling a constructor directly (new SomeClass()), you call a factory method that decides which concrete implementation to instantiate.
This allows a class to delegate object creation to subclasses or helper classes.

Without factory method:
```Java
// without Factory Method:
public class NotificationService {
    public void send(String message) {
        EmailNotification notification = new EmailNotification();
        notification.send(message);
    }
}

// with Factory Method:
public interface Notification {
    void send(String message);
}

public class EmailNotification implements Notification {
    public void send(String message) {
        System.out.println("Email: " + message);
    }
}

public class SmsNotification implements Notification {
    public void send(String message) {
        System.out.println("SMS: " + message);
    }
}

public abstract class NotificationFactory {
    public abstract Notification createNotification();
}

public class EmailFactory extends NotificationFactory {
    public Notification createNotification() {
        return new EmailNotification();
    }
}

public class SmsFactory extends NotificationFactory {
    public Notification createNotification() {
        return new SmsNotification();
    }
}
```
The key advantage is decoupling: callers depend on the Notification interface, not any concrete class. When you add a PushNotification channel, only the factory changes. The limitation is that the subclassing approach can lead to a parallel hierarchy — for every new product type you often need a new creator subclass, which can become unwieldy. The static factory approach avoids this but sacrifices extensibility without modification.

#### Builder
The Builder pattern is a creational design pattern used to construct complex objects step-by-step. It separates the construction process from the final representation, making it easier to build objects with many optional or configurable fields.

Use it when:
- A class has many constructor parameters (especially optional ones).
- You want the object to be immutable after creation.
- You want a readable, fluent way to create configurations.
- You want to avoid "telescoping constructors".

To use the Builder pattern create a static nested Builder class inside your main class, the builder class contains the same fields as the parent class, all the methods in the builder set fields and return the builder (fluent interface) a build() method creates the final immutable object.

The motivating problem is telescoping constructors — when a class has many optional parameters, you end up with a combinatorial explosion of constructor overloads, or one massive constructor where callers must pass null for parameters they don't care about:
```Java
// The problem — which nulls mean what?
new HttpRequest("GET", "https://api.example.com", null, null, 30, true, null);
```
The Builder solves this by making construction readable and flexible:
```Java
public class HttpRequest {
    private final String method;
    private final String url;
    private final Map<String, String> headers;
    private final String body;
    private final int timeoutSeconds;
    private final boolean followRedirects;

    private HttpRequest(Builder builder) {
        this.method = builder.method;
        this.url = builder.url;
        this.headers = Collections.unmodifiableMap(builder.headers);
        this.body = builder.body;
        this.timeoutSeconds = builder.timeoutSeconds;
        this.followRedirects = builder.followRedirects;
    }

    public static class Builder {
        // Required parameters
        private final String method;
        private final String url;

        // Optional parameters with defaults
        private Map<String, String> headers = new HashMap<>();
        private String body = null;
        private int timeoutSeconds = 30;
        private boolean followRedirects = true;

        public Builder(String method, String url) {
            this.method = method;
            this.url = url;
        }

        public Builder header(String key, String value) {
            this.headers.put(key, value);
            return this;
        }

        public Builder body(String body) {
            this.body = body;
            return this;
        }

        public Builder timeout(int seconds) {
            this.timeoutSeconds = seconds;
            return this;
        }

        public Builder followRedirects(boolean follow) {
            this.followRedirects = follow;
            return this;
        }

        public HttpRequest build() {
            // Validation belongs here, before the object is created
            if (body != null && method.equals("GET")) {
                throw new IllegalStateException("GET requests cannot have a body");
            }
            return new HttpRequest(this);
        }
    }
}

// Usage — reads almost like natural language
HttpRequest request = new HttpRequest.Builder("POST", "https://api.example.com/users")
    .header("Authorization", "Bearer token123")
    .header("Content-Type", "application/json")
    .body("{\"name\": \"Alice\"}")
    .timeout(60)
    .build();
```

Notice that `HttpRequest` is immutable — its fields are all final. The Builder is the only way to construct it, and validation happens in `build()` before the object comes into existence. This is a significant advantage over setters, which allow objects to exist in partially-constructed, invalid states.
In the Java ecosystem, Lombok's `@Builder` annotation generates this boilerplate for you, which is why you see it ubiquitously in Spring Boot codebases. Libraries like `OkHttp`'s `Request.Builder`, `Hibernate`'s `CriteriaBuilder`, and `Spring`'s `UriComponentsBuilder` all use this pattern. `Guava`'s `ImmutableList.builder()` and `ImmutableMap.builder()` are textbook examples.
The Lombok caveat: while `@Builder` is convenient, it generates builders with all fields optional, meaning there's no compile-time enforcement of required parameters. For critical domain objects, a hand-written builder that puts required parameters in the constructor (as shown above) is safer.

### Structural Patterns
Structural patterns are concerned with how classes and objects are composed to form larger structures. Unlike creational patterns (which deal with object instantiation) or behavioral patterns (which deal with communication between objects), structural patterns focus on the relationships between entities — how they fit together to build flexible, maintainable architectures. The four patterns we'll cover — Decorator, Facade, Composite, and Proxy — each solve a distinct structural problem, yet they share a common philosophy: prefer composition over inheritance.

#### Decorator
The Decorator pattern allows you to attach additional responsibilities to an object dynamically, without modifying its class or creating an explosion of subclasses. It wraps an object inside another object that shares the same interface, adding behavior before or after delegating to the wrapped instance.
```Java
// The component interface
public interface TextProcessor {
    String process(String text);
}

// Concrete component
public class PlainTextProcessor implements TextProcessor {
    @Override
    public String process(String text) {
        return text;
    }
}

// Base decorator — holds a reference to the wrapped component
public abstract class TextProcessorDecorator implements TextProcessor {
    protected final TextProcessor wrapped;

    public TextProcessorDecorator(TextProcessor wrapped) {
        this.wrapped = wrapped;
    }

    @Override
    public String process(String text) {
        return wrapped.process(text);
    }
}

// Concrete decorators
public class UpperCaseDecorator extends TextProcessorDecorator {
    public UpperCaseDecorator(TextProcessor wrapped) {
        super(wrapped);
    }

    @Override
    public String process(String text) {
        return super.process(text).toUpperCase();
    }
}

public class TrimDecorator extends TextProcessorDecorator {
    public TrimDecorator(TextProcessor wrapped) {
        super(wrapped);
    }

    @Override
    public String process(String text) {
        return super.process(text).trim();
    }
}

// Usage
TextProcessor processor = new UpperCaseDecorator(new TrimDecorator(new PlainTextProcessor()));
System.out.println(processor.process("  hello world  ")); // "HELLO WORLD"
```
What makes this powerful is that you compose behaviors at runtime. You can stack any number of decorators in any order without touching existing code — a clean embodiment of the Open/Closed Principle.

The main pitfall is over-decoration. When you stack many decorators, debugging becomes painful because a stack trace will zigzag through multiple wrapper classes. Also, since each decorator must implement the full interface, if that interface grows, maintenance overhead compounds across all decorators. This pattern works best when the component interface is stable and relatively small.

#### Facade
The Facade pattern provides a simplified, unified interface to a complex subsystem. It doesn't add new functionality — it orchestrates existing functionality in a way that reduces the cognitive load on the caller. The subsystem classes remain accessible if needed, but most clients only need to interact with the facade.
Think of a home theater system. To watch a movie you need to: power on the projector, set the input source, dim the lights, power on the amplifier, set the volume, start the Blu-ray player. A HomeTheaterFacade hides all that behind a single watchMovie() method.

```Java
// Subsystem classes
public class ProjectorSystem {
    public void on() { System.out.println("Projector ON"); }
    public void setInput(String source) { System.out.println("Input: " + source); }
}

public class SoundSystem {
    public void on() { System.out.println("Sound system ON"); }
    public void setVolume(int level) { System.out.println("Volume: " + level); }
}

public class StreamingService {
    public void connect() { System.out.println("Streaming service connected"); }
    public void play(String title) { System.out.println("Playing: " + title); }
}

// The Facade
public class HomeTheaterFacade {
    private final ProjectorSystem projector;
    private final SoundSystem sound;
    private final StreamingService streaming;

    public HomeTheaterFacade(ProjectorSystem projector, SoundSystem sound, StreamingService streaming) {
        this.projector = projector;
        this.sound = sound;
        this.streaming = streaming;
    }

    public void watchMovie(String title) {
        projector.on();
        projector.setInput("HDMI");
        sound.on();
        sound.setVolume(20);
        streaming.connect();
        streaming.play(title);
    }

    public void endMovie() {
        System.out.println("Shutting down home theater...");
    }
}
```

At the architecture level, a service layer in a layered application (Controller → Service → Repository) is a facade: the service class coordinates repositories, domain logic, and external integrations so that the controller doesn't need to know about any of it.
The limitation to watch for is that a facade can become a "God class" if it absorbs too much responsibility. When a facade starts containing significant business logic rather than just delegating and coordinating, it's been misused. It should remain a thin orchestration layer.

#### Composite
The Composite pattern lets you compose objects into tree structures to represent part-whole hierarchies, and then treat individual objects and compositions of objects uniformly. The key insight is that both a leaf node and a composite node implement the same interface, so the client code doesn't need to distinguish between them.
The most intuitive example is a file system. A File and a Directory are both "file system entries." A directory can contain files or other directories, yet you can call getSize() on either and the correct behavior cascades through the tree.
```Java
// Component interface
public interface FileSystemEntry {
    String getName();
    long getSize();
    void print(String indent);
}

// Leaf
public class File implements FileSystemEntry {
    private final String name;
    private final long size;

    public File(String name, long size) {
        this.name = name;
        this.size = size;
    }

    @Override public String getName() { return name; }
    @Override public long getSize() { return size; }

    @Override
    public void print(String indent) {
        System.out.println(indent + "📄 " + name + " (" + size + " bytes)");
    }
}

// Composite
public class Directory implements FileSystemEntry {
    private final String name;
    private final List<FileSystemEntry> children = new ArrayList<>();

    public Directory(String name) { this.name = name; }

    public void add(FileSystemEntry entry) { children.add(entry); }
    public void remove(FileSystemEntry entry) { children.remove(entry); }

    @Override public String getName() { return name; }

    @Override
    public long getSize() {
        return children.stream().mapToLong(FileSystemEntry::getSize).sum();
    }

    @Override
    public void print(String indent) {
        System.out.println(indent + "📁 " + name);
        children.forEach(child -> child.print(indent + "  "));
    }
}

// Usage
Directory root = new Directory("root");
Directory src = new Directory("src");
src.add(new File("Main.java", 2048));
src.add(new File("Utils.java", 1024));

Directory resources = new Directory("resources");
resources.add(new File("config.yml", 512));

root.add(src);
root.add(resources);
root.add(new File("README.md", 256));

root.print("");
System.out.println("Total size: " + root.getSize() + " bytes");
```

The primary tension in the Composite pattern is deciding whether to declare child-management methods (add, remove) in the component interface or only in the composite class. Declaring them in the interface gives uniformity but forces leaf nodes to either implement meaningless operations or throw UnsupportedOperationException. Declaring them only in Directory preserves type safety but forces clients to cast when they need to manipulate the tree structure. There's no universally correct answer — it depends on whether transparency or safety is more important in your context.

#### Proxy
The Proxy pattern provides a surrogate or placeholder for another object to control access to it. The proxy implements the same interface as the real subject, intercepts calls, and decides whether and how to forward them. This interception point is where you inject cross-cutting concerns: lazy initialization, access control, logging, caching, remote communication, or transaction management.

There are several distinct flavors worth knowing:

- Virtual Proxy: defers expensive object creation until actually needed (lazy loading).
- Protection Proxy: controls access based on permissions.
- Remote Proxy: represents an object in a different address space (RMI stubs are classic examples).
- Caching Proxy: stores results of expensive operations and returns cached responses.

```Java
// Subject interface
public interface ImageLoader {
    void display();
}

// Real subject — expensive to create
public class HighResolutionImage implements ImageLoader {
    private final String filePath;

    public HighResolutionImage(String filePath) {
        this.filePath = filePath;
        loadFromDisk(); // Expensive operation
    }

    private void loadFromDisk() {
        System.out.println("Loading image from disk: " + filePath);
    }

    @Override
    public void display() {
        System.out.println("Displaying: " + filePath);
    }
}

// Virtual Proxy — defers loading until display() is actually called
public class ImageProxy implements ImageLoader {
    private final String filePath;
    private HighResolutionImage realImage;

    public ImageProxy(String filePath) {
        this.filePath = filePath; // Cheap — no disk I/O yet
    }

    @Override
    public void display() {
        if (realImage == null) {
            realImage = new HighResolutionImage(filePath); // Load on first access
        }
        realImage.display();
    }
}
```
Now, in modern Java development, you rarely write static proxies by hand. Java's dynamic proxy mechanism (`java.lang.reflect.Proxy`) lets you create proxies at runtime for any interface:
```Java
public class LoggingHandler implements InvocationHandler {
    private final Object target;

    public LoggingHandler(Object target) {
        this.target = target;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("Calling: " + method.getName());
        long start = System.currentTimeMillis();
        Object result = method.invoke(target, args);
        System.out.println("Completed in " + (System.currentTimeMillis() - start) + "ms");
        return result;
    }
}

// Usage
ImageLoader realImage = new HighResolutionImage("photo.jpg");
ImageLoader proxy = (ImageLoader) Proxy.newProxyInstance(
    realImage.getClass().getClassLoader(),
    new Class[]{ImageLoader.class},
    new LoggingHandler(realImage)
);
proxy.display();
```

This is precisely how Spring AOP works under the hood. When you annotate a method with @Transactional or @Cacheable, Spring wraps your bean in a JDK dynamic proxy (or a CGLIB subclass proxy if the target doesn't implement an interface) that intercepts the method call and applies the cross-cutting concern. Hibernate uses proxies for lazy-loaded entity associations — when you access a `@ManyToOne` relationship, you're often touching a Hibernate proxy that transparently fetches the data from the database only when a getter is invoked.
The key pitfall with proxies — especially in Spring — is that self-invocation bypasses the proxy. If a `@Transactional` method calls another `@Transactional` method in the same class, the second call goes directly to this rather than through the proxy, so the transaction behavior is silently skipped. This is one of the most common and confusing Spring bugs in production codebases.

The distinction between Decorator and Proxy is worth dwelling on, as they look structurally similar. Both wrap an object implementing the same interface. The difference is intent: a Decorator adds behavior and is typically composed by the client (you choose which decorators to apply). A Proxy controls access and is often transparent to the client — they don't know or care that they're talking to a proxy rather than the real object.
Similarly, Facade and Proxy both sit in front of something else, but a Facade simplifies a complex subsystem for external clients, while a Proxy represents a single object and controls access to it specifically.

### Behavioral Patterns
Behavioral patterns are concerned with algorithms and the assignment of responsibilities between objects. While structural patterns describe how objects are assembled, behavioral patterns describe how they communicate and collaborate at runtime. The central question they answer is not "how is this object built?" but rather "who does what, and how do they talk to each other?".

#### Strategy
The Strategy pattern defines a family of algorithms, encapsulates each one behind a common interface, and makes them interchangeable. The key idea is that the algorithm can vary independently from the clients that use it. Rather than baking a decision into a class with conditionals, you extract each branch into its own object and inject the appropriate one at runtime.The smell that signals you need Strategy is a method full of if-else or switch blocks where each branch performs a conceptually similar operation — sorting, pricing, validation, compression, routing. Every time a new variant is needed, you're back modifying the same class, violating the Open/Closed Principle.Consider an e-commerce platform with multiple shipping cost calculation strategies:

```Java
// Strategy interface
public interface ShippingStrategy {
    double calculate(double weightKg, double distanceKm);
}

// Concrete strategies
public class StandardShipping implements ShippingStrategy {
    @Override
    public double calculate(double weightKg, double distanceKm) {
        return weightKg * 1.5 + distanceKm * 0.05;
    }
}

public class ExpressShipping implements ShippingStrategy {
    private static final double SURCHARGE = 15.0;

    @Override
    public double calculate(double weightKg, double distanceKm) {
        return (weightKg * 2.5 + distanceKm * 0.1) + SURCHARGE;
    }
}

public class FreeShipping implements ShippingStrategy {
    @Override
    public double calculate(double weightKg, double distanceKm) {
        return 0.0;
    }
}

// Context — uses a strategy without knowing its internals
public class ShoppingCart {
    private ShippingStrategy shippingStrategy;
    private final List<OrderItem> items = new ArrayList<>();

    public ShoppingCart(ShippingStrategy shippingStrategy) {
        this.shippingStrategy = shippingStrategy;
    }

    // Strategy can be swapped at runtime
    public void setShippingStrategy(ShippingStrategy strategy) {
        this.shippingStrategy = strategy;
    }

    public double calculateShipping(double distanceKm) {
        double totalWeight = items.stream()
            .mapToDouble(OrderItem::getWeightKg)
            .sum();
        return shippingStrategy.calculate(totalWeight, distanceKm);
    }
}
```
What makes this especially clean in modern Java is that a single-method interface is a functional interface, meaning strategies can be expressed as lambdas. The strategy pattern and Java's functional programming model are natural allies:
```Java
ShippingStrategy weekendPromo = (weight, distance) -> weight * 1.0; // flat rate weekend promo
ShoppingCart cart = new ShoppingCart(weekendPromo);

// Or using method references
ShoppingCart premiumCart = new ShoppingCart(new ExpressShipping());

// Swap strategy at runtime based on user's membership tier
if (user.isPremiumMember()) {
    cart.setShippingStrategy(new FreeShipping());
}
```
In real-world Java, java.util.Comparator is the most ubiquitous strategy in the entire JDK. When you pass a Comparator to Collections.sort() or List.sort(), you're injecting a sorting strategy. Spring Security's AuthenticationProvider is a strategy — you can plug in LDAP, OAuth, database, or custom authentication. Jackson's SerializationFeature configuration, Hibernate's NamingStrategy, and Spring's ResourceLoader all follow this pattern.
The limitation to be aware of is that Strategy introduces a proliferation of small classes (or lambdas) that can make the codebase harder to navigate if overused. It also requires the context to be aware of the available strategies — some external mechanism must decide which strategy to inject, which is where a Factory or DI container comes in. If the algorithm selection logic itself becomes complex, you've just moved the problem rather than solved it.

#### Observer
The Observer pattern defines a one-to-many dependency between objects so that when one object — the subject or publisher — changes state, all its dependents — observers or subscribers — are notified and updated automatically. It's the foundational pattern behind event-driven programming, reactive systems, and the publish-subscribe model.
The motivating problem is decoupling: the subject should not need to know who is listening or what they do with the notification. New observers can be added without modifying the subject at all.
```Java
interface Subject {
    void register(Observer o);
    void unregister(Observer o);
    void notify();
}

interface Observer {
    void update(int temperature);
}

class WeatherStation implements Subject {
    private List<Observer> observers = new ArrayList<>();
    private int temperature;

    @Override
    public void registerObserver(Observer o) {
        observers.add(o);
    }

    @Override
    public void removeObserver(Observer o) {
        observers.remove(o);
    }

    @Override
    public void notifyObservers() {
        for (Observer o : observers) {
            o.update(temperature);
        }
    }

    public void setTemperature(int temp) {
        this.temperature = temp;
        notifyObservers();
    }
}

class PhoneDisplay implements Observer {
    @Override
    public void update(int temperature) {
        System.out.println("Phone display updated: " + temperature + "°C");
    }
}

class TVDisplay implements Observer {
    @Override
    public void update(int temperature) {
        System.out.println("TV display updated: " + temperature + "°C");
    }
}
```
Java has had built-in observer support since its early days via java.util.Observable and java.util.Observer, but these were deprecated in Java 9 because Observable is a class (forcing inheritance), and its implementation is neither thread-safe nor flexible. The ecosystem has moved on to better alternatives.
Spring's ApplicationEvent system is the most practically important observer implementation in enterprise Java. It decouples components across the entire application context:
```Java
// Custom event
public class OrderPlacedEvent extends ApplicationEvent {
    private final Order order;

    public OrderPlacedEvent(Object source, Order order) {
        super(source);
        this.order = order;
    }

    public Order getOrder() { return order; }
}

// Publisher
@Service
public class OrderService {
    private final ApplicationEventPublisher eventPublisher;

    public OrderService(ApplicationEventPublisher eventPublisher) {
        this.eventPublisher = eventPublisher;
    }

    public Order placeOrder(OrderRequest request) {
        Order order = processOrder(request);
        eventPublisher.publishEvent(new OrderPlacedEvent(this, order));
        return order;
    }
}

// Observers — completely decoupled from OrderService
@Component
public class EmailListener {
    @EventListener
    public void handleOrderPlaced(OrderPlacedEvent event) {
        // Send email
    }
}

@Component
public class InventoryListener {
    @EventListener
    @Async  // Can even be asynchronous
    public void handleOrderPlaced(OrderPlacedEvent event) {
        // Update inventory in a separate thread
    }
}
```
For reactive systems, Project Reactor (the foundation of Spring WebFlux) takes this pattern to its logical extreme. `Flux` and `Mono` are essentially observable streams — publishers that emit items to subscribers, with backpressure support for cases where publishers emit faster than subscribers can consume.
The critical pitfalls with Observer deserve careful attention. First, memory leaks are a pervasive problem — if observers are registered but never removed, the subject holds strong references that prevent garbage collection. In long-lived subjects, this is a serious leak. The solution is either weak references (used in some frameworks) or diligent lifecycle management (calling `removeListener` when a component is destroyed). Second, notification order is typically undefined and should not be relied upon. Third, in synchronous implementations, a slow or throwing observer blocks or breaks the entire notification chain — robust implementations catch exceptions per-observer and continue notifying the rest. Finally, in multithreaded environments, the list of listeners itself must be protected — `CopyOnWriteArrayList` is a common choice because it's safe for concurrent reads while writes create a new copy.

#### Command
The Command pattern encapsulates a request as an object, thereby allowing you to parameterize clients with different requests, queue or log requests, and support undoable operations. The operation's invoker doesn't know what the operation does — it just knows it can call execute() on it.
This encapsulation gives you three powerful capabilities that you can't easily get with direct method calls: deferred execution (store the command and run it later), undo/redo (store a history of commands and reverse them), and queuing (put commands in a work queue for a thread pool to process).
```Java
// Command interface
public interface Command {
    void execute();
    void undo();
}

// Receiver — the object that actually knows how to perform the work
public class TextEditor {
    private final StringBuilder content = new StringBuilder();

    public void insertText(int position, String text) {
        content.insert(position, text);
        System.out.println("Content: " + content);
    }

    public void deleteText(int position, int length) {
        content.delete(position, position + length);
        System.out.println("Content: " + content);
    }

    public String getContent() { return content.toString(); }
}

// Concrete command
public class InsertTextCommand implements Command {
    private final TextEditor editor;
    private final int position;
    private final String text;

    public InsertTextCommand(TextEditor editor, int position, String text) {
        this.editor = editor;
        this.position = position;
        this.text = text;
    }

    @Override
    public void execute() {
        editor.insertText(position, text);
    }

    @Override
    public void undo() {
        // Reverse: delete the text that was inserted
        editor.deleteText(position, text.length());
    }
}

// Invoker — manages command execution and history
public class CommandHistory {
    private final Deque<Command> history = new ArrayDeque<>();

    public void execute(Command command) {
        command.execute();
        history.push(command);
    }

    public void undo() {
        if (!history.isEmpty()) {
            history.pop().undo();
        }
    }
}

// Usage
TextEditor editor = new TextEditor();
CommandHistory history = new CommandHistory();

history.execute(new InsertTextCommand(editor, 0, "Hello"));
history.execute(new InsertTextCommand(editor, 5, " World"));
// Content: Hello World

history.undo();
// Content: Hello

history.undo();
// Content: (empty)
```
In Java's functional style, simple commands without undo requirements can be expressed as Runnable or Supplier — both are functional command interfaces. This is exactly how ExecutorService works: you submit Runnable or Callable commands to an executor that queues and runs them on managed threads. The submitter doesn't know which thread will run the task or when — it just encapsulates the work and hands it off.
```Java
// Commands as lambdas submitted to an executor — Command pattern in disguise
ExecutorService executor = Executors.newFixedThreadPool(4);

executor.submit(() -> processPayment(order));
executor.submit(() -> sendConfirmationEmail(order));
executor.submit(() -> updateInventory(order));
```
Spring's `@Transactional` with savepoints, database migration tools like Flyway (each migration script is a command that can be tracked and potentially rolled back), and job scheduling systems like Quartz (where a `Job` interface is essentially a Command) all embody this pattern.
A particularly practical real-world application is transactional outbox pattern implementations, where instead of performing side effects directly, you store command objects in a database table (the outbox) as part of the same transaction as your domain change. A separate process reads and executes these commands, guaranteeing at-least-once delivery even if the application crashes between the database write and the side effect.
One nuance that trips people up is the boundary between the Command and the Receiver. Commands should be thin — they hold the data needed to perform an action and delegate the actual work to the receiver. When commands start containing significant business logic themselves, you've blurred this boundary and made testing harder. The command's job is to know what to do and with what data; the receiver knows how to do it.
Undo implementation deserves special attention in practice. Straightforward state restoration (store the previous value, restore it on undo) works for simple cases. For complex objects, you often combine Command with Memento — the command captures a snapshot of the relevant state before executing, and restores it on undo. For collaborative or distributed systems, event sourcing takes this idea to its conclusion: the entire application state is derived from an append-only log of commands (events), and you can replay or roll back to any point in history.

#### State
The State pattern allows an object to alter its behavior when its internal state changes. The object will appear to change its class. Rather than encoding state-dependent behavior as sprawling conditionals throughout a class, you extract each state into its own object that handles behavior for that state.
The problem it solves becomes obvious when you see code like this scattered throughout a class:
```Java
// WITHOUT State pattern — conditional chaos
public void handlePayment() {
    if (status.equals("PENDING")) { ... }
    else if (status.equals("PROCESSING")) { ... }
    else if (status.equals("PAID")) { throw new IllegalStateException(); }
    else if (status.equals("CANCELLED")) { ... }
}

public void cancel() {
    if (status.equals("PENDING")) { ... }
    else if (status.equals("PROCESSING")) { ... }
    else if (status.equals("PAID")) { ... }
    // And so on for every method
}
```
Every new state or new operation means touching every conditional block. With the State pattern, adding a new state means adding one new class, and adding a new operation means adding one new method to the state interface.
Let's model an order's lifecycle:
```Java
// State interface
public interface OrderState {
    void confirm(OrderContext order);
    void ship(OrderContext order);
    void deliver(OrderContext order);
    void cancel(OrderContext order);
}

// Context — delegates all behavior to its current state
public class OrderContext {
    private OrderState currentState;
    private final String orderId;

    public OrderContext(String orderId) {
        this.orderId = orderId;
        this.currentState = new PendingState(); // Initial state
    }

    public void setState(OrderState state) {
        System.out.println("Transitioning to: " + state.getClass().getSimpleName());
        this.currentState = state;
    }

    // All operations delegate to the current state
    public void confirm() { currentState.confirm(this); }
    public void ship()    { currentState.ship(this); }
    public void deliver() { currentState.deliver(this); }
    public void cancel()  { currentState.cancel(this); }

    public String getOrderId() { return orderId; }
}

// Concrete states
public class PendingState implements OrderState {
    @Override
    public void confirm(OrderContext order) {
        System.out.println("Order confirmed. Awaiting shipment.");
        order.setState(new ConfirmedState());
    }

    @Override
    public void ship(OrderContext order) {
        throw new IllegalStateException("Cannot ship a pending order.");
    }

    @Override
    public void deliver(OrderContext order) {
        throw new IllegalStateException("Cannot deliver a pending order.");
    }

    @Override
    public void cancel(OrderContext order) {
        System.out.println("Order cancelled from pending state.");
        order.setState(new CancelledState());
    }
}

public class ConfirmedState implements OrderState {
    @Override
    public void confirm(OrderContext order) {
        throw new IllegalStateException("Order already confirmed.");
    }

    @Override
    public void ship(OrderContext order) {
        System.out.println("Order shipped.");
        order.setState(new ShippedState());
    }

    @Override
    public void deliver(OrderContext order) {
        throw new IllegalStateException("Order has not been shipped yet.");
    }

    @Override
    public void cancel(OrderContext order) {
        System.out.println("Order cancelled after confirmation. Refund initiated.");
        order.setState(new CancelledState());
    }
}

public class ShippedState implements OrderState {
    @Override
    public void confirm(OrderContext order) {
        throw new IllegalStateException("Order already confirmed.");
    }

    @Override
    public void ship(OrderContext order) {
        throw new IllegalStateException("Order already shipped.");
    }

    @Override
    public void deliver(OrderContext order) {
        System.out.println("Order delivered successfully.");
        order.setState(new DeliveredState());
    }

    @Override
    public void cancel(OrderContext order) {
        throw new IllegalStateException("Cannot cancel an order in transit.");
    }
}

public class DeliveredState implements OrderState {
    @Override public void confirm(OrderContext order) { throw new IllegalStateException("Order complete."); }
    @Override public void ship(OrderContext order)    { throw new IllegalStateException("Order complete."); }
    @Override public void deliver(OrderContext order) { throw new IllegalStateException("Already delivered."); }
    @Override public void cancel(OrderContext order)  { throw new IllegalStateException("Cannot cancel a delivered order."); }
}

// Usage
OrderContext order = new OrderContext("ORD-001");
order.confirm();  // PendingState → ConfirmedState
order.ship();     // ConfirmedState → ShippedState
order.deliver();  // ShippedState → DeliveredState
order.cancel();   // throws IllegalStateException
```
The relationship between State and Strategy is worth pausing on because their structure is nearly identical — both involve an object delegating behavior to an interchangeable implementation of an interface. The difference is intent and lifecycle. In Strategy, the context is typically unaware of which concrete strategy it holds, and strategies don't usually trigger transitions to other strategies — the client chooses and injects them. In State, the states are deeply aware of each other and drive their own transitions — a `ShippedState` knows to move to `DeliveredState`. The context's behavior changes as a natural consequence of domain events, not external injection.
In real-world Java, Spring's `AbstractStateMachine` from Spring State Machine is a full framework implementation of this pattern, used in workflow engines and order management systems. Java's `Thread` is a canonical example from the JDK itself — a thread's behavior for `start()`, `interrupt()`, and `join()` varies completely depending on whether it's `NEW`, `RUNNABLE`, `BLOCKED`, `WAITING`, or `TERMINATED`. TCP connection management (`CLOSED` → `SYN_SENT` → `ESTABLISHED` → `FIN_WAIT` → `...`) is the networking textbook example.
One practical consideration is where state transitions live. In the example above, states transition themselves by calling `order.setState(new ConfirmedState())`. This is flexible but means each state must know about other state classes, creating coupling within the state family. An alternative is to have the context manage all transitions, with states returning a signal of what should happen next. For complex workflows, a dedicated transition table or DSL (as Spring State Machine provides) is cleaner than hardcoding transitions inside state classes.
Another pitfall is state explosion. If a domain object has many independent state dimensions — say, an order has a payment status AND a fulfillment status AND a return status — modeling all combinations as individual state objects produces a combinatorial nightmare. In that case, you may be better served by separate, simpler state machines for each dimension, or by revisiting your domain model.

## 12. Serialization
Serialization in Java is the process of converting an object's state into a byte stream so it can be persisted to disk, transmitted over a network, or stored in a database — and then reconstructed later through deserialization.

### Serializable
At its heart, Java's built-in serialization is enabled by implementing the `java.io.Serializable` interface. This is a marker interface — it has no methods, it simply signals to the JVM that objects of this class are eligible for serialization.

```Java
import java.io.*;

public class Employee implements Serializable {

    private static final long serialVersionUID = 1L;

    private String name;
    private String department;
    private double salary;

    public Employee(String name, String department, double salary) {
        this.name = name;
        this.department = department;
        this.salary = salary;
    }

    @Override
    public String toString() {
        return "Employee{name='" + name + "', department='" + department + "', salary=" + salary + "}";
    }
}
```
Serializing and deserializing this object uses ObjectOutputStream and ObjectInputStream:
```Java
public class SerializationDemo {

    public static void serialize(Employee emp, String filePath) throws IOException {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filePath))) {
            oos.writeObject(emp);
            System.out.println("Serialized: " + emp);
        }
    }

    public static Employee deserialize(String filePath) throws IOException, ClassNotFoundException {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filePath))) {
            return (Employee) ois.readObject();
        }
    }

    public static void main(String[] args) throws Exception {
        Employee emp = new Employee("Alice", "Engineering", 95000.0);
        serialize(emp, "employee.ser");

        Employee restored = deserialize("employee.ser");
        System.out.println("Deserialized: " + restored);
    }
}
```
The JVM handles everything automatically here — field types, object graph references, class metadata.

### serialVersionUUID
The serialVersionUID is a version identifier for a serializable class. When you deserialize an object, the JVM compares the serialVersionUID embedded in the byte stream against the one in the currently loaded class. If they don't match, an InvalidClassException is thrown.
If you don't declare it yourself, the JVM computes one automatically based on the class structure — fields, methods, interfaces. This means that even an innocuous change like adding a helper method can change the computed UID and break deserialization of previously stored data.
```Java
// Version 1 — stored to disk
public class Config implements Serializable {
    private static final long serialVersionUID = 1L;
    private String host;
    private int port;
}

// Version 2 — adding a new field
public class Config implements Serializable {
    private static final long serialVersionUID = 1L; // same UID = backward compatible
    private String host;
    private int port;
    private int timeout = 30; // new field gets default value on deserialization
}
```
With a consistent serialVersionUID, adding new fields is backward compatible — the new field simply takes its default value when deserializing old data. Removing fields or changing types is a different story and will silently corrupt or break data.
The rule of thumb in production systems: always declare serialVersionUID explicitly and increment it deliberately when you make breaking changes.

### transient
Not every field should be serialized. Passwords, open connections, thread references, cached computed values — these should be excluded. The transient keyword tells the serialization engine to skip a field entirely.
```Java
public class DatabaseConnection implements Serializable {

    private static final long serialVersionUID = 1L;

    private String host;
    private int port;
    private String username;

    private transient String password;         // sensitive — never serialize
    private transient Connection connection;   // runtime resource — can't serialize
    private transient int cachedHashCode;      // derived value — recalculate on restore

    public DatabaseConnection(String host, int port, String username, String password) {
        this.host = host;
        this.port = port;
        this.username = username;
        this.password = password;
    }
}
```
After deserialization, password and connection will be null, and cachedHashCode will be 0. You need to account for this in your code — often by reconnecting lazily or re-prompting for credentials.

### Custom Serialization
Java lets you override the default serialization behavior by declaring private writeObject and readObject methods. These are not interface methods — the serialization engine discovers them via reflection. This is a critical hook for handling encryption, validation, or structural transformation.
```Java
public class SecureEmployee implements Serializable {

    private static final long serialVersionUID = 1L;

    private String name;
    private transient String sensitiveData; // excluded from default serialization

    public SecureEmployee(String name, String sensitiveData) {
        this.name = name;
        this.sensitiveData = sensitiveData;
    }

    private void writeObject(ObjectOutputStream oos) throws IOException {
        oos.defaultWriteObject(); // serialize non-transient fields normally
        // encrypt before writing
        String encrypted = encrypt(sensitiveData);
        oos.writeObject(encrypted);
    }

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException {
        ois.defaultReadObject(); // deserialize non-transient fields normally
        // decrypt after reading
        String encrypted = (String) ois.readObject();
        this.sensitiveData = decrypt(encrypted);
    }

    private String encrypt(String value) {
        // simplified — use proper AES in production
        return "ENC:" + new StringBuilder(value).reverse();
    }

    private String decrypt(String value) {
        String stripped = value.replace("ENC:", "");
        return new StringBuilder(stripped).reverse().toString();
    }
}
```
This pattern is heavily used in the JDK itself. HashMap, for instance, doesn't serialize its internal bucket array directly — it uses writeObject/readObject to serialize only the key-value pairs, reconstructing the table on deserialization to account for different load factors and capacities.

### Externalizable
Externalizable goes further than custom writeObject/readObject — it gives you complete, explicit control over the serialization format with no default behavior at all. You must implement writeExternal and readExternal, and critically, the class must have a public no-arg constructor because the JVM constructs the object first before calling readExternal.
```Java
public class Point implements Externalizable {

    private double x;
    private double y;
    private double z;

    // Required for Externalizable
    public Point() {}

    public Point(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    @Override
    public void writeExternal(ObjectOutput out) throws IOException {
        out.writeDouble(x);
        out.writeDouble(y);
        out.writeDouble(z);
    }

    @Override
    public void readExternal(ObjectInput in) throws IOException {
        this.x = in.readDouble();
        this.y = in.readDouble();
        this.z = in.readDouble();
    }
}
```
Externalizable is faster and produces smaller output than default serialization because there's no class metadata, field names, or type descriptors written — just the raw data you choose to write. The trade-off is that you own the entire contract: if you add a field and forget to update writeExternal and readExternal, it simply won't be persisted.

### Object Graphs
Java's serialization engine is smart about object graphs. If two objects reference the same third object, only one copy is serialized and both references point to the same restored object. It also handles circular references without infinite loops.
```Java
public class Department implements Serializable {
    private static final long serialVersionUID = 1L;
    private String name;
    private List<StaffMember> members = new ArrayList<>();

    public void add(StaffMember m) { members.add(m); }
}

public class StaffMember implements Serializable {
    private static final long serialVersionUID = 1L;
    private String name;
    private Department department; // circular reference back to department

    public StaffMember(String name, Department department) {
        this.name = name;
        this.department = department;
    }
}
```
The JVM maintains an internal handle table during serialization — each object gets a handle, and subsequent references to the same object write just the handle rather than the full object again. This prevents duplication and infinite loops, but it also means the byte stream holds a reference graph, not a tree. Deep or wide object graphs can exhaust heap memory on both ends.

### Security
Java serialization is notorious for security vulnerabilities. Deserialization of untrusted data is one of the most dangerous operations in Java — it allows arbitrary code execution through gadget chains. Libraries like Apache Commons Collections, Spring, and others have historically contained classes that, when deserialized in the right sequence, execute attacker-controlled code.
The attack mechanism is subtle: `readObject` calls happen during deserialization automatically, including on objects deep in the graph. If a malicious byte stream tricks the JVM into deserializing a class with a dangerous `readObject` implementation, the damage is done before you even see the returned object.
The most practical defense is using a serialization filter, introduced in Java 9 and backported:
```Java
ObjectInputStream ois = new ObjectInputStream(inputStream);

// Whitelist approach — only allow specific classes
ois.setObjectInputFilter(filterInfo -> {
    Class<?> cls = filterInfo.serialClass();
    if (cls == null) return ObjectInputFilter.Status.UNDECIDED;

    if (cls == Employee.class || cls == String.class || cls == ArrayList.class) {
        return ObjectInputFilter.Status.ALLOWED;
    }
    return ObjectInputFilter.Status.REJECTED;
});
```
You can also configure a global JVM-wide filter via the system property `jdk.serialFilter`. The broader advice from the Java security community is increasingly: don't use Java's built-in serialization for untrusted input, ever. Use JSON (Jackson, Gson), Protocol Buffers, or Avro instead.

### Common Pitfalls

#### Serialzing Non-Serializable fields
The most frequent mistake developers make is serializing classes that contain non-serializable fields without marking them transient. This causes a NotSerializableException at runtime, not compile time — the compiler won't warn you.

#### Schema Evolution Problem
Another common trap is mutating a serialized class in a way that silently corrupts restored objects. Changing a field's type, narrowing its range, or removing a field that old data contains will either throw an exception or silently zero out values, depending on whether serialVersionUID is consistent.

##### Solution 1: implement readObject
The most surgical fix for handling old serialized data that doesn't match your current class shape is implementing a custom readObject. You can detect when a field was absent in the old data and supply a safe default, or read the old field under its old name and migrate the value manually.
```Java
public class UserProfile implements Serializable {

    private static final long serialVersionUID = 1L;

    private String username;
    private String email;

    // Version 2: we want to split 'fullName' (old) into 'firstName' + 'lastName' (new)
    // The old field must be kept temporarily to allow migration
    @Deprecated
    private transient String fullName; // we'll read it manually, not via default

    private String firstName;
    private String lastName;
    private int loginCount;         // newly added field — will be 0 for old data
    private String preferredLocale; // newly added field — will be null for old data

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException {
        // Read the stream as-is — new fields absent in old data get their defaults
        ois.defaultReadObject();

        // Migration: if the old 'fullName' was present and new fields weren't populated
        if (firstName == null && lastName == null && fullName != null) {
            String[] parts = fullName.trim().split("\\s+", 2);
            this.firstName = parts[0];
            this.lastName = parts.length > 1 ? parts[1] : "";
        }

        // Supply safe defaults for genuinely new fields
        if (preferredLocale == null) {
            this.preferredLocale = "en-US";
        }

        if (loginCount < 0) {
            this.loginCount = 0; // guard against corrupted legacy data
        }
    }

    private void readObjectNoData() throws ObjectStreamException {
        // Called when the class is present but the stream contains no data for it
        // (e.g., the object was serialized by an older JVM before this class existed in hierarchy)
        this.preferredLocale = "en-US";
        this.loginCount = 0;
    }
}
```

##### Solution 2: declare serialPersistentFields 
If you want to explicitly declare which fields participate in serialization — essentially freezing the serialization contract independent of what fields the class actually has — you can use the serialPersistentFields mechanism. This is a static final field of type ObjectStreamField[].
```Java
public class OrderRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    // Explicitly declare the serialization contract — only these fields are serialized
    // regardless of what other fields exist on the class
    private static final ObjectStreamField[] serialPersistentFields = {
        new ObjectStreamField("orderId", String.class),
        new ObjectStreamField("totalAmount", double.class),
        new ObjectStreamField("status", String.class)
        // 'internalAuditCode' is intentionally excluded even though it's a real field
    };

    private String orderId;
    private double totalAmount;
    private String status;
    private String internalAuditCode; // runtime-only, never serialized
    private transient Connection dbConnection; // also excluded

    // Now, even if you rename or add fields in the class body, the serialized
    // format is determined by serialPersistentFields — stable and explicit
}
```

##### Solution 3: use a version field
A more deliberate approach — especially useful when you anticipate multiple rounds of evolution — is to embed an explicit version number in the serialized data itself and branch in readObject accordingly.

```Java
public class AppSettings implements Serializable {

    private static final long serialVersionUID = 1L;

    // Always increment this when the schema changes
    private int dataVersion = 3;

    // Current fields (version 3 shape)
    private String theme;
    private boolean notificationsEnabled;
    private int sessionTimeoutMinutes;
    private List<String> pinnedMenuItems; // added in version 2
    private Map<String, String> customShortcuts; // added in version 3

    private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException {
        ois.defaultReadObject();

        // Migrate forward based on what version the data was written with
        if (dataVersion < 2) {
            // pinnedMenuItems didn't exist — supply a default
            this.pinnedMenuItems = new ArrayList<>();
        }

        if (dataVersion < 3) {
            // customShortcuts didn't exist — supply a default
            this.customShortcuts = new HashMap<>();
        }

        // After migration, stamp the current version
        this.dataVersion = 3;
    }
}
```

##### Solution 4: Serialization Proxy Pattern
This is the most robust and elegant solution, advocated strongly by Joshua Bloch in Effective Java. Instead of serializing the real object, you serialize a simple, stable proxy — a private nested class that captures only the logical state. The real object is reconstituted from the proxy during deserialization.

```Java
public final class DateRange implements Serializable {

    private final LocalDate start;
    private final LocalDate end;

    public DateRange(LocalDate start, LocalDate end) {
        if (start.isAfter(end)) throw new IllegalArgumentException("start must be before end");
        this.start = start;
        this.end = end;
    }

    // Intercept serialization — write the proxy instead of this object
    private Object writeReplace() {
        return new SerializationProxy(this);
    }

    // Prevent direct deserialization of DateRange — must go through proxy
    private void readObject(ObjectInputStream ois) throws InvalidObjectException {
        throw new InvalidObjectException("Use serialization proxy");
    }

    // The proxy: a simple, stable, serialization-friendly representation
    private static class SerializationProxy implements Serializable {

        private static final long serialVersionUID = 1L;

        private final String start; // stored as ISO string — immune to LocalDate internals
        private final String end;

        SerializationProxy(DateRange range) {
            this.start = range.start.toString();
            this.end = range.end.toString();
        }

        // Reconstruct the real object from the proxy — goes through the constructor,
        // so invariants (start before end) are always enforced
        private Object readResolve() {
            return new DateRange(LocalDate.parse(start), LocalDate.parse(end));
        }
    }

    public LocalDate getStart() { return start; }
    public LocalDate getEnd() { return end; }
}
```
The proxy pattern has several compounding benefits. First, because deserialization goes through the real constructor, your invariants and validation logic are always enforced — a malicious or corrupt byte stream cannot create an object in an illegal state. Second, the proxy is a thin, intentionally simple class that you consciously design for longevity — it's your real schema. Third, it handles inheritance hierarchies cleanly in ways that custom `readObject`/`writeObject` cannot.
The `writeReplace` and `readResolve` hooks are what make it tick. `writeReplace` says "when you go to serialize me, serialize this other object instead." `readResolve` says "when you've finished deserializing me, return this other object to the caller instead." Together they let you fully substitute the serialized representation without touching the real class's structure.

#### Large Object Graphs

Watch out for large object graphs where every referenced object gets pulled in. Serializing a single entity might inadvertently pull in the entire object graph of your domain model — connection pools, caches, thread references — causing massive byte streams or NotSerializableException on objects you never intended to serialize.

TOEXPAND: how to deal with large object graphs in serialization.

## 13. IO and NIO
Java has two generations of I/O APIs that coexist in the platform: the original `java.io` package introduced in Java 1.0, and the New I/O (`java.nio`) package introduced in Java 1.4, later significantly extended in Java 7 with NIO.2. Understanding both — and knowing when to reach for each — is essential for writing correct, performant Java applications.

### IO
Everything in java.io is built around the concept of a stream — a sequential flow of data. The two abstract root classes are InputStream and OutputStream, which operate on raw bytes. Every concrete byte-based I/O class in the package extends one of these two.InputStream defines three core methods: read() which returns a single byte as an int (or -1 at end of stream), read(byte[]) which fills a buffer, and read(byte[], offset, length) which fills a portion of a buffer. OutputStream mirrors this with write(int), write(byte[]), and write(byte[], offset, length), plus flush() to force any buffered data out and close() to release resources.

```Java
// Reading a file byte by byte — illustrative but inefficient in practice
try (InputStream in = new FileInputStream("data.bin")) {
    int byteValue;
    while ((byteValue = in.read()) != -1) {
        // byteValue is 0-255, not a signed byte
        process(byteValue);
    }
}

// Reading in chunks — far more practical
try (InputStream in = new FileInputStream("data.bin")) {
    byte[] buffer = new byte[8192]; // 8KB chunks
    int bytesRead;
    while ((bytesRead = in.read(buffer)) != -1) {
        process(buffer, 0, bytesRead); // only process what was actually read
    }
}
```

A critical subtlety: read(byte[]) is not guaranteed to fill the entire buffer. It returns however many bytes were available — which could be 1, even if you passed a 8192-byte array. This is especially true with network streams where data arrives in packets. Always use bytesRead as the actual count.The distinction between byte streams and character streams is fundamental. Byte streams (InputStream/OutputStream) handle raw binary data — images, audio, compiled classes, serialized objects. Character streams (Reader/Writer) handle text and are encoding-aware. They sit on top of byte streams and handle the translation between bytes and Unicode characters. Using a byte stream to read a text file works in ASCII, but falls apart the moment you encounter multibyte UTF-8 sequences or any non-Latin character set. This is a source of subtle, hard-to-diagnose bugs in production systems.

#### Reader and Writer
Reader and Writer are the character-stream counterparts to InputStream and OutputStream. The bridge between the two worlds is InputStreamReader and OutputStreamWriter — they wrap byte streams and apply a character encoding.

```Java
// Explicitly specifying encoding — always do this, never rely on platform default
try (Reader reader = new InputStreamReader(new FileInputStream("text.txt"), StandardCharsets.UTF_8)) {
    char[] buffer = new char[1024];
    int charsRead;
    while ((charsRead = reader.read(buffer)) != -1) {
        System.out.print(new String(buffer, 0, charsRead));
    }
}
```

FileReader and FileWriter are convenience subclasses of InputStreamReader and OutputStreamWriter that open files directly. Their historical flaw was using the platform default encoding, which made code non-portable. Since Java 11, they have constructors that accept a Charset, so always use those.

```Java
// Pre-Java 11 anti-pattern — platform default encoding, not portable
Reader r = new FileReader("file.txt");

// Correct — always explicit
Reader r = new FileReader("file.txt", StandardCharsets.UTF_8);
```

BufferedReader and BufferedWriter are the workhorses of text I/O. BufferedReader adds an internal character buffer and, crucially, the readLine() method which returns lines without the line terminator, or null at end of stream. BufferedWriter adds newLine() which writes the platform-appropriate line separator.

```Java
// Reading a file line by line — the classic pattern
try (BufferedReader br = new BufferedReader(new FileReader("config.txt", StandardCharsets.UTF_8))) {
    String line;
    while ((line = br.readLine()) != null) {
        if (!line.startsWith("#") && !line.isBlank()) {
            processConfigLine(line);
        }
    }
}

// Writing text with buffering
try (BufferedWriter bw = new BufferedWriter(new FileWriter("output.txt", StandardCharsets.UTF_8))) {
    bw.write("Line one");
    bw.newLine();
    bw.write("Line two");
    bw.newLine();
    bw.flush(); // flush before close for safety, though close() flushes too
}
```

The decorator pattern that java.io is built on becomes clear when you chain these classes. Each wrapper adds a capability — buffering, encoding, line-handling — while delegating the actual I/O to the inner stream. Understanding this chain matters when something goes wrong: a flush() call on a BufferedWriter flushes to the OutputStreamWriter beneath it and then to the FileOutputStream beneath that.

#### File
java.io.File is the original API for representing file system paths and performing file operations. It's been largely superseded by java.nio.file.Path (covered later), but you'll encounter it constantly in existing codebases and some APIs that haven't been updated.

```Java
File file = new File("/var/data/report.txt");

// Querying state
System.out.println(file.exists());       // does it exist at all
System.out.println(file.isFile());       // is it a regular file
System.out.println(file.isDirectory());  // is it a directory
System.out.println(file.canRead());      // readable by this process
System.out.println(file.canWrite());     // writable by this process
System.out.println(file.length());       // size in bytes
System.out.println(file.lastModified()); // milliseconds since epoch

// Creating files and directories
File newFile = new File("/tmp/test.txt");
newFile.createNewFile(); // atomic creation — returns false if already exists

File singleDir = new File("/tmp/mydir");
singleDir.mkdir(); // creates one level only

File deepDir = new File("/tmp/a/b/c/d");
deepDir.mkdirs(); // creates entire path — the plural 's' matters

// Listing directory contents
File dir = new File("/var/data");
String[] names = dir.list();           // just names
File[] files = dir.listFiles();        // File objects
File[] txtFiles = dir.listFiles(
    (d, name) -> name.endsWith(".txt") // FilenameFilter
);

// Deletion — non-recursive, directory must be empty
file.delete();

// Rename and move — same filesystem only, returns boolean not exception on failure
File dest = new File("/var/data/report_archived.txt");
file.renameTo(dest); // check return value — silent failure is a common bug
```
The File class has notable limitations: delete() returns a boolean rather than throwing on failure, methods are not atomic, there's no symbolic link support, and list() returns null (not an empty array) if the path doesn't exist or isn't a directory — a classic NPE trap. The NIO Path API fixes all of these.

#### PrintWriter and Scanner
PrintWriter wraps a Writer (or an OutputStream) and provides print(), println(), and printf() / format() — the formatted text output API. It's what you use when you want System.out-style convenience writing to a file or network socket.

```Java
try (PrintWriter pw = new PrintWriter(
        new BufferedWriter(new FileWriter("report.txt", StandardCharsets.UTF_8)))) {

    pw.println("=== Sales Report ===");
    pw.printf("%-20s %10s %10s%n", "Product", "Units", "Revenue");
    pw.printf("%-20s %10d %10.2f%n", "Widget A", 1500, 45750.00);
    pw.printf("%-20s %10d %10.2f%n", "Widget B", 870, 32190.00);

    if (pw.checkError()) {
        // PrintWriter swallows exceptions and sets an error flag instead
        // You MUST check this — it's one of PrintWriter's most dangerous behaviors
        throw new IOException("PrintWriter encountered an error");
    }
}
```

PrintWriter never throws IOException from its write methods — it silently sets an internal error flag. Always call checkError() when writing to anything other than a console, because silent write failures to a file are catastrophic and hard to diagnose.
Scanner is the counterpart for parsing structured text input. It tokenizes its source (a stream, file, string, or Readable) using a delimiter pattern (whitespace by default) and provides typed nextInt(), nextDouble(), nextLine(), etc.

```Java
// Parsing a structured data file
String data = "Alice 32 85000.50\nBob 28 72000.00\nCarol 45 110000.75";

try (Scanner scanner = new Scanner(data)) {
    while (scanner.hasNextLine()) {
        String name = scanner.next();
        int age = scanner.nextInt();
        double salary = scanner.nextDouble();
        System.out.printf("%s is %d years old, earns %.2f%n", name, age, salary);
    }
}

// Reading a CSV with a custom delimiter
try (Scanner scanner = new Scanner(new File("data.csv"), StandardCharsets.UTF_8)) {
    scanner.useDelimiter(",|\\n"); // split on comma or newline
    while (scanner.hasNext()) {
        System.out.println(scanner.next().trim());
    }
}
```

Scanner is convenient for small parsing tasks but not appropriate for high-performance parsing of large files — it has significant overhead per token. For that, BufferedReader with String.split() or a dedicated CSV library is more appropriate.

#### Piped Streams
PipedInputStream/PipedOutputStream (and their character counterparts PipedReader/PipedWriter) create a direct data pipe between two threads — one writes, the other reads. This is a classic producer-consumer implementation using I/O primitives.

```Java
public class PipedStreamDemo {

    public static void main(String[] args) throws IOException {
        PipedOutputStream pos = new PipedOutputStream();
        PipedInputStream pis = new PipedInputStream(pos); // connect them

        // Producer thread — writes data into the pipe
        Thread producer = new Thread(() -> {
            try (PrintWriter writer = new PrintWriter(pos)) {
                for (int i = 1; i <= 5; i++) {
                    writer.println("Message " + i);
                    writer.flush();
                    Thread.sleep(100);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        });

        // Consumer thread — reads from the pipe
        Thread consumer = new Thread(() -> {
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(pis))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    System.out.println("Received: " + line);
                }
            } catch (IOException e) {
                System.err.println("Pipe read error: " + e.getMessage());
            }
        });

        consumer.start();
        producer.start();
    }
}
```

### NIO

## 14. Networking
https://www.geeksforgeeks.org/java/java/#:~:text=Project%3A%C2%A0Text%20Editor-,Networking,-Java%20Networking%20enables

## 15. Spring Framework
https://www.geeksforgeeks.org/advance-java/advanced-java/#:~:text=6.1%20Basics%20of%20Spring%20Framework

The Spring Framework is a lightweight Java framework used to build scalable, maintainable enterprise applications. It offers a programming and configuration model for modern Java development.

### Dependency Injection
Dependency Injection is a design pattern used in software development to implement Inversion of Control. It allows a class to receive its dependencies from an external source rather than creating them within the class. This reduces the dependency between classes and makes the system more maintainable.


### Inversion of Control
Inversion of Control (IoC) is a design principle used in object-oriented programming where the control of object creation and dependency management is transferred from the application code to an external framework or container. This reduces the complexity of managing dependencies manually and allows for more modular and flexible code.

Spring IoC (Inversion of Control) Container is the core of the Spring Framework. It creates and manages objects (beans), injects dependencies and manages their life cycles. It uses Dependency Injection (DI), based on configurations from XML files, Java-based configuration, annotations or POJOs. Since the container, not the developer, controls object creating and wiring, it's called Inversion of Control (IoC).

There are two types of IoC containers in Spring:
- BeanFactory: is the most basic version of the IoC container. It provides basic support for dependency injection and bean lifecycle management. It is suitable for lightweight applications where advanced features are not required. 
- ApplicationContext: is an extension of BeanFactory with more enterprise features like event propagation, internationalization and more. It is the preferred choice for most Spring applications due to its advanced capabilities.

### Aspect-Oriented Programming
AOP allows developers to separate cross-cutting concerns (such as logging, security and transaction management) from the business logic.

### Maven
Maven allows us to manage dependencies automatically, we don't have to download JAR files manually. Maven does it automatically. When we add dependencies in the pom.xml, Maven downloads the important libraries from the central repository and keeps them up to date.


### Bean lifecycle

### Annotations


## 16. Spring Boot
https://www.geeksforgeeks.org/advance-java/advanced-java/#:~:text=following%20article%3A%20Spring-,6.2%20Spring%20Boot,-Spring%20Boot%20simplifies

## 17. JDBC

### Connections

### Prepared Statements

### SQL Injection Prevention

### Transactions

## 18. Testing and Best Practices
https://www.geeksforgeeks.org/advance-java/advanced-java/#:~:text=article%3A%20Java%20Microservices-,7.%20JUnit,-JUnit%20is%20a

### Unit Testing Basics

### Clean Code Principles

### Common Java Pitfalls


## 19. Interview Questions and Answers

### Core Java Fundamentals
1. What are the differences between JVM, JRE, and JDK, and how do they work together when running a Java application?

2. Explain the Java compilation process and how it differs from the execution process at runtime.

3. What is bytecode in Java, and why does Java use bytecode instead of directly compiling to machine code?

4. Describe the basic Java memory model. What are the main memory areas used by the JVM?

5. How does Java achieve platform independence, and what role does the JVM play in this?

### Object Oriented Programming

### Collections Framework

### Exception Handling

### Java 8+ Features

### Concurrency and Parallelism

### Java Memory Management

### Immutability

### Equals and HashCode Contract

### SOLID

### Design Patterns

### Serialization

### IO and NIO

### Networking

### Spring Framework

### Spring Boot

### JDBC

### Testing and Best Practices

#### Exercises
List of exercises: https://codingdojo.org/kata/

##### 1. FizzBuzz

##### 2. CSV Parser

##### 2. Roman Numeral Converter

##### 3. Expression Evaluator (mini calculator with + - * /)

##### 4. Bowling Game Kata

##### 5. Prime Factors Kata

##### 6. Anagram Finder

##### 7. String Calculator Kata Exercise
Write a method:
```Java
int add(String input)
```
that parses a string containing numbers separated by delimiters and returns their sum. The function must correctly handle default delimiters, custom delimiters, and edge cases.
1. Basic Case: the input will contain zero or more integers separated by commas:
    ```Java
    "" → return 0

    "1" → 1

    "1,2,3" → 6
    ```
2. Support Newline as a Delimiter: the string can also contain newline (\n) characters as valid delimiters:
    ```Java
    "1\n2,3" → 6
    ```
3. Custom Delimiters: the input may specify one or more custom delimiters at the start using this format:
    ```Java
        //<delimiter>\n<numbers>
    ```
    Examples:
    ```Java
    "//;\n1;2;3" → delimiters = ;, sum = 6

    "//|\n5|6|7" → 18
    ```
4. Custom Delimiters of Any Length: if the delimiter is wrapped in brackets, it can be longer than one character:
    ```Java
    "//[***]\n1***2***3" → 6
    ```
5. Multiple Custom Delimiters: you may also receive multiple delimiters, each wrapped in brackets:
    ```Java
    "//[*][%]\n1*2%3" → 6

    "//[&&][|||]\n4&&5|||6" → 15
    ```
6. Negative Numbers: if a negative number appears, throw an exception:
    ```Java
    "1,-2,3" → throw IllegalArgumentException("Negatives not allowed: -2")
    ```
    If multiple negatives:
    ```Java
    "1,-2,-5" → "Negatives not allowed: -2, -5"
    ```
7. Ignore Numbers > 1000: numbers larger than 1000 must be ignored.
    ```Java
    "2,1001,3" → 5
    ```