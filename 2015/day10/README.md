# 2015 - DAY 10

This puzzle revolves around a look-and-say sequence and the output is the
length of applying the sequence 40 times to the input.

## My Input

`1113222113`

## PART 1 ANSWER

`After 40 applications of LookAndSay the length is: 252594`

## PART 2 ANSWER

`After 50 applications of LookAndSay the length is: 3579328`

## Deno/Typescript

This wasn't too hard. Way easier than I had imagined because the look and say
sequence didn't make too much sense to me. I did think of doing some reduction
on the input string and some other functional methods but brute force
iterative stuff seemed easier to me. Given the length of the input it does
seem like this problem tests string handling in a language/runtime.

## Python3

This was pretty straight forward as it is just like the Deno implementation.

## Ruby

Same style but it isn't that fast at all. Even with a forced for loop it
wasn't faster. I believe this has to do with the way Ruby indexes strings
and builds them. Considering it has to allot a ~36 million character
long string by the end there has to be some bottle neck. I did try to do
some other algos in IRB but I couldn't find a simple solution off the top
of my head. I will have to think on a faster one.

After some thinking I decided to go with a paired array. I didn't think
it would be faster as the runtime would have to go over the data still
and while it is at it get a sub array. However, the number of items is half
because of the fact all items are pairs. So instead of ~36 million chars as
well as any overhead from strings it is just an array with about ~18 million.

## Go

This has the same slowness as ruby. It ran slower oddly enough. I do believe
it is the creation of strings and reparsing them. I will defintely have to
use a different method for performance.

I took the more performant solution from the Ruby folder and did it in
Go. The speed is on par with the Ruby solution.

## Rust

Used the same method as Ruby and Go. It runs just as fast I think. Easy
enough.

## Elixir

This time I used pattern matching and a bit of internal recursion to
get the exact number of iterations. The curve ball is that appending
to a list in Elixir is slow so just add to the head of a list while
building it then slap it into reverse (small time penalty). Pretty
fun solution to write.

## Clojure

In Clojure there isn't the same kind of function pattern matching out
of the box (there is a lib from what I searched). Anyways, I used the
loop function with recur to go over the pairs for a number of iters.
It looks kind of ugly but it gets the job done like the other solutions.
I think doing both iteration and building in one function is the cause
of the ugliness. I am sure that I could make it beautiful but it works.
