#!/usr/bin/python3

import re

"""
Checks if there are three or more vowels in a string.
"""
def has_three_or_more_vowels(datum: str) -> bool:
    """
    aei results in True
    >>> has_three_or_more_vowels("aei")
    True

    xazegov results in True (a,e,o)
    >>> has_three_or_more_vowels("xazegov")
    True

    aeiouaeiouaeiou results in True (a, e, i, o, u) x 3
    >>> has_three_or_more_vowels("aeiouaeiouaeiou")
    True

    ugknbfddgicrmopn results in True (u,i,o)
    >>> has_three_or_more_vowels("ugknbfddgicrmopn")
    True

    aaa results in True (a,a,a)
    >>> has_three_or_more_vowels("aaa")
    True

    jchzalrnumimnmhp results in True (a,u,i)
    >>> has_three_or_more_vowels("jchzalrnumimnmhp")
    True

    haegwjzuvuyypxyu results in True (a,e,u,u,u)
    >>> has_three_or_more_vowels("haegwjzuvuyypxyu")
    True

    dvszwmarrgswjxmb results in False (a)
    >>> has_three_or_more_vowels("dvszwmarrgswjxmb")
    False
    """
    return len(re.findall("[aeiou]", datum)) > 2

"""
Checks if there is a pair of letters repeated in a string.
"""
def has_same_letter_pair(datum: str) -> bool:
    """
    xx results in True
    >>> has_same_letter_pair("xx")
    True

    abcdde results in True
    >>> has_same_letter_pair("abcdde")
    True

    aabbccdd results in True
    >>> has_same_letter_pair("aabbccdd")
    True

    ugknbfddgicrmopn results in True
    >>> has_same_letter_pair("ugknbfddgicrmopn")
    True

    aaa results in True
    >>> has_same_letter_pair("aaa")
    True

    jchzalrnumimnmhp results in False
    >>> has_same_letter_pair("jchzalrnumimnmhp")
    False

    haegwjzuvuyypxyu results in True
    >>> has_same_letter_pair("haegwjzuvuyypxyu")
    True

    dvszwmarrgswjxmb results in True
    >>> has_same_letter_pair("dvszwmarrgswjxmb")
    True
    """
    return len(re.findall(r"(.)\1{1,}", datum)) > 0

"""
Checks if there is any naughty strings in the string.
"""
def has_no_naughty_strings(datum: str) -> bool:
    """
    xx results in True
    >>> has_no_naughty_strings("xx")
    True

    abcdde results in False
    >>> has_no_naughty_strings("abcdde")
    False

    aabbccdd results in False
    >>> has_no_naughty_strings("aabbccdd")
    False

    ugknbfddgicrmopn results in True
    >>> has_no_naughty_strings("ugknbfddgicrmopn")
    True

    aaa results in True
    >>> has_no_naughty_strings("aaa")
    True

    jchzalrnumimnmhp results in True
    >>> has_no_naughty_strings("jchzalrnumimnmhp")
    True

    haegwjzuvuyypxyu results in False
    >>> has_no_naughty_strings("haegwjzuvuyypxyu")
    False

    dvszwmarrgswjxmb results in True
    >>> has_no_naughty_strings("dvszwmarrgswjxmb")
    True
    """
    return len(re.findall(r"(ab)|(cd)|(pq)|(xy)", datum)) < 1

"""
Checks if string is nice.
"""
def is_string_nice(datum: str) -> bool:
    """
    xx results in False
    >>> is_string_nice("xx")
    False

    abcdde results in False
    >>> is_string_nice("abcdde")
    False

    aabbccdd results in False
    >>> is_string_nice("aabbccdd")
    False

    ugknbfddgicrmopn results in True
    >>> is_string_nice("ugknbfddgicrmopn")
    True

    aaa results in True
    >>> is_string_nice("aaa")
    True

    jchzalrnumimnmhp results in False
    >>> is_string_nice("jchzalrnumimnmhp")
    False

    haegwjzuvuyypxyu results in False
    >>> is_string_nice("haegwjzuvuyypxyu")
    False

    dvszwmarrgswjxmb results in False
    >>> is_string_nice("dvszwmarrgswjxmb")
    False
    """
    return has_three_or_more_vowels(datum) and has_same_letter_pair(datum) and has_no_naughty_strings(datum)

"""
Runs the script for day 5.
"""
def main():
    with open('../myinput.txt', mode='r') as f:
        nice_string_count = len(list(filter(lambda x: is_string_nice(x), f.read().split('\n'))))
        print(f"{nice_string_count} nice strings.")

if __name__ == '__main__':
    main()
