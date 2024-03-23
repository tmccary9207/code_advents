# 2015 - DAY 8

This challenge is to take a file with string literals on each line and count the number of characters for the string literal two quotes plus the characters inside minus the number of actual characters in the string.

```
\" -> " escaped quote
\\ -> \ esacped backslash
\x27 -> ' escaped ascii character
```

## Part 2

The second part of this is to reencode all quotes with a slash and all slashes to double slashes. The result should be the amount of added chars.

## MY ANSWER?

```
The number of characters of code for string literals minus the number of characters in memory for the values of the strings is 1333.
The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is 2046.
```

## DENO/TYPESCRIPT

This wasn't too difficult code wise. I used regexes and replaceAll to reduce chars to a single char and to reencode chars for part 2. The real difficulty was encoding the strings for unit testing. Another way would be replace escapes with a letter then count the number of that letter in the string but that would be more searching instead of just comparing two lengths.

## PYTHON 3

This wasn't difficult either. The regex counting style of the typescript version works across languages very well.

## RUBY 3

Another easy translation from the typescript version. However, the unit test has some strange artifacts to it that the script isn't affected by. Pretty sure it is down to how strings are escaped internally.

## GO

As with Ruby and Python this was an easy translation. Nothing much else to say.

## RUST

As with the others a good algo saved the day.

## ELIXIR

Algo just keeps working. Easy.

## CLOJURE

Another algo save. Even in parenthesis town it works.
