import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { Action, translateInstructions, runInstructions, runInstructions2 } from "./logic.ts";

Deno.test("translateInstructions", () => {
  assertEquals(
    {
      action: Action.TurnOn,
      fromPositionStart: "0",
      fromPositionEnd: "0",
      toPositionStart: "999",
      toPositionEnd: "999"
    },
    translateInstructions("turn on 0,0 through 999,999")
  );
  assertEquals(
    {
      action: Action.Toggle,
      fromPositionStart: "0",
      fromPositionEnd: "0",
      toPositionStart: "999",
      toPositionEnd: "0"
    },
    translateInstructions("toggle 0,0 through 999,0")
  );
  assertEquals(
    {
      action: Action.TurnOff,
      fromPositionStart: "499",
      fromPositionEnd: "499",
      toPositionStart: "500",
      toPositionEnd: "500"
    },
    translateInstructions("turn off 499,499 through 500,500")
  );
});

Deno.test("runInstructions", () => {
  assertEquals(
    1000000,
    runInstructions("turn on 0,0 through 999,999\n")
  );
  assertEquals(
    1000,
    runInstructions("toggle 0,0 through 999,0\n")
  );
  assertEquals(
    999996,
    runInstructions("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n")
  );
});

Deno.test("runInstructions2", () => {
  assertEquals(
    1000000,
    runInstructions2("turn on 0,0 through 999,999\n")
  );
  assertEquals(
    2000,
    runInstructions2("toggle 0,0 through 999,0\n")
  );
  assertEquals(
    999996,
    runInstructions2("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n")
  );
  assertEquals(
    1,
    runInstructions2("turn on 0,0 through 0,0\n")
  );
  assertEquals(
    2000000,
    runInstructions2("toggle 0,0 through 999,999\n")
  );
});
