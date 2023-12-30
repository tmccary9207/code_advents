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
  fromPositionStart: string,
  fromPositionEnd: string,
  toPositionStart: string,
  toPositionEnd: string,
};

/**
 * Translates an instructions line to an instructions object.
 * @param {string} instructions The instructions (a single line) from the input data.
 */
function translateInstructions(instructions: string): Instructions | null {
  const groups =
    (instructions
      .matchAll(/(?<action>.*)\s(?<fromPositionStart>\d+)\,(?<fromPositionEnd>\d+).*\s(?<toPositionStart>\d+)\,(?<toPositionEnd>\d+)/g)
      .next().value || {}).groups;

  if (!groups) {
    // Invalid instructions
    return null;
  }

  return groups;
}

/**
 * Creates the initial light array.
 */
function createLightArray(): Array<Array<number>> {
  return Array.from(
    { length: 1000 },
    () => Array<LightState>(1000).fill(LightState.Off)
  );
}

/**
 * Runs all the instructions then returns the number of lights left on.
 * @param {string} allInstructions Instructions separated by a new line.
 */
function runInstructions(allInstructions: string): number {
  const allLights = createLightArray();

  // A little helper function that can access allLights array without passing it.
  const getLightState = function(action: Action, x: number, y: number) {
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

    for (let x = parseInt(instructions.fromPositionStart); x <= parseInt(instructions.toPositionStart); ++x) {
      for (let y = parseInt(instructions.fromPositionEnd); y <= parseInt(instructions.toPositionEnd); ++y) {
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

/**
 * Runs all the instructions then returns the brightness of the light array.
 * @param {string} allInstructions Instructions separated by a new line.
 */
function runInstructions2(allInstructions: string): number {
  const allLights = createLightArray();

  // A little helper function that can access allLights array without passing it.
  const getLightState = function(action: Action, x: number, y: number) {
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

    for (let x = parseInt(instructions.fromPositionStart); x <= parseInt(instructions.toPositionStart); ++x) {
      for (let y = parseInt(instructions.fromPositionEnd); y <= parseInt(instructions.toPositionEnd); ++y) {
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

export { Action, LightState, translateInstructions, runInstructions, runInstructions2 };
