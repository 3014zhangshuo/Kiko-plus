---
layout: post
title: "算法运行时间估算"
date: 2021-06-22
tags: [algorithm]
---

#### O(1) - Constant Time
The algorithm performs a constant number of operations regardless of the size of the input.

**Examples:**
- Access a single number in an array by index
- Add 2 numbers together

#### O(log n) - Logarithmic Time
As the size of input `n` increases, the algorithm's running time grows by `log(n)`. The rate
of growth is relatively slow, so O(log n) algorithms are usually very fast. As you can see in the table below, when `n` is 1 billion, `log(n)` is only 30.

**Example:**
Binary search on a sorted list. The size that needs to be searched is split in half each time, so the remaining list goes from size n to n/2 to n/4... until either the element is found or there's just one element left. If there are a billion elements in the list, it will take a maximum of 30 checks to find the element or determine that it is not on the list.

Whenever an algorithm only goes through part of its input, see if it splits the input by at least half on average each time, which would give it a logarithmic running time.

*Table of n vs. log(n)*

|n   |log(n)|
|----|------|
|2   |1     |
|1000|10    |
|1M  |20    |
|1B  |30    |

#### O(n) - Linear Time
The running time of an algorithm grows in proportion to the size of input.

**Examples:**
- Search through an unsorted array for a number
- Sum all the numbers in an array
- Access a ingle number in a LinkedList by index

#### O(n log n) - Linearithmic time
log(n) is much closer to n than to n^2, so this running time is closer to linear than to higher running times (and no one actually says "Linearithmic").

**Examples:**
Sort an array with QuickSort or Merge Sort. When recursion in involved, calculating the running time can be complicated. You can often work out a sample case to estimate what the running time will be.

#### O(n^2) - Quadratic Time
The algorithm's running time grows in proportion to the square of the input size, and is common when using nested-loops.

**Examples:**
- Printing the multiplication table for a list of numbers
- Insertion Sort

*Table of n vs. n^2*

|n   |n^2   |
|----|------|
|1   |1     |
|10  |100   |
|10  |10,000|
|1000|1M    |

Nested Loops
Sometimes you'll encounter O(n^3) algorithms or even higher exponents. These usually have considerably worse running times than O(n^2) algorithms even if they don't have a different name!

A Quadratic running time is common when you have nested loops. To calculate the running time, find the maximum number of nested loops that go through a significant portion of the input.

- 1 loop (not nested) = O(n)
- 2 loops = O(n^2)
- 3 loops = O(n^3)

Some algorithms use nested loops where the outer loop goes through an input m. The time complexity in such cases is O(nm). For example, while the above multiplication table compared a list of data to itself, in other cases you may want to compare all of one list n with all of another list m.



* [Running time and Big-O](https://www.learneroo.com/modules/106/nodes/559)
* [程序运行时间估算](https://blog.csdn.net/qq_35212671/article/details/53414729)
