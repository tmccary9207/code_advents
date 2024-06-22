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
