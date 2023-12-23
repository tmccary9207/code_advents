import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { doesHashStartWithFiveZeros, getLowestNumber } from "./logic.ts";

Deno.test("doesHashStartWithFiveZeros", () => {
    assertEquals(true, doesHashStartWithFiveZeros("000001dbbfa"));
    assertEquals(false, doesHashStartWithFiveZeros("000011dbbfa"));
});

Deno.test("getLowestNumber", async () => {
    assertEquals(609043, await getLowestNumber("abcdef"));
    assertEquals(1048970, await getLowestNumber("pqrstuv"));
});
