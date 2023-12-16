import { takeDirections } from "./mover.ts";

const text = await Deno.readTextFile('../myinput.txt');

console.log(`At least this many houses received a single present: ${takeDirections(text)}`);
