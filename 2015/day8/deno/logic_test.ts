import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import {
  countMemoryChars,
  reencodeString,
  reencodeStringChars,
} from "./logic.ts";

Deno.test("countMemoryChars", () => {
  assertEquals(
    2,
    countMemoryChars(`\"\"`),
  );
  assertEquals(
    2,
    countMemoryChars(`\"abc\"`),
  );
  assertEquals(
    3,
    countMemoryChars(`\"aaa\\\"aaa\"`),
  );
  assertEquals(
    5,
    countMemoryChars(`\"\\x27\"`),
  );
  assertEquals(
    2,
    countMemoryChars(`\"b\\w\\\"`),
  );
  assertEquals(
    9,
    countMemoryChars(`\"xrgcripdu\\x4c\\xc4gszjhrvumvz\\\"mngbirb\"`),
  );
  assertEquals(
    4,
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

Deno.test("reencodeStringChars", () => {
  assertEquals(
    reencodeStringChars(`\"\"`),
    4,
  );
  assertEquals(
    reencodeStringChars(`\"abc\"`),
    4,
  );
  assertEquals(
    reencodeStringChars(`\"aaa\\\"aaa\"`),
    6,
  );
  assertEquals(
    reencodeStringChars(`\"\\x27\"`),
    5,
  );
});
