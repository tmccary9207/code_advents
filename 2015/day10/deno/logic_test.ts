import { assertEquals } from "https://deno.land/std@0.224.0/assert/mod.ts";

import { lookAndSay } from "./logic.ts";

Deno.test("lookAndSay", () => {
    assertEquals(
        "11",
        lookAndSay("1"),
    );
    assertEquals(
        "21",
        lookAndSay("11"),
    );
    assertEquals(
        "1211",
        lookAndSay("21"),
    );
    assertEquals(
        "111221",
        lookAndSay("1211"),
    );
    assertEquals(
        "312211",
        lookAndSay("111221"),
    );
});
