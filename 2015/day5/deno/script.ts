import { isStringNice } from "./logic.ts";

const text = await Deno.readTextFile('../myinput.txt');

const numberOfNiceStrings = text.split('\n').filter(isStringNice).length;

console.log(`${numberOfNiceStrings} nice strings.`);
