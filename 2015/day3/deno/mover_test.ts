import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { santaNewLocation, takeDirections } from './mover.ts';

Deno.test("sanataNewLocation", () => {
    assertEquals([0, 1], santaNewLocation([0, 0], "^"));
    assertEquals([0, -1], santaNewLocation([0, 0], "v"));
    assertEquals([1, 0], santaNewLocation([0, 0], ">"));
    assertEquals([-1, 0], santaNewLocation([0, 0], "<"));
});

Deno.test("takeDirections example 1", () => {
    assertEquals(2, takeDirections(">"));
});
Deno.test("takeDirections example 2", () => {
    assertEquals(4, takeDirections("^>v<"));
});
Deno.test("takeDirections example 3", () => {
    assertEquals(2, takeDirections("^v^v^v^v^v"));
});
