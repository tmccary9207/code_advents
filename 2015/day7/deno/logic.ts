type Instruction =  ValueInstruction | AssignmentInstruction | LeftRightLogicInstruction | NotLogicInstruction;

interface ValueInstruction {
    type: string;
    wireLabel: string;
    value: string;
}

interface AssignmentInstruction {
    type: string;
    wireLabel: string;
    source: string;
}

interface LeftRightLogicInstruction {
    type: string;
    wireLabel: string;
    logicLeft: string;
    logicLeftNumber: boolean;
    logicOperator: string;
    logicRight: string;
    logicRightNumber: boolean;
}

interface NotLogicInstruction {
    type: string;
    wireLabel: string;
    logicRight: string;
    logicRightNumber: boolean;
}

interface OverrideInstruction {
    wireLabel: string;
    value: number;
}

/**
 * Translates the instructions into one of three kinds of instructions or null.
 * @param {string} datum Instruction string
 */
function translateInstructions(datum: string): Instruction | null {
    const valueInstruction = (datum.matchAll(/^(?<value>\d+) -> (?<wireLabel>\w+)$/g).next().value  || {}).groups;

    if (valueInstruction) {
        valueInstruction.type = "valueInstruction";
        return valueInstruction as ValueInstruction;
    }

    const assignmentInstruction = (datum.matchAll(/^(?<source>\w+) -> (?<wireLabel>\w+)$/g).next().value || {}).groups;

    if (assignmentInstruction) {
        assignmentInstruction.type = "assignmentInstruction";
        return assignmentInstruction as AssignmentInstruction;
    }

    const notLogicInstruction = (datum.matchAll(/^(NOT)\s(?<logicRight>\w+)\s->\s(?<wireLabel>\w+)$/g).next().value || {}).groups;

    if (notLogicInstruction) {
        notLogicInstruction.type = "notLogicInstruction";
        notLogicInstruction.logicRightNumber = notLogicInstruction.logicRight.match(/^\d+$/g) !== null;
        return notLogicInstruction as NotLogicInstruction;
    }

    const leftRightLogicInstruction = (datum.matchAll(/^(?<logicLeft>\w+)\s(?<logicOperator>\w+)\s(?<logicRight>\w+|\d+)\s->\s(?<wireLabel>\w+)$/g).next().value || {}).groups;

    if (leftRightLogicInstruction) {
        leftRightLogicInstruction.type = "leftRightLogicInstruction";
        leftRightLogicInstruction.logicLeftNumber = leftRightLogicInstruction.logicLeft.match(/^\d+$/g) !== null;
        leftRightLogicInstruction.logicRightNumber = leftRightLogicInstruction.logicRight.match(/^\d+$/g) !== null;
        return leftRightLogicInstruction as LeftRightLogicInstruction;
    }

    return null;
}

/**
 * Returns instructions as an array of two arrays. First is a value set instructions and the second logic instructions.
 * @param {string} datum Input string with new lines.
 */
function getInstructions(datum: string): [ValueInstruction[], Instruction[]] {
    return datum
        .split("\n")
        .filter((x: string) => x)
        .reduce(
            (acc, x) => {
                const instruction = translateInstructions(x);
                if (instruction == null) {
                    return acc;
                }
                if (instruction.type === "valueInstruction") {
                    return [acc[0].concat(instruction as ValueInstruction), acc[1]];
                }
                return [acc[0], acc[1].concat(instruction)];
            },
            [[] as ValueInstruction[], [] as Instruction[]]
        );
}

/**
 * Initialize the wires with values that can be set from the get go.
 * @param {Array} instructions Value set instructions array.
 */
function setupWiresWithValueInstructions(instructions: ValueInstruction[]): Map<string, number> {
    return instructions.reduce((acc, x) => {
        acc.set(x.wireLabel, parseInt(x.value) & 0xFFFF)
        return acc;
    }, new Map<string, number>());
}

/**
 * Checks to see if the current wire logic is applicable to the current state of the wires.
 * @param {Instruction} instruction wire instruction
 * @param {Map<string, number>} wires wires
 */
function isInstructionDoable(instruction: Instruction, wires: Map<string, number>): boolean {
    switch (instruction.type) {
        case "notLogicInstruction": {
            // Has the wire already been setup or is the logic being applied to a number?
            const notLI = instruction as NotLogicInstruction;
            return notLI.logicRightNumber || wires.has(notLI.logicRight);
        }
        case "assignmentInstruction": {
            const assLI = instruction as AssignmentInstruction;
            return wires.has(assLI.source);
        }
        default: {
            const leftRightLI = instruction as LeftRightLogicInstruction;
            const isLeftOkay = leftRightLI.logicLeftNumber || wires.has(leftRightLI.logicLeft);
            if (!isLeftOkay) {
                return false;
            }
            const isRightOkay = leftRightLI.logicRightNumber || wires.has(leftRightLI.logicRight);
            if (!isRightOkay) {
                return false;
            }
            return true;
        }
    }
}

/**
 * Applies the logic instruction on the wires.
 * @param {Instruction} instruction
 * @param {Map<string, number>} wires wires
 */
function applyLogic(instruction: Instruction, wires: Map<string, number>) {
    switch (instruction.type) {
        case "notLogicInstruction": {
            const notLI = instruction as NotLogicInstruction;
            const value = (notLI.logicRightNumber ? parseInt(notLI.logicRight) : wires.get(notLI.logicRight)) || 0;
            wires.set(notLI.wireLabel, (~value & 0xFFFF));
            return;
        }
        case "assignmentInstruction": {
            const assLI = instruction as AssignmentInstruction;
            wires.set(assLI.wireLabel, wires.get(assLI.source) || 0);
            return;
        }
        default: {
            const leftRightLI = instruction as LeftRightLogicInstruction;
            const leftValue = (leftRightLI.logicLeftNumber ?
                parseInt(leftRightLI.logicLeft) :
                wires.get(leftRightLI.logicLeft)) || 0;
            const rightValue = (leftRightLI.logicRightNumber ?
                parseInt(leftRightLI.logicRight) :
                wires.get(leftRightLI.logicRight)) || 0;
            switch (leftRightLI.logicOperator) {
                case "AND":
                    wires.set(leftRightLI.wireLabel, (leftValue & rightValue) & 0xFFFF);
                    return;
                case "OR":
                    wires.set(leftRightLI.wireLabel, (leftValue | rightValue) & 0xFFFF);
                    return;
                case "LSHIFT":
                    wires.set(leftRightLI.wireLabel, (leftValue << rightValue) & 0xFFFF);
                    return;
                case "RSHIFT":
                    wires.set(leftRightLI.wireLabel, (leftValue >> rightValue) & 0xFFFF);
                    return;
            }
        }
    }
}

/**
 * Runs the wires logic instructions and returns the value for the target wire.
 * @param {string} text logic instructions
 * @param targetWire target wire to get value from (default is "a").
 * @param {OverrideInstruction} overrideInstruction Override a wire with a value instruction.
 */
function runInstructions(text: string, targetWire = "a", overrideInstruction: OverrideInstruction | null = null): number {
    let [valueInstructions, logicInstructions] = getInstructions(text);
    let oldLILength = -1;
    const wires = setupWiresWithValueInstructions(valueInstructions);
    if (overrideInstruction !== null) {
        // If supplied with an override set that value after the setup is complete.
        wires.set(overrideInstruction.wireLabel, overrideInstruction.value);
    }

    while (logicInstructions.length > 0 && logicInstructions.length !== oldLILength) {
        // Prevent a endless loop by checking that a deadlock hasn't occurred.
        oldLILength = logicInstructions.length;
        logicInstructions = logicInstructions.filter((instruction) => {
            if (!isInstructionDoable(instruction, wires)) {
                // Can't do this instruction yet so return true so it can be tried on the next loop.
                return true;
            }

            applyLogic(instruction, wires);

            return false;
        });
    }

    return wires.get(targetWire) || 0;
}

export { applyLogic, getInstructions, isInstructionDoable, runInstructions, setupWiresWithValueInstructions, translateInstructions };
