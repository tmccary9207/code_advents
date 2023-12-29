import { runInstructions } from "./logic.ts";

const text = await Deno.readTextFile('../myinput.txt');

const numberOfLightsOn = runInstructions(text);

console.log(`${numberOfLightsOn} lights are on.`);
