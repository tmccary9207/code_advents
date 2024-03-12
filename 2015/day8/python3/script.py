#!/usr/bin/python3

import re
"""
Implementation of day 8 for year 2015 in AoC.
"""


def count_memory_chars(datum: str):
    """
    Counts the number of characters of code for string literals minus the
    number of characters in memory for the values of the string.

    A blank string (2 quotes).
    >>> count_memory_chars(r'""')
    2

    A normal string (2 quotes).
    >>> count_memory_chars(r'"abc"')
    2

    A normal string with a quote in the middle (2 quotes and an escaped quote).
    >>> count_memory_chars(r'"aaa\\"aaa"')
    3

    A string with a hex escape (2 quotes and an escaped hex).
    >>> count_memory_chars(r'"\\x27"')
    5
    """
    no_quotes = datum[1:-1]
    two_letter_match_count = len(re.findall(r'(\\")|(\\\\)', datum))
    four_letter_match_count = len(re.findall(r'(\\x[0-9|a-f|A-F]{2})', datum))

    return len(datum) - (len(no_quotes) - (two_letter_match_count +
                                           (3 * four_letter_match_count)))


def count_reencode_string_chars(datum: str):
    """
    Counts the total number of characters to represent the newly encoded
    strings minus the number of characters of code in each original string.

    A blank string (2 quotes) gets two esacped quotes inside it for 4 chars.
    >>> count_reencode_string_chars(r'""')
    4

    A normal string (2 quotes) gets two esacped quotes inside it for 4 chars.
    >>> count_reencode_string_chars(r'"abc"')
    4

    A normal string with a quote in the middle (2 quotes and an escaped quote).
    >>> count_reencode_string_chars(r'"aaa\\"aaa"')
    6

    A string with a hex escape (2 quotes and an escaped hex).
    >>> count_reencode_string_chars(r'"\\x27"')
    5
    """
    escaped_slash_count = len(re.findall(r'(\\)', datum))
    escaped_quotes_count = len(re.findall(r'(")', datum)) - 2

    return (escaped_slash_count + escaped_quotes_count) + 4


def main():
    """
    Runs the script for day 7.
    """
    with open('../myinput.txt', mode='r') as f:
        text = f.read()
        lines = text.strip().split("\n")

    memory_chars = 0
    encode_chars = 0
    for line in lines:
        memory_chars += count_memory_chars(line)
        encode_chars += count_reencode_string_chars(line)

    print(
        "The number of characters of code for string literals minus the number"
        + " of characters in memory for the values of " +
        f" the strings is {memory_chars}.")
    print("The total number of characters to represent the newly encoded " +
          "strings minus the number of characters of code in each original " +
          f"string literal is {encode_chars}.")


if __name__ == '__main__':
    main()
