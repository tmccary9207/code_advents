#!/usr/bin/python3
import re

"""
Implementation of day 11 for year 2015 in AoC.
"""

def get_next_char(char: str) -> str:
    """
    Get the next valid char.

    Examples
    --------
    >>> get_next_char("z")
    'a'

    >>> get_next_char("h")
    'j'

    >>> get_next_char("k")
    'm'

    >>> get_next_char("n")
    'p'

    >>> get_next_char("a")
    'b'

    >>> get_next_char("e")
    'f'
    """
    ord_val = ord(char)
    match ord_val:
        case 122:
            return "a"
        case 104 | 107 | 110:
            return chr(ord_val + 2)
        case _:
            return chr(ord_val + 1)

def has_three_ascending_letters(input: str) -> str:
    """
    Checks to see there is a set of three ascending
    letters.

    Examples
    --------
    >>> has_three_ascending_letters("")
    False

    >>> has_three_ascending_letters("abc")
    True

    >>> has_three_ascending_letters("lllbcdi")
    True
    """
    if len(input) < 3:
        return False

    triplets = [input[i:i+3] for i in range(len(input) - 2)]
    for triplet in triplets:
        first = ord(triplet[0])
        second = ord(triplet[1])
        third = ord(triplet[2])
        if first + 1 == second and second + 1 == third:
            return True

    return False

def get_next_password(current: str) -> str:
    """
    Gets the next valid password.

    Examples
    --------
    >>> get_next_password("cqqxxyzs")
    'cqqxxyzt'

    >>> get_next_password("abcdefgh")
    'abcdffaa'

    >>> get_next_password("ghijklmn")
    'ghjaabcc'
    """
    remaining = current[0:7]

    # Clip the remaining to the position of
    # i, l or o in the current and replace
    # it with a valid char.
    res = re.search(r"[ilo]", remaining)
    if res != None:
        remaining = remaining[0:res.start()] + get_next_char(res.group(0))


    if not has_three_ascending_letters(remaining):
        if len(remaining) > 3:
            next_char_two = get_next_char(remaining[3])
            next_char_three = get_next_char(next_char_two)
            return remaining[0:4] +\
                remaining[3] +\
                next_char_two + (2 * next_char_three)
        return remaining + ((5 - len(remaining)) * "a") + "bcc"

    num_of_pairs = len(re.findall(r"(.)\1", remaining))

    if num_of_pairs == 2:
        return remaining + get_next_char(current[-1])
    if num_of_pairs == 1:
        return remaining[0:2] +\
            get_next_char(remaining[2]) +\
            "aabcc"
    return remaining[0:4] +\
        (2 * get_next_char(remaining[4]) +\
        (2 * "a"))

def main():
    """
    Runs the script for day 11.
    """
    current_password = "cqjxjnds"
    next_password_one = get_next_password(current_password)
    next_password_two = get_next_password(next_password_one)
    print(f"Next password is: {next_password_one}")
    print(f"Next password after that is: {next_password_two}")

if __name__ == '__main__':
    main()
