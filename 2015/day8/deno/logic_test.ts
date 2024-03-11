import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { countMemoryChars, reencodeString } from "./logic.ts";

Deno.test("countMemoryChars", () => {
  assertEquals(
    0,
    countMemoryChars(`\"\"`),
  );
  assertEquals(
    3,
    countMemoryChars(`\"abc\"`),
  );
  assertEquals(
    7,
    countMemoryChars(`\"aaa\\\"aaa\"`),
  );
  assertEquals(
    1,
    countMemoryChars(`\"\\x27\"`),
  );
  assertEquals(
    4,
    countMemoryChars(`\"b\\w\\\"`),
  );
  assertEquals(
    30,
    countMemoryChars(`\"xrgcripdu\\x4c\\xc4gszjhrvumvz\\\"mngbirb\"`),
  );
  assertEquals(
    23,
    countMemoryChars(`\"\\\\\\\\zkisyjpbzandqikqjqvee\"`),
  );
});

Deno.test("reencodeString", () => {
  assertEquals(
    reencodeString(`\"\"`),
    `\"\\\"\\\"\"`,
  );
  assertEquals(
    reencodeString(`\"abc\"`),
    `\"\\\"abc\\\"\"`,
  );
  assertEquals(
    reencodeString(`\"aaa\\\"aaa\"`),
    `\"\\\"aaa\\\\\\\"aaa\\\"\"`,
  );
  assertEquals(
    reencodeString(`\"\\x27\"`),
    `\"\\\"\\\\x27\\\"\"`,
  );
});
