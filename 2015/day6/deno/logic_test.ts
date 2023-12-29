import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { Action, translateInstructions, runInstructions } from "./logic.ts";

Deno.test("translateInstructions", () => {
    assertEquals(
        { action: Action.TurnOn, fromPosition: [0, 0], toPosition: [999, 999]},
        translateInstructions("turn on 0,0 through 999,999")
    );
    assertEquals(
        { action: Action.Toggle, fromPosition: [0, 0], toPosition: [999, 0]},
        translateInstructions("toggle 0,0 through 999,0")
    );
    assertEquals(
        { action: Action.TurnOff, fromPosition: [499, 499], toPosition: [500, 500]},
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
