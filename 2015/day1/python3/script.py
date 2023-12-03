#!/usr/bin/python3

from functools import reduce

"""
A reducer to get the floor that Santa ends up on.
"""
def reducer(input: str) -> int:
    """
    "(())" Results in floor 0:
    >>> reducer("(())")
    0

    "()()" Results in floor 0:
    >>> reducer("()()")
    0

    "(((" results in floor 3.
    >>> reducer("(((")
    3

    "(()(()(" results in floor 3.
    >>> reducer("(()(()(")
    3

    "))(((((" results in floor 3.
    >>> reducer("))(((((")
    3

    "())" results in floor -1.
    >>> reducer("())")
    -1

    "))(" results in floor -1.
    >>> reducer("))(")
    -1

    ")))" results in floor -3.
    >>> reducer(")))")
    -3

    ")())())" results in floor -3.
    >>> reducer(")())())")
    -3
    """
    return reduce(lambda x, y: x + 1 if y == '(' else x - 1, input, 0)

"""
Runs the script for day 1.
"""
def main():
    with open('../myinput.txt', mode='r') as f:
        floor = reducer(f.read().replace("\n", ""))
        print(f"Santa ends up on floor: {floor}")

if __name__ == '__main__':
    main()
