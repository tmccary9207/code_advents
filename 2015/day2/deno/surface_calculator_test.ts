import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { surfaceAreaWithSlack  } from "./surface_calculator.ts";

Deno.test("surfaceAreaWithSlack example 1", () => {
    assertEquals(58, surfaceAreaWithSlack("2x3x4"));
});
Deno.test("surfaceAreaWithSlack example 2", () => {
    assertEquals(43, surfaceAreaWithSlack("1x1x10"));
});
