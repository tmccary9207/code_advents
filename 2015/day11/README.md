# 2015 - DAY 11

This puzzle revolves around rotating the last character in a string to
meet a few requirements. The answer should be the next valid password.

1. Must have three letters in order.
2. Can not have `i`, `o` or `l` in it.
3. Must contain two pairs of letters in it.

## My Input

`cqjxjnds`

## PART 1 ANSWER

`cqjxxyzz`

## PART 2 ANSWER

`cqkaabcc`

## Deno/Typescript

For this solution I used three checking functions and generator to produce all
possible strings up to N length. Never used generators before in JS so it was
interesting. Very iterrative in nature. There is a simple trick to just output
a fresh code but it isn't very programming centric in my opinion.

## Python3

I tried the more logic pattern approach for Python3. It works without countless
iterations but I am sure there are cases where it fails. Seems that calling it
a simple trick wasn't true. It was a great mental exercise none the less.

## Ruby

## Go

## Rust

## Elixir

## Clojure
