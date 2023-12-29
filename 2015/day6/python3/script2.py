#!/usr/bin/python3

import re
import typing

"""
Translates an instructions line to an instructions object.
"""
def translate_instructions(instructions: str) -> typing.Optional[dict]:
    """
    Turn on all lights from 0,0 to 999,999
    >>> translate_instructions("turn on 0,0 through 999,999")
    {'action': 'turn on', 'fromPosition': [0, 0], 'toPosition': [999, 999]}

    Toggle all lights from 0,0 to 999,0
    >>> translate_instructions("toggle 0,0 through 999,0")
    {'action': 'toggle', 'fromPosition': [0, 0], 'toPosition': [999, 0]}

    Turn off all lights from 499,499 to 500,500
    >>> translate_instructions("turn off 499,499 through 500,500")
    {'action': 'turn off', 'fromPosition': [499, 499], 'toPosition': [500, 500]}
    """
    tuples = re.findall(r'(.*)\s(\d+\,\d+).*\s(\d+\,\d+)', instructions)
    if not tuples:
        return None
    matches = tuples[0]
    return {
        'action': matches[0],
        'fromPosition': [int(x) for x in matches[1].split(",")],
        'toPosition': [int(x) for x in matches[2].split(",")],
    }

"""
Runs all the instructions then returns the brightness of the light array.
"""
def run_instructions(all_instructions: str) -> int:
    r"""
    Turning on all lights results in 1,000,000
    >>> run_instructions("turn on 0,0 through 999,999\n")
    1000000

    Toggling 0,0 to 999,0 results in 1,000
    >>> run_instructions("toggle 0,0 through 999,0\n")
    2000

    Turning every light on and 4 off results in 999,996
    >>> run_instructions("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n")
    999996

    Turning on 1 light results in 1
    >>> run_instructions("turn on 0,0 through 0,0\n")
    1

    Toggling a million results in 2,000,000
    >>> run_instructions("toggle 0,0 through 999,999\n")
    2000000
    """
    all_lights = [[0 for _ in range(1000)] for _ in range(1000)]

    for instruction_string in all_instructions.split('\n'):
        instructions = translate_instructions(instruction_string)

        if instructions is None:
            continue

        for x in range(instructions['fromPosition'][0], instructions['toPosition'][0] + 1):
            for y in range(instructions['fromPosition'][1], instructions['toPosition'][1] + 1):
                state = all_lights[x][y]
                if instructions['action'] == 'toggle':
                    all_lights[x][y] = state + 2
                    continue
                if instructions['action'] == 'turn off':
                    all_lights[x][y] = state - 1 if state - 1 != -1 else 0
                    continue
                all_lights[x][y] = state + 1

    brightness = 0
    for x in range(1000):
        for y in range(1000):
            brightness += all_lights[x][y]

    return brightness

"""
Runs the script for day 6.
"""
def main():
    with open('../myinput.txt', mode='r') as f:
        lights_on_count = run_instructions(f.read())
        print(f"{lights_on_count} lights are on.")

if __name__ == '__main__':
    main()
