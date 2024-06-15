import { assertEquals } from "jsr:@std/assert";
import {
  getLongestRoute,
  getRouteMap,
  getShortestRoute,
  lineToParts,
} from "./logic.ts";

Deno.test("lineToParts", () => {
  assertEquals(
    lineToParts("London to Dublin = 464"),
    ["London", "Dublin", 464],
  );
});

Deno.test("getRouteMap", () => {
  const exampleInput =
    "London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141";
  const partArrays = exampleInput.split("\n").map(lineToParts);

  assertEquals(
    getRouteMap(partArrays),
    {
      "Belfast": { "Dublin": 141, "London": 518 },
      "Dublin": { "Belfast": 141, "London": 464 },
      "London": { "Belfast": 518, "Dublin": 464 },
    },
  );
});

Deno.test("getShortestRoute", () => {
  assertEquals(
    getShortestRoute({
      "Belfast": { "Dublin": 141, "London": 518 },
      "Dublin": { "Belfast": 141, "London": 464 },
      "London": { "Belfast": 518, "Dublin": 464 },
    }),
    605,
  );
  assertEquals(
    getShortestRoute({
      "1": { "2": 7, "3": 9, "6": 14 },
      "2": { "1": 7, "3": 10, "4": 15 },
      "3": { "2": 10, "4": 11, "1": 9, "6": 2 },
      "4": { "2": 15, "3": 11, "5": 6 },
      "5": { "4": 6, "6": 9 },
      "6": { "5": 9, "3": 2, "1": 14 },
    }),
    33,
  );
});

Deno.test("getLongestRoute", () => {
  assertEquals(
    getLongestRoute({
      "Belfast": { "Dublin": 141, "London": 518 },
      "Dublin": { "Belfast": 141, "London": 464 },
      "London": { "Belfast": 518, "Dublin": 464 },
    }),
    982,
  );
  assertEquals(
    getLongestRoute({
      "1": { "2": 7, "3": 9, "6": 14 },
      "2": { "1": 7, "3": 10, "4": 15 },
      "3": { "2": 10, "4": 11, "1": 9, "6": 2 },
      "4": { "2": 15, "3": 11, "5": 6 },
      "5": { "4": 6, "6": 9 },
      "6": { "5": 9, "3": 2, "1": 14 },
    }),
    58,
  );
});
