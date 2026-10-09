# Discrete Mathematics

## Index

- [1. Logic and Proofs](#1-logic-and-proofs)
  - [1.1 Propositional Logic](#11-propositional-logic)
  - [1.2 Predicate Logic](#12-predicate-logic)
  - [1.3 Rules of Inference](#13-rules-of-inference)
  - [1.4 Proof Techniques](#14-proof-techniques)
- [2. Sets, Functions, and Relations](#2-sets-functions-and-relations)
  - [2.1 Set Theory](#21-set-theory)
  - [2.2 Functions](#22-functions)
  - [2.3 Cardinality](#23-cardinality)
  - [2.4 Relations](#24-relations)
  - [2.5 Equivalence Relations and Orders](#25-equivalence-relations-and-orders)
- [3. Induction and Recursion](#3-induction-and-recursion)
  - [3.1 Sequences and Summations](#31-sequences-and-summations)
  - [3.2 Mathematical Induction](#32-mathematical-induction)
  - [3.3 Recursive Definitions](#33-recursive-definitions)
- [4. Number Theory](#4-number-theory)
  - [4.1 Divisibility](#41-divisibility)
  - [4.2 GCD and LCM](#42-gcd-and-lcm)
  - [4.3 Modular Arithmetic](#43-modular-arithmetic)
  - [4.4 Applications of Number Theory](#44-applications-of-number-theory)
- [5. Combinatorics](#5-combinatorics)
  - [5.1 Counting Principles](#51-counting-principles)
  - [5.2 Permutations and Combinations](#52-permutations-and-combinations)
  - [5.3 Binomial Coefficients](#53-binomial-coefficients)
  - [5.4 Pigeonhole Principle](#54-pigeonhole-principle)
  - [5.5 Inclusion–Exclusion](#55-inclusionexclusion)
  - [5.6 Special Counting Sequences](#56-special-counting-sequences)
- [6. Recurrence Relations and Generating Functions](#6-recurrence-relations-and-generating-functions)
  - [6.1 Recurrence Relations](#61-recurrence-relations)
  - [6.2 Divide-and-Conquer Recurrences](#62-divide-and-conquer-recurrences)
  - [6.3 Generating Functions](#63-generating-functions)
- [7. Discrete Probability](#7-discrete-probability)
  - [7.1 Probability Fundamentals](#71-probability-fundamentals)
  - [7.2 Bayes and Applications](#72-bayes-and-applications)
  - [7.3 Random Variables](#73-random-variables)
  - [7.4 Distributions and Bounds](#74-distributions-and-bounds)
- [8. Graph Theory](#8-graph-theory)
  - [8.1 Graph Fundamentals](#81-graph-fundamentals)
  - [8.2 Graph Representation and Isomorphism](#82-graph-representation-and-isomorphism)
  - [8.3 Connectivity](#83-connectivity)
  - [8.4 Traversals and Paths](#84-traversals-and-paths)
  - [8.5 Planarity and Coloring](#85-planarity-and-coloring)
  - [8.6 Matchings and Flows](#86-matchings-and-flows)
- [9. Trees](#9-trees)
  - [9.1 Tree Fundamentals](#91-tree-fundamentals)
  - [9.2 Applications of Trees](#92-applications-of-trees)
  - [9.3 Tree Traversal](#93-tree-traversal)
  - [9.4 Spanning Trees](#94-spanning-trees)
- [10. Algorithms and Complexity](#10-algorithms-and-complexity)
  - [10.1 Algorithm Basics](#101-algorithm-basics)
  - [10.2 Growth of Functions](#102-growth-of-functions)
  - [10.3 Complexity Analysis](#103-complexity-analysis)
- [11. Boolean Algebra](#11-boolean-algebra)
  - [11.1 Boolean Functions](#111-boolean-functions)
  - [11.2 Logic Circuits](#112-logic-circuits)
  - [11.3 Circuit Minimization](#113-circuit-minimization)
- [12. Algebraic Structures](#12-algebraic-structures)
  - [12.1 Groups](#121-groups)
  - [12.2 Rings and Fields](#122-rings-and-fields)
  - [12.3 Applications](#123-applications)
- [13. Formal Languages and Automata](#13-formal-languages-and-automata)
  - [13.1 Languages and Grammars](#131-languages-and-grammars)
  - [13.2 Finite-State Machines](#132-finite-state-machines)
  - [13.3 Regular Languages](#133-regular-languages)
  - [13.4 Computability](#134-computability)

---

<a id="1-logic-and-proofs"></a>
## 1. Logic and Proofs

Logic gives mathematics and computer science a precise language. In that language, "true", "false", "for all" and "therefore" each have exactly one meaning. This chapter starts with propositions and the connectives that combine them, extends them with predicates and quantifiers, and then uses rules of inference and standard proof techniques to build arguments that are guaranteed to be correct. Every later chapter relies on these tools. The same ideas also appear in everyday programming, in boolean conditions, assertions, database queries, type systems and SAT solvers.

<a id="11-propositional-logic"></a>
### 1.1 Propositional Logic

Propositional logic treats whole statements as atomic units that are either true or false, and studies how connectives combine them into larger statements.

#### Propositions and Truth Values

**Why.** Natural language is ambiguous. "The system is secure" means different things to different people. Before we can reason rigorously, we need statements whose truth is not open to interpretation.

**What.** A **proposition** is a declarative sentence that is either true or false, but not both. Its **truth value** is written `T`/`F` (or `1`/`0`). Propositions are usually named with **propositional variables** such as `p`, `q`, `r`.

- An **atomic** proposition cannot be broken into smaller propositions ("7 is prime").
- A **compound** proposition is built from others using connectives ("7 is prime and 7 is odd").

Propositional logic assumes **bivalence**: every proposition has exactly one of the two truth values, even if we do not yet know which one.

| Sentence | Proposition? | Reason |
|---|---|---|
| "7 is prime." | Yes (T) | Declarative, definite truth value |
| "2 + 2 = 5." | Yes (F) | False propositions are still propositions |
| "Every even integer greater than 2 is a sum of two primes." | Yes (unknown) | Goldbach's conjecture: the truth value exists but has not been determined |
| "x + 1 = 3." | No | Truth depends on `x` (this is a predicate, see 1.2) |
| "Close the door." | No | Command, not a statement |
| "Is it raining?" | No | Question |
| "This sentence is false." | No | Paradox: neither value can be assigned consistently |

**Analogy.** A proposition behaves like a boolean constant in a program. Once it is evaluated, it is fixed. A sentence with an unbound variable is more like a function that has not been called yet.

```python
# Propositions: fixed truth values
p = 7 % 2 == 1          # "7 is odd"   -> True
q = 2 + 2 == 5          # "2 + 2 = 5"  -> False

# Not a proposition: the truth value depends on x (a predicate, see 1.2)
def x_plus_one_is_three(x):
    return x + 1 == 3

x_plus_one_is_three(2)  # True  -- only after choosing x do we get a proposition
x_plus_one_is_three(5)  # False
```

**Key takeaways**

- A proposition is a declarative sentence with exactly one truth value, either T or F.
- Not knowing the truth value does not stop a sentence from being a proposition. Depending on a free variable does.
- Questions, commands, and self-referential paradoxes are not propositions.
- Compound propositions are built from atomic ones with connectives.

> **Practice**
>
> 1. (Beginner) Classify each as a proposition or not, and give the truth value where possible: "1 + 1 = 10", "Delete this file.", "There are infinitely many primes.", "x > 0".
> 2. (Intermediate) Explain why "Tomorrow it will rain" can be treated as a proposition, while "It is raining here" cannot be treated as one without more context. What extra information turns the second into a proposition?
> 3. (Interview) Is the sentence "This statement is false" a proposition? Relate your answer to why a function `def f(): return not f()` cannot produce a boolean. *Hint:* try assigning T, then F, and follow the consequences.

#### Logical Connectives

**Why.** Real conditions are rarely atomic. "The user is logged in **and** is not banned" combines two simpler facts. Connectives are the operators that build compound propositions, in the same way that `+` and `*` build arithmetic expressions.

**What.** The standard connectives, with their counterparts in code:

| Symbol | Name | Read as | True exactly when | Python | C / Java / JS |
|---|---|---|---|---|---|
| `¬p` | Negation | not p | p is false | `not p` | `!p` |
| `p ∧ q` | Conjunction | p and q | both are true | `p and q` | `p && q` |
| `p ∨ q` | Disjunction | p or q | at least one is true | `p or q` | `p \|\| q` |
| `p ⊕ q` | Exclusive or | p xor q | exactly one is true | `p != q` | `p != q` |
| `p → q` | Conditional | if p then q | not (p true and q false) | `(not p) or q` | `!p \|\| q` |
| `p ↔ q` | Biconditional | p if and only if q | both have the same value | `p == q` | `p == q` |

**Inclusive vs exclusive or.** In logic, "or" is **inclusive**: `p ∨ q` is true when both are true. English often means the exclusive version ("soup or salad comes with the meal"). When you need exactly one, use `⊕`.

**Precedence.** From tightest to loosest binding: `¬`, `∧`, `∨`, `→`, `↔`. So:

```text
¬p ∧ q ∨ r → s      parses as      ((¬p ∧ q) ∨ r) → s
```

By convention `→` associates to the right (`p → q → r` means `p → (q → r)`), but explicit parentheses are always clearer.

```python
def NOT(p):        return not p
def AND(p, q):     return p and q
def OR(p, q):      return p or q
def XOR(p, q):     return p != q          # on booleans, "different" means exactly one is true
def IMPLIES(p, q): return (not p) or q    # false only for p=True, q=False
def IFF(p, q):     return p == q

# Short-circuiting: Python stops evaluating as soon as the result is known
def expensive():
    print("evaluated")
    return True

False and expensive()   # prints nothing: False ∧ anything is False
True or expensive()     # prints nothing: True ∨ anything is True
```

**Key takeaways**

- `¬`, `∧`, `∨`, `⊕`, `→`, `↔` are the core connectives. Each one is fully defined by its truth table.
- Logical "or" is inclusive. Use `⊕` for "exactly one".
- Precedence is `¬ > ∧ > ∨ > → > ↔`. Add parentheses whenever there could be doubt.
- Most languages have no implication operator. Write `p → q` as `!p || q`.

> **Practice**
>
> 1. (Beginner) Let `p` = "it is sunny" and `q` = "I go running". Write in English: `¬p ∧ q`, `p → q`, `¬(p ∨ q)`.
> 2. (Intermediate) Fully parenthesize `p ∨ ¬q ∧ r → p ↔ q` according to standard precedence.
> 3. (Interview) Python has no implication operator, yet `p <= q` correctly computes `p → q` for booleans. Explain why. *Hint:* in Python, `False < True`. Compare the four cases with the truth table of `→`.

#### Truth Tables

**Why.** A compound proposition can have many variables, and intuition about it is unreliable. A truth table is a mechanical, exhaustive procedure: it lists every possible assignment of truth values and the resulting value of the formula. Nothing is left to judgment.

**How.**

1. List the variables. With `n` variables there are `2ⁿ` rows.
2. Enumerate the assignments systematically, for example by counting in binary from all-T down to all-F.
3. Add one column per subformula, working from the innermost outward.
4. The final column is the value of the whole formula.

Example: `(p ∨ q) ∧ ¬(p ∧ q)`

| p | q | p ∨ q | p ∧ q | ¬(p ∧ q) | (p ∨ q) ∧ ¬(p ∧ q) |
|---|---|---|---|---|---|
| T | T | T | T | F | **F** |
| T | F | T | F | T | **T** |
| F | T | T | F | T | **T** |
| F | F | F | F | T | **F** |

The final column matches `p ⊕ q`, so this formula is one way to express exclusive or using only `∧`, `∨`, `¬`.

```python
from itertools import product

def truth_table(variables, formula):
    """Print the truth table of formula, a function taking len(variables) booleans."""
    print(" | ".join(variables) + " | result")
    for values in product([True, False], repeat=len(variables)):  # all 2^n assignments
        cells = ["T" if v else "F" for v in values]
        result = "T" if formula(*values) else "F"
        print(" | ".join(cells) + " | " + result)

truth_table(["p", "q"], lambda p, q: (p or q) and not (p and q))
# p | q | result
# T | T | F
# T | F | T
# F | T | T
# F | F | F
```

**Cost.** Truth tables grow exponentially. 10 variables need 1,024 rows, and 50 variables need about 10¹⁵. This exponential growth is why satisfiability (below) is a hard computational problem.

**Key takeaways**

- A truth table evaluates a formula under all `2ⁿ` assignments of its `n` variables.
- Build intermediate columns for subformulas to avoid mistakes.
- Two formulas with identical final columns are logically equivalent.
- The method is complete but exponential, so it only scales to small formulas.

> **Practice**
>
> 1. (Beginner) Build the truth table for `p → (q ∨ ¬r)`. How many rows evaluate to F?
> 2. (Intermediate) A formula has 6 variables. How many rows does its truth table have? How many *distinct* boolean functions of 6 variables exist?
> 3. (Interview) Given two boolean expressions over `n` variables, describe an algorithm to decide whether they always produce the same result, and state its complexity. *Hint:* consider the truth table of their XOR. Is a better worst case likely? Look ahead to Satisfiability.

#### Conditional and Biconditional Statements

**Why.** "If ... then ..." is the shape of almost every mathematical theorem and every program requirement. Its truth table surprises most beginners, so it deserves careful study.

**The conditional `p → q`.** `p` is the **hypothesis** (antecedent) and `q` is the **conclusion** (consequent). The statement is false in only one situation: the hypothesis holds and the conclusion fails.

**Analogy: a promise.** "If you get an A, I will give you $10."

- You get an A and receive $10: promise kept (T).
- You get an A and do not receive $10: promise broken (F).
- You do not get an A: whatever happens, the promise was not broken (T).

The last case is called **vacuous truth**. A conditional with a false hypothesis is true.

**The biconditional `p ↔ q`.** True when `p` and `q` have the same truth value. It means `(p → q) ∧ (q → p)`, and is read "p if and only if q" (often written "iff").

| p | q | p → q | p ↔ q |
|---|---|---|---|
| T | T | T | T |
| T | F | **F** | F |
| F | T | T | F |
| F | F | T | T |

**English forms of `p → q`.** All of the following mean the same thing:

| Phrase | Note |
|---|---|
| if p, then q / p implies q | Standard form |
| q if p / q whenever p | Conclusion stated first |
| p only if q | **Not** the same as "q only if p". p cannot happen without q |
| p is sufficient for q | p alone guarantees q |
| q is necessary for p | Without q, no p |
| q unless ¬p | "q unless r" means `¬r → q` |

**Biconditional phrases:** "p if and only if q", "p is necessary and sufficient for q", "p exactly when q".

Note that `→` says nothing about causation. "If 2 + 2 = 4 then Paris is in France" is true, even though the two facts are unrelated.

```python
# A policy as a conditional: "if a user is an admin, then they can delete posts"
users = [
    {"name": "ana",  "is_admin": True,  "can_delete": True},
    {"name": "ben",  "is_admin": False, "can_delete": False},
    {"name": "cleo", "is_admin": False, "can_delete": True},   # vacuously fine for the policy
]

policy_holds = all((not u["is_admin"]) or u["can_delete"] for u in users)  # p → q per user
print(policy_holds)  # True

# Stronger policy as a biconditional: "admin if and only if can delete"
iff_holds = all(u["is_admin"] == u["can_delete"] for u in users)
print(iff_holds)     # False: cleo can delete without being admin
```

**Key takeaways**

- `p → q` is false only when `p` is true and `q` is false.
- A false hypothesis makes the conditional vacuously true.
- "p only if q" means `p → q`. "p if q" means `q → p`.
- `p ↔ q` is equivalent to `(p → q) ∧ (q → p)` and holds when both sides match.

> **Practice**
>
> 1. (Beginner) Determine the truth value: "If 2 + 2 = 5, then the Moon is made of cheese." "If 2 + 2 = 4, then 3 is even."
> 2. (Intermediate) Write each as `p → q`, identifying `p` and `q`: "You can access the server only if you use the VPN." "A passing CI run is necessary for a merge." "The build fails unless all tests pass."
> 3. (Interview) A requirement says: "The alarm sounds only if the door is open." A test observes the door open and the alarm silent. Does this violate the requirement? *Hint:* decide carefully which statement is the hypothesis before checking the truth table.

#### Converse, Inverse, and Contrapositive

**Why.** Many reasoning errors come from silently replacing a conditional with a related statement that is *not* equivalent to it. Knowing which variations are safe tells you when such a substitution is allowed.

**What.** For a conditional `p → q`:

| Name | Form | Equivalent to `p → q`? |
|---|---|---|
| Original | `p → q` | — |
| Converse | `q → p` | No |
| Inverse | `¬p → ¬q` | No |
| Contrapositive | `¬q → ¬p` | **Yes** |

The converse and the inverse are equivalent *to each other*, because the inverse is the contrapositive of the converse.

```text
   original:     p → q    <== equivalent ==>    ¬q → ¬p   :contrapositive
                   |                               |
                (swap)                          (swap)
                   |                               |
   converse:     q → p    <== equivalent ==>    ¬p → ¬q   :inverse
```

Example: "If it is raining, the ground is wet."

- Converse: "If the ground is wet, it is raining." (False: a sprinkler could be on.)
- Inverse: "If it is not raining, the ground is not wet." (False for the same reason.)
- Contrapositive: "If the ground is not wet, it is not raining." (True whenever the original is.)

```python
from itertools import product

implies = lambda a, b: (not a) or b
rows = list(product([True, False], repeat=2))

original       = [implies(p, q)         for p, q in rows]
converse       = [implies(q, p)         for p, q in rows]
inverse        = [implies(not p, not q) for p, q in rows]
contrapositive = [implies(not q, not p) for p, q in rows]

print(original == contrapositive)  # True
print(converse == inverse)         # True
print(original == converse)        # False: differs on the row p=F, q=T
```

**Key takeaways**

- The contrapositive `¬q → ¬p` is logically equivalent to `p → q`.
- The converse `q → p` and the inverse `¬p → ¬q` are not equivalent to the original, but they are equivalent to each other.
- Assuming the converse of a true statement is one of the most common logical errors.
- Proof by contrapositive (1.4) relies directly on this equivalence.

> **Practice**
>
> 1. (Beginner) Write the converse, inverse, and contrapositive of "If n is divisible by 6, then n is divisible by 3." Which of the four are true for all integers `n`?
> 2. (Intermediate) Give an example of a true conditional whose converse is also true. What does that tell you about the biconditional?
> 3. (Interview) A code reviewer reads: "Every valid session token matches the regex `^[a-f0-9]{64}$`, so the check `if regex.match(token): grant_access()` is correct." Identify the logical flaw. *Hint:* write the known fact as `p → q` and compare it with the conditional the code actually implements.

#### Tautologies and Contradictions

**Why.** Some formulas are true or false purely because of their logical form, whatever their variables mean. These formulas are the "laws" of logic, and they are the basis of valid reasoning.

**What.**

| Kind | Definition | Example |
|---|---|---|
| Tautology | True under every assignment | `p ∨ ¬p` |
| Contradiction | False under every assignment | `p ∧ ¬p` |
| Contingency | True under some assignments, false under others | `p → q` |

Two dual facts connect them:

- `F` is a tautology if and only if `¬F` is a contradiction.
- `F` is a contradiction if and only if it is **unsatisfiable**, meaning no assignment makes it true.

Example: `((p → q) ∧ p) → q` is a tautology. It is the formal content of modus ponens (1.3).

| p | q | p → q | (p → q) ∧ p | ((p → q) ∧ p) → q |
|---|---|---|---|---|
| T | T | T | T | T |
| T | F | F | F | T |
| F | T | T | F | T |
| F | F | T | F | T |

**In code.** A condition that is a tautology makes its `else` branch dead code. A condition that is a contradiction makes its `if` branch dead code. Linters warn about these ("condition is always true").

```python
from itertools import product

def classify(n_vars, formula):
    results = {formula(*vals) for vals in product([True, False], repeat=n_vars)}
    if results == {True}:
        return "tautology"
    if results == {False}:
        return "contradiction"
    return "contingency"

implies = lambda a, b: (not a) or b
print(classify(2, lambda p, q: implies(implies(p, q) and p, q)))  # tautology
print(classify(1, lambda p: p and not p))                          # contradiction
print(classify(2, lambda p, q: implies(p, q)))                     # contingency
```

**Key takeaways**

- A tautology is always true, a contradiction is always false, and a contingency is neither.
- The negation of a tautology is a contradiction, and vice versa.
- Valid inference rules correspond to tautologies of the form `(premises) → conclusion`.
- In code, tautological or contradictory conditions signal dead branches or bugs.

> **Practice**
>
> 1. (Beginner) Classify: `p → ¬p`, `(p ∧ q) ∧ ¬(p ∨ q)`, `(p → q) ∨ (q → p)`.
> 2. (Intermediate) Show that `(p → q) ∧ (q → r) → (p → r)` is a tautology using a truth table with 8 rows.
> 3. (Interview) You have a fast function `is_satisfiable(formula)`. How would you use it to test whether a formula is a tautology? *Hint:* a formula is a tautology if no assignment makes it false.

#### Logical Equivalence

**Why.** We often want to replace a formula with a simpler or more convenient one without changing its meaning. In code, that is a safe refactoring of a condition. Logical equivalence is the guarantee that such a replacement is safe.

**What.** Formulas `A` and `B` are **logically equivalent**, written `A ≡ B`, if they have the same truth value under every assignment. Equivalently, `A ↔ B` is a tautology.

Note the difference: `↔` is a connective *inside* a formula, while `≡` is a claim *about* two formulas.

Example: `p → q ≡ ¬p ∨ q`

| p | q | p → q | ¬p | ¬p ∨ q |
|---|---|---|---|---|
| T | T | T | F | T |
| T | F | F | F | F |
| F | T | T | T | T |
| F | F | T | T | T |

The two final columns are identical, so the formulas are equivalent.

There are two ways to prove an equivalence:

1. **Truth table**: compare final columns (mechanical, exponential).
2. **Algebraic rewriting**: apply known laws step by step (see the next topic).

```python
from itertools import product

def equivalent(n_vars, f, g):
    """True iff f and g agree on every assignment."""
    return all(f(*v) == g(*v) for v in product([True, False], repeat=n_vars))

print(equivalent(2, lambda p, q: not (p and q), lambda p, q: (not p) or (not q)))  # True  (De Morgan)
print(equivalent(2, lambda p, q: not (p and q), lambda p, q: (not p) and (not q))) # False (common mistake)
```

```javascript
// Refactoring a guard with De Morgan: ¬(a ∧ b) ≡ ¬a ∨ ¬b
// Before
if (!(user.isActive && user.hasPaid)) { blockAccess(); }
// After: same behavior, reads as "inactive or unpaid"
if (!user.isActive || !user.hasPaid) { blockAccess(); }
```

**Key takeaways**

- `A ≡ B` means `A` and `B` agree on all assignments, i.e. `A ↔ B` is a tautology.
- `≡` is a statement about formulas, and `↔` is a connective inside a formula.
- Equivalence can be shown by truth tables or by chains of known laws.
- Equivalent conditions can be swapped in code without changing behavior.

> **Practice**
>
> 1. (Beginner) Verify with a truth table that `¬(p ∨ q) ≡ ¬p ∧ ¬q`.
> 2. (Intermediate) Decide whether each pair is equivalent: `p → (q → r)` vs `(p ∧ q) → r`; `(p → q) → r` vs `p → (q → r)`. Give a distinguishing assignment where they differ.
> 3. (Interview) Two engineers wrote different feature-flag conditions over 40 boolean settings. How would you determine whether the conditions are equivalent without enumerating 2⁴⁰ cases by hand? *Hint:* build a single formula that is satisfiable exactly when the two conditions disagree.

#### Laws of Propositional Logic

**Why.** Truth tables do not scale. A small set of proven equivalences lets us transform formulas algebraically, the same way we simplify `2x + 3x` to `5x`.

**What.** The standard laws (each can be verified by truth table):

| Law | Form(s) |
|---|---|
| Identity | `p ∧ T ≡ p`, `p ∨ F ≡ p` |
| Domination | `p ∨ T ≡ T`, `p ∧ F ≡ F` |
| Idempotent | `p ∨ p ≡ p`, `p ∧ p ≡ p` |
| Double negation | `¬(¬p) ≡ p` |
| Commutative | `p ∨ q ≡ q ∨ p`, `p ∧ q ≡ q ∧ p` |
| Associative | `(p ∨ q) ∨ r ≡ p ∨ (q ∨ r)`, same for `∧` |
| Distributive | `p ∨ (q ∧ r) ≡ (p ∨ q) ∧ (p ∨ r)`, `p ∧ (q ∨ r) ≡ (p ∧ q) ∨ (p ∧ r)` |
| De Morgan | `¬(p ∧ q) ≡ ¬p ∨ ¬q`, `¬(p ∨ q) ≡ ¬p ∧ ¬q` |
| Absorption | `p ∨ (p ∧ q) ≡ p`, `p ∧ (p ∨ q) ≡ p` |
| Negation (complement) | `p ∨ ¬p ≡ T`, `p ∧ ¬p ≡ F` |
| Conditional | `p → q ≡ ¬p ∨ q` |
| Contrapositive | `p → q ≡ ¬q → ¬p` |
| Biconditional | `p ↔ q ≡ (p → q) ∧ (q → p)` |
| Exportation | `(p ∧ q) → r ≡ p → (q → r)` |

**Duality.** Swapping `∧`/`∨` and `T`/`F` in any law gives another law. This is why most laws come in pairs.

Worked simplification: `¬(p ∨ (¬p ∧ q))`

```text
¬(p ∨ (¬p ∧ q))
≡ ¬p ∧ ¬(¬p ∧ q)          De Morgan
≡ ¬p ∧ (¬¬p ∨ ¬q)         De Morgan
≡ ¬p ∧ (p ∨ ¬q)           Double negation
≡ (¬p ∧ p) ∨ (¬p ∧ ¬q)    Distributive
≡ F ∨ (¬p ∧ ¬q)           Negation
≡ ¬p ∧ ¬q                 Identity
```

Proving a tautology algebraically: `(p ∧ q) → (p ∨ q)`

```text
(p ∧ q) → (p ∨ q)
≡ ¬(p ∧ q) ∨ (p ∨ q)      Conditional
≡ (¬p ∨ ¬q) ∨ (p ∨ q)     De Morgan
≡ (¬p ∨ p) ∨ (¬q ∨ q)     Associative + commutative
≡ T ∨ T                   Negation
≡ T                       Domination
```

Computer algebra systems apply these laws automatically:

```python
from sympy import symbols
from sympy.logic.boolalg import simplify_logic

p, q = symbols("p q")
print(simplify_logic(~(p | (~p & q))))   # ~p & ~q   (matches the manual derivation)
print(simplify_logic((p & q) >> (p | q)))  # True      (">>" is implication in SymPy)
```

**Key takeaways**

- About a dozen laws suffice for most algebraic manipulation of formulas.
- De Morgan, distributive, and conditional laws are the most frequently used.
- Laws come in dual pairs (swap `∧`/`∨` and `T`/`F`).
- Justify each rewriting step by naming the law used.

> **Practice**
>
> 1. (Beginner) Simplify `(p ∧ q) ∨ (p ∧ ¬q)` using the laws, naming each step.
> 2. (Intermediate) Show algebraically that `¬(p → q) ≡ p ∧ ¬q`, and that `(p → q) ∧ (p → r) ≡ p → (q ∧ r)`.
> 3. (Interview) Simplify this Python guard and justify each step: `if not (user is None or not user.active): ...` *Hint:* apply De Morgan, then double negation.

#### Normal Forms (CNF and DNF)

**Why.** Many algorithms, including SAT solvers, circuit synthesizers and theorem provers, need formulas in a predictable, uniform shape. Normal forms supply that shape, and every formula can be converted into them.

**Vocabulary.**

- A **literal** is a variable or its negation: `p`, `¬q`.
- A **clause** is a disjunction of literals: `(p ∨ ¬q ∨ r)`.
- A **term** is a conjunction of literals: `(p ∧ ¬q ∧ r)`.

| Form | Shape | Example | Easy to check |
|---|---|---|---|
| **DNF** (disjunctive normal form) | OR of ANDs | `(p ∧ ¬q) ∨ (¬p ∧ q)` | Satisfiability: one consistent term suffices |
| **CNF** (conjunctive normal form) | AND of ORs | `(p ∨ q) ∧ (¬p ∨ ¬q)` | Validity: every clause must contain some `x` and `¬x` |

**From a truth table.**

- **DNF:** for each row where the formula is **T**, write a term that matches that row exactly (a *minterm*), then OR them together.
- **CNF:** for each row where the formula is **F**, write a clause that rules out that row (a *maxterm*), then AND them together.

Example for `p ⊕ q` (true on rows TF and FT, false on TT and FF):

```text
DNF: (p ∧ ¬q) ∨ (¬p ∧ q)        one term per TRUE row
CNF: (¬p ∨ ¬q) ∧ (p ∨ q)        clause (¬p ∨ ¬q) rules out TT; (p ∨ q) rules out FF
```

**Algebraic conversion.**

1. Eliminate `↔` and `→` using the biconditional and conditional laws.
2. Push negations inward with De Morgan and double negation, until `¬` applies only to variables (negation normal form).
3. Distribute: `∨` over `∧` for CNF, or `∧` over `∨` for DNF.

Example: `¬(p → q) ∨ r`

```text
¬(p → q) ∨ r
≡ ¬(¬p ∨ q) ∨ r            Conditional
≡ (p ∧ ¬q) ∨ r             De Morgan + double negation   <- already DNF
≡ (p ∨ r) ∧ (¬q ∨ r)       Distribute ∨ over ∧           <- CNF
```

**Size warning.** Distribution can blow up exponentially. For example, `(a₁ ∧ b₁) ∨ ... ∨ (aₙ ∧ bₙ)` has `2ⁿ` clauses in CNF. The **Tseitin transformation** avoids this by introducing helper variables. It produces a CNF of linear size that is *equisatisfiable* (satisfiable exactly when the original is), though not equivalent.

```python
from itertools import product

def to_dnf(variables, formula):
    """Build a DNF string from the truth table: one minterm per true row."""
    terms = []
    for values in product([True, False], repeat=len(variables)):
        if formula(*values):                                     # keep only rows where it is true
            literals = [v if val else "¬" + v for v, val in zip(variables, values)]
            terms.append("(" + " ∧ ".join(literals) + ")")
    return " ∨ ".join(terms) if terms else "F"                   # no true rows: contradiction

def to_cnf(variables, formula):
    """Build a CNF string from the truth table: one clause per false row."""
    clauses = []
    for values in product([True, False], repeat=len(variables)):
        if not formula(*values):
            literals = ["¬" + v if val else v for v, val in zip(variables, values)]  # flip each literal
            clauses.append("(" + " ∨ ".join(literals) + ")")
    return " ∧ ".join(clauses) if clauses else "T"

print(to_dnf(["p", "q"], lambda p, q: p != q))  # (p ∧ ¬q) ∨ (¬p ∧ q)
print(to_cnf(["p", "q"], lambda p, q: p != q))  # (¬p ∨ ¬q) ∧ (p ∨ q)
```

**Key takeaways**

- DNF is an OR of ANDs and CNF is an AND of ORs. Every formula has both forms.
- DNF comes from the true rows of the truth table, and CNF from the false rows.
- To convert algebraically, eliminate `→`/`↔`, push `¬` inward, then distribute.
- Naive conversion can be exponential. Tseitin gives a linear-size equisatisfiable CNF.

> **Practice**
>
> 1. (Beginner) Convert `p ↔ q` to both DNF and CNF.
> 2. (Intermediate) Convert `(p ∨ q) → r` to CNF algebraically, naming each law used.
> 3. (Interview) SAT solvers take CNF input. Satisfiability of a DNF formula can be checked in linear time. Why does "convert to DNF, then check" not solve SAT efficiently? *Hint:* think about the size of the DNF relative to the original CNF.

#### Satisfiability

**Why.** Many practical problems reduce to one question: "Is there an assignment that makes all these constraints true?" Scheduling, package dependency resolution, hardware verification, test generation and Sudoku can all be phrased this way.

**What.** A formula is **satisfiable** if at least one assignment makes it true. That assignment is a **model** or **witness**. Otherwise the formula is **unsatisfiable**. SAT ties together several earlier ideas:

- `F` is a tautology if and only if `¬F` is unsatisfiable.
- `F ≡ G` if and only if `F ⊕ G` is unsatisfiable.
- An argument is valid if and only if `premises ∧ ¬conclusion` is unsatisfiable.

**Complexity.** SAT was the first problem proven **NP-complete** (Cook–Levin theorem, 1971). No known algorithm solves every instance in polynomial time.

| Variant | Clause restriction | Complexity |
|---|---|---|
| 2-SAT | At most 2 literals per clause | Polynomial (implication graph + SCCs) |
| Horn-SAT | At most 1 positive literal per clause | Polynomial (unit propagation) |
| 3-SAT | At most 3 literals per clause | NP-complete |
| General CNF-SAT | Any clauses | NP-complete |

Modern **CDCL** solvers handle instances with millions of variables in practice. They build on the **DPLL** algorithm:

- **Unit propagation**: a clause with a single unassigned literal forces that literal.
- **Branching**: pick a variable, try `T`, and backtrack to `F` on conflict.

```python
def dpll(clauses, assignment=None):
    """Clauses are lists of non-zero ints (DIMACS style): k means x_k, -k means ¬x_k.
    Returns a satisfying assignment {var: bool} or None if unsatisfiable."""
    if assignment is None:
        assignment = {}
    simplified = []
    for clause in clauses:
        if any(assignment.get(abs(l)) == (l > 0) for l in clause):
            continue                                   # clause already satisfied
        remaining = [l for l in clause if abs(l) not in assignment]
        if not remaining:
            return None                                # every literal false: conflict
        simplified.append(remaining)
    if not simplified:
        return assignment                              # all clauses satisfied
    for clause in simplified:                          # unit propagation
        if len(clause) == 1:
            lit = clause[0]
            return dpll(simplified, {**assignment, abs(lit): lit > 0})
    var = abs(simplified[0][0])                        # branch on an unassigned variable
    for value in (True, False):
        result = dpll(simplified, {**assignment, var: value})
        if result is not None:
            return result
    return None                                        # both branches failed

# (x1 ∨ x2) ∧ (¬x1 ∨ x3) ∧ (¬x2 ∨ ¬x3) ∧ ¬x3
print(dpll([[1, 2], [-1, 3], [-2, -3], [-3]]))  # {3: False, 1: False, 2: True}
print(dpll([[1], [-1]]))                         # None (x1 ∧ ¬x1)
```

**Encoding constraints.** "Exactly one of `a, b, c`" in CNF is "at least one" plus "no two":

```text
(a ∨ b ∨ c) ∧ (¬a ∨ ¬b) ∧ (¬a ∨ ¬c) ∧ (¬b ∨ ¬c)
```

**Key takeaways**

- Satisfiable means at least one assignment makes the formula true.
- Validity, equivalence, and argument checking all reduce to (un)satisfiability.
- SAT is NP-complete in general, but 2-SAT and Horn-SAT are polynomial.
- DPLL/CDCL solvers use unit propagation and backtracking, and are very effective in practice.

> **Practice**
>
> 1. (Beginner) Is `(p ∨ q) ∧ (¬p ∨ q) ∧ (p ∨ ¬q) ∧ (¬p ∨ ¬q)` satisfiable? Justify without a full truth table.
> 2. (Intermediate) Encode "at most one of `a, b, c, d` is true" in CNF. How many clauses does the pairwise encoding need for `n` variables?
> 3. (Interview) A package manager must install `app`, which needs `lib >= 2` or `compat`. `lib 2` conflicts with `ssl 1`, and `compat` requires `ssl 1`. Model this as a SAT instance. *Hint:* one boolean variable per (package, version), with clauses for "requires", "conflicts", and "only one version per package".

<a id="12-predicate-logic"></a>
### 1.2 Predicate Logic

Propositional logic cannot look inside a statement. Predicate logic adds variables, predicates, and quantifiers, so that we can make claims about "all" or "some" objects in a collection.

#### Predicates and Domains

**Why.** Consider: "All humans are mortal. Socrates is human. Therefore Socrates is mortal." In propositional logic these are three unrelated propositions `p`, `q`, `r`, and nothing connects them. The argument is valid because of the *internal* structure (human, mortal, Socrates), so we need a logic that can express that structure.

**What.**

- A **predicate** `P(x)` is a statement containing variables. It becomes a proposition once every variable is given a value. `P(x)` is called the *propositional function* evaluated at `x`.
- The **domain** (universe of discourse) is the set of values the variables may take.
- Predicates can take several arguments: `L(x, y)`: "x < y" is a 2-place predicate.
- The **truth set** of `P` is `{x ∈ D | P(x) is true}`.

**Analogy.** A predicate is a function that returns a boolean. The domain is its parameter type.

**The domain matters.** The same predicate can behave differently over different domains:

| Predicate | Domain | Is it true for every `x`? |
|---|---|---|
| `x² ≥ x` | Integers ℤ | Yes |
| `x² ≥ x` | Reals ℝ | No (`x = 0.5`) |
| `x² = 2` has a solution | Rationals ℚ | No |
| `x² = 2` has a solution | Reals ℝ | Yes (`x = √2`) |

```python
def P(x):                  # P(x): "x squared is at least x"
    return x * x >= x

print(P(3), P(-2), P(0))   # True True True  -- each call yields a proposition
print(P(0.5))              # False: 0.25 >= 0.5 fails, so the claim fails over the reals

def L(x, y):               # 2-place predicate L(x, y): "x < y"
    return x < y

truth_set = {x for x in range(-10, 11) if x * x == 4}
print(truth_set)           # {-2, 2}: truth set of "x² = 4" over the integers -10..10
```

**Key takeaways**

- A predicate is a statement with variables. Assigning the variables yields a proposition.
- The domain must always be specified, because truth can change with it.
- Predicates can have any number of arguments.
- The truth set collects the domain elements that satisfy the predicate.

> **Practice**
>
> 1. (Beginner) Let `P(x)`: "x² > 10" over the integers. Find the truth values of `P(3)`, `P(-4)`, `P(0)`.
> 2. (Intermediate) Give the truth set of `Q(x)`: "x² = x" over ℕ, ℤ, and ℝ. Then find a predicate whose truth set is empty over ℝ but non-empty over ℂ.
> 3. (Interview) In SQL, `SELECT * FROM users WHERE age >= 18 AND country = 'IT'` returns a truth set. Identify the predicate, its domain, and its arguments. How does `NULL` complicate the "two truth values" assumption? *Hint:* SQL uses three-valued logic. Look up what `NULL = NULL` evaluates to.

#### Universal and Existential Quantifiers

**Why.** Predicates let us talk about individual objects. Quantifiers let us talk about *collections* of objects: "every user has an email" or "some request timed out".

**What.**

| Statement | Read as | True when | False when |
|---|---|---|---|
| `∀x P(x)` | for all x, P(x) | `P(x)` holds for every `x` in the domain | some `x` fails: a **counterexample** |
| `∃x P(x)` | there exists x such that P(x) | `P(x)` holds for at least one `x`: a **witness** | `P(x)` fails for every `x` |
| `∃!x P(x)` | there exists a unique x | exactly one `x` satisfies `P` | zero or at least two do |

**Finite domains.** If `D = {a₁, …, aₙ}`, then

```text
∀x P(x)  ≡  P(a₁) ∧ P(a₂) ∧ … ∧ P(aₙ)      (a big AND)
∃x P(x)  ≡  P(a₁) ∨ P(a₂) ∨ … ∨ P(aₙ)      (a big OR)
```

**Empty domain.** `∀x P(x)` is vacuously true, because there is nothing to fail. `∃x P(x)` is false, because there is nothing to witness it. This matches the identities of `∧` (empty AND = T) and `∨` (empty OR = F).

**Restricted quantifiers.** "For all positive x" and "for some positive x" translate differently:

```text
∀x > 0, P(x)   ≡   ∀x (x > 0 → P(x))     universal pairs with →
∃x > 0, P(x)   ≡   ∃x (x > 0 ∧ P(x))     existential pairs with ∧
```

Mixing these up is a classic error. `∃x (Student(x) → Smart(x))` is true as soon as *any non-student* exists, so it does not say what was intended.

**Precedence.** Quantifiers bind more tightly than all connectives. `∀x P(x) ∨ Q(x)` means `(∀x P(x)) ∨ Q(x)`.

```python
D = [1, 2, 3, 4]

print(all(x < 5 for x in D))               # ∀x (x < 5)                  -> True
print(any(x % 3 == 0 for x in D))          # ∃x (3 divides x)            -> True (witness: 3)
print(sum(1 for x in D if x % 2 == 0) == 1)  # ∃!x (x is even)          -> False (2 and 4)

print(all(x > 10 for x in []))             # ∀ over empty domain -> True (vacuous)
print(any(x > 10 for x in []))             # ∃ over empty domain -> False

# Restricted quantifier: "every even element is greater than 1"
print(all((x % 2 != 0) or (x > 1) for x in D))  # ∀x (Even(x) → x > 1) -> True
```

**Key takeaways**

- `∀` asserts something about every element, and one counterexample refutes it.
- `∃` asserts at least one element, and one witness proves it.
- Over finite domains, `∀` is a big AND and `∃` is a big OR. Python's `all`/`any` match them exactly, including on empty input.
- Pair `∀` with `→` and `∃` with `∧` when restricting the domain.

> **Practice**
>
> 1. (Beginner) Over the domain `{1, 2, 3, 4}`, find the truth values of `∀x (x² ≤ 16)`, `∃x (x² = 9)`, and `∀x (x is prime)`.
> 2. (Intermediate) Explain why `∃x (Student(x) → Smart(x))` is a wrong translation of "Some student is smart", and give a domain where it is true but the English sentence is false.
> 3. (Interview) Why does `all([])` return `True` in Python, and why is that the right design choice? *Hint:* think of `all` as a fold over `and`, starting from an identity element.

#### Nested Quantifiers

**Why.** Interesting statements usually involve several quantified variables: "every element has a larger element", or "for every ε there is a δ". The *order* of the quantifiers changes the meaning in ways that are easy to miss.

**What.** Quantifiers are read left to right, and each one is in the scope of those before it. A useful way to evaluate them is as a **game**:

- For `∀`, an adversary picks the value and tries to make the statement fail.
- For `∃`, you pick the value and try to make it hold.
- A later choice may depend on the earlier ones.

```text
∀x ∃y (x + y = 0)   over ℤ:   adversary picks x, then you pick y = -x       -> TRUE
∃y ∀x (x + y = 0)   over ℤ:   you must pick one y before seeing x           -> FALSE
```

**Analogy.** "Everyone has a mother" (`∀x ∃y Mother(y, x)`) is very different from "There is someone who is everyone's mother" (`∃y ∀x Mother(y, x)`).

Quantifiers of the **same type** can be swapped freely: `∀x ∀y ≡ ∀y ∀x` and `∃x ∃y ≡ ∃y ∃x`. Quantifiers of **different types** generally cannot.

All two-variable combinations for `L(x, y)`: "x likes y":

| Formula | Meaning |
|---|---|
| `∀x ∀y L(x, y)` | Everyone likes everyone |
| `∀x ∃y L(x, y)` | Everyone likes someone (possibly different people) |
| `∃y ∀x L(x, y)` | There is one person whom everyone likes |
| `∃x ∀y L(x, y)` | Someone likes everyone |
| `∀y ∃x L(x, y)` | Everyone is liked by someone |
| `∃x ∃y L(x, y)` | Someone likes someone |

One direction of swapping is always valid: `∃y ∀x P(x, y) → ∀x ∃y P(x, y)`. If one `y` works for every `x`, then each `x` has a `y`. The converse is false in general.

**In code.** Nested quantifiers are nested loops. `∀x ∃y` becomes an `all` wrapping an `any`. Evaluating `k` nested quantifiers over a domain of size `n` costs `O(nᵏ)`.

```python
D = range(-5, 6)

# ∀x ∃y (x + y = 0): y may depend on x
print(all(any(x + y == 0 for y in D) for x in D))   # True

# ∃y ∀x (x + y = 0): a single y must work for all x
print(any(all(x + y == 0 for x in D) for y in D))   # False

# "A has no duplicates": ∀i ∀j (i ≠ j → A[i] ≠ A[j])
A = [3, 1, 4, 1, 5]
no_dups = all(i == j or A[i] != A[j] for i in range(len(A)) for j in range(len(A)))
print(no_dups)                                      # False: A[1] == A[3]
```

**Key takeaways**

- Quantifiers are read left to right, and later variables may depend on earlier ones.
- Swapping quantifiers of the same type is safe. Swapping `∀` and `∃` generally is not.
- `∃y ∀x` implies `∀x ∃y`, but not the reverse.
- In code, nested quantifiers become nested `all`/`any` loops.

> **Practice**
>
> 1. (Beginner) Over ℤ, find the truth values of `∀x ∃y (y > x)` and `∃y ∀x (y > x)`.
> 2. (Intermediate) Find the truth value of `∀x ∀y ∃z (z = (x + y) / 2)` over ℤ and over ℝ. Explain the difference.
> 3. (Interview) Express "array `A` is sorted in non-decreasing order" with quantifiers in two ways: one with two index variables and one comparing only adjacent elements. Which gives the faster check, and why are they equivalent? *Hint:* the adjacent version needs transitivity of `≤`.

#### Negating Quantified Statements

**Why.** To disprove a claim, or to write the failure condition of a check, you need its exact negation. Negating quantified statements by intuition goes wrong surprisingly often.

**What.** **De Morgan's laws for quantifiers:**

```text
¬∀x P(x)  ≡  ∃x ¬P(x)       "not everything satisfies P" = "something fails P"
¬∃x P(x)  ≡  ∀x ¬P(x)       "nothing satisfies P"        = "everything fails P"
```

Over a finite domain, these are the ordinary De Morgan laws applied to the big AND and big OR.

**Nested quantifiers:** push `¬` inward one quantifier at a time, flipping each `∀ ↔ ∃`, and negate the predicate at the end.

```text
¬∀x ∃y (x + y = 0)
≡ ∃x ¬∃y (x + y = 0)
≡ ∃x ∀y (x + y ≠ 0)
```

**Negating a restricted universal** gives the shape of every counterexample:

```text
¬∀x (P(x) → Q(x))  ≡  ∃x ¬(P(x) → Q(x))  ≡  ∃x (P(x) ∧ ¬Q(x))
```

A counterexample is an element that satisfies the hypothesis but violates the conclusion.

| English claim | Correct negation | Common wrong negation |
|---|---|---|
| All birds can fly | Some bird cannot fly | No bird can fly |
| Some test failed | No test failed (all passed) | Some test passed |
| `f` is bounded: `∃M ∀x (\|f(x)\| ≤ M)` | `∀M ∃x (\|f(x)\| > M)` | `∃M ∀x (\|f(x)\| > M)` |

```python
data = [3, 8, 1, 9]

# ¬∀x P(x) ≡ ∃x ¬P(x)
assert (not all(x > 2 for x in data)) == any(not (x > 2) for x in data)

# The useful part of the negation is the witness: the element that breaks the claim
witness = next((x for x in data if not x > 2), None)
print(witness)  # 1
```

**Key takeaways**

- `¬∀ ≡ ∃¬` and `¬∃ ≡ ∀¬`.
- For nested quantifiers, flip every quantifier while pushing the negation inward.
- `¬∀x (P → Q) ≡ ∃x (P ∧ ¬Q)`: a counterexample satisfies the hypothesis and violates the conclusion.
- "Not all" is not the same as "none".

> **Practice**
>
> 1. (Beginner) Negate and simplify so that no `¬` stands in front of a quantifier: `∀x (x² ≥ 0)`, `∃x (x² = -1)`.
> 2. (Intermediate) Negate the definition of continuity at 0: `∀ε > 0 ∃δ > 0 ∀x (|x| < δ → |f(x)| < ε)`. Remember the restricted quantifiers.
> 3. (Interview) A test asserts `all(is_valid(r) for r in records)` and fails. What does the negation tell you the failure message should contain to be useful? *Hint:* the negation is an existential statement. What object does it promise exists?

#### Bound and Free Variables

**Why.** In `∀x P(x, y)`, the `x` and the `y` play different roles. Telling them apart is necessary to know whether a formula is a proposition, and to substitute values without changing the meaning. Programming has the same issue with variable scope.

**What.**

- A variable occurrence is **bound** if it falls within the scope of a quantifier on that variable.
- Otherwise it is **free**.
- The **scope** of a quantifier is the subformula it applies to.
- A formula with no free variables is a **closed formula** (a sentence), and it is a proposition.
- A formula with free variables is a predicate on those variables.

The same name can be free in one place and bound in another:

```text
∀x ( P(x, y) ∧ ∃y Q(x, y) ) ∨ R(x)
   └──── scope of ∀x ─────┘
               └── ∃y ──┘

x in P(x, y) and Q(x, y): bound by ∀x
x in R(x):                FREE (outside the scope of ∀x)
y in P(x, y):             FREE (not inside ∃y)
y in Q(x, y):             bound by ∃y
```

**Renaming (α-equivalence).** A bound variable can be renamed consistently without changing the meaning: `∀x P(x) ≡ ∀z P(z)`. Rename bound variables to avoid clashes like the one above:

```text
∀w ( P(w, y) ∧ ∃v Q(w, v) ) ∨ R(x)       same meaning; now each name plays one role
```

Free variables (`y` and the last `x`) must *not* be renamed. They are the formula's parameters, and renaming them changes what the formula says.

**Analogy.** Bound variables are like function parameters and local variables, whose names do not matter outside the function. Free variables are like globals or closure captures, whose values come from the surrounding context.

```python
y = 10                            # outer context supplies the free variable y

def f(x):                         # x is bound (a parameter): renaming it changes nothing
    return x + y                  # y is free in the body: its value comes from outside

g = lambda x: (lambda y: x + y)   # inner y is bound by the inner lambda; x is free in it
print(f(1), g(1)(2))              # 11 3
```

**Key takeaways**

- Bound variables are inside the scope of a matching quantifier. Free variables are not.
- A formula is a proposition only if it has no free variables.
- Bound variables can be renamed consistently without changing the meaning.
- Rename bound variables before substituting, to avoid accidentally capturing a free variable.

> **Practice**
>
> 1. (Beginner) Identify every free and bound occurrence in `∃x (P(x) ∧ ∀y Q(x, y, z))`.
> 2. (Intermediate) Rewrite `∀x (P(x) → ∃x Q(x))` so that no variable name is quantified twice. Is the result equivalent?
> 3. (Interview) Substituting `y := x` into `∃x (x > y)` naively gives `∃x (x > x)`, which is false, although the original is true for every `y` over ℤ. Explain what went wrong and how compilers and theorem provers avoid it. *Hint:* search for "capture-avoiding substitution".

#### Translating English to Logic

**Why.** Specifications, requirements, and theorems start in natural language. Translating them precisely exposes ambiguity and makes them checkable, by a proof or by code.

**How.**

1. Fix the **domain**. A broad domain plus restricting predicates is often simplest.
2. Define **predicates** with explicit meaning, such as `S(x)`: "x is a student".
3. Identify the **quantifiers** ("every", "some", "no", "only") and their order.
4. Apply the standard patterns, then reread the result as English to check it.

| English | Logic |
|---|---|
| All A are B | `∀x (A(x) → B(x))` |
| Some A are B | `∃x (A(x) ∧ B(x))` |
| No A are B | `∀x (A(x) → ¬B(x))` ≡ `¬∃x (A(x) ∧ B(x))` |
| Not all A are B | `∃x (A(x) ∧ ¬B(x))` |
| Only A are B | `∀x (B(x) → A(x))` |
| Every A has some B-related y | `∀x (A(x) → ∃y R(x, y))` |

Worked example: "Every student in the class has a friend in the class who has taken a programming course."

```text
Domain: all people
C(x): x is in the class      F(x, y): x and y are friends      P(y): y took a programming course

∀x ( C(x) → ∃y ( C(y) ∧ F(x, y) ∧ P(y) ) )
```

**Ambiguity check.** "Everybody loves somebody" could mean `∀x ∃y L(x, y)` or `∃y ∀x L(x, y)`. Choose deliberately, and state your reading.

The same discipline applies to data constraints. A foreign key is a nested quantified statement, and the query that finds violations is its negation:

```python
# ∀o ∈ Orders ∃c ∈ Customers (o.customer_id = c.id)
customers = [{"id": 1}, {"id": 2}]
orders = [{"id": 10, "customer_id": 1}, {"id": 11, "customer_id": 7}]

customer_ids = {c["id"] for c in customers}
print(all(o["customer_id"] in customer_ids for o in orders))  # False
```

```sql
-- Negation: ∃o ∈ Orders ∀c ∈ Customers (o.customer_id ≠ c.id)
SELECT o.*
FROM orders o
WHERE NOT EXISTS (SELECT 1 FROM customers c WHERE c.id = o.customer_id);  -- returns order 11
```

**Key takeaways**

- Fix the domain and define predicates explicitly before translating.
- "All" pairs with `→`, "some" pairs with `∧`, and "only A are B" reverses the direction of the implication.
- Ambiguous English often hides a quantifier-order choice. Resolve it explicitly.
- Integrity constraints are quantified formulas, and their violations are the negations.

> **Practice**
>
> 1. (Beginner) Translate, with domain "all animals": "Every dog is a mammal." "Some mammals are not dogs." "No cat is a dog."
> 2. (Intermediate) Translate: "Only admins can delete posts." "Every user has exactly one primary email address." (Use `∃!` or expand it into `∃` and `∀`.)
> 3. (Interview) Translate "there is a server that can reach every database" and "every database is reachable from some server". Which one implies the other? Write a query or function that checks the stronger one. *Hint:* look at the quantifier order in each statement.

<a id="13-rules-of-inference"></a>
### 1.3 Rules of Inference

Rules of inference are small reasoning steps that have each been verified once and for all. Every valid argument, however long, can be built by chaining them.

#### Valid Arguments

**Why.** A truth table can check whether a single formula is a tautology. A mathematical argument, though, is a *sequence* of statements leading to a conclusion. We need a precise criterion for when the conclusion really follows from the premises.

**What.** An **argument** is a list of **premises** `p₁, …, pₙ` and a **conclusion** `c`, written `p₁, …, pₙ ⊢ c` or as:

```text
p₁
p₂
…
pₙ
───
∴ c
```

The argument is **valid** if, whenever all premises are true, the conclusion is also true. Equivalently:

```text
(p₁ ∧ p₂ ∧ … ∧ pₙ) → c    is a tautology
```

To refute validity, find a **critical row**: an assignment that makes every premise true and the conclusion false.

**Validity vs soundness.** Validity concerns *form* only. An argument is **sound** if it is valid **and** all its premises are actually true. Only a sound argument guarantees a true conclusion.

| Argument | Valid? | Sound? |
|---|---|---|
| All cats can fly. Tom is a cat. ∴ Tom can fly. | Yes | No (false premise) |
| If n is even, n² is even. 4 is even. ∴ 16 is even. | Yes | Yes |
| If it rains, the street is wet. The street is wet. ∴ It rained. | No | No |

A valid argument can have a false conclusion (when a premise is false). An invalid argument can have a true conclusion by luck.

```python
from itertools import product

def is_valid(n_vars, premises, conclusion):
    """Return (True, None) if valid, else (False, critical_row)."""
    for values in product([True, False], repeat=n_vars):
        if all(p(*values) for p in premises) and not conclusion(*values):
            return False, values                 # premises all true, conclusion false
    return True, None

imp = lambda a, b: (not a) or b

# p → q, q → r  ⊢  p → r      (hypothetical syllogism)
print(is_valid(3, [lambda p, q, r: imp(p, q), lambda p, q, r: imp(q, r)],
                  lambda p, q, r: imp(p, r)))    # (True, None)

# p → q, q  ⊢  p              (affirming the consequent)
print(is_valid(2, [lambda p, q: imp(p, q), lambda p, q: q],
                  lambda p, q: p))               # (False, (False, True))
```

**Key takeaways**

- An argument is valid when the premises cannot all be true while the conclusion is false.
- Validity is equivalent to `(premises) → conclusion` being a tautology, or to `premises ∧ ¬conclusion` being unsatisfiable.
- A critical row (all premises T, conclusion F) proves invalidity.
- Sound means valid with true premises. Only soundness guarantees a true conclusion.

> **Practice**
>
> 1. (Beginner) Use a truth table to decide whether `p ∨ q, ¬p ⊢ q` is valid.
> 2. (Intermediate) Decide validity and give a critical row if invalid: `p → q, ¬p ⊢ ¬q`; `p → (q ∨ r), ¬q, ¬r ⊢ ¬p`.
> 3. (Interview) "All 1,200 tests pass; if the code is correct, all tests pass; therefore the code is correct." Is this valid? Rewrite it as a valid argument, and say which premise you would then have to defend. *Hint:* the direction of the implication matters.

#### Modus Ponens and Modus Tollens

**Why.** Checking validity with truth tables is exponential. Instead, we build arguments from a small set of rules that are each known to be valid. Modus ponens and modus tollens are the two most important.

**What.**

| Rule | Premises | Conclusion | Underlying tautology |
|---|---|---|---|
| Modus ponens (MP) | `p → q`, `p` | `q` | `((p → q) ∧ p) → q` |
| Modus tollens (MT) | `p → q`, `¬q` | `¬p` | `((p → q) ∧ ¬q) → ¬p` |
| Conjunction | `p`, `q` | `p ∧ q` | `(p ∧ q) → (p ∧ q)` |
| Simplification | `p ∧ q` | `p` | `(p ∧ q) → p` |
| Addition | `p` | `p ∨ q` | `p → (p ∨ q)` |

- **Modus ponens** ("mode that affirms"): the rule is known and its condition holds, so the result holds. This is forward reasoning.
- **Modus tollens** ("mode that denies"): the rule is known and its result is missing, so the condition did not hold. This is backward reasoning, and it is the logic of debugging.

**Formal derivation.** Each line is a premise or follows from earlier lines by a named rule.

```text
Premises: p → q,  q → r,  ¬r.        Goal: ¬p

1. p → q        premise
2. q → r        premise
3. ¬r           premise
4. ¬q           MT 2, 3
5. ¬p           MT 1, 4
```

**MT in debugging.** "If the config loaded, the log contains `ready`. The log does not contain `ready`. Therefore the config did not load." This is valid. The opposite inference, seeing `ready` and concluding that the config loaded, is a fallacy (affirming the consequent) unless the converse rule is independently known.

**In code.** Rule engines and expert systems repeatedly apply modus ponens (forward chaining):

```python
def forward_chain(facts, rules):
    """rules: list of (set_of_premises, conclusion). Apply modus ponens until nothing changes."""
    facts = set(facts)
    changed = True
    while changed:
        changed = False
        for premises, conclusion in rules:
            if premises <= facts and conclusion not in facts:  # all premises already known
                facts.add(conclusion)                          # modus ponens step
                changed = True
    return facts

rules = [
    ({"rain"}, "wet_ground"),
    ({"wet_ground", "freezing"}, "ice"),
    ({"ice"}, "slippery"),
]
print(forward_chain({"rain", "freezing"}, rules))
# {'rain', 'freezing', 'wet_ground', 'ice', 'slippery'}   (set order may vary)
```

**Key takeaways**

- MP: from `p → q` and `p`, infer `q`. MT: from `p → q` and `¬q`, infer `¬p`.
- Each rule of inference corresponds to a tautology, which is what makes it valid.
- Formal derivations cite a rule and line numbers for every step.
- Forward chaining in rule engines is repeated modus ponens.

> **Practice**
>
> 1. (Beginner) Name the rule: from "If it snows, school closes" and "School is open", infer "It is not snowing".
> 2. (Intermediate) Derive `s` from the premises `p ∧ q`, `p → r`, `r → s`, citing a rule for each line.
> 3. (Interview) "If the cache is warm, responses take under 50 ms." A response took 200 ms. What can you conclude? What can you conclude if a response took 30 ms? *Hint:* one case is modus tollens. The other tempts you into a fallacy covered later in this subchapter.

#### Syllogisms

**Why.** Much reasoning chains conditions ("this leads to that, which leads to something else") or eliminates alternatives ("it is either A or B, and it is not A"). Syllogisms formalize both patterns.

**What.**

| Rule | Premises | Conclusion | Intuition |
|---|---|---|---|
| Hypothetical syllogism | `p → q`, `q → r` | `p → r` | Implications chain (transitivity) |
| Disjunctive syllogism | `p ∨ q`, `¬p` | `q` | Process of elimination |
| Constructive dilemma | `p → q`, `r → s`, `p ∨ r` | `q ∨ s` | Each alternative leads somewhere |

**Categorical syllogisms.** Aristotle's syllogisms relate classes of things, for example "All M are P; all S are M; therefore all S are P". They are valid because class inclusion is transitive:

```text
+------------------------- P: mortal --------+
|   +------------------ M: human --------+   |
|   |   +------- S: Greek -------+       |   |
|   |   |       * Socrates       |       |   |
|   |   +------------------------+       |   |
|   +------------------------------------+   |
+--------------------------------------------+
```

**Implications as a graph.** If each `a → b` is a directed edge, hypothetical syllogism says `x → y` is derivable exactly when `y` is reachable from `x`. This is the core idea behind the polynomial-time 2-SAT algorithm.

```python
from collections import defaultdict, deque

def follows(implications, start, goal):
    """Is start → goal derivable by chaining (hypothetical syllogism)? BFS reachability."""
    graph = defaultdict(list)
    for a, b in implications:
        graph[a].append(b)
    seen, queue = {start}, deque([start])
    while queue:
        node = queue.popleft()
        if node == goal:
            return True
        for nxt in graph[node]:
            if nxt not in seen:
                seen.add(nxt)
                queue.append(nxt)
    return False

imps = [("p", "q"), ("q", "r"), ("r", "s"), ("t", "q")]
print(follows(imps, "p", "s"))  # True:  p → q → r → s
print(follows(imps, "s", "p"))  # False: implications do not run backwards
```

**Key takeaways**

- Hypothetical syllogism chains implications: `p → q`, `q → r` give `p → r`.
- Disjunctive syllogism eliminates an alternative: `p ∨ q`, `¬p` give `q`.
- Categorical syllogisms are valid exactly when they follow from transitivity of class inclusion.
- Chaining implications is reachability in a directed graph.

> **Practice**
>
> 1. (Beginner) Derive `p` from `p ∨ q`, `q → r`, `¬r`, naming each rule.
> 2. (Intermediate) Is "All A are B; some C are B; therefore some C are A" valid? If not, draw a diagram that serves as a counterexample.
> 3. (Interview) Given thousands of implications between feature flags (`a → b` means "enabling a requires b"), how would you efficiently answer many queries of the form "does enabling x force y?" *Hint:* precompute something on the implication graph. Consider strongly connected components and transitive closure.

#### Resolution

**Why.** Humans pick the right rule for each step by insight. A computer needs one uniform rule that it can apply mechanically. Resolution is that rule, and it is the basis of automated theorem provers, Prolog, and SAT solvers' clause learning.

**What.** For clauses (disjunctions of literals):

```text
(p ∨ q)     (¬p ∨ r)
─────────────────────
       (q ∨ r)
```

`p` and `¬p` cancel, and the remaining literals are combined into the **resolvent**. The rule is sound: if `p` is true, `r` must hold, and if `p` is false, `q` must hold.

Familiar rules are special cases:

| Rule | As resolution |
|---|---|
| Modus ponens | `{¬p, q}` and `{p}` resolve to `{q}` |
| Modus tollens | `{¬p, q}` and `{¬q}` resolve to `{¬p}` |
| Disjunctive syllogism | `{p, q}` and `{¬p}` resolve to `{q}` |

**Refutation proofs.** To show premises entail a conclusion `c`:

1. Convert the premises and `¬c` to CNF (a set of clauses).
2. Resolve pairs repeatedly.
3. If the **empty clause** `{}` (a contradiction) appears, the premises entail `c`.

Resolution is **refutation-complete** for propositional logic: if the clause set is unsatisfiable, the empty clause will eventually be derived.

Example: from `p → q`, `q → r`, `p`, prove `r`.

```text
Clauses: {¬p, q}  {¬q, r}  {p}  {¬r}   <- negated goal

{¬q, r}   {¬r}
      \   /
      {¬q}    {¬p, q}
          \   /
          {¬p}    {p}
              \   /
               { }      empty clause: contradiction, so r follows
```

```python
from itertools import combinations

def resolve(c1, c2):
    """All resolvents of two clauses (frozensets of int literals; -k means ¬x_k)."""
    resolvents = []
    for lit in c1:
        if -lit in c2:
            new = (c1 - {lit}) | (c2 - {-lit})
            if not any(-l in new for l in new):     # discard tautologies like {x, ¬x}
                resolvents.append(frozenset(new))
    return resolvents

def entails(kb, query_clause):
    """Does kb entail query_clause? Add its negation and search for the empty clause."""
    clauses = {frozenset(c) for c in kb}
    clauses |= {frozenset([-lit]) for lit in query_clause}  # ¬(a ∨ b) = {¬a}, {¬b}
    while True:
        new = set()
        for c1, c2 in combinations(clauses, 2):
            for r in resolve(c1, c2):
                if not r:
                    return True                     # empty clause derived
                new.add(r)
        if new <= clauses:
            return False                            # saturated: no refutation exists
        clauses |= new

# p=1, q=2, r=3:  p → q, q → r, p  ⊢  r
print(entails([[-1, 2], [-2, 3], [1]], [3]))  # True
print(entails([[-1, 2], [-2, 3]], [3]))       # False (p is no longer a premise)
```

**Key takeaways**

- Resolution: from `(p ∨ q)` and `(¬p ∨ r)`, infer `(q ∨ r)`.
- It works on clauses, so the input must be in CNF.
- MP, MT, and disjunctive syllogism are special cases.
- Proof by refutation: add the negated goal and derive the empty clause. This is complete for propositional logic.

> **Practice**
>
> 1. (Beginner) Find the resolvent of `(p ∨ ¬q ∨ r)` and `(q ∨ s)`.
> 2. (Intermediate) Use resolution to show that `(p ∨ q) ∧ (p ∨ ¬q) ∧ (¬p ∨ q) ∧ (¬p ∨ ¬q)` is unsatisfiable.
> 3. (Interview) Why do resolution provers work by refutation (deriving `{}` from premises plus the negated goal) instead of deriving the goal directly? *Hint:* try deriving `p ∨ q` from the premise `p` using resolution alone.

#### Inference with Quantifiers

**Why.** The Socrates argument mixes a universal statement ("all humans are mortal") with a specific individual ("Socrates"). We need rules for moving between quantified statements and statements about particular elements.

**What.**

| Rule | From | Infer | Condition |
|---|---|---|---|
| Universal instantiation (UI) | `∀x P(x)` | `P(c)` | `c` is any element of the domain |
| Universal generalization (UG) | `P(c)` | `∀x P(x)` | `c` is **arbitrary**: nothing special about it was assumed |
| Existential instantiation (EI) | `∃x P(x)` | `P(c)` | `c` is a **fresh** name, not used earlier |
| Existential generalization (EG) | `P(c)` | `∃x P(x)` | `c` is some element of the domain |

Combining UI with MP gives **universal modus ponens**: from `∀x (P(x) → Q(x))` and `P(a)`, infer `Q(a)`.

Worked derivation. Premises: "A student in this class has not read the book" and "Everyone in this class passed the first exam". Conclusion: "Someone who passed the first exam has not read the book".

```text
C(x): x is in the class    B(x): x read the book    P(x): x passed the first exam

1. ∃x (C(x) ∧ ¬B(x))      premise
2. C(a) ∧ ¬B(a)           EI from 1 (a is a fresh name)
3. C(a)                   simplification 2
4. ∀x (C(x) → P(x))       premise
5. C(a) → P(a)            UI from 4
6. P(a)                   MP 3, 5
7. ¬B(a)                  simplification 2
8. P(a) ∧ ¬B(a)           conjunction 6, 7
9. ∃x (P(x) ∧ ¬B(x))      EG from 8
```

Instantiate existentials (step 2) **before** universals (step 5). UI may be applied to any name, while EI requires a name that has not been used yet.

**In code.** Prolog is essentially an engine for universal modus ponens. A rule with variables is a universally quantified implication, and a query is answered by instantiating it.

```prolog
% ∀X (human(X) → mortal(X))
mortal(X) :- human(X).

% fact
human(socrates).

% query: is mortal(socrates) derivable?   UI with X = socrates, then MP
?- mortal(socrates).
% true.
```

**Key takeaways**

- UI and EG move from general to specific and back without restrictions.
- UG requires a truly arbitrary element. EI requires a fresh name.
- Universal modus ponens (UI + MP) is the workhorse of quantified reasoning.
- Instantiate existentials before universals so that the names stay fresh.

> **Practice**
>
> 1. (Beginner) Derive `mortal(socrates)` formally from `∀x (H(x) → M(x))` and `H(socrates)`, citing each rule.
> 2. (Intermediate) Find the error in this derivation: (1) `∃x Even(x)` premise; (2) `∃x Odd(x)` premise; (3) `Even(c)` EI 1; (4) `Odd(c)` EI 2; (5) `Even(c) ∧ Odd(c)`; (6) `∃x (Even(x) ∧ Odd(x))` EG 5.
> 3. (Interview) A property-based test checks `sort(xs) == sort(sort(xs))` on 10,000 random lists. Why does this not justify universal generalization, while a pen-and-paper proof for an "arbitrary list xs" does? *Hint:* compare "arbitrary" with "randomly sampled", and think about what UG requires of `c`.

#### Common Fallacies

**Why.** A fallacy is an argument pattern that *looks* valid but is not. Fallacies show up in proofs, code reviews, and incident post-mortems, so learning to recognize them is as important as learning the valid rules.

**What.**

| Fallacy | Form | Example | Why invalid |
|---|---|---|---|
| Affirming the consequent | `p → q`, `q` ⊢ `p` | If the service is down, the alert fires. The alert fired. ∴ The service is down. | Critical row `p = F, q = T` (alert can fire for other reasons) |
| Denying the antecedent | `p → q`, `¬p` ⊢ `¬q` | If you are a CS major, you know logic. You are not. ∴ You don't know logic. | Critical row `p = F, q = T` |
| Circular reasoning | Conclusion used as premise | "The function is correct because its output matches the spec, and the spec was generated from its output." | Nothing independent supports the conclusion |
| Hasty generalization | `P(a₁), …, P(aₖ)` ⊢ `∀x P(x)` | `n² + n + 41` is prime for `n = 0..10`, so it is prime for all `n` | Fails at `n = 40` |
| Quantifier swap | `∀x ∃y P` ⊢ `∃y ∀x P` | Every user has a password ∴ there is one password every user has | Order of dependence changed |
| Undistributed middle | All A are B, all C are B ⊢ all A are C | All cats are mammals, all dogs are mammals ∴ all cats are dogs | Shared class B says nothing about A vs C |

The first two are the converse and inverse errors from 1.1 in argument form. You can check them mechanically:

```python
from itertools import product

def is_valid(n_vars, premises, conclusion):
    for values in product([True, False], repeat=n_vars):
        if all(p(*values) for p in premises) and not conclusion(*values):
            return False, values
    return True, None

imp = lambda a, b: (not a) or b

# Affirming the consequent: p → q, q ⊢ p
print(is_valid(2, [lambda p, q: imp(p, q), lambda p, q: q], lambda p, q: p))
# (False, (False, True))

# Denying the antecedent: p → q, ¬p ⊢ ¬q
print(is_valid(2, [lambda p, q: imp(p, q), lambda p, q: not p], lambda p, q: not q))
# (False, (False, True))

# Modus tollens, for contrast: p → q, ¬q ⊢ ¬p
print(is_valid(2, [lambda p, q: imp(p, q), lambda p, q: not q], lambda p, q: not p))
# (True, None)
```

**Key takeaways**

- Affirming the consequent and denying the antecedent are the most common formal fallacies.
- Both fail on the row `p = F, q = T`.
- Examples never prove a universal statement, and swapping quantifiers changes meaning.
- When in doubt, reduce the argument to its form and search for a critical row.

> **Practice**
>
> 1. (Beginner) Name the fallacy: "If a number is divisible by 4, it is even. 6 is even. Therefore 6 is divisible by 4."
> 2. (Intermediate) "If the patch fixes the bug, the regression test passes. The test passes. So the patch fixes the bug." Name the fallacy, then add a premise that makes the argument valid.
> 3. (Interview) "Our alert fires whenever the service is down. The alert did not fire, so the service is up." Is this reasoning valid? If it is valid, what could still make the conclusion false in production? *Hint:* separate validity from soundness, and question how true the premise is.

<a id="14-proof-techniques"></a>
### 1.4 Proof Techniques

A proof is an argument that a reader can verify step by step and that establishes a statement beyond doubt. This subchapter covers the standard proof strategies and when to use each one.

#### Direct Proof

**Why.** Most theorems have the form "for all x, if P(x) then Q(x)". The most natural way to prove such a statement is to start from what you know and work toward what you want.

**What.** To prove `∀x (P(x) → Q(x))` directly:

1. Let `x` be an **arbitrary** element of the domain. This is what licenses universal generalization at the end.
2. **Assume** `P(x)`.
3. **Unfold** definitions into algebraic facts.
4. Use algebra, known theorems, and inference rules to reach the definition of `Q(x)`.
5. Conclude `Q(x)`.

Definitions used constantly:

| Term | Definition |
|---|---|
| `n` is even | `n = 2k` for some integer `k` |
| `n` is odd | `n = 2k + 1` for some integer `k` |
| `a` divides `b` (`a ∣ b`) | `b = a·k` for some integer `k` (with `a ≠ 0`) |
| `r` is rational | `r = a/b` for integers `a, b` with `b ≠ 0` |

```text
Theorem. For all x in D, if P(x) then Q(x).
Proof.   Let x ∈ D be arbitrary and assume P(x).
         [unfold the definition of P]
         [algebra / known results]
         [repackage the result to match the definition of Q]
         Therefore Q(x).  ∎
```

**Example 1.** *If `n` is odd, then `n²` is odd.*

Proof. Let `n` be an odd integer, so `n = 2k + 1` for some integer `k`. Then `n² = 4k² + 4k + 1 = 2(2k² + 2k) + 1`. Since `2k² + 2k` is an integer, `n²` has the form `2m + 1`, so it is odd. ∎

**Example 2.** *The sum of two rational numbers is rational.*

Proof. Let `r = a/b` and `s = c/d` with integers `a, b, c, d` and `b, d ≠ 0`. Then `r + s = (ad + bc)/(bd)`. The numerator and denominator are integers, and `bd ≠ 0` because neither factor is zero. So `r + s` is rational. ∎

Testing a claim on many cases before proving it is cheap and catches false conjectures early. It is **not** a proof:

```python
# Sanity check, not a proof: test the claim on many odd n before investing in a proof
assert all((n * n) % 2 == 1 for n in range(-1001, 1002, 2))   # n = -1001, -999, ..., 1001
```

**Key takeaways**

- Direct proof: take an arbitrary element, assume the hypothesis, and derive the conclusion.
- Begin by unfolding definitions. End by re-packaging the result into the target definition.
- Use different variable names for independent objects (`k` and `j`, not `k` twice).
- Numeric checks build confidence but never replace a proof of a universal claim.

> **Practice**
>
> 1. (Beginner) Prove directly: the sum of two even integers is even.
> 2. (Intermediate) Prove: if `a ∣ b` and `b ∣ c`, then `a ∣ c`.
> 3. (Interview) Prove: if `a ∣ b` and `a ∣ c`, then `a ∣ (bx + cy)` for all integers `x, y`. Why is this fact the key to the correctness of the Euclidean algorithm (Chapter 4)? *Hint:* write `b` and `c` as multiples of `a`, then factor.

#### Proof by Contrapositive

**Why.** Sometimes the hypothesis gives you very little to work with. Knowing that "`n²` is even" does not easily tell you anything about `n` itself. The *negated conclusion* may be much more concrete, and the contrapositive lets you start from it.

**What.** Since `p → q ≡ ¬q → ¬p` (1.1), proving `¬q → ¬p` directly proves `p → q`.

```text
Goal:       p  ─────────────►  q        (hard: p gives little to work with)
Rewrite:   ¬q  ─────────────► ¬p        (easier: ¬q gives a concrete form)
```

**Example 1.** *If `n²` is even, then `n` is even.*

Direct attempt: `n² = 2k`, so `n = √(2k)`, which leads nowhere.

Contrapositive: *if `n` is odd, then `n²` is odd*. We proved exactly this in the previous topic. ∎

**Example 2.** *If `3n + 2` is odd, then `n` is odd.*

Contrapositive: suppose `n` is even, so `n = 2k`. Then `3n + 2 = 6k + 2 = 2(3k + 1)`, which is even. ∎

**Example 3.** *For positive integers `a, b`: if `ab > 100`, then `a > 10` or `b > 10`.*

Contrapositive: suppose `a ≤ 10` and `b ≤ 10` (De Morgan on the conclusion). Then `ab ≤ 10 · 10 = 100`. ∎

| Use contrapositive when... | Example signal |
|---|---|
| The conclusion's negation is a concrete form | "n is even" is easier to use than "n² is even" |
| The conclusion is a disjunction | `¬(q₁ ∨ q₂)` gives two facts, `¬q₁ ∧ ¬q₂` |
| The hypothesis involves a "non-" property | "if x is irrational..." becomes "if x is rational..." |

**Key takeaways**

- To prove `p → q`, prove `¬q → ¬p` instead. The two are logically equivalent.
- This works well when `¬q` is concrete and `p` is not.
- Use De Morgan when the conclusion is a disjunction or conjunction.
- Say explicitly that you are proving the contrapositive.

> **Practice**
>
> 1. (Beginner) Prove by contrapositive: if `n²` is odd, then `n` is odd.
> 2. (Intermediate) Prove: for real numbers `x, y`, if `x + y ≥ 2`, then `x ≥ 1` or `y ≥ 1`.
> 3. (Interview) A hash table has `m` buckets and stores `n` keys. Prove that if `n > m`, then some bucket holds at least two keys. *Hint:* assume every bucket holds at most one key, and count.

#### Proof by Contradiction

**Why.** Some statements have no obvious starting point: "√2 is irrational" or "there are infinitely many primes". Each says something does *not* exist or is *not* finite. Assuming the opposite gives you a concrete object to work with, and you then show that this object cannot exist.

**What.** To prove a statement `s`:

1. Assume `¬s`.
2. Derive a contradiction `r ∧ ¬r` (any statement together with its negation).
3. Conclude `s`, because `¬s → F` is equivalent to `s`.

For a conditional `p → q`, assume `p ∧ ¬q` and derive a contradiction.

**Classic example.** *√2 is irrational.*

Proof. Suppose, for contradiction, that `√2` is rational. Then `√2 = a/b` with integers `a, b`, `b ≠ 0`, in lowest terms (no common factor other than 1). Squaring gives `a² = 2b²`, so `a²` is even, and therefore `a` is even (proved by contrapositive above). Write `a = 2c`. Then `4c² = 2b²`, so `b² = 2c²`, which makes `b²` and hence `b` even. Now `a` and `b` are both even, which contradicts lowest terms. Therefore `√2` is irrational. ∎

**Contrapositive vs contradiction.**

| | Contrapositive | Contradiction |
|---|---|---|
| Assume | `¬q` | `p ∧ ¬q` (or `¬s` for any statement `s`) |
| Goal | Exactly `¬p` | **Any** contradiction |
| Applies to | Conditionals | Any statement |
| Strength | Clear target | Flexible, but the target is unknown in advance |

**In computing.** The undecidability of the halting problem (Chapter 13) is a proof by contradiction:

```python
def halts(program, data):
    """HYPOTHETICAL: returns True iff program(data) eventually stops. Assume it exists."""
    ...

def paradox(program):
    if halts(program, program):   # if program would halt when run on itself...
        while True:               # ...then loop forever
            pass
    return                        # ...otherwise halt immediately

# Consider paradox(paradox):
#   it halts  <=>  halts(paradox, paradox) is False  <=>  it does not halt.
# Contradiction, so no correct `halts` function can exist.
```

**Pitfall.** If your "contradiction" actually comes from an algebra mistake, the argument proves nothing. Check that the contradiction depends on the assumption `¬s`.

**Key takeaways**

- Assume the statement is false and derive an impossibility.
- This is especially useful for "not", "no", "irrational", and "infinitely many" statements.
- Unlike the contrapositive, the contradiction can be anything, which gives flexibility at the cost of a clear target.
- State the assumption explicitly ("Suppose, for contradiction, ...") and point out exactly where it fails.

> **Practice**
>
> 1. (Beginner) Prove by contradiction that there is no largest integer.
> 2. (Intermediate) Prove that `√3` is irrational. Where does the argument need "if `3 ∣ n²` then `3 ∣ n`", and how would you prove that lemma?
> 3. (Interview) Prove that in any group of `n ≥ 2` people, at least two have the same number of friends within the group (friendship is mutual). *Hint:* the possible friend counts are `0, …, n − 1`. Can `0` and `n − 1` both occur?

#### Proof by Cases

**Why.** Sometimes no single argument covers every object at once, but the domain splits naturally into a few kinds, and each kind is easy to handle. For example, integers are even or odd, reals are negative, zero, or positive, and an integer has remainder 0, 1, or 2 mod 3.

**What.** Based on the equivalence

```text
(p₁ ∨ p₂ ∨ … ∨ pₖ) → q   ≡   (p₁ → q) ∧ (p₂ → q) ∧ … ∧ (pₖ → q)
```

1. Split into cases `p₁, …, pₖ` that together cover **every** possibility.
2. Prove `q` in each case separately.

The cases do not need to be disjoint, but they **must be exhaustive**.

**Example.** *For every integer `n`, `n² mod 4` is 0 or 1.*

- Case 1: `n` even, `n = 2k`. Then `n² = 4k²`, so `n² ≡ 0 (mod 4)`.
- Case 2: `n` odd, `n = 2k + 1`. Then `n² = 4(k² + k) + 1`, so `n² ≡ 1 (mod 4)`.

The two cases cover all integers. ∎

**WLOG ("without loss of generality").** If the cases are symmetric (for example, "`x ≤ y`" and "`y ≤ x`" are handled by identical reasoning with the roles swapped), prove one case and say "WLOG assume `x ≤ y`".

**Exhaustive proof.** When the domain is finite and small, checking every case *is* a proof, and a computer can do the checking:

```python
# Exhaustive proof: claim "(n + 1)^3 >= 3^n for 1 <= n <= 4". Finite cases, all checked.
assert all((n + 1) ** 3 >= 3 ** n for n in range(1, 5))   # 8>=3, 27>=9, 64>=27, 125>=81

# Proof by cases mirrored in code: the match must cover every possible residue
def square_mod_4(n):
    match n % 2:            # every integer falls into exactly one case
        case 0:             # n = 2k   -> n² = 4k²         ≡ 0 (mod 4)
            return 0
        case 1:             # n = 2k+1 -> n² = 4(k²+k) + 1 ≡ 1 (mod 4)
            return 1

assert all(square_mod_4(n) == (n * n) % 4 for n in range(-1000, 1000))  # sanity check
```

**Key takeaways**

- Split the domain into exhaustive cases and prove the claim in each one.
- Missing a case invalidates the whole proof. Check for boundary cases such as zero, equality, and negatives.
- Use WLOG to collapse symmetric cases, and say why the symmetry holds.
- For finite domains, exhaustive checking (including by computer) is a valid proof.

> **Practice**
>
> 1. (Beginner) Prove that `max(a, b) + min(a, b) = a + b` for all real `a, b`.
> 2. (Intermediate) Prove that `n³ − n` is divisible by 3 for every integer `n`, using the cases `n mod 3 ∈ {0, 1, 2}`.
> 3. (Interview) Prove that no integer of the form `4k + 3` can be written as a sum of two perfect squares. *Hint:* use the worked example above and list the possible values of `a² + b² mod 4`.

#### Existence and Uniqueness Proofs

**Why.** Many results claim that something exists ("this equation has a solution") or that exactly one such thing exists ("the solution is unique"). In code, existence is "the function returns something" and uniqueness is "the result is well defined, so any two correct implementations agree".

**What.**

- **Existence** `∃x P(x)`: produce a **witness** `c` and verify `P(c)` (constructive), or argue that one must exist (non-constructive, see the next topic).
- **Uniqueness** `∃!x P(x)` needs two parts:
  1. *Existence*: some `x` satisfies `P`.
  2. *Uniqueness*: if `P(y)` and `P(z)`, then `y = z`. (Equivalently, any `y ≠ x` fails `P`.)

```text
∃!x P(x)   ≡   ∃x ( P(x) ∧ ∀y ( P(y) → y = x ) )
```

**Example (existence).** *Some positive integer can be written as a sum of two positive cubes in two different ways.*

Witness: `1729 = 1³ + 12³ = 9³ + 10³`. ∎

**Example (existence and uniqueness).** *If `a ≠ 0`, the equation `ax + b = 0` has a unique real solution.*

- Existence: `x = −b/a` works, since `a(−b/a) + b = 0`.
- Uniqueness: if `ay + b = 0` and `az + b = 0`, then `ay = az`. Since `a ≠ 0`, dividing gives `y = z`. ∎

A computer search can *find* a witness. Once found, the witness is a complete existence proof:

```python
from itertools import combinations_with_replacement

def smallest_two_way_cube_sum(limit):
    sums = {}
    for a, b in combinations_with_replacement(range(1, limit), 2):  # a <= b avoids duplicates
        sums.setdefault(a**3 + b**3, []).append((a, b))
    return min((n, pairs) for n, pairs in sums.items() if len(pairs) >= 2)

print(smallest_two_way_cube_sum(20))   # (1729, [(1, 12), (9, 10)])
```

**Key takeaways**

- Existence: exhibit a witness and verify it, or argue indirectly.
- Uniqueness: assume two objects satisfy the property and show that they are equal.
- `∃!` always needs **both** parts. Uniqueness alone does not imply existence.
- A computer-found witness is a valid existence proof. Failing to find one proves nothing.

> **Practice**
>
> 1. (Beginner) Prove there exists a prime `p` such that `p + 2` and `p + 4` are also prime.
> 2. (Intermediate) Prove there is a unique positive integer `n` such that `n² − 1` is prime. *(Factor first.)*
> 3. (Interview) An array holds `n − 1` distinct integers from `1..n`. Prove that exactly one value is missing, and give an `O(n)` time, `O(1)` extra space algorithm to find it. *Hint:* existence and uniqueness come from counting. For the algorithm, compare the actual sum with an expected one.

#### Constructive vs Non-constructive Proofs

**Why.** Knowing that a solution exists and knowing how to find one are different things. For a programmer, the difference matters: a constructive proof is essentially an algorithm, while a non-constructive proof only tells you the search will not be empty.

**What.**

| | Constructive | Non-constructive |
|---|---|---|
| Shows | A specific witness, or a method to compute it | That a witness must exist |
| Typical tools | Explicit formulas, algorithms, induction | Contradiction, pigeonhole, parity, case splits on unknown facts |
| Gives you | An algorithm | Existence only |
| Example | `x = −b/a` solves `ax + b = 0` | Some two of any 13 people share a birth month |

**Classic non-constructive proof.** *There exist irrational numbers `a, b` such that `aᵇ` is rational.*

Consider `√2^√2`. It is either rational or irrational:

- If it is rational, take `a = b = √2`. Done.
- If it is irrational, take `a = √2^√2` and `b = √2`. Then `aᵇ = √2^(√2·√2) = √2² = 2`, which is rational. Done.

One of the two cases must hold, but the proof never says which one.

**A constructive alternative.** Take `a = √2` and `b = log₂ 9` (which is irrational). Then `aᵇ = 2^(½ · log₂ 9) = 2^(log₂ 3) = 3`.

**Constructive proofs as programs.** "For every `n` there is a prime greater than `n`" has a constructive proof that is also an algorithm. It is slow, but correct:

```python
from math import factorial

def prime_greater_than(n):
    """Constructive proof that a prime > n exists: the smallest factor > 1 of n! + 1."""
    m = factorial(n) + 1
    d = 2
    while m % d != 0:   # find the smallest divisor d > 1; the smallest such divisor is always prime
        d += 1
    return d            # d > n: every k in 2..n divides n!, so it leaves remainder 1 when dividing m

print([prime_greater_than(n) for n in range(1, 8)])   # [2, 3, 7, 5, 11, 7, 71]
```

(This connects to the *Curry–Howard correspondence*: in constructive logic, proofs are programs and propositions are types.)

**Key takeaways**

- Constructive proofs produce the witness. Non-constructive proofs only show that one must exist.
- Non-constructive proofs often come from contradiction, pigeonhole, or a case split on an undecided fact.
- A constructive proof is an algorithm, though not necessarily an efficient one.
- When the goal is to compute something, look for a constructive proof.

> **Practice**
>
> 1. (Beginner) Classify as constructive or non-constructive: (a) "6 is a perfect number because 1 + 2 + 3 = 6"; (b) "among any 367 people, two share a birthday".
> 2. (Intermediate) Give a constructive proof that for every integer `n ≥ 1` there are `n` consecutive composite integers. *(Consider `(n + 1)! + 2, …, (n + 1)! + (n + 1)`.)*
> 3. (Interview) The pigeonhole principle shows that among any 5 integers, two have a difference divisible by 4. Turn this non-constructive argument into an `O(n)` algorithm that returns such a pair from a list of `n ≥ 5` integers. *Hint:* the pigeonholes are remainders mod 4. Use a dictionary keyed by remainder.

#### Counterexamples

**Why.** Proving a universal claim can be hard, but disproving one is often easy: a single failure is enough. Looking for counterexamples first saves you from trying to prove false statements.

**What.** From 1.2: `¬∀x P(x) ≡ ∃x ¬P(x)`. A single `x` where `P(x)` fails disproves `∀x P(x)`. For a conditional `∀x (P(x) → Q(x))`, the counterexample must satisfy `P` and violate `Q`.

| Claim | Counterexample |
|---|---|
| Every positive integer is a sum of two squares | `3` |
| `n² + n + 41` is prime for every `n ≥ 0` | `n = 40`: `1681 = 41²` |
| If `n²` is divisible by 4, then `n` is divisible by 4 | `n = 2` |
| `(a + b)² = a² + b²` | `a = b = 1` |

**Where to look.** Try small values, `0`, `1`, negatives, equal arguments, empty inputs, and boundary values. In code, these are the edge cases for unit tests.

**Limits.**

- A counterexample disproves a **universal** claim. It cannot disprove an existential one.
- Not finding a counterexample does **not** prove the claim. Goldbach's conjecture has been checked to about 4·10¹⁸ and is still unproven.

**Analogy.** A failing test case is a counterexample to "this code is correct". Property-based testing tools (e.g. Hypothesis, QuickCheck) search for counterexamples automatically and shrink them to minimal ones.

```python
def find_counterexample(prop, candidates):
    """Return the first candidate where prop fails, or None (which proves nothing)."""
    for x in candidates:
        if not prop(x):
            return x
    return None

def is_prime(m):
    return m > 1 and all(m % d for d in range(2, int(m ** 0.5) + 1))

print(find_counterexample(lambda n: is_prime(n * n + n + 41), range(100)))  # 40
print(find_counterexample(lambda n: n % 4 == 0 or (n * n) % 4 != 0, range(1, 50)))  # 2
```

**Key takeaways**

- One counterexample disproves a universal claim.
- For a conditional claim, the counterexample must satisfy the hypothesis and violate the conclusion.
- Search small and boundary cases first.
- Absence of counterexamples is evidence, not proof.

> **Practice**
>
> 1. (Beginner) Disprove: "for all integers `a, b`, if `a² = b²` then `a = b`."
> 2. (Intermediate) Disprove: "`2ⁿ − 1` is prime for every prime `n`." Find the smallest counterexample, by hand or with code.
> 3. (Interview) "The greedy algorithm (always take the largest coin that fits) gives the minimum number of coins for any coin system." Find a coin system and amount that disprove this. *Hint:* use three denominations, including 1, where a large coin "overshoots" and forces many small coins afterward.

#### Proof Strategy and Writing

**Why.** Knowing the techniques is not enough. You also need to choose a technique for a given statement and write the proof so that a reader can verify it. A proof is communication: if the reader cannot follow it, it has not done its job.

**Choosing a technique.**

| Statement shape | First technique to try |
|---|---|
| `∀x (P(x) → Q(x))` | Direct proof; contrapositive if `¬Q` is more concrete than `P` |
| "There is no...", "irrational", "infinitely many" | Contradiction |
| Domain splits naturally (parity, sign, remainder) | Cases |
| `∃x P(x)` | Construct a witness |
| `∃!x P(x)` | Existence plus uniqueness |
| `p ↔ q` | Prove `p → q` and `q → p` separately |
| `∀n ≥ n₀ P(n)` with recursive structure | Induction (Chapter 3) |
| You suspect it is false | Search for a counterexample |

**Process.**

```text
                 Read the statement carefully
                              │
          Unfold definitions; identify quantifiers and form
                              │
              Try small examples ── fails? ──► Counterexample: done
                              │ holds
                    What is its shape?
   ┌────────────┬─────────────┼──────────────┬───────────────┐
 p → q       ∃x P(x)      "no"/"not"     domain splits    ∀n ∈ ℕ
   │            │             │              │               │
 Direct /    Construct   Contradiction     Cases         Induction
 contrapos.   witness
                              │
          Write it up: assumptions, steps, justifications, ∎
```

Work **forward** from the hypotheses ("what do I know?") and **backward** from the goal ("what would suffice?") until the two meet in the middle.

**Writing checklist.**

- State the theorem and the technique: "We prove the contrapositive", "Suppose, for contradiction, ...".
- Introduce every variable with its type: "Let `n` be an integer".
- Use different names for independent objects.
- Justify each non-trivial step (definition, lemma, or algebra).
- Avoid "clearly" and "obviously" unless the step really is immediate.
- Mark the end of the proof with `∎` (or "QED").

**Bad vs good.** *Claim: the sum of two odd integers is even.*

```text
BAD:   Let m = 2k + 1 and n = 2k + 1. Then m + n = 4k + 2 = 2(2k + 1), which is even.
       Flaw: reusing k forces m = n, so only the case of equal numbers was proved.

GOOD:  Let m and n be odd integers, so m = 2k + 1 and n = 2j + 1 for some integers k, j.
       Then m + n = 2k + 2j + 2 = 2(k + j + 1). Since k + j + 1 is an integer,
       m + n is even.  ∎
```

**Common mistakes.**

| Mistake | Example |
|---|---|
| Assuming the conclusion | Starting from the equation you want to prove and "simplifying" it to `0 = 0` |
| Proof by example | Checking `n = 1, 2, 3` and declaring the claim true for all `n` |
| Missing cases | Proving for `x > 0` and `x < 0`, forgetting `x = 0` |
| Hidden division by zero | Cancelling a factor `(a − b)` when `a = b` |
| Converse confusion | Proving `q → p` when `p → q` was asked |

**Key takeaways**

- Let the logical form of the statement guide the choice of technique.
- Test examples first. They suggest both proofs and counterexamples.
- Work forward from the hypotheses and backward from the goal.
- Write for a skeptical reader: introduce variables, justify steps, and state the structure.

> **Practice**
>
> 1. (Beginner) Find the error: "Let `a = b`. Then `a² = ab`, so `a² − b² = ab − b²`, so `(a + b)(a − b) = b(a − b)`, so `a + b = b`, so `2b = b`, so `2 = 1`."
> 2. (Intermediate) Prove that for every integer `n`, `n` is even if and only if `n²` is even. Choose the technique for each direction and say why.
> 3. (Interview) A colleague doubts that your loop `while lo < hi: mid = (lo + hi) // 2; ...` always terminates. Sketch a proof that would convince them. *Hint:* find a non-negative integer quantity that strictly decreases on every iteration, then use the fact that a strictly decreasing sequence of non-negative integers cannot go on forever (well-ordering, Chapter 3).

<a id="2-sets-functions-and-relations"></a>
## 2. Sets, Functions, and Relations

Sets, functions, and relations are the basic vocabulary of discrete mathematics. Almost every later object, including graphs, formal languages, probability spaces and database tables, is defined in terms of them. This chapter builds up sets and their operations, uses them to define functions and to compare the sizes of infinite sets, and then studies relations, including the equivalence relations and orders behind hashing, sorting, and dependency resolution. In code, the same ideas appear as `set` and `dict`, SQL joins, comparators, and the topological sort inside every build system.

<a id="21-set-theory"></a>
### 2.1 Set Theory

A set is an unordered collection of distinct objects. This subchapter covers how to describe sets, compare them, combine them, and reason about the results.

#### Set Notation and Builder Form

**Why.** "The small primes" and "the active users" are vague phrases. Mathematics and programs both need a precise way to say exactly which objects belong to a collection and which do not.

**What.** A **set** is a collection of distinct objects, called its **elements** or **members**. We write `x ∈ A` for "x is an element of A" and `x ∉ A` for "x is not an element of A". A set is determined completely by its members, which has two consequences:

- **Order does not matter:** `{1, 2, 3} = {3, 1, 2}`.
- **Duplicates do not matter:** `{1, 1, 2} = {1, 2}`.

There are two standard ways to describe a set:

| Notation | Form | Example | Best for |
|---|---|---|---|
| Roster | List the elements | `{2, 3, 5, 7}` | Small, explicit sets |
| Roster with ellipsis | List enough elements to show a pattern | `{1, 3, 5, 7, …}` | Obvious patterns (use with care) |
| Set-builder | `{x ∈ U \| P(x)}` | `{x ∈ ℤ \| x > 0 ∧ x is even}` | Sets defined by a property |
| Set-builder (image form) | `{f(x) \| x ∈ U}` | `{n² \| n ∈ ℕ}` | Sets of computed values |

Set-builder notation `{x ∈ U | P(x)}` reads "the set of all `x` in `U` such that `P(x)`". It is a predicate (1.2) turned into a collection: the set contains exactly the elements of `U` for which the predicate is true.

**Standard sets.**

| Symbol | Set | Elements |
|---|---|---|
| `ℕ` | Natural numbers | `{0, 1, 2, 3, …}` (some texts start at 1; this guide includes 0) |
| `ℤ` | Integers | `{…, −2, −1, 0, 1, 2, …}` |
| `ℤ⁺` | Positive integers | `{1, 2, 3, …}` |
| `ℚ` | Rational numbers | `{a/b \| a, b ∈ ℤ, b ≠ 0}` |
| `ℝ` | Real numbers | All points on the number line |
| `∅` or `{}` | Empty set | No elements |
| `U` | Universal set | Everything under discussion in the current context |

**Sets of sets.** Sets can contain other sets. The set `{∅}` is *not* empty: it has exactly one element, namely the empty set. Think of `∅` as an empty box and `{∅}` as a box that contains an empty box.

**Analogy.** A set is like a guest list checked by a doorman. The only question it answers is "is this person on the list?". The order of the names is irrelevant, and writing a name twice does not admit the person twice.

**Why the domain `U` matters.** Unrestricted set-builder notation leads to contradictions. Russell's paradox defines `R = {x | x ∉ x}` (the set of all sets that do not contain themselves) and asks whether `R ∈ R`. Either answer implies the other, the same self-reference as "This sentence is false" (1.1). Writing `{x ∈ U | P(x)}`, which only selects from an existing set `U`, avoids the problem.

```python
primes_small = {2, 3, 5, 7}                        # roster notation
print({1, 2, 3} == {3, 1, 2, 2})                   # True: order and duplicates are ignored

# Set-builder {x ∈ U | P(x)} maps directly onto a set comprehension
U = range(1, 21)
evens = {x for x in U if x % 2 == 0}               # {x ∈ U | x is even}
squares = {n * n for n in range(1, 6)}             # {n² | n ∈ {1, …, 5}} = {1, 4, 9, 16, 25}

print(4 in evens, 5 in evens)                      # True False   (∈ and ∉)

empty = set()                                      # ∅  (note: {} is an empty dict in Python)
box_with_empty_box = {frozenset()}                 # {∅}: elements of a set must be hashable
print(len(empty), len(box_with_empty_box))         # 0 1
```

**Key takeaways**

- A set is determined only by which elements it contains. Order and repetition are irrelevant.
- Roster notation lists elements. Set-builder notation `{x ∈ U | P(x)}` selects elements by a predicate.
- `∅` has no elements, while `{∅}` has one element.
- Always build sets from a known domain `U`. Unrestricted comprehension leads to Russell's paradox.

> **Practice**
>
> 1. (Beginner) Write in roster notation: `{x ∈ ℤ | x² < 10}` and `{2n + 1 | n ∈ {0, 1, 2, 3}}`.
> 2. (Intermediate) Write the set of positive integers that are multiples of 3 or of 5 in set-builder notation. How many elements does `{∅, {∅}, {∅, {∅}}}` have, and what are they?
> 3. (Interview) Python rejects `{{1, 2}, {3}}` but accepts `{frozenset({1, 2}), frozenset({3})}`. Why must the elements of a hash-based set be immutable? *Hint:* think about what happens to a hash table when an element changes after it has been inserted.

#### Subsets and Equality

**Why.** Many practical questions compare two collections. "Is every admin also a registered user?" is a subset question. "Do these two queries return the same rows?" is an equality question. Both need precise definitions, and equality of sets has its own standard proof technique.

**What.**

| Concept | Notation | Definition |
|---|---|---|
| Subset | `A ⊆ B` | `∀x (x ∈ A → x ∈ B)`: every element of A is in B |
| Proper subset | `A ⊂ B` (or `A ⊊ B`) | `A ⊆ B` and `A ≠ B`: B has at least one extra element |
| Superset | `B ⊇ A` | Same as `A ⊆ B` |
| Equality | `A = B` | `A ⊆ B` and `B ⊆ A` |

Two facts follow immediately from the definition:

- `A ⊆ A` for every set `A`.
- `∅ ⊆ A` for every set `A`. The condition `x ∈ ∅ → x ∈ A` has a false hypothesis for every `x`, so it is vacuously true (1.1).

**Element-of vs subset-of.** These are easy to confuse, especially when sets contain sets:

| Statement | True? | Reason |
|---|---|---|
| `1 ∈ {1, 2}` | Yes | 1 is one of the listed elements |
| `{1} ⊆ {1, 2}` | Yes | Every element of `{1}` is in `{1, 2}` |
| `{1} ∈ {1, 2}` | No | The elements are the numbers 1 and 2, not the set `{1}` |
| `∅ ⊆ {1}` | Yes | The empty set is a subset of every set |
| `∅ ∈ {1}` | No | The only element is 1 |
| `∅ ∈ {∅}` and `∅ ⊆ {∅}` | Both yes | `∅` is listed as an element, and is also a subset of everything |

**How: proving `A ⊆ B`.** Take an arbitrary element `x ∈ A` and show `x ∈ B`. This is a direct proof (1.4) of a universally quantified conditional.

*Example.* `{x ∈ ℤ | 6 ∣ x} ⊆ {x ∈ ℤ | 2 ∣ x}`.
Let `x` be an integer with `6 ∣ x`, so `x = 6k` for some integer `k`. Then `x = 2(3k)`, so `2 ∣ x`. ∎

**How: proving `A = B` (double inclusion).** Prove `A ⊆ B` and `B ⊆ A` separately.

*Example.* `{n ∈ ℤ | n² is even} = {n ∈ ℤ | n is even}`.
(⊆) If `n²` is even, then `n` is even. This was proved by contrapositive in 1.4.
(⊇) If `n = 2k`, then `n² = 4k² = 2(2k²)`, which is even. ∎

```text
  B
  ┌─────────────────────────────┐
  │  A                          │      A ⊂ B: every point of A lies inside B,
  │  ┌──────────────┐           │      and B has points outside A
  │  │   x ∈ A      │   y ∈ B   │
  │  └──────────────┘   y ∉ A   │
  └─────────────────────────────┘
```

```python
admins = {"ana"}
users = {"ana", "ben", "cleo"}

print(admins <= users)          # True   A ⊆ B
print(admins < users)           # True   A ⊂ B (proper)
print(users <= users)           # True   every set is a subset of itself
print(users < users)            # False  but not a proper subset
print(set() <= admins)          # True   ∅ ⊆ A
print({"ana", "ana"} == admins) # True   equality ignores duplicates
```

**Key takeaways**

- `A ⊆ B` means every element of `A` is also in `B`. `∅ ⊆ A` and `A ⊆ A` always hold.
- `∈` relates an element to a set. `⊆` relates two sets. Do not mix them up.
- Prove `A ⊆ B` by taking an arbitrary `x ∈ A` and showing `x ∈ B`.
- Prove `A = B` by double inclusion: `A ⊆ B` and `B ⊆ A`.

> **Practice**
>
> 1. (Beginner) True or false: `∅ ∈ ∅`, `∅ ⊆ ∅`, `{1} ∈ {{1}, 2}`, `{1} ⊆ {{1}, 2}`, `{{1}} ⊆ {{1}, 2}`.
> 2. (Intermediate) Prove that `⊆` is transitive: if `A ⊆ B` and `B ⊆ C`, then `A ⊆ C`.
> 3. (Interview) You receive two unsorted lists of `n` user IDs each, possibly with duplicates. Decide whether they contain the same *set* of IDs. Compare a nested-loop approach, a sorting approach, and a hashing approach in time and memory. *Hint:* equality is double inclusion. What does a hash set make cheap?

#### Power Sets

**Why.** Many problems are "try every combination": every subset of features to enable, every selection of items for a knapsack, every set of servers that might fail together. The collection of all subsets of a set has a name and a predictable size.

**What.** The **power set** of `A` is the set of all subsets of `A`:

```text
P(A) = { S | S ⊆ A }
```

For `A = {a, b, c}`:

```text
P(A) = { ∅, {a}, {b}, {c}, {a,b}, {a,c}, {b,c}, {a,b,c} }
```

If `|A| = n`, then `|P(A)| = 2ⁿ`. To build a subset, you make an independent yes/no decision for each of the `n` elements, which gives `2 · 2 · … · 2 = 2ⁿ` possibilities. Note that `P(∅) = {∅}` has one element, matching `2⁰ = 1`.

**Subsets as bit strings.** List the elements in a fixed order. Then each subset corresponds to exactly one `n`-bit string, with bit `i` equal to 1 if and only if element `i` is included. This correspondence (a bijection, see 2.2) is how programs enumerate subsets:

| Mask (decimal) | Bits `c b a` | Subset |
|---|---|---|
| 0 | `000` | `∅` |
| 1 | `001` | `{a}` |
| 2 | `010` | `{b}` |
| 3 | `011` | `{a, b}` |
| 4 | `100` | `{c}` |
| 5 | `101` | `{a, c}` |
| 6 | `110` | `{b, c}` |
| 7 | `111` | `{a, b, c}` |

```python
from itertools import chain, combinations

def power_set(items):
    """All subsets of items, enumerated with bitmasks."""
    items = list(items)
    n = len(items)
    result = []
    for mask in range(1 << n):                                    # 2^n masks: 0 … 2^n − 1
        subset = {items[i] for i in range(n) if mask & (1 << i)}  # bit i set -> include items[i]
        result.append(subset)
    return result

print(len(power_set("abc")))       # 8
print(len(power_set(range(10))))   # 1024: doubling with every extra element

# Equivalent standard-library recipe: all combinations of size 0, 1, …, n
def power_set_itertools(items):
    items = list(items)
    return chain.from_iterable(combinations(items, k) for k in range(len(items) + 1))
```

**Cost.** Because `|P(A)|` doubles with each added element, brute-force search over subsets works for about 20 to 25 elements and becomes infeasible soon after. This is the same exponential growth seen with truth tables (1.1).

**Key takeaways**

- `P(A)` is the set of all subsets of `A`, including `∅` and `A` itself.
- `|P(A)| = 2^|A|`, because each element is independently in or out.
- Subsets of an `n`-element set correspond one-to-one with `n`-bit strings, which makes them easy to enumerate with bitmasks.
- Algorithms that try every subset run in `Ω(2ⁿ)` time.

> **Practice**
>
> 1. (Beginner) List all elements of `P({1, 2})` and of `P({∅})`.
> 2. (Intermediate) Prove that `A ⊆ B` if and only if `P(A) ⊆ P(B)`.
> 3. (Interview) Given `n ≤ 20` integers and a target `t`, decide whether some subset sums to `t`. Describe a bitmask solution and its running time. Why does it become impractical near `n = 40`, and how could splitting the input in half help? *Hint:* each half has only `2^(n/2)` subsets. Sort one list of sums and search it.

#### Cartesian Products

**Why.** Sets ignore order, but many objects are naturally ordered: a point `(x, y)`, a cell `(row, column)`, a database row `(id, name, email)`. We need a construction in which position matters.

**What.** An **ordered pair** `(a, b)` has a first component and a second component, and

```text
(a, b) = (c, d)   if and only if   a = c and b = d
```

So `(1, 2) ≠ (2, 1)`, whereas `{1, 2} = {2, 1}`. The **Cartesian product** of `A` and `B` is the set of all ordered pairs with the first component from `A` and the second from `B`:

```text
A × B = { (a, b) | a ∈ A and b ∈ B }
```

More generally, `A₁ × A₂ × … × Aₙ` is the set of **n-tuples** `(a₁, …, aₙ)`, and `Aⁿ` means `A × A × … × A` (n times). For example, `ℝ²` is the plane and `{0, 1}⁸` is the set of all bytes.

Properties:

- `|A × B| = |A| · |B|` for finite sets. This is the product rule of counting (Chapter 5).
- `A × ∅ = ∅`, because there is no second component to choose.
- `A × B ≠ B × A` in general. They are equal only if `A = B` or one of them is empty.

```text
              B = {x, y, z}
             x        y        z
         ┌────────┬────────┬────────┐
A    1   │ (1,x)  │ (1,y)  │ (1,z)  │      |A × B| = 2 · 3 = 6
=        ├────────┼────────┼────────┤
{1,2} 2  │ (2,x)  │ (2,y)  │ (2,z)  │
         └────────┴────────┴────────┘
```

**Pairs from sets.** Ordered pairs do not need to be a new primitive. Kuratowski's definition `(a, b) = {{a}, {a, b}}` builds them from sets alone and satisfies the equality rule above. This is one reason set theory can serve as a foundation for the rest of mathematics.

**In code.** Nested loops over two collections iterate over their Cartesian product. In SQL, `CROSS JOIN` computes it.

```python
from itertools import product

ranks = ["A", "K", "Q"]
suits = ["S", "H"]                               # spades, hearts

cards = list(product(ranks, suits))              # ranks × suits
print(cards)        # [('A', 'S'), ('A', 'H'), ('K', 'S'), ('K', 'H'), ('Q', 'S'), ('Q', 'H')]
print(len(cards))   # 6 = 3 · 2

# The same product as nested loops: the outer loop is the first component
same = [(r, s) for r in ranks for s in suits]
print(same == cards)                             # True

bytes_ = list(product([0, 1], repeat=8))         # {0, 1}^8
print(len(bytes_))                               # 256
```

**Key takeaways**

- In an ordered pair, position matters: `(a, b) = (c, d)` exactly when `a = c` and `b = d`.
- `A × B` is the set of all pairs `(a, b)` with `a ∈ A` and `b ∈ B`, and `|A × B| = |A| · |B|`.
- The Cartesian product is not commutative, and `A × ∅ = ∅`.
- Nested loops, `itertools.product`, and SQL `CROSS JOIN` all compute Cartesian products.

> **Practice**
>
> 1. (Beginner) Let `A = {0, 1}` and `B = {a, b, c}`. List `A × B` and `B × A`. Are they equal?
> 2. (Intermediate) Prove that `A × (B ∪ C) = (A × B) ∪ (A × C)` by double inclusion.
> 3. (Interview) A test matrix covers 4 operating systems, 3 browsers, and 5 screen sizes. How many configurations are there? Many teams test far fewer. What property should a reduced test set keep? *Hint:* look up pairwise (all-pairs) testing. Every pair of values from any two factors should appear in at least one test.

#### Set Operations

**Why.** Most questions about collections combine them: who is enrolled in both courses, in either one, in only one, or in neither? Set operations answer these, and each one corresponds to a logical connective from Chapter 1.

**What.** Let `A` and `B` be subsets of a universal set `U`.

| Operation | Notation | Definition | Logic | Python | SQL |
|---|---|---|---|---|---|
| Union | `A ∪ B` | `{x \| x ∈ A ∨ x ∈ B}` | `∨` | `A \| B` | `UNION` |
| Intersection | `A ∩ B` | `{x \| x ∈ A ∧ x ∈ B}` | `∧` | `A & B` | `INTERSECT` |
| Difference | `A − B` (or `A \ B`) | `{x \| x ∈ A ∧ x ∉ B}` | `p ∧ ¬q` | `A - B` | `EXCEPT` |
| Symmetric difference | `A Δ B` (or `A ⊕ B`) | `(A − B) ∪ (B − A)` | `⊕` | `A ^ B` | (no direct keyword) |
| Complement | `Ā` (or `Aᶜ`) | `{x ∈ U \| x ∉ A}` | `¬` | `U - A` | `NOT IN` |

Sets `A` and `B` are **disjoint** if `A ∩ B = ∅`. Operations extend to families of sets: `⋃ᵢ Aᵢ` contains every element that belongs to at least one `Aᵢ`, and `⋂ᵢ Aᵢ` contains every element that belongs to all of them.

**Counting.** For finite sets, adding `|A|` and `|B|` counts the elements of `A ∩ B` twice, so

```text
|A ∪ B| = |A| + |B| − |A ∩ B|
```

This is the simplest case of inclusion–exclusion (Chapter 5).

```python
python_students = {"ana", "ben", "cleo", "dev"}
java_students = {"cleo", "dev", "eli"}

print(sorted(python_students | java_students))   # ['ana', 'ben', 'cleo', 'dev', 'eli']   ∪
print(sorted(python_students & java_students))   # ['cleo', 'dev']                        ∩
print(sorted(python_students - java_students))   # ['ana', 'ben']                         −
print(sorted(python_students ^ java_students))   # ['ana', 'ben', 'eli']                  Δ

# Inclusion–exclusion check: 5 = 4 + 3 − 2
assert len(python_students | java_students) == \
       len(python_students) + len(java_students) - len(python_students & java_students)

# Sets over a small universe as bitmasks: element i is present iff bit i is set.
# Set operations become single CPU instructions.
U = 0b1111_1111            # universe {0, …, 7}
A = 0b0000_1111            # {0, 1, 2, 3}
B = 0b0011_1100            # {2, 3, 4, 5}
print(bin(A | B))          # 0b111111      {0, …, 5}        union
print(bin(A & B))          # 0b1100        {2, 3}           intersection
print(bin(A & ~B))         # 0b11          {0, 1}           difference
print(bin(A ^ B))          # 0b110011      {0, 1, 4, 5}     symmetric difference
print(bin(U & ~A))         # 0b11110000    {4, …, 7}        complement within U
```

**Key takeaways**

- Union, intersection, difference, symmetric difference, and complement correspond to `∨`, `∧`, `p ∧ ¬q`, `⊕`, and `¬`.
- The complement is always taken relative to a universal set `U`.
- `|A ∪ B| = |A| + |B| − |A ∩ B|` for finite sets.
- Over a small universe, bitmasks implement set operations with bitwise operators.

> **Practice**
>
> 1. (Beginner) Let `U = {1, …, 10}`, `A = {1, 2, 3, 4, 5}`, `B = {4, 5, 6, 7}`. Compute `A ∪ B`, `A ∩ B`, `A − B`, `B − A`, `A Δ B`, and `Ā`.
> 2. (Intermediate) Prove `A − B = A ∩ B̄` by double inclusion.
> 3. (Interview) Given two sorted arrays of distinct integers of lengths `n` and `m`, compute their intersection in `O(n + m)` time and `O(1)` extra space (not counting the output). *Hint:* use one pointer per array and always advance the pointer at the smaller value.

#### Set Identities

**Why.** Set expressions such as filters, permission rules, and query conditions can often be simplified or rearranged. Set identities are the algebraic laws that make this safe. Each one is a logical equivalence from 1.1 in disguise, because `x ∈ A ∪ B` means exactly `x ∈ A ∨ x ∈ B`.

**What.**

| Law | Union form | Intersection form |
|---|---|---|
| Identity | `A ∪ ∅ = A` | `A ∩ U = A` |
| Domination | `A ∪ U = U` | `A ∩ ∅ = ∅` |
| Idempotent | `A ∪ A = A` | `A ∩ A = A` |
| Complement | `A ∪ Ā = U` | `A ∩ Ā = ∅` |
| Double complement | `(Ā)‾ = A` | |
| Commutative | `A ∪ B = B ∪ A` | `A ∩ B = B ∩ A` |
| Associative | `A ∪ (B ∪ C) = (A ∪ B) ∪ C` | `A ∩ (B ∩ C) = (A ∩ B) ∩ C` |
| Distributive | `A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C)` | `A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C)` |
| De Morgan | `(A ∪ B)‾ = Ā ∩ B̄` | `(A ∩ B)‾ = Ā ∪ B̄` |
| Absorption | `A ∪ (A ∩ B) = A` | `A ∩ (A ∪ B) = A` |

The table has a **duality**: swap `∪ ↔ ∩` and `∅ ↔ U` in any identity and you get another identity.

**How: three ways to prove an identity.**

1. **Double inclusion.** Show each side is a subset of the other by following an arbitrary element.
2. **Set-builder and logic.** Rewrite each side as `{x | …}` and transform the condition with logical equivalences.
3. **Membership table.** Like a truth table: one row for each combination of "in / not in" for the sets involved. If the two final columns match, the identity holds.

*Method 2, De Morgan:*

```text
(A ∩ B)‾ = { x | ¬(x ∈ A ∧ x ∈ B) }          definition of complement and ∩
         = { x | ¬(x ∈ A) ∨ ¬(x ∈ B) }        De Morgan's law for logic (1.1)
         = { x | x ∈ Ā ∨ x ∈ B̄ }              definition of complement
         = Ā ∪ B̄                               definition of ∪            ∎
```

*Method 3, distributive law `A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C)` (1 = in, 0 = not in):*

| A | B | C | B ∪ C | A ∩ (B ∪ C) | A ∩ B | A ∩ C | (A ∩ B) ∪ (A ∩ C) |
|---|---|---|---|---|---|---|---|
| 1 | 1 | 1 | 1 | **1** | 1 | 1 | **1** |
| 1 | 1 | 0 | 1 | **1** | 1 | 0 | **1** |
| 1 | 0 | 1 | 1 | **1** | 0 | 1 | **1** |
| 1 | 0 | 0 | 0 | **0** | 0 | 0 | **0** |
| 0 | 1 | 1 | 1 | **0** | 0 | 0 | **0** |
| 0 | 1 | 0 | 1 | **0** | 0 | 0 | **0** |
| 0 | 0 | 1 | 1 | **0** | 0 | 0 | **0** |
| 0 | 0 | 0 | 0 | **0** | 0 | 0 | **0** |

A membership table is a complete proof for any identity built from `∪`, `∩`, `−`, and complement. Each row describes one region of the Venn diagram, and every element of `U` falls into exactly one region.

```python
from itertools import product

def membership_table_equal(lhs, rhs, k):
    """Check a k-set identity row by row: each row says whether x is in each set."""
    for row in product([True, False], repeat=k):
        if lhs(*row) != rhs(*row):
            return False, row                    # this region is a counterexample
    return True, None

# A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C)
print(membership_table_equal(lambda a, b, c: a and (b or c),
                             lambda a, b, c: (a and b) or (a and c), 3))
# (True, None)

# A tempting but false "identity": A − (B − C) = (A − B) − C
print(membership_table_equal(lambda a, b, c: a and not (b and not c),
                             lambda a, b, c: (a and not b) and not c, 3))
# (False, (True, True, True)): an x in all three sets is on the left side but not the right
```

**Key takeaways**

- Every set identity mirrors a logical equivalence. `∪, ∩, complement` correspond to `∨, ∧, ¬`.
- Prove identities by double inclusion, by set-builder notation plus logic, or with a membership table.
- Duality: swapping `∪ ↔ ∩` and `∅ ↔ U` turns one identity into another.
- Set difference is neither commutative nor associative. Check before regrouping it.

> **Practice**
>
> 1. (Beginner) Simplify `(A ∪ B) ∩ (A ∪ B̄)` using the laws in the table, naming each law you use.
> 2. (Intermediate) Prove the absorption law `A ∪ (A ∩ B) = A` by double inclusion, then again with a membership table.
> 3. (Interview) A query has the filter `WHERE NOT (status IN ('archived', 'deleted') OR region = 'eu')`. Rewrite it without the outer `NOT` so that each condition is a simple positive or negative test on one column. Which identity justifies the rewrite? *Hint:* the set of rows that pass a filter behaves like a set, and `NOT` is complement.

#### Venn Diagrams

**Why.** For two or three sets, a picture is often the fastest way to understand an expression, to see which elements it includes, or to solve a counting problem. Venn diagrams make set operations visual.

**What.** A rectangle represents the universal set `U`, and each set is a closed region inside it. With `n` sets drawn in general position, the diagram has `2ⁿ` regions, one for each combination of "inside / outside" each set, including the region outside all of them. An expression is shown by shading the regions it contains.

```text
U
┌───────────────────────────────────────────────┐
│                                               │
│   A ┌─────────────────────┐                   │
│     │                     │                   │
│     │   A − B    ┌────────┼───────────┐ B     │
│     │            │ A ∩ B  │   B − A   │       │
│     └────────────┼────────┘           │       │
│                  │                    │       │
│                  └────────────────────┘       │
│                                  (A ∪ B)‾     │
└───────────────────────────────────────────────┘
```

**Three sets.** Three overlapping circles create 8 regions, which the table below labels by membership (1 = inside). Shading an expression means selecting rows. For example, `A ∩ (B ∪ C)` is regions 1, 2, and 3.

| Region | A | B | C | Description |
|---|---|---|---|---|
| 1 | 1 | 1 | 1 | `A ∩ B ∩ C` |
| 2 | 1 | 1 | 0 | in A and B only |
| 3 | 1 | 0 | 1 | in A and C only |
| 4 | 1 | 0 | 0 | only A |
| 5 | 0 | 1 | 1 | in B and C only |
| 6 | 0 | 1 | 0 | only B |
| 7 | 0 | 0 | 1 | only C |
| 8 | 0 | 0 | 0 | outside all three |

The rows are exactly the rows of a membership table. A Venn diagram is a drawing of that table.

**Counting with regions.** *100 developers were surveyed. 60 use Python, 45 use Java, and 20 use both.* Fill the regions from the inside out:

```text
both          = 20
Python only   = 60 − 20 = 40
Java only     = 45 − 20 = 25
neither       = 100 − (40 + 20 + 25) = 15
```

**Limitations.** With four or more sets, circles can no longer produce all `2ⁿ` regions, so more complicated shapes are needed. A diagram also shows only one configuration of the sets, so it can suggest an identity but cannot prove one. Use a membership table or an element argument for proofs.

```python
def venn_regions(U, **sets):
    """Group each element of U by the exact combination of sets that contain it."""
    names = list(sets)
    regions = {}
    for x in U:
        key = tuple(name for name in names if x in sets[name]) or ("outside",)
        regions.setdefault(key, set()).add(x)
    return regions

U = range(1, 16)
regions = venn_regions(U,
                       even={x for x in U if x % 2 == 0},
                       mult3={x for x in U if x % 3 == 0},
                       mult5={x for x in U if x % 5 == 0})
for key, members in sorted(regions.items()):
    print(key, sorted(members))
# ('even',) [2, 4, 8, 14]
# ('even', 'mult3') [6, 12]
# ('even', 'mult5') [10]
# ('mult3',) [3, 9]
# ('mult3', 'mult5') [15]
# ('mult5',) [5]
# ('outside',) [1, 7, 11, 13]
```

**Key takeaways**

- A Venn diagram shows `U` as a rectangle and each set as a region. `n` sets give `2ⁿ` regions.
- Each region corresponds to one row of a membership table.
- For counting problems, fill the innermost region first and work outward.
- Diagrams help intuition and checking. They are not proofs.

> **Practice**
>
> 1. (Beginner) Sketch a two-set Venn diagram and shade `(A − B) ∪ (B − A)`. Which operation from the table in Set Operations is this?
> 2. (Intermediate) In a class of 60 students, 30 take Math, 25 take CS, 18 take Physics, 10 take Math and CS, 8 take Math and Physics, 6 take CS and Physics, and 3 take all three. How many take none of the three? Fill all 8 regions.
> 3. (Interview) A colleague "proves" `A − (B ∩ C) = (A − B) ∩ (A − C)` by drawing a Venn diagram where the two shaded areas look the same. Is the identity true? Explain why the picture is not enough. *Hint:* check the region inside `A` and `B` but outside `C`.

#### Multisets

**Why.** Sets discard duplicates, but sometimes repetition carries information: the words in a document, the items in a shopping cart, or the prime factors of a number (`12 = 2 · 2 · 3`). A **multiset** keeps track of how many times each element occurs while still ignoring order.

**What.** A multiset over `U` is described by a **multiplicity function** `m: U → ℕ`, where `m(x)` is the number of copies of `x`. It can be written `{a, a, b}`, `{a², b}`, or `{a: 2, b: 1}`. Its cardinality is the sum of all multiplicities.

| Collection | Order matters? | Duplicates matter? | Python type |
|---|---|---|---|
| Sequence (list, tuple) | Yes | Yes | `list`, `tuple` |
| Set | No | No | `set`, `frozenset` |
| Multiset (bag) | No | Yes | `collections.Counter` |

**Operations** are defined element by element on multiplicities:

| Operation | Multiplicity of `x` in the result | `Counter` |
|---|---|---|
| Union `A ∪ B` | `max(m_A(x), m_B(x))` | `A \| B` |
| Intersection `A ∩ B` | `min(m_A(x), m_B(x))` | `A & B` |
| Sum `A ⊎ B` | `m_A(x) + m_B(x)` | `A + B` |
| Difference `A − B` | `max(m_A(x) − m_B(x), 0)` | `A - B` |

When all multiplicities are 0 or 1, union, intersection, and difference reduce to the ordinary set operations.

**Example: gcd and lcm.** The prime factorization of a number is a multiset of primes. The gcd of two numbers is the product of the *intersection* of their factor multisets (minimum exponents), and the lcm is the product of the *union* (maximum exponents). Chapter 4 develops this further.

```python
from collections import Counter
from math import prod

print(Counter("listen") == Counter("silent"))      # True: anagrams are equal as multisets
print(set("aab") == set("abb"))                    # True as sets...
print(Counter("aab") == Counter("abb"))            # False as multisets: multiplicities differ

def factor(n):
    """Prime factorization of n as a multiset {prime: exponent}."""
    f, p = Counter(), 2
    while p * p <= n:
        while n % p == 0:
            f[p] += 1
            n //= p
        p += 1
    if n > 1:
        f[n] += 1                                  # leftover factor is prime
    return f

a, b = factor(360), factor(84)                     # 360 = 2³·3²·5,  84 = 2²·3·7
gcd = prod(p ** k for p, k in (a & b).items())     # min exponents: 2²·3       = 12
lcm = prod(p ** k for p, k in (a | b).items())     # max exponents: 2³·3²·5·7  = 2520
print(gcd, lcm)                                    # 12 2520
```

**Key takeaways**

- A multiset ignores order but keeps multiplicities. Formally it is a function `m: U → ℕ`.
- Multiset union and intersection take the max and min of multiplicities, and the sum adds them.
- In Python, `collections.Counter` is a multiset.
- Prime factorizations, word counts, and anagram checks are all multiset problems.

> **Practice**
>
> 1. (Beginner) Let `A = {a, a, b, c}` and `B = {a, b, b, d}`. Compute `A ∪ B`, `A ∩ B`, `A ⊎ B`, and `A − B`.
> 2. (Intermediate) List all multisets of size 2 whose elements come from `{x, y, z}`. How many are there, and how does this compare with the number of 2-element *subsets*?
> 3. (Interview) Given a string `s` and a pattern `p`, return every index where a substring of `s` is an anagram of `p`. Aim for `O(|s|)` time for a fixed alphabet. *Hint:* slide a window of length `|p|` across `s` and update a character-count multiset by one addition and one removal per step.

<a id="22-functions"></a>
### 2.2 Functions

A function assigns to each input exactly one output. Defining functions precisely, as special sets of pairs, makes properties like "lossless", "covers every output", and "invertible" exact. These properties matter for encodings, hashing, and comparing the sizes of sets.

#### Domain, Codomain, and Range

**Why.** In a program, a function signature such as `int -> int` promises which inputs are accepted and what kind of value comes back. Mathematics makes the same promise, and also separates the *declared* type of the outputs from the outputs the function *actually* produces.

**What.** A **function** `f: A → B` assigns to **each** element `a ∈ A` **exactly one** element `f(a) ∈ B`. Formally, `f` is a subset of `A × B` in which every `a ∈ A` appears as a first component exactly once.

| Term | Notation | Meaning | Programming analogue |
|---|---|---|---|
| Domain | `A` | Allowed inputs | Parameter type |
| Codomain | `B` | Declared kind of output | Return type |
| Range (image) | `f(A) = {f(a) \| a ∈ A}` | Outputs actually produced, `f(A) ⊆ B` | Values a call can really return |
| Image of a subset | `f(S) = {f(a) \| a ∈ S}` | Outputs produced by inputs in `S` | `{f(x) for x in S}` |
| Preimage | `f⁻¹(T) = {a ∈ A \| f(a) ∈ T}` | Inputs that land in `T` | "Which inputs give these results?" |

There are two ways to fail to be a function:

- **Not total:** some input has no output (`f(x) = 1/x` on `ℝ` has no value at 0). A rule that is undefined on some inputs is called a *partial function*.
- **Not well-defined:** some input has two outputs (`f(x) = ±√x`).

```text
   A = {1, 2, 3}          B = {a, b, c, d}

      1 ───────────────►  a
                          b      no arrow arrives: b is not in the range
      2 ──────────┐
                  ├────►  c      two arrows arrive: allowed for a function
      3 ──────────┘
                          d

   domain = {1, 2, 3}    codomain = {a, b, c, d}    range = {a, c}
```

Every element of the domain sends out exactly one arrow. Elements of the codomain may receive zero, one, or many arrows.

**Example.** `f: ℤ → ℤ`, `f(x) = x²`. The domain and codomain are both `ℤ`, the range is `{0, 1, 4, 9, …}`, `f⁻¹({4}) = {−2, 2}`, and `f⁻¹({3}) = ∅`.

**Equality.** Two functions are equal when they have the same domain, the same codomain, and the same value on every input. The rule used to compute them does not matter: `f(x) = (x + 1)²` and `g(x) = x² + 2x + 1` are the same function on `ℝ`.

```python
def is_function(pairs, domain):
    """Is this set of (input, output) pairs a total, well-defined function on domain?"""
    outputs = {}
    for a, b in pairs:
        if a in outputs and outputs[a] != b:
            return False                       # a has two different outputs: not well-defined
        outputs[a] = b
    return set(outputs) == set(domain)         # every input needs an output: total

f = {1: "a", 2: "c", 3: "c"}                   # a dict is a finite function
print(is_function(f.items(), {1, 2, 3}))       # True
print(is_function({(1, "a"), (1, "b")}, {1}))  # False

image = set(f.values())                                   # range: {'a', 'c'}
preimage = lambda T: {a for a, b in f.items() if b in T}  # f⁻¹(T)
print(sorted(image), preimage({"c"}), preimage({"b"}))    # ['a', 'c'] {2, 3} set()
```

**Key takeaways**

- A function assigns every element of its domain exactly one output.
- The codomain is the declared target. The range is the set of values actually produced, and it is a subset of the codomain.
- The preimage `f⁻¹(T)` is defined for every function, whether or not `f` has an inverse.
- Functions are equal when they agree on domain, codomain, and every value.

> **Practice**
>
> 1. (Beginner) For `f: ℤ → ℤ` with `f(n) = |n| + 1`, give the domain, codomain, and range, and compute `f⁻¹({3})` and `f⁻¹({0})`.
> 2. (Intermediate) Which of these define a function `ℝ → ℝ`? `f(x) = 1/x`, `f(x) = √x`, `f(x) = ±√(x² + 1)`, `f(x) = ⌊x⌋`. For each failure, say whether it fails totality or well-definedness.
> 3. (Interview) A function is annotated `def parse(s: str) -> int`, but it raises an exception on some inputs. In the mathematical sense, is it a function from `str` to `int`? How do `Optional[int]` or a `Result` type change the answer? *Hint:* think of it as a partial function, and consider what happens when you enlarge the codomain.

#### Injective Functions

**Why.** An injective function never sends two inputs to the same output, so no information is lost and the input can always be recovered from the output. Unique identifiers, database primary keys, and lossless encoders all rely on this property.

**What.** `f: A → B` is **injective** (one-to-one) if different inputs always give different outputs:

```text
∀a₁, a₂ ∈ A   ( f(a₁) = f(a₂)  →  a₁ = a₂ )
```

The contrapositive form, `a₁ ≠ a₂ → f(a₁) ≠ f(a₂)`, is often easier to read, but the form above is easier to prove.

```text
  Injective                      Not injective
  1 ──────► a                    1 ──────► a
  2 ──────► b                    2 ───┐
  3 ──────► c                    3 ───┴──► b     two inputs collide
            d                              c
```

**How.**

- *To prove* injectivity: assume `f(a₁) = f(a₂)` and derive `a₁ = a₂` with algebra.
- *To disprove* it: find two distinct inputs with the same output (a counterexample, 1.4).

*Example.* `f: ℝ → ℝ`, `f(x) = 3x + 7` is injective. Assume `3a₁ + 7 = 3a₂ + 7`. Subtracting 7 and dividing by 3 gives `a₁ = a₂`. ∎

*Example.* `g(x) = x²` is **not** injective on `ℝ`, because `g(−1) = g(1)`. On `ℕ` it **is** injective. The same rule can be injective or not depending on the domain.

Any strictly increasing or strictly decreasing function is injective, since distinct inputs are ordered and their outputs keep that strict order.

**Finite sets and collisions.** If `f: A → B` is injective and both sets are finite, then `|A| ≤ |B|`. A function from a larger set to a smaller one *must* have collisions. This is the pigeonhole principle (Chapter 5), and it is why every hash function that maps arbitrarily long inputs to fixed-size digests has collisions.

```python
def is_injective(f: dict) -> bool:
    return len(set(f.values())) == len(f)       # no output value is repeated

print(is_injective({x: 3 * x + 7 for x in range(-50, 50)}))   # True
print(is_injective({x: x * x for x in range(-50, 50)}))       # False: (-1)² = 1²

# Pigeonhole in practice: 9 keys into 8 buckets must collide
keys = ["k0", "k1", "k2", "k3", "k4", "k5", "k6", "k7", "k8"]
buckets = {k: hash(k) % 8 for k in keys}
print(is_injective(buckets))                                  # False, whatever the hash values
```

**Key takeaways**

- Injective means distinct inputs give distinct outputs: `f(a₁) = f(a₂) → a₁ = a₂`.
- Prove it by assuming equal outputs and deriving equal inputs. Disprove it with one collision.
- Restricting the domain can make a non-injective rule injective.
- For finite sets, an injection `A → B` requires `|A| ≤ |B|`, so compressing into a smaller set always causes collisions.

> **Practice**
>
> 1. (Beginner) Is `f: ℤ → ℤ, f(n) = n + 7` injective? Is `g: ℤ → ℤ, g(n) = n mod 5`? Justify each answer.
> 2. (Intermediate) Prove that `f(x) = (3x − 1)/(x + 2)` is injective on `ℝ − {−2}`.
> 3. (Interview) A URL shortener maps long URLs to 7-character codes over the 62 characters `[A-Za-z0-9]`. Can this mapping be injective? What design makes it injective in practice? *Hint:* compare `62⁷` with the number of URLs you will store, and compare hashing the URL with assigning codes from a counter.

#### Surjective Functions

**Why.** A surjective function reaches every possible output. You want this for a hash function that should be able to use every bucket, for a decoder that should be able to produce every message, and whenever every element of a target must be "covered".

**What.** `f: A → B` is **surjective** (onto) if every element of the codomain is the image of at least one input:

```text
∀b ∈ B  ∃a ∈ A  ( f(a) = b )
```

Equivalently, the range equals the codomain: `f(A) = B`.

```text
  Surjective                     Not surjective
  1 ──────► a                    1 ──────► a
  2 ───┐                         2 ──────► b
  3 ───┴──► b                              c     never hit
```

**How.**

- *To prove* surjectivity: take an arbitrary `b ∈ B`, solve `f(a) = b` for `a`, and check that the solution really lies in `A`.
- *To disprove* it: find a `b` that has no preimage.

*Example.* `f: ℤ → ℤ`, `f(n) = n − 3` is onto. Given any integer `b`, take `a = b + 3`, which is an integer, and `f(a) = b`. ∎

*Example.* `g: ℤ → ℤ`, `g(n) = 2n` is **not** onto, because `2n = 1` has no integer solution. The same rule on `ℝ → ℝ` *is* onto, since `a = b/2` is a real number. The check "is the solution in `A`?" decides the answer.

*Example.* `x ↦ x²` is not onto as a map `ℝ → ℝ` (`−1` is never reached), but it is onto as a map `ℝ → [0, ∞)`. Surjectivity depends on the codomain.

| | Injective | Surjective |
|---|---|---|
| Informal | No collisions | No missed outputs |
| Logic | `∀a₁ ∀a₂ (f(a₁) = f(a₂) → a₁ = a₂)` | `∀b ∃a (f(a) = b)` |
| Arrows into each `b ∈ B` | At most one | At least one |
| Proof pattern | Assume equal outputs, derive equal inputs | Given `b`, construct `a` |
| Finite sets | `\|A\| ≤ \|B\|` | `\|A\| ≥ \|B\|` |
| Depends on | Mostly the domain | Mostly the codomain |

```python
def is_surjective(f: dict, codomain) -> bool:
    return set(f.values()) == set(codomain)     # the range must cover the codomain

m = 10
print(is_surjective({k: k % m for k in range(100)}, range(m)))         # True: every bucket used
print(is_surjective({k: (2 * k) % m for k in range(100)}, range(m)))   # False: odd buckets unused
```

**Key takeaways**

- Surjective means every element of the codomain is hit: `∀b ∃a f(a) = b`.
- Prove it by solving `f(a) = b` and checking that `a` lies in the domain.
- Changing the codomain can make a function onto or stop it from being onto.
- For finite sets, a surjection `A → B` requires `|A| ≥ |B|`.

> **Practice**
>
> 1. (Beginner) Is `f: ℤ → ℤ, f(n) = 3n` onto? Is `g: ℝ → ℝ, g(x) = 3x` onto?
> 2. (Intermediate) Prove that `f: ℤ × ℤ → ℤ, f(m, n) = 2m + 3n` is onto. *Hint:* first write `1` as `2m + 3n`.
> 3. (Interview) A hash table uses `h(k) = (a · k) mod m` for integer keys. For which multipliers `a` does the map `k ↦ (a · k) mod m` on `{0, …, m − 1}` reach every bucket? *Hint:* the answer depends on `gcd(a, m)`. Try `m = 10` with `a = 3` and with `a = 4` (Chapter 4).

#### Bijective Functions

**Why.** A bijection pairs the elements of two sets perfectly, with nothing left over on either side. Bijections let you rename things without losing information, encode and decode losslessly, and count one set by counting another. They are also the basis for comparing the sizes of infinite sets (2.3).

**What.** `f: A → B` is **bijective** (a one-to-one correspondence) if it is both injective and surjective. Equivalently, every `b ∈ B` has **exactly one** preimage. For finite sets, a bijection exists exactly when `|A| = |B|`. A bijection from a set to itself is called a **permutation**.

| Injective? | Surjective? | Name | Example on finite sets |
|---|---|---|---|
| No | No | (neither) | `{1,2,3} → {a,b,c}` with `1,2 ↦ a`, `3 ↦ b` |
| Yes | No | Injection only | `{1,2} → {a,b,c}` with `1 ↦ a`, `2 ↦ b` |
| No | Yes | Surjection only | `{1,2,3} → {a,b}` with `1,2 ↦ a`, `3 ↦ b` |
| Yes | Yes | Bijection | `{1,2,3} → {a,b,c}` with `1 ↦ a`, `2 ↦ b`, `3 ↦ c` |

**Counting by bijection.** To count a set, find a bijection to a set that is easier to count. Subsets of an `n`-element set correspond one-to-one with `n`-bit strings (2.1), so there are `2ⁿ` of them.

**Example: zig-zag encoding.** The function `z: ℤ → ℕ` defined by

```text
z(n) = 2n          if n ≥ 0
z(n) = −2n − 1     if n < 0

   n :  0  −1   1  −2   2  −3   3  …
 z(n):  0   1   2   3   4   5   6  …
```

is a bijection. Non-negative integers go to the even naturals and negative integers go to the odd naturals. Protocol Buffers uses exactly this encoding so that small negative numbers get short variable-length encodings. It also shows that `ℤ` and `ℕ` have the same cardinality (2.3).

```python
def zigzag_encode(n: int) -> int:
    return 2 * n if n >= 0 else -2 * n - 1       # 0, -1, 1, -2, 2 -> 0, 1, 2, 3, 4

def zigzag_decode(m: int) -> int:
    return m // 2 if m % 2 == 0 else -(m + 1) // 2

# Injective and surjective on a test range: every code 0 … 999 is used exactly once
codes = [zigzag_encode(n) for n in range(-500, 500)]
assert sorted(codes) == list(range(1000))
# Decoding undoes encoding: the inverse function (next topic)
assert all(zigzag_decode(zigzag_encode(n)) == n for n in range(-10**4, 10**4))
```

**Key takeaways**

- A bijection is a function that is both injective and surjective. Each output has exactly one preimage.
- Finite sets have a bijection between them exactly when they have the same size.
- To count a set, find a bijection to a set you can already count.
- Lossless encodings such as zig-zag, Base64, and permutations of an array are bijections.

> **Practice**
>
> 1. (Beginner) Which of these are bijections `ℝ → ℝ`? `2x − 5`, `x²`, `x³`, `eˣ`.
> 2. (Intermediate) Define `φ: P({1, …, n}) → {0, 1}ⁿ` by sending a subset `S` to the bit string with 1 in position `i` exactly when `i ∈ S`. Prove that `φ` is a bijection.
> 3. (Interview) Fisher–Yates shuffles an array of length `n` by choosing, for `i` from `n − 1` down to 1, a random index `j ∈ {0, …, i}` and swapping. Why does it produce every permutation with equal probability? *Hint:* count the possible sequences of choices and show that the map from choice sequences to permutations is a bijection.

#### Inverse Functions

**Why.** Decoding, decrypting, undoing an edit, and converting back to the original units are all inverse operations. Knowing exactly when an inverse exists tells you when an operation can be undone without ambiguity.

**What.** If `f: A → B` is a bijection, its **inverse** `f⁻¹: B → A` sends each `b` to its unique preimage:

```text
f⁻¹(b) = a   if and only if   f(a) = b

f⁻¹(f(a)) = a  for all a ∈ A        f(f⁻¹(b)) = b  for all b ∈ B
```

Reverse every arrow and see what goes wrong when `f` is not a bijection:

```text
  f not injective                       f not surjective
  1 ───┐                                1 ──────► a
  2 ───┴──► a                                     b
                                       reversed: b has no arrow back,
  reversed: a would go to both 1        so f⁻¹(b) is undefined
  and 2, so f⁻¹(a) is not well-defined
```

So a function has an inverse function **if and only if** it is a bijection.

**Notation warning.** `f⁻¹(T)` applied to a *set* means the preimage, which exists for every function. `f⁻¹(b)` as a *function* exists only for bijections. Neither is `1/f(x)`.

**How: computing an inverse.** Write `y = f(x)` and solve for `x`.

*Example.* `f: ℝ − {3} → ℝ − {2}`, `f(x) = (2x + 1)/(x − 3)`.

```text
y(x − 3) = 2x + 1
yx − 3y  = 2x + 1
x(y − 2) = 3y + 1
x        = (3y + 1)/(y − 2)          so  f⁻¹(y) = (3y + 1)/(y − 2),  defined for y ≠ 2
```

The excluded value `y = 2` is exactly the value the original function never reaches, which is why the codomain was chosen as `ℝ − {2}`.

**One-sided inverses.** An injective function has a *left* inverse `g` with `g(f(a)) = a`: it can be decoded, though some codes are unused. A surjective function has a *right* inverse `h` with `f(h(b)) = b`: you can always pick some preimage. Only a bijection has a two-sided inverse.

```python
def invert(f: dict, codomain) -> dict:
    """Inverse of a finite function, or an explanation of why there is none."""
    inv = {}
    for a, b in f.items():
        if b in inv:
            raise ValueError(f"not injective: {inv[b]!r} and {a!r} both map to {b!r}")
        inv[b] = a
    missing = set(codomain) - set(inv)
    if missing:
        raise ValueError(f"not surjective: no preimage for {sorted(missing)}")
    return inv

# Caesar cipher: a bijection on the 26 letters, inverted by shifting back
letters = "abcdefghijklmnopqrstuvwxyz"
encrypt = {c: letters[(i + 3) % 26] for i, c in enumerate(letters)}
decrypt = invert(encrypt, letters)
secret = "".join(encrypt[c] for c in "hello")
print(secret, "".join(decrypt[c] for c in secret))   # khoor hello
```

**Key takeaways**

- A function has an inverse if and only if it is a bijection.
- `f⁻¹ ∘ f` is the identity on `A`, and `f ∘ f⁻¹` is the identity on `B`.
- Compute an inverse by solving `y = f(x)` for `x`, keeping track of excluded values.
- The preimage `f⁻¹(T)` of a set always exists. The inverse function does not.

> **Practice**
>
> 1. (Beginner) Find the inverse of `f: ℝ → ℝ, f(x) = 5x − 2`, and verify both `f⁻¹(f(x)) = x` and `f(f⁻¹(y)) = y`.
> 2. (Intermediate) `f(x) = x²` has no inverse as a map `ℝ → ℝ`. Restrict its domain and codomain so that it becomes a bijection, and give the inverse. Is there more than one way to do this?
> 3. (Interview) Password hashes are stored instead of passwords. Explain why a hash from all strings to 256-bit digests cannot have an inverse function, and why "no inverse exists" is not the same as "it is hard to find *some* preimage". *Hint:* compare the sizes of the domain and codomain, then think about right inverses.

#### Function Composition

**Why.** Programs are built by chaining steps: parse, validate, transform, serialize. Composition is the mathematical form of this chaining, and its laws explain which refactorings are safe.

**What.** For `f: A → B` and `g: B → C`, the **composition** `g ∘ f: A → C` is

```text
(g ∘ f)(x) = g(f(x))
```

Read `g ∘ f` as "g after f": `f` is applied first even though it is written second. The composition is defined only when the outputs of `f` are valid inputs for `g`.

```text
          f             g
   A ─────────► B ─────────► C
   │                         ▲
   └──────── g ∘ f ──────────┘
```

| Property | Statement |
|---|---|
| Associative | `h ∘ (g ∘ f) = (h ∘ g) ∘ f`, so parentheses can be dropped |
| Not commutative | Usually `g ∘ f ≠ f ∘ g` |
| Identity | `f ∘ id_A = f = id_B ∘ f`, where `id_A(x) = x` |
| Inverses | `f⁻¹ ∘ f = id_A` and `f ∘ f⁻¹ = id_B` |
| Inverse of a composition | `(g ∘ f)⁻¹ = f⁻¹ ∘ g⁻¹` (to undo "socks, then shoes", remove shoes first) |

*Example.* `f(x) = x + 1` and `g(x) = 2x` on `ℝ`. Then `(g ∘ f)(x) = 2(x + 1) = 2x + 2`, but `(f ∘ g)(x) = 2x + 1`.

**Preserved properties.** If `f` and `g` are both injective, so is `g ∘ f`. The same holds for surjective and bijective.

*Proof (injective).* Suppose `g(f(a₁)) = g(f(a₂))`. Since `g` is injective, `f(a₁) = f(a₂)`. Since `f` is injective, `a₁ = a₂`. ∎

The partial converses are also useful: if `g ∘ f` is injective then `f` is injective, and if `g ∘ f` is surjective then `g` is surjective.

```python
from functools import reduce

def compose(*fs):
    """compose(h, g, f)(x) == h(g(f(x))): applied right to left, like h ∘ g ∘ f."""
    return reduce(lambda g, f: lambda x: g(f(x)), fs, lambda x: x)   # start from the identity

f = lambda x: x + 1
g = lambda x: 2 * x
print(compose(g, f)(5), compose(f, g)(5))      # 12 11   g∘f ≠ f∘g

# A text-normalization pipeline: strip, then lowercase, then collapse internal spaces
normalize = compose(" ".join, str.split, str.lower, str.strip)
print(normalize("   Hello    WORLD  "))        # hello world
```

**Key takeaways**

- `(g ∘ f)(x) = g(f(x))`. The right-hand function is applied first.
- Composition is associative but not commutative.
- Composing injections, surjections, or bijections gives a function of the same kind.
- The inverse of a composition reverses the order: `(g ∘ f)⁻¹ = f⁻¹ ∘ g⁻¹`.

> **Practice**
>
> 1. (Beginner) Let `f(x) = x²` and `g(x) = x − 3` on `ℝ`. Compute `(f ∘ g)(x)`, `(g ∘ f)(x)`, and `(f ∘ g)(5)`.
> 2. (Intermediate) Prove that if `g ∘ f` is surjective, then `g` is surjective. Give an example where `g ∘ f` is surjective but `f` is not.
> 3. (Interview) A web framework wraps a handler as `app = logging(auth(cache(handler)))`. Which middleware sees the incoming request first, and which sees the outgoing response first? Why does associativity let you build the stack one layer at a time? *Hint:* each middleware is a function from handlers to handlers. Trace a request in and its response back out.

#### Floor and Ceiling Functions

**Why.** Discrete quantities often come from continuous formulas: the number of pages needed for `n` items, the middle index of an array, the number of bits in a number, the level of a node in a heap. Floor and ceiling turn real values into integers in a controlled way.

**What.**

- **Floor** `⌊x⌋`: the greatest integer less than or equal to `x` (round down, toward −∞).
- **Ceiling** `⌈x⌉`: the least integer greater than or equal to `x` (round up, toward +∞).

Both are functions `ℝ → ℤ`. They are surjective but not injective.

| `x` | `⌊x⌋` | `⌈x⌉` | Truncation (round toward 0) |
|---|---|---|---|
| 3.7 | 3 | 4 | 3 |
| −3.7 | −4 | −3 | −3 |
| 5 | 5 | 5 | 5 |
| −0.5 | −1 | 0 | 0 |

```text
    ⌊−1.5⌋      ⌈−1.5⌉                   ⌊1.5⌋       ⌈1.5⌉
       │           │                       │           │
   ────●─────○─────●───────────●───────────●─────○─────●─────►
      −2   −1.5   −1           0           1    1.5    2
```

**Properties** (`x` real, `n` integer):

| Property | Statement |
|---|---|
| Characterization | `⌊x⌋ = n` iff `n ≤ x < n + 1`, and `⌈x⌉ = n` iff `n − 1 < x ≤ n` |
| Sandwich | `x − 1 < ⌊x⌋ ≤ x ≤ ⌈x⌉ < x + 1` |
| Negation | `⌊−x⌋ = −⌈x⌉` and `⌈−x⌉ = −⌊x⌋` |
| Integer shift | `⌊x + n⌋ = ⌊x⌋ + n` and `⌈x + n⌉ = ⌈x⌉ + n` |
| Gap | `⌈x⌉ − ⌊x⌋` is 0 if `x` is an integer and 1 otherwise |
| Ceiling by floor | `⌈a/b⌉ = ⌊(a + b − 1)/b⌋` for integers `a` and `b > 0` |
| Not additive | `⌊x + y⌋` can differ from `⌊x⌋ + ⌊y⌋` (try `x = y = 0.5`) |

**Common uses.**

| Quantity | Formula |
|---|---|
| Pages for `n` items, `k` per page | `⌈n/k⌉` |
| Middle index of `lo … hi` | `⌊(lo + hi)/2⌋` |
| Bits to write `n ≥ 1` in binary | `⌊log₂ n⌋ + 1` |
| Parent of node `i` in a 0-indexed binary heap | `⌊(i − 1)/2⌋` |

**In code, watch the rounding direction.** Python's `//` is floor division, while C, Java, and JavaScript's integer division and Python's `int()` truncate toward zero. The two agree for non-negative operands and differ for negative ones. Floating-point ceilings also lose precision for large integers, so use integer arithmetic.

```python
import math

print(7 // 2, -7 // 2)                  # 3 -4     floor division
print(int(-3.5), math.floor(-3.5))      # -3 -4    truncation is not floor for negatives
print(-7 % 2)                           # 1        Python's % matches floor: a == b*(a//b) + a%b

def ceil_div(a, b):
    """⌈a/b⌉ for integers with b > 0, using only exact integer arithmetic."""
    return -(-a // b)                   # ⌈x⌉ = −⌊−x⌋

print(ceil_div(101, 20))                # 6 pages for 101 items at 20 per page

n = 10**17 + 1
print(math.ceil(n / 2))                 # 50000000000000000   wrong: n / 2 was rounded as a float
print(ceil_div(n, 2))                   # 50000000000000001   exact

print((1000).bit_length(), math.floor(math.log2(1000)) + 1)   # 10 10   bits needed for 1000
```

**Key takeaways**

- `⌊x⌋` rounds down and `⌈x⌉` rounds up. Both are integers within distance 1 of `x`.
- `⌊x⌋ = n` exactly when `n ≤ x < n + 1`. Most proofs about floor start from this characterization.
- Integer shifts move through floor and ceiling, but sums of non-integers do not.
- In code, distinguish floor from truncation and avoid floats for exact ceilings of large integers.

> **Practice**
>
> 1. (Beginner) Compute `⌊−2.01⌋`, `⌈−2.01⌉`, `⌊7/3⌋`, `⌈7/3⌉`, and `⌊log₂ 100⌋`.
> 2. (Intermediate) Prove that `⌊n/2⌋ + ⌈n/2⌉ = n` for every integer `n`. *Hint:* proof by cases on parity (1.4).
> 3. (Interview) The Java binary search line `int mid = (lo + hi) / 2;` contained a bug for years. What is it, and why does `lo + (hi - lo) / 2` fix it? Does `/` in Java compute `⌊ ⌋` when `lo + hi` is negative? *Hint:* consider integer overflow, then compare truncation with floor.

<a id="23-cardinality"></a>
### 2.3 Cardinality

Cardinality is the size of a set. For finite sets it is ordinary counting. For infinite sets, bijections show that there are different sizes of infinity, and this has a direct consequence for computing: some problems cannot be solved by any program.

#### Finite and Infinite Sets

**Why.** "How many?" is easy to answer for a finite set: count the elements. For infinite sets, counting never ends, so we need a definition of "same size" that does not rely on finishing a count.

**What.** Matching elements is more basic than counting. Two piles of coins have the same size if you can pair them off one-to-one, even if you cannot count. This leads to the following definitions:

- `|A| = |B|` (same **cardinality**) if there is a bijection `A → B`.
- `|A| ≤ |B|` if there is an injection `A → B`.
- `A` is **finite** with `|A| = n` if there is a bijection `{1, …, n} → A` (and `|∅| = 0`). Otherwise `A` is **infinite**.

**Infinite sets behave differently.** In a finite set, a proper subset is always strictly smaller. An infinite set can have the same cardinality as a proper subset of itself. The map `n ↦ 2n` is a bijection from `ℕ` to the even naturals, so there are "as many" even numbers as natural numbers. Some definitions of "infinite" (Dedekind's) are based on exactly this property.

**Analogy: Hilbert's hotel.** A hotel has rooms 0, 1, 2, … and every room is occupied. A new guest arrives. Move the guest in room `n` to room `n + 1`. Everyone still has a room and room 0 is free. A full infinite hotel can still take another guest, which is impossible for a full finite hotel.

| Property | Finite sets | Infinite sets |
|---|---|---|
| Proper subset can have the same size | Never | Always possible |
| Injection `A → A` is automatically surjective | Yes | No (`n ↦ n + 1` on `ℕ` misses 0) |
| Adding one element changes the size | Yes | Not necessarily (`\|ℕ\| = \|ℕ ∪ {−1}\|`) |
| Size is a natural number | Yes | No, it is a cardinal such as `ℵ₀` |

Familiar finite rules still hold for finite sets: `|A × B| = |A| · |B|`, `|P(A)| = 2^|A|`, and `|A ∪ B| ≤ |A| + |B|`. Every subset of a finite set is finite.

```python
from itertools import count, islice

# ℕ is in bijection with its proper subset of even numbers
evens = (2 * n for n in count())
print(list(islice(evens, 6)))                 # [0, 2, 4, 6, 8, 10]

# Hilbert's hotel: n ↦ n + 1 is injective on ℕ but never produces 0
shift = lambda n: n + 1
print(0 in {shift(n) for n in range(1000)})   # False: room 0 is now free

# Finite case: an injection from a finite set to itself is automatically onto
n = 10
f = {x: (3 * x + 1) % n for x in range(n)}
print(len(set(f.values())) == n)              # True: injective, and therefore surjective
```

**Key takeaways**

- Two sets have the same cardinality when a bijection exists between them. This works for infinite sets too.
- `|A| ≤ |B|` means there is an injection from `A` to `B`.
- An infinite set can be the same size as a proper subset of itself. A finite set cannot.
- For finite sets, injective, surjective, and bijective coincide for maps from a set to itself.

> **Practice**
>
> 1. (Beginner) Give an explicit bijection showing `|ℕ| = |{n ∈ ℕ | n ≥ 5}|`.
> 2. (Intermediate) Prove that if `A` is finite and `f: A → A` is injective, then `f` is surjective. *Hint:* compare `|f(A)|` with `|A|`.
> 3. (Interview) Hilbert's hotel is full. Infinitely many buses arrive, and each bus carries infinitely many passengers, numbered 0, 1, 2, …. Assign every current guest and every passenger a room so that no room is shared. *Hint:* send current guests to rooms `2ⁿ` and passenger `j` of bus `i` to `3^(i+1) · 5^j`. Why can no two people collide?

#### Countable Sets

**Why.** A set is countable if its elements can be listed one after another so that each element appears at some finite position. This is exactly the kind of set a program can enumerate given unlimited time, which makes countability the right notion of size for computing.

**What.** A set is **countable** if it is finite or has a bijection with `ℕ`. In the second case it is **countably infinite**, with cardinality `ℵ₀` ("aleph-null"). The following conditions are equivalent for a non-empty set `A`:

- `A` is countable.
- There is an injection `A → ℕ`.
- There is a surjection `ℕ → A`, that is, a list `a₀, a₁, a₂, …` in which every element appears (repeats allowed).

**Examples.**

| Set | Listing that reaches every element |
|---|---|
| `ℤ` | `0, −1, 1, −2, 2, …` (the zig-zag bijection from 2.2) |
| `ℕ × ℕ` | Walk the diagonals `x + y = 0, 1, 2, …` |
| `ℚ` | Each rational is `p/q` with `(p, q) ∈ ℤ × ℤ⁺`, a countable set. List those pairs and skip duplicates |
| `Σ*`, all finite strings over a finite alphabet | Shortlex: by length, then alphabetically within each length |
| All programs in any language | A program is a finite string, so this is a subset of `Σ*` |
| Countable union of countable sets | Interleave the lists (diagonally) |

**The diagonal walk.** Listing `ℕ × ℕ` row by row, `(0,0), (0,1), (0,2), …`, never reaches `(1, 0)`, because the first row is infinite. Walking the diagonals reaches every pair after finitely many steps:

```text
          y=0      y=1      y=2      y=3
  x=0   (0,0)₀   (0,1)₂   (0,2)₅   (0,3)₉   …
  x=1   (1,0)₁   (1,1)₄   (1,2)₈     …
  x=2   (2,0)₃   (2,1)₇     …
  x=3   (3,0)₆     …
         subscript = position in the list
```

The position of `(x, y)` is given by the **Cantor pairing function** `π(x, y) = (x + y)(x + y + 1)/2 + y`, which is a bijection `ℕ × ℕ → ℕ`.

**Pitfall.** A listing must reach every element *after finitely many steps*. "First all the positive numbers, then the negative ones" is not a valid listing of `ℤ`, because the negative numbers never get a position.

```python
from itertools import count, islice, product
from math import isqrt

def pairs():
    """Enumerate ℕ × ℕ diagonal by diagonal."""
    for d in count():                       # d = x + y, the index of the diagonal
        for y in range(d + 1):
            yield (d - y, y)

def cantor_pair(x, y):
    return (x + y) * (x + y + 1) // 2 + y

def cantor_unpair(z):
    w = (isqrt(8 * z + 1) - 1) // 2         # the diagonal: largest w with w(w+1)/2 <= z
    y = z - w * (w + 1) // 2
    return (w - y, y)

print(list(islice(pairs(), 6)))             # [(0, 0), (1, 0), (0, 1), (2, 0), (1, 1), (0, 2)]
assert all(cantor_unpair(cantor_pair(x, y)) == (x, y) for x in range(200) for y in range(200))

def all_strings(alphabet):
    """Shortlex enumeration of Σ*: every finite string appears at a finite position."""
    for length in count():
        for chars in product(alphabet, repeat=length):
            yield "".join(chars)

print(list(islice(all_strings("ab"), 7)))   # ['', 'a', 'b', 'aa', 'ab', 'ba', 'bb']
```

**Key takeaways**

- Countable means finite or listable as `a₀, a₁, a₂, …` with every element at a finite position.
- `ℕ`, `ℤ`, `ℚ`, `ℕ × ℕ`, and the set of finite strings all have cardinality `ℵ₀`.
- The listing order matters. Diagonal walks and shortlex order reach every element, while row-by-row walks may not.
- The set of all programs is countable because every program is a finite string.

> **Practice**
>
> 1. (Beginner) Give an explicit listing of all odd integers, positive and negative, showing that the set is countable.
> 2. (Intermediate) Prove that the union of two countably infinite sets `A` and `B` is countable. Be careful if `A` and `B` overlap.
> 3. (Interview) Prove that the set of all valid Python programs is countable, without reference to how Python works beyond "a program is a text file". *Hint:* use the shortlex enumeration above and filter out the strings that are not valid programs. What does filtering do to countability?

#### Uncountable Sets

**Why.** Not every infinite set can be listed. Some are strictly larger than `ℕ`. Because programs are countable, this means there are more problems than programs, so some problems have no algorithm at all.

**What.** A set is **uncountable** if it is not countable. Standard examples:

- the real numbers `ℝ`, and any interval such as `(0, 1)`
- the power set `P(ℕ)`
- the set `{0, 1}^ℕ` of infinite bit sequences, equivalently the set of functions `ℕ → {0, 1}`

These all have the same cardinality, called the **continuum** `𝔠 = 2^ℵ₀`.

**Cantor's theorem.** For every set `A`, `|A| < |P(A)|`. No function `f: A → P(A)` is surjective.

*Proof.* Let `f: A → P(A)` be any function and define

```text
D = { a ∈ A | a ∉ f(a) }
```

Suppose `D = f(d)` for some `d ∈ A`. Then `d ∈ D` if and only if `d ∉ f(d) = D`, which is a contradiction. So `D` is not in the range of `f`, and `f` is not onto. ∎

Applied repeatedly, the theorem gives an endless hierarchy `|ℕ| < |P(ℕ)| < |P(P(ℕ))| < …`. There is no largest infinity.

| Set | Countable? | Reason |
|---|---|---|
| `ℕ`, `ℤ`, `ℚ`, `ℕ × ℕ` | Yes | Explicit listings (previous topic) |
| Finite strings, programs | Yes | Shortlex enumeration |
| Finite subsets of `ℕ` | Yes | Each one is a finite bit string |
| Algebraic numbers | Yes | Each is a root of an integer polynomial, and those are finite lists of integers |
| `P(ℕ)`, infinite bit sequences | No | Cantor's theorem / diagonal argument |
| `ℝ`, `(0, 1)` | No | Diagonal argument (next topic) |
| Irrational numbers | No | Otherwise `ℝ = ℚ ∪ irrationals` would be a union of two countable sets |
| Functions `ℕ → ℕ` | No | Contains a copy of the functions `ℕ → {0, 1}` |

**Consequence for computing.** A decision problem can be viewed as a function `Σ* → {0, 1}` that answers yes or no for every input string. There are uncountably many such functions but only countably many programs, so most decision problems cannot be solved by any program. The halting problem (1.4, Chapter 13) is one explicit example.

```python
from itertools import product

# Cantor's theorem, verified exhaustively for a 3-element set:
# for every f: A -> P(A), the diagonal set D is missed.
A = [0, 1, 2]
subsets = [frozenset(a for i, a in enumerate(A) if mask >> i & 1) for mask in range(2 ** len(A))]

checked = 0
for images in product(subsets, repeat=len(A)):     # all 8³ = 512 functions A -> P(A)
    f = dict(zip(A, images))
    D = frozenset(a for a in A if a not in f[a])   # the diagonal set
    assert D not in f.values()                     # D is never in the range
    checked += 1
print(f"No surjection among {checked} functions")  # No surjection among 512 functions
```

**Key takeaways**

- Uncountable sets cannot be listed. `ℝ`, `P(ℕ)`, and infinite bit sequences are uncountable.
- Cantor's theorem: `|A| < |P(A)|` for every set, so there are infinitely many sizes of infinity.
- The proof builds the "diagonal" set `D = {a | a ∉ f(a)}`, which differs from every `f(a)`.
- Countably many programs but uncountably many problems means most problems are unsolvable.

> **Practice**
>
> 1. (Beginner) Classify as countable or uncountable: the set of finite subsets of `ℕ`, the set of all subsets of `ℕ`, the interval `[0, 0.001]`, the set of real roots of polynomials with integer coefficients.
> 2. (Intermediate) Prove that the set of irrational numbers is uncountable, using the facts that `ℝ` is uncountable and `ℚ` is countable.
> 3. (Interview) A colleague claims: "For every function `ℕ → {0, 1}`, someone could in principle write a program that computes it." Refute this using only cardinality, without the halting problem. *Hint:* how many programs are there, and how many functions `ℕ → {0, 1}`?

#### Cantor's Diagonal Argument

**Why.** The diagonal argument is one of the most reused ideas in mathematics and computer science. It proves that `ℝ` is uncountable, and the same pattern of self-reference proves the undecidability of the halting problem and Gödel's incompleteness theorem. Learning the pattern once lets you recognize it in all of these.

**What.** *Theorem.* The interval `(0, 1)` is uncountable.

*Proof.* Suppose, for contradiction, that `s₀, s₁, s₂, …` is a list of every real number in `(0, 1)`, each written as an infinite decimal. Build a new number `d` digit by digit: the `n`-th digit of `d` is chosen to **differ** from the `n`-th digit of `sₙ`. A safe rule is "use 5, unless that digit is 5, then use 4". Using only 4s and 5s avoids the double representation `0.4999… = 0.5000…`.

```text
  s₀ = 0 . [5]  1   0   4   1  …
  s₁ = 0 .  4  [1]  4   1   5  …
  s₂ = 0 .  9   2  [6]  5   3  …
  s₃ = 0 .  0   0   0  [0]  0  …
   ⋮                         ⋱
  d  = 0 .  4   5   5   5   …      digit n of d ≠ digit n of sₙ
```

For every `n`, `d` differs from `sₙ` in the `n`-th digit, so `d ≠ sₙ`. But `d ∈ (0, 1)`, so it should appear in the list. Contradiction. ∎

**The general pattern.** Arrange the objects in a table where row `i` describes the `i`-th object on input `j`. Then build a new object by flipping the diagonal. The new object disagrees with row `i` at position `i`, so it is not any row.

| Result | Rows | Columns | Diagonal object |
|---|---|---|---|
| `(0, 1)` is uncountable | Listed reals `sᵢ` | Digit positions | `d` with digit `n` ≠ digit `n` of `sₙ` |
| Cantor's theorem | Subsets `f(a)` | Elements `a` | `D = {a \| a ∉ f(a)}` |
| Russell's paradox | Sets `x` | Sets `x` | `{x \| x ∉ x}` |
| Halting problem | Programs `Pᵢ` | Inputs `j` | A program that does the opposite of `Pᵢ` on input `i` |

**Common mistakes.**

- *"Just add `d` to the list."* The argument applies to every list, including the new one. It shows that no list can be complete, not that one particular list is incomplete.
- *"Apply it to ℚ."* The constructed `d` need not be rational, so it does not have to be in the list of rationals and there is no contradiction.
- *"Apply it to finite strings."* The diagonal object is infinite, so it is not a finite string.

```python
def diagonal(enumeration):
    """Given enumeration(n) = the n-th infinite bit sequence (a function k -> bit),
    return a sequence that differs from every listed sequence."""
    return lambda k: 1 - enumeration(k)(k)        # flip bit k of sequence k

# One attempted list of all infinite bit sequences: sequence n = binary digits of n, then 0s
def enumeration(n):
    return lambda k: (n >> k) & 1

d = diagonal(enumeration)
assert all(d(n) != enumeration(n)(n) for n in range(10_000))   # differs from each sequence
print([d(k) for k in range(10)])   # [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
# The all-ones sequence is missing: every listed sequence eventually becomes all 0s.
```

**Key takeaways**

- Assume a complete list, build an object that differs from the `n`-th entry at position `n`, and conclude the list was incomplete.
- Choose replacement digits that avoid representation issues (such as trailing 9s).
- The same pattern proves Cantor's theorem, Russell's paradox, and the undecidability of the halting problem.
- The argument fails when the constructed object might lie outside the set, as with `ℚ` or finite strings.

> **Practice**
>
> 1. (Beginner) A list begins `s₀ = 0.1111…`, `s₁ = 0.2525…`, `s₂ = 0.5000…`, `s₃ = 0.3141…`. Using the rule "5 unless the digit is 5, then 4", write the first four digits of the diagonal number `d`.
> 2. (Intermediate) Use a diagonal argument to prove that the set of all functions `ℕ → ℕ` is uncountable. *Hint:* given a list `f₀, f₁, …`, define `g(n) = fₙ(n) + 1`.
> 3. (Interview) Why does the diagonal argument fail to show that the rationals in `(0, 1)` are uncountable? Point to the exact step that breaks. *Hint:* is the constructed `d` guaranteed to be in the set being listed?

#### Schröder–Bernstein Theorem

**Why.** Proving `|A| = |B|` requires a bijection, and explicit bijections can be awkward to build, for example between `(0, 1)` and `[0, 1]`. Injections in each direction are usually easy. The Schröder–Bernstein theorem says that is enough.

**What.** *Theorem (Schröder–Bernstein).* If there are injections `f: A → B` and `g: B → A`, then there is a bijection `A → B`. In cardinality notation: `|A| ≤ |B|` and `|B| ≤ |A|` imply `|A| = |B|`. This makes `≤` on cardinalities antisymmetric, one of the properties of a partial order (2.5).

**How.** Find an injection each way. They do not need to be related or surjective.

*Example 1.* `|(0, 1)| = |[0, 1]|`.
- `(0, 1) → [0, 1]`: the inclusion `x ↦ x`.
- `[0, 1] → (0, 1)`: `x ↦ (x + 1)/3`, whose values lie in `[1/3, 2/3] ⊂ (0, 1)`.
Both are injective, so the sets have the same cardinality. ∎

*Example 2.* `|ℕ × ℕ| = |ℕ|`.
- `ℕ → ℕ × ℕ`: `n ↦ (n, 0)`.
- `ℕ × ℕ → ℕ`: `(a, b) ↦ 2ᵃ · 3ᵇ`, which is injective by unique prime factorization (Chapter 4). ∎

*Example 3.* `|ℝ| = |P(ℕ)|`.
- `P(ℕ) → ℝ`: send `S` to the decimal `0.d₀d₁d₂…` with `dₙ = 1` if `n ∈ S` and `0` otherwise. Decimals using only the digits 0 and 1 have unique representations, so this is injective.
- `ℝ → P(ℚ)`: send `x` to `{q ∈ ℚ | q < x}`. Between two different reals there is a rational, so different reals give different sets. Since `ℚ` is countable, `P(ℚ)` has the same cardinality as `P(ℕ)`. ∎

**Proof idea.** Start at any element and alternately apply `f` and `g` forward, and their inverses backward as far as possible. Each element lies on exactly one **chain**:

```text
  … ──► a₀ ──f──► b₀ ──g──► a₁ ──f──► b₁ ──g──► a₂ ──► …
```

Going backward, a chain either stops at an element of `A` that is not in the range of `g`, stops at an element of `B` that is not in the range of `f`, or never stops. Define `h: A → B` by `h(a) = f(a)` on chains that stop in `A` or never stop, and `h(a) = g⁻¹(a)` on chains that stop in `B`. On every chain, `h` matches the `A`-elements with the `B`-elements one-to-one, so `h` is a bijection.

```python
def schroder_bernstein(a):
    """Bijection h: ℤ⁺ → ℤ⁺ built from the injections f(n) = 2n (A → B) and g(n) = 3n (B → A)."""
    x, side = a, "A"
    while True:                              # trace a's chain backward
        if side == "A":
            if x % 3 != 0:                   # x has no g-preimage: chain stops in A
                return 2 * a                 # use f
            x, side = x // 3, "B"
        else:
            if x % 2 != 0:                   # x has no f-preimage: chain stops in B
                return a // 3                # use g⁻¹
            x, side = x // 2, "A"

h = {a: schroder_bernstein(a) for a in range(1, 30_001)}
print([h[a] for a in range(1, 10)])                       # [2, 4, 1, 8, 10, 12, 14, 16, 3]
assert len(set(h.values())) == len(h)                     # injective on the tested range
assert set(range(1, 10_001)) <= set(h.values())           # every small value is reached
```

**Key takeaways**

- Injections `A → B` and `B → A` together guarantee a bijection.
- It is usually far easier to find two injections than one explicit bijection.
- The proof splits both sets into chains and chooses `f` or `g⁻¹` on each chain.
- The theorem makes `≤` on cardinalities antisymmetric.

> **Practice**
>
> 1. (Beginner) Use Schröder–Bernstein to show `|[0, 1]| = |[0, 2)|`. Give both injections explicitly.
> 2. (Intermediate) Show `|ℤ × ℤ| = |ℕ|` by giving explicit injections in both directions and proving each is injective.
> 3. (Interview) A teammate claims the set of all JSON documents is "bigger" than `ℕ` because documents can nest without limit. Settle the question with Schröder–Bernstein. *Hint:* map `n` to the JSON number literal `n`. For the other direction, serialize the document to bytes and read the bytes as a number, adding a leading 1 byte so that leading zeros are not lost.

<a id="24-relations"></a>
### 2.4 Relations

A relation generalizes a function. It is any set of pairs, so an element may be related to none, one, or many others. Relations model "follows", "depends on", "is less than", "is in the same team as", and, in their n-ary form, every table in a relational database.

#### Binary Relations

**Why.** Many connections are not functions. A student takes several courses, a user follows many accounts, and a number is less than infinitely many others. These connections still need a precise mathematical form.

**What.** A **binary relation** `R` from `A` to `B` is any subset `R ⊆ A × B`. We write `a R b` when `(a, b) ∈ R`. A relation **on** `A` is a relation from `A` to `A`, that is, a subset of `A × A`.

| | Function `f: A → B` | Relation `R ⊆ A × B` |
|---|---|---|
| Outputs per input | Exactly one | Any number, including zero |
| Formal object | Special subset of `A × B` | Any subset of `A × B` |
| Inverse | Exists only for bijections | `R⁻¹ = {(b, a) \| (a, b) ∈ R}` always exists |
| Examples | `x ↦ x²`, `user_id ↦ email` | `<`, "divides", "follows", "enrolled in" |

Every function is a relation, but most relations are not functions. Since a relation on an `n`-element set is any subset of the `n²` pairs in `A × A`, there are `2^(n²)` relations on it.

**Examples.**

- `<` on `ℤ`: `{(a, b) | a < b}`.
- Divisibility on `ℤ⁺`: `a ∣ b` iff `b = ak` for some integer `k`.
- Enrollment: `E ⊆ Students × Courses`, with `(s, c) ∈ E` when student `s` takes course `c`.
- Its inverse `E⁻¹ ⊆ Courses × Students` answers "who takes this course?".

```python
A = range(1, 7)
divides = {(a, b) for a in A for b in A if b % a == 0}    # a R b  iff  a | b
print((2, 6) in divides, (6, 2) in divides)               # True False
print(len(divides))                                       # 14 of the 36 possible pairs

multiple_of = {(b, a) for (a, b) in divides}              # R⁻¹: "b is a multiple of a"
print((6, 2) in multiple_of)                              # True

def related_to(R, a):
    """All b with a R b. For a function this would always be exactly one element."""
    return {b for (x, b) in R if x == a}

print(sorted(related_to(divides, 2)))                     # [2, 4, 6]
```

**Key takeaways**

- A binary relation from `A` to `B` is any subset of `A × B`. Write `a R b` for `(a, b) ∈ R`.
- Functions are exactly the relations in which every input has exactly one partner.
- The inverse relation `R⁻¹` swaps every pair and always exists.
- An `n`-element set has `2^(n²)` relations on it.

> **Practice**
>
> 1. (Beginner) List the pairs of `R = {(a, b) ∈ {1, 2, 3, 4}² | a < b}`. How many are there? Describe `R⁻¹` in words.
> 2. (Intermediate) How many relations are there on a 3-element set `A`? How many of them are functions `A → A`?
> 3. (Interview) In a social network, "user `a` follows user `b`" is a relation `F`. Why is it not a function? Which product feature corresponds to `F⁻¹`? How would you store `F` so that both "whom does `a` follow?" and "who follows `b`?" are fast? *Hint:* one index per direction, at the cost of double writes.

#### Relation Representations (Matrices and Digraphs)

**Why.** The same relation can be stored and drawn in several ways, and each makes different questions easy. A matrix allows algebra and constant-time lookup, a directed graph shows structure at a glance, and an adjacency list is compact for sparse data. Directed graphs are also the link to graph theory (Chapter 8).

**What.** Let `R` be divisibility on `A = {1, 2, 3, 4}`:

```text
R = {(1,1), (1,2), (1,3), (1,4), (2,2), (2,4), (3,3), (4,4)}
```

**Zero-one matrix.** Number the elements `a₁, …, aₙ`. The matrix `M_R` has `mᵢⱼ = 1` if `aᵢ R aⱼ` and `0` otherwise. The row is the first component and the column is the second.

```text
          1  2  3  4
     1 [  1  1  1  1 ]
M_R= 2 [  0  1  0  1 ]
     3 [  0  0  1  0 ]
     4 [  0  0  0  1 ]
```

**Directed graph (digraph).** Draw one vertex per element and an arrow `a → b` for each pair `(a, b) ∈ R`. A pair `(a, a)` is a **loop**, drawn here as `↺`.

```text
      ↺                ↺
      1 ─────────────► 2
      │ ╲              │
      │   ╲            │
      ▼     ╲          ▼
      3       ╲──────► 4
      ↺                ↺
```

**Adjacency list.** For each element, list the elements it is related to: `1: [1, 2, 3, 4]`, `2: [2, 4]`, `3: [3]`, `4: [4]`.

| Representation | Space | Test `a R b` | List all `b` with `a R b` | Best for |
|---|---|---|---|---|
| Set of pairs (hash set) | `O(\|R\|)` | `O(1)` average | `O(\|R\|)` | Simple code, membership tests |
| Zero-one matrix | `O(n²)` | `O(1)` | `O(n)` | Dense relations, algebraic operations |
| Adjacency list | `O(n + \|R\|)` | `O(deg a)` | `O(deg a)` | Sparse relations, graph traversal |

**Operations as matrix algebra.** For relations on the same set:

| Relation operation | Matrix operation |
|---|---|
| `R ∪ S` | Element-wise OR |
| `R ∩ S` | Element-wise AND |
| `R⁻¹` | Transpose |
| Composition `S ∘ R` | Boolean matrix product `M_R ⊙ M_S` (next topics) |

```python
A = [1, 2, 3, 4]
R = {(a, b) for a in A for b in A if b % a == 0}

idx = {a: i for i, a in enumerate(A)}
M = [[0] * len(A) for _ in A]
for a, b in R:
    M[idx[a]][idx[b]] = 1                  # row = first component, column = second

for row in M:
    print(row)
# [1, 1, 1, 1]
# [0, 1, 0, 1]
# [0, 0, 1, 0]
# [0, 0, 0, 1]

adj = {a: sorted(b for (x, b) in R if x == a) for a in A}
print(adj)                                  # {1: [1, 2, 3, 4], 2: [2, 4], 3: [3], 4: [4]}

transpose = [list(col) for col in zip(*M)]  # matrix of R⁻¹
```

**Key takeaways**

- A relation can be stored as a set of pairs, a zero-one matrix, or an adjacency list, and drawn as a digraph.
- In the matrix, `mᵢⱼ = 1` means `aᵢ R aⱼ`. In the digraph, it means an arrow from `aᵢ` to `aⱼ`.
- Union, intersection, and inverse correspond to OR, AND, and transpose.
- Matrices suit dense relations. Adjacency lists suit sparse ones.

> **Practice**
>
> 1. (Beginner) Write the zero-one matrix and draw the digraph of `R = {(a, b) | a + b is even}` on `{1, 2, 3, 4}`.
> 2. (Intermediate) The matrix below represents a relation on `{1, 2, 3}`. List its pairs and describe the relation in words. Then give the matrix of its inverse.
>    ```text
>    [ 0 1 1 ]
>    [ 0 0 1 ]
>    [ 0 0 0 ]
>    ```
> 3. (Interview) A follow graph has `10⁷` users and an average of 200 follows per user. Estimate the memory needed for a bit matrix and for adjacency lists with 4-byte IDs. Which would you choose? *Hint:* `n²` bits versus about `n + |R|` integers.

#### Reflexive, Symmetric, Antisymmetric, Transitive Properties

**Why.** A handful of properties classify the most important relations. Equivalence relations and partial orders (2.5) are defined by them, and they decide which reasoning steps are valid. Transitivity, for example, is what lets a sorting algorithm conclude `a < c` from `a < b` and `b < c` without comparing `a` and `c`.

**What.** Let `R` be a relation on `A`.

| Property | Definition | In the digraph | In the matrix | Example | Non-example |
|---|---|---|---|---|---|
| Reflexive | `∀a (a R a)` | Loop at every vertex | Diagonal all 1 | `≤`, `=`, `⊆` | `<` |
| Irreflexive | `∀a ¬(a R a)` | No loops | Diagonal all 0 | `<`, `≠` | `≤` |
| Symmetric | `∀a ∀b (a R b → b R a)` | Every arrow has a reverse arrow | `M = Mᵀ` | `=`, "is a sibling of" | `≤` |
| Antisymmetric | `∀a ∀b (a R b ∧ b R a → a = b)` | No two-way arrows between distinct vertices | No `mᵢⱼ = mⱼᵢ = 1` with `i ≠ j` | `≤`, `⊆`, `∣` on `ℤ⁺` | "is a sibling of" |
| Transitive | `∀a ∀b ∀c (a R b ∧ b R c → a R c)` | Every two-step path has a direct shortcut | `M ⊙ M ≤ M` element-wise | `<`, `⊆`, "is an ancestor of" | "is the parent of" |

**Easily confused pairs.**

- *Symmetric and antisymmetric are not opposites.* Equality is both. The relation `{(1, 2), (2, 1), (1, 3)}` is neither.
- *Irreflexive is not the same as "not reflexive".* `{(1, 1)}` on `{1, 2}` is neither reflexive (no `(2, 2)`) nor irreflexive (has `(1, 1)`).
- *Vacuous truth applies.* The empty relation is symmetric, antisymmetric, and transitive, because no pairs exist to break the conditions.

**Worked example.** Divisibility on `ℤ⁺`:

- Reflexive: `a = a · 1`, so `a ∣ a`.
- Antisymmetric: if `b = ak` and `a = bj` with `a, b > 0`, then `a = ajk`, so `jk = 1` with positive integers, which forces `j = k = 1` and `a = b`.
- Transitive: if `b = ak` and `c = bj`, then `c = a(kj)`.
- Not symmetric: `1 ∣ 2` but `2 ∤ 1`.

On all of `ℤ`, divisibility is **not** antisymmetric, since `2 ∣ −2` and `−2 ∣ 2` but `2 ≠ −2`. The domain matters.

```python
def is_reflexive(R, A):   return all((a, a) in R for a in A)
def is_irreflexive(R, A): return all((a, a) not in R for a in A)
def is_symmetric(R):      return all((b, a) in R for (a, b) in R)
def is_antisymmetric(R):  return all(a == b or (b, a) not in R for (a, b) in R)

def is_transitive(R):
    succ = {}
    for a, b in R:
        succ.setdefault(a, set()).add(b)
    return all((a, c) in R for (a, b) in R for c in succ.get(b, ()))   # every a→b→c has a→c

A = range(1, 5)
relations = {
    "=":            {(a, b) for a in A for b in A if a == b},
    "<=":           {(a, b) for a in A for b in A if a <= b},
    "<":            {(a, b) for a in A for b in A if a < b},
    "divides":      {(a, b) for a in A for b in A if b % a == 0},
    "same parity":  {(a, b) for a in A for b in A if (a - b) % 2 == 0},
    "differ by 1":  {(a, b) for a in A for b in A if abs(a - b) == 1},
}
print(f"{'':13}" + "".join(f"{h:9}" for h in ["refl", "irrefl", "sym", "antisym", "trans"]).rstrip())
for name, R in relations.items():
    flags = [is_reflexive(R, A), is_irreflexive(R, A), is_symmetric(R),
             is_antisymmetric(R), is_transitive(R)]
    print(f"{name:13}" + "".join(f"{str(x):9}" for x in flags).rstrip())
#              refl     irrefl   sym      antisym  trans
# =            True     False    True     True     True
# <=           True     False    False    True     True
# <            False    True     False    True     True
# divides      True     False    False    True     True
# same parity  True     False    True     False    True
# differ by 1  False    True     True     False    False
```

**Key takeaways**

- Reflexive: everything is related to itself. Symmetric: every pair goes both ways. Antisymmetric: no two distinct elements are related both ways. Transitive: chains can be shortened.
- Symmetric and antisymmetric can both hold, or both fail.
- Each property has a simple picture in the digraph and in the matrix.
- Whether a property holds can depend on the underlying set, as with divisibility on `ℤ⁺` versus `ℤ`.

> **Practice**
>
> 1. (Beginner) Which of the five properties does `R = {(1,1), (2,2), (3,3), (1,2), (2,1)}` on `{1, 2, 3}` have?
> 2. (Intermediate) On `ℤ`, define `a R b` iff `ab ≥ 0`. Determine which properties hold and give a counterexample for each one that fails.
> 3. (Interview) A Java comparator `(a, b) -> a.score > b.score ? 1 : -1` makes `Collections.sort` occasionally throw "Comparison method violates its general contract!". Which property of the underlying order is violated? *Hint:* compute `compare(x, x)` and compare `compare(a, b)` with `compare(b, a)` when two scores are equal.

#### Composition of Relations

**Why.** Many useful relations are chains of simpler ones: "grandparent" is "parent of a parent", "friend of a friend" is two friendship steps, and a database join links two tables through a shared column. Composition is the operation that builds these chains.

**What.** For `R ⊆ A × B` and `S ⊆ B × C`, the **composition** is

```text
S ∘ R = { (a, c) | ∃b ∈ B  (a R b  ∧  b S c) }
```

`R` is applied first, matching the convention for functions in 2.2. Some texts write `R ; S` for the same relation.

```text
      R           S
  a ──────► b ──────► c        (a, c) ∈ S ∘ R  because some middle element b links them
```

**Powers.** For a relation on `A`, define `R¹ = R` and `Rⁿ⁺¹ = Rⁿ ∘ R`. Then `(a, b) ∈ Rⁿ` exactly when there is a path of length `n` from `a` to `b` in the digraph.

**Properties.**

- Composition is associative: `T ∘ (S ∘ R) = (T ∘ S) ∘ R`.
- `(S ∘ R)⁻¹ = R⁻¹ ∘ S⁻¹`.
- `R` is transitive if and only if `R² ⊆ R`. Every two-step path must already be a one-step pair.

**Example.** Let the parent relation be `P = {(ana, ben), (ben, cleo), (ben, dev), (cleo, eli)}`. Then

```text
P ∘ P = {(ana, cleo), (ana, dev), (ben, eli)}       the grandparent relation
```

**Matrix form.** `M_{S∘R} = M_R ⊙ M_S`, the **Boolean product**, which is matrix multiplication with AND in place of multiplication and OR in place of addition:

```text
(M_R ⊙ M_S)ᵢⱼ = OR over k of ( (M_R)ᵢₖ AND (M_S)ₖⱼ )
```

In words, `i` reaches `j` if some middle element `k` is reachable from `i` by `R` and reaches `j` by `S`.

```python
def compose(S, R):
    """S ∘ R = {(a, c) | ∃b: a R b and b S c}. R is applied first, as with functions."""
    S_from = {}
    for b, c in S:
        S_from.setdefault(b, set()).add(c)            # index S by its first component
    return {(a, c) for (a, b) in R for c in S_from.get(b, ())}

P = {("ana", "ben"), ("ben", "cleo"), ("ben", "dev"), ("cleo", "eli")}
print(sorted(compose(P, P)))     # [('ana', 'cleo'), ('ana', 'dev'), ('ben', 'eli')]

def bool_matmul(X, Y):
    """Boolean matrix product: entry (i, j) is 1 iff some k has X[i][k] = Y[k][j] = 1."""
    return [[int(any(X[i][k] and Y[k][j] for k in range(len(Y)))) for j in range(len(Y[0]))]
            for i in range(len(X))]

M = [[0, 1, 0],                  # R = {(1,2), (2,3)} on {1, 2, 3}
     [0, 0, 1],
     [0, 0, 0]]
print(bool_matmul(M, M))         # [[0, 0, 1], [0, 0, 0], [0, 0, 0]]   R² = {(1,3)}
```

In SQL, composition is a join on the middle column followed by a projection onto the outer columns:

```sql
-- grandparent = parent ∘ parent: join on the shared middle person
SELECT DISTINCT p1.parent AS grandparent, p2.child AS grandchild
FROM parent_of AS p1
JOIN parent_of AS p2 ON p1.child = p2.parent;
```

**Key takeaways**

- `S ∘ R` relates `a` to `c` when some middle element `b` has `a R b` and `b S c`.
- `Rⁿ` describes paths of length exactly `n` in the digraph.
- `R` is transitive if and only if `R² ⊆ R`.
- In matrix form, composition is a Boolean matrix product. In SQL, it is a join followed by a projection.

> **Practice**
>
> 1. (Beginner) For `R = {(1, 2), (2, 3), (3, 1)}` on `{1, 2, 3}`, compute `R²` and `R³`. What is special about `R³`?
> 2. (Intermediate) Prove that a relation `R` is transitive if and only if `R² ⊆ R`.
> 3. (Interview) "People you may know" suggests friends of friends who are not already friends and are not the user. Write the suggestion relation using composition, difference, and the identity relation, and estimate the cost per user if the average degree is `d`. *Hint:* `(F ∘ F) − F − {(a, a) | a ∈ A}`. The intermediate result has up to `d²` pairs per user.

#### Closures of Relations

**Why.** A relation often lacks a property we need, and we want to add as few pairs as possible to get it. The most important case is reachability: "does module A depend on module B, directly or indirectly?" is asking whether `(A, B)` is in the **transitive closure** of the direct-dependency relation.

**What.** The **closure** of `R` with respect to a property is the smallest relation that contains `R` and has the property. "Smallest" means that it is contained in every relation that contains `R` and has the property.

| Closure | Formula | Meaning in the digraph |
|---|---|---|
| Reflexive | `R ∪ Δ`, where `Δ = {(a, a) \| a ∈ A}` | Add a loop at every vertex |
| Symmetric | `R ∪ R⁻¹` | Add the reverse of every arrow |
| Transitive | `R⁺ = R ∪ R² ∪ R³ ∪ …` | Add `a → b` whenever there is a path from `a` to `b` |
| Reflexive-transitive | `R* = R⁺ ∪ Δ` | "Reachable in zero or more steps" |

On an `n`-element set, `R⁺ = R ∪ R² ∪ … ∪ Rⁿ`. A shortest path visits each vertex at most once, so it has at most `n` edges.

Not every property has a closure. Antisymmetry, for example, can only be gained by *removing* pairs, so there is no smallest antisymmetric relation containing a relation like `{(1, 2), (2, 1)}`.

**Example.** `R = {(1, 2), (2, 3), (3, 4)}` on `{1, 2, 3, 4}`.

```text
  R:            1 ──► 2 ──► 3 ──► 4

  R⁺ adds:      (1, 3), (2, 4)              paths of length 2
                (1, 4)                      path of length 3
  R⁺ = {(1,2), (1,3), (1,4), (2,3), (2,4), (3,4)}
```

**Warshall's algorithm** computes the transitive closure in `O(n³)` time. It considers each vertex `k` in turn as a possible intermediate stop. After step `k`, `W[i][j] = 1` exactly when there is a path from `i` to `j` whose intermediate vertices all come from the first `k` vertices.

```text
W[i][j]  ←  W[i][j]  OR  ( W[i][k]  AND  W[k][j] )
```

```python
def warshall(M):
    """Transitive closure of the relation with zero-one matrix M."""
    n = len(M)
    W = [row[:] for row in M]                # copy so the input is not modified
    for k in range(n):                       # allow vertex k as an intermediate stop
        for i in range(n):
            if W[i][k]:                      # i reaches k ...
                for j in range(n):
                    if W[k][j]:              # ... and k reaches j,
                        W[i][j] = 1          # so i reaches j
    return W

M = [[0, 1, 0, 0],                           # 1 → 2 → 3 → 4
     [0, 0, 1, 0],
     [0, 0, 0, 1],
     [0, 0, 0, 0]]
for row in warshall(M):
    print(row)
# [0, 1, 1, 1]
# [0, 0, 1, 1]
# [0, 0, 0, 1]
# [0, 0, 0, 0]
```

**Key takeaways**

- A closure is the smallest extension of `R` that has a given property.
- The reflexive closure adds `Δ`, the symmetric closure adds `R⁻¹`, and the transitive closure adds all paths.
- The transitive closure answers reachability questions. On `n` elements, paths of length up to `n` suffice.
- Warshall's algorithm computes the transitive closure in `O(n³)`. Some properties, such as antisymmetry, have no closure.

> **Practice**
>
> 1. (Beginner) For `R = {(1, 2), (2, 1), (2, 3)}` on `{1, 2, 3}`, find the reflexive, symmetric, and transitive closures.
> 2. (Intermediate) Find a relation `R` such that taking the symmetric closure and then the transitive closure gives a different result from taking the transitive closure and then the symmetric closure.
> 3. (Interview) A monorepo has 50,000 packages and their direct dependencies. Engineers want to know which packages must be rebuilt when package `X` changes. Would you precompute the full transitive closure, or answer each query with a graph search? *Hint:* the closure can contain `Θ(n²)` pairs, while a breadth-first search on the reversed dependency graph costs `O(n + m)` per query.

#### N-ary Relations and Databases

**Why.** Real records have more than two fields. A student has an ID, a name, and a major. A relational database stores exactly this kind of data, and the relational model introduced by E. F. Codd in 1970 is built directly on n-ary relations.

**What.** An **n-ary relation** on sets `A₁, …, Aₙ` is a subset of `A₁ × A₂ × … × Aₙ`. Its elements are n-tuples, and `n` is its **degree**.

| Database term | Mathematical term |
|---|---|
| Table | n-ary relation |
| Row | n-tuple |
| Column | Position in the tuple, with its domain `Aᵢ` |
| Primary key | Columns whose values determine the whole tuple |

A **primary key** makes the mapping from key values to rows a function: no two rows share a key. A key made of several columns is a **composite key**.

**Relational algebra.** Queries are built from a small set of operations on relations:

| Operation | Symbol | Result | SQL |
|---|---|---|---|
| Selection | `σ_P(R)` | Tuples of `R` that satisfy `P` | `WHERE` |
| Projection | `π_{cols}(R)` | Only the listed columns, duplicates removed | `SELECT DISTINCT cols` |
| Join | `R ⋈ S` | Pairs of tuples that agree on the shared attributes, combined | `JOIN … ON` |
| Cartesian product | `R × S` | Every combination of tuples | `CROSS JOIN` |
| Union, intersection, difference | `∪`, `∩`, `−` | Set operations on relations with the same columns | `UNION`, `INTERSECT`, `EXCEPT` |
| Rename | `ρ` | Same relation with new names | `AS` |

**Sets vs bags.** In the mathematical model a relation is a set, so it has no duplicate rows and no order. SQL tables and query results are actually multisets (2.1): `SELECT major FROM Students` can return `'CS'` twice. `SELECT DISTINCT` and `UNION` remove duplicates, while `UNION ALL` keeps them.

**Example.**

```text
Students                       Enrolled
id | name | major              student_id | course
---+------+------              -----------+---------------
 1 | Ana  | CS                          1 | Discrete Math
 2 | Ben  | Math                        1 | Databases
 3 | Cleo | CS                          3 | Discrete Math

Names of students enrolled in Discrete Math:
π_name( σ_{course = 'Discrete Math'}( Students ⋈_{id = student_id} Enrolled ) )  =  {Ana, Cleo}
```

```python
students = {            # Students(id, name, major)
    (1, "Ana", "CS"),
    (2, "Ben", "Math"),
    (3, "Cleo", "CS"),
}
enrolled = {            # Enrolled(student_id, course)
    (1, "Discrete Math"),
    (1, "Databases"),
    (3, "Discrete Math"),
}

def select(R, pred):                 # σ: keep tuples that satisfy pred
    return {t for t in R if pred(t)}

def project(R, *cols):               # π: keep chosen positions; the set removes duplicates
    return {tuple(t[i] for i in cols) for t in R}

def join(R, S, i, j):                # R ⋈ S on R[i] = S[j]: concatenate matching tuples
    return {r + s for r in R for s in S if r[i] == s[j]}

joined = join(students, enrolled, 0, 0)      # (id, name, major, student_id, course)
in_dm = select(joined, lambda t: t[4] == "Discrete Math")
print(sorted(project(in_dm, 1)))             # [('Ana',), ('Cleo',)]

print(sorted(project(enrolled, 1)))          # [('Databases',), ('Discrete Math',)]  no duplicates
print(sorted(project(students, 2)))          # [('CS',), ('Math',)]
```

```sql
SELECT DISTINCT s.name
FROM Students AS s
JOIN Enrolled AS e ON e.student_id = s.id
WHERE e.course = 'Discrete Math';
```

**Key takeaways**

- An n-ary relation is a subset of `A₁ × … × Aₙ`. A database table is an n-ary relation.
- Selection filters rows, projection keeps columns, and join combines tables on matching values.
- A primary key makes "key ↦ row" a function.
- The mathematical model uses sets. SQL uses multisets unless you ask for `DISTINCT`.

> **Practice**
>
> 1. (Beginner) Using the tables above, compute `π_course(Enrolled)` and `σ_{major = 'Math'}(Students)`.
> 2. (Intermediate) Write a relational-algebra expression for the IDs of students who are enrolled in no course, then translate it to SQL using `EXCEPT`.
> 3. (Interview) `SELECT major FROM Students` returns duplicates, but `π_major(Students)` does not. Give a query where this difference changes the answer, for example with `COUNT` or with `UNION` versus `UNION ALL`. *Hint:* SQL uses bag (multiset) semantics.

<a id="25-equivalence-relations-and-orders"></a>
### 2.5 Equivalence Relations and Orders

Two kinds of relations matter more than any others. Equivalence relations capture "the same in some respect", and orders capture "comes before". Equivalence relations underlie modular arithmetic, hashing, and union–find. Orders underlie sorting, scheduling, version control, and dependency resolution.

#### Equivalence Relations

**Why.** Programs constantly treat different values as "the same": strings that differ only in case, numbers with the same remainder, files with the same content, records that describe the same customer. An equivalence relation is the precise definition of a well-behaved "sameness".

**What.** A relation `~` on `A` is an **equivalence relation** if it is

- **reflexive:** `a ~ a` for every `a`,
- **symmetric:** `a ~ b` implies `b ~ a`, and
- **transitive:** `a ~ b` and `b ~ c` imply `a ~ c`.

| Relation | Set | Equivalence? |
|---|---|---|
| `a ≡ b (mod n)`, meaning `n ∣ (a − b)` | `ℤ` | Yes |
| Same length | Strings | Yes |
| Equal ignoring case | Strings | Yes |
| Same connected component | Vertices of an undirected graph | Yes |
| `f(a) = f(b)` for a fixed function `f` | Domain of `f` | Yes, always |
| `\|a − b\| ≤ 1` | `ℝ` | No: `0 ~ 1` and `1 ~ 2`, but not `0 ~ 2` |
| "Is a friend of" | People | No: not transitive, usually not reflexive |
| `≤` | `ℤ` | No: not symmetric |

**Equivalence via a key function.** For any function `f: A → B`, the relation `a ~ b ⟺ f(a) = f(b)` is an equivalence relation, because it inherits reflexivity, symmetry, and transitivity from `=`. In fact *every* equivalence relation has this form: take `f(a)` to be the class of `a` (next topic). In practice, the cleanest way to define "sameness" is to compute a **canonical form** (lowercase the string, reduce the number mod `n`, sort the letters) and compare canonical forms.

**Proof: congruence mod `n` is an equivalence relation.**

- Reflexive: `a − a = 0 = n · 0`, so `n ∣ (a − a)`.
- Symmetric: if `a − b = nk`, then `b − a = n(−k)`.
- Transitive: if `a − b = nk` and `b − c = nj`, then `a − c = n(k + j)`. ∎

**In code.** Python's `__eq__` must be an equivalence relation, and it must agree with `__hash__`: if `a == b` then `hash(a) == hash(b)`. Sets and dicts rely on both. Defining equality from a canonical key satisfies both requirements automatically.

```python
class Tag:
    """Tags compare case-insensitively: equality is the kernel of casefold()."""
    def __init__(self, name):
        self.name = name

    def _key(self):
        return self.name.casefold()            # canonical form

    def __eq__(self, other):
        return isinstance(other, Tag) and self._key() == other._key()

    def __hash__(self):
        return hash(self._key())               # equal objects must have equal hashes

tags = {Tag("Python"), Tag("python"), Tag("PYTHON"), Tag("Rust")}
print(len(tags))                               # 2

# A "tolerance" equality is NOT an equivalence relation: transitivity fails
close = lambda x, y: abs(x - y) <= 0.1
print(close(0.0, 0.08), close(0.08, 0.16), close(0.0, 0.16))   # True True False
```

**Key takeaways**

- An equivalence relation is reflexive, symmetric, and transitive.
- "Same value under a key function" is always an equivalence relation, and every equivalence relation can be written this way.
- Congruence mod `n` is the standard example and the basis of modular arithmetic (Chapter 4).
- Tolerance-based "approximately equal" relations are not transitive and must not be used as `__eq__`.

> **Practice**
>
> 1. (Beginner) Which of these are equivalence relations on `ℤ`? `a R b` iff `a + b` is even; `a R b` iff `a − b` is odd; `a R b` iff `|a| = |b|`.
> 2. (Intermediate) Prove that for any function `f: A → B`, the relation `a ~ b ⟺ f(a) = f(b)` is an equivalence relation on `A`.
> 3. (Interview) A `Point` class defines `__eq__` as "the distance between the points is less than `1e-9`" and is then used as a dictionary key. What can go wrong? *Hint:* check transitivity, and ask what `__hash__` could possibly return.

#### Equivalence Classes

**Why.** An equivalence relation sorts elements into groups of mutually equivalent elements. It is often simpler to work with the groups than with individual elements. The residue classes mod `n`, for example, are the "numbers" of modular arithmetic, and grouping anagrams is grouping by a class.

**What.** The **equivalence class** of `a` is

```text
[a] = { x ∈ A | x ~ a }
```

Any element of a class is a **representative** of it. The set of all classes is the **quotient set** `A/~`.

**Theorem.** For `a, b ∈ A`, the following are equivalent:

1. `a ~ b`
2. `[a] = [b]`
3. `[a] ∩ [b] ≠ ∅`

So two classes are either identical or disjoint. They never partially overlap.

*Proof of 3 ⇒ 1.* Let `c ∈ [a] ∩ [b]`. Then `c ~ a` and `c ~ b`. By symmetry `a ~ c`, and by transitivity `a ~ b`. ∎

**Example: congruence mod 3.**

```text
[0] = { …, −6, −3, 0, 3, 6, … }
[1] = { …, −5, −2, 1, 4, 7, … }        ℤ/3ℤ = { [0], [1], [2] }
[2] = { …, −4, −1, 2, 5, 8, … }
```

Infinitely many integers collapse into just three classes. `[1] = [4] = [−2]`, because these are three names for the same class.

**Canonical representatives.** To compute with classes, pick one standard representative per class: the remainder in `{0, …, n − 1}`, the lowercase spelling, the sorted letters. Grouping by that representative computes the classes.

```python
from collections import defaultdict

def classes(items, key):
    """Equivalence classes of x ~ y  ⟺  key(x) == key(y)."""
    groups = defaultdict(list)
    for x in items:
        groups[key(x)].append(x)        # key(x) is the canonical representative of [x]
    return list(groups.values())

print(classes(range(-4, 6), lambda n: n % 3))
# [[-4, -1, 2, 5], [-3, 0, 3], [-2, 1, 4]]

words = ["listen", "google", "silent", "enlist", "gogole"]
print(classes(words, lambda w: "".join(sorted(w))))
# [['listen', 'silent', 'enlist'], ['google', 'gogole']]
```

**When there is no key function.** Sometimes the relation is given only as a list of "same as" pairs, for example duplicate-record pairs reported by a matcher. The smallest equivalence relation containing these pairs is their reflexive, symmetric, and transitive closure (2.4). The **union–find** (disjoint-set) structure computes its classes efficiently:

```python
from collections import defaultdict

def find(parent, x):
    while parent[x] != x:
        parent[x] = parent[parent[x]]     # path halving keeps the trees shallow
        x = parent[x]
    return x

def union(parent, a, b):
    parent[find(parent, a)] = find(parent, b)

parent = {x: x for x in "abcdef"}
for a, b in [("a", "b"), ("c", "d"), ("b", "d"), ("e", "f")]:   # known "same as" pairs
    union(parent, a, b)

groups = defaultdict(set)
for x in parent:
    groups[find(parent, x)].add(x)
print(sorted(sorted(g) for g in groups.values()))   # [['a', 'b', 'c', 'd'], ['e', 'f']]
```

**Key takeaways**

- `[a]` is the set of everything equivalent to `a`. The classes form the quotient set `A/~`.
- Two classes are either equal or disjoint, and `[a] = [b]` exactly when `a ~ b`.
- Compute classes by grouping on a canonical representative.
- If the relation is given as pairs, union–find computes the classes of its closure.

> **Practice**
>
> 1. (Beginner) List the equivalence classes of congruence mod 4 on `{0, 1, …, 11}`.
> 2. (Intermediate) On `ℤ × (ℤ − {0})`, define `(a, b) ~ (c, d)` iff `ad = bc`. Prove that `~` is an equivalence relation (transitivity needs care) and describe its classes. Which familiar number system is the quotient set?
> 3. (Interview) A deduplication model outputs pairs of record IDs it believes refer to the same customer. Produce groups of records that refer to the same customer, in near-linear time. *Hint:* the pairs generate an equivalence relation. Which data structure merges classes cheaply?

#### Partitions

**Why.** Splitting a set into non-overlapping groups is common: shards of a database, clusters of data points, the input classes of a test plan. Partitions turn out to be exactly the same thing as equivalence relations, viewed from a different angle.

**What.** A **partition** of `A` is a collection of subsets `A₁, A₂, …` (called **blocks**) such that

1. every block is non-empty,
2. the blocks are pairwise disjoint, and
3. their union is `A`.

```text
A = {1, 2, 3, 4, 5, 6}
┌───────────────────────────────────┐
│  ┌────────┐ ┌────────┐ ┌────────┐ │
│  │ 3   6  │ │ 1   4  │ │ 2   5  │ │     blocks of congruence mod 3
│  └────────┘ └────────┘ └────────┘ │
└───────────────────────────────────┘
```

| Collection (subsets of `{1, …, 6}`) | Partition? | Reason |
|---|---|---|
| `{1, 4}, {2, 5}, {3, 6}` | Yes | Non-empty, disjoint, covers everything |
| `{1, 2}, {2, 3}, {4, 5, 6}` | No | 2 appears in two blocks |
| `{1, 2, 3}, {4, 5}` | No | 6 is not covered |
| `{1, 2, 3}, {4, 5, 6}, ∅` | No | Empty block |

**Theorem (equivalence relations ↔ partitions).** The equivalence classes of an equivalence relation on `A` form a partition of `A`. Conversely, every partition defines an equivalence relation: `a ~ b` iff `a` and `b` are in the same block. These two constructions are inverse to each other, so equivalence relations on `A` and partitions of `A` are in one-to-one correspondence.

**Counting.** The number of partitions of an `n`-element set is the **Bell number** `Bₙ`: `1, 1, 2, 5, 15, 52, 203, …` for `n = 0, 1, 2, …`. By the theorem, a 3-element set has exactly 5 equivalence relations.

**Refinement.** Partition `P` **refines** `Q` if every block of `P` lies inside some block of `Q`. Congruence mod 6 refines congruence mod 3, because each class mod 6 lies inside one class mod 3. Refinement is a partial order on partitions (next topics).

**Equivalence partitioning in testing.** Inputs that the specification treats the same way form one class. Testing one representative per class, plus values at the class boundaries, gives good coverage with few tests.

```python
def is_partition(blocks, A):
    seen = set()
    for block in blocks:
        if not block or seen & block:          # empty block, or overlap with an earlier block
            return False
        seen |= block
    return seen == set(A)                      # the blocks must cover A

def relation_from_partition(blocks):
    """a ~ b iff a and b are in the same block."""
    return {(a, b) for block in blocks for a in block for b in block}

A = range(1, 7)
print(is_partition([{1, 4}, {2, 5}, {3, 6}], A))       # True
print(is_partition([{1, 2}, {2, 3}, {4, 5, 6}], A))    # False: overlap
print(is_partition([{1, 2, 3}, {4, 5}], A))            # False: 6 missing

R = relation_from_partition([{1, 4}, {2, 5}, {3, 6}])
print(R == {(a, b) for a in A for b in A if (a - b) % 3 == 0})   # True: congruence mod 3
```

**Key takeaways**

- A partition splits a set into non-empty, pairwise disjoint blocks that cover it.
- Equivalence relations and partitions are the same information: classes are blocks, and blocks define "same block" relations.
- The number of partitions of an `n`-element set is the Bell number `Bₙ`.
- One representative per block plus boundary values is the basis of equivalence-partition testing.

> **Practice**
>
> 1. (Beginner) Which are partitions of `{1, …, 6}`? `{{1, 2}, {3, 4}, {5, 6}}`, `{{1, 2, 3, 4, 5, 6}}`, `{{1}, {2, 3}, {3, 4, 5, 6}}`.
> 2. (Intermediate) List all 5 partitions of `{a, b, c}`. For each, write the corresponding equivalence relation as a set of pairs.
> 3. (Interview) A validation function treats ages below 0 as invalid, 0–17 as minor, 18–64 as adult, 65–150 as senior, and above 150 as invalid. Design a minimal test set using equivalence partitioning and boundary-value analysis. *Hint:* one representative per block, plus the values on each side of every boundary.

#### Partial Orders

**Why.** Many "comes before" relations leave some pairs unordered. Two tasks may both depend on a third without depending on each other. Two Git branches may both descend from a commit without either containing the other. Partial orders describe exactly this: order where it exists, and no forced comparison where it does not.

**What.** A relation `≼` on `S` is a **partial order** if it is reflexive, antisymmetric, and transitive. The pair `(S, ≼)` is a **partially ordered set** (poset).

- `a` and `b` are **comparable** if `a ≼ b` or `b ≼ a`, and **incomparable** otherwise.
- A **strict partial order** `≺` is irreflexive and transitive, like `<` or `⊂`. Convert between the two with `a ≺ b ⟺ a ≼ b ∧ a ≠ b`.

| Poset | Comparable pair | Incomparable pair |
|---|---|---|
| `(ℤ, ≤)` | Every pair | None (it is a total order) |
| `(P({a, b}), ⊆)` | `{a} ⊆ {a, b}` | `{a}` and `{b}` |
| `(ℤ⁺, ∣)` | `2 ∣ 6` | 2 and 3 |
| Commits ordered by "is an ancestor of or equal to" | A commit and its descendant | Tips of two diverged branches |
| `ℕ²` with `(a, b) ≼ (c, d)` iff `a ≤ c` and `b ≤ d` | `(1, 2) ≼ (3, 4)` | `(1, 2)` and `(2, 1)` |

**Special elements.**

| Term | Meaning |
|---|---|
| Minimal element | Nothing is strictly below it |
| Least element | It is below everything (at most one exists) |
| Maximal element | Nothing is strictly above it |
| Greatest element | It is above everything (at most one exists) |
| Upper bound of `X` | An element above every element of `X` |
| Least upper bound (lub, supremum) | The least of the upper bounds, if there is one |
| Lower bound / greatest lower bound (glb, infimum) | Defined symmetrically |

Maximal is not the same as greatest. In `({2, 3, 4, 6}, ∣)`, both 4 and 6 are maximal (nothing in the set is a proper multiple of them), but neither is greatest, because `4 ∤ 6` and `6 ∤ 4`. Similarly, 2 and 3 are minimal, and there is no least element.

**In distributed systems.** Vector clocks order events by the component-wise order above. If neither clock is `≼` the other, the events are **concurrent**: neither could have influenced the other.

```python
def leq(u, v):
    """Component-wise order: u ≼ v iff u[i] <= v[i] for every i."""
    return all(a <= b for a, b in zip(u, v))

def compare(u, v):
    if leq(u, v) and leq(v, u):
        return "equal"
    if leq(u, v):
        return "before"
    if leq(v, u):
        return "after"
    return "concurrent"                   # incomparable: neither happened before the other

print(compare((1, 0, 2), (2, 1, 2)))      # before
print(compare((2, 0, 0), (1, 3, 0)))      # concurrent
```

**Key takeaways**

- A partial order is reflexive, antisymmetric, and transitive. Some pairs may be incomparable.
- Strict partial orders (`<`, `⊂`) are irreflexive and transitive.
- Maximal and minimal elements can be many. Greatest and least elements are unique if they exist.
- Subsets, divisibility, Git ancestry, and vector clocks are all partial orders that are not total.

> **Practice**
>
> 1. (Beginner) In the poset `({1, 2, 3, 4, 6, 12}, ∣)`, find two incomparable elements, and the least and greatest elements if they exist.
> 2. (Intermediate) Prove that the component-wise order on `ℕ²` is a partial order but not a total order.
> 3. (Interview) A replicated key-value store uses vector clocks. Two replicas hold versions of the same key with clocks `(3, 1, 0)` and `(2, 2, 0)`. Which version should win? *Hint:* check whether either clock is `≼` the other. If they are incomparable, what must the system do instead of picking a winner?

#### Hasse Diagrams

**Why.** The digraph of a partial order is cluttered. Every element has a loop, and every chain `a ≼ b ≼ c` forces an extra arrow `a → c`. A Hasse diagram keeps only the edges that carry information, which makes the structure of a poset visible at a glance.

**What.** Say `b` **covers** `a` if `a ≺ b` and there is no `c` with `a ≺ c ≺ b`. In other words, `b` is directly above `a`. The **Hasse diagram** draws only the covering pairs:

1. Remove all loops, since reflexivity is implied.
2. Remove every edge implied by transitivity, keeping only covering pairs.
3. Draw every edge pointing upward and drop the arrowheads, so that "higher" means "greater".

`a ≼ b` holds exactly when there is an upward path from `a` to `b`.

**Example: `(P({a, b, c}), ⊆)`.**

```text
                 {a,b,c}
               /    |    \
          {a,b}   {a,c}   {b,c}
            | \   /   \   / |
            |  \ /     \ /  |
            |   X       X   |
            |  / \     / \  |
            | /   \   /   \ |
           {a}     {b}     {c}
               \    |    /
                    ∅
```

The full digraph would have 27 arrows (19 non-loop pairs plus 8 loops). The Hasse diagram has 12 edges.

**Example: divisors of 12 under divisibility.**

```text
         12
        /  \
      4      6
      |     /|
      |   /  |
      | /    |
      2      3
       \    /
         1
```

Reading the diagram: 1 is the least element and 12 is the greatest. 4 and 6 are incomparable, and so are 2 and 3, and 4 and 3. `2 ∣ 12` holds because there is an upward path `2 → 4 → 12`.

```python
def hasse_edges(S, leq):
    """Covering pairs (a, b): a < b with nothing strictly between them."""
    lt = lambda a, b: a != b and leq(a, b)
    return sorted((a, b) for a in S for b in S
                  if lt(a, b) and not any(lt(a, c) and lt(c, b) for c in S))

divisors = [1, 2, 3, 4, 6, 12]
print(hasse_edges(divisors, lambda a, b: b % a == 0))
# [(1, 2), (1, 3), (2, 4), (2, 6), (3, 6), (4, 12), (6, 12)]
```

**Key takeaways**

- A Hasse diagram draws only covering pairs, with greater elements placed higher.
- Loops and transitive edges are omitted because they can be recovered.
- `a ≼ b` exactly when there is an upward path from `a` to `b`.
- Minimal, maximal, least, and greatest elements are easy to read off the diagram.

> **Practice**
>
> 1. (Beginner) Draw the Hasse diagram of `({1, 2, 3, 5, 6, 10, 15, 30}, ∣)`. Compare its shape with the diagram of `P({a, b, c})`. Why are they the same?
> 2. (Intermediate) How many edges does the Hasse diagram of `(P(S), ⊆)` have when `|S| = n`? *Hint:* each edge adds exactly one element to a subset.
> 3. (Interview) Is the graph shown by `git log --graph` always the Hasse diagram of the "is an ancestor of" order? *Hint:* consider a `--no-ff` merge of a feature branch when `main` has not moved since the branch was created. Is the edge from the merge commit to its first parent a covering pair?

#### Total Orders

**Why.** Sorting needs every pair of elements to be comparable, otherwise there is no single correct position for each one. A total order is a partial order with no incomparable pairs: everything lines up.

**What.** A partial order `≼` on `S` is a **total order** (linear order) if every two elements are comparable:

```text
∀a ∀b  (a ≼ b  ∨  b ≼ a)
```

The corresponding strict order satisfies **trichotomy**: exactly one of `a ≺ b`, `a = b`, `b ≺ a` holds.

Related terms:

- A **chain** in a poset is a subset that is totally ordered. An **antichain** is a subset in which no two elements are comparable.
- A **well-order** is a total order in which every non-empty subset has a least element. `(ℕ, ≤)` is well-ordered, while `(ℤ, ≤)` and `(ℚ≥0, ≤)` are not. This is the basis of induction (Chapter 3).

| | Partial order | Total order | Well-order |
|---|---|---|---|
| Every pair comparable | Not required | Yes | Yes |
| Every non-empty subset has a least element | Not required | Not required | Yes |
| Example | `(P(S), ⊆)` | `(ℤ, ≤)` | `(ℕ, ≤)` |

**Lexicographic order.** Given total orders on `A` and `B`, order pairs by the first component and break ties with the second:

```text
(a₁, b₁) ≺ (a₂, b₂)   iff   a₁ ≺ a₂   or   (a₁ = a₂ and b₁ ≺ b₂)
```

This is how dictionaries order words and how multi-key sorts work. Lexicographic order on strings is total, but it is **not** a well-order: `b ≻ ab ≻ aab ≻ aaab ≻ …` descends forever. That is why the enumeration of all strings in 2.3 used **shortlex** order (by length first), which is a well-order.

```python
people = [("ana", 30), ("ben", 25), ("cleo", 30), ("dev", 25)]

# Lexicographic order on the key (age descending, name ascending)
print(sorted(people, key=lambda p: (-p[1], p[0])))
# [('ana', 30), ('cleo', 30), ('ben', 25), ('dev', 25)]

words = ["b", "ab", "aab", "a"]
print(sorted(words))                                   # ['a', 'aab', 'ab', 'b']   lexicographic
print(sorted(words, key=lambda s: (len(s), s)))        # ['a', 'b', 'ab', 'aab']   shortlex

# Version strings need lexicographic order on integer tuples, not on characters
versions = ["1.10.0", "1.2.3", "1.2.10"]
print(sorted(versions))                                            # ['1.10.0', '1.2.10', '1.2.3']
print(sorted(versions, key=lambda v: tuple(map(int, v.split(".")))))  # ['1.2.3', '1.2.10', '1.10.0']
```

**Key takeaways**

- A total order is a partial order in which every pair is comparable. Sorting requires one.
- Chains are totally ordered subsets. Antichains have no comparable pairs.
- Lexicographic order on tuples is total when each component order is total. Tuple keys in `sorted` use it.
- A well-order also requires every non-empty subset to have a least element. `ℕ` has one, `ℤ` does not.

> **Practice**
>
> 1. (Beginner) Which of these are total orders? `(ℤ, ≤)`, `(P({1, 2}), ⊆)`, `(ℤ⁺, ∣)`, strings under lexicographic order.
> 2. (Intermediate) Prove that lexicographic order on `ℕ × ℕ` is a total order. Is it a well-order?
> 3. (Interview) In the poset `(P({1, …, n}), ⊆)`, what is the length of the longest chain? Find an antichain with more than `n` elements for `n = 4`. *Hint:* a chain can grow one element at a time. For the antichain, consider all subsets of one fixed size.

#### Lattices

**Why.** In many posets, any two elements have a best common upper bound and a best common lower bound. Sets have union and intersection, numbers under divisibility have lcm and gcd, and security levels can always be combined. This structure, a lattice, appears in program analysis, access control, and replicated data types that must merge without conflicts.

**What.** A **lattice** is a poset in which every pair of elements `a, b` has

- a least upper bound, called the **join** `a ∨ b`, and
- a greatest lower bound, called the **meet** `a ∧ b`.

| Lattice | Order | Join `a ∨ b` | Meet `a ∧ b` |
|---|---|---|---|
| `P(S)` | `⊆` | `A ∪ B` | `A ∩ B` |
| `ℤ⁺` | `∣` | `lcm(a, b)` | `gcd(a, b)` |
| Any total order | `≤` | `max(a, b)` | `min(a, b)` |
| `ℕᵏ` | Component-wise `≤` | Component-wise max | Component-wise min |

**A poset that is not a lattice.** Below, `a` and `b` have two upper bounds, `c` and `d`, but `c` and `d` are incomparable, so there is no *least* upper bound.

```text
     c     d
     | \ / |
     |  X  |
     | / \ |
     a     b
```

Divisibility on `{1, 2, 3}` also fails, because 2 and 3 have no upper bound in the set at all.

**Laws.** Join and meet are commutative, associative, and idempotent (`a ∨ a = a`), and they satisfy absorption (`a ∨ (a ∧ b) = a`). These are the same laws as the set identities of 2.1, which is no accident: `(P(S), ⊆)` is a lattice. A lattice with a top `⊤` and a bottom `⊥` is **bounded**, and every finite lattice is bounded. Boolean algebra (Chapter 11) is a lattice with extra structure.

**Applications.**

| Area | Lattice | How join is used |
|---|---|---|
| Access control | Security levels (Public ≤ Internal ≤ Secret) | Combining data from two sources gets the join of their levels |
| Static analysis | Abstract values of variables | At a branch merge point, the analysis takes the join of both paths |
| CRDTs (replicated data) | Replica states | Replicas merge states with the join, so they converge in any order |

**Why join works for replication.** Because join is commutative, associative, and idempotent, replicas can receive updates in any order, grouped in any way, and even more than once, and still end in the same state.

```python
import math

def merge(u, v):
    """Join in the component-wise lattice: the least upper bound of two vectors."""
    return tuple(max(a, b) for a, b in zip(u, v))

# Grow-only counter CRDT: each replica counts its own increments in its own slot
r1, r2, r3 = (3, 0, 1), (1, 2, 1), (0, 0, 4)
a = merge(merge(r1, r2), r3)
b = merge(r3, merge(r2, r1))
print(a, a == b, merge(a, a) == a)    # (3, 2, 4) True True   order and duplicates do not matter
print(sum(a))                         # 9: the counter's value

print(math.lcm(12, 18), math.gcd(12, 18))   # 36 6   join and meet in (ℤ⁺, |)
```

**Key takeaways**

- A lattice is a poset in which every pair has a join (least upper bound) and a meet (greatest lower bound).
- `(P(S), ⊆)` with `∪, ∩`, `(ℤ⁺, ∣)` with lcm and gcd, and every total order with max and min are lattices.
- Join and meet are commutative, associative, idempotent, and absorptive.
- These laws let replicated systems merge states safely in any order.

> **Practice**
>
> 1. (Beginner) In `(ℤ⁺, ∣)`, compute `12 ∨ 18` and `12 ∧ 18`. In `(P({1, 2, 3}), ⊆)`, compute `{1, 2} ∨ {2, 3}` and `{1, 2} ∧ {2, 3}`.
> 2. (Intermediate) Is `({1, 2, 3, 4, 6, 12}, ∣)` a lattice? Is `({1, 2, 3, 12, 18}, ∣)`? Justify each answer by checking joins and meets.
> 3. (Interview) Why must the merge function of a state-based CRDT be commutative, associative, and idempotent? How does defining it as a lattice join guarantee all three? *Hint:* in a real network, messages arrive out of order, are batched differently on different replicas, and are sometimes delivered twice.

#### Topological Sorting

**Why.** Build systems, package managers, course schedules, spreadsheet recalculation, and database migrations all face the same problem: given "X must happen before Y" constraints, find one order that satisfies all of them. Topological sorting solves it.

**What.** A **linear extension** of a partial order `≼` is a total order `≤_T` that respects it: `a ≺ b` implies `a <_T b`. Every finite poset has at least one linear extension, and finding one is called **topological sorting**.

In graph terms, a directed graph has a topological order if and only if it has no directed cycle (it is a **DAG**). Its reachability relation is then a partial order. A cycle such as `A → B → A` makes the problem unsolvable.

**Key lemma.** Every finite non-empty poset has a minimal element. Start anywhere and keep stepping to a strictly smaller element. This cannot go on forever in a finite set without repeating, and a repeat would contradict antisymmetry.

**Kahn's algorithm** repeatedly removes a minimal element:

1. Compute the in-degree (number of prerequisites) of every vertex.
2. Put every vertex with in-degree 0 into a queue. These are the minimal elements.
3. Repeatedly remove a vertex from the queue, output it, and decrement the in-degree of its successors. Any successor that reaches 0 joins the queue.
4. If some vertices are never output, the graph has a cycle.

It runs in `O(V + E)` time. The order is usually not unique: whenever the queue holds several vertices, any of them can go next.

**Example: course prerequisites.**

```text
 Intro Programming ──► Data Structures ──┐
                                         ▼
 Discrete Math ────────────────────► Algorithms ──► Compilers
       │                                                ▲
       └──────────► Theory of Computation ──────────────┘
```

Valid orders include
`Intro, Discrete, Data Structures, Theory, Algorithms, Compilers` and
`Discrete, Theory, Intro, Data Structures, Algorithms, Compilers`.

```python
from collections import deque

def topological_sort(nodes, edges):
    """Kahn's algorithm. Each edge (a, b) means a must come before b."""
    succ = {v: [] for v in nodes}
    indeg = {v: 0 for v in nodes}
    for a, b in edges:
        succ[a].append(b)
        indeg[b] += 1
    ready = deque(v for v in nodes if indeg[v] == 0)    # minimal elements: no prerequisites
    order = []
    while ready:
        v = ready.popleft()
        order.append(v)
        for w in succ[v]:                               # removing v may make w minimal
            indeg[w] -= 1
            if indeg[w] == 0:
                ready.append(w)
    if len(order) != len(nodes):
        raise ValueError("cycle detected: no topological order exists")
    return order

courses = ["Intro", "Discrete", "DataStructures", "Algorithms", "Theory", "Compilers"]
prereqs = [("Intro", "DataStructures"), ("DataStructures", "Algorithms"),
           ("Discrete", "Algorithms"), ("Discrete", "Theory"),
           ("Algorithms", "Compilers"), ("Theory", "Compilers")]
print(topological_sort(courses, prereqs))
# ['Intro', 'Discrete', 'DataStructures', 'Theory', 'Algorithms', 'Compilers']

try:
    topological_sort(["A", "B"], [("A", "B"), ("B", "A")])
except ValueError as e:
    print(e)                                            # cycle detected: no topological order exists
```

Python's standard library also provides `graphlib.TopologicalSorter`, which implements the same idea and supports parallel processing through its `get_ready()` and `done()` methods.

**Key takeaways**

- A topological sort is a linear extension: a total order consistent with all the "before" constraints.
- One exists exactly when the dependency graph has no directed cycle.
- Kahn's algorithm repeatedly outputs a minimal element and runs in `O(V + E)`.
- Topological orders are usually not unique, and any vertex in the ready queue can be processed next.

> **Practice**
>
> 1. (Beginner) Give two topological orders of the course graph above that differ from the two listed.
> 2. (Intermediate) Prove that a finite directed graph has a topological order if and only if it has no directed cycle. *Hint:* for one direction, show that a cycle makes an order impossible. For the other, show that a DAG always has a vertex with in-degree 0, then use induction on the number of vertices.
> 3. (Interview) A build tool must compile targets on `k` parallel workers while respecting dependencies. How would you adapt Kahn's algorithm, and what limits the speedup no matter how large `k` is? *Hint:* everything in the ready queue can run at the same time. Think about the longest dependency path, the critical path.

<a id="3-induction-and-recursion"></a>
## 3. Induction and Recursion

This chapter is about infinite families of objects that are each described by finite rules: sequences, sums, recursively built sets and data structures, and the programs that process them. Its main proof tool is mathematical induction, which turns "it holds at the start, and each step preserves it" into "it holds for every case". The same pattern explains why recursive functions return correct answers, why loops terminate, and how running times are counted.

<a id="31-sequences-and-summations"></a>
### 3.1 Sequences and Summations

Sequences are ordered lists of values indexed by integers, and summations add up their terms. This subchapter introduces the notation, the sequences and sums that appear most often in algorithm analysis, and techniques for reducing a sum to a closed formula.

#### Sequences

**Why.** Many quantities in computing come in an indexed series: the running time for inputs of size 1, 2, 3, …, the capacity of a growing buffer after each resize, the balance of an account month by month. We need a uniform way to name the `n`-th value and to describe the whole series by a finite rule.

**What.** A **sequence** is a function from a set of consecutive integers (usually `ℕ = {0, 1, 2, …}` or `ℤ⁺ = {1, 2, 3, …}`) to a set `S` (2.2). The image of `n` is written `a_n` and called the `n`-th **term**. The whole sequence is written `(a_n)` or `{a_n}`, or listed as `a_0, a_1, a_2, …`.

A **finite sequence** `a_1, a_2, …, a_n` is also called a **string** or **word** when its terms come from an alphabet. Its **length** is `n`, and the string of length 0 is the **empty string** `λ` (used heavily in Chapter 13).

There are two standard ways to specify a sequence:

| Specification | Form | Example | Computing `a_n` |
|---|---|---|---|
| Explicit (closed form) | `a_n = f(n)` | `a_n = 2n + 1` | Directly, in one evaluation |
| Recursive | Initial term(s) plus a rule using earlier terms | `a_0 = 1`, `a_n = a_{n−1} + 2` | Step by step from `a_0` |

Both describe the same sequence `1, 3, 5, 7, …`. Converting a recursive specification into an explicit one is called **solving the recurrence** (Chapter 6).

**Monotonicity.** A sequence is **increasing** if `a_n < a_{n+1}` for all `n`, and **non-decreasing** if `a_n ≤ a_{n+1}`. Decreasing and non-increasing are defined symmetrically. The running time of most algorithms, as a function of input size, is non-decreasing.

**Finitely many terms never determine a sequence.** "Find the next term" puzzles have no unique answer. The sequence `1, 2, 4, 8, 16` looks like `2^n`, but it is also the start of the number of regions formed by joining `n` points on a circle with all possible chords, whose sixth term is 31, not 32. The first terms suggest a formula. Only a proof establishes it.

```text
   n points on a circle        1    2    3    4    5    6
   regions (all chords)        1    2    4    8   16   31   <- not 32
   2^(n-1)                     1    2    4    8   16   32
```

**Analogy.** An explicit formula is a random-access array: ask for index 1000 and get the answer immediately. A recursive definition is a linked list: to reach item 1000, you walk through the 999 before it.

```python
from itertools import islice
from math import comb

def explicit(n):
    return 2 * n + 1                           # a_n = 2n + 1

def recursive():
    a = 1                                      # a_0 = 1
    while True:                                # an infinite sequence as a lazy generator
        yield a
        a = a + 2                              # a_n = a_{n-1} + 2

print([explicit(n) for n in range(6)])         # [1, 3, 5, 7, 9, 11]
print(list(islice(recursive(), 6)))            # [1, 3, 5, 7, 9, 11]

def circle_regions(n):
    return comb(n, 4) + comb(n, 2) + 1         # closed form for the chord-regions sequence

print([circle_regions(n) for n in range(1, 8)])    # [1, 2, 4, 8, 16, 31, 57]
```

**Key takeaways**

- A sequence is a function whose domain is a set of consecutive integers. `a_n` is its `n`-th term.
- Sequences are specified explicitly (`a_n = f(n)`) or recursively (initial terms plus a rule).
- A finite sequence over an alphabet is a string. The empty string `λ` has length 0.
- No finite list of terms determines a sequence. A guessed formula must be proved.

> **Practice**
>
> 1. (Beginner) Give an explicit formula and a recursive definition for each sequence: `3, 7, 11, 15, …` and `2, 6, 18, 54, …`.
> 2. (Intermediate) Find two different explicit formulas that both begin `1, 2, 4` but differ at the fourth term. Then list the first five terms of `a_n = n² − n + 1` and of `b_0 = 1`, `b_n = b_{n−1} + 2(n − 1)` and explain why they agree.
> 3. (Interview) A log-processing service must expose "the `n`-th event" for an unbounded stream. When would you model it as a generator (recursive style) and when as an indexable function (explicit style)? *Hint:* compare the cost of reaching term `n`, the memory used, and whether terms can be recomputed independently.

#### Arithmetic and Geometric Progressions

**Why.** Two growth patterns dominate computing. Adding a fixed amount at each step (one more element, one more second) gives linear growth. Multiplying by a fixed factor (doubling a buffer, halving a search range, compounding interest) gives exponential growth. These patterns are the arithmetic and geometric progressions.

**What.**

| | Arithmetic progression | Geometric progression |
|---|---|---|
| Rule | Constant **difference** `d` between terms | Constant **ratio** `r` between terms |
| Recursive form | `a_0 = a`, `a_n = a_{n−1} + d` | `a_0 = a`, `a_n = r · a_{n−1}` |
| Explicit form | `a_n = a + n·d` | `a_n = a · r^n` |
| Example | `5, 8, 11, 14, …` (`a = 5`, `d = 3`) | `3, 6, 12, 24, …` (`a = 3`, `r = 2`) |
| Growth | Linear in `n` | Exponential if `\|r\| > 1`, decays to 0 if `\|r\| < 1` |
| Test | `a_{n+1} − a_n` is constant | `a_{n+1} / a_n` is constant (terms non-zero) |
| In computing | Array addresses, evenly spaced timestamps | Buffer doubling, exponential backoff, halving in binary search |

The two families are linked by logarithms and exponentials: if `(a_n)` is arithmetic, then `(2^{a_n})` is geometric, and if `(b_n)` is geometric with positive terms, then `(log b_n)` is arithmetic. This is why exponential growth looks like a straight line on a log-scale plot.

**How.** To identify a progression, compute consecutive differences and ratios. To find the `n`-th term, read off `a` (the term at index 0) and `d` or `r`, then use the explicit form. Watch the indexing: if the sequence starts at `a_1`, the formulas become `a_n = a_1 + (n − 1)d` and `a_n = a_1 · r^{n−1}`.

```text
 Arithmetic: address of A[i] = base + i * size      Geometric: dynamic array capacity after resizes
   base=1000, size=4                                  1 -> 2 -> 4 -> 8 -> 16 -> 32
   A[0]  A[1]  A[2]  A[3]                             ×2   ×2   ×2   ×2    ×2
   1000  1004  1008  1012   (d = 4)                   reaching capacity N takes only ~log2(N) resizes
```

```python
def classify(seq):
    diffs = {b - a for a, b in zip(seq, seq[1:])}
    ratios = {b / a for a, b in zip(seq, seq[1:]) if a != 0}
    if len(diffs) == 1:
        return f"arithmetic, d = {diffs.pop()}"
    if len(ratios) == 1 and 0 not in seq:
        return f"geometric, r = {ratios.pop()}"
    return "neither"

print(classify([5, 8, 11, 14]))       # arithmetic, d = 3
print(classify([3, 6, 12, 24]))       # geometric, r = 2.0
print(classify([1, 4, 9, 16]))        # neither  (squares: differences 3, 5, 7 grow)

# Exponential backoff: retry delays form a geometric progression, capped at a maximum
base, factor, cap = 0.1, 2, 5.0
delays = [min(base * factor**k, cap) for k in range(8)]
print(delays)                         # [0.1, 0.2, 0.4, 0.8, 1.6, 3.2, 5.0, 5.0]
```

**Key takeaways**

- Arithmetic: constant difference, `a_n = a + nd`, linear growth.
- Geometric: constant ratio, `a_n = a·r^n`, exponential growth or decay.
- Check the starting index. Starting at `a_1` shifts the exponent or multiplier to `n − 1`.
- Logarithms turn geometric progressions into arithmetic ones, and exponentials do the reverse.

> **Practice**
>
> 1. (Beginner) Classify each sequence and give its 10th term (counting the first listed term as `a_1`): `7, 4, 1, −2, …` and `81, 27, 9, 3, …`.
> 2. (Intermediate) A geometric progression has `a_2 = 12` and `a_5 = 96`. Find `a_0` and `r`. Can an arithmetic progression with `d ≠ 0` also be geometric?
> 3. (Interview) Why do dynamic arrays (Python `list`, Java `ArrayList`, C++ `std::vector`) grow capacity by a constant factor instead of a constant amount? *Hint:* count the total number of element copies needed to reach `n` elements under each policy. The closed forms in the next topics will make this precise.

#### Summation Notation

**Why.** Analysing algorithms constantly requires adding up long lists of terms: the work done by every iteration of a loop, the cost of every level of a recursion. Writing `a_1 + a_2 + ⋯ + a_n` is clumsy and ambiguous about the pattern. Summation notation states exactly which terms are added.

**What.** The sum of `a_m, a_{m+1}, …, a_n` is written

```text
     n
     Σ   a_i        written inline as  Σ_{i=m}^{n} a_i
    i=m
```

- `i` is the **index of summation**. It is a bound variable (1.2): renaming it to `j` or `k` changes nothing.
- `m` is the **lower limit** and `n` the **upper limit**. The sum has `n − m + 1` terms.
- If `n < m`, the sum is **empty** and equals 0, the identity for addition.
- `Σ_{x ∈ S} f(x)` sums `f` over all elements of a finite set `S`.
- Products use the same notation with `Π`. An empty product equals 1, which is why `0! = 1` and `x^0 = 1`.

A summation is exactly a `for` loop with an accumulator:

```python
def summation(a, m, n):
    total = 0                      # empty sum = 0
    for i in range(m, n + 1):      # i runs from m to n inclusive: n - m + 1 terms
        total += a(i)
    return total

print(summation(lambda i: i * i, 1, 4))     # 30 = 1 + 4 + 9 + 16
print(summation(lambda i: i * i, 5, 4))     # 0   (empty sum)
print(sum(i * i for i in range(1, 5)))      # 30   (the idiomatic one-liner)
```

**Manipulation rules.**

| Rule | Identity |
|---|---|
| Constant factor | `Σ c·a_i = c · Σ a_i` |
| Sum of sums | `Σ (a_i + b_i) = Σ a_i + Σ b_i` |
| Constant term | `Σ_{i=m}^{n} c = (n − m + 1)·c` |
| Splitting the range | `Σ_{i=m}^{n} a_i = Σ_{i=m}^{k} a_i + Σ_{i=k+1}^{n} a_i` for `m ≤ k < n` |
| Index shift (`j = i + s`) | `Σ_{i=m}^{n} a_i = Σ_{j=m+s}^{n+s} a_{j−s}` |
| Swapping a double sum | `Σ_{i=1}^{p} Σ_{j=1}^{q} a_{ij} = Σ_{j=1}^{q} Σ_{i=1}^{p} a_{ij}` |

The first two rules together are called **linearity**. Common mistakes: `Σ a_i·b_i ≠ (Σ a_i)(Σ b_i)`, and `Σ_{i=1}^{n} c = n·c`, not `c`.

**Nested loops are double sums.** The number of times the body runs is the sum over the outer index of the number of inner iterations. When the inner range depends on the outer index, the summation diagram is a triangle, and swapping the order of summation means reading it by columns instead of rows.

```text
for i in 1..4:              i\j  1  2  3  4
    for j in 1..i:           1   *                  rows:    Σ_{i=1}^{4} i = 1+2+3+4 = 10
        body()               2   *  *
                             3   *  *  *            columns: Σ_{j=1}^{4} (4 − j + 1) = 4+3+2+1 = 10
                             4   *  *  *  *
```

```python
n = 4
count = sum(1 for i in range(1, n + 1) for j in range(1, i + 1))
print(count)                                         # 10
print(sum(i for i in range(1, n + 1)))               # 10  (by rows)
print(sum(n - j + 1 for j in range(1, n + 1)))       # 10  (by columns)
```

**Key takeaways**

- `Σ_{i=m}^{n} a_i` has `n − m + 1` terms. The index is a bound variable.
- An empty sum is 0 and an empty product is 1.
- Linearity, range splitting, and index shifting are the core manipulation rules.
- Nested loops correspond to double sums, and the order of summation may be swapped.

> **Practice**
>
> 1. (Beginner) Evaluate `Σ_{i=1}^{5} (2i − 1)`, `Σ_{k=0}^{3} 2^k`, and `Π_{j=1}^{4} j`.
> 2. (Intermediate) Rewrite `Σ_{i=3}^{n+2} (i − 2)²` so that the index starts at 1. Then use linearity to express `Σ_{i=1}^{n} (3i + 2)` in terms of `Σ i` and `n`.
> 3. (Interview) Exactly how many times does `body()` run in `for i in range(n): for j in range(i + 1, n): body()`, and what common task does this loop perform? *Hint:* write the count as a double sum and reverse the order of summation, or count unordered pairs directly.

#### Closed Forms of Common Sums

**Why.** A sum like `Σ_{i=1}^{n} i` hides how big it is. A **closed form**, such as `n(n + 1)/2`, is a formula with a fixed number of operations regardless of `n`. It can be evaluated in constant time and immediately shows the growth rate (Chapter 10), which is usually what an analysis needs.

**What.**

| Sum | Closed form | Growth |
|---|---|---|
| `Σ_{i=1}^{n} 1` | `n` | `Θ(n)` |
| `Σ_{i=1}^{n} i` | `n(n + 1) / 2` | `Θ(n²)` |
| `Σ_{i=1}^{n} i²` | `n(n + 1)(2n + 1) / 6` | `Θ(n³)` |
| `Σ_{i=1}^{n} i³` | `(n(n + 1) / 2)²` | `Θ(n⁴)` |
| `Σ_{i=0}^{n} r^i`, `r ≠ 1` | `(r^{n+1} − 1) / (r − 1)` | `Θ(r^n)` if `r > 1`, `Θ(1)` if `0 < r < 1` |
| `Σ_{i=0}^{∞} r^i`, `\|r\| < 1` | `1 / (1 − r)` | constant |
| `Σ_{i=1}^{n} 1/i` (harmonic `H_n`) | no closed form; `H_n ≈ ln n + 0.5772` | `Θ(log n)` |

Rule of thumb: `Σ_{i=1}^{n} i^k` is `Θ(n^{k+1})`, just as the integral of `x^k` is `x^{k+1}/(k+1)`.

**How: the arithmetic series (Gauss's pairing).** Write the sum forwards and backwards and add the two lines column by column:

```text
  S =   1   +   2   + ... + (n-1) +   n
  S =   n   + (n-1) + ... +   2   +   1
 ---------------------------------------
 2S = (n+1) + (n+1) + ... + (n+1) + (n+1)   = n(n+1)      so   S = n(n+1)/2
```

More generally, any arithmetic series equals the number of terms times the average of the first and last terms.

**How: the geometric series (shift and subtract).** Multiply by `r` and subtract. Everything except two terms cancels:

```text
   S = 1 + r + r² + ... + r^n
  rS =     r + r² + ... + r^n + r^{n+1}
 -------------------------------------
  rS − S = r^{n+1} − 1               so   S = (r^{n+1} − 1)/(r − 1)
```

For `r = 2` this gives `1 + 2 + 4 + ⋯ + 2^n = 2^{n+1} − 1`: each power of two is one more than the sum of all smaller powers. This explains why a doubling dynamic array does `O(n)` total copying work: the copies form a geometric series dominated by its last term.

**Analogy.** A geometric series with `r = 1/2` is walking half the remaining distance to a wall with every step. You never pass the wall, so the total distance converges to 1.

```python
from fractions import Fraction

n = 100
assert sum(range(1, n + 1)) == n * (n + 1) // 2
assert sum(i**2 for i in range(1, n + 1)) == n * (n + 1) * (2 * n + 1) // 6
assert sum(i**3 for i in range(1, n + 1)) == (n * (n + 1) // 2) ** 2
assert sum(3**i for i in range(n + 1)) == (3**(n + 1) - 1) // (3 - 1)

# Partial sums of 1/2 + 1/4 + 1/8 + ... approach 1 but never reach it
print([str(sum(Fraction(1, 2**i) for i in range(1, k + 1))) for k in range(1, 6)])
# ['1/2', '3/4', '7/8', '15/16', '31/32']

# Dynamic array: copies made when doubling capacity from 1 up to n = 1024
copies = sum(2**i for i in range(10))      # 1 + 2 + ... + 512 elements copied
print(copies)                              # 1023 < 2 * 1024, so O(1) amortized per append
```

**Key takeaways**

- Closed forms replace an `n`-term sum by a constant-size formula that reveals the growth rate.
- `Σ i = n(n + 1)/2` (pairing) and `Σ r^i = (r^{n+1} − 1)/(r − 1)` (shift and subtract) are the two most used.
- A geometric series with `r > 1` is dominated by its largest term. With `|r| < 1` it is bounded by a constant.
- The harmonic sum `H_n` has no closed form but grows like `ln n`.

> **Practice**
>
> 1. (Beginner) Compute `1 + 2 + ⋯ + 200` and `1 + 3 + 9 + ⋯ + 3^6` using closed forms.
> 2. (Intermediate) Find a closed form for the sum of the first `n` odd numbers `1 + 3 + ⋯ + (2n − 1)` and for `Σ_{i=1}^{n} (3i + 2)`. Verify each for `n = 4`.
> 3. (Interview) An algorithm processes an input of size `n`, then recurses on an input of size `n/2`, then `n/4`, and so on down to 1, doing linear work at each level. What is the total work? How would the answer change if each level spawned two halves instead of one? *Hint:* write the work per level as a series. One case is geometric with `r = 1/2`, the other has `log₂ n` equal terms.

#### Telescoping Sums

**Why.** Some sums have no obvious pattern, but each term can be written as a difference of consecutive values of another sequence. Then almost everything cancels, leaving only the first and last values, like a collapsible telescope folding down to its two ends.

**What.** For any sequence `(a_n)`,

```text
  Σ_{i=1}^{n} (a_i − a_{i−1}) = a_n − a_0
```

because the sum is `(a_1 − a_0) + (a_2 − a_1) + ⋯ + (a_n − a_{n−1})` and every intermediate term appears once with `+` and once with `−`. This is the discrete analogue of the fundamental theorem of calculus: summing the differences of a sequence recovers the change in the sequence.

**How.** Find a sequence `a_i` such that the term you are summing equals `a_i − a_{i−1}` (or `a_{i+1} − a_i`). Partial fractions and factorial identities are the usual sources.

*Example 1.* `Σ_{i=1}^{n} 1/(i(i + 1))`. Partial fractions give `1/(i(i + 1)) = 1/i − 1/(i + 1)`.

```text
  (1/1 − 1/2) + (1/2 − 1/3) + (1/3 − 1/4) + ... + (1/n − 1/(n+1))
        ╰───────╯      ╰───────╯      ╰──── ... ───╯
         cancel         cancel            cancel
  = 1 − 1/(n+1) = n/(n+1)
```

*Example 2.* `Σ_{i=1}^{n} i·i!`. Since `(i + 1)! − i! = i!·(i + 1 − 1) = i·i!`, the sum telescopes to `(n + 1)! − 1! = (n + 1)! − 1`.

*Example 3: deriving `Σ i` without guessing.* Since `i² − (i − 1)² = 2i − 1`, summing from 1 to `n` gives `n² − 0² = 2·Σ i − n`, so `Σ i = (n² + n)/2`. The same trick with cubes, `i³ − (i − 1)³ = 3i² − 3i + 1`, derives the formula for `Σ i²`.

**In computing.** The potential method of amortized analysis is a telescoping argument. If an operation costs `c_i` and changes a potential function from `Φ_{i−1}` to `Φ_i`, then the total of `c_i + (Φ_i − Φ_{i−1})` over all operations equals the total actual cost plus `Φ_n − Φ_0`. The potential terms collapse.

```python
from fractions import Fraction
from math import factorial

n = 10
lhs = sum(Fraction(1, i * (i + 1)) for i in range(1, n + 1))
print(lhs, Fraction(n, n + 1))                       # 10/11 10/11

assert sum(i * factorial(i) for i in range(1, n + 1)) == factorial(n + 1) - 1

# Generic check: summing differences of any sequence recovers last − first
a = [5, 2, 9, 9, 4, 11]
diffs = [a[i] - a[i - 1] for i in range(1, len(a))]
print(sum(diffs), a[-1] - a[0])                      # 6 6
```

**Key takeaways**

- `Σ_{i=1}^{n} (a_i − a_{i−1}) = a_n − a_0`: all intermediate terms cancel.
- The skill is rewriting a term as a difference of consecutive values, often via partial fractions.
- Telescoping can derive closed forms such as `Σ i` from scratch.
- Amortized analysis with a potential function relies on a telescoping sum.

> **Practice**
>
> 1. (Beginner) Evaluate `Σ_{i=1}^{99} (√(i + 1) − √i)` and `Σ_{k=1}^{n} (2^k − 2^{k−1})`.
> 2. (Intermediate) Use `1/(i(i + 2)) = (1/2)(1/i − 1/(i + 2))` to find a closed form for `Σ_{i=1}^{n} 1/(i(i + 2))`. Why do two terms survive at each end instead of one?
> 3. (Interview) Explain why the total actual cost of `n` operations is at most the sum of their amortized costs `ĉ_i = c_i + Φ_i − Φ_{i−1}`, provided the potential satisfies `Φ_n ≥ Φ_0`. *Hint:* sum the definition of `ĉ_i` over all `i` and let the potential terms telescope.

<a id="32-mathematical-induction"></a>
### 3.2 Mathematical Induction

Induction proves statements of the form "for every integer `n ≥ n₀`, `P(n)`" by proving finitely many things. This subchapter covers the standard form, the strong form, their common foundation in the well-ordering principle, and the mistakes that make induction proofs fail.

#### Weak Induction

**Why.** Testing `Σ_{i=1}^{n} i = n(n + 1)/2` for a million values of `n` still leaves infinitely many unchecked. A direct proof needs a clever idea for each new formula. Induction gives a general method: instead of proving `P(n)` for each `n` separately, prove that the property *starts* and that it *propagates*.

**Analogy.** Picture an infinite row of dominoes. If the first domino falls, and every falling domino knocks over the next one, then every domino falls. You never need to watch domino number one million; the two facts together guarantee it.

**What.** The **principle of mathematical induction** (weak or ordinary induction) states that to prove `∀n ≥ n₀ P(n)`, it suffices to prove:

1. **Basis step:** `P(n₀)`.
2. **Inductive step:** `∀k ≥ n₀ (P(k) → P(k + 1))`.

In the inductive step, the assumption `P(k)` is the **inductive hypothesis (IH)**. As an inference rule (1.3):

```text
  P(n₀)
  ∀k ≥ n₀ (P(k) → P(k + 1))
  ─────────────────────────
  ∴ ∀n ≥ n₀ P(n)
```

The inductive step is proved like any conditional (1.4): take an arbitrary `k ≥ n₀`, assume `P(k)`, and derive `P(k + 1)`. You are not assuming what you want to prove. You are proving an implication, and the implication is what makes the chain of dominoes work.

**How: the proof template.**

```text
Theorem. For all integers n ≥ n₀, P(n).
Proof (by induction on n).
  Basis.  Show P(n₀) by direct computation.
  Inductive step.  Let k ≥ n₀ be arbitrary and assume P(k)   (IH).
          Write out P(k + 1), the goal.
          Rewrite the goal so that a P(k)-shaped piece appears, apply the IH, simplify.
          Therefore P(k + 1).
  By induction, P(n) holds for all n ≥ n₀.  ∎
```

**Example 1 (a sum).** *For all `n ≥ 1`, `1 + 2 + ⋯ + n = n(n + 1)/2`.*

Proof. Basis: for `n = 1`, the left side is 1 and the right side is `1·2/2 = 1`.
Inductive step: assume `1 + ⋯ + k = k(k + 1)/2` for some `k ≥ 1`. Then

```text
  1 + ... + k + (k + 1) = k(k + 1)/2 + (k + 1)       (IH applied to the first k terms)
                        = (k + 1)(k/2 + 1)
                        = (k + 1)(k + 2)/2           which is P(k + 1).  ∎
```

**Example 2 (divisibility).** *For all `n ≥ 0`, `3 ∣ n³ − n`.*

Proof. Basis: `0³ − 0 = 0 = 3·0`.
Inductive step: assume `3 ∣ k³ − k`. Then `(k + 1)³ − (k + 1) = k³ + 3k² + 3k + 1 − k − 1 = (k³ − k) + 3(k² + k)`. The first part is divisible by 3 by the IH and the second is a multiple of 3, so the sum is divisible by 3. ∎

**Example 3 (an inequality with a later start).** *For all `n ≥ 5`, `2^n > n²`.*

Proof. Basis: `2⁵ = 32 > 25 = 5²`. (The claim is false for `n = 2, 3, 4`, which is why `n₀ = 5`.)
Inductive step: assume `2^k > k²` with `k ≥ 5`. Then `2^{k+1} = 2·2^k > 2k²`. It remains to show `2k² ≥ (k + 1)²`, i.e. `k² ≥ 2k + 1`. This holds because `k ≥ 5` gives `k² ≥ 5k = 2k + 3k > 2k + 1`. ∎

**Induction is recursion.** An induction proof is a recipe that builds a proof of `P(n)` for any specific `n`: start from the basis and apply the inductive step `n − n₀` times. The structure is identical to a recursive function with a base case.

```python
def proof_of(n):
    """Produce the chain of steps that establishes P(n) from the basis P(0)."""
    if n == 0:
        return ["P(0) by the basis step"]
    return proof_of(n - 1) + [f"P({n - 1}) -> P({n}) by the inductive step"]

print(*proof_of(3), sep="\n")
# P(0) by the basis step
# P(0) -> P(1) by the inductive step
# P(1) -> P(2) by the inductive step
# P(2) -> P(3) by the inductive step

# Spot checks (not a proof) of the three examples above
assert all(sum(range(1, n + 1)) == n * (n + 1) // 2 for n in range(1, 500))
assert all((n**3 - n) % 3 == 0 for n in range(500))
assert all(2**n > n**2 for n in range(5, 500)) and not 2**4 > 4**2
```

**Key takeaways**

- Weak induction: prove the basis `P(n₀)` and the step `P(k) → P(k + 1)` for arbitrary `k ≥ n₀`.
- The inductive hypothesis is the premise of an implication, not an assumption of the result.
- In the step, locate a copy of `P(k)` inside `P(k + 1)`, apply the IH, and finish with algebra.
- The basis can start at any `n₀`. Choose it as the first value where the claim, and the step's reasoning, both hold.

> **Practice**
>
> 1. (Beginner) Prove by induction that `1 + 2 + 4 + ⋯ + 2^n = 2^{n+1} − 1` for all `n ≥ 0`.
> 2. (Intermediate) Prove that `n! > 2^n` for all `n ≥ 4`, and that `6 ∣ 7^n − 1` for all `n ≥ 0`.
> 3. (Interview) A `2^n × 2^n` grid has one arbitrary square removed. Prove that the rest can always be tiled with L-shaped trominoes (3-square L pieces). *Hint:* split the grid into four `2^{n−1} × 2^{n−1}` quadrants. One quadrant contains the missing square. Place a single tromino at the centre so that each of the other three quadrants is also missing exactly one square.

#### Strong Induction

**Why.** Sometimes `P(k + 1)` does not follow from `P(k)` alone but from some earlier case, or from several. To prove that `n` factors into primes, write `n = a·b`: the factors `a` and `b` can be anywhere below `n`, not just at `n − 1`. Strong induction lets the inductive step use *every* earlier case.

**Analogy.** Weak induction is a ladder where each rung rests on the one directly below. Strong induction is a staircase built from concrete: each new step rests on the whole solid structure beneath it.

**What.** The **principle of strong induction** (complete induction) states that to prove `∀n ≥ n₀ P(n)`, it suffices to prove:

1. **Basis step:** `P(n₀)`, and possibly `P(n₀ + 1), …, P(n₀ + b)` if the step needs to reach back `b + 1` places.
2. **Inductive step:** for every `k ≥ n₀ + b`, `(P(n₀) ∧ P(n₀ + 1) ∧ ⋯ ∧ P(k)) → P(k + 1)`.

| | Weak induction | Strong induction |
|---|---|---|
| Hypothesis in the step | `P(k)` only | `P(n₀), …, P(k)`: all earlier cases |
| Typical use | Sums, simple inequalities, one-step recurrences | Factorizations, multi-term recurrences, divide-and-conquer, games |
| Basis | Usually one case | As many cases as the step reaches back |
| Logical strength | Equivalent: each can be derived from the other | Equivalent |

Strong induction is no more powerful than weak induction. Applying weak induction to `Q(n) = P(n₀) ∧ ⋯ ∧ P(n)` turns any strong induction proof into a weak one. Use whichever form makes the step easiest to write.

**Example 1 (prime factorization exists).** *Every integer `n ≥ 2` is a product of one or more primes.*

Proof. Basis: 2 is prime, so it is a product of one prime.
Inductive step: assume every integer `j` with `2 ≤ j ≤ k` is a product of primes, and consider `k + 1`. If `k + 1` is prime, we are done. Otherwise `k + 1 = a·b` with `2 ≤ a, b ≤ k`. By the IH both `a` and `b` are products of primes, so their product is too. ∎

The IH was applied to `a` and `b`, whose values we do not know in advance. Weak induction would offer only `P(k)`, which is useless here.

**Example 2 (postage).** *Every amount `n ≥ 12` cents can be paid with 4-cent and 5-cent stamps.*

Proof. Basis: `12 = 4+4+4`, `13 = 4+4+5`, `14 = 4+5+5`, `15 = 5+5+5`.
Inductive step: let `k ≥ 15` and assume all amounts from 12 to `k` can be paid. Then `k + 1 − 4 = k − 3` lies between 12 and `k`, so it can be paid. Add one 4-cent stamp. ∎

Four basis cases are needed because the step reaches back four places. With only `n = 12` as the basis, the step for `k + 1 = 13` would rely on 9, which cannot be paid.

The proof is also an algorithm. Each recursive call corresponds to one use of the inductive hypothesis:

```python
def postage(n):
    """Return (fours, fives) with 4*fours + 5*fives == n, for n >= 12."""
    base = {12: (3, 0), 13: (2, 1), 14: (1, 2), 15: (0, 3)}   # the four basis cases
    if n in base:
        return base[n]
    fours, fives = postage(n - 4)                             # IH applied to n - 4, not n - 1
    return fours + 1, fives

for n in [12, 17, 23, 100]:
    f4, f5 = postage(n)
    assert 4 * f4 + 5 * f5 == n
    print(n, (f4, f5))
# 12 (3, 0)
# 17 (3, 1)
# 23 (2, 3)
# 100 (25, 0)
```

**Key takeaways**

- Strong induction assumes `P` for *all* values from `n₀` to `k` when proving `P(k + 1)`.
- Use it when the step needs cases other than the immediately preceding one, for example after splitting into factors or halves.
- Provide as many basis cases as the step reaches back. A missing basis case breaks the whole chain.
- Weak and strong induction are logically equivalent. A constructive strong induction proof is a recursive algorithm.

> **Practice**
>
> 1. (Beginner) Prove that every amount `n ≥ 8` cents can be paid with 3-cent and 5-cent stamps. How many basis cases do you need?
> 2. (Intermediate) Prove by strong induction that every positive integer is a sum of distinct powers of 2 (the existence of binary representation). Then prove that the Fibonacci numbers (`f_0 = 0`, `f_1 = 1`, `f_n = f_{n−1} + f_{n−2}`) satisfy `f_n < 2^n` for all `n ≥ 0`.
> 3. (Interview) Two players alternately remove 1 or 2 stones from a pile of `n`. Whoever takes the last stone wins. Prove that the first player has a winning strategy if and only if `n` is not a multiple of 3. *Hint:* use strong induction on `n`, with cases on `n mod 3`. Show that from a multiple of 3 every move leaves a non-multiple, and from a non-multiple some move leaves a multiple.

#### Well-Ordering Principle

**Why.** Why is induction valid at all? It cannot be proved from ordinary arithmetic alone. It rests on a basic property of the natural numbers, which also supports two other common arguments: the "minimal counterexample" proof and the proof that a loop terminates.

**What.** The **well-ordering principle (WOP)** states:

```text
  Every non-empty subset of ℕ has a least element.
```

This is what makes `(ℕ, ≤)` a well-order (2.5). It fails for other familiar number sets:

| Set | Well-ordered by `≤`? | A non-empty subset with no least element |
|---|---|---|
| `ℕ`, `ℤ⁺`, `{n ∈ ℤ \| n ≥ n₀}` | Yes | None exists |
| `ℤ` | No | `ℤ` itself (no smallest integer) |
| `ℚ≥0`, `ℝ≥0` | No | `{1/n \| n ∈ ℤ⁺}` (gets arbitrarily close to 0, never reaches it) |

**WOP implies induction.** Suppose `P(0)` and `∀k (P(k) → P(k + 1))` hold, but `P(n)` fails for some `n`. Then the set of counterexamples `C = {n ∈ ℕ | ¬P(n)}` is non-empty, so by WOP it has a least element `m`. `m ≠ 0` because `P(0)` holds. So `m − 1 ∈ ℕ` and `m − 1 ∉ C` because `m` is the least counterexample. Hence `P(m − 1)` holds, and the inductive step gives `P(m)`, contradicting `m ∈ C`. ∎ (Conversely, WOP can be proved by strong induction, so the three principles are equivalent.)

**How: proof by minimal counterexample.** Suppose the theorem is false, take the *smallest* counterexample `m`, and derive a contradiction, usually by constructing an even smaller counterexample. This is induction in contrapositive form.

*Example.* *Every integer `n ≥ 2` has a prime divisor.* Suppose not, and let `m` be the least integer `≥ 2` with no prime divisor. `m` is not prime (it would divide itself), so `m = a·b` with `2 ≤ a < m`. Since `a < m`, `a` has a prime divisor `p`, and `p ∣ a ∣ m`, a contradiction. ∎

**How: proving termination.** A strictly decreasing sequence of natural numbers must be finite. Otherwise its set of values would be a non-empty subset of `ℕ` with no least element. So, to prove that a loop terminates, find a **variant** (ranking function): an expression with natural-number values that strictly decreases on every iteration.

| Algorithm | Variant | Why it decreases |
|---|---|---|
| Euclid's `gcd(a, b)` | `b` | `b` is replaced by `a mod b < b` |
| Binary search | `hi − lo` | Each iteration discards at least one position |
| Bubble sort | Number of inversions | Each adjacent swap of an inverted pair removes exactly one inversion |
| Countdown `while n > 0: n -= 1` | `n` | Decremented by 1 |

```python
def gcd(a, b):
    """Euclid's algorithm for a, b >= 0, with the termination variant checked at run time."""
    while b != 0:
        old_variant = b
        a, b = b, a % b
        assert 0 <= b < old_variant      # the variant is a natural number and strictly decreases
    return a

print(gcd(252, 105))                     # 21

# By contrast, there is no known variant for the Collatz loop below.
# Whether it terminates for every n >= 1 is a famous open problem.
def collatz_steps(n):
    steps = 0
    while n != 1:
        n = n // 2 if n % 2 == 0 else 3 * n + 1
        steps += 1
    return steps

print(collatz_steps(27))                 # 111
```

**Key takeaways**

- WOP: every non-empty set of natural numbers has a least element. It fails for `ℤ`, `ℚ≥0`, and `ℝ≥0`.
- WOP, weak induction, and strong induction are equivalent. Each can be derived from the others.
- Minimal counterexample: assume a smallest failure exists, then produce a smaller one or another contradiction.
- A loop terminates if some natural-number-valued variant strictly decreases on every iteration.

> **Practice**
>
> 1. (Beginner) Which of these sets have a least element: `{n ∈ ℤ | n² > 50}`, `{n ∈ ℕ | n² > 50}`, `{x ∈ ℝ | x > 0}`, the set of positive even numbers that are not a sum of two primes?
> 2. (Intermediate) Use WOP to prove the existence half of the division algorithm: for integers `a` and `d > 0`, there exist integers `q` and `0 ≤ r < d` with `a = dq + r`. *Hint:* take `r` to be the least element of `{a − dq | q ∈ ℤ, a − dq ≥ 0}` and show it is less than `d`.
> 3. (Interview) Prove that "while some adjacent pair is out of order, swap it" terminates for every finite list, and bound the number of swaps. *Hint:* an inversion is a pair of positions `i < j` with `A[i] > A[j]`. What happens to the number of inversions after one adjacent swap, and what is its maximum value?

#### Common Induction Pitfalls

**Why.** An induction proof has few moving parts, so a flaw in any one of them invalidates the whole argument while the rest still looks convincing. Recognising the standard failure patterns is the fastest way to write correct proofs and to review other people's.

**What.**

| Pitfall | What goes wrong | Fix |
|---|---|---|
| Missing or wrong basis | The step is valid but the chain never starts | Always verify the basis explicitly, with real numbers |
| Step fails for small `k` | The step's argument silently needs `k` to be large enough | Check the step at the smallest `k` it is used for. Add basis cases or raise `n₀` |
| Too few basis cases in strong induction | The step reaches back further than the basis covers | Count how far back the IH is applied and cover that many base values |
| Assuming the conclusion | Start from `P(k + 1)` and derive a true statement | Start from the IH and derive `P(k + 1)`, or make sure every step is reversible |
| Hypothesis too weak | The IH does not give enough information to prove `P(k + 1)` | Prove a stronger statement (strengthen the IH) |
| "Build-up" error | `P(k + 1)` is proved only for objects built from a size-`k` object, not for every size-`k + 1` object | Start from an arbitrary object of size `k + 1` and reduce it to size `k` |

**Example 1 (missing basis).** *Claim: `n² + n` is odd for every `n ≥ 1`.* The step works: if `k² + k` is odd, then `(k + 1)² + (k + 1) = (k² + k) + 2(k + 1)` is odd plus even, which is odd. But the basis fails: `1² + 1 = 2` is even. In fact `n² + n = n(n + 1)` is always even. The step only shows that oddness would propagate, and there is no odd case to start from.

```python
step_ok = all((k*k + k) % 2 == 0 or ((k+1)**2 + (k+1)) % 2 == 1 for k in range(1000))
basis_ok = (1*1 + 1) % 2 == 1
print(step_ok, basis_ok)      # True False  -> the implication holds, but the chain never starts
```

**Example 2 (step fails for small `k`): "all horses are the same colour".** *Claim: in every set of `n ≥ 1` horses, all horses have the same colour.* Basis: one horse has one colour. Step: given `k + 1` horses, remove horse A. The remaining `k` share a colour by the IH. Put A back, remove horse B instead, and the remaining `k` again share a colour. The two groups overlap, so all `k + 1` share a colour.

```text
  k + 1 = 3:   {H1, H2, H3}  ->  {H2, H3} same colour,  {H1, H3} same colour,  overlap = {H3}   works
  k + 1 = 2:   {H1, H2}      ->  {H2} same colour,      {H1} same colour,      overlap = ∅      FAILS
```

The step needs the two groups to share a horse, which requires `k + 1 ≥ 3`. The case `1 → 2` is the broken domino, so nothing beyond `n = 1` follows.

**Example 3 (strengthening the hypothesis).** *Claim: `Σ_{i=1}^{n} 1/i² < 2` for all `n ≥ 1`.* A direct induction fails: knowing the sum is below 2 says nothing about whether adding `1/(k + 1)²` keeps it below 2. Prove the stronger claim `Σ_{i=1}^{n} 1/i² ≤ 2 − 1/n` instead. Then the IH is precise enough:

```text
  Σ_{i=1}^{k+1} 1/i² ≤ 2 − 1/k + 1/(k + 1)²  ≤  2 − 1/(k + 1)
  because   1/(k + 1)² ≤ 1/k − 1/(k + 1) = 1/(k(k + 1)).
```

The stronger statement is easier to prove because it gives the step more to work with. Experienced provers strengthen the hypothesis routinely.

**Example 4 (build-up error).** To prove a property of all connected graphs with `k + 1` vertices, it is tempting to take a connected graph with `k` vertices and add a vertex. But that only covers graphs that can be built this way, and you have to prove that every `(k + 1)`-vertex graph arises like that, which is often the hard part. The safe pattern is to start from an *arbitrary* `(k + 1)`-vertex graph, remove a suitable vertex, and apply the IH to what remains.

**Key takeaways**

- Check the basis with actual values. A valid step with a false basis proves nothing.
- Check that the inductive step works for the smallest `k` it is applied to.
- Argue forward from the IH to `P(k + 1)`, never backward from `P(k + 1)` to something true.
- If the IH is too weak to finish the step, strengthen the statement being proved.
- In the step, start from an arbitrary object of size `k + 1` and shrink it. Do not grow a size-`k` object.

> **Practice**
>
> 1. (Beginner) Find the error: "Claim: `n = n + 1` for all `n`. Step: if `k = k + 1`, adding 1 to both sides gives `k + 1 = k + 2`. Hence the claim holds by induction."
> 2. (Intermediate) Find the error: "Every set of `n ≥ 2` lines in the plane, no two parallel, passes through a common point. Basis: two non-parallel lines meet. Step: given `k + 1` lines, the first `k` meet at a point `p` and the last `k` meet at a point `q`. The `k − 1` lines in both groups pass through `p` and `q`, so `p = q`."
> 3. (Interview) A teammate proves "every tree with `n` vertices has `n − 1` edges" by taking a tree with `k` vertices and attaching a new leaf. Is the proof complete? What must be added, or how should the step be restructured? *Hint:* does every tree with `k + 1` vertices arise by attaching a leaf to a `k`-vertex tree? What property of trees (Chapter 9) would you need to prove first?

<a id="33-recursive-definitions"></a>
### 3.3 Recursive Definitions

A recursive definition describes an object in terms of smaller instances of itself, plus base cases that stop the regress. This subchapter applies the idea to functions, sets, and algorithms, introduces structural induction for proving facts about recursively defined objects, and finishes with loop invariants for proving iterative programs correct.

#### Recursively Defined Functions

**Why.** Many functions are easiest to state in terms of their own smaller values: `n! = n·(n − 1)!`, or "the number of ways to climb `n` stairs taking 1 or 2 steps at a time is the number of ways for `n − 1` plus the number for `n − 2`". A closed form may be unknown, complicated, or non-existent, while the recursive description is short and obviously right.

**What.** A function `f` with domain `ℕ` is **defined recursively** by:

1. **Basis step:** the value of `f` at one or more initial arguments, such as `f(0)`.
2. **Recursive step:** a rule giving `f(n)` in terms of `f` at smaller arguments.

Strong induction (3.2) guarantees that such a definition determines exactly one value for every `n`: the values at smaller arguments are already determined when `f(n)` is computed.

| Function | Basis | Recursive step |
|---|---|---|
| Factorial | `0! = 1` | `n! = n · (n − 1)!` |
| Power | `a^0 = 1` | `a^n = a · a^{n−1}` |
| Sum of a sequence | `Σ_{i=1}^{0} a_i = 0` | `Σ_{i=1}^{n} a_i = Σ_{i=1}^{n−1} a_i + a_n` |
| Fibonacci | `f_0 = 0`, `f_1 = 1` | `f_n = f_{n−1} + f_{n−2}` |
| GCD (Euclid) | `gcd(a, 0) = a` | `gcd(a, b) = gcd(b, a mod b)` for `b > 0` |

**Well-definedness.** A recursive "definition" must reach a base case from every argument, by steps that always land inside the domain. Two ways this fails:

- `f(n) = 1 + f(n + 1)`: the argument grows, so no base case is ever reached and `f` is not defined.
- `g(n) = g(n/2)` for even `n` and `g(n) = g(3n + 1)` for odd `n > 1`, with `g(1) = 1`: whether every argument reaches 1 is the open Collatz problem from 3.2. Nobody knows whether `g` is well-defined on all of `ℤ⁺`.

The safe pattern is the one in the table: every recursive call is made on an argument that is strictly smaller in a well-ordered set (3.2). Arguments need not shrink by 1. Euclid's algorithm shrinks the second argument, and the Ackermann function shrinks a pair of arguments in lexicographic order. That function is well-defined but grows faster than any function built from loops with bounds fixed in advance.

**Recursion and induction are partners.** Properties of a recursively defined function are proved by induction that follows the same structure as the definition.

*Example.* *For all `n ≥ 1`, `f_1 + f_2 + ⋯ + f_n = f_{n+2} − 1`.*
Basis: `f_1 = 1` and `f_3 − 1 = 2 − 1 = 1`.
Step: assume `f_1 + ⋯ + f_k = f_{k+2} − 1`. Then `f_1 + ⋯ + f_k + f_{k+1} = f_{k+2} − 1 + f_{k+1} = f_{k+3} − 1` by the Fibonacci rule. ∎

**Efficiency.** A definition that is mathematically correct can be computationally disastrous. Translating the Fibonacci definition literally recomputes the same values over and over. The number of calls is `2f_{n+1} − 1`, which grows exponentially. Caching each value after it is computed (**memoization**) makes the cost linear.

```text
 fib(5) call tree: fib(3) is computed twice, fib(2) three times, fib(1) five times
                         fib(5)
                  ┌────────┴────────┐
               fib(4)             fib(3)
            ┌─────┴─────┐       ┌───┴───┐
         fib(3)      fib(2)   fib(2)  fib(1)
        ┌──┴──┐      ┌──┴──┐  ┌──┴──┐
     fib(2) fib(1) fib(1) fib(0) fib(1) fib(0)
     ┌──┴──┐
  fib(1) fib(0)
```

```python
from functools import lru_cache

def factorial(n):
    return 1 if n == 0 else n * factorial(n - 1)     # basis | recursive step

calls = 0
def fib_naive(n):
    global calls
    calls += 1
    if n < 2:
        return n                                     # f_0 = 0, f_1 = 1
    return fib_naive(n - 1) + fib_naive(n - 2)

@lru_cache(maxsize=None)                             # memoization: each f_n computed once
def fib(n):
    return n if n < 2 else fib(n - 1) + fib(n - 2)

print(factorial(5))                                  # 120
print(fib_naive(20), calls)                          # 6765 21891   (21891 = 2*f_21 - 1)
print(fib(90))                                       # 2880067194370816120  (instant)
```

**Key takeaways**

- A recursive definition has a basis and a recursive step that uses values at smaller arguments.
- It is well-defined when every chain of recursive calls reaches a base case, which is guaranteed when arguments strictly decrease in a well-ordered set.
- Prove properties of recursively defined functions by induction that mirrors the definition.
- Direct translation can repeat work exponentially. Memoization or bottom-up iteration avoids this.

> **Practice**
>
> 1. (Beginner) Give a recursive definition of `m·n` for `m, n ∈ ℕ` using only addition, and of the sequence `a_n = 3^n + 1`. Compute `f_0` through `f_10`.
> 2. (Intermediate) Prove by induction that `f_{n+1}·f_{n−1} − f_n² = (−1)^n` for all `n ≥ 1` (Cassini's identity).
> 3. (Interview) Prove that the naive recursive Fibonacci makes exactly `2f_{n+1} − 1` calls on input `n`, and rewrite it to use `O(n)` time and `O(1)` extra space. *Hint:* let `C(n)` be the number of calls, write a recurrence for `C(n)` that resembles the Fibonacci rule, and prove the formula by strong induction. For the rewrite, keep only the last two values.

#### Recursively Defined Sets

**Why.** Many important collections are infinite but generated by a few rules: the natural numbers, all strings over an alphabet, all syntactically valid programs, all JSON documents, all binary trees. Listing them is impossible, but stating "these are the starting elements, and these rules build new elements from existing ones" captures the set exactly.

**What.** A set `S` is **defined recursively** by:

1. **Basis step:** specific elements that belong to `S`.
2. **Recursive step:** rules that build new elements of `S` from elements already known to be in `S`.
3. **Exclusion rule:** `S` contains nothing else. It is the *smallest* set closed under the rules.

The exclusion rule is usually left implicit, but it is essential. Without it, the rules "`0 ∈ S`; if `n ∈ S` then `n + 2 ∈ S`" would also be satisfied by `ℤ`, not just by the even naturals.

| Set | Basis | Recursive step |
|---|---|---|
| `ℕ` | `0 ∈ ℕ` | `n ∈ ℕ → n + 1 ∈ ℕ` |
| Strings `Σ*` over alphabet `Σ` | `λ ∈ Σ*` | `w ∈ Σ*`, `x ∈ Σ` → `wx ∈ Σ*` |
| Balanced parentheses `B` | `λ ∈ B` | `u, v ∈ B` → `(u)v ∈ B` |
| Full binary trees `T` | A single vertex is in `T` | `T₁, T₂ ∈ T` → a new root with left subtree `T₁` and right subtree `T₂` is in `T` |
| Lists of `A` | `Nil` (empty list) | `a ∈ A`, `L` a list → `Cons(a, L)` is a list |
| Arithmetic expressions `E` | Numbers and variables | `e₁, e₂ ∈ E` → `(e₁ + e₂)`, `(e₁ · e₂)`, `(−e₁)` are in `E` |

**How: generating elements in rounds.** Start with the basis elements, then repeatedly apply every rule to what you already have. Every element of `S` appears after finitely many rounds, and the round in which it first appears measures how many rule applications it needs. This is the same as producing the strings of a grammar (Chapter 13).

```text
Balanced parentheses B, rule: u, v ∈ B  ->  (u)v ∈ B

Round 0:  λ
Round 1:  ()                               u = λ,  v = λ
Round 2:  ()(),  (()),  (())()             new combinations using ()
Round 3:  ()()(), ()(()), (()()), ((())), ...
```

```python
def balanced_up_to(max_len):
    """Generate the recursively defined set B of balanced strings up to length max_len."""
    B = {""}                                           # basis: the empty string λ
    while True:
        new = {f"({u}){v}" for u in B for v in B       # recursive step: (u)v
               if len(u) + len(v) + 2 <= max_len}
        if new <= B:                                   # no new elements: closed under the rule
            return B
        B |= new

def is_balanced(s):
    """Membership test: each prefix has at least as many '(' as ')', and totals are equal."""
    depth = 0
    for c in s:
        depth += 1 if c == "(" else -1
        if depth < 0:
            return False
    return depth == 0

B6 = balanced_up_to(6)
print(sorted(B6, key=lambda s: (len(s), s)))
# ['', '()', '(())', '()()', '((()))', '(()())', '(())()', '()(())', '()()()']
print(len(B6), all(is_balanced(s) for s in B6))       # 9 True
```

The recursive definition and the counter-based membership test describe the same set. Proving that they agree is a typical use of structural induction (next topic).

**Data types are recursively defined sets.** An algebraic data type in a functional language, or a class whose fields refer to the class itself, is a recursive set definition in code:

```python
from dataclasses import dataclass
from typing import Optional

@dataclass
class Tree:                     # full binary tree: either a leaf (no children) or a root with two subtrees
    left: Optional["Tree"] = None
    right: Optional["Tree"] = None

leaf = Tree()                                  # basis
t = Tree(Tree(leaf, leaf), leaf)               # recursive step applied twice
```

**Key takeaways**

- A recursive set definition has a basis, recursive rules, and an exclusion rule: the set is the smallest one closed under the rules.
- Every element is produced by finitely many rule applications starting from basis elements.
- Strings, lists, trees, expressions, and grammars are all recursively defined sets.
- Recursive data types in code are recursive set definitions.

> **Practice**
>
> 1. (Beginner) Give recursive definitions of the set of positive multiples of 3, and of the set of palindromes over `{a, b}`.
> 2. (Intermediate) Let `S` be defined by `(3, 2) ∈ S`, and `(a, b) ∈ S → (a + 2, b + 3) ∈ S` and `(a + 3, b + 2) ∈ S`. List the elements produced in the first two rounds. Conjecture a property shared by all elements of `S` that involves `5 ∣ a + b`.
> 3. (Interview) Write a recursive definition of the set of valid JSON values, then sketch a recursive `validate(value)` function whose cases correspond to your rules. *Hint:* the basis covers `null`, booleans, numbers, and strings. The recursive step covers arrays of values and objects mapping strings to values.

#### Structural Induction

**Why.** Recursively defined sets such as trees, strings, and expressions are not naturally indexed by a single integer `n`. We could induct on size or height, but there is a more direct method whose shape matches the definition of the set exactly, the same way recursive code matches the shape of the data.

**What.** To prove that `P(x)` holds for every element `x` of a recursively defined set `S`:

1. **Basis step:** show `P(x)` for every basis element `x`.
2. **Recursive step:** for every rule that builds `x` from `x₁, …, x_m`, show that `P(x₁) ∧ ⋯ ∧ P(x_m)` implies `P(x)`.

Why it works: the elements for which `P` holds form a set that contains the basis and is closed under the rules. `S` is the *smallest* such set (the exclusion rule), so every element of `S` satisfies `P`. Equivalently, it is strong induction on the number of rule applications needed to build `x`. Ordinary weak induction is the special case where `S = ℕ`, with basis 0 and rule `n ↦ n + 1`.

**Example 1 (full binary trees).** Define for a full binary tree `T`:

| | Single vertex | Tree with root, subtrees `T₁` and `T₂` |
|---|---|---|
| Leaves `l(T)` | 1 | `l(T₁) + l(T₂)` |
| Internal vertices `i(T)` | 0 | `1 + i(T₁) + i(T₂)` |
| Height `h(T)` | 0 | `1 + max(h(T₁), h(T₂))` |
| Vertices `n(T)` | 1 | `1 + n(T₁) + n(T₂)` |

*Claim: `l(T) = i(T) + 1` for every full binary tree.*
Basis: a single vertex has `l = 1` and `i = 0`.
Recursive step: assume `l(T₁) = i(T₁) + 1` and `l(T₂) = i(T₂) + 1`. Then
`l(T) = l(T₁) + l(T₂) = i(T₁) + i(T₂) + 2 = (1 + i(T₁) + i(T₂)) + 1 = i(T) + 1`. ∎

*Claim: `n(T) ≤ 2^{h(T)+1} − 1`.*
Basis: `n = 1 = 2^1 − 1`.
Recursive step: with `h = h(T)`, both subtrees have height at most `h − 1`, so `n(T) = 1 + n(T₁) + n(T₂) ≤ 1 + 2(2^h − 1) = 2^{h+1} − 1`. ∎

The second claim is why a balanced binary search tree with `n` keys has height at least `log₂(n + 1) − 1` (Chapter 9).

```text
            •              l(T) = 4 leaves (○)
          ╱   ╲            i(T) = 3 internal (•)
         •     ○           l = i + 1  (holds)
        ╱ ╲                h(T) = 3, n(T) = 7 ≤ 2^4 − 1 = 15  (holds)
       ○   •
          ╱ ╲
         ○   ○
```

**Example 2 (strings).** Define the length of a string recursively: `len(λ) = 0` and `len(wx) = len(w) + 1`. Define concatenation by `w·λ = w` and `w·(vx) = (w·v)x`. *Claim: `len(w·v) = len(w) + len(v)`.* Use structural induction on `v`. Basis: `len(w·λ) = len(w) = len(w) + 0`. Step: `len(w·(vx)) = len((w·v)x) = len(w·v) + 1 = len(w) + len(v) + 1 = len(w) + len(vx)`. ∎

**Recursive code follows the same pattern.** A function defined by one case per rule of the data type is called **structural recursion**. It terminates, because each call is on a strictly smaller part, and its correctness proof is a structural induction with one case per branch.

```python
from dataclasses import dataclass
from typing import Optional

@dataclass
class Tree:
    left: Optional["Tree"] = None
    right: Optional["Tree"] = None

def is_leaf(t):
    return t.left is None and t.right is None

def leaves(t):       return 1 if is_leaf(t) else leaves(t.left) + leaves(t.right)
def internal(t):     return 0 if is_leaf(t) else 1 + internal(t.left) + internal(t.right)
def height(t):       return 0 if is_leaf(t) else 1 + max(height(t.left), height(t.right))
def size(t):         return 1 if is_leaf(t) else 1 + size(t.left) + size(t.right)

L = Tree()
t = Tree(Tree(L, Tree(L, L)), L)                     # the tree drawn above
print(leaves(t), internal(t), height(t), size(t))    # 4 3 3 7
assert leaves(t) == internal(t) + 1
assert size(t) <= 2 ** (height(t) + 1) - 1
```

**Key takeaways**

- Structural induction proves `P` for every element of a recursively defined set: basis elements, then one step per construction rule.
- In each step, assume `P` for the components and prove it for the constructed element.
- It is valid because of the exclusion rule. Weak induction on `ℕ` is the simplest special case.
- Structural recursion and structural induction share a shape: one case per rule.

> **Practice**
>
> 1. (Beginner) Prove by structural induction that every string in the set `B` of balanced parentheses has even length.
> 2. (Intermediate) Define `reverse(λ) = λ` and `reverse(wx) = x·reverse(w)` for a symbol `x`. Prove that `len(reverse(w)) = len(w)`. Then prove that every string in `B` has equal numbers of `(` and `)`, and that every prefix has at least as many `(` as `)`.
> 3. (Interview) Explain why a function that walks a JSON document by recursing only into the elements of arrays and the values of objects must terminate on any document parsed from text, but may loop forever on an in-memory object graph built in code. *Hint:* the termination argument is structural induction over a finite, recursively built value. What can an in-memory graph contain that a parsed tree cannot?

#### Recursive Algorithms

**Why.** If a problem can be reduced to smaller instances of the same problem, a recursive algorithm writes that reduction down directly. The resulting code is often shorter and much easier to prove correct than an iterative equivalent, because the correctness proof is an induction with the same structure as the code.

**What.** A **recursive algorithm** solves an instance by:

1. Solving **base cases** directly.
2. Otherwise, **reducing** the instance to one or more smaller instances, solving them by recursive calls, and **combining** the results.

Its correctness proof is a strong induction on the input size:

- **Basis:** the base cases return correct answers.
- **Inductive step:** assuming every recursive call on a smaller input returns a correct answer (the IH), the combination step produces a correct answer.
- **Termination:** every call is on a strictly smaller input, measured by a natural-number variant (3.2).

The key discipline is the **recursive leap of faith**: when reasoning about the combine step, trust the recursive calls to be correct. Do not trace them. That trust is exactly what the inductive hypothesis provides.

**Example: fast exponentiation.** Computing `a^n` with `n` multiplications is slow when `n` is large, as in cryptography (Chapter 4). Use `a^n = (a^{n/2})²` for even `n`.

```python
def power(a, n):
    """Compute a**n for n >= 0 with O(log n) multiplications."""
    if n == 0:
        return 1                              # basis: a^0 = 1
    half = power(a, n // 2)                   # IH: correct, because n // 2 < n
    if n % 2 == 0:
        return half * half                    # a^n = (a^{n/2})^2
    return half * half * a                    # a^n = (a^{(n-1)/2})^2 · a

def binary_search(arr, target, lo=0, hi=None):
    """Return an index of target in sorted arr[lo:hi], or -1."""
    if hi is None:
        hi = len(arr)
    if lo >= hi:
        return -1                             # basis: empty range
    mid = (lo + hi) // 2
    if arr[mid] == target:
        return mid
    if arr[mid] < target:
        return binary_search(arr, target, mid + 1, hi)   # range shrinks: variant hi - lo decreases
    return binary_search(arr, target, lo, mid)

print(power(3, 13), 3**13)                    # 1594323 1594323
print(binary_search([2, 3, 5, 7, 11, 13], 11), binary_search([2, 3, 5, 7], 4))   # 4 -1
```

*Correctness of `power`, by strong induction on `n`.* Basis: `power(a, 0) = 1 = a^0`. Step: let `n ≥ 1` and assume `power(a, m) = a^m` for all `m < n`. Since `⌊n/2⌋ < n`, `half = a^{⌊n/2⌋}`. If `n` is even, `half² = a^n`. If `n` is odd, `⌊n/2⌋ = (n − 1)/2`, and `half²·a = a^{n−1}·a = a^n`. ∎ The argument halves at each call, so there are about `log₂ n` calls.

**The call stack.** Each active call keeps its own frame (arguments, local variables, return point) on the call stack. The maximum recursion depth determines the memory used, and very deep recursion overflows the stack.

```text
factorial(3)                          stack grows ↓          returns ↑
 └─ 3 * factorial(2)                  [factorial(3): n=3]     6
       └─ 2 * factorial(1)            [factorial(2): n=2]     2
             └─ 1 * factorial(0)      [factorial(1): n=1]     1
                   └─ return 1        [factorial(0): n=0]     1
```

| | Recursion | Iteration |
|---|---|---|
| Natural fit | Recursive data (trees, grammars), divide-and-conquer | Linear scans, simple counters |
| Correctness proof | Induction mirroring the recursive structure | Loop invariant (next topic) |
| Memory | `O(depth)` stack frames | Usually `O(1)` extra |
| Risk | Stack overflow (Python's default limit is about 1000 frames) | Off-by-one errors in loop bounds |
| Conversion | Every recursion can be made iterative with an explicit stack | Tail recursion is a loop in disguise |

The running time of a recursive algorithm satisfies a recurrence, for example `T(n) = T(n/2) + O(1)` for binary search and `T(n) = 2T(n/2) + O(n)` for merge sort. Solving such recurrences is the subject of Chapter 6.

**Key takeaways**

- A recursive algorithm handles base cases directly and reduces larger inputs to strictly smaller ones.
- Prove correctness by strong induction: base cases, the combine step under the IH, and a decreasing variant for termination.
- Trust the recursive calls when reasoning about one level. That trust is the inductive hypothesis.
- Recursion uses stack space proportional to its depth. Its running time is described by a recurrence.

> **Practice**
>
> 1. (Beginner) Write a recursive function that returns the maximum of a non-empty list, and prove it correct by induction on the length of the list.
> 2. (Intermediate) Prove that `binary_search` above returns a correct answer: an index of `target` if it occurs in the sorted range `arr[lo:hi]`, and `−1` otherwise. State the variant that guarantees termination.
> 3. (Interview) A recursive depth-first search crashes with `RecursionError` on a graph shaped like a path of 100 000 vertices. Rewrite it iteratively and explain what replaces the call stack. *Hint:* push vertices onto an explicit list used as a stack. Consider when a vertex should be marked as visited so that it is processed only once.

#### Program Correctness and Loop Invariants

**Why.** Testing shows that a program works on the inputs you tried. A proof shows that it works on all inputs. For loops, the main proof tool is the **loop invariant**, a property that holds before and after every iteration. It is induction applied to the number of iterations.

**What.** A program `S` is specified with a **precondition** `p` (what is assumed about the input) and a **postcondition** `q` (what must hold at the end). The **Hoare triple** `{p} S {q}` states:

- **Partial correctness:** if `p` holds before `S` runs and `S` terminates, then `q` holds afterwards.
- **Total correctness:** partial correctness, and `S` terminates on every input satisfying `p`.

| Rule | Premises | Conclusion |
|---|---|---|
| Composition | `{p} S₁ {r}` and `{r} S₂ {q}` | `{p} S₁; S₂ {q}` |
| Conditional | `{p ∧ c} S₁ {q}` and `{p ∧ ¬c} S₂ {q}` | `{p} if c then S₁ else S₂ {q}` |
| Loop | `{I ∧ c} S {I}` | `{I} while c: S {I ∧ ¬c}` |

The loop rule is the heart of the method. If the body preserves `I` whenever it runs, then `I` still holds when the loop exits, and so does `¬c` because the loop stopped.

**How: the three-part invariant proof.**

1. **Initialization:** `I` holds before the first iteration.
2. **Maintenance:** if `I` and the loop condition hold at the start of an iteration, `I` holds at its end.
3. **Termination:** the loop stops (find a decreasing variant, 3.2), and `I ∧ ¬c` implies the postcondition.

Steps 1 and 2 are the basis and inductive step of an induction on the number of iterations completed. A good invariant usually describes *the part of the job already done*.

**Example: iterative fast exponentiation.**

```python
def power_iter(a, n):
    """Precondition: n >= 0.  Postcondition: returns a**n."""
    result, base, exp = 1, a, n
    # Invariant I:  result * base**exp == a**n   and   exp >= 0
    while exp > 0:                                   # variant: exp (a natural number that strictly decreases)
        assert result * base**exp == a**n            # I holds at the start of each iteration
        if exp % 2 == 1:
            result *= base                           # moves one factor of base into result
        base *= base                                 # base**exp keeps its value after halving exp
        exp //= 2
    assert result * base**exp == a**n and exp == 0   # I ∧ ¬(exp > 0)
    return result                                    # since exp == 0, result == a**n

print(power_iter(3, 13))                             # 1594323
```

*Proof.*
Initialization: `result·base^exp = 1·a^n = a^n`.
Maintenance: suppose `result·base^exp = a^n` with `exp > 0`. If `exp` is even, the new values are `base²` and `exp/2`, and `(base²)^{exp/2} = base^exp`. If `exp` is odd, the new values are `result·base`, `base²`, and `(exp − 1)/2`, and `result·base·(base²)^{(exp−1)/2} = result·base^exp`. Either way the product is unchanged.
Termination: `exp` is a natural number that strictly decreases (it is halved while positive), so the loop stops. At exit `exp = 0`, so `I` gives `result·1 = a^n`. ∎

**Example: insertion sort.** Invariant of the outer loop: *at the start of iteration `i`, `A[0:i]` contains the original first `i` elements, in sorted order.* Initialization: `A[0:1]` has one element and is sorted. Maintenance: the inner loop inserts `A[i]` into its place, so `A[0:i+1]` is sorted. Termination: the loop ends with `i = n`, so `A[0:n]`, the whole array, is sorted.

```text
 i = 3:   [ 2  5  8 | 4  9  1 ]      invariant: A[0:3] = [2, 5, 8] is sorted
                      ↑ insert 4
 i = 4:   [ 2  4  5  8 | 9  1 ]      invariant restored for A[0:4]
```

| Concept | Role | Proves | Example for `power_iter` |
|---|---|---|---|
| Invariant | Property preserved by every iteration | Partial correctness | `result·base^exp = a^n` |
| Variant | Natural-number quantity that strictly decreases | Termination | `exp` |

**Key takeaways**

- `{p} S {q}`: partial correctness assumes termination, while total correctness also proves it.
- A loop invariant is proved by initialization, maintenance, and termination. This is induction on the number of iterations.
- At exit, the invariant together with the negated loop condition must imply the postcondition.
- Pair every invariant with a variant to prove that the loop terminates.

> **Practice**
>
> 1. (Beginner) State an invariant for the loop `best = A[0]; for i in range(1, n): best = max(best, A[i])` and use it to prove that the loop returns the maximum of `A`.
> 2. (Intermediate) Prove that this loop computes `n!` for `n ≥ 0`: `f, i = 1, 0; while i < n: i += 1; f *= i`. Give the invariant, the variant, and the three proof parts.
> 3. (Interview) State the invariant that makes the iterative binary search `lo, hi = 0, len(A)` / `while lo < hi: ...` correct, and explain how a wrong update such as `lo = mid` instead of `lo = mid + 1` breaks either the invariant or the variant. *Hint:* the invariant should say where `target` must be if it occurs at all. Check whether `hi − lo` still strictly decreases when `hi = lo + 1`.

<a id="4-number-theory"></a>
## 4. Number Theory

<a id="41-divisibility"></a>
### 4.1 Divisibility

#### Divisibility and the Division Algorithm

#### Primes

#### Fundamental Theorem of Arithmetic

#### Sieve of Eratosthenes

#### Infinitude of Primes

<a id="42-gcd-and-lcm"></a>
### 4.2 GCD and LCM

#### Greatest Common Divisor

#### Least Common Multiple

#### Euclidean Algorithm

#### Extended Euclidean Algorithm

#### Bézout's Identity

<a id="43-modular-arithmetic"></a>
### 4.3 Modular Arithmetic

#### Congruences

#### Modular Operations

#### Modular Inverses

#### Linear Congruences

#### Chinese Remainder Theorem

#### Fast Modular Exponentiation

<a id="44-applications-of-number-theory"></a>
### 4.4 Applications of Number Theory

#### Fermat's Little Theorem

#### Euler's Totient Function

#### Euler's Theorem

#### Integer Representations and Bases

#### Hashing and Check Digits

#### RSA Cryptography

<a id="5-combinatorics"></a>
## 5. Combinatorics

<a id="51-counting-principles"></a>
### 5.1 Counting Principles

#### Sum Rule

#### Product Rule

#### Subtraction Rule

#### Division Rule

#### Tree Diagrams

<a id="52-permutations-and-combinations"></a>
### 5.2 Permutations and Combinations

#### Permutations

#### Combinations

#### Permutations with Repetition

#### Combinations with Repetition (Stars and Bars)

#### Multinomial Coefficients

#### Generating Permutations and Combinations

<a id="53-binomial-coefficients"></a>
### 5.3 Binomial Coefficients

#### Binomial Theorem

#### Pascal's Triangle

#### Pascal's Identity

#### Vandermonde's Identity

#### Combinatorial Proofs

<a id="54-pigeonhole-principle"></a>
### 5.4 Pigeonhole Principle

#### Basic Pigeonhole Principle

#### Generalized Pigeonhole Principle

#### Ramsey Numbers

<a id="55-inclusionexclusion"></a>
### 5.5 Inclusion–Exclusion

#### Principle of Inclusion–Exclusion

#### Counting Onto Functions

#### Derangements

<a id="56-special-counting-sequences"></a>
### 5.6 Special Counting Sequences

#### Catalan Numbers

#### Stirling Numbers

#### Bell Numbers

#### Integer Partitions

<a id="6-recurrence-relations-and-generating-functions"></a>
## 6. Recurrence Relations and Generating Functions

<a id="61-recurrence-relations"></a>
### 6.1 Recurrence Relations

#### Modeling with Recurrences

#### Fibonacci and Tower of Hanoi

#### Iteration and Substitution Method

#### Linear Homogeneous Recurrences

#### Characteristic Equations

#### Linear Nonhomogeneous Recurrences

<a id="62-divide-and-conquer-recurrences"></a>
### 6.2 Divide-and-Conquer Recurrences

#### Divide-and-Conquer Algorithms

#### Recursion Trees

#### Master Theorem

<a id="63-generating-functions"></a>
### 6.3 Generating Functions

#### Ordinary Generating Functions

#### Operations on Generating Functions

#### Solving Recurrences with Generating Functions

#### Counting with Generating Functions

#### Exponential Generating Functions

<a id="7-discrete-probability"></a>
## 7. Discrete Probability

<a id="71-probability-fundamentals"></a>
### 7.1 Probability Fundamentals

#### Sample Spaces and Events

#### Probability Axioms

#### Equally Likely Outcomes

#### Complements and Unions

#### Conditional Probability

#### Independence

<a id="72-bayes-and-applications"></a>
### 7.2 Bayes and Applications

#### Law of Total Probability

#### Bayes' Theorem

#### Birthday Problem

#### Monty Hall Problem

<a id="73-random-variables"></a>
### 7.3 Random Variables

#### Discrete Random Variables

#### Probability Mass Functions

#### Expected Value

#### Linearity of Expectation

#### Indicator Random Variables

#### Variance and Standard Deviation

<a id="74-distributions-and-bounds"></a>
### 7.4 Distributions and Bounds

#### Bernoulli and Binomial Distributions

#### Geometric Distribution

#### Markov's Inequality

#### Chebyshev's Inequality

#### Probabilistic Method

#### Randomized Algorithms

<a id="8-graph-theory"></a>
## 8. Graph Theory

<a id="81-graph-fundamentals"></a>
### 8.1 Graph Fundamentals

#### Graph Terminology

#### Directed and Undirected Graphs

#### Degree and Handshaking Lemma

#### Special Graphs (Complete, Cycle, Wheel, Hypercube)

#### Bipartite Graphs

#### Subgraphs and Complements

<a id="82-graph-representation-and-isomorphism"></a>
### 8.2 Graph Representation and Isomorphism

#### Adjacency Lists

#### Adjacency Matrices

#### Incidence Matrices

#### Graph Isomorphism

#### Graph Invariants

<a id="83-connectivity"></a>
### 8.3 Connectivity

#### Walks, Paths, and Cycles

#### Connected Components

#### Strongly Connected Components

#### Cut Vertices and Bridges

#### Vertex and Edge Connectivity

<a id="84-traversals-and-paths"></a>
### 8.4 Traversals and Paths

#### Breadth-First Search

#### Depth-First Search

#### Euler Paths and Circuits

#### Hamiltonian Paths and Circuits

#### Dijkstra's Shortest Path Algorithm

#### Traveling Salesperson Problem

<a id="85-planarity-and-coloring"></a>
### 8.5 Planarity and Coloring

#### Planar Graphs

#### Euler's Formula

#### Kuratowski's Theorem

#### Graph Coloring

#### Chromatic Number

#### Four Color Theorem

#### Edge Coloring

<a id="86-matchings-and-flows"></a>
### 8.6 Matchings and Flows

#### Matchings

#### Hall's Marriage Theorem

#### Network Flows

#### Max-Flow Min-Cut Theorem

<a id="9-trees"></a>
## 9. Trees

<a id="91-tree-fundamentals"></a>
### 9.1 Tree Fundamentals

#### Properties of Trees

#### Rooted Trees

#### M-ary Trees

#### Tree Height and Balance

#### Counting Trees and Cayley's Formula

<a id="92-applications-of-trees"></a>
### 9.2 Applications of Trees

#### Binary Search Trees

#### Decision Trees

#### Huffman Coding

#### Game Trees and Minimax

<a id="93-tree-traversal"></a>
### 9.3 Tree Traversal

#### Preorder Traversal

#### Inorder Traversal

#### Postorder Traversal

#### Expression Trees and Prefix/Postfix Notation

<a id="94-spanning-trees"></a>
### 9.4 Spanning Trees

#### Spanning Trees

#### Constructing Spanning Trees with DFS and BFS

#### Backtracking

#### Minimum Spanning Trees

#### Prim's Algorithm

#### Kruskal's Algorithm

<a id="10-algorithms-and-complexity"></a>
## 10. Algorithms and Complexity

<a id="101-algorithm-basics"></a>
### 10.1 Algorithm Basics

#### Algorithm Specification and Pseudocode

#### Searching Algorithms

#### Sorting Algorithms

#### Greedy Algorithms

<a id="102-growth-of-functions"></a>
### 10.2 Growth of Functions

#### Big-O Notation

#### Big-Omega Notation

#### Big-Theta Notation

#### Common Growth Rates

#### Comparing Function Growth

<a id="103-complexity-analysis"></a>
### 10.3 Complexity Analysis

#### Time Complexity

#### Space Complexity

#### Worst, Best, and Average Case

#### Tractable and Intractable Problems

#### P, NP, and NP-Completeness

<a id="11-boolean-algebra"></a>
## 11. Boolean Algebra

<a id="111-boolean-functions"></a>
### 11.1 Boolean Functions

#### Boolean Expressions

#### Boolean Identities

#### Duality

#### Sum-of-Products Expansion

#### Functional Completeness

<a id="112-logic-circuits"></a>
### 11.2 Logic Circuits

#### Logic Gates

#### Combinational Circuits

#### Adders

#### NAND and NOR Universality

<a id="113-circuit-minimization"></a>
### 11.3 Circuit Minimization

#### Karnaugh Maps

#### Don't-Care Conditions

#### Quine–McCluskey Method

<a id="12-algebraic-structures"></a>
## 12. Algebraic Structures

<a id="121-groups"></a>
### 12.1 Groups

#### Binary Operations

#### Semigroups and Monoids

#### Groups and Abelian Groups

#### Subgroups

#### Cyclic Groups

#### Lagrange's Theorem

#### Permutation Groups

#### Group Homomorphisms and Isomorphisms

<a id="122-rings-and-fields"></a>
### 12.2 Rings and Fields

#### Rings

#### Integral Domains

#### Fields

#### Finite Fields

#### Polynomial Rings

<a id="123-applications"></a>
### 12.3 Applications

#### Burnside's Lemma

#### Error-Correcting Codes

#### Hamming Codes

<a id="13-formal-languages-and-automata"></a>
## 13. Formal Languages and Automata

<a id="131-languages-and-grammars"></a>
### 13.1 Languages and Grammars

#### Alphabets, Strings, and Languages

#### Phrase-Structure Grammars

#### Chomsky Hierarchy

#### Backus–Naur Form

#### Derivation Trees

<a id="132-finite-state-machines"></a>
### 13.2 Finite-State Machines

#### Finite-State Machines with Output

#### Deterministic Finite Automata

#### Nondeterministic Finite Automata

#### NFA to DFA Conversion

#### DFA Minimization

<a id="133-regular-languages"></a>
### 13.3 Regular Languages

#### Regular Expressions

#### Kleene's Theorem

#### Closure Properties

#### Pumping Lemma for Regular Languages

<a id="134-computability"></a>
### 13.4 Computability

#### Pushdown Automata

#### Turing Machines

#### Church–Turing Thesis

#### Decidability

#### Halting Problem
