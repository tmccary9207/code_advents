import { lookAndSay } from "./logic.ts";

// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  let lookAndSayNumber = "1113222113";

  for (let i = 0; i < 40; ++i) {
    lookAndSayNumber = lookAndSay(lookAndSayNumber);
  }

  console.log(
    `After 40 applications of LookAndSay the length is: ${lookAndSayNumber.length}`,
  );

  for (let i = 0; i < 10; ++i) {
    lookAndSayNumber = lookAndSay(lookAndSayNumber);
  }

  console.log(
    `After 50 applications of LookAndSay the length is: ${lookAndSayNumber.length}`,
  );
}
