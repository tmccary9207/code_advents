import { reducer } from "./reducer.ts";

const text = await Deno.readTextFile('../myinput.txt').then((input) => input.replaceAll('\n', ''));

console.log(`Santa ends up on floor: ${reducer(text)}`);
