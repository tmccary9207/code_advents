#!/usr/bin/python3

from functools import reduce

"""
Get the new location for Santa.
"""
def new_location(current_location: tuple, direction: str) -> tuple:
    """
    0, 0 + ^ results in 0, 1
    >>> new_location((0, 0), "^")
    (0, 1)

    0, 0 + v results in 0, -1
    >>> new_location((0, 0), "v")
    (0, -1)

    0, 0 + > results in 1, 0
    >>> new_location((0, 0), ">")
    (1, 0)

    0, 0 + < results in -1, 0
    >>> new_location((0, 0), "<")
    (-1, 0)
    """
    match direction:
        case "^":
            return (current_location[0], current_location[1] + 1)
        case "v":
            return (current_location[0], current_location[1] - 1)
        case ">":
            return (current_location[0] + 1, current_location[1])
        case "<":
            return (current_location[0] - 1, current_location[1])
        case _:
            return current_location

"""
Takes in directions from an elf and returns the number of unique houses Santa visited.
"""
def take_directions(directions: str) -> int:
    """
    > results in 2
    >>> take_directions(">")
    2

    ^>v< results in 4
    >>> take_directions("^>v<")
    4

    ^v^v^v^v^v results in 2
    >>> take_directions("^v^v^v^v^v")
    2
    """
    visited = {"0,0"}
    current_location = (0, 0)
    for direction in directions:
        current_location = new_location(current_location, direction)
        visited.add(f"{current_location[0]},{current_location[1]}")
    return len(visited)

"""
Runs the script for day 3.
"""
def main():
    with open('../myinput.txt', mode='r') as f:
        houses_visited = take_directions(f.read())
        print(f"At least this many houses received a single present: {houses_visited}")

if __name__ == '__main__':
    main()
