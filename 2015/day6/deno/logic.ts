enum Action {
    TurnOn = "turn on",
    TurnOff = "turn off",
    Toggle = "toggle",
};

enum LightState {
    Off = 0,
    On = 1,
};

interface Instructions {
    action: Action,
    fromPosition: [number, number],
    toPosition: [number, number],
};

/**
 * Translates an instructions line to an instructions object.
 * @param {string} instructions The instructions (a single line) from the input data.
 */
function translateInstructions(instructions: string): Instructions | null {
    const matches =
        instructions.matchAll(/(.*)\s(\d+\,\d+).*\s(\d+\,\d+)/g).next().value ||
        [];

    if (matches.length < 4) {
        // Invalid instructions
        return null;
    }

    let action: Action;

    switch (matches[1]) {
        case "turn on":
            action = Action.TurnOn;
            break;
        case "turn off":
            action = Action.TurnOff;
            break;
        case "toggle":
            action = Action.Toggle;
            break;
        default:
            action = Action.TurnOff;
    }

    const fromPosition: [number, number] =
        matches[2].split(",").map((x: string) => parseInt(x));
    const toPosition: [number, number] =
        matches[3].split(",").map((x: string) => parseInt(x));

    return {
        action,
        fromPosition,
        toPosition,
    };
}

/**
 * Runs all the instructions then returns the number of lights left on.
 * @param {string} allInstructions Instructions separated by a new line.
 */
function runInstructions(allInstructions: string): number {
    const allLights =  Array.from(
        { length: 1000 },
        () => Array<LightState>(1000).fill(LightState.Off)
    );

    // A little helper function that can access allLights array without passing it.
    const getLightState = function (action: Action, x: number, y: number) {
        if (action === Action.Toggle) {
            // Update based on actual state of the light.
            return allLights[x][y] === LightState.On ? LightState.Off : LightState.On;
        }
        return action === Action.TurnOff ? LightState.Off : LightState.On;
    };

    // Loop through all instructions.
    allInstructions.split("\n").forEach((instructString: string) => {
        const instructions = translateInstructions(instructString);

        if (instructions === null) {
            // Invalid instructions.
            return;
        }

        for (let x = instructions.fromPosition[0]; x <= instructions.toPosition[0]; ++x) {
            for (let y = instructions.fromPosition[1]; y <= instructions.toPosition[1]; ++y) {
                const lightState = getLightState(instructions.action, x, y);
                allLights[x][y] = lightState;
            }
        }
    });

    // Sum up the lights in the On position.
    let lightsOnCount = 0;
    allLights.forEach((rowOfLights) => {
        rowOfLights.forEach((light: LightState) => {
            if (light === LightState.On) {
                lightsOnCount++;
            }
        });
    });

    return lightsOnCount;
}

export { Action, LightState, translateInstructions, runInstructions };
