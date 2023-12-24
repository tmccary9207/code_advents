import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";
import { hasThreeOrMoreVowels, hasSameLetterPair, hasNoNaughtyStrings, isStringNice } from "./logic.ts";

Deno.test("hasThreeOrMoreVowels", () => {
    assertEquals(true, hasThreeOrMoreVowels("aei"));
    assertEquals(true, hasThreeOrMoreVowels("xazegov"));
    assertEquals(true, hasThreeOrMoreVowels("aeiouaeiouaeiou"));
    assertEquals(true, hasThreeOrMoreVowels("ugknbfddgicrmopn"));
    assertEquals(true, hasThreeOrMoreVowels("aaa"));
    assertEquals(true, hasThreeOrMoreVowels("jchzalrnumimnmhp"));
    assertEquals(true, hasThreeOrMoreVowels("haegwjzuvuyypxyu"));
    assertEquals(false, hasThreeOrMoreVowels("dvszwmarrgswjxmb"));
});

Deno.test("hasSameLetterPair", () => {
    assertEquals(true, hasSameLetterPair("xx"));
    assertEquals(true, hasSameLetterPair("abcdde"));
    assertEquals(true, hasSameLetterPair("aabbccdd"));
    assertEquals(true, hasSameLetterPair("ugknbfddgicrmopn"));
    assertEquals(true, hasSameLetterPair("aaa"));
    assertEquals(false, hasSameLetterPair("jchzalrnumimnmhp"));
    assertEquals(true, hasSameLetterPair("haegwjzuvuyypxyu"));
    assertEquals(true, hasSameLetterPair("dvszwmarrgswjxmb"));
});

Deno.test("hasNoNaughtyStrings", () => {
    assertEquals(true, hasNoNaughtyStrings("xx"));
    assertEquals(false, hasNoNaughtyStrings("abcdde"));
    assertEquals(false, hasNoNaughtyStrings("aabbccdd"));
    assertEquals(true, hasNoNaughtyStrings("ugknbfddgicrmopn"));
    assertEquals(true, hasNoNaughtyStrings("aaa"));
    assertEquals(true, hasNoNaughtyStrings("jchzalrnumimnmhp"));
    assertEquals(false, hasNoNaughtyStrings("haegwjzuvuyypxyu"));
    assertEquals(true, hasNoNaughtyStrings("dvszwmarrgswjxmb"));
});

Deno.test("isStringNice", () => {
    assertEquals(false, isStringNice("xx"));
    assertEquals(false, isStringNice("abcdde"));
    assertEquals(false, isStringNice("aabbccdd"));
    assertEquals(true, isStringNice("ugknbfddgicrmopn"));
    assertEquals(true, isStringNice("aaa"));
    assertEquals(false, isStringNice("jchzalrnumimnmhp"));
    assertEquals(false, isStringNice("haegwjzuvuyypxyu"));
    assertEquals(false, isStringNice("dvszwmarrgswjxmb"));
});
