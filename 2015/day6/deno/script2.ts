import { runInstructions } from "./logic2.ts";

const text = await Deno.readTextFile('../myinput.txt');

const totalBrightness = runInstructions(text);

console.log(`${totalBrightness} is the total brightness.`);
