#!/usr/bin/python3

"""
Implementation of day 10 for year 2015 in AoC.
"""

def look_and_say(input: str) -> str:
    """
    Get a Look And Say Sequence of a digit only string.

    Examples
    --------
    >>> look_and_say("1")
    '11'

    >>> look_and_say("11")
    '21'

    >>> look_and_say("21")
    '1211'

    >>> look_and_say("1211")
    '111221'

    >>> look_and_say("111221")
    '312211'
    """
    # chars = input.split('')
    current = input[0]
    current_count = 0
    output = ''

    for char in input:
        if current == char:
            current_count += 1
        else:
            output += str(current_count) + current
            current = char
            current_count = 1
    output += str(current_count) + current

    return output

def main():
    """
    Runs the script for day 10.
    """
    look_and_say_number = "1113222113"

    for _ in range(40):
        look_and_say_number = look_and_say(look_and_say_number)

    print(f"After 40 applications of LookAndSay the length is: {len(look_and_say_number)}")

    for _ in range(10):
        look_and_say_number = look_and_say(look_and_say_number)
    
    print(f"After 50 applications of LookAndSay the length is: {len(look_and_say_number)}")

if __name__ == '__main__':
    main()
