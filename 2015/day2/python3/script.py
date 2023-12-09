#!/usr/bin/python3

from functools import reduce

"""
Calculate the surface area of the present.
"""
def surface_area(sides: list[int]) -> int:
    """
    6, 12, 8 Results in 52
    >>> surface_area([6, 12, 8])
    52

    1, 10, 10 Results in 42
    >>> surface_area([1, 10, 10])
    42
    """
    return reduce(lambda x, y: x + y, [x * 2 for x in sides], 0)

"""
Calculate the surface area plus slack for a present.
"""
def surface_area_with_slack(input: str) -> int:
    """
    2x3x4 results to 58:
    >>> surface_area_with_slack("2x3x4")
    58

    1x1x10 results to 43:
    >>> surface_area_with_slack("1x1x10")
    43
    """
    length, width, height = [int(x) for x in input.split("x")]
    sides = [(length * width), (width * height), (height * length)]
    return surface_area(sides) + min(sides)

"""
Runs the script for day 2.
"""
def main():
    with open('../myinput.txt', mode='r') as f:
        total_surface_area = reduce(lambda x, y: x + surface_area_with_slack(y), f.read().strip().split("\n"), 0)
        print(f"Total square feet of wrapping paper needed: {total_surface_area}")

if __name__ == '__main__':
    main()
