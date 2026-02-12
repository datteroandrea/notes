# Object Oriented Programming in Java
Useful links:
https://www.geeksforgeeks.org/java/java/
https://www.geeksforgeeks.org/advance-java/advanced-java/
https://www.geeksforgeeks.org/advance-java/spring-boot/

## Index
1. [Core Java Fundamentals](#core-java-fundamentals)
    - [JVM, JRE, JDK](#jvm-jre-jdk)
    - [Compilation vs Execution](#compilation-vs-execution)
2. [Object Oriented Programming](#object-oriented-programming)
    - [Encapsulation](#encapsulation)
    - [Inheritance](#inheritance)
    - [Polymorphism (REWRITE)](#polymorphism)
        - [Compile-time Polymorphism](#compile-time-polymorphism)
        - [Runtime Polymorphism](#runtime-polymorphism)
    - [Abstraction](#abstraction)
        - [Interfaces](#interfaces)
        - [Abstract Classes](#abstract-classes)
3. [Collections Framework (IMPROVE)](#collections-framework)
    - [List](#list)
        - [ArrayList](#arraylist)
        - [LinkedList](#linkedlist)
    - [Set](#set)
        - [HashSet](#hashset)
        - [LinkedHashSet (TODO)](#linkedhashset)
    - [Map (TODO)](#map)
        - [HashMap](#hashmap)
        - [TreeMap](#treemap)
        - [LinkedHashMap (TODO)](#compile-time-polymorphism)
    - [Queue (TODO)](#queue)
        - [PriorityQueue (TODO)](#priorityqueue)
    - [Iterator (TODO)](#iterator)
    - [Comparator (TODO)](#comparator)
    - [HashMap vs TreeMap (TODO)](#hashmap-vs-treemap)
4. [Exception Handling (IMPROVE)](#exception-handling)
    - [Checked vs Unchecked Exceptions](#checked-vs-unchecked-exceptions)
    - [try-catch-finally](#try-catch-finally)
    - [throw vs throws](#throw-vs-throws)
    - [Custom Exceptions](#custom-exceptions)
5. [Java 8+ features (IMPROVE)](#java-8-features)
    - [Functional Interfaces](#functional-interfaces)
    - [Lambda Expressions](#lambda-expressions)
    - [Method References (TODO)](#method-references)
    - [Streams (IMPROVE)](#streams)
    - [Optional](#optional)
6. [Concurrency & Parallelism (IMPROVE)](#concurrency-and-parallelism)
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
7. [Java Memory Management (IMPROVE)](#java-memory-management)
    - [Stack](#stack)
    - [Heap](#heap)
    - [Garbage Collection (EXPAND)](#garbage-collection)
        - [Generational Garbage Collection (TODO)](#generational-garbage-collection)
        - [Memory Leaks (IMPROVE)](#memory-leaks)
8. [Immutability (IMPROVE)](#immutability)
    - [Immutable Variables (IMPROVE)](#immutable-variables)
    - [Immutable Methods (TODO)](#immutable-methods)
    - [Immutable Classes (IMPROVE)](#immutable-classes)
        - [String Immutability](#string-immutability)
        - [Benefits and Pitfalls](#benefits-and-pitfalls)
9. [Equals & Hashcode Contract](#equals-and-hashcode-contract)
10. [SOLID](#solid)
11. [Design Patterns](#design-patterns)
    - [Creational Patterns](#creational-patterns)
        - [Singleton](#singleton)
        - [Factory](#factory)
        - [Builder](#builder)
    - [Structural Patterns (TODO)](#structural-patterns)
        - [Decorator (TODO)](#decorator)
        - [Facade (TODO)](#facade)
        - [Composite (TODO)](#composite)
        - [Proxy (TODO)](#proxy)
    - [Behavioral Patterns (EXPAND)](#behavioral-patterns)
        - [Strategy](#strategy)
        - [Observer](#observer)
        - [Command (TODO)](#command)
        - [State (TODO)](#state)
12. [Serialization](#serialization)
    - [Serializable vs Externalizable](#serializable-vs-externalizable)
    - [transient](#transient)
    - [Versioning](#versioning)
13. [I/O & NIO](#io-and-nio)
    - [System I/O](#system-io)
    - [Streams vs Readers/Writers](#streams-vs-readers-and-writers)
    - [File Handling](#file-handling)
        - [Java IO](#java-io)
        - [Java NIO](#java-nio)
14. [Networking (TODO)](#networking)
    - [](#)
    - [](#)
    - [](#)
    - [](#)
15. [Spring Framework](#spring-framework)
    - [Dependency Injection](#dependency-injection)
    - [Inversion of Control](#inversion-of-control)
    - [Aspect-Oriented Programming](#aspect-oriented-programming)
    - [Maven](#maven)
    - [Bean lifecycle (TODO)](#bean-lifecycle)
    - [Annotations (TODO)](#annotations)
16. [Spring Boot (TODO)](#spring-boot)
    - [](#)
    - [](#)
    - [](#)
    - [](#)
    - [](#)
17. [JDBC (TODO)](#jdbc)
    - [Connections (TODO)](#connections)
    - [Prepared Statements (TODO)](#prepared-statements)
    - [SQL Injection Prevention (TODO)](#sql-injection-prevention)
    - [Transactions (TODO)](#transactions)
18. [Testing & Best Practices (TODO)](#testing-and-best-practices)
    - [Unit Testing Basics (TODO)](#unit-testing-basics)
    - [Clean Code Principles (TODO)](#clean-code-principles)
    - [Common Java Pitfalls (TODO)](#common-java-pitfalls)
19. [Interview Questions & Anwers (TODO)](#interview-questions-and-answers)
    - [](#)
    - [](#)
    - [](#)
    - [](#)

## Core Java Fundamentals
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


## Object-Oriented Programming

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

## Collections Framework
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

## Exception Handling

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

## Java 8 Features

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

## Concurrency and Parallelism
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

## Java Memory Management
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

## Immutability
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

## Equals and HashCode Contract
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

## SOLID
SOLID is a set of five core Object-Oriented Design principles that help you write maintainable, flexible, and scalable software, SOLID stands for:
- Single Responsibility: a class should only have one responsibility.
- Open/Closed: classes should be open for extension but closed for modification.
- Liskov Substitution: if class A is a subtype of class B, we should be able to replace B with A without disrupting the behavior of our program.
- Interface Segregation: larger interfaces should be split into smaller ones. By doing so, we can ensure that implementing classes only need to be concerned about the methods that are of interest to them.
- Dependency Inversion: The principle of dependency inversion refers to the decoupling of software modules. This way, instead of high-level modules depending on low-level modules, both will depend on abstractions.

## Design Patterns
Design patterns are proven, reusable solutions to common software design problems.
They are not code you copy-paste, but rather general templates for solving recurring issues in object-oriented programming.

There are different types of design patterns:
- Creational patterns deal with object creation: how, when, and by whom objects should be instantiated, some examples are: Singleton, Factory Method, Abstract Factory and Builder.
Structural patterns deal with class composition: how objects fit together to form larger structures, some examples are: Adapter, Decorator, Facade, Composite and Proxy.
- Behavioral patterns handle communication and responsibility distribution between objects, some examples are: Observer, Command, Iterator, Template, State, Chain of Responsibility.

### Creational Patterns

#### Singleton
In object-oriented programming, a Java singleton class is a class that can have only one object (an instance of the class) at a time. After the first time, if we try to instantiate the Java Singleton classes, the new variable also points to the first instance created. So, whatever modifications we do to any variable inside the class through any instance, affect the variable of the single instance created and are visible if we access that variable through any variable of that class type defined.
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

The primary purpose of a Java Singleton class is to restrict the limit of the number of object creations to only one. This often ensures that there is access control to resources, for example, a socket or a database connection.

It is memory efficient as the object creation will take place only once instead of creating it each time a new request is made, which reduces the overhead and makes it memory efficient.

It is thread-safe: only a single thread at a time can access the instance.

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

#### Builder
The Builder pattern is a creational design pattern used to construct complex objects step-by-step. It separates the construction process from the final representation, making it easier to build objects with many optional or configurable fields.

Use it when:
- A class has many constructor parameters (especially optional ones).
- You want the object to be immutable after creation.
- You want a readable, fluent way to create configurations.
- You want to avoid "telescoping constructors".

To use the Builder pattern create a static nested Builder class inside your main class, the builder class contains the same fields as the parent class, all the methods in the builder set fields and return the builder (fluent interface) a build() method creates the final immutable object.

```Java
public class User {

    private final String firstName;
    private final String lastName;
    private final int age;
    private final boolean emailVerified;

    private User(Builder builder) {
        this.firstName = builder.firstName;
        this.lastName = builder.lastName;
        this.age = builder.age;
        this.emailVerified = builder.emailVerified;
    }

    public static class Builder {
        private String firstName;
        private String lastName;
        private int age;
        private boolean emailVerified;

        public Builder firstName(String firstName) {
            this.firstName = firstName;
            return this;
        }

        public Builder lastName(String lastName) {
            this.lastName = lastName;
            return this;
        }

        public Builder age(int age) {
            this.age = age;
            return this;
        }

        public Builder emailVerified(boolean emailVerified) {
            this.emailVerified = emailVerified;
            return this;
        }

        public User build() {
            return new User(this);
        }
    }
}
```

### Structural Patterns

#### Decorator

#### Facade

#### Composite

#### Proxy

### Behavioral Patterns

#### Strategy
The Strategy Pattern is a behavioral design pattern that lets you define a family of algorithms, encapsulate each algorithm in its own class, and switch between them at runtime.

Use it when:
- You have multiple ways to perform an action.
- You want to choose the algorithm at runtime.
- You want to avoid long if–else or switch statements.
- You want to follow the Open/Closed Principle (easy to add new behaviors without modifying existing code).

To use the Strategy pattern create "Strategy Interface" that defines a common method for all algorithms, create different classes called "Concrete Strategies" that implement different variations of the interface then define a "context" that uses a strategy and allows changing it dynamically.

```Java
public interface PaymentStrategy {
    void pay(double amount);
}

public class CreditCardPayment implements PaymentStrategy {
    @Override
    public void pay(double amount) {
        System.out.println("Paid " + amount + " using Credit Card.");
    }
}

public class PayPalPayment implements PaymentStrategy {
    @Override
    public void pay(double amount) {
        System.out.println("Paid " + amount + " using PayPal.");
    }
}

public class CryptoPayment implements PaymentStrategy {
    @Override
    public void pay(double amount) {
        System.out.println("Paid " + amount + " using Crypto.");
    }
}

public class CheckoutContext {
    private PaymentStrategy strategy;

    public void setPaymentStrategy(PaymentStrategy strategy) {
        this.strategy = strategy;
    }

    public void processOrder(double amount) {
        strategy.pay(amount);
    }
}
```

#### Observer
The Observer Pattern is a behavioral design pattern that defines a one-to-many relationship between objects. When one object (the Subject) changes its state, all the dependent objects (the Observers) are automatically notified.

Use the Observer pattern when:
One object's change should update others automatically.
You want to avoid tight coupling between objects.
You need a reactive update system.
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

#### Command

#### State

## Serialization
Serialization is the process of converting a Java object into a byte stream so it can be saved in the disk, sent over a network, cached, etc.

Deserialization is the reverse process: reconstructing the object from the byte stream.

### Serializable vs Externalizable
Serializable is a marker interface (an interface with no methods), the JVM automatically handles serialization of the object using reflection. It's not really efficient because it stores class metadata and does not offer control on which fields are serialized.

Externalizable is a sub-interface of Serializable, it introduces 2 mandatory methods:
```Java
void writeExternal(ObjectOutput out) throws IOException;
void readExternal(ObjectInput in) throws IOException, ClassNotFoundException;
```

This method allows control of how the object is serialized/deserialized.

### transient
In a Serializable or Externalizable Object, fields marked with transient keywords will not be serialized.
```Java
class User implements Serializable {
    private String username;
    private transient String password; // will not be serialized
}
```

### Versioning
Java serialization uses serialVersionUID to verify version compatibility between the class that produced the serialized object and the class that is trying to read it.
A serialVersionUID is declared as follows:
```Java
private static final long serialVersionUID = 1L;
```
If you don't, JVM generates one automatically based on class structure. Small changes (like adding a field or changing method visibility) can change the generated UID which can break backward compatibility.

The best practice is to always explicitly define serialVersionUID in Serializable classes to control compatibility.

Changing a Serializable class is safe if you:
- Add new fields they are set to default values when reading old data
- Remove transient keyword
- Change method logic

It is unsafe if you:
- Remove a non-transient field
- Change field type
- Change class hierarchy (e.g., removing Serializable)
- Change serialVersionUID manually

## IO and NIO
https://www.geeksforgeeks.org/java/java/#:~:text=Project%3A%20Snake%20Game-,File%20Handling,-Java%20File%20Handling
Java I/O (Input/Output) is a collection of classes and streams in the java.io package that handle reading data from sources (like files, keyboard, or network) and writing data to destinations (like files, console or sockets). It provides both byte and character streams to support all types of data.
Java I/O is the traditional, stream-based, blocking I/O API this means that:
data is read/written 1 byte or char at a time
when calling read() or write(), the thread stops and waits until the operation finishes

### System IO
System.in: This is the standard input stream that is used to read characters from the keyboard or any other standard input device, it implements the following methods:
int read(): reads one byte of data.
int read(byte[] b): reads bytes into an array.
int read(byte[] b, int off, int len): reads bytes into part of an array.
void close(): closes the input stream.
int available(): returns the number of bytes that can be read without blocking.
System.out: This is the standard output stream that is used to produce the result of a program on an output device like the computer screen, it implements the following methods:
print(String s): This Java method displays text on the console, keeping the cursor at the end of the printed text so the next output continues from the same line.
println(String s): This method in Java is also used to display a text on the console. It prints the text on the console and the cursor moves to the start of the next line at the console. The next printing takes place from the next line.
printf(String s, T… args): The printf() method in Java is used for formatted output and can take multiple arguments, making it more flexible than print() or println().
System.err: This is the standard error stream that is used to display error messages separately from normal output.

### Streams vs Readers and Writers
Depending on the type of operations, streams can be divided into two primary classes:
Input Stream: These streams are used to read data that must be taken as an input from a source array or file or any peripheral device. i.e.: FileInputStream, BufferedInputStream, ByteArrayInputStream.
Output Stream: These streams are used to write data as outputs into an array or file or any output peripheral device. i.e.: FileOutputStream, BufferedOutputStream, ByteArrayOutputStream.

Streams can be divided into two primary classes:
Byte Stream: are used to perform input and output of 8-bit bytes. They are suitable for handling raw binary data such as images, audio, and video, using classes like InputStream and OutputStream.
Character Stream: are used to perform input and output of 16-bit Unicode characters. They are best suited for handling text data, using classes like Reader and Writer which automatically handle character encoding and decoding.
### File handling

#### Java I/O
File represents a pathname to a file or directory. It does not read/write file contents, but manages metadata and operations.

```Java
File file = new File("example.txt");

file.exists();
file.canRead();
file.canWrite();
file.isDirectory();
file.isFile();
file.length();      // size in bytes
file.getAbsolutePath();
```

To read and write bytes:
```Java
try (FileInputStream fis = new FileInputStream("input.bin")) {
    int data;
    while ((data = fis.read()) != -1) {
        System.out.println(data);
    }
}

try (FileOutputStream fos = new FileOutputStream("output.bin")) {
    fos.write(new byte[]{1, 2, 3});
}


To read and write text:
try (BufferedReader br = new BufferedReader(new FileReader("input.txt"))) {
    String line;
    while ((line = br.readLine()) != null) {
        System.out.println(line);
    }
}

try (PrintWriter pw = new PrintWriter(new FileWriter("output.txt"))) {
    pw.println("Hello World");
}
```

Copying files:
```Java
try (InputStream in = new FileInputStream("in.txt");
     OutputStream out = new FileOutputStream("out.txt")) {
    in.transferTo(out);
}
```

#### Java NIO
The modern API uses Path, Files, and offers better performance, error handling, and ease of use.

```Java
Path path = Paths.get("example.txt");

Files.exists(path);
Files.isDirectory(path);
Files.size(path);
Files.getLastModifiedTime(path);

Files.createFile(path);
Files.delete(path);

List<String> lines = Files.readAllLines(path); // small files
byte[] bytes = Files.readAllBytes(path);       // binary

try (Stream<String> lines = Files.lines(path)) {
    lines.forEach(System.out::println);
}

Files.write(path, "Hello".getBytes());
Files.write(path, List.of("One", "Two")); // text lines

Files.copy(Paths.get("in.txt"), Paths.get("out.txt"));
```



## Networking
https://www.geeksforgeeks.org/java/java/#:~:text=Project%3A%C2%A0Text%20Editor-,Networking,-Java%20Networking%20enables

## Spring Framework
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


## Spring Boot
https://www.geeksforgeeks.org/advance-java/advanced-java/#:~:text=following%20article%3A%20Spring-,6.2%20Spring%20Boot,-Spring%20Boot%20simplifies

## JDBC

### Connections

### Prepared Statements

### SQL Injection Prevention

### Transactions

## Testing and Best Practices
https://www.geeksforgeeks.org/advance-java/advanced-java/#:~:text=article%3A%20Java%20Microservices-,7.%20JUnit,-JUnit%20is%20a

### Unit Testing Basics

### Clean Code Principles

### Common Java Pitfalls


## Interview Questions and Answers
1. What are the differences between JVM, JRE, and JDK, and how do they work together when running a Java application?

2. Explain the Java compilation process and how it differs from the execution process at runtime.

3. What is bytecode in Java, and why does Java use bytecode instead of directly compiling to machine code?

4. Describe the basic Java memory model. What are the main memory areas used by the JVM?

5. How does Java achieve platform independence, and what role does the JVM play in this?