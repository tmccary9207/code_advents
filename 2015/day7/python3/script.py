#!/usr/bin/python3

import re
import typing

"""
Translates a line of instructions into a instructions dictionary or None.
"""
def translate_instructions(datum: str) -> typing.Optional[dict]:
    r"""
    Instructions to assign 123 to wire labelled x.
    >>> translate_instructions("123 -> x") == {'wireLabel': 'x', 'value': '123'}
    True

    Instructions to assign the value of wire a to wire labelled x.
    >>> translate_instructions("a -> x") == {'wireLabel': 'x', 'source': 'a'}
    True

    Instructions to assign the value of x bitwise AND y to wire labelled z.
    >>> translate_instructions("x AND y -> z") == {'wireLabel': 'z', 'logicLeft': 'x', 'leftNumber': False, 'logicOperator': 'AND', 'logicRight': 'y', 'rightNumber': False}
    True

    Instructions to assign the value of p bitwise LSHIFT 2 to wire labelled q.
    >>> translate_instructions("p LSHIFT 2 -> q") == {'wireLabel': 'q', 'logicLeft': 'p', 'leftNumber': False, 'logicOperator': 'LSHIFT', 'logicRight': '2', 'rightNumber': True}
    True

    Instructions to assign the value of e bitwise NOT to wire labelled f.
    >>> translate_instructions("NOT e -> f") == {'wireLabel': 'f', 'logicRight': 'e', 'rightNumber': False}
    True
    """
    match = re.match(
       r'^(?P<value>\d+) -> (?P<wireLabel>\w+)$',
       datum
    )

    if match:
        return match.groupdict()

    match = re.match(
        r'^(?P<source>\w+) -> (?P<wireLabel>\w+)$',
        datum
    )

    if match:
        return match.groupdict()

    match = re.match(
        r'^(NOT)\s(?P<logicRight>\w+)\s->\s(?P<wireLabel>\w+)$',
        datum
    )

    if match:
        dict = match.groupdict()
        dict['rightNumber'] = re.match(r'^\d+$', dict['logicRight']) is not None
        return dict

    match = re.match(
        r'^(?P<logicLeft>\w+)\s(?P<logicOperator>\w+)\s(?P<logicRight>\w+|\d+)\s->\s(?P<wireLabel>\w+)$',
        datum
    )

    if match:
        dict = match.groupdict()
        dict['leftNumber'] = re.match(r'^\d+$', dict['logicLeft']) is not None
        dict['rightNumber'] = re.match(r'^\d+$', dict['logicRight']) is not None
        return dict

    return None

"""
Returns instructions as a list of two lists. First is a value set instructions and the second logic instructions.
"""
def get_instructions(datum: str) -> tuple[list[dict], list[dict]]:
    r"""
    Returns the instructions from an input string.
    >>> expected = (
    ...        [{'value': '123', 'wireLabel': 'x'}, {'value': '456', 'wireLabel': 'y'}],
    ...        [
    ...             {'logicLeft': 'x', 'logicOperator': 'AND', 'logicRight': 'y', 'wireLabel': 'd', 'leftNumber': False, 'rightNumber': False},
    ...             {'logicLeft': 'x', 'logicOperator': 'OR', 'logicRight': 'y', 'wireLabel': 'e', 'leftNumber': False, 'rightNumber': False},
    ...             {'logicLeft': 'x', 'logicOperator': 'LSHIFT', 'logicRight': '2', 'wireLabel': 'f', 'leftNumber': False, 'rightNumber': True},
    ...             {'logicLeft': 'y', 'logicOperator': 'RSHIFT', 'logicRight': '2', 'wireLabel': 'g', 'leftNumber': False, 'rightNumber': True},
    ...             {'logicRight': 'x', 'wireLabel': 'h', 'rightNumber': False}, {'logicRight': 'y', 'wireLabel': 'i', 'rightNumber': False}
    ...        ]
    ...    )
    >>> get_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i") == expected
    True
    """
    value_instructions = []
    logic_instructions = []

    for line in datum.split('\n'):
        instructions = translate_instructions(line)
        if instructions is None:
            continue
        if 'value' in instructions:
            value_instructions.append(instructions)
            continue
        logic_instructions.append(instructions)

    return value_instructions, logic_instructions

"""
Initialize the wires with values that can be set from the get go.
"""
def setup_wires(instructions: list[dict]) -> dict:
    r"""
    Initializes the wires.
    >>> setup_wires([{'value': '123', 'wireLabel': 'x'}, {'value': '456', 'wireLabel': 'y'}])
    {'x': 123, 'y': 456}
    """
    wires = {}

    for instruction in instructions:
        wires[instruction['wireLabel']] = int(instruction['value'])

    return wires

"""
Checks to see if the instruction is possible given the current state of the wires.
"""
def is_instruction_doable(instruction: dict, wires: dict) -> bool:
    r"""
    No wires and a not logic instruction with a value should be True.
    >>> is_instruction_doable({'wireLabel':'f','logicRight':'123','rightNumber':True}, {})
    True

    No wires and a not logic instruction with a source wire should be False.
    >>> is_instruction_doable({'wireLabel':'f','logicRight':'q','rightNumber':False}, {})
    False

    Has wires and a not logic instruction with a source wire in wires should be True.
    >>> is_instruction_doable({'wireLabel':'f','logicRight':'q','rightNumber':False}, {'q':1})
    True

    No wires and a logic instruction with values should be True.
    >>> is_instruction_doable({'wireLabel':'g','logicRight':'2','rightNumber':True,'logicLeft':'2','leftNumber':True,'logicOperator':'RSHIFT'}, {})
    True

    No wires and a logic instruction with value and a wire should be False.
    >>> is_instruction_doable({'wireLabel':'g','logicRight':'2','rightNumber':True,'logicLeft':'x','leftNumber':False,'logicOperator':'RSHIFT'}, {})
    False

    Has wires and a logic instruction with value and a wire should be True.
    >>> is_instruction_doable({'wireLabel':'g','logicRight':'2','rightNumber':True,'logicLeft':'x','leftNumber':False,'logicOperator':'RSHIFT'}, {'x': 2})
    True

    Has wires and a logic instruction with two wires should be True.
    >>> is_instruction_doable({'wireLabel':'g','logicRight':'y','rightNumber':False,'logicLeft':'x','leftNumber':False,'logicOperator':'RSHIFT'}, {'x': 2, 'y': 3})
    True
    """
    if 'source' in instruction:
        return instruction['source'] in wires

    if 'logicLeft' not in instruction:
        return instruction['rightNumber'] or (instruction['logicRight'] in wires)

    is_okay = instruction['leftNumber'] or (instruction['logicLeft'] in wires)
    if not is_okay:
        return False

    is_okay = instruction['rightNumber'] or (instruction['logicRight'] in wires)

    return is_okay

"""
Applies the instructions and sets the value to the wires.
"""
def apply_logic(instruction: dict, wires: dict):
    r"""
    Apply AND logic.
    >>> original = {'x':123,'y':456}
    >>> apply_logic({'wireLabel':'d','logicLeft':'x','leftNumber':False,'logicRight':'y','rightNumber':False,'logicOperator':'AND'},original)
    >>> original == {'d': 72,'x':123,'y':456}
    True

    Apply OR logic.
    >>> original = {'x':123,'y':456}
    >>> apply_logic({'wireLabel':'e','logicLeft':'x','leftNumber':False,'logicRight':'y','rightNumber':False,'logicOperator':'OR'},original)
    >>> original == {'e': 507,'x':123,'y':456}
    True

    Apply LSHIFT logic.
    >>> original = {'x':123,'y':456}
    >>> apply_logic({'wireLabel':'f','logicLeft':'x','leftNumber':False,'logicRight':'2','rightNumber':True,'logicOperator':'LSHIFT'},original)
    >>> original == {'f': 492,'x':123,'y':456}
    True

    Apply RSHIFT logic.
    >>> original = {'x':123,'y':456}
    >>> apply_logic({'wireLabel':'g','logicLeft':'y','leftNumber':False,'logicRight':'2','rightNumber':True,'logicOperator':'RSHIFT'},original)
    >>> original == {'g':114,'x':123,'y':456}
    True

    Apply NOT wire logic.
    >>> original = {'x':123,'y':456}
    >>> apply_logic({'wireLabel':'h','logicRight':'x','rightNumber':False},original)
    >>> original == {'h': 65412,'x':123,'y':456}
    True

    Apply NOT logic #2.
    >>> original = {'x':123,'y':456}
    >>> apply_logic({'wireLabel':'i','logicRight':'y','rightNumber':False},original)
    >>> original == {'i': 65079,'x':123,'y':456}
    True
    """
    if 'source' in instruction:
        # ASSIGNMENT
        wires[instruction['wireLabel']] = wires[instruction['source']]
        return
    if 'logicLeft' not in instruction:
        # LOGIC NOT
        value = wires[instruction['logicRight']] if not instruction['rightNumber'] else int(instruction['logicRight'])
        wires[instruction['wireLabel']] = ~value & 0xFFFF
        return

    # LOGIC INSTRUCTIONS
    left_value = wires[instruction['logicLeft']] if not instruction['leftNumber'] else int(instruction['logicLeft'])
    right_value = wires[instruction['logicRight']] if not instruction['rightNumber'] else int(instruction['logicRight'])
    match instruction['logicOperator']:
        case "AND":
            wires[instruction['wireLabel']] = left_value & right_value
            return
        case "OR":
            wires[instruction['wireLabel']] = left_value | right_value
            return
        case "LSHIFT":
            wires[instruction['wireLabel']] = (left_value << right_value) & 0xFFFF
            return
        case "RSHIFT":
            wires[instruction['wireLabel']] = (left_value >> right_value) & 0xFFFF
            return

"""
Filter logic for run_instructions.
"""
def filter_logic(instruction: dict, wires: dict) -> bool:
    if not is_instruction_doable(instruction, wires):
        return True
    apply_logic(instruction, wires)
    return False

"""
Runs the instructions and returns the value of target_wire.
"""
def run_instructions(datum: str, target_wire: str = "a", override: typing.Optional[dict] = None):
    r"""
    Wire d is 72.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "d")
    72

    Wire e is 507.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "e")
    507

    Wire f is 492.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "f")
    492

    Wire g is 114.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "g")
    114

    Wire h is 65412.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "h")
    65412

    Wire i is 65079.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "i")
    65079

    Wire x is 123.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "x")
    123

    Wire y is 456.
    >>> run_instructions("123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i", "y")
    456
    """
    (value_instructions, logic_instructions) = get_instructions(datum)
    old_li_length = -1
    wires = setup_wires(value_instructions)

    if override:
        wires[override['wireLabel']] = override['value']

    while len(logic_instructions) > 0 and old_li_length != len(logic_instructions):
        old_li_length = len(logic_instructions)
        logic_instructions = list(filter(lambda x: filter_logic(x, wires), logic_instructions))

    return wires[target_wire] if target_wire in wires else 0

"""
Runs the script for day 7.
"""
def main():
    with open('../myinput.txt', mode='r') as f:
        text = f.read()
        wire_a_original = run_instructions(text, "a")
        print(f"Wire A's value is {wire_a_original}.")
        new_wire_a_value = run_instructions(text, "a", {'wireLabel': 'b','value': wire_a_original})
        print(f"Wire A's value when B is overridden with {wire_a_original} is {new_wire_a_value}.")

if __name__ == '__main__':
    main()
