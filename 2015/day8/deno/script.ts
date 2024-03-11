import { countMemoryChars, reencodeString } from "./logic.ts";

const text = await Deno.readTextFile("../myinput.txt");
const lines = text.trimEnd().split("\n");

console.log(`first: ${lines[0].length}`);
console.log(`first mem chars: ${countMemoryChars(lines[0])}`);

let codeChars = 0;
let encodeChars = 0;
lines.forEach((val) => {
  codeChars += val.length - countMemoryChars(val);
  encodeChars += reencodeString(val).length - val.length;
});

console.log(
  `The number of characters of code for string literals minus the number of characters in memory for the values of the strings is ${codeChars}.`,
);
console.log(
  `The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is ${encodeChars}.`,
);
