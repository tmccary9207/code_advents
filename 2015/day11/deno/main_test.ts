import { assertEquals } from "jsr:@std/assert";
import {
  checkConditionOne,
  checkConditionThree,
  checkConditionTwo,
  getNextChar,
  getNextPassword,
  passesAllChecks,
} from "./main.ts";

Deno.test("checkConditionOne", () => {
  assertEquals(checkConditionOne("hijklmmn"), true);
  assertEquals(checkConditionOne("abbceffg"), false);
  assertEquals(checkConditionOne("abbcegjk"), false);
  assertEquals(checkConditionOne("ghjaabcc"), true);
  assertEquals(checkConditionOne("abcdffaa"), true);
});

Deno.test("checkConditionTwo", () => {
  assertEquals(checkConditionTwo("hijklmmn"), false);
  assertEquals(checkConditionTwo("abbceffg"), true);
  assertEquals(checkConditionTwo("abbcegjk"), true);
  assertEquals(checkConditionTwo("ghjaabcc"), true);
  assertEquals(checkConditionTwo("abcdffaa"), true);
});

Deno.test("checkConditionThree", () => {
  assertEquals(checkConditionThree("hijklmmn"), false);
  assertEquals(checkConditionThree("abbceffg"), true);
  assertEquals(checkConditionThree("abbcegjk"), false);
  assertEquals(checkConditionThree("ghjaabcc"), true);
  assertEquals(checkConditionThree("abcdffaa"), true);
});

Deno.test("passesAllChecks", () => {
  assertEquals(passesAllChecks("ghjaabcc"), true);
  assertEquals(passesAllChecks("abcdffaa"), true);
});

Deno.test("getNextChar", () => {
  assertEquals(getNextChar("a"), "b");
  assertEquals(getNextChar("h"), "j");
  assertEquals(getNextChar("k"), "m");
  assertEquals(getNextChar("n"), "p");
  assertEquals(getNextChar("z"), "a");
});

Deno.test("getNextPassword", () => {
  assertEquals(getNextPassword("abcdefgh"), "abcdffaa");
  assertEquals(getNextPassword("ghijklmn"), "ghjaabcc");
});
