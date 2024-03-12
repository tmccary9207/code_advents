import { countMemoryChars, reencodeStringChars } from "./logic.ts";

const text = await Deno.readTextFile("../myinput.txt");
const lines = text.trimEnd().split("\n");

let memoryChars = 0;
let encodeChars = 0;
lines.forEach((val) => {
  memoryChars += countMemoryChars(val);
  encodeChars += reencodeStringChars(val);
});

console.log(
  `The number of characters of code for string literals minus the number of characters in memory for the values of the strings is ${memoryChars}.`,
);
console.log(
  `The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is ${encodeChars}.`,
);
