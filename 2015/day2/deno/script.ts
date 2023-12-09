import { surfaceAreaWithSlack  } from "./surface_calculator.ts";

const text = await Deno.readTextFile('../myinput.txt').then(x => x.replace(/\n$/, ""));
const presents = text.split('\n');
const totalSurfaceArea = presents.reduce((acc, x) =>  acc + surfaceAreaWithSlack(x), 0);

console.log(`Total quare feet of wrapping paper needed: ${totalSurfaceArea}`);
