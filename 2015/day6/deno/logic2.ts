enum Action {
    TurnOn = "turn on",
    TurnOff = "turn off",
    Toggle = "toggle",
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
 * Runs all the instructions then returns the brightness of the light array.
 * @param {string} allInstructions Instructions separated by a new line.
 */
function runInstructions(allInstructions: string): number {
    const allLights =  Array.from(
        { length: 1000 },
        () => Array<number>(1000).fill(0)
    );

    // A little helper function that can access allLights array without passing it.
    const getLightState = function (action: Action, x: number, y: number) {
        const current = allLights[x][y];
        if (action === Action.Toggle) {
            // Update based on actual state of the light.
            return current + 2;
        }
        if (action === Action.TurnOn) {
            return current + 1;
        }
        if ((current - 1) < 0) {
            return 0;
        }
        return current - 1;
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
    let totalBrightness = 0;
    allLights.forEach((rowOfLights) => {
        rowOfLights.forEach((light: number) => {
            totalBrightness += light;
        });
    });

    return totalBrightness;
}

export { Action, translateInstructions, runInstructions };
