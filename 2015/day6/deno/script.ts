import { runInstructions, runInstructions2 } from "./logic.ts";

const text = await Deno.readTextFile('../myinput.txt');

const numberOfLightsOn = runInstructions(text);

console.log(`${numberOfLightsOn} lights are on.`);

const totalbrightness = runInstructions2(text);

console.log(`${totalbrightness} is the total brightness.`);
