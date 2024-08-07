# 2015 - DAY 9

This challenge revolves around the idea that Santa has a list of locations he
needs to visit. The goal is to answer with shortest distance that yields him
having visted all locations only once.

## myinput.txt format

```
X to Y = 1
Y to Z = 2
X to Z = 3
```

## MY ANSWER? Part 1

Using a Dijkstra algo on each possible origin I loop over every possible
starting point to find the absolute shortest distance. Probably not the least
intense calculation but it gets the correct answer.

```
Shortest possible distance is: 251
```

## PART 2

The opposite needs to happen, the goal is to find the longest possible
distance.

## MY ANSWER? Part 2

Creating another function that just does the opposite is all that is
needed.

```
Longest possible distance is: 898
```

## DENO

In Javascript this is an easy task I figure. The hard part was just trying
to the Dijkstra algo enough that I could write it and apply it to a situation
where I have to test all possible starting locations.

## PYTHON3

Same as Javascript but with a little bit of pythonic code.

## RUBY

Same as Javascript but ruby-esque (happiness intensifies).

## GOLANG

Same implementation just Golang style. The iterative nature of the solution
is very obvious in this version. I am sure there is some linked list logic
solution avaiable to me that I didn't use but I just wanted what works.

## RUST

Same implementation but I did use a comparator function for so I wouldn't
need to repeat it into a short and long function. Just string slices and
at one point a `*` to remove some borrowing. Never had to do that in Rust
before though I can say I have now. Not really the easiest up until now
due to the borrow checker.

## Elixir

No more simple for loop logic with local variables this time. A comparator
and tail call recursive logic is required to get to the solution. This
was a bit more work to get done mentally but it runs like greased lightning.

## Clojure

This was a tad bit easier than Elixir as I didn't have to think of pattern
matching when writing functions (just use `recur`). It is a lot shorter
compared to the Elixir version even though the same immutable rules apply.
However, it does take longer as it has to force lazy sequences.
