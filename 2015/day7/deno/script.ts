import { runInstructions } from "./logic.ts";

const text = await Deno.readTextFile('../myinput.txt');

const wireValue = runInstructions(text);

console.log(`Wire A's value is ${wireValue}.`);

const overridenValue = runInstructions(text, "a", { wireLabel: "b", value: wireValue });

console.log(`Wire A's value when B is overridden with ${wireValue} is ${overridenValue}.`);
