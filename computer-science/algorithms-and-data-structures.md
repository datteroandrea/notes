# Algorithms and Data Structures

A self-contained study guide that covers all fundamental topics of Algorithms & Data Structures. Each chapter builds intuition first ("why"), then the mechanics ("what" and "how"), with runnable examples, key takeaways, and interview-style practice.

## Index
0. [Interview Foundations](#0-interview-foundations)
1. [Array and Hashing](#1-array-and-hashing)
2. [Two Pointer](#2-two-pointer)
3. [Stack](#3-stack)
4. [Binary Search](#4-binary-search)
5. [Sliding Window](#5-sliding-window)
6. [Linked List](#6-linked-list)
7. [Trees](#7-trees)
8. [Tries](#8-tries)
9. [Backtracking](#9-backtracking)
10. [Heap or Priority Queue](#10-heap-or-priority-queue)
11. [1D Dynamic Programming](#11-1d-dynamic-programming)
12. [Intervals](#12-intervals)
13. [Greedy](#13-greedy)
14. [Advanced Graphs](#14-advanced-graphs)
15. [2D Dynamic Programming](#15-2d-dynamic-programming)
16. [Bit Manipulation](#16-bit-manipulation)
17. [Math and Geometry](#17-math-and-geometry)

---

## 0. Interview Foundations

Before any specific data structure, top-company interviews test three
meta-skills: reasoning about time and space complexity out loud, recognizing
which pattern a disguised problem belongs to, and driving the session with a
clear, communicative process. This chapter makes those explicit so the rest of
the guide plugs into a repeatable method.

### 0.1 Big-O Complexity Analysis

Big-O describes how an algorithm's running time or memory grows as the input size
`n` grows, ignoring constants and lower-order terms. Interviewers ask "what's the
time and space complexity?" after almost every solution — a correct answer that
you cannot analyze reads as luck, not understanding.

The "why": at Google/Meta scale, `n` can be billions. An O(n^2) solution that is
fine on a laptop for 1,000 items is hopeless on 1,000,000. Big-O lets you compare
approaches before writing a line of code and justify why your solution is
efficient enough.

Focus on the dominant term as `n` grows. Drop constants (`O(2n)` is `O(n)`) and
non-dominant terms (`O(n^2 + n)` is `O(n^2)`), because for large `n` the biggest
term swamps everything else.

```text
Growth from best to worst (n = 1,000,000):
O(1)        constant       1            hash lookup, array index
O(log n)    logarithmic    ~20          binary search
O(n)        linear         1,000,000    single scan
O(n log n)  linearithmic   ~20,000,000  best comparison sorts, heap sort
O(n^2)      quadratic      10^12        nested loops over the input
O(2^n)      exponential    astronomical unpruned subset/backtracking
O(n!)       factorial      hopeless     brute-force permutations
```

```python
# O(n) time, O(1) space: one pass, fixed extra memory
def contains_target(nums, target):
    for x in nums:            # n iterations
        if x == target:       # O(1) work each
            return True
    return False

# O(n) time, O(n) space: the hash set grows with input
def has_duplicate(nums):
    seen = set()              # extra memory proportional to n
    for x in nums:
        if x in seen:         # O(1) average lookup
            return True
        seen.add(x)
    return False
```

A common interview move is the *space-for-time trade*: `has_duplicate` above uses
O(n) memory to achieve O(n) time instead of O(n^2) nested comparisons. Being able
to name that trade-off explicitly is what interviewers listen for.

> Key Takeaways
> - Big-O measures growth as `n` grows; drop constants and lower-order terms.
> - Always state *both* time and space complexity, and the worst case.
> - Know the ladder: O(1) < O(log n) < O(n) < O(n log n) < O(n^2) < O(2^n) < O(n!).
> - Trading extra space (a hash map) for less time is a core interview instinct.

> 🧪 Practice
> 1. State the time and space complexity of each solution you write in later
>    chapters, out loud, before checking it.
> 2. Given nested loops where the inner loop runs to `i` (not `n`), derive the
>    complexity. (Answer: 1+2+...+n = O(n^2).)
> 3. Interview: An algorithm halves the input each step and does O(n) work per
>    level. What is the total complexity? (Hint: sum the work across log n levels;
>    this is the Master Theorem case behind merge sort.)

### 0.2 Pattern Recognition

Most interview problems are one of a dozen patterns wearing a disguise. The
skill that separates passing candidates is mapping the problem's *signals* — its
wording and constraints — to a known technique in seconds, instead of inventing
an approach from scratch under pressure.

The intuition: interviewers rarely ask something truly novel; they re-skin
classic patterns. "Sorted array" whispers binary search or two pointers.
"Contiguous subarray/substring" whispers sliding window. Training yourself to
hear these whispers is most of the battle.

| Signal in the problem                                   | Likely pattern            | Chapter |
| ------------------------------------------------------- | ------------------------- | ------- |
| "Have I seen this / count occurrences / find a pair"    | Hash map / set            | 1       |
| Sorted array, find pair/triplet, in-place partition     | Two pointers              | 2       |
| Match/nesting, "most recent", next greater element      | Stack / monotonic stack   | 3       |
| Sorted input, or "minimize the maximum / find boundary" | Binary search             | 4       |
| Contiguous subarray/substring, "longest/shortest with"  | Sliding window            | 5       |
| Cycle, reverse, middle of a sequence                    | Fast/slow pointers        | 6       |
| Hierarchy, "levels", ancestors, sorted-by-structure     | Tree DFS/BFS, BST         | 7       |
| Prefix/autocomplete/dictionary of words                 | Trie                      | 8       |
| "All combinations/permutations/subsets", constraints    | Backtracking              | 9       |
| "Top/smallest/largest k", streaming median, scheduling  | Heap / priority queue     | 10      |
| "Number of ways", "min/max cost", overlapping choices   | Dynamic programming       | 11, 15  |
| Ranges `[start, end]`, meetings, overlaps               | Intervals (sort + sweep)  | 12      |
| "Maximize/minimize" with a safe local choice            | Greedy                    | 13      |
| Nodes + edges, shortest path, connectivity, ordering    | Graph BFS/DFS/Dijkstra/UF | 14      |
| Pairs cancel, parity, subsets of <= 20 items            | Bit manipulation          | 16      |

> Key Takeaways
> - Read the constraints first: they leak the intended complexity and pattern
>   (e.g. `n <= 20` hints at O(2^n) backtracking; `n <= 10^5` rules out O(n^2)).
> - "Sorted" -> binary search or two pointers. "Contiguous" -> sliding window.
> - "All possibilities" -> backtracking. "Ways/min/max over choices" -> DP.
> - When stuck, ask which pattern the *input shape* and *ask* resemble.

> 🧪 Practice
> 1. For each practice problem in later chapters, name the pattern before solving.
> 2. Given `1 <= n <= 18` and "find the optimal ordering", what complexity and
>    technique are implied? (Hint: bitmask DP over subsets.)
> 3. Interview: You are asked for the longest substring with at most `k` distinct
>    characters. Which pattern, and why? (Hint: "substring" + "at most" = variable
>    sliding window.)

### 0.3 The Interview Process (Clarify, Plan, Code, Test)

Interviewers grade communication and problem-solving, not just a correct final
answer. A reliable four-step loop keeps you from silence, from coding the wrong
problem, and from missing edge cases — the three most common ways strong coders
still fail loops.

The intuition: the interview is a collaboration simulation. Thinking out loud
lets the interviewer give hints and see your reasoning; jumping straight to code
hides both.

1. **Clarify.** Restate the problem. Ask about input size, ranges, duplicates,
   empty/`null` inputs, and expected output format. Confirm one example by hand.
2. **Plan.** State a brute-force approach and its complexity, then propose an
   optimized approach and *its* complexity. Get a nod before coding.
3. **Code.** Write clean, readable code, narrating as you go. Use helper
   functions and meaningful names; do not micro-optimize prematurely.
4. **Test.** Dry-run your code on the example, then edge cases: empty input,
   single element, all-equal, negatives, overflow, the largest allowed `n`.

```text
Time budget for a 45-minute coding round (rough):
Clarify   ~5 min   |==|
Plan      ~8 min   |===|
Code     ~22 min   |=========|
Test      ~8 min   |===|
Buffer    ~2 min   |=|
```

> Key Takeaways
> - Never code before confirming the problem and agreeing on an approach.
> - Always state complexity before and after optimizing.
> - Think out loud continuously; silence loses signal and forfeits hints.
> - Reserve time to test edge cases — finding your own bug scores better than the
>   interviewer finding it.

> 🧪 Practice
> 1. Take any problem and write down five clarifying questions before solving it.
> 2. Practice narrating a solution aloud end to end without long silences.
> 3. Interview: List the edge cases you would test for "reverse a linked list".
>    (Hint: empty list, single node, two nodes, and a list with a cycle if
>    unspecified.)

---

## 1. Array and Hashing

Arrays are the most fundamental data structure: a contiguous block of memory
holding elements of the same type. Hashing pairs with arrays to trade memory for
speed, turning many linear scans into constant-time lookups. Mastering these two
underpins almost every other topic in this guide.

### 1.1 Arrays and Dynamic Arrays

An array stores elements back-to-back in memory. Because every element is the
same size and the start address is known, the machine can compute the address of
index `i` with simple arithmetic (`base + i * elementSize`), which is why random
access is O(1). A *dynamic array* (Java `ArrayList`, Python `list`, C++
`vector`) wraps a fixed array and automatically resizes when it fills up.

Think of a static array as a row of numbered mailboxes bolted to a wall: you can
reach any box instantly, but you cannot add a new box without moving to a bigger
wall. That "move to a bigger wall" is what a dynamic array does for you behind
the scenes by allocating a larger array and copying elements over.

```python
# Dynamic array behavior in Python
nums = [3, 1, 4]        # contiguous storage, capacity may exceed length
nums.append(1)          # amortized O(1); occasionally triggers a resize+copy
print(nums[2])          # O(1) random access -> 4
nums.insert(1, 9)       # O(n): elements after index 1 shift right
nums.pop()              # O(1) from the end
nums.pop(0)             # O(n): everything shifts left to fill the gap
```

The subtle part is *amortized* cost. A resize copies all `n` elements (O(n)), but
doubling capacity means resizes happen rarely, so the average cost per append is
still O(1).

| Operation            | Time      | Why                                  |
| -------------------- | --------- | ------------------------------------ |
| Access by index      | O(1)      | Address arithmetic                   |
| Append at end        | O(1)*     | Amortized; occasional resize         |
| Insert/delete middle | O(n)      | Shift elements                       |
| Search (unsorted)    | O(n)      | Must scan                            |

> Key Takeaways
> - Arrays give O(1) random access because memory is contiguous.
> - Dynamic arrays amortize appends to O(1) by doubling capacity.
> - Inserting or deleting anywhere but the end costs O(n) due to shifting.

> 🧪 Practice
> 1. Write a function that reverses an array in place using no extra array.
> 2. Given an array, return a new array where each element is the running sum up
>    to that index (e.g. `[1,2,3] -> [1,3,6]`).
> 3. Remove all instances of a value `val` from an array in place and return the
>    new length, without allocating a second array.
> 4. Interview: You must implement `append` for your own dynamic array class.
>    How do you achieve amortized O(1)? (Hint: think about the growth factor and
>    how total copies sum across many appends.)

### 1.2 Hash Tables (Maps and Sets)

A hash table stores key-value pairs and answers "is this key present, and what is
its value?" in O(1) average time. The trick is a *hash function* that converts a
key into an array index. Instead of scanning `n` items, you jump straight to the
bucket where the key must live.

Imagine a coat check: you hand over a coat and receive a numbered ticket. To
retrieve the coat, the attendant goes directly to that numbered hook rather than
searching every hook. The hash function is what turns your coat (the key) into a
ticket number (the index).

Two keys can hash to the same index — a *collision*. The two common fixes are
*chaining* (each bucket holds a linked list of entries) and *open addressing*
(probe to the next free slot).

```java
// HashMap for counting; HashSet for membership
Map<String, Integer> counts = new HashMap<>();
for (String word : words) {
    // getOrDefault avoids a null check; average O(1) per update
    counts.put(word, counts.getOrDefault(word, 0) + 1);
}

Set<Integer> seen = new HashSet<>();
seen.add(42);
boolean present = seen.contains(42); // O(1) average -> true
```

```text
Hashing "cat" -> hash % capacity = index 3

buckets:
[0] -> null
[1] -> null
[2] -> null
[3] -> ("cat", 5) -> ("act", 2)   <- collision resolved by chaining
[4] -> null
```

| Operation | Average | Worst (all collide) |
| --------- | ------- | ------------------- |
| Insert    | O(1)    | O(n)                |
| Lookup    | O(1)    | O(n)                |
| Delete    | O(1)    | O(n)                |

> Key Takeaways
> - Hash tables trade memory for near-constant lookup, insert, and delete.
> - A good hash function distributes keys evenly to minimize collisions.
> - Worst case degrades to O(n); real libraries mitigate this with resizing and
>   good hash functions.
> - Use a set for membership, a map for key-value associations.

> 🧪 Practice
> 1. Given an array, return `true` if any value appears at least twice using a
>    hash set.
> 2. Count the frequency of each character in a string and return the most
>    frequent one.
> 3. Given two arrays, return their intersection (unique common elements).
> 4. Interview: Two Sum — return indices of the two numbers that add up to a
>    target. (Hint: store each number's complement as you iterate so you never
>    need a second pass.)

### 1.3 Prefix Sums

A prefix sum array lets you answer "what is the sum of elements between index `i`
and `j`?" in O(1) after O(n) preprocessing. The idea: precompute the cumulative
sum up to every index, then any range sum is the difference of two cumulative
sums.

The "why" is avoiding repeated work. If you are asked many range-sum queries,
recomputing each by looping is O(n) per query. Precomputing once means each query
becomes a single subtraction.

```python
def build_prefix(nums):
    prefix = [0] * (len(nums) + 1)      # prefix[0] = 0 sentinel simplifies math
    for i, x in enumerate(nums):
        prefix[i + 1] = prefix[i] + x   # cumulative sum
    return prefix

# sum of nums[i..j] inclusive = prefix[j+1] - prefix[i]
nums = [2, 4, 6, 8]
prefix = build_prefix(nums)             # [0, 2, 6, 12, 20]
range_sum = prefix[3] - prefix[1]       # nums[1..2] = 4 + 6 = 10
```

```text
nums:    2    4    6    8
prefix: 0    2    6   12   20
              i=1        j=2
sum(1..2) = prefix[3] - prefix[1] = 12 - 2 = 10
```

> Key Takeaways
> - Prefix sums convert many range-sum queries from O(n) each to O(1) each.
> - Use a leading 0 sentinel so `sum(i..j) = prefix[j+1] - prefix[i]` with no
>   edge cases.
> - The same idea extends to 2D grids and to prefix products or XOR.

> 🧪 Practice
> 1. Given an array, answer `q` range-sum queries efficiently.
> 2. Find the pivot index where the sum of elements to the left equals the sum to
>    the right.
> 3. Given an array of integers and a target `k`, count subarrays whose sum
>    equals `k`. (Hint: combine prefix sums with a hash map of seen sums.)

---

## 2. Two Pointer

The two-pointer technique uses two indices moving through a data structure to
solve problems that would otherwise need nested loops. By coordinating the
pointers, you often cut O(n^2) brute force down to O(n). It shines on sorted
arrays, strings, and linked lists.

### 2.1 Opposite-Ends (Converging) Pointers

Here one pointer starts at the beginning and the other at the end; they move
toward each other. The "why": on a sorted array, comparing the two ends tells you
which direction to move without checking every pair. Each step eliminates a whole
range of possibilities.

Picture two people walking toward each other from opposite ends of a hallway,
deciding at each step who takes a step based on what they see. They meet in the
middle after at most `n` total steps.

```python
def two_sum_sorted(nums, target):
    left, right = 0, len(nums) - 1
    while left < right:
        s = nums[left] + nums[right]
        if s == target:
            return [left, right]
        elif s < target:
            left += 1          # need a bigger sum -> move low end up
        else:
            right -= 1         # need a smaller sum -> move high end down
    return []
```

```text
[1, 3, 4, 5, 7, 11]  target = 9
 L                 R   1+11=12 > 9 -> R--
 L              R      1+7 =8  < 9 -> L++
    L           R      3+7 =10 > 9 -> R--
    L        R         3+5 =8  < 9 -> L++
       L     R         4+5 =9  -> found
```

> Key Takeaways
> - Converging pointers turn many O(n^2) sorted-array problems into O(n).
> - Each comparison lets you discard one candidate, so total work is linear.
> - Requires the data to be sorted (or a property that gives directional info).

> 🧪 Practice
> 1. Determine whether a string is a palindrome, ignoring non-alphanumeric
>    characters and case.
> 2. Given a sorted array, return all unique pairs that sum to a target.
> 3. Container With Most Water: given heights, find two lines forming the largest
>    water container. (Hint: move the pointer at the shorter line inward.)

### 2.2 Same-Direction (Fast/Slow) Pointers

Both pointers start at the same side but move at different speeds or under
different conditions. The slow pointer marks a boundary (e.g. the end of the
"kept" region) while the fast pointer scans ahead. This is the backbone of
in-place array editing and cycle detection.

The intuition: the slow pointer is a "write head" and the fast pointer is a
"read head." You read every element once, but only advance the write head when an
element should be kept.

```java
// Remove duplicates from a sorted array in place, return new length
int removeDuplicates(int[] nums) {
    if (nums.length == 0) return 0;
    int slow = 0;                       // last unique element's index
    for (int fast = 1; fast < nums.length; fast++) {
        if (nums[fast] != nums[slow]) { // found a new unique value
            slow++;
            nums[slow] = nums[fast];    // write it just after the kept region
        }
    }
    return slow + 1;
}
```

> Key Takeaways
> - Slow = write boundary, fast = scanner; ideal for in-place O(1)-space edits.
> - Different speeds also detect cycles (see Linked List, Chapter 6).
> - Single pass keeps the whole operation O(n).

> 🧪 Practice
> 1. Move all zeros to the end of an array while keeping the order of non-zeros.
> 2. Given a sorted array, remove duplicates so each element appears at most
>    twice.
> 3. Interview: Detect if a sequence has a cycle using only two pointers and O(1)
>    space. (Hint: if a fast pointer laps a slow one, a cycle exists.)

## 3. Stack

A stack is a Last-In-First-Out (LIFO) collection: the last item pushed is the
first popped. It models nested structure and "most recent" relationships, which
makes it the natural tool for matching brackets, evaluating expressions, undo
history, and function call frames.

### 3.1 Stack Fundamentals

A stack supports three core operations: `push` (add to top), `pop` (remove from
top), and `peek`/`top` (look at the top without removing). All are O(1). The
mental model is a stack of plates: you add and remove from the top only.

The "why" is order reversal and nesting. Whenever the most recently seen thing
must be resolved before older things, a stack captures that automatically.

```python
stack = []
stack.append(1)   # push -> [1]
stack.append(2)   # push -> [1, 2]
top = stack[-1]   # peek -> 2
stack.pop()       # pop  -> returns 2, stack is [1]
is_empty = not stack
```

A classic use is validating balanced parentheses: push every opening bracket,
and on a closing bracket check that it matches the top.

```python
def is_valid(s):
    pairs = {')': '(', ']': '[', '}': '{'}
    stack = []
    for ch in s:
        if ch in pairs.values():        # opening bracket
            stack.append(ch)
        elif ch in pairs:               # closing bracket
            if not stack or stack.pop() != pairs[ch]:
                return False            # mismatch or nothing to close
    return not stack                    # leftover openings = invalid
```

> Key Takeaways
> - Stacks are LIFO; push, pop, and peek are all O(1).
> - Ideal for nested/most-recent problems: brackets, expression parsing, undo.
> - Function call stacks and recursion are stacks under the hood.

> 🧪 Practice
> 1. Implement a `MinStack` that returns the minimum in O(1) alongside push/pop.
> 2. Evaluate a Reverse Polish Notation expression (e.g. `["2","1","+","3","*"]`).
> 3. Interview: Given a string of parentheses, return the length of the longest
>    valid substring. (Hint: a stack of indices lets you measure valid spans.)

### 3.2 Monotonic Stack

A monotonic stack keeps its elements sorted (always increasing or always
decreasing) as you push. When a new element would break the order, you pop until
order is restored. This pattern answers "next greater/smaller element" questions
in O(n) instead of O(n^2).

The intuition: an element that is smaller than the incoming one can never be the
"next greater" answer for anything further right, so you resolve and discard it
immediately. Each element is pushed and popped at most once — hence linear time.

```python
def next_greater(nums):
    res = [-1] * len(nums)
    stack = []                          # holds indices, values decreasing
    for i, x in enumerate(nums):
        # current x resolves all smaller elements waiting on the stack
        while stack and nums[stack[-1]] < x:
            res[stack.pop()] = x
        stack.append(i)
    return res

# next_greater([2, 1, 2, 4, 3]) -> [4, 2, 4, -1, -1]
```

```text
Process 4 (i=3): stack has indices of 2,1,2 (values below 4)
pop 2 -> res=4, pop 1 -> res=4, pop 2 -> res=4, then push 4
```

> Key Takeaways
> - Monotonic stacks solve next-greater/smaller and span problems in O(n).
> - Each element is pushed and popped once, giving amortized O(1) per element.
> - Store indices (not just values) when you need distances or positions.

> 🧪 Practice
> 1. Given daily temperatures, return for each day how many days until a warmer
>    one.
> 2. Compute the largest rectangle area in a histogram.
> 3. Interview: Find the next greater element for each item in a circular array.
>    (Hint: iterate the array twice using modulo indexing.)

## 4. Binary Search

Binary search finds a target in a sorted collection by repeatedly halving the
search space. Each comparison discards half the remaining candidates, giving
O(log n) time. Beyond arrays, the same "halve the possibilities" idea applies to
searching over an answer space.

### 4.1 Classic Binary Search

Given a sorted array, compare the target to the middle element. If equal, done.
If the target is larger, discard the left half; if smaller, discard the right
half. Repeat on the surviving half.

The power comes from exponential elimination: 1,000,000 elements need only ~20
comparisons, because each step cuts the field in half (2^20 > 10^6).

```java
int binarySearch(int[] nums, int target) {
    int lo = 0, hi = nums.length - 1;   // inclusive bounds
    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;   // avoids integer overflow
        if (nums[mid] == target) return mid;
        else if (nums[mid] < target) lo = mid + 1;  // target in right half
        else hi = mid - 1;                           // target in left half
    }
    return -1;                          // not found
}
```

```text
find 7 in [1, 3, 5, 7, 9, 11]
lo=0 hi=5 mid=2 -> 5 < 7 -> lo=3
lo=3 hi=5 mid=4 -> 9 > 7 -> hi=3
lo=3 hi=3 mid=3 -> 7 == 7 -> return 3
```

The two recurring bug sources are the loop condition (`<=` vs `<`) and how you
update bounds. Keeping bounds *inclusive* with `lo <= hi` and `mid +/- 1` is the
most robust template.

> Key Takeaways
> - Requires sorted data; runs in O(log n) time, O(1) space.
> - Use `lo + (hi - lo) / 2` to avoid overflow on large indices.
> - Be deliberate about inclusive vs exclusive bounds to avoid infinite loops.

> 🧪 Practice
> 1. Return the index where a target would be inserted to keep an array sorted.
> 2. Find the first and last position of a target value in a sorted array.
> 3. Interview: Search a rotated sorted array in O(log n). (Hint: one half is
>    always sorted — decide which, then check if the target lies within it.)

### 4.2 Binary Search on the Answer Space

Sometimes the array is not what you search — instead you search over the *range
of possible answers*. This works when a candidate answer has a monotonic
"feasible/infeasible" property: if `x` works, everything above (or below) it also
works. You binary-search for the boundary.

The intuition: reframe an optimization ("minimize the maximum load") as a
decision ("can we do it with limit `x`?"). If that decision is monotonic in `x`,
binary search finds the smallest feasible `x`.

```python
def min_eating_speed(piles, hours):
    def hours_needed(speed):
        # ceil division: bananas eaten per pile at this speed
        return sum((p + speed - 1) // speed for p in piles)

    lo, hi = 1, max(piles)              # answer lies in [1, max pile]
    while lo < hi:
        mid = (lo + hi) // 2
        if hours_needed(mid) <= hours:  # feasible -> try slower
            hi = mid
        else:                           # too slow -> must go faster
            lo = mid + 1
    return lo                           # smallest feasible speed
```

> Key Takeaways
> - Search the answer range, not the input, when feasibility is monotonic.
> - Turn "optimize X" into "is X achievable with value v?" then find the boundary.
> - Cost is O(log(range) * cost-of-feasibility-check).

> 🧪 Practice
> 1. Given `n` items and a per-day capacity, find the least capacity to ship all
>    within `d` days.
> 2. Find the smallest divisor so that the sum of ceilings stays within a limit.
> 3. Interview: Split an array into `k` subarrays minimizing the largest subarray
>    sum. (Hint: binary search the largest-sum value; greedily count needed
>    splits.)

## 5. Sliding Window

A sliding window maintains a contiguous range (subarray or substring) that
expands and contracts as you scan, so you never recompute overlapping work. It
turns many O(n^2) or O(n*k) substring/subarray problems into a single O(n) pass.

### 5.1 Fixed-Size Window

The window has a constant width `k`. As you slide it one step right, you add the
new element entering on the right and remove the one leaving on the left, updating
a running aggregate (sum, count, etc.) in O(1) per step.

The "why": recomputing the sum of every length-`k` block from scratch is O(n*k).
By reusing the previous window's sum and only adjusting for the one element added
and the one removed, each step is O(1).

```python
def max_sum_subarray(nums, k):
    window = sum(nums[:k])              # first window
    best = window
    for i in range(k, len(nums)):
        window += nums[i] - nums[i - k] # add entering, drop leaving
        best = max(best, window)
    return best

# max_sum_subarray([2, 1, 5, 1, 3, 2], 3) -> 9  (5+1+3)
```

```text
[2 1 5] 1 3 2   sum=8
2 [1 5 1] 3 2   sum=8 - 2 + 1 = 7
2 1 [5 1 3] 2   sum=7 - 1 + 3 = 9  <- best
2 1 5 [1 3 2]   sum=9 - 5 + 2 = 6
```

> Key Takeaways
> - Fixed windows update aggregates in O(1) by adding one element and removing
>   one per slide.
> - Total time is O(n) versus O(n*k) for naive recomputation.
> - Great for "maximum/average of every length-k block" problems.

> 🧪 Practice
> 1. Find the maximum average of any contiguous subarray of length `k`.
> 2. Count how many length-`k` substrings contain all distinct characters.
> 3. Interview: Return the maximum in every sliding window of size `k`. (Hint: a
>    monotonic deque keeps candidates in O(n) total.)

### 5.2 Variable-Size Window

The window grows by advancing the right edge and shrinks by advancing the left
edge whenever a constraint is violated (e.g. "no repeated characters" or "sum <=
target"). You track the best valid window seen.

The intuition: expand greedily to include more, and only shrink the minimum
necessary to restore validity. Because each pointer moves forward at most `n`
times total, the whole scan is O(n).

```python
def longest_unique_substring(s):
    seen = {}                           # char -> last index seen
    left = 0
    best = 0
    for right, ch in enumerate(s):
        if ch in seen and seen[ch] >= left:
            left = seen[ch] + 1         # jump left past the duplicate
        seen[ch] = right
        best = max(best, right - left + 1)
    return best

# longest_unique_substring("abcabcbb") -> 3  ("abc")
```

> Key Takeaways
> - Expand right to grow; advance left only to fix a violated constraint.
> - Each pointer moves at most n steps, so the total is O(n).
> - Track window contents with a hash map or counts to test validity in O(1).

> 🧪 Practice
> 1. Find the smallest subarray whose sum is at least a target `s`.
> 2. Find the longest substring containing at most `k` distinct characters.
> 3. Interview: Given strings `s` and `t`, find the smallest window in `s` that
>    contains all characters of `t`. (Hint: expand until valid, then shrink while
>    still valid, recording the best.)

## 6. Linked List

A linked list stores elements in nodes, each pointing to the next. Unlike arrays,
nodes are scattered in memory and connected by references, so insertion and
deletion at a known position are O(1) — but random access is O(n). Linked lists
teach pointer manipulation that recurs in trees and graphs.

### 6.1 Singly and Doubly Linked Lists

In a *singly* linked list each node holds a value and a `next` pointer. In a
*doubly* linked list each node also holds a `prev` pointer, allowing backward
traversal and O(1) deletion given only the node. The list is accessed through a
`head` reference (and often a `tail`).

The trade-off vs arrays: linked lists win when you frequently insert/delete in
the middle and do not need indexed access; arrays win for random access and cache
performance.

```python
class Node:
    def __init__(self, val, nxt=None):
        self.val = val
        self.next = nxt

# Build 1 -> 2 -> 3
head = Node(1, Node(2, Node(3)))

# Insert 9 after the head node in O(1)
head.next = Node(9, head.next)          # 1 -> 9 -> 2 -> 3

# Traverse
node = head
while node:
    print(node.val)
    node = node.next
```

```text
Singly:  [1|*]->[9|*]->[2|*]->[3|/]
Doubly:  /<-[1]<->[9]<->[2]<->[3]->/
```

| Operation                 | Array | Linked List |
| ------------------------- | ----- | ----------- |
| Access by index           | O(1)  | O(n)        |
| Insert/delete at head      | O(n)  | O(1)        |
| Insert/delete given node  | O(n)  | O(1)*       |
| Search                    | O(n)  | O(n)        |

(*O(1) for doubly; singly needs the previous node.)

> Key Takeaways
> - Nodes link via references; no contiguous memory, so no O(1) indexing.
> - Insertion/deletion at a known node is O(1); finding it is O(n).
> - Doubly linked lists trade extra memory for backward traversal and easier
>   deletion.

> 🧪 Practice
> 1. Implement a singly linked list with `addFirst`, `addLast`, and `remove`.
> 2. Find the middle node of a linked list in one pass.
> 3. Interview: Design an LRU cache. (Hint: a hash map plus a doubly linked list
>    gives O(1) get and put.)

### 6.2 Reversal and Fast/Slow Pointers

Two techniques dominate linked-list problems. *Reversal* re-points each node's
`next` to its predecessor, walking the list once. *Fast/slow pointers* (Floyd's
algorithm) advance one pointer twice as fast as the other to find the middle or
detect a cycle.

Reversal intuition: you cannot go backward, so carry a `prev` reference and flip
each link as you pass. Fast/slow intuition: if there is a loop, the fast pointer
eventually laps the slow one and they collide; if not, fast simply reaches the
end.

```java
ListNode reverse(ListNode head) {
    ListNode prev = null, cur = head;
    while (cur != null) {
        ListNode next = cur.next;   // remember the rest of the list
        cur.next = prev;            // flip the pointer backward
        prev = cur;                 // advance prev
        cur = next;                 // advance cur
    }
    return prev;                    // new head
}

boolean hasCycle(ListNode head) {
    ListNode slow = head, fast = head;
    while (fast != null && fast.next != null) {
        slow = slow.next;           // +1
        fast = fast.next.next;      // +2
        if (slow == fast) return true;  // they met -> cycle
    }
    return false;
}
```

> Key Takeaways
> - Reversal flips `next` pointers in one O(n) pass using a `prev` tracker.
> - Fast/slow pointers find the middle (fast reaches end when slow is at middle).
> - If fast ever equals slow, the list has a cycle (Floyd's detection).

> 🧪 Practice
> 1. Reverse a linked list both iteratively and recursively.
> 2. Determine whether a linked list is a palindrome using O(1) extra space.
> 3. Interview: Given a cycle exists, return the node where the cycle begins.
>    (Hint: after the meeting point, move one pointer back to the head and
>    advance both one step at a time.)

## 7. Trees

A tree is a hierarchical structure of nodes with one root and no cycles; each
node has children. Binary trees (at most two children) and binary search trees
model sorted data, file systems, decision processes, and more. Recursion is the
natural language of trees.

### 7.1 Binary Trees and Traversals

A binary tree node holds a value and left/right child references. *Traversal*
means visiting every node in a defined order. Depth-first traversals come in
three flavors — preorder (node, left, right), inorder (left, node, right), and
postorder (left, right, node) — while breadth-first (level order) visits nodes
level by level.

The "why" of order: inorder on a BST yields sorted values; preorder serializes
structure; postorder is used when children must be processed before their parent
(e.g. computing subtree sizes or deleting a tree).

```python
class TreeNode:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def inorder(node, out):
    if not node:
        return
    inorder(node.left, out)             # left subtree first
    out.append(node.val)                # then the node
    inorder(node.right, out)            # then right subtree

from collections import deque
def level_order(root):
    result, q = [], deque([root] if root else [])
    while q:
        level = []
        for _ in range(len(q)):         # process one full level
            node = q.popleft()
            level.append(node.val)
            if node.left:  q.append(node.left)
            if node.right: q.append(node.right)
        result.append(level)
    return result
```

```text
        4
       / \
      2   6      inorder:   2 4 6 (sorted for a BST)
     / \          preorder:  4 2 6
    1   3         level:     [4] [2 6] [1 3]
```

> Key Takeaways
> - DFS uses recursion/stack; BFS uses a queue and visits level by level.
> - Inorder of a BST produces sorted output.
> - Choose postorder when a node depends on results from its children.

> 🧪 Practice
> 1. Compute the maximum depth of a binary tree.
> 2. Return the level-order traversal as a list of levels.
> 3. Interview: Determine whether two trees are mirror images (symmetric). (Hint:
>    compare left-of-one with right-of-other recursively.)

### 7.2 Binary Search Trees

A binary search tree (BST) maintains the invariant that every node's left subtree
holds smaller values and its right subtree holds larger values. This ordering
makes search, insert, and delete O(h), where `h` is the height — O(log n) when
balanced, O(n) when degenerate.

The intuition mirrors binary search: at each node you decide left or right,
halving the remaining candidates (in a balanced tree).

```java
TreeNode search(TreeNode root, int target) {
    while (root != null) {
        if (target == root.val) return root;
        root = target < root.val ? root.left : root.right; // go one direction
    }
    return null;
}

TreeNode insert(TreeNode root, int val) {
    if (root == null) return new TreeNode(val);
    if (val < root.val) root.left = insert(root.left, val);
    else if (val > root.val) root.right = insert(root.right, val);
    return root;                        // duplicates ignored here
}
```

Balance matters: inserting sorted values into a plain BST creates a linked list
(height n). Self-balancing variants (AVL, red-black) keep height O(log n).

> Key Takeaways
> - BST invariant: left < node < right for every node.
> - Search/insert/delete are O(h); balanced gives O(log n), degenerate gives O(n).
> - Inorder traversal validates or lists a BST in sorted order.

> 🧪 Practice
> 1. Validate whether a binary tree is a proper BST (mind duplicate and range
>    edge cases).
> 2. Find the k-th smallest element in a BST.
> 3. Interview: Find the lowest common ancestor of two nodes in a BST. (Hint: the
>    split point is where the two target values diverge left vs right.)

## 8. Tries

A trie (prefix tree) stores strings by sharing common prefixes along tree paths.
Each edge represents a character, and each root-to-node path spells a prefix.
Tries make prefix queries and autocomplete fast — O(length) per operation,
independent of how many words are stored.

### 8.1 Prefix Trees

Instead of storing whole words separately, a trie stores each character once per
shared prefix. A node marks whether a word ends there. To insert or search a
word of length `L`, you walk `L` edges — O(L) regardless of the dictionary size.

The "why": many words share prefixes ("car", "card", "care"), and a trie stores
that shared prefix a single time, then branches. This is both space-efficient for
dense dictionaries and time-efficient for prefix lookups.

```python
class TrieNode:
    def __init__(self):
        self.children = {}              # char -> TrieNode
        self.is_word = False            # true if a word ends here

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for ch in word:
            if ch not in node.children:
                node.children[ch] = TrieNode()
            node = node.children[ch]
        node.is_word = True             # mark end of word

    def search(self, word):
        node = self._walk(word)
        return node is not None and node.is_word

    def starts_with(self, prefix):
        return self._walk(prefix) is not None

    def _walk(self, s):
        node = self.root
        for ch in s:
            if ch not in node.children:
                return None
            node = node.children[ch]
        return node
```

```text
insert "car", "card", "care":

(root)
  └─c─a─r*        (* marks a complete word)
         ├─d*
         └─e*
```

> Key Takeaways
> - Tries share prefixes, so insert/search/prefix-check are O(word length).
> - A boolean `is_word` flag distinguishes a stored word from a mere prefix.
> - Excellent for autocomplete, spell-check, and prefix-matching problems.

> 🧪 Practice
> 1. Implement `insert`, `search`, and `startsWith` for a trie.
> 2. Add a `delete(word)` operation that prunes now-unused nodes.
> 3. Interview: Support search with a `.` wildcard that matches any single
>    character. (Hint: at a `.`, recurse into all current children.)

## 9. Backtracking

Backtracking explores all candidate solutions by building them incrementally and
abandoning ("pruning") any partial candidate that cannot lead to a valid full
solution. It is a disciplined brute force: try a choice, recurse, then undo the
choice to try the next. It powers subsets, permutations, combinations, and
constraint puzzles.

### 9.1 The Backtracking Template

Every backtracking solution shares a shape: a recursive function that (1) records
a complete solution at a base case, (2) iterates over the available choices, (3)
makes a choice, recurses, and (4) undoes the choice before the next iteration.
The undo step is what makes it "backtracking."

The intuition is exploring a decision tree depth-first. Each node is a partial
solution; each branch is a choice. Pruning cuts entire branches early, which is
what keeps an exponential search tractable in practice.

```python
def subsets(nums):
    result = []

    def backtrack(start, path):
        result.append(path[:])          # record current subset (copy!)
        for i in range(start, len(nums)):
            path.append(nums[i])        # choose
            backtrack(i + 1, path)      # explore with this choice
            path.pop()                  # un-choose (backtrack)

    backtrack(0, [])
    return result

# subsets([1, 2, 3]) -> [], [1], [1,2], [1,2,3], [1,3], [2], [2,3], [3]
```

```text
decision tree for subsets of [1,2,3]:
            []
      /      |      \
    [1]     [2]     [3]
    / \      |
 [1,2][1,3] [2,3]
   |
 [1,2,3]
```

Permutations differ only in the choice set: instead of a `start` index, track
which elements are already used.

> Key Takeaways
> - Pattern: choose -> recurse -> un-choose; the undo is the defining step.
> - Append a *copy* of the path when recording, or later mutations corrupt it.
> - Prune invalid partials early to avoid exploring doomed branches.
> - Time is typically exponential; pruning determines practical performance.

> 🧪 Practice
> 1. Generate all subsets of a set that may contain duplicates (no duplicate
>    subsets).
> 2. Generate all permutations of a list of distinct integers.
> 3. Find all combinations of candidate numbers summing to a target (reuse
>    allowed).
> 4. Interview: Solve the N-Queens problem, returning all valid board
>    placements. (Hint: track attacked columns and both diagonals as you place
>    one queen per row.)

## 10. Heap or Priority Queue

A heap is a tree-shaped array that always gives you the smallest (min-heap) or
largest (max-heap) element in O(1), with O(log n) insert and remove. A priority
queue is the abstract "always serve the highest priority next" interface that a
heap implements. They excel at top-k, scheduling, and streaming-median problems.

### 10.1 Binary Heaps

A binary heap is a complete binary tree stored compactly in an array: the parent
of index `i` is `(i-1)/2`, its children are `2i+1` and `2i+2`. The *heap
property* says every parent is <= (min-heap) or >= (max-heap) its children, so
the extreme element is always at the root (index 0).

The "why": you rarely need full sorting — you need the current best repeatedly. A
heap keeps just enough order to surface the best in O(1) and repair itself in
O(log n) by "bubbling" a moved element up or down.

```python
import heapq

nums = [5, 1, 8, 3]
heapq.heapify(nums)                     # O(n) build a min-heap
smallest = nums[0]                      # peek min -> 1 (O(1))
heapq.heappush(nums, 2)                 # O(log n)
mn = heapq.heappop(nums)                # remove+return min -> 1 (O(log n))

# Max-heap trick: push negatives
maxh = []
for x in [5, 1, 8, 3]:
    heapq.heappush(maxh, -x)
largest = -heapq.heappop(maxh)          # -> 8
```

```text
min-heap as tree (array [1,3,8,5]):
        1
       / \
      3   8
     /
    5
parent(i)=(i-1)//2, children=2i+1, 2i+2
```

| Operation   | Time     |
| ----------- | -------- |
| Peek min/max| O(1)     |
| Push        | O(log n) |
| Pop         | O(log n) |
| Build (heapify) | O(n) |

> Key Takeaways
> - Heaps give O(1) access to the min/max and O(log n) insert/remove.
> - Stored as an array using index arithmetic — no explicit node pointers.
> - `heapify` builds a heap in O(n), faster than n individual pushes.
> - Simulate a max-heap with a min-heap by negating values.

> 🧪 Practice
> 1. Return the k largest elements of an array.
> 2. Merge `k` sorted lists into one sorted list using a heap.
> 3. Find the k-th largest element in a stream (supports repeated queries).
> 4. Interview: Maintain the median of a stream of numbers. (Hint: two heaps — a
>    max-heap for the lower half, a min-heap for the upper half — kept balanced.)

## 11. 1D Dynamic Programming

Dynamic programming (DP) solves problems by breaking them into overlapping
subproblems and storing each subproblem's answer so it is computed only once. In
1D DP the state is captured by a single index. DP converts exponential recursion
into polynomial time.

### 11.1 Memoization vs Tabulation

DP has two implementation styles. *Memoization* (top-down) writes the natural
recursion but caches results so each state is solved once. *Tabulation*
(bottom-up) fills a table from base cases upward, avoiding recursion entirely.
Both need two properties: *optimal substructure* (the answer builds from
subproblem answers) and *overlapping subproblems* (the same subproblems recur).

The intuition with Fibonacci: naive recursion recomputes `fib(3)` many times,
exploding to O(2^n). Caching each `fib(k)` once collapses it to O(n).

```python
# Top-down: memoization
def fib_memo(n, cache={}):
    if n < 2:
        return n
    if n not in cache:
        cache[n] = fib_memo(n - 1, cache) + fib_memo(n - 2, cache)
    return cache[n]

# Bottom-up: tabulation with O(1) space (only last two values needed)
def fib_tab(n):
    if n < 2:
        return n
    prev, cur = 0, 1
    for _ in range(2, n + 1):
        prev, cur = cur, prev + cur     # roll the window forward
    return cur
```

```text
Without memo (fib 5):        With memo:
        f5                   compute f1..f5 once each
      /    \                 f2=f1+f0, f3=f2+f1, ...
    f4      f3               O(n) time instead of O(2^n)
   / \     / \
  f3  f2  f2 f1   <- f3, f2 recomputed repeatedly
```

| Style       | Direction | Pros                         | Cons                     |
| ----------- | --------- | ---------------------------- | ------------------------ |
| Memoization | Top-down  | Mirrors recursion; lazy      | Recursion depth/overhead |
| Tabulation  | Bottom-up | No recursion; easy to shrink | Must order states        |

> Key Takeaways
> - DP needs optimal substructure and overlapping subproblems.
> - Memoization caches recursive calls; tabulation fills a table iteratively.
> - Many 1D DPs only need the last few states, enabling O(1) space.

> 🧪 Practice
> 1. Climbing Stairs: count the ways to reach step `n` taking 1 or 2 steps.
> 2. House Robber: maximize the sum of non-adjacent elements.
> 3. Coin Change: fewest coins to make an amount (return -1 if impossible).
> 4. Interview: Longest Increasing Subsequence in O(n log n). (Hint: keep the
>    smallest possible tail for each subsequence length via binary search.)

## 12. Intervals

Interval problems deal with ranges `[start, end]` — meetings, bookings, number
lines. The recurring insight is that sorting intervals by start (or end) exposes
their overlap structure, letting you merge, insert, or count them in a single
linear pass after the sort.

### 12.1 Merging and Overlap

Two intervals overlap when one starts before the other ends. To merge a list,
sort by start time, then sweep left to right: if the current interval overlaps
the last merged one, extend that one's end; otherwise start a new merged
interval.

The "why" of sorting: once sorted by start, any interval can only overlap with
the most recently added merged interval, so you never need to look backward
further. That reduces an O(n^2) all-pairs comparison to O(n log n) (sort) + O(n)
(sweep).

```python
def merge(intervals):
    intervals.sort(key=lambda iv: iv[0])    # sort by start
    merged = [intervals[0]]
    for start, end in intervals[1:]:
        last = merged[-1]
        if start <= last[1]:                # overlaps the last merged interval
            last[1] = max(last[1], end)     # extend it
        else:
            merged.append([start, end])     # disjoint -> new interval
    return merged

# merge([[1,3],[2,6],[8,10],[15,18]]) -> [[1,6],[8,10],[15,18]]
```

```text
sorted:  [1,3] [2,6] [8,10] [15,18]
number line:
1---3
  2------6      -> overlap -> merge into 1------6
              8--10
                          15----18
result: [1,6] [8,10] [15,18]
```

> Key Takeaways
> - Sort by start; then a single sweep handles all overlaps.
> - Overlap test: `next.start <= current.end`.
> - Dominant cost is the O(n log n) sort; the sweep is O(n).

> 🧪 Practice
> 1. Merge all overlapping intervals.
> 2. Insert a new interval into a sorted, non-overlapping list and merge as
>    needed.
> 3. Determine whether a person could attend all meetings (no overlaps).
> 4. Interview: Find the minimum number of meeting rooms required. (Hint: sort
>    start and end times separately, or use a min-heap of end times.)

## 13. Greedy

A greedy algorithm builds a solution by always taking the choice that looks best
right now, never reconsidering. It is simpler and faster than DP, but only
correct when local optimal choices provably lead to a global optimum. Recognizing
*when* greedy works is the real skill.

### 13.1 Greedy Strategy and Correctness

A greedy algorithm needs the *greedy-choice property* (a globally optimal
solution can be reached by locally optimal choices) and *optimal substructure*.
When these hold, you skip exploring alternatives entirely. When they do not,
greedy gives a wrong answer and you need DP or search.

The intuition with Kadane's algorithm (maximum subarray): at each element, either
extend the running subarray or start fresh from the current element — whichever
is larger. The local decision "would restarting help?" is provably safe here.

```python
def max_subarray(nums):
    best = cur = nums[0]
    for x in nums[1:]:
        cur = max(x, cur + x)           # extend, or restart at x
        best = max(best, cur)           # track the best seen
    return best

# max_subarray([-2,1,-3,4,-1,2,1,-5,4]) -> 6  ([4,-1,2,1])
```

A cautionary contrast: greedy coin change (always take the largest coin) works
for standard currencies but *fails* for denominations like `[1, 3, 4]` making
6 — greedy gives `4+1+1` (3 coins) while the optimum is `3+3` (2 coins). That
problem needs DP.

> Key Takeaways
> - Greedy works only with the greedy-choice property plus optimal substructure.
> - When valid, it is typically O(n log n) or O(n) and very simple.
> - Always sanity-check with a counterexample; many "obvious" greedies are wrong.

> 🧪 Practice
> 1. Maximum Subarray (Kadane's algorithm).
> 2. Jump Game: can you reach the last index given max jump lengths?
> 3. Assign cookies to maximize satisfied children (greedy matching).
> 4. Interview: Given gas and cost arrays, find the starting station to complete
>    a circular route. (Hint: if total gas >= total cost, a unique start exists;
>    reset the candidate whenever the running tank goes negative.)

## 14. Advanced Graphs

A graph is a set of nodes (vertices) connected by edges, modeling networks, maps,
dependencies, and relationships. This chapter covers representation and
traversal, weighted shortest paths, and connectivity structures — the tools
behind routing, scheduling, and clustering.

### 14.1 Representation and Traversal

Graphs are usually stored as an *adjacency list* (each node maps to its
neighbors) — compact for sparse graphs — or an *adjacency matrix* (a 2D grid of
edge existence) — simple but O(V^2) space. Traversal visits nodes via BFS (a
queue, shortest hops in unweighted graphs) or DFS (a stack/recursion, deep
exploration). A `visited` set prevents revisiting and infinite loops on cycles.

The "why" of `visited`: unlike trees, graphs can have cycles, so you must record
where you have been or you will loop forever.

```python
from collections import deque

graph = {0: [1, 2], 1: [2], 2: [0, 3], 3: []}   # adjacency list

def bfs(start):
    visited = {start}
    q = deque([start])
    order = []
    while q:
        node = q.popleft()
        order.append(node)
        for nbr in graph[node]:
            if nbr not in visited:      # skip already-seen nodes
                visited.add(nbr)
                q.append(nbr)
    return order

def dfs(node, visited):
    visited.add(node)
    for nbr in graph[node]:
        if nbr not in visited:
            dfs(nbr, visited)
```

| Representation   | Space   | Edge check | Best for        |
| ---------------- | ------- | ---------- | --------------- |
| Adjacency list   | O(V+E)  | O(degree)  | Sparse graphs   |
| Adjacency matrix | O(V^2)  | O(1)       | Dense graphs    |

> Key Takeaways
> - Adjacency lists suit sparse graphs; matrices suit dense ones or O(1) edge
>   checks.
> - BFS gives shortest paths in unweighted graphs; DFS explores deeply.
> - Always track visited nodes to handle cycles.

> 🧪 Practice
> 1. Count the number of connected components (islands) in a grid.
> 2. Detect a cycle in a directed graph.
> 3. Interview: Clone a graph, preserving all nodes and edges. (Hint: map
>    originals to copies as you DFS/BFS.)

### 14.2 Weighted Shortest Paths (Dijkstra)

When edges carry non-negative weights, BFS no longer gives shortest paths.
Dijkstra's algorithm repeatedly expands the closest not-yet-finalized node,
using a min-heap ordered by distance from the source. Once a node is popped, its
shortest distance is final.

The intuition: always finalize the nearest frontier node next; because weights
are non-negative, no later path can improve a node you already reached most
cheaply.

```python
import heapq

def dijkstra(graph, source):
    # graph: node -> list of (neighbor, weight)
    dist = {source: 0}
    pq = [(0, source)]                  # (distance, node)
    while pq:
        d, node = heapq.heappop(pq)
        if d > dist.get(node, float('inf')):
            continue                    # stale entry, skip
        for nbr, w in graph[node]:
            nd = d + w
            if nd < dist.get(nbr, float('inf')):
                dist[nbr] = nd          # found a shorter path
                heapq.heappush(pq, (nd, nbr))
    return dist
```

Runtime is O((V + E) log V) with a binary heap. Dijkstra fails with negative
weights — use Bellman-Ford there.

> Key Takeaways
> - Dijkstra finds shortest paths from a source with non-negative weights.
> - Uses a min-heap; each node is finalized when first popped.
> - O((V+E) log V); for negative edges use Bellman-Ford instead.

> 🧪 Practice
> 1. Find the shortest path length between two nodes in a weighted graph.
> 2. Network Delay Time: time for a signal to reach all nodes from a source.
> 3. Interview: Find the cheapest flight from src to dst with at most `k` stops.
>    (Hint: Dijkstra/BFS variant that also tracks stops used.)

### 14.3 Union-Find and Minimum Spanning Trees

Union-Find (Disjoint Set Union) tracks which nodes belong to the same group,
supporting near-O(1) `find` (which set is `x` in?) and `union` (merge two sets).
With it, Kruskal's algorithm builds a *minimum spanning tree* (MST) — the
cheapest set of edges connecting all nodes without cycles — by adding edges
cheapest-first, skipping any that would join already-connected nodes.

The intuition for Union-Find: represent each set as a tree with a root
representative; two nodes are connected iff they share a root. *Path compression*
and *union by rank* flatten these trees, making operations almost constant.

```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))    # each node is its own root initially
        self.rank = [0] * n

    def find(self, x):
        while self.parent[x] != x:
            self.parent[x] = self.parent[self.parent[x]]  # path compression
            x = self.parent[x]
        return x

    def union(self, a, b):
        ra, rb = self.find(a), self.find(b)
        if ra == rb:
            return False                # already connected -> would form a cycle
        if self.rank[ra] < self.rank[rb]:
            ra, rb = rb, ra
        self.parent[rb] = ra            # attach smaller tree under larger
        if self.rank[ra] == self.rank[rb]:
            self.rank[ra] += 1
        return True

def kruskal(n, edges):                  # edges: (weight, u, v)
    uf = UnionFind(n)
    total = 0
    for w, u, v in sorted(edges):       # cheapest edges first
        if uf.union(u, v):              # add only if it connects new components
            total += w
    return total
```

> Key Takeaways
> - Union-Find answers connectivity queries in near-constant amortized time.
> - Path compression + union by rank keep the trees flat.
> - Kruskal's MST = sort edges, add each unless it forms a cycle (Union-Find
>   detects cycles).

> 🧪 Practice
> 1. Count connected components in an undirected graph using Union-Find.
> 2. Detect whether adding edges ever creates a cycle (redundant connection).
> 3. Interview: Given points on a plane, find the minimum cost to connect all of
>    them. (Hint: build all pairwise edges with Manhattan distance, then run
>    Kruskal or Prim.)

## 15. 2D Dynamic Programming

2D dynamic programming uses a two-dimensional state — typically two indices into
two sequences, or a position in a grid. The table `dp[i][j]` captures the answer
for a subproblem defined by both coordinates. These problems cover string
alignment, grids, and knapsack-style selection.

### 15.1 Grid and Two-Sequence DP

The key move is identifying what `dp[i][j]` means and which neighbors it depends
on. In grid problems it is usually "best value to reach cell `(i, j)`," depending
on the cell above and to the left. In two-sequence problems (like Longest Common
Subsequence) it is "answer for the first `i` chars of A and first `j` of B,"
depending on whether the current characters match.

The intuition for LCS: if the characters match, the answer extends the diagonal
subproblem by one; if not, take the better of dropping one character from either
string.

```python
def longest_common_subsequence(a, b):
    m, n = len(a), len(b)
    # dp[i][j] = LCS length of a[:i] and b[:j]; extra row/col of zeros
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if a[i - 1] == b[j - 1]:
                dp[i][j] = dp[i - 1][j - 1] + 1     # chars match -> extend diagonal
            else:
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])  # drop one char
    return dp[m][n]

# longest_common_subsequence("abcde", "ace") -> 3  ("ace")
```

```text
      ""  a  c  e
  ""   0  0  0  0
   a   0  1  1  1
   b   0  1  1  1
   c   0  1  2  2
   d   0  1  2  2
   e   0  1  2  3   <- answer bottom-right
```

A grid min-path example: `dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1])`.

> Key Takeaways
> - Define `dp[i][j]` precisely, then find which prior cells it depends on.
> - Matching characters extend the diagonal; mismatches take the best neighbor.
> - Add a zero-filled first row/column to avoid boundary special-casing.
> - Many 2D DPs can be reduced to O(n) space by keeping only the previous row.

> 🧪 Practice
> 1. Count unique paths from the top-left to bottom-right of a grid (right/down
>    only).
> 2. Minimum path sum through a grid of costs.
> 3. Edit distance: minimum insert/delete/replace operations to convert one
>    string into another.
> 4. Interview: 0/1 Knapsack — maximize value within a weight capacity. (Hint:
>    `dp[i][w]` chooses whether to include item `i`; iterate items and capacities.)

## 16. Bit Manipulation

Bit manipulation operates directly on the binary representation of integers using
bitwise operators. It enables compact sets, fast arithmetic tricks, and elegant
solutions to problems about pairing, parity, and subsets. Numbers are just fixed
arrays of bits you can address individually.

### 16.1 Bitwise Operators and Common Tricks

The core operators are AND (`&`), OR (`|`), XOR (`^`), NOT (`~`), and shifts
(`<<`, `>>`). AND masks bits, OR sets bits, XOR toggles/compares bits, and shifts
multiply or divide by powers of two. XOR is special: `x ^ x = 0` and `x ^ 0 = x`,
so XORing a list cancels every value that appears an even number of times.

The intuition for the "single number" problem: if every element appears twice
except one, XORing them all cancels the pairs and leaves the unique value.

```python
# Core idioms (bit 0 is least significant)
x = 0b1010
is_set   = (x >> 2) & 1               # test bit 2 -> 0
set_bit  = x | (1 << 0)               # set   bit 0 -> 0b1011
clear    = x & ~(1 << 1)              # clear bit 1 -> 0b1000
toggle   = x ^ (1 << 3)               # flip  bit 3 -> 0b0010
is_even  = (x & 1) == 0               # last bit -> even/odd
is_pow2  = x > 0 and (x & (x - 1)) == 0   # only one bit set

def single_number(nums):
    result = 0
    for n in nums:
        result ^= n                   # pairs cancel, unique survives
    return result

def count_bits(x):
    count = 0
    while x:
        x &= x - 1                    # clears the lowest set bit each loop
        count += 1
    return count
```

```text
  0b1010   (10)
& 0b1001   (x-1 = 9)
= 0b1000   -> lowest set bit removed; loop runs once per set bit
```

| Expression       | Effect                          |
| ---------------- | ------------------------------- |
| `x & (x - 1)`    | clears lowest set bit           |
| `x & -x`         | isolates lowest set bit         |
| `x ^ y`          | bits that differ                |
| `x << k`         | multiply by 2^k                 |
| `x >> k`         | divide by 2^k (floor)           |

> Key Takeaways
> - XOR cancels duplicates: `x ^ x = 0`, `x ^ 0 = x`.
> - `x & (x - 1)` clears the lowest set bit; count set bits by repeating it.
> - `(x & (x - 1)) == 0` tests a power of two (for x > 0).
> - Shifts are fast multiply/divide by powers of two.

> 🧪 Practice
> 1. Count the number of 1 bits in an integer (Hamming weight).
> 2. Given an array where every element appears twice except one, find the
>    single element.
> 3. Reverse the bits of a 32-bit unsigned integer.
> 4. Interview: Every element appears three times except one — find it. (Hint:
>    count each bit position mod 3, or use two accumulators.)

## 17. Math and Geometry

This chapter collects number-theory and coordinate/matrix techniques that appear
in interviews: modular arithmetic, primes, and geometric grid manipulations.
These problems reward recognizing structure and symmetry over brute force.

### 17.1 Number Theory Essentials

Common building blocks include the greatest common divisor (GCD), prime testing
and sieving, and modular arithmetic for keeping large results bounded. The
Euclidean algorithm computes GCD by repeatedly replacing the larger number with
its remainder — because `gcd(a, b) = gcd(b, a mod b)`.

The intuition for the Sieve of Eratosthenes: rather than testing each number for
primality independently, cross out all multiples of each prime you find; whatever
survives is prime. This finds all primes up to `n` in O(n log log n).

```python
def gcd(a, b):
    while b:
        a, b = b, a % b                 # Euclidean reduction
    return a

def sieve(n):
    is_prime = [True] * (n + 1)
    is_prime[0] = is_prime[1] = False
    for p in range(2, int(n ** 0.5) + 1):
        if is_prime[p]:
            for multiple in range(p * p, n + 1, p):
                is_prime[multiple] = False   # cross out multiples of p
    return [i for i, prime in enumerate(is_prime) if prime]

# Modular arithmetic keeps huge numbers manageable
MOD = 10 ** 9 + 7
result = (123456789 * 987654321) % MOD
```

> Key Takeaways
> - `gcd(a, b) = gcd(b, a mod b)`; the Euclidean algorithm is O(log min(a, b)).
> - The sieve finds all primes up to n in O(n log log n); start crossing at p*p.
> - Take a modulus after each multiply/add to prevent overflow in big-number
>   problems.

> 🧪 Practice
> 1. Compute the GCD and LCM of two integers (`lcm = a / gcd(a, b) * b`).
> 2. Count the primes strictly less than `n`.
> 3. Interview: Compute `x^n` efficiently (fast/binary exponentiation). (Hint:
>    square the base and halve the exponent; multiply in the base when the
>    exponent bit is 1.)

### 17.2 Matrix and Grid Techniques

Grid problems exploit index symmetry. Rotating an image 90 degrees clockwise, for
example, can be done in place by first transposing the matrix (swap across the
main diagonal) and then reversing each row. Spiral traversal and layer-by-layer
processing follow similar boundary-shrinking logic.

The "why" of transpose-then-reverse: transposing maps element `(i, j)` to
`(j, i)`; reversing each row then sends column `j` to its rotated position,
composing exactly into a 90-degree clockwise rotation without extra memory.

```python
def rotate(matrix):
    n = len(matrix)
    # Step 1: transpose in place (swap (i,j) with (j,i))
    for i in range(n):
        for j in range(i + 1, n):
            matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    # Step 2: reverse each row
    for row in matrix:
        row.reverse()
```

```text
transpose            reverse rows
1 2 3     1 4 7        7 4 1
4 5 6  -> 2 5 8   ->   8 5 2
7 8 9     3 6 9        9 6 3   (90 degrees clockwise)
```

> Key Takeaways
> - Rotate 90 degrees clockwise = transpose, then reverse each row (in place).
> - Grid traversals often shrink boundaries (top, bottom, left, right) inward.
> - Watch index bounds carefully; off-by-one errors dominate grid bugs.

> 🧪 Practice
> 1. Rotate an n x n matrix 90 degrees clockwise in place.
> 2. Return the elements of a matrix in spiral order.
> 3. Set entire rows and columns to zero wherever a zero appears, using O(1)
>    extra space.
> 4. Interview: Search a matrix sorted both row-wise and column-wise in O(m + n).
>    (Hint: start from the top-right corner and eliminate a row or column each
>    step.)
