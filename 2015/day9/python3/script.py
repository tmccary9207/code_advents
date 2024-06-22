#!/usr/bin/python3

from sys import maxsize
"""
Implementation of day 9 for year 2015 in AoC.
"""

def line_to_parts(input: str) -> list[str, str, int]:
    """
    Takes a line of input and splits into a list of origin,
    desination, distance.

    Examples
    --------
    >>> line_to_parts("London to Dublin = 464")
    ['London', 'Dublin', 464]
    """
    origin, _, destination, __, distance = input.split(' ')
    return [origin, destination, int(distance)]

def get_route_map(parts: list[list[str, str, int]]) -> dict:
    """
    Takes a list of part lists and produce a route dict.

    Examples
    --------
    >>> get_route_map([['London', 'Dublin', 464], ['London', 'Belfast', 518], ['Dublin', 'Belfast', 141]])
    {'London': {'Dublin': 464, 'Belfast': 518}, 'Dublin': {'London': 464, 'Belfast': 141}, 'Belfast': {'London': 518, 'Dublin': 141}}
    """
    routes = {}

    for part in parts:
        origin, destination, distance = part
        origin_map = routes.get(origin) or {}
        destination_map = routes.get(destination) or {}
        origin_map[destination] = distance
        destination_map[origin] = distance
        routes[origin] = origin_map
        routes[destination] = destination_map

    return routes

def get_shortest_route(routes: dict) -> int:
    """
    Get the shortest distance that can be traveled from
    a given routemap.

    Examples
    --------

    From the AoC description.
    >>> get_shortest_route({"Belfast": { "Dublin": 141, "London": 518 }, "Dublin": { "Belfast": 141, "London": 464 }, "London": { "Belfast": 518, "Dublin": 464 }, })
    605

    A more difficult example.
    >>> get_shortest_route({"1": { "2": 7, "3": 9, "6": 14 },"2": { "1": 7, "3": 10, "4": 15 },"3": { "2": 10, "4": 11, "1": 9, "6": 2 },"4": { "2": 15, "3": 11, "5": 6 },"5": { "4": 6, "6": 9 },"6": { "5": 9, "3": 2, "1": 14 },})
    33
    """
    locations = list(routes.keys())
    number_of_hops = len(locations) - 1
    shortest = maxsize

    for start_location in locations:
        distance_for_route = 0
        visited = [start_location]

        for _ in range(number_of_hops):
            origin = routes.get(visited[-1])
            destinations_not_yet_visited = [
                x for x in list(origin.keys()) if x not in visited
            ]

            if len(destinations_not_yet_visited) < 1:
                break

            chosen = destinations_not_yet_visited[0]
            chosen_distance = origin.get(chosen)
            for x in destinations_not_yet_visited:
                x_distance = origin.get(x)
                if x_distance < chosen_distance:
                    chosen = x
                    chosen_distance = x_distance

            visited.append(chosen)
            distance_for_route += chosen_distance
        
        if len(visited) == len(locations) and distance_for_route < shortest:
            shortest = distance_for_route

    return shortest

def get_longest_route(routes: dict) -> int:
    """
    Get the longest distance that can be traveled from
    a given routemap.

    Examples
    --------

    From the AoC description.
    >>> get_longest_route({"Belfast": { "Dublin": 141, "London": 518 }, "Dublin": { "Belfast": 141, "London": 464 }, "London": { "Belfast": 518, "Dublin": 464 }, })
    982

    A more difficult example.
    >>> get_longest_route({"1": { "2": 7, "3": 9, "6": 14 },"2": { "1": 7, "3": 10, "4": 15 },"3": { "2": 10, "4": 11, "1": 9, "6": 2 },"4": { "2": 15, "3": 11, "5": 6 },"5": { "4": 6, "6": 9 },"6": { "5": 9, "3": 2, "1": 14 },})
    58
    """
    locations = list(routes.keys())
    number_of_hops = len(locations) - 1
    longest = 0

    for start_location in locations:
        distance_for_route = 0
        visited = [start_location]

        for _ in range(number_of_hops):
            origin = routes.get(visited[-1])
            destinations_not_yet_visited = [
                x for x in list(origin.keys()) if x not in visited
            ]

            if len(destinations_not_yet_visited) < 1:
                break

            chosen = destinations_not_yet_visited[0]
            chosen_distance = origin.get(chosen)
            for x in destinations_not_yet_visited:
                x_distance = origin.get(x)
                if x_distance > chosen_distance:
                    chosen = x
                    chosen_distance = x_distance

            visited.append(chosen)
            distance_for_route += chosen_distance
        
        if len(visited) == len(locations) and distance_for_route > longest:
            longest = distance_for_route

    return longest

def main():
    """
    Runs the script for day 9.
    """
    with open('../myinput.txt', mode='r') as f:
        text = f.read()
        lines = text.strip().split("\n")

    routes = get_route_map([line_to_parts(line) for line in lines])
    shortest = get_shortest_route(routes)
    longest = get_longest_route(routes)

    print(f"Shortest possible distance is: {shortest}")
    print(f"Longest possible distance is: {longest}")

    return

if __name__ == '__main__':
    main()