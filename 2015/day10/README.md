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
itterative stuff seemed easier to me. Given the length of the input it does
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

## Go

This has the same slowness as ruby. It ran slower oddly enough. I do believe
it is the creation of strings and reparsing them. I will defintely have to
use a different method for performance.
